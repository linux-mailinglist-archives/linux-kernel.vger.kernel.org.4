Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DE26119A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJ1Rwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJ1Rwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:52:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5522211CB64
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A4A2B8274E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 17:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED35C433C1;
        Fri, 28 Oct 2022 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666979565;
        bh=bRP4b0nrKel2fYZGsiPz1CK/O6L1+rG7uPO+C+LE/uk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XvDGDGvU3BbybAyTX3bxHLaptvgsDZm/VVy54V3jr9qhoqxgZ7dUcwP/hBD2BdTL0
         drfhZXqacrOk5sAYPg4bJoZu0KgpNawTxGigcsJzwAjJxWD7hT2ZzLGGl7gPuCyuMw
         KGR/bV0hRFf36y2RiQaKawK9tvqIE8irqRVIhS3iRUc1LFhDeCJH/4dBdWcmoFORxP
         xe0WiFRL1n48s/DhubJbXwxvj3rhvZOIuIKy+XLPp+bbiMmzhEGKhPEz0lL6RyRFoM
         xL0171Gr2j2cT01O9hoUoK2E8Sen03WvNJqYbbOBPjNBmwFtTucINJufRQSQdTHGTt
         OBWjEbMIA2aZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 523785C0692; Fri, 28 Oct 2022 10:52:45 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:52:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-kernel@vger.kernel.org, clm@meta.com, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, longman@redhat.com
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Message-ID: <20221028175245.GN5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
 <Y1ECHVUHilqgKD9o@feng-clx>
 <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1Hr6PNy9EJk245f@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Hr6PNy9EJk245f@feng-clx>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 08:46:32AM +0800, Feng Tang wrote:
> On Thu, Oct 20, 2022 at 07:09:44AM -0700, Paul E. McKenney wrote:
> [...]
> > > >  static void clocksource_watchdog(struct timer_list *unused)
> > > >  {
> > > > -	u64 csnow, wdnow, cslast, wdlast, delta;
> > > > +	u64 csnow, wdnow, cslast, wdlast, delta, wdi;
> > > >  	int next_cpu, reset_pending;
> > > >  	int64_t wd_nsec, cs_nsec;
> > > >  	struct clocksource *cs;
> > > > @@ -440,6 +440,17 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > >  		if (atomic_read(&watchdog_reset_pending))
> > > >  			continue;
> > > >  
> > > > +		/* Check for bogus measurements. */
> > > > +		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> > > > +		if (wd_nsec < (wdi >> 2)) {
> > > > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > > +			continue;
> > > > +		}
> > > 
> > > If this happens (500ms timer happens only after less than 125ms),
> > > there is some severe problem with timer/interrupt system. 
> > 
> > Should I add ", suspect timer/interrupt bug" just after "jiffy time
> > interval"?  Or would a comment before that pr_warn() work better for you?
> 
> Both are fine for me.
> 
> > > > +		if (wd_nsec > (wdi << 2)) {
> > > > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > > +			continue;
> > > > +		}
> > > 
> > > I agree with Waiman that some rate limiting may be needed. As there
> > > were reports of hundreds of seconds of delay, 2 seconds delay could
> > > easily happen if a system is too busy or misbehave to trigger this
> > > problem.
> > 
> > Good points, thank you both!
> > 
> > Left to myself, I would use a capped power-of-two backoff that was reset
> > any time that the interval was within bounds.  Maybe a cap of 10 minutes?
> 
> Yep, that's more informative. Thanks!

And here is the resulting patch.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit adc0512cf34fe7f0d73966d59644b826ee526742
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Oct 28 10:38:58 2022 -0700

    clocksource: Exponential backoff for load-induced bogus watchdog reads
    
    The clocksource watchdog will reject measurements that are excessively
    delayed, that is, by more than 1.5 seconds beyond the intended 0.5-second
    watchdog interval.  On an extremely busy system, this can result in a
    console message being printed every two seconds.  This is excessively
    noisy for a non-error condition.
    
    Therefore, apply exponential backoff to these messages.  This exponential
    backoff is capped at 1024 times the watchdog interval, which comes to
    not quite one message per ten minutes.
    
    Please note that the bogus watchdog reads that occur when the watchdog
    interval is less than 0.125 seconds are still printed unconditionally
    because these likely correspond to a serious error condition in the
    timer code or hardware.
    
    Reported-by: Waiman Long <longman@redhat.com>
    Reported-by: Feng Tang <feng.tang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: John Stultz <jstultz@google.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Stephen Boyd <sboyd@kernel.org>
    Cc: Feng Tang <feng.tang@intel.com>
    Cc: Waiman Long <longman@redhat.com>

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b173271..daac05aedf56a 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -125,6 +125,10 @@ struct clocksource {
 	struct list_head	wd_list;
 	u64			cs_last;
 	u64			wd_last;
+	u64			wd_last_bogus;
+	int			wd_bogus_shift;
+	unsigned long		wd_bogus_count;
+	unsigned long		wd_bogus_count_last;
 #endif
 	struct module		*owner;
 };
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3f5317faf891f..6537ffa02e445 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -448,8 +448,26 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 		if (wd_nsec > (wdi << 2)) {
-			/* This can happen on busy systems, which can delay the watchdog. */
-			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
+			bool needwarn = false;
+			u64 wd_lb;
+
+			cs->wd_bogus_count++;
+			if (!cs->wd_bogus_shift) {
+				needwarn = true;
+			} else {
+				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
+				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
+				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
+					needwarn = true;
+			}
+			if (needwarn) {
+				/* This can happen on busy systems, which can delay the watchdog. */
+				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count - cs->wd_bogus_count_last);
+				cs->wd_last_bogus = wdnow;
+				if (cs->wd_bogus_shift < 10)
+					cs->wd_bogus_shift++;
+				cs->wd_bogus_count_last = cs->wd_bogus_count;
+			}
 			continue;
 		}
 
