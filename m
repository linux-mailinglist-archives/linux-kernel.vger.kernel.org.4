Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F90E610A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJ1Gns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ1GmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216591BA1EE;
        Thu, 27 Oct 2022 23:42:15 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5pWWf+3dsIOu8CSx9lrBiUn5W4Lnb/neXb0oKsFWAng=;
        b=4ZPiVHPI0iFWRK9ednqGdsD5fbSGi0bqlFCld5sXPpjiWF/EkTMPKRJCqEvj91C8CQoG2i
        iWBtLeCmhDKS7TvCzI2GmuMkLt+9kbxTSTtk2qiqeks1vMFiVrlIC/3OTbK3GI5U9oK+9X
        tASPAEoECVGoAnOrV/NUDJzBlMM2QwjXHUqfAdmSk+GkG5hfTf1uz+CKiP9s+7ea+nyptf
        KlcoqNE4k3Gz4KzyWqkb+c6FdN4LwJ8fvvZGBPHtR8KC18CAgKv7Lv2Ss0fsNrRl8g2uqp
        fWTidCkfSvmlTs7X4qtFpr0neFBmOBeD7OxcwuRNTHmqCAKlDAOQsBGfcG+xsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5pWWf+3dsIOu8CSx9lrBiUn5W4Lnb/neXb0oKsFWAng=;
        b=mXVWt+g0c4VBjB/u0w4b3A3RLZF6B4a/nJMA7nZFbvZqL+JWuzaCup+FxH/gKj/eVp1xgp
        tOqV/Z89R8f2nXBQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Introduce affinity_context
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220922180041.1768141-5-longman@redhat.com>
References: <20220922180041.1768141-5-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <166693933335.29415.16559251303195144552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     713a2e21a5137e96d2594f53d19784ffde3ddbd0
Gitweb:        https://git.kernel.org/tip/713a2e21a5137e96d2594f53d19784ffde3ddbd0
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 22 Sep 2022 14:00:40 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:21 +02:00

sched: Introduce affinity_context

In order to prepare for passing through additional data through the
affinity call-chains, convert the mask and flags argument into a
structure.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220922180041.1768141-5-longman@redhat.com
---
 kernel/sched/core.c     | 114 +++++++++++++++++++++++++--------------
 kernel/sched/deadline.c |   7 +--
 kernel/sched/sched.h    |  11 ++--
 3 files changed, 85 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f6f2807..5ad4e2e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2189,14 +2189,18 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 #ifdef CONFIG_SMP
 
 static void
-__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
+__do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx);
 
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask,
-				  u32 flags);
+				  struct affinity_context *ctx);
 
 static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 {
+	struct affinity_context ac = {
+		.new_mask  = cpumask_of(rq->cpu),
+		.flags     = SCA_MIGRATE_DISABLE,
+	};
+
 	if (likely(!p->migration_disabled))
 		return;
 
@@ -2206,7 +2210,7 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 	/*
 	 * Violates locking rules! see comment in __do_set_cpus_allowed().
 	 */
-	__do_set_cpus_allowed(p, cpumask_of(rq->cpu), SCA_MIGRATE_DISABLE);
+	__do_set_cpus_allowed(p, &ac);
 }
 
 void migrate_disable(void)
