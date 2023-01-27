Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F567EB7B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjA0QtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjA0Qs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:48:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02847BE76
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:48:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F7FF61D04
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC85C433D2;
        Fri, 27 Jan 2023 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674838136;
        bh=3U+vcqG5HFeC0VQLakTFwxLx4UOTeu/61nzctv1KVF0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BBo4Qx0vkZJ0MqpdXYxto8/tipjMoKB0O1J/zeMuSQcU9aRS6GJhqunoCuvNUlM4W
         KIj91xH/1iTFaNcl1PbTqq9Xt97qWoOFf8OnP+Gh0xZqS/CpXYKzJt1U7S5sg/rdtX
         R+HoVJQW6uDiu1Qb39hM573MXI9utQToprr8hA/AhPD6d28ztzU5zEb9TUXvHR/cQE
         BxzJxnP0Dlm3xBgEOZJlaS9RAfzMqYKgy9n5NAhCfDtA7JRYIfdNyQfKAyKthhDcNz
         QZ69awA3OPWRaUEImZr4kpU51YrI9YG4vmvvzRrC5Gc5rOgOb8PJZ8R2R1rU35m9x+
         O4gAC4HIFjfvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 23E3B5C0510; Fri, 27 Jan 2023 08:48:56 -0800 (PST)
Date:   Fri, 27 Jan 2023 08:48:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools/memory-model: Unify UNLOCK+LOCK pairings to
 po-unlock-lock-po
Message-ID: <20230127164856.GU2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-2-jonas.oberhauser@huaweicloud.com>
 <Y9KsI/PsW4DK083z@rowland.harvard.edu>
 <20230126200828.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230126232148.GA855268@paulmck-ThinkPad-P17-Gen-1>
 <c9c511d1-318b-8551-e5d7-be9fa5e09008@huaweicloud.com>
 <20230127151340.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <ef82e396-dad0-78fe-1cc7-817163829a77@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef82e396-dad0-78fe-1cc7-817163829a77@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:57:43PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/27/2023 4:13 PM, Paul E. McKenney wrote:
> > On Fri, Jan 27, 2023 at 02:18:41PM +0100, Jonas Oberhauser wrote:
> > > On 1/27/2023 12:21 AM, Paul E. McKenney wrote:
> > > > On Thu, Jan 26, 2023 at 12:08:28PM -0800, Paul E. McKenney wrote:
> > > > > On Thu, Jan 26, 2023 at 11:36:51AM -0500, Alan Stern wrote:
> > > > > > On Thu, Jan 26, 2023 at 02:46:03PM +0100, Jonas Oberhauser wrote:
> > > > > > > LKMM uses two relations for talking about UNLOCK+LOCK pairings:
> > > > > > > 
> > > > > > > 	1) po-unlock-lock-po, which handles UNLOCK+LOCK pairings
> > > > > > > 	   on the same CPU or immediate lock handovers on the same
> > > > > > > 	   lock variable
> > > > > > > 
> > > > > > > 	2) po;[UL];(co|po);[LKW];po, which handles UNLOCK+LOCK pairs
> > > > > > > 	   literally as described in rcupdate.h#L1002, i.e., even
> > > > > > > 	   after a sequence of handovers on the same lock variable.
> > > > > > > 
> > > > > > > The latter relation is used only once, to provide the guarantee
> > > > > > > defined in rcupdate.h#L1002 by smp_mb__after_unlock_lock(), which
> > > > > > > makes any UNLOCK+LOCK pair followed by the fence behave like a full
> > > > > > > barrier.
> > > > > > > 
> > > > > > > This patch drops this use in favor of using po-unlock-lock-po
> > > > > > > everywhere, which unifies the way the model talks about UNLOCK+LOCK
> > > > > > > pairings.  At first glance this seems to weaken the guarantee given
> > > > > > > by LKMM: When considering a long sequence of lock handovers
> > > > > > > such as below, where P0 hands the lock to P1, which hands it to P2,
> > > > > > > which finally executes such an after_unlock_lock fence, the mb
> > > > > > > relation currently links any stores in the critical section of P0
> > > > > > > to instructions P2 executes after its fence, but not so after the
> > > > > > > patch.
> > > > > > > 
> > > > > > > P0(int *x, int *y, spinlock_t *mylock)
> > > > > > > {
> > > > > > >           spin_lock(mylock);
> > > > > > >           WRITE_ONCE(*x, 2);
> > > > > > >           spin_unlock(mylock);
> > > > > > >           WRITE_ONCE(*y, 1);
> > > > > > > }
> > > > > > > 
> > > > > > > P1(int *y, int *z, spinlock_t *mylock)
> > > > > > > {
> > > > > > >           int r0 = READ_ONCE(*y); // reads 1
> > > > > > >           spin_lock(mylock);
> > > > > > >           spin_unlock(mylock);
> > > > > > >           WRITE_ONCE(*z,1);
> > > > > > > }
> > > > > > > 
> > > > > > > P2(int *z, int *d, spinlock_t *mylock)
> > > > > > > {
> > > > > > >           int r1 = READ_ONCE(*z); // reads 1
> > > > > > >           spin_lock(mylock);
> > > > > > >           spin_unlock(mylock);
> > > > > > >           smp_mb__after_unlock_lock();
> > > > > > >           WRITE_ONCE(*d,1);
> > > > > > > }
> > > > > > > 
> > > > > > > P3(int *x, int *d)
> > > > > > > {
> > > > > > >           WRITE_ONCE(*d,2);
> > > > > > >           smp_mb();
> > > > > > >           WRITE_ONCE(*x,1);
> > > > > > > }
> > > > > > > 
> > > > > > > exists (1:r0=1 /\ 2:r1=1 /\ x=2 /\ d=2)
> > > > > > > 
> > > > > > > Nevertheless, the ordering guarantee given in rcupdate.h is actually
> > > > > > > not weakened.  This is because the unlock operations along the
> > > > > > > sequence of handovers are A-cumulative fences.  They ensure that any
> > > > > > > stores that propagate to the CPU performing the first unlock
> > > > > > > operation in the sequence must also propagate to every CPU that
> > > > > > > performs a subsequent lock operation in the sequence.  Therefore any
> > > > > > > such stores will also be ordered correctly by the fence even if only
> > > > > > > the final handover is considered a full barrier.
> > > > > > > 
> > > > > > > Indeed this patch does not affect the behaviors allowed by LKMM at
> > > > > > > all.  The mb relation is used to define ordering through:
> > > > > > > 1) mb/.../ppo/hb, where the ordering is subsumed by hb+ where the
> > > > > > >      lock-release, rfe, and unlock-acquire orderings each provide hb
> > > > > > > 2) mb/strong-fence/cumul-fence/prop, where the rfe and A-cumulative
> > > > > > >      lock-release orderings simply add more fine-grained cumul-fence
> > > > > > >      edges to substitute a single strong-fence edge provided by a long
> > > > > > >      lock handover sequence
> > > > > > > 3) mb/strong-fence/pb and various similar uses in the definition of
> > > > > > >      data races, where as discussed above any long handover sequence
> > > > > > >      can be turned into a sequence of cumul-fence edges that provide
> > > > > > >      the same ordering.
> > > > > > > 
> > > > > > > Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > > > > > > ---
> > > > > > Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> > > > > A quick spot check showed no change in performance, so thank you both!
> > > > > 
> > > > > Queued for review and further testing.
> > > > And testing on https://github.com/paulmckrcu/litmus for litmus tests up
> > > > to ten processes and allowing 10 minutes per litmus test got this:
> > > > 
> > > > Exact output matches: 5208
> > > > !!! Timed out: 38
> > > > !!! Unknown primitive: 7
> > > > 
> > > > This test compared output with and without your patch.
> > > > 
> > > > For the tests with a Results clause, these failed:
> > > Gave me a heart attack there for a second!
> > Sorry for the scare!!!
> > 
> > > > Also, I am going to be pushing the scripts I use to mainline.  They might
> > > > not be perfect, but they will be quite useful for this sort of change
> > > > to the memory model.
> > > I could also provide Coq proofs, although those are ignoring the srcu/data
> > > race parts at the moment.
> > Can such proofs serve as regression tests for future changes?
> > 
> > 							Thanx, Paul
> 
> So-so. On the upside, it would be easy to make them raise an alarm if the
> future change breaks stuff.
> On the downside, they will often need maintenance together with any change.
> Sometimes a lot, sometimes very little.
> I think for the proofs that show the equivalence between two models, the
> maintenance is quite a bit higher because every change needs to be reflected
> in both versions. So if you do 10 equivalent transformations and want to
> show that they remain equivalent with any future changes you do, you need to
> keep at least 10 additional models around ("current LKMM where ppo isn't in
> po, current LKMM where the unlock fence still relies on co, ...").
> 
> Right now, each equivalence proof I did (e.g., for using po-unlock-lock-po
> here, or the ppo<=po patch I originally proposed) is at average in the
> ballpark of 500 lines of proof script. And as evidenced by my discussion
> with Alan, these proofs only cover the "core model".
> 
> So for this kind of thing, I think it's better to look at them to have more
> confidence in the patch, and do the patch more based on which model is more
> reasonable (as Alan enforces). Then consider the simplified version as the
> more natural one, and not worry about future changes that break the
> equivalence (that would usually indicate a problem with the old model,
> rather than a problem with the patch).
> 
> For regressions, I would rather consider some desirable properties of LKMM,
> like "DRF-SC" or "monotonicity of barriers" or "ppo <= po" and try to prove
> those. This has the upside of not requiring to carry additional models
> around, so much less than half the maintenance effort, and if the property
> should be broken this usually would indicate a problem with the patch. So I
> think the bang for the buck is much higher there.
> 
> Those are my current thoughts anyways : )

That matches my experience, for whatever that is worth.  (I first
used Promela/spin in the early 1990s, which proved to be an excellent
cautionary tale.)

							Thanx, Paul
