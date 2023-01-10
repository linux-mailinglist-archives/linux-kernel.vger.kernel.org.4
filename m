Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE6663FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjAJMI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238345AbjAJMHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:07:43 -0500
Received: from outbound-smtp51.blacknight.com (outbound-smtp51.blacknight.com [46.22.136.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E7959FBD
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:05:16 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp51.blacknight.com (Postfix) with ESMTPS id 67425FAD25
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:04:49 +0000 (GMT)
Received: (qmail 14603 invoked from network); 10 Jan 2023 12:04:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Jan 2023 12:04:49 -0000
Date:   Tue, 10 Jan 2023 12:04:47 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230110120447.q7jtsk6i6lyu4wv5@techsingularity.net>
References: <20230106142743.30759-1-mgorman@techsingularity.net>
 <Y7wxjBN9bDaZ0BKo@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y7wxjBN9bDaZ0BKo@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 04:23:56PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 06, 2023 at 02:27:43PM +0000, Mel Gorman wrote:
> > rw_semaphore and rwlock are explicitly unfair to writers in the presense
> > of readers by design with a PREEMPT_RT configuration. Commit 943f0edb754f
> > ("locking/rt: Add base code for RT rw_semaphore and rwlock") notes;
> > 
> > 	The implementation is writer unfair, as it is not feasible to do
> > 	priority inheritance on multiple readers, but experience has shown
> > 	that real-time workloads are not the typical workloads which are
> > 	sensitive to writer starvation.
> > 
> > While atypical, it's also trivial to block writers with PREEMPT_RT
> > indefinitely without ever making forward progress. Since LTP-20220121,
> > the dio_truncate test case went from having 1 reader to having 16 readers
> > and the number of readers is sufficient to prevent the down_write ever
> > succeeding while readers exist. Ultimately the test is killed after 30
> > minutes as a failure.
> > 
> > dio_truncate is not a realtime application but indefinite writer starvation
> > is undesirable. The test case has one writer appending and truncating files
> > A and B while multiple readers read file A.  The readers and writer are
> > contending for one file's inode lock which never succeeds as the readers
> > keep reading until the writer is done which never happens.
> > 
> > This patch records a timestamp when the first writer is blocked. Reader
> > bias is allowed until the first writer has been blocked for a minimum of
> > 4ms and a maximum of (4ms + 1 jiffie). The cutoff time is arbitrary on
> > the assumption that a hard realtime application missing a 4ms deadline
> > would not need PRREMPT_RT. It's expected that hard realtime applications
> > avoid such heavy reader/writer contention by design. On a test machine,
> > the test completed in 92 seconds.
> 
> >  static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
> >  				      unsigned int state)
> >  {
> > @@ -76,7 +79,8 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
> >  	 * Allow readers, as long as the writer has not completely
> >  	 * acquired the semaphore for write.
> >  	 */
> > -	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
> > +	if (atomic_read(&rwb->readers) != WRITER_BIAS &&
> > +	    jiffies - rwb->waiter_blocked < RW_CONTENTION_THRESHOLD) {
> >  		atomic_inc(&rwb->readers);
> >  		raw_spin_unlock_irq(&rtm->wait_lock);
> >  		return 0;
> 
> Blergh.
> 

I'm not surprised at the reaction.

> So a number of comments:
> 
>  - this deserves a giant comment, not only an obscure extra condition.
> 

Easy enough.

>  - this would be better if it were limited to only have effect
>    when there are no RT/DL tasks involved.
> 

That's a little more involved but as a bonus, it gets lots of comments
at the cost of a loss of waiter_blocked granularity.

> This made me re-read the phase-fair rwlock paper and again note that RW
> semaphore (eg blocking) variant was delayed to future work and AFAICT
> this future hasn't happened yet :/
> 

Story of our lives. Is https://www.cs.unc.edu/~anderson/papers/ecrts09b.pdf
the right paper to start with? (just a quick search, haven't actually
read it)

> AFAICT it would still require boosting the readers (something tglx still
> has nightmares of) and limiting reader concurrency, another thing that
> hurts.
> 

I guess proxy execution would be part of that puzzle but even though I'm not
overly familiar with the problem, the more I think about it, the less fun
it gets. Even if readers were boosted, all of the readers have to complete
before the writer can go ahead so proxy execution would only help if the
writer had higher priority. I'm no expert but it occurs to me that blocking
readers for writes or proxy execution would have to assume that writers are
inherently high priority than readers regardless of their actual priority.
I guess that's mostly true but maybe there is a counter-example.

Taking mmap_sem as an example. A design stupid enough to mix critical threads
with low-priority threads that require malloc() within the same address
space would have a problem assuming the writer is higher priority. Then
again, the critical phase faulting memory and needing mmap_sem for read is
also broken behaviour. Same with inode semaphores, critical tasks doing
IO at all or IO to the same file is madness. I cannot think of a case
offhand where the writer is inherently less important than the reader *and*
contenting on the semaphore is reasonable behaviour for a RT task.

This is not tested or even booted but it tracks dl/rt task taking a lock for
read since the last write unlock. The major downside is additional overhead
in the read fast path the first time a rt/dl task acquires the lock for read.

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
index c201aadb9301..a732cbdd5a62 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -39,7 +39,11 @@
  * major surgery for a very dubious value.
  *
  * The risk of writer starvation is there, but the pathological use cases
- * which trigger it are not necessarily the typical RT workloads.
+ * which trigger it are not necessarily the typical RT workloads. The worst
+ * case of indefinite starvation of a writer will force readers into the
+ * slow path if a writer is blocked for more than RW_CONTENTION_THRESHOLD
+ * jiffies unless dl/rt tasks have taken a read lock since the last write
+ * unlock.
  *
  * Fast-path orderings:
  * The lock/unlock of readers can run in fast paths: lock and unlock are only
@@ -65,6 +69,67 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 	return 0;
 }
 
+/*
+ * Allow reader bias with a pending writer for a minimum of 4ms or 1 tick.
+ * The granularity is not exact as the lowest bit in rwbase_rt->waiter_blocked
+ * is used to detect recent rt/dl tasks taking a read lock.
+ */
+#define RW_CONTENTION_THRESHOLD (HZ/250+1)
+
+static void __sched update_dlrt_reader(struct rwbase_rt *rwb)
+{
+
+	/* No update required if dl/rt tasks already identified. */
+	if (rwb->waiter_blocked & 1)
+		return;
+
+	/*
+	 * Record a dl/rt task acquiring the lock for read. This may result
+	 * in indefinite writer starvation but dl/rt tasks should avoid such
+	 * behaviour.
+	 */
+	if (dl_task(current) || rt_task(current)) {
+		struct rt_mutex_base *rtm;
+		unsigned long flags;
+
+		rtm = &rwb->rtmutex;
+		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+
+		/* Guarantees at least 1 tick of a delay. */
+		rwb->waiter_blocked = (rwb->waiter_blocked + 1) | 1;
+
+		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+	}
+}
+
+/* rtmutex->wait_lock must be held. */
+static void __sched set_writer_blocked(struct rwbase_rt *rwb)
+{
+	/*
+	 * Lowest bit preserved to identify recent rt/dl tasks acquiring
+	 * the lock for read.
+	 */
+	rwb->waiter_blocked |= jiffies & ~1UL;
+}
+
+static bool __sched rwbase_allow_reader_bias(struct rwbase_rt *rwb)
+{
+	/*
+	 * Allow reader bias if a dl or rt task took the lock for read
+	 * since the last write unlock. Such tasks should be designed
+	 * to avoid heavy writer contention or indefinite starvation.
+	 */
+	if (rwb->waiter_blocked & 1)
+		return true;
+
+	/*
+	 * Allow reader bias unless a writer has been blocked for more
+	 * than RW_CONTENTION_THRESHOLD jiffies. This may break priority
+	 * inheritance for readers but avoid indefinite writer starvation.
+	 */
+	return jiffies - rwb->waiter_blocked < RW_CONTENTION_THRESHOLD;
+}
+
 static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 				      unsigned int state)
 {
@@ -74,9 +139,11 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
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
@@ -140,10 +207,18 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
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
 
-	return __rwbase_read_lock(rwb, state);
+	/* Record if the current task acquiring the lock is a dl/rt task. */
+	if (!ret)
+		update_dlrt_reader(rwb);
+
+	return ret;
 }
 
 static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
@@ -264,12 +339,17 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
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
+	rwb->waiter_blocked = 0;
 	rwbase_restore_current_state();
 	trace_contention_end(rwb, 0);
 
-- 
Mel Gorman
SUSE Labs
