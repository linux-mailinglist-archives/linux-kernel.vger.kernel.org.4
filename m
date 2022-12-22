Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBE9653A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiLVAki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLVAkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:40:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820F71A07C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:40:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC6E161990
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B6AC433EF;
        Thu, 22 Dec 2022 00:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671669633;
        bh=I+kpxglA0suYMgiGkmENfSLGvSNnbp1bNtc6hrYCWPE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=asNdlQcWicHcE/cM1R3vMR05/YAfI77Cv18Jq7JrbGMeUfL/crRaPzIa4GKNsc9sK
         TwgO1sdu3t2Viywl+gDkOPBuh4TAK5aiNYh9YwqgD3ji/LIwh/5s811rIAGVT3fVic
         oi54pcuxkbp2beVdscAyG3OD336PrNZbumRElqJ1dyWGW1MDzE83NYX++0DrXnqi+H
         gwLiZBDQLE3WXaBRkovItIA9kXp/Gn45ivBE5H5FAFyxs9ZBEeBts9Q/4gjzwtHyRh
         41u/KTptSJKtWphb6EQeToefRuPbHWgVNNcA3p1TLAZHP0941kJFovyAW1HviVdJKQ
         3MbeR0bAkkUaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C85765C1409; Wed, 21 Dec 2022 16:40:32 -0800 (PST)
Date:   Wed, 21 Dec 2022 16:40:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Feng Tang <feng.tang@intel.com>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <20221222004032.GI4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221220082512.186283-1-feng.tang@intel.com>
 <6fb04ee9-ce77-4835-2ad1-b7f8419cfb77@redhat.com>
 <20221220183400.GY4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6Ja+kYQAi4pppV6@feng-clx>
 <8a9bed0d-c166-37e9-24c3-8cea7a336c76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a9bed0d-c166-37e9-24c3-8cea7a336c76@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:26:15PM -0500, Waiman Long wrote:
