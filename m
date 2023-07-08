Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C16D74BBE1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjGHE4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 00:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHE4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 00:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1A21992;
        Fri,  7 Jul 2023 21:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64B4B60180;
        Sat,  8 Jul 2023 04:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CAEC433C8;
        Sat,  8 Jul 2023 04:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688792206;
        bh=jIH7Dfx3OwyzpblB1J6hrgpIP+zaCBKcXWS7lbXyui0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qEoys0WaXmk7pNR5ZPtpF8oo5PmqL7P4as5nypl3VFH84TpNwVlXWQ5WVG4Rv7LXZ
         AbOVffz9IcqDpV4qlWdm36jqrwLx5Flr1o+VFt0aRhSeFk0kVBZvK57tVM2nUIate9
         AH6mvJiphww5q/EArHBI7Yr2LNZxT2jqj9nebTYO/PKgQ+a/ZjDrL3Zu3ChxRjYr+5
         bPDCcOaZZqaV2jznUPnB1k9NooBw4EPMWr97ZoXy5i+PZOxP5Wm8TGL0bjtYMzH3wo
         3w4tTP7E5+MWT35V2DNKh+1Lx6H/lB8Bbyf4a1tU13ogHyq4I+AYlLmRR6CA1e9GFu
         MC2hfzX/CF7hg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 25C7DCE00A7; Fri,  7 Jul 2023 21:56:46 -0700 (PDT)
Date:   Fri, 7 Jul 2023 21:56:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Make srcu_might_be_idle() take early return if
 rcu_gp_is_normal() return true
Message-ID: <daaefdef-03d7-4681-bceb-df29d488f5c3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230704082615.7415-1-qiang.zhang1211@gmail.com>
 <77d16cbb-b28c-4b13-aecb-9ad787559557@paulmck-laptop>
 <CALm+0cW6DojcxSnzf2mMXhXP-MHJ0aEvSqyh1TbtvBC4bzfsOw@mail.gmail.com>
 <087e3da2-ffd9-4cf4-8893-73f4edc3cfba@paulmck-laptop>
 <CALm+0cV2WdFzSaLpGodqv6idxvBSjupHPHNuK_z3r8Xya7KUuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cV2WdFzSaLpGodqv6idxvBSjupHPHNuK_z3r8Xya7KUuw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 10:11:30AM +0800, Z qiang wrote:
> >
> > On Fri, Jul 07, 2023 at 06:28:29PM +0800, Z qiang wrote:
> > > >
> > > > On Tue, Jul 04, 2023 at 04:26:15PM +0800, Zqiang wrote:
> > > > > When invoke synchronize_srcu(), in the srcu_might_be_idle(), the current
> > > > > CPU's sdp->lock will be acquired to check whether there are pending
> > > > > callbacks in the sdp->srcu_cblist, if there are no pending callbacks,
> > > > > probabilistically probe global state to decide whether to convert to
> > > > > synchronize_srcu_expedited() call. however, for the rcupdate.rcu_normal=1
> > > > > kernels and after the rcu_set_runtime_mode() is called, invoke the
> > > > > rcu_gp_is_normal() is always return true, this mean that invoke the
> > > > > synchronize_srcu_expedited() always fall back to synchronize_srcu(),
> > > > > so there is no need to acquire sdp->lock to check sdp->srcu_cblist and
> > > > > probe global state in srcu_might_be_idle().
> > > > >
> > > > > This commit therefore make srcu_might_be_idle() return immediately if the
> > > > > rcu_gp_is_normal() return true.
> > > > >
> > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > > ---
> > > > >  kernel/rcu/srcutree.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > index 20d7a238d675..aea49cb60a45 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -1172,6 +1172,8 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> > > > >       unsigned long tlast;
> > > > >
> > > > >       check_init_srcu_struct(ssp);
> > > > > +     if (rcu_gp_is_normal())
> > > > > +             return false;
> > > >
> > > > Again, thank you for looking into SRCU!
> > > >
> > > > I am not at all enthusiastic about this one.  With this change, the name
> > > > srcu_might_be_idle() is no longer accurate.  Yes, the name could change,
> > > > but any name would be longer and more confusing.
> > > >
> > > > So unless there is a measureable benefit to this one on a production
> > > > workload, I cannot justify taking it.
> > > >
> > > > Is there a measureable benefit?
> > >
> > > Hi, Paul
> > >
> > > I only find that for Preempt-RT kernel,  the rcu_normal_after_boot is
> > > set by default:
> > > static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
> > > This affects only rcu but also srcu, this make the synchronize_srcu() and
> > > synchronize_srcu_expedited() always fall back to __synchronize_srcu(ssp, true),
> > > this means that call the srcu_might_be_idle() is meaningless.
> >
> > I do understand that the current setup favors default kernel builds at
> > runtime by a few low-cost instructions, and that your change favors,
> > as you say, kernels built for real-time, kernels built for certain types
> > of HPC workloads, and all kernels during a small time during boot.
> >
> > My question is instead whether any of this makes a measureable difference
> > at the system level.
> >
> > My guess is "no, not even close", but the way to convince me otherwise
> > would be to actually run the workload and kernels on real hardware and
> > provide measurements showing a statistically significant difference that
> > the workload(s) in question care(s) about.
> >
> > So what can you show me?
> >
> > And srcu_might_be_idle() is not meaningless in that situation, just
> > ignored completely.  And that is in fact the nature and purpose of the
> > C-language || operator.  ;-)
> 
> Agree with you :)
> This make me want to ask another question,  why srcu also use
> rcupdate.rcu_normal and rcupdate.rcu_expedited to decide expedited
> srcu grace-period or only use normal grace-period instead of
> generating srcu_normal and srcu_expedited?

Because I have not yet come across a situation where it was useful for
the one to be expedited and the other normal.

But if you know of such a situation, let's talk about it.

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >                                                         Thanx, Paul
> >
> > > Thanks
> > > Zqiang
> > >
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > >       /* If the local srcu_data structure has callbacks, not idle.  */
> > > > >       sdp = raw_cpu_ptr(ssp->sda);
> > > > >       spin_lock_irqsave_rcu_node(sdp, flags);
> > > > > --
> > > > > 2.17.1
> > > > >
