Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB46CAFED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjC0UZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjC0UZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8520E35BF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679948666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GFELJIylOd6FzPoG34U6948e0UYJqjaUeBOiP9UwiQ4=;
        b=Ow0E5O2P3Pkez/Dp5it3kfMaBAOOWpNNDIEnYltUmQLOfg1oXdsRUk7Qg+1oez4XIw91Ia
        a0kRmPCACod6Tepd2su8pkrtwKDyO9N7pMIW0ll062rzMehqUMYBPOoJGgNTaWD6JH/tBC
        qTmCOxz9jkCPDrT+5TdhbSqsBUwOFic=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-t-BH6Cm-N6KWvahZmI8YrA-1; Mon, 27 Mar 2023 16:24:23 -0400
X-MC-Unique: t-BH6Cm-N6KWvahZmI8YrA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCB4638123B2;
        Mon, 27 Mar 2023 20:24:22 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89521202701F;
        Mon, 27 Mar 2023 20:24:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/8] locking/rwsem: Minor code refactoring in rwsem_mark_wake()
Date:   Mon, 27 Mar 2023 16:24:06 -0400
Message-Id: <20230327202413.1955856-2-longman@redhat.com>
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

Rename "oldcount" to "count" as it is not always old count value.
Also make some minor code refactoring to reduce indentation. There is
no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230216210933.1169097-2-longman@redhat.com
---
 kernel/locking/rwsem.c | 44 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acb5a50309a1..e589f69793df 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -40,7 +40,7 @@
  *
  * When the rwsem is reader-owned and a spinning writer has timed out,
  * the nonspinnable bit will be set to disable optimistic spinning.
-
+ *
  * When a writer acquires a rwsem, it puts its task_struct pointer
  * into the owner field. It is cleared after an unlock.
  *
@@ -413,7 +413,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 			    struct wake_q_head *wake_q)
 {
 	struct rwsem_waiter *waiter, *tmp;
-	long oldcount, woken = 0, adjustment = 0;
+	long count, woken = 0, adjustment = 0;
 	struct list_head wlist;
 
 	lockdep_assert_held(&sem->wait_lock);
@@ -424,22 +424,23 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	 */
 	waiter = rwsem_first_waiter(sem);
 
-	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
-		if (wake_type == RWSEM_WAKE_ANY) {
-			/*
-			 * Mark writer at the front of the queue for wakeup.
-			 * Until the task is actually later awoken later by
-			 * the caller, other writers are able to steal it.
-			 * Readers, on the other hand, will block as they
-			 * will notice the queued writer.
-			 */
-			wake_q_add(wake_q, waiter->task);
-			lockevent_inc(rwsem_wake_writer);
-		}
+	if (waiter->type != RWSEM_WAITING_FOR_WRITE)
+		goto wake_readers;
 
-		return;
+	if (wake_type == RWSEM_WAKE_ANY) {
+		/*
+		 * Mark writer at the front of the queue for wakeup.
+		 * Until the task is actually later awoken later by
+		 * the caller, other writers are able to steal it.
+		 * Readers, on the other hand, will block as they
+		 * will notice the queued writer.
+		 */
+		wake_q_add(wake_q, waiter->task);
+		lockevent_inc(rwsem_wake_writer);
 	}
+	return;
 
+wake_readers:
 	/*
 	 * No reader wakeup if there are too many of them already.
 	 */
@@ -455,15 +456,15 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		struct task_struct *owner;
 
 		adjustment = RWSEM_READER_BIAS;
-		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
-		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
+		count = atomic_long_fetch_add(adjustment, &sem->count);
+		if (unlikely(count & RWSEM_WRITER_MASK)) {
 			/*
 			 * When we've been waiting "too" long (for writers
 			 * to give up the lock), request a HANDOFF to
 			 * force the issue.
 			 */
 			if (time_after(jiffies, waiter->timeout)) {
-				if (!(oldcount & RWSEM_FLAG_HANDOFF)) {
+				if (!(count & RWSEM_FLAG_HANDOFF)) {
 					adjustment -= RWSEM_FLAG_HANDOFF;
 					lockevent_inc(rwsem_rlock_handoff);
 				}
@@ -524,21 +525,21 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	adjustment = woken * RWSEM_READER_BIAS - adjustment;
 	lockevent_cond_inc(rwsem_wake_reader, woken);
 
-	oldcount = atomic_long_read(&sem->count);
+	count = atomic_long_read(&sem->count);
 	if (list_empty(&sem->wait_list)) {
 		/*
 		 * Combined with list_move_tail() above, this implies
 		 * rwsem_del_waiter().
 		 */
 		adjustment -= RWSEM_FLAG_WAITERS;
-		if (oldcount & RWSEM_FLAG_HANDOFF)
+		if (count & RWSEM_FLAG_HANDOFF)
 			adjustment -= RWSEM_FLAG_HANDOFF;
 	} else if (woken) {
 		/*
 		 * When we've woken a reader, we no longer need to force
 		 * writers to give up the lock and we can clear HANDOFF.
 		 */
-		if (oldcount & RWSEM_FLAG_HANDOFF)
+		if (count & RWSEM_FLAG_HANDOFF)
 			adjustment -= RWSEM_FLAG_HANDOFF;
 	}
 
@@ -844,7 +845,6 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		 * Try to acquire the lock
 		 */
 		taken = rwsem_try_write_lock_unqueued(sem);
-
 		if (taken)
 			break;
 
-- 
2.31.1