@@ -2228,6 +2232,10 @@ EXPORT_SYMBOL_GPL(migrate_disable);
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
+	struct affinity_context ac = {
+		.new_mask  = &p->cpus_mask,
+		.flags     = SCA_MIGRATE_ENABLE,
+	};
 
 	if (p->migration_disabled > 1) {
 		p->migration_disabled--;
@@ -2243,7 +2251,7 @@ void migrate_enable(void)
 	 */
 	preempt_disable();
 	if (p->cpus_ptr != &p->cpus_mask)
-		__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+		__set_cpus_allowed_ptr(p, &ac);
 	/*
 	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
 	 * regular cpus_mask, otherwise things that race (eg.
@@ -2523,19 +2531,19 @@ out_unlock:
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
  */
-void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
+void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx)
 {
-	if (flags & (SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) {
-		p->cpus_ptr = new_mask;
+	if (ctx->flags & (SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) {
+		p->cpus_ptr = ctx->new_mask;
 		return;
 	}
 
-	cpumask_copy(&p->cpus_mask, new_mask);
-	p->nr_cpus_allowed = cpumask_weight(new_mask);
+	cpumask_copy(&p->cpus_mask, ctx->new_mask);
+	p->nr_cpus_allowed = cpumask_weight(ctx->new_mask);
 }
 
 static void
-__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
+__do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
@@ -2552,7 +2560,7 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 	 *
 	 * XXX do further audits, this smells like something putrid.
 	 */
-	if (flags & SCA_MIGRATE_DISABLE)
+	if (ctx->flags & SCA_MIGRATE_DISABLE)
 		SCHED_WARN_ON(!p->on_cpu);
 	else
 		lockdep_assert_held(&p->pi_lock);
@@ -2571,7 +2579,7 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 	if (running)
 		put_prev_task(rq, p);
 
-	p->sched_class->set_cpus_allowed(p, new_mask, flags);
+	p->sched_class->set_cpus_allowed(p, ctx);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -2581,7 +2589,12 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
-	__do_set_cpus_allowed(p, new_mask, 0);
+	struct affinity_context ac = {
+		.new_mask  = new_mask,
+		.flags     = 0,
+	};
+
+	__do_set_cpus_allowed(p, &ac);
 }
 
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
@@ -2834,8 +2847,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
  * Called with both p->pi_lock and rq->lock held; drops both before returning.
  */
 static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
-					 const struct cpumask *new_mask,
-					 u32 flags,
+					 struct affinity_context *ctx,
 					 struct rq *rq,
 					 struct rq_flags *rf)
 	__releases(rq->lock)
@@ -2864,7 +2876,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 		cpu_valid_mask = cpu_online_mask;
 	}
 
-	if (!kthread && !cpumask_subset(new_mask, cpu_allowed_mask)) {
+	if (!kthread && !cpumask_subset(ctx->new_mask, cpu_allowed_mask)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2873,18 +2885,18 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	 * Must re-check here, to close a race against __kthread_bind(),
 	 * sched_setaffinity() is not guaranteed to observe the flag.
 	 */
-	if ((flags & SCA_CHECK) && (p->flags & PF_NO_SETAFFINITY)) {
+	if ((ctx->flags & SCA_CHECK) && (p->flags & PF_NO_SETAFFINITY)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (!(flags & SCA_MIGRATE_ENABLE)) {
-		if (cpumask_equal(&p->cpus_mask, new_mask))
+	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
+		if (cpumask_equal(&p->cpus_mask, ctx->new_mask))
 			goto out;
 
 		if (WARN_ON_ONCE(p == current &&
 				 is_migration_disabled(p) &&
-				 !cpumask_test_cpu(task_cpu(p), new_mask))) {
+				 !cpumask_test_cpu(task_cpu(p), ctx->new_mask))) {
 			ret = -EBUSY;
 			goto out;
 		}
@@ -2895,18 +2907,18 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	 * for groups of tasks (ie. cpuset), so that load balancing is not
 	 * immediately required to distribute the tasks within their new mask.
 	 */
-	dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, new_mask);
+	dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);
 	if (dest_cpu >= nr_cpu_ids) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	__do_set_cpus_allowed(p, new_mask, flags);
+	__do_set_cpus_allowed(p, ctx);
 
-	if (flags & SCA_USER)
+	if (ctx->flags & SCA_USER)
 		user_mask = clear_user_cpus_ptr(p);
 
-	ret = affine_move_task(rq, p, rf, dest_cpu, flags);
+	ret = affine_move_task(rq, p, rf, dest_cpu, ctx->flags);
 
 	kfree(user_mask);
 
@@ -2928,18 +2940,23 @@ out:
  * call is not atomic; no spinlocks may be held.
  */
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, u32 flags)
+				  struct affinity_context *ctx)
 {
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(p, &rf);
-	return __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf);
+	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);
 }
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	return __set_cpus_allowed_ptr(p, new_mask, 0);
+	struct affinity_context ac = {
+		.new_mask  = new_mask,
+		.flags     = 0,
+	};
+
+	return __set_cpus_allowed_ptr(p, &ac);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
@@ -2955,6 +2972,7 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 				     const struct cpumask *subset_mask)
 {
 	struct cpumask *user_mask = NULL;
+	struct affinity_context ac;
 	struct rq_flags rf;
 	struct rq *rq;
 	int err;
@@ -2991,7 +3009,11 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 		p->user_cpus_ptr = user_mask;
 	}
 
-	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
+	ac = (struct affinity_context){
+		.new_mask = new_mask,
+	};
+
+	return __set_cpus_allowed_ptr_locked(p, &ac, rq, &rf);
 
 err_unlock:
 	task_rq_unlock(rq, p, &rf);
