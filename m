Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A695723B36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbjFFITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbjFFIS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:18:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56139E40;
        Tue,  6 Jun 2023 01:18:56 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:18:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vbZvBwsTqFXWY9oaJ114END5x75WZTbsWPBUYt1EctA=;
        b=DVIo9BQympy6w2Cvx8DrFNYsCl8qrZj8r269lEo47/+aJaOVXuWDCxAW62iRXzHLwYw8oy
        UpEV7qJLYngRhVrGqq25OensgLPDcPYxPZCWKCZkoOBZm70xVOv+Hyv2BQd3SkFNs5dO4E
        aCnJZsUjjRI6BpXN+pa27Mt/95/q0l68zTVjVMqzdVC9/fOvsK6CtA1SZo44CQi2yeEU0L
        HXz8+7Cw7KYt6z+CZej9tjcd6CPop0OjDt1KajiTK94DqRWniOd/fTKVMg9pK7j/pgE+PR
        b1B41iSG/8qAzEtzvi3vjJS5F/7TfRi4gAHeBztCOHqeg7jOPI1W9Q73ed07GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vbZvBwsTqFXWY9oaJ114END5x75WZTbsWPBUYt1EctA=;
        b=GxVDKjhqyVWoV79iV5SCwyrRckve/zxnlxejQABIxbKA/2xsEcSPnCHHL25E8r9kHoUNYz
        SgNc1TYQRRJjA+Ag==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Refactor CPU utilization functions
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515115735.296329-2-dietmar.eggemann@arm.com>
References: <20230515115735.296329-2-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <168603953443.404.1204658294899368545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3eb6d6ececca2fd566d717b37ab467c246f66be7
Gitweb:        https://git.kernel.org/tip/3eb6d6ececca2fd566d717b37ab467c246f66be7
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Mon, 15 May 2023 13:57:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:13:43 +02:00

sched/fair: Refactor CPU utilization functions

There is a lot of code duplication in cpu_util_next() & cpu_util_cfs().

Remove this by allowing cpu_util_next() to be called with p = NULL.
Rename cpu_util_next() to cpu_util() since the '_next' suffix is no
longer necessary to distinct cpu utilization related functions.
Implement cpu_util_cfs(cpu) as cpu_util(cpu, p = NULL, -1).

This will allow to code future related cpu util changes only in one
place, namely in cpu_util().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230515115735.296329-2-dietmar.eggemann@arm.com
---
 kernel/sched/fair.c  | 63 +++++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h | 47 +--------------------------------
 2 files changed, 50 insertions(+), 60 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df0ff90..09e3be2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7202,11 +7202,41 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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
@@ -7217,9 +7247,9 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
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
@@ -7255,7 +7285,7 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 		 */
 		if (dst_cpu == cpu)
 			util_est += _task_util_est(p);
-		else if (unlikely(task_on_rq_queued(p) || current == p))
+		else if (p && unlikely(task_on_rq_queued(p) || current == p))
 			lsub_positive(&util_est, _task_util_est(p));
 
 		util = max(util, util_est);
@@ -7264,6 +7294,11 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
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
@@ -7281,9 +7316,9 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 {
 	/* Task has no contribution or is new */
 	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
-		return cpu_util_cfs(cpu);
+		p = NULL;
 
-	return cpu_util_next(cpu, p, -1);
+	return cpu_util(cpu, p, -1);
 }
 
 /*
@@ -7330,7 +7365,7 @@ static inline void eenv_task_busy_time(struct energy_env *eenv,
  * cpu_capacity.
  *
  * The contribution of the task @p for which we want to estimate the
- * energy cost is removed (by cpu_util_next()) and must be calculated
+ * energy cost is removed (by cpu_util()) and must be calculated
  * separately (see eenv_task_busy_time). This ensures:
  *
  *   - A stable PD utilization, no matter which CPU of that PD we want to place
@@ -7351,7 +7386,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	int cpu;
 
 	for_each_cpu(cpu, pd_cpus) {
-		unsigned long util = cpu_util_next(cpu, p, -1);
+		unsigned long util = cpu_util(cpu, p, -1);
 
 		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
 	}
@@ -7375,7 +7410,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 
 	for_each_cpu(cpu, pd_cpus) {
 		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
-		unsigned long util = cpu_util_next(cpu, p, dst_cpu);
+		unsigned long util = cpu_util(cpu, p, dst_cpu);
 		unsigned long cpu_util;
 
 		/*
@@ -7521,7 +7556,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
-			util = cpu_util_next(cpu, p, cpu);
+			util = cpu_util(cpu, p, cpu);
 			cpu_cap = capacity_of(cpu);
 
 			/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d8ba81c..aaf6fc2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2955,53 +2955,8 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
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
