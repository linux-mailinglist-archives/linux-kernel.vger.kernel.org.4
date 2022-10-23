Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DEC60962C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJWUdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJWUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:33:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D9E6715F;
        Sun, 23 Oct 2022 13:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F460B80DD0;
        Sun, 23 Oct 2022 20:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20E3C433C1;
        Sun, 23 Oct 2022 20:32:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GGCHpZzH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666557174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvHYiUD7yNRmt/asO7QumwNoOyWIQxir33jt5CIvM9o=;
        b=GGCHpZzHb5lPcZyGswIBHQcNGEIPQaTvQl+HfPJd/ZnqTaqWRNrjWebo//8RZ9Rqsu65Sh
        UHaBe/0H4JjmNEcvv7wzFRjm+/GTanCFE+z1xJtK0Imgg1gWbl5PTEfnCazGMwFSZi9Up3
        5286Zs09ENNAYT6JT+IB3ssrqgGzpl4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 69c84e2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 23 Oct 2022 20:32:54 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v1 2/2] stackprotector: actually use get_random_canary()
Date:   Sun, 23 Oct 2022 22:32:08 +0200
Message-Id: <20221023203208.118919-3-Jason@zx2c4.com>
In-Reply-To: <20221023203208.118919-1-Jason@zx2c4.com>
References: <20221023203208.118919-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RNG always mixes in the Linux version extremely early in boot. It
also always includes a cycle counter, not only during early boot, but
each and every time it is invoked prior to being fully initialized.
Together, this means that the use of additional xors inside of the
various stackprotector.h files is superfluous and over-complicated.
Instead, we can get exactly the same thing, but better, by just calling
`get_random_canary()`.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/arm/include/asm/stackprotector.h     |  9 +--------
 arch/arm64/include/asm/stackprotector.h   |  9 +--------
 arch/csky/include/asm/stackprotector.h    | 10 +---------
 arch/mips/include/asm/stackprotector.h    |  9 +--------
 arch/powerpc/include/asm/stackprotector.h | 10 +---------
 arch/riscv/include/asm/stackprotector.h   | 10 +---------
 arch/sh/include/asm/stackprotector.h      | 10 +---------
 arch/x86/include/asm/stackprotector.h     | 14 +-------------
 arch/xtensa/include/asm/stackprotector.h  |  7 +------
 9 files changed, 9 insertions(+), 79 deletions(-)

diff --git a/arch/arm/include/asm/stackprotector.h b/arch/arm/include/asm/stackprotector.h
index 088d03161be5..0bd4979759f1 100644
--- a/arch/arm/include/asm/stackprotector.h
+++ b/arch/arm/include/asm/stackprotector.h
@@ -15,9 +15,6 @@
 #ifndef _ASM_STACKPROTECTOR_H
 #define _ASM_STACKPROTECTOR_H 1
 
-#include <linux/random.h>
-#include <linux/version.h>
-
 #include <asm/thread_info.h>
 
 extern unsigned long __stack_chk_guard;
