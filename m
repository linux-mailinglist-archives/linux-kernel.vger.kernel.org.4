Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8320B6045B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiJSMs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiJSMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:47:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD8B2D753
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:49 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id b5so16113262pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZgcfNdayfFXkcge4kHlidh3EZUZ+6CNq8c/La+Qf7c=;
        b=EN2G7ythNaQoql5lJ6kdcazc6m+WelLAL7ze6ZExNo9PAdeoHo6G9r7AGUNMf/TKoz
         yy1LhFnh2OJ+NSjy3CbBdG9LhQoFybqSCj8IDBQ2svmkqof1AaCCFtKHdBlEos2KI1cn
         ylLga1qosHEmiJQK1ErdOD3SzOPBmFbTHYZJT8s4wV8ay7HaEapkKF7NQHT+gwcVW47U
         +iDL5aQEqY1OJpuvU3MSpZVR+heP46DOzmPQtvpsynXkB82BIR1+bR3NUs6ar35O+4AE
         qpoN8lX86nLDlbu1MjEY+gDIR9AfASAAbZ/OzfqGvlDfydPSpbLfzrUqJN6oL5D+dsxG
         kEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZgcfNdayfFXkcge4kHlidh3EZUZ+6CNq8c/La+Qf7c=;
        b=gPH/EJGA/rWwEDzGiSRMkn6Ijup+eU8+rPIXh/h+5AC9ImBzOTMfLxNceUjy0+ckco
         NDBjQJ/C40AOQsCXwaS9544R0v6OsjWsAJhovLQVhOABEz1SM6wNcc9b1lonUNQmjtdK
         N+DjIjkAKojWsmWi1VcrTk6iQqjKS6fwQxSrANEP61r1MUupHhAJf+XjJ2GkdbkVKUdC
         lPvGbYBylxP8oFR3myChoUa4GUeN42BmrXO2aLkwMbYNPjzPIDo8TI4uqYApbhnEjQIA
         AXd0rYwswqEcalG9i/Tozt6W5IdjVWWLR1a3U72nvRTcNnDir8jFEbGL1gVR+puHv/Ad
         2oQw==
X-Gm-Message-State: ACrzQf2xLsWyq1e/8L5VVb+CYutFw3fWuMM9tmna0VAzzysFC9Kj/WVD
        BkaZLQozZmwAlEwRRC6l42x+1Q==
X-Google-Smtp-Source: AMsMyM4r0Iti8WBTjfp7ajEKsL6hS8vgg1wyYrDnUA6bN/atrWL4ZOio5TtH3D+EAU19As7GsY6+gQ==
X-Received: by 2002:a63:da4f:0:b0:43f:6af:74ed with SMTP id l15-20020a63da4f000000b0043f06af74edmr7142827pgj.290.1666182595892;
        Wed, 19 Oct 2022 05:29:55 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id c21-20020a63da15000000b00439c6a4e1ccsm9881825pgh.62.2022.10.19.05.29.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:29:55 -0700 (PDT)
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
Subject: [PATCH v6 4/4] sched/fair: Deal with SIS scan failures
Date:   Wed, 19 Oct 2022 20:28:59 +0800
Message-Id: <20221019122859.18399-5-wuyun.abel@bytedance.com>
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

When SIS_CORE is active, idle cpus are recorded into a cpumask at
CORE granule, and the SIS domain scan tries to locate an idle cpu
in this cpumask. So the quality of the cpumask matters. There are
generally two types of cpus that need to be dealt with:

 - False positive: the cpus that are present in the idle cpumask
   but is actually busy. This can be caused by task enqueuing to
   these cpus without removing from the cpumask immediately. To
   solve this, the cpumask needs to be shrinked if poor quality
   of the mask is observed.

 - True negative: the cpus that are idle but not show up in the
   idle cpumask. This is due to the rule of CORE granule update
   that these idle cpus will be ignored when their SMT siblings
   are already present in the idle cpumask.

According to the nature of the two type cpus and some heuristics,
the strategies against SIS scan failures are as follows:

 - It can be predicted that if a scan fails, the next scan from the
   same cpu will probably fail too. So mark these cpus fail-prone.
   A scan from fail-prone cpu is the time to shrink the cpumask.

 - All true negative cpus are the SMT siblings of the false positive
   cpus, and are taken for granted to be treated as the fallbacks of
   the false positive cpus. So a fail-prone scan should also check
   the SMT siblings to see if any true negative cpu exists.

The number of false positive cpus being removed during one scan is
not constrained, but it will be implicitly constrained by the load
of the LLC. If LLC is under heavy pressure, both the weight of idle
cpumask and the scan depth are reduced, so does the number of cpus
removed.

