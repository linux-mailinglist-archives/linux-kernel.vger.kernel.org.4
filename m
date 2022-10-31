Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5230613C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiJaRmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiJaRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506ECDFBA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D950F61363
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 17:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F853C433D6;
        Mon, 31 Oct 2022 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667238133;
        bh=Abc89EMf7l3S9ZPbr6wRc/D8oF8wZ7KW0J6mu12qlM8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lxgaCPKLhq/0WxF6sA7Q+ctDkqYy9KskEW0LHaw2TwOeZrURZyKACuZ/ZTD269KcV
         LMRIUCvVA+ZwDNs3vHZOV8opmK0BI6FefWyZjaTErWZJJnM5bJHWpZSMPjmlm0ajml
         u6+f3iD5aGJY2lH8PhWeTMerQSHdtc7i3kLDfeRJUUk15bryW0bKVuDyR2b3m4ww4X
         hf0pAvxh8b7fNwbxYcxHgq/MQ560AuoLtdscrFlRMMZZ+ap4cfeHTRSaoZw+DWxOO1
         WUfmiA2aO2eLIAMHhn0ZtKfUn5WsDUiknbJrQWBR/WmJTzeNMNGqhrE1VwCD2KOuPq
         IzbJehfIDjcJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CFFEF5C0920; Mon, 31 Oct 2022 10:42:12 -0700 (PDT)
Date:   Mon, 31 Oct 2022 10:42:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-kernel@vger.kernel.org, clm@meta.com, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, longman@redhat.com
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Message-ID: <20221031174212.GB5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
 <Y1ECHVUHilqgKD9o@feng-clx>
 <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1Hr6PNy9EJk245f@feng-clx>
 <20221028175245.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <Y19kStu4zBFyvKPK@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y19kStu4zBFyvKPK@feng-clx>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:59:38PM +0800, Feng Tang wrote:
