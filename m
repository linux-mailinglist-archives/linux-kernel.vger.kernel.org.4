Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D3A67FB70
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 23:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjA1W74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 17:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjA1W7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 17:59:54 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0D112233E0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 14:59:52 -0800 (PST)
Received: (qmail 352652 invoked by uid 1000); 28 Jan 2023 17:59:52 -0500
Date:   Sat, 28 Jan 2023 17:59:52 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        paulmck@kernel.org, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9WeOTmGCCfjMUtG@andrea>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 11:14:17PM +0100, Andrea Parri wrote:
> > Evidently the plain-coherence check rules out x=1 at the 
> > end, because when I relax that check, x=1 becomes a possible result.  
> > Furthermore, the graphical output confirms that this execution has a 
> > ww-incoh edge from Wx=2 to Wx=1.  But there is no ww-vis edge from Wx=1 
> > to Wx=2!  How can this be possible?  It seems like a bug in herd7.
> 
> By default, herd7 performs some edges removal when generating the
> graphical outputs.  The option -showraw can be useful to increase
> the "verbosity", for example,
> 
>   [with "exists (x=2)", output in /tmp/T.dot]
>   $ herd7 -conf linux-kernel.cfg T.litmus -show prop -o /tmp -skipchecks plain-coherence -doshow ww-vis -showraw ww-vis

Okay, thanks, that helps a lot.

So here's what we've got.  The litmus test:


C hb-and-int
{}

P0(int *x, int *y)
{
    *x = 1;
    smp_store_release(y, 1);
}

P1(int *x, int *y, int *dx, int *dy, spinlock_t *l)
{
    spin_lock(l);
    int r1 = READ_ONCE(*dy);
    if (r1==1)
        spin_unlock(l);

    int r0 = smp_load_acquire(y);
    if (r0 == 1) {
        WRITE_ONCE(*dx,1);
    }
}

P2(int *dx, int *dy)
{
    WRITE_ONCE(*dy,READ_ONCE(*dx));
}


P3(int *x, spinlock_t *l)
{
    spin_lock(l);
    smp_mb__after_unlock_lock();
    *x = 2;
}

exists (x=2)


The reason why Wx=1 ->ww-vis Wx=2:

	0:Wx=1 ->po-rel 0:Wy=1 and po-rel < fence < ww-post-bounded.

	0:Wy=1 ->rfe 1:Ry=1 ->(hb* & int) 1:Rdy=1 and
		(rfe ; hb* & int) <= (rfe ; xbstar & int) <= vis.

	1:Rdy=1 ->po 1:unlock ->rfe 3:lock ->po 3:Wx=2
		so 1:Rdy=1 ->po-unlock-lock-po 3:Wx=2
		and po-unlock-lock-po <= mb <= fence <= w-pre-bounded.

Finally, w-post-bounded ; vis ; w-pre-bounded <= ww-vis.

This explains why the memory model says there isn't a data race.  This 
doesn't use the smp_mb__after_unlock_lock at all.

Alan
