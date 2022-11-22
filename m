Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509816348A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiKVUmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiKVUk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:40:29 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18196B389;
        Tue, 22 Nov 2022 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149594;
        bh=SvSw6S6e6tNfd6zrniG0qDKZ90D4V2JsOuZkwcMLt50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GX9PyzQ1VfxNh7aVUCaTMFBuiF6jgRbZZ6n2zVI5SawH7X3WOBAUfCUN+GHtlzl9/
         oBEgFxlgVTs6DgdsVhmQI/vcUrIaPaDBPONWdLqsDadk1W4/tOPLdg0uhe+CItqOVd
         0lMvY9schWolPPD4CFdbzQoKhDnD+Q60s+ze8mE9AjXJsUpfSzdBxgX5HEzgBfMfr1
         JW2dNE7SEOzBwOhW63nvwusiWwWiZ5wEFcphScF53TwIEtluFdBiHirjXCbULv2r05
         DstqyIEVnOAAka4oUmyOE7d+79WLfSXjTnlne+xzLAQYP7y0cDccw4BtgUKSSWueAZ
         gclxxPCB8FgRg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2f2cTNzWgr;
        Tue, 22 Nov 2022 15:39:54 -0500 (EST)
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
Subject: [PATCH 24/30] sched: NUMA-aware per-memory-map concurrency ID
Date:   Tue, 22 Nov 2022 15:39:26 -0500
Message-Id: <20221122203932.231377-25-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep track of a NUMA-aware concurrency ID. On NUMA systems, when a
NUMA-aware concurrency ID is observed by user-space to be associated
with a NUMA node, it is guaranteed to never change NUMA node unless a
kernel-level NUMA configuration change happens.

Exposing a numa-aware concurrency ID is useful in situations where a
process or a set of processes belonging to cpuset are pinned to a set of
cores which belong to a subset of the system's NUMA nodes. In those
situations, it is possible to benefit from the compactness of
concurrency IDs over CPU ids, while keeping NUMA locality, for indexing
a per-cpu data structure which takes into account NUMA locality.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/mm.h       |  18 +++++
 include/linux/mm_types.h |  68 +++++++++++++++-
 include/linux/sched.h    |   3 +
 kernel/fork.c            |   3 +
 kernel/sched/core.c      |   8 +-
 kernel/sched/sched.h     | 168 +++++++++++++++++++++++++++++++++++----
 6 files changed, 245 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e0fba52de3e2..c7dfdf4c9d08 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3484,6 +3484,20 @@ static inline int task_mm_cid(struct task_struct *t)
 {
 	return t->mm_cid;
 }
+#ifdef CONFIG_NUMA
+static inline int task_mm_numa_cid(struct task_struct *t)
+{
+	if (num_possible_nodes() == 1)
+		return task_mm_cid(t);
+	else
+		return t->mm_numa_cid;
+}
+#else
+static inline int task_mm_numa_cid(struct task_struct *t)
+{
+	return task_mm_cid(t);
+}
+#endif
 #else
 static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
@@ -3498,6 +3512,10 @@ static inline int task_mm_cid(struct task_struct *t)
 	 */
 	return raw_smp_processor_id();
 }
+static inline int task_mm_numa_cid(struct task_struct *t)
+{
+	return task_mm_cid(t);
+}
 #endif
 
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index dabb42d26bb9..8c9afe8ce603 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -18,6 +18,7 @@
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
+#include <linux/nodemask.h>
 
 #include <asm/mmu.h>
 
@@ -847,15 +848,80 @@ static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 	return (struct cpumask *)cid_bitmap;
 }
 
