Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810B769F5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjBVNrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjBVNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:47:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF41125;
        Wed, 22 Feb 2023 05:47:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C73FB8123A;
        Wed, 22 Feb 2023 13:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1526C433D2;
        Wed, 22 Feb 2023 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677073638;
        bh=zCC0XkWQD3wf20Y5Q/XG/X/FXj9lNvFwMc9Tyj9Zc6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eP3AiwSxl6GHQk7WxIqOtOxCM2oNEqzdAwLg1/NAm0y/wADWAZX//T9jq6k5KNlm5
         NdD8f76LghjjI02nFBQGS7TWxGGsEfSZkMKy2Mz1Azza4kfQx/hulFflpMTDKPMxLj
         MNAgUG73r/PEwlo4ZRryoVnMOIpHIaX76FP4GgkPfGQEdFQ2WxefoYPgZhaeZaHRoi
         /vmFr/xfYIE2LoGCDYrkqqEQUjK0MN72huEcbe9ctmQgwY6+Ws2Ab0YjcCuvDT2zgm
         nGiS9qLL2nMx6kzPOnE5yiId+y+LNrV1SVdW1jbnEQtEJEBadGCiL6PqlppICyMWTK
         pkomLlIegm7Bg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C7C524049F; Wed, 22 Feb 2023 10:47:14 -0300 (-03)
Date:   Wed, 22 Feb 2023 10:47:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [PATCH v1 00/51] shadow metric clean up and improvements
Message-ID: <Y/Yc4m6ozl9B0w4l@kernel.org>
References: <20230219092848.639226-1-irogers@google.com>
 <Y/IFNyI9JcChoR2p@kernel.org>
 <CAP-5=fWzydsYNKPBv+wCh4M9QaRbk5NiJOUDsjbjPdPjFWQ82g@mail.gmail.com>
 <CAP-5=fWmFtktttCmXBmF1W-V5yU47UFod=MxOX3re5pG_ScETQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWmFtktttCmXBmF1W-V5yU47UFod=MxOX3re5pG_ScETQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 21, 2023 at 09:44:36AM -0800, Ian Rogers escreveu:
> On Sun, Feb 19, 2023 at 7:43 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Sun, Feb 19, 2023, 3:17 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >
> > > Em Sun, Feb 19, 2023 at 01:27:57AM -0800, Ian Rogers escreveu:
> > > > Recently the shadow stat metrics broke due to repeated aggregation and
> > > > a quick fix was applied:
> > > > https://lore.kernel.org/lkml/20230209064447.83733-1-irogers@google.com/
> > > > This is the longer fix but one that comes with some extras. To avoid
> > > > fixing issues for hard coded metrics, the topdown, SMI cost and
> > > > transaction flags are moved into json metrics. A side effect of this
> > > > is that TopdownL1 metrics will now be displayed when supported, if no
> > > > "perf stat" events are specified.
> > > >
> > > > Another fix included here is for event grouping as raised in:
> > > > https://lore.kernel.org/lkml/CA+icZUU_ew7pzWJJZLbj1xsU6MQTPrj8tkFfDhNdTDRQfGUBMQ@mail.gmail.com/
> > > > Metrics are now tagged with NMI and SMT flags, meaning that the events
> > > > shouldn't be grouped if the NMI watchdog is enabled or SMT is enabled.
> > > >
> > > > Given the two issues, the metrics are re-generated and the patches
> > > > also include the latest Intel vendor events. The changes to the metric
> > > > generation code can be seen in:
> > > > https://github.com/intel/perfmon/pull/56
> > > >
> > > > Hard coded metrics support thresholds, the patches add this ability to
> > > > json metrics so that the hard coded metrics can be removed. Migrate
> > > > remaining hard coded metrics to looking up counters from the
> > > > evlist/aggregation count. Finally, get rid of the saved_value logic
> > > > and thereby look to fix the aggregation issues.
> > > >
> > > > Some related fix ups and code clean ups are included in the changes,
> > > > in particular to aid with the code's readability and to keep topdown
> > > > documentation in sync.
> > >
> > > That is great work but won't have a reasonable time sitting on
> > > linux-next to make it into 6.3.
> > >
> > > I have just applied it locally for the usual set of tests, that I'll
> > > report back here.
> >
> >
> > Ugh. I'm guessing it won't be useful if I point out more things broken
> > with the current workaround, like metrics with --repeat :-/
> >
> > Thanks,
> > Ian
> 
> So currently the flow of patches is:
> 
> 1) initially testing - acme tmp.perf/core
> 2) things staged for next release - acme perf/core (perhaps this
> should be called perf-next)

Yeah, perf-tools-next probably.

