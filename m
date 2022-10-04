Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8F85F4625
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJDPGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJDPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7443F5AC7E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664895970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50a5iJfaLzCpaDTsLjUsvQCTTc/RwKOyv7j+iKLCP1I=;
        b=Jyxqkcz5QUHxSCeDTKkz5TB/JyXO5IVWk1qrQCNu1QeipPvjjQNwBj46/gSij/phf8nLwU
        NIrHQAB/urRQXEGwzujihgBr2oRQewLR1nZsmcSKG2UGjdZb4Y+J1P5pwTdJqpfLVAFAix
        St7JeHYpajirerJ5v+2zxG17/kBusjM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-132-tWiqOhYdOzehMoMx07iM0A-1; Tue, 04 Oct 2022 11:06:08 -0400
X-MC-Unique: tWiqOhYdOzehMoMx07iM0A-1
Received: by mail-wm1-f70.google.com with SMTP id k21-20020a7bc415000000b003b4fac53006so3657388wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 08:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=50a5iJfaLzCpaDTsLjUsvQCTTc/RwKOyv7j+iKLCP1I=;
        b=L4dVB5JhTQMfZLTdCq7coGMAZ/hk8mDfAOFWu/EjJ55dRToWG6q0OSMholJhF20Qjm
         2/Ik2N9n5EQ/vsgwW4VUT8wPRCRO44yauHVnYO7AsPo+RQt6Sf5KOiATb4dMAQhQE1/3
         RoXVS1/7eSY6iXk8o/YYx+OhIJCMibN2mm0gUqLKvBVtdxcYuneywI8vy608O+mc5zgu
         JIwn6nhgUsJrfSs2OxaPh7RB9Lo9lLxcuoWrs674jRRfto0PaLSBV3rWQFIDWh6X7BGl
         vS/0gp3KobwdAAO3j6ubR2beZuRxFjTJTHvGCfuxwY/yISK3X18UW1sj5x29DqtyUOkq
         oDzg==
X-Gm-Message-State: ACrzQf3KtpC0g4hmjN6BS7OM70JGoafkYW+9PcW6DFU94vpfiWdj/hkM
        rtzMp4jq8GPNlrzXEHE1CrenBsv0dJFVz5KS+MsPC/5D539adUI13kVxX37Q+g3n3BuQfCl28ko
        i0S9Td3WP24anPPqbx4khEmfdyVAPQCwj8hrakVSUayTnBkQ6NIXQ1KqZcfktOqMdW6ylFL7F8y
        1n
X-Received: by 2002:adf:ea42:0:b0:22e:3ca8:c269 with SMTP id j2-20020adfea42000000b0022e3ca8c269mr6794887wrn.186.1664895965207;
        Tue, 04 Oct 2022 08:06:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Sej5aFLRJSLK7KLakiwAMiKggyVEshUxMOLh7XFtNT0VvWRKkUmbqJsfGnll/JBJ/I8yTog==
X-Received: by 2002:adf:ea42:0:b0:22e:3ca8:c269 with SMTP id j2-20020adfea42000000b0022e3ca8c269mr6794847wrn.186.1664895964815;
        Tue, 04 Oct 2022 08:06:04 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003b4ac05a8a4sm25777717wmo.27.2022.10.04.08.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:06:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v4 3/4] workqueue: Convert the idle_timer to a delayed_work
Date:   Tue,  4 Oct 2022 16:05:20 +0100
Message-Id: <20221004150521.822266-4-vschneid@redhat.com>
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

A later patch will require a sleepable context in the idle worker timeout
function. Converting worker_pool.idle_timer to a delayed_work gives us just
that.

One caveat is that we need to be careful about re-queuing the dwork from
its callback function. Lai expressed concerns about overtly violating
documented locking rules, but extra locking is required around delaying the
dwork, else a worker thread adding itself to the idle_list might push the
dwork further back (IDLE_WORKER_TIMEOUT) than the work callback would (next
idle worker expiry).

