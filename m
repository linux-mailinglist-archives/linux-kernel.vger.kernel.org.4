Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E782C6E7EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjDSPu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjDSPuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:50:46 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45660AD02
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681919416;
        bh=E/qU2CCtUlZDFCZ2IkUa6uWLS5UI5BC/xq5EMwVZaoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuZClFhF8stX3fY6qOfgQ87nOb5xIuvbIkngJLJdM85gc2kxAZJbzZFwWCvBYtmjA
         b14S5rmC851mdpkX2AW+n9m4H54YH89IIeJUZZDIQOa4vnwi/b2B4vyqEh3qzARm9E
         p+MEnqV4ukAhwjIzGOMfRcgSGLdBeWeTA71HeeQzexlXxM35dQ51qqgeuVYfVWenh2
         eA031J2tm7I7EiqJAB25zLKbKFSdgPMhKD9SK9G9HlfxpZdYssLttSzKIuvs2ZKque
         9ejxgchecYKp18NVxZCr19L2KxcWji/LQT+cxNYdubk/ztzZR4MgCum0oQoJoymalz
         HlyYa71/5R8vQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q1lc838MnzvrN;
        Wed, 19 Apr 2023 11:50:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com
Subject: [RFC PATCH v9 2/2] sched: Fix performance regression introduced by mm_cid
Date:   Wed, 19 Apr 2023 11:50:12 -0400
Message-Id: <20230419155012.63901-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419155012.63901-1-mathieu.desnoyers@efficios.com>
References: <20230419155012.63901-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
sched_mm_cid_migrate_to() (with destination runqueue lock held) in
activate_task() for migrating tasks. If the destination cpu's mm_cid is
unset, and if the source runqueue is not actively using its mm_cid, then
the source cpu's mm_cid is moved to the destination cpu on migration.

Introduce a task-work executed periodically, similarly to NUMA work,
which delays reclaim of cid values when they are unused for a period of
time.

Keep track of the allocation time for each per-cpu cid, and let the task
work clear them when they are observed to be older than
SCHED_MM_CID_PERIOD_NS and unused. This task work also clears all
mm_cids which are greater or equal to the Hamming weight of the mm
cidmask to keep concurrency ids compact.

Because we want to ensure the mm_cid converges towards the smaller
values as migrations happen, the prior optimization that was done when
context switching between threads belonging to the same mm is removed,
because it could delay the lazy release of the destination runqueue
mm_cid after it has been replaced by a migration. Removing this prior
optimization is not an issue performance-wise because the introduced
per-mm/per-cpu mm_cid tracking also covers this more specific case.

This patch is based on v6.3-rc7 with this patch applied:

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
Changes since v8:
- In order to take care of infrequently scheduled tasks, bump the time
  snapshot associated with old cids if an active task using the mm is
  observed on their associated rq.
- Eliminate this_cpu_ptr() overhead on fast-paths by using
  __this_cpu_read() and __this_cpu_write().
- Eliminate duplicated this_cpu_ptr() by handing the resulting pointer
  as argument to the callees in sched_mm_cid_migrate_to and
  sched_mm_cid_remote_clear.

Changes since v7:
- Call sched_mm_cid_migrate_to() for try-to-wake-up migrations as well,
- Remove next_scan bogus variable which shadows actual initialized
  variable. Fixed issue reported by kernel test robot,
- Clear the src_cid in sched_mm_cid_migrate_to() in situations where the
  dst_cid is already set to prevent over-allocation of cids in frequent
  migration scenarios when atomic_read(&mm->mm_users) < t->nr_cpus_allowed.
- Rebase on v6.3-rc7.

Changes since v6:
- Reintroduce migrate-to hook to hand-off cid from source to destination
  runqueue. This ensures that a single-threaded process always observes
  mm_cid==0 when migrating across CPUs.
