Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9023272E2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbjFMMSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242302AbjFMMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:18:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9208910CE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:18:03 -0700 (PDT)
Message-ID: <20230613121615.930971031@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686658682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2tbe1yf/elw3q9ddi46TIJjkrkI2lPyw8V2Oqd13dsI=;
        b=Z+j5IOigCOSxABtOlN+yWSRchWd5GWYQ9Z9wwU7tk8wF8owqZ/CoWtYWWbNpfGPDVsq9pe
        VdMnziL6VtzIVlboyXqn0WnVYllsvFaUg4wb/8trEiEvamMN/N7bY1YPYRGHegyLFjxsUP
        qWKA70ogPLwbp2ycCXF328xnqAeMv+n6UfFiO/oY4WXfQ/cywVvX0rrFS3rizKUi6AnVm9
        vNuHXIKAPhj88C+JXeZfuLKICKoaA4nFNDVVhZQ0ETebCSLXL2SkoHqXOsCnYX4OLSiytY
        lWpwwnmbxIqbUwBbeg0qA2WHWI9nPf/3oQMXCDFNH0+awhpvP3lOINycqRDa6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686658682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2tbe1yf/elw3q9ddi46TIJjkrkI2lPyw8V2Oqd13dsI=;
        b=YcKBKvNaFHmXxiJgFMKXlF+yzcTSYQ460MahzXCsEGWq7z/B/Gbs5AZ730QiVR65TMdbCX
        cSKMIcLLr3aYaCDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [patch V2 6/8] x86/smp: Cure kexec() vs. mwait_play_dead() breakage
References: <20230613115353.599087484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 13 Jun 2023 14:18:02 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TLDR: It's a mess.

When kexec() is executed on a system with "offline" CPUs, which are parked
in mwait_play_dead() it can end up in a triple fault during the bootup of
the kexec kernel or cause hard to diagnose data corruption.

The reason is that kexec() eventually overwrites the previous kernels text,
page tables, data and stack, If it writes to the cache line which is
monitored by an previously offlined CPU, MWAIT resumes execution and ends
up executing the wrong text, dereferencing overwritten page tables or
corrupting the kexec kernels data.

Cure this by bringing the offline CPUs out of MWAIT into HLT.

Write to the monitored cache line of each offline CPU, which makes MWAIT
resume execution. The written control word tells the offline CPUs to issue
HLT, which does not have the MWAIT problem.

That does not help, if a stray NMI, MCE or SMI hits the offline CPUs as
those make it come out of HLT.

A follow up change will put them into INIT, which protects at least against
NMI and SMI.

Fixes: ea53069231f9 ("x86, hotplug: Use mwait to offline a processor, fix the legacy case")
Reported-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/smp.h |    2 +
 arch/x86/kernel/smp.c      |   23 ++++++++---------
 arch/x86/kernel/smpboot.c  |   59 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -132,6 +132,8 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 void cond_wakeup_cpu0(void);
 
