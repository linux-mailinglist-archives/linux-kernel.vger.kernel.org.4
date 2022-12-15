Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF464D50D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLOBjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLOBjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:39:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB371EAE0;
        Wed, 14 Dec 2022 17:39:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35407B81AD3;
        Thu, 15 Dec 2022 01:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96F0C433F0;
        Thu, 15 Dec 2022 01:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671068378;
        bh=s6b0uszi3DpFRj6ZPXGBLSj2n0806qTbbl7XXYe9TSw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=obsJuRgco9TTNdcWHiJmTFbt3bu81Pjuf7EuJfmhooUlDQyBiNnLDqaJc5Qw67xVs
         9joX6AkbHN/I69XqpylEyti2JvGoEg2j1jwieDXhcOCgPOMo0Xv6LEZ4AfTov5LRWD
         PNv4wteumSDMDVSA8SPv7dsr8FIp35LKqXynHlZ0Xw3ZzVz3IZqjIVPPInBi4BigV5
         rnPCno/cExZVdEGvJXSd9FWM/sk6XnSmlzYfxVnCCAxpeyJzwToZLHhJSDRP83xQE+
         xbcWpTByJv4t/zsf1PbNLPSfan6WOsum/7CHM3B70P7vVPa2/+NO6xIWg0TEacQi9l
         IJSfa7bhZ7Qnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 657165C0A6A; Wed, 14 Dec 2022 17:39:38 -0800 (PST)
Date:   Wed, 14 Dec 2022 17:39:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     boqun.feng@gmail.com, frederic@kernel.org, neeraj.iitr10@gmail.com,
        urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221215013938.GF4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com>
 <20221214212455.GA4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
 <CAEXW_YRvSrD40WJ+8GicWB5NN8QyLLoUzRS9j8Tc9CMvojKO0g@mail.gmail.com>
 <CAEXW_YQx78ge_U7asX4YHcsi1EDZSRo_wGN_DJmWnXcAYjHWgQ@mail.gmail.com>
 <20221215000433.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQsJCcK7+fMaXQ9rLWt05+s9NrKT=uGrUaSe9HzfbM5sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQsJCcK7+fMaXQ9rLWt05+s9NrKT=uGrUaSe9HzfbM5sg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 08:34:03PM -0500, Joel Fernandes wrote:
> On Wed, Dec 14, 2022 at 7:04 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Dec 14, 2022 at 11:14:48PM +0000, Joel Fernandes wrote:
> > > On Wed, Dec 14, 2022 at 11:10 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Wed, Dec 14, 2022 at 11:07 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > On Wed, Dec 14, 2022 at 9:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > I also did not get why you care about readers that come and ago (you
> > > > > > > mentioned the first reader seeing incorrect idx and the second reader
> > > > > > > seeing the right flipped one, etc). Those readers are irrelevant
> > > > > > > AFAICS since they came and went, and need not be waited on , right?.
> > > > > >
> > > > > > The comment is attempting to show (among other things) that we don't
> > > > > > need to care about readers that come and go more than twice during that
> > > > > > critical interval of time during the counter scans.
> > > > >
> > > > > Why do we need to care about readers that come and go even once? Once
> > > > > they are gone, they have already done an unlock() and their RSCS is
> > > > > over, so they need to be considered AFAICS.
> > > > >
> > > >
> > > > Aargh, I meant: "so they need to be considered AFAICS".
> > >
> > > Trying again: "so they need not be considered AFAICS".
> >
> > Give or take counter wrap, which can make it appear that still-present
> > readers have finished.
> 
> Ah you mean those flood of readers affect the counter wrapping and not
> that those readers have to be waited on or anything, they just happen
> to have a side-effect on *existing readers* which need to be waited
> on.

Exactly, that flood of readers could potentially result in a
counter-wrap-induced too-short SRCU grace period, and it is SRCU's job
to avoid that, and specifically the job of the code that this comment
lives in.

> Thanks a lot for this explanation, this part I agree. Readers that
> sampled the idx before the flip happened, and then did their
> lock+unlock counter increments both after the flip, and after the
> second unlock counter scan (second scan), can mess up the lock
> counters such that the second scan found lock==unlock, even though it
> is not to be due to pre-existing readers. But as you pointed out,
> there have to be a substantially large number of these to cause the
> equality check to match. This might be another reason why it is
> important to scan the unlocks first, because the locks are what have
> to cause the wrap around of the lock counter. Instead if you counted
> locks first, then the unlocks would have to do the catching up to the
> locks which are much fewer than a full wrap around.

True enough!

> I still don't see why this affects only the first reader. There could
> be more than 1 reader that needs to be waited on (the readers that
> started before the grace period started). Say there are 5 of them.
> When the grace period starts, the interfering readers (2^32 of them or
> so) could have sampled the old idx before the flip, and then do
> lock+unlock (on that old pre-flip() idx) in quick succession after the
> smp_mb() in the second srcu_readers_active_idx_check(). That causes
> those 5 poor readers to not be waited on. Granted, any new readers
> after this thundering herd should see the new idx and will not be
> affected, thanks to the memory barriers.

Yes, there could be quite a few such readers, but it only takes one
messed-up reader to constitute a bug in SRCU.  ;-)

> Still confused, but hey I'll take it little at a time ;-) Also thanks
> for the suggestions for litmus tests.

Agreed, setting this sort of thing aside for a bit and then coming back
to it can be helpful.

							Thanx, Paul

> Cheers,
> 
>  - Joel
> 
> > > Anyway, my 1 year old son is sick so signing off for now. Thanks.
> >
> > Ouch!  I hope he recovers quickly and completely!!!
> >
> >                                                         Thanx, Paul
