Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FB673DE9F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjFZMOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjFZMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:13:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C361B7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:13:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687781634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=W0C/gQWPaKfuz1+hBaCVHIC+o4umn9jvWAHQU4uljzs=;
        b=Skr8Y4Sp0iZmZrFig5938MiwaLRAyarKv32CPHZoJeUdMDlvOKdU+58vl1kEGdvCBnaP56
        5tlvpu9yIEvmkKOOFhPMDPwavpbtmc1OcCx3o/UCkQCeAJaqdpyFY7hezEUqBsejA508n/
        bX0Fi+DJR/q+aNYLVgesVnvQDF6xflO/d+U/lrC675BCyuTED998JEVSnWNMXxJX3iYxMK
        9AjA4mcRdE5kAxlHtV5MuPBLxRnp9b4Zn4r47rM44ZCF9Shq40au9uKxB5DsErCNTJJip5
        x5zQPb36K7ASCkmbo8aIX31E9d/zfXb/Z8gGYXcdJuYUFh3daaLXdSYqaRc2vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687781634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=W0C/gQWPaKfuz1+hBaCVHIC+o4umn9jvWAHQU4uljzs=;
        b=KGujkv56i6FcoAfpDTZYJzWnTn1jC7CEmupWS9bUKtKWt0kfVm7U/5m5TdW15sAFiOiTHa
        F4HoSDAk7rgaqeAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/core for v6.5-rc1
References: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz>
Message-ID: <168778151644.3634408.18311962903658740097.tglx@vps.praguecc.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 26 Jun 2023 14:13:54 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-06=
-26

up to:  45e34c8af58f: x86/smp: Put CPUs into INIT on shutdown if possible


A set of fixes for kexec(), reboot and shutdown issues

 - Ensure that the WBINVD in stop_this_cpu() has been completed before the
   control CPU proceedes.

   stop_this_cpu() is used for kexec(), reboot and shutdown to park the APs
   in a HLT loop.

   The control CPU sends an IPI to the APs and waits for their CPU online bits
   to be cleared. Once they all are marked "offline" it proceeds.

   But stop_this_cpu() clears the CPU online bit before issuing WBINVD,
   which means there is no guarantee that the AP has reached the HLT loop.

   This was reported to cause intermittent reboot/shutdown failures due to
   some dubious interaction with the firmware.

   This is not only a problem of WBINVD. The code to actually "stop" the
   CPU which runs between clearing the online bit and reaching the HLT loop
   can cause large enough delays on its own (think virtualization). That's
   especially dangerous for kexec() as kexec() expects that all APs are in
   a safe state and not executing code while the boot CPU jumps to the new
   kernel. There are more issues vs. kexec() which are addressed separately.

   Cure this by implementing an explicit synchronization point right before
   the AP reaches HLT. This guarantees that the AP has completed the full
   stop proceedure.

 - Fix the condition for WBINVD in stop_this_cpu().

   The WBINVD in stop_this_cpu() is required for ensuring that when
   switching to or from memory encryption no dirty data is left in the
   cache lines which might cause a write back in the wrong more later.

   This checks CPUID directly because the feature bit might have been
   cleared due to a command line option.

   But that CPUID check accesses leaf 0x8000001f::EAX unconditionally. Intel
   CPUs return the content of the highest supported leaf when a non-existing
   leaf is read, while AMD CPUs return all zeros for unsupported leafs.
   =20
   So the result of the test on Intel CPUs is lottery and on AMD its just
   correct by chance.

   While harmless it's incorrect and causes the conditional wbinvd() to be
   issued where not required, which caused the above issue to be unearthed.

 - Make kexec() robust against AP code execution

   Ashok observed triple faults when doing kexec() on a system which had
   been booted with "nosmt".

   It turned out that the SMT siblings which had been brought up partially
   are parked in mwait_play_dead() to enable power savings.

   mwait_play_dead() is monitoring the thread flags of the AP's idle task,
   which has been chosen as it's unlikely to be written to.

   But kexec() can overwrite the previous kernel text and data including
   page tables etc. When it overwrites the cache lines monitored by an AP
   that AP resumes execution after the MWAIT on eventually overwritten
   text, stack and page tables, which obviously might end up in a triple
   fault easily.

   Make this more robust in several steps:

    1) Use an explicit per CPU cache line for monitoring.

    2) Write a command to these cache lines to kick APs out of MWAIT before
       proceeding with kexec(), shutdown or reboot.

       The APs confirm the wakeup by writing status back and then enter a
       HLT loop.

    3) If the system uses INIT/INIT/STARTUP for AP bringup, park the APs
       in INIT state.

       HLT is not a guarantee that an AP won't wake up and resume
       execution. HLT is woken up by NMI and SMI. SMI puts the CPU back
       into HLT (+/- firmware bugs), but NMI is delivered to the CPU which
       executes the NMI handler. Same issue as the MWAIT scenario described
       above.

       Sending an INIT/INIT sequence to the APs puts them into wait for
       STARTUP state, which is safe against NMI.

    There is still an issue remaining which can't be fixed: #MCE

    If the AP sits in HLT and receives a broadcast #MCE it will try to
    handle it with the obvious consequences.

    INIT/INIT clears CR4.MCE in the AP which will cause a broadcast #MCE to
    shut down the machine.

    So there is a choice between fire (HLT) and frying pan (INIT). Frying
    pan has been chosen as it's at least preventing the NMI issue.

    On systems which are not using INIT/INIT/STARTUP there is not much
    which can be done right now, but at least the obvious and easy to
    trigger MWAIT issue has been addressed.