> 
> On 12/20/22 20:01, Feng Tang wrote:
> > Using correct email address of John Stultz.
> > 
> > On Tue, Dec 20, 2022 at 10:34:00AM -0800, Paul E. McKenney wrote:
> > > On Tue, Dec 20, 2022 at 11:11:08AM -0500, Waiman Long wrote:
> > > > On 12/20/22 03:25, Feng Tang wrote:
> > > > > There were bug reported on 8 sockets x86 machines that TSC was wrongly
> > > > > disabled when system is under heavy workload.
> > > > > 
> > > > >    [ 818.380354] clocksource: timekeeping watchdog on CPU336: hpet wd-wd read-back delay of 1203520ns
> > > > >    [ 818.436160] clocksource: wd-tsc-wd read-back delay of 181880ns, clock-skew test skipped!
> > > > >    [ 819.402962] clocksource: timekeeping watchdog on CPU338: hpet wd-wd read-back delay of 324000ns
> > > > >    [ 819.448036] clocksource: wd-tsc-wd read-back delay of 337240ns, clock-skew test skipped!
> > > > >    [ 819.880863] clocksource: timekeeping watchdog on CPU339: hpet read-back delay of 150280ns, attempt 3, marking unstable
> > > > >    [ 819.936243] tsc: Marking TSC unstable due to clocksource watchdog
> > > > >    [ 820.068173] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> > > > >    [ 820.092382] sched_clock: Marking unstable (818769414384, 1195404998)
> > > > >    [ 820.643627] clocksource: Checking clocksource tsc synchronization from CPU 267 to CPUs 0,4,25,70,126,430,557,564.
> > > > >    [ 821.067990] clocksource: Switched to clocksource hpet
> > > > > 
> > > > > This can be reproduced when system is running memory intensive 'stream'
> > > > > test, or some stress-ng subcases like 'ioport'.
> > > > > 
> > > > > The reason is when system is under heavy load, the read latency of
> > > > > clocksource can be very high, it can be seen even with lightweight
> > > > > TSC read, and is much worse on MMIO or IO port read based external
> > > > > clocksource. Causing the watchdog check to be inaccurate.
> > > > > 
> > > > > As the clocksource watchdog is a lifetime check with frequency of
> > > > > twice a second, there is no need to rush doing it when the system
> > > > > is under heavy load and the clocksource read latency is very high,
> > > > > suspend the watchdog timer for 5 minutes.
> > > > > 
> > > > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > > > > ---
> > > > >    kernel/time/clocksource.c | 45 ++++++++++++++++++++++++++++-----------
> > > > >    1 file changed, 32 insertions(+), 13 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > > > > index 9cf32ccda715..8cd74b89d577 100644
> > > > > --- a/kernel/time/clocksource.c
> > > > > +++ b/kernel/time/clocksource.c
> > > > > @@ -384,6 +384,15 @@ void clocksource_verify_percpu(struct clocksource *cs)
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
> > > > > +static inline void clocksource_reset_watchdog(void)
> > > > > +{
> > > > > +	struct clocksource *cs;
> > > > > +
> > > > > +	list_for_each_entry(cs, &watchdog_list, wd_list)
> > > > > +		cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
> > > > > +}
> > > > > +
> > > > > +
> > > > >    static void clocksource_watchdog(struct timer_list *unused)
> > > > >    {
> > > > >    	u64 csnow, wdnow, cslast, wdlast, delta;
> > > > > @@ -391,6 +400,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > > >    	int64_t wd_nsec, cs_nsec;
> > > > >    	struct clocksource *cs;
> > > > >    	enum wd_read_status read_ret;
> > > > > +	unsigned long extra_wait = 0;
> > > > >    	u32 md;
> > > > >    	spin_lock(&watchdog_lock);
> > > > > @@ -410,13 +420,30 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > > >    		read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
> > > > > -		if (read_ret != WD_READ_SUCCESS) {
> > > > > -			if (read_ret == WD_READ_UNSTABLE)
> > > > > -				/* Clock readout unreliable, so give it up. */
> > > > > -				__clocksource_unstable(cs);
> > > > > +		if (read_ret == WD_READ_UNSTABLE) {
> > > > > +			/* Clock readout unreliable, so give it up. */
> > > > > +			__clocksource_unstable(cs);
> > > > >    			continue;
> > > > >    		}
> > > > > +		/*
> > > > > +		 * When WD_READ_SKIP is returned, it means the system is likely
> > > > > +		 * under very heavy load, where the latency of reading
> > > > > +		 * watchdog/clocksource is very big, and affect the accuracy of
> > > > > +		 * watchdog check. So give system some space and suspend the
> > > > > +		 * watchdog check for 5 minutes.
> > > > > +		 */
> > > > > +		if (read_ret == WD_READ_SKIP) {
> > > > > +			/*
> > > > > +			 * As the watchdog timer will be suspended, and
> > > > > +			 * cs->last could keep unchanged for 5 minutes, reset
> > > > > +			 * the counters.
> > > > > +			 */
> > > > > +			clocksource_reset_watchdog();
> > > > > +			extra_wait = HZ * 300;
> > > > > +			break;
> > > > > +		}
> > > > > +
> > > > >    		/* Clocksource initialized ? */
> > > > >    		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
> > > > >    		    atomic_read(&watchdog_reset_pending)) {
> > > > > @@ -512,7 +539,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > > >    	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
> > > > >    	 */
> > > > >    	if (!timer_pending(&watchdog_timer)) {
> > > > > -		watchdog_timer.expires += WATCHDOG_INTERVAL;
> > > > > +		watchdog_timer.expires += WATCHDOG_INTERVAL + extra_wait;
> > > > >    		add_timer_on(&watchdog_timer, next_cpu);
> > > > >    	}
> > > > >    out:
> > > > > @@ -537,14 +564,6 @@ static inline void clocksource_stop_watchdog(void)
> > > > >    	watchdog_running = 0;
> > > > >    }
> > > > > -static inline void clocksource_reset_watchdog(void)
> > > > > -{
> > > > > -	struct clocksource *cs;
> > > > > -
> > > > > -	list_for_each_entry(cs, &watchdog_list, wd_list)
> > > > > -		cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
> > > > > -}
> > > > > -
> > > > >    static void clocksource_resume_watchdog(void)
> > > > >    {
> > > > >    	atomic_inc(&watchdog_reset_pending);
> > > > It looks reasonable to me. Thanks for the patch.
> > > > 
> > > > Acked-by: Waiman Long <longman@redhat.com>
> > > Queued, thank you both!
> > Thanks for reviewing and queueing!
> > 
> > > If you would like this to go in some other way:
> > > 
> > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > And while I am remembering it...  Any objections to reversing the role of
> > > TSC and the other timers on systems where TSC is believed to be accurate?
> > > So that if there is clocksource skew, HPET is marked unstable rather than
> > > TSC?
> > For the bug in commit log, I think it's the 8 sockets system with
> > hundreds of CPUs causing the big latency, while the HPET itself may
> > not be broken, and if we switched to ACPI PM_TIMER as watchdog, we
> > could see similar big latency.
> > 
> > I used to only see this issue with stress tool like stress-ng, but
> > seems with larger and larger system, even the momory intensive load
> > can easily trigger this.
> > 
> > > This would preserve the diagnostics without hammering performance
> > > when skew is detected.  (Switching from TSC to HPET hammers performance
> > > enough that our automation usually notices and reboots the system.)
> > Yes, switching to HPET is a disaster for performance, we've seen
> > from 30% to 90% drop in different benchmarks.
> 
> Switching to hpet is very bad for performance. That is the main reason why I
> posted clocksource patches in the past to avoid this as much as possible. I
> think your patch is also a good countermeasure to avoid this.

So for the smaller systems, how about something like the following?

The background is a number of two-socket systems showing TSC clock skew
despite having CONSTANT_TSC, NONSTOP_TSC, and TSC_ADJUST all set on
the boot CPU.  According to NTP, the skew was 40,000 parts per million.
HPET and ACPI PM timer were within a few parts per million, but are both
a no-go for the workloads in question, as you say.  NTP actually keeps
userspace aligned with atomic-clock time to within about ten parts per
million, but that kind of skew between Kernel Standard Time and Userspace
Standard Time cannot be a good thing.

Thoughts?

							Thanx, Paul

-------------------------------------------------------------------------

commit 199dfa2ba23dd0d650b1482a091e2e15457698b7
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Dec 21 16:20:25 2022 -0800

    clocksource: Verify HPET and PMTMR when TSC unverified
    
    On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
    NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
    TSC is disabled.  This works well much of the time, but there is the
    occasional system that meets all of these criteria, but which still
    has a TSC that skews significantly from atomic-clock time.  This is
    usually attributed to a firmware or hardware fault.  Yes, the various
    NTP daemons do express their opinions of userspace-to-atomic-clock time
    skew, but they put them in various places, depending on the daemon and
    distro in question.  It would therefore be good for the kernel to have
    some clue that there is a problem.
    
    The old behavior of marking the TSC unstable is a non-starter because a
    great many workloads simply cannot tolerate the overheads and latencies
    of the various non-TSC clocksources.  In addition, NTP-corrected systems
    often seem to be able to tolerate significant kernel-space time skew as
    long as the userspace time sources are within epsilon of atomic-clock
    time.
    
    Therefore, when watchdog verification of TSC is disabled, enable it for
    HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
    time-skew diagnostic without degrading the system's performance.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Dave Hansen <dave.hansen@linux.intel.com>
    Cc: "H. Peter Anvin" <hpa@zytor.com>
    Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
    Cc: Feng Tang <feng.tang@intel.com>
    Cc: Waiman Long <longman@redhat.com
    Cc: <x86@kernel.org>

diff --git a/arch/x86/include/asm/time.h b/arch/x86/include/asm/time.h
index 8ac563abb567b..a53961c64a567 100644
--- a/arch/x86/include/asm/time.h
+++ b/arch/x86/include/asm/time.h
@@ -8,6 +8,7 @@
 extern void hpet_time_init(void);
 extern void time_init(void);
 extern bool pit_timer_init(void);
+extern bool tsc_clocksource_watchdog_disabled(void);
 
 extern struct clock_event_device *global_clock_event;
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 71f336425e58a..c8eb1ac5125ab 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1091,6 +1091,8 @@ int __init hpet_enable(void)
 	if (!hpet_counting())
 		goto out_nohpet;
 
+	if (tsc_clocksource_watchdog_disabled())
+		clocksource_hpet.flags |= CLOCK_SOURCE_MUST_VERIFY;
 	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cce..924e877b95f31 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1186,6 +1186,11 @@ static void __init tsc_disable_clocksource_watchdog(void)
 	clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
 }
 
+bool tsc_clocksource_watchdog_disabled(void)
+{
+	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY);
+}
+
 static void __init check_system_tsc_reliable(void)
 {
 #if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 279ddff81ab49..180003132bc1a 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -23,6 +23,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <asm/io.h>
+#include <asm/time.h>
 
 /*
  * The I/O port the PMTMR resides at.
@@ -210,6 +211,8 @@ static int __init init_acpi_pm_clocksource(void)
 		return -ENODEV;
 	}
 
+	if (tsc_clocksource_watchdog_disabled())
+		clocksource_acpi_pm.flags |= CLOCK_SOURCE_MUST_VERIFY;
 	return clocksource_register_hz(&clocksource_acpi_pm,
 						PMTMR_TICKS_PER_SEC);
 }
