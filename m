Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9A26D5016
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjDCSN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjDCSN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:13:56 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B17E172C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680545631;
        bh=PRqdeSnOhzqlNeHm4nKYhnGTKbrzwEbupUOVZqey9UU=;
        h=From:To:Cc:Subject:Date:From;
        b=Ea3n+tbiKf6ZDFAj8hHAKZYPcgF81KfX52/ipRC6HzpmGHtAeFfTRiZsI9vQsfoPZ
         Zy3HTnG5/JxCkyu7V3nib4Cry/IH+n1o7xjYDXkyTLRnGKsOLcBYkir1j78y3AP+eZ
         RyVJBH132C3B10QZRjeWox5UiiNoLKTTgsGYzXt3Xo4qqF6Jgp/0Qh+WIHd4F3dzDv
         Vpdh2doPcpu5pHDfqIA5qzicYoeNueMJYG/OU390vVHCEeuIPjBmuobzQD+/5m4d1Z
         TtBfAu+cggb4njuBngNeQqSVPkSTsQNYELcZbv2FWzq7fjZQSa4dUIPimHYvfRFaJb
         hDilCXEJjOb7g==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PqzYB6bqXzthh;
        Mon,  3 Apr 2023 14:13:50 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Aaron Lu <aaron.lu@intel.com>
Subject: [RFC PATCH] sched: Fix performance regression introduced by mm_cid
Date:   Mon,  3 Apr 2023 14:13:42 -0400
Message-Id: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
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

Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
sysbench regression reported by Aaron Lu.

Keep track of the currently allocated mm_cid for each mm/cpu rather than
freeing them immediately on context switch. This eliminates most atomic
operations when context switching back and forth between threads
belonging to different memory spaces in multi-threaded scenarios (many
processes, each with many threads). The per-mm/per-cpu mm_cid values are
serialized by their respective runqueue locks.

Thread migration is handled by introducing invocation to
sched_mm_cid_migrate_from() (with source runqueue lock held) and to
sched_mm_cid_migrate_to() (with destination runqueue lock held) in
move_queued_task().

sched_mm_cid_migrate_from() clears the mm_cid from the task's mm per-cpu
index corresponding to the source runqueue if it matches the last mm_cid
observed by the migrated task. This last mm_cid value is returned as a
hint to conditionally clear the mm's per-cpu mm_cid on the destination
cpu.

Then, in sched_mm_cid_migrate_to(), if the last mm_cid is smaller than
the mm's destination cpu current mm_cid, clear the mm's destination cpu
current mm_cid. If the migrated task's mm is in use on the destination
cpu, the reclaim of the mm_cid will be done lazily on the next
destination cpu context switch, else it is performed immediately.

The source cpu's mm_cid is _not_ simply moved to the destination cpu on
migration, because passing ownership of the mm_cid value to the
destination cpu while an actively running tasks also has its own
mm_cid value (in case of lazy reclaim on next context switch) would
over-allocate mm_cid values beyond the number of possible cpus.

Because we want to ensure the mm_cid converges towards the smaller
values as migrations happen, the prior optimization that was done when
context switching between threads belonging to the same mm is removed,
because it could delay the lazy release of the destination runqueue
mm_cid after it has been replaced by a migration. Removing this prior
optimization is not an issue performance-wise because the introduced
per-mm/per-cpu mm_cid tracking also covers this more specific case.

This patch is based on v6.3-rc5 with this patch applied:

("mm: Fix memory leak on mm_init error handling")

