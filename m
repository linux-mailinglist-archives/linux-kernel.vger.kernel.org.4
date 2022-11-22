Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B1634880
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiKVUkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiKVUjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:39:53 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83CC697D9;
        Tue, 22 Nov 2022 12:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149587;
        bh=BpFNFGqq4+d7vh2x3P9VxGSiYntBRAT7SS6wTXEi1Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NevQsb7PhCkntKnP6fpPYsyNw+ebPvq07+pVocq5J2I1jYaZHjBhk1/LAaUlSWckE
         +7qCB9DOORFLgQTQeM9F/9Aat9o0Bk8Mto6MWVrLT7HD2ClaTY8GMkYLWVPTcpLMeP
         jHmAgYL+VqBwcfVRsuaI90PcqPVVybvjnE/vLEhgwpz8jEK96V+X/7psyPOWR79iI4
         ErHmbi1f8WsQF3MIXu5JlYJjr6GVAp3nnQmEasQHPDGBGbJ1jnKESH+VMUxH/mgWKa
         ct6LJYqRDGXKIyVT2vQnvK802gekXXInxagEGifWwjKUth/l3cS9NA3bPqS1TboY3g
         jdisff/18P96w==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2V6tl0zXP7;
        Tue, 22 Nov 2022 15:39:46 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 07/30] sched: Introduce per-memory-map concurrency ID
Date:   Tue, 22 Nov 2022 15:39:09 -0500
Message-Id: <20221122203932.231377-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Baseline:                    86.5±0.3 ms
With mm_cid:                 86.7±2.6 ms

* perf bench sched messaging (threaded)

Baseline:                    84.3±3.0 ms
With mm_cid:                 84.7±2.6 ms

* hackbench (process)

Baseline:                    82.9±2.7 ms
With mm_cid:                 82.9±2.9 ms

* hackbench (threaded)

Baseline:                    85.2±2.6 ms
With mm_cid:                 84.4±2.9 ms

[1] https://github.com/google/tcmalloc/blob/master/tcmalloc/internal/linux_syscall_support.h#L26

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
Changes since v3:
- Remove per-runqueue vcpu id cache optimization.
- Remove single-threaded process optimization.
- Introduce spinlock to protect vcpu id bitmaps.

Changes since v4:
- Disable interrupts around mm_vcpu_get/mm_vcpu_put. The spin locks are
  used from within the scheduler context switch with interrupts off, so
  all uses of these spin locks need to have interrupts off.
- Initialize tsk->mm_vcpu to -1 in dup_task_struct to be consistent with
  other states where mm_vcpu_active is 0.

Changes since v5:
- Combine rseq vcpu id init into a single function.
- Use raw spinlock with irqs disabled.
- sched_vcpu_fork: warn  on mm_vcpu != -1 rather than setting it again.
- Move numa-awareness to a separate patch.
- Rename Virtual CPU ID "vcpu_id" to Concurrency ID "cid".
- Rename "Memory Space" (vm) to "Memory Map" (mm).
---
 fs/exec.c                |  4 +++
 include/linux/mm.h       | 25 +++++++++++++++++
 include/linux/mm_types.h | 43 ++++++++++++++++++++++++++++-
 include/linux/sched.h    |  5 ++++
 init/Kconfig             |  4 +++
 kernel/fork.c            |  8 +++++-
 kernel/sched/core.c      | 51 +++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h     | 58 ++++++++++++++++++++++++++++++++++++++++
 kernel/signal.c          |  2 ++
 9 files changed, 198 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 349a5da91efe..324f11e9e9c0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1013,6 +1013,7 @@ static int exec_mmap(struct mm_struct *mm)
 	tsk->active_mm = mm;
 	tsk->mm = mm;
 	lru_gen_add_mm(mm);
+	mm_init_cid(mm);
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
@@ -1808,6 +1809,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
+	sched_mm_cid_before_execve(current);
 
 	file = do_open_execat(fd, filename, flags);
 	retval = PTR_ERR(file);
@@ -1838,6 +1840,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	if (retval < 0)
 		goto out;
 
+	sched_mm_cid_after_execve(current);
 	/* execve succeeded */
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
@@ -1857,6 +1860,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 		force_fatal_sig(SIGSEGV);
 
 out_unmark:
