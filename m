Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D25E6151E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiKATGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKATG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CB81ADB3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 083D461709
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1F1C433D6;
        Tue,  1 Nov 2022 19:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667329587;
        bh=q+bX156BqITupEgbFgCmfNKvJ1osOnHzw4r27+WlIBQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=knRSJGPa/pIr6rJyJjDq0/EqKUGzrKrl1ZdhHWQSrSX3I/o3Pv8AHcQYUsdaKsTmX
         v5d9a4vLpRsHJS7EJaj87q/pkYiBjLUAxGnHEyngq5bGgI08x04oD6DSGmp1GgCzj0
         h5BXBYfmjMxX5BdWNxdaRcBIkV7VWBvD6n/C9TXquP3ReawzeDBh60BxlFksvVXkSk
         i3FkhW6csbaQ5rXDUXEpD7onAaGwo4RoySTacS/nY/MS6qWq7eMtPBvRPjjnnqxKXk
         k0ov6OhRBkx6CeaXSl+tUBayj4THMiKg0msZWWGEa9dr0gAmgOJhlvm3PjQp2axoyH
         DvGsJc30Yu/HA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 062FB5C05C0; Tue,  1 Nov 2022 12:06:27 -0700 (PDT)
Date:   Tue, 1 Nov 2022 12:06:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-kernel@vger.kernel.org, clm@meta.com, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, longman@redhat.com
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Message-ID: <20221101190627.GI5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
 <Y1ECHVUHilqgKD9o@feng-clx>
 <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1Hr6PNy9EJk245f@feng-clx>
 <20221028175245.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <Y19kStu4zBFyvKPK@feng-clx>
 <20221031174212.GB5600@paulmck-ThinkPad-P17-Gen-1>
 <Y2CyBGNM0rMI6nCG@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2CyBGNM0rMI6nCG@feng-clx>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 01:43:32PM +0800, Feng Tang wrote:
> On Mon, Oct 31, 2022 at 10:42:12AM -0700, Paul E. McKenney wrote:
> 
> [...]
> > > > @@ -448,8 +448,26 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > >  			continue;
> > > >  		}
> > > >  		if (wd_nsec > (wdi << 2)) {
> > > 
> > > Just recalled one thing, that it may be better to check 'cs_nsec' 
> > > instead of 'wd_nsec', as some watchdog may have small wrap-around
> > > value. IIRC, HPET's counter is 32 bits long and wraps at about
> > > 300 seconds, and PMTIMER's counter is 24 bits which wraps at about
> > > 3 ~ 4 seconds. So when a long stall of the watchdog timer happens,
> > > the watchdog's value could 'overflow' many times.
> > > 
> > > And usually the 'current' closcksource has longer wrap time than
> > > the watchdog.
> > 
> > Why not both?
> 
> You mean checking both clocksource and the watchdog? It's fine for
> me, though I still trust clocksource more.

OK, good, I will check both.  You never know what future hardware
might bring.

I also reversed the order of the checks, so that it now checks for heavy
load before too-short interval.  The purpose is to automatically avoid
being fooled by clock wrap.

> I checked some old emails and found some long stall logs for reference.
> 
> * one stall of 471 seconds
> 
>  [ 2410.694068] clocksource: timekeeping watchdog on CPU262: Marking clocksource 'tsc' as unstable because the skew is too large:
>  [ 2410.706920] clocksource:                       'hpet' wd_nsec: 0 wd_now: ffd70be2 wd_last: 40da633b mask: ffffffff
>  [ 2410.718583] clocksource:                       'tsc' cs_nsec: 471766594285 cs_now: 44f62c184e9 cs_last: 394a7a43771 mask: ffffffffffffffff
>  [ 2410.732568] clocksource:                       'tsc' is current clocksource.
>  [ 2410.740553] tsc: Marking TSC unstable due to clocksource watchdog
>  [ 2410.747611] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
>  [ 2410.757321] sched_clock: Marking unstable (2398804490960, 11943006672)<-(2419023952548, -8276474713)
>  [ 2410.767741] clocksource: Checking clocksource tsc synchronization from CPU 233 to CPUs 0,73,93-94,226,454,602,821.
>  [ 2410.784045] clocksource: Switched to clocksource hpet
> 
> 
> * another one of 5 seconds
> 
>  [ 3302.211708] clocksource: timekeeping watchdog on CPU9: Marking clocksource 'tsc' as unstable because the skew is too large:
>  [ 3302.211710] clocksource:                       'acpi_pm' wd_nsec: 312227950 wd_now: 92367f wd_last: 8128bd mask: ffffff
>  [ 3302.211712] clocksource:                       'tsc' cs_nsec: 4999196389 cs_now: 9e811223a9754 cs_last: 9e80e767df194 mask: ffffffffffffffff
>  [ 3302.211714] clocksource:                       'tsc' is current clocksource.
>  [ 3302.211716] tsc: Marking TSC unstable due to clocksource watchdog

Very good, thank you!  I believe that both of these would be handled
by the updated commit (see below for the update).

> >  		if (wd_nsec > (wdi << 2) || cs_nsec > (wdi << 2)) {
> > 
> > > > -			/* This can happen on busy systems, which can delay the watchdog. */
> > > > -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
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
> > > 
> > > I'm not sure if we need to check the last_bogus counter, or just
> > > the current interval 'cs_nsec' is what we care, and some code
> > > like this ?
> > 
> > I thought we wanted exponential backoff?  Do you really get that from
> > the changes below?
> 
> Aha, I misunderstood your words. I thought to only report one time for
> each 2, 4, 8, ... 256 seconds stall, and after that only report stall
> of 512+ seconds. So your approach looks good to me, as our intention is
> to avoid the flood of warning message.

Sounds good, thank you!

Please see below for a patch to be squashed into the original.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit eaee921daa7091f0eb731c9217ccc638ed5f8baf
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Nov 1 12:02:18 2022 -0700

    squash! clocksource: Exponential backoff for load-induced bogus watchdog reads
    
    [ paulmck: Apply Feng Tang feedback. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 6537ffa02e445..de8047b6720f5 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -442,12 +442,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		/* Check for bogus measurements. */
 		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
-		if (wd_nsec < (wdi >> 2)) {
-			/* This usually indicates broken timer code or hardware. */
-			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
-			continue;
-		}
-		if (wd_nsec > (wdi << 2)) {
+		if (wd_nsec > (wdi << 2) || cs_nsec > (wdi << 2)) {
 			bool needwarn = false;
 			u64 wd_lb;
 
@@ -470,6 +465,12 @@ static void clocksource_watchdog(struct timer_list *unused)
 			}
 			continue;
 		}
+		/* Check too-short measurements second to handle wrap. */
+		if (wd_nsec < (wdi >> 2) || cs_nsec < (wdi >> 2)) {
+			/* This usually indicates broken timer code or hardware. */
+			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
+			continue;
+		}
 
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
