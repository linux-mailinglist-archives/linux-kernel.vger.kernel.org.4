Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD86B652657
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiLTSeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiLTSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:34:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D66CE5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:34:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE0C61552
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8E5C433D2;
        Tue, 20 Dec 2022 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671561240;
        bh=mA6CFHE0J7KQg+nJf7XbNZ+xnBEaxn3I/j9GWkA2Pwc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=haFix5zuJJiW/4mSb5TVj0hhZsHfit+Htslfqml64RsMEpCJLXjr3BFQIXHIV4K0S
         hjQ+rk1Aq7eUBDzwh6JQOFOWlBRGWQ9b82+C9nj54fnH48v+inQ/R+jgeYpPtpA3uf
         4UHw2GBW1rrUlQbzt2MX8jqV61Sp3nxVmwesw/Iv2dVjKiegc5SIVmY32/Qn4Ck7Gs
         psGtgwdN8LsFHMjMjG1QyV/JbdNr7z3PdptMBLBJNFrggOW+usF3NxvmDdEFVrlEF/
         Pzu3qa1PKFasCFZ0X42K7DhfWxJzZsFb1XkVtapVlLcDSTEozMugXEtxDwMF+FYr0F
         mmhNSWxbTpvuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6F7255C09C0; Tue, 20 Dec 2022 10:34:00 -0800 (PST)
Date:   Tue, 20 Dec 2022 10:34:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <20221220183400.GY4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221220082512.186283-1-feng.tang@intel.com>
 <6fb04ee9-ce77-4835-2ad1-b7f8419cfb77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fb04ee9-ce77-4835-2ad1-b7f8419cfb77@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 11:11:08AM -0500, Waiman Long wrote:
> On 12/20/22 03:25, Feng Tang wrote:
> > There were bug reported on 8 sockets x86 machines that TSC was wrongly
> > disabled when system is under heavy workload.
> > 
> >   [ 818.380354] clocksource: timekeeping watchdog on CPU336: hpet wd-wd read-back delay of 1203520ns
> >   [ 818.436160] clocksource: wd-tsc-wd read-back delay of 181880ns, clock-skew test skipped!
> >   [ 819.402962] clocksource: timekeeping watchdog on CPU338: hpet wd-wd read-back delay of 324000ns
> >   [ 819.448036] clocksource: wd-tsc-wd read-back delay of 337240ns, clock-skew test skipped!
> >   [ 819.880863] clocksource: timekeeping watchdog on CPU339: hpet read-back delay of 150280ns, attempt 3, marking unstable
> >   [ 819.936243] tsc: Marking TSC unstable due to clocksource watchdog
> >   [ 820.068173] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> >   [ 820.092382] sched_clock: Marking unstable (818769414384, 1195404998)
> >   [ 820.643627] clocksource: Checking clocksource tsc synchronization from CPU 267 to CPUs 0,4,25,70,126,430,557,564.
> >   [ 821.067990] clocksource: Switched to clocksource hpet
> > 
> > This can be reproduced when system is running memory intensive 'stream'
> > test, or some stress-ng subcases like 'ioport'.
> > 
> > The reason is when system is under heavy load, the read latency of
> > clocksource can be very high, it can be seen even with lightweight
> > TSC read, and is much worse on MMIO or IO port read based external
> > clocksource. Causing the watchdog check to be inaccurate.
> > 
> > As the clocksource watchdog is a lifetime check with frequency of
> > twice a second, there is no need to rush doing it when the system
> > is under heavy load and the clocksource read latency is very high,
> > suspend the watchdog timer for 5 minutes.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >   kernel/time/clocksource.c | 45 ++++++++++++++++++++++++++++-----------
> >   1 file changed, 32 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index 9cf32ccda715..8cd74b89d577 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -384,6 +384,15 @@ void clocksource_verify_percpu(struct clocksource *cs)
> >   }
> >   EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
> > +static inline void clocksource_reset_watchdog(void)
> > +{
> > +	struct clocksource *cs;
> > +
> > +	list_for_each_entry(cs, &watchdog_list, wd_list)
> > +		cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
> > +}
> > +
> > +
> >   static void clocksource_watchdog(struct timer_list *unused)
> >   {
> >   	u64 csnow, wdnow, cslast, wdlast, delta;
> > @@ -391,6 +400,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> >   	int64_t wd_nsec, cs_nsec;
> >   	struct clocksource *cs;
> >   	enum wd_read_status read_ret;
> > +	unsigned long extra_wait = 0;
> >   	u32 md;
> >   	spin_lock(&watchdog_lock);
> > @@ -410,13 +420,30 @@ static void clocksource_watchdog(struct timer_list *unused)
> >   		read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
> > -		if (read_ret != WD_READ_SUCCESS) {
> > -			if (read_ret == WD_READ_UNSTABLE)
> > -				/* Clock readout unreliable, so give it up. */
> > -				__clocksource_unstable(cs);
> > +		if (read_ret == WD_READ_UNSTABLE) {
> > +			/* Clock readout unreliable, so give it up. */
> > +			__clocksource_unstable(cs);
> >   			continue;
> >   		}
> > +		/*
> > +		 * When WD_READ_SKIP is returned, it means the system is likely
> > +		 * under very heavy load, where the latency of reading
> > +		 * watchdog/clocksource is very big, and affect the accuracy of
> > +		 * watchdog check. So give system some space and suspend the
> > +		 * watchdog check for 5 minutes.
> > +		 */
> > +		if (read_ret == WD_READ_SKIP) {
> > +			/*
> > +			 * As the watchdog timer will be suspended, and
> > +			 * cs->last could keep unchanged for 5 minutes, reset
> > +			 * the counters.
> > +			 */
> > +			clocksource_reset_watchdog();
> > +			extra_wait = HZ * 300;
> > +			break;
> > +		}
> > +
> >   		/* Clocksource initialized ? */
> >   		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
> >   		    atomic_read(&watchdog_reset_pending)) {
> > @@ -512,7 +539,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> >   	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
> >   	 */
> >   	if (!timer_pending(&watchdog_timer)) {
> > -		watchdog_timer.expires += WATCHDOG_INTERVAL;
> > +		watchdog_timer.expires += WATCHDOG_INTERVAL + extra_wait;
> >   		add_timer_on(&watchdog_timer, next_cpu);
> >   	}
> >   out:
> > @@ -537,14 +564,6 @@ static inline void clocksource_stop_watchdog(void)
> >   	watchdog_running = 0;
> >   }
> > -static inline void clocksource_reset_watchdog(void)
> > -{
> > -	struct clocksource *cs;
> > -
> > -	list_for_each_entry(cs, &watchdog_list, wd_list)
> > -		cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
> > -}
> > -
> >   static void clocksource_resume_watchdog(void)
> >   {
> >   	atomic_inc(&watchdog_reset_pending);
> 
> It looks reasonable to me. Thanks for the patch.
> 
> Acked-by: Waiman Long <longman@redhat.com>

Queued, thank you both!

If you would like this to go in some other way:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

And while I am remembering it...  Any objections to reversing the role of
TSC and the other timers on systems where TSC is believed to be accurate?
So that if there is clocksource skew, HPET is marked unstable rather than
TSC?  This would preserve the diagnostics without hammering performance
when skew is detected.  (Switching from TSC to HPET hammers performance
enough that our automation usually notices and reboots the system.)

							Thanx, Paul