- Ensure compactness of mm_cid in task-work by clearing mm_cid per-cpu
  entries that are above the Hamming weight of the mm cidmask.

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
 include/linux/mm_types.h |  82 +++++-
 include/linux/sched.h    |   3 +
 include/linux/sched/mm.h |   5 +
 kernel/fork.c            |   9 +-
 kernel/sched/core.c      | 524 +++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h     | 235 +++++++++++++++---
 6 files changed, 803 insertions(+), 55 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a57e6ae78e65..5eab61156f0e 100644
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
@@ -600,15 +607,19 @@ struct mm_struct {
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
+		/*
+		 * @mm_cid_next_scan: Next mm_cid scan (in jiffies).
+		 *
+		 * When the next mm_cid scan is due (in jiffies).
+		 */
+		unsigned long mm_cid_next_scan;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -873,6 +884,37 @@ static inline void vma_iter_init(struct vma_iterator *vmi,
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
@@ -886,16 +928,40 @@ static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 
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
index 63d242164b1a..41c24f406fcf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1313,7 +1313,10 @@ struct task_struct {
 
 #ifdef CONFIG_SCHED_MM_CID
 	int				mm_cid;		/* Current cid in mm */
+	int				last_mm_cid;	/* Most recent cid in mm */
+	int				migrate_from_cpu;
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
index ea332319dffe..ff198be38a11 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -793,6 +793,7 @@ void __mmdrop(struct mm_struct *mm)
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
+	mm_destroy_cid(mm);
 
 	for (i = 0; i < NR_MM_COUNTERS; i++)
 		percpu_counter_destroy(&mm->rss_stat[i]);
@@ -1057,7 +1058,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 #ifdef CONFIG_SCHED_MM_CID
 	tsk->mm_cid = -1;
+	tsk->last_mm_cid = -1;
 	tsk->mm_cid_active = 0;
+	tsk->migrate_from_cpu = -1;
 #endif
 	return tsk;
 
@@ -1162,18 +1165,22 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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
index 0d18c3969f90..c6e2dd8f4ee3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2086,6 +2086,8 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (task_on_rq_migrating(p))
 		flags |= ENQUEUE_MIGRATED;
+	if (flags & ENQUEUE_MIGRATED)
+		sched_mm_cid_migrate_to(rq, p);
 
 	enqueue_task(rq, p, flags);
 
@@ -3195,6 +3197,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
 		rseq_migrate(p);
+		sched_mm_cid_migrate_from(p);
 		perf_event_task_migrate(p);
 	}
 
@@ -4468,6 +4471,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
+	init_sched_mm_cid(p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -5114,7 +5118,6 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
-	switch_mm_cid(prev, next);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -5270,6 +5273,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 *
 	 * kernel ->   user   switch + mmdrop() active
 	 *   user ->   user   switch
+	 *
+	 * switch_mm_cid() needs to be updated if the barriers provided
+	 * by context_switch() are modified.
 	 */
 	if (!next->mm) {                                // to kernel
 		enter_lazy_tlb(prev->active_mm, next);
@@ -5299,6 +5305,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		}
 	}
 
+	/* switch_mm_cid() requires the memory barriers above. */
+	switch_mm_cid(prev, next);
+
 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
 
 	prepare_lock_switch(rq, next, rf);
@@ -5587,6 +5596,7 @@ void scheduler_tick(void)
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
+	task_tick_mm_cid(rq, curr);
 
 	rq_unlock(rq, &rf);
 
@@ -11383,45 +11393,525 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
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
+ * mm_cid remote-clear implements a lock-free algorithm to clear per-mm/cpu cid
+ * concurrently with respect to the execution of the source runqueue context
+ * switch.
+ *
+ * There is one basic properties we want to guarantee here:
+ *
+ * (1) Remote-clear should _never_ mark a per-cpu cid UNSET when it is actively
+ * used by a task. That would lead to concurrent allocation of the cid and
+ * userspace corruption.
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
+ * On the remote-clear side, there is one transition we care about:
+ *
+ * (TMA) cmpxchg to *pcpu_cid to set the LAZY flag
+ *
+ * There is also a transition to UNSET state which can be performed from all
+ * sides (scheduler, remote-clear). It is always performed with a cmpxchg which
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
+ * Context switch CS-1                       Remote-clear
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
+ * still an active task on the cpu. Remote-clear will therefore not transition
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
+void sched_mm_cid_migrate_from(struct task_struct *t)
+{
+	t->migrate_from_cpu = task_cpu(t);
+}
+
+static
+int __sched_mm_cid_migrate_from_fetch_cid(struct rq *src_rq,
+					  struct task_struct *t,
+					  struct mm_cid *src_pcpu_cid)
 {
 	struct mm_struct *mm = t->mm;
-	unsigned long flags;
+	struct task_struct *src_task;
+	int src_cid, last_mm_cid;
 
 	if (!mm)
+		return -1;
+
+	last_mm_cid = t->last_mm_cid;
+	/*
+	 * If the migrated task has no last cid, or if the current
+	 * task on src rq uses the cid, it means the source cid does not need
+	 * to be moved to the destination cpu.
+	 */
+	if (last_mm_cid == -1)
+		return -1;
+	src_cid = READ_ONCE(src_pcpu_cid->cid);
+	if (!mm_cid_is_valid(src_cid) || last_mm_cid != src_cid)
+		return -1;
+
+	/*
+	 * If we observe an active task using the mm on this rq, it means we
+	 * are not the last task to be migrated from this cpu for this mm, so
+	 * there is no need to move src_cid to the destination cpu.
+	 */
+	rcu_read_lock();
+	src_task = rcu_dereference(src_rq->curr);
+	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
+		rcu_read_unlock();
+		t->last_mm_cid = -1;
+		return -1;
+	}
+	rcu_read_unlock();
+
+	return src_cid;
+}
+
+static
+int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
+					      struct task_struct *t,
+					      struct mm_cid *src_pcpu_cid,
+					      int src_cid)
+{
+	struct task_struct *src_task;
+	struct mm_struct *mm = t->mm;
+	int lazy_cid;
+
+	if (src_cid == -1)
+		return -1;
+
+	/*
+	 * Attempt to clear the source cpu cid to move it to the destination
+	 * cpu.
+	 */
+	lazy_cid = mm_cid_set_lazy_put(src_cid);
+	if (!try_cmpxchg(&src_pcpu_cid->cid, &src_cid, lazy_cid))
+		return -1;
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
+	src_task = rcu_dereference(src_rq->curr);
+	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
+		rcu_read_unlock();
+		/*
+		 * We observed an active task for this mm, there is therefore
+		 * no point in moving this cid to the destination cpu.
+		 */
+		t->last_mm_cid = -1;
+		return -1;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * The src_cid is unused, so it can be unset.
+	 */
+	if (!try_cmpxchg(&src_pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
+		return -1;
+	return src_cid;
+}
+
+/*
+ * Migration to dst cpu. Called with dst_rq lock held.
+ * Interrupts are disabled, which keeps the window of cid ownership without the
+ * source rq lock held small.
+ */
+void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
+{
+	struct mm_cid *src_pcpu_cid, *dst_pcpu_cid;
+	struct mm_struct *mm = t->mm;
+	int src_cid, dst_cid, src_cpu;
+	struct rq *src_rq;
+
+	lockdep_assert_rq_held(dst_rq);
+
+	if (!mm)
+		return;
+	src_cpu = t->migrate_from_cpu;
+	if (src_cpu == -1) {
+		t->last_mm_cid = -1;
+		return;
+	}
+	/*
+	 * Move the src cid if the dst cid is unset. This keeps id
+	 * allocation closest to 0 in cases where few threads migrate around
+	 * many cpus.
+	 *
+	 * If destination cid is already set, we may have to just clear
+	 * the src cid to ensure compactness in frequent migrations
+	 * scenarios.
+	 *
+	 * It is not useful to clear the src cid when the number of threads is
+	 * greater or equal to the number of allowed cpus, because user-space
+	 * can expect that the number of allowed cids can reach the number of
+	 * allowed cpus.
+	 */
+	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
+	dst_cid = READ_ONCE(dst_pcpu_cid->cid);
+	if (!mm_cid_is_unset(dst_cid) &&
+	    atomic_read(&mm->mm_users) >= t->nr_cpus_allowed)
+		return;
+	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, src_cpu);
+	src_rq = cpu_rq(src_cpu);
+	src_cid = __sched_mm_cid_migrate_from_fetch_cid(src_rq, t, src_pcpu_cid);
+	if (src_cid == -1)
+		return;
+	src_cid = __sched_mm_cid_migrate_from_try_steal_cid(src_rq, t, src_pcpu_cid,
+							    src_cid);
+	if (src_cid == -1)
+		return;
+	if (!mm_cid_is_unset(dst_cid)) {
+		__mm_cid_put(mm, src_cid);
+		return;
+	}
+	/* Move src_cid to dst cpu. */
+	mm_cid_snapshot_time(mm);
+	WRITE_ONCE(dst_pcpu_cid->cid, src_cid);
+}
+
+static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_cid,
+				      int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct task_struct *t;
+	unsigned long flags;
+	int cid, lazy_cid;
+
+	cid = READ_ONCE(pcpu_cid->cid);
+	if (!mm_cid_is_valid(cid))
 		return;
+
+	/*
+	 * Clear the cpu cid if it is set to keep cid allocation compact.  If
+	 * there happens to be other tasks left on the source cpu using this
+	 * mm, the next task using this mm will reallocate its cid on context
+	 * switch.
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
+	 * the lazy-put flag, that task will be responsible for transitioning
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
 
+static void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct mm_cid *pcpu_cid;
+	struct task_struct *curr;
+	u64 rq_clock;
+
+	/*
+	 * rq->clock load is racy on 32-bit but one spurious clear once in a
+	 * while is irrelevant.
+	 */
+	rq_clock = READ_ONCE(rq->clock);
+	pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu);
+
+	/*
+	 * In order to take care of infrequently scheduled tasks, bump the time
+	 * snapshot associated with this cid if an active task using the mm is
+	 * observed on this rq.
+	 */
+	rcu_read_lock();
+	curr = rcu_dereference(rq->curr);
+	if (READ_ONCE(curr->mm_cid_active) && curr->mm == mm) {
+		WRITE_ONCE(pcpu_cid->time, rq_clock);
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	if (rq_clock < pcpu_cid->time + SCHED_MM_CID_PERIOD_NS)
+		return;
+	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
+}
+
+static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
+					     int weight)
+{
+	struct mm_cid *pcpu_cid;
+	int cid;
+
+	pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu);
+	cid = READ_ONCE(pcpu_cid->cid);
+	if (!mm_cid_is_valid(cid) || cid < weight)
+		return;
+	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
+}
+
+static void task_mm_cid_work(struct callback_head *work)
+{
+	struct task_struct *t = current;
+	struct mm_struct *mm;
+	int cpu;
+	unsigned long now = jiffies, old_scan, next_scan;
+	struct cpumask *cidmask;
+	int weight;
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
+	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
+	if (!old_scan) {
+		unsigned long res;
+
+		res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
+		if (res != old_scan)
+			old_scan = res;
+		else
+			old_scan = next_scan;
+	}
+	if (time_before(now, old_scan))
+		return;
+	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
+		return;
+	cidmask = mm_cidmask(mm);
+	/* Clear cids that were not recently used. */
+	for_each_possible_cpu(cpu)
+		sched_mm_cid_remote_clear_old(mm, cpu);
+	weight = cpumask_weight(cidmask);
+	/*
+	 * Clear cids that are greater or equal to the cidmask weight to
+	 * recompact it.
+	 */
+	for_each_possible_cpu(cpu)
+		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
+}
+
+void init_sched_mm_cid(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	int mm_users = 0;
+
+	if (mm) {
+		mm_users = atomic_read(&mm->mm_users);
+		if (mm_users == 1)
+			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
+	}
+	t->cid_work.next = &t->cid_work;	/* Protect against double add */
+	init_task_work(&t->cid_work, task_mm_cid_work);
+}
+
+void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
+{
+	struct callback_head *work = &curr->cid_work;
+	unsigned long now = jiffies;
+
+	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
+	    work->next != work)
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
+	 * Matches barrier in sched_mm_cid_remote_clear_old().
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
+	 * Matches barrier in sched_mm_cid_remote_clear_old().
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
+	 * Matches barrier in sched_mm_cid_remote_clear_old().
+	 */
+	smp_mb();
+	t->last_mm_cid = t->mm_cid = mm_cid_get(mm);
+	rq_unlock_irqrestore(rq, &rf);
 	rseq_set_notify_resume(t);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..d1d470441422 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3249,61 +3249,238 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
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
+extern void sched_mm_cid_migrate_from(struct task_struct *t);
+extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
+extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
+extern void init_sched_mm_cid(struct task_struct *t);
+
+static inline void __mm_cid_put(struct mm_struct *mm, int cid)
+{
+	if (cid < 0)
+		return;
+	cpumask_clear_cpu(cid, mm_cidmask(mm));
+}
+
+/*
+ * The per-mm/cpu cid can have the MM_CID_LAZY_PUT flag set or transition to
+ * the MM_CID_UNSET state without holding the rq lock, but the rq lock needs to
+ * be held to transition to other states.
+ *
+ * State transitions synchronized with cmpxchg or try_cmpxchg need to be
+ * consistent across cpus, which prevents use of this_cpu_cmpxchg.
+ */
+static inline void mm_cid_put_lazy(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
+	int cid;
+
+	lockdep_assert_rq_held(this_rq());
+	cid = __this_cpu_read(pcpu_cid->cid);
+	if (!mm_cid_is_lazy_put(cid) ||
+	    !try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
+		return;
+	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+}
+
+static inline int mm_cid_pcpu_unset(struct mm_struct *mm)
+{
+	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
+	int cid, res;
+
+	lockdep_assert_rq_held(this_rq());
+	cid = __this_cpu_read(pcpu_cid->cid);
+	for (;;) {
+		if (mm_cid_is_unset(cid))
+			return MM_CID_UNSET;
+		/*
+		 * Attempt transition from valid or lazy-put to unset.
+		 */
+		res = cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, cid, MM_CID_UNSET);
+		if (res == cid)
+			break;
+		cid = res;
+	}
+	return cid;
+}
+
+static inline void mm_cid_put(struct mm_struct *mm)
+{
+	int cid;
+
+	lockdep_assert_rq_held(this_rq());
+	cid = mm_cid_pcpu_unset(mm);
+	if (cid == MM_CID_UNSET)
+		return;
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
+	 * filled. This only happens during concurrent remote-clear
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
+/*
+ * Save a snapshot of the current runqueue time of this cpu
+ * with the per-cpu cid value, allowing to estimate how recently it was used.
+ */
+static inline void mm_cid_snapshot_time(struct mm_struct *mm)
 {
-	lockdep_assert_irqs_disabled();
-	if (cid < 0)
-		return;
-	raw_spin_lock(&mm->cid_lock);
-	__cpumask_clear_cpu(cid, mm_cidmask(mm));
-	raw_spin_unlock(&mm->cid_lock);
+	struct rq *rq = this_rq();
+
+	lockdep_assert_rq_held(rq);
+	__this_cpu_write(mm->pcpu_cid->time, rq->clock);
+}
+
+static inline int __mm_cid_get(struct mm_struct *mm)
+{
+	int cid;
+
+	/*
+	 * All allocations (even those using the cid_lock) are lock-free. If
+	 * use_cid_lock is set, hold the cid_lock to perform cid allocation to
+	 * guarantee forward progress.
+	 */
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
+	 * because this is only required for forward progress.
+	 */
+	barrier();
+	/*
+	 * Retry until it succeeds. It is guaranteed to eventually succeed once
+	 * all newcoming allocations observe the use_cid_lock flag set.
+	 */
+	do {
+		cid = __mm_cid_try_get(mm);
+		cpu_relax();
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
+	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
+	struct rq *rq = this_rq();
+	struct cpumask *cpumask;
+	int cid;
 
-	lockdep_assert_irqs_disabled();
-	raw_spin_lock(&mm->cid_lock);
-	ret = __mm_cid_get(mm);
-	raw_spin_unlock(&mm->cid_lock);
-	return ret;
+	lockdep_assert_rq_held(rq);
+	cpumask = mm_cidmask(mm);
+	cid = __this_cpu_read(pcpu_cid->cid);
+	if (mm_cid_is_valid(cid)) {
+		mm_cid_snapshot_time(mm);
+		return cid;
+	}
+	if (mm_cid_is_lazy_put(cid)) {
+		if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
+			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+	}
+	cid = __mm_cid_get(mm);
+	__this_cpu_write(pcpu_cid->cid, cid);
+	return cid;
 }
 
-static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
+static inline void switch_mm_cid(struct task_struct *prev,
+				 struct task_struct *next)
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
+		mm_cid_snapshot_time(prev->mm);
+		mm_cid_put_lazy(prev);
 		prev->mm_cid = -1;
 	}
 	if (next->mm_cid_active)
-		next->mm_cid = mm_cid_get(next->mm);
+		next->last_mm_cid = next->mm_cid = mm_cid_get(next->mm);
 }
 
 #else
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
+static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
+static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
+static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
+static inline void init_sched_mm_cid(struct task_struct *t) { }
 #endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.25.1

