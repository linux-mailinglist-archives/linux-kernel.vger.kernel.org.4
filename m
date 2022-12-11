Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01992649209
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLKCrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLKCrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:47:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561D013F17;
        Sat, 10 Dec 2022 18:47:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7D107CE010F;
        Sun, 11 Dec 2022 02:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B0CC433D2;
        Sun, 11 Dec 2022 02:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670726831;
        bh=a85+YHrkUTxTxO4/UXl+D9uSuSdZ9mM7ecjBPKZ65EE=;
        h=From:To:Cc:Subject:Date:From;
        b=FEfOlQhlGESTUpVvnRkhqPGlEuKXXeyr2VLqvxnoFZ+g8EgEsita1hF9RMyAGPUu5
         73Ej4ZZJ2/F+iZjXDUyCczg7FW06Eh3zZkhRmaZhxECzADJL75P5tF+nhdy/LZBEX4
         ZXdl5pGJxevAAXxwFTwvrh68owCZ5/qYR6rKQFDnG9U7OH9ufrc+1L2g5g2gJy10gy
         J8kquE4kqm9kU6C7m9jWVTYkuwShYFfzd+Ub18OCXbdA3sBUaVvZKF2lwHsdOvVNxy
         DHR5uW2yMW0VEnFw+kFVclSiHr5mRjdHWoaow4CNBMbIW06lJCOiRF4ujII8oHUmP/
         OgqfCO1ytvbSA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, x86@kernel.org
Subject: [PATCH] kbuild: add test-{ge,gt,le,lt} macros
Date:   Sun, 11 Dec 2022 11:46:47 +0900
Message-Id: <20221211024647.2614394-1-masahiroy@kernel.org>
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

GNU Make 4.4 introduced $(intcmp ...), which is useful to compare two
integers without forking a new process.

Add test-{ge,gt,le,lt} macros, which work more efficiently with GNU
Make >= 4.4. For older Make versions, they fall back to the 'test'
shell command.

The first two parameters to $(intcmp ...) must not be empty. To avoid
the syntax error, I appended '0' to them. Fortunately, '00' is treated
as '0'. This is needed because CONFIG options may expand to an empty
string when the kernel configuration is not included.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V
---

Changes in v3:
  - Use $(intcmp ...) instead of playing with $(sort ...)

 Makefile                  |  2 +-
 arch/riscv/Makefile       |  2 +-
 arch/x86/Makefile         |  2 +-
 scripts/Kbuild.include    | 16 ++++++++++++++++
 scripts/Makefile.compiler |  4 ++--
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index fbd9ff4a61e7..8801cac4d3d5 100644
--- a/Makefile
+++ b/Makefile
@@ -993,7 +993,7 @@ KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
 # Check for frame size exceeding threshold during prolog/epilog insertion
 # when using lld < 13.0.0.
 ifneq ($(CONFIG_FRAME_WARN),0)
-ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
+ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
 KBUILD_LDFLAGS	+= -plugin-opt=-warn-stack-size=$(CONFIG_FRAME_WARN)
 endif
 endif
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 0d13b597cb55..faf2c2177094 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -37,7 +37,7 @@ else
 endif
 
 ifeq ($(CONFIG_LD_IS_LLD),y)
-ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 150000; echo $$?),0)
+ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 150000),y)
 	KBUILD_CFLAGS += -mno-relax
 	KBUILD_AFLAGS += -mno-relax
 ifndef CONFIG_AS_IS_LLVM
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 415a5d138de4..e72c7a49cd59 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -211,7 +211,7 @@ endif
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
 
 ifdef CONFIG_LTO_CLANG
-ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
+ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
 KBUILD_LDFLAGS	+= -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
 endif
 endif
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index cbe28744637b..5019bc1e38e4 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -11,6 +11,22 @@ space   := $(empty) $(empty)
 space_escape := _-_SPACE_-_
 pound := \#
 
+###
+# Comparison macros.
+# Usage: $(call test-lt, $(CONFIG_LLD_VERSION), 150000)
+#
+# Use $(intcmp ...) if supported. (Make >= 4.4)
+# Otherwise, fall back to the 'test' shell command.
+ifeq ($(intcmp 1,0,,,y),y)
+test-le = $(intcmp $(strip $1)0, $(strip $2)0,y,y,)
+test-lt = $(intcmp $(strip $1)0, $(strip $2)0,y,,)
+else
+test-le = $(shell test $(strip $1)0 -le $(strip $2)0 && echo y)
+test-lt = $(shell test $(strip $1)0 -lt $(strip $2)0 && echo y)
+endif
+test-ge = $(call test-le, $2, $1)
+test-gt = $(call test-lt, $2, $1)
+
 ###
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
 dot-target = $(dir $@).$(notdir $@)
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 20d353dcabfb..3d8adfd34af1 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -63,11 +63,11 @@ cc-disable-warning = $(call try-run,\
 
 # gcc-min-version
 # Usage: cflags-$(call gcc-min-version, 70100) += -foo
-gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION)0 -ge $(1)0 ] && echo y)
+gcc-min-version = $(call test-ge, $(CONFIG_GCC_VERSION), $1)
 
 # clang-min-version
 # Usage: cflags-$(call clang-min-version, 110000) += -foo
-clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION)0 -ge $(1)0 ] && echo y)
+clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
 
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
-- 
2.34.1