To sum up, this patch marks the cpus fail-prone if scans from them
failed last time, so next time scanning from them will also check
their SMT siblings to see if any true negative cpus available. The
false positive cpus will be removed during fail-prone scans if its
belonging core is fully busy.

Benchmark
=========

All of the benchmarks are done inside a normal cpu cgroup in a clean
environment with cpu turbo disabled, and test machines are:

A) A dual socket machine modeled Intel Xeon(R) Platinum 8260 with SNC
disabled, so there are 2 NUMA nodes each of which has 24C/48T. Each
NUMA shares an LLC.

B) A dual socket machine modeled AMD EPYC 7Y83 64-Core Processor with
NPS1 enabled, so there are 2 NUMA nodes each of which has 64C/128T.
Each NUMA node contains several LLCs sized of 16 cpus.

The 'baseline' is based on tip sched/core fb04563d1cae (v5.19.0) with
the first 2 patches of this series applied. While 'sis_core' includes
the whole patchset.

Results
=======

hackbench-process-pipes
 (A)			baseline		sis_core
Amean     1        0.2540 (   0.00%)      0.2533 (   0.26%)
Amean     4        0.6220 (   0.00%)      0.5993 (   3.64%)
Amean     7        0.8020 (   0.00%)      0.7663 *   4.45%*
Amean     12       1.1823 (   0.00%)      1.1037 *   6.65%*
Amean     21       2.7717 (   0.00%)      2.2203 *  19.89%*
Amean     30       5.1200 (   0.00%)      3.7133 *  27.47%*
Amean     48       8.5890 (   0.00%)      7.0863 *  17.50%*
Amean     79      11.2580 (   0.00%)     10.3717 *   7.87%*
Amean     110     13.1283 (   0.00%)     12.4133 *   5.45%*
Amean     141     15.5967 (   0.00%)     14.4883 *   7.11%*
Amean     172     18.1153 (   0.00%)     17.2557 *   4.75%*
Amean     203     21.1340 (   0.00%)     20.2807 (   4.04%)
Amean     234     23.8227 (   0.00%)     22.8510 (   4.08%)
Amean     265     26.8293 (   0.00%)     25.7367 *   4.07%*
Amean     296     29.5800 (   0.00%)     28.7847 (   2.69%)
 (B)
Amean     1        0.3650 (   0.00%)      0.3510 (   3.84%)
Amean     4        0.4837 (   0.00%)      0.4753 (   1.72%)
Amean     7        0.4997 (   0.00%)      0.5073 (  -1.53%)
Amean     12       0.5863 (   0.00%)      0.5807 (   0.97%)
Amean     21       0.8930 (   0.00%)      0.8953 (  -0.26%)
Amean     30       1.2530 (   0.00%)      1.2633 (  -0.82%)
Amean     48       1.9743 (   0.00%)      1.9023 (   3.65%)
Amean     79       3.4933 (   0.00%)      3.2820 (   6.05%)
Amean     110      5.5963 (   0.00%)      5.3923 (   3.65%)
Amean     141      7.6550 (   0.00%)      6.8633 (  10.34%)
Amean     172      8.8323 (   0.00%)      8.2973 *   6.06%*
Amean     203     10.8683 (   0.00%)      9.5170 *  12.43%*
Amean     234     11.8683 (   0.00%)     10.6217 (  10.50%)
Amean     265     13.4717 (   0.00%)     11.9357 *  11.40%*
Amean     296     13.8130 (   0.00%)     12.7430 *   7.75%*

The results on machine A can approximately divided into 3 sections:
 - busy, e.g. <21 groups
 - overloaded, e.g. 21~48 groups
 - saturated, the rest part

The two cases of 296 groups in B and 110 groups in A have same amount
of tasks per cpu. So does 30 groups in B and 12 groups in A. So the
sections on A also apply to B, except that B only has the first two.
This implies that this feature seems to have consistant behaviour on
LLCs with different sizes.

For the busy part the result is neutral with slight wins or loss.
It's not hard to find an idle cpu in such case, so SIS_CORE doesn't
outperform the linear scanner, considering the cpumask is maintained
at a cost which will negate the slight benefit.

Once load increases, SIS_CORE helps improving the throughput quite a
lot by squeezing out the hidden capacity of the cpus. And even under
extreme load pressure when the cpu capacity is almost fully utilized,
there is still some can be exploited.

Although it is unlikely to be such loaded in the real world, the long
running workloads like training jobs can also keep cpus busy and can
benefit from this feature a lot.

netperf
 (A-udp)		    baseline		   sis_core
