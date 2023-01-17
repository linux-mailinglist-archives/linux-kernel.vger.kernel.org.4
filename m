Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799B866E40D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjAQQub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjAQQu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:50:27 -0500
Received: from outbound-smtp48.blacknight.com (outbound-smtp48.blacknight.com [46.22.136.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D39EF2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:50:24 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id F3D21FA7DC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:50:22 +0000 (GMT)
Received: (qmail 16444 invoked from network); 17 Jan 2023 16:50:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jan 2023 16:50:22 -0000
Date:   Tue, 17 Jan 2023 16:50:21 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y8avJm1FQI9vB9cv@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 03:22:30PM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-01-17 08:38:17 [+0000], Mel Gorman wrote:
> > rw_semaphore and rwlock are explicitly unfair to writers in the presense
> > of readers by design with a PREEMPT_RT configuration. Commit 943f0edb754f
> > ("locking/rt: Add base code for RT rw_semaphore and rwlock") notes;
> > 
> >         The implementation is writer unfair, as it is not feasible to do
> >         priority inheritance on multiple readers, but experience has shown
> >         that real-time workloads are not the typical workloads which are
> >         sensitive to writer starvation.
> > 
> > While atypical, it's also trivial to block writers with PREEMPT_RT
> > indefinitely without ever making forward progress. Since LTP-20220121,
> > the dio_truncate test case went from having 1 reader to having 16 readers
> > and the number of readers is sufficient to prevent the down_write ever
> > succeeding while readers exist. Eventually the test is killed after 30
> > minutes as a failure.
> > 
> > dio_truncate is not a realtime application but indefinite writer starvation
> 
> If so then the PI boosting would not work if we would have it ;)
> 

True, but it's still undesirable for a basic functional test using normal
tasks with no prioritisation to stall forever.

> > is undesirable. The test case has one writer appending and truncating files
> > A and B while multiple readers read file A. The readers and writer are
> > contending for one file's inode lock which never succeeds as the readers
> > keep reading until the writer is done which never happens.
> 
> This tests the implementation of rwsem/ rwlock functionality to ensure
> that it is not writer unfair.
> 

Also true but in this case at least, the test's tasks do not care about
priority inheritance.

> > This patch records a timestamp when the first writer is blocked if no
> > deadline or realtime task has recently acquired the lock for read. If
> > dt/rt tasks are involved, then reader bias is preserved. For other tasks,
> DL/ RT. Would it work to use the capital letters if it refers to the
> scheduling class?
> 

Sure.

> > reader bias is allowed until the first writer has been blocked for a minimum
> > of 4ms or 1 tick. The cutoff time is arbitrary on the assumption that a
> > normal application contending for 4ms also does not need PREEMPT_RT. On
> > a test machine, the test completed in 88 seconds.
> 
> I would go for one second just because it _usually_ does not matter
> since none of the important locks rely on that (as stated in the commit
> message). But then why not use the 4ms/ 1 tick as you suggest. This is
> after all what the NON-PREEMPT_RT implementation is using to ensure that
> the writer is not stalled infinitely. The RWLOCK implementation is
> already writer unfair.
> 

1 second is a relatively long time. The test would eventually complete
but not before the 30 minute timeout hits and kills the test anyway.
It makes more sense to explicitly make it similar to RWSEM_WAIT_TIMEOUT.

> Side note: If the test case gets updated to RT reader which acquire the
> lock (the whole time) then they will block writer again :)
> 

True, but in that case a RT-specific test showed that the lock is
writer unfair and no one is surprised. It's the test design equivalent
of "stop hitting yourself" until the lock is writer fair assuming that
happens.

> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  include/linux/rwbase_rt.h  |  3 ++
> >  kernel/locking/rwbase_rt.c | 84 +++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 82 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
> > index 1d264dd08625..05c4dc74b8bd 100644
> > --- a/include/linux/rwbase_rt.h
> > +++ b/include/linux/rwbase_rt.h
> > @@ -10,12 +10,14 @@
> >  
> >  struct rwbase_rt {
> >  	atomic_t		readers;
> > +	unsigned long		waiter_blocked;
> >  	struct rt_mutex_base	rtmutex;
> >  };
> >  
> >  #define __RWBASE_INITIALIZER(name)				\
> >  {								\
> >  	.readers = ATOMIC_INIT(READER_BIAS),			\
> > +	.waiter_blocked = 0,					\
> >  	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(name.rtmutex),	\
> >  }
> >  
> > @@ -23,6 +25,7 @@ struct rwbase_rt {
> >  	do {							\
> >  		rt_mutex_base_init(&(rwbase)->rtmutex);		\
> >  		atomic_set(&(rwbase)->readers, READER_BIAS);	\
> > +		(rwbase)->waiter_blocked = 0;			\
> >  	} while (0)
> >  
> >  
> > diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> > index c201aadb9301..db2f6accf49f 100644
> > --- a/kernel/locking/rwbase_rt.c
> > +++ b/kernel/locking/rwbase_rt.c
> > @@ -39,7 +39,11 @@
> >   * major surgery for a very dubious value.
> >   *
> >   * The risk of writer starvation is there, but the pathological use cases
> > - * which trigger it are not necessarily the typical RT workloads.
> > + * which trigger it are not necessarily the typical RT workloads. The worst
> > + * case of indefinite starvation of a writer will force readers into the
> > + * slow path if a writer is blocked for more than RW_CONTENTION_THRESHOLD
> > + * jiffies unless dl/rt tasks have taken a read lock since the last write
>
> DL/RT please.
> 

Done.

> > + * unlock.
> >   *
> >   * Fast-path orderings:
> >   * The lock/unlock of readers can run in fast paths: lock and unlock are only
> > @@ -65,6 +69,61 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Allow reader bias with a pending writer for a minimum of 4ms or 1 tick.
> 
>     * This matches RWSEM_WAIT_TIMEOUT for the generic RWSEM
>     * implementation.
> 

Done, but I also renamed the threshold to RWBASE_RT_WAIT_TIMEOUT.

> > + * The granularity is not exact as the lowest bit in rwbase_rt->waiter_blocked
> > + * is used to detect recent rt/dl tasks taking a read lock.
> > + */
> > +#define RW_CONTENTION_THRESHOLD (HZ/250+1)
> 				   DIV_ROUND_UP(HZ, 250)
> 
> > +static void __sched update_dlrt_reader(struct rwbase_rt *rwb)
> > +{
> > +	/* No update required if dl/rt tasks already identified. */
> > +	if (rwb->waiter_blocked & 1)
> > +		return;
> > +
> > +	/*
> > +	 * Record a dl/rt task acquiring the lock for read. This may result
> DL/RT
> > +	 * in indefinite writer starvation but dl/rt tasks should avoid such
> > +	 * behaviour.
> > +	 */
> > +	if (dl_task(current) || rt_task(current)) {
> 
> There is also task_is_realtime(). But using only rt_task() should work
> since it also covers dl_task().

True, changed to rt_task only. 

> 
> > +		struct rt_mutex_base *rtm = &rwb->rtmutex;
> > +		unsigned long flags;
> > +
> > +		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> > +		rwb->waiter_blocked |= 1;
> > +		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> > +	}
> > +}
> > +
> > +/* rtmutex->wait_lock must be held. */
> > +static void __sched set_writer_blocked(struct rwbase_rt *rwb)
> > +{
> > +	/*
> > +	 * Lowest bit preserved to identify recent rt/dl tasks acquiring
> > +	 * the lock for read so guarantee at least one tick delay.
> > +	 */
> > +	rwb->waiter_blocked |= (jiffies + 2) & ~1UL;
> 
> I'm unsure what |= means in terms of multiple writers. It seems to
> extend the wait period and the second writer has none after the first
> one leaves.
> 

That's an oversight as v1 only covered the first writer. The unguarded
check turns into garbage for multiple writers.

> > +}
> > +
> > +static bool __sched rwbase_allow_reader_bias(struct rwbase_rt *rwb)
> > +{
> > +	/*
> > +	 * Allow reader bias if a dl or rt task took the lock for read
> > +	 * since the last write unlock. Such tasks should be designed
> > +	 * to avoid heavy writer contention or indefinite starvation.
> > +	 */
> > +	if (rwb->waiter_blocked & 1)
> > +		return true;
> > +
> > +	/*
> > +	 * Allow reader bias unless a writer has been blocked for more
> > +	 * than RW_CONTENTION_THRESHOLD jiffies.
> > +	 */
> > +	return jiffies - rwb->waiter_blocked < RW_CONTENTION_THRESHOLD;
> 
> if you set
> 	rwb->waiter_blocked = jiffies + RW_CONTENTION_THRESHOLD
> 
> then you could use
> 	time_after(jiffies, waiter->waiter_blocked)
> 
> and we could name it timeout. So the first writer sets it and my guess
> would be that the each RT reader ignores this delay while every non-RT
> tries to acquire the lock unless as long as the timeout did not occur.
> Then they back off and wait for one writer to acquire the lock.
> I don't know what we do with the possible second writer but I guess
> first writer on unlock should reset the timeout for the next writer. So
> we have again reader followed by writer.
> 

The second writer was an oversight. I think it's better to keep it simple
and let the first writer blocked determine when reader bias finishes.
The timeout resets when the write lock is released.

Thanks Sebastian. Based on your feedback, v3 looks like this

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

This patch records a timestamp when the first writer is blocked if no
deadline or realtime task has recently acquired the lock for read. If DT / RT
tasks are involved, then reader bias priority inheritance is preserved. For
other tasks, reader bias is allowed until the first writer has been blocked
for a minimum of 4ms similar to RWSEM_WAIT_TIMEOUT.  This is sufficient
to allow the test case to complete within the 30 minutes timeout.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/rwbase_rt.h  |  3 ++
 kernel/locking/rwbase_rt.c | 87 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 5 deletions(-)

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
index c201aadb9301..99d81e8d1f25 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -39,7 +39,11 @@
  * major surgery for a very dubious value.
  *
  * The risk of writer starvation is there, but the pathological use cases
- * which trigger it are not necessarily the typical RT workloads.
+ * which trigger it are not necessarily the typical RT workloads. The worst
+ * case of indefinite starvation of a writer will force readers into the
+ * slow path if a writer is blocked for more than RWBASE_RT_WAIT_TIMEOUT
+ * jiffies unless DL / RT tasks have taken a read lock since the last write
+ * unlock.
  *
  * Fast-path orderings:
  * The lock/unlock of readers can run in fast paths: lock and unlock are only
@@ -65,6 +69,64 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 	return 0;
 }
 
+/*
+ * Allow reader bias with a pending writer for a minimum of 4ms or 1 tick.
+ * This matches RWSEM_WAIT_TIMEOUT for the generic RWSEM implementation.
+ * The granularity is not exact as the lowest bit in rwbase_rt->waiter_timeout
+ * is used to detect recent DL / RT tasks taking a read lock.
+ */
+#define RWBASE_RT_WAIT_TIMEOUT DIV_ROUND_UP(HZ, 250)
+
+static void __sched update_dlrt_reader(struct rwbase_rt *rwb)
+{
+	/* No update required if DL / RT tasks already identified. */
+	if (rwb->waiter_timeout & 1)
+		return;
+
+	/*
+	 * Record a DL / RT task acquiring the lock for read. This may result
+	 * in indefinite writer starvation but DL / RT tasks should avoid such
+	 * behaviour.
+	 */
+	if (rt_task(current)) {
+		struct rt_mutex_base *rtm = &rwb->rtmutex;
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+		rwb->waiter_timeout |= 1;
+		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+	}
+}
+
+/* rtmutex->wait_lock must be held. */
+static void __sched set_writer_blocked(struct rwbase_rt *rwb)
+{
+	/*
+	 * Record the timeout based on the the first writer to block. The
+	 * lowest bit is used to identify recent DL / RT tasks acquiring the
+	 * lock for read so guarantee at least one tick delay.
+	 */
+	if (rwb->waiter_timeout <= 1) {
+		unsigned long timeout = jiffies + RWBASE_RT_WAIT_TIMEOUT + 2;
+
+		rwb->waiter_timeout |= timeout & ~1UL;
+	}
+}
+
+static bool __sched rwbase_allow_reader_bias(struct rwbase_rt *rwb)
+{
+	/*
+	 * Allow reader bias if a DL / RT task took the lock for read
+	 * since the last write unlock. Such tasks should be designed
+	 * to avoid heavy writer contention or indefinite starvation.
+	 */
+	if (rwb->waiter_timeout & 1)
+		return true;
+
+	/* Allow reader bias unless a writer timeout is reached. */
+	return time_before(jiffies, rwb->waiter_timeout);
+}
+
 static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 				      unsigned int state)
 {
@@ -74,9 +136,11 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
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
@@ -140,10 +204,18 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
 					    unsigned int state)
 {
+	int ret;
+
 	if (rwbase_read_trylock(rwb))
-		return 0;
+		ret = 0;
+	else
+		ret = __rwbase_read_lock(rwb, state);
+
+	/* Record if the current task acquiring the lock is a DL / RT task. */
+	if (!ret)
+		update_dlrt_reader(rwb);
 
-	return __rwbase_read_lock(rwb, state);
+	return ret;
 }
 
 static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
@@ -264,12 +336,17 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
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
 
