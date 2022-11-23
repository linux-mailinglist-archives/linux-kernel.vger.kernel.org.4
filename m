Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70E9636C57
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbiKWVXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiKWVXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:23:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1E470A12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:23:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B57561F2B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 21:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2931C433C1;
        Wed, 23 Nov 2022 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669238628;
        bh=cATiR1QG6cTY/mqQnaWiwo/Sa8WflOSrl15CfQvSEVM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HqV2reqZWvvaU0usYoj+DiRq9qcSL8WIDjmq26rH/DjkS/afyL+WCs8tC/1vZriV8
         WOdmpnHsd2kgVsx2kY8D1JLZFxhBjpDkhKl0ZSEG6m5jN+cc7MnqC3PWWltkIW3x+q
         puOWOToSThuXbwgbH/aQ5yn1p5dqCXmIAcBeh1u4RG3MjYv6DwUoG79+zL2lum3lzN
         nyhxCWnC9CcEtPs3EylGoBMrXtxqclGBBFrksJYGcmnSgm+qJAjZUS+vWx6lj6Ochp
         Qq5xkFRMsy/A14sg1u5Izfg8BXHJT+2rmX+rnT6J570yeTrXfnwfRTCmf2kTjgb1hW
         IzjqLSBdhUtqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5184B5C1286; Wed, 23 Nov 2022 13:23:48 -0800 (PST)
Date:   Wed, 23 Nov 2022 13:23:48 -0800
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
Message-ID: <20221123212348.GI4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
 <20221114232827.835599-1-paulmck@kernel.org>
 <87mt8pkzw1.ffs@tglx>
 <20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3rMc2VbgVLHN9db@feng-clx>
 <20221121181449.GA3774542@paulmck-ThinkPad-P17-Gen-1>
 <Y3zxB6r1kin8pSH1@feng-clx>
 <20221122220712.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <Y32HFE+BaATh9+l/@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y32HFE+BaATh9+l/@feng-clx>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:36:04AM +0800, Feng Tang wrote:
> On Tue, Nov 22, 2022 at 02:07:12PM -0800, Paul E. McKenney wrote:
> [...] 
> > > > If PM_TIMER was involved, I would expect 'acpi_pm' instead of
> > > > refined-jiffies.  Or am I misinterpreting the output and/or code?
> > > 
> > > It's about timing. On a typical server platform, the clocksources
> > > init order could be:
> > >   refined-jiffies --> hpet --> tsc-early --> acpi_pm --> tsc 
> > > 
> > > >From your log, TSC('tsc-early') is disabled before 'acpi_pm' get
> > > initialized, so 'acpi_pm' timer (if exist) had no chance to watchdog
> > > the tsc.
> > > 
> > > > Either way, would it make sense to add CLOCK_SOURCE_MUST_VERIFY to
> > > > clocksource_hpet.flags?
> > > 
> > > Maybe try below patch, which will skip watchdog for 'tsc-early',
> > > while giving 'acpi_pm' timer a chance to watchdog 'tsc'.
> > > 
> > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > index cafacb2e58cc..9840f0131764 100644
> > > --- a/arch/x86/kernel/tsc.c
> > > +++ b/arch/x86/kernel/tsc.c
> > > @@ -1131,8 +1131,7 @@ static struct clocksource clocksource_tsc_early = {
> > >  	.uncertainty_margin	= 32 * NSEC_PER_MSEC,
> > >  	.read			= read_tsc,
> > >  	.mask			= CLOCKSOURCE_MASK(64),
> > > -	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
> > > -				  CLOCK_SOURCE_MUST_VERIFY,
> > > +	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
> > >  	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
> > >  	.enable			= tsc_cs_enable,
> > >  	.resume			= tsc_resume,
> > 
> > Your mainline patch b50db7095fe0 ("x86/tsc: Disable clocksource watchdog
> > for TSC on qualified platorms") mitigates the issue so we are good for
> > the immediate future, at least assuming reliable TSC.
> > 
> > But it also disables checking against HPET, hence my question about
> > marking clocksource_hpet.flags with CLOCK_SOURCE_MUST_VERIFY at boot time
> > on systems whose CPUs have constant_tsc, nonstop_tsc, and tsc_adjust.
> 
> IIUC, this will make TSC to watchdog HPET every 500 ms. We have got
> report that the 500ms watchdog timer had big impact on some parallel
> workload on big servers, that was another factor for us to seek
> stopping the timer.

Another approach would be to slow it down.  Given the tighter bounds
on skew, it could be done every (say) 10 seconds while allowing
2 milliseconds skew instead of the current 100 microseconds.

> Is this about the concern of possible TSC frequency calibration
> issue, as the 40 ms per second drift between HPET and TSC? With 
> b50db7095fe0 backported, we also have another patch to force TSC
> calibration for those platforms which get the TSC freq directly
> from CPUID or MSR and don't have such info in dmesg:
>  "tsc: Refined TSC clocksource calibration: 2693.509 MHz" 
> 
> https://lore.kernel.org/lkml/20220509144110.9242-1-feng.tang@intel.com/
> 
> We did met tsc calibration issue due to some firmware issue, and
> this can help to catch it. You can try it if you think it's relevant.

I am giving this a go, thank you!

						Thanx, Paul

> Thanks,
> Feng
> 
> > Would that make sense?
> > 
> > 							Thanx, Paul
> > 
> > > > I am sending the full console output off-list.  Hey, you asked for it!  ;-)
> > > 
> > > Thanks for sharing!
> > > 
> > > Thanks,
> > > Feng
> > > 
> > > > 
> > > > 							Thanx, Paul
