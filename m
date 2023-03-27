Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A486CAFF2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjC0U0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjC0UZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF0D3C02
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679948668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gReWeVsxbG5vsOjLGeKXuMaVbUqU0YcjGeF+0CMOcxA=;
        b=PoLQMsxUuYoMheAUEunRG08KYU0zQLtVI/Arj86K9HYJbJUKitr0Fh0JziclW84v8ZwoyT
        F2ujqjRMk/o1kC7M3QpymV86EMOmhJgc02dZpIVzhsVSKCojYX+qIh/ghgMfkVDCQla+zz
        Ih320d0Z+rNGMaDthw3T0kV9AJrAvK8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-T0TqC2SmOWWrmoZMZTPLpw-1; Mon, 27 Mar 2023 16:24:24 -0400
X-MC-Unique: T0TqC2SmOWWrmoZMZTPLpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79EB7884EC4;
        Mon, 27 Mar 2023 20:24:24 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 422B4202701E;
        Mon, 27 Mar 2023 20:24:24 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] locking/rwsem: Unify wait loop
Date:   Mon, 27 Mar 2023 16:24:11 -0400
Message-Id: <20230327202413.1955856-7-longman@redhat.com>
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

Now that the reader and writer wait loops are identical, share the
code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem.c | 121 +++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 70 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 0bc262dc77fd..ee8861effcc2 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -650,13 +650,11 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
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
@@ -664,10 +662,10 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
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
@@ -997,6 +995,50 @@ static inline void rwsem_cond_wake_waiter(struct rw_semaphore *sem, long count,
 	rwsem_mark_wake(sem, wake_type, wake_q);
 }
 
+#define lockevent_rw_inc(rd, evr, evw)	do {	\
+	lockevent_cond_inc(evr, (rd));		\
+	lockevent_cond_inc(evw, !(rd));		\
+} while (0)
+
+static __always_inline struct rw_semaphore *
+rwsem_waiter_wait(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
+		  int state, bool reader)
+{
+	trace_contention_begin(sem, reader ? LCB_F_READ : LCB_F_WRITE);
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
+		lockevent_rw_inc(reader, rwsem_sleep_reader, rwsem_sleep_writer);
+	}
+
+	__set_current_state(TASK_RUNNING);
+
+	lockevent_rw_inc(reader, rwsem_rlock, rwsem_wlock);
+	trace_contention_end(sem, 0);
+	return sem;
+
+out_nolock:
+	rwsem_del_wake_waiter(sem, waiter);
+	__set_current_state(TASK_RUNNING);
+	lockevent_rw_inc(reader, rwsem_rlock_fail, rwsem_wlock_fail);
+	trace_contention_end(sem, -EINTR);
+	return ERR_PTR(-EINTR);
+}
+
 /*
  * Wait for the read lock to be granted
  */
@@ -1074,38 +1116,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
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
+	return rwsem_waiter_wait(sem, &waiter, state, true);
 }
 
 /*
@@ -1155,37 +1166,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
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
+	return rwsem_waiter_wait(sem, &waiter, state, false);
 }
 
 /*
-- 
2.31.1

