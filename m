Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C39B5B2E55
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiIIFx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiIIFxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:53:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BCB7EC6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 22:53:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t3so838486ply.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 22:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vPktivqJGC+qoU4od3K/hUKJYk2Dc2La6EnCvynGgPk=;
        b=WQBswRlsj681cRVT/6sASrWRpNtu5QVfQGWYBNj5m/FL1ywVmLZJcNvSvBN0+5mQKV
         a4uvc1qsh5tu22C/AtCpQFgc3Yl6XEHg0JXhqTrRVcNyvmWHtBHngf0FH30p4TIJEEzR
         vR+WuevzHulCa7dZ19HQ8sM/F4qjfWIJGKdhnhLefuc0sALLGxPCyVUMQAlzYV7EJr3g
         2jGI6HEOS6+Mimzbr31rDqY2diQuV2fOqX9OExX3S2hKG+dzCS6OWpYXLJz79bEG5TWV
         wDILxrSlYJw92VawhsV1qgabLmCP7F+2YA08JNCMqD6phlols+rldnED/TdwaU4bwb/B
         0pGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vPktivqJGC+qoU4od3K/hUKJYk2Dc2La6EnCvynGgPk=;
        b=k3NiG8GSbjQwXnCCv/NdBRCs9eBFnprztlueEg3vckLs943KqZVs+fMyA4Z1zLmm9c
         IdZuAG46clmsSWyOv1qyH+7cVAnno7TGxpMUL/U3JszaHYebXPm3XupeEnRwDLCI5rSz
         6NWm3hegQE/jN1NoXzy4KEiWrQHT75A6m9bCwX6EEtXXUDVEJaqgcjKEtj6CWkQMYhgh
         O797vpg509ovWlLiKBXFVFFlydMz3BFEgx/hWeUeXLzTxC6ZUhuRz7KsKEdubZaaJ8jq
         j15CNvWE6TEWXCUjSVw4qemmF9x8BcNDZJ+BV1MQHni3l85V/+KNvIYETLyIrnU2YCp+
         W5JQ==
X-Gm-Message-State: ACgBeo1Y3ex0l0wyRYa05LXmynJnI5MX7PFuJENp0xyrtJQZQkOTODeK
        pdEpOiDkhJljzAb8YmzK9qjI5fJWfnNLOA==
X-Google-Smtp-Source: AA6agR5V5Yga9TnX2fbknEMZyNYLh3rYFTUWeHSxrBQ0bvVuaP60D1uamuywTZMXSG5iffu4HieNug==
X-Received: by 2002:a17:903:1c1:b0:175:4cf0:31e4 with SMTP id e1-20020a17090301c100b001754cf031e4mr12519109plh.95.1662702819063;
        Thu, 08 Sep 2022 22:53:39 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id y66-20020a636445000000b00421841943dfsm464380pgb.12.2022.09.08.22.53.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2022 22:53:38 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v5 5/5] sched/fair: Introduce SIS_FILTER
Date:   Fri,  9 Sep 2022 13:53:04 +0800
Message-Id: <20220909055304.25171-6-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909055304.25171-1-wuyun.abel@bytedance.com>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wakeup fastpath for fair tasks, select_idle_sibling() aka SIS,
plays an important role in maximizing the usage of cpu resources and
can greatly affect overall performance of the system.

The SIS tries to find an idle cpu inside the targeting LLC to place
the woken-up task. The cache hot cpus are preferred, but if none of
them is idle, just fallback to the other cpus of that LLC by firing
a domain scan.  The domain scan works well under light pressure by
simply traversing the cpus of the LLC due to lots of idle cpus can
be available.

But things change. The LLCs are getting bigger in modern and future
machines, and the cloud service providers are consistently trying to
reduce TCO by pushing more load squeezing all kinds of resources.
So the fashion of simply traversing doesn't fit well to the future
requirement.

There are already features like SIS_{UTIL,PROP} exist to cope with
the scalability issue by limiting the scan depth, and it would be
better if we can improve the way of how it scans as well. And this
is exactly what the SIS_FILTER is born for.

