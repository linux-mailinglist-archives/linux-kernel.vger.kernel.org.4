Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224216DC823
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjDJPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDJPCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:02:01 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B4055AF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681138914;
        bh=9wzSiauRR/bNWzENq57aLLletG5piM/76bL2A6cOH4E=;
        h=From:To:Cc:Subject:Date:From;
        b=tv+74s+JDiNzl8yMJoMfXnfzDKGL6b+5idsWiVIEo6yCsjtk4xAwMoNJSvBcwbhD+
         AgL9nWRnnOwuuTij2kEJFhS4w7YVHlJrKwV2h8Qvrz/3poDOEUC0VbDzvxd4Ja7Prc
         z+GFLi6+QjITgygJTa49JCWF60fejnaGHfCyPKDxIJI38beD6HPJJWS8a3wnyr/ELg
         M9lFLIUJPfgDoZKls4bz54LWzlaOLXGs2yc5gqy+C5PrxUPg42xaf8fGnfn54bkjVi
         zXSu+QlvZlqF6CsMpXH3GRND/GyCGGUzacnrcK0ZL8uJhv+RKkrljuKLYo/lC/jURz
         4MUzu0gbCqikA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PwByT74VpzvWx;
        Mon, 10 Apr 2023 11:01:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com
Subject: [RFC PATCH v4] sched: Fix performance regression introduced by mm_cid
Date:   Mon, 10 Apr 2023 11:01:50 -0400
Message-Id: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
sched_mm_cid_migrate_from() in set_task_cpu() and to
sched_mm_cid_migrate_to() (with destination runqueue lock held) in
activate_task() for migrating tasks. set_task_cpu() is invoked with and
without source rq lock held: the wakeup path does not hold the source rq
lock.

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
 include/linux/mm_types.h |  60 +++++++
 include/linux/sched.h    |   1 +
 include/linux/sched/mm.h |   5 +
 kernel/fork.c            |   8 +-
 kernel/sched/core.c      | 361 ++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h     | 137 ++++++++++++---
 6 files changed, 530 insertions(+), 42 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a57e6ae78e65..4160ff5c6ebd 100644
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
@@ -873,6 +881,37 @@ static inline void vma_iter_init(struct vma_iterator *vmi,
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
@@ -886,16 +925,37 @@ static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 
 static inline void mm_init_cid(struct mm_struct *mm)
 {
+	int i;
+
 	raw_spin_lock_init(&mm->cid_lock);
+	for_each_possible_cpu(i)
+		*per_cpu_ptr(mm->pcpu_cid, i) = MM_CID_UNSET;
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
index 0d18c3969f90..425766cc1300 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2084,8 +2084,10 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (task_on_rq_migrating(p))
+	if (task_on_rq_migrating(p)) {
 		flags |= ENQUEUE_MIGRATED;
+		sched_mm_cid_migrate_to(rq, p);
+	}
 
 	enqueue_task(rq, p, flags);
 
@@ -3195,6 +3197,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
 		rseq_migrate(p);
+		sched_mm_cid_migrate_from(p);
 		perf_event_task_migrate(p);
 	}
 
@@ -5114,7 +5117,6 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
-	switch_mm_cid(prev, next);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -5270,6 +5272,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 *
 	 * kernel ->   user   switch + mmdrop() active
 	 *   user ->   user   switch
+	 *
+	 * switch_mm_cid() needs to be updated if the barriers provided
+	 * by context_switch() are modified.
 	 */
 	if (!next->mm) {                                // to kernel
 		enter_lazy_tlb(prev->active_mm, next);
@@ -5299,6 +5304,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		}
 	}
 
+	/* switch_mm_cid() requires the memory barriers above. */
+	switch_mm_cid(prev, next);
+
 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
 
 	prepare_lock_switch(rq, next, rf);
@@ -11383,45 +11391,360 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 }
 
 #ifdef CONFIG_SCHED_MM_CID
