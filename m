Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5C6A08AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjBWMfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjBWMes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:34:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB217532B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Yu4KpcpLybjLjkU3gNwo4HWX9o49wsMDX9ywKwgjG5w=; b=oEmKyGJAp3cZqg6dOxsAhotOOm
        V/RmkQGNhhpdFNV30VD5UkNxtCeFjGdGqC5wwbUw7WA2HPa+y8u2h64SooSNAn7xSjGkDnaHvM2CP
        abhJV5F33gmn0YSaE+JkK1xYIG40nuLQXXUX+LjG5aiMvcLI5Cbbq0mRS3yZbPCZfRS3PZX27f2VW
        A5ItRTO9mHUgrvi1cyMuAwftC0KCyXCfYRKbEzg39w1SvAzGaRkvmymfTO+di2+OQRk22kaM2txSv
        QdvyWcY9il9aaSodAEIhAotg51acDtP0il9EnDPPoXvSKPmLekTmAuR+0VNtpVwXeEXNWN+gvB+BE
        //e2JLnQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pVAo1-00CuVB-1h;
        Thu, 23 Feb 2023 12:34:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E057A300C50;
        Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C4C442C86FE07; Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Message-ID: <20230223123319.608133045@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 23 Feb 2023 13:26:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     longman@redhat.com, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com
Subject: [PATCH 5/6] locking/rwsem: Unify wait loop
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

Now that the reader and writer wait loops are identical, share the
code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem.c |  117 +++++++++++++++++++------------------------------
 1 file changed, 47 insertions(+), 70 deletions(-)

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -650,13 +650,11 @@ static void rwsem_mark_wake(struct rw_se
  * optionally wake up waiters before it returns.
  */
 static inline void
-rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
-		      struct wake_q_head *wake_q)
+rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
 		      __releases(&sem->wait_lock)
 {
 	bool first = rwsem_first_waiter(sem) == waiter;
-
-	wake_q_init(wake_q);
+	DEFINE_WAKE_Q(wake_q);
 
 	/*
 	 * If the wait_list isn't empty and the waiter to be deleted is
@@ -664,10 +662,10 @@ rwsem_del_wake_waiter(struct rw_semaphor
 	 * be eligible to acquire or spin on the lock.
 	 */
 	if (rwsem_del_waiter(sem, waiter) && first)
-		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, wake_q);
+		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
-	if (!wake_q_empty(wake_q))
-		wake_up_q(wake_q);
+	if (!wake_q_empty(&wake_q))
+		wake_up_q(&wake_q);
 }
 
 /*
@@ -993,6 +991,46 @@ static inline void rwsem_cond_wake_waite
 	rwsem_mark_wake(sem, wake_type, wake_q);
 }
 
+#define waiter_type(_waiter, _r, _w)	\
+	((_waiter)->type == RWSEM_WAITING_FOR_READ ? (_r) : (_w))
+
+static __always_inline struct rw_semaphore *
+rwsem_waiter_wait(struct rw_semaphore *sem, struct rwsem_waiter *waiter, int state)
+{
+	trace_contention_begin(sem, waiter_type(waiter, LCB_F_READ, LCB_F_WRITE));
+
+	/* wait to be given the lock */
+	for (;;) {
+		set_current_state(state);
+		if (!smp_load_acquire(&waiter->task)) {
+			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
+			break;
+		}
+		if (signal_pending_state(state, current)) {
+			raw_spin_lock_irq(&sem->wait_lock);
+			if (waiter->task)
+				goto out_nolock;
+			raw_spin_unlock_irq(&sem->wait_lock);
+			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
+			break;
+		}
+		schedule_preempt_disabled();
+		lockevent_inc(waiter_type(waiter, rwsem_sleep_reader, rwsem_sleep_writer));
+	}
+
+	__set_current_state(TASK_RUNNING);
+	lockevent_inc(waiter_type(waiter, rwsem_rlock, rwsem_wlock));
+	trace_contention_end(sem, 0);
+	return sem;
+
+out_nolock:
+	rwsem_del_wake_waiter(sem, waiter);
+	__set_current_state(TASK_RUNNING);
+	lockevent_inc(waiter_type(waiter, rwsem_rlock_fail, rwsem_wlock_fail));
+	trace_contention_end(sem, -EINTR);
+	return ERR_PTR(-EINTR);
+}
+
 /*
  * Wait for the read lock to be granted
  */
@@ -1071,38 +1109,7 @@ rwsem_down_read_slowpath(struct rw_semap
 	if (!wake_q_empty(&wake_q))
 		wake_up_q(&wake_q);
 
-	trace_contention_begin(sem, LCB_F_READ);
-
-	/* wait to be given the lock */
-	for (;;) {
-		set_current_state(state);
-		if (!smp_load_acquire(&waiter.task)) {
-			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
-			break;
-		}
-		if (signal_pending_state(state, current)) {
-			raw_spin_lock_irq(&sem->wait_lock);
-			if (waiter.task)
-				goto out_nolock;
-			raw_spin_unlock_irq(&sem->wait_lock);
-			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
-			break;
-		}
-		schedule_preempt_disabled();
-		lockevent_inc(rwsem_sleep_reader);
-	}
-
-	__set_current_state(TASK_RUNNING);
-	lockevent_inc(rwsem_rlock);
-	trace_contention_end(sem, 0);
-	return sem;
-
-out_nolock:
-	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
-	__set_current_state(TASK_RUNNING);
-	lockevent_inc(rwsem_rlock_fail);
-	trace_contention_end(sem, -EINTR);
-	return ERR_PTR(-EINTR);
+	return rwsem_waiter_wait(sem, &waiter, state);
 }
 
 /*
@@ -1150,37 +1157,7 @@ rwsem_down_write_slowpath(struct rw_sema
 	}
 	raw_spin_unlock_irq(&sem->wait_lock);
 
-	/* wait until we successfully acquire the lock */
-	trace_contention_begin(sem, LCB_F_WRITE);
-
-	for (;;) {
-		set_current_state(state);
-		if (!smp_load_acquire(&waiter.task)) {
-			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
-			break;
-		}
-		if (signal_pending_state(state, current)) {
-			raw_spin_lock_irq(&sem->wait_lock);
-			if (waiter.task)
-				goto out_nolock;
-			raw_spin_unlock_irq(&sem->wait_lock);
-			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
-			break;
-		}
-		schedule_preempt_disabled();
-		lockevent_inc(rwsem_sleep_writer);
-	}
-	__set_current_state(TASK_RUNNING);
-	lockevent_inc(rwsem_wlock);
-	trace_contention_end(sem, 0);
-	return sem;
-
-out_nolock:
-	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
-	__set_current_state(TASK_RUNNING);
-	lockevent_inc(rwsem_wlock_fail);
-	trace_contention_end(sem, -EINTR);
-	return ERR_PTR(-EINTR);
+	return rwsem_waiter_wait(sem, &waiter, state);
 }
 
 /*


