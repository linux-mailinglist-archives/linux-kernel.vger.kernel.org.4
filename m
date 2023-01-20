Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB2675A63
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjATQqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjATQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:46:32 -0500
X-Greylist: delayed 2934 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Jan 2023 08:46:29 PST
Received: from mail.alicef.me (mail.alicef.me [219.94.233.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DE0C63A8;
        Fri, 20 Jan 2023 08:46:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80D2E20AB2;
        Sat, 21 Jan 2023 00:21:49 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alicef.me; s=dkim;
        t=1674228117; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=SBKdiE9KzQY7Zgu/1krTkGqIJujFYeJk7E5BbagF4Lg=;
        b=bfHAmH48aDIy4Z27cbKaQCinBf8xieHA1SfcTlcovKQkwjqCNw6G6cXxSRx0AhsbGHHnOL
        O5/UStjifiu2qCLFpYSdadY2lvUMdqqP3q3DjBBDDkLysYBzdrgTK/qUZrPCfo5ePWofwF
        OPLurR1lFxITIasTXuIOrHghzDcenjkTaOkslELCTeGVPyWS99uomjSOd9WcTeyVppQC34
        crFG/zPueciRdrapuDVNPi3CalLXR/ktYIuQNh1cV2zGXumnnLk8Rep3soCCR4wqJLbk4U
        YxXPbGe98B6S5DRMmjNu9j72Qx9bZTOppYwENeiJZuF6YF4cRQP9+W+0Vxk4jw==
Date:   Sat, 21 Jan 2023 00:21:42 +0900
From:   Alice Ferrazzi <alicef@alicef.me>
To:     Vinay Varma <varmavinaym@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] scripts: `make rust-analyzer` for out-of-tree modules
Message-ID: <20230120152142.fywetc6a46sykkbs@alicef-pc>
References: <20230118160220.776302-1-varmavinaym@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118160220.776302-1-varmavinaym@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 12:02:20AM +0800, Vinay Varma wrote:
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
> Signed-off-by: Vinay Varma <varmavinaym@gmail.com>
> ---
>  Makefile                          | 12 +++++++-----
>  rust/Makefile                     |  6 ++++--
>  scripts/generate_rust_analyzer.py | 14 +++++++++-----
>  3 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f41ec8c8426b..a055a316d2a4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1831,11 +1831,6 @@ rustfmt:
>  rustfmtcheck: rustfmt_flags = --check
>  rustfmtcheck: rustfmt
>  
> -# IDE support targets
> -PHONY += rust-analyzer
> -rust-analyzer:
> -	$(Q)$(MAKE) $(build)=rust $@
> -
>  # Misc
>  # ---------------------------------------------------------------------------
>  
> @@ -1888,6 +1883,7 @@ help:
>  	@echo  '  modules         - default target, build the module(s)'
>  	@echo  '  modules_install - install the module'
>  	@echo  '  clean           - remove generated files in module directory only'
> +	@echo  '  rust-analyzer	  - generate rust-project.json rust-analyzer support file'
>  	@echo  ''
>  
>  endif # KBUILD_EXTMOD
> @@ -2022,6 +2018,12 @@ quiet_cmd_tags = GEN     $@
>  tags TAGS cscope gtags: FORCE
>  	$(call cmd,tags)
>  
> +# IDE support targets
> +PHONY += rust-analyzer
> +rust-analyzer:
> +	$(Q)$(MAKE) $(build)=rust $@
> +
> +
>  # Script to generate missing namespace dependencies
>  # ---------------------------------------------------------------------------
>  
> diff --git a/rust/Makefile b/rust/Makefile
> index 8f598a904f38..41c1435cd8d4 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -389,8 +389,10 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
>  	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
>  
>  rust-analyzer:
> -	$(Q)$(srctree)/scripts/generate_rust_analyzer.py $(srctree) $(objtree) \
> -		$(RUST_LIB_SRC) > $(objtree)/rust-project.json
> +	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
> +		$(abs_srctree) $(abs_objtree) \
> +		$(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
> +		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
>  
>  $(obj)/core.o: private skip_clippy = 1
>  $(obj)/core.o: private skip_flags = -Dunreachable_pub
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index ecc7ea9a4dcf..1546b80db554 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -8,8 +8,9 @@ import json
>  import logging
>  import pathlib
>  import sys
> +import os
>  
> -def generate_crates(srctree, objtree, sysroot_src):
> +def generate_crates(srctree, objtree, sysroot_src, external_src):
>      # Generate the configuration list.
>      cfg = []
>      with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
> @@ -65,7 +66,7 @@ def generate_crates(srctree, objtree, sysroot_src):
>          [],
>          is_proc_macro=True,
>      )
> -    crates[-1]["proc_macro_dylib_path"] = "rust/libmacros.so"
> +    crates[-1]["proc_macro_dylib_path"] = f"{objtree}/rust/libmacros.so"
>  
>      append_crate(
>          "build_error",
> @@ -98,13 +99,15 @@ def generate_crates(srctree, objtree, sysroot_src):
>      # Then, the rest outside of `rust/`.
>      #
>      # We explicitly mention the top-level folders we want to cover.
> -    for folder in ("samples", "drivers"):
> +    extra_src_dirs = ["samples", "drivers"] if external_src is None else [external_src]
> +
> +    for folder in extra_src_dirs:
>          for path in (srctree / folder).rglob("*.rs"):
>              logging.info("Checking %s", path)
>              name = path.name.replace(".rs", "")
>  
>              # Skip those that are not crate roots.
> -            if f"{name}.o" not in open(path.parent / "Makefile").read():
> +            if os.path.exists(path.parent / "Makefile") and f"{name}.o" not in open(path.parent / "Makefile").read():
>                  continue
>  
>              logging.info("Adding %s", name)
> @@ -123,6 +126,7 @@ def main():
>      parser.add_argument("srctree", type=pathlib.Path)
>      parser.add_argument("objtree", type=pathlib.Path)
>      parser.add_argument("sysroot_src", type=pathlib.Path)
> +    parser.add_argument("exttree", type=pathlib.Path, nargs='?')

I would prefer to don't mix '' and "" unless necessary

>      args = parser.parse_args()
>  
>      logging.basicConfig(
> @@ -131,7 +135,7 @@ def main():
>      )
>  
>      rust_project = {
> -        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src),
> +        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree),
>          "sysroot_src": str(args.sysroot_src),
>      }
>  
> -- 
> 2.39.0

I could test it on my enviroment with rust-out-of-tree-module and rustc
1.66
it correctly generated a json file rust-project.json with correct path

As following from github conversation:
Reviewed-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Tested-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>

Thanks,
Alicef
