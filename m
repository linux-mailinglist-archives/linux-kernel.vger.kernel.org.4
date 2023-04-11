Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D0A6DD670
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDKJTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDKJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:19:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEA61BF0;
        Tue, 11 Apr 2023 02:19:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so10180498pjo.4;
        Tue, 11 Apr 2023 02:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681204751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeaBCACEVIwHckAVsFLbm9w2zfLhotIxVt8Zw+73/aw=;
        b=Ye+3HJaoKKOwAOfETRmV0/uyM0vKByD1mGUg839f6029aqMIcufqZcojsBaA6AZisV
         BA5+WZ3N4S8X0uR5t9KJyhguJom4kVf6bYl24Pxbt1ChlkFz8XcIumJyMTHRIengJZFY
         eeUAxiGtUQ9mj79DjWHWJhwqMdp/p4LaRj17dLKcHxt76ByrwmWIcfHRiN7lwcfHmyNV
         /W4qYYs5zkOKH+3Z/yXe28NQ52/DHetXo33LC0UUR9Jx/asC+RkarJ5qSuwhZQbUofGg
         nLI/X+kPx5RSYKXyZ+Tq6gAnPpL/XYAJUzlqSMk9K64kPk5cAi+E8XBfadLDY2pwO/fn
         etXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681204751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeaBCACEVIwHckAVsFLbm9w2zfLhotIxVt8Zw+73/aw=;
        b=q9VSjm34Rn1gmJ10pKd8/ycl5KhMAd+lnIijhzh56p01xd5GHI5Q1i+zIx2yXHnDpH
         tfarp5ruDMqYESZPNcSQ22uH2gboAooLVq2k5US2V3Rrguf1G8YSgGX/u35Ik0jBM/l7
         fj/4oz5TuVSEL9d1TGCAqXn7ROffKjy9YZ/cGeFuHfrMq2863Ouo3uafzX7d8StbIU10
         OP5ZCEtiL7zyhQ/7moHxiyuLZzk8JiGY69a67n6rNB+4w7ubZwed2mQPxMhHyW5OxxtL
         rOPao2/dS0seojuJQTnvg89I6OAZo0PqdVv07MNOvUthO1B90k+wRh3sdQ0q06smZndU
         cyDg==
X-Gm-Message-State: AAQBX9e2OsV+gPpE2OUA4xYkUKdLR280TRQvYvwKI0i3GbY5OU76aBok
        l0kU5Z/eE5l6p0hd0iE856MHXi3lhKHYOg==
X-Google-Smtp-Source: AKy350aeKV/E9F7g0hiU7KpDsluFF1rwYlqtszfoQO7jCLAgp6rrvAGYPj2d+ZTAkZZphmQ5gCuq6Q==
X-Received: by 2002:a17:90a:2d0:b0:246:7f48:9a4d with SMTP id d16-20020a17090a02d000b002467f489a4dmr11296422pjd.19.1681204751373;
        Tue, 11 Apr 2023 02:19:11 -0700 (PDT)
Received: from localhost.localdomain ([218.186.180.226])
        by smtp.gmail.com with ESMTPSA id on13-20020a17090b1d0d00b0023493354f37sm10798725pjb.26.2023.04.11.02.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 02:19:10 -0700 (PDT)
From:   Vinay Varma <varmavinaym@gmail.com>
Cc:     Vinay Varma <varmavinaym@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: [PATCH v5] scripts: `make rust-analyzer` for out-of-tree modules
Date:   Tue, 11 Apr 2023 17:17:15 +0800
Message-Id: <20230411091714.130525-1-varmavinaym@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <CANiq72kD_ESDSh-gVmUS18HtVmkY=bgxkR7Wo=OiwfMyyD8EFw@mail.gmail.com>
References: <CANiq72kD_ESDSh-gVmUS18HtVmkY=bgxkR7Wo=OiwfMyyD8EFw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 Makefile                          | 11 ++++++-----
 rust/Makefile                     |  6 ++++--
 scripts/generate_rust_analyzer.py | 27 ++++++++++++++++++---------
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index ef4e96b9cd5b..1c57360e14f2 100644
--- a/Makefile
+++ b/Makefile
@@ -1856,11 +1856,6 @@ rustfmt:
 rustfmtcheck: rustfmt_flags = --check
 rustfmtcheck: rustfmt
 
-# IDE support targets
-PHONY += rust-analyzer
-rust-analyzer:
-	$(Q)$(MAKE) $(build)=rust $@
-
 # Misc
 # ---------------------------------------------------------------------------
 
@@ -1921,6 +1916,7 @@ help:
 	@echo  '  modules         - default target, build the module(s)'
 	@echo  '  modules_install - install the module'
 	@echo  '  clean           - remove generated files in module directory only'
+	@echo  '  rust-analyzer	  - generate rust-project.json rust-analyzer support file'
 	@echo  ''
 
 endif # KBUILD_EXTMOD
@@ -2058,6 +2054,11 @@ quiet_cmd_tags = GEN     $@
 tags TAGS cscope gtags: FORCE
 	$(call cmd,tags)
 
+# IDE support targets
+PHONY += rust-analyzer
+rust-analyzer:
+	$(Q)$(MAKE) $(build)=rust $@
+
 # Script to generate missing namespace dependencies
 # ---------------------------------------------------------------------------
 
diff --git a/rust/Makefile b/rust/Makefile
index aef85e9e8eeb..45c92acd13bc 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -360,8 +360,10 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
 
 rust-analyzer:
-	$(Q)$(srctree)/scripts/generate_rust_analyzer.py $(srctree) $(objtree) \
-		$(RUST_LIB_SRC) > $(objtree)/rust-project.json
+	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
+		$(abs_srctree) $(abs_objtree) \
+		$(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
+		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
 
 redirect-intrinsics = \
 	__eqsf2 __gesf2 __lesf2 __nesf2 __unordsf2 \
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 946e250c1b2a..848fa1ad92ba 100755
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
@@ -95,19 +96,26 @@ def generate_crates(srctree, objtree, sysroot_src):
         "exclude_dirs": [],
     }
 
+    def is_root_crate(build_file, target):
+        try:
+            return f"{target}.o" in open(build_file).read()
+        except FileNotFoundError:
+            return False
+
     # Then, the rest outside of `rust/`.
     #
     # We explicitly mention the top-level folders we want to cover.
-    for folder in ("samples", "drivers"):
-        for path in (srctree / folder).rglob("*.rs"):
+    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers"))
+    if external_src is not None:
+        extra_dirs = [external_src]
+    for folder in extra_dirs:
+        for path in folder.rglob("*.rs"):
             logging.info("Checking %s", path)
             name = path.name.replace(".rs", "")
 
             # Skip those that are not crate roots.
-            try:
-                if f"{name}.o" not in open(path.parent / "Makefile").read():
-                    continue
-            except FileNotFoundError:
+            if not is_root_crate(path.parent / "Makefile", name) and \
+               not is_root_crate(path.parent / "Kbuild", name):
                 continue
 
             logging.info("Adding %s", name)
@@ -126,6 +134,7 @@ def main():
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot_src", type=pathlib.Path)
+    parser.add_argument("exttree", type=pathlib.Path, nargs="?")
     args = parser.parse_args()
 
     logging.basicConfig(
@@ -134,7 +143,7 @@ def main():
     )
 
     rust_project = {
-        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src),
+        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree),
         "sysroot_src": str(args.sysroot_src),
     }
 
-- 
2.40.0

