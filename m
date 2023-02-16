Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14763699EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjBPVKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjBPVKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:10:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C400E2BF28
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676581790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEzH5Zj7yh9QZtg0PJSYZ6nzi6eSZlPlfr6VnAN6HTg=;
        b=VQ9TdMQKLKQzoF0LmKYRS/dfqvw0YfNLre0+r+8kd8kOkhcidBsHGoeFTjZg+aktYlX5uq
        W1YCgXs0YJo+d4s3hETbNtUK2T/zosYR+nwss37m4aewirU/AlHTqpMUYU/pf2DVlb6tm2
        NHUvzt2giK/ejbh8c+aQqJ+r74OyiVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-i5-PaZ1rMJiPEq6thjgeKA-1; Thu, 16 Feb 2023 16:09:46 -0500
X-MC-Unique: i5-PaZ1rMJiPEq6thjgeKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2788A101A521;
        Thu, 16 Feb 2023 21:09:46 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1F2C51FF;
        Thu, 16 Feb 2023 21:09:45 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/3] locking/rwsem: Enable early rwsem writer lock handoff
Date:   Thu, 16 Feb 2023 16:09:32 -0500
Message-Id: <20230216210933.1169097-3-longman@redhat.com>
In-Reply-To: <20230216210933.1169097-1-longman@redhat.com>
References: <20230216210933.1169097-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
is stable while holding the wait_lock, the most convenient place to
do the early handoff is at rwsem_mark_wake() where wait_lock has to be
acquired anyway.

There isn't much additional cost in doing this check and early handoff
in rwsem_mark_wake() while increasing the chance that a lock handoff
will be successful when the HANDOFF setting writer wakes up without
even the need to take the wait_lock at all. Note that if early handoff
fails to happen in rwsem_mark_wake(), a late handoff can still happen
when the awoken writer calls rwsem_try_write_lock().

Kernel test robot noticed a 19.3% improvement of
will-it-scale.per_thread_ops in an earlier version of this commit [1].

[1] https://lore.kernel.org/lkml/202302122155.87699b56-oliver.sang@intel.com/

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem.c            | 71 +++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 97fb6f3f840a..fd80f5828f24 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -67,3 +67,4 @@ LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
 LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
+LOCK_EVENT(rwsem_wlock_ehandoff) /* # of write lock early handoffs	*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index e589f69793df..fc3961ceabe8 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -412,8 +412,9 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 			    enum rwsem_wake_type wake_type,
 			    struct wake_q_head *wake_q)
 {
+	long count = atomic_long_read(&sem->count);
 	struct rwsem_waiter *waiter, *tmp;
-	long count, woken = 0, adjustment = 0;
+	long woken = 0, adjustment = 0;
 	struct list_head wlist;
 
 	lockdep_assert_held(&sem->wait_lock);
@@ -432,19 +433,39 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		 * Mark writer at the front of the queue for wakeup.
 		 * Until the task is actually later awoken later by
 		 * the caller, other writers are able to steal it.
+		 *
+		 * *Unless* HANDOFF is set, in which case only the
+		 * first waiter is allowed to take it.
+		 *
 		 * Readers, on the other hand, will block as they
 		 * will notice the queued writer.
 		 */
 		wake_q_add(wake_q, waiter->task);
 		lockevent_inc(rwsem_wake_writer);
+
+		if ((count & RWSEM_LOCK_MASK) || !(count & RWSEM_FLAG_HANDOFF))
+			return;
+
+		/*
+		 * If the rwsem is free and handoff flag is set with wait_lock
+		 * held, no other CPUs can take an active lock. We can do an
+		 * early handoff.
+		 */
+		adjustment = RWSEM_WRITER_LOCKED - RWSEM_FLAG_HANDOFF;
+		atomic_long_set(&sem->owner, (long)waiter->task);
+		waiter->task = NULL;
+		atomic_long_add(adjustment, &sem->count);
+		rwsem_del_waiter(sem, waiter);
+		lockevent_inc(rwsem_wlock_ehandoff);
 	}
 	return;
 
 wake_readers:
 	/*
-	 * No reader wakeup if there are too many of them already.
+	 * No reader wakeup if there are too many of them already or
+	 * something wrong happens.
 	 */
-	if (unlikely(atomic_long_read(&sem->count) < 0))
+	if (unlikely(count < 0))
 		return;
 
 	/*
@@ -468,7 +489,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
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
@@ -610,6 +636,12 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 
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
@@ -755,6 +787,10 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 	owner = rwsem_owner_flags(sem, &flags);
 	state = rwsem_owner_state(owner, flags);
+
+	if (owner == current)
+		return OWNER_NONSPINNABLE;	/* Handoff granted */
+
 	if (state != OWNER_WRITER)
 		return state;
 
@@ -1164,32 +1200,51 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		 * the lock, attempt to spin on owner to accelerate lock
 		 * transfer. If the previous owner is a on-cpu writer and it
 		 * has just released the lock, OWNER_NULL will be returned.
-		 * In this case, we attempt to acquire the lock again
-		 * without sleeping.
+		 * In this case, the waker may be in the process of early
+		 * lock handoff. Use the wait_lock to synchronize with that
+		 * before checking for handoff.
 		 */
 		if (waiter.handoff_set) {
 			enum owner_state owner_state;
 
 			owner_state = rwsem_spin_on_owner(sem);
-			if (owner_state == OWNER_NULL)
-				goto trylock_again;
+			if ((owner_state == OWNER_NULL) &&
+			    READ_ONCE(waiter.task)) {
+				raw_spin_lock_irq(&sem->wait_lock);
+				raw_spin_unlock_irq(&sem->wait_lock);
+			}
+			if (!READ_ONCE(waiter.task))
+				goto handed_off;
 		}
 
 		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_writer);
+		if (!READ_ONCE(waiter.task))
+			goto handed_off;
+
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
 
+handed_off:
+	/* Write lock handed off */
+	set_current_state(TASK_RUNNING);	/* smp_mb() */
+	goto out;
+
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
-- 
2.31.1

