Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CED864D459
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLOAKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLOAKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:10:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37E750B0;
        Wed, 14 Dec 2022 16:01:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DC2CB81AA9;
        Thu, 15 Dec 2022 00:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5F9C433EF;
        Thu, 15 Dec 2022 00:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671062497;
        bh=1LeoSAuSI09MIIQgCe2g5+a7buNfDKMa+AnqpAyiNa0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ft6bREINVRAf82Kr0u8a2dlcq4d8linzVNKVx0NboRXDfVEyeYFBSC9OXVZAPsNzi
         ZvTZ73DFFx8jBahmQQh7cOkH0ukoEIkjNjK104P6DVRgD+92dE97i2WrAJdd6NWC5R
         qIXtSmQ5DslgyGJ4iKW+c+rFf1JR7nT+2xJaK+LfHMNiJ//E4uZUNQmTOyLeQUkJWc
         8wlWwHKIVbG1yPnu6CaPWwBC6jFGweSaakNfAaSZYjNzm2kjhuGbidQaQdE3sNwMHa
         jXJ5by9vOReCDM5n+WyELJTE24fy31EMelMs57FRG3TpaxUPQLKkf1OUpCh3qgQSvX
         HGwXIMsLPzKVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4DEA05C0A6A; Wed, 14 Dec 2022 16:01:37 -0800 (PST)
Date:   Wed, 14 Dec 2022 16:01:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     boqun.feng@gmail.com, frederic@kernel.org, neeraj.iitr10@gmail.com,
        urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221215000137.GC4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com>
 <20221214212455.GA4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:07:52PM +0000, Joel Fernandes wrote:
> On Wed, Dec 14, 2022 at 9:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Dec 14, 2022 at 03:51:54PM -0500, Joel Fernandes wrote:
> > > Hi Paul,
> > >
> > > On Wed, Dec 14, 2022 at 2:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > The comment in srcu_readers_active_idx_check() following the smp_mb()
> > > > is out of date, hailing from a simpler time when preemption was disabled
> > > > across the bulk of __srcu_read_lock().  The fact that preemption was
> > > > disabled meant that the number of tasks that had fetched the old index
> > > > but not yet incremented counters was limited by the number of CPUs.
> [...]
> > > > +        * TREE01 rcutorture run reported this size to be no less than
> > > > +        * 9408 bytes, allowing up to 4704 levels of nesting, which is
> > > > +        * comfortably beyond excessive.  Especially on 64-bit systems,
> > > > +        * which are unlikely to be configured with an address space fully
> > > > +        * populated with memory, at least not anytime soon.
> > > >          */
> > >
> > > Below is a summary from my point of view. Please correct me if I'm
> > > wrong. I was trying to reason that we only need to care about waiting
> > > for readers that sample idx *after* srcu_read_lock() issued smp_mb().
> > >
> > > The case to consider a race between readers and
> > > srcu_readers_active_idx_check() IMO is when a reader samples idx,
> >
> > I would instead say "when a reader has sampled ->srcu_idx, but has not
> > yet executed the smp_mb() or incremented ->srcu_lock_count".
> 
> If it has not yet executed smp_mb(), then I am missing why this
> read-side critical section matters as far as being waited for. If it
> is waited for due to a race, great, just a slightly higher delay. If
> it is not waited for, then no one should care AFAICS, it is too late
> and the next grace period will anyway scan both the idx to track it.

From the viewpoints of other CPUs, it matters not whether that task has
or has not executed smp_mb().  Unless and until it also executes something
following that smp_mb(), that smp_mb() has zero software-visible effect.

To see this, try creating an LKMM litmus test in which it matters whether
a given process has or doesn't have an smp_mb() at the very end of that
process, that is, that smp_mb(), if present is the very last thing that
the process executes.

