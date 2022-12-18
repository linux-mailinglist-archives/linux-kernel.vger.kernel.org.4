Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796DF65044F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 19:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiLRSaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 13:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiLRS33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 13:29:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A668110F2;
        Sun, 18 Dec 2022 10:06:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65E74B80ACD;
        Sun, 18 Dec 2022 18:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1847FC433EF;
        Sun, 18 Dec 2022 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671386799;
        bh=+4b8SHIncr61S7nWnckzDHjes+eO28WU/zoZBZUfYIc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X1pzg+BWsZgY6ueR9PUtwbTVDU5BouRHuV7TP2e4StpCRs1EmPGAaiLbZOiZQl8gf
         oEXvk4oqhy/NzRVsuDySFEo8pJcSgkfhJyiGrCGSHHMPF+g21ggm+sX4tUHo2k6JGY
         8ULptkkc5GxqsBh4NtIGXGEiNfcpe/7n1a8yMpYzjkXbDDvxzxFxdunFmriGB6l/G7
         yu67/Yu8dwBKocEIcgr1cGJ2M2BWQ6nnPLsjivQCP0XvQhboGZu3kP/g3SWbPhm6IK
         sq96U4ZbW4jHni6JMozP+DairwijYeWW9Ykz22yLgtC0mmoWucg4xbVFUR1lmeYpBf
         NrxQ8yVBhBYww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A8CFC5C0A43; Sun, 18 Dec 2022 10:06:38 -0800 (PST)
Date:   Sun, 18 Dec 2022 10:06:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Fix opposite might_sleep() check in
 rcu_blocking_is_gp()
Message-ID: <20221218180638.GR4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221215035755.2820163-1-qiang1.zhang@intel.com>
 <20221217010345.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880526CB255AFF91F0D76A2DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588000890D537044BBAA209EDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221217051759.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <Y550Z+MOq1IX3Wb4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y550Z+MOq1IX3Wb4@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 02:01:11AM +0000, Joel Fernandes wrote:
> On Fri, Dec 16, 2022 at 09:17:59PM -0800, Paul E. McKenney wrote:
> > On Sat, Dec 17, 2022 at 02:44:47AM +0000, Zhang, Qiang1 wrote:
> > > 
> > > On Thu, Dec 15, 2022 at 11:57:55AM +0800, Zqiang wrote:
> > > > Currently, if the system is in the RCU_SCHEDULER_INACTIVE state, invoke
> > > > synchronize_rcu_*() will implies a grace period and return directly,
> > > > so there is no sleep action due to waiting for a grace period to end,
> > > > but this might_sleep() check is the opposite. therefore, this commit
> > > > puts might_sleep() check in the correct palce.
> > > > 
> > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > >
> > > >Queued for testing and review, thank you!
> > > >
> > > >I was under the impression that might_sleep() did some lockdep-based
> > > >checking, but I am unable to find it.  If there really is such checking,
> > > >that would be a potential argument for leaving this code as it is.
> > > >
> > > >
> > > >__might_sleep
> > > >   __might_resched(file, line, 0)
> > > >      rcu_sleep_check()
> > > >
> > > >Does it refer to this rcu_sleep_check() ?
> > > >
> > > >If so, when in the RCU_SCHEDULER_INACTIVE state,  the debug_lockdep_rcu_enabled() is always
> > > >return false, so the RCU_LOCKDEP_WARN() also does not produce an actual warning.
> > > 
> > > and when the system_state == SYSTEM_BOOTING, we just did  rcu_sleep_check()  and then  return.
> > 
> > Very good, thank you!
> > 
> > Thoughts from others?
> 
> Please consider this as a best-effort comment that might be missing details:
> 
> The might_sleep() was added in 18fec7d8758d ("rcu: Improve synchronize_rcu()
> diagnostics")
> 
> Since it is illegal to call a blocking API like synchronize_rcu() in a
> non-preemptible section, is there any harm in just calling might_sleep()
> uncomditionally in rcu_block_is_gp() ? I think it is a bit irrelevant if
> synchronize_rcu() is called from a call path, before scheduler is
> initialized, or after. The fact that it was even called from a
> non-preemptible section is a red-flag, considering if such non-preemptible
> section may call synchronize_rcu() API in the future, after full boot up,
> even if rarely.
> 
> For this reason, IMHO there is still value in doing the might_sleep() check
> unconditionally. Say if a common code path is invoked both before
> RCU_SCHEDULER_INIT and *very rarely* after RCU_SCHEDULER_INIT.
> 
> Or is there more of a point in doing this check if scheduler is initialized
> from RCU perspective ?

One advantage of its current placement would be if might_sleep() ever
unconditionally checks for interrupts being disabled.

I don't believe that might_sleep() will do that any time soon given the
likely fallout from code invoked at early boot as well as from runtime,
but why be in the way of that additional diagnostic check?

							Thanx, Paul

> If not, I would do something like this:
> 
> ---8<-----------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 79aea7df4345..23c2303de9f4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3435,11 +3435,12 @@ static int rcu_blocking_is_gp(void)
>  {
>  	int ret;
>  
> +	might_sleep();  /* Check for RCU read-side critical section. */
> +
>  	// Invoking preempt_model_*() too early gets a splat.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE ||
>  	    preempt_model_full() || preempt_model_rt())
>  		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
> -	might_sleep();  /* Check for RCU read-side critical section. */
>  	preempt_disable();
>  	/*
>  	 * If the rcu_state.n_online_cpus counter is equal to one,
