Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6835263B16B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiK1Sef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiK1Sd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:33:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A99AB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669660285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGM2PS6waVZLkSGP61Ah74Ke9n+AqtE5b7AKkQ/DYGQ=;
        b=SpK5DcxFyx4vHbID1TahhQ3WfAX9TIbJxTWxOVKrW/UDTXNLhDv6Oe7nIdiUuk72YS1SD7
        eaQ8bM2VWVVQ4B8jA1ZLXwPxu34ml5Y3jH0YmwSDMY+5O4cPgMNSX/4GTM6BsVMBQWlLeM
        50K3d7oKsXcYt0hkiqWYclsX5T6lkcs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-nJGr7m6COBGpYIm-6jUaKA-1; Mon, 28 Nov 2022 13:31:23 -0500
X-MC-Unique: nJGr7m6COBGpYIm-6jUaKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2795855438;
        Mon, 28 Nov 2022 18:31:22 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.33.37.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 004C12166B2E;
        Mon, 28 Nov 2022 18:31:21 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v6 4/4] workqueue: Unbind kworkers before sending them to exit()
Date:   Mon, 28 Nov 2022 18:31:09 +0000
Message-Id: <20221128183109.446754-5-vschneid@redhat.com>
In-Reply-To: <20221128183109.446754-1-vschneid@redhat.com>
References: <20221128183109.446754-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been reported that isolated CPUs can suffer from interference due to
per-CPU kworkers waking up just to die.

A surge of workqueue activity during initial setup of a latency-sensitive
application (refresh_vm_stats() being one of the culprits) can cause extra
per-CPU kworkers to be spawned. Then, said latency-sensitive task can be
running merrily on an isolated CPU only to be interrupted sometime later by
a kworker marked for death (cf. IDLE_WORKER_TIMEOUT, 5 minutes after last
kworker activity).

Prevent this by affining kworkers to the wq_unbound_cpumask (which doesn't
contain isolated CPUs, cf. HK_TYPE_WQ) before waking them up after marking
them with WORKER_DIE.

Changing the affinity does require a sleepable context, leverage the newly
introduced pool->idle_cull_work to get that.

Remove dying workers from pool->workers and keep track of them in a
separate list. This intentionally prevents for_each_loop_worker() from
iterating over workers that are marked for death.

Rename destroy_worker() to set_working_dying() to better reflect its
effects and relationship with wake_dying_workers().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 70 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c8b1466a9c070..da6396f513102 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -179,6 +179,7 @@ struct worker_pool {
 
 	struct worker		*manager;	/* L: purely informational */
 	struct list_head	workers;	/* A: attached workers */
+	struct list_head        dying_workers;  /* A: workers about to die */
 	struct completion	*detach_completion; /* all workers detached */
 
 	struct ida		worker_ida;	/* worker IDs for task name */
@@ -1904,7 +1905,7 @@ static void worker_detach_from_pool(struct worker *worker)
 	list_del(&worker->node);
 	worker->pool = NULL;
 
-	if (list_empty(&pool->workers))
+	if (list_empty(&pool->workers) && list_empty(&pool->dying_workers))
 		detach_completion = pool->detach_completion;
 	mutex_unlock(&wq_pool_attach_mutex);
 
@@ -1993,21 +1994,44 @@ static void rebind_worker(struct worker *worker, struct worker_pool *pool)
 	WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
 }
 
+static void wake_dying_workers(struct list_head *cull_list)
+{
+	struct worker *worker, *tmp;
+
+	list_for_each_entry_safe(worker, tmp, cull_list, entry) {
+		list_del_init(&worker->entry);
+		unbind_worker(worker);
+		/*
+		 * If the worker was somehow already running, then it had to be
+		 * in pool->idle_list when set_worker_dying() happened or we
+		 * wouldn't have gotten here.
+		 *
+		 * Thus, the worker must either have observed the WORKER_DIE
+		 * flag, or have set its state to TASK_IDLE. Either way, the
+		 * below will be observed by the worker and is safe to do
+		 * outside of pool->lock.
+		 */
+		wake_up_process(worker->task);
+	}
+}
+
 /**
- * destroy_worker - destroy a workqueue worker
+ * set_worker_dying - Tag a worker for destruction
  * @worker: worker to be destroyed
+ * @list: transfer worker away from its pool->idle_list and into list
  *
- * Destroy @worker and adjust @pool stats accordingly.  The worker should
- * be idle.
+ * Tag @worker for destruction and adjust @pool stats accordingly.  The worker
+ * should be idle.
  *
  * CONTEXT:
  * raw_spin_lock_irq(pool->lock).
  */
