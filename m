Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE486E2D6C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDNXqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDNXpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:45:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6969EFA;
        Fri, 14 Apr 2023 16:44:59 -0700 (PDT)
Message-ID: <20230414232310.319386819@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681515883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7hAm6I9MiGtPmIXfa24B9PQ6b2IikPrY0L+IvEnJvPI=;
        b=jK/GS8nzEcoNMYUK0AKSW91HahqfcKmgmQ+JtmtDnur9HSlYdew/SITlGW5QELStSGh6Q/
        V57WOhEWSVSxWZWhG3SaBczDcMaraK+itB6zsiGdpLQtzoC7yxxSloqDZW6B4Njz8MWDbR
        miMPGsiCOdTRydFFdFmiS70GYeAIK8oBwYAUlay9JYTfVbSXJ63AXiImeMdnSL+M470Et5
        VfCBSEigMVHivkoKuqa+6Tu/41+RxN+9jOUZtcMtyT4RoQND7Pp1xwtWviW33NcuD2Qa/G
        AC+ABgPHvS+/XtBUfn+u5LoukNQ3JpVGWaLmycJWPrCSc7LATrT2CKreEiN1ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681515883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7hAm6I9MiGtPmIXfa24B9PQ6b2IikPrY0L+IvEnJvPI=;
        b=IpKwz96GwSWUZ2KDbHlOo0nFprwPP3s9jahoNB/qpcC8qkXn9/Q9MaoBQo6UsIzMi7+Hea
        LODiZVcbnARULPAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        "Arjan van de Veen" <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: [patch 18/37] cpu/hotplug: Add CPU state tracking and synchronization
References: <20230414225551.858160935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 15 Apr 2023 01:44:42 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU state tracking and synchronization mechanism in smpboot.c is
completely independent of the hotplug code and all logic around it is
implemented in architecture specific code.

Except for the state reporting of the AP there is absolutely nothing
architecture specific and the sychronization and decision functions can be
moved into the generic hotplug core code.

Provide an integrated variant and add the core synchronization and decision
points. This comes in two flavours:

  1) DEAD state synchronization

     Updated by the architecture code once the AP reaches the point where
     it is ready to be torn down by the control CPU, e.g. by removing power
     or clocks or tear down via the hypervisor.

     The control CPU waits for this state to be reached with a timeout. If
     the state is reached an architecture specific cleanup function is
     invoked.

  2) Full state synchronization

     This extends #1 with AP alive synchronization. This is new
     functionality, which allows to replace architecture specific wait
     mechanims, e.g. cpumasks, completely.

     It also prevents that an AP which is in a limbo state can be brought
     up again. This can happen when an AP failed to report dead state
     during a previous off-line operation.

The dead synchronization is what most architectures use. Only x86 makes a
bringup decision based on that state at the moment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/Kconfig               |   15 +++
 include/linux/cpuhotplug.h |   12 ++
 kernel/cpu.c               |  193 ++++++++++++++++++++++++++++++++++++++++++++-
 kernel/smpboot.c           |    2 
 4 files changed, 221 insertions(+), 1 deletion(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -34,6 +34,21 @@ config ARCH_HAS_SUBPAGE_FAULTS
 config HOTPLUG_SMT
 	bool
 
+# Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
+config HOTPLUG_CORE_SYNC
+	bool
+
+# Basic CPU dead synchronization selected by architecture
+config HOTPLUG_CORE_SYNC_DEAD
+	bool
+	select HOTPLUG_CORE_SYNC
+
+# Full CPU synchronization with alive state selected by architecture
+config HOTPLUG_CORE_SYNC_FULL
+	bool
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
+	select HOTPLUG_CORE_SYNC
+
 config GENERIC_ENTRY
 	bool
 
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -519,4 +519,16 @@ void cpuhp_online_idle(enum cpuhp_state
 static inline void cpuhp_online_idle(enum cpuhp_state state) { }
 #endif
 
+void cpuhp_ap_sync_alive(void);
+void arch_cpuhp_sync_state_poll(void);
+void arch_cpuhp_cleanup_kick_cpu(unsigned int cpu);
+
+#ifdef CONFIG_HOTPLUG_CORE_SYNC_DEAD
+void cpuhp_ap_report_dead(void);
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu);
+#else
+static inline void cpuhp_ap_report_dead(void) { }
+static inline void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu) { }
+#endif
+
 #endif
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -17,6 +17,7 @@
 #include <linux/cpu.h>
 #include <linux/oom.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/bug.h>
 #include <linux/kthread.h>
@@ -59,6 +60,7 @@
  * @last:	For multi-instance rollback, remember how far we got
  * @cb_state:	The state for a single callback (install/uninstall)
  * @result:	Result of the operation
+ * @ap_sync_state:	State for AP synchronization
  * @done_up:	Signal completion to the issuer of the task for cpu-up
  * @done_down:	Signal completion to the issuer of the task for cpu-down
  */
