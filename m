Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0A26349CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiKVWHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiKVWHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:07:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA00C75A1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ECD0B81DBB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07A5C433D6;
        Tue, 22 Nov 2022 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669154832;
        bh=wglrgcNPHEyuDONMYL5SuSeMcamVk5FJnvzdWaABDkc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HUp1uKwZNH+PnlSe3IjBlKzbQ2Ku/RSYGu/2BfWUhKQ6X/OYFzbJgB/iJKqU3qYLc
         qbyx0mAvIWYupoOW7L5vAa0W113Mp+292kDkD4ZF+dDyLNME9rL/CRIx7zw7YkLpb3
         gxpS7Ai/V5la5EmDW2intdC8i6KeJTGlVXYbD3MqXA90ck8bDfjWgfzyPuwz8QAhxd
         5RED3B/wlUzWk5+Eac5zWNQkyVAeoWvUws3Ik4HPlWSeUT8ZPANwxcY25x9tAx25+v
         mpDrry9WKD5bsCJIKdPI5V9lund9MqgFF7gzOoMJzF2W/GEXB2/vBoBNxnqkoaRVD3
         TaxJUmPxECLSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 720A75C0B52; Tue, 22 Nov 2022 14:07:12 -0800 (PST)
Date:   Tue, 22 Nov 2022 14:07:12 -0800
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
Message-ID: <20221122220712.GP4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
 <20221114232827.835599-1-paulmck@kernel.org>
 <87mt8pkzw1.ffs@tglx>
 <20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3rMc2VbgVLHN9db@feng-clx>
 <20221121181449.GA3774542@paulmck-ThinkPad-P17-Gen-1>
 <Y3zxB6r1kin8pSH1@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3zxB6r1kin8pSH1@feng-clx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:55:51PM +0800, Feng Tang wrote:
> On Mon, Nov 21, 2022 at 10:14:49AM -0800, Paul E. McKenney wrote:
> > > > I have absolutely no argument with this statement, and going back a
> > > > long time.  ;-)
> > > > 
> > > > But the set of systems that caused me to send this turned out to have
> > > > real divergence between HPET and TSC, and 40 milliseconds per second of
> > > > divergence at that.  So not only do you hate this series, but it is also
> > > > the case that this series doesn't help with the problem at hand.
> > > 
> > > The drift is about 4% which is quite big. It seems that this is
> > > either problem of HPET/TSC's hardware/firmware, or the problem of
> > > frequency calibration for HPET/TSC. TSC calibration is complex,
> > > as it could be done from different methods depending on hardware
> > > and firmware, could you share the kernel boot log related with
> > > tsc/hpet and clocksource? 
> > > 
> > > Also if your platform has acpi PM_TIMER, you may try "nohpet"
> > > to use PM_TIMER instead of HPET and check if there is also big
> > > drift between TSC and PM_TIMER.
> > 
> > The kernel is built with CONFIG_X86_PM_TIMER=y, so I was guessing
> > that there is an ACPI PM_TIMER.  Except that when I booted
> > without your "Disable clocksource watchdog for TSC on qualified
> > platforms" patch, I get the following:
> > 
> > [   44.303035] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'tsc-early' as unstable because the skew is too large:
> > [   44.347034] clocksource:                       'refined-jiffies' wd_nsec: 503923392 wd_now: fffb73f8 wd_last: fffb7200 mask: ffffffff
> > [   44.374034] clocksource:                       'tsc-early' cs_nsec: 588042081 cs_now: 66c486d157 cs_last: 6682125e5e mask: ffffffffffffffff
> > [   44.403034] clocksource:                       No current clocksource.
> > [   44.418034] tsc: Marking TSC unstable due to clocksource watchdog
>  
> Aha, we've met similar error (TSC being judged 'unstable' by
> 'refined-jiffies') before, and our root cause is discussed in [1].
> In our case, we had early serial console enabled, which made it
> easier to be reproduced.
> 
> That was a trigger for us to proposed severl solutions before Thomas
> suggested to disable tsc watchdog for all qualified platforms.
> 
> [1]. https://lore.kernel.org/lkml/20201126012421.GA92582@shbuild999.sh.intel.com/

Thank you for the analysis!

> > If PM_TIMER was involved, I would expect 'acpi_pm' instead of
> > refined-jiffies.  Or am I misinterpreting the output and/or code?
> 
> It's about timing. On a typical server platform, the clocksources
> init order could be:
>   refined-jiffies --> hpet --> tsc-early --> acpi_pm --> tsc 
> 
> >From your log, TSC('tsc-early') is disabled before 'acpi_pm' get
> initialized, so 'acpi_pm' timer (if exist) had no chance to watchdog
> the tsc.
> 
> > Either way, would it make sense to add CLOCK_SOURCE_MUST_VERIFY to
> > clocksource_hpet.flags?
> 
> Maybe try below patch, which will skip watchdog for 'tsc-early',
> while giving 'acpi_pm' timer a chance to watchdog 'tsc'.
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index cafacb2e58cc..9840f0131764 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1131,8 +1131,7 @@ static struct clocksource clocksource_tsc_early = {
>  	.uncertainty_margin	= 32 * NSEC_PER_MSEC,
>  	.read			= read_tsc,
>  	.mask			= CLOCKSOURCE_MASK(64),
> -	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
> -				  CLOCK_SOURCE_MUST_VERIFY,
> +	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
>  	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
>  	.enable			= tsc_cs_enable,
>  	.resume			= tsc_resume,

Your mainline patch b50db7095fe0 ("x86/tsc: Disable clocksource watchdog
for TSC on qualified platorms") mitigates the issue so we are good for
the immediate future, at least assuming reliable TSC.

But it also disables checking against HPET, hence my question about
marking clocksource_hpet.flags with CLOCK_SOURCE_MUST_VERIFY at boot time
on systems whose CPUs have constant_tsc, nonstop_tsc, and tsc_adjust.

Would that make sense?

							Thanx, Paul

> > I am sending the full console output off-list.  Hey, you asked for it!  ;-)
> 
> Thanks for sharing!
> 
> Thanks,
> Feng
> 
> > 
> > 							Thanx, Paul
