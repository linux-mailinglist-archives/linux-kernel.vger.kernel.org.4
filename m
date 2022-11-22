Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8ED63449B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiKVTbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiKVTbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:31:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7085964A3B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669145416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqWXx4B31Pn7PRAztrkQHi3QWAEH1+l9z4s87lcuEGU=;
        b=eXePOJfHHrZcd/3iEtscmaRl3MuCUbaOdoVPiBz4tNnO4LD6G0N3kEor/m+kNImOdkeJDQ
        d8cgL0H4nMpbxukbssANVh3SeP3yhghyf/YqsUgRHYb7gJg2vMPe86ZMaFlj7XmaaZWtRY
        apHBO37iVVKo9IAe4jiK67ADPVt3NzA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-299-g8mLuvuzMXesy8YiCCE_fw-1; Tue, 22 Nov 2022 14:30:15 -0500
X-MC-Unique: g8mLuvuzMXesy8YiCCE_fw-1
Received: by mail-wm1-f71.google.com with SMTP id m34-20020a05600c3b2200b003cf549cb32bso11467119wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqWXx4B31Pn7PRAztrkQHi3QWAEH1+l9z4s87lcuEGU=;
        b=RGIcXdzoMxvCZZl4Xx1n0Gbm1Kiw52Y4jzYVzz2lDwdN/hsb2JP9wcJCXksOIC32xu
         ST8klSak6ktylcUUIhxnmTIBj3dQvQIgxKX2KVtqvI43WS92m6BNqF12gkmGES/Nb/zX
         kuC15t3yvaOESD2S1yUuEIszRxVnkBKlosO17ANmTkzPgcwjTwyhxcCzKo1yYEHH9QPw
         D/CcosJONHKwVjHgshDSDb/QFKsTnf2YUji+9A0IckJpaO04ewN3CPr73ZqYL44M/I3v
         XCvkastWIMcwsjRXCK8EbnWivUk1KUZJUNdVijsS/KKe4Nfqn6PFe7Kshc1rahnUkSiW
         +UXw==
X-Gm-Message-State: ANoB5pm9YdVLVeTltpc1H01wYYllE5KVRq3xWQGi3AYw+R8pZb9lFJo9
        ENqnZpQ/ZHG47wWU2XGwEyzQcJ9FTTnSy6UVfBh87+DczAwDSUE3PqlS5SlGxPnWUJ8Jq9updbP
        x83se9diXCQS5SvNegjmjGetumV8V9BhasmXwwiSrW5bY3AYC2cahYMvgiUR/RbG3AE6DC14+yA
        4G
X-Received: by 2002:a05:600c:3501:b0:3c7:4f0:77b3 with SMTP id h1-20020a05600c350100b003c704f077b3mr4308575wmq.93.1669145413312;
        Tue, 22 Nov 2022 11:30:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf43O8Cp/aTfJLAYEJCRrTIhJMzcaz2yadOUQGr+5Lg1rn6eTdTPuRoLyPMhKDGrpXHwrJG0BA==
X-Received: by 2002:a05:600c:3501:b0:3c7:4f0:77b3 with SMTP id h1-20020a05600c350100b003c704f077b3mr4308554wmq.93.1669145413058;
        Tue, 22 Nov 2022 11:30:13 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id r14-20020adff10e000000b002366553eca7sm4173682wro.83.2022.11.22.11.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:30:12 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v5 5/5] workqueue: Unbind kworkers before sending them to exit()
Date:   Tue, 22 Nov 2022 19:29:37 +0000
Message-Id: <20221122192937.2386494-6-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221122192937.2386494-1-vschneid@redhat.com>
References: <20221122192937.2386494-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index b744288c58a4b..8ce3b63851e95 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -182,6 +182,7 @@ struct worker_pool {
 
 	struct worker		*manager;	/* L: purely informational */
 	struct list_head	workers;	/* A: attached workers */
+	struct list_head        dying_workers;  /* A: workers about to die */
 	struct completion	*detach_completion; /* all workers detached */
 
 	struct ida		worker_ida;	/* worker IDs for task name */
@@ -1913,7 +1914,7 @@ static void worker_detach_from_pool(struct worker *worker)
 	list_del(&worker->node);
 	worker->pool = NULL;
 
-	if (list_empty(&pool->workers))
+	if (list_empty(&pool->workers) && list_empty(&pool->dying_workers))
 		detach_completion = pool->detach_completion;
 	mutex_unlock(&wq_pool_attach_mutex);
 
@@ -2002,21 +2003,44 @@ static void rebind_worker(struct worker *worker, struct worker_pool *pool)
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
@@ -2027,9 +2051,10 @@ static void destroy_worker(struct worker *worker)
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
@@ -2083,16 +2108,29 @@ static void idle_worker_timeout(struct timer_list *t)
 
 /*
  * idle_cull_fn - cull workers that have been idle for too long.
+ *
+ * We don't want to disturbed isolated CPUs because of a pcpu kworker being
+ * culled, so this also resets worker affinity. This requires a sleepable
+ * context, hence the split between timer callback and work item.
  */
 static void idle_cull_fn(struct work_struct *work)
 {
 	struct worker_pool *pool = container_of(work, struct worker_pool, idle_cull_work);
 	struct worker *worker, *tmp;
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
 
 	list_for_each_entry_safe(worker, tmp, &pool->idle_cull_list, entry)
-		destroy_worker(worker);
+		set_worker_dying(worker, &cull_list);
 
 	/* Re-arm the idle timer if necessary */
 	if (pool->nr_idle) {
@@ -2105,6 +2143,8 @@ static void idle_cull_fn(struct work_struct *work)
 	}
 
 	raw_spin_unlock_irq(&pool->lock);
+	wake_dying_workers(&cull_list);
+	mutex_unlock(&wq_pool_attach_mutex);
 }
 
 static void send_mayday(struct work_struct *work)
@@ -2468,12 +2508,12 @@ static int worker_thread(void *__worker)
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
@@ -3548,6 +3588,7 @@ static int init_worker_pool(struct worker_pool *pool)
 	timer_setup(&pool->mayday_timer, pool_mayday_timeout, 0);
 
 	INIT_LIST_HEAD(&pool->workers);
+	INIT_LIST_HEAD(&pool->dying_workers);
 
 	ida_init(&pool->worker_ida);
 	INIT_HLIST_NODE(&pool->hash_node);
@@ -3648,8 +3689,11 @@ static bool wq_manager_inactive(struct worker_pool *pool)
 static void put_unbound_pool(struct worker_pool *pool)
 {
 	DECLARE_COMPLETION_ONSTACK(detach_completion);
+	struct list_head cull_list;
 	struct worker *worker;
 
+	INIT_LIST_HEAD(&cull_list);
+
 	lockdep_assert_held(&wq_pool_mutex);
 
 	if (--pool->refcnt)
@@ -3672,17 +3716,19 @@ static void put_unbound_pool(struct worker_pool *pool)
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

