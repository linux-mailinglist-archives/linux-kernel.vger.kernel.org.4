Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FF0674031
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjASRlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjASRlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:41:23 -0500
Received: from outbound-smtp57.blacknight.com (outbound-smtp57.blacknight.com [46.22.136.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55EF8BAB7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:41:05 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id C8CA1FABCD
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:41:03 +0000 (GMT)
Received: (qmail 12993 invoked from network); 19 Jan 2023 17:41:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Jan 2023 17:41:03 -0000
Date:   Thu, 19 Jan 2023 17:41:01 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230119174101.rddtxk5xlamlnquh@techsingularity.net>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
 <Y8j+lENBWNWgt4mf@linutronix.de>
 <20230119110220.kphftcehehhi5l5u@techsingularity.net>
 <Y8lvwKHmmnikVDgk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y8lvwKHmmnikVDgk@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 05:28:48PM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-01-19 11:02:20 [+0000], Mel Gorman wrote:
> > > - Once the writer removes READER_BIAS, it forces the reader into the
> > >   slowpath.
> > 
> > Removed in __rwbase_write_trylock IIUC
> 
> And added back in case try trylock failed via __rwbase_write_unlock().
> The RTmutex is unlocked and the READER_BIAS is "returned".
> 

Indeed.

> > >   At that time the writer does not own the wait_lock meaning
> > >   the reader _could_ check the timeout before writer had a chance to set
> > >   it. The worst thing is probably that if jiffies does not have the
> > >   highest bit set then it will always disable the reader bias here.
> > >   The easiest thing is probably to check timeout vs 0 and ensure on the
> > >   writer side that the lowest bit is always set (in the unlikely case it
> > >   will end up as zero).
> > > 
> > 
> > I am missing something important. On the read side, we have
> > 
> 
> Look at this side by side:
> 
>                 writer                                                       reader
> 
> | static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> |                                      unsigned int state)
> | {
> |         /* Force readers into slow path */
> |         atomic_sub(READER_BIAS, &rwb->readers);
> 
> 
> |                                                               static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
> |                                                                                                     unsigned int state)
> |                                                               {       
> |                                                                       struct rt_mutex_base *rtm = &rwb->rtmutex;
> |                                                                       int ret;                         
> |                                                               
> |                                                                       raw_spin_lock_irq(&rtm->wait_lock);
> 
> Reader has the lock, writer will wait.
> 
> |                                                                       /*
> |                                                                        * Allow readers, as long as the writer has not completely
> |                                                                        * acquired the semaphore for write.
> |                                                                        */
> |                                                                       if (atomic_read(&rwb->readers) != WRITER_BIAS) {
> 
> here, the timeout value is not yet populated by the writer so the reader
> compares vs 0.
> 
> |                                                                               atomic_inc(&rwb->readers);
> |                                                                               raw_spin_unlock_irq(&rtm->wait_lock);
> |                                                                               return 0;
> |                                                                       }
> |                                                              
> 
> |         raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> |         if (__rwbase_write_trylock(rwb))
> |                 goto out_unlock;
> |
> 
> Hope this makes it easier.
> 

Yes, it makes your concern much clearer but I'm not sure it actually matters
in terms of preventing write starvation or in terms of correctness. At
worst, a writer is blocked that could have acquired the lock during a tiny
race but that's a timing issue rather than a correctness issue.

Lets say the race hits

									reader sees waiter_timeout == 0
	writer acquires wait_lock
	__rwbase_write_trylock fails
	update waiter_timeout
	rwbase_schedule

Each reader that hits the race goes ahead at a point in time but anything
readers after that observe the timeout and eventually the writer goes ahead.

If the waiter_timeout was updated before atomic_sub(READER_BIAS),
it doesn't close the race as atomic_sub is unordered so barriers would
also be needed and clearing of waiter_timeout moves to out_unlock in case
__rwbase_write_trylock succeeds. That's possible but the need for barriers
makes it more complicated than is necessary.

The race could be closed by moving wait_lock acquisition before the
atomic_sub in rwbase_write_lock() but it expands the scope of the wait_lock
and I'm not sure that's necessary for either correctness or preventing
writer starvation. It's a more straight-forward fix but expanding the
scope of a lock unnecessarily has been unpopular in the past.

I think we can close the race that concerns you but I'm not convinced we
need to and changing the scope of wait_lock would need a big comment and
probably deserves a separate patch.

Sorry if I'm still missing something stupid and thanks for your patience
reviewing this.

-- 
Mel Gorman
SUSE Labs
