Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB06D708CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjESATC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjESASf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3029F10C9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaea43def7so19740985ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455482; x=1687047482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJP3Bjk8+Z7BZ+AOr0Hj7XvZwuuUj3oJGBaMB6aUA1E=;
        b=p0Ab3/sP1z2ZSY9dmi2VcwVTegsdxJnwfZYrbbWKjUNqjrbgNIEgqwnf7hYtko6xCT
         nyvK530qsVCfDn0L6qRihkUZFqdT3KuBlBUgrKJdKLlZCQogjQXFUaNBzda116B/KcEi
         hWkL1TKFh64ajEoL4XBnWyK45O8doIJzYUcERunslSmOgCaO73RWmI1fCDIvBVF3DKQ4
         ujsFeLw++RwiJeNO6d0vdJrT3cdK4c+LLr+XzmS2zFLOp6my45k9CyehDD3BQOcxH0CV
         U1wMEX+ZwJ6N1M3AJ/EvEDvcc/u/SNW0tk4pcFXKnadfzYXjh0Ce8/FBOi2jdPMQv+9a
         vk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455482; x=1687047482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJP3Bjk8+Z7BZ+AOr0Hj7XvZwuuUj3oJGBaMB6aUA1E=;
        b=iLsEvuNp7TaxDZ9SE/1lo553p2UyQkZn9/WMOK/7m4Bfh65FIcjqscyHDPR7uLl+MX
         f4F5fPJipgjdTklITylvjXcamIjjmAnW7Iyh+z+30unUxdn7nLAK+qw5ANDnHY0NM+vi
         W4CgbhBKyEBL1PDO0Vfv3Pfxq61SRmQ932yqFi7po16UAHgGKvkhW6scOhpEuHxCq3Q+
         rv0bUGwEyBdRsX8GLrOHIi4qVwDXGLBdLrAfCoZZwip85iNh6X/fkkRebzaA/XNyWcsv
         1dgVe0rwRKvgjUDUMKA/Gw1+gD8MHYB/fJoU6ieFSOEGN/k18ox5XKuNzTcBC6YDlKt2
         3riQ==
X-Gm-Message-State: AC+VfDwO3fljEqYiOqQLxcTXmZ7WGOKPOf2OATwVZQMIivpqFNILwwjh
        5VwOquNbJewo/ik30OpCMYw=
X-Google-Smtp-Source: ACHHUZ42T5Tt7Sw4rTQtgcsEenu9rPPiWdPE8VCdTD02dVkrp/dOp+21fSNd38ocKMeC0eqHE/6AoA==
X-Received: by 2002:a17:902:7287:b0:1a9:8ba4:d0d3 with SMTP id d7-20020a170902728700b001a98ba4d0d3mr910157pll.8.1684455482357;
        Thu, 18 May 2023 17:18:02 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902ee4100b001a2135e7eabsm2078180plo.16.2023.05.18.17.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Date:   Thu, 18 May 2023 14:16:59 -1000
Message-Id: <20230519001709.2563-15-tj@kernel.org>
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

While renamed to pod, the code still assumes that the pods are defined by
NUMA boundaries. Let's generalize it:

* workqueue_attrs->affn_scope is added. Each enum represents the type of
  boundaries that define the pods. There are currently two scopes -
  WQ_AFFN_NUMA and WQ_AFFN_SYSTEM. The former is the same behavior as before
  - one pod per NUMA node. The latter defines one global pod across the
  whole system.

* struct wq_pod_type is added which describes how pods are configured for
  each affnity scope. For each pod, it lists the member CPUs and the
  preferred NUMA node for memory allocations. The reverse mapping from CPU
  to pod is also available.

* wq_pod_enabled is dropped. Pod is now always enabled. The previously
  disabled behavior is now implemented through WQ_AFFN_SYSTEM.

* get_unbound_pool() wants to determine the NUMA node to allocate memory
  from for the new pool. The variables are renamed from node to pod but the
  logic still assumes they're one and the same. Clearly distinguish them -
  walk the WQ_AFFN_NUMA pods to find the matching pod and then use the pod's
  NUMA node.

* wq_calc_pod_cpumask() was taking @pod but assumed that it was the NUMA
  node. Take @cpu instead and determine the cpumask to use from the pod_type
  matching @attrs.

