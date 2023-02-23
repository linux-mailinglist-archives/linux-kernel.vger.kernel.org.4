Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999C06A08A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjBWMew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjBWMeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:34:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40FA5328E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=K2pbR4KcjJRNdFn1g/z74LmAo74CzFbj013dia1RVO0=; b=PRPzLnSuPGsvGIsJRSbHD0VRiV
        ihE23ztaDlrwM3vlsaRthWGH3RjdLuoNFUiF980Y3ooo6TNnxOvl5xY6brBTGdLcOdVpBxMFRi2D8
        5Z446BNMSyDKBaGxjMJ4McatOq8txUJjFsOg1hSFuINTpcGi+87dMEq3DQ3LoQcf0o9KS0N7l6FG3
        jdKa1GY+lobwSY+qrgfRQnmcwD2at3VcOklQIzIeGvAyTheDgbqVUThV/Pd8EIutPw19Git9e/erf
        bl1lGvd9/3xImJH8zF6dcajFRaXyg0WqMbbX2G/oihGsEBNc0GYtVR4+PTqqvyHrpo3CDJi9tbJfS
        6IbWalKQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVAo0-00EMIl-Ok; Thu, 23 Feb 2023 12:34:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9F10300820;
        Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C0E2C2C86FE06; Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Message-ID: <20230223123319.548254615@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 23 Feb 2023 13:26:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     longman@redhat.com, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com
Subject: [PATCH 4/6] locking/rwsem: Split out rwsem_reader_wake()
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

To provide symmetry with rwsem_writer_wake().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem.c |   84 +++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 37 deletions(-)

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -106,9 +106,9 @@
  * atomic_long_cmpxchg() will be used to obtain writer lock.
  *
  * There are three places where the lock handoff bit may be set or cleared.
- * 1) rwsem_mark_wake() for readers		-- set, clear
+ * 1) rwsem_reader_wake() for readers	-- set, clear
  * 2) rwsem_writer_wake() for writers	-- set, clear
- * 3) rwsem_del_waiter()			-- clear
+ * 3) rwsem_del_waiter()		-- clear
  *
  * For all the above cases, wait_lock will be held. A writer must also
  * be the first one in the wait_list to be eligible for setting the handoff
@@ -377,8 +377,8 @@ rwsem_add_waiter(struct rw_semaphore *se
 /*
  * Remove a waiter from the wait_list and clear flags.
  *
- * Both rwsem_mark_wake() and rwsem_writer_wake() contain a full 'copy' of
- * this function. Modify with care.
+ * Both rwsem_{reader,writer}_wake() contain a full 'copy' of this function.
+ * Modify with care.
  *
  * Return: true if wait_list isn't empty and false otherwise
  */
@@ -488,42 +488,15 @@ static void rwsem_writer_wake(struct rw_
 	rwsem_waiter_wake(waiter, wake_q);
 }
 
-/*
- * handle the lock release when processes blocked on it that can now run
- * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
- *   have been set.
- * - there must be someone on the queue
- * - the wait_lock must be held by the caller
- * - tasks are marked for wakeup, the caller must later invoke wake_up_q()
- *   to actually wakeup the blocked task(s) and drop the reference count,
- *   preferably when the wait_lock is released
- * - woken process blocks are discarded from the list after having task zeroed
- * - writers are only marked woken if downgrading is false
- *
- * Implies rwsem_del_waiter() for all woken readers.
- */
-static void rwsem_mark_wake(struct rw_semaphore *sem,
-			    enum rwsem_wake_type wake_type,
-			    struct wake_q_head *wake_q)
+static void rwsem_reader_wake(struct rw_semaphore *sem,
+			      enum rwsem_wake_type wake_type,
+			      struct rwsem_waiter *waiter,
+			      struct wake_q_head *wake_q)
 {
-	struct rwsem_waiter *waiter, *tmp;
 	long count, woken = 0, adjustment = 0;
+	struct rwsem_waiter *tmp;
 	struct list_head wlist;
 
-	lockdep_assert_held(&sem->wait_lock);
-
-	/*
-	 * Take a peek at the queue head waiter such that we can determine
-	 * the wakeup(s) to perform.
-	 */
-	waiter = rwsem_first_waiter(sem);
-
-	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
-		if (wake_type == RWSEM_WAKE_ANY)
-			rwsem_writer_wake(sem, waiter, wake_q);
-		return;
-	}
-
 	/*
 	 * No reader wakeup if there are too many of them already.
 	 */
@@ -635,6 +608,42 @@ static void rwsem_mark_wake(struct rw_se
 }
 
 /*
+ * handle the lock release when processes blocked on it that can now run
+ * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
+ *   have been set.
+ * - there must be someone on the queue
+ * - the wait_lock must be held by the caller
+ * - tasks are marked for wakeup, the caller must later invoke wake_up_q()
+ *   to actually wakeup the blocked task(s) and drop the reference count,
+ *   preferably when the wait_lock is released
+ * - woken process blocks are discarded from the list after having task zeroed
+ * - writers are only marked woken if downgrading is false
+ *
+ * Implies rwsem_del_waiter() for all woken waiters.
+ */
+static void rwsem_mark_wake(struct rw_semaphore *sem,
+			    enum rwsem_wake_type wake_type,
+			    struct wake_q_head *wake_q)
+{
+	struct rwsem_waiter *waiter;
+
+	lockdep_assert_held(&sem->wait_lock);
+
+	/*
+	 * Take a peek at the queue head waiter such that we can determine
+	 * the wakeup(s) to perform.
+	 */
+	waiter = rwsem_first_waiter(sem);
+
+	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
+		if (wake_type == RWSEM_WAKE_ANY)
+			rwsem_writer_wake(sem, waiter, wake_q);
+	} else {
+		rwsem_reader_wake(sem, wake_type, waiter, wake_q);
+	}
+}
+
+/*
  * Remove a waiter and try to wake up other waiters in the wait queue
  * This function is called from the out_nolock path of both the reader and
  * writer slowpaths with wait_lock held. It releases the wait_lock and
@@ -1017,9 +1026,10 @@ rwsem_down_read_slowpath(struct rw_semap
 		 */
 		if ((rcnt == 1) && (count & RWSEM_FLAG_WAITERS)) {
 			raw_spin_lock_irq(&sem->wait_lock);
-			if (!list_empty(&sem->wait_list))
+			if (!list_empty(&sem->wait_list)) {
 				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
 						&wake_q);
+			}
 			raw_spin_unlock_irq(&sem->wait_lock);
 			wake_up_q(&wake_q);
 		}


