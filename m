Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07A68CBB6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBGBIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBGBIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:08:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071C93018F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:08:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0215B816A7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49116C433EF;
        Tue,  7 Feb 2023 01:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675732113;
        bh=mdglvBkLsD3vc6EjsUrILVSUGyGGqoNC/VQUk+FPkRM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZJqHdIteOhebj6oRNRQ10uK4b7H7mH5C/v8BloIgPK5iSGEWl1ASS2VzphItc/Sar
         xyVfKhIebneP/jbcyG0t3fnVfROzIUfbuTFytCDNB6haaO+UbWPQ1lpH57TKESktJU
         vPmjNek86r1OZkhG9nyyAQEonDMZmv0dvfgJ1UgjTKnldiOytFF2youtp1j2BuDams
         oOsEfGk2piEYcivpOxne1ACR8xC8JNYkRFf0wgwGPdvcftH1fAGwiePNz/iROruz7N
         pxwM3r7iArR6ywJDRyB+XPOSxfnoRMfvNzfQVOKSW6OlTYVhWjL2m5oqPld8odePeX
         8Jx3tqXZNJEqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9DDD05C0993; Mon,  6 Feb 2023 17:08:32 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:08:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@meta.com,
        neeraju@codeaurora.org, ak@linux.intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: PATCH v2 clocksource 8/7] clocksource: Enable TSC watchdog
 checking of HPET and PMTMR only when requested
Message-ID: <20230207010832.GU2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230203043658.GA1513624@paulmck-ThinkPad-P17-Gen-1>
 <82e4dae9-0aca-a06b-cb0d-5a189998cdc1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e4dae9-0aca-a06b-cb0d-5a189998cdc1@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 02:57:55PM -0500, Waiman Long wrote:
> On 2/2/23 23:36, Paul E. McKenney wrote:
> > Unconditionally enabling TSC watchdog checking of the HPET and PMTMR
> > clocksources can degrade latency and performance.  Therefore, provide
> > a new "watchdog" option to the tsc= boot parameter that opts into such
> > checking.  Note that tsc=watchdog is overridden by a tsc=nowatchdog
> > regardless of their relative positions in the list of boot parameters.
> > 
> > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > Reported-by: Waiman Long <longman@redhat.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 95f0d104c2322..7b4df6d89d3c3 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6373,6 +6373,12 @@
> >   			(HPET or PM timer) on systems whose TSC frequency was
> >   			obtained from HW or FW using either an MSR or CPUID(0x15).
> >   			Warn if the difference is more than 500 ppm.
> > +			[x86] watchdog: Use TSC as the watchdog clocksource with
> > +			which to check other HW timers (HPET or PM timer), but
> > +			only on systems where TSC has been deemed trustworthy.
> > +			This will be suppressed by an earlier tsc=nowatchdog and
> > +			can be overridden by a later tsc=nowatchdog.  A console
> > +			message will flag any such suppression or overriding.
> >   	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
> >   			value instead. Useful when the early TSC frequency discovery
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index a5371c6d4b64b..306c233c98d84 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -294,6 +294,7 @@ __setup("notsc", notsc_setup);
> >   static int no_sched_irq_time;
> >   static int no_tsc_watchdog;
> > +static int tsc_as_watchdog;
> >   static int __init tsc_setup(char *str)
> >   {
> > @@ -303,10 +304,22 @@ static int __init tsc_setup(char *str)
> >   		no_sched_irq_time = 1;
> >   	if (!strcmp(str, "unstable"))
> >   		mark_tsc_unstable("boot parameter");
> > -	if (!strcmp(str, "nowatchdog"))
> > +	if (!strcmp(str, "nowatchdog")) {
> >   		no_tsc_watchdog = 1;
> > +		if (tsc_as_watchdog)
> > +			pr_alert("%s: Overriding earlier tsc=watchdog with tsc=nowatchdog\n",
> > +				 __func__);
> > +		tsc_as_watchdog = 0;
> > +	}
> >   	if (!strcmp(str, "recalibrate"))
> >   		tsc_force_recalibrate = 1;
> > +	if (!strcmp(str, "watchdog")) {
> > +		if (no_tsc_watchdog)
> > +			pr_alert("%s: tsc=watchdog overridden by earlier tsc=nowatchdog\n",
> > +				 __func__);
> > +		else
> > +			tsc_as_watchdog = 1;
> > +	}
> >   	return 1;
> >   }
> > @@ -1192,7 +1205,8 @@ static void __init tsc_disable_clocksource_watchdog(void)
> >   bool tsc_clocksource_watchdog_disabled(void)
> >   {
> > -	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY);
> > +	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY) &&
> > +	       tsc_as_watchdog && !no_tsc_watchdog;
> >   }
> >   static void __init check_system_tsc_reliable(void)
> > 
> Acked-by: Waiman Long <longman@redhat.com>

Applied, thank you!

							Thanx, Paul
