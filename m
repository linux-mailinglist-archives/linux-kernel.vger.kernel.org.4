Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408746547FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLVVmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiLVVmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:42:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F827171
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:42:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6DFE61DA7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 21:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262F1C433EF;
        Thu, 22 Dec 2022 21:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671745340;
        bh=ZnBkphOfEGkpkdjMV9vL6SzQU7mgk1p2rIyeS6c6D80=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aQyUlWXXAFerqFTQT+jILpnV9rrgb0vk/xo+KNx2w1Xx4QS0ypRRPvjdhgNgGF+B+
         H89tT+41wpHOcO2IJA69S371UBf9Iupi3cVW94Li0R8gDzZrTp+TZqlDaIcdWub2SW
         5voMZi6NIvGgC6cUnwmPdl8D3NlkAWuWnAGdgGw+MDfUwCYUCrSPWnHuQv1bV7UEdo
         4PBlcH5Q1xs7igddjfs66FdOMx72wGg2xJ7lBLn0n5faDS65hAfqoWEQ0I4d4wHu16
         PgMKNNz12etIx9jGH7ru3c3MHcyf30QwcX4w+nQ8VaRcsG6+gI2LhIVIJV0POBTnPZ
         BX/QLiy9tAEtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BF45E5C167A; Thu, 22 Dec 2022 13:42:19 -0800 (PST)
Date:   Thu, 22 Dec 2022 13:42:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <20221222214219.GA1875767@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221220183400.GY4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6Ja+kYQAi4pppV6@feng-clx>
 <8a9bed0d-c166-37e9-24c3-8cea7a336c76@redhat.com>
 <20221222004032.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com>
 <20221222055515.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6PyisHYYtde/6Xk@feng-clx>
 <20221222061429.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6P7JPHf9wDse0XK@feng-clx>
 <20221222182446.GQ4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222182446.GQ4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 10:24:46AM -0800, Paul E. McKenney wrote:
> On Thu, Dec 22, 2022 at 02:37:24PM +0800, Feng Tang wrote:
> > On Wed, Dec 21, 2022 at 10:14:29PM -0800, Paul E. McKenney wrote:
> > > On Thu, Dec 22, 2022 at 02:00:42PM +0800, Feng Tang wrote:
> > > > On Wed, Dec 21, 2022 at 09:55:15PM -0800, Paul E. McKenney wrote:
> > > > > On Wed, Dec 21, 2022 at 10:39:53PM -0500, Waiman Long wrote:

[ . . . ]

> > > > > > As I currently understand, you are trying to use TSC as a watchdog to check
> > > > > > against HPET and PMTMR. I do have 2 questions about this patch.
> > > > > > 
> > > > > > First of all, why you need to use both HPET and PMTMR? Can you just use one
> > > > > > of those that are available. Secondly, is it possible to enable this
> > > > > > time-skew diagnostic for a limit amount of time instead running
> > > > > > indefinitely? The running of the clocksource watchdog itself will still
> > > > > > consume a tiny amount of CPU cycles.
> > > > > 
> > > > > I could certainly do something so that only the first of HPET and PMTMR
> > > > > is checked.  Could you give me a quick run-through of the advantages of
> > > > > using only one?  I would need to explain that in the commit log.
> > > > > 
> > > > > Would it make sense to have a kernel boot variable giving the number of
> > > > > minutes for which the watchdog was to run, with a default of zero
> > > > > meaning "indefinitely"?
> > > > 
> > > > We've discussed about the "os noise", which customer may really care.
> > > > IIUC, this patch intends to test if HPET/PMTIMER HW is broken, so how
> > > > about making it run for a number of minutes the default behavior.   
> > > 
> > > It is also intended to determine if TSC is broken, with NTP drift rates
> > > used to determine which timer is at fault.
> > > 
> > > OK, how about a Kconfig option for the number of minutes, set to whatever
> > > you guys tell me?  (Three minutes?  Five minutes?  Something else?)
> > > People wanting to run it continuously could then build their kernels
> > > with that Kconfig option set to zero.
> >  
> > I don't have specific preference for 5 or 10 minutes, as long as it
> > is a one time deal :) 
> > 
> > > > Also I've run the patch on a Alderlake system, with a fine acpi pm_timer
> > > > and a fake broken pm_timer, and they both works without errors.
> > > 
> > > Thank you!  Did it correctly identify the fake broken pm_timer as being
> > > broken?  If so, may I have your Tested-by?
> > 
> > On that Alderlake system, HPET will be disabled by kernel, and I
> > manually increased the tsc frequency about 1/256 to make pm_timer
> > look to have 1/256 deviation. And got dmesg like:
> > 
> > [    2.738554] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'acpi_pm' as unstable because the skew is too large:
> > [    2.738558] clocksource:                       'tsc' wd_nsec: 275956624 wd_now: 13aab38d0d wd_last: 1382c1144d mask: ffffffffffffffff
> > [    2.738564] clocksource:                       'acpi_pm' cs_nsec: 277034651 cs_now: 731575 cs_last: 63f3cb mask: ffffff
> > [    2.738568] clocksource:                       'tsc' (not 'acpi_pm') is current clocksource.
> > 
> > The deviation is indeed about 1/256. And pm_timer won't be shown in /sys/:
> > 
> > /sys/devices/system/clocksource/clocksource0/available_clocksource:tsc 
> > /sys/devices/system/clocksource/clocksource0/current_clocksource:tsc
> > 
> > So feel free to add:
> > 
> > 	Tested-by: Feng Tang <feng.tang@intel.com>
> 
> Thank you very much!  I will apply this on my next rebase.

