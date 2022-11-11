Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB525625B00
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiKKNIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiKKNH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:07:56 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8A08C5A1;
        Fri, 11 Nov 2022 05:07:50 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7zWm2wQZzmVpm;
        Fri, 11 Nov 2022 21:07:32 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 21:07:48 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 21:07:47 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Robert Elliott <elliott@hpe.com>
Subject: [PATCH v7 4/6] rcu: Add RCU stall diagnosis information
Date:   Fri, 11 Nov 2022 21:07:07 +0800
Message-ID: <20221111130709.247-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221111130709.247-1-thunder.leizhen@huawei.com>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because RCU CPU stall warnings are driven from the scheduling-clock
interrupt handler, a workload consisting of a very large number of
short-duration hardware interrupts can result in misleading stall-warning
messages.  On systems supporting only a single level of interrupts,
that is, where interrupts handlers cannot be interrupted, this can
produce misleading diagnostics.  The stack traces will show the
innocent-bystander interrupted task, not the interrupts that are
at the very least exacerbating the stall.

This situation can be improved by displaying the number of interrupts
and the CPU time that they have consumed.  Diagnosing other types
of stalls can be eased by also providing the count of softirqs and
the CPU time that they consumed as well as the number of context
switches and the task-level CPU time consumed.

Consider the following output given this change:

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu:     0-....: (1250 ticks this GP) <omitted>
rcu:          hardirqs   softirqs   csw/system
rcu:  number:      624         45            0
rcu: cputime:       69          1         2425   ==> 2500(ms)

This output shows that the number of hard and soft interrupts is small,
there are no context switches, and the system takes up a lot of time. This
indicates that the current task is looping with preemption disabled.

The impact on system performance is negligible because snapshot is
recorded only once for all continuous RCU stalls.

This added debugging information is suppressed by default and can be
enabled by building the kernel with CONFIG_RCU_CPU_STALL_CPUTIME=y or
by booting with rcupdate.rcu_cpu_stall_cputime=1.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++
 kernel/rcu/Kconfig.debug                      | 11 +++++++
 kernel/rcu/rcu.h                              |  1 +
 kernel/rcu/tree.c                             | 18 +++++++++++
 kernel/rcu/tree.h                             | 19 ++++++++++++
 kernel/rcu/tree_stall.h                       | 31 +++++++++++++++++++
 kernel/rcu/update.c                           |  2 ++
 7 files changed, 88 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 811b2e6d4672685..ee7d9d962591c5d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5084,6 +5084,12 @@
 			rcupdate.rcu_cpu_stall_timeout to be used (after
 			conversion from seconds to milliseconds).
 
+	rcupdate.rcu_cpu_stall_cputime= [KNL]
+			Provide statistics on the cputime and count of
+			interrupts and tasks during the sampling period. For
+			multiple continuous RCU stalls, all sampling periods
+			begin at half of the first RCU stall timeout.
+
 	rcupdate.rcu_expedited= [KNL]
 			Use expedited grace-period primitives, for
 			example, synchronize_rcu_expedited() instead
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 1b0c41d490f0588..025566a9ba44667 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -95,6 +95,17 @@ config RCU_EXP_CPU_STALL_TIMEOUT
 	  says to use the RCU_CPU_STALL_TIMEOUT value converted from
 	  seconds to milliseconds.
 
+config RCU_CPU_STALL_CPUTIME
+	bool "Provide additional RCU stall debug information"
+	depends on RCU_STALL_COMMON
+	default n
+	help
+	  Collect statistics during the sampling period, such as the number of
+	  (hard interrupts, soft interrupts, task switches) and the cputime of
+	  (hard interrupts, soft interrupts, kernel tasks) are added to the
+	  RCU stall report. For multiple continuous RCU stalls, all sampling
+	  periods begin at half of the first RCU stall timeout.
+
 config RCU_TRACE
 	bool "Enable tracing for RCU"
 	depends on DEBUG_KERNEL
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 96122f203187f39..4844dec36bddb48 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -231,6 +231,7 @@ extern int rcu_cpu_stall_ftrace_dump;
 extern int rcu_cpu_stall_suppress;
 extern int rcu_cpu_stall_timeout;
 extern int rcu_exp_cpu_stall_timeout;
+extern int rcu_cpu_stall_cputime;
 int rcu_jiffies_till_stall_check(void);
 int rcu_exp_jiffies_till_stall_check(void);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ed93ddb8203d42c..3921aacfd421ba9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -866,6 +866,24 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
 		}