* apply_wqattrs_prepare() is update to return ERR_PTR() on error instead of
  NULL so that it can indicate -EINVAL on invalid affinity scopes.

This patch allows CPUs to be grouped into pods however desired per type.
While this patch causes some internal behavior changes, nothing material
should change for workqueue users.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h |  31 +++++++-
 kernel/workqueue.c        | 154 ++++++++++++++++++++++++--------------
 2 files changed, 125 insertions(+), 60 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index b8961c8ea5b3..a2f826b6ec9a 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -124,6 +124,15 @@ struct rcu_work {
 	struct workqueue_struct *wq;
 };
 
+enum wq_affn_scope {
+	WQ_AFFN_NUMA,			/* one pod per NUMA node */
+	WQ_AFFN_SYSTEM,			/* one pod across the whole system */
+
+	WQ_AFFN_NR_TYPES,
+
+	WQ_AFFN_DFL = WQ_AFFN_NUMA,
+};
+
 /**
  * struct workqueue_attrs - A struct for workqueue attributes.
  *
@@ -140,12 +149,26 @@ struct workqueue_attrs {
 	 */
 	cpumask_var_t cpumask;
 
+	/*
+	 * Below fields aren't properties of a worker_pool. They only modify how
+	 * :c:func:`apply_workqueue_attrs` select pools and thus don't
+	 * participate in pool hash calculations or equality comparisons.
+	 */
+
 	/**
-	 * @ordered: work items must be executed one by one in queueing order
+	 * @affn_scope: unbound CPU affinity scope
 	 *
-	 * Unlike other fields, ``ordered`` isn't a property of a worker_pool. It
-	 * only modifies how :c:func:`apply_workqueue_attrs` select pools and thus
-	 * doesn't participate in pool hash calculations or equality comparisons.
+	 * CPU pods are used to improve execution locality of unbound work
+	 * items. There are multiple pod types, one for each wq_affn_scope, and
+	 * every CPU in the system belongs to one pod in every pod type. CPUs
+	 * that belong to the same pod share the worker pool. For example,
+	 * selecting %WQ_AFFN_NUMA makes the workqueue use a separate worker
+	 * pool for each NUMA node.
+	 */
+	enum wq_affn_scope affn_scope;
+
+	/**
+	 * @ordered: work items must be executed one by one in queueing order
 	 */
 	bool ordered;
 };
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index add6f5fc799b..dae1787833cb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -325,7 +325,18 @@ struct workqueue_struct {
 
 static struct kmem_cache *pwq_cache;
 
-static cpumask_var_t *wq_pod_cpus;	/* possible CPUs of each node */
+/*
+ * Each pod type describes how CPUs should be grouped for unbound workqueues.
+ * See the comment above workqueue_attrs->affn_scope.
+ */
+struct wq_pod_type {
+	int			nr_pods;	/* number of pods */
+	cpumask_var_t		*pod_cpus;	/* pod -> cpus */
+	int			*pod_node;	/* pod -> node */
+	int			*cpu_pod;	/* cpu -> pod */
+};
+
+static struct wq_pod_type wq_pod_types[WQ_AFFN_NR_TYPES];
 
 /*
  * Per-cpu work items which run for longer than the following threshold are
@@ -341,8 +352,6 @@ module_param_named(power_efficient, wq_power_efficient, bool, 0444);
 
 static bool wq_online;			/* can kworkers be created yet? */
 
-static bool wq_pod_enabled;		/* unbound CPU pod affinity enabled */
-
 /* buf for wq_update_unbound_pod_attrs(), protected by CPU hotplug exclusion */
 static struct workqueue_attrs *wq_update_pod_attrs_buf;
 
@@ -1753,10 +1762,6 @@ static int select_numa_node_cpu(int node)
 {
 	int cpu;
 
-	/* No point in doing this if NUMA isn't enabled for workqueues */
-	if (!wq_pod_enabled)
-		return WORK_CPU_UNBOUND;
-
 	/* Delay binding to CPU if node is not valid or online */
 	if (node < 0 || node >= MAX_NUMNODES || !node_online(node))
 		return WORK_CPU_UNBOUND;
@@ -3639,6 +3644,7 @@ struct workqueue_attrs *alloc_workqueue_attrs(void)
 		goto fail;
 
 	cpumask_copy(attrs->cpumask, cpu_possible_mask);
+	attrs->affn_scope = WQ_AFFN_DFL;
 	return attrs;
 fail:
 	free_workqueue_attrs(attrs);
@@ -3650,11 +3656,13 @@ static void copy_workqueue_attrs(struct workqueue_attrs *to,
 {
 	to->nice = from->nice;
 	cpumask_copy(to->cpumask, from->cpumask);
+
 	/*
-	 * Unlike hash and equality test, this function doesn't ignore
-	 * ->ordered as it is used for both pool and wq attrs.  Instead,
-	 * get_unbound_pool() explicitly clears ->ordered after copying.
+	 * Unlike hash and equality test, copying shouldn't ignore wq-only
+	 * fields as copying is used for both pool and wq attrs. Instead,
+	 * get_unbound_pool() explicitly clears the fields.
 	 */
+	to->affn_scope = from->affn_scope;
 	to->ordered = from->ordered;
 }
 
@@ -3680,6 +3688,24 @@ static bool wqattrs_equal(const struct workqueue_attrs *a,
 	return true;
 }
 
+/* find wq_pod_type to use for @attrs */
+static const struct wq_pod_type *
+wqattrs_pod_type(const struct workqueue_attrs *attrs)
+{
+	struct wq_pod_type *pt = &wq_pod_types[attrs->affn_scope];
+
+	if (likely(pt->nr_pods))
+		return pt;
+
+	/*
+	 * Before workqueue_init_topology(), only SYSTEM is available which is
+	 * initialized in workqueue_init_early().
+	 */
+	pt = &wq_pod_types[WQ_AFFN_SYSTEM];
+	BUG_ON(!pt->nr_pods);
+	return pt;
+}
+
 /**
  * init_worker_pool - initialize a newly zalloc'd worker_pool
  * @pool: worker_pool to initialize
@@ -3880,10 +3906,10 @@ static void put_unbound_pool(struct worker_pool *pool)
  */
 static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 {
+	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_NUMA];
 	u32 hash = wqattrs_hash(attrs);
 	struct worker_pool *pool;
-	int pod;
-	int target_pod = NUMA_NO_NODE;
+	int pod, node = NUMA_NO_NODE;
 
 	lockdep_assert_held(&wq_pool_mutex);
 
@@ -3895,28 +3921,24 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 		}
 	}
 
-	/* if cpumask is contained inside a pod, we belong to that pod */
-	if (wq_pod_enabled) {
-		for_each_node(pod) {
-			if (cpumask_subset(attrs->cpumask, wq_pod_cpus[pod])) {
-				target_pod = pod;
-				break;
-			}
+	/* If cpumask is contained inside a NUMA pod, that's our NUMA node */
+	for (pod = 0; pod < pt->nr_pods; pod++) {
+		if (cpumask_subset(attrs->cpumask, pt->pod_cpus[pod])) {
+			node = pt->pod_node[pod];
+			break;
 		}
 	}
 
 	/* nope, create a new one */
-	pool = kzalloc_node(sizeof(*pool), GFP_KERNEL, target_pod);
+	pool = kzalloc_node(sizeof(*pool), GFP_KERNEL, node);
 	if (!pool || init_worker_pool(pool) < 0)
 		goto fail;
 
 	copy_workqueue_attrs(pool->attrs, attrs);
-	pool->node = target_pod;
+	pool->node = node;
 
-	/*
-	 * ordered isn't a worker_pool attribute, always clear it.  See
-	 * 'struct workqueue_attrs' comments for detail.
-	 */
+	/* clear wq-only attr fields. See 'struct workqueue_attrs' comments */
+	pool->attrs->affn_scope = WQ_AFFN_NR_TYPES;
 	pool->attrs->ordered = false;
 
 	if (worker_pool_assign_id(pool) < 0)
@@ -4103,7 +4125,7 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
 /**
  * wq_calc_pod_cpumask - calculate a wq_attrs' cpumask for a pod
  * @attrs: the wq_attrs of the default pwq of the target workqueue
- * @pod: the target CPU pod
+ * @cpu: the target CPU
  * @cpu_going_down: if >= 0, the CPU to consider as offline
  * @cpumask: outarg, the resulting cpumask
  *
@@ -4117,30 +4139,29 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
  *
  * The caller is responsible for ensuring that the cpumask of @pod stays stable.
  */
-static void wq_calc_pod_cpumask(const struct workqueue_attrs *attrs, int pod,
-				 int cpu_going_down, cpumask_t *cpumask)
+static void wq_calc_pod_cpumask(const struct workqueue_attrs *attrs, int cpu,
+				int cpu_going_down, cpumask_t *cpumask)
 {
-	if (!wq_pod_enabled || attrs->ordered)
-		goto use_dfl;
+	const struct wq_pod_type *pt = wqattrs_pod_type(attrs);
+	int pod = pt->cpu_pod[cpu];
 
 	/* does @pod have any online CPUs @attrs wants? */
-	cpumask_and(cpumask, cpumask_of_node(pod), attrs->cpumask);
+	cpumask_and(cpumask, pt->pod_cpus[pod], attrs->cpumask);
+	cpumask_and(cpumask, cpumask, cpu_online_mask);
 	if (cpu_going_down >= 0)
 		cpumask_clear_cpu(cpu_going_down, cpumask);
 
-	if (cpumask_empty(cpumask))
-		goto use_dfl;
+	if (cpumask_empty(cpumask)) {
+		cpumask_copy(cpumask, attrs->cpumask);
+		return;
+	}
 
 	/* yeap, return possible CPUs in @pod that @attrs wants */
-	cpumask_and(cpumask, attrs->cpumask, wq_pod_cpus[pod]);
+	cpumask_and(cpumask, attrs->cpumask, pt->pod_cpus[pod]);
 
 	if (cpumask_empty(cpumask))
 		pr_warn_once("WARNING: workqueue cpumask: online intersect > "
 				"possible intersect\n");
-	return;
-
-use_dfl:
-	cpumask_copy(cpumask, attrs->cpumask);
 }
 
 /* install @pwq into @wq's cpu_pwq and return the old pwq */
@@ -4197,6 +4218,10 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 
 	lockdep_assert_held(&wq_pool_mutex);
 
+	if (WARN_ON(attrs->affn_scope < 0 ||
+		    attrs->affn_scope >= WQ_AFFN_NR_TYPES))
+		return ERR_PTR(-EINVAL);
+
 	ctx = kzalloc(struct_size(ctx, pwq_tbl, nr_cpu_ids), GFP_KERNEL);
 
 	new_attrs = alloc_workqueue_attrs();
@@ -4236,8 +4261,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 			ctx->dfl_pwq->refcnt++;
 			ctx->pwq_tbl[cpu] = ctx->dfl_pwq;
 		} else {
-			wq_calc_pod_cpumask(new_attrs, cpu_to_node(cpu), -1,
-					    tmp_attrs->cpumask);
+			wq_calc_pod_cpumask(new_attrs, cpu, -1, tmp_attrs->cpumask);
 			ctx->pwq_tbl[cpu] = alloc_unbound_pwq(wq, tmp_attrs);
 			if (!ctx->pwq_tbl[cpu])
 				goto out_free;
@@ -4257,7 +4281,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	free_workqueue_attrs(tmp_attrs);
 	free_workqueue_attrs(new_attrs);
 	apply_wqattrs_cleanup(ctx);
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 /* set attrs and install prepared pwqs, @ctx points to old pwqs on return */
@@ -4313,8 +4337,8 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 	}
 
 	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
-	if (!ctx)
-		return -ENOMEM;
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	/* the ctx has been prepared successfully, let's commit it */
 	apply_wqattrs_commit(ctx);
@@ -4376,7 +4400,6 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  */
 static void wq_update_pod(struct workqueue_struct *wq, int cpu, bool online)
 {
-	int pod = cpu_to_node(cpu);
 	int cpu_off = online ? -1 : cpu;
 	struct pool_workqueue *old_pwq = NULL, *pwq;
 	struct workqueue_attrs *target_attrs;
@@ -4384,8 +4407,7 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu, bool online)
 
 	lockdep_assert_held(&wq_pool_mutex);
 
-	if (!wq_pod_enabled || !(wq->flags & WQ_UNBOUND) ||
-	    wq->unbound_attrs->ordered)
+	if (!(wq->flags & WQ_UNBOUND) || wq->unbound_attrs->ordered)
 		return;
 
 	/*
@@ -4399,7 +4421,7 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu, bool online)
 	copy_workqueue_attrs(target_attrs, wq->unbound_attrs);
 
 	/* nothing to do if the target cpumask matches the current pwq */
-	wq_calc_pod_cpumask(wq->dfl_pwq->pool->attrs, pod, cpu_off, cpumask);
+	wq_calc_pod_cpumask(wq->dfl_pwq->pool->attrs, cpu, cpu_off, cpumask);
 	pwq = rcu_dereference_protected(*per_cpu_ptr(wq->cpu_pwq, cpu),
 					lockdep_is_held(&wq_pool_mutex));
 	if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
@@ -5640,8 +5662,8 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 			continue;
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
-		if (!ctx) {
-			ret = -ENOMEM;
+		if (IS_ERR(ctx)) {
+			ret = PTR_ERR(ctx);
 			break;
 		}
 
@@ -6234,6 +6256,7 @@ static inline void wq_watchdog_init(void) { }
  */
 void __init workqueue_init_early(void)
 {
+	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_SYSTEM];
 	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
 	int i, cpu;
 
@@ -6248,6 +6271,22 @@ void __init workqueue_init_early(void)
 	wq_update_pod_attrs_buf = alloc_workqueue_attrs();
 	BUG_ON(!wq_update_pod_attrs_buf);
 
+	/* initialize WQ_AFFN_SYSTEM pods */
+	pt->pod_cpus = kcalloc(1, sizeof(pt->pod_cpus[0]), GFP_KERNEL);
+	pt->pod_node = kcalloc(1, sizeof(pt->pod_node[0]), GFP_KERNEL);
+	pt->cpu_pod = kcalloc(nr_cpu_ids, sizeof(pt->cpu_pod[0]), GFP_KERNEL);
+	BUG_ON(!pt->pod_cpus || !pt->pod_node || !pt->cpu_pod);
+
+	BUG_ON(!zalloc_cpumask_var_node(&pt->pod_cpus[0], GFP_KERNEL, NUMA_NO_NODE));
+
+	wq_update_pod_attrs_buf = alloc_workqueue_attrs();
+	BUG_ON(!wq_update_pod_attrs_buf);
+
+	pt->nr_pods = 1;
+	cpumask_copy(pt->pod_cpus[0], cpu_possible_mask);
+	pt->pod_node[0] = NUMA_NO_NODE;
+	pt->cpu_pod[0] = 0;
+
 	/* initialize CPU pools */
 	for_each_possible_cpu(cpu) {
 		struct worker_pool *pool;
@@ -6365,8 +6404,8 @@ void __init workqueue_init(void)
  */
 void __init workqueue_init_topology(void)
 {
+	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_NUMA];
 	struct workqueue_struct *wq;
-	cpumask_var_t *tbl;
 	int node, cpu;
 
 	if (num_possible_nodes() <= 1)
@@ -6386,20 +6425,23 @@ void __init workqueue_init_topology(void)
 	 * available.  Build one from cpu_to_node() which should have been
 	 * fully initialized by now.
 	 */
-	tbl = kcalloc(nr_node_ids, sizeof(tbl[0]), GFP_KERNEL);
-	BUG_ON(!tbl);
+	pt->pod_cpus = kcalloc(nr_node_ids, sizeof(pt->pod_cpus[0]), GFP_KERNEL);
+	pt->pod_node = kcalloc(nr_node_ids, sizeof(pt->pod_node[0]), GFP_KERNEL);
+	pt->cpu_pod = kcalloc(nr_cpu_ids, sizeof(pt->cpu_pod[0]), GFP_KERNEL);
+	BUG_ON(!pt->pod_cpus || !pt->pod_node || !pt->cpu_pod);
 
 	for_each_node(node)
-		BUG_ON(!zalloc_cpumask_var_node(&tbl[node], GFP_KERNEL,
+		BUG_ON(!zalloc_cpumask_var_node(&pt->pod_cpus[node], GFP_KERNEL,
 				node_online(node) ? node : NUMA_NO_NODE));
 
 	for_each_possible_cpu(cpu) {
 		node = cpu_to_node(cpu);
-		cpumask_set_cpu(cpu, tbl[node]);
+		cpumask_set_cpu(cpu, pt->pod_cpus[node]);
+		pt->pod_node[node] = node;
+		pt->cpu_pod[cpu] = node;
 	}
 
-	wq_pod_cpus = tbl;
-	wq_pod_enabled = true;
+	pt->nr_pods = nr_node_ids;
 
 	/*
 	 * Workqueues allocated earlier would have all CPUs sharing the default
-- 
2.40.1

