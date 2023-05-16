Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76097048A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjEPJK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjEPJKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295903AAC;
        Tue, 16 May 2023 02:10:00 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdDGTOTh34IsmWSDxUg/LPSimNk3e+pihd/S/kw8Qb4=;
        b=muLJ2bohUK3KIDc+CdMIDuuiPO5LhVPEazsZPHF+aAayKC1aNMOI0VIkMZMV09QTGckoZ3
        ULLEqIH+qMt4AjYpGMKFmHCWvMOtK25X+dh6GaS1+efS1U90pFRVIYt1RC+iJCmwVKixSq
        aq3c243j51YH1JTGr2eVBhAh9ULwctyXlmx+qDgOTaophOJsOlsuaEZZb18Sc781sB6uFp
        U0fN4OEgnqW5v33yLr61Ujo4cGI9RQq/q3Y5PCugMzsEy25Pnbl4myXbvolwQILM4vmcyc
        kqzsJRPDEnUUbuWKkgOswoTU5XNuJFhqeRkCExHtzrLRcjtiVDPuCW++mwOOBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdDGTOTh34IsmWSDxUg/LPSimNk3e+pihd/S/kw8Qb4=;
        b=g1qeS6sw5GTe9XYM7pM8d7qoMDQDeciqpXR93v5yMv9CzWjdF9rf/0FfDDuBnKGne/fntz
        SORZZU2tXp6Ao7BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Provide a split up CPUHP_BRINGUP mechanism
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205257.080801387@linutronix.de>
References: <20230512205257.080801387@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819550.404.2949108833035827678.tip-bot2@tip-bot2>
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

Commit-ID:     a631be92b996c5db9b368e8b96305d22fb8c4180
Gitweb:        https://git.kernel.org/tip/a631be92b996c5db9b368e8b96305d22fb8c4180
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:45:01 +02:00

cpu/hotplug: Provide a split up CPUHP_BRINGUP mechanism

The bring up logic of a to be onlined CPU consists of several parts, which
are considered to be a single hotplug state:

  1) Control CPU issues the wake-up

  2) To be onlined CPU starts up, does the minimal initialization,
     reports to be alive and waits for release into the complete bring-up.

  3) Control CPU waits for the alive report and releases the upcoming CPU
     for the complete bring-up.

Allow to split this into two states:

  1) Control CPU issues the wake-up

     After that the to be onlined CPU starts up, does the minimal
     initialization, reports to be alive and waits for release into the
     full bring-up. As this can run after the control CPU dropped the
     hotplug locks the code which is executed on the AP before it reports
     alive has to be carefully audited to not violate any of the hotplug
     constraints, especially not modifying any of the various cpumasks.

     This is really only meant to avoid waiting for the AP to react on the
     wake-up. Of course an architecture can move strict CPU related setup
     functionality, e.g. microcode loading, with care before the
     synchronization point to save further pointless waiting time.

  2) Control CPU waits for the alive report and releases the upcoming CPU
     for the complete bring-up.

This allows that the two states can be split up to run all to be onlined
CPUs up to state #1 on the control CPU and then at a later point run state
#2. This spares some of the latencies of the full serialized per CPU
bringup by avoiding the per CPU wakeup/wait serialization. The assumption
is that the first AP already waits when the last AP has been woken up. This
obvioulsy depends on the hardware latencies and depending on the timings
this might still not completely eliminate all wait scenarios.

This split is just a preparatory step for enabling the parallel bringup
later. The boot time bringup is still fully serialized. It has a separate
config switch so that architectures which want to support parallel bringup
can test the split of the CPUHP_BRINGUG step separately.

To enable this the architecture must support the CPU hotplug core sync
mechanism and has to be audited that there are no implicit hotplug state
dependencies which require a fully serialized bringup.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205257.080801387@linutronix.de
---
 arch/Kconfig               |  4 ++-
 include/linux/cpuhotplug.h |  4 ++-
 kernel/cpu.c               | 70 +++++++++++++++++++++++++++++++++++--
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f55c5fc..d3015a6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -49,6 +49,10 @@ config HOTPLUG_CORE_SYNC_FULL
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select HOTPLUG_CORE_SYNC
 
