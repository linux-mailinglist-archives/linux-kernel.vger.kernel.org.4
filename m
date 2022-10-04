Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD65F42B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJDMJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJDMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:09:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E8C58527;
        Tue,  4 Oct 2022 05:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6CE661419;
        Tue,  4 Oct 2022 12:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71A5C433C1;
        Tue,  4 Oct 2022 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664885344;
        bh=rQo5WdWHeAhyrZm9gKjpC2nAI4tbbWT6uT3p8FgRJBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYIu2Iy3FalILzw/mEs7z20CpZ41VLIHh3oAPnVbQCBNKQghkFbBdnA4z//TYTxFR
         IAh4ldPm31eBPyV+xm09wGT7dEVdM+nUsJIIF0290YYDY9u9bVgl1eH4dJkjRbSSc6
         WzOCKgvoliWtGMrrTqxS+92TVDMmmiX8Qbg+Zzg3MfiLIee6PDYoti7IqFL+4KwGKr
         ogL1i7i8JmZUVLWRiC5gWgiXifhzkCjBddLuqQXBnDLVTwEOyg2AixVo/NAK2PC5WH
         X7O6AEz5tjcKpwznqxmQfm0TMQAvXBXJvYeUKFn1lXP0j+hP9iSAO/itEkKHBLM220
         aK7FZTAQctICA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36DB34062C; Tue,  4 Oct 2022 09:09:01 -0300 (-03)
Date:   Tue, 4 Oct 2022 09:09:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 00/23] Improvements to Intel perf metrics
Message-ID: <YzwiXfWNbLM0et3A@kernel.org>
References: <20221004021612.325521-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 03, 2022 at 07:15:49PM -0700, Ian Rogers escreveu:
> For consistency with:
> https://github.com/intel/perfmon-metrics
> rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.
> 
> Remove _SMT suffix metrics are dropped as the #SMT_On and #EBS_Mode
> are correctly expanded in the single main metric. Fix perf expr to
> allow a double if to be correctly processed.
> 
> Add all 6 levels of TMA metrics. Child metrics are placed in a group
> named after their parent allowing children of a metric to be
> easily measured using the metric name with a _group suffix.
> 
> Don't drop TMA metrics if they contain topdown events.
> 
> The ## and ##? operators are correctly expanded.
> 
> The locate-with column is added to the long description describing a
> sampling event.
> 
> Metrics are written in terms of other metrics to reduce the expression
> size and increase readability.
> 
> Following this the pmu-events/arch/x86 directories match those created
> by the script at:
> https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py
> with updates at:
> https://github.com/captain5050/event-converter-for-linux-perf
> 
> 
> v3. Fix a parse metrics test failure due to making metrics referring
>     to other metrics case sensitive - make the cases in the test
>     metric match.



Thanks, applied.

- Arnaldo


