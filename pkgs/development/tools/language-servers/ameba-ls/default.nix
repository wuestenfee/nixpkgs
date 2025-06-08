{
  lib,
  crystal,
  fetchFromGitHub,
  shards,
}:

let
  version = "0.1.0";
in
crystal.buildCrystalPackage {
  pname = "ameba-ls";
  inherit version;

  src = fetchFromGitHub {
    owner = "crystal-lang-tools";
    repo = "ameba-ls";
    rev = "v${version}";
    hash = "sha256-TEHjR+34wrq24XJNLhWZCEzcDEMDlmUHv0iiF4Z6JlI=";
  };

  format = "crystal";
  shardsFile = ./shards.nix;

  nativeBuildInputs = [
    crystal
    shards
  ];

  crystalBinaries.ameba-ls = {
    src = "src/ameba-ls.cr";
    options = [
      "--stats"
      "--release"
      "--no-debug"
      "--progress"
      "-Dpreview_mt"
    ];
  };

  installPhase = ''
    mkdir -p $out/bin
    cp ameba-ls $out/bin/
  '';

  meta = with lib; {
    description = "language server for ameba, a linter for crystal lang";
    mainProgram = "ameba-ls";
    homepage = "https://github.com/crystal-lang-tools/ameba-ls";
    license = licenses.mit;
    maintainers = with maintainers; [ wuestenfee ];
  };
}