+config HOTPLUG_SPLIT_STARTUP
+	bool
+	select HOTPLUG_CORE_SYNC_FULL
+
 config GENERIC_ENTRY
 	bool
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 5def71f..bc2d0a1 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -133,6 +133,7 @@ enum cpuhp_state {
 	CPUHP_MIPS_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		= CPUHP_BP_PREPARE_DYN + 20,
+	CPUHP_BP_KICK_AP,
 	CPUHP_BRINGUP_CPU,
 
 	/*
@@ -517,9 +518,12 @@ void cpuhp_online_idle(enum cpuhp_state state);
 static inline void cpuhp_online_idle(enum cpuhp_state state) { }
 #endif
 
+struct task_struct;
+
 void cpuhp_ap_sync_alive(void);
 void arch_cpuhp_sync_state_poll(void);
 void arch_cpuhp_cleanup_kick_cpu(unsigned int cpu);
+int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tidle);
 
 #ifdef CONFIG_HOTPLUG_CORE_SYNC_DEAD
 void cpuhp_ap_report_dead(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0ab6a7d..d2487aa 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -761,6 +761,47 @@ static int bringup_wait_for_ap_online(unsigned int cpu)
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_SPLIT_STARTUP
+static int cpuhp_kick_ap_alive(unsigned int cpu)
+{
+	if (!cpuhp_can_boot_ap(cpu))
+		return -EAGAIN;
+
+	return arch_cpuhp_kick_ap_alive(cpu, idle_thread_get(cpu));
+}
+
+static int cpuhp_bringup_ap(unsigned int cpu)
+{
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+	int ret;
+
+	/*
+	 * Some architectures have to walk the irq descriptors to
+	 * setup the vector space for the cpu which comes online.
+	 * Prevent irq alloc/free across the bringup.
+	 */
+	irq_lock_sparse();
+
+	ret = cpuhp_bp_sync_alive(cpu);
+	if (ret)
+		goto out_unlock;
+
+	ret = bringup_wait_for_ap_online(cpu);
+	if (ret)
+		goto out_unlock;
+
+	irq_unlock_sparse();
+
+	if (st->target <= CPUHP_AP_ONLINE_IDLE)
+		return 0;
+
+	return cpuhp_kick_ap(cpu, st, st->target);
+
+out_unlock:
+	irq_unlock_sparse();
+	return ret;
+}
+#else
 static int bringup_cpu(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
@@ -781,7 +822,6 @@ static int bringup_cpu(unsigned int cpu)
 	 */
 	irq_lock_sparse();
 
-	/* Arch-specific enabling code. */
 	ret = __cpu_up(cpu, idle);
 	if (ret)
 		goto out_unlock;
@@ -805,6 +845,7 @@ out_unlock:
 	irq_unlock_sparse();
 	return ret;
 }
+#endif
 
 static int finish_cpu(unsigned int cpu)
 {
@@ -1944,13 +1985,38 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= timers_prepare_cpu,
 		.teardown.single	= timers_dead_cpu,
 	},
-	/* Kicks the plugged cpu into life */
+
+#ifdef CONFIG_HOTPLUG_SPLIT_STARTUP
+	/*
+	 * Kicks the AP alive. AP will wait in cpuhp_ap_sync_alive() until
+	 * the next step will release it.
+	 */
+	[CPUHP_BP_KICK_AP] = {
+		.name			= "cpu:kick_ap",
+		.startup.single		= cpuhp_kick_ap_alive,
+	},
+
+	/*
+	 * Waits for the AP to reach cpuhp_ap_sync_alive() and then
+	 * releases it for the complete bringup.
+	 */
+	[CPUHP_BRINGUP_CPU] = {
+		.name			= "cpu:bringup",
+		.startup.single		= cpuhp_bringup_ap,
+		.teardown.single	= finish_cpu,
+		.cant_stop		= true,
+	},
+#else
+	/*
+	 * All-in-one CPU bringup state which includes the kick alive.
+	 */
 	[CPUHP_BRINGUP_CPU] = {
 		.name			= "cpu:bringup",
 		.startup.single		= bringup_cpu,
 		.teardown.single	= finish_cpu,
 		.cant_stop		= true,
 	},
+#endif
 	/* Final state before CPU kills itself */
 	[CPUHP_AP_IDLE_DEAD] = {
 		.name			= "idle:dead",