No change in functionality intended.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8185a42848c5..436b1dbdf9ff 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -167,9 +167,9 @@ struct worker_pool {
 	int			nr_workers;	/* L: total number of workers */
 	int			nr_idle;	/* L: currently idle workers */
 
-	struct list_head	idle_list;	/* L: list of idle workers */
-	struct timer_list	idle_timer;	/* L: worker idle timeout */
-	struct timer_list	mayday_timer;	/* L: SOS timer for workers */
+	struct list_head	idle_list;	  /* L: list of idle workers */
+	struct delayed_work     idle_reaper_work; /* L: worker idle timeout */
+	struct timer_list	mayday_timer;	  /* L: SOS timer for workers */
 
 	/* a workers is either on busy_hash or idle_list, or the manager */
 	DECLARE_HASHTABLE(busy_hash, BUSY_WORKER_HASH_ORDER);
@@ -1806,8 +1806,10 @@ static void worker_enter_idle(struct worker *worker)
 	/* idle_list is LIFO */
 	list_add(&worker->entry, &pool->idle_list);
 
-	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
-		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
+	if (too_many_workers(pool) && !delayed_work_pending(&pool->idle_reaper_work))
+		mod_delayed_work(system_unbound_wq,
+				 &pool->idle_reaper_work,
+				 IDLE_WORKER_TIMEOUT);
 
 	/* Sanity check nr_running. */
 	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);
@@ -2019,22 +2021,37 @@ static void destroy_worker(struct worker *worker)
 	wake_up_process(worker->task);
 }
 
-static void idle_worker_timeout(struct timer_list *t)
+/*
+ * idle_reaper_fn - reap workers that have been idle for too long.
+ *
+ * The delayed_work is only ever modified under raw_spin_lock_irq(pool->lock).
+ */
+static void idle_reaper_fn(struct work_struct *work)
 {
-	struct worker_pool *pool = from_timer(pool, t, idle_timer);
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct worker_pool *pool = container_of(dwork, struct worker_pool, idle_reaper_work);
 
 	raw_spin_lock_irq(&pool->lock);
 
 	while (too_many_workers(pool)) {
 		struct worker *worker;
 		unsigned long expires;
+		unsigned long now = jiffies;
 
-		/* idle_list is kept in LIFO order, check the last one */
+		/* idle_list is kept in LIFO order, check the oldest entry */
 		worker = list_entry(pool->idle_list.prev, struct worker, entry);
 		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
 
-		if (time_before(jiffies, expires)) {
-			mod_timer(&pool->idle_timer, expires);
+		/*
+		 * Careful: queueing a work item from here can and will cause a
+		 * self-deadlock when dealing with an unbound pool. However,
+		 * here the delay *cannot* be zero, so the queuing will
+		 * happen in the timer callback.
+		 */
+		if (time_before(now, expires)) {
+			mod_delayed_work(system_unbound_wq,
+					 &pool->idle_reaper_work,
+					 expires - now);
 			break;
 		}
 
@@ -3478,7 +3495,7 @@ static int init_worker_pool(struct worker_pool *pool)
 	INIT_LIST_HEAD(&pool->idle_list);
 	hash_init(pool->busy_hash);
 
-	timer_setup(&pool->idle_timer, idle_worker_timeout, TIMER_DEFERRABLE);
+	INIT_DEFERRABLE_WORK(&pool->idle_reaper_work, idle_reaper_fn);
 
 	timer_setup(&pool->mayday_timer, pool_mayday_timeout, 0);
 
@@ -3625,7 +3642,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 		wait_for_completion(pool->detach_completion);
 
 	/* shut down the timers */
-	del_timer_sync(&pool->idle_timer);
+	cancel_delayed_work_sync(&pool->idle_reaper_work);
 	del_timer_sync(&pool->mayday_timer);
 
 	/* RCU protected to allow dereferences from get_work_pool() */
-- 
2.31.1

