Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F64764F7CA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 06:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiLQFSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 00:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLQFSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 00:18:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C561C13DEF;
        Fri, 16 Dec 2022 21:18:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CA06B81ECE;
        Sat, 17 Dec 2022 05:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1522FC433EF;
        Sat, 17 Dec 2022 05:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671254280;
        bh=seabH3pp6Ywx4l0Rp3A9PBrYVqRhgw2IHVzlGMs1P8s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FxagPHMpLbrb8Csq2jT5Dc2oGXazsaSE0AZgxrjSW0wVao44XFaG3tHS7zTxE7vG8
         gIfvaFkz2Vj6A4RB8Cf0Uv7XTmztZVD0wxsdI9uhj3ODRbu1rPj0diKNfT83fG6JO5
         ll9apenHvo8puDg8hiVmKUDyjAP1d7PAZEduV+BkNwe0w3EtabOd4XyD8AJ6dEoCbg
         sPx0gm+F4nwjCUuoL3bfiPMVpQWO6WJSw/ezZxGErvQSpwntcBmxCqyUUtnrUA4PFc
         6D8hs6Q+gklHpCJjJCP0r7GnWvJZN5BJNCfxRD6mxyLcNNeFtLL1WSHU7CpEABr0Qb
         b9ceYFB9gwstQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AE1675C0A2D; Fri, 16 Dec 2022 21:17:59 -0800 (PST)
Date:   Fri, 16 Dec 2022 21:17:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Fix opposite might_sleep() check in
 rcu_blocking_is_gp()
Message-ID: <20221217051759.GK4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221215035755.2820163-1-qiang1.zhang@intel.com>
 <20221217010345.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880526CB255AFF91F0D76A2DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588000890D537044BBAA209EDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB588000890D537044BBAA209EDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 02:44:47AM +0000, Zhang, Qiang1 wrote:
> 
> On Thu, Dec 15, 2022 at 11:57:55AM +0800, Zqiang wrote:
> > Currently, if the system is in the RCU_SCHEDULER_INACTIVE state, invoke
> > synchronize_rcu_*() will implies a grace period and return directly,
> > so there is no sleep action due to waiting for a grace period to end,
> > but this might_sleep() check is the opposite. therefore, this commit
> > puts might_sleep() check in the correct palce.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >Queued for testing and review, thank you!
> >
> >I was under the impression that might_sleep() did some lockdep-based
> >checking, but I am unable to find it.  If there really is such checking,
> >that would be a potential argument for leaving this code as it is.
> >
> >
> >__might_sleep
> >   __might_resched(file, line, 0)
> >      rcu_sleep_check()
> >
> >Does it refer to this rcu_sleep_check() ?
> >
> >If so, when in the RCU_SCHEDULER_INACTIVE state,  the debug_lockdep_rcu_enabled() is always
> >return false, so the RCU_LOCKDEP_WARN() also does not produce an actual warning.
> 
> and when the system_state == SYSTEM_BOOTING, we just did  rcu_sleep_check()  and then  return.

Very good, thank you!

Thoughts from others?

							Thanx, Paul

> Thanks
> Zqiang
> 
> >Thanks
> >Zqiang
> >
> 
> >But in the meantime, full speed ahead!  ;-)
> >
> >						Thanx, Paul
> >
> > ---
> >  kernel/rcu/tree.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index ee8a6a711719..65f3dd2fd3ae 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3379,9 +3379,10 @@ void __init kfree_rcu_scheduler_running(void)
> >   */
> >  static int rcu_blocking_is_gp(void)
> >  {
> > -	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
> > +	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE) {
> > +		might_sleep();
> >  		return false;
> > -	might_sleep();  /* Check for RCU read-side critical section. */
> > +	}
> >  	return true;
> >  }
> >  
> > -- 
> > 2.25.1
> > 
