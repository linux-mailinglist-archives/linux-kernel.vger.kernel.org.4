Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54660CF78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiJYOqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiJYOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:46:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98FF188126;
        Tue, 25 Oct 2022 07:46:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y14so13075922ejd.9;
        Tue, 25 Oct 2022 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bv2yciqWXVf1nawsif5m+jnHjZDrY4BaG8l2aHPj3u0=;
        b=T3VrzCl2VUwTA1hQpT3Lg3Yn/FYN0GtoetEJy3NhGdEUFJAX9EAsZFI7wtsXHEgVqb
         2g5ujVKzErcjJBtPS/juOCBapHRuJPmElWNaH5oM0oOoH6keDIXVSsinX5ul4L0kKQWp
         2YVfMQKEhY5L5OETUDnXlTefSVOzRwCTcT/ll4cqNSg2PZUJjHsU3NmaCqScVtsdnwmJ
         SaN1M4c6pOnpwHMv5YBYbm76yq/rc1VcjXoUMY2gzfxI7yfd44ToqqjNrgPfwHYRG1v5
         iBNzBziYcLVuSeUOAp8x6dJGL+7D0sZGhgzyvva07pIy3eJJGwUqsydmn1ZBZljU1i2K
         igNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bv2yciqWXVf1nawsif5m+jnHjZDrY4BaG8l2aHPj3u0=;
        b=OkH/wI8CpUwOim05fgeU5OISXgEMb8ClVDcyw6WoIkh0WRyLk2QZYQuSK2KsHsZ9VK
         xe91y0r8VjxlphfkWrI4HmHlf7RDSWJPsAAx3YI/27YNdCk3RKooTfdnWfmZVbWDP65s
         IelyMU/niKgXbOeJXFCf5qxZ70q5AM4L2venSavAyqIj0VDX7nQC3X3cGrnNC7aRF7X7
         m1+vuz97+UPkJ6PAfmDAcK48SbSfV+koN647ACy2s4mNmUn4mcLbHNmZj/Otqzc+wxjr
         TzBbNMK9XpQtbFVmqYUaZQOI2apUU6hCGJct0PRYwX1Q59YdtDk7x/nuu+et3rdFenc6
         Jt6g==
X-Gm-Message-State: ACrzQf1U8q3hxBAHicpRyXUGqoinyYwR7s+nNhqNcZBv3cJ9GCOAQNjF
        ptXjDHn/ICdZs0WYShY7TX8juyn3n9U=
X-Google-Smtp-Source: AMsMyM4I9d5rImEGae4mCaZYkgtxaTJAsRanxYoDI91cG4h3UrV/Zj0KrVKp3w+t2q47uH4lDyZXlQ==
X-Received: by 2002:a17:906:7315:b0:7ab:8542:559c with SMTP id di21-20020a170906731500b007ab8542559cmr4973622ejc.639.1666709177096;
        Tue, 25 Oct 2022 07:46:17 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709067e4200b007a8de84ce36sm1474505ejr.206.2022.10.25.07.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:46:16 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/1] rcu: Refactor kvfree_call_rcu() and high-level helpers
Date:   Tue, 25 Oct 2022 16:46:12 +0200
Message-Id: <20221025144612.506951-1-urezki@gmail.com>
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

Currently a kvfree_call_rcu() takes an offset within a
structure as a second parameter, so a helper such as a
kvfree_rcu_arg_2() has to convert rcu_head and a freed
ptr to an offset in order to pass it. That leads to an
extra conversion on macro entry.

Instead of converting, refactor the code in way that a
pointer that has to be freed is passed directly to the
kvfree_call_rcu().

This patch does not make any functional change and is
transparent to all kvfree_rcu() users.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h |  5 ++---
 include/linux/rcutiny.h  | 12 ++++++------
 include/linux/rcutree.h  |  2 +-
 kernel/rcu/tiny.c        |  9 +++------
 kernel/rcu/tree.c        | 29 ++++++++++++-----------------
 5 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 08605ce7379d..cbd34058fff1 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -985,8 +985,7 @@ do {									\
 									\
 	if (___p) {									\
 		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
-		kvfree_call_rcu(&((___p)->rhf), (rcu_callback_t)(unsigned long)		\
-			(offsetof(typeof(*(ptr)), rhf)));				\
+		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));			\
 	}										\
 } while (0)
 
@@ -995,7 +994,7 @@ do {								\
 	typeof(ptr) ___p = (ptr);				\
 								\
 	if (___p)						\
-		kvfree_call_rcu(NULL, (rcu_callback_t) (___p));	\
+		kvfree_call_rcu(NULL, (void *) (___p));		\
 } while (0)
 
 /*
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 768196a5f39d..9623c039964c 100644
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
index 5efb51486e8a..e37a0747a8b2 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -33,7 +33,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
 }
 
 void synchronize_rcu_expedited(void);
-void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index a33a8d4942c3..6c9496d08669 100644
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
index 0ca21ac0f064..9fea2aff87a1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3068,8 +3068,8 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * This list is named "Channel 3".
 	 */
 	for (; head; head = next) {
-		unsigned long offset = (unsigned long)head->func;
-		void *ptr = (void *)head - offset;
+		void *ptr = (void *) head->func;
+		unsigned long offset = (void *) head - ptr;
 
 		next = head->next;
 		debug_rcu_head_unqueue((struct rcu_head *)ptr);
@@ -3307,26 +3307,21 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
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
@@ -3347,7 +3342,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 			// Inline if kvfree_rcu(one_arg) call.
 			goto unlock_return;
 
-		head->func = func;
+		head->func = ptr;
 		head->next = krcp->head;
 		krcp->head = head;
 		success = true;
-- 
2.30.2