+#ifdef CONFIG_NUMA
+/*
+ * Layout of node cidmasks:
+ * - mm_numa cidmask:           cpumask of the currently used mm_numa cids.
+ * - node_alloc cidmask:        cpumask tracking which cid were
+ *                              allocated (across nodes) in this
+ *                              memory map.
+ * - node cidmask[nr_node_ids]: per-node cpumask tracking which cid
+ *                              were allocated in this memory map.
+ */
+static inline cpumask_t *mm_numa_cidmask(struct mm_struct *mm)
+{
+	unsigned long cid_bitmap = (unsigned long)mm_cidmask(mm);
+
+	/* Skip mm_cidmask */
+	cid_bitmap += cpumask_size();
+	return (struct cpumask *)cid_bitmap;
+}
+
+static inline cpumask_t *mm_node_alloc_cidmask(struct mm_struct *mm)
+{
+	unsigned long cid_bitmap = (unsigned long)mm_numa_cidmask(mm);
+
+	/* Skip mm_numa_cidmask */
+	cid_bitmap += cpumask_size();
+	return (struct cpumask *)cid_bitmap;
+}
+
+static inline cpumask_t *mm_node_cidmask(struct mm_struct *mm, unsigned int node)
+{
+	unsigned long cid_bitmap = (unsigned long)mm_node_alloc_cidmask(mm);
+
+	/* Skip node alloc cidmask */
+	cid_bitmap += cpumask_size();
+	cid_bitmap += node * cpumask_size();
+	return (struct cpumask *)cid_bitmap;
+}
+
+static inline void mm_init_node_cidmask(struct mm_struct *mm)
+{
+	unsigned int node;
+
+	if (num_possible_nodes() == 1)
+		return;
+	cpumask_clear(mm_numa_cidmask(mm));
+	cpumask_clear(mm_node_alloc_cidmask(mm));
+	for (node = 0; node < nr_node_ids; node++)
+		cpumask_clear(mm_node_cidmask(mm, node));
+}
+
+static inline unsigned int mm_node_cidmask_size(void)
+{
+	if (num_possible_nodes() == 1)
+		return 0;
+	return (nr_node_ids + 2) * cpumask_size();
+}
+#else /* CONFIG_NUMA */
+static inline void mm_init_node_cidmask(struct mm_struct *mm) { }
+static inline unsigned int mm_node_cidmask_size(void)
+{
+	return 0;
+}
+#endif /* CONFIG_NUMA */
+
 static inline void mm_init_cid(struct mm_struct *mm)
 {
 	raw_spin_lock_init(&mm->cid_lock);
 	cpumask_clear(mm_cidmask(mm));
+	mm_init_node_cidmask(mm);
 }
 
 static inline unsigned int mm_cid_size(void)
 {
-	return cpumask_size();
+	return cpumask_size() + mm_node_cidmask_size();
 }
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm) { }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c7e3c27e0e2e..990ef3d4b22b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1317,6 +1317,9 @@ struct task_struct {
 #ifdef CONFIG_SCHED_MM_CID
 	int				mm_cid;		/* Current cid in mm */
 	int				mm_cid_active;	/* Whether cid bitmap is active */
+#ifdef CONFIG_NUMA
+	int				mm_numa_cid;	/* Current numa_cid in mm */
+#endif
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
diff --git a/kernel/fork.c b/kernel/fork.c
index d48dedc4be75..364f4c62b1a4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1050,6 +1050,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_SCHED_MM_CID
 	tsk->mm_cid = -1;
 	tsk->mm_cid_active = 0;
+#ifdef CONFIG_NUMA
+	tsk->mm_numa_cid = -1;
+#endif
 #endif
 	return tsk;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ef0cc40cca6b..095b5eb35d3d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11284,8 +11284,7 @@ void sched_mm_cid_exit_signals(struct task_struct *t)
 	if (!mm)
 		return;
 	local_irq_save(flags);
-	mm_cid_put(mm, t->mm_cid);
-	t->mm_cid = -1;
+	mm_cid_put(mm, t);
 	t->mm_cid_active = 0;
 	local_irq_restore(flags);
 }
@@ -11298,8 +11297,7 @@ void sched_mm_cid_before_execve(struct task_struct *t)
 	if (!mm)
 		return;
 	local_irq_save(flags);
-	mm_cid_put(mm, t->mm_cid);
-	t->mm_cid = -1;
+	mm_cid_put(mm, t);
 	t->mm_cid_active = 0;
 	local_irq_restore(flags);
 }
