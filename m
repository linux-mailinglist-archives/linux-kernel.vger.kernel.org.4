Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E147048C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjEPJM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjEPJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE734ECD;
        Tue, 16 May 2023 02:10:06 -0700 (PDT)
Date:   Tue, 16 May 2023 09:10:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ouStTd00DOqMEqwbdEHieaQ7cXHQVi3JFf+IrJXGaE=;
        b=ufufjnom7usTBPN2sp2DGdUFPIrNNgIBGdURZbyI0ptSxd/PSRGfVTHtLl58lP/cfkgNKd
        Gaj6jNzU12TMJoXXTqb0wKlERPWK2NFlGsKqFGO50Ka4x2Cc2d5cL3GRezKc96N2vUr3Iy
        55rlHU4q9uBLynPlOMg99cyMBXjA4eSQXZJsLv766BrBnQUIUL5iRyajiBvlCm6NIGXW3Q
        /6SNDCMiOCAFRD7/eBPOchujmzAOje1uhfwPd/LeCEnFF3MQ+OnxA0U7FAiIOBc7/2GfCT
        2sumPa8ja17hEH//lsGNSVl06MRD2pTXUDrA201vglP+HtWJ6MRtZiYTv3unLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ouStTd00DOqMEqwbdEHieaQ7cXHQVi3JFf+IrJXGaE=;
        b=y8CTverZgwUsDSVarzLMrXG6ig8uAT+jEC5Pk/XxhaZ0fUiucufyhTjwWy4CDc8IINCaIc
        hp+zIzPxoRsEa+BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Remove the CPU0 hotplug kludge
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205255.768845190@linutronix.de>
References: <20230512205255.768845190@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422820224.404.17661851630148144890.tip-bot2@tip-bot2>
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

Commit-ID:     5475abbde77f6d78a052a81e5d5de70e59f7181e
Gitweb:        https://git.kernel.org/tip/5475abbde77f6d78a052a81e5d5de70e59f7181e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:49 +02:00

x86/smpboot: Remove the CPU0 hotplug kludge

This was introduced with commit e1c467e69040 ("x86, hotplug: Wake up CPU0
via NMI instead of INIT, SIPI, SIPI") to eventually support physical
hotplug of CPU0:

 "We'll change this code in the future to wake up hard offlined CPU0 if
  real platform and request are available."

11 years later this has not happened and physical hotplug is not officially
supported. Remove the cruft.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205255.768845190@linutronix.de
---
 arch/x86/include/asm/apic.h   |   1 +-
 arch/x86/include/asm/smp.h    |   1 +-
 arch/x86/kernel/smpboot.c     | 168 ++-------------------------------
 drivers/acpi/processor_idle.c |   4 +-
 4 files changed, 13 insertions(+), 161 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 3216da7..dc50ed7 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -377,7 +377,6 @@ extern struct apic *__apicdrivers[], *__apicdrivers_end[];
  * APIC functionality to boot other CPUs - only used on SMP:
  */
 #ifdef CONFIG_SMP
-extern int wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip);
 extern int lapic_can_unplug_cpu(void);
 #endif
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4e91054..0ec4c64 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -130,7 +130,6 @@ void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
-void cond_wakeup_cpu0(void);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0ad902a..466e83a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -216,9 +216,6 @@ static void ap_calibrate_delay(void)
 	cpu_data(smp_processor_id()).loops_per_jiffy = loops_per_jiffy;
 }
 
-static int cpu0_logical_apicid;
-static int enable_start_cpu0;
-
 /*
  * Activate a secondary processor.
  */
@@ -241,8 +238,6 @@ static void notrace start_secondary(void *unused)
 	x86_cpuinit.early_percpu_clock_init();
 	smp_callin();
 
-	enable_start_cpu0 = 0;
-
 	/* otherwise gcc will move up smp_processor_id before the cpu_init */
 	barrier();
 	/* Check TSC synchronization with the control CPU: */
@@ -410,7 +405,7 @@ void smp_store_cpu_info(int id)
 	c->cpu_index = id;
 	/*
 	 * During boot time, CPU0 has this setup already. Save the info when
-	 * bringing up AP or offlined CPU0.
+	 * bringing up an AP.
 	 */
 	identify_secondary_cpu(c);
 	c->initialized = true;
