Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF0660215
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjAFO2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAFO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:27:59 -0500
Received: from outbound-smtp52.blacknight.com (outbound-smtp52.blacknight.com [46.22.136.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302EE1A059
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:27:57 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp52.blacknight.com (Postfix) with ESMTPS id 7A27CFA9B3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:27:55 +0000 (GMT)
Received: (qmail 25837 invoked from network); 6 Jan 2023 14:27:55 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 6 Jan 2023 14:27:55 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH] locking/rwbase: Prevent indefinite writer starvation
Date:   Fri,  6 Jan 2023 14:27:43 +0000
Message-Id: <20230106142743.30759-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
succeeding while readers exist. Ultimately the test is killed after 30
minutes as a failure.

dio_truncate is not a realtime application but indefinite writer starvation
is undesirable. The test case has one writer appending and truncating files
A and B while multiple readers read file A.  The readers and writer are
contending for one file's inode lock which never succeeds as the readers
keep reading until the writer is done which never happens.

This patch records a timestamp when the first writer is blocked. Reader
bias is allowed until the first writer has been blocked for a minimum of
4ms and a maximum of (4ms + 1 jiffie). The cutoff time is arbitrary on
the assumption that a hard realtime application missing a 4ms deadline
would not need PRREMPT_RT. It's expected that hard realtime applications
avoid such heavy reader/writer contention by design. On a test machine,
the test completed in 92 seconds.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/rwbase_rt.h  |  3 +++
 kernel/locking/rwbase_rt.c | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 1d264dd08625..05c4dc74b8bd 100644
--- a/include/linux/rwbase_rt.h
+++ b/include/linux/rwbase_rt.h
@@ -10,12 +10,14 @@
 
 struct rwbase_rt {
 	atomic_t		readers;
+	unsigned long		waiter_blocked;
 	struct rt_mutex_base	rtmutex;
 };
 
 #define __RWBASE_INITIALIZER(name)				\
 {								\
 	.readers = ATOMIC_INIT(READER_BIAS),			\
+	.waiter_blocked = 0,					\
 	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(name.rtmutex),	\
 }
 
@@ -23,6 +25,7 @@ struct rwbase_rt {
 	do {							\
 		rt_mutex_base_init(&(rwbase)->rtmutex);		\
 		atomic_set(&(rwbase)->readers, READER_BIAS);	\
+		(rwbase)->waiter_blocked = 0;			\
 	} while (0)
 
 
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index c201aadb9301..492bcfa7572c 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -65,6 +65,9 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 	return 0;
 }
 
+/* Allow reader bias with a pending writer for a minimum of 4ms or 1 tick. */
+#define RW_CONTENTION_THRESHOLD (HZ/250+1)
+
 static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 				      unsigned int state)
 {
@@ -76,7 +79,8 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 	 * Allow readers, as long as the writer has not completely
 	 * acquired the semaphore for write.
 	 */
-	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
+	if (atomic_read(&rwb->readers) != WRITER_BIAS &&
+	    jiffies - rwb->waiter_blocked < RW_CONTENTION_THRESHOLD) {
 		atomic_inc(&rwb->readers);
 		raw_spin_unlock_irq(&rtm->wait_lock);
 		return 0;
@@ -264,12 +268,18 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		if (__rwbase_write_trylock(rwb))
 			break;
 
+		/* Record first new read/write contention. */
+		if (!rwb->waiter_blocked)
+			rwb->waiter_blocked = jiffies;
+
 		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 		rwbase_schedule();
 		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 
 		set_current_state(state);
 	}
+
+	rwb->waiter_blocked = 0;
 	rwbase_restore_current_state();
 	trace_contention_end(rwb, 0);
 
-- 
2.35.3