The SIS filter is supposed to contain the idle and sched-idle cpus
of the targeting LLC and try to improve efficiency of SIS domain scan
by filtering out busy cpus, making the limited scan depth being used
more wisely.

The idle cpus are propagated to the filter lazily if the resident
cores are already present in the filter. This will ease the pain of
LLC cache traffic, and can also bring benefit by spreading out load
to different cores.

There is also a sequence number to indicate the generation of the
filter. The generation iterates every time when the filter resets.
Once a cpu is propagated/set to the filter, the filter generation
is cached locally to help identify whether it is present or not in
the filter, rather than peeking at the LLC shared filter.

Benchmark
=========

Tests are done in a dual socket (2 x 24C/48T) machine modeled Intel
Xeon(R) Platinum 8260, with SNC configuration:

	SNC on:  4 NUMA nodes each of which has 12C/24T
	SNC off: 2 NUMA nodes each of which has 24C/48T

All of the benchmarks are done inside a normal cpu cgroup in a clean
environment with cpu turbo disabled.

Baseline is tip sched/core 0fba527e959d (v5.19.0) with the first two
patches of this series, and the "patched" contains the whole series.

Results
=======

hackbench-process-pipes
                         baseline		  patched
(SNC on)
Amean     1        0.4557 (   0.00%)      0.4500 (   1.24%)
Amean     4        0.6033 (   0.00%)      0.5990 (   0.72%)
Amean     7        0.7627 (   0.00%)      0.7377 (   3.28%)
Amean     12       1.0653 (   0.00%)      1.0490 (   1.53%)
Amean     21       2.0283 (   0.00%)      1.8680 *   7.90%*
Amean     30       2.9670 (   0.00%)      2.7710 *   6.61%*
Amean     48       4.6863 (   0.00%)      4.5393 (   3.14%)
Amean     79       7.9443 (   0.00%)      7.6610 *   3.57%*
Amean     110     10.2393 (   0.00%)     10.5560 (  -3.09%)
Amean     141     12.6343 (   0.00%)     12.6137 (   0.16%)
Amean     172     14.9957 (   0.00%)     14.6547 *   2.27%*
Amean     203     16.9133 (   0.00%)     16.9000 (   0.08%)
Amean     234     19.2433 (   0.00%)     18.7687 (   2.47%)
Amean     265     21.6917 (   0.00%)     21.4060 (   1.32%)
Amean     296     23.8743 (   0.00%)     23.0990 *   3.25%*
(SNC off)
Amean     1        0.3143 (   0.00%)      0.2933 (   6.68%)
Amean     4        0.6070 (   0.00%)      0.5883 (   3.08%)
Amean     7        0.7960 (   0.00%)      0.7570 (   4.90%)
Amean     12       1.1947 (   0.00%)      1.0780 *   9.77%*
Amean     21       2.4837 (   0.00%)      1.8903 *  23.89%*
Amean     30       3.4577 (   0.00%)      2.7903 *  19.30%*
Amean     48       5.5227 (   0.00%)      4.8920 (  11.42%)
Amean     79       9.2933 (   0.00%)      8.0127 *  13.78%*
Amean     110     11.0443 (   0.00%)     10.1557 *   8.05%*
Amean     141     13.1360 (   0.00%)     12.7387 (   3.02%)
Amean     172     15.7770 (   0.00%)     14.5860 *   7.55%*
Amean     203     17.9557 (   0.00%)     17.1950 *   4.24%*
Amean     234     20.4373 (   0.00%)     19.6763 *   3.72%*
Amean     265     23.6053 (   0.00%)     22.5557 (   4.45%)
Amean     296     25.6803 (   0.00%)     24.4273 *   4.88%*

Generally the result showed better improvement on larger LLCs. And with
load increases but not saturate the cpus (<30 groups), the benefit is
obvious, and even under extreme pressure the filter also helps squeeze
out some power (remember that the baseline has already included first
two patches).

tbench4 Throughput
                         baseline		  patched
