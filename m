Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8E55E608E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiIVLKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiIVLKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:10:23 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F86454661;
        Thu, 22 Sep 2022 04:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844385;
        bh=xDvG695uXRFQo+ozZW1AMh8pOrZLNYQaeWGlwSiIshs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHRpQECeGwdfVDBgM4PZm+olBWtXEk7v6zcpQxzyp0lUGlHQ33Ba4XmG5TIXcIyqV
         iXZzQjy1l21kjjTePwFwzdCsNDktDbq1Xq8iYIrgm39pfsCeVtG/rtsqVl+np5sYlb
         n5+n29AdGlliCqQvL+7++xxB2xwLVLpXb7mYefDItNmCwMWLpF9/yDqutzdqoLFmsM
         kdQ4vj32dfV042Z5y0YF996A7TNcCvFZ3Eb1aeUVzjOgQhTrx446I1s/pfqtiEms5H
         xHMMrRPfoW19TQfHcpPRyRd7fY+yFYb+YWSEJTHGya5UsNX9kGiObjH9vQTuuwWzTy
         PkBzlmtrZWhsw==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3P1153zNND;
        Thu, 22 Sep 2022 06:59:45 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 09/25] sched: Introduce per memory space current virtual cpu id
Date:   Thu, 22 Sep 2022 06:59:24 -0400
Message-Id: <20220922105941.237830-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
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

This feature allows the scheduler to expose a current virtual cpu id
to user-space. This virtual cpu id is within the possible cpus range,
and is temporarily (and uniquely) assigned while threads are actively
running within a memory space. If a memory space has fewer threads than
cores, or is limited to run on few cores concurrently through sched
affinity or cgroup cpusets, the virtual cpu ids will be values close
to 0, thus allowing efficient use of user-space memory for per-cpu
data structures.

The vcpu_ids are NUMA-aware. On NUMA systems, when a vcpu_id is observed
by user-space to be associated with a NUMA node, it is guaranteed to
never change NUMA node unless a kernel-level NUMA configuration change
happens.

This feature is meant to be exposed by a new rseq thread area field.

The primary purpose of this feature is to do the heavy-lifting needed
by memory allocators to allow them to use per-cpu data structures
efficiently in the following situations:

- Single-threaded applications,
- Multi-threaded applications on large systems (many cores) with limited
  cpu affinity mask,
- Multi-threaded applications on large systems (many cores) with
  restricted cgroup cpuset per container,
- Processes using memory from many NUMA nodes.

One of the key concern from scheduler maintainers is the overhead
associated with additional spin locks or atomic operations in the
scheduler fast-path. This is why the following optimization is
implemented.

On context switch between threads belonging to the same memory space,
transfer the mm_vcpu_id from prev to next without any atomic ops. This
takes care of use-cases involving frequent context switch between
threads belonging to the same memory space.

Additional optimizations can be done if the spin locks added when
context switching between threads belonging to different processes end
up being a performance bottleneck. Those are left out of this patch
though. A performance impact would have to be clearly demonstrated to
justify the added complexity.

The credit goes to Paul Turner (Google) for the vcpu_id idea. This
feature is implemented based on the discussions with Paul Turner and
Peter Oskolkov (Google), but I took the liberty to implement scheduler
fast-path optimizations and my own NUMA-awareness scheme. The rumor has
it that Google have been running a rseq vcpu_id extension internally at
Google in production for a year. The tcmalloc source code indeed has
comments hinting at a vcpu_id prototype extension to the rseq system
call [1].

The following benchmarks do not show any significant overhead added to
the scheduler context switch by this feature:

* perf bench sched messaging (process)

Baseline:                    86.5±0.3 ms
With mm_vcpu_id:             86.7±2.6 ms

* perf bench sched messaging (threaded)

Baseline:                    84.3±3.0 ms
With mm_vcpu_id:             84.7±2.6 ms

* hackbench (process)

Baseline:                    82.9±2.7 ms
With mm_vcpu_id:             82.9±2.9 ms

* hackbench (threaded)

Baseline:                    85.2±2.6 ms
With mm_vcpu_id:             84.4±2.9 ms

