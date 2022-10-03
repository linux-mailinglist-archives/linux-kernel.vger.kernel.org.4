Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2B5F27CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 05:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJCDTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 23:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJCDTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 23:19:45 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BE2632B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 20:19:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VR8plep_1664767168;
Received: from rt2b04371.sqa.tbc.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VR8plep_1664767168)
          by smtp.aliyun-inc.com;
          Mon, 03 Oct 2022 11:19:38 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/core: Optimize the process of picking the max prio task for the core
Date:   Mon,  3 Oct 2022 11:19:28 +0800
Message-Id: <1664767168-30029-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we pick the max prio task for the core in the case of
sched_core_enabled(), if there's a task with a higher prio sched
class in the runqueue of a SMT, it's not necessary for other SMTs
to traverse lower prio sched classes. So we can change the traversal
order: for each sched class, if there exists a max prio task among
the core, pick it and break the loop.

To compare the prio of the tasks with the same sched class, we
introduce sched_class::prio_less().

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes since v1:
Fixes the compile error.
---
 kernel/sched/core.c      | 33 ++++++++++++++++++++++-----------
 kernel/sched/deadline.c  | 11 +++++++++++
 kernel/sched/fair.c      |  5 ++++-
 kernel/sched/idle.c      | 10 ++++++++++
 kernel/sched/rt.c        | 10 ++++++++++
 kernel/sched/sched.h     |  5 +++--
 kernel/sched/stop_task.c | 10 ++++++++++
 7 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a2d8a1f..50e28c8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -189,7 +189,7 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
 	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
-		return cfs_prio_less(a, b, in_fi);
+		return fair_sched_class.prio_less(a, b, in_fi);
 
 	return false;
 }
@@ -5886,6 +5886,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	int i, cpu, occ = 0;
 	struct rq *rq_i;
 	bool need_sync;
+	struct sched_class *class;
 
 	if (!sched_core_enabled(rq))
 		return __pick_next_task(rq, prev, rf);
@@ -5978,12 +5979,6 @@ static inline struct task_struct *pick_task(struct rq *rq)
 		}
 	}
 
-	/*
-	 * For each thread: do the regular task pick and find the max prio task
-	 * amongst them.
-	 *
-	 * Tie-break prio towards the current CPU
-	 */
 	for_each_cpu_wrap(i, smt_mask, cpu) {
 		rq_i = cpu_rq(i);
 
@@ -5994,12 +5989,28 @@ static inline struct task_struct *pick_task(struct rq *rq)
 		 */
 		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
 			update_rq_clock(rq_i);
+	}
 
-		p = rq_i->core_pick = pick_task(rq_i);
-		if (!max || prio_less(max, p, fi_before))
-			max = p;
+	/*
+	 * For each thread: do the regular task pick and find the max prio task
+	 * amongst them.
+	 *
+	 * Tie-break prio towards the current CPU
+	 */
+	for_each_class(class) {
+		for_each_cpu_wrap(i, smt_mask, cpu) {
+			rq_i = cpu_rq(i);
+			p = rq_i->core_pick = class->pick_task(rq_i);
+			if (!max || (p && class->prio_less(max, p, fi_before)))
+				max = p;
+		}
+		if (max)
+			break;
 	}
 
