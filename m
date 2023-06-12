Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB8172D107
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbjFLUtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbjFLUrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3D72962
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5F2862F13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1806DC43321;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=Mw35BFUR7+ZznSmU98NqwI0YjsJ69pjYjKZIJHsUNFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gocSLvBAODbkBcNotQbuYpw/q2jI3zbOB3NP3dScshtfaldm2FnQ0oOtHZUWOEQHn
         fsoPqwLPOQVmE1R6sdPkY653AuD6K6faZ4Dx9zDky63p98U6AkM+TWdQqnKsUipVtu
         9zo41kijZOQFC6Hvg5AwM3PbBIfaM+BSv+vjv/eT9/LKe3vQLfWb9C5PU5WaCGHRV2
         0YFZ+FJymFxZITVYkvE4hw/BWHqmgWaq752rDEggTXsiLJRtF7LBNugAgABUTbK21d
         QxtnTcM8wfu43iCMrw3N9yfV1TExIwqbMqNEbi57KXTxWwSBtcma87oOMBbptDgx83
         kjiP37OUltaRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ED2B9CE3A79; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 30/53] tools/nolibc: add autodetection for stackprotector support
Date:   Mon, 12 Jun 2023 13:44:51 -0700
Message-Id: <20230612204514.292087-30-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

The stackprotector support in nolibc should be enabled iff it is also
enabled in the compiler.
Use the preprocessor defines added by gcc and clang if stackprotector
support is enable to automatically do so in nolibc.

This completely removes the need for any user-visible API.

To avoid inlining the lengthy preprocessor check into every user
introduce a new header compiler.h that abstracts the logic away.

As the define NOLIBC_STACKPROTECTOR is now not user-relevant anymore
prefix it with an underscore.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230520133237.GA27501@1wt.eu/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/arch-aarch64.h          |  6 +++---
 tools/include/nolibc/arch-arm.h              |  6 +++---
 tools/include/nolibc/arch-i386.h             |  6 +++---
 tools/include/nolibc/arch-loongarch.h        |  6 +++---
 tools/include/nolibc/arch-mips.h             |  6 +++---
 tools/include/nolibc/arch-riscv.h            |  6 +++---
 tools/include/nolibc/arch-x86_64.h           |  6 +++---
 tools/include/nolibc/compiler.h              | 15 +++++++++++++++
 tools/include/nolibc/stackprotector.h        | 10 +++-------
 tools/testing/selftests/nolibc/nolibc-test.c |  4 ++--
 11 files changed, 42 insertions(+), 30 deletions(-)
 create mode 100644 tools/include/nolibc/compiler.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index e37c3ac86e23..64d67b080744 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -26,6 +26,7 @@ endif
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
 all_files := \
+		compiler.h \
 		ctype.h \
 		errno.h \
 		nolibc.h \
diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 6a859131c530..64ec65b4ee38 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_ARCH_AARCH64_H
 #define _NOLIBC_ARCH_AARCH64_H
 
+#include "compiler.h"
+
 /* The struct returned by the newfstatat() syscall. Differs slightly from the
  * x86_64's stat one by field ordering, so be careful.
  */
@@ -172,13 +174,11 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
-#define __ARCH_SUPPORTS_STACK_PROTECTOR
-
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
-#ifdef NOLIBC_STACKPROTECTOR
+#ifdef _NOLIBC_STACKPROTECTOR
 		"bl __stack_chk_init\n"   /* initialize stack protector                     */
 #endif
 		"ldr x0, [sp]\n"     /* argc (x0) was in the stack                          */
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 202e64f537dc..924169522cf7 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_ARCH_ARM_H
 #define _NOLIBC_ARCH_ARM_H
 
+#include "compiler.h"
+
 /* The struct returned by the stat() syscall, 32-bit only, the syscall returns
  * exactly 56 bytes (stops before the unused array). In big endian, the format
  * differs as devices are returned as short only.
@@ -199,13 +201,11 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
-#define __ARCH_SUPPORTS_STACK_PROTECTOR
-
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
-#ifdef NOLIBC_STACKPROTECTOR
+#ifdef _NOLIBC_STACKPROTECTOR
 		"bl __stack_chk_init\n"       /* initialize stack protector                          */
 #endif
 		"pop {%r0}\n"                 /* argc was in the stack                               */
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 7c41897a08ce..37f813912957 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_ARCH_I386_H
 #define _NOLIBC_ARCH_I386_H
 
+#include "compiler.h"
+
 /* The struct returned by the stat() syscall, 32-bit only, the syscall returns
  * exactly 56 bytes (stops before the unused array).
  */
@@ -181,8 +183,6 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
-#define __ARCH_SUPPORTS_STACK_PROTECTOR
-
 /* startup code */
 /*
  * i386 System V ABI mandates:
@@ -193,7 +193,7 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
-#ifdef NOLIBC_STACKPROTECTOR
+#ifdef _NOLIBC_STACKPROTECTOR
 		"call __stack_chk_init\n"   /* initialize stack protector                    */
 #endif
 		"pop %eax\n"                /* argc   (first arg, %eax)                      */
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 07e3b1fd7262..d8ea7e787df4 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_ARCH_LOONGARCH_H
 #define _NOLIBC_ARCH_LOONGARCH_H
 
