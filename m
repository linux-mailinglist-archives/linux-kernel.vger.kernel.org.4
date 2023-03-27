Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312F46CAF2F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjC0Txb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0Tx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:53:28 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473071703
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1679946803;
        bh=nsmc1lXzeDwzb2PFkpHMWf9ozymWoa/tBfMGyJVVxoU=;
        h=From:To:Cc:Subject:Date:From;
        b=aduuOPIFlxq2s9IEmNqAK/W6Q+fDWTqxcxqhFJGPVipK63sezE7Z7j8edB/tozvlP
         IBMswmitBTmiDUA0mSvFS9WU7w/ZHagcP6V4Mgd2KRVvlTobKOVvQjPdV8oHKAD8pu
         KbUxj1x9GlcAAqwXRBoYnPk1jvkxuCsqGPgpbHgLFzjrPVpoxKSFt/E1X3d6J1bFt5
         nVgJP4z4Vjhvl6VF4/+7CWoD4GmsCwfbBnuAEEo+cJRcsd1mFv+7hPZWjUkyMntgaY
         j1G3y5tjdKdMfx9dM9bO/2rFosP6cUZnOuvHzXp+NhBe3YYxCInnQxII+obTz3LTnn
         92hAJD7QkabIA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Plk5H5HlCztBx;
        Mon, 27 Mar 2023 15:53:23 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Aaron Lu <aaron.lu@intel.com>
Subject: [RFC PATCH] sched: Introduce mm_cid runqueue cache
Date:   Mon, 27 Mar 2023 15:53:18 -0400
Message-Id: <20230327195318.137094-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a per-runqueue cache containing { mm, mm_cid } entries.
Keep track of the recently allocated mm_cid for each mm rather than
freeing them immediately. This eliminates most atomic ops when
context switching back and forth between threads belonging to
different memory spaces in multi-threaded scenarios (many processes,
each with many threads).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c     |  45 +++++++++----
 kernel/sched/deadline.c |   3 +
 kernel/sched/fair.c     |   1 +
 kernel/sched/rt.c       |   2 +
 kernel/sched/sched.h    | 138 ++++++++++++++++++++++++++++++++++------
 5 files changed, 158 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..e91fc3b810e1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2329,6 +2329,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 	lockdep_assert_rq_held(rq);
 
 	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
+	rq_cid_cache_remove_mm_locked(rq, p->mm, false);
 	set_task_cpu(p, new_cpu);
 	rq_unlock(rq, rf);
 
@@ -2516,6 +2517,7 @@ int push_cpu_stop(void *arg)
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
 		deactivate_task(rq, p, 0);
+		rq_cid_cache_remove_mm_locked(rq, p->mm, false);
 		set_task_cpu(p, lowest_rq->cpu);
 		activate_task(lowest_rq, p, 0);
 		resched_curr(lowest_rq);
@@ -3215,6 +3217,7 @@ static void __migrate_swap_task(struct task_struct *p, int cpu)
 		rq_pin_lock(dst_rq, &drf);
 
 		deactivate_task(src_rq, p, 0);
+		rq_cid_cache_remove_mm_locked(src_rq, p->mm, false);
 		set_task_cpu(p, cpu);
 		activate_task(dst_rq, p, 0);
 		check_preempt_curr(dst_rq, p, 0);
@@ -3852,6 +3855,8 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
+	if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
+		rq_cid_cache_remove_mm(task_rq(p), p->mm, false);
 	__smp_call_single_queue(cpu, &p->wake_entry.llist);
 }
 
@@ -4269,6 +4274,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
+		rq_cid_cache_remove_mm(task_rq(p), p->mm, false);
 		set_task_cpu(p, cpu);
 	}
 #else
@@ -5114,7 +5120,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
-	switch_mm_cid(prev, next);
+	switch_mm_cid(rq, prev, next);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -6253,6 +6259,7 @@ static bool try_steal_cookie(int this, int that)
 			goto next;
 
 		deactivate_task(src, p, 0);
+		rq_cid_cache_remove_mm_locked(src, p->mm, false);
 		set_task_cpu(p, this);
 		activate_task(dst, p, 0);
 
@@ -11386,42 +11393,54 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	unsigned long flags;
+	struct rq_flags rf;
+	struct rq *rq;
 
 	if (!mm)
 		return;
-	local_irq_save(flags);
-	mm_cid_put(mm, t->mm_cid);
+	preempt_disable();
+	rq = this_rq();
+	rq_lock_irqsave(rq, &rf);
 	t->mm_cid = -1;
 	t->mm_cid_active = 0;
-	local_irq_restore(flags);
+	rq_cid_cache_remove_mm_locked(rq, mm, true);
+	rq_unlock_irqrestore(rq, &rf);
+	preempt_enable();
 }
 
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	unsigned long flags;
+	struct rq_flags rf;
+	struct rq *rq;
 
 	if (!mm)
 		return;
