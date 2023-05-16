Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22D57048B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjEPJLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjEPJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51E4C2E;
        Tue, 16 May 2023 02:10:03 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0aWj1iAm/IHl0qILKCcng0I7ME1ZF/B+YFdpxRe5lSI=;
        b=GoY3jqctMPAoztsvdGFc22RvKN+soxZr+KyB2CHGulEfPevOHb32St5oaom4xuZ7nfvYDs
        e5dJrHU1H7wNHAs+9nKXIuJsipoqM8MZgKlCodEU86L83ALafX6+IQJi56JYka7aqZIt3K
        TR9mmYL+/tnw6AcpLolHXlOIUUgw4qMFpz8kuxY9A+RcMnxDWibeYQeev3IWLzaTaLcHI8
        XVcytvLZqeFbGsL6hacSXsWrYNWDk9/lgZ8n0a0CJKNzXavVN7M651s9ile4m9zXfl9x9Z
        sErBqav3nNM+B46d66ilK0n5/VRBybmWyppVxVnVHF+ppxpRYVFG52Gi9e4/Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0aWj1iAm/IHl0qILKCcng0I7ME1ZF/B+YFdpxRe5lSI=;
        b=+L86v3RtB9+1ZhSFS4IfRlr5STqt46gUqaTirLhM0EuDSWQDSzF0qfqTbhYJbMtgGM8NCD
        q0KdM7MGThJmNNCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Switch to hotplug core state synchronization
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205256.529657366@linutronix.de>
References: <20230512205256.529657366@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819828.404.8387722204743973895.tip-bot2@tip-bot2>
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

Commit-ID:     2711b8e2b71fa3cce9c28b0f07b75882f141adfe
Gitweb:        https://git.kernel.org/tip/2711b8e2b71fa3cce9c28b0f07b75882f141adfe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:56 +02:00

x86/smpboot: Switch to hotplug core state synchronization

The new AP state tracking and synchronization mechanism in the CPU hotplug
core code allows to remove quite some x86 specific code:

  1) The AP alive synchronization based on cpumasks

  2) The decision whether an AP can be brought up again

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205256.529657366@linutronix.de
---
 arch/x86/Kconfig           |   1 +-
 arch/x86/include/asm/smp.h |   7 +-
 arch/x86/kernel/smp.c      |   1 +-
 arch/x86/kernel/smpboot.c  | 165 ++++++++----------------------------
 arch/x86/xen/smp_hvm.c     |  16 +--
 arch/x86/xen/smp_pv.c      |  39 +++++----
 6 files changed, 75 insertions(+), 154 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d019133..adb1ec8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -274,6 +274,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
