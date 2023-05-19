Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC2708CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjESASS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjESASC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A021738
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae615d5018so13834175ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455473; x=1687047473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqxsFLuh6S8kzvHhAiOj1kdb3o4HT8hk5LpbS18Nae0=;
        b=CQgMAuQpgHflzZZUtZxgSgS3EERH8X/Ag3BN66MKzvMndcGviahLmbGu5o45NBNxKD
         RqUxNFaBbAMf9O8i6gjouPS75+EHdDsH5zaHq/XDysfyUymnCIRat4E1WnGYq/Vc4+yn
         MR74qDubhRLQ1j2nSVmysh9MNx+QLoNBAeRKrvtS3BDKtuRJRgrDBeYp5Pf6P4MsnAo/
         yyNmuq5B2tN+ZyD6/Q/OG+T1eI9awMJnxyUfwpoz2QfQbLcb7KF9vKBNtm5nyLgRHEj4
         rDg8bZMSSbhrNykRMGdphbSt4dV+6UoRIw70qMUdpVtN5Roy/9J3X5ALw6Eqi6517Rj+
         xk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455473; x=1687047473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vqxsFLuh6S8kzvHhAiOj1kdb3o4HT8hk5LpbS18Nae0=;
        b=Xk1AObo7ecZdqJIfHSPqY1AmW4oXve7mqZUUbgf13oieYdNNVEZufKolObvzknV3fR
         dj5iQRfRcIApGlwPIygCtkF3NtfypVJY9BJApUKwZS+k2uKnHolC+8vDnxUF/FCzVIS2
         Vjsi4hrH+xUmWQZculllJSSjXYzerc+6m8brmXf6UWoro7UQo5ycwNwPxiIin2XjkPUM
         4ajnMHL/um8kyHcUyz9cWmuPyhXamrt8OMfwPzhhTFKaDqweIZFJFBXiclzcncEH/mjq
         ZFp7sRVVzSdaxNjkM/Favjl8JKeEeQk9dLHhdxDF9Bh51OGbDNIPADK661kdrnHjpEo9
         HfBA==
X-Gm-Message-State: AC+VfDxDDgKVwG2hmaq6Q69aR0tv2hN7L+rQqfDnht77alixVQs+i1zC
        OKTfAJtKEOyuoE9oCdsPKEE=
X-Google-Smtp-Source: ACHHUZ733ePQAybxSaamrYH0yWhchVqvqxaM3qbIqb4Qde6YtPRkswdnBuG2sKh4Amr31dfaUuQW8w==
X-Received: by 2002:a17:902:ecc4:b0:1ab:528:5f85 with SMTP id a4-20020a170902ecc400b001ab05285f85mr929380plh.59.1684455473115;
        Thu, 18 May 2023 17:17:53 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001a24cded097sm2031414plh.236.2023.05.18.17.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>
Subject: [PATCH 09/24] workqueue: Make unbound workqueues to use per-cpu pool_workqueues
Date:   Thu, 18 May 2023 14:16:54 -1000
Message-Id: <20230519001709.2563-10-tj@kernel.org>
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

A pwq (pool_workqueue) represents an association between a workqueue and a
worker_pool. When a work item is queued, the workqueue selects the pwq to
use, which in turn determines the pool, and queues the work item to the pool
through the pwq. pwq is also what implements the maximum concurrency limit -
@max_active.

As a per-cpu workqueue should be assocaited with a different worker_pool on
each CPU, it always had per-cpu pwq's that are accessed through wq->cpu_pwq.
However, unbound workqueues were sharing a pwq within each NUMA node by
default. The sharing has several downsides:

* Because @max_active is per-pwq, the meaning of @max_active changes
  depending on the machine configuration and whether workqueue NUMA locality
  support is enabled.

* Makes per-cpu and unbound code deviate.

* Gets in the way of making workqueue CPU locality awareness more flexible.

This patch makes unbound workqueues use per-cpu pwq's the same way per-cpu
workqueues do by making the following changes:

* wq->numa_pwq_tbl[] is removed and unbound workqueues now use wq->cpu_pwq
  just like per-cpu workqueues. wq->cpu_pwq is now RCU protected for unbound
  workqueues.

* numa_pwq_tbl_install() is renamed to install_unbound_pwq() and installs
  the specified pwq to the target CPU's wq->cpu_pwq.

