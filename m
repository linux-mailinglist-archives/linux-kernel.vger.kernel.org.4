Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB116654940
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiLVX2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiLVX2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:28:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156A61C126
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 15:28:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8520861D9F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 23:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB3AC433D2;
        Thu, 22 Dec 2022 23:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671751726;
        bh=n75CE56JG+8uNg3L6CecbO0S3UDi3slN/OLYYemTW0M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NgmwYDXsEdrhoqIY/+0PXoI9gulDLy9fI2WFvJHmWJtNNc24aKqbJKjTYkzeZjtED
         9Eerw28Avwchz1hhSph8zEwSj6Dt5TdnBA75/tZfJojegbb6tt7VbwxK4Ln4vAPih6
         6v2tliTaWM2fQbe4aAGed/Nt6RuWVk38M9P9ei+r6/syNL7liGxwLVOqC8KBmvTt+9
         Uol0UOSri4kOxdI1ZUK+VK7tsSeCGtQZdZp4BYl92VeWMWo2JXstsOQ4YisrGlMvUY
         cDkhuS7JSZQOTbjBpYu4qqIy5/ZyCP5YUzc0p091w3fRxktLk3Mme/8qq016BUn9wv
         YnGvgdX2cZ0fA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 774405C167A; Thu, 22 Dec 2022 15:28:46 -0800 (PST)
Date:   Thu, 22 Dec 2022 15:28:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <20221222232846.GA2171581@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y6Ja+kYQAi4pppV6@feng-clx>
 <8a9bed0d-c166-37e9-24c3-8cea7a336c76@redhat.com>
 <20221222004032.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com>
 <20221222055515.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6PyisHYYtde/6Xk@feng-clx>
 <20221222061429.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6P7JPHf9wDse0XK@feng-clx>
 <20221222182446.GQ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221222214219.GA1875767@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222214219.GA1875767@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 01:42:19PM -0800, Paul E. McKenney wrote:
> On Thu, Dec 22, 2022 at 10:24:46AM -0800, Paul E. McKenney wrote:
> > On Thu, Dec 22, 2022 at 02:37:24PM +0800, Feng Tang wrote:
> > > On Wed, Dec 21, 2022 at 10:14:29PM -0800, Paul E. McKenney wrote:
> > > > On Thu, Dec 22, 2022 at 02:00:42PM +0800, Feng Tang wrote:
> > > > > On Wed, Dec 21, 2022 at 09:55:15PM -0800, Paul E. McKenney wrote:
> > > > > > On Wed, Dec 21, 2022 at 10:39:53PM -0500, Waiman Long wrote:
> 
> [ . . . ]
> 
> > > > > > > As I currently understand, you are trying to use TSC as a watchdog to check
> > > > > > > against HPET and PMTMR. I do have 2 questions about this patch.
> > > > > > > 
> > > > > > > First of all, why you need to use both HPET and PMTMR? Can you just use one
> > > > > > > of those that are available. Secondly, is it possible to enable this
> > > > > > > time-skew diagnostic for a limit amount of time instead running
> > > > > > > indefinitely? The running of the clocksource watchdog itself will still
> > > > > > > consume a tiny amount of CPU cycles.
> > > > > > 
> > > > > > I could certainly do something so that only the first of HPET and PMTMR
> > > > > > is checked.  Could you give me a quick run-through of the advantages of
> > > > > > using only one?  I would need to explain that in the commit log.
> > > > > > 
> > > > > > Would it make sense to have a kernel boot variable giving the number of
> > > > > > minutes for which the watchdog was to run, with a default of zero
> > > > > > meaning "indefinitely"?
> > > > > 
> > > > > We've discussed about the "os noise", which customer may really care.
> > > > > IIUC, this patch intends to test if HPET/PMTIMER HW is broken, so how
> > > > > about making it run for a number of minutes the default behavior.   
> > > > 
> > > > It is also intended to determine if TSC is broken, with NTP drift rates
> > > > used to determine which timer is at fault.
> > > > 
> > > > OK, how about a Kconfig option for the number of minutes, set to whatever
> > > > you guys tell me?  (Three minutes?  Five minutes?  Something else?)
> > > > People wanting to run it continuously could then build their kernels
> > > > with that Kconfig option set to zero.
> > >  
> > > I don't have specific preference for 5 or 10 minutes, as long as it
> > > is a one time deal :) 
> > > 
> > > > > Also I've run the patch on a Alderlake system, with a fine acpi pm_timer
> > > > > and a fake broken pm_timer, and they both works without errors.
> > > > 
> > > > Thank you!  Did it correctly identify the fake broken pm_timer as being
> > > > broken?  If so, may I have your Tested-by?
> > > 
> > > On that Alderlake system, HPET will be disabled by kernel, and I
> > > manually increased the tsc frequency about 1/256 to make pm_timer
> > > look to have 1/256 deviation. And got dmesg like:
> > > 
> > > [    2.738554] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'acpi_pm' as unstable because the skew is too large:
> > > [    2.738558] clocksource:                       'tsc' wd_nsec: 275956624 wd_now: 13aab38d0d wd_last: 1382c1144d mask: ffffffffffffffff
> > > [    2.738564] clocksource:                       'acpi_pm' cs_nsec: 277034651 cs_now: 731575 cs_last: 63f3cb mask: ffffff
> > > [    2.738568] clocksource:                       'tsc' (not 'acpi_pm') is current clocksource.
> > > 
> > > The deviation is indeed about 1/256. And pm_timer won't be shown in /sys/:
> > > 
> > > /sys/devices/system/clocksource/clocksource0/available_clocksource:tsc 
> > > /sys/devices/system/clocksource/clocksource0/current_clocksource:tsc
> > > 
> > > So feel free to add:
> > > 
> > > 	Tested-by: Feng Tang <feng.tang@intel.com>
> > 
> > Thank you very much!  I will apply this on my next rebase.
> 
> But first, here is a prototype of the limited-time clocksource watchdog.

