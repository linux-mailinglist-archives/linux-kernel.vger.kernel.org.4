Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824AC618E08
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiKDCM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKDCMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:12:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC71C5;
        Thu,  3 Nov 2022 19:12:43 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N3PKJ4wQXz15MJP;
        Fri,  4 Nov 2022 10:12:36 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 10:12:42 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 10:12:41 +0800
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
Subject: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Date:   Fri, 4 Nov 2022 10:12:23 +0800
Message-ID: <20221104021224.102-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221104021224.102-1-thunder.leizhen@huawei.com>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
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

In some extreme cases, such as the I/O pressure test, the CPU usage may
be 100%, causing RCU stall. In this case, the printed information about
current is not useful. Displays the number and usage of hard interrupts,
soft interrupts, and context switches that are generated within half of
the CPU stall timeout, can help us make a general judgment. In other
cases, we can preliminarily determine whether an infinite loop occurs
when local_irq, local_bh or preempt is disabled.

For example:
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu:     0-....: (1250 ticks this GP) <omitted>
rcu:          hardirqs   softirqs   csw/system
rcu:  number:      624         45            0
rcu: cputime:       69          1         2425   ==> 2500(ms)

The example above shows that the number of hard and soft interrupts is
small, there is zero context switching, and the system takes up a lot of
time. We can quickly conclude that the current task is infinitely looped
with preempt_disable().

The impact on system performance is negligible because snapshot is
recorded only one time after 1/2 CPU stall timeout.

This enhanced debugging information is suppressed by default and can be
enabled by CONFIG_RCU_CPU_STALL_DEEP_DEBUG=y or
rcupdate.rcu_cpu_stall_deep_debug=1.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 kernel/rcu/Kconfig.debug                      | 10 ++++++
 kernel/rcu/rcu.h                              |  1 +
 kernel/rcu/tree.c                             | 16 ++++++++++
 kernel/rcu/tree.h                             | 17 ++++++++++
 kernel/rcu/tree_stall.h                       | 31 +++++++++++++++++++
 kernel/rcu/update.c                           |  2 ++
 7 files changed, 82 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a465d5242774af8..f7c0cfd1cdcacd3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5082,6 +5082,11 @@
 			rcupdate.rcu_cpu_stall_timeout to be used (after
 			conversion from seconds to milliseconds).
 
+	rcupdate.rcu_cpu_stall_cputime= [KNL]
+			Provide statistics on the cputime and count of
+			interrupts and tasks during the second half of
+			rcu stall timeout.
+
 	rcupdate.rcu_expedited= [KNL]
 			Use expedited grace-period primitives, for
 			example, synchronize_rcu_expedited() instead
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 1b0c41d490f0588..cd7190d6b34e790 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -95,6 +95,16 @@ config RCU_EXP_CPU_STALL_TIMEOUT
 	  says to use the RCU_CPU_STALL_TIMEOUT value converted from
 	  seconds to milliseconds.
 
+config RCU_CPU_STALL_CPUTIME
+	bool "Provide additional rcu stall debug information"
+	depends on RCU_STALL_COMMON
+	default n
+	help
+	  Statistics during the period from RCU_CPU_STALL_TIMEOUT/2 to
+	  RCU_CPU_STALL_TIMEOUT, such as the number of (hard interrupts, soft
+	  interrupts, task switches) and the cputime of (hard interrupts, soft
+	  interrupts, kerenl tasks) are added to the rcu stall report.
+
 config RCU_TRACE
 	bool "Enable tracing for RCU"
 	depends on DEBUG_KERNEL
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index be5979da07f5985..35816fbb4b82f17 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -224,6 +224,7 @@ extern int rcu_cpu_stall_ftrace_dump;
 extern int rcu_cpu_stall_suppress;
 extern int rcu_cpu_stall_timeout;
 extern int rcu_exp_cpu_stall_timeout;
+extern int rcu_cpu_stall_cputime;
 int rcu_jiffies_till_stall_check(void);
 int rcu_exp_jiffies_till_stall_check(void);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 93416afebd59c7a..3fcb17d7829ac8e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -931,6 +931,22 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
 		}
+
+		if (rcu_cpu_stall_cputime && rdp->snap_record.gp_seq != rdp->gp_seq) {
+			u64 *cpustat;
+			struct rcu_snap_record *rsrp;
+
+			cpustat = kcpustat_cpu(rdp->cpu).cpustat;
+
+			rsrp = &rdp->snap_record;
+			rsrp->cputime_irq     = cpustat[CPUTIME_IRQ];
+			rsrp->cputime_softirq = cpustat[CPUTIME_SOFTIRQ];
+			rsrp->cputime_system  = cpustat[CPUTIME_SYSTEM];
+			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
+			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
+			rsrp->nr_csw = nr_context_switches_cpu(rdp->cpu);
+			rsrp->gp_seq = rdp->gp_seq;
+		}
 	}
 
 	return 0;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d4a97e40ea9c3e2..44d49819a31f050 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -158,6 +158,22 @@ union rcu_noqs {
 	u16 s; /* Set of bits, aggregate OR here. */
 };
 
+/*
+ * Record the snapshot of the core stats at 1/2 rcu stall timeout. The member
+ * gp_seq is used to ensure that all members are updated only once during the
+ * second half period. The snapshot is taken only if this gp_seq is not equal
+ * to rdp->gp_seq.
+ */
+struct rcu_snap_record {
+	unsigned long	gp_seq;		/* Track rdp->gp_seq counter */
+	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
+	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
+	u64		cputime_system; /* Accumulated cputime of kernel tasks */
+	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
+	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */
+	unsigned long long nr_csw;	/* Accumulated number of task switches */
+};
+
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
@@ -262,6 +278,7 @@ struct rcu_data {
 	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
 	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
 	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
+	struct rcu_snap_record snap_record; /* Snapshot of core stats at 1/2 rcu stall timeout */
 
 	int cpu;
 };
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5653560573e22d6..2e560a70d88fd87 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -428,6 +428,35 @@ static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp
 	return j > 2 * HZ;
 }
 
+static void print_cpu_stat_info(int cpu)
+{
+	u64 *cpustat;
+	unsigned long half_timeout;
+	struct rcu_snap_record *rsrp;
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	if (!rcu_cpu_stall_cputime)
+		return;
+
+	rsrp = &rdp->snap_record;
+	if (rsrp->gp_seq != rdp->gp_seq)
+		return;
+
+	cpustat = kcpustat_cpu(cpu).cpustat;
+	half_timeout = rcu_jiffies_till_stall_check() / 2;
+
+	pr_err("         hardirqs   softirqs   csw/system\n");
+	pr_err(" number: %8ld %10d %12lld\n",
+		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
+		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
+		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
+	pr_err("cputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
+		div_u64(cpustat[CPUTIME_IRQ] - rsrp->cputime_irq, NSEC_PER_MSEC),
+		div_u64(cpustat[CPUTIME_SOFTIRQ] - rsrp->cputime_softirq, NSEC_PER_MSEC),
+		div_u64(cpustat[CPUTIME_SYSTEM] - rsrp->cputime_system, NSEC_PER_MSEC),
+		jiffies64_to_msecs(half_timeout));
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
index 738842c4886b235..aec76ccbe1e343b 100644
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

