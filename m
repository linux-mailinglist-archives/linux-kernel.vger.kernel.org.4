Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D676A08A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjBWMey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjBWMeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:34:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D528B53290
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LzsVsRfjf9ETCxQYWcN5alvuRxG2QcrRoaSxyUFP6b4=; b=vNGWC2yr4wyedzFUDO+tO6MBUN
        hqRYWG2BgSOgIyoitdfgYWmMA1tkmD1fTfEA5TDp8XDTG+33y42NnZbJiF0erX8RcmQIekZ6bhGNB
        TJqrCteviQcOFeHNM0Jkt9zd/VzuVMbY+KszSAlyGDf5vtj4BxvNIM4ncwh3HA2yQUBKaw1H8fUpl
        iKuxF1mdxI8zSDNBVLbMNDKy3tLIEMkI8U04J1IYoeQalyBe+5YcQMJI5Glbvd2jrnbrMzV8uzSMO
        vgm/iAZEC+xo0FiEkSsHv//FfzRi5AlTQdFEF8PJUHFU92b+uZQ0OSur9AROhTYrM/WEepCWZZ6QD
        6fUxRvqA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVAo0-00EMIk-Ov; Thu, 23 Feb 2023 12:34:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD8BE300472;
        Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B37832C86FE05; Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Message-ID: <20230223123319.367721619@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 23 Feb 2023 13:26:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     longman@redhat.com, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com
Subject: [PATCH 1/6] locking/rwsem: Minor code refactoring in rwsem_mark_wake()
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

From: Waiman Long <longman@redhat.com>

Rename "oldcount" to "count" as it is not always old count value.
Also make some minor code refactoring to reduce indentation. There
is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230216210933.1169097-2-longman@redhat.com
---
 kernel/locking/rwsem.c |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

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
@@ -413,7 +413,7 @@ static void rwsem_mark_wake(struct rw_se
 			    struct wake_q_head *wake_q)
 {
 	struct rwsem_waiter *waiter, *tmp;
-	long oldcount, woken = 0, adjustment = 0;
+	long count, woken = 0, adjustment = 0;
 	struct list_head wlist;
 
 	lockdep_assert_held(&sem->wait_lock);
@@ -424,22 +424,23 @@ static void rwsem_mark_wake(struct rw_se
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
@@ -455,15 +456,15 @@ static void rwsem_mark_wake(struct rw_se
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
@@ -524,21 +525,21 @@ static void rwsem_mark_wake(struct rw_se
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
 
@@ -844,7 +845,6 @@ static bool rwsem_optimistic_spin(struct
 		 * Try to acquire the lock
 		 */
 		taken = rwsem_try_write_lock_unqueued(sem);
-
 		if (taken)
 			break;
 


