Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B22680128
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 20:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjA2TSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 14:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjA2TSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 14:18:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F31420D
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 11:17:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5F4960DF0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34389C433EF;
        Sun, 29 Jan 2023 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675019873;
        bh=i0mpScqMWJJeyrARWmsSAqxD3avk9ge0Bq1RYD9JSUQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nZY3o6l7Ajyk+jz5LtPQ4fIdCbZuWSrIRH7q9dP9cXYXvlnY1Irx7N9DZZzMVJ/ZF
         i+DGF3lFWeOHQVgjh2KpFm4T6GqI5ybp6cXirIKN6XMBsKadk99OntfdoF7dkGHrYR
         3dadiTpsZ7LnzFej46Nd4Ejgp66ZPy6s2eTwLYvJQTMoxsrgbHke14wsM4Rmd86iqV
         4D1oSI82Hb6D+y2L0FQzirdQyTv9AjXhPhK4QDKown5yYqq85whDnWBm1jt//PBe3t
         skSF00RqBRZRrKtdzLs2tjiRd1Ti5YF22vzdMXRTnjx93yEBIO127zf3HpFBRxAPYs
         /jR0bIYvDf4+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C4BE45C08B3; Sun, 29 Jan 2023 11:17:52 -0800 (PST)
Date:   Sun, 29 Jan 2023 11:17:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230129191752.GA1115122@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <20230129051734.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9aY4hG3p+82vVIw@rowland.harvard.edu>
 <20230129162156.GG2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129162156.GG2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 08:21:56AM -0800, Paul E. McKenney wrote:
> On Sun, Jan 29, 2023 at 11:03:46AM -0500, Alan Stern wrote:
> > On Sat, Jan 28, 2023 at 09:17:34PM -0800, Paul E. McKenney wrote:
> > > On Sat, Jan 28, 2023 at 05:59:52PM -0500, Alan Stern wrote:
> > > > On Sat, Jan 28, 2023 at 11:14:17PM +0100, Andrea Parri wrote:
> > > > > > Evidently the plain-coherence check rules out x=1 at the 
> > > > > > end, because when I relax that check, x=1 becomes a possible result.  
> > > > > > Furthermore, the graphical output confirms that this execution has a 
> > > > > > ww-incoh edge from Wx=2 to Wx=1.  But there is no ww-vis edge from Wx=1 
> > > > > > to Wx=2!  How can this be possible?  It seems like a bug in herd7.
> > > > > 
> > > > > By default, herd7 performs some edges removal when generating the
> > > > > graphical outputs.  The option -showraw can be useful to increase
> > > > > the "verbosity", for example,
> > > > > 
> > > > >   [with "exists (x=2)", output in /tmp/T.dot]
> > > > >   $ herd7 -conf linux-kernel.cfg T.litmus -show prop -o /tmp -skipchecks plain-coherence -doshow ww-vis -showraw ww-vis
> > > > 
> > > > Okay, thanks, that helps a lot.
> > > > 
> > > > So here's what we've got.  The litmus test:
> > > > 
> > > > 
> > > > C hb-and-int
> > > > {}
> > > > 
> > > > P0(int *x, int *y)
> > > > {
> > > >     *x = 1;
> > > >     smp_store_release(y, 1);
> > > > }
> > > > 
> > > > P1(int *x, int *y, int *dx, int *dy, spinlock_t *l)
> > > > {
> > > >     spin_lock(l);
> > > >     int r1 = READ_ONCE(*dy);
> > > >     if (r1==1)
> > > >         spin_unlock(l);
> > > > 
> > > >     int r0 = smp_load_acquire(y);
> > > >     if (r0 == 1) {
> > > >         WRITE_ONCE(*dx,1);
> > > >     }
> > > 
> > > The lack of a spin_unlock() when r1!=1 is intentional?
> > 
> > I assume so.
> > 
> > > It is admittedly a cute way to prevent P3 from doing anything
> > > when r1!=1.  And P1 won't do anything if P3 runs first.
> > 
> > Right.
> > 
> > > > }
> > > > 
> > > > P2(int *dx, int *dy)
> > > > {
> > > >     WRITE_ONCE(*dy,READ_ONCE(*dx));
> > > > }
> > > > 
> > > > 
> > > > P3(int *x, spinlock_t *l)
> > > > {
> > > >     spin_lock(l);
> > > >     smp_mb__after_unlock_lock();
> > > >     *x = 2;
> > > > }
> > > > 
> > > > exists (x=2)
> > > > 
> > > > 
> > > > The reason why Wx=1 ->ww-vis Wx=2:
> > > > 
> > > > 	0:Wx=1 ->po-rel 0:Wy=1 and po-rel < fence < ww-post-bounded.
> > > > 
> > > > 	0:Wy=1 ->rfe 1:Ry=1 ->(hb* & int) 1:Rdy=1 and
> > > > 		(rfe ; hb* & int) <= (rfe ; xbstar & int) <= vis.
> > > > 
> > > > 	1:Rdy=1 ->po 1:unlock ->rfe 3:lock ->po 3:Wx=2
> > > > 		so 1:Rdy=1 ->po-unlock-lock-po 3:Wx=2
> > > > 		and po-unlock-lock-po <= mb <= fence <= w-pre-bounded.
> > > > 
> > > > Finally, w-post-bounded ; vis ; w-pre-bounded <= ww-vis.
> > > > 
> > > > This explains why the memory model says there isn't a data race.  This 
> > > > doesn't use the smp_mb__after_unlock_lock at all.
> > > 
> > > You lost me on this one.
> > > 
> > > Suppose that P3 starts first, then P0.  P1 is then stuck at the
> > > spin_lock() because P3 does not release that lock.  P2 goes out for a
> > > pizza.
> > 
> > That wouldn't be a valid execution.  One of the rules in lock.cat says 
> > that a spin_lock() call must read from a spin_unlock() or from an 
> > initial write, which rules out executions in which P3 acquires the lock 
> > first.
> 
> OK, I will bite...
> 
> Why can't P3's spin_lock() read from that initial write?
> 
> > > Why can't the two stores to x by P0 and P3 conflict, resulting in a
> > > data race?
> > 
> > That can't happen in executions where P1 acquires the lock first for the 
> > reason outlined above (P0's store to x propagates to P3 before P3 writes 
> > to x).  And there are no other executions -- basically, herd7 ignores 
> > deadlock scenarios.
> 
> True enough, if P1 gets there first, then P3 never stores to x.
> 
> What I don't understand is why P1 must always get there first.

Ah, is the rule that all processes must complete?

If so, then the only way all processes can complete is if P1 loads 1
from dy, thus releasing the lock.

But that dy=1 load can only happen after P2 has copied dx to dy, and has
stored a 1.  Which in turn only happens if P1's write to dx is ordered
before the lock release.  Which only executes if P1's load from y returned
1, which only happens after P0 stored 1 to y.

Which means that P3 gets the lock only after P0 completes its plain
write to x, so there is no data race.

The reason that P3 cannot go first is that this will prevent P1 from
completing, in turn preventing herd7 from counting that execution.

Or am I still missing a turn in there somewhere?

							Thanx, Paul
