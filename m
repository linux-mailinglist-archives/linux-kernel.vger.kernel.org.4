Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B7D636DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKWXAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKWXAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:00:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F393CED
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:00:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4829561F68
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEE0C433D6;
        Wed, 23 Nov 2022 23:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669244431;
        bh=xMQEI5/UaBXleLy7rFHYc25uhmr6Xx1RJf02gKDCj3M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nctdZzryom/KqAWlqstK1IX3ZErCw0/X5k4uA/2V6MLzCwgUcTqhN4zH6R9bAbRI9
         KvJyEzaOpSCZ3ORLjDsLGWheT4XrAAIncCtfo7+TOyBRUHqFdCNoXfHUma9WYp7r/w
         AjrCdqDjbUaJ7H33vIY+y/E10XveRVZvolFq6R14QZ4kUfxeGp3J4mMg+qp3VFmI8f
         uVv6JLbhmdLY6Rnl7LglwezKbF7G4hjzaOhwWZQIYfVrmOu2RGyMhv1L1QJhLhISWt
         GyN5jx9bWPP3agxPdRvTOFG60AAJtrVGSHtKRLuOJBISHW8HCwMGKdDcm1XNTJ8NE3
         MrXg92lfYJAgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 37FD85C0DF2; Wed, 23 Nov 2022 15:00:31 -0800 (PST)
Date:   Wed, 23 Nov 2022 15:00:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, dave@stgolabs.net,
        josh@joshtriplett.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
Message-ID: <20221123230031.GL4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221121035140.118651-1-zhouzhouyi@gmail.com>
 <20221122013754.GY4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123222543.GB1395324@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123222543.GB1395324@lothringen>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:25:43PM +0100, Frederic Weisbecker wrote:
> On Mon, Nov 21, 2022 at 05:37:54PM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 21, 2022 at 11:51:40AM +0800, Zhouyi Zhou wrote:
> > > @@ -358,7 +359,16 @@ torture_onoff(void *arg)
> > >  			schedule_timeout_interruptible(HZ / 10);
> > >  			continue;
> > >  		}
> > > +#ifdef CONFIG_NO_HZ_FULL
> > > +		/* do not offline tick do timer cpu */
> > > +		if (tick_nohz_full_running) {
> > > +			cpu = (torture_random(&rand) >> 4) % maxcpu;
> > > +			if (cpu >= tick_do_timer_cpu)
> > 
> > Why is this ">=" instead of "=="?
> > 
> > > +				cpu = (cpu + 1) % (maxcpu + 1);
> > > +		} else
> > > +#else
> > >  		cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
> > > +#endif
> > 
> > What happens if the value of tick_do_timer_cpu changes between the time of
> > the check above and the call to torture_offline() below?  Alternatively,
> > how is such a change in value prevented?
> 
> It can't, currently tick_do_timer_cpu is fixed when nohz_full is running.
> It can however have special values at early boot such as TICK_DO_TIMER_NONE.
> But if rcutorture is initialized after smp, it should be ok.

Ah, getting ahead of myself, thank you for the info!

So the thing to do would be to generate only maxcpu-1 choices.

							Thanx, Paul

> Thanks.
> 
> > 
> > 							Thanx, Paul
> > 
> > >  		if (!torture_offline(cpu,
> > >  				     &n_offline_attempts, &n_offline_successes,
> > >  				     &sum_offline, &min_offline, &max_offline))
> > > -- 
> > > 2.34.1
> > > 