-	local_irq_save(flags);
-	mm_cid_put(mm, t->mm_cid);
+	preempt_disable();
+	rq = this_rq();
+	rq_lock_irqsave(rq, &rf);
 	t->mm_cid = -1;
 	t->mm_cid_active = 0;
-	local_irq_restore(flags);
+	rq_cid_cache_remove_mm_locked(rq, mm, true);
+	rq_unlock_irqrestore(rq, &rf);
+	preempt_enable();
 }
 
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	unsigned long flags;
+	struct rq_flags rf;
+	struct rq *rq;
 
 	if (!mm)
 		return;
-	local_irq_save(flags);
-	t->mm_cid = mm_cid_get(mm);
+	preempt_disable();
+	rq = this_rq();
+	rq_lock_irqsave(rq, &rf);
+	t->mm_cid = mm_cid_get(rq, mm);
 	t->mm_cid_active = 1;
-	local_irq_restore(flags);
+	rq_unlock_irqrestore(rq, &rf);
+	preempt_enable();
 	rseq_set_notify_resume(t);
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b24371a6f7..34bb47442912 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -729,6 +729,7 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(later_rq->rd->span));
 	raw_spin_unlock(&dl_b->lock);
 
+	rq_cid_cache_remove_mm_locked(rq, p->mm, false);
 	set_task_cpu(p, later_rq->cpu);
 	double_unlock_balance(later_rq, rq);
 
@@ -2357,6 +2358,7 @@ static int push_dl_task(struct rq *rq)
 	}
 
 	deactivate_task(rq, next_task, 0);
+	rq_cid_cache_remove_mm_locked(rq, next_task->mm, false);
 	set_task_cpu(next_task, later_rq->cpu);
 	activate_task(later_rq, next_task, 0);
 	ret = 1;
@@ -2445,6 +2447,7 @@ static void pull_dl_task(struct rq *this_rq)
 				push_task = get_push_task(src_rq);
 			} else {
 				deactivate_task(src_rq, p, 0);
+				rq_cid_cache_remove_mm_locked(src_rq, p->mm, false);
 				set_task_cpu(p, this_cpu);
 				activate_task(this_rq, p, 0);
 				dmin = p->dl.deadline;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6986ea31c984..70ed6aef87ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8542,6 +8542,7 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 	lockdep_assert_rq_held(env->src_rq);
 
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
+	rq_cid_cache_remove_mm_locked(env->src_rq, p->mm, false);
 	set_task_cpu(p, env->dst_cpu);
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0a11f44adee5..3ad325db1db3 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2156,6 +2156,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	}
 
 	deactivate_task(rq, next_task, 0);
+	rq_cid_cache_remove_mm_locked(rq, next_task->mm, false);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
 	resched_curr(lowest_rq);
