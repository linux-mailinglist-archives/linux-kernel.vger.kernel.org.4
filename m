Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7558C7072FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjEQU0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEQU0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:26:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F73135AD;
        Wed, 17 May 2023 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684355210; x=1715891210;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=y3Lpo6i1Ow+VK1b2cyEfFgMYbY83bMwZmtqUkDzDvbc=;
  b=T79ohFZVn5Kf9Ds45hRvm/Y2Up0QN8Xtnjxt5BD+s0qB+wllNtfkUYs7
   BiZOfVyF3Tj4C/ppPbf+A5hPjmvkuksivBobWO2BvB2SYVliSawscE961
   v6Ernd4Qsqn7XYpwV/E+hC9pvSWCFnlOnDc0MdcszxzGHY5WvMR5VpTJa
   v58go9NpOf9JG8VBJBEpnjp7pnuzh2szpz4O5em0hOGy62VIoxrjC9ujA
   UHOe3HzVzBPwRkv/7tEeDIswqvjEx9HDR9d5/mlS8tH2x+6Kj2nvfbbXa
   KMYw7oUKPeLhu1rAUGDIcqRMG39Vjrp7w1tuYUkHEBQ17AOoBhUqOqtdl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="332234960"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="332234960"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 13:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="876162795"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="876162795"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 17 May 2023 13:26:49 -0700