@@ -3045,7 +3067,7 @@ out_free_mask:
 }
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
+__sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
 
 /*
  * Restore the affinity of a task @p which was previously restricted by a
@@ -3058,6 +3080,9 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
 void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 {
 	struct cpumask *user_mask = p->user_cpus_ptr;
+	struct affinity_context ac = {
+		.new_mask  = user_mask,
+	};
 	unsigned long flags;
 
 	/*
@@ -3065,7 +3090,7 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 	 * we free the mask explicitly to avoid it being inherited across
 	 * a subsequent fork().
 	 */
-	if (!user_mask || !__sched_setaffinity(p, user_mask))
+	if (!user_mask || !__sched_setaffinity(p, &ac))
 		return;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
@@ -3550,10 +3575,9 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 #else /* CONFIG_SMP */
 
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
-					 const struct cpumask *new_mask,
-					 u32 flags)
+					 struct affinity_context *ctx)
 {
-	return set_cpus_allowed_ptr(p, new_mask);
+	return set_cpus_allowed_ptr(p, ctx->new_mask);
 }
 
 static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
@@ -8090,7 +8114,7 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 #endif
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
+__sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 {
 	int retval;
 	cpumask_var_t cpus_allowed, new_mask;
@@ -8104,13 +8128,16 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	}
 
 	cpuset_cpus_allowed(p, cpus_allowed);
-	cpumask_and(new_mask, mask, cpus_allowed);
+	cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
+
+	ctx->new_mask = new_mask;
+	ctx->flags |= SCA_CHECK;
 
 	retval = dl_task_check_affinity(p, new_mask);
 	if (retval)
 		goto out_free_new_mask;
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
+	retval = __set_cpus_allowed_ptr(p, ctx);
 	if (retval)
 		goto out_free_new_mask;
 
@@ -8133,6 +8160,9 @@ out_free_cpus_allowed:
 
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
+	struct affinity_context ac = {
+		.new_mask = in_mask,
+	};
 	struct task_struct *p;
 	int retval;
 
@@ -8167,7 +8197,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
-	retval = __sched_setaffinity(p, in_mask);
+	retval = __sched_setaffinity(p, &ac);
 out_put_task:
 	put_task_struct(p);
 	return retval;
@@ -8948,6 +8978,12 @@ void show_state_filter(unsigned int state_filter)
  */
 void __init init_idle(struct task_struct *idle, int cpu)
 {
+#ifdef CONFIG_SMP
+	struct affinity_context ac = (struct affinity_context) {
+		.new_mask  = cpumask_of(cpu),
+		.flags     = 0,
+	};
+#endif
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
@@ -8972,7 +9008,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	 *
 	 * And since this is boot we can forgo the serialization.
 	 */
-	set_cpus_allowed_common(idle, cpumask_of(cpu), 0);
+	set_cpus_allowed_common(idle, &ac);
 #endif
 	/*
 	 * We're having a chicken and egg problem, even though we are
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9ae8f41..0d97d54 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2485,8 +2485,7 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 }
 
 static void set_cpus_allowed_dl(struct task_struct *p,
-				const struct cpumask *new_mask,
-				u32 flags)
+				struct affinity_context *ctx)
 {
 	struct root_domain *src_rd;
 	struct rq *rq;
@@ -2501,7 +2500,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 	 * update. We already made space for us in the destination
 	 * domain (see cpuset_can_attach()).
 	 */
-	if (!cpumask_intersects(src_rd->span, new_mask)) {
+	if (!cpumask_intersects(src_rd->span, ctx->new_mask)) {
 		struct dl_bw *src_dl_b;
 
 		src_dl_b = dl_bw_of(cpu_of(rq));
@@ -2515,7 +2514,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 		raw_spin_unlock(&src_dl_b->lock);
 	}
 
-	set_cpus_allowed_common(p, new_mask, flags);
+	set_cpus_allowed_common(p, ctx);
 }
 
 /* Assumes rq->lock is held */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5f18460..6c91fb7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2145,6 +2145,11 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define RETRY_TASK		((void *)-1UL)
 
+struct affinity_context {
+	const struct cpumask *new_mask;
+	unsigned int flags;
+};
+
 struct sched_class {
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -2173,9 +2178,7 @@ struct sched_class {
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
-	void (*set_cpus_allowed)(struct task_struct *p,
-				 const struct cpumask *newmask,
-				 u32 flags);
+	void (*set_cpus_allowed)(struct task_struct *p, struct affinity_context *ctx);
 
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
@@ -2286,7 +2289,7 @@ extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void trigger_load_balance(struct rq *rq);
 
-extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
+extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
 
 static inline struct task_struct *get_push_task(struct rq *rq)
 {
