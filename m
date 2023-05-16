Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAE27048B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjEPJMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjEPJKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF244ECE;
        Tue, 16 May 2023 02:10:06 -0700 (PDT)
Date:   Tue, 16 May 2023 09:10:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhyYjOdL9Xh+igEdWlJzgDl6PmeFAtVERSEQAfxWd+8=;
        b=pELWHZ9IZJ7PzmsbKdmftWxpU++vvpP7FfZE64oZerMZ/Tppj83FwX0R4dyQrsA2lrHoVn
        TwID5y2GkQ5HymADOonc7WMmhEBiBRLawF4AE6DcAnaq0vnfavy5y2u4kWxKBzIMXhnACL
        b7Q5DUsvrAK7fPv3JEwMONrkm+w0/kIy8Q7fgzySZcvQYbXub89oq6Zm8jypmWYVHlXtNa
        0PD8eyRsC63h1trVqFHMNmKaeA/IZOmCLz5U/ZSEwH+K2wTROxSBThXDMyBTBC2hXD29L5
        sckzEQz2v2vb0nJLfTBcfklgryvpaOT9HpC5zOTFQdg3q+EfytviZNYVszLqXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhyYjOdL9Xh+igEdWlJzgDl6PmeFAtVERSEQAfxWd+8=;
        b=SyZIdwshXo9RJgHXV9tyOdgZGJPJBHwiUFJNm79sE22gQZPRAG0gqXtrV7pfC/y6iQyJlL
        lLLnAaYtxGfIhaAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Avoid pointless delay calibration if TSC
 is synchronized
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205255.608773568@linutronix.de>
References: <20230512205255.608773568@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422820317.404.12739124536640523554.tip-bot2@tip-bot2>
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

Commit-ID:     134a12827bc59484c4d4a3ceabf178c831febbb8
Gitweb:        https://git.kernel.org/tip/134a12827bc59484c4d4a3ceabf178c831febbb8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:48 +02:00

x86/smpboot: Avoid pointless delay calibration if TSC is synchronized

When TSC is synchronized across sockets then there is no reason to
calibrate the delay for the first CPU which comes up on a socket.

Just reuse the existing calibration value.

This removes 100ms pointlessly wasted time from CPU hotplug per socket.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205255.608773568@linutronix.de
---
 arch/x86/kernel/smpboot.c | 40 +++++++++++++++++++++++---------------
 arch/x86/kernel/tsc.c     | 20 +++++++++++++++----
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8eb7721..0ad902a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -178,28 +178,17 @@ static void smp_callin(void)
 	 */
 	apic_ap_setup();
 
-	/*
-	 * Save our processor parameters. Note: this information
-	 * is needed for clock calibration.
-	 */
+	/* Save our processor parameters. */
 	smp_store_cpu_info(cpuid);
 
 	/*
 	 * The topology information must be up to date before
-	 * calibrate_delay() and notify_cpu_starting().
+	 * notify_cpu_starting().
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
 	ap_init_aperfmperf();
 
-	/*
-	 * Get our bogomips.
-	 * Update loops_per_jiffy in cpu_data. Previous call to
-	 * smp_store_cpu_info() stored a value that is close but not as
-	 * accurate as the value just calculated.
-	 */
-	calibrate_delay();
-	cpu_data(cpuid).loops_per_jiffy = loops_per_jiffy;
 	pr_debug("Stack at about %p\n", &cpuid);
 
 	wmb();
@@ -212,8 +201,24 @@ static void smp_callin(void)
 	cpumask_set_cpu(cpuid, cpu_callin_mask);
 }
 
+static void ap_calibrate_delay(void)
+{
+	/*
+	 * Calibrate the delay loop and update loops_per_jiffy in cpu_data.
+	 * smp_store_cpu_info() stored a value that is close but not as
+	 * accurate as the value just calculated.
+	 *
+	 * As this is invoked after the TSC synchronization check,
+	 * calibrate_delay_is_known() will skip the calibration routine
+	 * when TSC is synchronized across sockets.
+	 */
+	calibrate_delay();
+	cpu_data(smp_processor_id()).loops_per_jiffy = loops_per_jiffy;
+}
+
 static int cpu0_logical_apicid;
 static int enable_start_cpu0;
+
 /*
  * Activate a secondary processor.
  */
@@ -240,10 +245,15 @@ static void notrace start_secondary(void *unused)
 
 	/* otherwise gcc will move up smp_processor_id before the cpu_init */
 	barrier();
+	/* Check TSC synchronization with the control CPU: */
+	check_tsc_sync_target();
+
 	/*
-	 * Check TSC synchronization with the boot CPU:
+	 * Calibrate the delay loop after the TSC synchronization check.
+	 * This allows to skip the calibration when TSC is synchronized
+	 * across sockets.
 	 */
-	check_tsc_sync_target();
+	ap_calibrate_delay();
 
 	speculative_store_bypass_ht_init();
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3446988..1412b77 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1598,10 +1598,7 @@ void __init tsc_init(void)
 
 #ifdef CONFIG_SMP
 /*
- * If we have a constant TSC and are using the TSC for the delay loop,
- * we can skip clock calibration if another cpu in the same socket has already
- * been calibrated. This assumes that CONSTANT_TSC applies to all
- * cpus in the socket - this should be a safe assumption.
+ * Check whether existing calibration data can be reused.
  */
 unsigned long calibrate_delay_is_known(void)
 {
@@ -1609,6 +1606,21 @@ unsigned long calibrate_delay_is_known(void)
 	int constant_tsc = cpu_has(&cpu_data(cpu), X86_FEATURE_CONSTANT_TSC);
 	const struct cpumask *mask = topology_core_cpumask(cpu);
 
+	/*
+	 * If TSC has constant frequency and TSC is synchronized across
+	 * sockets then reuse CPU0 calibration.
+	 */
+	if (constant_tsc && !tsc_unstable)
+		return cpu_data(0).loops_per_jiffy;
+
+	/*
+	 * If TSC has constant frequency and TSC is not synchronized across
+	 * sockets and this is not the first CPU in the socket, then reuse
+	 * the calibration value of an already online CPU on that socket.
+	 *
+	 * This assumes that CONSTANT_TSC is consistent for all CPUs in a
+	 * socket.
+	 */
 	if (!constant_tsc || !mask)
 		return 0;
 
