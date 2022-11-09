Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D69B62283E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKIKTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKIKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:19:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B8320353;
        Wed,  9 Nov 2022 02:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k3fhI0EDQhx144oOIVYum1ejVOBa/krogJebW64v4jw=; b=aawUreYdObygKvpeUS0YezekcC
        FjtjM60pvE5P7GTzJ6hpXlJ4ULWclz11Q3BY3Bp87uAjYBP/U6Ff/r/ungcruGj1I2Xp+PoPAH6QQ
        kAYQ0BlrS/QNumLoZISR07cXe9BfQP+vJu2qjDzvg7Zwwxm09jxFPEWIx1cAaNXOpJpYNUWDoDeHc
        ciwANKoGAl6fsUHzF7W5EXL4Xk6uMQx8HS1vryjR3fojHwws+SvkWhCVDY8luKIdvFFEnpSiIbtGj
        9wV10qghZOyM285QmJpkuGHmw1nwpKzQTCcDSzK5Mf7G7YVEtyHhXzCsMTL5bMnNDvdLl2LLTx/IU
        X4bgpHew==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osiB7-00B5p4-2m; Wed, 09 Nov 2022 10:19:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D981A30036B;
        Wed,  9 Nov 2022 11:19:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDFCD2BD856FF; Wed,  9 Nov 2022 11:19:20 +0100 (CET)
Date:   Wed, 9 Nov 2022 11:19:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Message-ID: <Y2t+qOoDLaoH2ipo@hirez.programming.kicks-ass.net>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
 <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
 <Y2pT7ij/TcI4EmH6@hirez.programming.kicks-ass.net>
 <580eec2b-f204-2eb1-806d-8282b8b60bf2@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580eec2b-f204-2eb1-806d-8282b8b60bf2@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 03:07:42PM -0500, Mathieu Desnoyers wrote:
> On 2022-11-08 08:04, Peter Zijlstra wrote:
> > On Thu, Nov 03, 2022 at 04:03:43PM -0400, Mathieu Desnoyers wrote:
> > 
> > > The credit goes to Paul Turner (Google) for the vcpu_id idea. This
> > > feature is implemented based on the discussions with Paul Turner and
> > > Peter Oskolkov (Google), but I took the liberty to implement scheduler
> > > fast-path optimizations and my own NUMA-awareness scheme. The rumor has
> > > it that Google have been running a rseq vcpu_id extension internally at
> > > Google in production for a year. The tcmalloc source code indeed has
> > > comments hinting at a vcpu_id prototype extension to the rseq system
> > > call [1].
> > 
> > Re NUMA thing -- that means that on a 512 node system a single threaded
> > task can still observe 512 separate vcpu-ids, right?
> 
> Yes, that's correct.

So,.. I've been thinking. How about we expose _two_ vcpu-ids :-)

One is the original, system wide min(nr_thread, nr_cpus) and the other
is a per-node vcpu-id. Not like you did, but min(nr_threads,
nr_cpus_per_node) like.

That way userspace can either use:

 - rseq::cpu_id -- as it does today

 - rseq::vcpu_id -- (when -1, see rseq::cpu_id) the original vcpu_id
                    proposal, which is typically good enough when your
		    application is not NUMA aware and relies on NUMA
		    balancing (most every application out there)

 - rseq::node_id *and*
   rseq::vcpu_node_id -- Combined it gives both node locality
                         and a *dense* space within the node.

This then lets the application pick whatever is best.

Note that using node affine memory allocations by default is a *very*
bad idea since it wrecks NUMA balancing, you really should only use this
if you application is fully NUMA aware and knows what it is doing.