https://lore.kernel.org/lkml/20230330133822.66271-1-mathieu.desnoyers@efficios.com/

Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
Link: https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/mm_types.h |  30 ++++++++++
 include/linux/sched.h    |   1 +
 kernel/fork.c            |   8 ++-
 kernel/sched/core.c      | 122 +++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h     |  83 +++++++++++++++++++-------
 5 files changed, 210 insertions(+), 34 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0722859c3647..21466fdc4dc6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -609,6 +609,14 @@ struct mm_struct {
 		 * were being concurrently updated by the updaters.
 		 */
 		raw_spinlock_t cid_lock;
+		/**
+		 * @pcpu_cid: Per-cpu current cid.
+		 *
+		 * Keep track of the currently allocated mm_cid for each cpu.
+		 * The per-cpu mm_cid values are serialized by their respective
+		 * runqueue locks.
+		 */
+		int __percpu *pcpu_cid;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -872,6 +880,7 @@ static inline void vma_iter_init(struct vma_iterator *vmi,
 }
 
 #ifdef CONFIG_SCHED_MM_CID
+
 /* Accessor for struct mm_struct's cidmask. */
 static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 {
@@ -885,16 +894,37 @@ static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 
 static inline void mm_init_cid(struct mm_struct *mm)
 {
+	int i;
+
 	raw_spin_lock_init(&mm->cid_lock);
+	for_each_possible_cpu(i)
+		*per_cpu_ptr(mm->pcpu_cid, i) = -1;
 	cpumask_clear(mm_cidmask(mm));
 }
 
+static inline int mm_alloc_cid(struct mm_struct *mm)
+{
+	mm->pcpu_cid = alloc_percpu(int);
+	if (!mm->pcpu_cid)
+		return -ENOMEM;
+	mm_init_cid(mm);
+	return 0;
+}
+
+static inline void mm_destroy_cid(struct mm_struct *mm)
+{
+	free_percpu(mm->pcpu_cid);
+	mm->pcpu_cid = NULL;
+}
+
 static inline unsigned int mm_cid_size(void)
 {
 	return cpumask_size();
 }
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm) { }
+static inline int mm_alloc_cid(struct mm_struct *mm) { return 0; }
+static inline void mm_destroy_cid(struct mm_struct *mm) { }
 static inline unsigned int mm_cid_size(void)
 {
 	return 0;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63d242164b1a..48d48b2c73a5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1313,6 +1313,7 @@ struct task_struct {
 
 #ifdef CONFIG_SCHED_MM_CID
 	int				mm_cid;		/* Current cid in mm */
+	int				last_mm_cid;	/* Most recent cid in mm */
 	int				mm_cid_active;	/* Whether cid bitmap is active */
 #endif
 
diff --git a/kernel/fork.c b/kernel/fork.c
index c983c4fe3090..0a2b905c2ed5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -790,6 +790,7 @@ void __mmdrop(struct mm_struct *mm)
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
+	mm_destroy_cid(mm);
 
 	for (i = 0; i < NR_MM_COUNTERS; i++)
 		percpu_counter_destroy(&mm->rss_stat[i]);
@@ -1054,6 +1055,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 #ifdef CONFIG_SCHED_MM_CID
 	tsk->mm_cid = -1;
+	tsk->last_mm_cid = -1;
 	tsk->mm_cid_active = 0;
 #endif
 	return tsk;
@@ -1159,18 +1161,22 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
+	if (mm_alloc_cid(mm))
+		goto fail_cid;
+
 	for (i = 0; i < NR_MM_COUNTERS; i++)
 		if (percpu_counter_init(&mm->rss_stat[i], 0, GFP_KERNEL_ACCOUNT))
 			goto fail_pcpu;
 
 	mm->user_ns = get_user_ns(user_ns);
 	lru_gen_init_mm(mm);
-	mm_init_cid(mm);
 	return mm;
 
 fail_pcpu:
 	while (i > 0)
 		percpu_counter_destroy(&mm->rss_stat[--i]);
+	mm_destroy_cid(mm);
+fail_cid:
 	destroy_context(mm);
 fail_nocontext:
 	mm_free_pgd(mm);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..775c7da6ec7f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2326,16 +2326,20 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 				   struct task_struct *p, int new_cpu)
 {
+	int cid;
+
 	lockdep_assert_rq_held(rq);
 
 	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, new_cpu);
+	cid = sched_mm_cid_migrate_from(rq, p);
 	rq_unlock(rq, rf);
 
 	rq = cpu_rq(new_cpu);
 
 	rq_lock(rq, rf);
 	WARN_ON_ONCE(task_cpu(p) != new_cpu);
+	sched_mm_cid_migrate_to(rq, p, cid);
 	activate_task(rq, p, 0);
 	check_preempt_curr(rq, p, 0);
 
@@ -11383,45 +11387,139 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 }
 
 #ifdef CONFIG_SCHED_MM_CID
+/*
+ * Migration from src cpu. Called with src_rq lock held.
+ */
+int sched_mm_cid_migrate_from(struct rq *src_rq, struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	int src_cid, *src_pcpu_cid, last_mm_cid;
+
+	lockdep_assert_rq_held(src_rq);
+
+	if (!mm)
+		return -1;
+
+	last_mm_cid = t->last_mm_cid;
+	/*
+	 * If the migrated task has no last cid, or if the current
+	 * task on src rq uses the cid, it means the destination cpu
+	 * does not have to reallocate its cid to keep the cid allocation
+	 * compact.
+	 */
+	if (last_mm_cid == -1 || src_rq->curr->mm == mm)
+		return -1;
+
+	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(src_rq));
+	src_cid = *src_pcpu_cid;
+	/*
+	 * If the source cpu cid is set, and matches the last cid of the
+	 * migrated task, clear the source cpu cid to keep cid allocation
+	 * compact to cover the case where this task is the last task using
+	 * this mm on the source cpu. If there happens to be other tasks left
+	 * on the source cpu using this mm, the next task using this mm will
+	 * reallocate its cid on context switch.
+	 */
+	if (src_cid != -1 && last_mm_cid == src_cid) {
+		/*
+		 * We cannot keep ownership of concurrency ID without runqueue
+		 * lock held when it is not used by a current task, because it
+		 * would lead to allocation of more concurrency ids than there
+		 * are possible cpus in the system. The last_mm_cid is used as
+		 * a hint to conditionally unset the dst cpu cid, keeping
+		 * allocated concurrency ids compact.
+		 */
+		__mm_cid_put(mm, src_cid);
+		*src_pcpu_cid = -1;
+	}
+	return last_mm_cid;
+}
+
+/*
+ * Migration to dst cpu. Called with dst_rq lock held.
+ */
+void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t, int src_cid)
+{
+	struct mm_struct *mm = t->mm;
+	int dst_cid, *dst_pcpu_cid;
+
+	lockdep_assert_rq_held(dst_rq);
+
+	if (!mm || src_cid == -1)
+		return;
+
+	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
+
+	/*
+	 * If destination cpu cid is greater than the source cpu cid, unset it
+	 * so it can be reallocated.
+	 */
+	dst_cid = *dst_pcpu_cid;
+	if (dst_cid == -1 || dst_cid < src_cid)
+		return;
+	*dst_pcpu_cid = -1;
+	/*
+	 * Put dst_cid if it is not currently in use, else it will be lazy put
+	 * on the next context switch.
+	 */
+	if (dst_rq->curr->mm != mm)
+		__mm_cid_put(mm, dst_cid);
+}
+
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	unsigned long flags;
+	struct rq_flags rf;
+	struct rq *rq;
 
 	if (!mm)
 		return;
