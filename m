Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE64708CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjESASj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjESASQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737DD19A4
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae408f4d1aso21407515ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455477; x=1687047477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR0xPNG0L8gwUGyT27ySKhJ3diloQZpm6Ut1A4Xwn5A=;
        b=AP1IkGZ6T721vNp/0h3CkTuhmpM817bqlt2R2Nwr0dLi9Z2tl7aBHHx0vxxwaI/nyU
         07+/lEBbm+olWurCyC42PKwvv+hCHynk+3cCds2P8C4xGhfCAbnKGarEr9VVA1F+tZG4
         Z3ARYBLZreQtYTI+kYYuMPnx7Ii9CAejIq+CB36hJTsTm/xwJCM3WGrQA37SNXOuWVdu
         aLvJtItIv4TQoUEM5eWSpKXIb90lz5kJRDGop5qM6sTIr5dK/1pJm4atC2sAJHVQKJw2
         Iul/xJ3YLFEQTpWqPQvvIkYCgVfMdQ15GE/SoN8UQjxx9EWOPF9pYCV/4aJ75zTLdQ+t
         w4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455477; x=1687047477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PR0xPNG0L8gwUGyT27ySKhJ3diloQZpm6Ut1A4Xwn5A=;
        b=lRV1d7v8saSeMTCtc2dg7iX1IXVX8+St2VxrwR4QAKdSOL0RFGGSTy6TYY7pBOl2Lb
         Pzuhza7xKIwZE606II5o5Ol2mUrlCaitGCJ3skpf5cc/HcZGW5VZ3T9HsKG7a/NZdNtn
         DuDpLMwp0v1RFaa3qpnT8h2lREFOAyXcJ7+oXjLbOnwBIgexyvdUnjMzz6WsbqpcP/QC
         IQoc9vnQAc+6q23TGctM4b8O9yeSEqhkADC+FWssYOpGERvTEWOq1scqSY4Tok8D1vir
         7oTKhyx5PIrNQVhVncH5aVL9ui3y9bhcmKsZ6IiKaIPjIsgaZU8fhgW8vP6Lt0VuOwiM
         DENA==
X-Gm-Message-State: AC+VfDzXWL8ebZK2opdH3mqnXJhxTafXHKP3gvpVa55I/4nI1Ol1irYF
        hxzzeZTeP+tWMjkaIixMxi8=
X-Google-Smtp-Source: ACHHUZ7U+RvbKAOWku8f8INnNAuEklL4CScoMCgSsGiIbse/7uK5TPtHfpB7CpRMwOc8HG9oLJbL/g==
X-Received: by 2002:a17:902:fe18:b0:1aa:e5cd:6478 with SMTP id g24-20020a170902fe1800b001aae5cd6478mr767671plj.58.1684455476892;
        Thu, 18 May 2023 17:17:56 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m24-20020a170902bb9800b0019ee045a2b3sm2010057pls.308.2023.05.18.17.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/24] workqueue: Rename NUMA related names to use pod instead
Date:   Thu, 18 May 2023 14:16:56 -1000
Message-Id: <20230519001709.2563-12-tj@kernel.org>
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

Workqueue is in the process of improving CPU affinity awareness. It will
become more flexible and won't be tied to NUMA node boundaries. This patch
renames all NUMA related names in workqueue.c to use "pod" instead.

While "pod" isn't a very common term, it short and captures the grouping of
CPUs well enough. These names are only going to be used within workqueue
implementation proper, so the specific naming doesn't matter that much.

* wq_numa_possible_cpumask -> wq_pod_cpus

* wq_numa_enabled -> wq_pod_enabled

* wq_update_unbound_numa_attrs_buf -> wq_update_pod_attrs_buf

* workqueue_select_cpu_near -> select_numa_node_cpu

  This rename is different from others. The function is only used by
  queue_work_node() and specifically tries to find a CPU in the specified
  NUMA node. As workqueue affinity will become more flexible and untied from
  NUMA, this function's name should specifically describe that it's for
  NUMA.

* wq_calc_node_cpumask -> wq_calc_pod_cpumask

* wq_update_unbound_numa -> wq_update_pod

* wq_numa_init -> wq_pod_init

