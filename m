Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EE465E18E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbjAEA0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjAEA0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:26:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A816950F50;
        Wed,  4 Jan 2023 16:24:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAF906185C;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC00C433EF;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878290;
        bh=VS7CzfrucTZq5lKAwKfv+JBikA9PozXDvQDOAqrBc+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5v1H8hxvIHVoAXudNisEdfAmk7CCcswplwyigcFl5Iyls+TsNFn+cRC0ivT/6gca
         xO6GmJB+eroJwEBbCMVO5LlqSN4W88CpNEi5vmgFC3EayDQG3sagne/KWAF8i9YymN
         A6VVOPyFbnkjnQjnuT8aVQ8VrJ22KdakoVC0Q1cBpxqDikMenmJ+1dqLr3jPz37+VV
         GUvGdj0rLTNoXcPgWZrm9ERL1hcxTBptGzvMxAFPwSogs03XfKsks8Z5cUHVSust4j
         +NbUTgS2iAsG3lH9oTEfzzMVN0YxCn27z1pH+yDrAhLrkOzjHjx55yXwqsyUiOVqao
         /awWtb/YBvDtQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DEEDD5C05CA; Wed,  4 Jan 2023 16:24:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/8] rcu: Refactor kvfree_call_rcu() and high-level helpers
Date:   Wed,  4 Jan 2023 16:24:41 -0800
Message-Id: <20230105002448.1768892-1-paulmck@kernel.org>
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

Currently a kvfree_call_rcu() takes an offset within a structure as
a second parameter, so a helper such as a kvfree_rcu_arg_2() has to
convert rcu_head and a freed ptr to an offset in order to pass it. That
leads to an extra conversion on macro entry.

Instead of converting, refactor the code in way that a pointer that has
to be freed is passed directly to the kvfree_call_rcu().

This patch does not make any functional change and is transparent to
all kvfree_rcu() users.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  5 ++---
 include/linux/rcutiny.h  | 12 ++++++------
 include/linux/rcutree.h  |  2 +-
 kernel/rcu/tiny.c        |  9 +++------
 kernel/rcu/tree.c        | 29 ++++++++++++-----------------
 5 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 03abf883a281b..f38d4469d7f30 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1011,8 +1011,7 @@ do {									\
 									\
 	if (___p) {									\
 		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
-		kvfree_call_rcu(&((___p)->rhf), (rcu_callback_t)(unsigned long)		\
-			(offsetof(typeof(*(ptr)), rhf)));				\
+		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));			\
 	}										\
 } while (0)
 
@@ -1021,7 +1020,7 @@ do {								\
 	typeof(ptr) ___p = (ptr);				\
 								\
 	if (___p)						\
-		kvfree_call_rcu(NULL, (rcu_callback_t) (___p));	\
+		kvfree_call_rcu(NULL, (void *) (___p));		\
 } while (0)
 
 /*
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 68f9070aa1110..7f17acf29dda7 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -98,25 +98,25 @@ static inline void synchronize_rcu_expedited(void)
  */
 extern void kvfree(const void *addr);
 
-static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+static inline void __kvfree_call_rcu(struct rcu_head *head, void *ptr)
 {
 	if (head) {
-		call_rcu(head, func);
+		call_rcu(head, (rcu_callback_t) ((void *) head - ptr));
 		return;
 	}
 
 	// kvfree_rcu(one_arg) call.
 	might_sleep();
 	synchronize_rcu();
-	kvfree((void *) func);
+	kvfree(ptr);
 }
 
 #ifdef CONFIG_KASAN_GENERIC
-void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 #else
-static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+static inline void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 {
-	__kvfree_call_rcu(head, func);
+	__kvfree_call_rcu(head, ptr);
 }
 #endif
 
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 4003bf6cfa1c2..56bccb5a8fdea 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -33,7 +33,7 @@ static inline void rcu_virt_note_context_switch(void)
 }
 
 void synchronize_rcu_expedited(void);
-void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 72913ce21258b..42f7589e51e09 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -246,15 +246,12 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
 EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 
 #ifdef CONFIG_KASAN_GENERIC
-void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 {
-	if (head) {
-		void *ptr = (void *) head - (unsigned long) func;
-
+	if (head)
 		kasan_record_aux_stack_noalloc(ptr);
-	}
 
-	__kvfree_call_rcu(head, func);
+	__kvfree_call_rcu(head, ptr);
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 #endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cf34a961821ad..7d222acd85bfd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3103,8 +3103,8 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * This list is named "Channel 3".
 	 */
 	for (; head; head = next) {
-		unsigned long offset = (unsigned long)head->func;
-		void *ptr = (void *)head - offset;
+		void *ptr = (void *) head->func;
+		unsigned long offset = (void *) head - ptr;
 
 		next = head->next;
 		debug_rcu_head_unqueue((struct rcu_head *)ptr);
@@ -3342,26 +3342,21 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
  * be free'd in workqueue context. This allows us to: batch requests together to
  * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
  */
-void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
 	bool success;
-	void *ptr;
 
-	if (head) {
-		ptr = (void *) head - (unsigned long) func;
-	} else {
-		/*
-		 * Please note there is a limitation for the head-less
-		 * variant, that is why there is a clear rule for such
-		 * objects: it can be used from might_sleep() context
-		 * only. For other places please embed an rcu_head to
-		 * your data.
-		 */
+	/*
+	 * Please note there is a limitation for the head-less
+	 * variant, that is why there is a clear rule for such
+	 * objects: it can be used from might_sleep() context
+	 * only. For other places please embed an rcu_head to
+	 * your data.
+	 */
+	if (!head)
 		might_sleep();
-		ptr = (unsigned long *) func;
-	}
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
@@ -3382,7 +3377,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 			// Inline if kvfree_rcu(one_arg) call.
 			goto unlock_return;
 
-		head->func = func;
+		head->func = ptr;
 		head->next = krcp->head;
 		krcp->head = head;
 		success = true;
-- 
2.31.1.189.g2e36527f23