[1] https://github.com/google/tcmalloc/blob/master/tcmalloc/internal/linux_syscall_support.h#L26

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
Changes since v3:
- Remove per-runqueue vcpu id cache optimization.
- Remove single-threaded process optimization.
- Introduce spinlock to protect vcpu id bitmaps.
---
 fs/exec.c                |   6 ++
 include/linux/mm.h       |  25 ++++++
 include/linux/mm_types.h | 110 +++++++++++++++++++++++++-
 include/linux/sched.h    |   5 ++
 init/Kconfig             |   4 +
 kernel/fork.c            |  11 ++-
 kernel/sched/core.c      |  49 ++++++++++++
 kernel/sched/sched.h     | 166 +++++++++++++++++++++++++++++++++++++++
 kernel/signal.c          |   2 +
 9 files changed, 376 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 778123259e42..e42f76509f36 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1015,6 +1015,9 @@ static int exec_mmap(struct mm_struct *mm)
 	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
 	tsk->mm = mm;
+	mm_init_vcpu_lock(mm);
+	mm_init_vcpumask(mm);
+	mm_init_node_vcpumask(mm);
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
@@ -1809,6 +1812,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
+	sched_vcpu_before_execve(current);
 
 	file = do_open_execat(fd, filename, flags);
 	retval = PTR_ERR(file);
@@ -1839,6 +1843,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	if (retval < 0)
 		goto out;
 
+	sched_vcpu_after_execve(current);
 	/* execve succeeded */
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
@@ -1858,6 +1863,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 		force_fatal_sig(SIGSEGV);
 
 out_unmark:
+	sched_vcpu_after_execve(current);
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7898e29bcfb5..61b8b2e9bac3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3447,4 +3447,29 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  */
 #define  ZAP_FLAG_DROP_MARKER        ((__force zap_flags_t) BIT(0))
 
+#ifdef CONFIG_SCHED_MM_VCPU
+void sched_vcpu_before_execve(struct task_struct *t);
+void sched_vcpu_after_execve(struct task_struct *t);
+void sched_vcpu_fork(struct task_struct *t);
+void sched_vcpu_exit_signals(struct task_struct *t);
+static inline int task_mm_vcpu_id(struct task_struct *t)
+{
+	return t->mm_vcpu;
+}
+#else
+static inline void sched_vcpu_before_execve(struct task_struct *t) { }
+static inline void sched_vcpu_after_execve(struct task_struct *t) { }
+static inline void sched_vcpu_fork(struct task_struct *t) { }
+static inline void sched_vcpu_exit_signals(struct task_struct *t) { }
+static inline int task_mm_vcpu_id(struct task_struct *t)
+{
+	/*
+	 * Use the processor id as a fall-back when the mm vcpu feature is
+	 * disabled. This provides functional per-cpu data structure accesses
+	 * in user-space, althrough it won't provide the memory usage benefits.
+	 */
+	return raw_smp_processor_id();
+}
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c29ab4c0cd5c..a85b17a290fd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -17,6 +17,7 @@
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
+#include <linux/nodemask.h>
 
 #include <asm/mmu.h>
 
@@ -528,7 +529,19 @@ struct mm_struct {
 		 * &struct mm_struct is freed.
 		 */
 		atomic_t mm_count;
-
+#ifdef CONFIG_SCHED_MM_VCPU
+		/**
+		 * @vcpu_lock: Protect vcpu_id bitmap updates vs lookups.
+		 *
+		 * Prevent situations where updates to the vcpu_id bitmap
+		 * happen concurrently with lookups. Those can lead to
+		 * situations where a lookup cannot find a free bit simply
+		 * because it was unlucky enough to load, non-atomically,
+		 * bitmap words as they were being concurrently updated by the
+		 * updaters.
+		 */
+		spinlock_t vcpu_lock;
+#endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* PTE page table pages */
 #endif
@@ -693,6 +706,101 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 	return (struct cpumask *)&mm->cpu_bitmap;
 }
 
