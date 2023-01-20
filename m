Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219E46755B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjATNYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjATNYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:24:48 -0500
Received: from outbound-smtp48.blacknight.com (outbound-smtp48.blacknight.com [46.22.136.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95540BF8A6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:24:45 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id 0A427FAE0F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:24:43 +0000 (GMT)
Received: (qmail 16057 invoked from network); 20 Jan 2023 13:24:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Jan 2023 13:24:43 -0000
Date:   Fri, 20 Jan 2023 13:24:41 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230120132441.4jjke47rnpikiuf5@techsingularity.net>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
 <Y8j+lENBWNWgt4mf@linutronix.de>
 <20230119110220.kphftcehehhi5l5u@techsingularity.net>
 <Y8lvwKHmmnikVDgk@linutronix.de>
 <20230119174101.rddtxk5xlamlnquh@techsingularity.net>
 <Y8pP3CD1PQ4KWhXF@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y8pP3CD1PQ4KWhXF@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:25:00AM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-01-19 17:41:01 [+0000], Mel Gorman wrote:
> > 
> > Yes, it makes your concern much clearer but I'm not sure it actually matters
> > in terms of preventing write starvation or in terms of correctness. At
> > worst, a writer is blocked that could have acquired the lock during a tiny
> > race but that's a timing issue rather than a correctness issue.
> 
> Correct. My concern is that one reader may need to wait 4ms+ for the
> lock while a following reader (that one that sees the timeout) does not.
> This can lead to confusion later on.
> 

Ok, yes, that is a valid concern I had not considered when thinking in
terms of correctness or writer starvation. It would be very tricky to
diagnose if it happened.

> > The race could be closed by moving wait_lock acquisition before the
> > atomic_sub in rwbase_write_lock() but it expands the scope of the wait_lock
> > and I'm not sure that's necessary for either correctness or preventing
> > writer starvation. It's a more straight-forward fix but expanding the
> > scope of a lock unnecessarily has been unpopular in the past.
> > 
> > I think we can close the race that concerns you but I'm not convinced we
> > need to and changing the scope of wait_lock would need a big comment and
> > probably deserves a separate patch.
> 
> would it work to check the timeout vs 0 before and only apply the
> timeout check if it is != zero? The writer would need to unconditionally
> or the lowest bit. That should close gaps at a low price. The timeout
> variable is always read within the lock so there shouldn't be need for
> any additional barriers.
> 

Yes, as a bonus point, it can be checked early in rwbase_allow_reader_bias
and is an cheap test for the common case so it's win-win all round.

Patch is now this;

--8<--
locking/rwbase: Prevent indefinite writer starvation

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

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/rwbase_rt.h  |  3 +++
 kernel/locking/rwbase_rt.c | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

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
index c201aadb9301..9d5bbf2985de 100644
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
@@ -264,12 +291,17 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		if (__rwbase_write_trylock(rwb))
 			break;
 
+		/* Record timeout when reader bias is ignored. */
+		rwb->waiter_timeout = jiffies + RWBASE_RT_WAIT_TIMEOUT;
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
 
