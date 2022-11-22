Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7F763449A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiKVTb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiKVTbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:31:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2231E91C39
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669145414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7U2dCc3qRrIxneK1dml4DuolDvzGGs0bA5uFiU/5J/w=;
        b=ZZ8Jrq+RhtbUkyOCVmBG1UsELTl6gC9ZgzEsGY+LgVM2vtM/MFMYoZdY64fY+m7uy0FUEK
        D8NnsnyHmvMJ3F2o7uD5bqT6+KN4QyxX6mDKhqZpyWnDtuB/4SWwIeaVHToGOQt27tJmI6
        J0DNi9vsXAEmVHgBdCQmQM3o6dTxxkw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-473-fdOSotJyN0iDnSdxJ8NFog-1; Tue, 22 Nov 2022 14:30:13 -0500
X-MC-Unique: fdOSotJyN0iDnSdxJ8NFog-1
Received: by mail-wm1-f71.google.com with SMTP id h9-20020a1c2109000000b003cfd37aec58so8516355wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7U2dCc3qRrIxneK1dml4DuolDvzGGs0bA5uFiU/5J/w=;
        b=b2l7l+6S7D9iLlBALUOicRmoqgyedzBuKma/rp80wDLWuEPxB2rZyDNNZJSlO2etxw
         k12Ux5Bnnh3CZrBa1lC2AnsMH5ILWoO1WgvyonbPR6RpBki6f6Uizp07Grwqc0SO4n98
         joa9ZdskA9y6vc8uuo+jRtAWDU1xKuGnOpst056EctecCImjMvLZj3NNJ/jP7Zks42sg
         jmzgENDMN5yu7Paf2U7d1DLlkqrS1MPMz5gLenE1egoS3rSGr7CspUbEyJXEj/EJDJZf
         geqo8+rOsFXffGs+cb73XInXX8J+SYX4fmaynj8YKbcasB+ajLIOdImtXwPgaXeIuDJL
         SwYg==
X-Gm-Message-State: ANoB5pkl1/aF6oEV7yhYosmWiGiEjwR7liRPGNloYn9XieCrAxC3Vaq2
        DN/wbVkg6KnY7c4WbSt5bjXA/v5HbM3x6zXRlbAdDl5FN0tCoTfUPcDA3+8hCVFonHHD49//hW4
        v/EIe9rEeaKqroiGSSS9leXWFTEeHCzSVXuWnZI5UEBGKvT+JtVsfgzixNOfSXAOz7I0NjtDU0g
        er
X-Received: by 2002:a05:600c:a10:b0:3cf:75f4:794a with SMTP id z16-20020a05600c0a1000b003cf75f4794amr21090175wmp.16.1669145411271;
        Tue, 22 Nov 2022 11:30:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7osyUiAQSmMBQVuh2+MsN7+fDCECdEmauhOPEFUYckw0AGY3iiS1oeg37UURWv4BuvhA05iA==
X-Received: by 2002:a05:600c:a10:b0:3cf:75f4:794a with SMTP id z16-20020a05600c0a1000b003cf75f4794amr21090155wmp.16.1669145411045;
        Tue, 22 Nov 2022 11:30:11 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id r14-20020adff10e000000b002366553eca7sm4173682wro.83.2022.11.22.11.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:30:10 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v5 4/5] workqueue: Convert the idle_timer to a timer + work_struct
Date:   Tue, 22 Nov 2022 19:29:36 +0000
Message-Id: <20221122192937.2386494-5-vschneid@redhat.com>
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

A later patch will require a sleepable context in the idle worker timeout
function. Converting worker_pool.idle_timer to a delayed_work gives us just
that, however this would imply turning all idle_timer expiries into
scheduler events (waking up a worker to handle the dwork).

Instead, implement a "custom dwork" where the timer callback does some
extra checks before queuing the associated work.

No change in functionality intended.

The new worker_pool.idle_cull_list is made ____cacheline_aligned to prevent
it from sitting over two cachelines.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 68 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4fc8085f3fe17..b744288c58a4b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -169,7 +169,12 @@ struct worker_pool {
 
 	struct list_head	idle_list;	/* L: list of idle workers */
 	struct timer_list	idle_timer;	/* L: worker idle timeout */
-	struct timer_list	mayday_timer;	/* L: SOS timer for workers */
+
+	struct list_head	idle_cull_list  /* L: list of idle workers to cull */
+	____cacheline_aligned;
+	struct work_struct      idle_cull_work; /* L: worker idle cleanup */
+
+	struct timer_list	mayday_timer;	  /* L: SOS timer for workers */
 
 	/* a workers is either on busy_hash or idle_list, or the manager */
 	DECLARE_HASHTABLE(busy_hash, BUSY_WORKER_HASH_ORDER);
@@ -1812,7 +1817,9 @@ static void worker_enter_idle(struct worker *worker)
 	/* idle_list is LIFO */
 	list_add(&worker->entry, &pool->idle_list);
 
-	if (worker_cull_count(pool) && !timer_pending(&pool->idle_timer))
+	if (worker_cull_count(pool) &&
+	    !timer_pending(&pool->idle_timer) &&
+	    !work_pending(&pool->idle_cull_work))
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
 
 	/* Sanity check nr_running. */
@@ -2025,13 +2032,27 @@ static void destroy_worker(struct worker *worker)
 	wake_up_process(worker->task);
 }
 
