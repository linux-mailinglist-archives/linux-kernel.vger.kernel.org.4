Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FE36763FD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 06:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjAUFZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 00:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAUFZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 00:25:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D2A6F301;
        Fri, 20 Jan 2023 21:25:29 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so10906372pjg.4;
        Fri, 20 Jan 2023 21:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cswjGbuOcw+5dX1m6FkjMVYFf21463Tt36uhkxzVWf4=;
        b=QtLfUAFdF2vtJhg96utnlcw/XB1gISFca1XDKDVYXxLTHqtSkujZp065YY6hDDLdvF
         ayPu+N+UCZmiVjnUTK4WW0BSK27PVCRbkDCYutLHlRrPG2LsbY7xll2H5nSutetOKPjn
         iBxD9PJRCcb/LsD9VF8iJ52bw+1B5HFKWy5ABKMg0jukgomEcpQw2TGVKOjE7eAa8fjU
         /ZrXRGBGh/eNABTI6wWxdqeV0eeH/fm6ltaDKgh9gLcLQ44i82bwXc6Vl0rcVElVGIfc
         wux3+FeZ/fwLpIL/kTkrDTa3jC0eLoCNRkYLh0uwkfRggTwSUkSwTm9d+7r46J3hxFt9
         x//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cswjGbuOcw+5dX1m6FkjMVYFf21463Tt36uhkxzVWf4=;
        b=KxD0EbaXD/R1QX6HOuUEXlm5wgfIJnThRm31pAb9RVqBbyXYxGE5qUCYdoSQ5VR34u
         s9ls9AyFfdanXSRqhMrLgqhJRXhlQJzS2NG4aNBr9OVTmHB/dTxXmAn6RVa4ovtT2Z5w
         Rnx6RI2yPHRk5maJRBk5Qq87TDxGyDCYPuIIPGkwC53HSuuIc0kCpT84UJmDUTAQVvzm
         6b2LW63ZbexY5Eg/MztHPTWzBZOfW3LKphlGPjCP+pW/l4NVK4Y7FpeS5ORWepep0tFg
         h0MKGWeqk1+chp+BrQCt2oTv+8MvPiJtVs+D48jz0V/S/cKCAYKy/4r8HgpXXJp/aZNa
         9K6g==
X-Gm-Message-State: AFqh2koqbHLhT8SzNFsnYOExddZ61gcohj0gKYEoQnQb40ddiHS37d5m
        9dQxgero/YqEfmjrUhXSNB8=
X-Google-Smtp-Source: AMrXdXsXS5JzY5/o/iCFWRpBlRncq4ZO/XcPzqO+M8Hz7coBCNuW57gPCbW160eHwciNW77SNMU5Og==
X-Received: by 2002:a05:6a20:cc47:b0:b8:70f7:fc3a with SMTP id hq7-20020a056a20cc4700b000b870f7fc3amr14924880pzb.51.1674278729239;
        Fri, 20 Jan 2023 21:25:29 -0800 (PST)
Received: from localhost.localdomain ([218.186.180.226])
        by smtp.gmail.com with ESMTPSA id 35-20020a630d63000000b004cc95c9bd97sm9870810pgn.35.2023.01.20.21.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 21:25:28 -0800 (PST)
From:   Vinay Varma <varmavinaym@gmail.com>
Cc:     alicef@alicef.me, Vinay Varma <varmavinaym@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: [PATCH v2] scripts: `make rust-analyzer` for out-of-tree modules
Date:   Sat, 21 Jan 2023 13:25:07 +0800
Message-Id: <20230121052507.885734-1-varmavinaym@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <CANiq72k4cOEOykgUhgqaXPC7xhX2EoC8c4sr1oFEhKMfEdi=wA@mail.gmail.com>
References: <CANiq72k4cOEOykgUhgqaXPC7xhX2EoC8c4sr1oFEhKMfEdi=wA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for out-of-tree rust modules to use the `rust-analyzer`
make target to generate the rust-project.json file.

The change involves adding an optional parameter `external_src` to the
`generate_rust_analyzer.py` which expects the path to the out-of-tree
module's source directory. When this parameter is passed, I have chosen
not to add the non-core modules (samples and drivers) into the result
since these are not expected to be used in third party modules. Related
changes are also made to the Makefile and rust/Makefile allowing the
`rust-analyzer` target to be used for out-of-tree modules as well.

Link: https://github.com/Rust-for-Linux/linux/pull/914
Link: https://github.com/Rust-for-Linux/rust-out-of-tree-module/pull/2