* apply_wqattrs_prepare() now always allocates a separate pwq for each CPU
  unless the workqueue is ordered. If ordered, all CPUs use wq->dfl_pwq.
  This makes the return value of wq_calc_node_cpumask() unnecessary. It now
  returns void.

* @max_active now means the same thing for both per-cpu and unbound
  workqueues. WQ_UNBOUND_MAX_ACTIVE now equals WQ_MAX_ACTIVE and
  documentation is updated accordingly. WQ_UNBOUND_MAX_ACTIVE is no longer
  used in workqueue implementation and will be removed later.

* All unbound pwq operations which used to be per-numa-node are now per-cpu.

For most unbound workqueue users, this shouldn't cause noticeable changes.
Work item issue and completion will be a small bit faster, flush_workqueue()
would become a bit more expensive, and the total concurrency limit would
likely become higher. All @max_active==1 use cases are currently being
audited for conversion into alloc_ordered_workqueue() and they shouldn't be
affected once the audit and conversion is complete.

One area where the behavior change may be more noticeable is
workqueue_congested() as the reported congestion state is now per CPU
instead of NUMA node. There are only two users of this interface -
drivers/infiniband/hw/hfi1 and net/smc. Maintainers of both subsystems are
cc'd. Inputs on the behavior change would be very much appreciated.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Karsten Graul <kgraul@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>
---
 Documentation/core-api/workqueue.rst |  21 ++-
 include/linux/workqueue.h            |   8 +-
 kernel/workqueue.c                   | 218 ++++++++++-----------------
 3 files changed, 89 insertions(+), 158 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index a4c9b9d1905f..8e541c5d8fa9 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -220,17 +220,16 @@ resources, scheduled and executed.
 ``max_active``
 --------------
 
-``@max_active`` determines the maximum number of execution contexts
-per CPU which can be assigned to the work items of a wq.  For example,
-with ``@max_active`` of 16, at most 16 work items of the wq can be
-executing at the same time per CPU.
-
-Currently, for a bound wq, the maximum limit for ``@max_active`` is
-512 and the default value used when 0 is specified is 256.  For an
-unbound wq, the limit is higher of 512 and 4 *
-``num_possible_cpus()``.  These values are chosen sufficiently high
-such that they are not the limiting factor while providing protection
-in runaway cases.
+``@max_active`` determines the maximum number of execution contexts per
+CPU which can be assigned to the work items of a wq. For example, with
+``@max_active`` of 16, at most 16 work items of the wq can be executing
+at the same time per CPU. This is always a per-CPU attribute, even for
+unbound workqueues.
+
+The maximum limit for ``@max_active`` is 512 and the default value used
+when 0 is specified is 256. These values are chosen sufficiently high
+such that they are not the limiting factor while providing protection in
+runaway cases.
 
 The number of active work items of a wq is usually regulated by the
 users of the wq, more specifically, by how many work items the users
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 3992c994787f..d1b681f67985 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -342,14 +342,10 @@ enum {
 	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
 
 	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
-	WQ_MAX_UNBOUND_PER_CPU	= 4,	  /* 4 * #cpus for unbound wq */
+	WQ_UNBOUND_MAX_ACTIVE	= WQ_MAX_ACTIVE,
 	WQ_DFL_ACTIVE		= WQ_MAX_ACTIVE / 2,
 };
 
-/* unbound wq's aren't per-cpu, scale max_active according to #cpus */
-#define WQ_UNBOUND_MAX_ACTIVE	\
-	max_t(int, WQ_MAX_ACTIVE, num_possible_cpus() * WQ_MAX_UNBOUND_PER_CPU)
-
 /*
  * System-wide workqueues which are always present.
  *
@@ -390,7 +386,7 @@ extern struct workqueue_struct *system_freezable_power_efficient_wq;
  * alloc_workqueue - allocate a workqueue
  * @fmt: printf format for the name of the workqueue
  * @flags: WQ_* flags
- * @max_active: max in-flight work items, 0 for default
+ * @max_active: max in-flight work items per CPU, 0 for default
  * remaining args: args for @fmt
  *
  * Allocate a workqueue with the specified parameters.  For detailed
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 574d2e12417d..43f3bb801bd9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -320,8 +320,7 @@ struct workqueue_struct {
 
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
-	struct pool_workqueue __percpu **cpu_pwq; /* I: per-cpu pwqs */
-	struct pool_workqueue __rcu *numa_pwq_tbl[]; /* PWR: unbound pwqs indexed by node */
+	struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
 };
 
 static struct kmem_cache *pwq_cache;