(SNC on)
Hmean     1        301.54 (   0.00%)      302.52 *   0.32%*
Hmean     2        607.81 (   0.00%)      604.76 *  -0.50%*
Hmean     4       1210.64 (   0.00%)     1204.79 *  -0.48%*
Hmean     8       2381.73 (   0.00%)     2375.87 *  -0.25%*
Hmean     16      4601.21 (   0.00%)     4681.25 *   1.74%*
Hmean     32      7626.84 (   0.00%)     7607.93 *  -0.25%*
Hmean     64      9251.51 (   0.00%)     8956.00 *  -3.19%*
Hmean     128    20620.98 (   0.00%)    19258.30 *  -6.61%*
Hmean     256    20406.51 (   0.00%)    20783.82 *   1.85%*
Hmean     384    20312.97 (   0.00%)    20407.40 *   0.46%*
(SNC off)
Hmean     1        292.37 (   0.00%)      286.27 *  -2.09%*
Hmean     2        583.29 (   0.00%)      574.82 *  -1.45%*
Hmean     4       1155.83 (   0.00%)     1137.27 *  -1.61%*
Hmean     8       2297.63 (   0.00%)     2261.98 *  -1.55%*
Hmean     16      4562.44 (   0.00%)     4430.95 *  -2.88%*
Hmean     32      7425.69 (   0.00%)     7341.70 *  -1.13%*
Hmean     64      9021.77 (   0.00%)     8954.61 *  -0.74%*
Hmean     128    20257.76 (   0.00%)    20198.82 *  -0.29%*
Hmean     256    20043.54 (   0.00%)    19785.57 *  -1.29%*
Hmean     384    19528.03 (   0.00%)    19956.96 *   2.20%*

The slight regression indicates that if the workload has already had
a relatively high SIS success rate, e.g. tbench4 ~= 50%, the benefit
the filter brought will be reduced while its cost is still there. And
the benefit might not balance the cost if SIS success rate goes high
enough.

But the real world is more complicated. Different workloads can be
located on the same machine to share resources, and their profiles can
vary quite much, so the SIS success rate is not predictable.

Conclusion
==========

The SIS filter is much more efficient than linear scan under certain
circumstances, and even if it goes unlucky, the filter can be disabled
at any time.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/topology.h | 18 ++++++++
 kernel/sched/core.c            |  1 +
 kernel/sched/fair.c            | 83 ++++++++++++++++++++++++++++++++--
 kernel/sched/features.h        |  1 +
 kernel/sched/sched.h           |  3 ++
 kernel/sched/topology.c        |  9 +++-
 6 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index cc6089765b64..f8e6154b5c37 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -114,7 +114,20 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	enum sd_state	state;
+	u64		seq;
 	int		nr_idle_scan;
