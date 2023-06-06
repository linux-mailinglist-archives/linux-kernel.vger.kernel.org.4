Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6544723B35
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbjFFITF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbjFFIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:18:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60411B5;
        Tue,  6 Jun 2023 01:18:55 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B97gNlcZnE7EtJHgh7FyWdlEQspnBevMBqc2y/sQb4I=;
        b=0EpdI1D/aRi0I4BsPrRkfZpinhxDNoBYF7TtxntrSP+6zbigL/Lj40XndWb21BkmN0OCRR
        pnhG1E2BcYRRLFJ208w2FoHTlEDJedhWffgrR60nF39KqlSDx7IyNxqp+nO8bo+1van73b
        LRM4PHCsQ9kouFCIrjodw9ArKrjuwB/GhIkBLL739OexVYUbCiDmrTm2LKkC3dp4H8+oGt
        eQ4aPDo8AqzCTc7X1XthUKWkYp/AEoLuviHd21Y2EvzUjdvgfmzcEywAu9IrM0eX8Uv/gY
        22ChOxytp2MxV2Y6BOmr5qDe2EKTQTyfAk4krUB6hhnqT6pH2g8OzD19FW1W6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B97gNlcZnE7EtJHgh7FyWdlEQspnBevMBqc2y/sQb4I=;
        b=n8JrjyUkYkWgau3JkJU/iEInplxHxa6IWnNL0jXzxRrfUzEiFzbtkIcjBlFGiRFktpUPXi
        zZ7+rt19zmIoQ9DQ==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair, cpufreq: Introduce 'runnable boosting'
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515115735.296329-3-dietmar.eggemann@arm.com>
References: <20230515115735.296329-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <168603953382.404.17377096355701794965.tip-bot2@tip-bot2>
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

Commit-ID:     7d0583cf9ec7bf8e5897dc7d3a7059e8fae5464a
Gitweb:        https://git.kernel.org/tip/7d0583cf9ec7bf8e5897dc7d3a7059e8fae5464a
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Mon, 15 May 2023 13:57:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:13:44 +02:00

sched/fair, cpufreq: Introduce 'runnable boosting'

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230515115735.296329-3-dietmar.eggemann@arm.com
---
 kernel/sched/cpufreq_schedutil.c |  3 +-
 kernel/sched/fair.c              | 38 ++++++++++++++++++++++++-------
 kernel/sched/sched.h             |  1 +-
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e321145..4492608 100644
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
index 09e3be2..6189d1a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7207,6 +7207,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  * @cpu: the CPU to get the utilization for
  * @p: task for which the CPU utilization should be predicted or NULL
  * @dst_cpu: CPU @p migrates to, -1 if @p moves from @cpu or @p == NULL
+ * @boost: 1 to enable boosting, otherwise 0
  *
  * The unit of the return value must be the same as the one of CPU capacity
  * so that CPU utilization can be compared with CPU capacity.
@@ -7224,6 +7225,12 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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
@@ -7234,12 +7241,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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
@@ -7257,6 +7271,9 @@ static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
 
 		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
 
+		if (boost)
+			util_est = max(util_est, runnable);
+
 		/*
 		 * During wake-up @p isn't enqueued yet and doesn't contribute
 		 * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
@@ -7296,7 +7313,12 @@ static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
 
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
@@ -7318,7 +7340,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
 		p = NULL;
 
-	return cpu_util(cpu, p, -1);
+	return cpu_util(cpu, p, -1, 0);
 }
 
 /*
@@ -7386,7 +7408,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	int cpu;
 
 	for_each_cpu(cpu, pd_cpus) {
-		unsigned long util = cpu_util(cpu, p, -1);
+		unsigned long util = cpu_util(cpu, p, -1, 0);
 
 		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
 	}
@@ -7410,7 +7432,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 
 	for_each_cpu(cpu, pd_cpus) {
 		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
-		unsigned long util = cpu_util(cpu, p, dst_cpu);
+		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
 		unsigned long cpu_util;
 
 		/*
@@ -7556,7 +7578,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
-			util = cpu_util(cpu, p, cpu);
+			util = cpu_util(cpu, p, cpu, 0);
 			cpu_cap = capacity_of(cpu);
 
 			/*
@@ -10607,7 +10629,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 			break;
 
 		case migrate_util:
-			util = cpu_util_cfs(i);
+			util = cpu_util_cfs_boost(i);
 
 			/*
 			 * Don't try to pull utilization from a CPU with one
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aaf6fc2..556496c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2957,6 +2957,7 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 
 
 extern unsigned long cpu_util_cfs(int cpu);
+extern unsigned long cpu_util_cfs_boost(int cpu);
 
 static inline unsigned long cpu_util_rt(struct rq *rq)
 {