> 3) linux wide next release testing - linux-next
> 4) release - linus/master
> 
> I wonder if there should be a perf-next-next branch to work around the
> "sitting time" problem. Otherwise anybody who touches code in these 51
> patches will create a merge conflict. Given the aggregation issues
> we're likely to see changes in this code and so conflicts are likely
> to happen.
> 
> The patch flow with perf-next-next would be:
> 
> 1) initial testing - tmp.perf-next-next
> 2) things acquiring sitting time and where developers work - perf-next-next
> 3) things staged for the next release - perf-next
> 4) as 3 above
> 5) as 4 above
> 
> With linux-next picking up acme perf/core (aka perf-next) daily it
> isn't clear whether we should work off of perf-core or linux-next as
> they are so in sync. This process means we've lost a sitting place for
> developer patches and we're going to feel the pain in terms of merge
> conflicts on the list, difficulty building off of the latest work
> without cherry-picking from the list, etc.

I'll send perf/core to Linus today and then your 51 patches will appear
on perf-tools-next, where we'll do what was done before in perf/core
(remained like that for historical reasons).

I'll make perf/urgent become 'perf-tools', and when the merge window
closes, we turn 'perf-tools-next' into 'perf-tools',

- Arnaldo
 
> Thanks,
> Ian
> 
> > > - Arnaldo
> > >
> > > > Ian Rogers (51):
> > > >   perf tools: Ensure evsel name is initialized
> > > >   perf metrics: Improve variable names
> > > >   perf pmu-events: Remove aggr_mode from pmu_event
> > > >   perf pmu-events: Change aggr_mode to be an enum
> > > >   perf pmu-events: Change deprecated to be a bool
> > > >   perf pmu-events: Change perpkg to be a bool
> > > >   perf expr: Make the online topology accessible globally
> > > >   perf pmu-events: Make the metric_constraint an enum
> > > >   perf pmu-events: Don't '\0' terminate enum values
> > > >   perf vendor events intel: Refresh alderlake events
> > > >   perf vendor events intel: Refresh alderlake-n metrics
> > > >   perf vendor events intel: Refresh broadwell metrics
> > > >   perf vendor events intel: Refresh broadwellde metrics
> > > >   perf vendor events intel: Refresh broadwellx metrics
> > > >   perf vendor events intel: Refresh cascadelakex events
> > > >   perf vendor events intel: Add graniterapids events
> > > >   perf vendor events intel: Refresh haswell metrics
> > > >   perf vendor events intel: Refresh haswellx metrics
> > > >   perf vendor events intel: Refresh icelake events
> > > >   perf vendor events intel: Refresh icelakex metrics
> > > >   perf vendor events intel: Refresh ivybridge metrics
> > > >   perf vendor events intel: Refresh ivytown metrics
> > > >   perf vendor events intel: Refresh jaketown events
> > > >   perf vendor events intel: Refresh knightslanding events
> > > >   perf vendor events intel: Refresh sandybridge events
> > > >   perf vendor events intel: Refresh sapphirerapids events
> > > >   perf vendor events intel: Refresh silvermont events
> > > >   perf vendor events intel: Refresh skylake events
> > > >   perf vendor events intel: Refresh skylakex metrics
> > > >   perf vendor events intel: Refresh tigerlake events
> > > >   perf vendor events intel: Refresh westmereep-dp events
> > > >   perf jevents: Add rand support to metrics
> > > >   perf jevent: Parse metric thresholds
> > > >   perf pmu-events: Test parsing metric thresholds with the fake PMU
> > > >   perf list: Support for printing metric thresholds
> > > >   perf metric: Compute and print threshold values
> > > >   perf expr: More explicit NAN handling
> > > >   perf metric: Add --metric-no-threshold option
> > > >   perf stat: Add TopdownL1 metric as a default if present
> > > >   perf stat: Implement --topdown using json metrics
> > > >   perf stat: Remove topdown event special handling
> > > >   perf doc: Refresh topdown documentation
> > > >   perf stat: Remove hard coded transaction events
> > > >   perf stat: Use metrics for --smi-cost
> > > >   perf stat: Remove perf_stat_evsel_id
> > > >   perf stat: Move enums from header
> > > >   perf stat: Hide runtime_stat
> > > >   perf stat: Add cpu_aggr_map for loop
> > > >   perf metric: Directly use counts rather than saved_value
> > > >   perf stat: Use counts rather than saved_value
> > > >   perf stat: Remove saved_value/runtime_stat
> > > >
> > > >  tools/perf/Documentation/perf-stat.txt        |   27 +-
> > > >  tools/perf/Documentation/topdown.txt          |   70 +-
> > > >  tools/perf/arch/powerpc/util/header.c         |    2 +-
> > > >  tools/perf/arch/x86/util/evlist.c             |    6 +-
> > > >  tools/perf/arch/x86/util/topdown.c            |   78 +-
> > > >  tools/perf/arch/x86/util/topdown.h            |    1 -
> > > >  tools/perf/builtin-list.c                     |   13 +-
> > > >  tools/perf/builtin-script.c                   |    9 +-
> > > >  tools/perf/builtin-stat.c                     |  233 +-
> > > >  .../arch/x86/alderlake/adl-metrics.json       | 3190 ++++++++++-------
> > > >  .../pmu-events/arch/x86/alderlake/cache.json  |   36 +-
> > > >  .../arch/x86/alderlake/floating-point.json    |   27 +
> > > >  .../arch/x86/alderlake/frontend.json          |    9 +
> > > >  .../pmu-events/arch/x86/alderlake/memory.json |    3 +-
> > > >  .../arch/x86/alderlake/pipeline.json          |   14 +-
> > > >  .../arch/x86/alderlake/uncore-other.json      |   28 +-
> > > >  .../arch/x86/alderlaken/adln-metrics.json     |  811 +++--
> > > >  .../arch/x86/broadwell/bdw-metrics.json       | 1439 ++++----
> > > >  .../arch/x86/broadwellde/bdwde-metrics.json   | 1405 ++++----
> > > >  .../arch/x86/broadwellx/bdx-metrics.json      | 1626 +++++----
> > > >  .../arch/x86/broadwellx/uncore-cache.json     |   74 +-
> > > >  .../x86/broadwellx/uncore-interconnect.json   |   64 +-
> > > >  .../arch/x86/broadwellx/uncore-other.json     |    4 +-
> > > >  .../arch/x86/cascadelakex/cache.json          |   24 +-
> > > >  .../arch/x86/cascadelakex/clx-metrics.json    | 2198 ++++++------
> > > >  .../arch/x86/cascadelakex/frontend.json       |    8 +-
> > > >  .../arch/x86/cascadelakex/pipeline.json       |   16 +
> > > >  .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
> > > >  .../arch/x86/cascadelakex/uncore-other.json   |  120 +-
> > > >  .../arch/x86/cascadelakex/uncore-power.json   |    8 +-
> > > >  .../arch/x86/graniterapids/cache.json         |   54 +
> > > >  .../arch/x86/graniterapids/frontend.json      |   10 +
> > > >  .../arch/x86/graniterapids/memory.json        |  174 +
> > > >  .../arch/x86/graniterapids/other.json         |   29 +
> > > >  .../arch/x86/graniterapids/pipeline.json      |  102 +
> > > >  .../x86/graniterapids/virtual-memory.json     |   26 +
> > > >  .../arch/x86/haswell/hsw-metrics.json         | 1220 ++++---
> > > >  .../arch/x86/haswellx/hsx-metrics.json        | 1397 ++++----
> > > >  .../pmu-events/arch/x86/icelake/cache.json    |   16 +
> > > >  .../arch/x86/icelake/floating-point.json      |   31 +
> > > >  .../arch/x86/icelake/icl-metrics.json         | 1932 +++++-----
> > > >  .../pmu-events/arch/x86/icelake/pipeline.json |   23 +-
> > > >  .../arch/x86/icelake/uncore-other.json        |   56 +
> > > >  .../arch/x86/icelakex/icx-metrics.json        | 2153 +++++------
> > > >  .../arch/x86/icelakex/uncore-memory.json      |    2 +-
> > > >  .../arch/x86/icelakex/uncore-other.json       |    4 +-
> > > >  .../arch/x86/ivybridge/ivb-metrics.json       | 1270 ++++---
> > > >  .../arch/x86/ivytown/ivt-metrics.json         | 1311 ++++---
> > > >  .../pmu-events/arch/x86/jaketown/cache.json   |    6 +-
> > > >  .../arch/x86/jaketown/floating-point.json     |    2 +-
> > > >  .../arch/x86/jaketown/frontend.json           |   12 +-
> > > >  .../arch/x86/jaketown/jkt-metrics.json        |  602 ++--
> > > >  .../arch/x86/jaketown/pipeline.json           |    2 +-
> > > >  .../arch/x86/jaketown/uncore-cache.json       |   22 +-
> > > >  .../x86/jaketown/uncore-interconnect.json     |   74 +-
> > > >  .../arch/x86/jaketown/uncore-memory.json      |    4 +-
> > > >  .../arch/x86/jaketown/uncore-other.json       |   22 +-
> > > >  .../arch/x86/jaketown/uncore-power.json       |    8 +-
> > > >  .../arch/x86/knightslanding/cache.json        |   94 +-
> > > >  .../arch/x86/knightslanding/pipeline.json     |    8 +-
> > > >  .../arch/x86/knightslanding/uncore-other.json |    8 +-
> > > >  tools/perf/pmu-events/arch/x86/mapfile.csv    |   29 +-
> > > >  .../arch/x86/sandybridge/cache.json           |    8 +-
> > > >  .../arch/x86/sandybridge/floating-point.json  |    2 +-
> > > >  .../arch/x86/sandybridge/frontend.json        |   12 +-
> > > >  .../arch/x86/sandybridge/pipeline.json        |    2 +-
> > > >  .../arch/x86/sandybridge/snb-metrics.json     |  601 ++--
> > > >  .../arch/x86/sapphirerapids/cache.json        |   24 +-
> > > >  .../x86/sapphirerapids/floating-point.json    |   32 +
> > > >  .../arch/x86/sapphirerapids/frontend.json     |    8 +
> > > >  .../arch/x86/sapphirerapids/pipeline.json     |   19 +-
> > > >  .../arch/x86/sapphirerapids/spr-metrics.json  | 2283 ++++++------
> > > >  .../arch/x86/sapphirerapids/uncore-other.json |   60 +
> > > >  .../arch/x86/silvermont/frontend.json         |    2 +-
> > > >  .../arch/x86/silvermont/pipeline.json         |    2 +-
> > > >  .../pmu-events/arch/x86/skylake/cache.json    |   25 +-
> > > >  .../pmu-events/arch/x86/skylake/frontend.json |    8 +-
> > > >  .../pmu-events/arch/x86/skylake/other.json    |    1 +
> > > >  .../pmu-events/arch/x86/skylake/pipeline.json |   16 +
> > > >  .../arch/x86/skylake/skl-metrics.json         | 1877 ++++++----
> > > >  .../arch/x86/skylake/uncore-other.json        |    1 +
> > > >  .../pmu-events/arch/x86/skylakex/cache.json   |    8 +-
> > > >  .../arch/x86/skylakex/frontend.json           |    8 +-
> > > >  .../arch/x86/skylakex/pipeline.json           |   16 +
> > > >  .../arch/x86/skylakex/skx-metrics.json        | 2097 +++++------
> > > >  .../arch/x86/skylakex/uncore-memory.json      |    2 +-
> > > >  .../arch/x86/skylakex/uncore-other.json       |   96 +-
> > > >  .../arch/x86/skylakex/uncore-power.json       |    6 +-
> > > >  .../arch/x86/tigerlake/floating-point.json    |   31 +
> > > >  .../arch/x86/tigerlake/pipeline.json          |   18 +
> > > >  .../arch/x86/tigerlake/tgl-metrics.json       | 1942 +++++-----
> > > >  .../arch/x86/tigerlake/uncore-other.json      |   28 +-
> > > >  .../arch/x86/westmereep-dp/cache.json         |    2 +-
> > > >  .../x86/westmereep-dp/virtual-memory.json     |    2 +-
> > > >  tools/perf/pmu-events/jevents.py              |   58 +-
> > > >  tools/perf/pmu-events/metric.py               |    8 +-
> > > >  tools/perf/pmu-events/pmu-events.h            |   35 +-
> > > >  tools/perf/tests/expand-cgroup.c              |    3 +-
> > > >  tools/perf/tests/expr.c                       |    7 +-
> > > >  tools/perf/tests/parse-metric.c               |   21 +-
> > > >  tools/perf/tests/pmu-events.c                 |   49 +-
> > > >  tools/perf/util/cpumap.h                      |    3 +
> > > >  tools/perf/util/cputopo.c                     |   14 +
> > > >  tools/perf/util/cputopo.h                     |    5 +
> > > >  tools/perf/util/evsel.h                       |    2 +-
> > > >  tools/perf/util/expr.c                        |   16 +-
> > > >  tools/perf/util/expr.y                        |   12 +-
> > > >  tools/perf/util/metricgroup.c                 |  178 +-
> > > >  tools/perf/util/metricgroup.h                 |    5 +-
> > > >  tools/perf/util/pmu.c                         |   17 +-
> > > >  tools/perf/util/print-events.h                |    1 +
> > > >  tools/perf/util/smt.c                         |   11 +-
> > > >  tools/perf/util/smt.h                         |   12 +-
> > > >  tools/perf/util/stat-display.c                |  117 +-
> > > >  tools/perf/util/stat-shadow.c                 | 1287 ++-----
> > > >  tools/perf/util/stat.c                        |   74 -
> > > >  tools/perf/util/stat.h                        |   96 +-
> > > >  tools/perf/util/synthetic-events.c            |    2 +-
> > > >  tools/perf/util/topdown.c                     |   68 +-
> > > >  tools/perf/util/topdown.h                     |   11 +-
> > > >  120 files changed, 18025 insertions(+), 15590 deletions(-)
> > > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/cache.json
> > > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
> > > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/memory.json
> > > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/other.json
> > > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
> > > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/virtual-memory.json
> > > >
> > > > --
> > > > 2.39.2.637.g21b0678d19-goog
> > > >
> > >
> > > --
> > >
> > > - Arnaldo

-- 

- Arnaldo
