Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2865D5BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbjADOdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbjADOch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:32:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF67837531
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:32:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C8076175F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB13FC433F1;
        Wed,  4 Jan 2023 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672842747;
        bh=LnUfuWjYjSCYv3VFT/Go2AEABRbAqzG6/TB50W6Hsuc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bdp+E5QjkA9Eo8XFJNAEArK60xe2FYT6pn/Taq5z70Pia/D1arANv+AF+E1hVQ/yU
         bmw39vJUZv0fLsVrXpGl6J8ieP+YWA4Jcy/1RlrhLprfqwSDahT2u7ZWWoT3U2hGzj
         buDcLkV4qU1x8VO5K5656deweaYraJMb16SsJen6jCqDlQTIU3zOOF8XkBPwLRUkWm
         AiqyYBfrqTnevXYD2iQuB+vJKCj8ZI9b15tFc3vFb9d/Nt2t7KYuGEOHhOLmv7ybEs
         7Y357FbR4qUg6MRyrk7S9Lk+fbzlkeuljoUs4PaMp5E1hMM1lFJKY9LbMhQLUvn42i
         O3bU2jwViaX6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 590465C0558; Wed,  4 Jan 2023 06:32:27 -0800 (PST)
Date:   Wed, 4 Jan 2023 06:32:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH v5] x86/tsc: Add option to force frequency recalibration
 with HW timer
Message-ID: <20230104143227.GC4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230104081938.1014511-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104081938.1014511-1-feng.tang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 04:19:38PM +0800, Feng Tang wrote:
> The kernel assumes that the TSC frequency which is provided by the
> hardware / firmware via MSRs or CPUID(0x15) is correct after applying
> a few basic consistency checks. This disables the TSC recalibration
> against HPET or PM timer.
> 
> As a result there is no mechanism to validate that frequency in cases
> where a firmware or hardware defect is suspected. And there was case
> that some user used atomic clock to measure the TSC frequency and
> reported an inaccuracy issue, which was later fixed in firmware.
> 
> Add an option 'recalibrate' for 'tsc' kernel parameter to force the
> tsc freq recalibration with HPET or PM timer, and warn if the
> deviation from previous value is more than about 500 PPM, which
> provides a way to verify the data from hardware / firmware.
> 
> There is no functional change to existing work flow.
> 
> Recently there was a real-world case: "The 40ms/s divergence between
> TSC and HPET was observed on hardware that is quite recent" [1], on
> that platform the TSC frequence 1896 MHz was got from CPUID(0x15),
> and the force-reclibration with HPET/PMTIMER both calibrated out
> value of 1975 MHz, which also matched with check from software
> 'chronyd', indicating it's a problem of BIOS or firmware.
> 
> [Thanks tglx for helping improving the commit log]
> 
> [1]. https://lore.kernel.org/lkml/20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1/
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Nice!!!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> Changelog:
> 
>   since v4:
>     * add the real world case, where the patch helped to root
>       caused a BIOS/FW problem of inaccurate CPUID-0x15 info
>     * rebase against v6.2-rc1
> 
>   since v3:
>     * add some real world case into commit log
>     * rebase against v6.0-rc1
> 
>   since v2:
>     * revise the option description in kernel-parameters.txt
>     * rebase against v5.19-rc2
> 
>   since v1:
>     * refine commit log to state clearly the problem and intention
>       of the patch by copying Thomas' words.
> 
> .../admin-guide/kernel-parameters.txt         |  4 +++
>  arch/x86/kernel/tsc.c                         | 34 ++++++++++++++++---
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..d9eb98e748d5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6369,6 +6369,10 @@
>  			in situations with strict latency requirements (where
>  			interruptions from clocksource watchdog are not
>  			acceptable).
> +			[x86] recalibrate: force to do frequency recalibration
> +			with a HW timer (HPET or PM timer) for systems whose
> +			TSC frequency comes from HW or FW through MSR or CPUID(0x15),
> +			and warn if the difference is more than 500 ppm.
>  
>  	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
>  			value instead. Useful when the early TSC frequency discovery
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index a78e73da4a74..92bbc4a6b3fc 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -48,6 +48,8 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);
>  
>  int tsc_clocksource_reliable;
>  
> +static int __read_mostly tsc_force_recalibrate;
> +
>  static u32 art_to_tsc_numerator;
>  static u32 art_to_tsc_denominator;
>  static u64 art_to_tsc_offset;
> @@ -303,6 +305,8 @@ static int __init tsc_setup(char *str)
>  		mark_tsc_unstable("boot parameter");
>  	if (!strcmp(str, "nowatchdog"))
>  		no_tsc_watchdog = 1;
> +	if (!strcmp(str, "recalibrate"))
> +		tsc_force_recalibrate = 1;
>  	return 1;
>  }
>  
> @@ -1374,6 +1378,25 @@ static void tsc_refine_calibration_work(struct work_struct *work)
>  	else
>  		freq = calc_pmtimer_ref(delta, ref_start, ref_stop);
>  
> +	/* Will hit this only if tsc_force_recalibrate has been set */
> +	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> +
> +		/* Warn if the deviation exceeds 500 ppm */
> +		if (abs(tsc_khz - freq) > (tsc_khz >> 11)) {
> +			pr_warn("Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!\n");
> +			pr_info("Previous calibrated TSC freq:\t %lu.%03lu MHz\n",
> +				(unsigned long)tsc_khz / 1000,
> +				(unsigned long)tsc_khz % 1000);
> +		}
> +
> +		pr_info("TSC freq recalibrated by [%s]:\t %lu.%03lu MHz\n",
> +			hpet ? "HPET" : "PM_TIMER",
> +			(unsigned long)freq / 1000,
> +			(unsigned long)freq % 1000);
> +
> +		return;
> +	}
> +
>  	/* Make sure we're within 1% */
>  	if (abs(tsc_khz - freq) > tsc_khz/100)
>  		goto out;
> @@ -1407,8 +1430,10 @@ static int __init init_tsc_clocksource(void)
>  	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
>  		return 0;
>  
> -	if (tsc_unstable)
> -		goto unreg;
> +	if (tsc_unstable) {
> +		clocksource_unregister(&clocksource_tsc_early);
> +		return 0;
> +	}
>  
>  	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
>  		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
> @@ -1421,9 +1446,10 @@ static int __init init_tsc_clocksource(void)
>  		if (boot_cpu_has(X86_FEATURE_ART))
>  			art_related_clocksource = &clocksource_tsc;
>  		clocksource_register_khz(&clocksource_tsc, tsc_khz);
> -unreg:
>  		clocksource_unregister(&clocksource_tsc_early);
> -		return 0;
> +
> +		if (!tsc_force_recalibrate)
> +			return 0;
>  	}
>  
>  	schedule_delayed_work(&tsc_irqwork, 0);
> -- 
> 2.34.1
> 
