Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B3D72F020
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbjFMXkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbjFMXjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:39:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A04A1BCA;
        Tue, 13 Jun 2023 16:39:32 -0700 (PDT)
Message-ID: <20230613224545.254342916@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=S1ZfOkoiJB2kbqQox9OxmAfYtyI5QC2rzE61oGY2waI=;
        b=vF5HDxYbH8punvcwCLqKLMPap6u7XVFG9M5EvE1E2tB0CBoFcslhDsWEOgEjR+ZvsUTSpQ
        zzhInPUPy6roQjFul3ergv18bmONVjj7gNedoZqv9o4IiuPaF4ueCxogB6kh2haB9erQ3w
        YkG+GUbwDxusli6NoMhxb0+PVh+MTuTLcrHtPMqmvSdDz+gxJqBvJ7g9SmHBia8x6Uwiky
        BlvQzkCIhGguRmFm2VGi3VJP3a5oe35HHlvt6P70AVcKGjy69E6Lo6e0jN5E60nOO0ak5M
        U3DCFcJmKFiD8pc97pHKSWH5p1GyWpENCSENgnVCNwX9keOG/JpHayojaCiMgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=S1ZfOkoiJB2kbqQox9OxmAfYtyI5QC2rzE61oGY2waI=;
        b=SgpjluZPAEQtuKC4D/witxOPknzFWf9AB0QjDMq+evSyPu16vpYbAaf0xJhRGEtVEn2IUL
        tV683ff+pApvZSBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 06/17] m68k/cpu: Switch to arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 01:39:30 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 arch/m68k/Kconfig            |    1 +
 arch/m68k/include/asm/bugs.h |   21 ---------------------
 arch/m68k/kernel/setup_mm.c  |    3 ++-
 3 files changed, 3 insertions(+), 22 deletions(-)

--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -4,6 +4,7 @@ config M68K
 	default y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
--- a/arch/m68k/include/asm/bugs.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  include/asm-m68k/bugs.h
- *
- *  Copyright (C) 1994  Linus Torvalds
- */
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-#ifdef CONFIG_MMU
-extern void check_bugs(void);	/* in arch/m68k/kernel/setup.c */
-#else
-static void check_bugs(void)
-{
-}
-#endif
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
@@ -504,7 +505,7 @@ static int __init proc_hardware_init(voi
 module_init(proc_hardware_init);
 #endif
 
-void check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 #if defined(CONFIG_FPU) && !defined(CONFIG_M68KFPU_EMU)
 	if (m68k_fputype == 0) {