+
+/*
+ * mm_cid migrate-from implements a lock-free algorithm to clear per-mm/cpu cid
+ * concurrently with respect to the execution of the source runqueue context
+ * switch.
+ *
+ * There are two basic properties we want is to guarantee here:
+ *
+ * (1) Migrate-from should _never_ mark a per-cpu cid UNSET when it is actively
+ *     used by a task. That would lead to concurrent allocation of the cid and
+ *     userspace corruption.
+ *
+ * (2) Migrate-from should ideally not leak a cid value when there are no more
+ *     tasks using it on the cpu. This ensures we keep cid allocations as
+ *     compact as possible (closest to 0). Getting this wrong will not cause
+ *     userspace corruption, just a less compact id allocation.
+ *
+ * Provide those guarantees by introducing a Dekker memory ordering to
+ * guarantee that a pair of loads observe at least one of a pair of stores,
+ * which can be shown as:
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
+ * Let's introduce task (Y) which has mm == src_task->mm and task (N) which has
+ * mm != src_task->mm for the rest of the discussion. There are two scheduler
+ * state transitions on context switch we care about:
+ *
+ * (TSA) Store to rq->curr with transition from (N) to (Y)
+ *
+ * (TSB) Store to rq->curr with transition from (Y) to (N)
+ *
+ * On the migrate-from side, there is one transition we care about:
+ *
+ * (TMA) cmpxchg to *pcpu_cid to set the LAZY flag
+ *
+ * There is also a transition to UNSET state which can be performed from all
+ * sides (scheduler, migrate-from). It is always performed with a cmpxchg which
+ * guarantees that only a single thread will succeed:
+ *
+ * (TMB) cmpxchg to *pcpu_cid to mark UNSET
+ *
+ * Just to be clear, what we do _not_ want to happen is a transition to UNSET
+ * when a thread is actively using the cid (property (1)). And ideally we do
+ * not want to leak a cid after migrating the last task from a cpu (property
+ * (2)).
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
+ * still an active task on the cpu. Migrate-from will therefore not transition
+ * to UNSET, which fulfills property (1). That observed task will itself
+ * eventually need a migrate-from to be migrated away from that cpu, which
+ * fulfills property (2).
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
+ *
+ *
+ * Scenario B) (TSB)+(TMA) (from prev task perspective)
+ *
+ * CPU0                                      CPU1
+ *
+ * Context switch CS-1                       Migrate-from
+ *   - store to rq->curr: (Y)->(N) (TSB)     - cmpxchg to *pcpu_id to LAZY (TMA)
+ *                                           (implied barrier after cmpxchg)
+ *   - switch_mm_cid()
+ *     - memory barrier (see switch_mm_cid()
+ *       comment explaining how this barrier
+ *       is combined with other scheduler
+ *       barriers)
+ *     - cid_put_lazy() (prev)
+ *       - READ_ONCE(*pcpu_cid)              - rcu_dereference(src_rq->curr)
+ *
+ * This Dekker ensures that either task (N) is observed by the
+ * rcu_dereference() or the LAZY flag is observed by READ_ONCE(), or both are
+ * observed.
+ *
+ * If rcu_dereference observes (N) but LAZY is not observed, migrate-from will
+ * take care to advance the state to UNSET, thus fulfilling property (2).
+ * Because (Y) is not running anymore property (1) is fulfilled.
+ *
+ * If rcu_dereference does not observe (N), but LAZY is observed, migrate-from
+ * does not advance to UNSET because it observes (Y), but LAZY flag will make
+ * the task on CPU0 take care of advancing the state to UNSET, thus fulfilling
+ * property (2).
+ *
+ * If both (N) and LAZY are observed, both migrate-from and CPU0 will try to
+ * advance the state to UNSET, but only one will succeed its cmpxchg.
+ *
+ * What we are effectively preventing with this Dekker is a scenario where
+ * neither LAZY flag nor store (N) are observed, which would fail property (2)
+ * because it would leak a cid on a cpu that has no task left using the
+ * mm.
+ */
+
+/*
+ * Migration from src cpu. Called from set_task_cpu(). There are no guarantees
+ * that the rq lock is held.
+ */
+void sched_mm_cid_migrate_from(struct task_struct *t)
+{
+	int src_cid, *src_pcpu_cid, last_mm_cid;
+	struct mm_struct *mm = t->mm;
+	struct rq *src_rq;
+	struct task_struct *src_task;
+
+	if (!mm)
+		return;
+
+	last_mm_cid = t->last_mm_cid;
+	/*
+	 * If the migrated task has no last cid, or if the current
+	 * task on src rq uses the cid, it means the destination cpu
+	 * does not have to reallocate its cid to keep the cid allocation
+	 * compact.
+	 */
+	if (last_mm_cid == -1)
+		return;
+
+	src_rq = task_rq(t);
+	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(src_rq));
+	src_cid = READ_ONCE(*src_pcpu_cid);
+
+	if (!mm_cid_is_valid(src_cid) || last_mm_cid != src_cid)
+		return;
+
+	/*
+	 * If we observe an active task using the mm on this rq, it means we
+	 * are not the last task to be migrated from this cpu for this mm, so
+	 * there is no need to clear the src_cid.
+	 */
+	rcu_read_lock();
+	src_task = rcu_dereference(src_rq->curr);
+	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
+		rcu_read_unlock();
+		t->last_mm_cid = -1;
+		return;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * If the source cpu cid is set, and matches the last cid of the
+	 * migrated task, clear the source cpu cid to keep cid allocation
+	 * compact to cover the case where this task is the last task using
+	 * this mm on the source cpu. If there happens to be other tasks left
+	 * on the source cpu using this mm, the next task using this mm will
+	 * reallocate its cid on context switch.
+	 *
+	 * We cannot keep ownership of concurrency ID without runqueue
+	 * lock held when it is not used by a current task, because it
+	 * would lead to allocation of more concurrency ids than there
+	 * are possible cpus in the system. The last_mm_cid is used as
+	 * a hint to conditionally unset the dst cpu cid, keeping
+	 * allocated concurrency ids compact.
+	 */
+	if (cmpxchg(src_pcpu_cid, src_cid, mm_cid_set_lazy_put(src_cid)) != src_cid)
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
+	 * If we observe an active task using the mm on this rq after setting the lazy-put
+	 * flag, this task will be responsible for transitioning from lazy-put
+	 * flag set to MM_CID_UNSET.
+	 */
+	rcu_read_lock();
+	src_task = rcu_dereference(src_rq->curr);
+	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
+		rcu_read_unlock();
+		/*
+		 * We observed an active task for this mm, clearing the destination
+		 * cpu mm_cid is not relevant for compactness.
+		 */
+		t->last_mm_cid = -1;
+		return;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * The src_cid is unused, so it can be unset.
+	 */
+	if (cmpxchg(src_pcpu_cid, mm_cid_set_lazy_put(src_cid), MM_CID_UNSET) !=
+	    mm_cid_set_lazy_put(src_cid))
+		return;
+	__mm_cid_put(mm, src_cid);
+}
+
+/*
+ * Migration to dst cpu. Called with dst_rq lock held.
+ */
+void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	int src_cid, dst_cid, *dst_pcpu_cid;
+	struct task_struct *dest_task;
+
+	lockdep_assert_rq_held(dst_rq);
+
+	src_cid = t->last_mm_cid;
+	if (!mm || src_cid == -1)
+		return;
+
+	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
+
+	/*
+	 * If destination cpu cid is greater than the source cpu cid, unset it
+	 * so it can be reallocated.
+	 */
+	dst_cid = READ_ONCE(*dst_pcpu_cid);
+	if (!mm_cid_is_valid(dst_cid) || dst_cid <= src_cid)
+		return;
+	/*
+	 * Put dst_cid if it is not currently in use, else it will be lazy put
+	 * on the next context switch.
+	 */
+	dest_task = rcu_dereference_protected(dst_rq->curr, lockdep_is_held(__rq_lockp(dst_rq)));
+	if (dest_task->mm_cid_active && dest_task->mm == mm) {
+		WARN_ON_ONCE(dest_task->mm_cid != dst_cid);
+		/*
+		 * Attempt to set lazy-put flag. Can fail due to concurrent
+		 * migrate-from, which sets lazy-put flag or MM_CID_UNSET.
+		 */
+		(void) cmpxchg(dst_pcpu_cid, dst_cid, mm_cid_set_lazy_put(dst_cid));
+		return;
+	}
+	/*
+	 * Attempt to set MM_CID_UNSET. Can fail due to concurrent
+	 * migrate-from, which sets lazy-put flag or MM_CID_UNSET.
+	 */
+	if (cmpxchg(dst_pcpu_cid, dst_cid, MM_CID_UNSET) != dst_cid)
+		return;
+	__mm_cid_put(mm, dst_cid);
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
+	 * Matches barrier in sched_mm_cid_migrate_from().
+	 */
+	smp_mb();
+	mm_cid_put(t);
+	t->last_mm_cid = t->mm_cid = -1;
+	rq_unlock_irqrestore(rq, &rf);
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
+	 * Matches barrier in sched_mm_cid_migrate_from().
+	 */
+	smp_mb();
+	mm_cid_put(t);
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
+	 * Matches barrier in sched_mm_cid_migrate_from().
+	 */
+	smp_mb();
+	t->last_mm_cid = t->mm_cid = mm_cid_get(mm);
+	rq_unlock_irqrestore(rq, &rf);
 	rseq_set_notify_resume(t);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..f3e7dc2cd1cc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3249,7 +3249,66 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
 }
 
 #ifdef CONFIG_SCHED_MM_CID
