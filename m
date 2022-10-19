Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759AB6045BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiJSMsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiJSMr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:47:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C77677
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id l1so17068667pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b833A5Qsan0f1SmZzQdaOcnrkCwR8FuKT3y3L+uSymQ=;
        b=WElDJ3m+gbu/8yW1wMY5/NQQpGk5O6qWPJ7IXza5ac6pMQSh+lfcyWuSS1azUMNNbI
         iEEA9LVKPTDZbtNMQQjhKqwSngFIk5ZFmvU6YnyAoPyTqkL6hbac1H/XY4u7SFKxNS3d
         8dGtuILcsMW4ONrvg6ZrQVWBh+GEeeM/ZdsZfy7DuEulns/ueDeN4u946vhXxU+APxMQ
         H9ryMcesDUP56D7vwavxgTzr7tsXKCjLI9YUxEoHZ3JUdPGMJEfQX7+6o5JbWd+5wQeG
         3jZoTU/xMDseD+DmCaUSv7ikidruz6TuJ2ncwfpzk/AiLUkRI0j66vgqAKp89l7FUalE
         QNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b833A5Qsan0f1SmZzQdaOcnrkCwR8FuKT3y3L+uSymQ=;
        b=4w+33OJHqMNPTc8ySslCXc44n26iBUxlmpkVlBUdRznNRqulCejeXdH0Ts0YWWT0ft
         TvTg5S9J4+7shAvHmuJSdNYnAdBi+WOdt5oiLCmERRVCJxuRxnhsg9yTO05/aIrRN5We
         P5JRFYI3pNczWp9kH5dt7ieVExq3kP3NnaOVPgS5T68D417GZTHhX6fsDDzB31ftMjTE
         8csMSAFOb+HHYXvKu+jd3jSEYWitfkTAAhNgoh1OC5Mm/xmc3tv8AoLGUkYx0jfsl6FM
         eezK8SPYVkwyzavBFSifDQRj2Snp2JYhAq+TCCAinDELaAyTrVp/27MlQ0kQDQsoVyZN
         ZLEQ==
X-Gm-Message-State: ACrzQf20rA/eYLrI/gQJ4FH/CmmHedbcaBfMV+szP7782M5GsWqQsPYr
        9V2OW3xqqiKoiYQsG7cKiKGBiw==
X-Google-Smtp-Source: AMsMyM7dWsRnybs0mUt0ACL1XY4OGyxjSgp5UlXHTSgoO5MKtycbnzcRNidCuJTnqyQl4W3V5BizVg==
X-Received: by 2002:a17:902:e848:b0:180:c732:1e52 with SMTP id t8-20020a170902e84800b00180c7321e52mr8378443plg.83.1666182589286;
        Wed, 19 Oct 2022 05:29:49 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id c21-20020a63da15000000b00439c6a4e1ccsm9881825pgh.62.2022.10.19.05.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:29:49 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v6 3/4] sched/fair: Introduce SIS_CORE
Date:   Wed, 19 Oct 2022 20:28:58 +0800
Message-Id: <20221019122859.18399-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019122859.18399-1-wuyun.abel@bytedance.com>
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
them is idle, a domain scan is fired to check the other cpus of that
LLC. It currently scans in linear fashion, and it works well under
light pressure due to lots of idle cpus can be available.

But things change. The LLC is getting bigger in modern and future
machines, and players like cloud service providers are continuously
trying to use all kinds of resources more efficiently to reduce TCO.
In either case, locating an idle cpu is no longer as easy as before.
So the linear scan doesn't fit well in such cases.

There are already features like SIS_{UTIL,PROP} exist to deal with
the scalability issue by limiting the scan depth, and it would be
better if we can improve the way how it scans as well. And this is
exactly what the SIS_CORE is born for.

When SIS_CORE is enabled, a cpumask containing idle cpus for each
LLC is maintained and stored in each LLC shared domain. The idle
cpus are recorded at CORE granule, so in theory only one idle cpu
of a CORE can be set to the mask. The ideas behind this:

 - Recording idle cpus is to narrow down the SIS scan, so we can
   avoid touching the runqueues that must be in a busy state, as
   we all know that the runqueues are one of the most hot data in
   the system. And because all the possibly idle cpus are in the
   mask, the hint of has_idle_core still works.

 - The rule of CORE granule update helps spreading load out to
   different cores trying to make better use of cpu capacity.

A major concern is the accuracy of the idle cpumask. A cpu present
in the mask might not be idle any more, which is called the false
positive cpu. Such cpus will negate lots of benefit this feature
brings. The strategy against the false positives will be introduced
in next patch.

Another concern is the overhead of accessing the LLC-shared cpumask,
which can be more severe in large LLCs. But a perf stat on cache
miss rate during hackbench doesn't show obvious difference.

