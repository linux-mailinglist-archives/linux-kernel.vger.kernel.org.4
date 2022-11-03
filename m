Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C44D61877E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiKCSaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiKCSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505763899
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667500187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4s9+JHBoTG9/gQjRX0RwWWyQfm5vM6EXmU/9JRuJrY=;
        b=i8Jc1JWoOewOaCHoHffNOF6gnIwQ9Rzu2PoXunZ8+8c1TJVzQ4M5wqzXdyJpHhpt9QKZNg
        RIX3+Ken9CGqHZY/b2rN2+3q4g3/urSmPrz1+dn3jadYcuwsqQRIQHntKkErbJy6NlsPuC
        8od6V4nS8J4ceyvzHLWkXxBGhJLmCBM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-IxJNVEndNv2mu2aQTbfs_g-1; Thu, 03 Nov 2022 14:29:46 -0400
X-MC-Unique: IxJNVEndNv2mu2aQTbfs_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A72EF1C14345;
        Thu,  3 Nov 2022 18:29:45 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46E2F1121325;
        Thu,  3 Nov 2022 18:29:45 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v5 5/6] locking/rwsem: Enable direct rwsem lock handoff
Date:   Thu,  3 Nov 2022 14:29:35 -0400
Message-Id: <20221103182936.217120-6-longman@redhat.com>
In-Reply-To: <20221103182936.217120-1-longman@redhat.com>
References: <20221103182936.217120-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reworking the code to enable a true lock handoff is more complex due to
the following facts:
 1) The RWSEM_FLAG_HANDOFF bit is protected by the wait_lock and it
    is too expensive to always take the wait_lock in the unlock path
    to prevent racing.
 2) The reader lock fast path may add a RWSEM_READER_BIAS at the wrong
    time to prevent a proper lock handoff from a reader owned rwsem.

A lock handoff can only be initiated when the following conditions are
true:
 1) The RWSEM_FLAG_HANDOFF bit is set.
 2) The task to do the handoff don't see any other active lock
    excluding the lock that it might have held.

The new handoff mechanism performs handoff in rwsem_wakeup() to minimize
overhead. The rwsem count will be known at that point to determine if
handoff should be done. However, there is a small time gap between the
rwsem becomes free and the wait_lock is taken where a reader can come
in and add a RWSEM_READER_BIAS to the count or the current first waiter
can take the rwsem and clear RWSEM_FLAG_HANDOFF in the interim. That
will fail the handoff operation. To handle the former case, a secondary
handoff will also be done in the rwsem_down_read_slowpath() to catch it.

With true lock handoff, there is no need to do a NULL owner spinning
anymore as wakeup will be performed if handoff is possible. So it
is likely that the first waiter won't actually go to sleep even when
schedule() is called in this case.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 135 +++++++++++++++++++++++++++++++++++------
 1 file changed, 117 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index d80f22f7ecb6..c9f24ed8757d 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -338,6 +338,7 @@ enum rwsem_waiter_type {
 enum rwsem_handoff_state {
 	HANDOFF_NONE = 0,
 	HANDOFF_REQUESTED,
+	HANDOFF_GRANTED,
 };
 
 struct rwsem_waiter {
@@ -486,6 +487,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		 */
 		owner = waiter->task;
 		__rwsem_set_reader_owned(sem, owner);
+	} else if (waiter->handoff_state == HANDOFF_GRANTED) {
+		/*
+		 * rwsem_handoff() has added to count RWSEM_READER_BIAS of
+		 * the first waiter.
+		 */
+		adjustment = RWSEM_READER_BIAS;
 	}
 
 	/*
@@ -583,7 +590,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
 		      struct wake_q_head *wake_q)
 		      __releases(&sem->wait_lock)
 {
-	bool first = rwsem_first_waiter(sem) == waiter;
+	struct rwsem_waiter *first = rwsem_first_waiter(sem);
 
 	wake_q_init(wake_q);
 
@@ -592,8 +599,21 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
 	 * the first waiter, we wake up the remaining waiters as they may
 	 * be eligible to acquire or spin on the lock.
 	 */
-	if (rwsem_del_waiter(sem, waiter) && first)
+	if (rwsem_del_waiter(sem, waiter) && (waiter == first)) {
+		switch (waiter->handoff_state) {
+		case HANDOFF_GRANTED:
+			raw_spin_unlock_irq(&sem->wait_lock);
+			return;
+		case HANDOFF_REQUESTED:
+			/* Pass handoff state to the new first waiter */
+			first = rwsem_first_waiter(sem);
+			WRITE_ONCE(first->handoff_state, HANDOFF_REQUESTED);
+			fallthrough;
+		default:
+			break;
+		}
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, wake_q);
+	}
 	raw_spin_unlock_irq(&sem->wait_lock);
 	if (!wake_q_empty(wake_q))
 		wake_up_q(wake_q);
