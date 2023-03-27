Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF06CAFEE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjC0UZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjC0UZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3C93ABA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679948667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlsCSIZsm4o5WvUVG0SHZMGS9aAGDqrQ6uJd+nDZAjw=;
        b=bdsTkUrMIU4/9goqbj5QFXLJPgjJskQgM2bPpcs6W1edeXwy1b4DJZRN/arGmydmaq0fSI
        eGhE79vux/wPq7Cwz/bHx1aEMc/bN+VfO22r7g17iLDVh41U5xgHyxkU4UI98a/eVPII3X
        8mklZgXfY0kXvjURzyWjDGF6b7a7Mv8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-dWEAiqxvMMe040rQ_D1Mug-1; Mon, 27 Mar 2023 16:24:24 -0400
X-MC-Unique: dWEAiqxvMMe040rQ_D1Mug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F459811E7C;
        Mon, 27 Mar 2023 20:24:23 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 591AE2027040;
        Mon, 27 Mar 2023 20:24:23 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] locking/rwsem: Rework writer wakeup
Date:   Mon, 27 Mar 2023 16:24:08 -0400
Message-Id: <20230327202413.1955856-4-longman@redhat.com>
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

Currently readers and writers have distinctly different wait/wake
methods. For readers the ->count adjustment happens on the wakeup
side, while for writers the ->count adjustment happens on the wait
side.

This asymmetry is unfortunate since the wake side has an additional
guarantee -- specifically, the wake side has observed the unlocked
state, and thus it can know that speculative READER_BIAS perbutations
on ->count are just that, they will be undone.

Additionally, unifying the wait/wake methods allows sharing code.

As such, do a straight-forward transform of the writer wakeup into the
wake side.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem.c | 259 +++++++++++++++++++----------------------
 1 file changed, 123 insertions(+), 136 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 4b9e492abd59..0cc0aa566a6b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -394,6 +394,108 @@ rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
 	return false;
 }
 