+	select HOTPLUG_CORE_SYNC_FULL		if SMP
 	select HOTPLUG_SMT			if SMP
 	select IRQ_FORCED_THREADING
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 0ec4c64..693c999 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -38,6 +38,8 @@ struct smp_ops {
 	void (*crash_stop_other_cpus)(void);
 	void (*smp_send_reschedule)(int cpu);
 
+	void (*cleanup_dead_cpu)(unsigned cpu);
+	void (*poll_sync_state)(void);
 	int (*cpu_up)(unsigned cpu, struct task_struct *tidle);
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
@@ -90,7 +92,8 @@ static inline int __cpu_disable(void)
 
 static inline void __cpu_die(unsigned int cpu)
 {
-	smp_ops.cpu_die(cpu);
+	if (smp_ops.cpu_die)
+		smp_ops.cpu_die(cpu);
 }
 
 static inline void __noreturn play_dead(void)
@@ -123,8 +126,6 @@ void native_smp_cpus_done(unsigned int max_cpus);
 int common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_cpu_disable(void);
-int common_cpu_die(unsigned int cpu);
-void native_cpu_die(unsigned int cpu);
 void __noreturn hlt_play_dead(void);
 void native_play_dead(void);
 void play_dead_common(void);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 375b33e..4f6375b 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -269,7 +269,6 @@ struct smp_ops smp_ops = {
 	.smp_send_reschedule	= native_smp_send_reschedule,
 
 	.cpu_up			= native_cpu_up,
-	.cpu_die		= native_cpu_die,
 	.cpu_disable		= native_cpu_disable,
 	.play_dead		= native_play_dead,
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4349e8a..5938641 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,7 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/stackprotector.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -101,9 +102,6 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
-/* All of these masks are initialized in setup_cpu_local_masks() */
-static cpumask_var_t cpu_initialized_mask;
-static cpumask_var_t cpu_callout_mask;
 /* Representing CPUs for which sibling maps can be computed */
 static cpumask_var_t cpu_sibling_setup_mask;
 
@@ -166,10 +164,10 @@ static void ap_starting(void)
 	int cpuid = smp_processor_id();
 
 	/*
-	 * If woken up by an INIT in an 82489DX configuration
-	 * cpu_callout_mask guarantees the CPU does not reach this point
-	 * before an INIT_deassert IPI reaches the local APIC, so it is now
-	 * safe to touch the local APIC.
+	 * If woken up by an INIT in an 82489DX configuration the alive
+	 * synchronization guarantees that the CPU does not reach this
+	 * point before an INIT_deassert IPI reaches the local APIC, so it
+	 * is now safe to touch the local APIC.
 	 *
 	 * Set up this CPU, first the APIC, which is probably redundant on
 	 * most boards.
@@ -213,17 +211,6 @@ static void ap_calibrate_delay(void)
 	cpu_data(smp_processor_id()).loops_per_jiffy = loops_per_jiffy;
 }
 
-static void wait_for_master_cpu(int cpu)
-{
-	/*
-	 * Wait for release by control CPU before continuing with AP
-	 * initialization.
-	 */
-	WARN_ON(cpumask_test_and_set_cpu(cpu, cpu_initialized_mask));
-	while (!cpumask_test_cpu(cpu, cpu_callout_mask))
-		cpu_relax();
-}
-
 /*
  * Activate a secondary processor.
  */
@@ -244,11 +231,11 @@ static void notrace start_secondary(void *unused)
 	cpu_init_exception_handling();
 
 	/*
-	 * Sync point with wait_cpu_initialized(). Sets AP in
-	 * cpu_initialized_mask and then waits for the control CPU
-	 * to release it.
+	 * Synchronization point with the hotplug core. Sets the
+	 * synchronization state to ALIVE and waits for the control CPU to
+	 * release this CPU for further bringup.
 	 */
-	wait_for_master_cpu(raw_smp_processor_id());
+	cpuhp_ap_sync_alive();
 
 	cpu_init();
 	rcu_cpu_starting(raw_smp_processor_id());
@@ -278,7 +265,6 @@ static void notrace start_secondary(void *unused)
 	set_cpu_online(smp_processor_id(), true);
 	lapic_online();
 	unlock_vector_lock();
-	cpu_set_state_online(smp_processor_id());
 	x86_platform.nmi_init();
 
 	/* enable local interrupts */
@@ -729,9 +715,9 @@ static void impress_friends(void)
 	 * Allow the user to impress friends.
 	 */
 	pr_debug("Before bogomips\n");
-	for_each_possible_cpu(cpu)
-		if (cpumask_test_cpu(cpu, cpu_callout_mask))
-			bogosum += cpu_data(cpu).loops_per_jiffy;
+	for_each_online_cpu(cpu)
+		bogosum += cpu_data(cpu).loops_per_jiffy;
+
 	pr_info("Total of %d processors activated (%lu.%02lu BogoMIPS)\n",
 		num_online_cpus(),
 		bogosum/(500000/HZ),
@@ -1003,6 +989,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip = real_mode_header->trampoline_start;
+	int ret;
 
 #ifdef CONFIG_X86_64
 	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
@@ -1043,13 +1030,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 		}
 	}
 
