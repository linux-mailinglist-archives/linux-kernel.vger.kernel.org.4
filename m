Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ABA71562D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjE3HFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjE3HFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:05:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B87F4
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:05:06 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QVjyp169RzFqWW;
        Tue, 30 May 2023 15:02:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 15:04:32 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <tim.c.chen@linux.intel.com>,
        <yu.c.chen@intel.com>, <gautham.shenoy@amd.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <kprateek.nayak@amd.com>,
        <wuyun.abel@bytedance.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v8 2/2] sched/fair: Scan cluster before scanning LLC in wake-up path
Date:   Tue, 30 May 2023 15:02:53 +0800
Message-ID: <20230530070253.33306-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230530070253.33306-1-yangyicong@huawei.com>
References: <20230530070253.33306-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

For platforms having clusters like Kunpeng920, CPUs within the same cluster
have lower latency when synchronizing and accessing shared resources like
cache. Thus, this patch tries to find an idle cpu within the cluster of the
target CPU before scanning the whole LLC to gain lower latency. This
will be implemented in 3 steps in select_idle_sibling():
1. When the prev_cpu/recent_used_cpu are good wakeup candidates, use them
   if they're sharing cluster with the target CPU. Otherwise record them
   and do the scanning first.
2. Scanning the cluster prior to the LLC of the target CPU for an
   idle CPU to wakeup.
3. If no idle CPU found after scanning and the prev_cpu/recent_used_cpu
   can be used, use them.

Testing has been done on Kunpeng920 by pinning tasks to one numa and two
numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.

With this patch, We noticed enhancement on tbench and netperf within one
numa or cross two numa on 6.4-rc4:
tbench results (node 0):
            baseline                     patched
  1:        326.2337        372.0611 (   14.05%)
  4:       1311.0912       1467.6606 (   11.94%)
  8:       2635.7595       2919.4199 (   10.76%)
 16:       5280.4710       5881.6082 (   11.38%)
 32:      10013.8106      10295.7659 (    2.82%)
 64:       7866.9267       7990.9609 (    1.58%)
128:       6643.0075       6773.0634 (    1.96%)
tbench results (node 0-1):
            baseline                     patched
  1:        328.2215        371.8220 (   13.28%)
  4:       1318.7803       1463.8069 (   11.00%)
  8:       2610.1637       2890.8220 (   10.75%)
 16:       5191.1229       5608.0970 (    8.03%)
 32:       9255.6653      10312.0177 (   11.41%)
 64:      16053.9385      17516.5449 (    9.11%)
128:      14145.9979      14190.7678 (    0.32%)
netperf results TCP_RR (node 0):
            baseline                     patched
  1:      77045.1699      92320.0580 (   19.83%)
  4:      78419.5796      92010.5521 (   17.33%)
  8:      79044.9299      92154.7030 (   16.59%)
 16:      80559.1244      92531.6847 (   14.86%)
 32:      78005.1397      79176.5900 (    1.50%)
 64:      29246.8246      29312.8208 (    0.23%)
128:      12098.8488      12169.5650 (    0.58%)
netperf results TCP_RR (node 0-1):
            baseline                     patched
  1:      77614.5377      92504.7655 (   19.18%)
  4:      79324.3967      91717.0429 (   15.62%)
  8:      79281.3608      91807.1218 (   15.80%)
 16:      79064.0960      92004.1390 (   16.37%)
 32:      78033.7068      86588.8343 (   10.96%)
 64:      75946.3002      76128.3367 (    0.24%)
128:      28518.5077      27985.0884 (   -1.87%)
netperf results UDP_RR (node 0):
            baseline                     patched
  1:      93981.2392     105321.3925 (   12.07%)
  4:      94939.0909     104816.2619 (   10.40%)
  8:      96025.7748     105125.4418 (    9.48%)
 16:      96218.2809     104576.4454 (    8.69%)
 32:      80740.3541      83242.5556 (    3.10%)
 64:      30622.1298      30805.0830 (    0.60%)
128:      12369.6187      12659.8038 (    2.35%)
netperf results UDP_RR (node 0-1):
            baseline                     patched
  1:      94372.8042     105957.8761 (   12.28%)
  4:      92867.0020     103963.9574 (   11.95%)
  8:      92832.1536     103722.3126 (   11.73%)
 16:      93171.2927     103496.3700 (   11.08%)
 32:      76859.0806      95176.8247 (   23.83%)
 64:      53131.3217      77129.8854 (   45.17%)
