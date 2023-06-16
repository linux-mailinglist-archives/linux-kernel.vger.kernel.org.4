Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FA4732B73
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344399AbjFPJ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344134AbjFPJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B775EA;
        Fri, 16 Jun 2023 02:24:52 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907488;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CRZ/I+UHhDqzwb3VMqBS3zXkZGutnO/KuKUuPRDd4w=;
        b=iiRuaZqg+ML8Y7P/U4IvPnWsPvt360b1m4qJFPRXIHUgtSZI311SDLKRN9z/snR5Vs6YRx
        ODimoHNTpntc6LXvwIooI02dtPgSfhyYMLmSUa0GrRzl7qkNn32giLW1j1An7hjm8g1eCk
        WEKSwzM3epB2vckajyFbSTxykloq9eUHXjeMMMyqy726iTeG5OrHpWaIpVctQPpwDqqbZt
        bQwddA3VxXV0tPotH2RuZ2mSOAFocyaKixA41DJVjgWyZIsZk7AmTITm2neOY3E/Yp3X1n
        3ZpN/co2UavIGMC7iJf6EkKYg+Jd3F+2ogsa+OHk0jsJ2eyGDLfhC1xpyp/igw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907488;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CRZ/I+UHhDqzwb3VMqBS3zXkZGutnO/KuKUuPRDd4w=;
        b=3CIbApYBXKikxfE00QRM4Djn93HFAAzVRCmFv2xTNrWupP7Opn+bCmFHzSUGisOY1rnwdw
        6CZ0/7rGs17BK/Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] m68k/cpu: Switch to arch_cpu_finalize_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.254342916@linutronix.de>
References: <20230613224545.254342916@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748843.404.10599176474859670498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     9ceecc2589b9d7cef6b321339ed8de484eac4b20
Gitweb:        https://git.kernel.org/tip/9ceecc2589b9d7cef6b321339ed8de484eac4b20
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:15:59 +02:00

m68k/cpu: Switch to arch_cpu_finalize_init()

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20230613224545.254342916@linutronix.de

---
 arch/m68k/Kconfig            |  1 +
 arch/m68k/include/asm/bugs.h | 21 ---------------------
 arch/m68k/kernel/setup_mm.c  |  3 ++-
 3 files changed, 3 insertions(+), 22 deletions(-)
 delete mode 100644 arch/m68k/include/asm/bugs.h

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 40198a1..dc792b3 100644
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
diff --git a/arch/m68k/include/asm/bugs.h b/arch/m68k/include/asm/bugs.h
deleted file mode 100644
index 7455306..0000000
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
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index fbff1ce..6f1ae01 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
@@ -504,7 +505,7 @@ static int __init proc_hardware_init(void)
 module_init(proc_hardware_init);
 #endif
 
-void check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 #if defined(CONFIG_FPU) && !defined(CONFIG_M68KFPU_EMU)
 	if (m68k_fputype == 0) {
