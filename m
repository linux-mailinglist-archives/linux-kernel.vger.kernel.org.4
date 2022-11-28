Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE06863B16A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiK1Se0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiK1Sd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:33:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61168274
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669660286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBeA7STGfam5IOKxD+wB1RjgRxQP91bo13x/HX7w5mQ=;
        b=ecnWwGyomCgz+xuQUlohCqXMHG7Ex9vSOD/QgQDYPdCkHOxXLU59P5aVgqprI8/bT1dOr4
        g3MsTHvg1+OAxDwaiKxX0G6GOumOFp39uYH598sowPKkeGyzly+Ayoz7P/8wHXg1lHV6j7
        dgEAIt94vXNWxG09J/9+a8B4pdEg8IM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-UVzXAoVYOQ6S6tCp3ERLqA-1; Mon, 28 Nov 2022 13:31:22 -0500
X-MC-Unique: UVzXAoVYOQ6S6tCp3ERLqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2E35800186;
        Mon, 28 Nov 2022 18:31:21 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.33.37.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C436E2166B2E;
        Mon, 28 Nov 2022 18:31:20 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v6 3/4] workqueue: Convert the idle_timer to a timer + work_struct
Date:   Mon, 28 Nov 2022 18:31:08 +0000
Message-Id: <20221128183109.446754-4-vschneid@redhat.com>
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

A later patch will require a sleepable context in the idle worker timeout
function. Converting worker_pool.idle_timer to a delayed_work gives us just
that, however this would imply turning all idle_timer expiries into
scheduler events (waking up a worker to handle the dwork).

Instead, implement a "custom dwork" where the timer callback does some
extra checks before queuing the associated work.

No change in functionality intended.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 51 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8185a42848c50..c8b1466a9c070 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -169,7 +169,9 @@ struct worker_pool {
 
 	struct list_head	idle_list;	/* L: list of idle workers */
 	struct timer_list	idle_timer;	/* L: worker idle timeout */
-	struct timer_list	mayday_timer;	/* L: SOS timer for workers */
+	struct work_struct      idle_cull_work; /* L: worker idle cleanup */
+
+	struct timer_list	mayday_timer;	  /* L: SOS timer for workers */
 
 	/* a workers is either on busy_hash or idle_list, or the manager */
 	DECLARE_HASHTABLE(busy_hash, BUSY_WORKER_HASH_ORDER);
@@ -1806,7 +1808,9 @@ static void worker_enter_idle(struct worker *worker)
 	/* idle_list is LIFO */
 	list_add(&worker->entry, &pool->idle_list);
 
-	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
+	if (too_many_workers(pool) &&
+	    !timer_pending(&pool->idle_timer) &&
+	    !work_pending(&pool->idle_cull_work))
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
 
 	/* Sanity check nr_running. */
@@ -2019,17 +2023,56 @@ static void destroy_worker(struct worker *worker)
 	wake_up_process(worker->task);
 }
 
+/*
+ * idle_worker_timeout - check if some idle workers can now be deleted.
+ *
+ * The timer is armed in worker_enter_idle(). Note that it isn't disarmed in
+ * worker_leave_idle(), as a worker flicking between idle and active while its
+ * pool is at the too_many_workers() tipping point would cause too much timer
+ * housekeeping overhead. Since IDLE_WORKER_TIMEOUT is long enough, we just let
+ * it expire and re-evaluate things from there.
+ */
 static void idle_worker_timeout(struct timer_list *t)
 {
 	struct worker_pool *pool = from_timer(pool, t, idle_timer);
+	bool do_cull = false;
+
+	if (work_pending(&pool->idle_cull_work))
+		return;
 
 	raw_spin_lock_irq(&pool->lock);
 
-	while (too_many_workers(pool)) {
+	if (too_many_workers(pool)) {
 		struct worker *worker;
 		unsigned long expires;
 
 		/* idle_list is kept in LIFO order, check the last one */
+		worker = list_entry(pool->idle_list.prev, struct worker, entry);
+		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
+		do_cull = !time_before(jiffies, expires);
+
+		if (!do_cull)
+			mod_timer(&pool->idle_timer, expires);
+	}
+	raw_spin_unlock_irq(&pool->lock);
+
+	if (do_cull)
+		queue_work(system_unbound_wq, &pool->idle_cull_work);
+}
+
+/*
+ * idle_cull_fn - cull workers that have been idle for too long.
+ */
+static void idle_cull_fn(struct work_struct *work)
+{
+	struct worker_pool *pool = container_of(work, struct worker_pool, idle_cull_work);
+
+	raw_spin_lock_irq(&pool->lock);
+
+	while (too_many_workers(pool)) {
+		struct worker *worker;
+		unsigned long expires;
+
 		worker = list_entry(pool->idle_list.prev, struct worker, entry);
 		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
 
@@ -3479,6 +3522,7 @@ static int init_worker_pool(struct worker_pool *pool)
 	hash_init(pool->busy_hash);
 
 	timer_setup(&pool->idle_timer, idle_worker_timeout, TIMER_DEFERRABLE);
+	INIT_WORK(&pool->idle_cull_work, idle_cull_fn);
 
 	timer_setup(&pool->mayday_timer, pool_mayday_timeout, 0);
 
@@ -3626,6 +3670,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 
 	/* shut down the timers */
 	del_timer_sync(&pool->idle_timer);
+	cancel_work_sync(&pool->idle_cull_work);
 	del_timer_sync(&pool->mayday_timer);
 
 	/* RCU protected to allow dereferences from get_work_pool() */
-- 
2.31.1

