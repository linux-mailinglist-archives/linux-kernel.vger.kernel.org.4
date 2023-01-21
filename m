Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1327676771
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAUQk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAUQk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:40:26 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328C7274A3;
        Sat, 21 Jan 2023 08:40:25 -0800 (PST)
Date:   Sat, 21 Jan 2023 16:40:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1674319220; x=1674578420;
        bh=UZ4zBLoMlkARBQygJ/NawONLaYtQNjobxOUov/XyRNo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=L7jZ/k3oOvWdCCI2tygKTXiVJjiCAD5LHXFcy3q6yzFe2heqxMfg+oX0/JhaDGMoq
         qYI7kj7JcKCEEFF0AYflG1g/3wEXFDC11KSDTXlytU8W9TvGGBFKWcK5Pukr1hF2z2
         8ZfBTlYdmLuj7WDtPwWxpdsqqOv0YrnsTA9CqIhKg8dNniuUVlc3j/5+6ZtCPZJUDs
         omVLtxa2B3r5FhMDzdRQF9ouXNXyCAb8Up5Cdr6cnsn0a3tp5XzfD3TuAKCSdnlgoW
         Xm4cbOARfSoEXNRldLCD/rS8MVoX2tPMnpFVQIzgXhPEwi2PvMZtvGesvj3Y0eVBtN
         4B1SA/JG0/BVw==
To:     Vinay Varma <varmavinaym@gmail.com>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     alicef@alicef.me, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] scripts: `make rust-analyzer` for out-of-tree modules
Message-ID: <j3z2AysKmwKLAGCfVhAiuuLAc5rJN43zklg6FUghrTENwPjJTj_xl8qD4ASI9WEVWafK7S34yMwOTsrpBVzmP8A6SCFvMsEe8XRlqtWD-cc=@protonmail.com>
In-Reply-To: <20230121052507.885734-1-varmavinaym@gmail.com>
References: <CANiq72k4cOEOykgUhgqaXPC7xhX2EoC8c4sr1oFEhKMfEdi=wA@mail.gmail.com> <20230121052507.885734-1-varmavinaym@gmail.com>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------- Original Message -------
On Saturday, January 21st, 2023 at 06:25, Vinay Varma <varmavinaym@gmail.co=
m> wrote:


> Adds support for out-of-tree rust modules to use the `rust-analyzer`
> make target to generate the rust-project.json file.
>
> The change involves adding an optional parameter `external_src` to the
> `generate_rust_analyzer.py` which expects the path to the out-of-tree
> module's source directory. When this parameter is passed, I have chosen
> not to add the non-core modules (samples and drivers) into the result
> since these are not expected to be used in third party modules. Related
> changes are also made to the Makefile and rust/Makefile allowing the
> `rust-analyzer` target to be used for out-of-tree modules as well.
>
> Link: https://github.com/Rust-for-Linux/linux/pull/914
> Link: https://github.com/Rust-for-Linux/rust-out-of-tree-module/pull/2
>
> Signed-off-by: Vinay Varma varmavinaym@gmail.com

"make -C ../rust-for-linux M=3D$(pwd) rust-analyzer" produces a rust-projec=
t.json file in the source dir of the out of tree kernel module with a crate=
 definition for the kernel module. In addition rust-analyzer is able to res=
olve definitions from the kernel crate as expected.

Tested-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

