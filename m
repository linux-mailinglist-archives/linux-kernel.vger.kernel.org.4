Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1DE64D1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiLNVZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLNVZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:25:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8177F36C7A;
        Wed, 14 Dec 2022 13:24:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36FE0B81A28;
        Wed, 14 Dec 2022 21:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEF7C433D2;
        Wed, 14 Dec 2022 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671053096;
        bh=5/asdlYPdZWKFecz4IFrnLxReRX3mG0tk0EIRPPo0lA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NeaCLOkNE6WhwMxc0kQs7dByuRFBHqGlj1aaqqlxmhtdZKnV0Av74X6aIY59c+FF+
         xWZIu/QnceYAfLeeNTynxs8vfNY/+JypxB5WLs9FxVpZN3l2JWj0xdF9atz8t/kMf3
         yTkKahqAfHYxG5fCwAf9tb0P1XJIhbrPE2XTWudIvw8lnVgFEiy6FMssQnSxt7t1FU
         FCTEmwBVUSXRRq010B2gM61s9XJcECg1sF/sF+diEcsD0HPI1vhbhNOsPItZyzQUZM
         O+GnJFdTxQcLtyWahZ7QgChzNWGor2qx2EBU4Yks1rFtHn9AfQpvvnc72a6wNiiH08
         H7zA7sisVCs6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9EF425C0A6A; Wed, 14 Dec 2022 13:24:55 -0800 (PST)
Date:   Wed, 14 Dec 2022 13:24:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     boqun.feng@gmail.com, frederic@kernel.org, neeraj.iitr10@gmail.com,
        urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221214212455.GA4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 03:51:54PM -0500, Joel Fernandes wrote:
> Hi Paul,
> 
> On Wed, Dec 14, 2022 at 2:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > The comment in srcu_readers_active_idx_check() following the smp_mb()
> > is out of date, hailing from a simpler time when preemption was disabled
> > across the bulk of __srcu_read_lock().  The fact that preemption was
> > disabled meant that the number of tasks that had fetched the old index
> > but not yet incremented counters was limited by the number of CPUs.
> >
> > In our more complex modern times, the number of CPUs is no longer a limit.
> > This commit therefore updates this comment, additionally giving more
> > memory-ordering detail.
> >
> > Reported-by: Boqun Feng <boqun.feng@gmail.com>
> > Reported-by: Frederic Weisbecker <frederic@kernel.org>
> > Reported-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Reported-by: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
> > Reported-by: Uladzislau Rezki <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 68b8d8b150db1..ba12c50ee3658 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -469,24 +469,53 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
> >
> >         /*
> >          * If the locks are the same as the unlocks, then there must have
> > -        * been no readers on this index at some time in between. This does
> > -        * not mean that there are no more readers, as one could have read
> > -        * the current index but not have incremented the lock counter yet.
> > +        * been no readers on this index at some point in this function.
> > +        * But there might be more readers, as a task might have read
> > +        * the current ->srcu_idx but not yet have incremented its CPU's
> > +        * ->srcu_lock_count[idx] counter.  In fact, it is possible
> > +        * that most of the tasks have been preempted between fetching
> > +        * ->srcu_idx and incrementing ->srcu_lock_count[idx].  And there
> > +        * could be almost (ULONG_MAX / sizeof(struct task_struct)) tasks
> > +        * in a system whose address space was fully populated with memory.
> > +        * Call this quantity Nt.
> 
> If I understand correctly, here we are saying ULONG_MAX bytes is the
> total theoretical size of memory right? So we cannot have more than Nt
> tasks preempted.

Yes, that is the intent.

> >          *
> > -        * So suppose that the updater is preempted here for so long
> > -        * that more than ULONG_MAX non-nested readers come and go in
> > -        * the meantime.  It turns out that this cannot result in overflow
> > -        * because if a reader modifies its unlock count after we read it
> > -        * above, then that reader's next load of ->srcu_idx is guaranteed
> > -        * to get the new value, which will cause it to operate on the
> > -        * other bank of counters, where it cannot contribute to the
> > -        * overflow of these counters.  This means that there is a maximum
> > -        * of 2*NR_CPUS increments, which cannot overflow given current
> > -        * systems, especially not on 64-bit systems.
> > +        * So suppose that the updater is preempted at this point in the
> > +        * code for a long time.  That now-preempted updater has already
> > +        * flipped ->srcu_idx (possibly during the preceding grace period),
> > +        * done an smp_mb() (again, possibly during the preceding grace
> > +        * period), and summed up the ->srcu_unlock_count[idx] counters.
> > +        * How many times can a given one of the aforementioned Nt tasks
> > +        * increment the old ->srcu_idx value's ->srcu_lock_count[idx]
> > +        * counter, in the absence of nesting?
> >          *
> > -        * OK, how about nesting?  This does impose a limit on nesting
> > -        * of floor(ULONG_MAX/NR_CPUS/2), which should be sufficient,
> > -        * especially on 64-bit systems.
> > +        * It can clearly do so once, given that it has already fetched
> > +        * the old value of ->srcu_idx and is just about to use that value
> > +        * to index its increment of ->srcu_lock_count[idx].  But as soon as
> > +        * it leaves that SRCU read-side critical section, it will increment
> > +        * ->srcu_unlock_count[idx], which must follow the updater's above
> > +        * read from that same value.  Thus, as soon the reading task does
> > +        * an smp_mb() and a later fetch from ->srcu_idx, that task will be
> > +        * guaranteed to get the new index.  Except that the increment of
> > +        * ->srcu_unlock_count[idx] in __srcu_read_unlock() is after the
> > +        * smp_mb(), and the fetch from ->srcu_idx in __srcu_read_lock()
> > +        * is before the smp_mb().  Thus, that task might not see the new
> > +        * value of ->srcu_idx until the -second- __srcu_read_lock(),
> > +        * which in turn means that this task might well increment
> > +        * ->srcu_lock_count[idx] for the old value of ->srcu_idx twice,
> > +        * not just once.
> > +        *
> > +        * That is, there can be almost 2 * Nt further increments of
> > +        * ->srcu_lock_count[idx] for the old index.  But this is OK because
> 
> s/almost/atmost/ ?

The advantage of "almost" is it accounts for the fact that the update-side
thread isn't going to be doing any SRCU reading.  ;-)

> and also, I think you need 1 smp_mb() per CPU to reflect the update to
> the per-cpu counter, so it min(2 * Nt, number of CPUs) which I think
> is much smaller, but that is ok to not mention.

You make a good point, but that min() would be too small.  It would
instead be Nt + Nc, where "Nc" is the number of CPUs.

I will update this on the next rebase.

> > +        * the size of the task_struct structure limits the value of Nt.
> > +        *
> > +        * OK, but what about nesting?  This does impose a limit on
> > +        * nesting of half of the size of the task_struct structure
> > +        * (measured in bytes), which should be sufficient.  A late 2022
> 
> Does nesting here mean one SRCU reader section nested within another?
> With this definition of nesting, is it not possible for a single task
> to increment the 'lock' counter any number of times before getting
> preempted?

That is exactly why nesting depth must be limited.  And let's face it,
if you have code that nests 4704 times within a given SRCU read-side
critical section, that code needs some serious help!

> > +        * TREE01 rcutorture run reported this size to be no less than
> > +        * 9408 bytes, allowing up to 4704 levels of nesting, which is
> > +        * comfortably beyond excessive.  Especially on 64-bit systems,
> > +        * which are unlikely to be configured with an address space fully
> > +        * populated with memory, at least not anytime soon.
> >          */
> 
> Below is a summary from my point of view. Please correct me if I'm
> wrong. I was trying to reason that we only need to care about waiting
> for readers that sample idx *after* srcu_read_lock() issued smp_mb().
> 
> The case to consider a race between readers and
> srcu_readers_active_idx_check() IMO is when a reader samples idx,