-	local_irq_save(flags);
+
+	preempt_disable();
+	rq = this_rq();
+	rq_lock_irqsave(rq, &rf);
 	mm_cid_put(mm, t->mm_cid);
-	t->mm_cid = -1;
+	t->last_mm_cid = t->mm_cid = -1;
 	t->mm_cid_active = 0;
-	local_irq_restore(flags);
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
+
+	preempt_disable();
+	rq = this_rq();
+	rq_lock_irqsave(rq, &rf);
 	mm_cid_put(mm, t->mm_cid);
-	t->mm_cid = -1;
+	t->last_mm_cid = t->mm_cid = -1;
 	t->mm_cid_active = 0;
-	local_irq_restore(flags);
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
+
+	preempt_disable();
+	rq = this_rq();
+	rq_lock_irqsave(rq, &rf);
+	t->last_mm_cid = t->mm_cid = mm_cid_get(mm);
 	t->mm_cid_active = 1;
-	local_irq_restore(flags);
+	rq_unlock_irqrestore(rq, &rf);
+	preempt_enable();
 	rseq_set_notify_resume(t);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..2bc62cc412e1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3249,7 +3249,47 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
 }
 
 #ifdef CONFIG_SCHED_MM_CID
-static inline int __mm_cid_get(struct mm_struct *mm)
+extern int sched_mm_cid_migrate_from(struct rq *src_rq, struct task_struct *t);
+extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t, int cid);
+
+static inline void __mm_cid_put(struct mm_struct *mm, int cid)
+{
+	lockdep_assert_irqs_disabled();
+	if (cid < 0)
+		return;
+	raw_spin_lock(&mm->cid_lock);
+	__cpumask_clear_cpu(cid, mm_cidmask(mm));
+	raw_spin_unlock(&mm->cid_lock);
+}
+
+static inline void mm_cid_put(struct mm_struct *mm, int thread_cid)
+{
+	int *pcpu_cid, cid;
+
+	lockdep_assert_irqs_disabled();
+	if (thread_cid < 0)
+		return;
+	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
+	cid = *pcpu_cid;
+	if (cid == thread_cid)
+		*pcpu_cid = -1;
+	__mm_cid_put(mm, thread_cid);
+}
+
+static inline void mm_cid_put_lazy(struct mm_struct *mm, int thread_cid)
+{
+	int *pcpu_cid, cid;
+
+	lockdep_assert_irqs_disabled();
+	if (thread_cid < 0)
+		return;
+	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
+	cid = *pcpu_cid;
+	if (cid != thread_cid)
+		__mm_cid_put(mm, thread_cid);
+}
+
+static inline int __mm_cid_get_locked(struct mm_struct *mm)
 {
 	struct cpumask *cpumask;
 	int cid;
@@ -3262,48 +3302,49 @@ static inline int __mm_cid_get(struct mm_struct *mm)
 	return cid;
 }
 
