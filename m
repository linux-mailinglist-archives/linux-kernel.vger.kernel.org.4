Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF4698203
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjBORbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBORbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:31:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E693144A3;
        Wed, 15 Feb 2023 09:31:02 -0800 (PST)
Date:   Wed, 15 Feb 2023 18:30:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676482260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=vfwls3jmMnkBa5nyZRMX9xq04XCtdBNjeNQ6TcWm1FI=;
        b=3tvHami8l+pqUUBu8DbZThFJfmomNE9zeb7xH69jrt24tKs1dYICczUQTI4BSVY9F1124Y
        rJd4ynFfCiyPRgot3kG625u3aYBHFMyIXXTek5sB0aDL43HJAlgHL8qzvaqplbUnsPKxl2
        MMjFMDaRNaYA/ydOIwjoE2L7++rtJZH9kswnQqBLNjhPqEOBXfEAgJDCvNVeFWwhsD5OfP
        zADB/JkCyQJsTjhBRtLHLHI/VsDT7YkuGX5b/3SLmrmShA1XnsnpgVsLxJKzKc4D3NJfkM
        NERnw945HN0C7hNKjyFeiKyVJRpjqYh6ypN7GCebyvVDjOb1bRBP7BNvg+GLmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676482260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=vfwls3jmMnkBa5nyZRMX9xq04XCtdBNjeNQ6TcWm1FI=;
        b=S8pQAoFXP2vSKvM5e2F0HP/CAeQzWybEYvIOMcFXElQtP0MwPOQFdnyJ1YjqPweqW2sOnF
        Nz6lvC9vu47+8xBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] locking/rwbase: Mitigate indefinite writer starvation
Message-ID: <Y+0W0wgyaJqYHKoj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mel Gorman <mgorman@techsingularity.net>

rw_semaphore and rwlock are explicitly unfair to writers in the presence
of readers by design with a PREEMPT_RT configuration. Commit 943f0edb754f
("locking/rt: Add base code for RT rw_semaphore and rwlock") notes;

        The implementation is writer unfair, as it is not feasible to do
        priority inheritance on multiple readers, but experience has shown
        that real-time workloads are not the typical workloads which are
        sensitive to writer starvation.

While atypical, it's also trivial to block writers with PREEMPT_RT
indefinitely without ever making forward progress. Since LTP-20220121,
the dio_truncate test case went from having 1 reader to having 16 readers
and the number of readers is sufficient to prevent the down_write ever
succeeding while readers exist. Eventually the test is killed after 30
minutes as a failure.

dio_truncate is not a realtime application but indefinite writer starvation
is undesirable. The test case has one writer appending and truncating files
A and B while multiple readers read file A. The readers and writer are
contending for one file's inode lock which never succeeds as the readers
keep reading until the writer is done which never happens.

Record a timestamp when the first writer is blocked and force all new
readers into the slow path upon expiration. Set the timeout to 4ms or
one tick which aligns with the generic implementation of rwsem.
This is sufficient to allow the dio_truncate test case to complete
within the 30 minutes timeout.

[bigeasy@linutronix.de: Fix overflow, close race against reader, match rwsem
			timeouts, simplification, don't prefer RT/DL reader
			as per tglx suggestion.]

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
- v4 https://lore.kernel.org/20230120140847.4pjqf3oinemokcyp@techsingularity.net
    - Reworded last paragraph of the commit message as Mel's suggestion
    - RT/DL tasks are no longer excluded from the waiter timeout. There
      is no reason why this should be done since no RT user relies on
      rwsem (and would need this kind of behaviour). The critical user
      from RT perspective replaced rwsem with RCU.
      Avoiding special treatment avoids this kind of bug with RT
      readers.
    - Update comments accordingly.

 include/linux/rwbase_rt.h  |  3 +++
 kernel/locking/rwbase_rt.c | 37 +++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 1d264dd086250..b969b1d9bb85c 100644
--- a/include/linux/rwbase_rt.h
+++ b/include/linux/rwbase_rt.h
@@ -10,12 +10,14 @@
 
 struct rwbase_rt {
 	atomic_t		readers;
+	unsigned long		waiter_timeout;
 	struct rt_mutex_base	rtmutex;
 };
 
 #define __RWBASE_INITIALIZER(name)				\
 {								\
 	.readers = ATOMIC_INIT(READER_BIAS),			\
+	.waiter_timeout = 0,					\
 	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(name.rtmutex),	\
 }
 
@@ -23,6 +25,7 @@ struct rwbase_rt {
 	do {							\
 		rt_mutex_base_init(&(rwbase)->rtmutex);		\
 		atomic_set(&(rwbase)->readers, READER_BIAS);	\
+		(rwbase)->waiter_timeout = 0;			\
 	} while (0)
 
 
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index c201aadb93017..dfd133672de86 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -38,8 +38,10 @@
  * Implementing the one by one reader boosting/handover mechanism is a
  * major surgery for a very dubious value.
  *
- * The risk of writer starvation is there, but the pathological use cases
- * which trigger it are not necessarily the typical RT workloads.
+ * Writer starvation is avoided by forcing all reader acquisitions into the slow
+ * path once the writer is blocked for more than RWBASE_RT_WAIT_TIMEOUT jiffies.
+ * The writer owns the rtmutex at the time it sets the timeout which guarantees
+ * that it will be the new lock owner once all active reader leave.
  *
  * Fast-path orderings:
  * The lock/unlock of readers can run in fast paths: lock and unlock are only
@@ -65,6 +67,22 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 	return 0;
 }
 
+/*
+ * Allow reader bias with a pending writer for a minimum of 4ms or 1 tick. This
+ * matches RWSEM_WAIT_TIMEOUT for the generic RWSEM implementation.
+ */
+#define RWBASE_RT_WAIT_TIMEOUT DIV_ROUND_UP(HZ, 250)
+
+static bool __sched rwbase_allow_reader_bias(struct rwbase_rt *rwb)
+{
+	/* Allow reader bias if no writer is blocked. */
+	if (!rwb->waiter_timeout)
+		return true;
+
+	/* Allow reader bias unless a writer timeout has expired. */
+	return time_before(jiffies, rwb->waiter_timeout);
+}
+
 static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 				      unsigned int state)
 {
@@ -74,9 +92,11 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 	raw_spin_lock_irq(&rtm->wait_lock);
 	/*
 	 * Allow readers, as long as the writer has not completely
-	 * acquired the semaphore for write.
+	 * acquired the semaphore for write and reader bias is still
+	 * allowed.
 	 */
-	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
+	if (atomic_read(&rwb->readers) != WRITER_BIAS &&
+	    rwbase_allow_reader_bias(rwb)) {
 		atomic_inc(&rwb->readers);
 		raw_spin_unlock_irq(&rtm->wait_lock);
 		return 0;
@@ -255,6 +275,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 	for (;;) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
+			rwb->waiter_timeout = 0;
 			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
 			trace_contention_end(rwb, -EINTR);
@@ -264,12 +285,20 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		if (__rwbase_write_trylock(rwb))
 			break;
 
+		/*
+		 * Record timeout when reader bias is ignored. Ensure timeout
+		 * is at least 1 in case of overflow.
+		 */
+		rwb->waiter_timeout = (jiffies + RWBASE_RT_WAIT_TIMEOUT) | 1;
+
 		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 		rwbase_schedule();
 		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 
 		set_current_state(state);
 	}
+
+	rwb->waiter_timeout = 0;
 	rwbase_restore_current_state();
 	trace_contention_end(rwb, 0);
 
-- 
2.39.1