+/*
+ * idle_worker_timeout - check if some idle workers can now be deleted.
+ *
+ * The timer is armed in worker_enter_idle(). Note that it isn't disarmed in
+ * worker_leave_idle(), as a worker flicking between idle and active while its
+ * pool is at the worker_cull_count() tipping point would cause too much timer
+ * housekeeping overhead. Since IDLE_WORKER_TIMEOUT is long enough, we just let
+ * it expire and re-evaluate things from there.
+ */
 static void idle_worker_timeout(struct timer_list *t)
 {
 	struct worker_pool *pool = from_timer(pool, t, idle_timer);
+	unsigned int max_cull_cnt, cull_cnt;
+
+	if (work_pending(&pool->idle_cull_work))
+		return;
 
 	raw_spin_lock_irq(&pool->lock);
 
-	while (worker_cull_count(pool)) {
+	max_cull_cnt = worker_cull_count(pool);
+	for (cull_cnt = 0; cull_cnt < max_cull_cnt; cull_cnt++) {
 		struct worker *worker;
 		unsigned long expires;
 
@@ -2039,12 +2060,48 @@ static void idle_worker_timeout(struct timer_list *t)
 		worker = list_entry(pool->idle_list.prev, struct worker, entry);
 		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
 
+		/* All remaining entries will be younger than this */
 		if (time_before(jiffies, expires)) {
-			mod_timer(&pool->idle_timer, expires);
+			if (!cull_cnt)
+				mod_timer(&pool->idle_timer, expires);
 			break;
 		}
 
+		/*
+		 * Mark the idle worker ripe for culling.
+		 * If a preempted idle worker gets to run before the idle cull
+		 * handles it, it will just pop itself out of that list and
+		 * continue as normal.
+		 */
+		list_move(&worker->entry, &pool->idle_cull_list);
+	}
+	raw_spin_unlock_irq(&pool->lock);
+
+	if (cull_cnt)
+		queue_work(system_unbound_wq, &pool->idle_cull_work);
+}
+
+/*
+ * idle_cull_fn - cull workers that have been idle for too long.
+ */
+static void idle_cull_fn(struct work_struct *work)
+{
+	struct worker_pool *pool = container_of(work, struct worker_pool, idle_cull_work);
+	struct worker *worker, *tmp;
+
+	raw_spin_lock_irq(&pool->lock);
+
+	list_for_each_entry_safe(worker, tmp, &pool->idle_cull_list, entry)
 		destroy_worker(worker);
+
+	/* Re-arm the idle timer if necessary */
+	if (pool->nr_idle) {
+		unsigned long expires;
+
+		worker = list_entry(pool->idle_list.prev, struct worker, entry);
+		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
+		if (time_before(jiffies, expires))
+			mod_timer(&pool->idle_timer, expires);
 	}
 
 	raw_spin_unlock_irq(&pool->lock);
@@ -3482,9 +3539,11 @@ static int init_worker_pool(struct worker_pool *pool)
 	pool->watchdog_ts = jiffies;
 	INIT_LIST_HEAD(&pool->worklist);
 	INIT_LIST_HEAD(&pool->idle_list);
+	INIT_LIST_HEAD(&pool->idle_cull_list);
 	hash_init(pool->busy_hash);
 
 	timer_setup(&pool->idle_timer, idle_worker_timeout, TIMER_DEFERRABLE);
+	INIT_WORK(&pool->idle_cull_work, idle_cull_fn);
 
 	timer_setup(&pool->mayday_timer, pool_mayday_timeout, 0);
 
@@ -3632,6 +3691,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 
 	/* shut down the timers */
 	del_timer_sync(&pool->idle_timer);
+	cancel_work_sync(&pool->idle_cull_work);
 	del_timer_sync(&pool->mayday_timer);
 
 	/* RCU protected to allow dereferences from get_work_pool() */
-- 
2.31.1

