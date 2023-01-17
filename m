Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CF366E07E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjAQOZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjAQOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:24:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B0F1C306;
        Tue, 17 Jan 2023 06:22:41 -0800 (PST)
Date:   Tue, 17 Jan 2023 15:22:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673965358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rNbRUq17jXca6tXC9u5GgCkkefHgg4QVQCXss833Bc=;
        b=cf0DDugTrpbViSovrf0++ZeIl/5rAcjhz4FV299F2W05nHIEhd0ozFEb2cPNs7rjV7qAyU
        GYJH0ANcfWNUYmYc3DWevC27bHJCbumOjwWlxnJKASH8ML0vSl9AgATb7ICSJkUBTky9OB
        Qcy0UjmnhbdiF6F/qACROrwGHOyq48GP7Rj3w9B2PoIY+Wr0ke9nhe+1Uhidb1a+XBaP1U
        99JnBWIn4RaILadXixunQlzQyZ58R5T59e+8zQfyuI5oVd5Tk7uYwmDddVN8WIpmZB2k9Q
        ZtZsOhKFHxUoP54HqmUkG1hjkEho69Mb+MOIrAx6zAoJ70MPaKl5hJeLlVbsRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673965358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rNbRUq17jXca6tXC9u5GgCkkefHgg4QVQCXss833Bc=;
        b=cI3GLTo9pTXge6PUPWObzW/e4e9TG5xFHfTVLPwgZ8umeT3sevkYJZvGVYBliVpJ+a7msl
        gPnI5Y+O7mus5wBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y8avJm1FQI9vB9cv@linutronix.de>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-17 08:38:17 [+0000], Mel Gorman wrote:
> rw_semaphore and rwlock are explicitly unfair to writers in the presense
> of readers by design with a PREEMPT_RT configuration. Commit 943f0edb754f
> ("locking/rt: Add base code for RT rw_semaphore and rwlock") notes;
> 
>         The implementation is writer unfair, as it is not feasible to do
>         priority inheritance on multiple readers, but experience has shown
>         that real-time workloads are not the typical workloads which are
>         sensitive to writer starvation.
> 
> While atypical, it's also trivial to block writers with PREEMPT_RT
> indefinitely without ever making forward progress. Since LTP-20220121,
> the dio_truncate test case went from having 1 reader to having 16 readers
> and the number of readers is sufficient to prevent the down_write ever
> succeeding while readers exist. Eventually the test is killed after 30
> minutes as a failure.
> 
> dio_truncate is not a realtime application but indefinite writer starvation

If so then the PI boosting would not work if we would have it ;)

> is undesirable. The test case has one writer appending and truncating files
> A and B while multiple readers read file A. The readers and writer are
> contending for one file's inode lock which never succeeds as the readers
> keep reading until the writer is done which never happens.

This tests the implementation of rwsem/ rwlock functionality to ensure
that it is not writer unfair.

> This patch records a timestamp when the first writer is blocked if no
> deadline or realtime task has recently acquired the lock for read. If
> dt/rt tasks are involved, then reader bias is preserved. For other tasks,
DL/ RT. Would it work to use the capital letters if it refers to the
scheduling class?

> reader bias is allowed until the first writer has been blocked for a minimum
> of 4ms or 1 tick. The cutoff time is arbitrary on the assumption that a
> normal application contending for 4ms also does not need PREEMPT_RT. On
> a test machine, the test completed in 88 seconds.

I would go for one second just because it _usually_ does not matter
since none of the important locks rely on that (as stated in the commit
message). But then why not use the 4ms/ 1 tick as you suggest. This is
after all what the NON-PREEMPT_RT implementation is using to ensure that
the writer is not stalled infinitely. The RWLOCK implementation is
already writer unfair.

Side note: If the test case gets updated to RT reader which acquire the
lock (the whole time) then they will block writer again :)

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/rwbase_rt.h  |  3 ++
>  kernel/locking/rwbase_rt.c | 84 +++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 82 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
> index 1d264dd08625..05c4dc74b8bd 100644
> --- a/include/linux/rwbase_rt.h
> +++ b/include/linux/rwbase_rt.h
> @@ -10,12 +10,14 @@
>  
>  struct rwbase_rt {
>  	atomic_t		readers;
> +	unsigned long		waiter_blocked;
>  	struct rt_mutex_base	rtmutex;
>  };
>  
>  #define __RWBASE_INITIALIZER(name)				\
>  {								\
>  	.readers = ATOMIC_INIT(READER_BIAS),			\
> +	.waiter_blocked = 0,					\
>  	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(name.rtmutex),	\
>  }
>  
> @@ -23,6 +25,7 @@ struct rwbase_rt {
>  	do {							\
>  		rt_mutex_base_init(&(rwbase)->rtmutex);		\
>  		atomic_set(&(rwbase)->readers, READER_BIAS);	\
> +		(rwbase)->waiter_blocked = 0;			\
>  	} while (0)
>  
>  
> diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> index c201aadb9301..db2f6accf49f 100644
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -39,7 +39,11 @@
>   * major surgery for a very dubious value.
>   *
>   * The risk of writer starvation is there, but the pathological use cases
> - * which trigger it are not necessarily the typical RT workloads.
> + * which trigger it are not necessarily the typical RT workloads. The worst
> + * case of indefinite starvation of a writer will force readers into the
> + * slow path if a writer is blocked for more than RW_CONTENTION_THRESHOLD
> + * jiffies unless dl/rt tasks have taken a read lock since the last write
DL/RT please.

> + * unlock.
>   *
>   * Fast-path orderings:
>   * The lock/unlock of readers can run in fast paths: lock and unlock are only
> @@ -65,6 +69,61 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
>  	return 0;
>  }
>  
> +/*
> + * Allow reader bias with a pending writer for a minimum of 4ms or 1 tick.

    * This matches RWSEM_WAIT_TIMEOUT for the generic RWSEM
    * implementation.

> + * The granularity is not exact as the lowest bit in rwbase_rt->waiter_blocked
> + * is used to detect recent rt/dl tasks taking a read lock.
> + */
> +#define RW_CONTENTION_THRESHOLD (HZ/250+1)
				   DIV_ROUND_UP(HZ, 250)