@@ -807,51 +802,14 @@ static void __init smp_quirk_init_udelay(void)
 }
 
 /*
- * Poke the other CPU in the eye via NMI to wake it up. Remember that the normal
- * INIT, INIT, STARTUP sequence will reset the chip hard for us, and this
- * won't ... remember to clear down the APIC, etc later.
+ * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-int
-wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip)
-{
-	u32 dm = apic->dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
-	unsigned long send_status, accept_status = 0;
-	int maxlvt;
-
-	/* Target chip */
-	/* Boot on the stack */
-	/* Kick the second */
-	apic_icr_write(APIC_DM_NMI | dm, apicid);
-
-	pr_debug("Waiting for send to finish...\n");
-	send_status = safe_apic_wait_icr_idle();
-
-	/*
-	 * Give the other CPU some time to accept the IPI.
-	 */
-	udelay(200);
-	if (APIC_INTEGRATED(boot_cpu_apic_version)) {
-		maxlvt = lapic_get_maxlvt();
-		if (maxlvt > 3)			/* Due to the Pentium erratum 3AP.  */
-			apic_write(APIC_ESR, 0);
-		accept_status = (apic_read(APIC_ESR) & 0xEF);
-	}
-	pr_debug("NMI sent\n");
-
-	if (send_status)
-		pr_err("APIC never delivered???\n");
-	if (accept_status)
-		pr_err("APIC delivery error (%lx)\n", accept_status);
-
-	return (send_status | accept_status);
-}
-
-static int
-wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
+static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 {
 	unsigned long send_status = 0, accept_status = 0;
 	int maxlvt, num_starts, j;
 
+	preempt_disable();
 	maxlvt = lapic_get_maxlvt();
 
 	/*
@@ -957,6 +915,7 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 	if (accept_status)
 		pr_err("APIC delivery error (%lx)\n", accept_status);
 
+	preempt_enable();
 	return (send_status | accept_status);
 }
 
@@ -997,67 +956,6 @@ static void announce_cpu(int cpu, int apicid)
 			node, cpu, apicid);
 }
 
-static int wakeup_cpu0_nmi(unsigned int cmd, struct pt_regs *regs)
-{
-	int cpu;
-
-	cpu = smp_processor_id();
-	if (cpu == 0 && !cpu_online(cpu) && enable_start_cpu0)
-		return NMI_HANDLED;
-
-	return NMI_DONE;
-}
-
-/*
- * Wake up AP by INIT, INIT, STARTUP sequence.
- *
- * Instead of waiting for STARTUP after INITs, BSP will execute the BIOS
- * boot-strap code which is not a desired behavior for waking up BSP. To
- * void the boot-strap code, wake up CPU0 by NMI instead.
- *
- * This works to wake up soft offlined CPU0 only. If CPU0 is hard offlined
- * (i.e. physically hot removed and then hot added), NMI won't wake it up.
- * We'll change this code in the future to wake up hard offlined CPU0 if
- * real platform and request are available.
- */
-static int
-wakeup_cpu_via_init_nmi(int cpu, unsigned long start_ip, int apicid,
-	       int *cpu0_nmi_registered)
-{
-	int id;
-	int boot_error;
-
-	preempt_disable();
-
-	/*
-	 * Wake up AP by INIT, INIT, STARTUP sequence.
-	 */
-	if (cpu) {
-		boot_error = wakeup_secondary_cpu_via_init(apicid, start_ip);
-		goto out;
-	}
-
-	/*
-	 * Wake up BSP by nmi.
-	 *
-	 * Register a NMI handler to help wake up CPU0.
-	 */
-	boot_error = register_nmi_handler(NMI_LOCAL,
-					  wakeup_cpu0_nmi, 0, "wake_cpu0");
-
-	if (!boot_error) {
-		enable_start_cpu0 = 1;
-		*cpu0_nmi_registered = 1;
-		id = apic->dest_mode_logical ? cpu0_logical_apicid : apicid;
-		boot_error = wakeup_secondary_cpu_via_nmi(id, start_ip);
-	}
-
-out:
-	preempt_enable();
-
-	return boot_error;
-}
-
 int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 {
 	int ret;
@@ -1086,8 +984,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
  * Returns zero if CPU booted OK, else error code from
  * ->wakeup_secondary_cpu.
  */
-static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
-		       int *cpu0_nmi_registered)
+static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 {
 	/* start_ip had better be page-aligned! */
 	unsigned long start_ip = real_mode_header->trampoline_start;
@@ -1120,7 +1017,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	 * This grunge runs the startup process for
 	 * the targeted processor.
 	 */
-
 	if (x86_platform.legacy.warm_reset) {
 
 		pr_debug("Setting warm reset code and vector.\n");
@@ -1149,15 +1045,14 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	 * - Use a method from the APIC driver if one defined, with wakeup
 	 *   straight to 64-bit mode preferred over wakeup to RM.
 	 * Otherwise,
-	 * - Use an INIT boot APIC message for APs or NMI for BSP.
+	 * - Use an INIT boot APIC message
 	 */
 	if (apic->wakeup_secondary_cpu_64)
 		boot_error = apic->wakeup_secondary_cpu_64(apicid, start_ip);
 	else if (apic->wakeup_secondary_cpu)
 		boot_error = apic->wakeup_secondary_cpu(apicid, start_ip);
 	else
-		boot_error = wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
-						     cpu0_nmi_registered);
+		boot_error = wakeup_secondary_cpu_via_init(apicid, start_ip);
 
 	if (!boot_error) {
 		/*
@@ -1206,9 +1101,8 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int apicid = apic->cpu_present_to_apicid(cpu);
-	int cpu0_nmi_registered = 0;
 	unsigned long flags;
-	int err, ret = 0;
+	int err;
 
 	lockdep_assert_irqs_enabled();
 
@@ -1247,11 +1141,10 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 	if (err)
 		return err;
 
-	err = do_boot_cpu(apicid, cpu, tidle, &cpu0_nmi_registered);
+	err = do_boot_cpu(apicid, cpu, tidle);
 	if (err) {
 		pr_err("do_boot_cpu failed(%d) to wakeup CPU#%u\n", err, cpu);
-		ret = -EIO;
-		goto unreg_nmi;
+		return err;
 	}
 
 	/*
@@ -1267,15 +1160,7 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 		touch_nmi_watchdog();
 	}
 
-unreg_nmi:
-	/*
-	 * Clean up the nmi handler. Do this after the callin and callout sync
-	 * to avoid impact of possible long unregister time.
-	 */
-	if (cpu0_nmi_registered)
-		unregister_nmi_handler(NMI_LOCAL, "wake_cpu0");
-
-	return ret;
+	return 0;
 }
 
 /**
@@ -1373,14 +1258,6 @@ static void __init smp_cpu_index_default(void)
 	}
 }
 
-static void __init smp_get_logical_apicid(void)
-{
-	if (x2apic_mode)
-		cpu0_logical_apicid = apic_read(APIC_LDR);
-	else
-		cpu0_logical_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
-}
-
 void __init smp_prepare_cpus_common(void)
 {
 	unsigned int i;
@@ -1443,8 +1320,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	/* Setup local timer */
 	x86_init.timers.setup_percpu_clockev();
 
-	smp_get_logical_apicid();
-
 	pr_info("CPU0: ");
 	print_cpu_info(&cpu_data(0));
 
@@ -1752,18 +1627,6 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
-/**
- * cond_wakeup_cpu0 - Wake up CPU0 if needed.
- *
- * If NMI wants to wake up CPU0, start CPU0.
- */
-void cond_wakeup_cpu0(void)
-{
-	if (smp_processor_id() == 0 && enable_start_cpu0)
-		start_cpu0();
-}
-EXPORT_SYMBOL_GPL(cond_wakeup_cpu0);
-
 /*
  * We need to flush the caches before going to sleep, lest we have
  * dirty data in our caches when we come back up.
@@ -1831,8 +1694,6 @@ static inline void mwait_play_dead(void)
 		__monitor(mwait_ptr, 0, 0);
 		mb();
 		__mwait(eax, 0);
-
-		cond_wakeup_cpu0();
 	}
 }
 
@@ -1841,11 +1702,8 @@ void __noreturn hlt_play_dead(void)
 	if (__this_cpu_read(cpu_info.x86) >= 4)
 		wbinvd();
 
-	while (1) {
+	while (1)
 		native_halt();
-
-		cond_wakeup_cpu0();
-	}
 }
 
 void native_play_dead(void)
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9718d07..dc615ef 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -597,10 +597,6 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 			io_idle(cx->address);
 		} else
 			return -ENODEV;
-
-#if defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
-		cond_wakeup_cpu0();
-#endif
 	}
 
 	/* Never reached */
