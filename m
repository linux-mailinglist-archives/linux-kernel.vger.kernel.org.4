Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0620267D98F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjAZXVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAZXVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:21:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5836A5F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:21:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4C57B81ECD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2CEC4339B;
        Thu, 26 Jan 2023 23:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674775308;
        bh=Lq6fk+GyGqDaZwOCXFqbZs1aT14bPTbAZD8s9qjgcgA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ppFAvVEBTAx8wB1/3zpJnjQB7YumwwNC4kghzSA5g3H1A6h484f1QVsGvZyfsq4zb
         tZkAzahbEwrFCbde3zPmhMIis6bNjQg+VD9NexLC4HV1wcVOGTgrRjmKcsXdONBjdZ
         1pYvVBYvPA5b9oaH6MOLO0MGWac2bBCesNQgDc3ecQHrUpKSwI3LwcwfFxm9O2SGNt
         OX4IQHe3IJOYVDVdHoHohI+L3yh7XePTnoGVumzIf1O7Q5upwzs0urs4jJSOXbfF8m
         okyJEfQ2ZtUIK7SuKbnSLuq7T4knmLF8oB3+23pA0ozAUPDZn9fPEC2EqEovSz1CSV
         pcFnY7m5amVww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 286795C1C6D; Thu, 26 Jan 2023 15:21:48 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:21:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools/memory-model: Unify UNLOCK+LOCK pairings to
 po-unlock-lock-po
Message-ID: <20230126232148.GA855268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-2-jonas.oberhauser@huaweicloud.com>
 <Y9KsI/PsW4DK083z@rowland.harvard.edu>
 <20230126200828.GK2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126200828.GK2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 12:08:28PM -0800, Paul E. McKenney wrote:
> On Thu, Jan 26, 2023 at 11:36:51AM -0500, Alan Stern wrote:
> > On Thu, Jan 26, 2023 at 02:46:03PM +0100, Jonas Oberhauser wrote:
> > > LKMM uses two relations for talking about UNLOCK+LOCK pairings:
> > > 
> > > 	1) po-unlock-lock-po, which handles UNLOCK+LOCK pairings
> > > 	   on the same CPU or immediate lock handovers on the same
> > > 	   lock variable
> > > 
> > > 	2) po;[UL];(co|po);[LKW];po, which handles UNLOCK+LOCK pairs
> > > 	   literally as described in rcupdate.h#L1002, i.e., even
> > > 	   after a sequence of handovers on the same lock variable.
> > > 
> > > The latter relation is used only once, to provide the guarantee
> > > defined in rcupdate.h#L1002 by smp_mb__after_unlock_lock(), which
> > > makes any UNLOCK+LOCK pair followed by the fence behave like a full
> > > barrier.
> > > 
> > > This patch drops this use in favor of using po-unlock-lock-po
> > > everywhere, which unifies the way the model talks about UNLOCK+LOCK
> > > pairings.  At first glance this seems to weaken the guarantee given
> > > by LKMM: When considering a long sequence of lock handovers
> > > such as below, where P0 hands the lock to P1, which hands it to P2,
> > > which finally executes such an after_unlock_lock fence, the mb
> > > relation currently links any stores in the critical section of P0
> > > to instructions P2 executes after its fence, but not so after the
> > > patch.
> > > 
> > > P0(int *x, int *y, spinlock_t *mylock)
> > > {
> > >         spin_lock(mylock);
> > >         WRITE_ONCE(*x, 2);
> > >         spin_unlock(mylock);
> > >         WRITE_ONCE(*y, 1);
> > > }
> > > 
> > > P1(int *y, int *z, spinlock_t *mylock)
> > > {
> > >         int r0 = READ_ONCE(*y); // reads 1
> > >         spin_lock(mylock);
> > >         spin_unlock(mylock);
> > >         WRITE_ONCE(*z,1);
> > > }
> > > 
> > > P2(int *z, int *d, spinlock_t *mylock)
> > > {
> > >         int r1 = READ_ONCE(*z); // reads 1
> > >         spin_lock(mylock);
> > >         spin_unlock(mylock);
> > >         smp_mb__after_unlock_lock();
> > >         WRITE_ONCE(*d,1);
> > > }
> > > 
> > > P3(int *x, int *d)
> > > {
> > >         WRITE_ONCE(*d,2);
> > >         smp_mb();
> > >         WRITE_ONCE(*x,1);
> > > }
> > > 
> > > exists (1:r0=1 /\ 2:r1=1 /\ x=2 /\ d=2)
> > > 
> > > Nevertheless, the ordering guarantee given in rcupdate.h is actually
> > > not weakened.  This is because the unlock operations along the
> > > sequence of handovers are A-cumulative fences.  They ensure that any
> > > stores that propagate to the CPU performing the first unlock
> > > operation in the sequence must also propagate to every CPU that
> > > performs a subsequent lock operation in the sequence.  Therefore any
> > > such stores will also be ordered correctly by the fence even if only
> > > the final handover is considered a full barrier.
> > > 
> > > Indeed this patch does not affect the behaviors allowed by LKMM at
> > > all.  The mb relation is used to define ordering through:
> > > 1) mb/.../ppo/hb, where the ordering is subsumed by hb+ where the
> > >    lock-release, rfe, and unlock-acquire orderings each provide hb
> > > 2) mb/strong-fence/cumul-fence/prop, where the rfe and A-cumulative
> > >    lock-release orderings simply add more fine-grained cumul-fence
> > >    edges to substitute a single strong-fence edge provided by a long
> > >    lock handover sequence
> > > 3) mb/strong-fence/pb and various similar uses in the definition of
> > >    data races, where as discussed above any long handover sequence
> > >    can be turned into a sequence of cumul-fence edges that provide
> > >    the same ordering.
> > > 
> > > Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > > ---
> > 
> > Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> 
> A quick spot check showed no change in performance, so thank you both!
> 
> Queued for review and further testing.

And testing on https://github.com/paulmckrcu/litmus for litmus tests up
to ten processes and allowing 10 minutes per litmus test got this:

Exact output matches: 5208
!!! Timed out: 38
!!! Unknown primitive: 7

This test compared output with and without your patch.

For the tests with a Results clause, these failed:

	manual/kernel/C-srcu-nest-7.litmus
	manual/kernel/C-srcu-nest-5.litmus
	manual/kernel/C-srcu-nest-6.litmus
	manual/kernel/C-srcu-nest-8.litmus

But all of these will continue to fail until we get Alan's new-age SRCU
patch applied.

Therefore, this constitutes success, so good show thus far on testing!  ;-)

Also, I am going to be pushing the scripts I use to mainline.  They might
not be perfect, but they will be quite useful for this sort of change
to the memory model.

						Thanx, Paul