> +static void __sched update_dlrt_reader(struct rwbase_rt *rwb)
> +{
> +	/* No update required if dl/rt tasks already identified. */
> +	if (rwb->waiter_blocked & 1)
> +		return;
> +
> +	/*
> +	 * Record a dl/rt task acquiring the lock for read. This may result
DL/RT
> +	 * in indefinite writer starvation but dl/rt tasks should avoid such
> +	 * behaviour.
> +	 */
> +	if (dl_task(current) || rt_task(current)) {

There is also task_is_realtime(). But using only rt_task() should work
since it also covers dl_task().

> +		struct rt_mutex_base *rtm = &rwb->rtmutex;
> +		unsigned long flags;
> +
> +		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> +		rwb->waiter_blocked |= 1;
> +		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> +	}
> +}
> +
> +/* rtmutex->wait_lock must be held. */
> +static void __sched set_writer_blocked(struct rwbase_rt *rwb)
> +{
> +	/*
> +	 * Lowest bit preserved to identify recent rt/dl tasks acquiring
> +	 * the lock for read so guarantee at least one tick delay.
> +	 */
> +	rwb->waiter_blocked |= (jiffies + 2) & ~1UL;

I'm unsure what |= means in terms of multiple writers. It seems to
extend the wait period and the second writer has none after the first
one leaves.

> +}
> +
> +static bool __sched rwbase_allow_reader_bias(struct rwbase_rt *rwb)
> +{
> +	/*
> +	 * Allow reader bias if a dl or rt task took the lock for read
> +	 * since the last write unlock. Such tasks should be designed
> +	 * to avoid heavy writer contention or indefinite starvation.
> +	 */
> +	if (rwb->waiter_blocked & 1)
> +		return true;
> +
> +	/*
> +	 * Allow reader bias unless a writer has been blocked for more
> +	 * than RW_CONTENTION_THRESHOLD jiffies.
> +	 */
> +	return jiffies - rwb->waiter_blocked < RW_CONTENTION_THRESHOLD;

if you set
	rwb->waiter_blocked = jiffies + RW_CONTENTION_THRESHOLD

then you could use
	time_after(jiffies, waiter->waiter_blocked)

and we could name it timeout. So the first writer sets it and my guess
would be that the each RT reader ignores this delay while every non-RT
tries to acquire the lock unless as long as the timeout did not occur.
Then they back off and wait for one writer to acquire the lock.
I don't know what we do with the possible second writer but I guess
first writer on unlock should reset the timeout for the next writer. So
we have again reader followed by writer.

> +}
> +
>  static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
>  				      unsigned int state)
>  {
> @@ -74,9 +133,11 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
>  	raw_spin_lock_irq(&rtm->wait_lock);
>  	/*
>  	 * Allow readers, as long as the writer has not completely
> -	 * acquired the semaphore for write.
> +	 * acquired the semaphore for write and reader bias is still
> +	 * allowed.
>  	 */
> -	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
> +	if (atomic_read(&rwb->readers) != WRITER_BIAS &&
> +	    rwbase_allow_reader_bias(rwb)) {
>  		atomic_inc(&rwb->readers);
>  		raw_spin_unlock_irq(&rtm->wait_lock);
>  		return 0;
> @@ -140,10 +201,18 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
>  static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
>  					    unsigned int state)
>  {
> +	int ret;
> +
>  	if (rwbase_read_trylock(rwb))
> -		return 0;
> +		ret = 0;
> +	else
> +		ret = __rwbase_read_lock(rwb, state);
> +
> +	/* Record if the current task acquiring the lock is a dl/rt task. */
> +	if (!ret)
> +		update_dlrt_reader(rwb);
>  
> -	return __rwbase_read_lock(rwb, state);
> +	return ret;
>  }
>  
>  static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
> @@ -264,12 +333,17 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  		if (__rwbase_write_trylock(rwb))
>  			break;
>  
> +		/* Record first new read/write contention. */
> +		set_writer_blocked(rwb);
> +
>  		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
>  		rwbase_schedule();
>  		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
>  
>  		set_current_state(state);
>  	}
> +
> +	rwb->waiter_blocked = 0;
>  	rwbase_restore_current_state();
>  	trace_contention_end(rwb, 0);
>  

Sebastian
