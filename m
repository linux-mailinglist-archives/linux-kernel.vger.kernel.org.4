Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1455F60B6B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiJXTIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiJXTIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6326BD46
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666633496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dj+K0QnmZOTaKDE9gNQSNFlKIJ5weGyKvZBo3KJQByY=;
        b=eFpya0j5yu0wRUQbkpLeQDl6XmtuXSs5dVJnAjMbtiTlStuL2kMlyiqyYobvRM+Nh4Pv1u
        Sl9dwh/8LS2ytjQrxqzmH61tNbAIpwp1Uq6KpILOrtl6nbpEDyoh9Vckg+bEawI3b3M8cL
        EY5bPjAw4A6QKP2t0mdc3uUj0ecdzzo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-8_A9CgkHOe-LDS4tt285hQ-1; Mon, 24 Oct 2022 13:44:52 -0400
X-MC-Unique: 8_A9CgkHOe-LDS4tt285hQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86622882826;
        Mon, 24 Oct 2022 17:44:51 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 404D7492B0E;
        Mon, 24 Oct 2022 17:44:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v4 4/5] locking/rwsem: Enable direct rwsem lock handoff
Date:   Mon, 24 Oct 2022 13:44:17 -0400
Message-Id: <20221024174418.796468-5-longman@redhat.com>
In-Reply-To: <20221024174418.796468-1-longman@redhat.com>
References: <20221024174418.796468-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 kernel/locking/rwsem.c | 141 +++++++++++++++++++++++++++++++----------
 1 file changed, 109 insertions(+), 32 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index a8bfc905637a..287606aee0e6 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -341,6 +341,7 @@ enum rwsem_waiter_type {
 enum rwsem_handoff_state {
 	HANDOFF_NONE = 0,
 	HANDOFF_REQUESTED,
+	HANDOFF_GRANTED,
 };
 
 struct rwsem_waiter {
@@ -489,6 +490,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
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
@@ -586,7 +593,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
 		      struct wake_q_head *wake_q)
 		      __releases(&sem->wait_lock)
 {
-	bool first = rwsem_first_waiter(sem) == waiter;
+	struct rwsem_waiter *first = rwsem_first_waiter(sem);
 
 	wake_q_init(wake_q);
 
@@ -595,8 +602,21 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
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
@@ -764,6 +784,11 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 	owner = rwsem_owner_flags(sem, &flags);
 	state = rwsem_owner_state(owner, flags);
+
+	/* A handoff may have been granted */
+	if (!flags && (owner == current))
+		return OWNER_NONSPINNABLE;
+
 	if (state != OWNER_WRITER)
 		return state;
 
@@ -977,6 +1002,32 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
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
@@ -1051,6 +1102,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	waiter.handoff_state = HANDOFF_NONE;
 
 	raw_spin_lock_irq(&sem->wait_lock);
+	count = atomic_long_read(&sem->count);
 	if (list_empty(&sem->wait_list)) {
 		/*
 		 * In case the wait queue is empty and the lock isn't owned
@@ -1058,7 +1110,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 		 * immediately as its RWSEM_READER_BIAS has already been set
 		 * in the count.
 		 */
-		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
+		if (!(count & RWSEM_WRITER_MASK)) {
 			/* Provide lock ACQUIRE */
 			smp_acquire__after_ctrl_dep();
 			raw_spin_unlock_irq(&sem->wait_lock);
@@ -1067,13 +1119,33 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 			return sem;
 		}
 		adjustment += RWSEM_FLAG_WAITERS;
+	} else if ((count & RWSEM_FLAG_HANDOFF) &&
+		  ((count & RWSEM_LOCK_MASK) == RWSEM_READER_BIAS)) {
+		/*
+		 * If the waiter to be handed off is a reader, this reader
+		 * can piggyback on top of top of that.
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
@@ -1120,7 +1192,6 @@ static struct rw_semaphore __sched *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	struct rwsem_waiter waiter;
-	int null_owner_retries;
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
@@ -1162,7 +1233,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	set_current_state(state);
 	trace_contention_begin(sem, LCB_F_WRITE);
 
-	for (null_owner_retries = 0;;) {
+	for (;;) {
 		if (rwsem_try_write_lock(sem, &waiter)) {
 			/* rwsem_try_write_lock() implies ACQUIRE on success */
 			break;
@@ -1182,37 +1253,28 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		 * without sleeping.
 		 */
 		if (READ_ONCE(waiter.handoff_state)) {
-			enum owner_state owner_state;
-
-			preempt_disable();
-			owner_state = rwsem_spin_on_owner(sem);
-			preempt_enable();
-
-			/*
-			 * owner is NULL doesn't guarantee the lock is free.
-			 * An incoming reader will temporarily increment the
-			 * reader count without changing owner and the
-			 * rwsem_try_write_lock() will fails if the reader
-			 * is not able to decrement it in time. Allow 8
-			 * trylock attempts when hitting a NULL owner before
-			 * going to sleep.
-			 */
-			if ((owner_state == OWNER_NULL) &&
-			    (null_owner_retries < 8)) {
-				null_owner_retries++;
-				goto trylock_again;
+			if (READ_ONCE(waiter.handoff_state) == HANDOFF_REQUESTED) {
+				preempt_disable();
+				rwsem_spin_on_owner(sem);
+				preempt_enable();
 			}
-			null_owner_retries = 0;
+			if (READ_ONCE(waiter.handoff_state) == HANDOFF_GRANTED)
+				goto skip_sleep;
 		}
 
 		schedule();
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
@@ -1221,6 +1283,9 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
 	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
+	if (unlikely(READ_ONCE(waiter.handoff_state) == HANDOFF_GRANTED))
+		goto out_lock;
+
 	lockevent_inc(rwsem_wlock_fail);
 	trace_contention_end(sem, -EINTR);
 	return ERR_PTR(-EINTR);
@@ -1232,12 +1297,24 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
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

