class Heroku < Formula
  desc "Everything you need to get started with Heroku"
  homepage "https://cli.heroku.com"
  url "https://cli-assets.heroku.com/heroku-v7.12.2/heroku-v7.12.2.tar.xz"
  sha256 "db5e7f9f980d1c76421702e7779982e62be52d4a5f16f36e6d14ced9af7f5e1e"
  depends_on "heroku/brew/heroku-node"

  def install
    inreplace "bin/heroku", /^CLIENT_HOME=/, "export HEROKU_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
    inreplace "bin/heroku", "\"$DIR/node\"", "#{Formula["heroku-node"].opt_share}/node"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/heroku"

    bash_completion.install "#{libexec}/node_modules/@heroku-cli/plugin-autocomplete/autocomplete/brew/bash"
    zsh_completion.install "#{libexec}/node_modules/@heroku-cli/plugin-autocomplete/autocomplete/brew/zsh/_heroku"
  end

  def caveats; <<~EOS
    To use the Heroku CLI's autocomplete --
      Via homebrew's shell completion:
        1) Follow homebrew's install instructions https://docs.brew.sh/Shell-Completion
            NOTE: For zsh, as the instructions mention, be sure compinit is autoloaded
                  and called, either explicitly or via a framework like oh-my-zsh.
        2) Then run
          $ heroku autocomplete --refresh-cache

      OR

      Use our standalone setup:
        1) Run and follow the install steps:
          $ heroku autocomplete
  EOS
  end

  test do
    system bin/"heroku", "version"
  end
end