Note:

This conflicts with smp/core and x86/boot. The recommended ordering of
merging these three branches is smp/core, x86/boot, x86/core.

The x86/boot and final x86/core merge have both subtle conflicts. I've
pushed out the following tags:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git merge_smp_core_x=
86_boot_for_6_5
   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git merge_smp_core_x=
86_boot_x86_core_for_6_5

for your conveniance to check against.

Thanks,

	tglx

------------------>
Thomas Gleixner (6):
      x86/smp: Make stop_other_cpus() more robust
      x86/smp: Remove pointless wmb()s from native_stop_other_cpus()
      x86/smp: Use dedicated cache-line for mwait_play_dead()
      x86/smp: Cure kexec() vs. mwait_play_dead() breakage
      x86/smp: Split sending INIT IPI out into a helper function
      x86/smp: Put CPUs into INIT on shutdown if possible

Tony Battersby (1):
      x86/smp: Dont access non-existing CPUID leaf


 arch/x86/include/asm/cpu.h |   2 +
 arch/x86/include/asm/smp.h |   4 ++
 arch/x86/kernel/process.c  |  28 +++++++--
 arch/x86/kernel/smp.c      | 104 ++++++++++++++++++++++---------
 arch/x86/kernel/smpboot.c  | 149 +++++++++++++++++++++++++++++++++----------=
--
 5 files changed, 215 insertions(+), 72 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 78796b98a544..9ba3c3dec6f3 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -98,4 +98,6 @@ extern u64 x86_read_arch_cap_msr(void);
 int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
 int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
=20
+extern struct cpumask cpus_stop_mask;
+
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4e91054c84be..5906aa914220 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -132,11 +132,15 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 void cond_wakeup_cpu0(void);
=20
+void smp_kick_mwait_play_dead(void);
+
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
 void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
=20
+bool smp_park_other_cpus_in_init(void);
+
 void smp_store_boot_cpu_info(void);
 void smp_store_cpu_info(int id);
=20
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index dac41a0072ea..ff9b80a0e3e3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -759,15 +759,26 @@ bool xen_set_default_idle(void)
 }
 #endif