-	/*
-	 * AP might wait on cpu_callout_mask in cpu_init() with
-	 * cpu_initialized_mask set if previous attempt to online
-	 * it timed-out. Clear cpu_initialized_mask so that after
-	 * INIT/SIPI it could start with a clean state.
-	 */
-	cpumask_clear_cpu(cpu, cpu_initialized_mask);
 	smp_mb();
 
 	/*
@@ -1060,47 +1040,16 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 	 * - Use an INIT boot APIC message
 	 */
 	if (apic->wakeup_secondary_cpu_64)
-		return apic->wakeup_secondary_cpu_64(apicid, start_ip);
+		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip);
 	else if (apic->wakeup_secondary_cpu)
-		return apic->wakeup_secondary_cpu(apicid, start_ip);
-
-	return wakeup_secondary_cpu_via_init(apicid, start_ip);
-}
-
-static int wait_cpu_cpumask(unsigned int cpu, const struct cpumask *mask)
-{
-	unsigned long timeout;
-
-	/*
-	 * Wait up to 10s for the CPU to report in.
-	 */
-	timeout = jiffies + 10*HZ;
-	while (time_before(jiffies, timeout)) {
-		if (cpumask_test_cpu(cpu, mask))
-			return 0;
-
-		schedule();
-	}
-	return -1;
-}
-
-/*
- * Bringup step two: Wait for the target AP to reach cpu_init_secondary()
- * and thus wait_for_master_cpu(), then set cpu_callout_mask to allow it
- * to proceed.  The AP will then proceed past setting its 'callin' bit
- * and end up waiting in check_tsc_sync_target() until we reach
- * wait_cpu_online() to tend to it.
- */
-static int wait_cpu_initialized(unsigned int cpu)
-{
-	/*
-	 * Wait for first sign of life from AP.
-	 */
-	if (wait_cpu_cpumask(cpu, cpu_initialized_mask))
-		return -1;
+		ret = apic->wakeup_secondary_cpu(apicid, start_ip);
+	else
+		ret = wakeup_secondary_cpu_via_init(apicid, start_ip);
 
-	cpumask_set_cpu(cpu, cpu_callout_mask);
-	return 0;
+	/* If the wakeup mechanism failed, cleanup the warm reset vector */
+	if (ret)
+		arch_cpuhp_cleanup_kick_cpu(cpu);
+	return ret;
 }
 
 static int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
@@ -1125,11 +1074,6 @@ static int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 	 */
 	mtrr_save_state();
 
-	/* x86 CPUs take themselves offline, so delayed offline is OK. */
-	err = cpu_check_up_prepare(cpu);
-	if (err && err != -EBUSY)
-		return err;
-
 	/* the FPU context is blank, nobody can own it */
 	per_cpu(fpu_fpregs_owner_ctx, cpu) = NULL;
 
@@ -1146,17 +1090,29 @@ static int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 
 int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
-	int ret;
-
-	ret = native_kick_ap(cpu, tidle);
-	if (!ret)
-		ret = wait_cpu_initialized(cpu);
+	return native_kick_ap(cpu, tidle);
+}
 
+void arch_cpuhp_cleanup_kick_cpu(unsigned int cpu)
+{
 	/* Cleanup possible dangling ends... */
-	if (x86_platform.legacy.warm_reset)
+	if (smp_ops.cpu_up == native_cpu_up && x86_platform.legacy.warm_reset)
 		smpboot_restore_warm_reset_vector();
+}
 
