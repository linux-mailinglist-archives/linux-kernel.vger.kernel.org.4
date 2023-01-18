Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FD06724FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjARRcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjARRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:32:01 -0500
Received: from outbound-smtp40.blacknight.com (outbound-smtp40.blacknight.com [46.22.139.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EE958670
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:31:34 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id CC22E1C392F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:31:32 +0000 (GMT)
Received: (qmail 18706 invoked from network); 18 Jan 2023 17:31:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jan 2023 17:31:32 -0000
Date:   Wed, 18 Jan 2023 17:31:30 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y8gPhTGkfCbGwoUu@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 04:25:57PM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-01-17 16:50:21 [+0000], Mel Gorman wrote:
> 
> > diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> > index c201aadb9301..99d81e8d1f25 100644
> > --- a/kernel/locking/rwbase_rt.c
> > +++ b/kernel/locking/rwbase_rt.c
> > @@ -65,6 +69,64 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Allow reader bias with a pending writer for a minimum of 4ms or 1 tick.
> > + * This matches RWSEM_WAIT_TIMEOUT for the generic RWSEM implementation.
> > + * The granularity is not exact as the lowest bit in rwbase_rt->waiter_timeout
> > + * is used to detect recent DL / RT tasks taking a read lock.
> > + */
> > +#define RWBASE_RT_WAIT_TIMEOUT DIV_ROUND_UP(HZ, 250)
> > +
> > +static void __sched update_dlrt_reader(struct rwbase_rt *rwb)
> > +{
> > +	/* No update required if DL / RT tasks already identified. */
> > +	if (rwb->waiter_timeout & 1)
> > +		return;
> > +
> > +	/*
> > +	 * Record a DL / RT task acquiring the lock for read. This may result
> > +	 * in indefinite writer starvation but DL / RT tasks should avoid such
> > +	 * behaviour.
> > +	 */
> > +	if (rt_task(current)) {
> > +		struct rt_mutex_base *rtm = &rwb->rtmutex;
> > +		unsigned long flags;
> > +
> > +		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> > +		rwb->waiter_timeout |= 1;
> 
> Let me see of I parsed the whole logic right:
> 
> _After_ the RT reader acquired the lock, the lowest bit is set. This may
> be immediately if the timeout did not occur yet.
> With this flag set, all following reader incl. SCHED_OTHER will acquire
> the lock.
> 

Correct. The intent was to track if there were any DL / RT tasks since
the last write unlock in case there was a mix of SCHED_OTHER and rt_tasks
contending on the same lock with unknown arrival times.

> If so, then I don't know why this is a good idea.
> 
> If _only_ the RT reader is allowed to acquire the lock while the writer
> is waiting then it make sense to prefer the RT tasks. (So the check is
> on current and not on the lowest bit).
> All other (SCHED_OTHER) reader would have to block on the rtmutex after
> the timeout. This makes sense to avoid the starvation.
> 

Ok, fair enough.

> If we drop that "we prefer the RT reader" then it would block on the
> RTmutex. It will _still_ be preferred over the writer because it will be
> enqueued before the writer in the queue due to its RT priority. The only
> downside is that it has to wait until all readers are left.

The writer has to wait until all the readers have left anyway.

> So by allowing the RT reader to always acquire the lock as long as the
> WRITER_BIAS isn't set, we would allow to enter early while the other
> reader are still in and after the timeout you would only have RT reader
> going in and out. All SCHED_OTHER reader block on the RTmutex.
> 
> I think I like this.
> 

If I understand you correctly, the patch becomes this;

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

This patch records a timestamp when the first writer is blocked. DT /
RT tasks can continue to take the lock for read as long as readers exist
indefinitely. Other readers can acquire the read lock unless a writer
has been blocked for a minimum of 4ms. This is sufficient to allow the
dio_truncate test case to complete within the 30 minutes timeout.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/rwbase_rt.h  |  3 +++
 kernel/locking/rwbase_rt.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 3 deletions(-)

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
index c201aadb9301..84c5e4e4d25b 100644
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
@@ -65,6 +68,35 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 	return 0;
 }
 
+/*
+ * Allow reader bias for SCHED_OTHER tasks with a pending writer for a
+ * minimum of 4ms or 1 tick. This matches RWSEM_WAIT_TIMEOUT for the
+ * generic RWSEM implementation.
+ */
+#define RWBASE_RT_WAIT_TIMEOUT DIV_ROUND_UP(HZ, 250)
+
+/* rtmutex->wait_lock must be held. */
+static void __sched set_writer_blocked(struct rwbase_rt *rwb)
+{
+	/* Record the timeout based on the the first writer to block. */
+	if (!rwb->waiter_timeout)
+		rwb->waiter_timeout = jiffies + RWBASE_RT_WAIT_TIMEOUT;
+}
+
+static bool __sched rwbase_allow_reader_bias(struct rwbase_rt *rwb)
+{
+	/*
+	 * Allow reader bias for DL / RT tasks. Such tasks should be
+	 * designed to avoid heavy writer contention or indefinite
+	 * starvation.
+	 */
+	if (rt_task(current))
+		return true;
+
+	/* Allow reader bias unless a writer timeout is reached. */
+	return time_before(jiffies, rwb->waiter_timeout);
+}
+
 static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 				      unsigned int state)
 {
@@ -74,9 +106,11 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
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
@@ -264,12 +298,17 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		if (__rwbase_write_trylock(rwb))
 			break;
 
+		/* Record first new read/write contention. */
+		set_writer_blocked(rwb);
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
 
