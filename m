Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE26AE5AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjCGP7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjCGP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:58:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46E19477D;
        Tue,  7 Mar 2023 07:57:04 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso12268393pjs.3;
        Tue, 07 Mar 2023 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678204624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+WhmNvyuzqlExpYYh7Rlrgluvlj6y0oW+rTW+VkZB4=;
        b=V3sin0IBOGbhGIEs2LKhORy9EQaehgDvid40b0dvoHNQIGRt3VoQbCI2S9S9rOaGlm
         HxJPN7egTgZ/7NXm/vw2EhjYFCX2YJvgUFSrJsHXMebXyu6+c6LU1d+kOzs9t3M9G7hI
         yr3t1Iieh0+wp0w3ijKHszJA3CMU06cha6l9doSi3v3CgqkksAGBJ1PnzjZ5vsM0UADQ
         0iIi75xFhx4H0+sSfBLMON6QHUW8UDLayK3nxcMssCPVPLxHG1/SREpaAyfbr+CFBVIs
         ghyBxTAZaVWUO2/WaxrPupGd+0wIA4h/582X+QDFHgSxSVA0MzjKrwB6WRBcd/NEGpL2
         uAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678204624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+WhmNvyuzqlExpYYh7Rlrgluvlj6y0oW+rTW+VkZB4=;
        b=zBGS6pdFc7nlE8J0L1tod8OxtcpX3pq62T2TEOeb/vj4eKQn9DB4DXl2aEdQZx+HEf
         5lSKfYp4Z16Yc0kcsdrDAGT1IxtqHhfa5ARHF6f/BB44AOrKWv+Wh1s5ZmwawZQilQf6
         c2z9eC60gZtJry/DHaNXjbQUC+8qFPSq5/fUGD4yXsCg3+NGGrQcX7NTzjJcbhJE47L9
         3s9nXQYuqa+BOe1FWL3suOTFK97uy3kOJNrYrgWS8HCF2CFNv35lV8tTmvRRi3uIJXuO
         +G/2Bh8e9qR4RptjWqOs0Ger0tGH/4sbkOLO3BH1K79sGwoE+RnW+iuAMq95FAAY1dzT
         yaHA==
X-Gm-Message-State: AO0yUKWdiCo40c6bhanjBj96cgNDTSvyEBUSqfLmU8iU05hGTl0UKNaT
        4v53iETDvCMgHEXAzCClT+CQpK0gwDVMZQ==
X-Google-Smtp-Source: AK7set+yZM9Dwc6FqtYsJowtfxw9gQp79YeaxR3WXOXCIzmggTmF27wy9SYGXc/IWDYEO869x99FJA==
X-Received: by 2002:a17:90a:6485:b0:237:461c:b44d with SMTP id h5-20020a17090a648500b00237461cb44dmr15265856pjj.46.1678204624100;
        Tue, 07 Mar 2023 07:57:04 -0800 (PST)
Received: from nvrarch.lan ([218.186.180.226])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090ae98900b00233afe09177sm9405070pjy.8.2023.03.07.07.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:57:03 -0800 (PST)
From:   Vinay Varma <varmavinaym@gmail.com>
Cc:     masahiroy@kernel.org, alicef@alicef.me,
        Vinay Varma <varmavinaym@gmail.com>,
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
Subject: [PATCH v4] scripts: `make rust-analyzer` for out-of-tree modules
Date:   Tue,  7 Mar 2023 23:55:22 +0800
Message-Id: <20230307155521.241104-1-varmavinaym@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307144233.205819-1-varmavinaym@gmail.com>
References: <20230307144233.205819-1-varmavinaym@gmail.com>
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
 Makefile                          | 11 +++++-----
 rust/Makefile                     |  6 ++++--
 scripts/generate_rust_analyzer.py | 36 +++++++++++++++++++------------
 3 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index 3f6628780eb2..ee7b61dc6075 100644
--- a/Makefile
+++ b/Makefile
@@ -1860,11 +1860,6 @@ rustfmt:
 rustfmtcheck: rustfmt_flags = --check
 rustfmtcheck: rustfmt
 
-# IDE support targets
-PHONY += rust-analyzer
-rust-analyzer:
-	$(Q)$(MAKE) $(build)=rust $@
-
 # Misc
 # ---------------------------------------------------------------------------
 
@@ -1917,6 +1912,7 @@ help:
 	@echo  '  modules         - default target, build the module(s)'
 	@echo  '  modules_install - install the module'
 	@echo  '  clean           - remove generated files in module directory only'
+	@echo  '  rust-analyzer	  - generate rust-project.json rust-analyzer support file'
 	@echo  ''
 
 endif # KBUILD_EXTMOD
@@ -2053,6 +2049,11 @@ quiet_cmd_tags = GEN     $@
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
index ecc7ea9a4dcf..7a1a958b1f8a 100755
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
@@ -95,25 +96,31 @@ def generate_crates(srctree, objtree, sysroot_src):
         "exclude_dirs": [],
     }
 
+    def is_root_crate(build_file, target):
+        return os.path.exists(build_file) and target in open(build_file).read()
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
 
@@ -123,6 +130,7 @@ def main():
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot_src", type=pathlib.Path)
+    parser.add_argument("exttree", type=pathlib.Path, nargs="?")
     args = parser.parse_args()
 
     logging.basicConfig(
@@ -131,7 +139,7 @@ def main():
     )
 
     rust_project = {
-        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src),
+        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree),
         "sysroot_src": str(args.sysroot_src),
     }
 
-- 
2.39.2

