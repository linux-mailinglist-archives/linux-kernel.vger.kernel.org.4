Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC304656DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 19:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiL0Si0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 13:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiL0SiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:38:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4571086
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 10:38:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E7AFB811CE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 18:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D48C433D2;
        Tue, 27 Dec 2022 18:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672166299;
        bh=gx4NbBb8aTMMHzMqjLaQmjj0MyXIwWjJNkmXDYW0MA4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=trhhbEykKtx91/Z2LWGOuziJN525/pXkaN5UwEqUCQQQ/7bB9sENEf5B/+tKzl9Y7
         GqbHCkBsTFez3bgFspv9wAltyXWUOFaCbs1HDGRuQTo4yUk/CN97IYsJpLnpzJMfbH
         bl+CjOtNC0d3i8FbiBxXHgFmnol58LZejdwqNwGotbHd4nYzLdG2Wz8qyLAr6Pifk/
         UEXlh/cm/sUXYc2kJSoGT3IZsJ0hZxu23HdMpSKd0HzDxBPwvAA1BXXu9178tsTN9z
         gcAh6lVz0aj6+7Y8BtCme046o0BuGwIGDBs4qzMmKcWmmLtZQyagFuJzJBC+JF4RBI
         WwZFCMI/j8UvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3E1205C0AC4; Tue, 27 Dec 2022 10:38:19 -0800 (PST)
Date:   Tue, 27 Dec 2022 10:38:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <20221227183819.GI4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221222055515.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6PyisHYYtde/6Xk@feng-clx>
 <20221222061429.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6P7JPHf9wDse0XK@feng-clx>
 <20221222182446.GQ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221222214219.GA1875767@paulmck-ThinkPad-P17-Gen-1>
 <Y6UNwAOQIGWyDfsX@feng-clx>
 <20221223033729.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <ad71008d-4acc-d211-dc19-c33bb25ff42c@redhat.com>
 <Y6UrQd2VIyakhV/U@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6UrQd2VIyakhV/U@feng-clx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 12:14:57PM +0800, Feng Tang wrote:
> On Thu, Dec 22, 2022 at 10:49:23PM -0500, Waiman Long wrote:
> > On 12/22/22 22:37, Paul E. McKenney wrote:
> > > > > commit dfbf67806c4c7f2bdd79cdefe86a2bea6e7afcab
> > > > > Author: Paul E. McKenney<paulmck@kernel.org>
> > > > > Date:   Thu Dec 22 13:21:47 2022 -0800
> > > > > 
> > > > >      clocksource: Permit limited-duration clocksource watchdogging
> > > > >      Some systems want regular clocksource checking, but their workloads
> > > > >      cannot tolerate the overhead of full-time clocksource checking.
> > > > >      Therefore, add a CLOCKSOURCE_WATCHDOG_DURATION Kconfig option and a
> > > > >      clocksource.watchdog_duration kernel-boot parameter that limits the
> > > > >      clocksource watchdog to the specified number of minutes past boot.
> > > > >      Values of zero disable checking, and a value of -1 restores the
> > > > >      traditional behavior of always checking.
> > > > >      This does change behavior compared to older kernels, but recent kernels
> > > > >      disable the clocksource watchdog completely in the common case where the
> > > > >      TSC is judged to be trustworthy.  This change in behavior is therefore
> > > > >      not a real issue.
> > > > Yes, this changes the general semantics. Last year, I've posted a
> > > > patch to limit the watchdog to run for 10 minutes, and at that time
> > > > Thomas mentioned one of his machine may show tsc issue after running
> > > > for one day depending on work load [1].
> > > > 
> > > > As the intention is to validate HPET/PMTIMER, which are not as
> > > > delicate as TSC, maybe we can add a per-clocksource verify-period
> > > > field, and only set it for HPET/PMTIMER?
> > > > 
> > > > [1].https://lore.kernel.org/lkml/875z286xtk.fsf@nanos.tec.linutronix.de/
> > > Got it.
> > > 
> > > The workloads I am closest to are OK with the clocksource watchdog
> > > running indefinitely, but thus far the skew is visible very early.
> > > But broken hardware can do whatever it wants whenever it wants.  I could
> > > meet Thomas's request by making the default be indefinite, and allowing
> > > whoever cares to make it finite.  Or maybe the fact that the TSC is not
> > > marked unstable makes a difference.
> > > 
> > > Thoughts?
> > 
> > Sorry for the late reply.
> > 
> > Maybe the default should be an auto mode where if TSC is marked stable and
> > don't need to verify, we can run watchdog for HPET and PMTMR for 10 mins.
> > Otherwise, run it indefinitely to not change existing behavior.
> 
> Yes, sounds reasonable to me. 
> 
> btw, what I suggested in last mail is some code (untested) like this:
> 
> ---
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index c8eb1ac5125a..db20aac5d14d 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -862,6 +862,7 @@ static struct clocksource clocksource_hpet = {
>  	.mask		= HPET_MASK,
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>  	.resume		= hpet_resume_counter,
> +	.wd_limited	= true,
>  };
>  
>  /*
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 1d42d4b17327..2b6278f69516 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -125,6 +125,8 @@ struct clocksource {
>  	struct list_head	wd_list;
>  	u64			cs_last;
>  	u64			wd_last;
> +	bool			wd_limited;
> +	u64			wd_iters;
>  #endif
>  	struct module		*owner;
>  };
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 777a5eba68fd..eb2d9adf06b0 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -425,6 +425,8 @@ static void clocksource_watchdog(struct timer_list *unused)
>  			cs->flags |= CLOCK_SOURCE_WATCHDOG;
>  			cs->wd_last = wdnow;
>  			cs->cs_last = csnow;
> +			if (cs->wd_limited)
> +				cs->wd_iters = 1200;
>  			continue;
>  		}
>  
> @@ -492,6 +494,9 @@ static void clocksource_watchdog(struct timer_list *unused)
>  				tick_clock_notify();
>  			}
>  		}
> +
> +		if (cs->wd_limited && !(cs->wd_iters--))
> +			list_del_init(&cs->wd_list);
>  	}
>  
>  	/*

If this works for Waiman, and given a proper patch, I am happy to replace
my b90f0a5cfc0e ("clocksource: Permit limited-duration clocksource
watchdogging") with this that proper patch.

> Thanks,
> Feng
> 
> > Given such a default, I don't think we need your second patch to determine
> > if both HPET and PMTMR needs to be checked.

And indeed, this one is off to the side, not on track for mainline:

375e65d3055f ("clocksource: Limit the number of watchdogged clocksources")

But if I am confused about which patch you mean, please let me know!

							Thanx, Paul