+	sched_mm_cid_after_execve(current);
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..e0fba52de3e2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3475,4 +3475,29 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  */
 #define  ZAP_FLAG_DROP_MARKER        ((__force zap_flags_t) BIT(0))
 
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
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..dabb42d26bb9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -556,7 +556,18 @@ struct mm_struct {
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
@@ -824,6 +835,36 @@ static inline void vma_iter_init(struct vma_iterator *vmi,
 	vmi->mas.node = MAS_START;
 }
 
+#ifdef CONFIG_SCHED_MM_CID
+/* Accessor for struct mm_struct's cidmask. */
+static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
+{
+	unsigned long cid_bitmap = (unsigned long)mm;
+
+	cid_bitmap += offsetof(struct mm_struct, cpu_bitmap);
+	/* Skip cpu_bitmap */
+	cid_bitmap += cpumask_size();
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
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2a9e14e3e668..c7e3c27e0e2e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1314,6 +1314,11 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif
 
+#ifdef CONFIG_SCHED_MM_CID
+	int				mm_cid;		/* Current cid in mm */
+	int				mm_cid_active;	/* Whether cid bitmap is active */
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	union {
diff --git a/init/Kconfig b/init/Kconfig
index abf65098f1b6..6e8af7a6893f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1039,6 +1039,10 @@ config RT_GROUP_SCHED
 
 endif #CGROUP_SCHED
 
+config SCHED_MM_CID
+	def_bool y
+	depends on SMP && RSEQ
+
 config UCLAMP_TASK_GROUP
 	bool "Utilization clamping per group of tasks"
 	depends on CGROUP_SCHED
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..d48dedc4be75 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1047,6 +1047,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->reported_split_lock = 0;
 #endif
 
+#ifdef CONFIG_SCHED_MM_CID
+	tsk->mm_cid = -1;
+	tsk->mm_cid_active = 0;
+#endif
 	return tsk;
 
 free_stack:
@@ -1150,6 +1154,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 
 	mm->user_ns = get_user_ns(user_ns);
 	lru_gen_init_mm(mm);
+	mm_init_cid(mm);
 	return mm;
 
 fail_nocontext:
@@ -1579,6 +1584,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 
 	tsk->mm = mm;
 	tsk->active_mm = mm;
+	sched_mm_cid_fork(tsk);
 	return 0;
 }
 
@@ -3041,7 +3047,7 @@ void __init proc_caches_init(void)
 	 * dynamically sized based on the maximum CPU number this system
 	 * can have, taking hotplug into account (nr_cpu_ids).
 	 */
-	mm_size = sizeof(struct mm_struct) + cpumask_size();
+	mm_size = sizeof(struct mm_struct) + cpumask_size() + mm_cid_size();
 
 	mm_cachep = kmem_cache_create_usercopy("mm_struct",
 			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 07ac08caf019..ef0cc40cca6b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5019,6 +5019,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
+	switch_mm_cid(prev, next);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -11273,3 +11274,53 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
         trace_sched_update_nr_running_tp(rq, count);
 }
+
+#ifdef CONFIG_SCHED_MM_CID
+void sched_mm_cid_exit_signals(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	unsigned long flags;
+
+	if (!mm)
+		return;
+	local_irq_save(flags);
+	mm_cid_put(mm, t->mm_cid);
+	t->mm_cid = -1;
+	t->mm_cid_active = 0;
+	local_irq_restore(flags);
+}
+
+void sched_mm_cid_before_execve(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	unsigned long flags;
+
+	if (!mm)
+		return;
+	local_irq_save(flags);
+	mm_cid_put(mm, t->mm_cid);
+	t->mm_cid = -1;
+	t->mm_cid_active = 0;
+	local_irq_restore(flags);
+}
+
+void sched_mm_cid_after_execve(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	unsigned long flags;
+
+	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
+
+	local_irq_save(flags);
+	t->mm_cid = mm_cid_get(mm);
+	t->mm_cid_active = 1;
+	local_irq_restore(flags);
+	rseq_set_notify_resume(t);
+}
+
+void sched_mm_cid_fork(struct task_struct *t)
+{
+	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm || t->mm_cid != -1);
+	t->mm_cid_active = 1;
+}
+#endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 771f8ddb7053..0096dc22926e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3261,4 +3261,62 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
 	cgroup_account_cputime(curr, delta_exec);
 }
 
+#ifdef CONFIG_SCHED_MM_CID
+static inline int __mm_cid_get(struct mm_struct *mm)
+{
+	struct cpumask *cpumask;
+	int cid;
+
+	cpumask = mm_cidmask(mm);
+	cid = cpumask_first_zero(cpumask);
+	if (cid >= nr_cpu_ids)
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
+	ret = __mm_cid_get(mm);
+	raw_spin_unlock(&mm->cid_lock);
+	return ret;
+}
+
+static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
+{
+	if (prev->mm_cid_active) {
+		if (next->mm_cid_active && next->mm == prev->mm) {
+			/*
+			 * Context switch between threads in same mm, hand over
+			 * the mm_cid from prev to next.
+			 */
+			next->mm_cid = prev->mm_cid;
+			prev->mm_cid = -1;
+			return;
+		}
+		mm_cid_put(prev->mm, prev->mm_cid);
+		prev->mm_cid = -1;
+	}
+	if (next->mm_cid_active)
+		next->mm_cid = mm_cid_get(next->mm);
+}
+
+#else
+static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
+#endif
+
 #endif /* _KERNEL_SCHED_SCHED_H */
diff --git a/kernel/signal.c b/kernel/signal.c
index d140672185a4..88d849f15668 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2950,6 +2950,7 @@ void exit_signals(struct task_struct *tsk)
 	cgroup_threadgroup_change_begin(tsk);
 
 	if (thread_group_empty(tsk) || (tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
+		sched_mm_cid_exit_signals(tsk);
 		tsk->flags |= PF_EXITING;
 		cgroup_threadgroup_change_end(tsk);
 		return;
@@ -2960,6 +2961,7 @@ void exit_signals(struct task_struct *tsk)
 	 * From now this task is not visible for group-wide signals,
 	 * see wants_signal(), do_signal_stop().
 	 */
+	sched_mm_cid_exit_signals(tsk);
 	tsk->flags |= PF_EXITING;
 
 	cgroup_threadgroup_change_end(tsk);
-- 
2.25.1

