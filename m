Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB3686F46
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjBATvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBATvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:51:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD100273A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:51:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD85461913
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D135C433EF;
        Wed,  1 Feb 2023 19:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675281078;
        bh=yiHfvhT6ZcBvqKpoeXaUCaKBibrKOqdXjfhaXZsSRhM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uAYSHhK9HD/ioE7EB4Dhazwh2en9EYFN1KAxlFtcGD02vx4wQvpvDnoyXSJ31Mtmk
         eYtm1MdA2T4ZtElQi/6idB6xqINFHZ286XPXrxk45WFSD9WJ+4DY6dDXDPi+1JhrCg
         hPhvwA4e49iU94R5CjZsbN6fIIJjPC+kDv5STNfpr8zrs7oDbwPt1R0lXMwSARYmvM
         0nz4KfWRw91Y+lqad7KbQx5Xe9P69sKlC7HxgWkFZaAP78q/WXTyc1xNz9fX5sJknl
         etntJIvgfxjloBKe3WEbKFDLImL/iPg8Cv5Yu8kIzTwLJRdu3AVCuk5qw1r549dE80
         D/zm2GRI/f5ew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B737A5C06D0; Wed,  1 Feb 2023 11:51:17 -0800 (PST)
Date:   Wed, 1 Feb 2023 11:51:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org
Subject: Re: [PATCH v2 clocksource 6/7] clocksource: Verify HPET and PMTMR
 when TSC unverified
Message-ID: <20230201195117.GL2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230125002730.1471349-6-paulmck@kernel.org>
 <87wn51znsh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn51znsh.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:24:14AM +0100, Thomas Gleixner wrote:
> Paul!
> 
> On Tue, Jan 24 2023 at 16:27, Paul E. McKenney wrote:
> > On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
> > NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
> > TSC is disabled.  This works well much of the time, but there is the
> > occasional production-level system that meets all of these criteria, but
> > which still has a TSC that skews significantly from atomic-clock time.
> > This is usually attributed to a firmware or hardware fault.  Yes, the
> > various NTP daemons do express their opinions of userspace-to-atomic-clock
> > time skew, but they put them in various places, depending on the daemon
> > and distro in question.  It would therefore be good for the kernel to
> > have some clue that there is a problem.
> >
> > The old behavior of marking the TSC unstable is a non-starter because a
> > great many workloads simply cannot tolerate the overheads and latencies
> > of the various non-TSC clocksources.  In addition, NTP-corrected systems
> > sometimes can tolerate significant kernel-space time skew as long as
> > the userspace time sources are within epsilon of atomic-clock time.
> >
> > Therefore, when watchdog verification of TSC is disabled, enable it for
> > HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
> > time-skew diagnostic without degrading the system's performance.
> 
> I'm more than unhappy about this. We finally have a point where the TSC
> watchdog overhead can go away without adding TSC=reliable to the kernel
> commandline.
> 
> Now you add an unconditionally enforce the watchdog again in a way which
> even cannot be disabled on the kernel command line.
> 
> Patently bad idea, no cookies for you!

What can I say?  40,000 parts per million TSC clock skew did raise some
eyebrows, and therefore the complete suppressing of that diagnostic
completely was not at all a welcome development.

So how about the (untested) patch below, either on top of the existing
series or folded into e57818b20b0b ("clocksource: Verify HPET and PMTMR
when TSC unverified")?

The idea is to provide TSC checking of HPET and PMTMR only when the
TSC is deemed reliable and the new tsc=watchdog kernel boot parameter
is provided.  If both tsc=watchdog and tsc=nowatchdog are provided,
tsc=watchdog wins and a console message is emitted (no splat).

To restate, with this patch, unless the sysadmin asks for it, there will
be no clocksource watchdog unless there also would have been one without
this patch.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 115829d71d0ca..d681f9252aaa7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6382,6 +6382,12 @@
 			(HPET or PM timer) on systems whose TSC frequency was
 			obtained from HW or FW using either an MSR or CPUID(0x15).
 			Warn if the difference is more than 500 ppm.
+			[x86] watchdog: Use TSC as the watchdog clocksource with
+			which to check other HW timers (HPET or PM timer), but
+			only on systems where TSC has been deemed trustworthy.
+			This will be suppressed by an earlier tsc=nowatchdog and
+			can be overridden by a later tsc=nowatchdog.  A console
+			message will flag any such suppression or overriding.
 
 	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
 			value instead. Useful when the early TSC frequency discovery
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a5371c6d4b64b..306c233c98d84 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -294,6 +294,7 @@ __setup("notsc", notsc_setup);
 
 static int no_sched_irq_time;
 static int no_tsc_watchdog;
+static int tsc_as_watchdog;
 
 static int __init tsc_setup(char *str)
 {
@@ -303,10 +304,22 @@ static int __init tsc_setup(char *str)
 		no_sched_irq_time = 1;
 	if (!strcmp(str, "unstable"))
 		mark_tsc_unstable("boot parameter");
-	if (!strcmp(str, "nowatchdog"))
+	if (!strcmp(str, "nowatchdog")) {
 		no_tsc_watchdog = 1;
+		if (tsc_as_watchdog)
+			pr_alert("%s: Overriding earlier tsc=watchdog with tsc=nowatchdog\n",
+				 __func__);
+		tsc_as_watchdog = 0;
+	}
 	if (!strcmp(str, "recalibrate"))
 		tsc_force_recalibrate = 1;
+	if (!strcmp(str, "watchdog")) {
+		if (no_tsc_watchdog)
+			pr_alert("%s: tsc=watchdog overridden by earlier tsc=nowatchdog\n",
+				 __func__);
+		else
+			tsc_as_watchdog = 1;
+	}
 	return 1;
 }
 
@@ -1192,7 +1205,8 @@ static void __init tsc_disable_clocksource_watchdog(void)
 
 bool tsc_clocksource_watchdog_disabled(void)
 {
-	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY);
+	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY) &&
+	       tsc_as_watchdog && !no_tsc_watchdog;
 }
 
 static void __init check_system_tsc_reliable(void)
