Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F0C675657
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjATOI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjATOIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:08:54 -0500
Received: from outbound-smtp58.blacknight.com (outbound-smtp58.blacknight.com [46.22.136.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CF1BC8BC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:08:50 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp58.blacknight.com (Postfix) with ESMTPS id 4E42DFAE01
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:08:49 +0000 (GMT)
Received: (qmail 32017 invoked from network); 20 Jan 2023 14:08:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Jan 2023 14:08:48 -0000
Date:   Fri, 20 Jan 2023 14:08:47 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] locking/rwbase: Mitigate indefinite writer starvation
Message-ID: <20230120140847.4pjqf3oinemokcyp@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rw_semaphore and rwlock are explicitly unfair to writers in the presense
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

This patch records a timestamp when the first writer is blocked. DL /
RT tasks can continue to take the lock for read as long as readers exist
indefinitely. Other readers can acquire the read lock unless a writer
has been blocked for a minimum of 4ms. This is sufficient to allow the
dio_truncate test case to complete within the 30 minutes timeout.

[bigeasy@linutronix.de: Fix overflow, close race against reader, match rwsem
			timeouts, better rt_task handling, simplification]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rwbase_rt.h  |  3 +++
 kernel/locking/rwbase_rt.c | 41 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 1d264dd08625..b969b1d9bb85 100644
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
index c201aadb9301..24fafe16e008 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -39,7 +39,10 @@
  * major surgery for a very dubious value.
  *
  * The risk of writer starvation is there, but the pathological use cases
- * which trigger it are not necessarily the typical RT workloads.
+ * which trigger it are not necessarily the typical RT workloads. SCHED_OTHER
+ * reader acquisitions will be forced into the slow path if a writer is
+ * blocked for more than RWBASE_RT_WAIT_TIMEOUT jiffies. New DL / RT readers
+ * can still starve a writer indefinitely.
  *
  * Fast-path orderings:
  * The lock/unlock of readers can run in fast paths: lock and unlock are only
@@ -65,6 +68,27 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 	return 0;
 }
 
+/*
+ * Allow reader bias for SCHED_OTHER tasks with a pending writer for a
+ * minimum of 4ms or 1 tick. This matches RWSEM_WAIT_TIMEOUT for the
+ * generic RWSEM implementation.
+ */
+#define RWBASE_RT_WAIT_TIMEOUT DIV_ROUND_UP(HZ, 250)
+
+static bool __sched rwbase_allow_reader_bias(struct rwbase_rt *rwb)
+{
+	/*
+	 * Allow reader bias if no writer is blocked or for DL / RT tasks.
+	 * Such tasks should be designed to avoid heavy writer contention
+	 * or indefinite starvation.
+	 */
+	if (!rwb->waiter_timeout || rt_task(current))
+		return true;
+
+	/* Allow reader bias unless a writer timeout has expired. */
+	return time_before(jiffies, rwb->waiter_timeout);
+}
+
 static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 				      unsigned int state)
 {
@@ -74,9 +98,11 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
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
@@ -255,6 +281,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 	for (;;) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
+			rwb->waiter_timeout = 0;
 			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
 			trace_contention_end(rwb, -EINTR);
@@ -264,12 +291,20 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
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
Mel Gorman
SUSE Labs