@@ -759,6 +779,11 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 	owner = rwsem_owner_flags(sem, &flags);
 	state = rwsem_owner_state(owner, flags);
+
+	/* A handoff may have been granted */
+	if (!flags && (owner == current))
+		return OWNER_NONSPINNABLE;
+
 	if (state != OWNER_WRITER)
 		return state;
 
@@ -969,6 +994,32 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 }
 #endif
 
+/*
+ * Hand off the lock to the first waiter
+ */
+static void rwsem_handoff(struct rw_semaphore *sem, long adj,
+			  struct wake_q_head *wake_q)
+{
+	struct rwsem_waiter *waiter;
+	enum rwsem_wake_type wake_type;
+
+	lockdep_assert_held(&sem->wait_lock);
+	adj -= RWSEM_FLAG_HANDOFF;
+	waiter = rwsem_first_waiter(sem);
+	WRITE_ONCE(waiter->handoff_state, HANDOFF_GRANTED);
+	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
+		wake_type = RWSEM_WAKE_ANY;
+		adj += RWSEM_WRITER_LOCKED;
+		atomic_long_set(&sem->owner, (long)waiter->task);
+	} else {
+		wake_type = RWSEM_WAKE_READ_OWNED;
+		adj += RWSEM_READER_BIAS;
+		__rwsem_set_reader_owned(sem, waiter->task);
+	}
+	atomic_long_add(adj, &sem->count);
+	rwsem_mark_wake(sem, wake_type, wake_q);
+}
+
 /*
  * Prepare to wake up waiter(s) in the wait queue by putting them into the
  * given wake_q if the rwsem lock owner isn't a writer. If rwsem is likely
@@ -1043,6 +1094,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	waiter.handoff_state = HANDOFF_NONE;
 
 	raw_spin_lock_irq(&sem->wait_lock);
+	count = atomic_long_read(&sem->count);
 	if (list_empty(&sem->wait_list)) {
 		/*
 		 * In case the wait queue is empty and the lock isn't owned
@@ -1050,7 +1102,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 		 * immediately as its RWSEM_READER_BIAS has already been set
 		 * in the count.
 		 */
-		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
+		if (!(count & RWSEM_WRITER_MASK)) {
 			/* Provide lock ACQUIRE */
 			smp_acquire__after_ctrl_dep();
 			raw_spin_unlock_irq(&sem->wait_lock);
@@ -1059,13 +1111,36 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 			return sem;
 		}
 		adjustment += RWSEM_FLAG_WAITERS;
+	} else if ((count & RWSEM_FLAG_HANDOFF) &&
+		  ((count & RWSEM_LOCK_MASK) == RWSEM_READER_BIAS)) {
+		/*
+		 * If the waiter to be handed off is a reader, all the
+		 * readers in the wait queue will be waken up. As this reader
+		 * hasn't been queued in the wait queue yet, it may as well
+		 * keep its RWSEM_READER_BIAS and return after waking up
+		 * other readers in the queue.
+		 */
+		if (rwsem_first_waiter(sem)->type == RWSEM_WAITING_FOR_READ)
+			adjustment = 0;
+		rwsem_handoff(sem, adjustment, &wake_q);
+
+		if (!adjustment) {
+			raw_spin_unlock_irq(&sem->wait_lock);
+			wake_up_q(&wake_q);
+			return sem;
+		}
+		adjustment = 0;
 	}
 	rwsem_add_waiter(sem, &waiter);
 
