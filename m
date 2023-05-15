Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC07702C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbjEOMNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbjEOMM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:12:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E12C41A6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:12:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB2EEFEC;
        Mon, 15 May 2023 04:58:39 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7568B3F7BD;
        Mon, 15 May 2023 04:57:53 -0700 (PDT)
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
Subject: [PATCH v3 2/2] sched/fair, cpufreq: Introduce 'runnable boosting'
Date:   Mon, 15 May 2023 13:57:35 +0200
Message-Id: <20230515115735.296329-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515115735.296329-1-dietmar.eggemann@arm.com>
References: <20230515115735.296329-1-dietmar.eggemann@arm.com>
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

CPU contention for CFS tasks can be detected by 'CPU runnable > CPU
utililization' in cpu_util_cfs_boost() -> cpu_util(..., boost = 1).
Schedutil uses 'runnable boosting' by calling cpu_util_cfs_boost().

To be in sync with schedutil's CPU frequency selection, Energy Aware
Scheduling (EAS) also calls cpu_util(..., boost = 1) during max util
detection.

Moreover, 'runnable boosting' is also used in load-balance for busiest
CPU selection when the migration type is 'migrate_util', i.e. only at
sched domains which don't have the SD_SHARE_PKG_RESOURCES flag set.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/cpufreq_schedutil.c |  3 ++-
 kernel/sched/fair.c              | 38 +++++++++++++++++++++++++-------
 kernel/sched/sched.h             |  1 +
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e3211455b203..4492608b7d7f 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -155,10 +155,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
+	unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu);
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
-	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
+	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
 					  FREQUENCY_UTIL, NULL);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9874e28d5e38..3b5b6186f2b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7150,6 +7150,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  * @cpu: the CPU to get the utilization for
  * @p: task for which the CPU utilization should be predicted or NULL
  * @dst_cpu: CPU @p migrates to, -1 if @p moves from @cpu or @p == NULL
+ * @boost: 1 to enable boosting, otherwise 0
  *
  * The unit of the return value must be the same as the one of CPU capacity
  * so that CPU utilization can be compared with CPU capacity.
@@ -7167,6 +7168,12 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  * be when a long-sleeping task wakes up. The contribution to CPU utilization
  * of such a task would be significantly decayed at this point of time.
  *
+ * Boosted CPU utilization is defined as max(CPU runnable, CPU utilization).
+ * CPU contention for CFS tasks can be detected by CPU runnable > CPU
+ * utilization. Boosting is implemented in cpu_util() so that internal
+ * users (e.g. EAS) can use it next to external users (e.g. schedutil),
+ * latter via cpu_util_cfs_boost().
+ *
  * CPU utilization can be higher than the current CPU capacity
  * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because
  * of rounding errors as well as task migrations or wakeups of new tasks.
@@ -7177,12 +7184,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  * though since this is useful for predicting the CPU capacity required
  * after task migrations (scheduler-driven DVFS).
  *
- * Return: (Estimated) utilization for the specified CPU.
+ * Return: (Boosted) (estimated) utilization for the specified CPU.
  */
-static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
+static unsigned long
+cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 {
 	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
 	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
+	unsigned long runnable;
+
+	if (boost) {
+		runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
+		util = max(util, runnable);
+	}
 
 	/*
 	 * If @dst_cpu is -1 or @p migrates from @cpu to @dst_cpu remove its
@@ -7200,6 +7214,9 @@ static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
 
 		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
 
+		if (boost)
+			util_est = max(util_est, runnable);
+
 		/*
 		 * During wake-up @p isn't enqueued yet and doesn't contribute
 		 * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
@@ -7239,7 +7256,12 @@ static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
 
 unsigned long cpu_util_cfs(int cpu)
 {
-	return cpu_util(cpu, NULL, -1);
+	return cpu_util(cpu, NULL, -1, 0);
+}
+
+unsigned long cpu_util_cfs_boost(int cpu)
+{
+	return cpu_util(cpu, NULL, -1, 1);
 }
 
 /*
@@ -7261,7 +7283,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
 		p = NULL;
 
-	return cpu_util(cpu, p, -1);
+	return cpu_util(cpu, p, -1, 0);
 }
 
 /*
@@ -7329,7 +7351,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	int cpu;
 
 	for_each_cpu(cpu, pd_cpus) {
-		unsigned long util = cpu_util(cpu, p, -1);
+		unsigned long util = cpu_util(cpu, p, -1, 0);
 
 		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
 	}
@@ -7353,7 +7375,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 
 	for_each_cpu(cpu, pd_cpus) {
 		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
-		unsigned long util = cpu_util(cpu, p, dst_cpu);
+		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
 		unsigned long cpu_util;
 
 		/*
@@ -7499,7 +7521,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
-			util = cpu_util(cpu, p, cpu);
+			util = cpu_util(cpu, p, cpu, 0);
 			cpu_cap = capacity_of(cpu);
 
 			/*
@@ -10559,7 +10581,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 			break;
 
 		case migrate_util:
-			util = cpu_util_cfs(i);
+			util = cpu_util_cfs_boost(i);
 
 			/*
 			 * Don't try to pull utilization from a CPU with one
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f78c0f85cc76..5861e236adc6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2948,6 +2948,7 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 
 
 extern unsigned long cpu_util_cfs(int cpu);
+extern unsigned long cpu_util_cfs_boost(int cpu);
 
 static inline unsigned long cpu_util_rt(struct rq *rq)
 {
-- 
2.25.1

