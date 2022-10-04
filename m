Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3995B5F4626
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJDPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJDPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE545AC6B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664895973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4UKkux0NQcy21BxYM6cWK9bW5qHoR8CiY5xTdRWFuE=;
        b=Kv6tAvrGiGL0LL7uGisjKN4e2kLaHUo80rjsFlnhwlDPHIdQT6n0cY7GX7uZRFD1HPLzAx
        +flK+Ii3wI7D2Qa++o4fdEBl7foEcIlFBcfxVsBHl6z/ciYqbw5FHoQa0X0KsrKy0PI/c3
        RmGudmoavV6Qa11x2bv7GtpNYbnTEvQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-134-Bl9_KzjGPLqEdFuMu4HnTw-1; Tue, 04 Oct 2022 11:06:11 -0400
X-MC-Unique: Bl9_KzjGPLqEdFuMu4HnTw-1
Received: by mail-wm1-f70.google.com with SMTP id c3-20020a7bc843000000b003b486fc6a40so3657625wml.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 08:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k4UKkux0NQcy21BxYM6cWK9bW5qHoR8CiY5xTdRWFuE=;
        b=C9/IVD81SZdEKHb2ALYMAu38EkUUY4Q7mNVdeTO8m1V6vuUSztp9UK6OWfQV6hehxU
         4loqQG+7AfF1f4nvAMTxgmMhHDlHvJlqtVr8hSV1W8oqqMBa3G0+TsYxCigV9EyE2YjJ
         hhtNM9u9MVEqWcwrYSNaB6xohNGnRe1o7XXBll9Ri+jadrvye2ZnIwDxR/DED60GXG2J
         0MzItM74E4i3ETbMqMsWoyH77x5gpkWwwLZ/r79jDX3TF9tW38gKIjrrFqbQJkxyKWdG
         l3Y1vCBWqYQZikGRoW1SHoBsPANzzkuFVthUr+X7RcBJpLuxzAm5AUwLm2+CyRpEJBJe
         xNCw==
X-Gm-Message-State: ACrzQf1tS1orEO1Wj0qQ9ethZLP5Od9L/9JG7Jf3DLNLcEoZ7fo1br2m
        RvYu4/ypYd4bAsdtVTf8o8P1U4HgjN7kKlZjGvcQdnniErzC3hCPqAa9p/5gsYNXBj2efxXswlB
        Z30pm/f1vHb5WZW5/lRyUInS4u/O87MqHGD8d9m2VsuGqhQc+JSLohPFEwlugzN+99p/Ikr5XW2
        gP
X-Received: by 2002:adf:ce8b:0:b0:22c:dea6:6ea with SMTP id r11-20020adfce8b000000b0022cdea606eamr13800690wrn.387.1664895967262;
        Tue, 04 Oct 2022 08:06:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM599KGtFtBeX+d651Az58J2VHYEBgjX0z4viWSsXNccX/RLb9BcoArIrwRvw92M+AXscRNM6Q==
X-Received: by 2002:adf:ce8b:0:b0:22c:dea6:6ea with SMTP id r11-20020adfce8b000000b0022cdea606eamr13800645wrn.387.1664895966752;
        Tue, 04 Oct 2022 08:06:06 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003b4ac05a8a4sm25777717wmo.27.2022.10.04.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:06:05 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v4 4/4] workqueue: Unbind workers before sending them to exit()
Date:   Tue,  4 Oct 2022 16:05:21 +0100
Message-Id: <20221004150521.822266-5-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221004150521.822266-1-vschneid@redhat.com>
References: <20221004150521.822266-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
introduced pool->idle_reaper_work to get that.
Remove dying workers from pool->workers and keep track of them in a
separate list. This intentionally prevents for_each_loop_worker() from
iterating over workers that are marked for death.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 80 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 436b1dbdf9ff..714db7df7105 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -177,6 +177,7 @@ struct worker_pool {
 
 	struct worker		*manager;	/* L: purely informational */
 	struct list_head	workers;	/* A: attached workers */
+	struct list_head        dying_workers;  /* A: workers about to die */
 	struct completion	*detach_completion; /* all workers detached */
 
 	struct ida		worker_ida;	/* worker IDs for task name */
@@ -1902,7 +1903,7 @@ static void worker_detach_from_pool(struct worker *worker)
 	list_del(&worker->node);
 	worker->pool = NULL;
 
-	if (list_empty(&pool->workers))
+	if (list_empty(&pool->workers) && list_empty(&pool->dying_workers))
 		detach_completion = pool->detach_completion;
 	mutex_unlock(&wq_pool_attach_mutex);
 
@@ -1991,9 +1992,31 @@ static void rebind_worker(struct worker *worker, struct worker_pool *pool)
 	WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
 }
 
