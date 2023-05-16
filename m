Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EAD7048B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjEPJL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjEPJKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D9249C1;
        Tue, 16 May 2023 02:10:04 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228200;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+Hr9uxG3PpxL1NN2dciFk8dChTBpokmPa1W5wkPnz4=;
        b=Q33QtIj7ECcJER4gqXl+GQmyyWAXpW2Pm6WAxRyl3UuV8hRnVGyQoihDIGbfH8X1nJqVb4
        dBGUV9NL53LCKTY5R8GANi+BhzRrhm3nIpioujrFQM9uTfXkLWa4AekVGJQluSset/+0QH
        TlIYeS5CvBbSqsd4AQ7qUO0BvXQdUQ83xZHasBKYmyXX7nZTlMCAyIwl3U58D+zHnAj8Bc
        LRPHGzLvIBYDnrz7OBwfaeKP8G1J2+QQr9R3/SJIuNFKezlAWAPtItJECOmF2+WJHr+Wmr
        Mo9zkU5epFsfd5gKY8A6TnQHfXzyil3k/ddpMEjB+aYpwaE3QO9zz6JLXG5j8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228200;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+Hr9uxG3PpxL1NN2dciFk8dChTBpokmPa1W5wkPnz4=;
        b=gm21szvfqMuVqU8ejSBrmeyLzme0udlZi+H0PjZtn+50COQXhFYxrcglBRTwdc930Rfl9g
        5LtgsEOMt/Cpg8BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Remove cpu_callin_mask
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205256.206394064@linutronix.de>
References: <20230512205256.206394064@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819999.404.14981768167213672785.tip-bot2@tip-bot2>
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

Commit-ID:     c8b7fb09d1bcfa61d4211f61542e1291e7b4cbad
Gitweb:        https://git.kernel.org/tip/c8b7fb09d1bcfa61d4211f61542e1291e7b4cbad
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:53 +02:00

x86/smpboot: Remove cpu_callin_mask

Now that TSC synchronization is SMP function call based there is no reason
to wait for the AP to be set in smp_callin_mask. The control CPU waits for
the AP to set itself in the online mask anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205256.206394064@linutronix.de
---
 arch/x86/kernel/smpboot.c | 74 +++++++-------------------------------
 1 file changed, 15 insertions(+), 59 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b2f44a8..3f731be 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -104,7 +104,6 @@ EXPORT_PER_CPU_SYMBOL(cpu_info);
 /* All of these masks are initialized in setup_cpu_local_masks() */
 static cpumask_var_t cpu_initialized_mask;
 static cpumask_var_t cpu_callout_mask;
-static cpumask_var_t cpu_callin_mask;
 /* Representing CPUs for which sibling maps can be computed */
 static cpumask_var_t cpu_sibling_setup_mask;
 
@@ -161,38 +160,30 @@ static inline void smpboot_restore_warm_reset_vector(void)
 
 }
 
-/*
- * Report back to the Boot Processor during boot time or to the caller processor
- * during CPU online.
- */
-static void smp_callin(void)
+/* Run the next set of setup steps for the upcoming CPU */
+static void ap_starting(void)
 {
-	int cpuid;
-
-	/*
-	 * If waken up by an INIT in an 82489DX configuration
-	 * cpu_callout_mask guarantees we don't get here before
-	 * an INIT_deassert IPI reaches our local APIC, so it is
-	 * now safe to touch our local APIC.
-	 */
-	cpuid = smp_processor_id();
+	int cpuid = smp_processor_id();
 
 	/*
-	 * the boot CPU has finished the init stage and is spinning
-	 * on callin_map until we finish. We are free to set up this
-	 * CPU, first the APIC. (this is probably redundant on most
-	 * boards)
+	 * If woken up by an INIT in an 82489DX configuration
+	 * cpu_callout_mask guarantees the CPU does not reach this point
+	 * before an INIT_deassert IPI reaches the local APIC, so it is now
+	 * safe to touch the local APIC.
+	 *
+	 * Set up this CPU, first the APIC, which is probably redundant on
+	 * most boards.
 	 */
 	apic_ap_setup();
 
-	/* Save our processor parameters. */
+	/* Save the processor parameters. */
 	smp_store_cpu_info(cpuid);
 
 	/*
 	 * The topology information must be up to date before
 	 * notify_cpu_starting().
 	 */
-	set_cpu_sibling_map(raw_smp_processor_id());
+	set_cpu_sibling_map(cpuid);
 
 	ap_init_aperfmperf();
 
@@ -205,11 +196,6 @@ static void smp_callin(void)
 	 * state CPUHP_ONLINE.
 	 */
 	notify_cpu_starting(cpuid);
-
-	/*
-	 * Allow the master to continue.
-	 */
-	cpumask_set_cpu(cpuid, cpu_callin_mask);
 }
 
 static void ap_calibrate_delay(void)