@@ -76,6 +78,7 @@ struct cpuhp_cpu_state {
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
 	int			result;
+	atomic_t		ap_sync_state;
 	struct completion	done_up;
 	struct completion	done_down;
 #endif
@@ -276,6 +279,182 @@ static bool cpuhp_is_atomic_state(enum c
 	return CPUHP_AP_IDLE_DEAD <= state && state < CPUHP_AP_ONLINE;
 }
 
+/* Synchronization state management */
+enum cpuhp_sync_state {
+	SYNC_STATE_DEAD,
+	SYNC_STATE_KICKED,
+	SYNC_STATE_SHOULD_DIE,
+	SYNC_STATE_ALIVE,
+	SYNC_STATE_SHOULD_ONLINE,
+	SYNC_STATE_ONLINE,
+};
+
+#ifdef CONFIG_HOTPLUG_CORE_SYNC
+/**
+ * cpuhp_ap_update_sync_state - Update synchronization state during bringup/teardown
+ * @state:	The synchronization state to set
+ *
+ * No synchronization point. Just update of the synchronization state.
+ */
+static inline void cpuhp_ap_update_sync_state(enum cpuhp_sync_state state)
+{
+	atomic_t *st = this_cpu_ptr(&cpuhp_state.ap_sync_state);
+	int sync = atomic_read(st);
+
+	while (!atomic_try_cmpxchg(st, &sync, state));
+}
+
+void __weak arch_cpuhp_sync_state_poll(void) { cpu_relax(); }
+
+static bool cpuhp_wait_for_sync_state(unsigned int cpu, enum cpuhp_sync_state state,
+				      enum cpuhp_sync_state next_state)
+{
+	atomic_t *st = per_cpu_ptr(&cpuhp_state.ap_sync_state, cpu);
+	ktime_t now, end, start = ktime_get();
+	int sync;
+
+	end = start + 10ULL * NSEC_PER_SEC;
+
+	sync = atomic_read(st);
+	while (1) {
+		if (sync == state) {
+			if (!atomic_try_cmpxchg(st, &sync, next_state))
+				continue;
+			return true;
+		}
+
+		now = ktime_get();
+		if (now > end) {
+			/* Timeout. Leave the state unchanged */
+			return false;
+		} else if (now - start < NSEC_PER_MSEC) {
+			/* Poll for one millisecond */
+			arch_cpuhp_sync_state_poll();
+		} else {
+			usleep_range_state(USEC_PER_MSEC, 2 * USEC_PER_MSEC, TASK_UNINTERRUPTIBLE);
+		}
+		sync = atomic_read(st);
+	}
+	return true;
+}
+#else  /* CONFIG_HOTPLUG_CORE_SYNC */
+static inline void cpuhp_ap_update_sync_state(enum cpuhp_sync_state state) { }
+#endif /* !CONFIG_HOTPLUG_CORE_SYNC */
+
+#ifdef CONFIG_HOTPLUG_CORE_SYNC_DEAD
+/**
+ * cpuhp_ap_report_dead - Update synchronization state to DEAD
+ *
+ * No synchronization point. Just update of the synchronization state.
+ */
+void cpuhp_ap_report_dead(void)
+{
+	cpuhp_ap_update_sync_state(SYNC_STATE_DEAD);
+}
+
+void __weak arch_cpuhp_cleanup_dead_cpu(unsigned int cpu) { }
+
+/*
+ * Late CPU shutdown synchronization point. Cannot use cpuhp_state::done_down
+ * because the AP cannot issue complete() at this stage.
+ */
+static void cpuhp_bp_sync_dead(unsigned int cpu)
+{
+	atomic_t *st = per_cpu_ptr(&cpuhp_state.ap_sync_state, cpu);
+	int sync = atomic_read(st);
+
+	do {
+		/* CPU can have reported dead already. Don't overwrite that! */
+		if (sync == SYNC_STATE_DEAD)
+			break;
+	} while (!atomic_try_cmpxchg(st, &sync, SYNC_STATE_SHOULD_DIE));
+
+	if (cpuhp_wait_for_sync_state(cpu, SYNC_STATE_DEAD, SYNC_STATE_DEAD)) {
+		/* CPU reached dead state. Invoke the cleanup function */
+		arch_cpuhp_cleanup_dead_cpu(cpu);
+		return;
+	}
+
+	/* No further action possible. Emit message and give up. */
+	pr_err("CPU%u failed to report dead state\n", cpu);
+}
+#else /* CONFIG_HOTPLUG_CORE_SYNC_DEAD */
+static inline void cpuhp_bp_sync_dead(unsigned int cpu) { }
+#endif /* !CONFIG_HOTPLUG_CORE_SYNC_DEAD */
+
+#ifdef CONFIG_HOTPLUG_CORE_SYNC_FULL
+/**
+ * cpuhp_ap_sync_alive - Synchronize AP with the control CPU once it is alive
+ *
+ * Updates the AP synchronization state to SYNC_STATE_ALIVE and waits
+ * for the BP to release it.
+ */
+void cpuhp_ap_sync_alive(void)
+{
+	atomic_t *st = this_cpu_ptr(&cpuhp_state.ap_sync_state);
+
+	cpuhp_ap_update_sync_state(SYNC_STATE_ALIVE);
+
+	/* Wait for the control CPU to release it. */
+	while (atomic_read(st) != SYNC_STATE_SHOULD_ONLINE)
+		cpu_relax();
+}
+
+static bool cpuhp_can_boot_ap(unsigned int cpu)
+{
+	atomic_t *st = per_cpu_ptr(&cpuhp_state.ap_sync_state, cpu);
+	int sync = atomic_read(st);
+
+again:
+	switch (sync) {
+	case SYNC_STATE_DEAD:
+		/* CPU is properly dead */
+		break;
+	case SYNC_STATE_KICKED:
+		/* CPU did not come up in previous attempt */
+		break;
+	case SYNC_STATE_ALIVE:
+		/* CPU is stuck cpuhp_ap_sync_alive(). */
+		break;
+	default:
+		/* CPU failed to report online or dead and is in limbo state. */
+		return false;
+	}
+
+	/* Prepare for booting */
+	if (!atomic_try_cmpxchg(st, &sync, SYNC_STATE_KICKED))
+		goto again;
+
+	return true;
+}
+
+void __weak arch_cpuhp_cleanup_kick_cpu(unsigned int cpu) { }
+
+/*
+ * Early CPU bringup synchronization point. Cannot use cpuhp_state::done_up
+ * because the AP cannot issue complete() so early in the bringup.
+ */
+static int cpuhp_bp_sync_alive(unsigned int cpu)
+{
+	int ret = 0;
+
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CORE_SYNC_FULL))
+		return 0;
+
+	if (!cpuhp_wait_for_sync_state(cpu, SYNC_STATE_ALIVE, SYNC_STATE_SHOULD_ONLINE)) {
+		pr_err("CPU%u failed to report alive state\n", cpu);
+		ret = -EIO;
+	}
+
+	/* Let the architecture cleanup the kick alive mechanics. */
+	arch_cpuhp_cleanup_kick_cpu(cpu);
+	return ret;
+}
+#else /* CONFIG_HOTPLUG_CORE_SYNC_FULL */
+static inline int cpuhp_bp_sync_alive(unsigned int cpu) { return 0; }
+static inline bool cpuhp_can_boot_ap(unsigned int cpu) { return true; }
+#endif /* !CONFIG_HOTPLUG_CORE_SYNC_FULL */
+
 /* Serializes the updates to cpu_online_mask, cpu_present_mask */
 static DEFINE_MUTEX(cpu_add_remove_lock);
 bool cpuhp_tasks_frozen;