Hmean     send-64         214.34 (   0.00%)      210.79 *  -1.65%*
Hmean     send-128        427.90 (   0.00%)      417.96 *  -2.32%*
Hmean     send-256        839.65 (   0.00%)      823.78 *  -1.89%*
Hmean     send-1024      3207.45 (   0.00%)     3167.96 *  -1.23%*
Hmean     send-2048      6097.24 (   0.00%)     6089.01 (  -0.13%)
Hmean     send-3312      9350.83 (   0.00%)     9299.09 (  -0.55%)
Hmean     send-4096     11368.25 (   0.00%)    11186.44 *  -1.60%*
Hmean     send-8192     18273.21 (   0.00%)    18103.81 (  -0.93%)
Hmean     send-16384    28207.81 (   0.00%)    28259.82 (   0.18%)
 (B-udp)
Hmean     send-64         249.97 (   0.00%)      256.99 *   2.81%*
Hmean     send-128        500.68 (   0.00%)      514.44 *   2.75%*
Hmean     send-256        991.59 (   0.00%)     1017.38 *   2.60%*
Hmean     send-1024      3913.02 (   0.00%)     3982.68 *   1.78%*
Hmean     send-2048      7627.99 (   0.00%)     7590.30 (  -0.49%)
Hmean     send-3312     11907.07 (   0.00%)    12114.03 *   1.74%*
Hmean     send-4096     14300.09 (   0.00%)    14753.34 *   3.17%*
Hmean     send-8192     24576.21 (   0.00%)    25431.42 *   3.48%*
Hmean     send-16384    42105.89 (   0.00%)    41813.30 (  -0.69%)
 (A-tcp)
Hmean     64        1191.91 (   0.00%)     1220.47 *   2.40%*
Hmean     128       2318.60 (   0.00%)     2354.56 (   1.55%)
Hmean     256       4267.41 (   0.00%)     4226.72 (  -0.95%)
Hmean     1024     13190.66 (   0.00%)    13065.91 (  -0.95%)
Hmean     2048     20466.22 (   0.00%)    20704.66 (   1.17%)
Hmean     3312     24363.57 (   0.00%)    24613.99 *   1.03%*
Hmean     4096     26144.44 (   0.00%)    26204.24 (   0.23%)
Hmean     8192     30387.77 (   0.00%)    30703.65 *   1.04%*
Hmean     16384    34942.71 (   0.00%)    34205.44 *  -2.11%*
 (B-tcp)
Hmean     64        1971.18 (   0.00%)     2120.61 *   7.58%*
Hmean     128       3752.96 (   0.00%)     3995.68 *   6.47%*
Hmean     256       6861.58 (   0.00%)     7342.93 *   7.02%*
Hmean     1024     21966.06 (   0.00%)    23725.30 *   8.01%*
Hmean     2048     33949.66 (   0.00%)    35620.67 *   4.92%*
Hmean     3312     40681.75 (   0.00%)    41543.26 *   2.12%*
Hmean     4096     44309.70 (   0.00%)    45390.03 *   2.44%*
Hmean     8192     50909.35 (   0.00%)    52157.16 *   2.45%*
Hmean     16384    57198.37 (   0.00%)    57686.96 (   0.85%)

The netperf has an almost 100% success rate on used target, prev or
recent cpus, so the domain scan is generally not performed. This test
is to see how much overhead of maintaining the idle cpumask and the
result is neutral, which sounds like the overhead is acceptable.

tbench4 Throughput
 (A)			baseline		sis_core
Hmean     1        280.53 (   0.00%)      289.44 *   3.17%*
Hmean     2        561.94 (   0.00%)      571.46 *   1.69%*
Hmean     4       1109.14 (   0.00%)     1129.88 *   1.87%*
Hmean     8       2229.39 (   0.00%)     2266.52 *   1.67%*
Hmean     16      4383.06 (   0.00%)     4473.48 *   2.06%*
Hmean     32      7124.14 (   0.00%)     7223.83 *   1.40%*
Hmean     64      8815.41 (   0.00%)     8770.21 *  -0.51%*
Hmean     128    19519.35 (   0.00%)    20337.24 *   4.19%*
Hmean     256    19392.24 (   0.00%)    20052.98 *   3.41%*
Hmean     384    19201.07 (   0.00%)    19563.63 *   1.89%*
 (B)
Hmean     1         515.98 (   0.00%)      499.91 *  -3.12%*
Hmean     2        1031.54 (   0.00%)     1044.38 *   1.24%*
Hmean     4        1953.44 (   0.00%)     1959.30 *   0.30%*
Hmean     8        3622.52 (   0.00%)     3773.08 *   4.16%*
Hmean     16       6545.82 (   0.00%)     6814.46 *   4.10%*
Hmean     32      13697.73 (   0.00%)    13078.74 *  -4.52%*
Hmean     64      25589.59 (   0.00%)    24576.52 *  -3.96%*
Hmean     128     35667.64 (   0.00%)    37590.20 *   5.39%*
Hmean     256     65215.85 (   0.00%)    64921.74 *  -0.45%*
Hmean     512     66035.57 (   0.00%)    63812.48 *  -3.37%*
Hmean     1024    53391.64 (   0.00%)    62356.50 *  16.79%*