And here is the limited-watchdogging patch.

Thoughts?

						Thanx, Paul

------------------------------------------------------------------------

commit 375e65d3055f9b379e5fbd449e69752cb69b4e19
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Dec 22 15:20:37 2022 -0800

    clocksource: Limit the number of watchdogged clocksources
    
    When TSC is deemed trustworthy, the clocksource watchdog will verify
    other clocksources against it.  @@@ Why limit it?  Needed from Waiman.
    Maybe overhead and disturbance of additional checks? @@@
    
    Therefore, supply a new tsc_watchdogged kernel boot parameter that
    limits the number of clocksources that will be verified against TSC.
    This parameter defaults to INT_MAX.  A value of zero prevents any
    verification.
    
    Link: https://lore.kernel.org/all/a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com/
    Reported-by: Waiman Long <longman@redhat.com>
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

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68c597e5909a4..0e304e40c21fa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6345,6 +6345,12 @@
 			with CPUID.16h support and partial CPUID.15h support.
 			Format: <unsigned int>
 
+	tsc_watchdogged=  [X86]
+			Specify the limit on the number of clocksources
+			that will be verified against TSC in cases where
+			the TSC is deemed trustworthy.	Defaults to
+			INT_MAX.  Specify zero to avoid verification.
+
 	tsx=		[X86] Control Transactional Synchronization
 			Extensions (TSX) feature in Intel processors that
 			support TSX control.
diff --git a/arch/x86/include/asm/time.h b/arch/x86/include/asm/time.h
index a53961c64a567..0fa15c4819082 100644
--- a/arch/x86/include/asm/time.h
+++ b/arch/x86/include/asm/time.h
@@ -8,7 +8,7 @@
 extern void hpet_time_init(void);
 extern void time_init(void);
 extern bool pit_timer_init(void);
-extern bool tsc_clocksource_watchdog_disabled(void);
+extern void tsc_clocksource_watchdog_disabled(struct clocksource *csp);
 
 extern struct clock_event_device *global_clock_event;
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c8eb1ac5125ab..cf28b0abc06bd 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1091,8 +1091,7 @@ int __init hpet_enable(void)
 	if (!hpet_counting())
 		goto out_nohpet;
 
-	if (tsc_clocksource_watchdog_disabled())
-		clocksource_hpet.flags |= CLOCK_SOURCE_MUST_VERIFY;
+	tsc_clocksource_watchdog_disabled(&clocksource_hpet);
 	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 924e877b95f31..6a1def7c02a6e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -53,6 +53,9 @@ static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
 struct clocksource *art_related_clocksource;
 
+static int max_tsc_watchdogged = INT_MAX;
+static atomic_t cur_tsc_watchdogged;
+
 struct cyc2ns {
 	struct cyc2ns_data data[2];	/*  0 + 2*16 = 32 */
 	seqcount_latch_t   seq;		/* 32 + 4    = 36 */
@@ -308,6 +311,14 @@ static int __init tsc_setup(char *str)
 
 __setup("tsc=", tsc_setup);
 
+static int __init tsc_watchdogged_setup(char *str)
+{
+	max_tsc_watchdogged = simple_strtol(str, NULL, 0);
+	return 1;
+}
+
+__setup("tsc_watchdogged=", tsc_watchdogged_setup);
+
 #define MAX_RETRIES		5
 #define TSC_DEFAULT_THRESHOLD	0x20000
 
@@ -1186,9 +1197,18 @@ static void __init tsc_disable_clocksource_watchdog(void)
 	clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
 }
 
-bool tsc_clocksource_watchdog_disabled(void)
+/*
+ * If the TSC is judged trustworthy and the limit on the number of
+ * to-be-watchdogged clocksources has not been exceeded, place the specified
+ * clocksource into must-verify state.
+ */
+void tsc_clocksource_watchdog_disabled(struct clocksource *csp)
 {
-	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY);
+	if (clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY ||
+	    atomic_inc_return(&cur_tsc_watchdogged) > max_tsc_watchdogged)
+		return;
+	pr_info("clocksource: '%s' will be checked by clocksource watchdog.\n", csp->name);
+	csp->flags |= CLOCK_SOURCE_MUST_VERIFY;
 }
 
 static void __init check_system_tsc_reliable(void)
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 82338773602ca..8562f59ac27e9 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -211,8 +211,7 @@ static int __init init_acpi_pm_clocksource(void)
 		return -ENODEV;
 	}
 
-	if (tsc_clocksource_watchdog_disabled())
-		clocksource_acpi_pm.flags |= CLOCK_SOURCE_MUST_VERIFY;
+	tsc_clocksource_watchdog_disabled(&clocksource_acpi_pm);
 	return clocksource_register_hz(&clocksource_acpi_pm, PMTMR_TICKS_PER_SEC);
 }
 