+#include "compiler.h"
+
 /* Syscalls for LoongArch :
  *   - stack is 16-byte aligned
  *   - syscall number is passed in a7
@@ -149,8 +151,6 @@
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
-#define __ARCH_SUPPORTS_STACK_PROTECTOR
-
 #if __loongarch_grlen == 32
 #define LONGLOG      "2"
 #define SZREG        "4"
@@ -175,7 +175,7 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
-#ifdef NOLIBC_STACKPROTECTOR
+#ifdef _NOLIBC_STACKPROTECTOR
 		"bl __stack_chk_init\n"               /* initialize stack protector                          */
 #endif
 		REG_L        " $a0, $sp, 0\n"         /* argc (a0) was in the stack                          */
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 65c19ccc7f9d..9860236e5340 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_ARCH_MIPS_H
 #define _NOLIBC_ARCH_MIPS_H
 
+#include "compiler.h"
+
 /* The struct returned by the stat() syscall. 88 bytes are returned by the
  * syscall.
  */
@@ -179,8 +181,6 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
-#define __ARCH_SUPPORTS_STACK_PROTECTOR
-
 /* startup code, note that it's called __start on MIPS */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) __start(void)
 {
@@ -189,7 +189,7 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protec
 		".set push\n"
 		".set    noreorder\n"
 		".option pic0\n"
-#ifdef NOLIBC_STACKPROTECTOR
+#ifdef _NOLIBC_STACKPROTECTOR
 		"jal __stack_chk_init\n" /* initialize stack protector                         */
 		"nop\n"                  /* delayed slot                                       */
 #endif
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index d0439249c9c9..86616aeb77a0 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_ARCH_RISCV_H
 #define _NOLIBC_ARCH_RISCV_H
 
+#include "compiler.h"
+
 struct sys_stat_struct {
 	unsigned long	st_dev;		/* Device.  */
 	unsigned long	st_ino;		/* File serial number.  */
@@ -177,8 +179,6 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
-#define __ARCH_SUPPORTS_STACK_PROTECTOR
-
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
@@ -187,7 +187,7 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protec
 		".option norelax\n"
 		"lla   gp, __global_pointer$\n"
 		".option pop\n"
-#ifdef NOLIBC_STACKPROTECTOR
+#ifdef _NOLIBC_STACKPROTECTOR
 		"call __stack_chk_init\n"    /* initialize stack protector                          */
 #endif
 		REG_L" a0, 0(sp)\n"          /* argc (a0) was in the stack                          */
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index e201af15e142..485a7ff72a87 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_ARCH_X86_64_H
 #define _NOLIBC_ARCH_X86_64_H
 
+#include "compiler.h"
+
 /* The struct returned by the stat() syscall, equivalent to stat64(). The
  * syscall returns 116 bytes and stops in the middle of __unused.
  */
@@ -181,8 +183,6 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
-#define __ARCH_SUPPORTS_STACK_PROTECTOR
-
 /* startup code */
 /*
  * x86-64 System V ABI mandates:
@@ -193,7 +193,7 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
-#ifdef NOLIBC_STACKPROTECTOR
+#ifdef _NOLIBC_STACKPROTECTOR
 		"call __stack_chk_init\n"   /* initialize stack protector                          */
 #endif
 		"pop %rdi\n"                /* argc   (first arg, %rdi)                            */
diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
new file mode 100644
index 000000000000..57da75cea799
--- /dev/null
+++ b/tools/include/nolibc/compiler.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * NOLIBC compiler support header
+ * Copyright (C) 2023 Thomas Weißschuh <linux@weissschuh.net>
+ */
+#ifndef _NOLIBC_COMPILER_H
+#define _NOLIBC_COMPILER_H
+
+#if defined(__SSP__) || defined(__SSP_STRONG__) || defined(__SSP_ALL__) || defined(__SSP_EXPLICIT__)
+
+#define _NOLIBC_STACKPROTECTOR
+
+#endif /* defined(__SSP__) ... */
+
+#endif /* _NOLIBC_COMPILER_H */
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index b0156fc077a0..0a89e2b89ca6 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -7,13 +7,9 @@
 #ifndef _NOLIBC_STACKPROTECTOR_H
 #define _NOLIBC_STACKPROTECTOR_H
 
-#include "arch.h"
+#include "compiler.h"
 
-#if defined(NOLIBC_STACKPROTECTOR)
-
-#if !defined(__ARCH_SUPPORTS_STACK_PROTECTOR)
-#error "nolibc does not support stack protectors on this arch"
-#endif
+#if defined(_NOLIBC_STACKPROTECTOR)
 
 #include "sys.h"
 #include "stdlib.h"
@@ -49,6 +45,6 @@ void __stack_chk_init(void)
 	if (__stack_chk_guard != (uintptr_t) &__stack_chk_guard)
 		__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
 }
-#endif /* defined(NOLIBC_STACKPROTECTOR) */
+#endif /* defined(_NOLIBC_STACKPROTECTOR) */
 
 #endif /* _NOLIBC_STACKPROTECTOR_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 861b9a74b71f..b50b5a8bcc90 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -802,13 +802,13 @@ static int run_protection(int min, int max)
 
 	llen += printf("0 -fstackprotector ");
 
-#if !defined(NOLIBC_STACKPROTECTOR)
+#if !defined(_NOLIBC_STACKPROTECTOR)
 	llen += printf("not supported");
 	pad_spc(llen, 64, "[SKIPPED]\n");
 	return 0;
 #endif
 
-#if defined(NOLIBC_STACKPROTECTOR)
+#if defined(_NOLIBC_STACKPROTECTOR)
 	if (!__stack_chk_guard) {
 		llen += printf("__stack_chk_guard not initialized");
 		pad_spc(llen, 64, "[FAIL]\n");
-- 
2.40.1

