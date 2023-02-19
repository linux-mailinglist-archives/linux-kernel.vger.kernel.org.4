Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577C769C141
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 16:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBSPnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 10:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjBSPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 10:43:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6300BDBD9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 07:43:35 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p18-20020a05600c359200b003dc57ea0dfeso594938wmq.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjOvkhvojmtF53IY21K4y6YcrAFM/XWfZzrTRIwfMes=;
        b=aGWeNccT/tZp877FsdqXebCR3eniCqghwTsbDGpnfiGBKY22fg+bC+XIdEBtPPf9I/
         wMBoe3uWIx8W0JyVKCaMl23L7QwKng7No+sCq7h97z7Kj0hPDmMLDqyM2NEz6rj0GyaL
         05RZLxvaTdDL0ZUGtMC8oJtlxOs9IS1M9K/2XAZBdUJxOusEmpBPV+DL3yDoNis6GRys
         SfDpltIHDakbh3ALLNgaBCWkHeLvH4k/++zXB0sfW1NVtlZtnJUP8LlvmSpPm6+4jUOZ
         bgX20hpLwx0FuiR3WmF7FG/LrDsosnfvDRQevBUibIL9vlPKbFw4QGIy4mFpDkAU3cqS
         lc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjOvkhvojmtF53IY21K4y6YcrAFM/XWfZzrTRIwfMes=;
        b=hhFhvOK+Ra3AiFE/6bTdLfhddZ/0BH0N/2XOnoPw+b1LHsmuWffeizacIh8eTCfq7b
         v/OOLxLjqF35zUATngfrpF9LZVcR9nSFRYX3Ll1LmI67Kj930Pu1Qgr79o0s+xQqQElt
         uvuLgPHJjVFYsbxc+F3k38ijDSD59EkALRUF7ICbf7xdcaSuL0x6pHD+4hdPoQAV4FqU
         s7aihA2K4D5+SoA615qq61Gh3qcYdsMoS86rMvjJnBxUZPfyZ0qnqVP5rFBp/T78DwC6
         V0PEjBwd3p8u1XBYttz9a3zZORSFNSet2HdQ1vYLIMX3Q47apOiY4okeBgNIYRAeYiGs
         wUvw==
X-Gm-Message-State: AO0yUKVEGh9XwTCWyUmlGqUFwJud4UA73mpXhhd+yFwHW+W2uMQcVgxN
        T646om08csQQww9115Fw+SIJffx+WNdd8CDXmY3Ohw==
X-Google-Smtp-Source: AK7set/zyN0OMAIFL6e7QseAoRUqiBhoejUey+m84Zwk96A40DPNbXd961PsFC5rRg67PD90hGmlVcgPE8LdcY1hqIw=
X-Received: by 2002:a05:600c:1c95:b0:3db:1d5e:699 with SMTP id
 k21-20020a05600c1c9500b003db1d5e0699mr197150wms.195.1676821413634; Sun, 19
 Feb 2023 07:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com> <Y/IFNyI9JcChoR2p@kernel.org>
In-Reply-To: <Y/IFNyI9JcChoR2p@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 19 Feb 2023 07:43:20 -0800
Message-ID: <CAP-5=fWzydsYNKPBv+wCh4M9QaRbk5NiJOUDsjbjPdPjFWQ82g@mail.gmail.com>
Subject: Re: [PATCH v1 00/51] shadow metric clean up and improvements
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Caleb Biggers <caleb.biggers@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023, 3:17 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Sun, Feb 19, 2023 at 01:27:57AM -0800, Ian Rogers escreveu:
> > Recently the shadow stat metrics broke due to repeated aggregation and
> > a quick fix was applied:
> > https://lore.kernel.org/lkml/20230209064447.83733-1-irogers@google.com/
> > This is the longer fix but one that comes with some extras. To avoid
> > fixing issues for hard coded metrics, the topdown, SMI cost and
> > transaction flags are moved into json metrics. A side effect of this
> > is that TopdownL1 metrics will now be displayed when supported, if no
> > "perf stat" events are specified.
> >
> > Another fix included here is for event grouping as raised in:
> > https://lore.kernel.org/lkml/CA+icZUU_ew7pzWJJZLbj1xsU6MQTPrj8tkFfDhNdTDRQfGUBMQ@mail.gmail.com/
> > Metrics are now tagged with NMI and SMT flags, meaning that the events
> > shouldn't be grouped if the NMI watchdog is enabled or SMT is enabled.
> >
> > Given the two issues, the metrics are re-generated and the patches
> > also include the latest Intel vendor events. The changes to the metric
> > generation code can be seen in:
> > https://github.com/intel/perfmon/pull/56
> >
> > Hard coded metrics support thresholds, the patches add this ability to
> > json metrics so that the hard coded metrics can be removed. Migrate
> > remaining hard coded metrics to looking up counters from the
> > evlist/aggregation count. Finally, get rid of the saved_value logic
> > and thereby look to fix the aggregation issues.
> >
> > Some related fix ups and code clean ups are included in the changes,
> > in particular to aid with the code's readability and to keep topdown
> > documentation in sync.
>
> That is great work but won't have a reasonable time sitting on
> linux-next to make it into 6.3.
>
> I have just applied it locally for the usual set of tests, that I'll
> report back here.


