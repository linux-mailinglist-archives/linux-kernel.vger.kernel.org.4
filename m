Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A943618E39
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiKDCXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKDCXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:23:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518B51135
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E33C761FB8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EF5C433D6;
        Fri,  4 Nov 2022 02:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667528617;
        bh=pRGAg/wBH4WkHx1UgEahGYENUVC88T1CXjDh6w+3eJE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BttJYgE2lK8hOQP7YNU5l6H+MZavWtaqHthMoyeMGjBU7NTAWilKhgvN2cL4Kpj9h
         dX2B9ZOX0CyyII+5UfMo2KAxrcQHYpX0MqmD3fCv1WqdlwzwhT1RdYLkPz5rBGSy+0
         SzvHZMftdS5X3NdOA55P8fMivyaM4BXfE5xG4HRiY/xVlfereRkHzFgGJNmXj8+8u/
         k7AphN4WSyxOgHuA6wsBDXjLXoc69r0wkL7j4MHd7F1w1MEZjy65D0zVfMogKQyJVR
         UZs+lh4GksfYponnFp3aYneTyQZh7v/8PhBslfVM+9Nt350rHq06rkTqM1lfpH8oNy
         Ef/EzyQoORgKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F38675C097E; Thu,  3 Nov 2022 19:23:36 -0700 (PDT)
Date:   Thu, 3 Nov 2022 19:23:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@meta.com,
        neeraju@codeaurora.org, ak@linux.intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, John Stultz <jstultz@google.com>
Subject: Re: [PATCH clocksource 2/2] clocksource: Exponential backoff for
 load-induced bogus watchdog reads
Message-ID: <20221104022336.GJ5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221102184001.GA1306489@paulmck-ThinkPad-P17-Gen-1>
 <20221102184009.1306751-2-paulmck@kernel.org>
 <1fdbdf78-cdca-975f-7f57-e391263d0aec@redhat.com>
 <20221103204910.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <61470eb8-fc3c-7f95-881e-03da1805b5ac@redhat.com>
 <20221104002616.GH5600@paulmck-ThinkPad-P17-Gen-1>
 <d6e2029d-8390-908b-577d-8724706ee652@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e2029d-8390-908b-577d-8724706ee652@redhat.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 09:01:45PM -0400, Waiman Long wrote:
> On 11/3/22 20:26, Paul E. McKenney wrote:
> > On Thu, Nov 03, 2022 at 08:20:27PM -0400, Waiman Long wrote:
> > > On 11/3/22 16:49, Paul E. McKenney wrote:
> > > > commit da44b8af99222ff8761a98ca8c00837a7d607d28
> > > > Author: Paul E. McKenney<paulmck@kernel.org>
> > > > Date:   Fri Oct 28 10:38:58 2022 -0700
> > > > 
> > > >       clocksource: Exponential backoff for load-induced bogus watchdog reads
> > > >       The clocksource watchdog will reject measurements that are excessively
> > > >       delayed, that is, by more than 1.5 seconds beyond the intended 0.5-second
> > > >       watchdog interval.  On an extremely busy system, this can result in a
> > > >       console message being printed every two seconds.  This is excessively
> > > >       noisy for a non-error condition.
> > > >       Therefore, apply exponential backoff to these messages.  This exponential
> > > >       backoff is capped at 1024 times the watchdog interval, which comes to
> > > >       not quite one message per ten minutes.
> > > >       Please note that the bogus watchdog reads that occur when the watchdog
> > > >       interval is less than 0.125 seconds are still printed unconditionally
> > > >       because these likely correspond to a serious error condition in the
> > > >       timer code or hardware.
> > > >       [ paulmck: Apply Feng Tang feedback. ]
> > > >       [ paulmck: Apply Waiman Long feedback. ]
> > > >       Reported-by: Waiman Long<longman@redhat.com>
> > > >       Reported-by: Feng Tang<feng.tang@intel.com>
> > > >       Signed-off-by: Paul E. McKenney<paulmck@kernel.org>
> > > >       Cc: John Stultz<jstultz@google.com>
> > > >       Cc: Thomas Gleixner<tglx@linutronix.de>
> > > >       Cc: Stephen Boyd<sboyd@kernel.org>
> > > >       Cc: Feng Tang<feng.tang@intel.com>
> > > >       Cc: Waiman Long<longman@redhat.com>
> > > > 
> > > > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> > > > index 1d42d4b173271..23b73f2293d6d 100644
> > > > --- a/include/linux/clocksource.h
> > > > +++ b/include/linux/clocksource.h
> > > > @@ -125,6 +125,9 @@ struct clocksource {
> > > >    	struct list_head	wd_list;
> > > >    	u64			cs_last;
> > > >    	u64			wd_last;
> > > > +	u64			wd_last_bogus;
> > > > +	int			wd_bogus_shift;
> > > > +	unsigned long		wd_bogus_count;
> > > >    #endif
> > > >    	struct module		*owner;
> > > >    };
> > > > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > > > index 3f5317faf891f..1eefb56505350 100644
> > > > --- a/kernel/time/clocksource.c
> > > > +++ b/kernel/time/clocksource.c
> > > > @@ -442,14 +442,33 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > >    		/* Check for bogus measurements. */
> > > >    		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> > > > -		if (wd_nsec < (wdi >> 2)) {
> > > > -			/* This usually indicates broken timer code or hardware. */
> > > > -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > > +		if (wd_nsec > (wdi << 2) || cs_nsec > (wdi << 2)) {
> > > > +			bool needwarn = false;
> > > > +			u64 wd_lb;
> > > > +
> > > > +			cs->wd_bogus_count++;
> > > > +			if (!cs->wd_bogus_shift) {
> > > > +				needwarn = true;
> > > > +			} else {
> > > > +				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
> > > > +				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> > > > +				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
> > > > +					needwarn = true;
> > > > +			}
> > > > +			if (needwarn) {
> > > > +				/* This can happen on busy systems, which can delay the watchdog. */
> > > > +				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count);
> > > Just one question, does "%lu additional" means the number of bogus count
> > > that doesn't meet the needwarn requirement and hence skipped. If so, I think
> > > you have to use "cs->wd_bogus_cnt - 1". Other than that, the change looks
> > > good to me.
> > It means the number since the last report, or, for the first report,
> > the number since boot.
> > 
> > Does that work for you?
> 
> OK, I think the word "additional" tricks me into thinking about extra bogus
> messages in additional to the current one. Using another word like "total"
> may be less confusing.

My concern with "total" is that people might think that the numbers
meant the total number of instances since boot.

So how about "(9 since last message)" or similar?

							Thanx, Paul
