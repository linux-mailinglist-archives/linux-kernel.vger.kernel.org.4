Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6028865A33D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 09:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiLaIao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 03:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 03:30:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5295911157;
        Sat, 31 Dec 2022 00:30:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAB9AB80189;
        Sat, 31 Dec 2022 08:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA19C433D2;
        Sat, 31 Dec 2022 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672475437;
        bh=DeGY3WtnQ9/BVhgPzj8b9RvS0+MPjHrMcjMxSB4XArM=;
        h=From:To:Cc:Subject:Date:From;
        b=NYl2X4ZTLykuScW1WehAqZ5NIe9wA0PEtHhvsijd2ESdrG+lPZBOuXMlavFL3d3Nu
         rDobV1WH9TP1tcLNGHYTG3q+9BtQUM1/dvBasugleQdPhidkGtinYnhN1FwO/sL8ju
         re0Jg2gnp3gTX7Nawx8BVzL3lnqqClUz2NWE8WCwj5pFj6P/QMBMCTmsxcqO1jNt5v
         ZapZvXGxduN/SFYlXp65UNQLOkW8m/MTqjop8+SPTmroqpMXTEmmM3B9wWC3EnfjSE
         L4eHMhPvZPnEqQKiCSfgjJtMf2dvCn8xAjO6BphD+FbeygVMyfgPQgLGFD1plfigw3
         qhhbFWYPCIl/A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>, David Gow <davidgow@google.com>,
        Helge Deller <deller@gmx.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH] kbuild: rust: move rust/target.json to scripts/
Date:   Sat, 31 Dec 2022 17:30:28 +0900
Message-Id: <20221231083028.1635698-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/ is a better place to generate files used treewide.

You do not need to add target.json to no-clean-files or MRPROER_FILES.

'make clean' does not visit scripts/, but 'make mrproper' does.

With target.json moved into scripts/, Kbuild will do the right thing.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                   |  4 ++--
 rust/.gitignore            |  1 -
 rust/Makefile              | 10 +---------
 scripts/.gitignore         |  1 +
 scripts/Makefile           |  8 +++++++-
 scripts/remove-stale-files |  2 ++
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 6b2a65f1aeaf..f9ec5bcacc60 100644
--- a/Makefile
+++ b/Makefile
@@ -569,7 +569,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
 		   -std=gnu11
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_RUSTFLAGS := $(rust_common_flags) \
-		    --target=$(objtree)/rust/target.json \
+		    --target=$(objtree)/scripts/target.json \
 		    -Cpanic=abort -Cembed-bitcode=n -Clto=n \
 		    -Cforce-unwind-tables=n -Ccodegen-units=1 \
 		    -Csymbol-mangling-version=v0 \
@@ -1593,7 +1593,7 @@ MRPROPER_FILES += include/config include/generated          \
 		  certs/x509.genkey \
 		  vmlinux-gdb.py \
 		  *.spec \
-		  rust/target.json rust/libmacros.so
+		  rust/libmacros.so
 
 # clean - Delete most, but leave enough to build external modules
 #
diff --git a/rust/.gitignore b/rust/.gitignore
index 9bd1af8e05a1..168cb26a31b9 100644
--- a/rust/.gitignore
+++ b/rust/.gitignore
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-target.json
 bindings_generated.rs
 bindings_helpers_generated.rs
 exports_*_generated.h
diff --git a/rust/Makefile b/rust/Makefile
index c8941fec6955..9e33fa04b594 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-always-$(CONFIG_RUST) += target.json
-no-clean-files += target.json
-
 obj-$(CONFIG_RUST) += core.o compiler_builtins.o
 always-$(CONFIG_RUST) += exports_core_generated.h
 
@@ -231,11 +228,6 @@ rusttest-kernel: $(src)/kernel/lib.rs rusttest-prepare \
 	$(call if_changed,rustc_test)
 	$(call if_changed,rustc_test_library)
 
-filechk_rust_target = $(objtree)/scripts/generate_rust_target < $<
-
-$(obj)/target.json: $(objtree)/include/config/auto.conf FORCE
-	$(call filechk,rust_target)
-
 ifdef CONFIG_CC_IS_CLANG
 bindgen_c_flags = $(c_flags)
 else
@@ -358,7 +350,7 @@ rust-analyzer:
 $(obj)/core.o: private skip_clippy = 1
 $(obj)/core.o: private skip_flags = -Dunreachable_pub
 $(obj)/core.o: private rustc_target_flags = $(core-cfgs)
-$(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs $(obj)/target.json FORCE
+$(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs scripts/target.json FORCE
 	$(call if_changed_dep,rustc_library)
 
 $(obj)/compiler_builtins.o: private rustc_objcopy = -w -W '__*'
diff --git a/scripts/.gitignore b/scripts/.gitignore
index b7aec8eb1bd4..11bf3c075fb6 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -8,4 +8,5 @@
 /recordmcount
 /sign-file
 /sorttable
+/target.json
 /unifdef
diff --git a/scripts/Makefile b/scripts/Makefile
index 1575af84d557..0e0ae3c06ed7 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -10,8 +10,14 @@ hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
 hostprogs-always-$(CONFIG_ASN1)				+= asn1_compiler
 hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
 hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
-hostprogs-always-$(CONFIG_RUST)				+= generate_rust_target
+always-$(CONFIG_RUST)					+= target.json
 
+filechk_rust_target = $< < include/config/auto.conf
+
+$(obj)/target.json: scripts/generate_rust_target include/config/auto.conf FORCE
+	$(call filechk,rust_target)
+
+hostprogs += generate_rust_target
 generate_rust_target-rust := y
 
 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index cdbdde89a271..c71bf2f68360 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -27,3 +27,5 @@ rm -f arch/x86/purgatory/kexec-purgatory.c
 rm -f scripts/extract-cert
 
 rm -f scripts/kconfig/[gmnq]conf-cfg
+
+rm -f rust/target.json
-- 
2.34.1