@@ -2429,6 +2430,7 @@ static void pull_rt_task(struct rq *this_rq)
 				push_task = get_push_task(src_rq);
 			} else {
 				deactivate_task(src_rq, p, 0);
+				rq_cid_cache_remove_mm_locked(src_rq, p->mm, false);
 				set_task_cpu(p, this_cpu);
 				activate_task(this_rq, p, 0);
 				resched = true;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..b2e12857e2c3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -947,6 +947,19 @@ struct balance_callback {
 	void (*func)(struct rq *rq);
 };
 
+#ifdef CONFIG_SCHED_MM_CID
+# define RQ_CID_CACHE_SIZE    8
+struct rq_cid_entry {
+	struct mm_struct *mm;   /* NULL if unset */
+	int mm_cid;
+};
+
+struct rq_cid_cache {
+	struct rq_cid_entry entry[RQ_CID_CACHE_SIZE];
+	unsigned int head;
+};
+#endif
+
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -1161,6 +1174,9 @@ struct rq {
 	call_single_data_t	cfsb_csd;
 	struct list_head	cfsb_csd_list;
 #endif
+#ifdef CONFIG_SCHED_MM_CID
+	struct rq_cid_cache	cid_cache;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -3249,6 +3265,92 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
 }
 
 #ifdef CONFIG_SCHED_MM_CID
+
+static inline void mm_cid_put(struct mm_struct *mm, int cid)
+{
+	lockdep_assert_irqs_disabled();
+	if (cid < 0)
+		return;
+	raw_spin_lock(&mm->cid_lock);
+	__cpumask_clear_cpu(cid, mm_cidmask(mm));
+	raw_spin_unlock(&mm->cid_lock);
+}
+
+static inline struct rq_cid_entry *rq_cid_cache_lookup(struct rq *rq, struct mm_struct *mm)
+{
+	struct rq_cid_cache *cid_cache = &rq->cid_cache;
+	int i;
+
+	for (i = 0; i < RQ_CID_CACHE_SIZE; i++) {
+		struct rq_cid_entry *entry = &cid_cache->entry[i];
+
+		if (entry->mm == mm)
+			return entry;
+	}
+	return NULL;
+}
+
+/* Removal from cache simply leaves an unused hole. */
+static inline int rq_cid_cache_lookup_remove(struct rq *rq, struct mm_struct *mm)
+{
+	struct rq_cid_entry *entry = rq_cid_cache_lookup(rq, mm);
+
+	if (!entry)
+		return -1;
+	entry->mm = NULL;       /* Remove from cache */
+	return entry->mm_cid;
+}
+
+static inline void rq_cid_cache_remove_mm_locked(struct rq *rq, struct mm_struct *mm, bool release_mm)
+{
+	int cid;
+
+	if (!mm)
+		return;
+	/*
+	 * Do not remove the cache entry for a runqueue that runs a task which
+	 * currently uses the target mm.
+	 */
+	if (!release_mm && rq->curr->mm == mm)
+		return;
+	cid = rq_cid_cache_lookup_remove(rq, mm);
+	mm_cid_put(mm, cid);
+}
+
+static inline void rq_cid_cache_remove_mm(struct rq *rq, struct mm_struct *mm, bool release_mm)
+{
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	rq_cid_cache_remove_mm_locked(rq, mm, release_mm);
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+/*
+  * Add at head, move head forward. Cheap LRU cache.
+  * Only need to clear the cid mask bit from its own mm_cidmask(mm) when we
+  * overwrite an old entry from the cache. Note that this is not needed if the
+  * overwritten entry is an unused hole. This access to the old_mm from an
+  * unrelated thread requires that cache entry for a given mm gets pruned from
+  * the cache when a task is dequeued from the runqueue.
+  */
+static inline void rq_cid_cache_add(struct rq *rq, struct mm_struct *mm, int cid)
+{
+	struct rq_cid_cache *cid_cache = &rq->cid_cache;
+	struct mm_struct *old_mm;
+	struct rq_cid_entry *entry;
+	unsigned int pos;
+
+	pos = cid_cache->head;
+	entry = &cid_cache->entry[pos];
+	old_mm = entry->mm;
+	if (old_mm)
+		mm_cid_put(old_mm, entry->mm_cid);
+	entry->mm = mm;
+	entry->mm_cid = cid;
+	cid_cache->head = (pos + 1) % RQ_CID_CACHE_SIZE;
+}
+
 static inline int __mm_cid_get(struct mm_struct *mm)
 {
 	struct cpumask *cpumask;
@@ -3262,28 +3364,26 @@ static inline int __mm_cid_get(struct mm_struct *mm)
 	return cid;
 }
 
-static inline void mm_cid_put(struct mm_struct *mm, int cid)
+static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
 {
-	lockdep_assert_irqs_disabled();
-	if (cid < 0)
-		return;
-	raw_spin_lock(&mm->cid_lock);
-	__cpumask_clear_cpu(cid, mm_cidmask(mm));
-	raw_spin_unlock(&mm->cid_lock);
-}
-
-static inline int mm_cid_get(struct mm_struct *mm)
-{
-	int ret;
+	struct rq_cid_entry *entry;
+	int cid;
 
 	lockdep_assert_irqs_disabled();
+	entry = rq_cid_cache_lookup(rq, mm);
+	if (entry) {
+		cid = entry->mm_cid;
+		goto end;
+	}
 	raw_spin_lock(&mm->cid_lock);
-	ret = __mm_cid_get(mm);
+	cid = __mm_cid_get(mm);
 	raw_spin_unlock(&mm->cid_lock);
-	return ret;
+	rq_cid_cache_add(rq, mm, cid);
+end:
+	return cid;
 }
 
-static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
+static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	if (prev->mm_cid_active) {
 		if (next->mm_cid_active && next->mm == prev->mm) {
@@ -3295,15 +3395,17 @@ static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *n
 			prev->mm_cid = -1;
 			return;
 		}
-		mm_cid_put(prev->mm, prev->mm_cid);
+		/* Leave the prev mm_cid in the cid rq cache. */
 		prev->mm_cid = -1;
 	}
 	if (next->mm_cid_active)
-		next->mm_cid = mm_cid_get(next->mm);
+		next->mm_cid = mm_cid_get(rq, next->mm);
 }
 
 #else
-static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
+static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
+static inline void rq_cid_cache_remove_mm_locked(struct rq *rq, struct mm_struct *mm, bool release_mm) { }
+static inline void rq_cid_cache_remove_mm(struct rq *rq, struct mm_struct *mm, bool release_mm) { }
 #endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.25.1

