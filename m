Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F613650484
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 20:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiLRTol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 14:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLRToi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 14:44:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA62B495;
        Sun, 18 Dec 2022 11:44:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC7E660DDC;
        Sun, 18 Dec 2022 19:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C40BC433D2;
        Sun, 18 Dec 2022 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671392675;
        bh=dVPM6t6Xg9f0O6WvLPMHXT7BN3dRlhW2IcLr0cu6VMY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K63PTY/mY1/GUExSYigG4BdC5FJrbiWkBAr1HSYyXPzkp9SN0ffIq5g8qsmt+D2Qx
         YFZGTdTXpSLo33ZGSbSOYEe6orb5GF3BLKgsRtrWFTdGaUc/qzuQ6PvxYkQp0eS0G2
         EYBUQSKF1VGkLvLclg1Ho1SRW2WJYO5v5pth/2YYJAX0yuhST/KcYTVv6rz/dB9J/g
         T7OWWRLFO/MictVNoxGXQGYvqOG8aN8y2JuqX/DXJKoDYLhP/334NZGFLBteji+rJO
         v+3TD4A5hT94HkUK9igov4fv8bu8Ymm0uIwDYTFZO7c9Bw+FC2IaHBpSd6AlM64vIx
         DXWoH0unlrfBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E80C35C0A43; Sun, 18 Dec 2022 11:44:34 -0800 (PST)
Date:   Sun, 18 Dec 2022 11:44:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Fix opposite might_sleep() check in
 rcu_blocking_is_gp()
Message-ID: <20221218194434.GS4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221215035755.2820163-1-qiang1.zhang@intel.com>
 <20221217010345.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880526CB255AFF91F0D76A2DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588000890D537044BBAA209EDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221217051759.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <Y550Z+MOq1IX3Wb4@google.com>
 <20221218180638.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSy4MyUW55Umtt4LRfX_4Dhdv0h2O=n+Zbq2ijakwGnBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSy4MyUW55Umtt4LRfX_4Dhdv0h2O=n+Zbq2ijakwGnBw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 02:29:10PM -0500, Joel Fernandes wrote:
> On Sun, Dec 18, 2022 at 1:06 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sun, Dec 18, 2022 at 02:01:11AM +0000, Joel Fernandes wrote:
> > > On Fri, Dec 16, 2022 at 09:17:59PM -0800, Paul E. McKenney wrote:
> > > > On Sat, Dec 17, 2022 at 02:44:47AM +0000, Zhang, Qiang1 wrote:
> > > > >
> > > > > On Thu, Dec 15, 2022 at 11:57:55AM +0800, Zqiang wrote:
> > > > > > Currently, if the system is in the RCU_SCHEDULER_INACTIVE state, invoke
> > > > > > synchronize_rcu_*() will implies a grace period and return directly,
> > > > > > so there is no sleep action due to waiting for a grace period to end,
> > > > > > but this might_sleep() check is the opposite. therefore, this commit
> > > > > > puts might_sleep() check in the correct palce.
> > > > > >
> > > > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > > >
> > > > > >Queued for testing and review, thank you!
> > > > > >
> > > > > >I was under the impression that might_sleep() did some lockdep-based
> > > > > >checking, but I am unable to find it.  If there really is such checking,
> > > > > >that would be a potential argument for leaving this code as it is.
> > > > > >
> > > > > >
> > > > > >__might_sleep
> > > > > >   __might_resched(file, line, 0)
> > > > > >      rcu_sleep_check()
> > > > > >
> > > > > >Does it refer to this rcu_sleep_check() ?
> > > > > >
> > > > > >If so, when in the RCU_SCHEDULER_INACTIVE state,  the debug_lockdep_rcu_enabled() is always
> > > > > >return false, so the RCU_LOCKDEP_WARN() also does not produce an actual warning.
> > > > >
> > > > > and when the system_state == SYSTEM_BOOTING, we just did  rcu_sleep_check()  and then  return.
> > > >
> > > > Very good, thank you!
> > > >
> > > > Thoughts from others?
> > >
> > > Please consider this as a best-effort comment that might be missing details:
> > >
> > > The might_sleep() was added in 18fec7d8758d ("rcu: Improve synchronize_rcu()
> > > diagnostics")
> > >
> > > Since it is illegal to call a blocking API like synchronize_rcu() in a
> > > non-preemptible section, is there any harm in just calling might_sleep()
> > > uncomditionally in rcu_block_is_gp() ? I think it is a bit irrelevant if
> > > synchronize_rcu() is called from a call path, before scheduler is
> > > initialized, or after. The fact that it was even called from a
> > > non-preemptible section is a red-flag, considering if such non-preemptible
> > > section may call synchronize_rcu() API in the future, after full boot up,
> > > even if rarely.
> > >
> > > For this reason, IMHO there is still value in doing the might_sleep() check
> > > unconditionally. Say if a common code path is invoked both before
> > > RCU_SCHEDULER_INIT and *very rarely* after RCU_SCHEDULER_INIT.
> > >
> > > Or is there more of a point in doing this check if scheduler is initialized
> > > from RCU perspective ?
> >
> > One advantage of its current placement would be if might_sleep() ever
> > unconditionally checks for interrupts being disabled.
> >
> > I don't believe that might_sleep() will do that any time soon given the
> > likely fallout from code invoked at early boot as well as from runtime,
> > but why be in the way of that additional diagnostic check?
> 
> If I understand the current code, might_sleep() is invoked only if the
> scheduler is INACTIVE from RCU perspective, and I don't think here are
> reports of fall out. That is current code behavior.
> 
> Situation right now is: might_sleep() only if the state is INACTIVE.
> Qiang's patch: might_sleep() only if the state is NOT INACTIVE.
> My suggestion: might_sleep() regardless of the state.
> 
> Is there a reason my suggestion will not work? Apologies if I
> misunderstood something.
> 
> thanks,
> 
>  - Joel
> 
> 
> >
> >                                                         Thanx, Paul
> >
> > > If not, I would do something like this:
> > >
> > > ---8<-----------------------
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 79aea7df4345..23c2303de9f4 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3435,11 +3435,12 @@ static int rcu_blocking_is_gp(void)
> > >  {
> > >       int ret;
> > >
> > > +     might_sleep();  /* Check for RCU read-side critical section. */
> > > +
> > >       // Invoking preempt_model_*() too early gets a splat.
> > >       if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE ||
> > >           preempt_model_full() || preempt_model_rt())
> > >               return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;

If the scheduler is inactive (early boot with interrupts disabled),
we return here.

> > > -     might_sleep();  /* Check for RCU read-side critical section. */

We get here only if the scheduler has started, and even then only in
preemption-disabled kernels.

Or is you concern that the might_sleep() never gets invoked in kernels
with preemption enabled?  Fixing that would require a slightly different
patch, though.

Or should I have waited until tomorrow to respond to this email?  ;-)

							Thanx, Paul

> > >       preempt_disable();
> > >       /*
> > >        * If the rcu_state.n_online_cpus counter is equal to one,
