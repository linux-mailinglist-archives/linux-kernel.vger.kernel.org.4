Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B79C610A87
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJ1Gna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJ1GmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094D1B90FE;
        Thu, 27 Oct 2022 23:42:14 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NI869xZZZx+04L6xNH8Z9K499//st8CftZ97RWKRzx0=;
        b=funjMDQpp5JXozZN+oJbjqOA4T11lK59jpO9G9JI0LvBmbu9x0kV+kuS1T6L2nm4ek0RZd
        E/oyydMoRHz6h2q8cE+9r1C0mMX3nvxbWt+JAXh7OGKD7riMz6pO+1dp+i25etR3zau7bq
        Uj8rkdQHniE9cLFYkS0YOOvdCAkCZ7qRx8xcTs04diqzk8pzREkhL0xJa7GfLmdzDKvGpp
        Y5HcVEngxQ4Yr3RF8FG4lQ4DTLA+/amY1mphyle2qiKkebMzgLEgO3ZYf0pYGNWwkUVfLv
        OPCUsFiRpsSkpeXmAvDSK6e0DbO5bq/8LWP/X+GGBLGzSMl/wY5E+weTznjsPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NI869xZZZx+04L6xNH8Z9K499//st8CftZ97RWKRzx0=;
        b=V77WgCTtcsVFe5Q5sAebQMieazCa10Eu1+UEzR9EbTjne4swVzBCczK1A5dIbBbPKwIwwE
        J0ECxUrTwVGWRqAA==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Always preserve the user requested cpumask
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220922180041.1768141-3-longman@redhat.com>
References: <20220922180041.1768141-3-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <166693933223.29415.17857148078176712895.tip-bot2@tip-bot2>
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

Commit-ID:     8f9ea86fdf99b81458cc21fc1c591fcd4a0fa1f4
Gitweb:        https://git.kernel.org/tip/8f9ea86fdf99b81458cc21fc1c591fcd4a0fa1f4
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 22 Sep 2022 14:00:38 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:22 +02:00

sched: Always preserve the user requested cpumask

Unconditionally preserve the user requested cpumask on
sched_setaffinity() calls. This allows using it outside of the fairly
narrow restrict_cpus_allowed_ptr() use-case and fix some cpuset issues
that currently suffer destruction of cpumasks.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220922180041.1768141-3-longman@redhat.com
---
 kernel/sched/core.c  | 119 ++++++++++++++++++++++--------------------
 kernel/sched/sched.h |   8 +++-
 2 files changed, 72 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ad4e2e..67fb0e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2540,6 +2540,12 @@ void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx
 
 	cpumask_copy(&p->cpus_mask, ctx->new_mask);
 	p->nr_cpus_allowed = cpumask_weight(ctx->new_mask);
+
+	/*
+	 * Swap in a new user_cpus_ptr if SCA_USER flag set
+	 */
+	if (ctx->flags & SCA_USER)
+		swap(p->user_cpus_ptr, ctx->user_mask);
 }
 
 static void
@@ -2600,6 +2606,8 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 		      int node)
 {
+	unsigned long flags;
+
 	if (!src->user_cpus_ptr)
 		return 0;
 
@@ -2607,7 +2615,10 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 	if (!dst->user_cpus_ptr)
 		return -ENOMEM;
 
+	/* Use pi_lock to protect content of user_cpus_ptr */
+	raw_spin_lock_irqsave(&src->pi_lock, flags);
 	cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
+	raw_spin_unlock_irqrestore(&src->pi_lock, flags);
 	return 0;
 }
 
@@ -2856,7 +2867,6 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	bool kthread = p->flags & PF_KTHREAD;
-	struct cpumask *user_mask = NULL;
 	unsigned int dest_cpu;
 	int ret = 0;
 
@@ -2915,14 +2925,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 
 	__do_set_cpus_allowed(p, ctx);
 
-	if (ctx->flags & SCA_USER)
-		user_mask = clear_user_cpus_ptr(p);
-
-	ret = affine_move_task(rq, p, rf, dest_cpu, ctx->flags);
-
-	kfree(user_mask);
-
-	return ret;
+	return affine_move_task(rq, p, rf, dest_cpu, ctx->flags);
 
 out:
 	task_rq_unlock(rq, p, rf);
@@ -2962,8 +2965,10 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
 /*
  * Change a given task's CPU affinity to the intersection of its current
- * affinity mask and @subset_mask, writing the resulting mask to @new_mask
- * and pointing @p->user_cpus_ptr to a copy of the old mask.
+ * affinity mask and @subset_mask, writing the resulting mask to @new_mask.
+ * If user_cpus_ptr is defined, use it as the basis for restricting CPU
+ * affinity or use cpu_online_mask instead.
+ *
  * If the resulting mask is empty, leave the affinity unchanged and return
  * -EINVAL.
  */