+static inline void
+rwsem_waiter_wake(struct rwsem_waiter *waiter, struct wake_q_head *wake_q)
+{
+	struct task_struct *tsk;
+
+	tsk = waiter->task;
+	get_task_struct(tsk);
+
+	/*
+	 * Ensure calling get_task_struct() before setting the reader
+	 * waiter to nil such that rwsem_down_read_slowpath() cannot
+	 * race with do_exit() by always holding a reference count
+	 * to the task to wakeup.
+	 */
+	smp_store_release(&waiter->task, NULL);
+	/*
+	 * Ensure issuing the wakeup (either by us or someone else)
+	 * after setting the reader waiter to nil.
+	 */
+	wake_q_add_safe(wake_q, tsk);
+}
+
+/*
+ * This function must be called with the sem->wait_lock held to prevent
+ * race conditions between checking the rwsem wait list and setting the
+ * sem->count accordingly.
+ *
+ * Implies rwsem_del_waiter() on success.
+ */
+static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
+					struct rwsem_waiter *waiter)
+{
+
+	struct rwsem_waiter *first = rwsem_first_waiter(sem);
+	long count, new;
+
+	lockdep_assert_held(&sem->wait_lock);
+
+	count = atomic_long_read(&sem->count);
+	do {
+		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
+
+		if (has_handoff) {
+			/*
+			 * Honor handoff bit and yield only when the first
+			 * waiter is the one that set it. Otherwisee, we
+			 * still try to acquire the rwsem.
+			 */
+			if (first->handoff_set && (waiter != first))
+				return false;
+		}
+
+		new = count;
+
+		if (count & RWSEM_LOCK_MASK) {
+			/*
+			 * A waiter (first or not) can set the handoff bit
+			 * if it is an RT task or wait in the wait queue
+			 * for too long.
+			 */
+			if (has_handoff || (!rt_task(waiter->task) &&
+					    !time_after(jiffies, waiter->timeout)))
+				return false;
+
+			new |= RWSEM_FLAG_HANDOFF;
+		} else {
+			new |= RWSEM_WRITER_LOCKED;
+			new &= ~RWSEM_FLAG_HANDOFF;
+
+			if (list_is_singular(&sem->wait_list))
+				new &= ~RWSEM_FLAG_WAITERS;
+		}
+	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
+
+	/*
+	 * We have either acquired the lock with handoff bit cleared or set
+	 * the handoff bit. Only the first waiter can have its handoff_set
+	 * set here to enable optimistic spinning in slowpath loop.
+	 */
+	if (new & RWSEM_FLAG_HANDOFF) {
+		first->handoff_set = true;
+		lockevent_inc(rwsem_wlock_handoff);
+		return false;
+	}
+
+	/*
+	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
+	 * success.
+	 */
+	list_del(&waiter->list);
+	atomic_long_set(&sem->owner, (long)waiter->task);
+	return true;
+}
+
+static void rwsem_writer_wake(struct rw_semaphore *sem,
+			      struct rwsem_waiter *waiter,
+			      struct wake_q_head *wake_q)
+{
+	if (rwsem_try_write_lock(sem, waiter))
+		rwsem_waiter_wake(waiter, wake_q);
+}
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -424,23 +526,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	 */
 	waiter = rwsem_first_waiter(sem);
 
-	if (waiter->type != RWSEM_WAITING_FOR_WRITE)
-		goto wake_readers;
-
-	if (wake_type == RWSEM_WAKE_ANY) {
-		/*
-		 * Mark writer at the front of the queue for wakeup.
-		 * Until the task is actually later awoken later by
-		 * the caller, other writers are able to steal it.
-		 * Readers, on the other hand, will block as they
-		 * will notice the queued writer.
-		 */
-		wake_q_add(wake_q, waiter->task);
-		lockevent_inc(rwsem_wake_writer);
+	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
+		if (wake_type == RWSEM_WAKE_ANY)
+			rwsem_writer_wake(sem, waiter, wake_q);
+		return;
 	}
-	return;
 
-wake_readers:
 	/*
 	 * No reader wakeup if there are too many of them already.
 	 */
@@ -552,25 +643,8 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		atomic_long_add(adjustment, &sem->count);
 
 	/* 2nd pass */
-	list_for_each_entry_safe(waiter, tmp, &wlist, list) {
-		struct task_struct *tsk;
-
-		tsk = waiter->task;
-		get_task_struct(tsk);
-
-		/*
-		 * Ensure calling get_task_struct() before setting the reader
-		 * waiter to nil such that rwsem_down_read_slowpath() cannot
-		 * race with do_exit() by always holding a reference count
-		 * to the task to wakeup.
-		 */
-		smp_store_release(&waiter->task, NULL);
-		/*
-		 * Ensure issuing the wakeup (either by us or someone else)
-		 * after setting the reader waiter to nil.
-		 */
-		wake_q_add_safe(wake_q, tsk);
-	}
+	list_for_each_entry_safe(waiter, tmp, &wlist, list)
+		rwsem_waiter_wake(waiter, wake_q);
 }
 
 /*
@@ -600,77 +674,6 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
 		wake_up_q(wake_q);
 }
 
-/*
- * This function must be called with the sem->wait_lock held to prevent
- * race conditions between checking the rwsem wait list and setting the
- * sem->count accordingly.
- *
- * Implies rwsem_del_waiter() on success.
- */
-static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
-					struct rwsem_waiter *waiter)
-{
-	struct rwsem_waiter *first = rwsem_first_waiter(sem);
-	long count, new;
-
-	lockdep_assert_held(&sem->wait_lock);
-
-	count = atomic_long_read(&sem->count);
-	do {
-		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
-
-		if (has_handoff) {
-			/*
-			 * Honor handoff bit and yield only when the first
-			 * waiter is the one that set it. Otherwisee, we
-			 * still try to acquire the rwsem.
-			 */
-			if (first->handoff_set && (waiter != first))
-				return false;
-		}
-
-		new = count;
-
-		if (count & RWSEM_LOCK_MASK) {
-			/*
-			 * A waiter (first or not) can set the handoff bit
-			 * if it is an RT task or wait in the wait queue
-			 * for too long.
-			 */
-			if (has_handoff || (!rt_task(waiter->task) &&
-					    !time_after(jiffies, waiter->timeout)))
-				return false;
-
-			new |= RWSEM_FLAG_HANDOFF;
-		} else {
-			new |= RWSEM_WRITER_LOCKED;
-			new &= ~RWSEM_FLAG_HANDOFF;
-
-			if (list_is_singular(&sem->wait_list))
-				new &= ~RWSEM_FLAG_WAITERS;
-		}
-	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
-
-	/*
-	 * We have either acquired the lock with handoff bit cleared or set
-	 * the handoff bit. Only the first waiter can have its handoff_set
-	 * set here to enable optimistic spinning in slowpath loop.
-	 */
-	if (new & RWSEM_FLAG_HANDOFF) {
-		first->handoff_set = true;
-		lockevent_inc(rwsem_wlock_handoff);
-		return false;
-	}
-
-	/*
-	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
-	 * success.
-	 */
-	list_del(&waiter->list);
-	rwsem_set_owner(sem);
-	return true;
-}
-
 /*
  * The rwsem_spin_on_owner() function returns the following 4 values
  * depending on the lock owner state.
@@ -1081,7 +1084,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	for (;;) {
 		set_current_state(state);
 		if (!smp_load_acquire(&waiter.task)) {
-			/* Matches rwsem_mark_wake()'s smp_store_release(). */
+			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
 			break;
 		}
 		if (signal_pending_state(state, current)) {
@@ -1151,55 +1154,39 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		}
 	} else {
 		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
+		if (rwsem_try_write_lock(sem, &waiter))
+			waiter.task = NULL;
 	}
