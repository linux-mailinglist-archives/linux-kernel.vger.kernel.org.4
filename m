Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB43C67364A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjASLDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjASLC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:02:26 -0500
Received: from outbound-smtp37.blacknight.com (outbound-smtp37.blacknight.com [46.22.139.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFC751C77
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:02:24 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id DFBE71DF9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:02:22 +0000 (GMT)
Received: (qmail 16588 invoked from network); 19 Jan 2023 11:02:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Jan 2023 11:02:22 -0000
Date:   Thu, 19 Jan 2023 11:02:20 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230119110220.kphftcehehhi5l5u@techsingularity.net>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
 <Y8j+lENBWNWgt4mf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y8j+lENBWNWgt4mf@linutronix.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:25:56AM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-01-18 17:31:30 [+0000], Mel Gorman wrote:
>  > If we drop that "we prefer the RT reader" then it would block on the
> > > RTmutex. It will _still_ be preferred over the writer because it will be
> > > enqueued before the writer in the queue due to its RT priority. The only
> > > downside is that it has to wait until all readers are left.
> > 
> > The writer has to wait until all the readers have left anyway.
> 
> I meant the READER in case it has RT priority. It will enqueue itself on
> the RTmutex, first in line, and wait until all other READER leave.
> 

Ah.

> > If I understand you correctly, the patch becomes this;
> 
> exactly.
> 
> > --8<--
> ???
> > This patch records a timestamp when the first writer is blocked. DT /
> 
> s/DT/DL
> 

Fixed.

> > RT tasks can continue to take the lock for read as long as readers exist
> > indefinitely. Other readers can acquire the read lock unless a writer
> > has been blocked for a minimum of 4ms. This is sufficient to allow the
> > dio_truncate test case to complete within the 30 minutes timeout.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> ???
> > diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> > index c201aadb9301..84c5e4e4d25b 100644
> > --- a/kernel/locking/rwbase_rt.c
> > +++ b/kernel/locking/rwbase_rt.c
> > @@ -74,9 +106,11 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
> >  	raw_spin_lock_irq(&rtm->wait_lock);
> >  	/*
> >  	 * Allow readers, as long as the writer has not completely
> > -	 * acquired the semaphore for write.
> > +	 * acquired the semaphore for write and reader bias is still
> > +	 * allowed.
> >  	 */
> > -	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
> > +	if (atomic_read(&rwb->readers) != WRITER_BIAS &&
> > +	    rwbase_allow_reader_bias(rwb)) {
> >  		atomic_inc(&rwb->readers);
> >  		raw_spin_unlock_irq(&rtm->wait_lock);
> >  		return 0;
> > @@ -264,12 +298,17 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> >  		if (__rwbase_write_trylock(rwb))
> >  			break;
> >  
> > +		/* Record first new read/write contention. */
> > +		set_writer_blocked(rwb);
> > +
> >  		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> >  		rwbase_schedule();
> >  		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> >  
> >  		set_current_state(state);
> >  	}
> > +
> > +	rwb->waiter_timeout = 0;
> 
> Regarding memory ordering and ordering in general:
> - Should the writer leave from rwbase_schedule() due to a signal then
>   set_writer_blocked() sets a timeout but it is not cleared on the
>   signal leave.
> 

You're correct, it should be reset in the signal check block before the
wait_lock is released by __rwbase_write_unlock. I considered different
ways to avoid multiple reset points but it was untidy.

> - There is only writer in that for loop within rwbase_write_lock()
>   because only one writer can own the rtmutex at a time. (A second
>   writer blocks on the RTmutex and needs to wait, I may have spread some
>   confusion earler). Therefore it should be okay to unconditionally set
>   the timeout (instead of checking for zero).
> 

Ah ok, I see now or at least I think I do.

> - Once the writer removes READER_BIAS, it forces the reader into the
>   slowpath.

Removed in __rwbase_write_trylock IIUC

>   At that time the writer does not own the wait_lock meaning
>   the reader _could_ check the timeout before writer had a chance to set
>   it. The worst thing is probably that if jiffies does not have the
>   highest bit set then it will always disable the reader bias here.
>   The easiest thing is probably to check timeout vs 0 and ensure on the
>   writer side that the lowest bit is always set (in the unlikely case it
>   will end up as zero).
> 

I am missing something important. On the read side, we have

        raw_spin_lock_irq(&rtm->wait_lock);
        /*
         * Allow readers, as long as the writer has not completely
         * acquired the semaphore for write and reader bias is still
         * allowed.
         */
        if (atomic_read(&rwb->readers) != WRITER_BIAS &&
            rwbase_allow_reader_bias(rwb)) {
                atomic_inc(&rwb->readers);
                raw_spin_unlock_irq(&rtm->wait_lock);
                return 0;
        }

So rtm->wait_lock is held and both the WRITER_BASE and timeout are checked
under the lock. On the write side it's also held when the timeout is
updated here

        raw_spin_lock_irqsave(&rtm->wait_lock, flags);
	...
	for (;;) {
		...

                /* Record timeout when reader bias is ignored. */
                rwb->waiter_timeout = jiffies + RWBASE_RT_WAIT_TIMEOUT;

                raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
                rwbase_schedule();
                raw_spin_lock_irqsave(&rtm->wait_lock, flags);

                set_current_state(state);
        }

        rwb->waiter_timeout = 0;
	...

out_unlock:
        raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);

(it's also now held in the signal block when it is cleared)

I'm not seeing exactly what the problem is unless it's an issue in the
fast path but I think the atomic_try_cmpxchg_acquire works there.

In the absense of wait_lock, I guess there would be a potential
race between the atomic_read(&rwb->readers) != WRITER_BIAS and
rwbase_allow_reader_bias(rwb) but that shouldn't be the case now. Even
if it wasn't locked, it might allow a new reader through but it'd be
a transient problem and writer starvation should be prevented once the
timeout is observed.

-- 
Mel Gorman
SUSE Labs