Received: from [10.251.17.142] (kliang2-mobl1.ccr.corp.intel.com [10.251.17.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 17A81580AF7;
        Wed, 17 May 2023 13:26:47 -0700 (PDT)
Message-ID: <7b7a9c75-bf81-922f-42ea-8e99852f7a7a@linux.intel.com>
Date:   Wed, 17 May 2023 16:26:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 00/15] Event, metric and metric group improvements
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230517173805.602113-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230517173805.602113-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-17 1:37 p.m., Ian Rogers wrote:
> Update Intel events to the latest at: https://github.com/intel/perfmon
> TMA info metrics are renamed for consistency and a fix is added that
> adds back in the Valkyrie metrics such as memory_bandwidth_total,
> memory_bandwidth_read and memory_bandwidth_write on icelakex.
> 
> Add a new feature to perf list to show a description of a metricgroup
> via a new metricgroups.json file, add this for the generated Intel
> metrics. The descriptions looks like:
> 
> ```
> $ perf list
> ...
> tma_frontend_bound_group: [Metrics contributing to tma_frontend_bound category]
>   tma_fetch_bandwidth
>        [This metric represents fraction of slots the CPU
>         was stalled due to Frontend bandwidth issues]
>   tma_fetch_latency
>        [This metric represents fraction of slots the CPU
>         was stalled due to Frontend latency issues]
> ...
> ```
> 
> v2/v3. Reword "Grouping from metrics spreadsheet" to "Grouping from
>        Top-down Microarchitecture Analysis Metrics spreadsheet" as
>        suggested by Kan Liang.
> 
> Ian Rogers (15):
>   perf vendor events intel: Update alderlake events/metrics
>   perf vendor events intel: Update broadwell variant events/metrics
>   perf vendor events intel: Update cascadelakex events/metrics
>   perf vendor events intel: Update elkhartlake events
>   perf vendor events intel: Update haswell(x) metrics
>   perf vendor events intel: Update icelake/icelakex events/metrics
>   perf vendor events intel: Update ivybridge/ivytown metrics
>   perf vendor events intel: Update jaketown metrics
>   perf vendor events intel: Update sandybridge metrics
>   perf vendor events intel: Update sapphirerapids events/metrics
>   perf vendor events intel: Update skylake/skylakex events/metrics
>   perf vendor events intel: Update snowridgex events
>   perf vendor events intel: Update tigerlake events/metrics
>   perf jevents: Add support for metricgroup descriptions
>   perf vendor events intel: Add metricgroup descriptions for all models

Thanks Ian.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> 
>  tools/perf/builtin-list.c                     |   11 +-
>  .../arch/x86/alderlake/adl-metrics.json       | 1314 ++++++++--------
>  .../pmu-events/arch/x86/alderlake/cache.json  |    9 +
>  .../pmu-events/arch/x86/alderlake/memory.json |    6 +-
>  .../arch/x86/alderlake/metricgroups.json      |  122 ++
>  .../arch/x86/alderlaken/adln-metrics.json     |  276 ++--
>  .../arch/x86/alderlaken/metricgroups.json     |   26 +
>  .../arch/x86/broadwell/bdw-metrics.json       |  580 +++----
>  .../arch/x86/broadwell/floating-point.json    |   15 +
>  .../arch/x86/broadwell/metricgroups.json      |  107 ++
>  .../arch/x86/broadwellde/bdwde-metrics.json   |  556 +++----
>  .../arch/x86/broadwellde/floating-point.json  |   15 +
>  .../arch/x86/broadwellde/metricgroups.json    |  107 ++
>  .../arch/x86/broadwellx/bdx-metrics.json      |  796 ++++++----
>  .../arch/x86/broadwellx/floating-point.json   |   15 +
>  .../arch/x86/broadwellx/metricgroups.json     |  107 ++
>  .../arch/x86/cascadelakex/clx-metrics.json    | 1231 +++++++++------
>  .../arch/x86/cascadelakex/floating-point.json |   31 +
>  .../arch/x86/cascadelakex/metricgroups.json   |  114 ++
>  .../arch/x86/cascadelakex/pipeline.json       |   23 +-
>  .../arch/x86/elkhartlake/cache.json           |    7 +
>  .../arch/x86/elkhartlake/memory.json          |    2 +
>  .../arch/x86/elkhartlake/other.json           |   10 +
>  .../arch/x86/elkhartlake/pipeline.json        |    3 +
>  .../arch/x86/haswell/hsw-metrics.json         |  484 +++---
>  .../arch/x86/haswell/metricgroups.json        |  107 ++
>  .../arch/x86/haswellx/hsx-metrics.json        |  700 ++++++---
>  .../arch/x86/haswellx/metricgroups.json       |  107 ++
>  .../pmu-events/arch/x86/icelake/cache.json    |   18 +
>  .../arch/x86/icelake/icl-metrics.json         |  950 ++++++------
>  .../arch/x86/icelake/metricgroups.json        |  113 ++
>  .../arch/x86/icelakex/icx-metrics.json        | 1306 +++++++++-------
>  .../arch/x86/icelakex/metricgroups.json       |  114 ++
>  .../arch/x86/ivybridge/ivb-metrics.json       |  526 +++----
>  .../arch/x86/ivybridge/metricgroups.json      |  107 ++
>  .../arch/x86/ivytown/ivt-metrics.json         |  534 +++----
>  .../arch/x86/ivytown/metricgroups.json        |  107 ++
>  .../arch/x86/jaketown/jkt-metrics.json        |  224 +--
>  .../arch/x86/jaketown/metricgroups.json       |  100 ++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   31 +-
>  .../arch/x86/sandybridge/metricgroups.json    |  100 ++
>  .../arch/x86/sandybridge/snb-metrics.json     |  222 +--
>  .../arch/x86/sapphirerapids/memory.json       |    6 +-
>  .../arch/x86/sapphirerapids/metricgroups.json |  118 ++
>  .../arch/x86/sapphirerapids/spr-metrics.json  | 1357 ++++++++++-------
>  .../sapphirerapids/uncore-interconnect.json   |    2 +-
>  .../x86/sapphirerapids/uncore-memory.json     |    8 +-
>  .../arch/x86/skylake/floating-point.json      |    8 +
>  .../arch/x86/skylake/metricgroups.json        |  113 ++
>  .../pmu-events/arch/x86/skylake/pipeline.json |   15 +-
>  .../arch/x86/skylake/skl-metrics.json         |  875 ++++++-----
>  .../arch/x86/skylakex/floating-point.json     |   31 +
>  .../arch/x86/skylakex/metricgroups.json       |  114 ++
>  .../arch/x86/skylakex/pipeline.json           |   23 +-
>  .../arch/x86/skylakex/skx-metrics.json        | 1183 ++++++++------
>  .../pmu-events/arch/x86/snowridgex/cache.json |    7 +
>  .../arch/x86/snowridgex/memory.json           |    2 +
>  .../pmu-events/arch/x86/snowridgex/other.json |   10 +
>  .../arch/x86/snowridgex/pipeline.json         |    3 +
>  .../x86/snowridgex/uncore-interconnect.json   |   14 +-
>  .../arch/x86/snowridgex/uncore-io.json        |    8 -
>  .../arch/x86/snowridgex/uncore-memory.json    |    7 +-
>  .../arch/x86/snowridgex/uncore-power.json     |    6 +-
>  .../pmu-events/arch/x86/tigerlake/cache.json  |   18 +
>  .../arch/x86/tigerlake/metricgroups.json      |  113 ++
>  .../arch/x86/tigerlake/pipeline.json          |    1 +
>  .../arch/x86/tigerlake/tgl-metrics.json       |  970 ++++++------
>  tools/perf/pmu-events/empty-pmu-events.c      |    5 +
>  tools/perf/pmu-events/jevents.py              |   49 +-
>  tools/perf/pmu-events/pmu-events.h            |    2 +
>  70 files changed, 9985 insertions(+), 6416 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/haswell/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelake/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/skylake/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/metricgroups.json
> 
