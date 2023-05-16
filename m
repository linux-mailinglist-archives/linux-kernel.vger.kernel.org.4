Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD55A7048AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjEPJLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjEPJKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD28A2D7F;
        Tue, 16 May 2023 02:10:03 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaP3IirQS29/nSRBGEvaWqpv53AEDPCueTjFwjsewdU=;
        b=yYMXhxyw1cZSdgPS9GRgRXxHEwwE0Q2foQtzhTHwRJfEslu2EcG1qguNDVLs9lKxak49sq
        EtfCsXV2ZLsvOX8n53uVsQCG4ckLLwm588joMplO/GPGktMFPcLwbZC7cw1W7ddAcxjZ28
        1Sfb9iXGWbn8FNIM6MHYCQ7BKM5UKCZvOCGscSXJRV8Jac1N7ttTAiaqwwDYrQpBGZjdaG
        nFqE4UA2snPMycANAhSaPDsO8GPfAiryqDgqD5jjnaMjJHy5Aeli+FUHWhH1znpfIxCEiD
        EpjnCjY5UHoy5uzyh0Fu9Adwg78KEbBgNkZkM1pl8zaY8BZk51/zDH9T9Va2Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaP3IirQS29/nSRBGEvaWqpv53AEDPCueTjFwjsewdU=;
        b=hV/fvp5UmC1dZ4ZtJhTYLv2Rk6mveoUPHZ2LhHIiCUJUNj7E1RHj/unQDv/dWL5YtZyyhl
        GeSJYRRzo0h/rtCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] ARM: smp: Switch to hotplug core state synchronization
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205256.635326070@linutronix.de>
References: <20230512205256.635326070@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819767.404.5002572577505730138.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     5490e769cdc7230cb93e804e656cce19d6c82253
Gitweb:        https://git.kernel.org/tip/5490e769cdc7230cb93e804e656cce19d6c82253
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:57 +02:00

ARM: smp: Switch to hotplug core state synchronization

Switch to the CPU hotplug core state tracking and synchronization
mechanim. No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205256.635326070@linutronix.de
---
 arch/arm/Kconfig           |  1 +
 arch/arm/include/asm/smp.h |  2 +-
 arch/arm/kernel/smp.c      | 18 +++++++-----------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0fb4b21..775ce86 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -124,6 +124,7 @@ config ARM
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 7c1c90d..8c05a7f 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -64,7 +64,7 @@ extern void secondary_startup_arm(void);
 
 extern int __cpu_disable(void);
 
-extern void __cpu_die(unsigned int cpu);
+static inline void __cpu_die(unsigned int cpu) { }
 
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 87f8d0e..6756203 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -288,15 +288,11 @@ int __cpu_disable(void)
 }
 
 /*
- * called on the thread which is asking for a CPU to be shutdown -
- * waits until shutdown has completed, or it is timed out.
+ * called on the thread which is asking for a CPU to be shutdown after the
+ * shutdown completed.
  */
-void __cpu_die(unsigned int cpu)
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 {
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_err("CPU%u: cpu didn't die\n", cpu);
-		return;
-	}
 	pr_debug("CPU%u: shutdown\n", cpu);
 
 	clear_tasks_mm_cpumask(cpu);
@@ -336,11 +332,11 @@ void __noreturn arch_cpu_idle_dead(void)
 	flush_cache_louis();
 
 	/*
-	 * Tell __cpu_die() that this CPU is now safe to dispose of.  Once
-	 * this returns, power and/or clocks can be removed at any point
-	 * from this CPU and its cache by platform_cpu_kill().
+	 * Tell cpuhp_bp_sync_dead() that this CPU is now safe to dispose
+	 * of. Once this returns, power and/or clocks can be removed at
+	 * any point from this CPU and its cache by platform_cpu_kill().
 	 */
-	(void)cpu_report_death();
+	cpuhp_ap_report_dead();
 
 	/*
 	 * Ensure that the cache lines associated with that completion are