@@ -30,11 +27,7 @@ extern unsigned long __stack_chk_guard;
  */
 static __always_inline void boot_init_stack_canary(void)
 {
-	unsigned long canary;
-
-	/* Try to get a semi random initial value. */
-	get_random_bytes(&canary, sizeof(canary));
-	canary ^= LINUX_VERSION_CODE;
+	unsigned long canary = get_random_canary();
 
 	current->stack_canary = canary;
 #ifndef CONFIG_STACKPROTECTOR_PER_TASK
diff --git a/arch/arm64/include/asm/stackprotector.h b/arch/arm64/include/asm/stackprotector.h
index 33f1bb453150..ae3ad80f51fe 100644
--- a/arch/arm64/include/asm/stackprotector.h
+++ b/arch/arm64/include/asm/stackprotector.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_STACKPROTECTOR_H
 #define __ASM_STACKPROTECTOR_H
 
-#include <linux/random.h>
-#include <linux/version.h>
 #include <asm/pointer_auth.h>
 
 extern unsigned long __stack_chk_guard;
@@ -28,12 +26,7 @@ extern unsigned long __stack_chk_guard;
 static __always_inline void boot_init_stack_canary(void)
 {
 #if defined(CONFIG_STACKPROTECTOR)
-	unsigned long canary;
-
-	/* Try to get a semi random initial value. */
-	get_random_bytes(&canary, sizeof(canary));
-	canary ^= LINUX_VERSION_CODE;
-	canary &= CANARY_MASK;
+	unsigned long canary = get_random_canary();
 
 	current->stack_canary = canary;
 	if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
diff --git a/arch/csky/include/asm/stackprotector.h b/arch/csky/include/asm/stackprotector.h
index d7cd4e51edd9..d23747447166 100644
--- a/arch/csky/include/asm/stackprotector.h
+++ b/arch/csky/include/asm/stackprotector.h
@@ -2,9 +2,6 @@
 #ifndef _ASM_STACKPROTECTOR_H
 #define _ASM_STACKPROTECTOR_H 1
 
-#include <linux/random.h>
-#include <linux/version.h>
-
 extern unsigned long __stack_chk_guard;
 
 /*
@@ -15,12 +12,7 @@ extern unsigned long __stack_chk_guard;
  */
 static __always_inline void boot_init_stack_canary(void)
 {
-	unsigned long canary;
-
-	/* Try to get a semi random initial value. */
-	get_random_bytes(&canary, sizeof(canary));
-	canary ^= LINUX_VERSION_CODE;
-	canary &= CANARY_MASK;
+	unsigned long canary = get_random_canary();
 
 	current->stack_canary = canary;
 	__stack_chk_guard = current->stack_canary;
diff --git a/arch/mips/include/asm/stackprotector.h b/arch/mips/include/asm/stackprotector.h
index 68d4be9e1254..518c192ad982 100644
--- a/arch/mips/include/asm/stackprotector.h
+++ b/arch/mips/include/asm/stackprotector.h
@@ -15,9 +15,6 @@
 #ifndef _ASM_STACKPROTECTOR_H
 #define _ASM_STACKPROTECTOR_H 1
 
-#include <linux/random.h>
-#include <linux/version.h>
-
 extern unsigned long __stack_chk_guard;
 
 /*
@@ -28,11 +25,7 @@ extern unsigned long __stack_chk_guard;
  */
 static __always_inline void boot_init_stack_canary(void)
 {
-	unsigned long canary;
-
-	/* Try to get a semi random initial value. */
-	get_random_bytes(&canary, sizeof(canary));
-	canary ^= LINUX_VERSION_CODE;
+	unsigned long canary = get_random_canary();
 
 	current->stack_canary = canary;
 	__stack_chk_guard = current->stack_canary;
diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
index 1c8460e23583..283c34647856 100644
--- a/arch/powerpc/include/asm/stackprotector.h
+++ b/arch/powerpc/include/asm/stackprotector.h
@@ -7,8 +7,6 @@
 #ifndef _ASM_STACKPROTECTOR_H
 #define _ASM_STACKPROTECTOR_H
 
-#include <linux/random.h>
-#include <linux/version.h>
 #include <asm/reg.h>
 #include <asm/current.h>
 #include <asm/paca.h>
@@ -21,13 +19,7 @@
  */
 static __always_inline void boot_init_stack_canary(void)
 {
-	unsigned long canary;
-
-	/* Try to get a semi random initial value. */
-	canary = get_random_canary();
-	canary ^= mftb();
-	canary ^= LINUX_VERSION_CODE;
-	canary &= CANARY_MASK;
+	unsigned long canary = get_random_canary();
 
 	current->stack_canary = canary;
 #ifdef CONFIG_PPC64
diff --git a/arch/riscv/include/asm/stackprotector.h b/arch/riscv/include/asm/stackprotector.h
index 09093af46565..43895b90fe3f 100644
--- a/arch/riscv/include/asm/stackprotector.h
+++ b/arch/riscv/include/asm/stackprotector.h
@@ -3,9 +3,6 @@
 #ifndef _ASM_RISCV_STACKPROTECTOR_H
 #define _ASM_RISCV_STACKPROTECTOR_H
 
-#include <linux/random.h>
-#include <linux/version.h>
-
 extern unsigned long __stack_chk_guard;
 
 /*
@@ -16,12 +13,7 @@ extern unsigned long __stack_chk_guard;
  */
 static __always_inline void boot_init_stack_canary(void)
 {
-	unsigned long canary;
-
-	/* Try to get a semi random initial value. */
-	get_random_bytes(&canary, sizeof(canary));
-	canary ^= LINUX_VERSION_CODE;
-	canary &= CANARY_MASK;
+	unsigned long canary = get_random_canary();
 
 	current->stack_canary = canary;
 	if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
diff --git a/arch/sh/include/asm/stackprotector.h b/arch/sh/include/asm/stackprotector.h
index 35616841d0a1..665dafac376f 100644
--- a/arch/sh/include/asm/stackprotector.h
+++ b/arch/sh/include/asm/stackprotector.h
@@ -2,9 +2,6 @@
 #ifndef __ASM_SH_STACKPROTECTOR_H
 #define __ASM_SH_STACKPROTECTOR_H
 
-#include <linux/random.h>
-#include <linux/version.h>
-
 extern unsigned long __stack_chk_guard;
 
 /*
@@ -15,12 +12,7 @@ extern unsigned long __stack_chk_guard;
  */
 static __always_inline void boot_init_stack_canary(void)
 {
-	unsigned long canary;
-
-	/* Try to get a semi random initial value. */
-	get_random_bytes(&canary, sizeof(canary));
-	canary ^= LINUX_VERSION_CODE;
-	canary &= CANARY_MASK;
+	unsigned long canary = get_random_canary();
 
 	current->stack_canary = canary;
 	__stack_chk_guard = current->stack_canary;
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 24a8d6c4fb18..00473a650f51 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -34,7 +34,6 @@
 #include <asm/percpu.h>
 #include <asm/desc.h>
 
-#include <linux/random.h>
 #include <linux/sched.h>
 
 /*
@@ -50,22 +49,11 @@
  */
 static __always_inline void boot_init_stack_canary(void)
 {
-	u64 canary;
-	u64 tsc;
+	unsigned long canary = get_random_canary();
 
 #ifdef CONFIG_X86_64
 	BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
 #endif
-	/*
-	 * We both use the random pool and the current TSC as a source
-	 * of randomness. The TSC only matters for very early init,
-	 * there it already has some randomness on most systems. Later
-	 * on during the bootup the random pool has true entropy too.
-	 */
-	get_random_bytes(&canary, sizeof(canary));
-	tsc = rdtsc();
-	canary += tsc + (tsc << 32UL);
-	canary &= CANARY_MASK;
 
 	current->stack_canary = canary;
 #ifdef CONFIG_X86_64
diff --git a/arch/xtensa/include/asm/stackprotector.h b/arch/xtensa/include/asm/stackprotector.h
index e368f94fd2af..e1e318a0c98a 100644
--- a/arch/xtensa/include/asm/stackprotector.h
+++ b/arch/xtensa/include/asm/stackprotector.h
@@ -14,7 +14,6 @@
 #ifndef _ASM_STACKPROTECTOR_H
 #define _ASM_STACKPROTECTOR_H 1
 
-#include <linux/random.h>
 #include <linux/version.h>
 
 extern unsigned long __stack_chk_guard;
@@ -27,11 +26,7 @@ extern unsigned long __stack_chk_guard;
  */
 static __always_inline void boot_init_stack_canary(void)
 {
-	unsigned long canary;
-
-	/* Try to get a semi random initial value. */
-	get_random_bytes(&canary, sizeof(canary));
-	canary ^= LINUX_VERSION_CODE;
+	unsigned long canary = get_random_canary();
 
 	current->stack_canary = canary;
 	__stack_chk_guard = current->stack_canary;
-- 
2.38.1