+	if (!max)
+		BUG();
+
 	cookie = rq->core->core_cookie = max->core_cookie;
 
 	/*
@@ -6010,7 +6021,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick;
 
-		if (!cookie_equals(p, cookie)) {
+		if (!p || !cookie_equals(p, cookie)) {
 			p = NULL;
 			if (cookie)
 				p = sched_core_find(rq_i, cookie);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 86dea6a..8e7aa7d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1942,6 +1942,7 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 
 	return sched_stop_runnable(rq) || sched_dl_runnable(rq);
 }
+
 #endif /* CONFIG_SMP */
 
 /*
@@ -2054,6 +2055,13 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 		enqueue_pushable_dl_task(rq, p);
 }
 
+#ifdef CONFIG_SCHED_CORE
+static bool prio_less_dl(struct task_struct *a, struct task_struct *b, bool in_fi)
+{
+	return !dl_time_before(a->dl.deadline, b->dl.deadline);
+}
+#endif
+
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -2704,6 +2712,9 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	.pick_next_task		= pick_next_task_dl,
 	.put_prev_task		= put_prev_task_dl,
 	.set_next_task		= set_next_task_dl,
+#ifdef CONFIG_SCHED_CORE
+	.prio_less		= prio_less_dl,
+#endif
 
 #ifdef CONFIG_SMP
 	.balance		= balance_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8b..eca2636 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11516,7 +11516,7 @@ void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
 	se_fi_update(se, rq->core->core_forceidle_seq, in_fi);
 }
 
-bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
+static bool prio_less_fair(struct task_struct *a, struct task_struct *b, bool in_fi)
 {
 	struct rq *rq = task_rq(a);
 	struct sched_entity *sea = &a->se;
@@ -12159,6 +12159,9 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
 	.pick_next_task		= __pick_next_task_fair,
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
+#ifdef CONFIG_SCHED_CORE
+	.prio_less		= prio_less_fair,
+#endif
 
 #ifdef CONFIG_SMP
 	.balance		= balance_fair,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f26ab26..a3c3e37 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -436,6 +436,13 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 	schedstat_inc(rq->sched_goidle);
 }
 
+#ifdef CONFIG_SCHED_CORE
+static bool prio_less_idle(struct task_struct *a, struct task_struct *b, bool in_fi)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_SMP
 static struct task_struct *pick_task_idle(struct rq *rq)
 {
@@ -507,6 +514,9 @@ static void update_curr_idle(struct rq *rq)
 	.pick_next_task		= pick_next_task_idle,
 	.put_prev_task		= put_prev_task_idle,
 	.set_next_task          = set_next_task_idle,
+#ifdef CONFIG_SCHED_CORE
+	.prio_less		= prio_less_idle,
+#endif
 
 #ifdef CONFIG_SMP
 	.balance		= balance_idle,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index d869bcf..4459a90 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1838,6 +1838,13 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 		enqueue_pushable_task(rq, p);
 }
 
+static bool prio_less_rt(struct task_struct *a, struct task_struct *b, bool in_fi)
+{
+	int pa = rt_prio(a->prio), pb = rt_prio(b->prio);
+
+	return -pa < -pb;
+}
+
 #ifdef CONFIG_SMP
 
 /* Only try algorithms three times */
@@ -2685,6 +2692,9 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 	.pick_next_task		= pick_next_task_rt,
 	.put_prev_task		= put_prev_task_rt,
 	.set_next_task          = set_next_task_rt,
+#ifdef CONFIG_SCHED_CORE
+	.prio_less		= prio_less_rt,
+#endif
 
 #ifdef CONFIG_SMP
 	.balance		= balance_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1644242..a7c6d10 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1218,8 +1218,6 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
-bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
-
 /*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
  * when core scheduling is enabled.
@@ -2155,6 +2153,9 @@ struct sched_class {
 
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
+#ifdef CONFIG_SCHED_CORE
+	bool (*prio_less)(struct task_struct *a, struct task_struct *b, bool in_fi);
+#endif
 
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 8559059..c9ddaaa 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -84,6 +84,13 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 	update_current_exec_runtime(curr, now, delta_exec);
 }
 
+#ifdef CONFIG_SCHED_CORE
+static bool prio_less_stop(struct task_struct *a, struct task_struct *b, bool in_fi)
+{
+	return false;
+}
+#endif
+
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -125,6 +132,9 @@ static void update_curr_stop(struct rq *rq)
 	.pick_next_task		= pick_next_task_stop,
 	.put_prev_task		= put_prev_task_stop,
 	.set_next_task          = set_next_task_stop,
+#ifdef CONFIG_SCHED_CORE
+	.prio_less		= prio_less_stop,
+#endif
 
 #ifdef CONFIG_SMP
 	.balance		= balance_stop,
-- 
1.8.3.1

