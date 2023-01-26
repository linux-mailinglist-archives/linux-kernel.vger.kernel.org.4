Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1025C67C1DF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjAZAjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjAZAjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:39:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B380361D43
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674693457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iDEg1bL2Pd2FJi7M41wYv/wjVNxd/1xDBORr+4z5xPM=;
        b=Vjgi66tIw+/duS/QvkJ3hSHv6G+2JGaNqmN47dLpO6lr+mDZapRNrqiCzlO73AtV6B1XsE
        oA6Y5dqdaFh06Q2l00073VWXhU5zXzYRuOSOnTD9IDzFMrHgg201KUKx5Ia1kG6j/SWW0Y
        whtxEZp9EeA8tJy/HLm/6rEeMYJKwrk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-bHAFzgNdMyCxYjvsREhpiw-1; Wed, 25 Jan 2023 19:37:32 -0500
X-MC-Unique: bHAFzgNdMyCxYjvsREhpiw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16878101A521;
        Thu, 26 Jan 2023 00:37:32 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3E70492C14;
        Thu, 26 Jan 2023 00:37:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v7 4/4] locking/rwsem: Enable direct rwsem lock handoff
Date:   Wed, 25 Jan 2023 19:36:28 -0500
Message-Id: <20230126003628.365092-5-longman@redhat.com>
In-Reply-To: <20230126003628.365092-1-longman@redhat.com>
References: <20230126003628.365092-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock handoff provided in rwsem isn't a true handoff like that in
the mutex. Instead, it is more like a quiescent state where optimistic
spinning and lock stealing are disabled to make it easier for the first
waiter to acquire the lock.

For mutex, lock handoff is done at unlock time as the owner value and
the handoff bit is in the same lock word and can be updated atomically.

That is the not case for rwsem which has a count value for locking and
a different owner value for storing lock owner. In addition, the handoff
processing differs depending on whether the first waiter is a writer or
a reader. We can only make that waiter type determination after acquiring
the wait lock. Together with the fact that the RWSEM_FLAG_HANDOFF bit is
stable while holding the wait_lock, the most convenient place to do the
handoff is at rwsem_wake() where wait_lock has to be acquired anyway.

Since a lot can happen between unlock time and after acquiring the
wait_lock in rwsem_wake(), we have to reconfirm the presence of the
handoff bit and the lock is free before doing the handoff. Handing off to
a reader has already been done pretty well by rwsem_mark_wake(), we don't
need to do anything extra other than disabling optimistic spinning. For
writer, additional code is added to pass the lock ownership to it. The
waiter is removed from the wait queue and waiter->task is cleared in
this case to signal that handoff has happened. This is similar to what
rwsem_mark_wake() is doing to readers whether a handoff has happened
or not.

Running a 96-thread rwsem locking test on a 96-thread x86-64 system,
the locking throughput increases slightly from 588 kops/s to 592 kops/s
with this change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 74 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acb5a50309a1..2cf1e0bfdaa5 100644
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
@@ -430,6 +430,10 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 			 * Mark writer at the front of the queue for wakeup.
 			 * Until the task is actually later awoken later by
 			 * the caller, other writers are able to steal it.
+			 *
+			 * *Unless* HANDOFF is set, in which case only the
+			 * first waiter is allowed to take it.
+			 *
 			 * Readers, on the other hand, will block as they
 			 * will notice the queued writer.
 			 */
@@ -467,7 +471,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 					adjustment -= RWSEM_FLAG_HANDOFF;
 					lockevent_inc(rwsem_rlock_handoff);
 				}
+				/*
+				 * With HANDOFF set for reader, we must
+				 * terminate all spinning.
+				 */
 				waiter->handoff_set = true;
+				rwsem_set_nonspinnable(sem);
 			}
 
 			atomic_long_add(-adjustment, &sem->count);
@@ -609,6 +618,12 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 
 	lockdep_assert_held(&sem->wait_lock);
 
+	if (!waiter->task) {
+		/* Write lock handed off */
+		smp_acquire__after_ctrl_dep();
+		return true;
+	}
+
 	count = atomic_long_read(&sem->count);
 	do {
 		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
@@ -754,6 +769,10 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 	owner = rwsem_owner_flags(sem, &flags);
 	state = rwsem_owner_state(owner, flags);
+
+	if (owner == current)
+		return OWNER_NONSPINNABLE;	/* Handoff granted */
+
 	if (state != OWNER_WRITER)
 		return state;
 
@@ -844,7 +863,6 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		 * Try to acquire the lock
 		 */
 		taken = rwsem_try_write_lock_unqueued(sem);
-
 		if (taken)
 			break;
 
@@ -1168,21 +1186,23 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		 * without sleeping.
 		 */
 		if (waiter.handoff_set) {
-			enum owner_state owner_state;
-
-			owner_state = rwsem_spin_on_owner(sem);
-			if (owner_state == OWNER_NULL)
-				goto trylock_again;
+			rwsem_spin_on_owner(sem);
+			if (!READ_ONCE(waiter.task)) {
+				/* Write lock handed off */
+				smp_acquire__after_ctrl_dep();
+				set_current_state(TASK_RUNNING);
+				goto out;
+			}
 		}
 
 		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_writer);
 		set_current_state(state);
-trylock_again:
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
 	__set_current_state(TASK_RUNNING);
 	raw_spin_unlock_irq(&sem->wait_lock);
+out:
 	lockevent_inc(rwsem_wlock);
 	trace_contention_end(sem, 0);
 	return sem;
@@ -1190,6 +1210,11 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 out_nolock:
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
+	if (!waiter.task) {
+		smp_acquire__after_ctrl_dep();
+		raw_spin_unlock_irq(&sem->wait_lock);
+		goto out;
+	}
 	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
 	lockevent_inc(rwsem_wlock_fail);
 	trace_contention_end(sem, -EINTR);
@@ -1202,14 +1227,41 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
  */
 static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 {
-	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
+	unsigned long flags;
+	unsigned long count;
 
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
 
-	if (!list_empty(&sem->wait_list))
-		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+	if (list_empty(&sem->wait_list))
+		goto unlock_out;
+
+	/*
+	 * If the rwsem is free and handoff flag is set with wait_lock held,
+	 * no other CPUs can take an active lock.
+	 */
+	count = atomic_long_read(&sem->count);
+	if (!(count & RWSEM_LOCK_MASK) && (count & RWSEM_FLAG_HANDOFF)) {
+		/*
+		 * Since rwsem_mark_wake() will handle the handoff to reader
+		 * properly, we don't need to do anything extra for reader.
+		 * Special handoff processing will only be needed for writer.
+		 */
+		struct rwsem_waiter *waiter = rwsem_first_waiter(sem);
+		long adj = RWSEM_WRITER_LOCKED - RWSEM_FLAG_HANDOFF;
+
+		if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
+			atomic_long_set(&sem->owner, (long)waiter->task);
+			atomic_long_add(adj, &sem->count);
+			wake_q_add(&wake_q, waiter->task);
+			rwsem_del_waiter(sem, waiter);
+			waiter->task = NULL;	/* Signal the handoff */
+			goto unlock_out;
+		}
+	}
+	rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
+unlock_out:
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
 	wake_up_q(&wake_q);
 
-- 
2.31.1