-static void destroy_worker(struct worker *worker)
+static void set_worker_dying(struct worker *worker, struct list_head *list)
 {
 	struct worker_pool *pool = worker->pool;
 
 	lockdep_assert_held(&pool->lock);
+	lockdep_assert_held(&wq_pool_attach_mutex);
 
 	/* sanity check frenzy */
 	if (WARN_ON(worker->current_work) ||
@@ -2018,9 +2042,10 @@ static void destroy_worker(struct worker *worker)
 	pool->nr_workers--;
 	pool->nr_idle--;
 
-	list_del_init(&worker->entry);
 	worker->flags |= WORKER_DIE;
-	wake_up_process(worker->task);
+
+	list_move(&worker->entry, list);
+	list_move(&worker->node, &pool->dying_workers);
 }
 
 /*
@@ -2062,11 +2087,24 @@ static void idle_worker_timeout(struct timer_list *t)
 
 /*
  * idle_cull_fn - cull workers that have been idle for too long.
+ *
+ * We don't want to disturb isolated CPUs because of a pcpu kworker being
+ * culled, so this also resets worker affinity. This requires a sleepable
+ * context, hence the split between timer callback and work item.
  */
 static void idle_cull_fn(struct work_struct *work)
 {
 	struct worker_pool *pool = container_of(work, struct worker_pool, idle_cull_work);
+	struct list_head cull_list;
 
+	INIT_LIST_HEAD(&cull_list);
+	/*
+	 * Grabbing wq_pool_attach_mutex here ensures an already-running worker
+	 * cannot proceed beyong worker_detach_from_pool() in its self-destruct
+	 * path. This is required as a previously-preempted worker could run after
+	 * set_worker_dying() has happened but before wake_dying_workers() did.
+	 */
+	mutex_lock(&wq_pool_attach_mutex);
 	raw_spin_lock_irq(&pool->lock);
 
 	while (too_many_workers(pool)) {
@@ -2081,10 +2119,12 @@ static void idle_cull_fn(struct work_struct *work)
 			break;
 		}
 
-		destroy_worker(worker);
+		set_worker_dying(worker, &cull_list);
 	}
 
 	raw_spin_unlock_irq(&pool->lock);
+	wake_dying_workers(&cull_list);
+	mutex_unlock(&wq_pool_attach_mutex);
 }
 
 static void send_mayday(struct work_struct *work)
@@ -2448,12 +2488,12 @@ static int worker_thread(void *__worker)
 	/* am I supposed to die? */
 	if (unlikely(worker->flags & WORKER_DIE)) {
 		raw_spin_unlock_irq(&pool->lock);
-		WARN_ON_ONCE(!list_empty(&worker->entry));
 		set_pf_worker(false);
 
 		set_task_comm(worker->task, "kworker/dying");
 		ida_free(&pool->worker_ida, worker->id);
 		worker_detach_from_pool(worker);
+		WARN_ON_ONCE(!list_empty(&worker->entry));
 		kfree(worker);
 		return 0;
 	}
@@ -3527,6 +3567,7 @@ static int init_worker_pool(struct worker_pool *pool)
 	timer_setup(&pool->mayday_timer, pool_mayday_timeout, 0);
 
 	INIT_LIST_HEAD(&pool->workers);
+	INIT_LIST_HEAD(&pool->dying_workers);
 
 	ida_init(&pool->worker_ida);
 	INIT_HLIST_NODE(&pool->hash_node);
@@ -3627,8 +3668,11 @@ static bool wq_manager_inactive(struct worker_pool *pool)
 static void put_unbound_pool(struct worker_pool *pool)
 {
 	DECLARE_COMPLETION_ONSTACK(detach_completion);
+	struct list_head cull_list;
 	struct worker *worker;
 
+	INIT_LIST_HEAD(&cull_list);
+
 	lockdep_assert_held(&wq_pool_mutex);
 
 	if (--pool->refcnt)
@@ -3651,17 +3695,19 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * Because of how wq_manager_inactive() works, we will hold the
 	 * spinlock after a successful wait.
 	 */
+	mutex_lock(&wq_pool_attach_mutex);
 	rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
 			   TASK_UNINTERRUPTIBLE);
 	pool->flags |= POOL_MANAGER_ACTIVE;
 
 	while ((worker = first_idle_worker(pool)))
-		destroy_worker(worker);
+		set_worker_dying(worker, &cull_list);
 	WARN_ON(pool->nr_workers || pool->nr_idle);
 	raw_spin_unlock_irq(&pool->lock);
 
-	mutex_lock(&wq_pool_attach_mutex);
-	if (!list_empty(&pool->workers))
+	wake_dying_workers(&cull_list);
+
+	if (!list_empty(&pool->workers) || !list_empty(&pool->dying_workers))
 		pool->detach_completion = &detach_completion;
 	mutex_unlock(&wq_pool_attach_mutex);
 
-- 
2.31.1

