Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8677765E189
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbjAEA0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbjAEA0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:26:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE124FD70;
        Wed,  4 Jan 2023 16:24:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E74D261890;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386EBC433F1;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878290;
        bh=eyuMolz7jRjywZspmtRUtHr0uH/ZCSEztevsvhEK960=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUYIXIZmmQrjC53VvOnPo8Dx0Onugn4spzyTZp9jWjZ4jlWVjX2fkf1SyTzyQwTiN
         igY6a0u3zn4v6V6l3dJEMtbCYk8zyRnBpDiXZ5AXWYFmpBGoZoAcO4Fnz2lEexjjSb
         mwv3y7UxZ6AewUICz2SD5mlyZM89fWkb2l6I+oE+YTx9Ttv55wK50ZmjqVfgrHIbAV
         HMmvTtw4pwCeP5b08DEc08BUFb5dLseMq4LAHrPtqLzfGLwdV4Mnfi+bZqYfToNXkf
         GDfe0VW4KlKcl0Yz/xFws6KKHfhf8S+xPNwmMCxjj8ymC/eduZSFlQ9h+dESn863wj
         1UqwotAmTspWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E536D5C08E5; Wed,  4 Jan 2023 16:24:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/8] rcu/kvfree: Move bulk/list reclaim to separate functions
Date:   Wed,  4 Jan 2023 16:24:43 -0800
Message-Id: <20230105002448.1768892-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002441.GA1768817@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002441.GA1768817@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kvfree_rcu() code maintains lists of pages of pointers, but also a
singly linked list, with the latter being used when memory allocation
fails.  Traversal of these two types of lists is currently open coded.
This commit simplifies the code by providing kvfree_rcu_bulk() and
kvfree_rcu_list() functions, respectively, to traverse these two types
of lists.  This patch does not introduce any functional change.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 114 ++++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4088b34ce9610..839e617f6c370 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3029,6 +3029,65 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 	return freed;
 }
 
+static void
+kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
+	struct kvfree_rcu_bulk_data *bnode, int idx)
+{
+	unsigned long flags;
+	int i;
+
+	debug_rcu_bhead_unqueue(bnode);
+
+	rcu_lock_acquire(&rcu_callback_map);
+	if (idx == 0) { // kmalloc() / kfree().
+		trace_rcu_invoke_kfree_bulk_callback(
+			rcu_state.name, bnode->nr_records,
+			bnode->records);
+
+		kfree_bulk(bnode->nr_records, bnode->records);
+	} else { // vmalloc() / vfree().
+		for (i = 0; i < bnode->nr_records; i++) {
+			trace_rcu_invoke_kvfree_callback(
+				rcu_state.name, bnode->records[i], 0);
+
+			vfree(bnode->records[i]);
+		}
+	}
+	rcu_lock_release(&rcu_callback_map);
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	if (put_cached_bnode(krcp, bnode))
+		bnode = NULL;
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+	if (bnode)
+		free_page((unsigned long) bnode);
+
+	cond_resched_tasks_rcu_qs();
+}
+
+static void
+kvfree_rcu_list(struct rcu_head *head)
+{
+	struct rcu_head *next;
+
+	for (; head; head = next) {
+		void *ptr = (void *) head->func;
+		unsigned long offset = (void *) head - ptr;
+
+		next = head->next;
+		debug_rcu_head_unqueue((struct rcu_head *)ptr);
+		rcu_lock_acquire(&rcu_callback_map);
+		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
+
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
+			kvfree(ptr);
+
+		rcu_lock_release(&rcu_callback_map);
+		cond_resched_tasks_rcu_qs();
+	}
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bulk_head_free or ->head_free.
@@ -3038,10 +3097,10 @@ static void kfree_rcu_work(struct work_struct *work)
 	unsigned long flags;
 	struct kvfree_rcu_bulk_data *bnode, *n;
 	struct list_head bulk_head[FREE_N_CHANNELS];
-	struct rcu_head *head, *next;
+	struct rcu_head *head;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
-	int i, j;
+	int i;
 
 	krwp = container_of(to_rcu_work(work),
 			    struct kfree_rcu_cpu_work, rcu_work);
@@ -3058,38 +3117,9 @@ static void kfree_rcu_work(struct work_struct *work)
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	// Handle the first two channels.
-	for (i = 0; i < FREE_N_CHANNELS; i++) {
-		list_for_each_entry_safe(bnode, n, &bulk_head[i], list) {
-			debug_rcu_bhead_unqueue(bnode);
-
-			rcu_lock_acquire(&rcu_callback_map);
-			if (i == 0) { // kmalloc() / kfree().
-				trace_rcu_invoke_kfree_bulk_callback(
-					rcu_state.name, bnode->nr_records,
-					bnode->records);
-
-				kfree_bulk(bnode->nr_records, bnode->records);
-			} else { // vmalloc() / vfree().
-				for (j = 0; j < bnode->nr_records; j++) {
-					trace_rcu_invoke_kvfree_callback(
-						rcu_state.name, bnode->records[j], 0);
-
-					vfree(bnode->records[j]);
-				}
-			}
-			rcu_lock_release(&rcu_callback_map);
-
-			raw_spin_lock_irqsave(&krcp->lock, flags);
-			if (put_cached_bnode(krcp, bnode))
-				bnode = NULL;
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
-			if (bnode)
-				free_page((unsigned long) bnode);
-
-			cond_resched_tasks_rcu_qs();
-		}
-	}
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		list_for_each_entry_safe(bnode, n, &bulk_head[i], list)
+			kvfree_rcu_bulk(krcp, bnode, i);
 
 	/*
 	 * This is used when the "bulk" path can not be used for the
@@ -3098,21 +3128,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * queued on a linked list through their rcu_head structures.
 	 * This list is named "Channel 3".
 	 */
-	for (; head; head = next) {
-		void *ptr = (void *) head->func;
-		unsigned long offset = (void *) head - ptr;
-
-		next = head->next;
-		debug_rcu_head_unqueue((struct rcu_head *)ptr);
-		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
-
-		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
-			kvfree(ptr);
-
-		rcu_lock_release(&rcu_callback_map);
-		cond_resched_tasks_rcu_qs();
-	}
+	kvfree_rcu_list(head);
 }
 
 static bool
-- 
2.31.1.189.g2e36527f23