+
+		if (rcu_cpu_stall_cputime && rdp->snap_record.gp_seq != rdp->gp_seq) {
+			int cpu = rdp->cpu;
+			struct rcu_snap_record *rsrp;
+			struct kernel_cpustat *kcsp;
+
+			kcsp = &kcpustat_cpu(cpu);
+
+			rsrp = &rdp->snap_record;
+			rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
+			rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
+			rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
+			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
+			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
+			rsrp->nr_csw = nr_context_switches_cpu(rdp->cpu);
+			rsrp->jiffies = jiffies;
+			rsrp->gp_seq = rdp->gp_seq;
+		}
 	}
 
 	return 0;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index fcb5d696eb1700d..192536916f9a607 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -158,6 +158,23 @@ union rcu_noqs {
 	u16 s; /* Set of bits, aggregate OR here. */
 };
 
+/*
+ * Record the snapshot of the core stats at half of the first RCU stall timeout.
+ * The member gp_seq is used to ensure that all members are updated only once
+ * during the sampling period. The snapshot is taken only if this gp_seq is not
+ * equal to rdp->gp_seq.
+ */
+struct rcu_snap_record {
+	unsigned long	gp_seq;		/* Track rdp->gp_seq counter */
+	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
+	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
+	u64		cputime_system; /* Accumulated cputime of kernel tasks */
+	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
+	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */
+	unsigned long long nr_csw;	/* Accumulated number of task switches */
+	unsigned long   jiffies;	/* Track jiffies value */
+};
+
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
@@ -262,6 +279,8 @@ struct rcu_data {
 	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
 	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
 	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
+	struct rcu_snap_record snap_record; /* Snapshot of core stats at half of */
+					    /* the first RCU stall timeout */
 
 	long lazy_len;			/* Length of buffered lazy callbacks. */
 	int cpu;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5653560573e22d6..a91e844872e59d2 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -428,6 +428,35 @@ static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp
 	return j > 2 * HZ;
 }
 
+static void print_cpu_stat_info(int cpu)
+{
+	struct rcu_snap_record rsr, *rsrp;
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	struct kernel_cpustat *kcsp = &kcpustat_cpu(cpu);
+
+	if (!rcu_cpu_stall_cputime)
+		return;
+
+	rsrp = &rdp->snap_record;
+	if (rsrp->gp_seq != rdp->gp_seq)
+		return;
+
+	rsr.cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
+	rsr.cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
+	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
+
+	pr_err("\t         hardirqs   softirqs   csw/system\n");
+	pr_err("\t number: %8ld %10d %12lld\n",
+		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
+		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
+		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
+	pr_err("\tcputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
+		div_u64(rsr.cputime_irq - rsrp->cputime_irq, NSEC_PER_MSEC),
+		div_u64(rsr.cputime_softirq - rsrp->cputime_softirq, NSEC_PER_MSEC),
+		div_u64(rsr.cputime_system - rsrp->cputime_system, NSEC_PER_MSEC),
+		jiffies64_to_msecs(jiffies - rsrp->jiffies));
+}
+
 /*
  * Print out diagnostic information for the specified stalled CPU.
  *
@@ -484,6 +513,8 @@ static void print_cpu_stall_info(int cpu)
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       rcuc_starved ? buf : "",
 	       falsepositive ? " (false positive?)" : "");
+
+	print_cpu_stat_info(cpu);
 }
 
 /* Complain about starvation of grace-period kthread.  */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index a05e23648c6b99f..76f9848a21cd5be 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -508,6 +508,8 @@ int rcu_cpu_stall_timeout __read_mostly = CONFIG_RCU_CPU_STALL_TIMEOUT;
 module_param(rcu_cpu_stall_timeout, int, 0644);
 int rcu_exp_cpu_stall_timeout __read_mostly = CONFIG_RCU_EXP_CPU_STALL_TIMEOUT;
 module_param(rcu_exp_cpu_stall_timeout, int, 0644);
+int rcu_cpu_stall_cputime __read_mostly = IS_ENABLED(CONFIG_RCU_CPU_STALL_CPUTIME);
+module_param(rcu_cpu_stall_cputime, int, 0644);
 #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
 
 // Suppress boot-time RCU CPU stall warnings and rcutorture writer stall
-- 
2.25.1