Signed-off-by: Vinay Varma <varmavinaym@gmail.com>
---
 Makefile                          | 12 +++++++-----
 rust/Makefile                     |  6 ++++--
 scripts/generate_rust_analyzer.py | 31 ++++++++++++++++++-------------
 3 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/Makefile b/Makefile
index f41ec8c8426b..a055a316d2a4 100644
--- a/Makefile
+++ b/Makefile
@@ -1831,11 +1831,6 @@ rustfmt:
 rustfmtcheck: rustfmt_flags = --check
 rustfmtcheck: rustfmt
 
-# IDE support targets
-PHONY += rust-analyzer
-rust-analyzer:
-	$(Q)$(MAKE) $(build)=rust $@
-
 # Misc
 # ---------------------------------------------------------------------------
 
@@ -1888,6 +1883,7 @@ help:
 	@echo  '  modules         - default target, build the module(s)'
 	@echo  '  modules_install - install the module'
 	@echo  '  clean           - remove generated files in module directory only'
+	@echo  '  rust-analyzer	  - generate rust-project.json rust-analyzer support file'
 	@echo  ''
 
 endif # KBUILD_EXTMOD
@@ -2022,6 +2018,12 @@ quiet_cmd_tags = GEN     $@
 tags TAGS cscope gtags: FORCE
 	$(call cmd,tags)
 
+# IDE support targets
+PHONY += rust-analyzer
+rust-analyzer:
+	$(Q)$(MAKE) $(build)=rust $@
+
+
 # Script to generate missing namespace dependencies
 # ---------------------------------------------------------------------------
 
diff --git a/rust/Makefile b/rust/Makefile
index 8f598a904f38..41c1435cd8d4 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -389,8 +389,10 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
 
 rust-analyzer:
-	$(Q)$(srctree)/scripts/generate_rust_analyzer.py $(srctree) $(objtree) \
-		$(RUST_LIB_SRC) > $(objtree)/rust-project.json
+	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
+		$(abs_srctree) $(abs_objtree) \
+		$(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
+		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
 
 $(obj)/core.o: private skip_clippy = 1
 $(obj)/core.o: private skip_flags = -Dunreachable_pub
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index ecc7ea9a4dcf..1792f379ee4e 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -6,10 +6,11 @@
 import argparse
 import json
 import logging
+import os
 import pathlib
 import sys
 
-def generate_crates(srctree, objtree, sysroot_src):
+def generate_crates(srctree, objtree, sysroot_src, external_src):
     # Generate the configuration list.
     cfg = []
     with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
@@ -65,7 +66,7 @@ def generate_crates(srctree, objtree, sysroot_src):
         [],
         is_proc_macro=True,
     )
-    crates[-1]["proc_macro_dylib_path"] = "rust/libmacros.so"
+    crates[-1]["proc_macro_dylib_path"] = f"{objtree}/rust/libmacros.so"
 
     append_crate(
         "build_error",
@@ -95,25 +96,28 @@ def generate_crates(srctree, objtree, sysroot_src):
         "exclude_dirs": [],
     }
 
+    def is_root_crate(build_file, target):
+        return os.path.exists(build_file) and target in open(build_file).read()
+
     # Then, the rest outside of `rust/`.
     #
     # We explicitly mention the top-level folders we want to cover.
-    for folder in ("samples", "drivers"):
+    for folder in ("samples", "drivers") if external_src is None else [external_src]:
         for path in (srctree / folder).rglob("*.rs"):
             logging.info("Checking %s", path)
             name = path.name.replace(".rs", "")
 
             # Skip those that are not crate roots.
-            if f"{name}.o" not in open(path.parent / "Makefile").read():
-                continue
+            if is_root_crate(path.parent / "Makefile", f"{name}.o") or \
+               is_root_crate(path.parent / "Kbuild", f"{name}.o"):
 
-            logging.info("Adding %s", name)
-            append_crate(
-                name,
-                path,
-                ["core", "alloc", "kernel"],
-                cfg=cfg,
-            )
+                logging.info("Adding %s", name)
+                append_crate(
+                    name,
+                    path,
+                    ["core", "alloc", "kernel"],
+                    cfg=cfg,
+                )
 
     return crates
 
@@ -123,6 +127,7 @@ def main():
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot_src", type=pathlib.Path)
+    parser.add_argument("exttree", type=pathlib.Path, nargs='?')
     args = parser.parse_args()
 
     logging.basicConfig(
@@ -131,7 +136,7 @@ def main():
     )
 
     rust_project = {
-        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src),
+        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree),
         "sysroot_src": str(args.sysroot_src),
     }
 
-- 
2.39.0

