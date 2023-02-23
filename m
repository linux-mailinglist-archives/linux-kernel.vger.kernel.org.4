Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14C16A08AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjBWMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjBWMeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:34:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7BA532AC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=WTI53Y+SwQOGWbcqDI+7SQeJQd6XtF7SRs7V3H3R59I=; b=TetszCDz9EJ8a4xLSdyc4i4hap
        ZLd7QFIX83/47cKL0WnZXXiSmxg5drYS3v5oCf8UGuMZowDCSvxu+EnF9PqTHAJOcv1ywYQvVDxe1
        bu7/YiJQkSz72yWjAW8n2zWyxZc2H6DgDnzg1D0OU9yVUH+ggoggtHEXOjoGtAushPYyBSlRYxa20
        nEVBQVeDcS5HEH1jK0GL+Ff8QxrmsvzCNjHXEOtAZIPSPQRZFhs1vTj2YJW4WsEr11yxz1YFBS0P3
        xhjhHhYmYlSB57HWvV9hsP844XD3oSWKTa9qNscKtHeO3VhQv9m6g0/v1x9n+REAJo2+8AX8t+kjV
        pYBjkTBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pVAo0-00CuV8-0z;
        Thu, 23 Feb 2023 12:34:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5484300750;
        Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BCD9B2C539A0B; Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Message-ID: <20230223123319.487908155@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 23 Feb 2023 13:26:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     longman@redhat.com, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com
Subject: [PATCH 3/6] locking/rwsem: Rework writer wakeup
References: <20230223122642.491637862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 kernel/locking/rwsem.c |  253 ++++++++++++++++++++++---------------------------
 1 file changed, 115 insertions(+), 138 deletions(-)

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -107,7 +107,7 @@
  *
  * There are three places where the lock handoff bit may be set or cleared.
  * 1) rwsem_mark_wake() for readers		-- set, clear
- * 2) rwsem_try_write_lock() for writers	-- set, clear
+ * 2) rwsem_writer_wake() for writers	-- set, clear
  * 3) rwsem_del_waiter()			-- clear
  *
  * For all the above cases, wait_lock will be held. A writer must also
@@ -377,7 +377,7 @@ rwsem_add_waiter(struct rw_semaphore *se
 /*
  * Remove a waiter from the wait_list and clear flags.
  *
- * Both rwsem_mark_wake() and rwsem_try_write_lock() contain a full 'copy' of
+ * Both rwsem_mark_wake() and rwsem_writer_wake() contain a full 'copy' of
  * this function. Modify with care.
  *
  * Return: true if wait_list isn't empty and false otherwise
@@ -394,6 +394,100 @@ rwsem_del_waiter(struct rw_semaphore *se
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
+static void rwsem_writer_wake(struct rw_semaphore *sem,
+			      struct rwsem_waiter *waiter,
+			      struct wake_q_head *wake_q)
+{
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
+				return;
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
+				return;
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
+		return;
+	}
+
+	/*
+	 * Have rwsem_writer_wake() fully imply rwsem_del_waiter() on
+	 * success.
+	 */
+	list_del(&waiter->list);
+	rwsem_set_owner(sem);
+	rwsem_waiter_wake(waiter, wake_q);
+}
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -424,23 +518,12 @@ static void rwsem_mark_wake(struct rw_se
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
@@ -547,25 +630,8 @@ static void rwsem_mark_wake(struct rw_se
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
@@ -596,77 +662,6 @@ rwsem_del_wake_waiter(struct rw_semaphor
 }
 
 /*
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
-/*
  * The rwsem_spin_on_owner() function returns the following 4 values
  * depending on the lock owner state.
  *   OWNER_NULL  : owner is currently NULL
@@ -1072,7 +1067,7 @@ rwsem_down_read_slowpath(struct rw_semap
 	for (;;) {
 		set_current_state(state);
 		if (!smp_load_acquire(&waiter.task)) {
-			/* Matches rwsem_mark_wake()'s smp_store_release(). */
+			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
 			break;
 		}
 		if (signal_pending_state(state, current)) {
@@ -1143,54 +1138,36 @@ rwsem_down_write_slowpath(struct rw_sema
 	} else {
 		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
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


