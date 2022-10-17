Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D8A600BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJQKB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiJQKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:01:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C3F52087;
        Mon, 17 Oct 2022 03:01:53 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MrXZy6DZHzHw1s;
        Mon, 17 Oct 2022 18:01:46 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 18:01:34 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 18:01:34 +0800
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
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 3/3] rcu: Add RCU stall diagnosis information
Date:   Mon, 17 Oct 2022 18:01:08 +0800
Message-ID: <20221017100108.2063-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221017100108.2063-1-thunder.leizhen@huawei.com>
References: <20221017100108.2063-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/rcu/tree.h       | 11 +++++++++++
 kernel/rcu/tree_stall.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d4a97e40ea9c3e2..fb3121d15cca6f8 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -158,6 +158,16 @@ union rcu_noqs {
 	u16 s; /* Set of bits, aggregate OR here. */
 };
 
+struct rcu_snap_record {
+	unsigned long	gp_seq;
+	u64		cputime_irq;
+	u64		cputime_softirq;
+	u64		cputime_system;
+	unsigned int	nr_hardirqs;
+	unsigned int	nr_softirqs;
+	unsigned long long nr_csw;
+};
+
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
@@ -262,6 +272,7 @@ struct rcu_data {
 	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
 	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
 	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
+	struct rcu_snap_record snap_record;
 
 	int cpu;
 };
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5653560573e22d6..08cfcf526f7d245 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -211,8 +211,10 @@ static void rcu_stall_kick_kthreads(void)
  */
 static void rcu_iw_handler(struct irq_work *iwp)
 {
+	int cpu = smp_processor_id();
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
+	struct rcu_snap_record *r;
 
 	rdp = container_of(iwp, struct rcu_data, rcu_iw);
 	rnp = rdp->mynode;
@@ -222,6 +224,16 @@ static void rcu_iw_handler(struct irq_work *iwp)
 		rdp->rcu_iw_pending = false;
 	}
 	raw_spin_unlock_rcu_node(rnp);
+
+	r = &rdp->snap_record;
+	r->cputime_irq     = kcpustat_this_cpu->cpustat[CPUTIME_IRQ];
+	r->cputime_softirq = kcpustat_this_cpu->cpustat[CPUTIME_SOFTIRQ];
+	r->cputime_system  = kcpustat_this_cpu->cpustat[CPUTIME_SYSTEM];
+	r->nr_hardirqs = kstat_cpu_irqs_sum(cpu);
+	r->nr_softirqs = kstat_cpu_softirqs_sum(cpu);
+	r->nr_csw = nr_context_switches_cpu(cpu);
+	barrier();
+	r->gp_seq = rdp->gp_seq;
 }
 
 //////////////////////////////////////////////////////////////////////////////
@@ -428,6 +440,32 @@ static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp
 	return j > 2 * HZ;
 }
 
+static void print_cpu_stat_info(int cpu)
+{
+	u64 *cpustat;
+	unsigned long half_timeout;
+	struct rcu_snap_record *r;
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	r = &rdp->snap_record;
+	if (r->gp_seq != rdp->gp_seq)
+		return;
+
+	cpustat = kcpustat_this_cpu->cpustat;
+	half_timeout = rcu_jiffies_till_stall_check() / 2;
+
+	pr_err("         hardirqs   softirqs   csw/system\n");
+	pr_err(" number: %8d %10d %12lld\n",
+		kstat_cpu_irqs_sum(cpu) - r->nr_hardirqs,
+		kstat_cpu_softirqs_sum(cpu) - r->nr_softirqs,
+		nr_context_switches_cpu(cpu) - r->nr_csw);
+	pr_err("cputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
+		div_u64(cpustat[CPUTIME_IRQ] - r->cputime_irq, NSEC_PER_MSEC),
+		div_u64(cpustat[CPUTIME_SOFTIRQ] - r->cputime_softirq, NSEC_PER_MSEC),
+		div_u64(cpustat[CPUTIME_SYSTEM] - r->cputime_system, NSEC_PER_MSEC),
+		jiffies64_to_msecs(half_timeout));
+}
+
 /*
  * Print out diagnostic information for the specified stalled CPU.
  *
@@ -484,6 +522,8 @@ static void print_cpu_stall_info(int cpu)
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       rcuc_starved ? buf : "",
 	       falsepositive ? " (false positive?)" : "");
+
+	print_cpu_stat_info(cpu);
 }
 
 /* Complain about starvation of grace-period kthread.  */
-- 
2.25.1

