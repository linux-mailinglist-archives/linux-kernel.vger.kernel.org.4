Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA9B63CEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiK3Fuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiK3Fu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:50:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D0159FEE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:50:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2115B81A31
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75056C433B5;
        Wed, 30 Nov 2022 05:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669787424;
        bh=mB2f49/57pI4KkyvYIzhm6qW9AM1dpfnpwL8vxECIZ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ckT3e9A4tGqG/uSE4R4x0FXmTXCyTrqmOrRbULLg6mB0m7tMkKzXmH4xd/zWr7uMO
         t/+B+orTwGvC5dyTbFm7mlB4TCE3/E2M90dVg+vWtl0vQQoFfwUavKPlU3GGzQSS7V
         C75xDIBK6sonNRPzW16zY84J6xJxR5NVum0HCkeiuOFlCAU6hNWmzreTIKdjBaFCvU
         3N7LaGrMowgTdDAEnAMkpXZpAPj17jPsZvU+smLTkmUW59xEyz95F2/5dfRVSde9oF
         TkfsYAREGocJt3Vc+R+Br2NDjpVmLYmSbkiAUyQorQfpH+8yuTmKbi2cLaRzXOP9En
         aaMGdsThVUFtQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1C1885C097E; Tue, 29 Nov 2022 21:50:24 -0800 (PST)
Date:   Tue, 29 Nov 2022 21:50:24 -0800
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
Message-ID: <20221130055024.GM4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221122220712.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <Y32HFE+BaATh9+l/@feng-clx>
 <20221123212348.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4QZzzk+FdGj4AXm@feng-clx>
 <20221129192915.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4az+FT5YjpAWjZc@feng-clx>
 <20221130041206.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bg1H/HLRLfucNO@feng-clx>
 <20221130051600.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4brjD/xUDlzJ4v7@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4brjD/xUDlzJ4v7@feng-clx>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:35:08PM +0800, Feng Tang wrote:
> On Tue, Nov 29, 2022 at 09:16:00PM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 30, 2022 at 12:49:24PM +0800, Feng Tang wrote:
> > > On Tue, Nov 29, 2022 at 08:12:06PM -0800, Paul E. McKenney wrote:
> > > > On Wed, Nov 30, 2022 at 09:38:00AM +0800, Feng Tang wrote:
> > > > > On Tue, Nov 29, 2022 at 11:29:15AM -0800, Paul E. McKenney wrote:
> > > > > [...]
> > > > > > > > > IIUC, this will make TSC to watchdog HPET every 500 ms. We have got
> > > > > > > > > report that the 500ms watchdog timer had big impact on some parallel
> > > > > > > > > workload on big servers, that was another factor for us to seek
> > > > > > > > > stopping the timer.
> > > > > > > > 
> > > > > > > > Another approach would be to slow it down.  Given the tighter bounds
> > > > > > > > on skew, it could be done every (say) 10 seconds while allowing
> > > > > > > > 2 milliseconds skew instead of the current 100 microseconds.
> > > > > > > 
> > > > > > > Yes, this can reduce the OS noise much. One problem is if we make it
> > > > > > > a general interface, there is some clocksource whose warp time is
> > > > > > > less than 10 seconds, like ACPI PM_TIMER (3-4 seconds), and I don't
> > > > > > > know if other ARCHs have similar cases.
> > > > > > 
> > > > > > Maybe a simpler approach is for systems with such high sensitivity to
> > > > > > OS noise to simply disable the clocksource watchdog.  ;-)
> > > > > 
> > > > > That's what the reported did, test with and without "tsc=reliable"
> > > > > parameter :)
> > > > > 
> > > > > And AFAIK, many customers with big server farms hate to add more
> > > > > cmdline parameters when we suggested so.
> > > > 
> > > > It can be surprisingly hard.  It is sometimes easier to patch the kernel
> > > > to change the default. 
> > > 
> > > Indeed, sometimes we were askd to provide patch than cmdline parameters :)
> > 
> > Do any of them like CONFIG_BOOT_CONFIG_EMBED?  ;-)
> > 
> > > > Part of the problem is getting the right set
> > > > of command-line parameters associated with the right versions of the
> > > > kernel in the not-uncommon case where different portions of the server
> > > > farm are running different versions of the kernel.
> > > > 
> > > > > > > > > Is this about the concern of possible TSC frequency calibration
> > > > > > > > > issue, as the 40 ms per second drift between HPET and TSC? With 
> > > > > > > > > b50db7095fe0 backported, we also have another patch to force TSC
> > > > > > > > > calibration for those platforms which get the TSC freq directly
> > > > > > > > > from CPUID or MSR and don't have such info in dmesg:
> > > > > > > > >  "tsc: Refined TSC clocksource calibration: 2693.509 MHz" 
> > > > > > > > > 
> > > > > > > > > https://lore.kernel.org/lkml/20220509144110.9242-1-feng.tang@intel.com/
> > > > > > > > > 
> > > > > > > > > We did met tsc calibration issue due to some firmware issue, and
> > > > > > > > > this can help to catch it. You can try it if you think it's relevant.
> > > > > > > > 
> > > > > > > > I am giving this a go, thank you!
> > > > > > > 
> > > > > > > Thanks for spending time testing it!
> > > > > > 
> > > > > > And here are the results from setting tsc_force_recalibrate to 1:
> > > > > > 
> > > > > > $ dmesg | grep -E 'calibrat|clocksource'
> > > > > > [    5.272939] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > > > > > [   16.830644] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76450417870 ns
> > > > > > [   17.938020] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > > > > [   24.548583] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> > > > > > [   49.762432] clocksource: Switched to clocksource tsc-early
> > > > > > [   50.076769] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> > > > > > [   55.615946] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > > > > [   55.640270] clocksource: Switched to clocksource tsc
> > > > > > [   56.694371] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> > > > > > [   56.724550] tsc: Previous calibrated TSC freq:        1896.000 MHz
> > > > > > [   56.737646] tsc: TSC freq recalibrated by [HPET]:     1975.000 MHz
> > > > > 
> > > > > Looks like there is really something wrong here. I assume the first
> > > > > number '1896 MHz' is got from CPUID(0x15)'s math calculation.
> > > > 
> > > > How about this from earlier in that same console?
> > > > 
> > > > [    0.000000] efi: EFI v2.80 by American Megatrends
> > > > [    0.000000] efi: ACPI=0x6f569000 ACPI 2.0=0x6f569014 TPMFinalLog=0x6f56b000 SMBIOS=0x753e1000 SMBIOS 3.0=0x753e0000 MEMATTR=0x62176018 ESRT=0x64bd1018 TPMEventLog=0x58737018
> > > > [    0.000000] [Firmware Bug]: TPM Final Events table missing or invalid
> > > > [    0.000000] SMBIOS 3.5.0 present.
> > > > [    0.000000] DMI: Quanta Grand Teton 1F0TUBZ0007/Grand Teton MB, BIOS F0T_1A15 08/25/2022
> > > > [    0.000000] tsc: Detected 1900.000 MHz processor
> > > > [    0.000000] tsc: Detected 1896.000 MHz TSC
> > > 
> > > I'm still not sure, but it's likely from CPUID(0x15). I met cases
> > > that even severs of same generations get their tsc frequence from
> > > different sources.
> > > 
> > > I locally have debug patch to check it:
> > > 
> > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > index cafacb2e58cc..82ddb4b0529a 100644
> > > --- a/arch/x86/kernel/tsc.c
> > > +++ b/arch/x86/kernel/tsc.c
> > > @@ -654,8 +654,11 @@ unsigned long native_calibrate_tsc(void)
> > >  	 * frequency and is the most accurate one so far we have. This
> > >  	 * is considered a known frequency.
> > >  	 */
> > > -	if (crystal_khz != 0)
> > > +	if (crystal_khz != 0) {
> > > +		printk("tsc: using CPUID[0x15] crystal_khz= %d kHz ebx=%d eax=%d\n",
> > > +		crystal_khz, ebx_numerator, eax_denominator);
> > >  		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > > +	}
> > >  
> > >  	/*
> > >  	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal
> > > @@ -668,6 +671,7 @@ unsigned long native_calibrate_tsc(void)
> > >  		cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
> > >  		crystal_khz = eax_base_mhz * 1000 *
> > >  			eax_denominator / ebx_numerator;
> > > +		printk("tsc: using CPUID[0x16] base_khz=%d kHz\n", crystal_khz);
> > >  	}
> > >  
> > >  	if (crystal_khz == 0)
> > 
> > I will give this one a go, thank you!
> > 
> > > This remind me that maybe we can add a line in dmesg telling people
> > > which exact soure that the TSC frequency comes from (CPUID, MSR or
> > > calibration from HW timers like HPET/PM_TIMER).
> > 
> > Thus far, it seems that this information could be useful.
> > 
> > > > > I thinks 2 more things could be try:
> > > > > 
> > > > > * add "nohpet" to the cmdline, so the tsc_force_recalibrate should use
> > > > >   ACPI PM_TIMER to do the calibration, say a third-party check.
> > > > 
> > > > OK, getting things teed up for TSC recalibration and nohpet.
> > > > 
> > > > > * If the system don't have auto-adjusted time setting like NTP, I
> > > > >   guess the system time will have obvious drift comparing to a normal
> > > > >   clock or a mobile phone time, as the deviation is about 4%, which
> > > > >   is 2.4 minutes per hour.
> > > > 
> > > > No ntpd, but there is a chronyd.
> > > > 
> > > > I will let you know what happens with HPET disabled and TSC recalibration
> > > > enabled.
> > 
> > And here you go:
> > 
> > [    0.000000] tsc: Detected 1900.000 MHz processor
> > [    0.000000] tsc: Detected 1896.000 MHz TSC
> > [    5.254788] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > [   25.669260] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > [   32.182958] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> > [   57.785756] clocksource: Switched to clocksource tsc-early
> > [   58.106661] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> > [   63.578433] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > [   63.602169] clocksource: Switched to clocksource tsc
> > [   64.636612] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> > [   64.664615] tsc: Previous calibrated TSC freq:        1896.000 MHz
> > [   64.677714] tsc: TSC freq recalibrated by [PM_TIMER]:         1975.000 MHz
>  
> Great! As both HPET and PM_TIMER get the same calibration 1975.000 MHz,
> and it matches the 40ms drift per second you mentioned earlier, this
> seems like the CPUID(0x15) gave the wrong frequence number.
> 
> Or unlikely, HPET and PM_TIMER are driven by the same circuit source,
> which has deviation.
> 
> Either way, I think the HW/FW could have some problem.

And this time with your printk()s:

[    0.000000] tsc: using CPUID[0x15] crystal_khz= 24000 kHz ebx=158 eax=2
[    0.000000] tsc: Detected 1900.000 MHz processor
[    0.000000] tsc: Detected 1896.000 MHz TSC
[    5.268858] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[   25.706231] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
[   32.223011] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[   57.823933] clocksource: Switched to clocksource tsc-early
[   58.144840] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[   63.613713] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
[   63.637323] clocksource: Switched to clocksource tsc
[   64.673579] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
[   64.703719] tsc: Previous calibrated TSC freq:        1896.000 MHz
[   64.716816] tsc: TSC freq recalibrated by [PM_TIMER]:         1974.999 MHz

What would be good next steps to check up on the hardware and firmware?

(My next step involves a pillow, but will follow up tomorrow morning
Pacific Time.)

							Thanx, Paul