I would instead say "when a reader has sampled ->srcu_idx, but has not
yet executed the smp_mb() or incremented ->srcu_lock_count".

> issues smp_mb() enters its RSCS. If it does not do smp_mb(), its RSCS
> need not be waited on as it is not considered to be entered from a
> global memory PoV.  Assuming it did issue the smp_mb() in
> srcu_read_lock() and then got preempted (which IMO is the only case to
> care about the reader for), and say the first scan failed to track
> down this in-flight RSCS.

Except that this smp_mb() is not externally visible to software.
Other CPUs have to have seen and access following that smp_mb() for it
to matter from a software viewpoint.

>                           The first scan can fail to track the RSCS
> for 2 reasons:
> 
> #1. The idx being scanned in the first scan is the one that the reader
> did not sample.
> #2. The smp_mb() in the first scan's srcu_readers_active_idx_check()
> happened *before* the smp_mb() post-counter increment in
> srcu_read_lock().

Again, software cannot see the smp_mb() in and of itself.  What
matters is the increment of ->srcu_lock_count and the updater's
scan of this same counter.

#3. The reader still hasn't gotten around to incrementing
->srcu_lock_count.

> In case of #2, the first scan was too early and the second scan will
> not even look at this idx as it gets flipped. So we can safely assume
> in #2 that this RSCS need not be waited on and was too early. IOW, the
> grace period started before the RSCS, so tough luck for that RSCS.

And the point of a number of the memory barriers is to ensure that when
this happens, the critical section is guaranteed to see anything that
happened before the start of the current grace period.

> So AFAICS, case #1 is the only one that matters for consideration of
> race. In this case, we will rely on the second scan and assume that we
> "need to do the right thing" for the case where the srcu_read_lock()'s
> smp_mb() happened *before* the second scan's smp_mb() and the idx
> being reader-occupied is supposed to be properly nailed down by the
> second scan. In this case, the second scan *will* see the lock count
> increment of all in-flight readers, preempted or otherwise, because of
> the smp_mb() it issues prior to sampling all the lock counts of the
> flipped idx.  And upto Nt number of increments can be "caught" by the
> second scan, before a wrap around fools it into believing the Nt
> readers don't need any love, quiet to their detriment.

Both #1 and #3 must be handled, right?

> I also did not get why you care about readers that come and ago (you
> mentioned the first reader seeing incorrect idx and the second reader
> seeing the right flipped one, etc). Those readers are irrelevant
> AFAICS since they came and went, and need not be waited on , right?.

The comment is attempting to show (among other things) that we don't
need to care about readers that come and go more than twice during that
critical interval of time during the counter scans.

> Thanks for the discussions today!

Good to have you guys there!

							Thanx, Paul

> thanks,
> 
>   - Joel
> 
> >         return srcu_readers_lock_idx(ssp, idx) == unlocks;
> >  }
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index ee8a6a711719a..399c818fe47ce 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4900,6 +4900,7 @@ void __init rcu_init(void)
> >         // Kick-start any polled grace periods that started early.
> >         if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
> >                 (void)start_poll_synchronize_rcu_expedited();
> > +       pr_alert("sizeof(struct task_struct) = %lu\n", sizeof(struct task_struct));
> >  }
> >
> >  #include "tree_stall.h"
