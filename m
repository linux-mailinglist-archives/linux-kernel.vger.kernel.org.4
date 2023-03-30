Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22A66D05E6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjC3NHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjC3NHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:07:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9DB8;
        Thu, 30 Mar 2023 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=msbl6O2CGPkUkUvjCW+nOGY6ckr9evNZQggsspXa+z8=; b=PQVyAxFY2wxeQDB6gMz26HUZML
        uwaGBn5Hm6KT8k53QozhTJxJbrK+0Wqu/CgzV6iojDrt1kJ8iSi8SKxa7YSUpbpyjQG7oOWSr3rbn
        phjKltE3xQmunowptbzUtymHd+92aKKUteqpXtZnKuzykc4cNcpAtZm3kl5nwcRD1XpsbCzRwLMe/
        gYi6VAnrq+/yVKs0+57kzARfQtyglhUN1KcPISot+pKTisRjmqAFRoORSa8aAj928KKhvAlg8Qy/F
        rLY5bDnYJTkdF881SWv6nCQvlodChMKrBITrjY/mtn3DLbZkzzlgCslvGPkwTrAPrh+FECYEjaCLt
        OOlOuQEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phrzb-00AQbG-Bo; Thu, 30 Mar 2023 13:07:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6622A300230;
        Thu, 30 Mar 2023 15:07:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EA692065CD4A; Thu, 30 Mar 2023 15:07:02 +0200 (CEST)
Date:   Thu, 30 Mar 2023 15:07:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Tinghao <tinghao.zhang@intel.com>,
        Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: Re: [PATCH] perf/x86/intel: Define bit macros for FixCntrCtl MSR
Message-ID: <20230330130702.GF124812@hirez.programming.kicks-ass.net>
References: <20230330012846.2927220-1-dapeng1.mi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330012846.2927220-1-dapeng1.mi@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 09:28:46AM +0800, Dapeng Mi wrote:
> Define bit macros for FixCntrCtl MSR and replace the bit hardcoding
> with these bit macros. This would make code be more human-readable.
> 
> Perf commands 'perf stat -e "instructions,cycles,ref-cycles"' and
> 'perf record -e "instructions,cycles,ref-cycles"' pass.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c      | 18 +++++++++---------
>  arch/x86/include/asm/perf_event.h | 10 ++++++++++
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 070cc4ef2672..b7c0bb78ed59 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2451,7 +2451,7 @@ static void intel_pmu_disable_fixed(struct perf_event *event)
>  
>  	intel_clear_masks(event, idx);
>  
> -	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
> +	mask = intel_fixed_bits(idx - INTEL_PMC_IDX_FIXED, INTEL_FIXED_BITS_MASK);
>  	cpuc->fixed_ctrl_val &= ~mask;

So maybe it's me, but I find the original far easier to read :/ That new
things I need to look up every single identifier before I can tell wth
it does.
