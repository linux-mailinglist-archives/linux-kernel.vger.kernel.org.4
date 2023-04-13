Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A47A6E1780
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDMWeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjDMWel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:34:41 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD07D8A41
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681425240;
        bh=eqqgbxPZsXgTo7uoGfxRec20hNNl4JWjav7PQDiZ2L0=;
        h=From:To:Cc:Subject:Date:From;
        b=KIZlOHQAVH1KtN2TUJkYubWoraSPWFbZF9/yun78JznAc52mG1n5H7rRMVg4NOBGL
         5jVMKH6QU0nJwmv00eLOEJAGd5qSTxuBnJmckilKByRnkH9TuecWJquhZfJ433L6iv
         pAlD9QUHSAiPVY9qfyVqVJRkikckII/aX3a5iWH7r+pgqwTexXfPn0oi0fG8om7wLS
         MsqaSp2yC2haLt5P2pEP4Qw4LIc4VnS5VxmiHYiDETKh363i6nbEjT8Y1To3GttUk6
         Zn380VazLth8Pze9wI19gJNKTY9QMKmU1MaMPqcwu5CrZeFkwEGebDlfhiWK8MjqNo
         JZOU61XAUowlA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PyDrm5cK9zvPY;
        Thu, 13 Apr 2023 18:34:00 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com
Subject: [RFC PATCH v6] sched: Fix performance regression introduced by mm_cid
Date:   Thu, 13 Apr 2023 18:33:56 -0400
Message-Id: <20230413223356.17195-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Thread migration is handled by introducing a task-work executed
periodically, similarly to NUMA work, which delays reclaim of cid
values when they are unused for a period of time.

Keep track of the allocation time for each per-cpu cid, and let the task
work clear them when they are observed to be older than
SCHED_MM_CID_PERIOD_NS and unused.

This fix is going for a task-work and delayed reclaim approach rather
than adding hooks to migrate-from and migrate-to because migration
happens to be a hot path for various real-world workloads.

Because we want to ensure the mm_cid converges towards the smaller
values as migrations happen, the prior optimization that was done when
context switching between threads belonging to the same mm is removed,
because it could delay the lazy release of the destination runqueue
mm_cid after it has been replaced by a migration. Removing this prior
optimization is not an issue performance-wise because the introduced
per-mm/per-cpu mm_cid tracking also covers this more specific case.

This patch is based on v6.3-rc6 with this patch applied:

("mm: Fix memory leak on mm_init error handling")

https://lore.kernel.org/lkml/20230330133822.66271-1-mathieu.desnoyers@efficios.com/

Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
Link: https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Olivier Dion <odion@efficios.com>
Cc: michael.christie@oracle.com
---
Changes since v5:
- Introduce task-work and delay-based reclaim.

Changes since v4:
- Retry on filled mm_cid mask,
- Disable interrupts during ownership of cid in migrate-from without rq
  lock,
- Implement lock-free cid-get, using spinlock only to guarantee
  forward progress when contention is detected.
- Use try_cmpxchg where appropriate.

Changes since v3:
- Rebase on v6.3-rc6,
- Move switch_mm_cid() from prepare_task_switch() to context_switch()
  after the switch_to() barrier,
- Adding missing barriers at the beginning of switch_mm_cid(),
- Document the lock-free migrate-from algorithm.
- Add memory barriers in sched_mm_cid_exit_signals(),
  sched_mm_cid_before_execve(), and sched_mm_cid_after_execve() to
  order t->mm_cid_active store, per-mm/cpu cid load wrt migrate-from
  per-mm-cid cid cmpxchg, t->mm_cid_active load.