+static void reap_workers(struct list_head *reaplist)
+{
+	struct worker *worker, *tmp;
+
+	list_for_each_entry_safe(worker, tmp, reaplist, entry) {
+		list_del_init(&worker->entry);
+		unbind_worker(worker);
+		/*
+		 * If the worker was somehow already running, then it had to be
+		 * in pool->idle_list when destroy_worker() happened or we
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
  * destroy_worker - destroy a workqueue worker
  * @worker: worker to be destroyed
+ * @list: transfer worker away from its pool->idle_list and into list
  *
  * Destroy @worker and adjust @pool stats accordingly.  The worker should
  * be idle.
@@ -2001,11 +2024,12 @@ static void rebind_worker(struct worker *worker, struct worker_pool *pool)
  * CONTEXT:
  * raw_spin_lock_irq(pool->lock).
  */
-static void destroy_worker(struct worker *worker)
+static void destroy_worker(struct worker *worker, struct list_head *list)
 {
 	struct worker_pool *pool = worker->pool;
 
 	lockdep_assert_held(&pool->lock);
+	lockdep_assert_held(&wq_pool_attach_mutex);
 
 	/* sanity check frenzy */
 	if (WARN_ON(worker->current_work) ||
@@ -2016,21 +2040,50 @@ static void destroy_worker(struct worker *worker)
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
  * idle_reaper_fn - reap workers that have been idle for too long.
  *
+ * Unbinding marked-for-destruction workers requires a sleepable context, as
+ * changing a task's affinity is not an atomic operation, and we don't want
+ * to disturb isolated CPUs IDLE_WORKER_TIMEOUT in the future just for a kworker
+ * to do_exit().
+ *
+ * Percpu kworkers should meet the conditions for the affinity change to not
+ * block (not migration-disabled and not running), but there is no *hard*
+ * guarantee that they are not running when we get here.
+ *
  * The delayed_work is only ever modified under raw_spin_lock_irq(pool->lock).
  */
 static void idle_reaper_fn(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct worker_pool *pool = container_of(dwork, struct worker_pool, idle_reaper_work);
+	struct list_head reaplist;
 
+	INIT_LIST_HEAD(&reaplist);
+
+	/*
+	 * Unlikely as it may be, a to-be-reaped worker could run after
+	 * idle_reaper_fn()::destroy_worker() has happened but before
+	 * idle_reaper_fn()::reap_workers() (consider a worker that stays
+	 * preempted after setting itself in the idle list, or before removing
+	 * itself from it).
+	 *
+	 * WORKER_DIE would be set in worker->flags, so it would be able to
+	 * kfree(worker) and head out to do_exit(), which wouldn't be nice to
+	 * the idle reaper.
+	 *
+	 * Grabbing wq_pool_attach_mutex here ensures an already-running worker
+	 * won't go beyond worker_detach_from_pool() in its self-destruct path
+	 * (WORKER_DIE is set with wq_pool_attach_mutex set).
+	 */
+	mutex_lock(&wq_pool_attach_mutex);
 	raw_spin_lock_irq(&pool->lock);
 
 	while (too_many_workers(pool)) {
@@ -2055,10 +2108,11 @@ static void idle_reaper_fn(struct work_struct *work)
 			break;
 		}
 
-		destroy_worker(worker);
+		destroy_worker(worker, &reaplist);
 	}
-
 	raw_spin_unlock_irq(&pool->lock);
+	reap_workers(&reaplist);
+	mutex_unlock(&wq_pool_attach_mutex);
 }
 
 static void send_mayday(struct work_struct *work)
@@ -2422,12 +2476,12 @@ static int worker_thread(void *__worker)
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
@@ -3500,6 +3554,7 @@ static int init_worker_pool(struct worker_pool *pool)
 	timer_setup(&pool->mayday_timer, pool_mayday_timeout, 0);
 
 	INIT_LIST_HEAD(&pool->workers);
+	INIT_LIST_HEAD(&pool->dying_workers);
 
 	ida_init(&pool->worker_ida);
 	INIT_HLIST_NODE(&pool->hash_node);
@@ -3600,8 +3655,11 @@ static bool wq_manager_inactive(struct worker_pool *pool)
 static void put_unbound_pool(struct worker_pool *pool)
 {
 	DECLARE_COMPLETION_ONSTACK(detach_completion);
+	struct list_head reaplist;
 	struct worker *worker;
 
+	INIT_LIST_HEAD(&reaplist);
+
 	lockdep_assert_held(&wq_pool_mutex);
 
 	if (--pool->refcnt)
@@ -3624,17 +3682,19 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * Because of how wq_manager_inactive() works, we will hold the
 	 * spinlock after a successful wait.
 	 */
+	mutex_lock(&wq_pool_attach_mutex);
 	rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
 			   TASK_UNINTERRUPTIBLE);
 	pool->flags |= POOL_MANAGER_ACTIVE;
 
 	while ((worker = first_idle_worker(pool)))
-		destroy_worker(worker);
+		destroy_worker(worker, &reaplist);
 	WARN_ON(pool->nr_workers || pool->nr_idle);
 	raw_spin_unlock_irq(&pool->lock);
 
-	mutex_lock(&wq_pool_attach_mutex);
-	if (!list_empty(&pool->workers))
+	reap_workers(&reaplist);
+
+	if (!list_empty(&pool->workers) || !list_empty(&pool->dying_workers))
 		pool->detach_completion = &detach_completion;
 	mutex_unlock(&wq_pool_attach_mutex);
 
-- 
2.31.1

