Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FD86D12D7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjC3XJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjC3XJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:09:19 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0AAFF2F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680217755;
        bh=DvPBNHtpLK4dMljweVlPBiWWZwj1994rwadAFIt5K6E=;
        h=From:To:Cc:Subject:Date:From;
        b=wEBqhdsai5eJFUQzqRVm754fY+W00bZdUpwlx6lZ0d1p38az4ZIrYcQ48XPQZ4yCX
         A/FpdV6K3VyvfRH5GgRDXMc5ry0BukA/PUTCnU1zd51CJ/JujFEIlYEWasn6OC0x3i
         4LulvCDtb4Ad7grEcHjEklQsRAK2AnfX45Z75/RePlNVGNkhe8Dk2JmxynnrhuYAT1
         Ryh5VvR/zrjrSTyqs783n/wV295LeCfdYR/7YV918xR0p295nalH4+Kq8FUD0UDlos
         6LCOnISVz1afpygS/agcQh3LsU1YvPKK8gA+8oqpinVBJUcBSJ4jNZyceW/lOv9g5x
         vtZ3XM68SHBBQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PnfHv0CKrztYf;
        Thu, 30 Mar 2023 19:09:15 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Aaron Lu <aaron.lu@intel.com>
Subject: [RFC PATCH] sched: Introduce per-mm/cpu concurrency id state
Date:   Thu, 30 Mar 2023 19:09:11 -0400
Message-Id: <20230330230911.228720-1-mathieu.desnoyers@efficios.com>
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

Keep track of the currently allocated mm_cid for each mm/cpu rather than
freeing them immediately. This eliminates most atomic ops when context
switching back and forth between threads belonging to different memory
spaces in multi-threaded scenarios (many processes, each with many
threads).

This patch is based on v6.3-rc4 with this patch applied:

("mm: Fix memory leak on mm_init error handling")

https://lore.kernel.org/lkml/20230330133822.66271-1-mathieu.desnoyers@efficios.com/

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/mm_types.h | 32 ++++++++++++++++
 kernel/fork.c            |  7 +++-
 kernel/sched/core.c      | 79 ++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h     | 81 ++++++++++++++++++++++++++++++----------
 4 files changed, 169 insertions(+), 30 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0722859c3647..335af2da5b34 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -609,6 +609,7 @@ struct mm_struct {
 		 * were being concurrently updated by the updaters.
 		 */
 		raw_spinlock_t cid_lock;
+		int __percpu *pcpu_cid;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -872,6 +873,16 @@ static inline void vma_iter_init(struct vma_iterator *vmi,
 }
 
 #ifdef CONFIG_SCHED_MM_CID
+
+enum pcpu_cid_state {
+	PCPU_CID_UNSET = -1U,
+};
+
+static inline bool pcpu_cid_is_unset(int cid)
+{
+	return cid == PCPU_CID_UNSET;
+}
+
 /* Accessor for struct mm_struct's cidmask. */
 static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 {
@@ -885,16 +896,37 @@ static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 
 static inline void mm_init_cid(struct mm_struct *mm)
 {
+	int i;
+
 	raw_spin_lock_init(&mm->cid_lock);
+	for_each_possible_cpu(i)
+		*per_cpu_ptr(mm->pcpu_cid, i) = PCPU_CID_UNSET;
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
diff --git a/kernel/fork.c b/kernel/fork.c
index c983c4fe3090..57fdc96ffa49 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -790,6 +790,7 @@ void __mmdrop(struct mm_struct *mm)
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
+	mm_destroy_cid(mm);
 
 	for (i = 0; i < NR_MM_COUNTERS; i++)
 		percpu_counter_destroy(&mm->rss_stat[i]);
@@ -1159,18 +1160,22 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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
index 0d18c3969f90..f07b87d155bd 100644
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
 
@@ -11383,45 +11387,102 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 }
 
 #ifdef CONFIG_SCHED_MM_CID
+/*
+ * Migration is from src cpu to dst cpu. Always called from stopper thread on
+ * src cpu with rq lock held.
+ */
+int sched_mm_cid_migrate_from(struct rq *src_rq, struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	int src_cpu, src_cid;
+	int *src_pcpu_cid;
+
+	if (!mm)
+		return PCPU_CID_UNSET;
+
+	src_cpu = cpu_of(src_rq);
+	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, src_cpu);
+	src_cid = *src_pcpu_cid;
+	if (pcpu_cid_is_unset(src_cid)) {
+		/* src_cid is unset, nothing to clear/grab. */
+		return PCPU_CID_UNSET;
+	}
+	/* Set to PCPU_CID_UNSET, grab ownership. */
+	*src_pcpu_cid = PCPU_CID_UNSET;
+	return src_cid;
+}
+
+void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t, int src_cid)
+{
+	struct mm_struct *mm = t->mm;
+	int dst_cpu, dst_cid;
+	int *dst_pcpu_cid;
+
+	if (!mm || pcpu_cid_is_unset(src_cid))
+		return;
+
+	dst_cpu = cpu_of(dst_rq);
+	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, dst_cpu);
+
+	/* *dst_pcpu_cid = min(src_cid, *dst_pcpu_cid) */
+	dst_cid = *dst_pcpu_cid;
+	if (!pcpu_cid_is_unset(dst_cid) && dst_cid < src_cid) {
+		__mm_cid_put(mm, src_cid);
+		return;
+	}
+	*dst_pcpu_cid = src_cid;
+	if (!pcpu_cid_is_unset(dst_cid)) {
+		/*
+		 * Put dst_cid if not currently in use, else it will be
+		 * lazy put.
+		 */
+		if (dst_rq->curr->mm != mm)
+			__mm_cid_put(mm, dst_cid);
+	}
+}
+
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	unsigned long flags;
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
 
 	if (!mm)
 		return;
-	local_irq_save(flags);
+	rq_lock_irqsave(rq, &rf);
 	mm_cid_put(mm, t->mm_cid);
 	t->mm_cid = -1;
 	t->mm_cid_active = 0;
-	local_irq_restore(flags);
+	rq_unlock_irqrestore(rq, &rf);
 }
 
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	unsigned long flags;
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
 
 	if (!mm)
 		return;
-	local_irq_save(flags);
+	rq_lock_irqsave(rq, &rf);
 	mm_cid_put(mm, t->mm_cid);
 	t->mm_cid = -1;
 	t->mm_cid_active = 0;
-	local_irq_restore(flags);
+	rq_unlock_irqrestore(rq, &rf);
 }
 
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	unsigned long flags;
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
 
 	if (!mm)
 		return;
-	local_irq_save(flags);
+	rq_lock_irqsave(rq, &rf);
 	t->mm_cid = mm_cid_get(mm);
 	t->mm_cid_active = 1;
-	local_irq_restore(flags);
+	rq_unlock_irqrestore(rq, &rf);
 	rseq_set_notify_resume(t);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..7b93847b89a3 100644
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
+		*pcpu_cid = PCPU_CID_UNSET;
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
@@ -3262,40 +3302,38 @@ static inline int __mm_cid_get(struct mm_struct *mm)
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
+	if (pcpu_cid_is_unset(cid)) {
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
@@ -3304,6 +3342,9 @@ static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *n
 
 #else
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
+static inline void sched_mm_cid_migrate(struct rq *rq, struct task_struct *t, int new_cpu) { }
+static inline int sched_mm_cid_migrate_from(struct rq *src_rq, struct task_struct *t) { return 0; }
+static inline void sched_mm_cid_migrate_to(struct rq *src_rq, struct task_struct *t, int cid) { }
 #endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.25.1