>
> ---
> Makefile | 12 +++++++-----
> rust/Makefile | 6 ++++--
> scripts/generate_rust_analyzer.py | 31 ++++++++++++++++++-------------
> 3 files changed, 29 insertions(+), 20 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f41ec8c8426b..a055a316d2a4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1831,11 +1831,6 @@ rustfmt:
> rustfmtcheck: rustfmt_flags =3D --check
> rustfmtcheck: rustfmt
>
> -# IDE support targets
> -PHONY +=3D rust-analyzer
> -rust-analyzer:
> - $(Q)$(MAKE) $(build)=3Drust $@
> -
> # Misc
> # -----------------------------------------------------------------------=
----
>
> @@ -1888,6 +1883,7 @@ help:
> @echo ' modules - default target, build the module(s)'
> @echo ' modules_install - install the module'
> @echo ' clean - remove generated files in module directory only'
> + @echo ' rust-analyzer - generate rust-project.json rust-analyzer suppor=
t file'
> @echo ''
>
> endif # KBUILD_EXTMOD
> @@ -2022,6 +2018,12 @@ quiet_cmd_tags =3D GEN $@
> tags TAGS cscope gtags: FORCE
> $(call cmd,tags)
>
> +# IDE support targets
> +PHONY +=3D rust-analyzer
> +rust-analyzer:
> + $(Q)$(MAKE) $(build)=3Drust $@
> +
> +
> # Script to generate missing namespace dependencies
> # -----------------------------------------------------------------------=
----
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 8f598a904f38..41c1435cd8d4 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -389,8 +389,10 @@ quiet_cmd_rustc_library =3D $(if $(skip_clippy),RUST=
C,$(RUSTC_OR_CLIPPY_QUIET)) L
> $(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
>
> rust-analyzer:
> - $(Q)$(srctree)/scripts/generate_rust_analyzer.py $(srctree) $(objtree) =
\
> - $(RUST_LIB_SRC) > $(objtree)/rust-project.json
>
> + $(Q)$(srctree)/scripts/generate_rust_analyzer.py \
> + $(abs_srctree) $(abs_objtree) \
> + $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
>
> + $(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
>
> $(obj)/core.o: private skip_clippy =3D 1
> $(obj)/core.o: private skip_flags =3D -Dunreachable_pub
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_an=
alyzer.py
> index ecc7ea9a4dcf..1792f379ee4e 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -6,10 +6,11 @@
> import argparse
> import json
> import logging
> +import os
> import pathlib
> import sys
>
> -def generate_crates(srctree, objtree, sysroot_src):
> +def generate_crates(srctree, objtree, sysroot_src, external_src):
> # Generate the configuration list.
> cfg =3D []
> with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
> @@ -65,7 +66,7 @@ def generate_crates(srctree, objtree, sysroot_src):
> [],
> is_proc_macro=3DTrue,
> )
> - crates[-1]["proc_macro_dylib_path"] =3D "rust/libmacros.so"
> + crates[-1]["proc_macro_dylib_path"] =3D f"{objtree}/rust/libmacros.so"
>
> append_crate(
> "build_error",
> @@ -95,25 +96,28 @@ def generate_crates(srctree, objtree, sysroot_src):
> "exclude_dirs": [],
> }
>
> + def is_root_crate(build_file, target):
> + return os.path.exists(build_file) and target in open(build_file).read()
> +
> # Then, the rest outside of `rust/`.
> #
> # We explicitly mention the top-level folders we want to cover.
> - for folder in ("samples", "drivers"):
> + for folder in ("samples", "drivers") if external_src is None else [exte=
rnal_src]:
> for path in (srctree / folder).rglob("*.rs"):
> logging.info("Checking %s", path)
> name =3D path.name.replace(".rs", "")
>
> # Skip those that are not crate roots.
> - if f"{name}.o" not in open(path.parent / "Makefile").read():
> - continue
> + if is_root_crate(path.parent / "Makefile", f"{name}.o") or \
> + is_root_crate(path.parent / "Kbuild", f"{name}.o"):
>
> - logging.info("Adding %s", name)
> - append_crate(
> - name,
> - path,
> - ["core", "alloc", "kernel"],
> - cfg=3Dcfg,
> - )
> + logging.info("Adding %s", name)
> + append_crate(
> + name,
> + path,
> + ["core", "alloc", "kernel"],
> + cfg=3Dcfg,
> + )
>
> return crates
>
> @@ -123,6 +127,7 @@ def main():
> parser.add_argument("srctree", type=3Dpathlib.Path)
> parser.add_argument("objtree", type=3Dpathlib.Path)
> parser.add_argument("sysroot_src", type=3Dpathlib.Path)
> + parser.add_argument("exttree", type=3Dpathlib.Path, nargs=3D'?')
> args =3D parser.parse_args()
>
> logging.basicConfig(
> @@ -131,7 +136,7 @@ def main():
> )
>
> rust_project =3D {
> - "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src)=
,
> + "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src,=
 args.exttree),
> "sysroot_src": str(args.sysroot_src),
> }
>
> --
> 2.39.0

Cheers,
Bj=C3=B6rn

(resend as I forgot to do reply to all)
