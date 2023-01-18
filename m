Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EFB672275
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjARQGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjARQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:05:46 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3003059245;
        Wed, 18 Jan 2023 08:02:34 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 20so10011157plo.3;
        Wed, 18 Jan 2023 08:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OR1pa/GbW4DJUJPKFZgeVx5ahTeFijGOvToDk9lr28w=;
        b=q1epYfurhNhtEgAMdJf55yrQkz0Nl15t6IJLWLIBlqJTCrB1GTOk4FtmttyLYtNt0t
         621pbRTmTqMqsHd12ggnaCqBuylb1gRAU+0IpmInFoT8Z7FGmP4xcbptMlB2becpVeec
         gpURz+9wG+b7wFCXZe2SuNHWVbVyg99PDjJ1Qwbiw7LgU+Lw2zTBk9IaHaY65o4xv+HL
         emnXqVg92EayZ/sYTLW1lPu+V+eKerxgCta8TVkREJxqqNOAJMPgiRB0/eNRwnFRxcIx
         fC3/tsdFOVV0Ox4v6ZwMdJZGrc+CA19bUeBXVlgmgt0uuV9J6tLhnIjiYRpgWOSCoOmI
         OehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OR1pa/GbW4DJUJPKFZgeVx5ahTeFijGOvToDk9lr28w=;
        b=4x8m4doH57+mJVJfAqzbgRBzDF27wXAv26ZfLgkIl7Dt7fa/Nd3T195Rn2i+dX4Irn
         t9XyI5aCglE+8lAKyfC9rD2+9ahIz7keO4hNbQrUaYLkg2TqBu1QaiA/ie2IN5RakvuN
         Q732uxW+13W1nkMiffCpDpYZreptDSRnLqwZzktBcOsLcSz7qcqF+rhXw6DB+5QTynpf
         w6Z+rC6O2F442qnZL42QunM4lpEoUf2PSjb9YwqPq/HXNrqefQWI68UgtlnIUZ15IDqi
         sU2HKTM92JwVOcT3dIQIfgAD2B2pCIcjQT1NlJR7sIEvLrzWHCuHOOqx4/OgAjAzajQ+
         BDtg==
X-Gm-Message-State: AFqh2krY8cQGfrc2Ry5PVmICaYNHAxSZCDmx+a5261Wpu5ZLU0BmqSNf
        5KW1SzttIZoTIHq0yVgPdbg=
X-Google-Smtp-Source: AMrXdXvVwV+ETpe8nxu6ihGd2qLsTWHaPQ9M8HtL5NtCtLaePq8ARzYyy0dTFLUOS0Ku/PQfh2G1NQ==
X-Received: by 2002:a17:902:da90:b0:189:469c:dc0 with SMTP id j16-20020a170902da9000b00189469c0dc0mr10872841plx.7.1674057750698;
        Wed, 18 Jan 2023 08:02:30 -0800 (PST)
Received: from localhost.localdomain ([218.186.180.226])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b00192b0a07891sm23364327plx.101.2023.01.18.08.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:02:30 -0800 (PST)
From:   Vinay Varma <varmavinaym@gmail.com>
Cc:     Vinay Varma <varmavinaym@gmail.com>,
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
Subject: [PATCH] scripts: `make rust-analyzer` for out-of-tree modules
Date:   Thu, 19 Jan 2023 00:02:20 +0800
Message-Id: <20230118160220.776302-1-varmavinaym@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Signed-off-by: Vinay Varma <varmavinaym@gmail.com>
---
 Makefile                          | 12 +++++++-----
 rust/Makefile                     |  6 ++++--
 scripts/generate_rust_analyzer.py | 14 +++++++++-----
 3 files changed, 20 insertions(+), 12 deletions(-)

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
index ecc7ea9a4dcf..1546b80db554 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -8,8 +8,9 @@ import json
 import logging
 import pathlib
 import sys
+import os
 
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
@@ -98,13 +99,15 @@ def generate_crates(srctree, objtree, sysroot_src):
     # Then, the rest outside of `rust/`.
     #
     # We explicitly mention the top-level folders we want to cover.
-    for folder in ("samples", "drivers"):
+    extra_src_dirs = ["samples", "drivers"] if external_src is None else [external_src]
+
+    for folder in extra_src_dirs:
         for path in (srctree / folder).rglob("*.rs"):
             logging.info("Checking %s", path)
             name = path.name.replace(".rs", "")
 
             # Skip those that are not crate roots.
-            if f"{name}.o" not in open(path.parent / "Makefile").read():
+            if os.path.exists(path.parent / "Makefile") and f"{name}.o" not in open(path.parent / "Makefile").read():
                 continue
 
             logging.info("Adding %s", name)
@@ -123,6 +126,7 @@ def main():
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot_src", type=pathlib.Path)
+    parser.add_argument("exttree", type=pathlib.Path, nargs='?')
     args = parser.parse_args()
 
     logging.basicConfig(
@@ -131,7 +135,7 @@ def main():
     )
 
     rust_project = {
-        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src),
+        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree),
         "sysroot_src": str(args.sysroot_src),
     }
 
-- 
2.39.0

