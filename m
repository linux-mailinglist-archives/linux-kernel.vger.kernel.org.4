Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264EB618E3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKDCZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKDCZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:25:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8DE62EA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:25:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB073B82B61
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E57EC433D7;
        Fri,  4 Nov 2022 02:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667528738;
        bh=D60uW/YA9vzrtA6YLe6Kcqm1hMPe3FtDEjljB3J+iKw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NkF6AT0by1tXAO7oay1y/w2sVyNr7qjK/r1TwK85VUQsR5jDSaQzUqNLkVofi/wet
         eW3fohHi9oil7ObARg1Q2oPrntmmeDTMAVkw2G3rz9nmuh/7u1+LuY7Wu1P/IvrTVo
         X/CjJ8GQaAh3Xo3LTh8uuEtMa02h+tFF11PoHRY0vbotzGWyfK1Kt+i6QFjiYxLNzX
         aVCSIu15ajI20hpH+VXFvVd91kkIAoPlitl9X1qC/4ziojOh6KXwtK/FZO4ukuWtti
         J7kh2n5pEJzu6wwugZWAVAhKa9rfT+UrfW9zaVYHKLXq2pCtjFZpSd4759DmclHFlH
         RWkUQUpz2Dmxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1147B5C097E; Thu,  3 Nov 2022 19:25:38 -0700 (PDT)
Date:   Thu, 3 Nov 2022 19:25:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@meta.com,
        neeraju@codeaurora.org, ak@linux.intel.com,
        zhengjun.xing@intel.com, Waiman Long <longman@redhat.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH clocksource 2/2] clocksource: Exponential backoff for
 load-induced bogus watchdog reads
Message-ID: <20221104022538.GK5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221102184001.GA1306489@paulmck-ThinkPad-P17-Gen-1>
 <20221102184009.1306751-2-paulmck@kernel.org>
 <Y2R2Fbuef2APXhU3@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2R2Fbuef2APXhU3@feng-clx>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:16:53AM +0800, Feng Tang wrote:
> On Wed, Nov 02, 2022 at 11:40:09AM -0700, Paul E. McKenney wrote:
> > The clocksource watchdog will reject measurements that are excessively
> > delayed, that is, by more than 1.5 seconds beyond the intended 0.5-second
> > watchdog interval.  On an extremely busy system, this can result in a
> > console message being printed every two seconds.  This is excessively
> > noisy for a non-error condition.
> > 
> > Therefore, apply exponential backoff to these messages.  This exponential
> > backoff is capped at 1024 times the watchdog interval, which comes to
> > not quite one message per ten minutes.
> > 
> > Please note that the bogus watchdog reads that occur when the watchdog
> > interval is less than 0.125 seconds are still printed unconditionally
> > because these likely correspond to a serious error condition in the
> > timer code or hardware.
> 
> I saw there is ongoing discussion about some wording, overall it
> looks good to me, thanks!
> 
> Reviewed-by: Feng Tang <feng.tang@intel.com>

Thank you!  I will apply both of your Reviewed-by tags on the next rebase,
by which time hopefully Waiman and I come to agreement on wording.  ;-)

						Thanx, Paul

> > [ paulmck: Apply Feng Tang feedback. ]
> > 
> > Reported-by: Waiman Long <longman@redhat.com>
> > Reported-by: Feng Tang <feng.tang@intel.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Feng Tang <feng.tang@intel.com>
> > Cc: Waiman Long <longman@redhat.com>
> > ---
> >  include/linux/clocksource.h |  4 ++++
> >  kernel/time/clocksource.c   | 31 +++++++++++++++++++++++++------
> >  2 files changed, 29 insertions(+), 6 deletions(-)
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
> > index 3f5317faf891f..de8047b6720f5 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -442,14 +442,33 @@ static void clocksource_watchdog(struct timer_list *unused)
> >  
> >  		/* Check for bogus measurements. */
> >  		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> > -		if (wd_nsec < (wdi >> 2)) {
> > -			/* This usually indicates broken timer code or hardware. */
> > -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > +		if (wd_nsec > (wdi << 2) || cs_nsec > (wdi << 2)) {
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
> > -		if (wd_nsec > (wdi << 2)) {
> > -			/* This can happen on busy systems, which can delay the watchdog. */
> > -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > +		/* Check too-short measurements second to handle wrap. */
> > +		if (wd_nsec < (wdi >> 2) || cs_nsec < (wdi >> 2)) {
> > +			/* This usually indicates broken timer code or hardware. */
> > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> >  			continue;
> >  		}
> >  
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