+
+	/*
+	 * The SIS filter
+	 *
+	 * Record idle and sched-idle cpus to improve efficiency of
+	 * the SIS domain scan.
+	 *
+	 * NOTE: this field is variable length. (Allocated dynamically
+	 * by attaching extra space to the end of the structure,
+	 * depending on how many CPUs the kernel has booted up with)
+	 */
+	unsigned long	icpus[];
 };
 
 struct sched_domain {
@@ -200,6 +213,11 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+static inline struct cpumask *sched_domain_icpus(struct sched_domain *sd)
+{
+	return to_cpumask(sd->shared->icpus);
+}
+
 extern void partition_sched_domains_locked(int ndoms_new,
 					   cpumask_var_t doms_new[],
 					   struct sched_domain_attr *dattr_new);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d289d87acf7..a0cbf6c0d540 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9719,6 +9719,7 @@ void __init sched_init(void)
 		rq->wake_stamp = jiffies;
 		rq->wake_avg_idle = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
+		rq->last_idle_seq = 0;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25df73c7e73c..354e6e646a7b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6262,6 +6262,57 @@ static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
 
+static inline u64 filter_seq(int cpu)
+{
+	struct sched_domain_shared *sds;
+
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds)
+		return READ_ONCE(sds->seq);
+
+	return 0;
+}
+
+static inline void filter_set_cpu(int cpu, int nr)
+{
+	struct sched_domain_shared *sds;
+
+	if (!sched_feat(SIS_FILTER))
+		return;
+
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds) {
+		cpu_rq(nr)->last_idle_seq = filter_seq(cpu);
+		set_bit(nr, sds->icpus);
+	}
+}
+
+static inline bool filter_test_cpu(int cpu, int nr)
+{
+	if (!sched_feat(SIS_FILTER))
+		return true;
+
+	return cpu_rq(nr)->last_idle_seq >= filter_seq(cpu);
+}
+
+static inline void filter_reset(int cpu)
+{
+	struct sched_domain_shared *sds;
+
+	if (!sched_feat(SIS_FILTER))
+		return;
+
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds) {
+		bitmap_zero(sds->icpus, nr_cpumask_bits);
+		/*
+		 * The seq field is racy but at least we can
+		 * use WRITE_ONCE() to prevent store tearing.
+		 */
+		WRITE_ONCE(sds->seq, filter_seq(cpu) + 1);
+	}
+}
+
 static inline void set_llc_state(int cpu, enum sd_state state)
 {
 	struct sched_domain_shared *sds;
@@ -6285,6 +6336,8 @@ static inline enum sd_state get_llc_state(int cpu, enum sd_state def)
 static inline void clear_idle_cpus(int cpu)
 {
 	set_llc_state(cpu, sd_is_busy);
+	if (sched_smt_active())
+		filter_reset(cpu);
 }
 
 static inline bool test_idle_cpus(int cpu)
@@ -6314,13 +6367,15 @@ void __update_idle_core(struct rq *rq)
 {
 	enum sd_state old, new = sd_has_icores;
 	int core = cpu_of(rq), cpu;
+	int exist;
 
 	if (rq->ttwu_pending)
 		return;
 
 	rcu_read_lock();
 	old = get_llc_state(core, sd_has_icores);
-	if (old == sd_has_icores)
+	exist = filter_test_cpu(core, core);
+	if (old == sd_has_icores && exist)
 		goto unlock;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
@@ -6329,11 +6384,26 @@ void __update_idle_core(struct rq *rq)
 
 		if (!available_idle_cpu(cpu)) {
 			new = sd_has_icpus;
-			break;
+
+			/*
+			 * If any cpu of this core has already
+			 * been set in the filter, then this
+			 * core is present and won't be missed
+			 * during SIS domain scan.
+			 */
+			if (exist)
+				break;
+			if (!sched_idle_cpu(cpu))
+				continue;
 		}
+
+		if (!exist)
+			exist = filter_test_cpu(core, cpu);
 	}
 
-	if (old != new)
+	if (!exist)
+		filter_set_cpu(core, core);
+	if (old != sd_has_icores && old != new)
 		set_llc_state(core, new);
 unlock:
 	rcu_read_unlock();
@@ -6447,8 +6517,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	if (!this_sd)
 		return -1;
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
-
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
 		unsigned long now = jiffies;
@@ -6496,6 +6564,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	if (sched_smt_active() && sched_feat(SIS_FILTER))
+		cpumask_and(cpus, sched_domain_icpus(sd), p->cpus_ptr);
+	else
+		cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		/*
 		 * This might get the has_idle_cores hint cleared for a
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..1bebdb87c2f4 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_FILTER, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b75ac74986fb..1fe1b152bc20 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1071,6 +1071,9 @@ struct rq {
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
 
+	/* Cached filter generation when setting this cpu */
+	u64			last_idle_seq;
+
 #ifdef CONFIG_HOTPLUG_CPU
 	struct rcuwait		hotplug_wait;
 #endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..01dccaca0fa8 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1641,6 +1641,13 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+		cpumask_copy(sched_domain_icpus(sd), sd_span);
+
+		/*
+		 * The cached per-cpu seq starts from 0, so initialize
+		 * filter seq to 1 to discard all cached cpu state.
+		 */
+		WRITE_ONCE(sd->shared->seq, 1);
 	}
 
 	sd->private = sdd;
@@ -2106,7 +2113,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;
-- 
2.37.3