But first, here is a prototype of the limited-time clocksource watchdog.
Thoughts?

						Thanx, Paul

------------------------------------------------------------------------

commit dfbf67806c4c7f2bdd79cdefe86a2bea6e7afcab
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Dec 22 13:21:47 2022 -0800

    clocksource: Permit limited-duration clocksource watchdogging
    
    Some systems want regular clocksource checking, but their workloads
    cannot tolerate the overhead of full-time clocksource checking.
    Therefore, add a CLOCKSOURCE_WATCHDOG_DURATION Kconfig option and a
    clocksource.watchdog_duration kernel-boot parameter that limits the
    clocksource watchdog to the specified number of minutes past boot.
    Values of zero disable checking, and a value of -1 restores the
    traditional behavior of always checking.
    
    This does change behavior compared to older kernels, but recent kernels
    disable the clocksource watchdog completely in the common case where the
    TSC is judged to be trustworthy.  This change in behavior is therefore
    not a real issue.
    
    Link: https://lore.kernel.org/all/a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com/
    Reported-by: Waiman Long <longman@redhat.com>
    Reported-by: Feng Tang <feng.tang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index bae8f11070bef..2676e011673d5 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -209,5 +209,17 @@ config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 	  per million.	If the clocksource is good enough for NTP,
 	  it is good enough for the clocksource watchdog!
 
+config CLOCKSOURCE_WATCHDOG_DURATION
+	int "Default time to run clocksource watchdog (in minutes)"
+	depends on CLOCKSOURCE_WATCHDOG
+	range -1 1440
+	default 10
+	help
+	  Specify the default number of minutes that the clocksource
+	  watchdog should run after being started.  Specify -1 to run
+	  indefinitely or zero to not run at all.  This value may be
+	  overridden using the clocksource.watchdog_duration kernel
+	  boot parameter.
+
 endmenu
 endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b153fce8c0e4b..c920c6c22e0fb 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -213,6 +213,9 @@ module_param(max_cswd_read_retries, ulong, 0644);
 EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
+static int watchdog_duration = CONFIG_CLOCKSOURCE_WATCHDOG_DURATION;
+module_param(watchdog_duration, int, 0444);
+static unsigned long watchdog_end_jiffies;
 
 enum wd_read_status {
 	WD_READ_SUCCESS,
@@ -549,7 +552,9 @@ static void clocksource_watchdog(struct timer_list *unused)
 	 * Arm timer if not already pending: could race with concurrent
 	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
 	 */
-	if (!timer_pending(&watchdog_timer)) {
+	if (!timer_pending(&watchdog_timer) &&
+	    (watchdog_duration < 0 ||
+	     (watchdog_duration >= 0 && time_before(jiffies, watchdog_end_jiffies)))) {
 		watchdog_timer.expires += WATCHDOG_INTERVAL + extra_wait;
 		add_timer_on(&watchdog_timer, next_cpu);
 	}
@@ -559,8 +564,10 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 static inline void clocksource_start_watchdog(void)
 {
-	if (watchdog_running || !watchdog || list_empty(&watchdog_list))
+	if (watchdog_running || !watchdog || list_empty(&watchdog_list) || !watchdog_duration)
 		return;
+	if (watchdog_duration > 0)
+		watchdog_end_jiffies = jiffies + watchdog_duration * 60 * HZ;
 	timer_setup(&watchdog_timer, clocksource_watchdog, 0);
 	watchdog_timer.expires = jiffies + WATCHDOG_INTERVAL;
 	add_timer_on(&watchdog_timer, cpumask_first(cpu_online_mask));
