Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D42B69CA18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjBTLpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBTLpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:45:42 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930A4EC53;
        Mon, 20 Feb 2023 03:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X8k7KlQ4uXMCXN8bSMF5Q1MWz8YaNsyZxevsKw/7eD0=; b=mv4Gf92/oWST8m1vQtLsjSNMKd
        p9mcm9oBmqXaW+70mPiWbaA73iD10I3guNk+kxNDeJaRS9XMLoRP0p01lbv19U+ImiB4robUUX0nv
        s0oEu2hgCbreGySB4AeIEAN9sH5I1oGGOW2XlofHJpPGJyIiuIxpPC68AoJwKm4g2nZc2i24OB/x4
        JCq31xaPjwsHY/xpdo1PYHaitI89SaYtWYmT4u71k+R/Z4AL9Kv6GAJY2WwBgJ3N17rV/QYcSIU00
        s4iEUzhVBkH7PWZTGq7LkypivcHev1O3MoxN0l0aMH0T357Fhq06lhOWkZeT7tq6UQqfV7En74mk7
        Sy20WBOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pU4bj-00BnUt-1l;
        Mon, 20 Feb 2023 11:45:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C3C530036B;
        Mon, 20 Feb 2023 12:45:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B4C32135FAC6; Mon, 20 Feb 2023 12:45:22 +0100 (CET)
Date:   Mon, 20 Feb 2023 12:45:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wyes Karny <wyes.karny@amd.com>,
        Stephane Eranian <eranian@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        ananth.narayan@amd.com
Subject: Re: [PATCH] perf/x86/rapl: Enable Core RAPL for AMD
Message-ID: <Y/NdUjLiQu+D0q7b@hirez.programming.kicks-ass.net>
References: <20230217161354.129442-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217161354.129442-1-wyes.karny@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 04:13:54PM +0000, Wyes Karny wrote:
> AMD processors support per-package and per-core energy monitoring
> through RAPL counters which can be accessed by users running in
> supervisor mode.
> 
> Core RAPL counters gives power consumption information per core.  For
> AMD processors the package level RAPL counter are already exposed to
> perf. Expose the core level RAPL counters also.
> 
> sudo perf stat -a --per-core -C 0-127 -e power/energy-cores/
> 
> Output:
> S0-D0-C0           2               8.73 Joules power/energy-cores/
> S0-D0-C1           2               8.73 Joules power/energy-cores/
> S0-D0-C2           2               8.73 Joules power/energy-cores/
> S0-D0-C3           2               8.73 Joules power/energy-cores/
> S0-D0-C4           2               8.73 Joules power/energy-cores/
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  arch/x86/events/rapl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 52e6e7ed4f78..d301bbbc3b93 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -537,7 +537,7 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
>   * - want to use same event codes across both architectures
>   */
>  static struct perf_msr amd_rapl_msrs[] = {
> -	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
> +	[PERF_RAPL_PP0]  = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },

Stephane, this was an oversight?

>  	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
>  	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
>  	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
> @@ -764,7 +764,8 @@ static struct rapl_model model_spr = {
>  };
>  
>  static struct rapl_model model_amd_hygon = {
> -	.events		= BIT(PERF_RAPL_PKG),
> +	.events		= BIT(PERF_RAPL_PP0) |
> +			  BIT(PERF_RAPL_PKG),
>  	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
>  	.rapl_msrs      = amd_rapl_msrs,
>  };
> -- 
> 2.34.1
> 
