Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A963C86B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiK2Tan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbiK2TaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:30:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3B1265F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:29:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E2ABB818A9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D94C433D6;
        Tue, 29 Nov 2022 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669750156;
        bh=vkc4yEbAftggAN91Dd7uHHrIey2HTE32KaDPJhdcRtI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KOKYF3O0IpQCb5UffTgR23azuQPB51u56U2m+4fDsjdAcOVasYKLiJmTb+GvLTkzH
         QbgBdEf2t3QdMYL0xxeOBpb87O8uWO6aWiVWAmgwPR17tKxct8YDFXkLlVc2UIPuky
         vedaImCtz8dtJ8Ez+xPvdG2NlRx8leTNLa3GqdMH58hDNYTTK2OUawA2O7hCYWYxQr
         1x8v3URihHux1AXKakArztVxn7ZXGhzeAeAuVjSxJudYMWSOis0mvRspKhtuaDTcTk
         cRpF+RPP/TUUD9l7CHFWAMCpiAvsaXyyOhRXELvf+yBlcnJCducLSIkzXmxNLqIv/E
         2ryj32ckf/3MA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9988A5C0584; Tue, 29 Nov 2022 11:29:15 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:29:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@meta.com,
        neeraju@codeaurora.org, ak@linux.intel.com,
        zhengjun.xing@intel.com, Chris Mason <clm@meta.com>,
        John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <20221129192915.GD4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221114232827.835599-1-paulmck@kernel.org>
 <87mt8pkzw1.ffs@tglx>
 <20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3rMc2VbgVLHN9db@feng-clx>
 <20221121181449.GA3774542@paulmck-ThinkPad-P17-Gen-1>
 <Y3zxB6r1kin8pSH1@feng-clx>
 <20221122220712.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <Y32HFE+BaATh9+l/@feng-clx>
 <20221123212348.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4QZzzk+FdGj4AXm@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4QZzzk+FdGj4AXm@feng-clx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:15:43AM +0800, Feng Tang wrote:
> On Wed, Nov 23, 2022 at 01:23:48PM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 23, 2022 at 10:36:04AM +0800, Feng Tang wrote:
> > > On Tue, Nov 22, 2022 at 02:07:12PM -0800, Paul E. McKenney wrote:
> > > [...] 
> > > > > > If PM_TIMER was involved, I would expect 'acpi_pm' instead of
> > > > > > refined-jiffies.  Or am I misinterpreting the output and/or code?
> > > > > 
> > > > > It's about timing. On a typical server platform, the clocksources
> > > > > init order could be:
> > > > >   refined-jiffies --> hpet --> tsc-early --> acpi_pm --> tsc 
> > > > > 
> > > > > >From your log, TSC('tsc-early') is disabled before 'acpi_pm' get
> > > > > initialized, so 'acpi_pm' timer (if exist) had no chance to watchdog
> > > > > the tsc.
> > > > > 
> > > > > > Either way, would it make sense to add CLOCK_SOURCE_MUST_VERIFY to
> > > > > > clocksource_hpet.flags?
> > > > > 
> > > > > Maybe try below patch, which will skip watchdog for 'tsc-early',
> > > > > while giving 'acpi_pm' timer a chance to watchdog 'tsc'.
> > > > > 
> > > > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > > > index cafacb2e58cc..9840f0131764 100644
> > > > > --- a/arch/x86/kernel/tsc.c
> > > > > +++ b/arch/x86/kernel/tsc.c
> > > > > @@ -1131,8 +1131,7 @@ static struct clocksource clocksource_tsc_early = {
> > > > >  	.uncertainty_margin	= 32 * NSEC_PER_MSEC,
> > > > >  	.read			= read_tsc,
> > > > >  	.mask			= CLOCKSOURCE_MASK(64),
> > > > > -	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
> > > > > -				  CLOCK_SOURCE_MUST_VERIFY,
> > > > > +	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
> > > > >  	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
> > > > >  	.enable			= tsc_cs_enable,
> > > > >  	.resume			= tsc_resume,
> > > > 
> > > > Your mainline patch b50db7095fe0 ("x86/tsc: Disable clocksource watchdog
> > > > for TSC on qualified platorms") mitigates the issue so we are good for
> > > > the immediate future, at least assuming reliable TSC.
> > > > 
> > > > But it also disables checking against HPET, hence my question about
> > > > marking clocksource_hpet.flags with CLOCK_SOURCE_MUST_VERIFY at boot time
> > > > on systems whose CPUs have constant_tsc, nonstop_tsc, and tsc_adjust.
> > > 
> > > IIUC, this will make TSC to watchdog HPET every 500 ms. We have got
> > > report that the 500ms watchdog timer had big impact on some parallel
> > > workload on big servers, that was another factor for us to seek
> > > stopping the timer.
> > 
> > Another approach would be to slow it down.  Given the tighter bounds
> > on skew, it could be done every (say) 10 seconds while allowing
> > 2 milliseconds skew instead of the current 100 microseconds.
> 
> Yes, this can reduce the OS noise much. One problem is if we make it
> a general interface, there is some clocksource whose warp time is
> less than 10 seconds, like ACPI PM_TIMER (3-4 seconds), and I don't
> know if other ARCHs have similar cases.

Maybe a simpler approach is for systems with such high sensitivity to
OS noise to simply disable the clocksource watchdog.  ;-)

> > > Is this about the concern of possible TSC frequency calibration
> > > issue, as the 40 ms per second drift between HPET and TSC? With 
> > > b50db7095fe0 backported, we also have another patch to force TSC
> > > calibration for those platforms which get the TSC freq directly
> > > from CPUID or MSR and don't have such info in dmesg:
> > >  "tsc: Refined TSC clocksource calibration: 2693.509 MHz" 
> > > 
> > > https://lore.kernel.org/lkml/20220509144110.9242-1-feng.tang@intel.com/
> > > 
> > > We did met tsc calibration issue due to some firmware issue, and
> > > this can help to catch it. You can try it if you think it's relevant.
> > 
> > I am giving this a go, thank you!
> 
> Thanks for spending time testing it!

And here are the results from setting tsc_force_recalibrate to 1:

$ dmesg | grep -E 'calibrat|clocksource'
[    5.272939] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[   16.830644] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76450417870 ns
[   17.938020] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
[   24.548583] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[   49.762432] clocksource: Switched to clocksource tsc-early
[   50.076769] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[   55.615946] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
[   55.640270] clocksource: Switched to clocksource tsc
[   56.694371] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
[   56.724550] tsc: Previous calibrated TSC freq:        1896.000 MHz
[   56.737646] tsc: TSC freq recalibrated by [HPET]:     1975.000 MHz

Apologies for the delay, but reconfigurations put the system off the
net for some time.

							Thanx, Paul