-	/* we're now waiting on the lock, but no longer actively locking */
-	count = atomic_long_add_return(adjustment, &sem->count);
-
-	rwsem_cond_wake_waiter(sem, count, &wake_q);
+	if (adjustment) {
+		/*
+		 * We are now waiting on the lock with no handoff, but no
+		 * longer actively locking.
+		 */
+		count = atomic_long_add_return(adjustment, &sem->count);
+		rwsem_cond_wake_waiter(sem, count, &wake_q);
+	}
 	raw_spin_unlock_irq(&sem->wait_lock);
 
 	if (!wake_q_empty(&wake_q))
@@ -1154,6 +1229,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	trace_contention_begin(sem, LCB_F_WRITE);
 
 	for (;;) {
+		enum rwsem_handoff_state handoff;
+
 		if (rwsem_try_write_lock(sem, &waiter)) {
 			/* rwsem_try_write_lock() implies ACQUIRE on success */
 			break;
@@ -1168,26 +1245,33 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		 * After setting the handoff bit and failing to acquire
 		 * the lock, attempt to spin on owner to accelerate lock
 		 * transfer. If the previous owner is a on-cpu writer and it
-		 * has just released the lock, OWNER_NULL will be returned.
-		 * In this case, we attempt to acquire the lock again
-		 * without sleeping.
+		 * has just released the lock, handoff_state is likely to be
+		 * set to HANDOFF_GRANTED or is to be set soon.
 		 */
-		if (READ_ONCE(waiter.handoff_state)) {
-			enum owner_state owner_state;
+		handoff = READ_ONCE(waiter.handoff_state);
+		if (handoff) {
+			if (handoff == HANDOFF_REQUESTED) {
+				rwsem_spin_on_owner(sem);
+				handoff = READ_ONCE(waiter.handoff_state);
+			}
 
-			owner_state = rwsem_spin_on_owner(sem);
-			if (owner_state == OWNER_NULL)
-				goto trylock_again;
+			if (handoff == HANDOFF_GRANTED)
+				goto skip_sleep;
 		}
 
 		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_writer);
 		set_current_state(state);
-trylock_again:
+skip_sleep:
 		raw_spin_lock_irq(&sem->wait_lock);
+		if (waiter.handoff_state == HANDOFF_GRANTED) {
+			rwsem_del_waiter(sem, &waiter);
+			break;
+		}
 	}
 	__set_current_state(TASK_RUNNING);
 	raw_spin_unlock_irq(&sem->wait_lock);
+out_lock:
 	lockevent_inc(rwsem_wlock);
 	trace_contention_end(sem, 0);
 	return sem;
@@ -1196,6 +1280,9 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
 	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
+	if (unlikely(READ_ONCE(waiter.handoff_state) == HANDOFF_GRANTED))
+		goto out_lock;
+
 	lockevent_inc(rwsem_wlock_fail);
 	trace_contention_end(sem, -EINTR);
 	return ERR_PTR(-EINTR);
@@ -1207,12 +1294,24 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
  */
 static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 {
-	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
+	unsigned long flags;
+	long count;
 
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
 
-	if (!list_empty(&sem->wait_list))
+	if (list_empty(&sem->wait_list)) {
+		raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
+		return sem;
+	}
+	/*
+	 * If the rwsem is free and handoff flag is set with wait_lock held,
+	 * no other CPUs can take an active lock.
+	 */
+	count = atomic_long_read(&sem->count);
+	if (!(count & RWSEM_LOCK_MASK) && (count & RWSEM_FLAG_HANDOFF))
+		rwsem_handoff(sem, 0, &wake_q);
+	else
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-- 
2.31.1

