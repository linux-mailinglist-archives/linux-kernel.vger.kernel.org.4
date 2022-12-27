Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6BF656ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiL0MQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiL0MOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1784D25CF;
        Tue, 27 Dec 2022 04:13:56 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHDy5QU0HGX/8tF21rLM9+AIUFyGknZaVCiwORLGxI8=;
        b=SwKwRp+y1EUPexei8bDwLZQCjtgzAEoVqZRsz7XQRwa9IvqwdZfQUX0f/DSUcvdC3PRwSP
        LpGH7y+ZOMcKB4mzmdrTdDbgARePok0spa+u4TEp6vF0QV60TVpCLiox0I38Es4ldOGAAV
        lPD5zACe5U2kLT1PLZymH85QUjpEQ8k8LKXd+O/uuaI734XGT5H9Jtq4GGefELCq04yGpJ
        O4XXGkg2F2msyO3gGlNHAO1Xhl1z8n3NFnw/hVg0MKldCtQN43ERUorsbr6oxEjVjlGjc4
        OCDxNx4vs4oyh3cbKWek4kTM+ukXStnMF7nXYvVogmXOKH3R21j/gC0vOvoQgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHDy5QU0HGX/8tF21rLM9+AIUFyGknZaVCiwORLGxI8=;
        b=I6rfvJgGrxS+9sIbyte+6I9DfnrQ1B+atTyh9TBZ32DSqky5AV8wis8PCwbZsYYfNmuJMv
        ocKL8iBnqmgyveBA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Introduce per-memory-map concurrency ID
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-8-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-8-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214323178.4906.1944423465099297043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     af7f588d8f7355bc4298dd1962d7826358fc95f0
Gitweb:        https://git.kernel.org/tip/af7f588d8f7355bc4298dd1962d7826358f=
c95f0
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:09 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:11 +01:00

sched: Introduce per-memory-map concurrency ID

This feature allows the scheduler to expose a per-memory map concurrency
ID to user-space. This concurrency ID is within the possible cpus range,
and is temporarily (and uniquely) assigned while threads are actively
running within a memory map. If a memory map has fewer threads than
cores, or is limited to run on few cores concurrently through sched
affinity or cgroup cpusets, the concurrency IDs will be values close
to 0, thus allowing efficient use of user-space memory for per-cpu
data structures.

This feature is meant to be exposed by a new rseq thread area field.

The primary purpose of this feature is to do the heavy-lifting needed
by memory allocators to allow them to use per-cpu data structures
efficiently in the following situations:

- Single-threaded applications,
- Multi-threaded applications on large systems (many cores) with limited
  cpu affinity mask,
- Multi-threaded applications on large systems (many cores) with
  restricted cgroup cpuset per container.

One of the key concern from scheduler maintainers is the overhead
associated with additional spin locks or atomic operations in the
scheduler fast-path. This is why the following optimization is
implemented.

On context switch between threads belonging to the same memory map,
transfer the mm_cid from prev to next without any atomic ops. This
takes care of use-cases involving frequent context switch between
threads belonging to the same memory map.

Additional optimizations can be done if the spin locks added when
context switching between threads belonging to different memory maps end
up being a performance bottleneck. Those are left out of this patch
though. A performance impact would have to be clearly demonstrated to
justify the added complexity.

The credit goes to Paul Turner (Google) for the original virtual cpu id
idea. This feature is implemented based on the discussions with Paul
Turner and Peter Oskolkov (Google), but I took the liberty to implement
scheduler fast-path optimizations and my own NUMA-awareness scheme. The
rumor has it that Google have been running a rseq vcpu_id extension
internally in production for a year. The tcmalloc source code indeed has
comments hinting at a vcpu_id prototype extension to the rseq system
call [1].

The following benchmarks do not show any significant overhead added to
the scheduler context switch by this feature:

* perf bench sched messaging (process)

Baseline:                    86.5=C2=B10.3 ms
With mm_cid:                 86.7=C2=B12.6 ms

* perf bench sched messaging (threaded)