+#ifdef CONFIG_SCHED_MM_VCPU
+/* Future-safe accessor for struct mm_struct's vcpu_mask. */
+static inline cpumask_t *mm_vcpumask(struct mm_struct *mm)
+{
+	unsigned long vcpu_bitmap = (unsigned long)mm;
+
+	vcpu_bitmap += offsetof(struct mm_struct, cpu_bitmap);
+	/* Skip cpu_bitmap */
+	vcpu_bitmap += cpumask_size();
+	return (struct cpumask *)vcpu_bitmap;
+}
+
+static inline void mm_init_vcpumask(struct mm_struct *mm)
+{
+	cpumask_clear(mm_vcpumask(mm));
+}
+
+static inline unsigned int mm_vcpumask_size(void)
+{
+	return cpumask_size();
+}
+
+#else
+static inline cpumask_t *mm_vcpumask(struct mm_struct *mm)
+{
+	return NULL;
+}
+
+static inline void mm_init_vcpumask(struct mm_struct *mm) { }
+
+static inline unsigned int mm_vcpumask_size(void)
+{
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_SCHED_MM_VCPU) && defined(CONFIG_NUMA)
+/*
+ * Layout of node vcpumasks:
+ * - node_alloc vcpumask:        cpumask tracking which vcpu_id were
+ *                               allocated (across nodes) in this
+ *                               memory space.
+ * - node vcpumask[nr_node_ids]: per-node cpumask tracking which vcpu_id
+ *                               were allocated in this memory space.
+ */
+static inline cpumask_t *mm_node_alloc_vcpumask(struct mm_struct *mm)
+{
+	unsigned long vcpu_bitmap = (unsigned long)mm_vcpumask(mm);
+
+	/* Skip mm_vcpumask */
+	vcpu_bitmap += cpumask_size();
+	return (struct cpumask *)vcpu_bitmap;
+}
+
+static inline cpumask_t *mm_node_vcpumask(struct mm_struct *mm, unsigned int node)
+{
+	unsigned long vcpu_bitmap = (unsigned long)mm_node_alloc_vcpumask(mm);
+
+	/* Skip node alloc vcpumask */
+	vcpu_bitmap += cpumask_size();
+	vcpu_bitmap += node * cpumask_size();
+	return (struct cpumask *)vcpu_bitmap;
+}
+
+static inline void mm_init_node_vcpumask(struct mm_struct *mm)
+{
+	unsigned int node;
+
+	if (num_possible_nodes() == 1)
+		return;
+	cpumask_clear(mm_node_alloc_vcpumask(mm));
+	for (node = 0; node < nr_node_ids; node++)
+		cpumask_clear(mm_node_vcpumask(mm, node));
+}
+
+static inline void mm_init_vcpu_lock(struct mm_struct *mm)
+{
+	spin_lock_init(&mm->vcpu_lock);
+}
+
+static inline unsigned int mm_node_vcpumask_size(void)
+{
+	if (num_possible_nodes() == 1)
+		return 0;
+	return (nr_node_ids + 1) * cpumask_size();
+}
+#else
+static inline void mm_init_node_vcpumask(struct mm_struct *mm) { }
+static inline void mm_init_vcpu_lock(struct mm_struct *mm) { }
+static inline unsigned int mm_node_vcpumask_size(void)
+{
+	return 0;
+}
+#endif
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6a80ce113d0e..9a2322c51b12 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1300,6 +1300,11 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif
 
+#ifdef CONFIG_SCHED_MM_VCPU
+	int				mm_vcpu;	/* Current vcpu in mm */
+	int				mm_vcpu_active;	/* Whether vcpu bitmap is active */
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	union {
diff --git a/init/Kconfig b/init/Kconfig
index c7900e8975f1..c0e830670b74 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1027,6 +1027,10 @@ config RT_GROUP_SCHED
 
 endif #CGROUP_SCHED
 
+config SCHED_MM_VCPU
+	def_bool y
+	depends on SMP && RSEQ
+
 config UCLAMP_TASK_GROUP
 	bool "Utilization clamping per group of tasks"
 	depends on CGROUP_SCHED
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..11bcca0ca25c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1049,6 +1049,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->reported_split_lock = 0;
 #endif
 
+#ifdef CONFIG_SCHED_MM_VCPU
+	tsk->mm_vcpu = 0;
+	tsk->mm_vcpu_active = 0;
+#endif
 	return tsk;
 
 free_stack:
@@ -1152,6 +1156,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 		goto fail_nocontext;
 
 	mm->user_ns = get_user_ns(user_ns);
+	mm_init_vcpu_lock(mm);
+	mm_init_vcpumask(mm);
+	mm_init_node_vcpumask(mm);
 	return mm;
 
 fail_nocontext:
@@ -1580,6 +1587,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 
 	tsk->mm = mm;
 	tsk->active_mm = mm;
+	sched_vcpu_fork(tsk);
 	return 0;
 }
 
@@ -3018,7 +3026,8 @@ void __init proc_caches_init(void)
 	 * dynamically sized based on the maximum CPU number this system
 	 * can have, taking hotplug into account (nr_cpu_ids).
 	 */
