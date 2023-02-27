Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550DA6A4D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjB0VkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjB0VkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:40:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B521CAFA;
        Mon, 27 Feb 2023 13:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3146C60F3C;
        Mon, 27 Feb 2023 21:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8BBC4339B;
        Mon, 27 Feb 2023 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677534016;
        bh=nbwhlTeSxGhw/pD2BLMBRVFJ0PxGzpZRp7GjSST97eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gteXZxTkFz7RcL6KKR92rNMrddYrDROkAx/v2gY8zslNEO2UPkSSqF2jTijJMBe/h
         6ScsloaAoQXfN3jrOwz5yMFhJKM3YfqoviAoM/ct8FUTyZ7DzQ9l8CjSAIHDatg8MD
         rX7MPytoB2U4cpzU+vTyPxz8mJSTouEOVuSDIWCMN/jsrqQWDppZzlSy+Ol/tusU7E
         yigyzcADjzjNQBirwSHsKk7MUIigljCfxcje2Brok4gNAbT9E5F45fUK4S5YQHqzIq
         TWHMsjUHsVlwjn/fIPiVcbgL7jAauzFjgmiI0dYPU2zjeEZS6Z3vddv1PIGuLfTQ3R
         MW3Fq0ri4dAmQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 92F274049F; Mon, 27 Feb 2023 18:40:13 -0300 (-03)
Date:   Mon, 27 Feb 2023 18:40:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] perf kvm: Support histograms and TUI mode
Message-ID: <Y/0jPa9xu371PtRS@kernel.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Feb 26, 2023 at 12:20:39PM +0800, Leo Yan escreveu:
> This patch set is to enable histograms and (partially) TUI mode in perf
> kvm tool.
> 
> Current tool uses its own RB tree to maintain KVM events, it's not easy
> to extend to support more metrics and have no chance to support TUI
> mode.  For this reason, we need firstly to refactor the code by using
> histograms and its associated RB tree; based on histograms we can add
> dimensions for KVM event statistics.  Finally, we need to enable TUI
> mode in the tool.  This is the methodology applied in this series.
> 
> This series enables TUI mode for 'perf kvm stat report', but it doesn't
> support TUI mode for 'perf kvm stat live'; this is because live mode is
> different from report for TUI mode, which will be implemented in later
> (TBH, I need to look into more details in histograms for this part).
> 
> Patches 01 ~ 04 are minor refactoring and they are preparation for later
> enabling histograms and dimensions.
> 
> Patches 05 ~ 10 are for enabling histograms and dimensions; with these
> changes the cached list is replaced by histograms list, and we extend to
> support more sorting keys (max time, min time, mean time).
> 
> Patches 11 ~ 13 are to enable TUI mode in stat report, after this patch
> TUI mode will be default mode, and user needs to input option '--stdio'
> for stdio mode rather than TUI mode.
> 
> Patch 14 updates documentation for new sorting and 'stdio' mode.
> 
> After changes:
> 
> Please see the screenshot for the TUI with 'perf kvm stat report':
> https://people.linaro.org/~leo.yan/debug/perf/perf_kvm_stat_report_tui.png
> 
> And I verified the '--stdio' mode and confirmed it has the same result
> with before applying this series.

Can you provide precise instructions for all the steps involved? from
'perf kvm record', I'm trying here with a simple 'perf kvm record' and
then starting vm and having trouble.

- Arnaldo
 
>   # perf kvm stat report --stdio
> 
> 
>   Analyze events for all VMs, all VCPUs:
> 
>                VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time 
> 
>              MSR_WRITE        520    60.05%     0.07%      0.74us     16.92us      2.62us ( +-   2.66% )
>                    HLT        179    20.67%    99.82%     64.53us  17159.69us  10123.40us ( +-   4.68% )
>     EXTERNAL_INTERRUPT         71     8.20%     0.07%      1.16us     79.63us     17.56us ( +-  10.92% )
>          EPT_MISCONFIG         68     7.85%     0.03%      5.53us     64.64us      8.09us ( +-  12.50% )
>       PREEMPTION_TIMER         18     2.08%     0.01%      1.91us     12.06us      5.53us ( +-  10.25% )
>       INTERRUPT_WINDOW          7     0.81%     0.00%      0.91us      1.66us      1.30us ( +-   9.09% )
>               MSR_READ          3     0.35%     0.00%      4.06us      4.84us      4.42us ( +-   5.11% )
> 
>   Total Samples:866, Total events handled time:1815367.45us.
> 
>   # perf kvm stat live
>   12:10:10.786799
> 
>   Analyze events for all VMs, all VCPUs:
> 
>                VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time 
> 
>              MSR_WRITE        121    66.85%    12.90%      0.67us  62918.87us    667.19us ( +-  80.72% )
>                    HLT         34    18.78%    76.61%   2069.99us  52171.44us  14103.37us ( +-  14.25% )
>     EXTERNAL_INTERRUPT         20    11.05%    10.49%      1.61us  47469.17us   3282.16us ( +-  75.75% )
>       PREEMPTION_TIMER          5     2.76%     0.00%      3.98us      7.39us      5.84us ( +-  10.51% )
>       INTERRUPT_WINDOW          1     0.55%     0.00%      2.01us      2.01us      2.01us ( +-   0.00% )
> 
>   Total Samples:181, Total events handled time:625919.05us.
> 
> 
> Leo Yan (14):
>   perf kvm: Refactor overall statistics
>   perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
>   perf kvm: Move up metrics helpers
>   perf kvm: Use subtraction for comparison metrics
>   perf kvm: Introduce histograms data structures
>   perf kvm: Pass argument 'sample' to kvm_alloc_init_event()
>   perf kvm: Parse address location for samples
>   perf kvm: Add dimensions for KVM event statistics
>   perf kvm: Use histograms list to replace cached list
>   perf kvm: Polish sorting key
>   perf kvm: Support printing attributions for dimensions
>   perf kvm: Add dimensions for percentages
>   perf kvm: Add TUI mode for stat report
>   perf kvm: Update documentation to reflect new changes
> 
>  tools/perf/Documentation/perf-kvm.txt |   9 +-
>  tools/perf/builtin-kvm.c              | 847 +++++++++++++++++++++-----
>  tools/perf/util/kvm-stat.h            |  26 +-
>  3 files changed, 707 insertions(+), 175 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 

- Arnaldo