> v2. Fixes commit message wrt missing mapfile.csv updates as noted by
>     Zhengjun Xing <zhengjun.xing@linux.intel.com>. ScaleUnit is added
>     for TMA metrics. Metrics with topdown events have have a missing
>     slots event added if necessary. The latest metrics at:
>     https://github.com/intel/perfmon-metrics are used, however, the
>     event-converter-for-linux-perf scripts now prefer their own
>     metrics in case of mismatched units when a metric is written in
>     terms of another.  Additional testing was performed on broadwell,
>     broadwellde, cascadelakex, haswellx, sapphirerapids and tigerlake
>     CPUs.
> 
> Ian Rogers (23):
>   perf expr: Allow a double if expression
>   perf test: Adjust case of test metrics
>   perf expr: Remove jevents case workaround
>   perf metrics: Don't scale counts going into metrics
>   perf vendor events: Update Intel skylakex
>   perf vendor events: Update Intel alderlake
>   perf vendor events: Update Intel broadwell
>   perf vendor events: Update Intel broadwellx
>   perf vendor events: Update Intel cascadelakex
>   perf vendor events: Update elkhartlake cpuids
>   perf vendor events: Update Intel haswell
>   perf vendor events: Update Intel haswellx
>   perf vendor events: Update Intel icelake
>   perf vendor events: Update Intel icelakex
>   perf vendor events: Update Intel ivybridge
>   perf vendor events: Update Intel ivytown
>   perf vendor events: Update Intel jaketown
>   perf vendor events: Update Intel sandybridge
>   perf vendor events: Update Intel sapphirerapids
>   perf vendor events: Update silvermont cpuids
>   perf vendor events: Update Intel skylake
>   perf vendor events: Update Intel tigerlake
>   perf vendor events: Update Intel broadwellde
> 
>  .../arch/test/test_soc/cpu/metrics.json       |    6 +-
>  .../arch/x86/alderlake/adl-metrics.json       | 1353 ++++++++++++++++-
>  .../pmu-events/arch/x86/alderlake/cache.json  |  129 +-
>  .../arch/x86/alderlake/frontend.json          |   12 +
>  .../pmu-events/arch/x86/alderlake/memory.json |   22 +
>  .../pmu-events/arch/x86/alderlake/other.json  |   22 +
>  .../arch/x86/alderlake/pipeline.json          |   14 +-
>  .../arch/x86/broadwell/bdw-metrics.json       |  679 +++++++--
>  .../arch/x86/broadwellde/bdwde-metrics.json   |  711 +++++++--
>  .../arch/x86/broadwellx/bdx-metrics.json      |  965 +++++++-----
>  .../arch/x86/broadwellx/uncore-cache.json     |   10 +-
>  .../x86/broadwellx/uncore-interconnect.json   |   18 +-
>  .../arch/x86/broadwellx/uncore-memory.json    |   18 +-
>  .../arch/x86/cascadelakex/clx-metrics.json    | 1285 ++++++++++------
>  .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
>  .../arch/x86/cascadelakex/uncore-other.json   |   10 +-
>  .../pmu-events/arch/x86/haswell/cache.json    |    4 +-
>  .../pmu-events/arch/x86/haswell/frontend.json |   12 +-
>  .../arch/x86/haswell/hsw-metrics.json         |  570 ++++++-
>  .../pmu-events/arch/x86/haswellx/cache.json   |    2 +-
>  .../arch/x86/haswellx/frontend.json           |   12 +-
>  .../arch/x86/haswellx/hsx-metrics.json        |  919 +++++++----
>  .../x86/haswellx/uncore-interconnect.json     |   18 +-
>  .../arch/x86/haswellx/uncore-memory.json      |   18 +-
>  .../pmu-events/arch/x86/icelake/cache.json    |    6 +-
>  .../arch/x86/icelake/icl-metrics.json         |  808 +++++++++-
>  .../pmu-events/arch/x86/icelake/pipeline.json |    2 +-
>  .../pmu-events/arch/x86/icelakex/cache.json   |    6 +-
>  .../arch/x86/icelakex/icx-metrics.json        | 1155 ++++++++++----
>  .../arch/x86/icelakex/pipeline.json           |    2 +-
>  .../arch/x86/icelakex/uncore-other.json       |    2 +-
>  .../arch/x86/ivybridge/ivb-metrics.json       |  594 ++++++--
>  .../pmu-events/arch/x86/ivytown/cache.json    |    4 +-
>  .../arch/x86/ivytown/floating-point.json      |    2 +-
>  .../pmu-events/arch/x86/ivytown/frontend.json |   18 +-
>  .../arch/x86/ivytown/ivt-metrics.json         |  630 ++++++--
>  .../arch/x86/ivytown/uncore-cache.json        |   58 +-
>  .../arch/x86/ivytown/uncore-interconnect.json |   84 +-
>  .../arch/x86/ivytown/uncore-memory.json       |    2 +-
>  .../arch/x86/ivytown/uncore-other.json        |    6 +-
>  .../arch/x86/ivytown/uncore-power.json        |    8 +-
>  .../arch/x86/jaketown/jkt-metrics.json        |  327 +++-
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   18 +-
>  .../arch/x86/sandybridge/snb-metrics.json     |  315 +++-
>  .../arch/x86/sapphirerapids/cache.json        |    4 +-
>  .../arch/x86/sapphirerapids/frontend.json     |   11 +
>  .../arch/x86/sapphirerapids/pipeline.json     |    4 +-
>  .../arch/x86/sapphirerapids/spr-metrics.json  | 1249 ++++++++++-----
>  .../arch/x86/skylake/skl-metrics.json         |  861 ++++++++---
>  .../arch/x86/skylakex/skx-metrics.json        | 1262 +++++++++------
>  .../arch/x86/skylakex/uncore-memory.json      |   18 +-
>  .../arch/x86/skylakex/uncore-other.json       |   19 +-
>  .../arch/x86/tigerlake/tgl-metrics.json       |  810 +++++++++-
>  tools/perf/pmu-events/empty-pmu-events.c      |    6 +-
>  tools/perf/tests/expr.c                       |    4 +
>  tools/perf/util/expr.c                        |   11 +-
>  tools/perf/util/expr.y                        |    2 +-
>  tools/perf/util/stat-shadow.c                 |    9 +-
>  58 files changed, 11514 insertions(+), 3630 deletions(-)
> 
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog

-- 

- Arnaldo
