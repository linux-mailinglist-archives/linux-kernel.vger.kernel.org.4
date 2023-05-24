Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B64B70F826
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjEXN7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjEXN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:59:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A9A9;
        Wed, 24 May 2023 06:59:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BDD9021D3D;
        Wed, 24 May 2023 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684936756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBvtScxG64js1V2WtJGSat2wyTIF8r92U3UegFL2rYQ=;
        b=RHX2g085w5u88X+4Z6mGRE58L0b4uuVjnoB5ile5yyEku/n0vK3Ga3gzxfL7+dqOWR8qzS
        Enh+hAYTwRSzigqBWe8ELlR+JBHmK0H4bMUVMJEQc98zMr5VIBl3JapUXhy5gy6G8xv9gW
        1Vyj+Mx19rJDf489l0WBgZnOiWR+PkQ=
Received: from suse.cz (dhcp129.suse.cz [10.100.51.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 944262C141;
        Wed, 24 May 2023 13:59:15 +0000 (UTC)
Date:   Wed, 24 May 2023 15:59:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 13/18] watchdog/hardlockup: Have the perf hardlockup
 use __weak functions more cleanly
Message-ID: <ZG4YMyifGLOBJxLo@alley>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.13.I847d9ec852449350997ba00401d2462a9cb4302b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519101840.v5.13.I847d9ec852449350997ba00401d2462a9cb4302b@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-19 10:18:37, Douglas Anderson wrote:
> The fact that there watchdog_hardlockup_enable(),
> watchdog_hardlockup_disable(), and watchdog_hardlockup_probe() are
> declared __weak means that the configured hardlockup detector can
> define non-weak versions of those functions if it needs to. Instead of
> doing this, the perf hardlockup detector hooked itself into the
> default __weak implementation, which was a bit awkward. Clean this up.
> 
> >From comments, it looks as if the original design was done because the
> __weak function were expected to implemented by the architecture and
> not by the configured hardlockup detector. This got awkward when we
> tried to add the buddy lockup detector which was not arch-specific but
> wanted to hook into those same functions.
> 
> This is not expected to have any functional impact.
>
> @@ -187,27 +187,33 @@ static inline void watchdog_hardlockup_kick(void) { }
>  #endif /* !CONFIG_HARDLOCKUP_DETECTOR_PERF */
>  
>  /*
> - * These functions can be overridden if an architecture implements its
> - * own hardlockup detector.
> + * These functions can be overridden based on the configured hardlockdup detector.
>   *
>   * watchdog_hardlockup_enable/disable can be implemented to start and stop when
> - * softlockup watchdog start and stop. The arch must select the
> + * softlockup watchdog start and stop. The detector must select the
>   * SOFTLOCKUP_DETECTOR Kconfig.
>   */
> -void __weak watchdog_hardlockup_enable(unsigned int cpu)
> -{
> -	hardlockup_detector_perf_enable();
> -}
> +void __weak watchdog_hardlockup_enable(unsigned int cpu) { }
>  
> -void __weak watchdog_hardlockup_disable(unsigned int cpu)
> -{
> -	hardlockup_detector_perf_disable();
> -}
> +void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
>  
>  /* Return 0, if a hardlockup watchdog is available. Error code otherwise */
>  int __weak __init watchdog_hardlockup_probe(void)
>  {
> -	return hardlockup_detector_perf_init();
> +	/*
> +	 * If CONFIG_HAVE_NMI_WATCHDOG is defined then an architecture
> +	 * is assumed to have the hard watchdog available and we return 0.
> +	 */
> +	if (IS_ENABLED(CONFIG_HAVE_NMI_WATCHDOG))
> +		return 0;
> +
> +	/*
> +	 * Hardlockup detectors other than those using CONFIG_HAVE_NMI_WATCHDOG
> +	 * are required to implement a non-weak version of this probe function
> +	 * to tell whether they are available. If they don't override then
> +	 * we'll return -ENODEV.
> +	 */
> +	return -ENODEV;
>  }

When thinking more about it. It is weird that we need to handle
CONFIG_HAVE_NMI_WATCHDOG in this default week function.

It should be handled in watchdog_hardlockup_probe() implemented
in kernel/watchdog_perf.c.

IMHO, the default __weak function could always return -ENODEV;

Would it make sense, please?

Best Regards,
Petr
