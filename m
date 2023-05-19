Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17B3708CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjESATl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjESAS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:57 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349591990
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53487355877so280508a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455494; x=1687047494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iauq3KRhjOAlqtECxTVPCDR0MkRcmzW4Ov/fyN5+fRg=;
        b=Bs9A31cw8E/KLB4jBCM/Q0aWEdwAMYoCLPS6LG3c0FyNgHV7o/kzW1zw+ShrvFxCZ1
         MZbOtxtPmVMBvSvCrrh9rEXxhFVOVVPXq+7kFKCNWnYfqflvwHpFN1OG9kOTi7giME38
         7MDnTEkafyUKNbSPIFfO4h8QqfqKvY/F+6d2ddVLTbevK90lrWD7E5dCQcI2ZFTMle5h
         ZaZmsgVE0YzdS/3so6Qkim+q6yHF6po2h9xDHu68dJiQbFjV0cSuRBKrbgguOwFWRtjY
         vQdRWYDgDKQDAfUHDv34jtoAH8Vgd8ZQRaSG4VGlbkqT/lVHfy6ENZDr7+Y6BSrO/33K
         oYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455494; x=1687047494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iauq3KRhjOAlqtECxTVPCDR0MkRcmzW4Ov/fyN5+fRg=;
        b=RFyw4JCzThDk4nIxxHx6DUYDAhKgOzBhkPfJQgzXHMj/DuDbml6vdV7XxL5BE/TeOU
         IVOVYxLMOLTsTCL0rG8pGvq/cOybfIaRGkFAeyYUBenJY1A4uY1MoRvd+0rqACjHkp+P
         EGp2VkP/24STepQgsnvQFJZIJ8R7CAWWA/VM2fyfnPjxPDPV86ZPQoBDeFw3E/Nm47Tg
         7XKIzGJbCMWSFqmmKP/ToECQE/23D4xZkyezIH6GMUfimBcKCTqqWojOABkYhyOOTegJ
         Fh1+xEMeSwOKvOdz6yu1g9JdjKh+3lFPf0TzG//FhtfKrnxkG4mHtwvKSvjQxNP6Q6IJ
         zU8g==
X-Gm-Message-State: AC+VfDwQ80D9SWLyxhpgarxq4KQFMI9CDvVcFmSYgAfALj3v/zBXgmjf
        +t0GgVI+txRs0KSUUncn6u0=
X-Google-Smtp-Source: ACHHUZ6sIhkHpo1U4LVuvJSvB6lsIi5CRlhimOBt8InNrQJbZ321WHjwKOu6UFdIkwc2o/7xWDNGDA==
X-Received: by 2002:a17:903:25c1:b0:19f:8ad5:4331 with SMTP id jc1-20020a17090325c100b0019f8ad54331mr765232plb.38.1684455493702;
        Thu, 18 May 2023 17:18:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902b59200b001ab0672fc1fsm2052529pls.105.2023.05.18.17.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 20/24] workqueue: Add workqueue_attrs->__pod_cpumask
Date:   Thu, 18 May 2023 14:17:05 -1000
Message-Id: <20230519001709.2563-21-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
References: <20230519001709.2563-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

workqueue_attrs has two uses:

* to specify the required unouned workqueue properties by users

* to match worker_pool's properties to workqueues by core code

For example, if the user wants to restrict a workqueue to run only CPUs 0
and 2, and the two CPUs are on different affinity scopes, the workqueue's
attrs->cpumask would contains CPUs 0 and 2, and the workqueue would be
associated with two worker_pools, one with attrs->cpumask containing just
CPU 0 and the other CPU 2.

Workqueue wants to support non-strict affinity scopes where work items are
started in their matching affinity scopes but the scheduler is free to
migrate them outside the starting scopes, which can enable utilizing the
whole machine while maintaining most of the locality benefits from affinity
scopes.