-static inline int __mm_cid_get(struct mm_struct *mm)
+extern void sched_mm_cid_migrate_from(struct task_struct *t);
+extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
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
+	int *pcpu_cid, cid;
+
+	lockdep_assert_rq_held(this_rq());
+	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
+	cid = READ_ONCE(*pcpu_cid);
+	if (!mm_cid_is_lazy_put(cid))
+		return;
+	if (cmpxchg(pcpu_cid, cid, MM_CID_UNSET) != cid)
+		return;
+	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+}
+
+static inline void mm_cid_put(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	int *pcpu_cid, cid, res;
+
+	lockdep_assert_rq_held(this_rq());
+	WARN_ON_ONCE(t->mm_cid < 0);
+	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
+	cid = READ_ONCE(*pcpu_cid);
+	for (;;) {
+		if (mm_cid_is_unset(cid))
+			return;
+		WARN_ON_ONCE(mm_cid_clear_lazy_put(cid) != t->mm_cid);
+		/*
+		 * Attempt transition from valid or lazy-put to unset.
+		 */
+		res = cmpxchg(pcpu_cid, cid, MM_CID_UNSET);
+		if (res == cid)
+			break;
+		cid = res;
+	}
+	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+}
+
+/*
+ * Lookup/set of mm_cidmask are serialized by cid_lock. Clear of mm_cidmask
+ * uses atomic operations, therefore requiring the set to be done with atomic
+ * operations as well.
+ */
+static inline int __mm_cid_get_locked(struct mm_struct *mm)
 {
 	struct cpumask *cpumask;
 	int cid;
@@ -3258,52 +3317,86 @@ static inline int __mm_cid_get(struct mm_struct *mm)
 	cid = cpumask_first_zero(cpumask);
 	if (cid >= nr_cpu_ids)
 		return -1;
-	__cpumask_set_cpu(cid, cpumask);
+	cpumask_set_cpu(cid, cpumask);
 	return cid;
 }
 
-static inline void mm_cid_put(struct mm_struct *mm, int cid)
+static inline int __mm_cid_get(struct mm_struct *mm)
 {
-	lockdep_assert_irqs_disabled();
-	if (cid < 0)
-		return;
+	int ret;
+
+	lockdep_assert_rq_held(this_rq());
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
 
-	lockdep_assert_irqs_disabled();
+	lockdep_assert_rq_held(this_rq());
+	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
+	cid = READ_ONCE(*pcpu_cid);
+	if (mm_cid_is_valid(cid))
+		return cid;
+	if (mm_cid_is_lazy_put(cid)) {
+		if (cmpxchg(pcpu_cid, cid, MM_CID_UNSET) == cid)
+			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+	}
 	raw_spin_lock(&mm->cid_lock);
-	ret = __mm_cid_get(mm);
+	cid = __mm_cid_get_locked(mm);
 	raw_spin_unlock(&mm->cid_lock);
-	return ret;
+	WRITE_ONCE(*pcpu_cid, cid);
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
+		 * switch_mm().
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
+static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
+static inline void sched_mm_cid_migrate_to(struct rq *src_rq, struct task_struct *t) { }
 #endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.25.1