Baseline:                    84.3=C2=B13.0 ms
With mm_cid:                 84.7=C2=B12.6 ms

* hackbench (process)

Baseline:                    82.9=C2=B12.7 ms
With mm_cid:                 82.9=C2=B12.9 ms

* hackbench (threaded)

Baseline:                    85.2=C2=B12.6 ms
With mm_cid:                 84.4=C2=B12.9 ms

[1] https://github.com/google/tcmalloc/blob/master/tcmalloc/internal/linux_sy=
scall_support.h#L26

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-8-mathieu.desnoyers@eff=
icios.com
---
 fs/exec.c                |  4 +++-
 include/linux/mm.h       | 25 +++++++++++++++++-
 include/linux/mm_types.h | 43 ++++++++++++++++++++++++++++-
 include/linux/sched.h    |  5 +++-
 init/Kconfig             |  4 +++-
 kernel/fork.c            |  8 ++++-
 kernel/sched/core.c      | 51 ++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h     | 58 +++++++++++++++++++++++++++++++++++++++-
 kernel/signal.c          |  2 +-
 9 files changed, 198 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index ab91324..58f1631 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1010,6 +1010,7 @@ static int exec_mmap(struct mm_struct *mm)
 	active_mm =3D tsk->active_mm;
 	tsk->active_mm =3D mm;
 	tsk->mm =3D mm;
+	mm_init_cid(mm);
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
@@ -1822,6 +1823,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	 */
 	check_unsafe_exec(bprm);
 	current->in_execve =3D 1;
+	sched_mm_cid_before_execve(current);
=20
 	file =3D do_open_execat(fd, filename, flags);
 	retval =3D PTR_ERR(file);
@@ -1852,6 +1854,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	if (retval < 0)
 		goto out;
=20
+	sched_mm_cid_after_execve(current);
 	/* execve succeeded */
 	current->fs->in_exec =3D 0;
 	current->in_execve =3D 0;
@@ -1871,6 +1874,7 @@ out:
 		force_fatal_sig(SIGSEGV);
=20
 out_unmark:
+	sched_mm_cid_after_execve(current);
 	current->fs->in_exec =3D 0;
 	current->in_execve =3D 0;
