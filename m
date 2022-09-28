Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D11E5EDD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiI1M4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiI1M4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:56:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814405FDC5;
        Wed, 28 Sep 2022 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664369808; x=1695905808;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=3RAHgbkHq8T+Qb+CU+6KDFqC9Ep0SqrCRbIgI6xn7tI=;
  b=ijdbRmLRYi9uUzyuN8zJwFkla8MF/0Rgp5poFX7YI6UghLfqJDVK1NZy
   kcX53OsswD7Iixe9/YDMsCx8i6BJ0++GaCguAVmhsdww+gIOkZ4LdwBhD
   AOE8SzI9RYirMeLyxVI4Sb2a1RmzWzdgsidj3Xvoeidwx9mM69nJp6R1E
   Q3L0CObYQ0uF7cj0NjS1QxHTPHMjoH5Sp33DSjAXnflgPjiVIOqvu+q/t
   1tYwM/sCMwrWH0N8V7guZqi0+Cp7XSzTsOMq24n5srOetpL3dyGePnJkk
   Uf3hWrXj3aKdOStDWseukqQAUP90rrFzwnaRVP3BllLedJGeY51GtHNe2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="387874747"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="387874747"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 05:56:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="599567148"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="599567148"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 28 Sep 2022 05:56:41 -0700
Received: from [10.252.215.103] (kliang2-mobl1.ccr.corp.intel.com [10.252.215.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D41B6580BE9;
        Wed, 28 Sep 2022 05:56:38 -0700 (PDT)
Message-ID: <6312dee3-aa37-b244-df0e-a5cd75ddee71@linux.intel.com>
Date:   Wed, 28 Sep 2022 08:56:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220928072204.1613330-1-irogers@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v1 00/22] Improvements to Intel perf metrics
In-Reply-To: <20220928072204.1613330-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-09-28 3:21 a.m., Ian Rogers wrote:
> For consistency with:
> https://github.com/intel/perfmon-metrics
> rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.
>

If so, all the scripts with the old name must be broken on the existing
platforms. Can we keep both old name and new name for the existing
platforms?

For the event naming, if we want to rename an event. We still keep the
old name and mark it as deprecated in the existing platforms to maintain
compatibility.

Can we do the similar thing for metrics?
For the existing platforms, just add all the metrics from the
perfmon-metrics and don't change the existing metrics unless they have
errors.

Thanks,
Kan
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
> Ian Rogers (22):
>   perf expr: Allow a double if expression
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
>  .../arch/x86/alderlake/adl-metrics.json       | 1215 ++++++++++++++++-
>  .../pmu-events/arch/x86/alderlake/cache.json  |  129 +-
>  .../arch/x86/alderlake/frontend.json          |   12 +
>  .../pmu-events/arch/x86/alderlake/memory.json |   22 +
>  .../pmu-events/arch/x86/alderlake/other.json  |   22 +
>  .../arch/x86/alderlake/pipeline.json          |   14 +-
>  .../arch/x86/broadwell/bdw-metrics.json       |  603 ++++++--
>  .../arch/x86/broadwellde/bdwde-metrics.json   |  639 +++++++--
>  .../arch/x86/broadwellx/bdx-metrics.json      |  644 +++++++--
>  .../arch/x86/broadwellx/uncore-cache.json     |   10 +-
>  .../x86/broadwellx/uncore-interconnect.json   |   18 +-
>  .../arch/x86/broadwellx/uncore-memory.json    |   18 +-
>  .../arch/x86/cascadelakex/clx-metrics.json    |  893 ++++++++----
>  .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
>  .../arch/x86/cascadelakex/uncore-other.json   |   10 +-
>  .../pmu-events/arch/x86/haswell/cache.json    |    4 +-
>  .../pmu-events/arch/x86/haswell/frontend.json |   12 +-
>  .../arch/x86/haswell/hsw-metrics.json         |  502 +++++--
>  .../pmu-events/arch/x86/haswellx/cache.json   |    2 +-
>  .../arch/x86/haswellx/frontend.json           |   12 +-
>  .../arch/x86/haswellx/hsx-metrics.json        |  707 +++++++---
>  .../x86/haswellx/uncore-interconnect.json     |   18 +-
>  .../arch/x86/haswellx/uncore-memory.json      |   18 +-
>  .../pmu-events/arch/x86/icelake/cache.json    |    6 +-
>  .../arch/x86/icelake/icl-metrics.json         |  725 +++++++++-
>  .../pmu-events/arch/x86/icelake/pipeline.json |    2 +-
>  .../pmu-events/arch/x86/icelakex/cache.json   |    6 +-
>  .../arch/x86/icelakex/icx-metrics.json        |  794 ++++++++++-
>  .../arch/x86/icelakex/pipeline.json           |    2 +-
>  .../arch/x86/icelakex/uncore-other.json       |    2 +-
>  .../arch/x86/ivybridge/ivb-metrics.json       |  525 +++++--
>  .../pmu-events/arch/x86/ivytown/cache.json    |    4 +-
>  .../arch/x86/ivytown/floating-point.json      |    2 +-
>  .../pmu-events/arch/x86/ivytown/frontend.json |   18 +-
>  .../arch/x86/ivytown/ivt-metrics.json         |  558 ++++++--
>  .../arch/x86/ivytown/uncore-cache.json        |   58 +-
>  .../arch/x86/ivytown/uncore-interconnect.json |   84 +-
>  .../arch/x86/ivytown/uncore-memory.json       |    2 +-
>  .../arch/x86/ivytown/uncore-other.json        |    6 +-
>  .../arch/x86/ivytown/uncore-power.json        |    8 +-
>  .../arch/x86/jaketown/jkt-metrics.json        |  291 ++--
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   18 +-
>  .../arch/x86/sandybridge/snb-metrics.json     |  279 +++-
>  .../arch/x86/sapphirerapids/cache.json        |    4 +-
>  .../arch/x86/sapphirerapids/frontend.json     |   11 +
>  .../arch/x86/sapphirerapids/pipeline.json     |    4 +-
>  .../arch/x86/sapphirerapids/spr-metrics.json  |  858 +++++++++++-
>  .../arch/x86/skylake/skl-metrics.json         |  774 ++++++++---
>  .../arch/x86/skylakex/skx-metrics.json        |  859 +++++++++---
>  .../arch/x86/skylakex/uncore-memory.json      |   18 +-
>  .../arch/x86/skylakex/uncore-other.json       |   19 +-
>  .../arch/x86/tigerlake/tgl-metrics.json       |  727 +++++++++-
>  tools/perf/tests/expr.c                       |    4 +
>  tools/perf/util/expr.c                        |   11 +-
>  tools/perf/util/expr.y                        |    2 +-
>  tools/perf/util/stat-shadow.c                 |    9 +-
>  56 files changed, 10103 insertions(+), 2129 deletions(-)
> 