-	return ret;
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
+{
+	if (smp_ops.cleanup_dead_cpu)
+		smp_ops.cleanup_dead_cpu(cpu);
+
+	if (system_state == SYSTEM_RUNNING)
+		pr_info("CPU %u is now offline\n", cpu);
+}
+
+void arch_cpuhp_sync_state_poll(void)
+{
+	if (smp_ops.poll_sync_state)
+		smp_ops.poll_sync_state();
 }
 
 /**
@@ -1348,9 +1304,6 @@ void __init native_smp_prepare_boot_cpu(void)
 	if (!IS_ENABLED(CONFIG_SMP))
 		switch_gdt_and_percpu_base(me);
 
-	/* already set me in cpu_online_mask in boot_cpu_init() */
-	cpumask_set_cpu(me, cpu_callout_mask);
-	cpu_set_state_online(me);
 	native_pv_lock_init();
 }
 
@@ -1477,8 +1430,6 @@ __init void prefill_possible_map(void)
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
-	alloc_bootmem_cpumask_var(&cpu_initialized_mask);
-	alloc_bootmem_cpumask_var(&cpu_callout_mask);
 	alloc_bootmem_cpumask_var(&cpu_sibling_setup_mask);
 }
 
@@ -1540,9 +1491,6 @@ static void remove_siblinginfo(int cpu)
 static void remove_cpu_from_maps(int cpu)
 {
 	set_cpu_online(cpu, false);
-	cpumask_clear_cpu(cpu, cpu_callout_mask);
-	/* was set by cpu_init() */
-	cpumask_clear_cpu(cpu, cpu_initialized_mask);
 	numa_remove_cpu(cpu);
 }
 
@@ -1593,36 +1541,11 @@ int native_cpu_disable(void)
 	return 0;
 }
 
-int common_cpu_die(unsigned int cpu)
-{
-	int ret = 0;
-
-	/* We don't do anything here: idle task is faking death itself. */
-
-	/* They ack this in play_dead() by setting CPU_DEAD */
-	if (cpu_wait_death(cpu, 5)) {
-		if (system_state == SYSTEM_RUNNING)
-			pr_info("CPU %u is now offline\n", cpu);
-	} else {
-		pr_err("CPU %u didn't die...\n", cpu);
-		ret = -1;
-	}
-
-	return ret;
-}
-
-void native_cpu_die(unsigned int cpu)
-{
-	common_cpu_die(cpu);
-}
-
 void play_dead_common(void)
 {
 	idle_task_exit();
 
-	/* Ack it */
-	(void)cpu_report_death();
-
+	cpuhp_ap_report_dead();
 	/*
 	 * With physical CPU hotplug, we should halt the cpu
 	 */
@@ -1724,12 +1647,6 @@ int native_cpu_disable(void)
 	return -ENOSYS;
 }
 
