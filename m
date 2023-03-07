Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FADB6AE3A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCGPAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCGPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:00:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E841BEF;
        Tue,  7 Mar 2023 06:47:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x34so13462435pjj.0;
        Tue, 07 Mar 2023 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678200458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efaxFGX7RhK5wlkuA3wHJVS02g4I2ZxWwk9Ysl91i4w=;
        b=DojDqSDfy0L8fiwZ5plEukZbmQpbpmld2wkUtOBNHHXfoQ0q4nMM8KmYfnBt02Tbzh
         edLT17+NXxBsUwfLo/pAnesJfRZ5bn0oFwZZWjNriQPDULPVXvZlOgTeMDMllGDdaxjU
         PW8cJYH0AWryRMPx64dFHRjkccaXwkrfi/cJjm/l0Y8poDIjmukkq8UJi7GBTi32Xs5y
         6pZBWgBo0S+gG3KliiEdFydz1JKbQWEW+Pm15njcEBY+bcaioOzVl61wSgcXTPD9Ph8T
         rYkcbEjrC7b8Pre9qhSKwR/lPNzQOmAqZt1IxVrBSrbb7HekRxiV4EXodaJfnyuRmckW
         j06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678200458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efaxFGX7RhK5wlkuA3wHJVS02g4I2ZxWwk9Ysl91i4w=;
        b=dlIPJXXE06D+RwOv22WmGEUXtwNKCA9zTErUhdf5Wjdr3W8OGTofEIs4q40/LuQsPi
         ooGvGJprwcsPw8d/a96JY1CyBgh25iDBnPwAsMla7vmZfBabLVXZrrSom+53qFsCix3D
         2j994pxcOjSNzUPJXXTI69IjuDu0V3P8Ga7i+6iusIk/HW7mE0D0kFYwaTvm9slju/Zb
         nVrAbXbMZa5meRAnhKSTNe2fBt6ouH1JnqCdvhuSKA5syIckybTCQ0dxZOXURXmFfJ8L
         O1ohYoopSd73ljw56ZWfc99wMOHiLZPEV2h7rJYoMFZHfAuFfsxTeLP7gxyNEkYvbuW3
         UbFA==
X-Gm-Message-State: AO0yUKWYoaxlpn2Xgr173btITHpeOA1eLHFmzFRe/VzYAZk8quvOrtKM
        1KSzC69GPyEESZAatyg3ESo=
X-Google-Smtp-Source: AK7set8d9pKclUkLOW+YvhmPqft4bWNEFaqe/nJa3tAKji0KKhXop4s0B4GU0OxLjDN1oPcuwdapBw==
X-Received: by 2002:a17:903:8cb:b0:19e:8e73:e977 with SMTP id lk11-20020a17090308cb00b0019e8e73e977mr16218574plb.67.1678200458481;
        Tue, 07 Mar 2023 06:47:38 -0800 (PST)
Received: from nvrarch.lan ([218.186.180.226])
        by smtp.gmail.com with ESMTPSA id la16-20020a170902fa1000b0019cb8ffd209sm8518542plb.229.2023.03.07.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 06:47:37 -0800 (PST)
From:   Vinay Varma <varmavinaym@gmail.com>
To:     miguel.ojeda.sandonis@gmail.com
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
Subject: [PATCH v3] scripts: `make rust-analyzer` for out-of-tree modules
Date:   Tue,  7 Mar 2023 22:42:34 +0800
Message-Id: <20230307144233.205819-1-varmavinaym@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CANiq72k-KhU398KzV0+8DP0AUYkaf_G+5PwXgzYwbbK6AgcCUg@mail.gmail.com>
References: <CANiq72k-KhU398KzV0+8DP0AUYkaf_G+5PwXgzYwbbK6AgcCUg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 scripts/generate_rust_analyzer.py | 31 ++++++++++++++++++-------------
 3 files changed, 28 insertions(+), 20 deletions(-)

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
index ecc7ea9a4dcf..741ccd6efe2b 100755
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
+    parser.add_argument("exttree", type=pathlib.Path, nargs="?")
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
2.39.2