@@ -602,35 +601,6 @@ static int worker_pool_assign_id(struct worker_pool *pool)
 	return ret;
 }
 
-/**
- * unbound_pwq_by_node - return the unbound pool_workqueue for the given node
- * @wq: the target workqueue
- * @node: the node ID
- *
- * This must be called with any of wq_pool_mutex, wq->mutex or RCU
- * read locked.
- * If the pwq needs to be used beyond the locking in effect, the caller is
- * responsible for guaranteeing that the pwq stays online.
- *
- * Return: The unbound pool_workqueue for @node.
- */
-static struct pool_workqueue *unbound_pwq_by_node(struct workqueue_struct *wq,
-						  int node)
-{
-	assert_rcu_or_wq_mutex_or_pool_mutex(wq);
-
-	/*
-	 * XXX: @node can be NUMA_NO_NODE if CPU goes offline while a
-	 * delayed item is pending.  The plan is to keep CPU -> NODE
-	 * mapping valid and stable across CPU on/offlines.  Once that
-	 * happens, this workaround can be removed.
-	 */
-	if (unlikely(node == NUMA_NO_NODE))
-		return wq->dfl_pwq;
-
-	return rcu_dereference_raw(wq->numa_pwq_tbl[node]);
-}
-
 static unsigned int work_color_to_flags(int color)
 {
 	return color << WORK_STRUCT_COLOR_SHIFT;
@@ -1657,16 +1627,14 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	rcu_read_lock();
 retry:
 	/* pwq which will be used unless @work is executing elsewhere */
-	if (wq->flags & WQ_UNBOUND) {
-		if (req_cpu == WORK_CPU_UNBOUND)
+	if (req_cpu == WORK_CPU_UNBOUND) {
+		if (wq->flags & WQ_UNBOUND)
 			cpu = wq_select_unbound_cpu(raw_smp_processor_id());
-		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));
-	} else {
-		if (req_cpu == WORK_CPU_UNBOUND)
+		else
 			cpu = raw_smp_processor_id();
-		pwq = *per_cpu_ptr(wq->cpu_pwq, cpu);
 	}
 
+	pwq = rcu_dereference(*per_cpu_ptr(wq->cpu_pwq, cpu));
 	pool = pwq->pool;
 
 	/*
@@ -1695,12 +1663,11 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	}
 
 	/*
-	 * pwq is determined and locked.  For unbound pools, we could have
-	 * raced with pwq release and it could already be dead.  If its
-	 * refcnt is zero, repeat pwq selection.  Note that pwqs never die
-	 * without another pwq replacing it in the numa_pwq_tbl or while
-	 * work items are executing on it, so the retrying is guaranteed to
-	 * make forward-progress.
+	 * pwq is determined and locked. For unbound pools, we could have raced
+	 * with pwq release and it could already be dead. If its refcnt is zero,
+	 * repeat pwq selection. Note that unbound pwqs never die without
+	 * another pwq replacing it in cpu_pwq or while work items are executing
+	 * on it, so the retrying is guaranteed to make forward-progress.
 	 */
 	if (unlikely(!pwq->refcnt)) {
 		if (wq->flags & WQ_UNBOUND) {
@@ -3799,12 +3766,8 @@ static void rcu_free_wq(struct rcu_head *rcu)
 		container_of(rcu, struct workqueue_struct, rcu);
 
 	wq_free_lockdep(wq);
-
-	if (!(wq->flags & WQ_UNBOUND))
-		free_percpu(wq->cpu_pwq);
-	else
-		free_workqueue_attrs(wq->unbound_attrs);
-
+	free_percpu(wq->cpu_pwq);
+	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
 }
 
@@ -4157,11 +4120,8 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
  *
  * The caller is responsible for ensuring that the cpumask of @node stays
  * stable.
- *
- * Return: %true if the resulting @cpumask is different from @attrs->cpumask,
- * %false if equal.
  */
-static bool wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
+static void wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
 				 int cpu_going_down, cpumask_t *cpumask)
 {
 	if (!wq_numa_enabled || attrs->no_numa)
@@ -4178,23 +4138,18 @@ static bool wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
 	/* yeap, return possible CPUs in @node that @attrs wants */
 	cpumask_and(cpumask, attrs->cpumask, wq_numa_possible_cpumask[node]);
 
-	if (cpumask_empty(cpumask)) {
+	if (cpumask_empty(cpumask))
 		pr_warn_once("WARNING: workqueue cpumask: online intersect > "
 				"possible intersect\n");
-		return false;
-	}
-
-	return !cpumask_equal(cpumask, attrs->cpumask);
+	return;
 
 use_dfl:
 	cpumask_copy(cpumask, attrs->cpumask);
-	return false;
 }
 
