Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69896E2D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjDNXrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjDNXrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:47:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C929742;
        Fri, 14 Apr 2023 16:46:07 -0700 (PDT)
Message-ID: <20230414232311.004104404@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681515901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ocDa9/b5b649kz9ODCiS7Obhl2xff0PGySrVJUnu/1Q=;
        b=Md1KUi0t4p5246hEM+Qbsg81XiYR2jMjuw8Cw1D96u97R/Z2vnRzvzyGsvg5/thdzlhagw
        VxVAyRxzHuR0yoObilNCNxEii10xKHOuzvMmMpympXYYlB2U8gUH+sjsIvQSBudSOTSmdM
        UnCqcdLP+SdXgts22XiNkil1Ao3IAY8flV5MA9J+wt6a2jzpqf6qFRYX/asyt9IKYGJESJ
        xr1bFKQEJqtc2y44yr2+c326EAG2BPB0FHdGHcRgBqiJBXhDU2UyMAE2uzcyA4utOsub3q
        p754cUuO5uG6++I5nPeZhand8mstexdu0PM3TYbIMB2kMernSkCdSX7RIPkZfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681515901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ocDa9/b5b649kz9ODCiS7Obhl2xff0PGySrVJUnu/1Q=;
        b=BXd39doKKTpBx8WPmaV0PtWPunRukkpmlrtLhowy8wImwT3Zn16BG6OqXrJtidsxX/8Ej+
        driBsAHHd5CWSWBA==
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
Subject: [patch 29/37] cpu/hotplug: Provide a split up CPUHP_BRINGUP mechanism
References: <20230414225551.858160935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 15 Apr 2023 01:45:00 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/Kconfig               |    4 ++
 include/linux/cpuhotplug.h |    4 ++
 kernel/cpu.c               |   70 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 76 insertions(+), 2 deletions(-)

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
 
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -133,6 +133,7 @@ enum cpuhp_state {
 	CPUHP_MIPS_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		= CPUHP_BP_PREPARE_DYN + 20,
+	CPUHP_BP_KICK_AP,
 	CPUHP_BRINGUP_CPU,
 
 	/*
@@ -519,9 +520,12 @@ void cpuhp_online_idle(enum cpuhp_state
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
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -759,6 +759,47 @@ static int bringup_wait_for_ap_online(un
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
@@ -775,7 +816,6 @@ static int bringup_cpu(unsigned int cpu)
 	 */
 	irq_lock_sparse();
 
-	/* Arch-specific enabling code. */
 	ret = __cpu_up(cpu, idle);
 	if (ret)
 		goto out_unlock;
@@ -799,6 +839,7 @@ static int bringup_cpu(unsigned int cpu)
 	irq_unlock_sparse();
 	return ret;
 }
+#endif
 
 static int finish_cpu(unsigned int cpu)
 {
@@ -1938,13 +1979,38 @@ static struct cpuhp_step cpuhp_hp_states
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

