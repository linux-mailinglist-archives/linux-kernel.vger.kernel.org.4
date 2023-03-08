Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADF16B0AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCHORD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCHOQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:16:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED45BDAB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8myYNA9doaFCH37K50WGD9TRFSQlPXJyh1FBjJaXRX8=; b=UZgW56g2kNil/sKFIW5iDkoH2D
        WDDJiNn3kYTTJ5LY72BGZgLvy1qd9zeTyH5JceJIGx2AtiWiQlE+f1g8vYcEDFGyklyjc8mvWfztp
        6GTZVZFheN5RXlQ+1LsAmhh4T7A5zHDImAhoTx3Mhn/XlhzzSX1ZD58i6BHZfXitK704sRRyTofPS
        dF+6xHyPqAteQjVkX1tSg72W6EOrXzRWOUnuw8m2MkdbQbhkqkpRe2HKgHZsqDxW4hiGYZm6NrnH9
        o4Mg9BDIHMql7X8RHf9MYurLYRRAI+ybrAfYIGvEfTxdKwvdIZ/I8/guO3zgb7uQUiP6I6NUd/ZG3
        UYhKQEWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZuac-007SOO-7d; Wed, 08 Mar 2023 14:16:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13B8B300288;
        Wed,  8 Mar 2023 15:16:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8D3720A28FE2; Wed,  8 Mar 2023 15:16:19 +0100 (CET)
Date:   Wed, 8 Mar 2023 15:16:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf/x86/intel: use hexidecimal value for cpuid
Message-ID: <20230308141619.GI2017917@hirez.programming.kicks-ass.net>
References: <20230308031501.4688-1-zhenyuw@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308031501.4688-1-zhenyuw@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:15:01AM +0800, Zhenyu Wang wrote:
> It's easier to use hexidecimal value instead of decimal for reading
> and following with SDM doc, also align with other cpuid calls.

*shrug*..

> Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 2 +-
>  arch/x86/events/intel/lbr.c  | 2 +-
>  arch/x86/events/intel/pt.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 14f0a746257d..5af084198c8f 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5903,7 +5903,7 @@ __init int intel_pmu_init(void)
>  	 * Check whether the Architectural PerfMon supports
>  	 * Branch Misses Retired hw_event or not.
>  	 */
> -	cpuid(10, &eax.full, &ebx.full, &fixed_mask, &edx.full);
> +	cpuid(0xA, &eax.full, &ebx.full, &fixed_mask, &edx.full);
>  	if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT)
>  		return -ENODEV;

But now the data type names and the cpuid calls are no longer related.