-/* install @pwq into @wq's numa_pwq_tbl[] for @node and return the old pwq */
-static struct pool_workqueue *numa_pwq_tbl_install(struct workqueue_struct *wq,
-						   int node,
-						   struct pool_workqueue *pwq)
+/* install @pwq into @wq's cpu_pwq and return the old pwq */
+static struct pool_workqueue *install_unbound_pwq(struct workqueue_struct *wq,
+					int cpu, struct pool_workqueue *pwq)
 {
 	struct pool_workqueue *old_pwq;
 
@@ -4204,8 +4159,8 @@ static struct pool_workqueue *numa_pwq_tbl_install(struct workqueue_struct *wq,
 	/* link_pwq() can handle duplicate calls */
 	link_pwq(pwq);
 
-	old_pwq = rcu_access_pointer(wq->numa_pwq_tbl[node]);
-	rcu_assign_pointer(wq->numa_pwq_tbl[node], pwq);
+	old_pwq = rcu_access_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu));
+	rcu_assign_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu), pwq);
 	return old_pwq;
 }
 
@@ -4222,10 +4177,10 @@ struct apply_wqattrs_ctx {
 static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
 {
 	if (ctx) {
-		int node;
+		int cpu;
 
-		for_each_node(node)
-			put_pwq_unlocked(ctx->pwq_tbl[node]);
+		for_each_possible_cpu(cpu)
+			put_pwq_unlocked(ctx->pwq_tbl[cpu]);
 		put_pwq_unlocked(ctx->dfl_pwq);
 
 		free_workqueue_attrs(ctx->attrs);
@@ -4242,11 +4197,11 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 {
 	struct apply_wqattrs_ctx *ctx;
 	struct workqueue_attrs *new_attrs, *tmp_attrs;
-	int node;
+	int cpu;
 
 	lockdep_assert_held(&wq_pool_mutex);
 
-	ctx = kzalloc(struct_size(ctx, pwq_tbl, nr_node_ids), GFP_KERNEL);
+	ctx = kzalloc(struct_size(ctx, pwq_tbl, nr_cpu_ids), GFP_KERNEL);
 
 	new_attrs = alloc_workqueue_attrs();
 	tmp_attrs = alloc_workqueue_attrs();
@@ -4280,14 +4235,16 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	if (!ctx->dfl_pwq)
 		goto out_free;
 
-	for_each_node(node) {
-		if (wq_calc_node_cpumask(new_attrs, node, -1, tmp_attrs->cpumask)) {
-			ctx->pwq_tbl[node] = alloc_unbound_pwq(wq, tmp_attrs);
-			if (!ctx->pwq_tbl[node])
-				goto out_free;
-		} else {
+	for_each_possible_cpu(cpu) {
+		if (new_attrs->no_numa) {
 			ctx->dfl_pwq->refcnt++;
-			ctx->pwq_tbl[node] = ctx->dfl_pwq;
+			ctx->pwq_tbl[cpu] = ctx->dfl_pwq;
+		} else {
+			wq_calc_node_cpumask(new_attrs, cpu_to_node(cpu), -1,
+					     tmp_attrs->cpumask);
+			ctx->pwq_tbl[cpu] = alloc_unbound_pwq(wq, tmp_attrs);
+			if (!ctx->pwq_tbl[cpu])
+				goto out_free;
 		}
 	}
 
@@ -4310,7 +4267,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 /* set attrs and install prepared pwqs, @ctx points to old pwqs on return */
 static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
 {
-	int node;
+	int cpu;
 
 	/* all pwqs have been created successfully, let's install'em */
 	mutex_lock(&ctx->wq->mutex);
@@ -4318,9 +4275,9 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
 	copy_workqueue_attrs(ctx->wq->unbound_attrs, ctx->attrs);
 
 	/* save the previous pwq and install the new one */
-	for_each_node(node)
-		ctx->pwq_tbl[node] = numa_pwq_tbl_install(ctx->wq, node,
-							  ctx->pwq_tbl[node]);
+	for_each_possible_cpu(cpu)
+		ctx->pwq_tbl[cpu] = install_unbound_pwq(ctx->wq, cpu,
+							ctx->pwq_tbl[cpu]);
 
 	/* @dfl_pwq might not have been used, ensure it's linked */
 	link_pwq(ctx->dfl_pwq);
@@ -4448,20 +4405,13 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 	cpumask = target_attrs->cpumask;
 
 	copy_workqueue_attrs(target_attrs, wq->unbound_attrs);
-	pwq = unbound_pwq_by_node(wq, node);
 
-	/*
-	 * Let's determine what needs to be done.  If the target cpumask is
-	 * different from the default pwq's, we need to compare it to @pwq's
-	 * and create a new one if they don't match.  If the target cpumask
-	 * equals the default pwq's, the default pwq should be used.
-	 */
-	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpu_off, cpumask)) {
-		if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
-			return;
-	} else {
-		goto use_dfl_pwq;
-	}
+	/* nothing to do if the target cpumask matches the current pwq */
+	wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpu_off, cpumask);
+	pwq = rcu_dereference_protected(*per_cpu_ptr(wq->cpu_pwq, cpu),
+					lockdep_is_held(&wq_pool_mutex));
+	if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
+		return;
 
 	/* create a new pwq */
 	pwq = alloc_unbound_pwq(wq, target_attrs);
@@ -4473,7 +4423,7 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 
 	/* Install the new pwq. */
 	mutex_lock(&wq->mutex);
-	old_pwq = numa_pwq_tbl_install(wq, node, pwq);
+	old_pwq = install_unbound_pwq(wq, cpu, pwq);
 	goto out_unlock;
 
 use_dfl_pwq:
@@ -4481,7 +4431,7 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 	raw_spin_lock_irq(&wq->dfl_pwq->pool->lock);
 	get_pwq(wq->dfl_pwq);
 	raw_spin_unlock_irq(&wq->dfl_pwq->pool->lock);
-	old_pwq = numa_pwq_tbl_install(wq, node, wq->dfl_pwq);
+	old_pwq = install_unbound_pwq(wq, cpu, wq->dfl_pwq);
 out_unlock:
 	mutex_unlock(&wq->mutex);
 	put_pwq_unlocked(old_pwq);
@@ -4492,11 +4442,11 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	bool highpri = wq->flags & WQ_HIGHPRI;
 	int cpu, ret;
 
-	if (!(wq->flags & WQ_UNBOUND)) {
-		wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
-		if (!wq->cpu_pwq)
-			goto enomem;
+	wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
+	if (!wq->cpu_pwq)
+		goto enomem;
 
+	if (!(wq->flags & WQ_UNBOUND)) {
 		for_each_possible_cpu(cpu) {
 			struct pool_workqueue **pwq_p =
 				per_cpu_ptr(wq->cpu_pwq, cpu);
@@ -4544,13 +4494,11 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 static int wq_clamp_max_active(int max_active, unsigned int flags,
 			       const char *name)
 {
-	int lim = flags & WQ_UNBOUND ? WQ_UNBOUND_MAX_ACTIVE : WQ_MAX_ACTIVE;
-
-	if (max_active < 1 || max_active > lim)
+	if (max_active < 1 || max_active > WQ_MAX_ACTIVE)
 		pr_warn("workqueue: max_active %d requested for %s is out of range, clamping between %d and %d\n",
-			max_active, name, 1, lim);
+			max_active, name, 1, WQ_MAX_ACTIVE);
 
-	return clamp_val(max_active, 1, lim);
+	return clamp_val(max_active, 1, WQ_MAX_ACTIVE);
 }
 
 /*
@@ -4594,7 +4542,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 					 unsigned int flags,
 					 int max_active, ...)
 {
-	size_t tbl_size = 0;
 	va_list args;
 	struct workqueue_struct *wq;
 	struct pool_workqueue *pwq;
@@ -4614,10 +4561,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 		flags |= WQ_UNBOUND;
 
 	/* allocate wq and format name */
-	if (flags & WQ_UNBOUND)
-		tbl_size = nr_node_ids * sizeof(wq->numa_pwq_tbl[0]);
-
-	wq = kzalloc(sizeof(*wq) + tbl_size, GFP_KERNEL);
+	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
 	if (!wq)
 		return NULL;
 
@@ -4712,7 +4656,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 void destroy_workqueue(struct workqueue_struct *wq)
 {
 	struct pool_workqueue *pwq;
-	int cpu, node;
+	int cpu;
 
 	/*
 	 * Remove it from sysfs first so that sanity check failure doesn't
@@ -4771,29 +4715,23 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	list_del_rcu(&wq->list);
 	mutex_unlock(&wq_pool_mutex);
 
-	if (!(wq->flags & WQ_UNBOUND)) {
-		for_each_possible_cpu(cpu)
-			put_pwq_unlocked(*per_cpu_ptr(wq->cpu_pwq, cpu));
-	} else {
-		/*
-		 * We're the sole accessor of @wq at this point.  Directly
-		 * access numa_pwq_tbl[] and dfl_pwq to put the base refs.
-		 * @wq will be freed when the last pwq is released.
-		 */
-		for_each_node(node) {
-			pwq = rcu_access_pointer(wq->numa_pwq_tbl[node]);
-			RCU_INIT_POINTER(wq->numa_pwq_tbl[node], NULL);
-			put_pwq_unlocked(pwq);
-		}
+	/*
+	 * We're the sole accessor of @wq. Directly access cpu_pwq and dfl_pwq
+	 * to put the base refs. @wq will be auto-destroyed from the last
+	 * pwq_put. RCU read lock prevents @wq from going away from under us.
+	 */
+	rcu_read_lock();
 
-		/*
-		 * Put dfl_pwq.  @wq may be freed any time after dfl_pwq is
-		 * put.  Don't access it afterwards.
-		 */
-		pwq = wq->dfl_pwq;
-		wq->dfl_pwq = NULL;
+	for_each_possible_cpu(cpu) {
+		pwq = rcu_access_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu));
+		RCU_INIT_POINTER(*per_cpu_ptr(wq->cpu_pwq, cpu), NULL);
 		put_pwq_unlocked(pwq);
 	}
+
+	put_pwq_unlocked(wq->dfl_pwq);
+	wq->dfl_pwq = NULL;
+
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(destroy_workqueue);
 
@@ -4870,10 +4808,11 @@ bool current_is_workqueue_rescuer(void)
  * unreliable and only useful as advisory hints or for debugging.
  *
  * If @cpu is WORK_CPU_UNBOUND, the test is performed on the local CPU.
- * Note that both per-cpu and unbound workqueues may be associated with
- * multiple pool_workqueues which have separate congested states.  A
- * workqueue being congested on one CPU doesn't mean the workqueue is also
- * contested on other CPUs / NUMA nodes.
+ *
+ * With the exception of ordered workqueues, all workqueues have per-cpu
+ * pool_workqueues, each with its own congested state. A workqueue being
+ * congested on one CPU doesn't mean that the workqueue is contested on any
+ * other CPUs.
  *
  * Return:
  * %true if congested, %false otherwise.
@@ -4889,12 +4828,9 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 	if (cpu == WORK_CPU_UNBOUND)
 		cpu = smp_processor_id();
 
-	if (!(wq->flags & WQ_UNBOUND))
-		pwq = *per_cpu_ptr(wq->cpu_pwq, cpu);
-	else
-		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));
-
+	pwq = *per_cpu_ptr(wq->cpu_pwq, cpu);
 	ret = !list_empty(&pwq->inactive_works);
+
 	preempt_enable();
 	rcu_read_unlock();
 
@@ -6399,7 +6335,7 @@ void __init workqueue_init_early(void)
 	system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
 	system_long_wq = alloc_workqueue("events_long", 0, 0);
 	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND,
-					    WQ_UNBOUND_MAX_ACTIVE);
+					    WQ_MAX_ACTIVE);
 	system_freezable_wq = alloc_workqueue("events_freezable",
 					      WQ_FREEZABLE, 0);
 	system_power_efficient_wq = alloc_workqueue("events_power_efficient",
-- 
2.40.1