-void native_cpu_die(unsigned int cpu)
-{
-	/* We said "no" in __cpu_disable */
-	BUG();
-}
-
 void native_play_dead(void)
 {
 	BUG();
diff --git a/arch/x86/xen/smp_hvm.c b/arch/x86/xen/smp_hvm.c
index b70afdf..ac95d19 100644
--- a/arch/x86/xen/smp_hvm.c
+++ b/arch/x86/xen/smp_hvm.c
@@ -55,18 +55,16 @@ static void __init xen_hvm_smp_prepare_cpus(unsigned int max_cpus)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void xen_hvm_cpu_die(unsigned int cpu)
+static void xen_hvm_cleanup_dead_cpu(unsigned int cpu)
 {
-	if (common_cpu_die(cpu) == 0) {
-		if (xen_have_vector_callback) {
-			xen_smp_intr_free(cpu);
-			xen_uninit_lock_cpu(cpu);
-			xen_teardown_timer(cpu);
-		}
+	if (xen_have_vector_callback) {
+		xen_smp_intr_free(cpu);
+		xen_uninit_lock_cpu(cpu);
+		xen_teardown_timer(cpu);
 	}
 }
 #else
-static void xen_hvm_cpu_die(unsigned int cpu)
+static void xen_hvm_cleanup_dead_cpu(unsigned int cpu)
 {
 	BUG();
 }
@@ -77,7 +75,7 @@ void __init xen_hvm_smp_init(void)
 	smp_ops.smp_prepare_boot_cpu = xen_hvm_smp_prepare_boot_cpu;
 	smp_ops.smp_prepare_cpus = xen_hvm_smp_prepare_cpus;
 	smp_ops.smp_cpus_done = xen_smp_cpus_done;
-	smp_ops.cpu_die = xen_hvm_cpu_die;
+	smp_ops.cleanup_dead_cpu = xen_hvm_cleanup_dead_cpu;
 
 	if (!xen_have_vector_callback) {
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index be40927..b089fb1 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -62,6 +62,7 @@ static void cpu_bringup(void)
 	int cpu;
 
 	cr4_init();
+	cpuhp_ap_sync_alive();
 	cpu_init();
 	touch_softlockup_watchdog();
 
@@ -83,7 +84,7 @@ static void cpu_bringup(void)
 
 	set_cpu_online(cpu, true);
 
-	cpu_set_state_online(cpu);  /* Implies full memory barrier. */
+	smp_mb();
 
 	/* We can take interrupts now: we're officially "up". */
 	local_irq_enable();
@@ -323,14 +324,6 @@ static int xen_pv_cpu_up(unsigned int cpu, struct task_struct *idle)
 
 	xen_setup_runstate_info(cpu);
 
-	/*
-	 * PV VCPUs are always successfully taken down (see 'while' loop
-	 * in xen_cpu_die()), so -EBUSY is an error.
-	 */
-	rc = cpu_check_up_prepare(cpu);
-	if (rc)
-		return rc;
-
 	/* make sure interrupts start blocked */
 	per_cpu(xen_vcpu, cpu)->evtchn_upcall_mask = 1;
 
@@ -349,6 +342,11 @@ static int xen_pv_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+static void xen_pv_poll_sync_state(void)
+{
+	HYPERVISOR_sched_op(SCHEDOP_yield, NULL);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int xen_pv_cpu_disable(void)
 {
@@ -364,18 +362,18 @@ static int xen_pv_cpu_disable(void)
 
 static void xen_pv_cpu_die(unsigned int cpu)
 {
-	while (HYPERVISOR_vcpu_op(VCPUOP_is_up,
-				  xen_vcpu_nr(cpu), NULL)) {
+	while (HYPERVISOR_vcpu_op(VCPUOP_is_up, xen_vcpu_nr(cpu), NULL)) {
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 	}
+}
 
-	if (common_cpu_die(cpu) == 0) {
-		xen_smp_intr_free(cpu);
-		xen_uninit_lock_cpu(cpu);
-		xen_teardown_timer(cpu);
-		xen_pmu_finish(cpu);
-	}
+static void xen_pv_cleanup_dead_cpu(unsigned int cpu)
+{
+	xen_smp_intr_free(cpu);
+	xen_uninit_lock_cpu(cpu);
+	xen_teardown_timer(cpu);
+	xen_pmu_finish(cpu);
 }
 
 static void __noreturn xen_pv_play_dead(void) /* used only with HOTPLUG_CPU */
@@ -397,6 +395,11 @@ static void xen_pv_cpu_die(unsigned int cpu)
 	BUG();
 }
 
+static void xen_pv_cleanup_dead_cpu(unsigned int cpu)
+{
+	BUG();
+}
+
 static void __noreturn xen_pv_play_dead(void)
 {
 	BUG();
@@ -437,6 +440,8 @@ static const struct smp_ops xen_smp_ops __initconst = {
 
 	.cpu_up = xen_pv_cpu_up,
 	.cpu_die = xen_pv_cpu_die,
+	.cleanup_dead_cpu = xen_pv_cleanup_dead_cpu,
+	.poll_sync_state = xen_pv_poll_sync_state,
 	.cpu_disable = xen_pv_cpu_disable,
 	.play_dead = xen_pv_play_dead,
 