=20
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f3f196e..cf008c2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1976,6 +1976,31 @@ struct zap_details {
 /* Set in unmap_vmas() to indicate a final unmap call.  Only used by hugetlb=
 */
 #define  ZAP_FLAG_UNMAP              ((__force zap_flags_t) BIT(1))
=20
+#ifdef CONFIG_SCHED_MM_CID
+void sched_mm_cid_before_execve(struct task_struct *t);
+void sched_mm_cid_after_execve(struct task_struct *t);
+void sched_mm_cid_fork(struct task_struct *t);
+void sched_mm_cid_exit_signals(struct task_struct *t);
+static inline int task_mm_cid(struct task_struct *t)
+{
+	return t->mm_cid;
+}
+#else
+static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
+static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
+static inline void sched_mm_cid_fork(struct task_struct *t) { }
+static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
+static inline int task_mm_cid(struct task_struct *t)
+{
+	/*
+	 * Use the processor id as a fall-back when the mm cid feature is
+	 * disabled. This provides functional per-cpu data structure accesses
+	 * in user-space, althrough it won't provide the memory usage benefits.
+	 */
+	return raw_smp_processor_id();
+}
+#endif
+
 #ifdef CONFIG_MMU
 extern bool can_do_mlock(void);
 #else
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3b84750..1c3bf76 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -645,7 +645,18 @@ struct mm_struct {
 		 * &struct mm_struct is freed.
 		 */
 		atomic_t mm_count;
-
+#ifdef CONFIG_SCHED_MM_CID
+		/**
+		 * @cid_lock: Protect cid bitmap updates vs lookups.
+		 *
+		 * Prevent situations where updates to the cid bitmap happen
+		 * concurrently with lookups. Those can lead to situations
+		 * where a lookup cannot find a free bit simply because it was
+		 * unlucky enough to load, non-atomically, bitmap words as they
+		 * were being concurrently updated by the updaters.
+		 */
+		raw_spinlock_t cid_lock;
+#endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* PTE page table pages */
 #endif
@@ -909,6 +920,36 @@ static inline void vma_iter_init(struct vma_iterator *vm=
i,
 	vmi->mas.node =3D MAS_START;
 }
=20
+#ifdef CONFIG_SCHED_MM_CID
+/* Accessor for struct mm_struct's cidmask. */
+static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
+{
+	unsigned long cid_bitmap =3D (unsigned long)mm;
+
+	cid_bitmap +=3D offsetof(struct mm_struct, cpu_bitmap);
+	/* Skip cpu_bitmap */
+	cid_bitmap +=3D cpumask_size();
+	return (struct cpumask *)cid_bitmap;
+}
+
+static inline void mm_init_cid(struct mm_struct *mm)
+{
+	raw_spin_lock_init(&mm->cid_lock);
+	cpumask_clear(mm_cidmask(mm));
+}
+
+static inline unsigned int mm_cid_size(void)
+{
+	return cpumask_size();
+}
+#else /* CONFIG_SCHED_MM_CID */
+static inline void mm_init_cid(struct mm_struct *mm) { }
+static inline unsigned int mm_cid_size(void)
+{
+	return 0;
+}
+#endif /* CONFIG_SCHED_MM_CID */
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *=
mm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e0bc020..4df2b3e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1311,6 +1311,11 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif
=20
+#ifdef CONFIG_SCHED_MM_CID
+	int				mm_cid;		/* Current cid in mm */
+	int				mm_cid_active;	/* Whether cid bitmap is active */
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
=20
 	union {
diff --git a/init/Kconfig b/init/Kconfig
index 7e5c3dd..1ce960a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1041,6 +1041,10 @@ config RT_GROUP_SCHED
=20
 endif #CGROUP_SCHED
=20
+config SCHED_MM_CID
+	def_bool y
+	depends on SMP && RSEQ
+
 config UCLAMP_TASK_GROUP
 	bool "Utilization clamping per group of tasks"
 	depends on CGROUP_SCHED
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe35..82b2b58 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1060,6 +1060,10 @@ static struct task_struct *dup_task_struct(struct task=
_struct *orig, int node)
 	tsk->reported_split_lock =3D 0;
 #endif
=20
+#ifdef CONFIG_SCHED_MM_CID
+	tsk->mm_cid =3D -1;
+	tsk->mm_cid_active =3D 0;
+#endif
 	return tsk;
=20
 free_stack:
@@ -1169,6 +1173,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, =
struct task_struct *p,
=20
 	mm->user_ns =3D get_user_ns(user_ns);
 	lru_gen_init_mm(mm);
+	mm_init_cid(mm);
 	return mm;
=20
 fail_pcpu:
@@ -1601,6 +1606,7 @@ static int copy_mm(unsigned long clone_flags, struct ta=
sk_struct *tsk)
=20
 	tsk->mm =3D mm;
 	tsk->active_mm =3D mm;
+	sched_mm_cid_fork(tsk);
 	return 0;
 }
=20
@@ -3034,7 +3040,7 @@ void __init mm_cache_init(void)
 	 * dynamically sized based on the maximum CPU number this system
 	 * can have, taking hotplug into account (nr_cpu_ids).
 	 */
-	mm_size =3D sizeof(struct mm_struct) + cpumask_size();
+	mm_size =3D sizeof(struct mm_struct) + cpumask_size() + mm_cid_size();
=20
 	mm_cachep =3D kmem_cache_create_usercopy("mm_struct",
 			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 25b582b..75830b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5052,6 +5052,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *=
prev,
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
+	switch_mm_cid(prev, next);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -11305,3 +11306,53 @@ void call_trace_sched_update_nr_running(struct rq *r=
q, int count)
 {
         trace_sched_update_nr_running_tp(rq, count);
 }
+
+#ifdef CONFIG_SCHED_MM_CID
+void sched_mm_cid_exit_signals(struct task_struct *t)
+{
+	struct mm_struct *mm =3D t->mm;
+	unsigned long flags;
+
+	if (!mm)
+		return;
+	local_irq_save(flags);
+	mm_cid_put(mm, t->mm_cid);
+	t->mm_cid =3D -1;
+	t->mm_cid_active =3D 0;
+	local_irq_restore(flags);
+}
+
+void sched_mm_cid_before_execve(struct task_struct *t)
+{
+	struct mm_struct *mm =3D t->mm;
+	unsigned long flags;
+
+	if (!mm)
+		return;
+	local_irq_save(flags);
+	mm_cid_put(mm, t->mm_cid);
+	t->mm_cid =3D -1;
+	t->mm_cid_active =3D 0;
+	local_irq_restore(flags);
+}
+
+void sched_mm_cid_after_execve(struct task_struct *t)
+{
+	struct mm_struct *mm =3D t->mm;
+	unsigned long flags;
+
+	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
+
+	local_irq_save(flags);
+	t->mm_cid =3D mm_cid_get(mm);
+	t->mm_cid_active =3D 1;
+	local_irq_restore(flags);
+	rseq_set_notify_resume(t);
+}
+
+void sched_mm_cid_fork(struct task_struct *t)
+{
+	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm || t->mm_cid !=3D -1);
+	t->mm_cid_active =3D 1;
+}
+#endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b3d6e81..c2d7467 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3269,4 +3269,62 @@ static inline void update_current_exec_runtime(struct =
task_struct *curr,
 	cgroup_account_cputime(curr, delta_exec);
 }
=20
+#ifdef CONFIG_SCHED_MM_CID
+static inline int __mm_cid_get(struct mm_struct *mm)
+{
+	struct cpumask *cpumask;
+	int cid;
+
+	cpumask =3D mm_cidmask(mm);
+	cid =3D cpumask_first_zero(cpumask);
+	if (cid >=3D nr_cpu_ids)
+		return -1;
+	__cpumask_set_cpu(cid, cpumask);
+	return cid;
+}
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
+static inline int mm_cid_get(struct mm_struct *mm)
+{
+	int ret;
+
+	lockdep_assert_irqs_disabled();
+	raw_spin_lock(&mm->cid_lock);
+	ret =3D __mm_cid_get(mm);
+	raw_spin_unlock(&mm->cid_lock);
+	return ret;
+}
+
+static inline void switch_mm_cid(struct task_struct *prev, struct task_struc=
t *next)
+{
+	if (prev->mm_cid_active) {
+		if (next->mm_cid_active && next->mm =3D=3D prev->mm) {
+			/*
+			 * Context switch between threads in same mm, hand over
+			 * the mm_cid from prev to next.
+			 */
+			next->mm_cid =3D prev->mm_cid;
+			prev->mm_cid =3D -1;
+			return;
+		}
+		mm_cid_put(prev->mm, prev->mm_cid);
+		prev->mm_cid =3D -1;
+	}
+	if (next->mm_cid_active)
+		next->mm_cid =3D mm_cid_get(next->mm);
+}
+
+#else
+static inline void switch_mm_cid(struct task_struct *prev, struct task_struc=
t *next) { }
+#endif
+
 #endif /* _KERNEL_SCHED_SCHED_H */
diff --git a/kernel/signal.c b/kernel/signal.c
index ae26da6..8cb28f1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2951,6 +2951,7 @@ void exit_signals(struct task_struct *tsk)
 	cgroup_threadgroup_change_begin(tsk);
=20
 	if (thread_group_empty(tsk) || (tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
+		sched_mm_cid_exit_signals(tsk);
 		tsk->flags |=3D PF_EXITING;
 		cgroup_threadgroup_change_end(tsk);
 		return;
@@ -2961,6 +2962,7 @@ void exit_signals(struct task_struct *tsk)
 	 * From now this task is not visible for group-wide signals,
 	 * see wants_signal(), do_signal_stop().
 	 */
+	sched_mm_cid_exit_signals(tsk);
 	tsk->flags |=3D PF_EXITING;
=20
 	cgroup_threadgroup_change_end(tsk);