Like netperf, tbench4 benchmark also has a high success rate ~39% on
the cache hot cpus, and the SIS overall success rate is ~45%. This
benchmark runs a fast idling workload and makes the SIS idle cpumask
quite unstable, which is a disaster to this feature. Even so, not
much but still some improvement can be seen from the result.

Conclusion
==========

The overhead of maintaining the idle cpumasks seems acceptable, and
this cost can trade for considerable throughput improvement once LLC
becomes busier in which case less idle cpus are available.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c  | 74 +++++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h |  3 ++
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3aa699e9d4af..d06d59ac2f05 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6309,6 +6309,16 @@ static void update_idle_cpu(int cpu)
 	}
 }
 
+static inline bool should_scan_sibling(int cpu)
+{
+	return cmpxchg(&cpu_rq(cpu)->sis_scan_sibling, 1, 0);
+}
+
+static inline void set_scan_sibling(int cpu)
+{
+	WRITE_ONCE(cpu_rq(cpu)->sis_scan_sibling, 1);
+}
+
 /*
  * Scans the local SMT mask to see if the entire core is idle, and records this
  * information in sd_llc_shared->has_idle_cores.
@@ -6384,17 +6394,20 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, int target)
+static int select_idle_smt(struct task_struct *p, int core, struct cpumask *cpus, int exclude)
 {
 	int cpu;
 
-	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
-		if (cpu == target)
+	for_each_cpu_and(cpu, cpu_smt_mask(core), p->cpus_ptr) {
+		if (exclude && cpu == core)
 			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
 	}
 
+	if (cpus)
+		cpumask_clear_cpu(core, cpus);
+
 	return -1;
 }
 
@@ -6409,12 +6422,21 @@ static inline bool test_idle_cores(int cpu)
 	return false;
 }
 
+static inline bool should_scan_sibling(int cpu)
+{
+	return false;
+}
+
+static inline void set_scan_sibling(int cpu)
+{
+}
+
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, int core, struct cpumask *cpus, int exclude)
 {
 	return -1;
 }
@@ -6434,6 +6456,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
 	struct sched_domain *this_sd = NULL;
+	bool scan_sibling = false;
 	u64 time = 0;
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
@@ -6479,20 +6502,31 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
-	if (sched_feat(SIS_CORE) && sched_smt_active())
+	if (sched_feat(SIS_CORE) && sched_smt_active()) {
+		/*
+		 * Due to the nature of idle core scanning, has_idle_core
+		 * hint should also consume the scan_sibling flag even
+		 * though it doesn't use the flag when scanning.
+		 */
+		scan_sibling = should_scan_sibling(target);
 		icpus = sched_domain_icpus(sd);
+	}
 
 	cpumask_and(cpus, icpus ? icpus : sched_domain_span(sd), p->cpus_ptr);
 
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
+		if (!--nr)
+			break;
+
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
-
+		} else if (scan_sibling) {
+			idle_cpu = select_idle_smt(p, cpu, icpus, 0);
+			if ((unsigned int)idle_cpu < nr_cpumask_bits)
+				break;
 		} else {
-			if (!--nr)
-				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
@@ -6503,9 +6537,25 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		set_idle_cores(target, false);
 
 	if (icpus && idle_cpu == -1) {
-		/* Reset the idle cpu mask if a full scan fails */
-		if (nr > 0)
-			cpumask_clear(icpus);
+		if (nr > 0 && (has_idle_core || scan_sibling)) {
+			/*
+			 * Reset the idle cpu mask if a full scan fails,
+			 * but ignore the !has_idle_core case which should
+			 * have already been fixed during scan.
+			 */
+			if (has_idle_core)
+				cpumask_clear(icpus);
+		} else {
+			/*
+			 * As for partial scan failures, it will probably
+			 * fail again next time scanning from the same cpu.
+			 * Due to the SIS_CORE rule of CORE granule update,
+			 * some idle cpus can be missed in the mask. So it
+			 * would be reasonable to scan SMT siblings as well
+			 * if the scan is fail-prone.
+			 */
+			set_scan_sibling(target);
+		}
 	}
 
 	if (sched_feat(SIS_PROP) && this_sd && !has_idle_core) {
@@ -6657,7 +6707,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, prev);
+			i = select_idle_smt(p, prev, NULL, 1);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1fc198be1ffd..c7f8ed5021e6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -971,6 +971,9 @@ struct rq {
 
 #ifdef CONFIG_SMP
 	unsigned int		ttwu_pending;
+#ifdef CONFIG_SCHED_SMT
+	int			sis_scan_sibling;
+#endif
 #endif
 	u64			nr_switches;
 
-- 
2.37.3