128:      24055.1642      30826.3553 (   28.15%)

Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
in the code has not been tested but it supposed to work.

Chen Yu also noticed this will improve the performance of tbench and
netperf on a 24 CPUs Jacobsville machine, there are 4 CPUs in one
cluster sharing L2 Cache.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
[https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
Tested-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 51 +++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 10 ++++++++
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..b8c129ed8b47 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6994,6 +6994,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	if (static_branch_unlikely(&sched_cluster_active)) {
+		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
+
+		if (sdc) {
+			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
+				if (!cpumask_test_cpu(cpu, cpus))
+					continue;
+
+				if (has_idle_core) {
+					i = select_idle_core(p, cpu, cpus, &idle_cpu);
+					if ((unsigned int)i < nr_cpumask_bits)
+						return i;
+				} else {
+					if (--nr <= 0)
+						return -1;
+					idle_cpu = __select_idle_cpu(cpu, p);
+					if ((unsigned int)idle_cpu < nr_cpumask_bits)
+						return idle_cpu;
+				}
+			}
+			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
+		}
+	}
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -7001,7 +7025,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 				return i;
 
 		} else {
-			if (!--nr)
+			if (--nr <= 0)
 				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
@@ -7103,7 +7127,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	bool has_idle_core = false;
 	struct sched_domain *sd;
 	unsigned long task_util, util_min, util_max;
-	int i, recent_used_cpu;
+	int i, recent_used_cpu, prev_aff = -1;
 
 	/*
 	 * On asymmetric system, update task utilization because we will check
@@ -7130,8 +7154,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
-	    asym_fits_cpu(task_util, util_min, util_max, prev))
-		return prev;
+	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
+		if (cpus_share_lowest_cache(prev, target))
+			return prev;
+		prev_aff = prev;
+	}
 
 	/*
 	 * Allow a per-cpu kthread to stack with the wakee if the
@@ -7158,7 +7185,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
-		return recent_used_cpu;
+		if (cpus_share_lowest_cache(recent_used_cpu, target))
+			return recent_used_cpu;
+	} else {
+		recent_used_cpu = -1;
 	}
 
 	/*
@@ -7199,6 +7229,17 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	/*
+	 * For cluster machines which have lower sharing cache like L2 or
+	 * LLC Tag, we tend to find an idle CPU in the target's cluster
+	 * first. But prev_cpu or recent_used_cpu may also be a good candidate,
+	 * use them if possible when no idle CPU found in select_idle_cpu().
+	 */
+	if ((unsigned int)prev_aff < nr_cpumask_bits)
+		return prev_aff;
+	if ((unsigned int)recent_used_cpu < nr_cpumask_bits)
+		return recent_used_cpu;
+
 	return target;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 23dabfc3668b..5097f93b635f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1816,6 +1816,7 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
+extern struct static_key_false sched_cluster_active;
 
 static __always_inline bool sched_asym_cpucap_active(void)
 {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 2c4cc6c95a9a..69968ed9ffb9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -672,7 +672,9 @@ DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
+
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
+DEFINE_STATIC_KEY_FALSE(sched_cluster_active);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -2363,6 +2365,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	struct rq *rq = NULL;
 	int i, ret = -ENOMEM;
 	bool has_asym = false;
+	bool has_cluster = false;
 
 	if (WARN_ON(cpumask_empty(cpu_map)))
 		goto error;
@@ -2384,6 +2387,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
 
 			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
+			has_cluster |= sd->flags & SD_CLUSTER;
 
 			if (tl == sched_domain_topology)
 				*per_cpu_ptr(d.sd, i) = sd;
@@ -2494,6 +2498,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (has_asym)
 		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
+	if (has_cluster)
+		static_branch_inc_cpuslocked(&sched_cluster_active);
+
 	if (rq && sched_debug_verbose) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
@@ -2593,6 +2600,9 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
 	if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, cpu)))
 		static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
 
+	if (rcu_access_pointer(per_cpu(sd_cluster, cpu)))
+		static_branch_dec_cpuslocked(&sched_cluster_active);
+
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map)
 		cpu_attach_domain(NULL, &def_root_domain, i);
-- 
2.24.0