To enable that, worker_pools need to distinguish the strict affinity that it
has to follow (because that's the restriction coming from the user) and the
soft affinity that it wants to apply when dispatching work items. Note that
two worker_pools with different soft dispatching requirements have to be
separate; otherwise, for example, we'd be ping-ponging worker threads across
NUMA boundaries constantly.

This patch adds workqueue_attrs->__pod_cpumask. The new field is double
underscored as it's only used internally to distinguish worker_pools. A
worker_pool's ->cpumask is now always the same as the online subset of
allowed CPUs of the associated workqueues, and ->__pod_cpumask is the pod's
subset of that ->cpumask. Going back to the example above, both worker_pools
would have ->cpumask containing both CPUs 0 and 2 but one's ->__pod_cpumask
would contain 0 while the other's 2.

* pool_allowed_cpus() is added. It returns the worker_pool's strict cpumask
  that the pool's workers must stay within. This is currently always
  ->__pod_cpumask as all boundaries are still strict.

* As a workqueue_attrs can now track both the associated workqueues' cpumask
  and its per-pod subset, wq_calc_pod_cpumask() no longer needs an external
  out-argument. Drop @cpumask and instead store the result in
  ->__pod_cpumask.

* The above also simplifies apply_wqattrs_prepare() as the same
  workqueue_attrs can be used to create all pods associated with a
  workqueue. tmp_attrs is dropped.

The only user-visible behavior change is that two workqueues with different
cpumasks no longer can share worker_pools even when their pod subsets
coincide. Going back to the example, let's say there's another workqueue
with cpumask 0, 2, 3, where 2 and 3 are in the same pod. It would be mapped
to two worker_pools - one with CPU 0, the other with 2 and 3. The former has
the same cpumask as the first pod of the earlier example and would have
shared the same worker_pool but that's no longer the case after this patch.
The worker_pools would have the same ->__pod_cpumask but their ->cpumask's
wouldn't match.

While this is necessary to support non-strict affinity scopes, there can be
further optimizations to maintain sharing among strict affinity scopes.
However, non-strict affinity scopes are going to be preferable for most use
cases and we don't see very diverse mixture of unbound workqueue cpumasks
anyway, so the additional overhead doesn't seem to justify the extra
complexity.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h | 16 +++++++++
 kernel/workqueue.c        | 74 ++++++++++++++++++++-------------------
 2 files changed, 54 insertions(+), 36 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a01b5dcbbeb9..7a0fc0919e0a 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -149,9 +149,25 @@ struct workqueue_attrs {
 
 	/**
 	 * @cpumask: allowed CPUs
+	 *
+	 * Work items in this workqueue are affine to these CPUs and not allowed
+	 * to execute on other CPUs. A pool serving a workqueue must have the
+	 * same @cpumask.
 	 */
 	cpumask_var_t cpumask;
 
+	/**
+	 * @__pod_cpumask: internal attribute used to create per-pod pools
+	 *
+	 * Internal use only.
+	 *
+	 * Per-pod unbound worker pools are used to improve locality. Always a
+	 * subset of ->cpumask. A workqueue can be associated with multiple
+	 * worker pools with disjoint @__pod_cpumask's. Whether the enforcement
+	 * of a pool's @__pod_cpumask is strict depends on @affn_strict.
+	 */
+	cpumask_var_t __pod_cpumask;
+
 	/*
 	 * Below fields aren't properties of a worker_pool. They only modify how
 	 * :c:func:`apply_workqueue_attrs` select pools and thus don't
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 58aec5cc5722..daebc28d09ab 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2029,6 +2029,11 @@ static struct worker *alloc_worker(int node)
 	return worker;
 }
 
+static cpumask_t *pool_allowed_cpus(struct worker_pool *pool)
+{
+	return pool->attrs->__pod_cpumask;
+}
+
 /**
  * worker_attach_to_pool() - attach a worker to a pool
  * @worker: worker to be attached
@@ -2054,7 +2059,7 @@ static void worker_attach_to_pool(struct worker *worker,
 		kthread_set_per_cpu(worker->task, pool->cpu);
 
 	if (worker->rescue_wq)
-		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+		set_cpus_allowed_ptr(worker->task, pool_allowed_cpus(pool));
 
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
@@ -2146,7 +2151,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 	}
 
 	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool->attrs->cpumask);
+	kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
 
 	/* successful, attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
@@ -3652,6 +3657,7 @@ void free_workqueue_attrs(struct workqueue_attrs *attrs)
 {
 	if (attrs) {
 		free_cpumask_var(attrs->cpumask);
+		free_cpumask_var(attrs->__pod_cpumask);
 		kfree(attrs);
 	}
 }
@@ -3673,6 +3679,8 @@ struct workqueue_attrs *alloc_workqueue_attrs(void)
 		goto fail;
 	if (!alloc_cpumask_var(&attrs->cpumask, GFP_KERNEL))
 		goto fail;
+	if (!alloc_cpumask_var(&attrs->__pod_cpumask, GFP_KERNEL))
+		goto fail;
 
 	cpumask_copy(attrs->cpumask, cpu_possible_mask);
 	attrs->affn_scope = wq_affn_dfl;
@@ -3687,6 +3695,7 @@ static void copy_workqueue_attrs(struct workqueue_attrs *to,
 {
 	to->nice = from->nice;
 	cpumask_copy(to->cpumask, from->cpumask);
+	cpumask_copy(to->__pod_cpumask, from->__pod_cpumask);
 
 	/*
 	 * Unlike hash and equality test, copying shouldn't ignore wq-only
@@ -3705,6 +3714,8 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
 	hash = jhash_1word(attrs->nice, hash);
 	hash = jhash(cpumask_bits(attrs->cpumask),
 		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
+	hash = jhash(cpumask_bits(attrs->__pod_cpumask),
+		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
 	return hash;
 }
 
@@ -3716,6 +3727,8 @@ static bool wqattrs_equal(const struct workqueue_attrs *a,
 		return false;
 	if (!cpumask_equal(a->cpumask, b->cpumask))
 		return false;
+	if (!cpumask_equal(a->__pod_cpumask, b->__pod_cpumask))
+		return false;
 	return true;
 }
 
@@ -3952,9 +3965,9 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 		}
 	}
 
-	/* If cpumask is contained inside a NUMA pod, that's our NUMA node */
+	/* If __pod_cpumask is contained inside a NUMA pod, that's our node */
 	for (pod = 0; pod < pt->nr_pods; pod++) {
-		if (cpumask_subset(attrs->cpumask, pt->pod_cpus[pod])) {
+		if (cpumask_subset(attrs->__pod_cpumask, pt->pod_cpus[pod])) {
 			node = pt->pod_node[pod];
 			break;
 		}
@@ -4147,11 +4160,10 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
  * @attrs: the wq_attrs of the default pwq of the target workqueue
  * @cpu: the target CPU
  * @cpu_going_down: if >= 0, the CPU to consider as offline
- * @cpumask: outarg, the resulting cpumask
  *
  * Calculate the cpumask a workqueue with @attrs should use on @pod. If
  * @cpu_going_down is >= 0, that cpu is considered offline during calculation.
- * The result is stored in @cpumask.
+ * The result is stored in @attrs->__pod_cpumask.
  *
  * If pod affinity is not enabled, @attrs->cpumask is always used. If enabled
  * and @pod has online CPUs requested by @attrs, the returned cpumask is the
@@ -4159,27 +4171,27 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
  *
  * The caller is responsible for ensuring that the cpumask of @pod stays stable.
  */
-static void wq_calc_pod_cpumask(const struct workqueue_attrs *attrs, int cpu,
-				int cpu_going_down, cpumask_t *cpumask)
+static void wq_calc_pod_cpumask(struct workqueue_attrs *attrs, int cpu,
+				int cpu_going_down)
 {
 	const struct wq_pod_type *pt = wqattrs_pod_type(attrs);
 	int pod = pt->cpu_pod[cpu];
 
 	/* does @pod have any online CPUs @attrs wants? */
-	cpumask_and(cpumask, pt->pod_cpus[pod], attrs->cpumask);
-	cpumask_and(cpumask, cpumask, cpu_online_mask);
+	cpumask_and(attrs->__pod_cpumask, pt->pod_cpus[pod], attrs->cpumask);
+	cpumask_and(attrs->__pod_cpumask, attrs->__pod_cpumask, cpu_online_mask);
 	if (cpu_going_down >= 0)
-		cpumask_clear_cpu(cpu_going_down, cpumask);
+		cpumask_clear_cpu(cpu_going_down, attrs->__pod_cpumask);
 
-	if (cpumask_empty(cpumask)) {
-		cpumask_copy(cpumask, attrs->cpumask);
+	if (cpumask_empty(attrs->__pod_cpumask)) {
+		cpumask_copy(attrs->__pod_cpumask, attrs->cpumask);
 		return;
 	}
 
 	/* yeap, return possible CPUs in @pod that @attrs wants */
-	cpumask_and(cpumask, attrs->cpumask, pt->pod_cpus[pod]);
+	cpumask_and(attrs->__pod_cpumask, attrs->cpumask, pt->pod_cpus[pod]);
 
-	if (cpumask_empty(cpumask))
+	if (cpumask_empty(attrs->__pod_cpumask))
 		pr_warn_once("WARNING: workqueue cpumask: online intersect > "
 				"possible intersect\n");
 }
@@ -4233,7 +4245,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		      const cpumask_var_t unbound_cpumask)
 {
 	struct apply_wqattrs_ctx *ctx;
-	struct workqueue_attrs *new_attrs, *tmp_attrs;
+	struct workqueue_attrs *new_attrs;
 	int cpu;
 
 	lockdep_assert_held(&wq_pool_mutex);
@@ -4245,8 +4257,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	ctx = kzalloc(struct_size(ctx, pwq_tbl, nr_cpu_ids), GFP_KERNEL);
 
 	new_attrs = alloc_workqueue_attrs();
-	tmp_attrs = alloc_workqueue_attrs();
-	if (!ctx || !new_attrs || !tmp_attrs)
+	if (!ctx || !new_attrs)
 		goto out_free;
 
 	/*
@@ -4259,13 +4270,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, unbound_cpumask);
 	if (unlikely(cpumask_empty(new_attrs->cpumask)))
 		cpumask_copy(new_attrs->cpumask, unbound_cpumask);
-
-	/*
-	 * We may create multiple pwqs with differing cpumasks.  Make a
-	 * copy of @new_attrs which will be modified and used to obtain
-	 * pools.
-	 */
-	copy_workqueue_attrs(tmp_attrs, new_attrs);
+	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
 
 	/*
 	 * If something goes wrong during CPU up/down, we'll fall back to
@@ -4281,8 +4286,8 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 			ctx->dfl_pwq->refcnt++;
 			ctx->pwq_tbl[cpu] = ctx->dfl_pwq;
 		} else {
-			wq_calc_pod_cpumask(new_attrs, cpu, -1, tmp_attrs->cpumask);
-			ctx->pwq_tbl[cpu] = alloc_unbound_pwq(wq, tmp_attrs);
+			wq_calc_pod_cpumask(new_attrs, cpu, -1);
+			ctx->pwq_tbl[cpu] = alloc_unbound_pwq(wq, new_attrs);
 			if (!ctx->pwq_tbl[cpu])
 				goto out_free;
 		}
@@ -4291,14 +4296,13 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	/* save the user configured attrs and sanitize it. */
 	copy_workqueue_attrs(new_attrs, attrs);
 	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);
+	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
 	ctx->attrs = new_attrs;
 
 	ctx->wq = wq;
-	free_workqueue_attrs(tmp_attrs);
 	return ctx;
 
 out_free:
-	free_workqueue_attrs(tmp_attrs);
 	free_workqueue_attrs(new_attrs);
 	apply_wqattrs_cleanup(ctx);
 	return ERR_PTR(-ENOMEM);
@@ -4423,7 +4427,6 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu, bool online)
 	int cpu_off = online ? -1 : cpu;
 	struct pool_workqueue *old_pwq = NULL, *pwq;
 	struct workqueue_attrs *target_attrs;
-	cpumask_t *cpumask;
 
 	lockdep_assert_held(&wq_pool_mutex);
 
@@ -4436,15 +4439,14 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu, bool online)
 	 * CPU hotplug exclusion.
 	 */
 	target_attrs = wq_update_pod_attrs_buf;
-	cpumask = target_attrs->cpumask;
-
-	copy_workqueue_attrs(target_attrs, wq->unbound_attrs);
+	copy_workqueue_attrs(target_attrs, wq->dfl_pwq->pool->attrs);
 
 	/* nothing to do if the target cpumask matches the current pwq */
-	wq_calc_pod_cpumask(wq->dfl_pwq->pool->attrs, cpu, cpu_off, cpumask);
+	wq_calc_pod_cpumask(target_attrs, cpu, cpu_off);
 	pwq = rcu_dereference_protected(*per_cpu_ptr(wq->cpu_pwq, cpu),
 					lockdep_is_held(&wq_pool_mutex));
-	if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
+	if (cpumask_equal(target_attrs->__pod_cpumask,
+			  pwq->pool->attrs->cpumask))
 		return;
 
 	/* create a new pwq */
@@ -5371,7 +5373,7 @@ static void rebind_workers(struct worker_pool *pool)
 	for_each_pool_worker(worker, pool) {
 		kthread_set_per_cpu(worker->task, pool->cpu);
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
-						  pool->attrs->cpumask) < 0);
+						  pool_allowed_cpus(pool)) < 0);
 	}
 
 	raw_spin_lock_irq(&pool->lock);
-- 
2.40.1