@@ -588,6 +767,9 @@ static int bringup_cpu(unsigned int cpu)
 	struct task_struct *idle = idle_thread_get(cpu);
 	int ret;
 
+	if (!cpuhp_can_boot_ap(cpu))
+		return -EAGAIN;
+
 	/*
 	 * Reset stale stack state from the last time this CPU was online.
 	 */
@@ -606,6 +788,10 @@ static int bringup_cpu(unsigned int cpu)
 	if (ret)
 		goto out_unlock;
 
+	ret = cpuhp_bp_sync_alive(cpu);
+	if (ret)
+		goto out_unlock;
+
 	ret = bringup_wait_for_ap_online(cpu);
 	if (ret)
 		goto out_unlock;
@@ -1109,6 +1295,8 @@ static int takedown_cpu(unsigned int cpu
 	/* This actually kills the CPU. */
 	__cpu_die(cpu);
 
+	cpuhp_bp_sync_dead(cpu);
+
 	tick_cleanup_dead_cpu(cpu);
 	rcutree_migrate_callbacks(cpu);
 	return 0;
@@ -1355,8 +1543,10 @@ void cpuhp_online_idle(enum cpuhp_state
 	if (state != CPUHP_AP_ONLINE_IDLE)
 		return;
 
+	cpuhp_ap_update_sync_state(SYNC_STATE_ONLINE);
+
 	/*
-	 * Unpart the stopper thread before we start the idle loop (and start
+	 * Unpark the stopper thread before we start the idle loop (and start
 	 * scheduling); this ensures the stopper task is always available.
 	 */
 	stop_machine_unpark(smp_processor_id());
@@ -2722,6 +2912,7 @@ void __init boot_cpu_hotplug_init(void)
 {
 #ifdef CONFIG_SMP
 	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
+	atomic_set(this_cpu_ptr(&cpuhp_state.ap_sync_state), SYNC_STATE_ONLINE);
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -326,6 +326,7 @@ void smpboot_unregister_percpu_thread(st
 }
 EXPORT_SYMBOL_GPL(smpboot_unregister_percpu_thread);
 
+#ifndef CONFIG_HOTPLUG_CORE_SYNC
 static DEFINE_PER_CPU(atomic_t, cpu_hotplug_state) = ATOMIC_INIT(CPU_POST_DEAD);
 
 /*
@@ -488,3 +489,4 @@ bool cpu_report_death(void)
 }
 
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
+#endif /* !CONFIG_HOTPLUG_CORE_SYNC */