---
 include/linux/mm.h        |   15 ++--
 include/linux/mm_types.h  |   23 +-----
 include/linux/sched.h     |    1 
 include/uapi/linux/rseq.h |    1 
 kernel/fork.c             |    1 
 kernel/rseq.c             |    9 ++
 kernel/sched/core.c       |   18 ++---
 kernel/sched/sched.h      |  157 +++++++++-------------------------------------
 8 files changed, 66 insertions(+), 159 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3484,6 +3484,10 @@ static inline int task_mm_vcpu_id(struct
 {
 	return t->mm_vcpu;
 }
+static inline int task_mm_vcpu_node_id(struct task_struct *t)
+{
+	return t->mm_vcpu_node;
+}
 #else
 static inline void sched_vcpu_before_execve(struct task_struct *t) { }
 static inline void sched_vcpu_after_execve(struct task_struct *t) { }
@@ -3491,12 +3495,11 @@ static inline void sched_vcpu_fork(struc
 static inline void sched_vcpu_exit_signals(struct task_struct *t) { }
 static inline int task_mm_vcpu_id(struct task_struct *t)
 {
-	/*
-	 * Use the processor id as a fall-back when the mm vcpu feature is
-	 * disabled. This provides functional per-cpu data structure accesses
-	 * in user-space, althrough it won't provide the memory usage benefits.
-	 */
-	return raw_smp_processor_id();
+	return -1; /* userspace should use cpu_id */
+}
+static inline int task_mm_vcpu_node_id(struct task_struct *t)
+{
+	return -1;
 }
 #endif
 
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -568,7 +568,7 @@ struct mm_struct {
 		 * bitmap words as they were being concurrently updated by the
 		 * updaters.
 		 */
-		spinlock_t vcpu_lock;
+		raw_spinlock_t vcpu_lock;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* PTE page table pages */
@@ -875,28 +875,15 @@ static inline unsigned int mm_vcpumask_s
 
 #if defined(CONFIG_SCHED_MM_VCPU) && defined(CONFIG_NUMA)
 /*
- * Layout of node vcpumasks:
- * - node_alloc vcpumask:        cpumask tracking which vcpu_id were
- *                               allocated (across nodes) in this
- *                               memory space.
  * - node vcpumask[nr_node_ids]: per-node cpumask tracking which vcpu_id
  *                               were allocated in this memory space.
  */
-static inline cpumask_t *mm_node_alloc_vcpumask(struct mm_struct *mm)
+static inline cpumask_t *mm_node_vcpumask(struct mm_struct *mm, unsigned int node)
 {
 	unsigned long vcpu_bitmap = (unsigned long)mm_vcpumask(mm);
 
 	/* Skip mm_vcpumask */
 	vcpu_bitmap += cpumask_size();
-	return (struct cpumask *)vcpu_bitmap;
-}
-
-static inline cpumask_t *mm_node_vcpumask(struct mm_struct *mm, unsigned int node)
-{
-	unsigned long vcpu_bitmap = (unsigned long)mm_node_alloc_vcpumask(mm);
-
-	/* Skip node alloc vcpumask */
-	vcpu_bitmap += cpumask_size();
 	vcpu_bitmap += node * cpumask_size();
 	return (struct cpumask *)vcpu_bitmap;
 }
@@ -907,21 +894,21 @@ static inline void mm_init_node_vcpumask
 
 	if (num_possible_nodes() == 1)
 		return;
-	cpumask_clear(mm_node_alloc_vcpumask(mm));
+
 	for (node = 0; node < nr_node_ids; node++)
 		cpumask_clear(mm_node_vcpumask(mm, node));
 }
 
 static inline void mm_init_vcpu_lock(struct mm_struct *mm)
 {
-	spin_lock_init(&mm->vcpu_lock);
+	raw_spin_lock_init(&mm->vcpu_lock);
 }
 
 static inline unsigned int mm_node_vcpumask_size(void)
 {
 	if (num_possible_nodes() == 1)
 		return 0;
-	return (nr_node_ids + 1) * cpumask_size();
+	return nr_node_ids * cpumask_size();
 }
 #else
 static inline void mm_init_node_vcpumask(struct mm_struct *mm) { }
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1316,6 +1316,7 @@ struct task_struct {
 
 #ifdef CONFIG_SCHED_MM_VCPU
 	int				mm_vcpu;	/* Current vcpu in mm */
+	int				mm_node_vcpu;	/* Current vcpu for this node */
 	int				mm_vcpu_active;	/* Whether vcpu bitmap is active */
 #endif
 
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -147,6 +147,7 @@ struct rseq {
 	 * (allocated uniquely within a memory space).
 	 */
 	__u32 vm_vcpu_id;
+	__u32 vm_vcpu_node_id;
 
 	/*
 	 * Flexible array member at end of structure, after last feature field.
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1049,6 +1049,7 @@ static struct task_struct *dup_task_stru
 
 #ifdef CONFIG_SCHED_MM_VCPU
 	tsk->mm_vcpu = -1;
+	tsk->mm_vcpu_node = -1;
 	tsk->mm_vcpu_active = 0;
 #endif
 	return tsk;
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -91,6 +91,7 @@ static int rseq_update_cpu_node_id(struc
 	u32 cpu_id = raw_smp_processor_id();
 	u32 node_id = cpu_to_node(cpu_id);
 	u32 vm_vcpu_id = task_mm_vcpu_id(t);
+	u32 vm_vcpu_node_id = task_mm_vcpu_node_id(t);
 
 	WARN_ON_ONCE((int) vm_vcpu_id < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
@@ -99,6 +100,7 @@ static int rseq_update_cpu_node_id(struc
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
 	unsafe_put_user(node_id, &rseq->node_id, efault_end);
 	unsafe_put_user(vm_vcpu_id, &rseq->vm_vcpu_id, efault_end);
+	unsafe_put_user(vm_vcpu_node_id, &rseq->vm_vcpu_node_id, efault_end);
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
@@ -116,8 +118,8 @@ static int rseq_update_cpu_node_id(struc
 
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
-	    vm_vcpu_id = 0;
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
+	u32 node_id = 0, vm_vcpu_id = -1, vm_vcpu_node_id = -1;
 
 	/*
 	 * Reset cpu_id_start to its initial state (0).
@@ -141,6 +143,9 @@ static int rseq_reset_rseq_cpu_node_id(s
 	 */
 	if (put_user(vm_vcpu_id, &t->rseq->vm_vcpu_id))
 		return -EFAULT;
+
+	if (put_user(vm_vcpu_node_id, &t->rseq->vm_vcpu_node_id))
+		return -EFAULT;
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11278,15 +11278,13 @@ void call_trace_sched_update_nr_running(
 #ifdef CONFIG_SCHED_MM_VCPU
 void sched_vcpu_exit_signals(struct task_struct *t)
 {
-	struct mm_struct *mm = t->mm;
 	unsigned long flags;
 
-	if (!mm)
+	if (!t->mm)
 		return;
+
 	local_irq_save(flags);
-	mm_vcpu_put(mm, t->mm_vcpu);
-	t->mm_vcpu = -1;
-	t->mm_vcpu_active = 0;
+	mm_vcpu_put(t);
 	local_irq_restore(flags);
 }
 
@@ -11297,10 +11295,9 @@ void sched_vcpu_before_execve(struct tas
 
 	if (!mm)
 		return;
+
 	local_irq_save(flags);
-	mm_vcpu_put(mm, t->mm_vcpu);
-	t->mm_vcpu = -1;
-	t->mm_vcpu_active = 0;
+	mm_vcpu_put(t);
 	local_irq_restore(flags);
 }
 
@@ -11312,9 +11309,9 @@ void sched_vcpu_after_execve(struct task
 	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
 
 	local_irq_save(flags);
-	t->mm_vcpu = mm_vcpu_get(mm);
-	t->mm_vcpu_active = 1;
+	mm_vcpu_get(t);
 	local_irq_restore(flags);
+
 	rseq_set_notify_resume(t);
 }
 
@@ -11322,6 +11319,7 @@ void sched_vcpu_fork(struct task_struct
 {
 	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
 	t->mm_vcpu = -1;
+	t->mm_vcpu_node = -1;
 	t->mm_vcpu_active = 1;
 }
 #endif
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3262,147 +3262,57 @@ static inline void update_current_exec_r
 }
 
 #ifdef CONFIG_SCHED_MM_VCPU
-static inline int __mm_vcpu_get_single_node(struct mm_struct *mm)
+static inline int __mm_vcpu_get(struct cpumask *cpumask)
 {
-	struct cpumask *cpumask;
 	int vcpu;
 
-	cpumask = mm_vcpumask(mm);
 	vcpu = cpumask_first_zero(cpumask);
-	if (vcpu >= nr_cpu_ids)
+	if (WARN_ON_ONCE(vcpu >= nr_cpu_ids))
 		return -1;
+
 	__cpumask_set_cpu(vcpu, cpumask);
 	return vcpu;
 }
 
-#ifdef CONFIG_NUMA
-static inline bool mm_node_vcpumask_test_cpu(struct mm_struct *mm, int vcpu_id)
-{
-	if (num_possible_nodes() == 1)
-		return true;
-	return cpumask_test_cpu(vcpu_id, mm_node_vcpumask(mm, numa_node_id()));
-}
 
-static inline int __mm_vcpu_get(struct mm_struct *mm)
+static inline void __mm_vcpu_put(struct task_struct *p, bool clear_active)
 {
-	struct cpumask *cpumask = mm_vcpumask(mm),
-		       *node_cpumask = mm_node_vcpumask(mm, numa_node_id()),
-		       *node_alloc_cpumask = mm_node_alloc_vcpumask(mm);
-	unsigned int node;
-	int vcpu;
-
-	if (num_possible_nodes() == 1)
-		return __mm_vcpu_get_single_node(mm);
-
-	/*
-	 * Try to reserve lowest available vcpu number within those already
-	 * reserved for this NUMA node.
-	 */
-	vcpu = cpumask_first_andnot(node_cpumask, cpumask);
-	if (vcpu >= nr_cpu_ids)
-		goto alloc_numa;
-	__cpumask_set_cpu(vcpu, cpumask);
-	goto end;
+	lockdep_assert_irqs_disabled();
+	WARN_ON_ONCE(p->mm_vcpu < 0);
 
-alloc_numa:
-	/*
-	 * Try to reserve lowest available vcpu number within those not already
-	 * allocated for numa nodes.
-	 */
-	vcpu = cpumask_first_notandnot(node_alloc_cpumask, cpumask);
-	if (vcpu >= nr_cpu_ids)
-		goto numa_update;
-	__cpumask_set_cpu(vcpu, cpumask);
-	__cpumask_set_cpu(vcpu, node_cpumask);
-	__cpumask_set_cpu(vcpu, node_alloc_cpumask);
-	goto end;
-
-numa_update:
-	/*
-	 * NUMA node id configuration changed for at least one CPU in the system.
-	 * We need to steal a currently unused vcpu_id from an overprovisioned
-	 * node for our current node. Userspace must handle the fact that the
-	 * node id associated with this vcpu_id may change due to node ID
-	 * reconfiguration.
-	 *
-	 * Count how many possible cpus are attached to each (other) node id,
-	 * and compare this with the per-mm node vcpumask cpu count. Find one
-	 * which has too many cpus in its mask to steal from.
-	 */
-	for (node = 0; node < nr_node_ids; node++) {
-		struct cpumask *iter_cpumask;
-
-		if (node == numa_node_id())
-			continue;
-		iter_cpumask = mm_node_vcpumask(mm, node);
-		if (nr_cpus_node(node) < cpumask_weight(iter_cpumask)) {
-			/* Try to steal from this node. */
-			vcpu = cpumask_first_andnot(iter_cpumask, cpumask);
-			if (vcpu >= nr_cpu_ids)
-				goto steal_fail;
-			__cpumask_set_cpu(vcpu, cpumask);
-			__cpumask_clear_cpu(vcpu, iter_cpumask);
-			__cpumask_set_cpu(vcpu, node_cpumask);
-			goto end;
-		}
-	}
+	raw_spin_lock(&mm->vcpu_lock);
 
-steal_fail:
-	/*
-	 * Our attempt at gracefully stealing a vcpu_id from another
-	 * overprovisioned NUMA node failed. Fallback to grabbing the first
-	 * available vcpu_id.
-	 */
-	vcpu = cpumask_first_zero(cpumask);
-	if (vcpu >= nr_cpu_ids)
-		return -1;
-	__cpumask_set_cpu(vcpu, cpumask);
-	/* Steal vcpu from its numa node mask. */
-	for (node = 0; node < nr_node_ids; node++) {
-		struct cpumask *iter_cpumask;
-
-		if (node == numa_node_id())
-			continue;
-		iter_cpumask = mm_node_vcpumask(mm, node);
-		if (cpumask_test_cpu(vcpu, iter_cpumask)) {
-			__cpumask_clear_cpu(vcpu, iter_cpumask);
-			break;
-		}
-	}
-	__cpumask_set_cpu(vcpu, node_cpumask);
-end:
-	return vcpu;
-}
+	__cpumask_clear_cpu(p->mm_vcpu, mm_vcpumask(mm));
+	p->mm_vcpu = -1;
+#ifdef CONFIG_NUMA
+	__cpumask_clear_cpu(p->mm_vcpu_node, mm_node_vcpumask(mm, task_node(p)));
+	p->mm_vcpu_node = -1;
+#endif
+	if (clear_active)
+		p->mm_vcpu_active = 0;
 
-#else
-static inline bool mm_node_vcpumask_test_cpu(struct mm_struct *mm, int vcpu_id)
-{
-	return true;
-}
-static inline int __mm_vcpu_get(struct mm_struct *mm)
-{
-	return __mm_vcpu_get_single_node(mm);
+	raw_spin_unlock(&mm->vcpu_lock);
 }
-#endif
 
-static inline void mm_vcpu_put(struct mm_struct *mm, int vcpu)
+static inline void mm_vcpu_put(struct task_struct *p, bool clear_active)
 {
-	lockdep_assert_irqs_disabled();
-	if (vcpu < 0)
-		return;
-	spin_lock(&mm->vcpu_lock);
-	__cpumask_clear_cpu(vcpu, mm_vcpumask(mm));
-	spin_unlock(&mm->vcpu_lock);
+	__mm_vcpu_put(p, true);
 }
 
-static inline int mm_vcpu_get(struct mm_struct *mm)
+static inline void mm_vcpu_get(struct task_struct *p)
 {
 	int ret;
 
 	lockdep_assert_irqs_disabled();
-	spin_lock(&mm->vcpu_lock);
-	ret = __mm_vcpu_get(mm);
-	spin_unlock(&mm->vcpu_lock);
+	WARN_ON_ONCE(p->mm_vcpu > 0);
+
+	raw_spin_lock(&mm->vcpu_lock);
+	p->mm_vcpu = __mm_vcpu_get(mm_vcpumask(m));
+#ifdef CONFIG_NUMA
+	p->mm_vcpu_node = __mm_vcpu_get(mm_node_vcpumask(mm, task_node(p)));
+#endif
+	p->mm_vcpu_active = 1;
+	raw_spin_unlock(&mm->vcpu_lock);
 	return ret;
 }
 
@@ -3414,15 +3324,16 @@ static inline void switch_mm_vcpu(struct
 			 * Context switch between threads in same mm, hand over
 			 * the mm_vcpu from prev to next.
 			 */
-			next->mm_vcpu = prev->mm_vcpu;
-			prev->mm_vcpu = -1;
+			swap(next->mm_vcpu, prev->mm_vcpu);
+#ifdef CONFIG_NUMA
+			swap(next->mm_vcpu_node, prev->mm_vcpu_node);
+#endif
 			return;
 		}
-		mm_vcpu_put(prev->mm, prev->mm_vcpu);
-		prev->mm_vcpu = -1;
+		__mm_vcpu_put(prev, false);
 	}
 	if (next->mm_vcpu_active)
-		next->mm_vcpu = mm_vcpu_get(next->mm);
+		mm_vcpu_get(next);
 }
 
 #else
