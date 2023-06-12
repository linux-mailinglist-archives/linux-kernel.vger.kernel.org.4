Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03972C01F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjFLKuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFLKt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:49:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1134A7DBD;
        Mon, 12 Jun 2023 03:34:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C32F2F4;
        Mon, 12 Jun 2023 03:34:37 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.27.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BAC03F663;
        Mon, 12 Jun 2023 03:33:47 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:33:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
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
Subject: Re: [PATCH v5 15/18] watchdog/perf: Add a weak function for an arch
 to detect if perf can use NMIs
Message-ID: <ZIb0hd8djM+jJviF@FVFF77S0Q05N>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.15.Ic55cb6f90ef5967d8aaa2b503a4e67c753f64d3a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519101840.v5.15.Ic55cb6f90ef5967d8aaa2b503a4e67c753f64d3a@changeid>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 10:18:39AM -0700, Douglas Anderson wrote:
> On arm64, NMI support needs to be detected at runtime. Add a weak
> function to the perf hardlockup detector so that an architecture can
> implement it to detect whether NMIs are available.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> While I won't object to this patch landing, I consider it part of the
> arm64 perf hardlockup effort. I would be OK with the earlier patches
> in the series landing and then not landing ${SUBJECT} patch nor
> anything else later.

FWIW, everything prior to this looks fine to me, so I reckon it'd be worth
splitting the series here and getting the buddy lockup detector in first, to
avoid a log-jam on all the subsequent NMI bits.

Thanks,
Mark.

> I'll also note that, as an alternative to this, it would be nice if we
> could figure out how to make perf_event_create_kernel_counter() fail
> on arm64 if NMIs aren't available. Maybe we could add a "must_use_nmi"
> element to "struct perf_event_attr"?
> 
> (no changes since v4)
> 
> Changes in v4:
> - ("Add a weak function for an arch to detect ...") new for v4.
> 
>  include/linux/nmi.h    |  1 +
>  kernel/watchdog_perf.c | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 47db14e7da52..eb616fc07c85 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -210,6 +210,7 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
>  
>  #ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
>  u64 hw_nmi_get_sample_period(int watchdog_thresh);
> +bool arch_perf_nmi_is_available(void);
>  #endif
>  
>  #if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
> diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
> index 349fcd4d2abc..8ea00c4a24b2 100644
> --- a/kernel/watchdog_perf.c
> +++ b/kernel/watchdog_perf.c
> @@ -234,12 +234,22 @@ void __init hardlockup_detector_perf_restart(void)
>  	}
>  }
>  
> +bool __weak __init arch_perf_nmi_is_available(void)
> +{
> +	return true;
> +}
> +
>  /**
>   * watchdog_hardlockup_probe - Probe whether NMI event is available at all
>   */
>  int __init watchdog_hardlockup_probe(void)
>  {
> -	int ret = hardlockup_detector_event_create();
> +	int ret;
> +
> +	if (!arch_perf_nmi_is_available())
> +		return -ENODEV;
> +
> +	ret = hardlockup_detector_event_create();
>  
>  	if (ret) {
>  		pr_info("Perf NMI watchdog permanently disabled\n");
> -- 
> 2.40.1.698.g37aff9b760-goog
> 
