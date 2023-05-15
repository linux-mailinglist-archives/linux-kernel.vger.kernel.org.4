Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06EC702C92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbjEOMXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbjEOMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:22:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 214FA1BD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:22:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC8BD4B3;
        Mon, 15 May 2023 04:58:37 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90CB53F7BD;
        Mon, 15 May 2023 04:57:51 -0700 (PDT)
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
Subject: [PATCH v3 1/2] sched/fair: Refactor CPU utilization functions
Date:   Mon, 15 May 2023 13:57:34 +0200
Message-Id: <20230515115735.296329-2-dietmar.eggemann@arm.com>
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

There is a lot of code duplication in cpu_util_next() & cpu_util_cfs().

Remove this by allowing cpu_util_next() to be called with p = NULL.
Rename cpu_util_next() to cpu_util() since the '_next' suffix is no
longer necessary to distinct cpu utilization related functions.
Implement cpu_util_cfs(cpu) as cpu_util(cpu, p = NULL, -1).

This will allow to code future related cpu util changes only in one
place, namely in cpu_util().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c  | 63 ++++++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h | 47 +--------------------------------
 2 files changed, 50 insertions(+), 60 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3f8135d7c89d..9874e28d5e38 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7145,11 +7145,41 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	return target;
 }
 
-/*
- * Predicts what cpu_util(@cpu) would return if @p was removed from @cpu
- * (@dst_cpu = -1) or migrated to @dst_cpu.
- */
-static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
+/**
+ * cpu_util() - Estimates the amount of CPU capacity used by CFS tasks.
+ * @cpu: the CPU to get the utilization for
+ * @p: task for which the CPU utilization should be predicted or NULL
+ * @dst_cpu: CPU @p migrates to, -1 if @p moves from @cpu or @p == NULL
+ *
+ * The unit of the return value must be the same as the one of CPU capacity
+ * so that CPU utilization can be compared with CPU capacity.
+ *
+ * CPU utilization is the sum of running time of runnable tasks plus the
+ * recent utilization of currently non-runnable tasks on that CPU.
+ * It represents the amount of CPU capacity currently used by CFS tasks in
+ * the range [0..max CPU capacity] with max CPU capacity being the CPU
+ * capacity at f_max.
+ *
+ * The estimated CPU utilization is defined as the maximum between CPU
+ * utilization and sum of the estimated utilization of the currently
+ * runnable tasks on that CPU. It preserves a utilization "snapshot" of
+ * previously-executed tasks, which helps better deduce how busy a CPU will
+ * be when a long-sleeping task wakes up. The contribution to CPU utilization
+ * of such a task would be significantly decayed at this point of time.
+ *
+ * CPU utilization can be higher than the current CPU capacity
+ * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because
+ * of rounding errors as well as task migrations or wakeups of new tasks.
+ * CPU utilization has to be capped to fit into the [0..max CPU capacity]
+ * range. Otherwise a group of CPUs (CPU0 util = 121% + CPU1 util = 80%)
+ * could be seen as over-utilized even though CPU1 has 20% of spare CPU
+ * capacity. CPU utilization is allowed to overshoot current CPU capacity
+ * though since this is useful for predicting the CPU capacity required
+ * after task migrations (scheduler-driven DVFS).
+ *
+ * Return: (Estimated) utilization for the specified CPU.
+ */
+static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
 {
 	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
 	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
@@ -7160,9 +7190,9 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 	 * contribution. In all the other cases @cpu is not impacted by the
 	 * migration so its util_avg is already correct.
 	 */
-	if (task_cpu(p) == cpu && dst_cpu != cpu)
+	if (p && task_cpu(p) == cpu && dst_cpu != cpu)
 		lsub_positive(&util, task_util(p));
-	else if (task_cpu(p) != cpu && dst_cpu == cpu)
+	else if (p && task_cpu(p) != cpu && dst_cpu == cpu)
 		util += task_util(p);
 
 	if (sched_feat(UTIL_EST)) {
@@ -7198,7 +7228,7 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 		 */
 		if (dst_cpu == cpu)
 			util_est += _task_util_est(p);
-		else if (unlikely(task_on_rq_queued(p) || current == p))
+		else if (p && unlikely(task_on_rq_queued(p) || current == p))
 			lsub_positive(&util_est, _task_util_est(p));
 
 		util = max(util, util_est);
@@ -7207,6 +7237,11 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 	return min(util, capacity_orig_of(cpu));
 }
 
+unsigned long cpu_util_cfs(int cpu)
+{
+	return cpu_util(cpu, NULL, -1);
+}
+
 /*
  * cpu_util_without: compute cpu utilization without any contributions from *p
  * @cpu: the CPU which utilization is requested
@@ -7224,9 +7259,9 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 {
 	/* Task has no contribution or is new */
 	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
-		return cpu_util_cfs(cpu);
+		p = NULL;
 
-	return cpu_util_next(cpu, p, -1);
+	return cpu_util(cpu, p, -1);
 }
 
 /*
@@ -7273,7 +7308,7 @@ static inline void eenv_task_busy_time(struct energy_env *eenv,
  * cpu_capacity.
  *
  * The contribution of the task @p for which we want to estimate the
- * energy cost is removed (by cpu_util_next()) and must be calculated
+ * energy cost is removed (by cpu_util()) and must be calculated
  * separately (see eenv_task_busy_time). This ensures:
  *
  *   - A stable PD utilization, no matter which CPU of that PD we want to place
@@ -7294,7 +7329,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	int cpu;
 
 	for_each_cpu(cpu, pd_cpus) {
-		unsigned long util = cpu_util_next(cpu, p, -1);
+		unsigned long util = cpu_util(cpu, p, -1);
 
 		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
 	}
@@ -7318,7 +7353,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 
 	for_each_cpu(cpu, pd_cpus) {
 		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
-		unsigned long util = cpu_util_next(cpu, p, dst_cpu);
+		unsigned long util = cpu_util(cpu, p, dst_cpu);
 		unsigned long cpu_util;
 
 		/*
@@ -7464,7 +7499,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
-			util = cpu_util_next(cpu, p, cpu);
+			util = cpu_util(cpu, p, cpu);
 			cpu_cap = capacity_of(cpu);
 
 			/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..f78c0f85cc76 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2946,53 +2946,8 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 	return READ_ONCE(rq->avg_dl.util_avg);
 }
 
-/**
- * cpu_util_cfs() - Estimates the amount of CPU capacity used by CFS tasks.
- * @cpu: the CPU to get the utilization for.
- *
- * The unit of the return value must be the same as the one of CPU capacity
- * so that CPU utilization can be compared with CPU capacity.
- *
- * CPU utilization is the sum of running time of runnable tasks plus the
- * recent utilization of currently non-runnable tasks on that CPU.
- * It represents the amount of CPU capacity currently used by CFS tasks in
- * the range [0..max CPU capacity] with max CPU capacity being the CPU
- * capacity at f_max.
- *
- * The estimated CPU utilization is defined as the maximum between CPU
- * utilization and sum of the estimated utilization of the currently
- * runnable tasks on that CPU. It preserves a utilization "snapshot" of
- * previously-executed tasks, which helps better deduce how busy a CPU will
- * be when a long-sleeping task wakes up. The contribution to CPU utilization
- * of such a task would be significantly decayed at this point of time.
- *
- * CPU utilization can be higher than the current CPU capacity
- * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because
- * of rounding errors as well as task migrations or wakeups of new tasks.
- * CPU utilization has to be capped to fit into the [0..max CPU capacity]
- * range. Otherwise a group of CPUs (CPU0 util = 121% + CPU1 util = 80%)
- * could be seen as over-utilized even though CPU1 has 20% of spare CPU
- * capacity. CPU utilization is allowed to overshoot current CPU capacity
- * though since this is useful for predicting the CPU capacity required
- * after task migrations (scheduler-driven DVFS).
- *
- * Return: (Estimated) utilization for the specified CPU.
- */
-static inline unsigned long cpu_util_cfs(int cpu)
-{
-	struct cfs_rq *cfs_rq;
-	unsigned long util;
-
-	cfs_rq = &cpu_rq(cpu)->cfs;
-	util = READ_ONCE(cfs_rq->avg.util_avg);
 
-	if (sched_feat(UTIL_EST)) {
-		util = max_t(unsigned long, util,
-			     READ_ONCE(cfs_rq->avg.util_est.enqueued));
-	}
-
-	return min(util, capacity_orig_of(cpu));
-}
+extern unsigned long cpu_util_cfs(int cpu);
 
 static inline unsigned long cpu_util_rt(struct rq *rq)
 {
-- 
2.25.1