> > > issues smp_mb() enters its RSCS. If it does not do smp_mb(), its RSCS
> > > need not be waited on as it is not considered to be entered from a
> > > global memory PoV.  Assuming it did issue the smp_mb() in
> > > srcu_read_lock() and then got preempted (which IMO is the only case to
> > > care about the reader for), and say the first scan failed to track
> > > down this in-flight RSCS.
> >
> > Except that this smp_mb() is not externally visible to software.
> > Other CPUs have to have seen and access following that smp_mb() for it
> > to matter from a software viewpoint.
> 
> Sure, that second pairing smp_mb() will be in
> srcu_readers_active_idx_check(). I am definitely considering it in
> pairs here in the reasoning, and not on its own.

Very good.

But you need more than pairs.  You also need memory accesses on both
sides of each smp_mb() in that pairing.

> > >                           The first scan can fail to track the RSCS
> > > for 2 reasons:
> > >
> > > #1. The idx being scanned in the first scan is the one that the reader
> > > did not sample.
> > > #2. The smp_mb() in the first scan's srcu_readers_active_idx_check()
> > > happened *before* the smp_mb() post-counter increment in
> > > srcu_read_lock().
> >
> > Again, software cannot see the smp_mb() in and of itself.  What
> > matters is the increment of ->srcu_lock_count and the updater's
> > scan of this same counter.
> 
> Yes, and that scan of the counter happens after a write-side smp_mb() AFAICS.
> 
> > #3. The reader still hasn't gotten around to incrementing
> > ->srcu_lock_count.
> 
> Then it has not executed an smp_mb() on the read-side yet, so it
> should not be taken into consideration AFAICS.
> 
> > > In case of #2, the first scan was too early and the second scan will
> > > not even look at this idx as it gets flipped. So we can safely assume
> > > in #2 that this RSCS need not be waited on and was too early. IOW, the
> > > grace period started before the RSCS, so tough luck for that RSCS.
> >
> > And the point of a number of the memory barriers is to ensure that when
> > this happens, the critical section is guaranteed to see anything that
> > happened before the start of the current grace period.
> 
> Sure.
> 
> > > So AFAICS, case #1 is the only one that matters for consideration of
> > > race. In this case, we will rely on the second scan and assume that we
> > > "need to do the right thing" for the case where the srcu_read_lock()'s
> > > smp_mb() happened *before* the second scan's smp_mb() and the idx
> > > being reader-occupied is supposed to be properly nailed down by the
> > > second scan. In this case, the second scan *will* see the lock count
> > > increment of all in-flight readers, preempted or otherwise, because of
> > > the smp_mb() it issues prior to sampling all the lock counts of the
> > > flipped idx.  And upto Nt number of increments can be "caught" by the
> > > second scan, before a wrap around fools it into believing the Nt
> > > readers don't need any love, quiet to their detriment.
> >
> > Both #1 and #3 must be handled, right?
> 
> This is the part I am not sure, that #3 matters, but I could be
> missing something.

My kneejerk reaction, right or wrong, is that you are thinking in terms
of a globally agreed-upon timeline.

> > > I also did not get why you care about readers that come and ago (you
> > > mentioned the first reader seeing incorrect idx and the second reader
> > > seeing the right flipped one, etc). Those readers are irrelevant
> > > AFAICS since they came and went, and need not be waited on , right?.
> >
> > The comment is attempting to show (among other things) that we don't
> > need to care about readers that come and go more than twice during that
> > critical interval of time during the counter scans.
> 
> Why do we need to care about readers that come and go even once? Once
> they are gone, they have already done an unlock() and their RSCS is
> over, so they need to be considered AFAICS.

Because if a given reader could come and go 2^32-1 times while always
using the same ->srcu_idx, then the updater could incorrectly lose track
of some other SRCU read-side critical section, and could thus end the
grace period prematurely.

> Again, sorry if my comments are nonsense, I will try to reason more.
> The goal of asking questions is to learn ;-)

Try setting up some LKMM litmus tests.  Those could be good documentation
in any case.  (Note that you have to cheat to make counter wrap happen,
and you need really small counters to avoid overflowing herd7's
capabilities.)

							Thanx, Paul