This patch records idle cpus when they goes idle at CORE granule for
each LLC, and the cpumask is in LLC shared domain. The false positive
cpus are cleared when SIS domain scan fails.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/topology.h | 15 ++++++++++
 kernel/sched/fair.c            | 51 +++++++++++++++++++++++++++++++---
 kernel/sched/features.h        |  7 +++++
 kernel/sched/topology.c        |  8 +++++-
 4 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 816df6cc444e..ac2162f33ada 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -82,6 +82,16 @@ struct sched_domain_shared {
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
 	int		nr_idle_scan;
+
+	/*
+	 * Used by sched feature SIS_CORE to record idle cpus at core
+	 * granule to improve efficiency of SIS domain scan.
+	 *
+	 * NOTE: this field is variable length. (Allocated dynamically
+	 * by attaching extra space to the end of the structure,
+	 * depending on how many CPUs the kernel has booted up with)
+	 */
+	unsigned long	icpus[];
 };
 
 struct sched_domain {
@@ -167,6 +177,11 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
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
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7b668e16812e..3aa699e9d4af 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6282,6 +6282,33 @@ static inline bool test_idle_cores(int cpu)
 	return false;
 }
 
+/*
+ * To honor the rule of CORE granule update, set this cpu to the LLC idle
+ * cpumask only if there is no cpu of this core showed up in the cpumask.
+ */
+static void update_idle_cpu(int cpu)
+{
+	struct sched_domain_shared *sds;
+
+	if (!sched_feat(SIS_CORE))
+		return;
+
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds) {
+		struct cpumask *icpus = to_cpumask(sds->icpus);
+
+		/*
+		 * This is racy against clearing in select_idle_cpu(),
+		 * and can lead to idle cpus miss the chance to be set to
+		 * the idle cpumask, thus the idle cpus are temporarily
+		 * out of reach in SIS domain scan. But it should be rare
+		 * and we still have ILB to kick them working.
+		 */
+		if (!cpumask_intersects(cpu_smt_mask(cpu), icpus))
+			cpumask_set_cpu(cpu, icpus);
+	}
+}
+
 /*
  * Scans the local SMT mask to see if the entire core is idle, and records this
  * information in sd_llc_shared->has_idle_cores.
@@ -6298,6 +6325,7 @@ void __update_idle_core(struct rq *rq)
 		return;
 
 	rcu_read_lock();
+	update_idle_cpu(core);
 	if (test_idle_cores(core))
 		goto unlock;
 
@@ -6343,7 +6371,13 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	if (idle)
 		return core;
 
-	cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
+	/*
+	 * It is unlikely that more than one cpu of a core show up
+	 * in the @cpus if SIS_CORE enabled.
+	 */
+	if (!sched_feat(SIS_CORE))
+		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
+
 	return -1;
 }
 
@@ -6394,7 +6428,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
  */
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask), *icpus = NULL;
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct sched_domain_shared *sd_share;
 	struct rq *this_rq = this_rq();
@@ -6402,8 +6436,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	struct sched_domain *this_sd = NULL;
 	u64 time = 0;
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
-
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
 		unsigned long now = jiffies;
@@ -6447,6 +6479,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	if (sched_feat(SIS_CORE) && sched_smt_active())
+		icpus = sched_domain_icpus(sd);
+
+	cpumask_and(cpus, icpus ? icpus : sched_domain_span(sd), p->cpus_ptr);
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -6465,6 +6502,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	if (has_idle_core)
 		set_idle_cores(target, false);
 
+	if (icpus && idle_cpu == -1) {
+		/* Reset the idle cpu mask if a full scan fails */
+		if (nr > 0)
+			cpumask_clear(icpus);
+	}
+
 	if (sched_feat(SIS_PROP) && this_sd && !has_idle_core) {
 		time = cpu_clock(this) - time;
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..bf3cae94caa6 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -63,6 +63,13 @@ SCHED_FEAT(TTWU_QUEUE, true)
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
 
+/*
+ * Record idle cpus at core granule for each LLC to improve efficiency of
+ * SIS domain scan. Combine with the above features of limiting scan depth
+ * to better deal with the scalability issue.
+ */
+SCHED_FEAT(SIS_CORE, true)
+
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
  * in a single rq->lock section. Default disabled because the
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..a2bb0091c10d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1641,6 +1641,12 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+
+		/*
+		 * This will temporarily break the rule of CORE granule,
+		 * but will be fixed after SIS scan failures.
+		 */
+		cpumask_copy(sched_domain_icpus(sd), sd_span);
 	}
 
 	sd->private = sdd;
@@ -2106,7 +2112,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;
-- 
2.37.3

