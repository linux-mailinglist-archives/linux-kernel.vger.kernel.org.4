Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48997004F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbjELKLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbjELKLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:11:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80C3F11B66
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:11:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61EC9139F;
        Fri, 12 May 2023 03:11:30 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3638D3F5A1;
        Fri, 12 May 2023 03:10:44 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] sched/fair, cpufreq: Introduce 'runnable boosting'
Date:   Fri, 12 May 2023 12:10:29 +0200
Message-Id: <20230512101029.342823-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512101029.342823-1-dietmar.eggemann@arm.com>
References: <20230512101029.342823-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The responsiveness of the Per Entity Load Tracking (PELT) util_avg in
mobile devices is still considered too low for utilization changes
during task ramp-up.

In Android this manifests in the fact that the first frames of a UI
activity are very prone to be jankframes (a frame which doesn't meet
the required frame rendering time, e.g. 16ms@60Hz) since the CPU
frequency is normally low at this point and has to ramp up quickly.

The beginning of an UI activity is also characterized by the occurrence
of CPU contention, especially on little CPUs. Current little CPUs can
have an original CPU capacity of only ~ 150 which means that the actual
CPU capacity at lower frequency can even be much smaller.

Schedutil maps CPU util_avg into CPU frequency request via:

  util = effective_cpu_util(..., cpu_util_cfs(cpu), ...) ->
  util = map_util_perf(util) -> freq = map_util_freq(util, ...)

CPU contention for CFS tasks can be detected by the 'CPU runnable_avg >
util_avg' condition in cpu_util_cfs(..., boost) -> cpu_util(..., boost).
Schedutil activates 'runnable boosting' by setting the new parameter
'boost = 1'.

To be in sync with schedutil's CPU frequency selection, Energy Aware
Scheduling (EAS) also calls cpu_util(..., boost = 1) during max util
detection.

Moreover, 'runnable boosting' is also used in load-balance for busiest
CPU selection when the migration type is 'migrate_util', i.e. only at
sched domains which don't have the SD_SHARE_PKG_RESOURCES flag set.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c              |  2 +-
 kernel/sched/cpufreq_schedutil.c |  3 ++-
 kernel/sched/fair.c              | 29 ++++++++++++++++++-----------
 kernel/sched/sched.h             |  4 ++--
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 898fa3bc2765..8b776db1d24c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7441,7 +7441,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 
 unsigned long sched_cpu_util(int cpu)
 {
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu, 0), ENERGY_UTIL, NULL);
 }
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e3211455b203..3b902f533214 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -155,10 +155,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
+	unsigned long util = cpu_util_cfs(sg_cpu->cpu, 1);
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
-	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
+	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
 					  FREQUENCY_UTIL, NULL);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1220cfbee258..3a10fe5988d6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1800,7 +1800,7 @@ static void update_numa_stats(struct task_numa_env *env,
 
 		ns->load += cpu_load(rq);
 		ns->runnable += cpu_runnable(rq);
-		ns->util += cpu_util_cfs(cpu);
+		ns->util += cpu_util_cfs(cpu, 0);
 		ns->nr_running += rq->cfs.h_nr_running;
 		ns->compute_capacity += capacity_of(cpu);
 
@@ -6184,9 +6184,10 @@ static inline bool cpu_overutilized(int cpu)
 {
 	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
 	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
+	unsigned long util = cpu_util_cfs(cpu, 0);
 
 	/* Return true only if the utilization doesn't fit CPU's capacity */
-	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
+	return !util_fits_cpu(util, rq_util_min, rq_util_max, cpu);
 }
 
 static inline void update_overutilized_status(struct rq *rq)
@@ -7149,10 +7150,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  * Predicts what cpu_util(@cpu) would return if @p was removed from @cpu
  * (@dst_cpu = -1) or migrated to @dst_cpu.
  */
-static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
+static unsigned long
+cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 {
 	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
 	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
+	unsigned long runnable;
+
+	runnable = boost ? READ_ONCE(cfs_rq->avg.runnable_avg) : 0;
+	util = max(util, runnable);
 
 	/*
 	 * If @dst_cpu is -1 or @p migrates from @cpu to @dst_cpu remove its
@@ -7169,6 +7175,7 @@ static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
 		unsigned long util_est;
 
 		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+		util_est = max(util_est, runnable);
 
 		/*
 		 * During wake-up @p isn't enqueued yet and doesn't contribute
@@ -7239,9 +7246,9 @@ static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
  *
  * Return: (Estimated) utilization for the specified CPU.
  */
-unsigned long cpu_util_cfs(int cpu)
+unsigned long cpu_util_cfs(int cpu, int boost)
 {
-	return cpu_util(cpu, NULL, -1);
+	return cpu_util(cpu, NULL, -1, boost);
 }
 
 /*
@@ -7263,7 +7270,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
 		p = NULL;
 
-	return cpu_util(cpu, p, -1);
+	return cpu_util(cpu, p, -1, 0);
 }
 
 /*
@@ -7331,7 +7338,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	int cpu;
 
 	for_each_cpu(cpu, pd_cpus) {
-		unsigned long util = cpu_util(cpu, p, -1);
+		unsigned long util = cpu_util(cpu, p, -1, 0);
 
 		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
 	}
@@ -7355,7 +7362,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 
 	for_each_cpu(cpu, pd_cpus) {
 		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
-		unsigned long util = cpu_util(cpu, p, dst_cpu);
+		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
 		unsigned long cpu_util;
 
 		/*
@@ -7501,7 +7508,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
-			util = cpu_util(cpu, p, cpu);
+			util = cpu_util(cpu, p, cpu, 0);
 			cpu_cap = capacity_of(cpu);
 
 			/*
@@ -9443,7 +9450,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		unsigned long load = cpu_load(rq);
 
 		sgs->group_load += load;
-		sgs->group_util += cpu_util_cfs(i);
+		sgs->group_util += cpu_util_cfs(i, 0);
 		sgs->group_runnable += cpu_runnable(rq);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
@@ -10561,7 +10568,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 			break;
 
 		case migrate_util:
-			util = cpu_util_cfs(i);
+			util = cpu_util_cfs(i, 1);
 
 			/*
 			 * Don't try to pull utilization from a CPU with one
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f78c0f85cc76..b4706874eec1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2947,7 +2947,7 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 }
 
 
-extern unsigned long cpu_util_cfs(int cpu);
+extern unsigned long cpu_util_cfs(int cpu, int boost);
 
 static inline unsigned long cpu_util_rt(struct rq *rq)
 {
@@ -3037,7 +3037,7 @@ static inline bool uclamp_rq_is_capped(struct rq *rq)
 	if (!static_branch_likely(&sched_uclamp_used))
 		return false;
 
-	rq_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
+	rq_util = cpu_util_cfs(cpu_of(rq), 0) + cpu_util_rt(rq);
 	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
 
 	return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
-- 
2.25.1