@@ -11312,7 +11310,7 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
 
 	local_irq_save(flags);
-	t->mm_cid = mm_cid_get(mm);
+	mm_cid_get(mm, t);
 	t->mm_cid_active = 1;
 	local_irq_restore(flags);
 	rseq_set_notify_resume(t);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0096dc22926e..87f61f926e88 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3262,38 +3262,174 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
 }
 
 #ifdef CONFIG_SCHED_MM_CID
-static inline int __mm_cid_get(struct mm_struct *mm)
+#ifdef CONFIG_NUMA
+static inline void __mm_numa_cid_get(struct mm_struct *mm, struct task_struct *t)
+{
+	struct cpumask *cpumask = mm_numa_cidmask(mm),
+		       *node_cpumask = mm_node_cidmask(mm, numa_node_id()),
+		       *node_alloc_cpumask = mm_node_alloc_cidmask(mm);
+	unsigned int node;
+	int cid;
+
+	if (num_possible_nodes() == 1) {
+		cid = -1;
+		goto end;
+	}
+
+	/*
+	 * Try to reserve lowest available cid number within those already
+	 * reserved for this NUMA node.
+	 */
+	cid = cpumask_first_andnot(node_cpumask, cpumask);
+	if (cid >= nr_cpu_ids)
+		goto alloc_numa;
+	__cpumask_set_cpu(cid, cpumask);
+	goto end;
+
+alloc_numa:
+	/*
+	 * Try to reserve lowest available cid number within those not already
+	 * allocated for numa nodes.
+	 */
+	cid = cpumask_first_notandnot(node_alloc_cpumask, cpumask);
+	if (cid >= nr_cpu_ids)
+		goto numa_update;
+	__cpumask_set_cpu(cid, cpumask);
+	__cpumask_set_cpu(cid, node_cpumask);
+	__cpumask_set_cpu(cid, node_alloc_cpumask);
+	goto end;
+
+numa_update:
+	/*
+	 * NUMA node id configuration changed for at least one CPU in the system.
+	 * We need to steal a currently unused cid from an overprovisioned
+	 * node for our current node. Userspace must handle the fact that the
+	 * node id associated with this cid may change due to node ID
+	 * reconfiguration.
+	 *
+	 * Count how many possible cpus are attached to each (other) node id,
+	 * and compare this with the per-mm node cidmask cpu count. Find one
+	 * which has too many cpus in its mask to steal from.
+	 */
+	for (node = 0; node < nr_node_ids; node++) {
+		struct cpumask *iter_cpumask;
+
+		if (node == numa_node_id())
+			continue;
+		iter_cpumask = mm_node_cidmask(mm, node);
+		if (nr_cpus_node(node) < cpumask_weight(iter_cpumask)) {
+			/* Try to steal from this node. */
+			cid = cpumask_first_andnot(iter_cpumask, cpumask);
+			if (cid >= nr_cpu_ids)
+				goto steal_fail;
+			__cpumask_set_cpu(cid, cpumask);
+			__cpumask_clear_cpu(cid, iter_cpumask);
+			__cpumask_set_cpu(cid, node_cpumask);
+			goto end;
+		}
+	}
+
+steal_fail:
+	/*
+	 * Our attempt at gracefully stealing a cid from another
+	 * overprovisioned NUMA node failed. Fallback to grabbing the first
+	 * available cid.
+	 */
+	cid = cpumask_first_zero(cpumask);
+	if (cid >= nr_cpu_ids) {
+		cid = -1;
+		goto end;
+	}
+	__cpumask_set_cpu(cid, cpumask);
+	/* Steal cid from its numa node mask. */
+	for (node = 0; node < nr_node_ids; node++) {
+		struct cpumask *iter_cpumask;
+
+		if (node == numa_node_id())
+			continue;
+		iter_cpumask = mm_node_cidmask(mm, node);
+		if (cpumask_test_cpu(cid, iter_cpumask)) {
+			__cpumask_clear_cpu(cid, iter_cpumask);
+			break;
+		}
+	}
+	__cpumask_set_cpu(cid, node_cpumask);
+end:
+	t->mm_numa_cid = cid;
+}
+
+static inline void __mm_numa_cid_put(struct mm_struct *mm, struct task_struct *t)
+{
+	int cid = t->mm_numa_cid;
+
+	if (num_possible_nodes() == 1)
+		return;
+	if (cid < 0)
+		return;
+	__cpumask_clear_cpu(cid, mm_numa_cidmask(mm));
+	t->mm_numa_cid = -1;
+}
+
+static inline void mm_numa_transfer_cid_prev_next(struct task_struct *prev, struct task_struct *next)
+{
+	next->mm_numa_cid = prev->mm_numa_cid;
+	prev->mm_numa_cid = -1;
+}
+#else
+static inline void __mm_numa_cid_get(struct mm_struct *mm, struct task_struct *t) { }
+static inline void __mm_numa_cid_put(struct mm_struct *mm, struct task_struct *t) { }
+static inline void mm_numa_transfer_cid_prev_next(struct task_struct *prev, struct task_struct *next) { }
+#endif
+
+static inline void __mm_cid_get(struct mm_struct *mm, struct task_struct *t)
 {
 	struct cpumask *cpumask;
 	int cid;
 
 	cpumask = mm_cidmask(mm);
 	cid = cpumask_first_zero(cpumask);
-	if (cid >= nr_cpu_ids)
-		return -1;
+	if (cid >= nr_cpu_ids) {
+		cid = -1;
+		goto end;
+	}
 	__cpumask_set_cpu(cid, cpumask);
-	return cid;
+end:
+	t->mm_cid = cid;
 }
 