* node -> pod in local variables

Only renames. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 162 +++++++++++++++++++++------------------------
 1 file changed, 76 insertions(+), 86 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6a5d227949d9..08ab40371697 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -325,8 +325,7 @@ struct workqueue_struct {
 
 static struct kmem_cache *pwq_cache;
 
-static cpumask_var_t *wq_numa_possible_cpumask;
-					/* possible CPUs of each node */
+static cpumask_var_t *wq_pod_cpus;	/* possible CPUs of each node */
 
 /*
  * Per-cpu work items which run for longer than the following threshold are
@@ -342,10 +341,10 @@ module_param_named(power_efficient, wq_power_efficient, bool, 0444);
 
 static bool wq_online;			/* can kworkers be created yet? */
 
-static bool wq_numa_enabled;		/* unbound NUMA affinity enabled */
+static bool wq_pod_enabled;		/* unbound CPU pod affinity enabled */
 
-/* buf for wq_update_unbound_numa_attrs(), protected by CPU hotplug exclusion */
-static struct workqueue_attrs *wq_update_unbound_numa_attrs_buf;
+/* buf for wq_update_unbound_pod_attrs(), protected by CPU hotplug exclusion */
+static struct workqueue_attrs *wq_update_pod_attrs_buf;
 
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detach */
@@ -1742,7 +1741,7 @@ bool queue_work_on(int cpu, struct workqueue_struct *wq,
 EXPORT_SYMBOL(queue_work_on);
 
 /**
- * workqueue_select_cpu_near - Select a CPU based on NUMA node
+ * select_numa_node_cpu - Select a CPU based on NUMA node
  * @node: NUMA node ID that we want to select a CPU from
  *
  * This function will attempt to find a "random" cpu available on a given
@@ -1750,12 +1749,12 @@ EXPORT_SYMBOL(queue_work_on);
  * WORK_CPU_UNBOUND indicating that we should just schedule to any
  * available CPU if we need to schedule this work.
  */
-static int workqueue_select_cpu_near(int node)
+static int select_numa_node_cpu(int node)
 {
 	int cpu;
 
 	/* No point in doing this if NUMA isn't enabled for workqueues */
-	if (!wq_numa_enabled)
+	if (!wq_pod_enabled)
 		return WORK_CPU_UNBOUND;
 
 	/* Delay binding to CPU if node is not valid or online */
@@ -1814,7 +1813,7 @@ bool queue_work_node(int node, struct workqueue_struct *wq,
 	local_irq_save(flags);
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
-		int cpu = workqueue_select_cpu_near(node);
+		int cpu = select_numa_node_cpu(node);
 
 		__queue_work(cpu, wq, work);
 		ret = true;
@@ -3883,8 +3882,8 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 {
 	u32 hash = wqattrs_hash(attrs);
 	struct worker_pool *pool;
-	int node;
-	int target_node = NUMA_NO_NODE;
+	int pod;
+	int target_pod = NUMA_NO_NODE;
 
 	lockdep_assert_held(&wq_pool_mutex);
 
@@ -3896,24 +3895,23 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 		}
 	}
 
-	/* if cpumask is contained inside a NUMA node, we belong to that node */
-	if (wq_numa_enabled) {
-		for_each_node(node) {
-			if (cpumask_subset(attrs->cpumask,
-					   wq_numa_possible_cpumask[node])) {
-				target_node = node;
+	/* if cpumask is contained inside a pod, we belong to that pod */
+	if (wq_pod_enabled) {
+		for_each_node(pod) {
+			if (cpumask_subset(attrs->cpumask, wq_pod_cpus[pod])) {
+				target_pod = pod;
 				break;
 			}
 		}
 	}
 
 	/* nope, create a new one */
-	pool = kzalloc_node(sizeof(*pool), GFP_KERNEL, target_node);
+	pool = kzalloc_node(sizeof(*pool), GFP_KERNEL, target_pod);
 	if (!pool || init_worker_pool(pool) < 0)
 		goto fail;
 
 	copy_workqueue_attrs(pool->attrs, attrs);
-	pool->node = target_node;
+	pool->node = target_pod;
 
 	/*
 	 * ordered isn't a worker_pool attribute, always clear it.  See
@@ -4103,40 +4101,38 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
 }
 
 /**
- * wq_calc_node_cpumask - calculate a wq_attrs' cpumask for the specified node
+ * wq_calc_pod_cpumask - calculate a wq_attrs' cpumask for a pod
  * @attrs: the wq_attrs of the default pwq of the target workqueue
- * @node: the target NUMA node
+ * @pod: the target CPU pod
  * @cpu_going_down: if >= 0, the CPU to consider as offline
  * @cpumask: outarg, the resulting cpumask
  *
- * Calculate the cpumask a workqueue with @attrs should use on @node.  If
- * @cpu_going_down is >= 0, that cpu is considered offline during
- * calculation.  The result is stored in @cpumask.
+ * Calculate the cpumask a workqueue with @attrs should use on @pod. If
+ * @cpu_going_down is >= 0, that cpu is considered offline during calculation.
+ * The result is stored in @cpumask.
  *
- * If NUMA affinity is not enabled, @attrs->cpumask is always used.  If
- * enabled and @node has online CPUs requested by @attrs, the returned
- * cpumask is the intersection of the possible CPUs of @node and
- * @attrs->cpumask.
+ * If pod affinity is not enabled, @attrs->cpumask is always used. If enabled
+ * and @pod has online CPUs requested by @attrs, the returned cpumask is the
+ * intersection of the possible CPUs of @pod and @attrs->cpumask.
  *
- * The caller is responsible for ensuring that the cpumask of @node stays
- * stable.
+ * The caller is responsible for ensuring that the cpumask of @pod stays stable.
  */
-static void wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
+static void wq_calc_pod_cpumask(const struct workqueue_attrs *attrs, int pod,
 				 int cpu_going_down, cpumask_t *cpumask)
 {
-	if (!wq_numa_enabled || attrs->ordered)
+	if (!wq_pod_enabled || attrs->ordered)
 		goto use_dfl;
 
-	/* does @node have any online CPUs @attrs wants? */
-	cpumask_and(cpumask, cpumask_of_node(node), attrs->cpumask);
+	/* does @pod have any online CPUs @attrs wants? */
+	cpumask_and(cpumask, cpumask_of_node(pod), attrs->cpumask);
 	if (cpu_going_down >= 0)
 		cpumask_clear_cpu(cpu_going_down, cpumask);
 
 	if (cpumask_empty(cpumask))
 		goto use_dfl;
 
-	/* yeap, return possible CPUs in @node that @attrs wants */
-	cpumask_and(cpumask, attrs->cpumask, wq_numa_possible_cpumask[node]);
+	/* yeap, return possible CPUs in @pod that @attrs wants */
+	cpumask_and(cpumask, attrs->cpumask, wq_pod_cpus[pod]);
 
 	if (cpumask_empty(cpumask))
 		pr_warn_once("WARNING: workqueue cpumask: online intersect > "
@@ -4240,8 +4236,8 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 			ctx->dfl_pwq->refcnt++;
 			ctx->pwq_tbl[cpu] = ctx->dfl_pwq;
 		} else {
-			wq_calc_node_cpumask(new_attrs, cpu_to_node(cpu), -1,
-					     tmp_attrs->cpumask);
+			wq_calc_pod_cpumask(new_attrs, cpu_to_node(cpu), -1,
+					    tmp_attrs->cpumask);
 			ctx->pwq_tbl[cpu] = alloc_unbound_pwq(wq, tmp_attrs);
 			if (!ctx->pwq_tbl[cpu])
 				goto out_free;
@@ -4332,12 +4328,11 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
  * @wq: the target workqueue
  * @attrs: the workqueue_attrs to apply, allocated with alloc_workqueue_attrs()
  *
- * Apply @attrs to an unbound workqueue @wq.  Unless disabled, on NUMA
- * machines, this function maps a separate pwq to each NUMA node with
- * possibles CPUs in @attrs->cpumask so that work items are affine to the
- * NUMA node it was issued on.  Older pwqs are released as in-flight work
- * items finish.  Note that a work item which repeatedly requeues itself
- * back-to-back will stay on its current pwq.
+ * Apply @attrs to an unbound workqueue @wq. Unless disabled, this function maps
+ * a separate pwq to each CPU pod with possibles CPUs in @attrs->cpumask so that
+ * work items are affine to the pod it was issued on. Older pwqs are released as
+ * in-flight work items finish. Note that a work item which repeatedly requeues
+ * itself back-to-back will stay on its current pwq.
  *
  * Performs GFP_KERNEL allocations.
  *
@@ -4360,31 +4355,28 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
 }
 
 /**
- * wq_update_unbound_numa - update NUMA affinity of a wq for CPU hot[un]plug
+ * wq_update_pod - update pod affinity of a wq for CPU hot[un]plug
  * @wq: the target workqueue
  * @cpu: the CPU coming up or going down
  * @online: whether @cpu is coming up or going down
  *
  * This function is to be called from %CPU_DOWN_PREPARE, %CPU_ONLINE and
- * %CPU_DOWN_FAILED.  @cpu is being hot[un]plugged, update NUMA affinity of
- * @wq accordingly.
- *
- * If NUMA affinity can't be adjusted due to memory allocation failure, it
- * falls back to @wq->dfl_pwq which may not be optimal but is always
- * correct.
- *
- * Note that when the last allowed CPU of a NUMA node goes offline for a
- * workqueue with a cpumask spanning multiple nodes, the workers which were
- * already executing the work items for the workqueue will lose their CPU
- * affinity and may execute on any CPU.  This is similar to how per-cpu
- * workqueues behave on CPU_DOWN.  If a workqueue user wants strict
- * affinity, it's the user's responsibility to flush the work item from
- * CPU_DOWN_PREPARE.
+ * %CPU_DOWN_FAILED. @cpu is being hot[un]plugged, update pod affinity of @wq
+ * accordingly.
+ *
+ * If pod affinity can't be adjusted due to memory allocation failure, it falls
+ * back to @wq->dfl_pwq which may not be optimal but is always correct.
+ *
+ * Note that when the last allowed CPU of a pod goes offline for a workqueue
+ * with a cpumask spanning multiple poders, the workers which were already
+ * executing the work items for the workqueue will lose their CPU affinity and
+ * may execute on any CPU. This is similar to how per-cpu workqueues behave on
+ * CPU_DOWN. If a workqueue user wants strict affinity, it's the user's
+ * responsibility to flush the work item from CPU_DOWN_PREPARE.
  */
-static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
-				   bool online)
+static void wq_update_pod(struct workqueue_struct *wq, int cpu, bool online)
 {
-	int node = cpu_to_node(cpu);
+	int pod = cpu_to_node(cpu);
 	int cpu_off = online ? -1 : cpu;
 	struct pool_workqueue *old_pwq = NULL, *pwq;
 	struct workqueue_attrs *target_attrs;
@@ -4392,7 +4384,7 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 
 	lockdep_assert_held(&wq_pool_mutex);
 
-	if (!wq_numa_enabled || !(wq->flags & WQ_UNBOUND) ||
+	if (!wq_pod_enabled || !(wq->flags & WQ_UNBOUND) ||
 	    wq->unbound_attrs->ordered)
 		return;
 
@@ -4401,13 +4393,13 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 	 * Let's use a preallocated one.  The following buf is protected by
 	 * CPU hotplug exclusion.
 	 */
-	target_attrs = wq_update_unbound_numa_attrs_buf;
+	target_attrs = wq_update_pod_attrs_buf;
 	cpumask = target_attrs->cpumask;
 
 	copy_workqueue_attrs(target_attrs, wq->unbound_attrs);
 
 	/* nothing to do if the target cpumask matches the current pwq */
-	wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpu_off, cpumask);
+	wq_calc_pod_cpumask(wq->dfl_pwq->pool->attrs, pod, cpu_off, cpumask);
 	pwq = rcu_dereference_protected(*per_cpu_ptr(wq->cpu_pwq, cpu),
 					lockdep_is_held(&wq_pool_mutex));
 	if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
@@ -4416,7 +4408,7 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 	/* create a new pwq */
 	pwq = alloc_unbound_pwq(wq, target_attrs);
 	if (!pwq) {
-		pr_warn("workqueue: allocation failed while updating NUMA affinity of \"%s\"\n",
+		pr_warn("workqueue: allocation failed while updating CPU pod affinity of \"%s\"\n",
 			wq->name);
 		goto use_dfl_pwq;
 	}
@@ -4547,11 +4539,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	struct pool_workqueue *pwq;
 
 	/*
-	 * Unbound && max_active == 1 used to imply ordered, which is no
-	 * longer the case on NUMA machines due to per-node pools.  While
+	 * Unbound && max_active == 1 used to imply ordered, which is no longer
+	 * the case on many machines due to per-pod pools. While
 	 * alloc_ordered_workqueue() is the right way to create an ordered
-	 * workqueue, keep the previous behavior to avoid subtle breakages
-	 * on NUMA.
+	 * workqueue, keep the previous behavior to avoid subtle breakages.
 	 */
 	if ((flags & WQ_UNBOUND) && max_active == 1)
 		flags |= __WQ_ORDERED;
@@ -5432,9 +5423,9 @@ int workqueue_online_cpu(unsigned int cpu)
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
 
-	/* update NUMA affinity of unbound workqueues */
+	/* update pod affinity of unbound workqueues */
 	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, true);
+		wq_update_pod(wq, cpu, true);
 
 	mutex_unlock(&wq_pool_mutex);
 	return 0;
@@ -5450,10 +5441,10 @@ int workqueue_offline_cpu(unsigned int cpu)
 
 	unbind_workers(cpu);
 
-	/* update NUMA affinity of unbound workqueues */
+	/* update pod affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
 	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, false);
+		wq_update_pod(wq, cpu, false);
 	mutex_unlock(&wq_pool_mutex);
 
 	return 0;
@@ -6231,7 +6222,7 @@ static inline void wq_watchdog_init(void) { }
 
 #endif	/* CONFIG_WQ_WATCHDOG */
 
-static void __init wq_numa_init(void)
+static void __init wq_pod_init(void)
 {
 	cpumask_var_t *tbl;
 	int node, cpu;
@@ -6246,8 +6237,8 @@ static void __init wq_numa_init(void)
 		}
 	}
 
-	wq_update_unbound_numa_attrs_buf = alloc_workqueue_attrs();
-	BUG_ON(!wq_update_unbound_numa_attrs_buf);
+	wq_update_pod_attrs_buf = alloc_workqueue_attrs();
+	BUG_ON(!wq_update_pod_attrs_buf);
 
 	/*
 	 * We want masks of possible CPUs of each node which isn't readily
@@ -6266,8 +6257,8 @@ static void __init wq_numa_init(void)
 		cpumask_set_cpu(cpu, tbl[node]);
 	}
 
-	wq_numa_possible_cpumask = tbl;
-	wq_numa_enabled = true;
+	wq_pod_cpus = tbl;
+	wq_pod_enabled = true;
 }
 
 /**
@@ -6367,15 +6358,14 @@ void __init workqueue_init(void)
 	BUG_ON(IS_ERR(pwq_release_worker));
 
 	/*
-	 * It'd be simpler to initialize NUMA in workqueue_init_early() but
-	 * CPU to node mapping may not be available that early on some
-	 * archs such as power and arm64.  As per-cpu pools created
-	 * previously could be missing node hint and unbound pools NUMA
-	 * affinity, fix them up.
+	 * It'd be simpler to initialize pods in workqueue_init_early() but CPU
+	 * to node mapping may not be available that early on some archs such as
+	 * power and arm64. As per-cpu pools created previously could be missing
+	 * node hint and unbound pool pod affinity, fix them up.
 	 *
 	 * Also, while iterating workqueues, create rescuers if requested.
 	 */
-	wq_numa_init();
+	wq_pod_init();
 
 	mutex_lock(&wq_pool_mutex);
 
@@ -6386,7 +6376,7 @@ void __init workqueue_init(void)
 	}
 
 	list_for_each_entry(wq, &workqueues, list) {
-		wq_update_unbound_numa(wq, smp_processor_id(), true);
+		wq_update_pod(wq, smp_processor_id(), true);
 		WARN(init_rescuer(wq),
 		     "workqueue: failed to create early rescuer for %s",
 		     wq->name);
-- 
2.40.1

