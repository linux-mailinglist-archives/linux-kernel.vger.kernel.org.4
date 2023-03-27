Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9F66CAFEA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjC0UZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjC0UZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D391835BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679948666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mu5ZzyYWSATBkbI4LlJA6D+0Mmfphw3RYNk8lrITOdU=;
        b=ZhbRkPnwLVzZfAqiSZ2OGAEZBygvWh4oPc0ylEpwEeTcSM+N6AtiexpMJSY8JObg3WrPiv
        RnbDssdPChiexyyFOhl/OQAh9lN0sIXHfbQwzQhg4bFJ0koFX9rke802pWS47zDF86mhWg
        c45I3n0ZKUPyiX37eAoZT3iK1QLCg7E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-N9bmmKYXPvKrIs6WEbuAqA-1; Mon, 27 Mar 2023 16:24:24 -0400
X-MC-Unique: N9bmmKYXPvKrIs6WEbuAqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35075280BF61;
        Mon, 27 Mar 2023 20:24:24 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED6652027040;
        Mon, 27 Mar 2023 20:24:23 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] locking/rwsem: Split out rwsem_reader_wake()
Date:   Mon, 27 Mar 2023 16:24:10 -0400
Message-Id: <20230327202413.1955856-6-longman@redhat.com>
In-Reply-To: <20230327202413.1955856-1-longman@redhat.com>
References: <20230327202413.1955856-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

To provide symmetry with rwsem_writer_wake().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem.c | 83 +++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 225e86326ea4..0bc262dc77fd 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -106,9 +106,9 @@
  * atomic_long_cmpxchg() will be used to obtain writer lock.
  *
  * There are three places where the lock handoff bit may be set or cleared.
- * 1) rwsem_mark_wake() for readers		-- set, clear
+ * 1) rwsem_reader_wake() for readers	-- set, clear
  * 2) rwsem_try_write_lock() for writers	-- set, clear
- * 3) rwsem_del_waiter()			-- clear
+ * 3) rwsem_del_waiter()		-- clear
  *
  * For all the above cases, wait_lock will be held. A writer must also
  * be the first one in the wait_list to be eligible for setting the handoff
@@ -377,7 +377,7 @@ rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
 /*
  * Remove a waiter from the wait_list and clear flags.
  *
- * Both rwsem_mark_wake() and rwsem_try_write_lock() contain a full 'copy' of
+ * Both rwsem_reader_wake() and rwsem_try_write_lock() contain a full 'copy' of
  * this function. Modify with care.
  *
  * Return: true if wait_list isn't empty and false otherwise
@@ -483,42 +483,15 @@ static void rwsem_writer_wake(struct rw_semaphore *sem,
 		rwsem_waiter_wake(waiter, wake_q);
 }
 
-/*
- * handle the lock release when processes blocked on it that can now run
- * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
- *   have been set.
- * - there must be someone on the queue
- * - the wait_lock must be held by the caller
- * - tasks are marked for wakeup, the caller must later invoke wake_up_q()
- *   to actually wakeup the blocked task(s) and drop the reference count,
- *   preferably when the wait_lock is released
- * - woken process blocks are discarded from the list after having task zeroed
- * - writers are only marked woken if downgrading is false
- *
- * Implies rwsem_del_waiter() for all woken readers.
- */
-static void rwsem_mark_wake(struct rw_semaphore *sem,
-			    enum rwsem_wake_type wake_type,
-			    struct wake_q_head *wake_q)
+static void rwsem_reader_wake(struct rw_semaphore *sem,
+			      enum rwsem_wake_type wake_type,
+			      struct rwsem_waiter *waiter,
+			      struct wake_q_head *wake_q)
 {
-	struct rwsem_waiter *waiter, *tmp;
 	long count, woken = 0, adjustment = 0;
+	struct rwsem_waiter *tmp;
 	struct list_head wlist;
 
-	lockdep_assert_held(&sem->wait_lock);
-
-	/*
-	 * Take a peek at the queue head waiter such that we can determine
-	 * the wakeup(s) to perform.
-	 */
-	waiter = rwsem_first_waiter(sem);
-
-	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
-		if (wake_type == RWSEM_WAKE_ANY)
-			rwsem_writer_wake(sem, waiter, wake_q);
-		return;
-	}
-
 	/*
 	 * No reader wakeup if there are too many of them already.
 	 */
@@ -634,6 +607,42 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		rwsem_waiter_wake(waiter, wake_q);
 }
 
+/*
+ * handle the lock release when processes blocked on it that can now run
+ * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
+ *   have been set.
+ * - there must be someone on the queue
+ * - the wait_lock must be held by the caller
+ * - tasks are marked for wakeup, the caller must later invoke wake_up_q()
+ *   to actually wakeup the blocked task(s) and drop the reference count,
+ *   preferably when the wait_lock is released
+ * - woken process blocks are discarded from the list after having task zeroed
+ * - writers are only marked woken if downgrading is false
+ *
+ * Implies rwsem_del_waiter() for all woken waiters.
+ */
+static void rwsem_mark_wake(struct rw_semaphore *sem,
+			    enum rwsem_wake_type wake_type,
+			    struct wake_q_head *wake_q)
+{
+	struct rwsem_waiter *waiter;
+
+	lockdep_assert_held(&sem->wait_lock);
+
+	/*
+	 * Take a peek at the queue head waiter such that we can determine
+	 * the wakeup(s) to perform.
+	 */
+	waiter = rwsem_first_waiter(sem);
+
+	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
+		if (wake_type == RWSEM_WAKE_ANY)
+			rwsem_writer_wake(sem, waiter, wake_q);
+	} else {
+		rwsem_reader_wake(sem, wake_type, waiter, wake_q);
+	}
+}
+
 /*
  * Remove a waiter and try to wake up other waiters in the wait queue
  * This function is called from the out_nolock path of both the reader and
@@ -1022,8 +1031,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 		if ((rcnt == 1) && (count & RWSEM_FLAG_WAITERS)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (!list_empty(&sem->wait_list))
-				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
-						&wake_q);
+				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED, &wake_q);
+
 			raw_spin_unlock_irq(&sem->wait_lock);
 			wake_up_q(&wake_q);
 		}
-- 
2.31.1