Ugh. I'm guessing it won't be useful if I point out more things broken
with the current workaround, like metrics with --repeat :-/

Thanks,
Ian

> - Arnaldo
>
> > Ian Rogers (51):
> >   perf tools: Ensure evsel name is initialized
> >   perf metrics: Improve variable names
> >   perf pmu-events: Remove aggr_mode from pmu_event
> >   perf pmu-events: Change aggr_mode to be an enum
> >   perf pmu-events: Change deprecated to be a bool
> >   perf pmu-events: Change perpkg to be a bool
> >   perf expr: Make the online topology accessible globally
> >   perf pmu-events: Make the metric_constraint an enum
> >   perf pmu-events: Don't '\0' terminate enum values
> >   perf vendor events intel: Refresh alderlake events
> >   perf vendor events intel: Refresh alderlake-n metrics
> >   perf vendor events intel: Refresh broadwell metrics
> >   perf vendor events intel: Refresh broadwellde metrics
> >   perf vendor events intel: Refresh broadwellx metrics
> >   perf vendor events intel: Refresh cascadelakex events
> >   perf vendor events intel: Add graniterapids events
> >   perf vendor events intel: Refresh haswell metrics
> >   perf vendor events intel: Refresh haswellx metrics
> >   perf vendor events intel: Refresh icelake events
> >   perf vendor events intel: Refresh icelakex metrics
> >   perf vendor events intel: Refresh ivybridge metrics
> >   perf vendor events intel: Refresh ivytown metrics
> >   perf vendor events intel: Refresh jaketown events
> >   perf vendor events intel: Refresh knightslanding events
> >   perf vendor events intel: Refresh sandybridge events
> >   perf vendor events intel: Refresh sapphirerapids events
> >   perf vendor events intel: Refresh silvermont events
> >   perf vendor events intel: Refresh skylake events
> >   perf vendor events intel: Refresh skylakex metrics
> >   perf vendor events intel: Refresh tigerlake events
> >   perf vendor events intel: Refresh westmereep-dp events
> >   perf jevents: Add rand support to metrics
> >   perf jevent: Parse metric thresholds
> >   perf pmu-events: Test parsing metric thresholds with the fake PMU
> >   perf list: Support for printing metric thresholds
> >   perf metric: Compute and print threshold values
> >   perf expr: More explicit NAN handling
> >   perf metric: Add --metric-no-threshold option
> >   perf stat: Add TopdownL1 metric as a default if present
> >   perf stat: Implement --topdown using json metrics
> >   perf stat: Remove topdown event special handling
> >   perf doc: Refresh topdown documentation
> >   perf stat: Remove hard coded transaction events
> >   perf stat: Use metrics for --smi-cost
> >   perf stat: Remove perf_stat_evsel_id
> >   perf stat: Move enums from header
> >   perf stat: Hide runtime_stat
> >   perf stat: Add cpu_aggr_map for loop
> >   perf metric: Directly use counts rather than saved_value
> >   perf stat: Use counts rather than saved_value
> >   perf stat: Remove saved_value/runtime_stat
> >
> >  tools/perf/Documentation/perf-stat.txt        |   27 +-
> >  tools/perf/Documentation/topdown.txt          |   70 +-
> >  tools/perf/arch/powerpc/util/header.c         |    2 +-
> >  tools/perf/arch/x86/util/evlist.c             |    6 +-
> >  tools/perf/arch/x86/util/topdown.c            |   78 +-
> >  tools/perf/arch/x86/util/topdown.h            |    1 -
> >  tools/perf/builtin-list.c                     |   13 +-
> >  tools/perf/builtin-script.c                   |    9 +-
> >  tools/perf/builtin-stat.c                     |  233 +-
> >  .../arch/x86/alderlake/adl-metrics.json       | 3190 ++++++++++-------
> >  .../pmu-events/arch/x86/alderlake/cache.json  |   36 +-
> >  .../arch/x86/alderlake/floating-point.json    |   27 +
> >  .../arch/x86/alderlake/frontend.json          |    9 +
> >  .../pmu-events/arch/x86/alderlake/memory.json |    3 +-
> >  .../arch/x86/alderlake/pipeline.json          |   14 +-
> >  .../arch/x86/alderlake/uncore-other.json      |   28 +-
> >  .../arch/x86/alderlaken/adln-metrics.json     |  811 +++--
> >  .../arch/x86/broadwell/bdw-metrics.json       | 1439 ++++----
> >  .../arch/x86/broadwellde/bdwde-metrics.json   | 1405 ++++----
> >  .../arch/x86/broadwellx/bdx-metrics.json      | 1626 +++++----
> >  .../arch/x86/broadwellx/uncore-cache.json     |   74 +-
> >  .../x86/broadwellx/uncore-interconnect.json   |   64 +-
> >  .../arch/x86/broadwellx/uncore-other.json     |    4 +-
> >  .../arch/x86/cascadelakex/cache.json          |   24 +-
> >  .../arch/x86/cascadelakex/clx-metrics.json    | 2198 ++++++------
> >  .../arch/x86/cascadelakex/frontend.json       |    8 +-
> >  .../arch/x86/cascadelakex/pipeline.json       |   16 +
> >  .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
> >  .../arch/x86/cascadelakex/uncore-other.json   |  120 +-
> >  .../arch/x86/cascadelakex/uncore-power.json   |    8 +-
> >  .../arch/x86/graniterapids/cache.json         |   54 +
> >  .../arch/x86/graniterapids/frontend.json      |   10 +
> >  .../arch/x86/graniterapids/memory.json        |  174 +
> >  .../arch/x86/graniterapids/other.json         |   29 +
> >  .../arch/x86/graniterapids/pipeline.json      |  102 +
> >  .../x86/graniterapids/virtual-memory.json     |   26 +
> >  .../arch/x86/haswell/hsw-metrics.json         | 1220 ++++---
> >  .../arch/x86/haswellx/hsx-metrics.json        | 1397 ++++----
> >  .../pmu-events/arch/x86/icelake/cache.json    |   16 +
> >  .../arch/x86/icelake/floating-point.json      |   31 +
> >  .../arch/x86/icelake/icl-metrics.json         | 1932 +++++-----
> >  .../pmu-events/arch/x86/icelake/pipeline.json |   23 +-
> >  .../arch/x86/icelake/uncore-other.json        |   56 +
> >  .../arch/x86/icelakex/icx-metrics.json        | 2153 +++++------
> >  .../arch/x86/icelakex/uncore-memory.json      |    2 +-
> >  .../arch/x86/icelakex/uncore-other.json       |    4 +-
> >  .../arch/x86/ivybridge/ivb-metrics.json       | 1270 ++++---
> >  .../arch/x86/ivytown/ivt-metrics.json         | 1311 ++++---
> >  .../pmu-events/arch/x86/jaketown/cache.json   |    6 +-
> >  .../arch/x86/jaketown/floating-point.json     |    2 +-
> >  .../arch/x86/jaketown/frontend.json           |   12 +-
> >  .../arch/x86/jaketown/jkt-metrics.json        |  602 ++--
> >  .../arch/x86/jaketown/pipeline.json           |    2 +-
> >  .../arch/x86/jaketown/uncore-cache.json       |   22 +-
> >  .../x86/jaketown/uncore-interconnect.json     |   74 +-
> >  .../arch/x86/jaketown/uncore-memory.json      |    4 +-
> >  .../arch/x86/jaketown/uncore-other.json       |   22 +-
> >  .../arch/x86/jaketown/uncore-power.json       |    8 +-
> >  .../arch/x86/knightslanding/cache.json        |   94 +-
> >  .../arch/x86/knightslanding/pipeline.json     |    8 +-
> >  .../arch/x86/knightslanding/uncore-other.json |    8 +-
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |   29 +-
> >  .../arch/x86/sandybridge/cache.json           |    8 +-
> >  .../arch/x86/sandybridge/floating-point.json  |    2 +-
> >  .../arch/x86/sandybridge/frontend.json        |   12 +-
> >  .../arch/x86/sandybridge/pipeline.json        |    2 +-
> >  .../arch/x86/sandybridge/snb-metrics.json     |  601 ++--
> >  .../arch/x86/sapphirerapids/cache.json        |   24 +-
> >  .../x86/sapphirerapids/floating-point.json    |   32 +
> >  .../arch/x86/sapphirerapids/frontend.json     |    8 +
> >  .../arch/x86/sapphirerapids/pipeline.json     |   19 +-
> >  .../arch/x86/sapphirerapids/spr-metrics.json  | 2283 ++++++------
> >  .../arch/x86/sapphirerapids/uncore-other.json |   60 +
> >  .../arch/x86/silvermont/frontend.json         |    2 +-
> >  .../arch/x86/silvermont/pipeline.json         |    2 +-
> >  .../pmu-events/arch/x86/skylake/cache.json    |   25 +-
> >  .../pmu-events/arch/x86/skylake/frontend.json |    8 +-
> >  .../pmu-events/arch/x86/skylake/other.json    |    1 +
> >  .../pmu-events/arch/x86/skylake/pipeline.json |   16 +
> >  .../arch/x86/skylake/skl-metrics.json         | 1877 ++++++----
> >  .../arch/x86/skylake/uncore-other.json        |    1 +
> >  .../pmu-events/arch/x86/skylakex/cache.json   |    8 +-
> >  .../arch/x86/skylakex/frontend.json           |    8 +-
> >  .../arch/x86/skylakex/pipeline.json           |   16 +
> >  .../arch/x86/skylakex/skx-metrics.json        | 2097 +++++------
> >  .../arch/x86/skylakex/uncore-memory.json      |    2 +-
> >  .../arch/x86/skylakex/uncore-other.json       |   96 +-
> >  .../arch/x86/skylakex/uncore-power.json       |    6 +-
> >  .../arch/x86/tigerlake/floating-point.json    |   31 +
> >  .../arch/x86/tigerlake/pipeline.json          |   18 +
> >  .../arch/x86/tigerlake/tgl-metrics.json       | 1942 +++++-----
> >  .../arch/x86/tigerlake/uncore-other.json      |   28 +-
> >  .../arch/x86/westmereep-dp/cache.json         |    2 +-
> >  .../x86/westmereep-dp/virtual-memory.json     |    2 +-
> >  tools/perf/pmu-events/jevents.py              |   58 +-
> >  tools/perf/pmu-events/metric.py               |    8 +-
> >  tools/perf/pmu-events/pmu-events.h            |   35 +-
> >  tools/perf/tests/expand-cgroup.c              |    3 +-
> >  tools/perf/tests/expr.c                       |    7 +-
> >  tools/perf/tests/parse-metric.c               |   21 +-
> >  tools/perf/tests/pmu-events.c                 |   49 +-
> >  tools/perf/util/cpumap.h                      |    3 +
> >  tools/perf/util/cputopo.c                     |   14 +
> >  tools/perf/util/cputopo.h                     |    5 +
> >  tools/perf/util/evsel.h                       |    2 +-
> >  tools/perf/util/expr.c                        |   16 +-
> >  tools/perf/util/expr.y                        |   12 +-
> >  tools/perf/util/metricgroup.c                 |  178 +-
> >  tools/perf/util/metricgroup.h                 |    5 +-
> >  tools/perf/util/pmu.c                         |   17 +-
> >  tools/perf/util/print-events.h                |    1 +
> >  tools/perf/util/smt.c                         |   11 +-
> >  tools/perf/util/smt.h                         |   12 +-
> >  tools/perf/util/stat-display.c                |  117 +-
> >  tools/perf/util/stat-shadow.c                 | 1287 ++-----
> >  tools/perf/util/stat.c                        |   74 -
> >  tools/perf/util/stat.h                        |   96 +-
> >  tools/perf/util/synthetic-events.c            |    2 +-
> >  tools/perf/util/topdown.c                     |   68 +-
> >  tools/perf/util/topdown.h                     |   11 +-
> >  120 files changed, 18025 insertions(+), 15590 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/cache.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/memory.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/other.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/virtual-memory.json
> >
> > --
> > 2.39.2.637.g21b0678d19-goog
> >
>
> --
>
> - Arnaldo
