Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966E964C8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiLNMJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiLNMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:09:12 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5BF252BB;
        Wed, 14 Dec 2022 04:06:35 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id b2so43966423eja.7;
        Wed, 14 Dec 2022 04:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGHrcvs5+OP3ZPeuQyDZLjj/ME4Z3YSiejlbgxIfAXQ=;
        b=EMtD07JGB7T+sh9g4yTXyb73+hzn6wq1orwr1MJXO92XmsAilPiIvvsJEmPvuGoTZ7
         u8ikJCECJQGSbuKuH7FS99JefZ6JMuOXMspcs6macLK9Kj2VuFl2qoAuWdSJbsG0jzD2
         SAV16hA+Ee3z3jRPprY3PFzRqjwz2fP9P28IJyrdrfepta/EVs1Lvj2hErbxqHdxmO+f
         iVzDy6y4p3fxlY1SjRXQ1yOi75UWUy0FudtHoaG0IvCD6whMceSMHXOdqTOwHp2jYBQt
         4yWqCzT8oPCkCPVnCaT0tOeuZOtqW12+uvEGWlUaXjR9SZUKhPZ4YbcOCNW5OXr3Zhsi
         JqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGHrcvs5+OP3ZPeuQyDZLjj/ME4Z3YSiejlbgxIfAXQ=;
        b=nx1Wf5UiSmMAdYAwSQh8z6sAvWfE0vi6+nPtxkp/9XXMDDfzKVqzYhxfOZKNco1WEd
         kByWuBPUrJzhv/q9UEkV2JtM6gUmGMv47JLRgHxqIxRme4t63V7rwM6DH04tRF+9t5/U
         fypG/fg9x7g90f7Pkkus7wKLnoItMxPPDK+JGKGcVilRhD6CsvBwuhURbKcpEoL3SnL7
         H3XEmYL0cRdihWQB0Qkza5FfJMA+n0u1dMSakQT2a3mo+9LZ0BvfCtFraC2MQNEblX28
         1ucmtK4Mno2N0kSt4Nre6puXBEDhN11xcY+8uZwFfMbalOgKrW8T3mjUl91vVZkXacCv
         axMA==
X-Gm-Message-State: ANoB5pldHuuGAgt3pM8rLOHwfOpw0hVhHm3YjX9kdHJfaNe7G67hXMiS
        MjQtzpGhgObkVmQUhgmVamJmI0FDi5E=
X-Google-Smtp-Source: AA0mqf7LsyELz1xplUzkgtkZLXZkbJTwGNz7woYc6+BugkDJX2tPkzEI8bqMtS0iG0qJJjwmoHdtZw==
X-Received: by 2002:a17:906:3694:b0:78d:f454:3762 with SMTP id a20-20020a170906369400b0078df4543762mr8307359ejc.5.1671019593473;
        Wed, 14 Dec 2022 04:06:33 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906305100b007c0b28b85c5sm5669875ejd.138.2022.12.14.04.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 04:06:32 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/2] rcu/kvfree: Carefully reset number of objects in krcp
Date:   Wed, 14 Dec 2022 13:06:29 +0100
Message-Id: <20221214120630.379527-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem. A schedule_delayed_monitor_work() relays on the
number of pointers queued into krcp. Based on that number
and threshold the work is rearmed with different delayed
intervals, i.e. sooner or later.

There are three pipes where pointers can be placed. When
any pipe is offloaded the krcp->count counter is set to
zero - what is wrong. Because another pipes might not be
empty.

Fix it by maintaining a counter individually per a pipe.
In order to get a number of objects per a krcp introduce
a krc_count() helper.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d155f2594317..312cb0dee117 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2785,7 +2785,8 @@ struct kfree_rcu_cpu_work {
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @initialized: The @rcu_work fields have been initialized
- * @count: Number of objects for which GP not started
+ * @head_count: Number of objects in rcu_head singular list
+ * @bulk_count: Number of objects in bulk-list
  * @bkvcache:
  *	A simple cache list that contains objects for reuse purpose.
  *	In order to save some per-cpu space the list is singular.
@@ -2803,13 +2804,19 @@ struct kfree_rcu_cpu_work {
  * the interactions with the slab allocators.
  */
 struct kfree_rcu_cpu {
+	// Objects queued on a linked list
+	// through their rcu_head structures.
 	struct rcu_head *head;
+	atomic_t head_count;
+
+	// Objects queued on a bulk-list.
 	struct list_head bulk_head[FREE_N_CHANNELS];
+	atomic_t bulk_count[FREE_N_CHANNELS];
+
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
 	bool initialized;
-	int count;
 
 	struct delayed_work page_cache_work;
 	atomic_t backoff_page_cache_fill;
@@ -3032,12 +3039,23 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 	return !!READ_ONCE(krcp->head);
 }
 
+static int krc_count(struct kfree_rcu_cpu *krcp)
+{
+	int sum = atomic_read(&krcp->head_count);
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		sum += atomic_read(&krcp->bulk_count[i]);
+
+	return sum;
+}
+
 static void
 schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 {
 	long delay, delay_left;
 
-	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
+	delay = krc_count(krcp) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
 	if (delayed_work_pending(&krcp->monitor_work)) {
 		delay_left = krcp->monitor_work.timer.expires - jiffies;
 		if (delay < delay_left)
@@ -3075,8 +3093,10 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// Channel 1 corresponds to the SLAB-pointer bulk path.
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
-				if (list_empty(&krwp->bulk_head_free[j]))
+				if (list_empty(&krwp->bulk_head_free[j])) {
 					list_replace_init(&krcp->bulk_head[j], &krwp->bulk_head_free[j]);
+					atomic_set(&krcp->bulk_count[j], 0);
+				}
 			}
 
 			// Channel 3 corresponds to both SLAB and vmalloc
@@ -3084,6 +3104,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
 				WRITE_ONCE(krcp->head, NULL);
+				atomic_set(&krcp->head_count, 0);
 
 				// Take a snapshot for this krwp. Please note no more
 				// any objects can be added to attached head_free channel
@@ -3091,8 +3112,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
 				krwp->head_free_gp_snap = get_state_synchronize_rcu();
 			}
 
-			WRITE_ONCE(krcp->count, 0);
-
 			// One work is per one batch, so there are three
 			// "free channels", the batch can handle. It can
 			// be that the work is in the pending state when
@@ -3229,6 +3248,8 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	// Finally insert and update the GP for this page.
 	bnode->records[bnode->nr_records++] = ptr;
 	bnode->gp_snap = get_state_synchronize_rcu();
+	atomic_inc(&(*krcp)->bulk_count[idx]);
+
 	return true;
 }
 
@@ -3282,11 +3303,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 		head->func = ptr;
 		head->next = krcp->head;
 		WRITE_ONCE(krcp->head, head);
+		atomic_inc(&krcp->head_count);
 		success = true;
 	}
 
-	WRITE_ONCE(krcp->count, krcp->count + 1);
-
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
 		schedule_delayed_monitor_work(krcp);
@@ -3317,7 +3337,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		count += READ_ONCE(krcp->count);
+		count += krc_count(krcp);
 		count += READ_ONCE(krcp->nr_bkv_objs);
 		atomic_set(&krcp->backoff_page_cache_fill, 1);
 	}
@@ -3334,7 +3354,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		int count;
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		count = krcp->count;
+		count = krc_count(krcp);
 		count += drain_page_cache(krcp);
 		kfree_rcu_monitor(&krcp->monitor_work.work);
 
-- 
2.30.2

