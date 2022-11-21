Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FEB6327C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiKUPWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiKUPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:21:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D98817056
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B4E8612D2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C42C433D6;
        Mon, 21 Nov 2022 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669044068;
        bh=7atMFS0RY0Y/N7XUzTTJuXzocBWr2wWTxt267FH+3DI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HnB3Tf4Idvo2yTv2MbHMbHDj3aHypDeuBOuDJ5xK8bFFkyKxlP9tQCLOh/0yDG0hp
         8HSFNsAT/tRtAB9J8gevCqbjDtO8CgzIB8W6S9iESZExOSj7EnwdVUXdsk7sIAEB3N
         nE0EmiiChIlAbvnAOrTB6GeLgKqV/9ErWIiEzqtsB6I/E1g873vuxlr82JZqqctVpo
         l9MyhstIKDG33MroHwZ8iSAfeFz0ktRQS8PhTUHWUjAEInIPOG9wtFsohwIhYLHfEP
         ZBbNsdaRcb0zE7PcP1VQGyzrbKYunxKxWj+KWSjmu7h89CiFOCP1ZqKoXm3aZuBto7
         LFxAdEGrqAEIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 96D825C0292; Mon, 21 Nov 2022 07:21:07 -0800 (PST)
Date:   Mon, 21 Nov 2022 07:21:07 -0800
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
Message-ID: <20221121152107.GI4001@paulmck-ThinkPad-P17-Gen-1>
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

Thank you for looking into this!

Knucklehead here failed to save away the dmesg.  Let me see what
I can drum up.

> Also if your platform has acpi PM_TIMER, you may try "nohpet"
> to use PM_TIMER instead of HPET and check if there is also big
> drift between TSC and PM_TIMER.

Let me see about giving this a go, and again, thank you!

						Thanx, Paul