@@ -2971,18 +2976,14 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 				     struct cpumask *new_mask,
 				     const struct cpumask *subset_mask)
 {
-	struct cpumask *user_mask = NULL;
-	struct affinity_context ac;
+	struct affinity_context ac = {
+		.new_mask  = new_mask,
+		.flags     = 0,
+	};
 	struct rq_flags rf;
 	struct rq *rq;
 	int err;
 
-	if (!p->user_cpus_ptr) {
-		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
-		if (!user_mask)
-			return -ENOMEM;
-	}
-
 	rq = task_rq_lock(p, &rf);
 
 	/*
@@ -2995,29 +2996,15 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 		goto err_unlock;
 	}
 
-	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
+	if (!cpumask_and(new_mask, task_user_cpus(p), subset_mask)) {
 		err = -EINVAL;
 		goto err_unlock;
 	}
 
-	/*
-	 * We're about to butcher the task affinity, so keep track of what
-	 * the user asked for in case we're able to restore it later on.
-	 */
-	if (user_mask) {
-		cpumask_copy(user_mask, p->cpus_ptr);
-		p->user_cpus_ptr = user_mask;
-	}
-
-	ac = (struct affinity_context){
-		.new_mask = new_mask,
-	};
-
 	return __set_cpus_allowed_ptr_locked(p, &ac, rq, &rf);
 
 err_unlock:
 	task_rq_unlock(rq, p, &rf);
-	kfree(user_mask);
 	return err;
 }
 
@@ -3071,33 +3058,25 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
 
 /*
  * Restore the affinity of a task @p which was previously restricted by a
- * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
- * @p->user_cpus_ptr.
+ * call to force_compatible_cpus_allowed_ptr().
  *
  * It is the caller's responsibility to serialise this with any calls to
  * force_compatible_cpus_allowed_ptr(@p).
  */
 void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 {
-	struct cpumask *user_mask = p->user_cpus_ptr;
 	struct affinity_context ac = {
-		.new_mask  = user_mask,
+		.new_mask  = task_user_cpus(p),
+		.flags     = 0,
 	};
-	unsigned long flags;
+	int ret;
 
 	/*
-	 * Try to restore the old affinity mask. If this fails, then
-	 * we free the mask explicitly to avoid it being inherited across
-	 * a subsequent fork().
+	 * Try to restore the old affinity mask with __sched_setaffinity().
+	 * Cpuset masking will be done there too.
 	 */
-	if (!user_mask || !__sched_setaffinity(p, &ac))
-		return;
-
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	user_mask = clear_user_cpus_ptr(p);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-
-	kfree(user_mask);
+	ret = __sched_setaffinity(p, &ac);
+	WARN_ON_ONCE(ret);
 }
 
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
@@ -8136,7 +8115,7 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 	retval = dl_task_check_affinity(p, new_mask);
 	if (retval)
 		goto out_free_new_mask;
-again:
+
 	retval = __set_cpus_allowed_ptr(p, ctx);
 	if (retval)
 		goto out_free_new_mask;
@@ -8148,7 +8127,24 @@ again:
 		 * Just reset the cpumask to the cpuset's cpus_allowed.
 		 */
 		cpumask_copy(new_mask, cpus_allowed);
-		goto again;
+
+		/*
+		 * If SCA_USER is set, a 2nd call to __set_cpus_allowed_ptr()
+		 * will restore the previous user_cpus_ptr value.
+		 *
+		 * In the unlikely event a previous user_cpus_ptr exists,
+		 * we need to further restrict the mask to what is allowed
+		 * by that old user_cpus_ptr.
+		 */
+		if (unlikely((ctx->flags & SCA_USER) && ctx->user_mask)) {
+			bool empty = !cpumask_and(new_mask, new_mask,
+						  ctx->user_mask);
+
+			if (WARN_ON_ONCE(empty))
+				cpumask_copy(new_mask, cpus_allowed);
+		}
+		__set_cpus_allowed_ptr(p, ctx);
+		retval = -EINVAL;
 	}
 
 out_free_new_mask:
@@ -8160,9 +8156,8 @@ out_free_cpus_allowed:
 
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
-	struct affinity_context ac = {
-		.new_mask = in_mask,
-	};
+	struct affinity_context ac;
+	struct cpumask *user_mask;
 	struct task_struct *p;
 	int retval;
 
@@ -8197,7 +8192,21 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
+	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+	if (!user_mask) {
+		retval = -ENOMEM;
+		goto out_put_task;
+	}
+	cpumask_copy(user_mask, in_mask);
+	ac = (struct affinity_context){
+		.new_mask  = in_mask,
+		.user_mask = user_mask,
+		.flags     = SCA_USER,
+	};
+
 	retval = __sched_setaffinity(p, &ac);
+	kfree(ac.user_mask);
+
 out_put_task:
 	put_task_struct(p);
 	return retval;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c91fb7..04f571d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1878,6 +1878,13 @@ static inline void dirty_sched_domain_sysctl(int cpu)
 #endif
 
 extern int sched_update_scaling(void);
+
+static inline const struct cpumask *task_user_cpus(struct task_struct *p)
+{
+	if (!p->user_cpus_ptr)
+		return cpu_possible_mask; /* &init_task.cpus_mask */
+	return p->user_cpus_ptr;
+}
 #endif /* CONFIG_SMP */
 
 #include "stats.h"
@@ -2147,6 +2154,7 @@ extern const u32		sched_prio_to_wmult[40];
 
 struct affinity_context {
 	const struct cpumask *new_mask;
+	struct cpumask *user_mask;
 	unsigned int flags;
 };
 