@@ -268,12 +254,7 @@ static void notrace start_secondary(void *unused)
 	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
 
-	/*
-	 * Sync point with wait_cpu_callin(). The AP doesn't wait here
-	 * but just sets the bit to let the controlling CPU (BSP) know that
-	 * it's got this far.
-	 */
-	smp_callin();
+	ap_starting();
 
 	/* Check TSC synchronization with the control CPU. */
 	check_tsc_sync_target();
@@ -1109,7 +1090,7 @@ static int wait_cpu_cpumask(unsigned int cpu, const struct cpumask *mask)
  * and thus wait_for_master_cpu(), then set cpu_callout_mask to allow it
  * to proceed.  The AP will then proceed past setting its 'callin' bit
  * and end up waiting in check_tsc_sync_target() until we reach
- * do_wait_cpu_online() to tend to it.
+ * wait_cpu_online() to tend to it.
  */
 static int wait_cpu_initialized(unsigned int cpu)
 {
@@ -1124,20 +1105,7 @@ static int wait_cpu_initialized(unsigned int cpu)
 }
 
 /*
- * Bringup step three: Wait for the target AP to reach smp_callin().
- * The AP is not waiting for us here so we don't need to parallelise
- * this step. Not entirely clear why we care about this, since we just
- * proceed directly to TSC synchronization which is the next sync
- * point with the AP anyway.
- */
-static void wait_cpu_callin(unsigned int cpu)
-{
-	while (!cpumask_test_cpu(cpu, cpu_callin_mask))
-		schedule();
-}
-
-/*
- * Bringup step four: Wait for the target AP to reach set_cpu_online() in
+ * Bringup step three: Wait for the target AP to reach set_cpu_online() in
  * start_secondary().
  */
 static void wait_cpu_online(unsigned int cpu)
@@ -1167,14 +1135,6 @@ static int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 	}
 
 	/*
-	 * Already booted CPU?
-	 */
-	if (cpumask_test_cpu(cpu, cpu_callin_mask)) {
-		pr_debug("do_boot_cpu %d Already started\n", cpu);
-		return -ENOSYS;
-	}
-
-	/*
 	 * Save current MTRR state in case it was changed since early boot
 	 * (e.g. by the ACPI SMI) to initialize new CPUs with MTRRs in sync:
 	 */
@@ -1211,7 +1171,6 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 	if (ret)
 		goto out;
 
-	wait_cpu_callin(cpu);
 	wait_cpu_online(cpu);
 
 out:
@@ -1327,7 +1286,6 @@ void __init smp_prepare_cpus_common(void)
 	 * Setup boot CPU information
 	 */
 	smp_store_boot_cpu_info(); /* Final full version of the data */
-	cpumask_copy(cpu_callin_mask, cpumask_of(0));
 	mb();
 
 	for_each_possible_cpu(i) {
@@ -1542,7 +1500,6 @@ __init void prefill_possible_map(void)
 void __init setup_cpu_local_masks(void)
 {
 	alloc_bootmem_cpumask_var(&cpu_initialized_mask);
-	alloc_bootmem_cpumask_var(&cpu_callin_mask);
 	alloc_bootmem_cpumask_var(&cpu_callout_mask);
 	alloc_bootmem_cpumask_var(&cpu_sibling_setup_mask);
 }
@@ -1606,7 +1563,6 @@ static void remove_cpu_from_maps(int cpu)
 {
 	set_cpu_online(cpu, false);
 	cpumask_clear_cpu(cpu, cpu_callout_mask);
-	cpumask_clear_cpu(cpu, cpu_callin_mask);
 	/* was set by cpu_init() */
 	cpumask_clear_cpu(cpu, cpu_initialized_mask);
 	numa_remove_cpu(cpu);