> On Fri, Oct 28, 2022 at 10:52:45AM -0700, Paul E. McKenney wrote:
> [...]
> > > > Left to myself, I would use a capped power-of-two backoff that was reset
> > > > any time that the interval was within bounds.  Maybe a cap of 10 minutes?
> > > 
> > > Yep, that's more informative. Thanks!
> > 
> > And here is the resulting patch.  Thoughts?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit adc0512cf34fe7f0d73966d59644b826ee526742
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Fri Oct 28 10:38:58 2022 -0700
> > 
> >     clocksource: Exponential backoff for load-induced bogus watchdog reads
> >     
> >     The clocksource watchdog will reject measurements that are excessively
> >     delayed, that is, by more than 1.5 seconds beyond the intended 0.5-second
> >     watchdog interval.  On an extremely busy system, this can result in a
> >     console message being printed every two seconds.  This is excessively
> >     noisy for a non-error condition.
> >     
> >     Therefore, apply exponential backoff to these messages.  This exponential
> >     backoff is capped at 1024 times the watchdog interval, which comes to
> >     not quite one message per ten minutes.
> >     
> >     Please note that the bogus watchdog reads that occur when the watchdog
> >     interval is less than 0.125 seconds are still printed unconditionally
> >     because these likely correspond to a serious error condition in the
> >     timer code or hardware.
> >     
> >     Reported-by: Waiman Long <longman@redhat.com>
> >     Reported-by: Feng Tang <feng.tang@intel.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Cc: John Stultz <jstultz@google.com>
> >     Cc: Thomas Gleixner <tglx@linutronix.de>
> >     Cc: Stephen Boyd <sboyd@kernel.org>
> >     Cc: Feng Tang <feng.tang@intel.com>
> >     Cc: Waiman Long <longman@redhat.com>
> > 
> > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> > index 1d42d4b173271..daac05aedf56a 100644
> > --- a/include/linux/clocksource.h
> > +++ b/include/linux/clocksource.h
> > @@ -125,6 +125,10 @@ struct clocksource {
> >  	struct list_head	wd_list;
> >  	u64			cs_last;
> >  	u64			wd_last;
> > +	u64			wd_last_bogus;
> > +	int			wd_bogus_shift;
> > +	unsigned long		wd_bogus_count;
> > +	unsigned long		wd_bogus_count_last;
> >  #endif
> >  	struct module		*owner;
> >  };
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index 3f5317faf891f..6537ffa02e445 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -448,8 +448,26 @@ static void clocksource_watchdog(struct timer_list *unused)
> >  			continue;
> >  		}
> >  		if (wd_nsec > (wdi << 2)) {
> 
> Just recalled one thing, that it may be better to check 'cs_nsec' 
> instead of 'wd_nsec', as some watchdog may have small wrap-around
> value. IIRC, HPET's counter is 32 bits long and wraps at about
> 300 seconds, and PMTIMER's counter is 24 bits which wraps at about
> 3 ~ 4 seconds. So when a long stall of the watchdog timer happens,
> the watchdog's value could 'overflow' many times.
> 
> And usually the 'current' closcksource has longer wrap time than
> the watchdog.

Why not both?

 		if (wd_nsec > (wdi << 2) || cs_nsec > (wdi << 2)) {

> > -			/* This can happen on busy systems, which can delay the watchdog. */
> > -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > +			bool needwarn = false;
> > +			u64 wd_lb;
> > +
> > +			cs->wd_bogus_count++;
> > +			if (!cs->wd_bogus_shift) {
> > +				needwarn = true;
> > +			} else {
> > +				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
> > +				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> > +				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
> > +					needwarn = true;
> 
> I'm not sure if we need to check the last_bogus counter, or just
> the current interval 'cs_nsec' is what we care, and some code
> like this ?

I thought we wanted exponential backoff?  Do you really get that from
the changes below?

And should we be using something like the jiffies counter to measure the
exponential backoff?

							Thanx, Paul

> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index daac05aedf56..3910dbb9b960 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -125,7 +125,6 @@ struct clocksource {
>  	struct list_head	wd_list;
>  	u64			cs_last;
>  	u64			wd_last;
> -	u64			wd_last_bogus;
>  	int			wd_bogus_shift;
>  	unsigned long		wd_bogus_count;
>  	unsigned long		wd_bogus_count_last;
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 6537ffa02e44..8e6d498b1492 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -442,28 +442,18 @@ static void clocksource_watchdog(struct timer_list *unused)
>  
>  		/* Check for bogus measurements. */
>  		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> -		if (wd_nsec < (wdi >> 2)) {
> +		if (cs_nsec < (wdi >> 2)) {
>  			/* This usually indicates broken timer code or hardware. */
> -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +			pr_warn("timekeeping watchdog on CPU%d: clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), cs->name, wd_nsec, WATCHDOG_INTERVAL);
>  			continue;
>  		}
> -		if (wd_nsec > (wdi << 2)) {
> -			bool needwarn = false;
> -			u64 wd_lb;
> -
> +		if (cs_nsec > (wdi << 2)) {
>  			cs->wd_bogus_count++;
> -			if (!cs->wd_bogus_shift) {
> -				needwarn = true;
> -			} else {
> -				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
> -				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> -				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
> -					needwarn = true;
> -			}
> -			if (needwarn) {
> +			if (!cs->wd_bogus_shift ||
> +			    (1 << cs->wd_bogus_shift) * wdi <= cs_nsec) {
>  				/* This can happen on busy systems, which can delay the watchdog. */
> -				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count - cs->wd_bogus_count_last);
> -				cs->wd_last_bogus = wdnow;
> +				pr_warn("timekeeping watchdog on CPU%d: clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), cs->name, cs_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count - cs->wd_bogus_count_last);
> +
>  				if (cs->wd_bogus_shift < 10)
>  					cs->wd_bogus_shift++;
>  				cs->wd_bogus_count_last = cs->wd_bogus_count;
> 
> Thanks,
> Feng
> 
> 
> > +			}
> > +			if (needwarn) {
> > +				/* This can happen on busy systems, which can delay the watchdog. */
> > +				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count - cs->wd_bogus_count_last);
> > +				cs->wd_last_bogus = wdnow;
> > +				if (cs->wd_bogus_shift < 10)
> > +					cs->wd_bogus_shift++;
> > +				cs->wd_bogus_count_last = cs->wd_bogus_count;
> > +			}
> >  			continue;
> >  		}
> >  