=20
+struct cpumask cpus_stop_mask;
+
 void __noreturn stop_this_cpu(void *dummy)
 {
+	struct cpuinfo_x86 *c =3D this_cpu_ptr(&cpu_info);
+	unsigned int cpu =3D smp_processor_id();
+
 	local_irq_disable();
+
 	/*
-	 * Remove this CPU:
+	 * Remove this CPU from the online mask and disable it
+	 * unconditionally. This might be redundant in case that the reboot
+	 * vector was handled late and stop_other_cpus() sent an NMI.
+	 *
+	 * According to SDM and APM NMIs can be accepted even after soft
+	 * disabling the local APIC.
 	 */
-	set_cpu_online(smp_processor_id(), false);
+	set_cpu_online(cpu, false);
 	disable_local_APIC();
-	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
+	mcheck_cpu_clear(c);
=20
 	/*
 	 * Use wbinvd on processors that support SME. This provides support
@@ -781,8 +792,17 @@ void __noreturn stop_this_cpu(void *dummy)
 	 * Test the CPUID bit directly because the machine might've cleared
 	 * X86_FEATURE_SME due to cmdline options.
 	 */
-	if (cpuid_eax(0x8000001f) & BIT(0))
+	if (c->extended_cpuid_level >=3D 0x8000001f && (cpuid_eax(0x8000001f) & BIT=
(0)))
 		native_wbinvd();
+
+	/*
+	 * This brings a cache line back and dirties it, but
+	 * native_stop_other_cpus() will overwrite cpus_stop_mask after it
+	 * observed that all CPUs reported stop. This write will invalidate
+	 * the related cache line on this CPU.
+	 */
+	cpumask_clear_cpu(cpu, &cpus_stop_mask);
+
 	for (;;) {
 		/*
 		 * Use native_halt() so that memory contents don't change
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 375b33ecafa2..0076932cfd40 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -21,12 +21,14 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/gfp.h>
+#include <linux/kexec.h>
=20
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 #include <asm/proto.h>
 #include <asm/apic.h>
+#include <asm/cpu.h>
 #include <asm/idtentry.h>
 #include <asm/nmi.h>
 #include <asm/mce.h>
@@ -129,7 +131,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct=
 pt_regs *regs)
 }
=20
 /*
- * this function calls the 'stop' function on all other CPUs in the system.
+ * Disable virtualization, APIC etc. and park the CPU in a HLT loop
  */
 DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
@@ -146,61 +148,96 @@ static int register_stop_handler(void)
=20
 static void native_stop_other_cpus(int wait)
 {
-	unsigned long flags;
-	unsigned long timeout;
+	unsigned int cpu =3D smp_processor_id();
+	unsigned long flags, timeout;
=20
 	if (reboot_force)
 		return;
=20
-	/*
-	 * Use an own vector here because smp_call_function
-	 * does lots of things not suitable in a panic situation.
-	 */
+	/* Only proceed if this is the first CPU to reach this code */
+	if (atomic_cmpxchg(&stopping_cpu, -1, cpu) !=3D -1)
+		return;
+
+	/* For kexec, ensure that offline CPUs are out of MWAIT and in HLT */
+	if (kexec_in_progress)
+		smp_kick_mwait_play_dead();
=20
 	/*
-	 * We start by using the REBOOT_VECTOR irq.
-	 * The irq is treated as a sync point to allow critical
-	 * regions of code on other cpus to release their spin locks
-	 * and re-enable irqs.  Jumping straight to an NMI might
-	 * accidentally cause deadlocks with further shutdown/panic
-	 * code.  By syncing, we give the cpus up to one second to
-	 * finish their work before we force them off with the NMI.
+	 * 1) Send an IPI on the reboot vector to all other CPUs.
+	 *
+	 *    The other CPUs should react on it after leaving critical
+	 *    sections and re-enabling interrupts. They might still hold
+	 *    locks, but there is nothing which can be done about that.
+	 *
+	 * 2) Wait for all other CPUs to report that they reached the
+	 *    HLT loop in stop_this_cpu()
+	 *
+	 * 3) If the system uses INIT/STARTUP for CPU bringup, then
+	 *    send all present CPUs an INIT vector, which brings them
+	 *    completely out of the way.
+	 *
+	 * 4) If #3 is not possible and #2 timed out send an NMI to the
+	 *    CPUs which did not yet report
+	 *
+	 * 5) Wait for all other CPUs to report that they reached the
+	 *    HLT loop in stop_this_cpu()
+	 *
+	 * #4 can obviously race against a CPU reaching the HLT loop late.
+	 * That CPU will have reported already and the "have all CPUs
+	 * reached HLT" condition will be true despite the fact that the
+	 * other CPU is still handling the NMI. Again, there is no
+	 * protection against that as "disabled" APICs still respond to
+	 * NMIs.
 	 */
-	if (num_online_cpus() > 1) {
-		/* did someone beat us here? */
-		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) !=3D -1)
-			return;
-
-		/* sync above data before sending IRQ */
-		wmb();
+	cpumask_copy(&cpus_stop_mask, cpu_online_mask);
+	cpumask_clear_cpu(cpu, &cpus_stop_mask);
=20
+	if (!cpumask_empty(&cpus_stop_mask)) {
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
=20
 		/*
 		 * Don't wait longer than a second for IPI completion. The
 		 * wait request is not checked here because that would
-		 * prevent an NMI shutdown attempt in case that not all
+		 * prevent an NMI/INIT shutdown in case that not all
 		 * CPUs reach shutdown state.
 		 */
 		timeout =3D USEC_PER_SEC;
-		while (num_online_cpus() > 1 && timeout--)
+		while (!cpumask_empty(&cpus_stop_mask) && timeout--)
 			udelay(1);
 	}
=20
-	/* if the REBOOT_VECTOR didn't work, try with the NMI */
-	if (num_online_cpus() > 1) {
+	/*
+	 * Park all other CPUs in INIT including "offline" CPUs, if
+	 * possible. That's a safe place where they can't resume execution
+	 * of HLT and then execute the HLT loop from overwritten text or
+	 * page tables.
+	 *
+	 * The only downside is a broadcast MCE, but up to the point where
+	 * the kexec() kernel brought all APs online again an MCE will just
+	 * make HLT resume and handle the MCE. The machine crashes and burns
+	 * due to overwritten text, page tables and data. So there is a
+	 * choice between fire and frying pan. The result is pretty much
+	 * the same. Chose frying pan until x86 provides a sane mechanism
+	 * to park a CPU.
+	 */
+	if (smp_park_other_cpus_in_init())
+		goto done;
+
+	/*
+	 * If park with INIT was not possible and the REBOOT_VECTOR didn't
+	 * take all secondary CPUs offline, try with the NMI.
+	 */
+	if (!cpumask_empty(&cpus_stop_mask)) {
 		/*
 		 * If NMI IPI is enabled, try to register the stop handler
 		 * and send the IPI. In any case try to wait for the other
 		 * CPUs to stop.
 		 */
 		if (!smp_no_nmi_ipi && !register_stop_handler()) {
-			/* Sync above data before sending IRQ */
-			wmb();
-
 			pr_emerg("Shutting down cpus with NMI\n");
=20
-			apic_send_IPI_allbutself(NMI_VECTOR);
+			for_each_cpu(cpu, &cpus_stop_mask)
+				apic->send_IPI(cpu, NMI_VECTOR);
 		}
 		/*
 		 * Don't wait longer than 10 ms if the caller didn't
@@ -208,14 +245,21 @@ static void native_stop_other_cpus(int wait)
 		 * one or more CPUs do not reach shutdown state.
 		 */
 		timeout =3D USEC_PER_MSEC * 10;
-		while (num_online_cpus() > 1 && (wait || timeout--))
+		while (!cpumask_empty(&cpus_stop_mask) && (wait || timeout--))
 			udelay(1);
 	}
=20
+done:
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
 	local_irq_restore(flags);
+
+	/*
+	 * Ensure that the cpus_stop_mask cache lines are invalidated on
+	 * the other CPUs. See comment vs. SME in stop_this_cpu().
+	 */
+	cpumask_clear(&cpus_stop_mask);
 }
=20
 /*
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce1ece4..4ee43396b910 100644
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
@@ -101,6 +102,20 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
=20
+struct mwait_cpu_dead {
+	unsigned int	control;
+	unsigned int	status;
+};
+
+#define CPUDEAD_MWAIT_WAIT	0xDEADBEEF
+#define CPUDEAD_MWAIT_KEXEC_HLT	0x4A17DEAD
+
+/*
+ * Cache line aligned data for mwait_play_dead(). Separate on purpose so
+ * that it's unlikely to be touched by other CPUs.
+ */
+static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
+
 /* Logical package management. We might want to allocate that dynamically */
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
@@ -162,6 +177,10 @@ static void smp_callin(void)
 {
 	int cpuid;
=20
+	/* Mop up eventual mwait_play_dead() wreckage */
+	this_cpu_write(mwait_cpu_dead.status, 0);
+	this_cpu_write(mwait_cpu_dead.control, 0);
+
 	/*
 	 * If waken up by an INIT in an 82489DX configuration
 	 * cpu_callout_mask guarantees we don't get here before
@@ -834,47 +853,38 @@ wakeup_secondary_cpu_via_nmi(int apicid, unsigned long =
start_eip)
 	return (send_status | accept_status);
 }
=20
-static int
-wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
+static void send_init_sequence(int phys_apicid)
 {
-	unsigned long send_status =3D 0, accept_status =3D 0;
-	int maxlvt, num_starts, j;
+	int maxlvt =3D lapic_get_maxlvt();
=20
-	maxlvt =3D lapic_get_maxlvt();
-
-	/*
-	 * Be paranoid about clearing APIC errors.
-	 */
+	/* Be paranoid about clearing APIC errors. */
 	if (APIC_INTEGRATED(boot_cpu_apic_version)) {
-		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP.  */
+		/* Due to the Pentium erratum 3AP.  */
+		if (maxlvt > 3)
 			apic_write(APIC_ESR, 0);
 		apic_read(APIC_ESR);
 	}
=20
-	pr_debug("Asserting INIT\n");
-
-	/*
-	 * Turn INIT on target chip
-	 */
-	/*
-	 * Send IPI
-	 */
-	apic_icr_write(APIC_INT_LEVELTRIG | APIC_INT_ASSERT | APIC_DM_INIT,
-		       phys_apicid);
-
-	pr_debug("Waiting for send to finish...\n");
-	send_status =3D safe_apic_wait_icr_idle();
+	/* Assert INIT on the target CPU */
+	apic_icr_write(APIC_INT_LEVELTRIG | APIC_INT_ASSERT | APIC_DM_INIT, phys_ap=
icid);
+	safe_apic_wait_icr_idle();
=20
 	udelay(init_udelay);
=20
-	pr_debug("Deasserting INIT\n");
-
-	/* Target chip */
-	/* Send IPI */
+	/* Deassert INIT on the target CPU */
 	apic_icr_write(APIC_INT_LEVELTRIG | APIC_DM_INIT, phys_apicid);
+	safe_apic_wait_icr_idle();
+}
=20
-	pr_debug("Waiting for send to finish...\n");
-	send_status =3D safe_apic_wait_icr_idle();
+/*
+ * Wake up AP by INIT, INIT, STARTUP sequence.
+ */
+static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long star=
t_eip)
+{
+	unsigned long send_status =3D 0, accept_status =3D 0;
+	int num_starts, j, maxlvt =3D lapic_get_maxlvt();
+
+	send_init_sequence(phys_apicid);
=20
 	mb();
=20
@@ -1455,6 +1465,25 @@ void arch_thaw_secondary_cpus_end(void)
 	cache_aps_init();
 }
=20
+bool smp_park_other_cpus_in_init(void)
+{
+	unsigned int cpu, this_cpu =3D smp_processor_id();
+	unsigned int apicid;
+
+	if (apic->wakeup_secondary_cpu_64 || apic->wakeup_secondary_cpu)
+		return false;
+
+	for_each_present_cpu(cpu) {
+		if (cpu =3D=3D this_cpu)
+			continue;
+		apicid =3D apic->cpu_present_to_apicid(cpu);
+		if (apicid =3D=3D BAD_APICID)
+			continue;
+		send_init_sequence(apicid);
+	}
+	return true;
+}
+
 /*
  * Early setup to make printk work.
  */
@@ -1758,10 +1787,10 @@ EXPORT_SYMBOL_GPL(cond_wakeup_cpu0);
  */
 static inline void mwait_play_dead(void)
 {
+	struct mwait_cpu_dead *md =3D this_cpu_ptr(&mwait_cpu_dead);
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int highest_cstate =3D 0;
 	unsigned int highest_subcstate =3D 0;
-	void *mwait_ptr;
 	int i;
=20
 	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||
@@ -1796,12 +1825,9 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
=20
-	/*
-	 * This should be a memory location in a cache line which is
-	 * unlikely to be touched by other processors.  The actual
-	 * content is immaterial as it is not actually modified in any way.
-	 */
-	mwait_ptr =3D &current_thread_info()->flags;
+	/* Set up state for the kexec() hack below */
+	md->status =3D CPUDEAD_MWAIT_WAIT;
+	md->control =3D CPUDEAD_MWAIT_WAIT;
=20
 	wbinvd();
=20
@@ -1814,16 +1840,63 @@ static inline void mwait_play_dead(void)
 		 * case where we return around the loop.
 		 */
 		mb();
-		clflush(mwait_ptr);
+		clflush(md);
 		mb();
-		__monitor(mwait_ptr, 0, 0);
+		__monitor(md, 0, 0);
 		mb();
 		__mwait(eax, 0);
=20
+		if (READ_ONCE(md->control) =3D=3D CPUDEAD_MWAIT_KEXEC_HLT) {
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
=20
+/*
+ * Kick all "offline" CPUs out of mwait on kexec(). See comment in
+ * mwait_play_dead().
+ */
+void smp_kick_mwait_play_dead(void)
+{
+	u32 newstate =3D CPUDEAD_MWAIT_KEXEC_HLT;
+	struct mwait_cpu_dead *md;
+	unsigned int cpu, i;
+
+	for_each_cpu_andnot(cpu, cpu_present_mask, cpu_online_mask) {
+		md =3D per_cpu_ptr(&mwait_cpu_dead, cpu);
+
+		/* Does it sit in mwait_play_dead() ? */
+		if (READ_ONCE(md->status) !=3D CPUDEAD_MWAIT_WAIT)
+			continue;
+
+		/* Wait up to 5ms */
+		for (i =3D 0; READ_ONCE(md->status) !=3D newstate && i < 1000; i++) {
+			/* Bring it out of mwait */
+			WRITE_ONCE(md->control, newstate);
+			udelay(5);
+		}
+
+		if (READ_ONCE(md->status) !=3D newstate)
+			pr_err_once("CPU%u is stuck in mwait_play_dead()\n", cpu);
+	}
+}
+
 void __noreturn hlt_play_dead(void)
 {
 	if (__this_cpu_read(cpu_info.x86) >=3D 4)