+void smp_kick_mwait_play_dead(void);
+
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/gfp.h>
+#include <linux/kexec.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
@@ -157,21 +158,19 @@ static void native_stop_other_cpus(int w
 	if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
 		return;
 
-	atomic_set(&stop_cpus_count, num_online_cpus() - 1);
+	/* For kexec, ensure that offline CPUs are out of MWAIT and in HLT */
+	if (kexec_in_progress)
+		smp_kick_mwait_play_dead();
 
-	/*
-	 * Use an own vector here because smp_call_function
-	 * does lots of things not suitable in a panic situation.
-	 */
+	atomic_set(&stop_cpus_count, num_online_cpus() - 1);
 
 	/*
-	 * We start by using the REBOOT_VECTOR irq.
-	 * The irq is treated as a sync point to allow critical
-	 * regions of code on other cpus to release their spin locks
-	 * and re-enable irqs.  Jumping straight to an NMI might
-	 * accidentally cause deadlocks with further shutdown/panic
-	 * code.  By syncing, we give the cpus up to one second to
-	 * finish their work before we force them off with the NMI.
+	 * Start by using the REBOOT_VECTOR. That acts as a sync point to
+	 * allow critical regions of code on other cpus to leave their
+	 * critical regions. Jumping straight to an NMI might accidentally
+	 * cause deadlocks with further shutdown code. This gives the CPUs
+	 * up to one second to finish their work before forcing them off
+	 * with the NMI.
 	 */
 	if (atomic_read(&stop_cpus_count) > 0) {
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -53,6 +53,7 @@
 #include <linux/tboot.h>
 #include <linux/gfp.h>
 #include <linux/cpuidle.h>
+#include <linux/kexec.h>
 #include <linux/numa.h>
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
@@ -106,6 +107,9 @@ struct mwait_cpu_dead {
 	unsigned int	status;
 };
 
+#define CPUDEAD_MWAIT_WAIT	0xDEADBEEF
+#define CPUDEAD_MWAIT_KEXEC_HLT	0x4A17DEAD
+
 /*
  * Cache line aligned data for mwait_play_dead(). Separate on purpose so
  * that it's unlikely to be touched by other CPUs.
@@ -173,6 +177,10 @@ static void smp_callin(void)
 {
 	int cpuid;
 
+	/* Mop up eventual mwait_play_dead() wreckage */
+	this_cpu_write(mwait_cpu_dead.status, 0);
+	this_cpu_write(mwait_cpu_dead.control, 0);
+
 	/*
 	 * If waken up by an INIT in an 82489DX configuration
 	 * cpu_callout_mask guarantees we don't get here before
@@ -1807,6 +1815,10 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
+	/* Set up state for the kexec() hack below */
+	md->status = CPUDEAD_MWAIT_WAIT;
+	md->control = CPUDEAD_MWAIT_WAIT;
+
 	wbinvd();
 
 	while (1) {
@@ -1824,10 +1836,57 @@ static inline void mwait_play_dead(void)
 		mb();
 		__mwait(eax, 0);
 
+		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
+			/*
+			 * Kexec is about to happen. Don't go back into mwait() as
+			 * the kexec kernel might overwrite text and data including
+			 * page tables and stack. So mwait() would resume when the
+			 * monitor cache line is written to and then the CPU goes
+			 * south due to overwritten text, page tables and stack.
+			 *
+			 * Note: This does _NOT_ protect against a stray MCE, NMI,
+			 * SMI. They will resume execution at the instruction
+			 * following the HLT instruction and run into the problem
+			 * which this is trying to prevent.
+			 */
+			WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
+			while(1)
+				native_halt();
+		}
+
 		cond_wakeup_cpu0();
 	}
 }
 
+/*
+ * Kick all "offline" CPUs out of mwait on kexec(). See comment in
+ * mwait_play_dead().
+ */
+void smp_kick_mwait_play_dead(void)
+{
+	u32 newstate = CPUDEAD_MWAIT_KEXEC_HLT;
+	struct mwait_cpu_dead *md;
+	unsigned int cpu, i;
+
+	for_each_cpu_andnot(cpu, cpu_present_mask, cpu_online_mask) {
+		md = per_cpu_ptr(&mwait_cpu_dead, cpu);
+
+		/* Does it sit in mwait_play_dead() ? */
+		if (READ_ONCE(md->status) != CPUDEAD_MWAIT_WAIT)
+			continue;
+
+		/* Wait maximal 5ms */
+		for (i = 0; READ_ONCE(md->status) != newstate && i < 1000; i++) {
+			/* Bring it out of mwait */
+			WRITE_ONCE(md->control, newstate);
+			udelay(5);
+		}
+
+		if (READ_ONCE(md->status) != newstate)
+			pr_err("CPU%u is stuck in mwait_play_dead()\n", cpu);
+	}
+}
+
 void __noreturn hlt_play_dead(void)
 {
 	if (__this_cpu_read(cpu_info.x86) >= 4)

