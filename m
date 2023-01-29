Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1967FCD3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 06:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjA2FRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 00:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2FRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 00:17:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BA01CAE5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 21:17:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33D26B80949
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 05:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EC4C433EF;
        Sun, 29 Jan 2023 05:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674969454;
        bh=e+C+wkZJWSvn1BATmhxdUMJRZVzw+/73+q/xG605ol4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PXoT17Z0OaZ5CkAa3hxeVIuA5gN/SAvyuWLy2CZH8HRF3W/j2BQ0BUk7TT4IdeEgn
         yQYpzC015Y4unTkxJ8TLZWLKltmmc4jl8GHVfBt8viiq3hHgIL8hQcP+7r+mr950pZ
         wPFI2nbLC+7t9RLAZ4UvrIwD32usN1h+OdljHOGuRNFSI6Ku8lhfe62bFGaOkLY5h5
         wEHxe9RbQFSGvcDYpzsggWFz6vqJYyXjFAOIA0eAPtE7qEdcSWBt+XVXKmMgejy0ZP
         JAhsAhVce6WSTpyPb+v7FcFI8I2RiUaXSAWs0quUp1kmtnCRCda37HTvmfXOAFfRRP
         KzexzUSBcXpkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6C98B5C0882; Sat, 28 Jan 2023 21:17:34 -0800 (PST)
Date:   Sat, 28 Jan 2023 21:17:34 -0800
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
Message-ID: <20230129051734.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 05:59:52PM -0500, Alan Stern wrote:
> On Sat, Jan 28, 2023 at 11:14:17PM +0100, Andrea Parri wrote:
> > > Evidently the plain-coherence check rules out x=1 at the 
> > > end, because when I relax that check, x=1 becomes a possible result.  
> > > Furthermore, the graphical output confirms that this execution has a 
> > > ww-incoh edge from Wx=2 to Wx=1.  But there is no ww-vis edge from Wx=1 
> > > to Wx=2!  How can this be possible?  It seems like a bug in herd7.
> > 
> > By default, herd7 performs some edges removal when generating the
> > graphical outputs.  The option -showraw can be useful to increase
> > the "verbosity", for example,
> > 
> >   [with "exists (x=2)", output in /tmp/T.dot]
> >   $ herd7 -conf linux-kernel.cfg T.litmus -show prop -o /tmp -skipchecks plain-coherence -doshow ww-vis -showraw ww-vis
> 
> Okay, thanks, that helps a lot.
> 
> So here's what we've got.  The litmus test:
> 
> 
> C hb-and-int
> {}
> 
> P0(int *x, int *y)
> {
>     *x = 1;
>     smp_store_release(y, 1);
> }
> 
> P1(int *x, int *y, int *dx, int *dy, spinlock_t *l)
> {
>     spin_lock(l);
>     int r1 = READ_ONCE(*dy);
>     if (r1==1)
>         spin_unlock(l);
> 
>     int r0 = smp_load_acquire(y);
>     if (r0 == 1) {
>         WRITE_ONCE(*dx,1);
>     }

The lack of a spin_unlock() when r1!=1 is intentional?

It is admittedly a cute way to prevent P3 from doing anything
when r1!=1.  And P1 won't do anything if P3 runs first.

> }
> 
> P2(int *dx, int *dy)
> {
>     WRITE_ONCE(*dy,READ_ONCE(*dx));
> }
> 
> 
> P3(int *x, spinlock_t *l)
> {
>     spin_lock(l);
>     smp_mb__after_unlock_lock();
>     *x = 2;
> }
> 
> exists (x=2)
> 
> 
> The reason why Wx=1 ->ww-vis Wx=2:
> 
> 	0:Wx=1 ->po-rel 0:Wy=1 and po-rel < fence < ww-post-bounded.
> 
> 	0:Wy=1 ->rfe 1:Ry=1 ->(hb* & int) 1:Rdy=1 and
> 		(rfe ; hb* & int) <= (rfe ; xbstar & int) <= vis.
> 
> 	1:Rdy=1 ->po 1:unlock ->rfe 3:lock ->po 3:Wx=2
> 		so 1:Rdy=1 ->po-unlock-lock-po 3:Wx=2
> 		and po-unlock-lock-po <= mb <= fence <= w-pre-bounded.
> 
> Finally, w-post-bounded ; vis ; w-pre-bounded <= ww-vis.
> 
> This explains why the memory model says there isn't a data race.  This 
> doesn't use the smp_mb__after_unlock_lock at all.

You lost me on this one.

Suppose that P3 starts first, then P0.  P1 is then stuck at the
spin_lock() because P3 does not release that lock.  P2 goes out for a
pizza.

Why can't the two stores to x by P0 and P3 conflict, resulting in a
data race?

							Thanx, Paul