+	raw_spin_unlock_irq(&sem->wait_lock);
 
 	/* wait until we successfully acquire the lock */
-	set_current_state(state);
 	trace_contention_begin(sem, LCB_F_WRITE);
 
 	for (;;) {
-		if (rwsem_try_write_lock(sem, &waiter)) {
-			/* rwsem_try_write_lock() implies ACQUIRE on success */
+		set_current_state(state);
+		if (!smp_load_acquire(&waiter.task)) {
+			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
 			break;
 		}
-
-		raw_spin_unlock_irq(&sem->wait_lock);
-
-		if (signal_pending_state(state, current))
-			goto out_nolock;
-
-		/*
-		 * After setting the handoff bit and failing to acquire
-		 * the lock, attempt to spin on owner to accelerate lock
-		 * transfer. If the previous owner is a on-cpu writer and it
-		 * has just released the lock, OWNER_NULL will be returned.
-		 * In this case, we attempt to acquire the lock again
-		 * without sleeping.
-		 */
-		if (waiter.handoff_set) {
-			enum owner_state owner_state;
-
-			owner_state = rwsem_spin_on_owner(sem);
-			if (owner_state == OWNER_NULL)
-				goto trylock_again;
+		if (signal_pending_state(state, current)) {
+			raw_spin_lock_irq(&sem->wait_lock);
+			if (waiter.task)
+				goto out_nolock;
+			raw_spin_unlock_irq(&sem->wait_lock);
+			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
+			break;
 		}
-
 		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_writer);
-		set_current_state(state);
-trylock_again:
-		raw_spin_lock_irq(&sem->wait_lock);
 	}
 	__set_current_state(TASK_RUNNING);
-	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
 	trace_contention_end(sem, 0);
 	return sem;
 
 out_nolock:
-	__set_current_state(TASK_RUNNING);
-	raw_spin_lock_irq(&sem->wait_lock);
 	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
+	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_wlock_fail);
 	trace_contention_end(sem, -EINTR);
 	return ERR_PTR(-EINTR);
-- 
2.31.1