-	mm_size = sizeof(struct mm_struct) + cpumask_size();
+	mm_size = sizeof(struct mm_struct) + cpumask_size() + mm_vcpumask_size() +
+		  mm_node_vcpumask_size();
 
 	mm_cachep = kmem_cache_create_usercopy("mm_struct",
 			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecd..402a68761a2b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4955,6 +4955,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
+	switch_mm_vcpu(prev, next);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -11161,3 +11162,51 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
         trace_sched_update_nr_running_tp(rq, count);
 }
+
+#ifdef CONFIG_SCHED_MM_VCPU
+void sched_vcpu_exit_signals(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+
+	if (!mm)
+		return;
+	preempt_disable();
+	mm_vcpu_put(mm, t->mm_vcpu);
+	t->mm_vcpu = -1;
+	t->mm_vcpu_active = 0;
+	preempt_enable();
+}
+
+void sched_vcpu_before_execve(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+
+	if (!mm)
+		return;
+	preempt_disable();
+	mm_vcpu_put(mm, t->mm_vcpu);
+	t->mm_vcpu = -1;
+	t->mm_vcpu_active = 0;
+	preempt_enable();
+}
+
+void sched_vcpu_after_execve(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+
+	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
+
+	preempt_disable();
+	t->mm_vcpu = mm_vcpu_get(mm);
+	t->mm_vcpu_active = 1;
+	preempt_enable();
+	rseq_set_notify_resume(t);
+}
+
+void sched_vcpu_fork(struct task_struct *t)
+{
+	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
+	t->mm_vcpu = -1;
+	t->mm_vcpu_active = 1;
+}
+#endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 47b89a0fc6e5..59c51fd4367a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3116,4 +3116,170 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
+#ifdef CONFIG_SCHED_MM_VCPU
+static inline int __mm_vcpu_get_single_node(struct mm_struct *mm)
+{
+	struct cpumask *cpumask;
+	int vcpu;
+
+	cpumask = mm_vcpumask(mm);
+	vcpu = cpumask_first_zero(cpumask);
+	if (vcpu >= nr_cpu_ids)
+		return -1;
+	__cpumask_set_cpu(vcpu, cpumask);
+	return vcpu;
+}
+
+#ifdef CONFIG_NUMA
+static inline bool mm_node_vcpumask_test_cpu(struct mm_struct *mm, int vcpu_id)
+{
+	if (num_possible_nodes() == 1)
+		return true;
+	return cpumask_test_cpu(vcpu_id, mm_node_vcpumask(mm, numa_node_id()));
+}
+
+static inline int __mm_vcpu_get(struct mm_struct *mm)
+{
+	struct cpumask *cpumask = mm_vcpumask(mm),
+		       *node_cpumask = mm_node_vcpumask(mm, numa_node_id()),
+		       *node_alloc_cpumask = mm_node_alloc_vcpumask(mm);
+	unsigned int node;
+	int vcpu;
+
+	if (num_possible_nodes() == 1)
+		return __mm_vcpu_get_single_node(mm);
+
+	/*
+	 * Try to reserve lowest available vcpu number within those already
+	 * reserved for this NUMA node.
+	 */
+	vcpu = cpumask_first_one_and_zero(node_cpumask, cpumask);
+	if (vcpu >= nr_cpu_ids)
+		goto alloc_numa;
+	__cpumask_set_cpu(vcpu, cpumask);
+	goto end;
+
+alloc_numa:
+	/*
+	 * Try to reserve lowest available vcpu number within those not already
+	 * allocated for numa nodes.
+	 */
+	vcpu = cpumask_first_zero_and_zero(node_alloc_cpumask, cpumask);
+	if (vcpu >= nr_cpu_ids)
+		goto numa_update;
+	__cpumask_set_cpu(vcpu, cpumask);
+	__cpumask_set_cpu(vcpu, node_cpumask);
+	__cpumask_set_cpu(vcpu, node_alloc_cpumask);
+	goto end;
+
+numa_update:
+	/*
+	 * NUMA node id configuration changed for at least one CPU in the system.
+	 * We need to steal a currently unused vcpu_id from an overprovisioned
+	 * node for our current node. Userspace must handle the fact that the
+	 * node id associated with this vcpu_id may change due to node ID
+	 * reconfiguration.
+	 *
+	 * Count how many possible cpus are attached to each (other) node id,
+	 * and compare this with the per-mm node vcpumask cpu count. Find one
+	 * which has too many cpus in its mask to steal from.
+	 */
+	for (node = 0; node < nr_node_ids; node++) {
+		struct cpumask *iter_cpumask;
+
+		if (node == numa_node_id())
+			continue;
+		iter_cpumask = mm_node_vcpumask(mm, node);
+		if (nr_cpus_node(node) < cpumask_weight(iter_cpumask)) {
+			/* Try to steal from this node. */
+			vcpu = cpumask_first_one_and_zero(iter_cpumask, cpumask);
+			if (vcpu >= nr_cpu_ids)
+				goto steal_fail;
+			__cpumask_set_cpu(vcpu, cpumask);
+			__cpumask_clear_cpu(vcpu, iter_cpumask);
+			__cpumask_set_cpu(vcpu, node_cpumask);
+			goto end;
+		}
+	}
+
+steal_fail:
+	/*
+	 * Our attempt at gracefully stealing a vcpu_id from another
+	 * overprovisioned NUMA node failed. Fallback to grabbing the first
+	 * available vcpu_id.
+	 */
+	vcpu = cpumask_first_zero(cpumask);
+	if (vcpu >= nr_cpu_ids)
+		return -1;
+	__cpumask_set_cpu(vcpu, cpumask);
+	/* Steal vcpu from its numa node mask. */
+	for (node = 0; node < nr_node_ids; node++) {
+		struct cpumask *iter_cpumask;
+
+		if (node == numa_node_id())
+			continue;
+		iter_cpumask = mm_node_vcpumask(mm, node);
+		if (cpumask_test_cpu(vcpu, iter_cpumask)) {
+			__cpumask_clear_cpu(vcpu, iter_cpumask);
+			break;
+		}
+	}
+	__cpumask_set_cpu(vcpu, node_cpumask);
+end:
+	return vcpu;
+}
+
+#else
+static inline bool mm_node_vcpumask_test_cpu(struct mm_struct *mm, int vcpu_id)
+{
+	return true;
+}
+static inline int __mm_vcpu_get(struct mm_struct *mm)
+{
+	return __mm_vcpu_get_single_node(mm);
+}
+#endif
+
+static inline void mm_vcpu_put(struct mm_struct *mm, int vcpu)
+{
+	if (vcpu < 0)
+		return;
+	spin_lock(&mm->vcpu_lock);
+	__cpumask_clear_cpu(vcpu, mm_vcpumask(mm));
+	spin_unlock(&mm->vcpu_lock);
+}
+
+static inline int mm_vcpu_get(struct mm_struct *mm)
+{
+	int ret;
+
+	spin_lock(&mm->vcpu_lock);
+	ret = __mm_vcpu_get(mm);
+	spin_unlock(&mm->vcpu_lock);
+	return ret;
+}
+
+static inline void switch_mm_vcpu(struct task_struct *prev, struct task_struct *next)
+{
+	if (prev->mm_vcpu_active) {
+		if (next->mm_vcpu_active && next->mm == prev->mm) {
+			/*
+			 * Context switch between threads in same mm, hand over
+			 * the mm_vcpu from prev to next.
+			 */
+			next->mm_vcpu = prev->mm_vcpu;
+			prev->mm_vcpu = -1;
+			return;
+		}
+		mm_vcpu_put(prev->mm, prev->mm_vcpu);
+		prev->mm_vcpu = -1;
+	}
+	if (next->mm_vcpu_active)
+		next->mm_vcpu = mm_vcpu_get(next->mm);
+}
+
+#else
+static inline void switch_mm_vcpu(struct task_struct *prev, struct task_struct *next) { }
+#endif
+
 #endif /* _KERNEL_SCHED_SCHED_H */
diff --git a/kernel/signal.c b/kernel/signal.c
index 6f86fda5e432..85611c50a0c7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2949,6 +2949,7 @@ void exit_signals(struct task_struct *tsk)
 	cgroup_threadgroup_change_begin(tsk);
 
 	if (thread_group_empty(tsk) || (tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
+		sched_vcpu_exit_signals(tsk);
 		tsk->flags |= PF_EXITING;
 		cgroup_threadgroup_change_end(tsk);
 		return;
@@ -2959,6 +2960,7 @@ void exit_signals(struct task_struct *tsk)
 	 * From now this task is not visible for group-wide signals,
 	 * see wants_signal(), do_signal_stop().
 	 */
+	sched_vcpu_exit_signals(tsk);
 	tsk->flags |= PF_EXITING;
 
 	cgroup_threadgroup_change_end(tsk);
-- 
2.25.1