-static inline void mm_cid_put(struct mm_struct *mm, int cid)
+static inline int __mm_cid_get(struct mm_struct *mm)
 {
+	int ret;
+
 	lockdep_assert_irqs_disabled();
-	if (cid < 0)
-		return;
 	raw_spin_lock(&mm->cid_lock);
-	__cpumask_clear_cpu(cid, mm_cidmask(mm));
+	ret = __mm_cid_get_locked(mm);
 	raw_spin_unlock(&mm->cid_lock);
+	return ret;
 }
 
 static inline int mm_cid_get(struct mm_struct *mm)
 {
-	int ret;
+	int *pcpu_cid, cid;
 
 	lockdep_assert_irqs_disabled();
-	raw_spin_lock(&mm->cid_lock);
-	ret = __mm_cid_get(mm);
-	raw_spin_unlock(&mm->cid_lock);
-	return ret;
+	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
+	cid = *pcpu_cid;
+	if (cid == -1) {
+		raw_spin_lock(&mm->cid_lock);
+		cid = __mm_cid_get_locked(mm);
+		raw_spin_unlock(&mm->cid_lock);
+		*pcpu_cid = cid;
+		return cid;
+	}
+	return cid;
 }
 
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
 {
 	if (prev->mm_cid_active) {
-		if (next->mm_cid_active && next->mm == prev->mm) {
-			/*
-			 * Context switch between threads in same mm, hand over
-			 * the mm_cid from prev to next.
-			 */
-			next->mm_cid = prev->mm_cid;
-			prev->mm_cid = -1;
-			return;
-		}
-		mm_cid_put(prev->mm, prev->mm_cid);
+		mm_cid_put_lazy(prev->mm, prev->mm_cid);
 		prev->mm_cid = -1;
 	}
 	if (next->mm_cid_active)
-		next->mm_cid = mm_cid_get(next->mm);
+		next->last_mm_cid = next->mm_cid = mm_cid_get(next->mm);
 }
 
 #else
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
+static inline void sched_mm_cid_migrate(struct rq *rq, struct task_struct *t, int new_cpu) { }
+static inline int sched_mm_cid_migrate_from(struct rq *src_rq, struct task_struct *t) { return 0; }
+static inline void sched_mm_cid_migrate_to(struct rq *src_rq, struct task_struct *t, int cid) { }
 #endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.25.1

