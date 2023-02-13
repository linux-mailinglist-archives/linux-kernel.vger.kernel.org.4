Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B08B695111
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjBMTuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjBMTtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46886BB87
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676317733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GznFzpuODdzkTxUTk9yUnyf2c6J4yJOQyX0ufIRGdKw=;
        b=gLmpvTwN7vI9koXveBz4zDv8x3/qmWPcz2u60+m7OQuOjV8btqgIsn7lZW3iSKdYJbw2W2
        bpnYwyLga7XhN8/wkuAfDBe/6RfYQhJdSobgoQyJikV1mT5A3JXOJPUFp+Dq7V8SIAU9Ci
        SDzHD+TeFWFLksJJ4eCLwTy5R9gxDG4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-y-5srHbKO1yjvKd7G90nNw-1; Mon, 13 Feb 2023 14:48:49 -0500
X-MC-Unique: y-5srHbKO1yjvKd7G90nNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 626C488B7A0;
        Mon, 13 Feb 2023 19:48:49 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C681C16022;
        Mon, 13 Feb 2023 19:48:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] locking/rwsem: Enable early rwsem writer lock handoff
Date:   Mon, 13 Feb 2023 14:48:31 -0500
Message-Id: <20230213194832.832256-2-longman@redhat.com>
In-Reply-To: <20230213194832.832256-1-longman@redhat.com>
References: <20230213194832.832256-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

For readers, setting the HANDOFF bit will disable writers from stealing
the lock. The actual handoff is done at rwsem_wake() time after taking
the wait_lock. There isn't much we need to improve here other than
setting the RWSEM_NONSPINNABLE bit in owner.

For writers, setting the HANDOFF bit does not guarantee that it can
acquire the rwsem successfully in a subsequent rwsem_try_write_lock()
after setting the bit there. A reader can come in and add a
RWSEM_READER_BIAS temporarily which can spoil the takeover of the rwsem
in rwsem_try_write_lock() leading to additional delay.

For mutex, lock handoff is done at unlock time as the owner value and
the handoff bit is in the same lock word and can be updated atomically.

That is the not case for rwsem which has a count value for locking and
a different owner value for storing lock owner. In addition, the handoff
processing differs depending on whether the first waiter is a writer or a
reader. We can only make that waiter type determination after acquiring
the wait lock. Together with the fact that the RWSEM_FLAG_HANDOFF bit
is stable while holding the wait_lock, the most convenient place to do
the early handoff is at rwsem_wake() where wait_lock has to be acquired
anyway. There isn't much additional cost in doing this check there while
increasing the chance that a lock handoff will be successful when the
writer wakes up.

Since a lot can happen between unlock time and after acquiring the
wait_lock in rwsem_wake(), we have to reconfirm the presence of the
handoff bit and the lock is free before doing the handoff.

Running a 96-thread rwsem locking test on a 96-thread x86-64 system,
the locking throughput increases slightly from 588 kops/s to 592 kops/s
with this change.

Kernel test robot also noticed a 19.3% improvement of
will-it-scale.per_thread_ops due to this commit [1].

[1] https://lore.kernel.org/lkml/202302122155.87699b56-oliver.sang@intel.com/

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 74 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acb5a50309a1..3936a5fe1229 100644
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
+		 * Since rwsem_mark_wake() will handle the handoff to readers
+		 * properly, we don't need to do anything extra for readers.
+		 * Early handoff processing will only be needed for writers.
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