---
 include/linux/mm_types.h |  77 +++++++++-
 include/linux/sched.h    |   2 +
 include/linux/sched/mm.h |   5 +
 kernel/fork.c            |   8 +-
 kernel/sched/core.c      | 325 ++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h     | 221 ++++++++++++++++++++++----
 6 files changed, 583 insertions(+), 55 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a57e6ae78e65..e96bb22a9098 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -550,6 +550,13 @@ struct vm_area_struct {
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
 
+#ifdef CONFIG_SCHED_MM_CID
+struct mm_cid {
+	u64 time;
+	int cid;
+};
+#endif
+
 struct kioctx_table;
 struct mm_struct {
 	struct {
@@ -600,15 +607,14 @@ struct mm_struct {
 		atomic_t mm_count;
 #ifdef CONFIG_SCHED_MM_CID
 		/**
-		 * @cid_lock: Protect cid bitmap updates vs lookups.
+		 * @pcpu_cid: Per-cpu current cid.
 		 *
-		 * Prevent situations where updates to the cid bitmap happen
-		 * concurrently with lookups. Those can lead to situations
-		 * where a lookup cannot find a free bit simply because it was
-		 * unlucky enough to load, non-atomically, bitmap words as they
-		 * were being concurrently updated by the updaters.
+		 * Keep track of the currently allocated mm_cid for each cpu.
+		 * The per-cpu mm_cid values are serialized by their respective
+		 * runqueue locks.
 		 */
-		raw_spinlock_t cid_lock;
+		struct mm_cid __percpu *pcpu_cid;
+		unsigned long mm_cid_next_scan;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -873,6 +879,37 @@ static inline void vma_iter_init(struct vma_iterator *vmi,
 }
 
 #ifdef CONFIG_SCHED_MM_CID
+
+enum mm_cid_state {
+	MM_CID_UNSET = -1U,		/* Unset state has lazy_put flag set. */
+	MM_CID_LAZY_PUT = (1U << 31),
+};
+
+static inline bool mm_cid_is_unset(int cid)
+{
+	return cid == MM_CID_UNSET;
+}
+
+static inline bool mm_cid_is_lazy_put(int cid)
+{
+	return !mm_cid_is_unset(cid) && (cid & MM_CID_LAZY_PUT);
+}
+
+static inline bool mm_cid_is_valid(int cid)
+{
+	return !(cid & MM_CID_LAZY_PUT);
+}
+
+static inline int mm_cid_set_lazy_put(int cid)
+{
+	return cid | MM_CID_LAZY_PUT;
+}
+
+static inline int mm_cid_clear_lazy_put(int cid)
+{
+	return cid & ~MM_CID_LAZY_PUT;
+}
+
 /* Accessor for struct mm_struct's cidmask. */
 static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 {
@@ -886,16 +923,40 @@ static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 
 static inline void mm_init_cid(struct mm_struct *mm)
 {
-	raw_spin_lock_init(&mm->cid_lock);
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, i);
+
+		pcpu_cid->cid = MM_CID_UNSET;
+		pcpu_cid->time = 0;
+	}
 	cpumask_clear(mm_cidmask(mm));
 }
 
+static inline int mm_alloc_cid(struct mm_struct *mm)
+{
+	mm->pcpu_cid = alloc_percpu(struct mm_cid);
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
index 63d242164b1a..530a49a2fdf3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1313,7 +1313,9 @@ struct task_struct {
 
 #ifdef CONFIG_SCHED_MM_CID
 	int				mm_cid;		/* Current cid in mm */
+	int				last_mm_cid;	/* Most recent cid in mm */
 	int				mm_cid_active;	/* Whether cid bitmap is active */
+	struct callback_head		cid_work;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..f20fc0600fcc 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -37,6 +37,11 @@ static inline void mmgrab(struct mm_struct *mm)
 	atomic_inc(&mm->mm_count);
 }
 
+static inline void smp_mb__after_mmgrab(void)
+{
+	smp_mb__after_atomic();
+}
+
 extern void __mmdrop(struct mm_struct *mm);
 
 static inline void mmdrop(struct mm_struct *mm)
diff --git a/kernel/fork.c b/kernel/fork.c
index ea332319dffe..3832bea713c4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -793,6 +793,7 @@ void __mmdrop(struct mm_struct *mm)
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
+	mm_destroy_cid(mm);
 
 	for (i = 0; i < NR_MM_COUNTERS; i++)
 		percpu_counter_destroy(&mm->rss_stat[i]);
@@ -1057,6 +1058,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 #ifdef CONFIG_SCHED_MM_CID
 	tsk->mm_cid = -1;
+	tsk->last_mm_cid = -1;
 	tsk->mm_cid_active = 0;
 #endif
 	return tsk;
@@ -1162,18 +1164,22 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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
index 0d18c3969f90..054199e2026d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4468,6 +4468,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
+	init_sched_mm_cid(p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -5114,7 +5115,6 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
-	switch_mm_cid(prev, next);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -5270,6 +5270,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 *
 	 * kernel ->   user   switch + mmdrop() active
 	 *   user ->   user   switch
+	 *
+	 * switch_mm_cid() needs to be updated if the barriers provided
+	 * by context_switch() are modified.
 	 */
 	if (!next->mm) {                                // to kernel
 		enter_lazy_tlb(prev->active_mm, next);
@@ -5299,6 +5302,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		}
 	}
 
+	/* switch_mm_cid() requires the memory barriers above. */
+	switch_mm_cid(prev, next);
+
 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
 
 	prepare_lock_switch(rq, next, rf);
@@ -5587,6 +5593,7 @@ void scheduler_tick(void)
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
+	task_tick_mm_cid(rq, curr);
 
 	rq_unlock(rq, &rf);
 
@@ -11383,45 +11390,327 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 }
 
 #ifdef CONFIG_SCHED_MM_CID
-void sched_mm_cid_exit_signals(struct task_struct *t)
+
+/**
+ * @cid_lock: Guarantee forward-progress of cid allocation.
+ *
+ * Concurrency ID allocation within a bitmap is mostly lock-free. The cid_lock
+ * is only used when contention is detected by the lock-free allocation so
+ * forward progress can be guaranteed.
+ */
+DEFINE_RAW_SPINLOCK(cid_lock);
+
+/**
+ * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
+ *
+ * When @use_cid_lock is 0, the cid allocation is lock-free. When contention is
+ * detected, it is set to 1 to ensure that all newly coming allocations are
+ * serialized by @cid_lock until the allocation which detected contention
+ * completes and sets @use_cid_lock back to 0. This guarantees forward progress
+ * of a cid allocation.
+ */
+int use_cid_lock;
+
+/*
+ * mm_cid clear-old implements a lock-free algorithm to clear per-mm/cpu cid
+ * concurrently with respect to the execution of the target runqueue context
+ * switch.
+ *
+ * There is one basic properties we want to guarantee here:
+ *
+ * (1) Clear-old should _never_ mark a per-cpu cid UNSET when it is actively
+ *     used by a task. That would lead to concurrent allocation of the cid and
+ *     userspace corruption.
+ *
+ * Provide this guarantee by introducing a Dekker memory ordering to guarantee
+ * that a pair of loads observe at least one of a pair of stores, which can be
+ * shown as:
+ *
+ *      X = Y = 0
+ *
+ *      w[X]=1          w[Y]=1
+ *      MB              MB
+ *      r[Y]=y          r[X]=x
+ *
+ * Which guarantees that x==0 && y==0 is impossible. But rather than using
+ * values 0 and 1, this algorithm cares about specific state transitions of the
+ * runqueue current task (as updated by the scheduler context switch), and the
+ * per-mm/cpu cid value.
+ *
+ * Let's introduce task (Y) which has task->mm == mm and task (N) which has
+ * task->mm != mm for the rest of the discussion. There are two scheduler state
+ * transitions on context switch we care about:
+ *
+ * (TSA) Store to rq->curr with transition from (N) to (Y)
+ *
+ * (TSB) Store to rq->curr with transition from (Y) to (N)
+ *
+ * On the clear-old side, there is one transition we care about:
+ *
+ * (TMA) cmpxchg to *pcpu_cid to set the LAZY flag
+ *
+ * There is also a transition to UNSET state which can be performed from all
+ * sides (scheduler, clear-old). It is always performed with a cmpxchg which
+ * guarantees that only a single thread will succeed:
+ *
+ * (TMB) cmpxchg to *pcpu_cid to mark UNSET
+ *
+ * Just to be clear, what we do _not_ want to happen is a transition to UNSET
+ * when a thread is actively using the cid (property (1)).
+ *
+ * Let's looks at the relevant combinations of TSA/TSB, and TMA transitions.
+ *
+ * Scenario A) (TSA)+(TMA) (from next task perspective)
+ *
+ * CPU0                                      CPU1
+ *
+ * Context switch CS-1                       Migrate-from
+ *   - store to rq->curr: (N)->(Y) (TSA)     - cmpxchg to *pcpu_id to LAZY (TMA)
+ *                                             (implied barrier after cmpxchg)
+ *   - switch_mm_cid()
+ *     - memory barrier (see switch_mm_cid()
+ *       comment explaining how this barrier
+ *       is combined with other scheduler
+ *       barriers)
+ *     - mm_cid_get (next)
+ *       - READ_ONCE(*pcpu_cid)              - rcu_dereference(src_rq->curr)
+ *
+ * This Dekker ensures that either task (Y) is observed by the
+ * rcu_dereference() or the LAZY flag is observed by READ_ONCE(), or both are
+ * observed.
+ *
+ * If task (Y) store is observed by rcu_dereference(), it means that there is
+ * still an active task on the cpu. Clear-old will therefore not transition
+ * to UNSET, which fulfills property (1).
+ *
+ * If task (Y) is not observed, but the lazy flag is observed by READ_ONCE(),
+ * it will move its state to UNSET, which clears the percpu cid perhaps
+ * uselessly (which is not an issue for correctness). Because task (Y) is not
+ * observed, CPU1 can move ahead to set the state to UNSET. Because moving
+ * state to UNSET is done with a cmpxchg expecting that the old state has the
+ * LAZY flag set, only one thread will successfully UNSET.
+ *
+ * If both states (LAZY flag and task (Y)) are observed, the thread on CPU0
+ * will observe the LAZY flag and transition to UNSET (perhaps uselessly), and
+ * CPU1 will observe task (Y) and do nothing more, which is fine.
+ *
+ * What we are effectively preventing with this Dekker is a scenario where
+ * neither LAZY flag nor store (Y) are observed, which would fail property (1)
+ * because this would UNSET a cid which is actively used.
+ */
+
+void sched_mm_cid_clear_old(struct mm_struct *mm, int cpu)
 {
-	struct mm_struct *mm = t->mm;
+	struct rq *rq = cpu_rq(cpu);
+	struct mm_cid *pcpu_cid;
+	struct task_struct *t;
 	unsigned long flags;
+	int cid, lazy_cid;
+	u64 rq_clock;
 
-	if (!mm)
+	/*
+	 * rq->clock load is racy on 32-bit but one spurious clear once in a
+	 * while is irrelevant.
+	 */
+	rq_clock = READ_ONCE(rq->clock);
+	pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu);
+	if (rq_clock < pcpu_cid->time + SCHED_MM_CID_PERIOD_NS)
+		return;
+
+	cid = READ_ONCE(pcpu_cid->cid);
+	if (!mm_cid_is_valid(cid))
+		return;
+
+	/*
+	 * If we observe an active task using the mm on this rq, there is no
+	 * need to clear the cid.
+	 */
+	rcu_read_lock();
+	t = rcu_dereference(rq->curr);
+	if (READ_ONCE(t->mm_cid_active) && t->mm == mm) {
+		rcu_read_unlock();
 		return;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * If the cpu cid is set clear the cpu cid to keep cid allocation
+	 * compact to cover the case where this task is the last task using
+	 * this mm on the source cpu. If there happens to be other tasks left
+	 * on the source cpu using this mm, the next task using this mm will
+	 * reallocate its cid on context switch.
+	 */
+	lazy_cid = mm_cid_set_lazy_put(cid);
+	if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
+		return;
+
+	/*
+	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
+	 * rq->curr->mm matches the scheduler barrier in context_switch()
+	 * between store to rq->curr and load of prev and next task's
+	 * per-mm/cpu cid.
+	 *
+	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
+	 * rq->curr->mm_cid_active matches the barrier in
+	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
+	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
+	 * load of per-mm/cpu cid.
+	 */
+
+	/*
+	 * If we observe an active task using the mm on this rq after setting
+	 * the lazy-put flag, this task will be responsible for transitioning
+	 * from lazy-put flag set to MM_CID_UNSET.
+	 */
+	rcu_read_lock();
+	t = rcu_dereference(rq->curr);
+	if (READ_ONCE(t->mm_cid_active) && t->mm == mm) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * The cid is unused, so it can be unset.
+	 * Disable interrupts to keep the window of cid ownership without rq
+	 * lock small.
+	 */
 	local_irq_save(flags);
-	mm_cid_put(mm, t->mm_cid);
-	t->mm_cid = -1;
-	t->mm_cid_active = 0;
+	if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
+		__mm_cid_put(mm, cid);
 	local_irq_restore(flags);
 }
 
+static void task_mm_cid_work(struct callback_head *work)
+{
+	struct task_struct *t = current;
+	struct mm_struct *mm;
+	int cpu;
+	unsigned long now = jiffies, old_scan, next_scan;
+
+	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
+
+	work->next = work;	/* Prevent double-add */
+	if (t->flags & PF_EXITING)
+		return;
+	mm = t->mm;
+	if (!mm)
+		return;
+	old_scan = READ_ONCE(mm->mm_cid_next_scan);
+	if (!old_scan) {
+		unsigned long res, next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
+
+		res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
+		if (res != old_scan)
+			old_scan = res;
+		else
+			old_scan = next_scan;
+	}
+	if (time_before(now, old_scan))
+		return;
+	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
+	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
+		return;
+	for_each_possible_cpu(cpu)
+		sched_mm_cid_clear_old(mm, cpu);
+}
+
+void init_sched_mm_cid(struct task_struct *t)
+{
+	int mm_users = 0;
+	struct mm_struct *mm = t->mm;
+
+	if (mm) {
+		mm_users = atomic_read(&mm->mm_users);
+		if (mm_users == 1)
+			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
+	}
+	/* Protect against double add */
+	t->cid_work.next = &t->cid_work;
+	init_task_work(&t->cid_work, task_mm_cid_work);
+}
+
+void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
+{
+	struct callback_head *work = &curr->cid_work;
+	unsigned long now = jiffies;
+
+	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
+		return;
+	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
+		return;
+	task_work_add(curr, work, TWA_RESUME);
+}
+
+void sched_mm_cid_exit_signals(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	struct rq_flags rf;
+	struct rq *rq;
+
+	if (!mm)
+		return;
+
+	preempt_disable();
+	rq = this_rq();
+	rq_lock_irqsave(rq, &rf);
+	preempt_enable_no_resched();	/* holding spinlock */
+	WRITE_ONCE(t->mm_cid_active, 0);
+	/*
+	 * Store t->mm_cid_active before loading per-mm/cpu cid.
+	 * Matches barrier in sched_mm_cid_clear_old().
+	 */
+	smp_mb();
+	mm_cid_put(mm);
+	t->last_mm_cid = t->mm_cid = -1;
+	rq_unlock_irqrestore(rq, &rf);
+}
+
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
-	t->mm_cid = -1;
-	t->mm_cid_active = 0;
-	local_irq_restore(flags);
+
+	preempt_disable();
+	rq = this_rq();
+	rq_lock_irqsave(rq, &rf);
+	preempt_enable_no_resched();	/* holding spinlock */
+	WRITE_ONCE(t->mm_cid_active, 0);
+	/*
+	 * Store t->mm_cid_active before loading per-mm/cpu cid.
+	 * Matches barrier in sched_mm_cid_clear_old().
+	 */
+	smp_mb();
+	mm_cid_put(mm);
+	t->last_mm_cid = t->mm_cid = -1;
+	rq_unlock_irqrestore(rq, &rf);
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
-	t->mm_cid_active = 1;
-	local_irq_restore(flags);
+
+	preempt_disable();
+	rq = this_rq();
+	rq_lock_irqsave(rq, &rf);
+	preempt_enable_no_resched();	/* holding spinlock */
+	WRITE_ONCE(t->mm_cid_active, 1);
+	/*
+	 * Store t->mm_cid_active before loading per-mm/cpu cid.
+	 * Matches barrier in sched_mm_cid_clear_old().
+	 */
+	smp_mb();
+	t->last_mm_cid = t->mm_cid = mm_cid_get(mm);
+	rq_unlock_irqrestore(rq, &rf);
 	rseq_set_notify_resume(t);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..fad8da4e50c1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3249,61 +3249,226 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
 }
 
 #ifdef CONFIG_SCHED_MM_CID
-static inline int __mm_cid_get(struct mm_struct *mm)
+
+#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
+#define MM_CID_SCAN_DELAY	100			/* 100ms */
+
+extern raw_spinlock_t cid_lock;
+extern int use_cid_lock;
+
+extern void init_sched_mm_cid(struct task_struct *t);
+extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
+
+static inline void __mm_cid_put(struct mm_struct *mm, int cid)
+{
+	if (cid < 0)
+		return;
+	cpumask_clear_cpu(cid, mm_cidmask(mm));
+}
+
+/*
+ * The per-mm/cpu cid can have the MM_CID_LAZY_PUT flag set or transition to the
+ * MM_CID_UNSET state without holding the rq lock, but the rq lock needs to be
+ * held to transition to other states.
+ */
+static inline void mm_cid_put_lazy(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	struct mm_cid *pcpu_cid;
+	int cid;
+
+	lockdep_assert_rq_held(this_rq());
+	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
+	cid = READ_ONCE(pcpu_cid->cid);
+	if (!mm_cid_is_lazy_put(cid))
+		return;
+	if (!try_cmpxchg(&pcpu_cid->cid, &cid, MM_CID_UNSET))
+		return;
+	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+}
+
+static inline void mm_cid_put(struct mm_struct *mm)
+{
+	struct mm_cid *pcpu_cid;
+	int cid, res;
+
+	lockdep_assert_rq_held(this_rq());
+	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
+	cid = READ_ONCE(pcpu_cid->cid);
+	for (;;) {
+		if (mm_cid_is_unset(cid))
+			return;
+		/*
+		 * Attempt transition from valid or lazy-put to unset.
+		 */
+		res = cmpxchg(&pcpu_cid->cid, cid, MM_CID_UNSET);
+		if (res == cid)
+			break;
+		cid = res;
+	}
+	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+}
+
+static inline int __mm_cid_try_get(struct mm_struct *mm)
 {
 	struct cpumask *cpumask;
 	int cid;
 
 	cpumask = mm_cidmask(mm);
-	cid = cpumask_first_zero(cpumask);
-	if (cid >= nr_cpu_ids)
+	/*
+	 * Retry finding first zero bit if the mask is temporarily
+	 * filled. This only happens during concurrent clear-old
+	 * which owns a cid without holding a rq lock.
+	 */
+	for (;;) {
+		cid = cpumask_first_zero(cpumask);
+		if (cid < nr_cpu_ids)
+			break;
+		cpu_relax();
+	}
+	if (cpumask_test_and_set_cpu(cid, cpumask))
 		return -1;
-	__cpumask_set_cpu(cid, cpumask);
 	return cid;
 }
 
-static inline void mm_cid_put(struct mm_struct *mm, int cid)
+static inline void mm_cid_snapshot_time(struct mm_struct *mm)
 {
-	lockdep_assert_irqs_disabled();
-	if (cid < 0)
-		return;
-	raw_spin_lock(&mm->cid_lock);
-	__cpumask_clear_cpu(cid, mm_cidmask(mm));
-	raw_spin_unlock(&mm->cid_lock);
+	struct rq *rq = this_rq();
+	struct mm_cid *pcpu_cid;
+
+	lockdep_assert_rq_held(rq);
+	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
+	WRITE_ONCE(pcpu_cid->time, rq->clock);
+}
+
+static inline int __mm_cid_get(struct mm_struct *mm)
+{
+	int cid;
+
+	if (!READ_ONCE(use_cid_lock)) {
+		cid = __mm_cid_try_get(mm);
+		if (cid >= 0)
+			goto end;
+		raw_spin_lock(&cid_lock);
+	} else {
+		raw_spin_lock(&cid_lock);
+		cid = __mm_cid_try_get(mm);
+		if (cid >= 0)
+			goto unlock;
+	}
+
+	/*
+	 * cid concurrently allocated. Retry while forcing following
+	 * allocations to use the cid_lock to ensure forward progress.
+	 */
+	WRITE_ONCE(use_cid_lock, 1);
+	/*
+	 * Set use_cid_lock before allocation. Only care about program order
+	 * because this is for forward progress.
+	 */
+	barrier();
+	/*
+	 * Retry until it succeeds. It is guaranteed to eventually
+	 * succeed once all newcoming allocations observe the
+	 * use_cid_lock flag set.
+	 */
+	do {
+		cid = __mm_cid_try_get(mm);
+	} while (cid < 0);
+	/*
+	 * Allocate before clearing use_cid_lock. Only care about
+	 * program order because this is for forward progress.
+	 */
+	barrier();
+	WRITE_ONCE(use_cid_lock, 0);
+unlock:
+	raw_spin_unlock(&cid_lock);
+end:
+	mm_cid_snapshot_time(mm);
+	return cid;
 }
 
 static inline int mm_cid_get(struct mm_struct *mm)
 {
-	int ret;
+	struct rq *rq = this_rq();
+	struct mm_cid *pcpu_cid;
+	struct cpumask *cpumask;
+	int cid;
 
-	lockdep_assert_irqs_disabled();
-	raw_spin_lock(&mm->cid_lock);
-	ret = __mm_cid_get(mm);
-	raw_spin_unlock(&mm->cid_lock);
-	return ret;
+	lockdep_assert_rq_held(rq);
+	cpumask = mm_cidmask(mm);
+	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
+	cid = READ_ONCE(pcpu_cid->cid);
+	if (mm_cid_is_valid(cid)) {
+		if (rq->clock > pcpu_cid->time + SCHED_MM_CID_PERIOD_NS) {
+			int first_zero = cpumask_first_zero(cpumask);
+
+			if (first_zero != -1 && first_zero < cid) {
+				/* Reallocate for compactness. */
+				mm_cid_put(mm);
+				goto allocate;
+			} else {
+				mm_cid_snapshot_time(mm);
+			}
+		}
+		return cid;
+	}
+	if (mm_cid_is_lazy_put(cid)) {
+		if (try_cmpxchg(&pcpu_cid->cid, &cid, MM_CID_UNSET))
+			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+	}
+allocate:
+	cid = __mm_cid_get(mm);
+	WRITE_ONCE(pcpu_cid->cid, cid);
+	return cid;
 }
 
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
 {
+	/*
+	 * Provide a memory barrier between rq->curr store and load of
+	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
+	 *
+	 * Should be adapted if context_switch() is modified.
+	 */
+	if (!next->mm) {                                // to kernel
+		/*
+		 * user -> kernel transition does not guarantee a barrier, but
+		 * we can use the fact that it performs an atomic operation in
+		 * mmgrab().
+		 */
+		if (prev->mm)                           // from user
+			smp_mb__after_mmgrab();
+		/*
+		 * kernel -> kernel transition does not change rq->curr->mm
+		 * state. It stays NULL.
+		 */
+	} else {                                        // to user
+		/*
+		 * kernel -> user transition does not provide a barrier
+		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
+		 * Provide it here.
+		 */
+		if (!prev->mm)                          // from kernel
+			smp_mb();
+		/*
+		 * user -> user transition guarantees a memory barrier through
+		 * switch_mm() when current->mm changes. If current->mm is
+		 * unchanged, no barrier is needed.
+		 */
+	}
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
+		mm_cid_put_lazy(prev);
 		prev->mm_cid = -1;
 	}
 	if (next->mm_cid_active)
-		next->mm_cid = mm_cid_get(next->mm);
+		next->last_mm_cid = next->mm_cid = mm_cid_get(next->mm);
 }
 
 #else
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
+static inline void init_sched_mm_cid(struct task_struct *t) { }
+static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
 #endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.25.1

