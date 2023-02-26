Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3CE6A2CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 02:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBZBBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 20:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBZBBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 20:01:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4ED12582
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 17:01:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B41DCB80B46
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 01:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF2BC433EF;
        Sun, 26 Feb 2023 01:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677373271;
        bh=D8jzb0FTnkYEVCyrIyivvcYn19NODDgx6FMuvpFYVRA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m+ue7k/kc5f0l1rfWrgkfLOOwtymFNyvqNd4pLZcPeN81PvCa06Ks9T84DnrTq99l
         Yfq92b7EhID/bSBlUIgo/4pz98+BsCxBWUvtBHHpuUv8nsNiIXGWdYVorvbAw+nhCC
         wIvHn7tkf0Mr70oP8/20TtA1sXT5KXhjOGK6XVM+TOSDuHdV6BdVaHkCOCj05BfZ/1
         q9MpThCOIzXZczXfI2w760cxHaxoMJQde5p7XByK7dgxGVmfvWyFpVoIP2WQzR0oXh
         vm//PByiAhNB6K3ObE2v4G3PMLErjGQPWN2IMlIYfQxNyw5EUDZU39CyyH57aDYboZ
         4p70n1zOiCHyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D28525C0292; Sat, 25 Feb 2023 17:01:10 -0800 (PST)
Date:   Sat, 25 Feb 2023 17:01:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 10:37:58AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 24, 2023 at 10:32:43AM -0500, Alan Stern wrote:
> > On Fri, Feb 24, 2023 at 02:52:51PM +0100, Jonas Oberhauser wrote:
> > > As stated in the documentation and implied by its name, the ppo
> > > (preserved program order) relation is intended to link po-earlier
> > > to po-later instructions under certain conditions.  However, a
> > > corner case currently allows instructions to be linked by ppo that
> > > are not executed by the same thread, i.e., instructions are being
> > > linked that have no po relation.
> > > 
> > > This happens due to the mb/strong-fence/fence relations, which (as
> > > one case) provide order when locks are passed between threads
> > > followed by an smp_mb__after_unlock_lock() fence.  This is
> > > illustrated in the following litmus test (as can be seen when using
> > > herd7 with `doshow ppo`):
> > > 
> > > P0(int *x, int *y)
> > > {
> > >     spin_lock(x);
> > >     spin_unlock(x);
> > > }
> > > 
> > > P1(int *x, int *y)
> > > {
> > >     spin_lock(x);
> > >     smp_mb__after_unlock_lock();
> > >     *y = 1;
> > > }
> > > 
> > > The ppo relation will link P0's spin_lock(x) and P1's *y=1, because
> > > P0 passes a lock to P1 which then uses this fence.
> > > 
> > > The patch makes ppo a subrelation of po by letting fence contribute
> > > to ppo only in case the fence links events of the same thread.
> > > 
> > > Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > > ---
> > >  tools/memory-model/linux-kernel.cat | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > > index cfc1b8fd46da..adf3c4f41229 100644
> > > --- a/tools/memory-model/linux-kernel.cat
> > > +++ b/tools/memory-model/linux-kernel.cat
> > > @@ -82,7 +82,7 @@ let rwdep = (dep | ctrl) ; [W]
> > >  let overwrite = co | fr
> > >  let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
> > >  let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
> > > -let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
> > > +let ppo = to-r | to-w | (fence & int) | (po-unlock-lock-po & int)
> > >  
> > >  (* Propagation: Ordering from release operations and strong fences. *)
> > >  let A-cumul(r) = (rfe ; [Marked])? ; r
> > 
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Queued for the v6.4 merge window (not the current one), thank you both!

I tested both Alan's and Jonas's commit.  These do not see to produce
any significant differences in behavior, which is of course a good thing.

Here are the differences and a few oddities:

auto/C-RR-G+RR-R+RR-G+RR-G+RR-R+RR-R+RR-R+RR-R.litmus

	Timed out with changes, completed without them.  But it completed
	in 558.29 seconds against a limit of 600 seconds, so never mind.

auto/C-RR-G+RR-R+RR-R+RR-G+RR-R+RR-R+RR-G+RR-R.litmus

	Timed out with changes, completed without them.  But it completed
	in 580.01 seconds against a limit of 600 seconds, so never mind. *

auto/C-RR-G+RR-R+RR-R+RR-R+RR-R+RR-G+RR-R+RR-R.litmus

	Timed out with changes, completed without them.  But it completed
	in 522.29 seconds against a limit of 600 seconds, so never mind.

auto/C-RR-G+RR-R+RR-R+RR-R+RR-R+RR-G+RR-G+RR-R.litmus

	Timed out with changes, completed without them.  But it completed
	in 588.70 seconds against a limit of 600 seconds, so never mind.

All tests that didn't time out matched Results comments.

The reason I am so cavalier about the times is that I was foolishly
running rcutorture concurrently with the new-version testing.  I re-ran
and of them, only auto/C-RR-G+RR-R+RR-R+RR-G+RR-R+RR-R+RR-G+RR-R.litmus
timed out the second time.  I re-ran it again, but without a time limit,
and it completed properly in 364.8 seconds compared to 580.  A rerun
took 360.1 seconds.  So things have slowed down a bit.

A few other oddities:

litmus/auto/C-LB-Lww+R-OC.litmus

	Both versions flag a data race, which I am not seeing.	It appears
	to me that P1's store to u0 cannot happen unless P0's store
	has completed.  So what am I missing here?

litmus/auto/C-LB-Lrw+R-OC.litmus
litmus/auto/C-LB-Lww+R-Oc.litmus
litmus/auto/C-LB-Lrw+R-Oc.litmus
litmus/auto/C-LB-Lrw+R-A+R-Oc.litmus
litmus/auto/C-LB-Lww+R-A+R-OC.litmus

	Ditto.  (There are likely more.)

Thoughts?

							Thanx, Paul
