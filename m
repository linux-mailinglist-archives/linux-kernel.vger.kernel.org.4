Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B06B632BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKUSO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiKUSOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:14:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55023BA5B2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:14:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CA3BB8128D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EBEC433C1;
        Mon, 21 Nov 2022 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669054489;
        bh=pbvMh6fhNxJq4w4Vhc2CV7bxHLYmfOj3X0JP3ped+28=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kIlBxuJpw5bjDtxoN1rIlETTaQfcCj3VxPEToyCYQqSVIwoPEjyz43KDWSxsPHJWV
         hY8teRZaMleb49T/FBWAqNWJ+Ky2JtQDQdSINhKzj3TlHRzLhiYdf87DM3uPcWQ5dT
         NaakjbD9e8z9AFd4yGCwTcYEsSUmn7GsqtWSBi13wbFjHVXchY81iZNpNOSnmSUlHQ
         Zyly0qmx/sn7MoxSItVHtwDSUwYz7Hj/600s7xg54eJHRr/9W0z/vDdZ/7YQr6bdS6
         o/oo10EigeiYSv6Gqc0mdMqFqQr2+qxPdO0cqWb8WMWYOYIgcl+NlO4CfWCIz8nG6+
         enRC/wUJQpC8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 656485C09CB; Mon, 21 Nov 2022 10:14:49 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:14:49 -0800
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
Message-ID: <20221121181449.GA3774542@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
 <20221114232827.835599-1-paulmck@kernel.org>
 <87mt8pkzw1.ffs@tglx>
 <20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3rMc2VbgVLHN9db@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3rMc2VbgVLHN9db@feng-clx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 08:55:15AM +0800, Feng Tang wrote:
> On Thu, Nov 17, 2022 at 03:09:10PM -0800, Paul E. McKenney wrote:
> > On Thu, Nov 17, 2022 at 10:57:34PM +0100, Thomas Gleixner wrote:
> > > Paul!
> > > 
> > > On Mon, Nov 14 2022 at 15:28, Paul E. McKenney wrote:
> > > >  
> > > > +		/* Check for bogus measurements. */
> > > > +		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> > > > +		if (wd_nsec < (wdi >> 2)) {
> > > > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > > +			continue;
> > > > +		}
> > > > +		if (wd_nsec > (wdi << 2)) {
> > > > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > > +			continue;
> > > > +		}
> > > 
> > > This is really getting ridiculous.
> > 
> > I have absolutely no argument with this statement, and going back a
> > long time.  ;-)
> > 
> > But the set of systems that caused me to send this turned out to have
> > real divergence between HPET and TSC, and 40 milliseconds per second of
> > divergence at that.  So not only do you hate this series, but it is also
> > the case that this series doesn't help with the problem at hand.
> 
> The drift is about 4% which is quite big. It seems that this is
> either problem of HPET/TSC's hardware/firmware, or the problem of
> frequency calibration for HPET/TSC. TSC calibration is complex,
> as it could be done from different methods depending on hardware
> and firmware, could you share the kernel boot log related with
> tsc/hpet and clocksource? 
> 
> Also if your platform has acpi PM_TIMER, you may try "nohpet"
> to use PM_TIMER instead of HPET and check if there is also big
> drift between TSC and PM_TIMER.

The kernel is built with CONFIG_X86_PM_TIMER=y, so I was guessing
that there is an ACPI PM_TIMER.  Except that when I booted
without your "Disable clocksource watchdog for TSC on qualified
platforms" patch, I get the following:

[   44.303035] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'tsc-early' as unstable because the skew is too large:
[   44.347034] clocksource:                       'refined-jiffies' wd_nsec: 503923392 wd_now: fffb73f8 wd_last: fffb7200 mask: ffffffff
[   44.374034] clocksource:                       'tsc-early' cs_nsec: 588042081 cs_now: 66c486d157 cs_last: 6682125e5e mask: ffffffffffffffff
[   44.403034] clocksource:                       No current clocksource.
[   44.418034] tsc: Marking TSC unstable due to clocksource watchdog

If PM_TIMER was involved, I would expect 'acpi_pm' instead of
refined-jiffies.  Or am I misinterpreting the output and/or code?

Either way, would it make sense to add CLOCK_SOURCE_MUST_VERIFY to
clocksource_hpet.flags?

I am sending the full console output off-list.  Hey, you asked for it!  ;-)

							Thanx, Paul