-static inline void mm_cid_put(struct mm_struct *mm, int cid)
+static inline void mm_cid_get(struct mm_struct *mm, struct task_struct *t)
 {
 	lockdep_assert_irqs_disabled();
-	if (cid < 0)
-		return;
 	raw_spin_lock(&mm->cid_lock);
-	__cpumask_clear_cpu(cid, mm_cidmask(mm));
+	__mm_cid_get(mm, t);
+	__mm_numa_cid_get(mm, t);
 	raw_spin_unlock(&mm->cid_lock);
 }
 
-static inline int mm_cid_get(struct mm_struct *mm)
+static inline void __mm_cid_put(struct mm_struct *mm, struct task_struct *t)
 {
-	int ret;
+	int cid = t->mm_cid;
+
+	if (cid < 0)
+		return;
+	__cpumask_clear_cpu(cid, mm_cidmask(mm));
+	t->mm_cid = -1;
+}
 
+static inline void mm_cid_put(struct mm_struct *mm, struct task_struct *t)
+{
 	lockdep_assert_irqs_disabled();
 	raw_spin_lock(&mm->cid_lock);
-	ret = __mm_cid_get(mm);
+	__mm_cid_put(mm, t);
+	__mm_numa_cid_put(mm, t);
 	raw_spin_unlock(&mm->cid_lock);
-	return ret;
+}
+
+static inline void mm_transfer_cid_prev_next(struct task_struct *prev, struct task_struct *next)
+{
+	next->mm_cid = prev->mm_cid;
+	prev->mm_cid = -1;
+	mm_numa_transfer_cid_prev_next(prev, next);
 }
 
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
@@ -3304,15 +3440,13 @@ static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *n
 			 * Context switch between threads in same mm, hand over
 			 * the mm_cid from prev to next.
 			 */
-			next->mm_cid = prev->mm_cid;
-			prev->mm_cid = -1;
+			mm_transfer_cid_prev_next(prev, next);
 			return;
 		}
-		mm_cid_put(prev->mm, prev->mm_cid);
-		prev->mm_cid = -1;
+		mm_cid_put(prev->mm, prev);
 	}
 	if (next->mm_cid_active)
-		next->mm_cid = mm_cid_get(next->mm);
+		mm_cid_get(next->mm, next);
 }
 
 #else
-- 
2.25.1

