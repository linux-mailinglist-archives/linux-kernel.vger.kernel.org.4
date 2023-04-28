Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1123A6F127E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345544AbjD1Hi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345537AbjD1Hi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:38:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1B19A0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:38:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f6bef3d4aso18071805276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667503; x=1685259503;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AdC7SCZdjFqy67oOFEch5p4Dr4mhhMxGIVwwNcMHgTw=;
        b=JOBvuzIrOnr/ThE7fE0ycdONsM2E4BczMUuiuAMgEnST84XB3W/6NFQtGM1TN52uoJ
         wBYyuR8zFPILhMCScxQxFtEec84szFlrjwDkIm6JQ5WPmmNko+Q/oJ9nN6kLBcThzm1f
         3h/fJzT/ld4mudbLbd60P/wfv9s8XrUKSamOl4R6YNyt+DPpqZwZLiVJFonQqdcilQVL
         FiKuDLU6eR7lGMengWWPf7QU1SxttrnfsE22+wbdw3MlDylGc7hue3fiV0qF4tmrM1mU
         diRPyKQsnaDFa/ri7pHjgnD1OClGUazl1kdvrtR8meQiaonoycJini4GAW06IkTek4w4
         1QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667503; x=1685259503;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdC7SCZdjFqy67oOFEch5p4Dr4mhhMxGIVwwNcMHgTw=;
        b=LiQtWqOmVGSuLkd525uaQa/lQiRkj6NNvnXebHq8qknxTdhKjsr+qwQiUN9W/eAf8m
         cP8gOC0X3TreldHhdywvhbl36FwW9eEihrMb2qPhyu+3+C5BXpdyCWyz8iKaEVWappR/
         t3ognpr99E3N4WQDUjCEfQEAG16m8fE7hyn859jZigoIckl/k3K1D+f3F2guKX6ehHQx
         WZBpyIPByGzWWIaXLHMMbm2dF/rxdP3VYDLqAGJBhLIhxxJKKfQJVF6z1+RIPhttleAV
         lC/ujHpGuSPWz7t3s1i1vKmSv703CSbmTN4pnXOuG5HTJrqc7th2t082bEoFgMpq+IWL
         rp3g==
X-Gm-Message-State: AC+VfDwb9rbuZSgchxReAFVt24nD4qqFOqqSg8+mGk+9cCPAxJC3TCRM
        owOQSSOz28abjw0l6cFjggKIEsqRm3lb
X-Google-Smtp-Source: ACHHUZ6pQ9cHpCOw4MdKWHbpczLqr6Do0sK02ipKRo/58dffXizC+Nt+C5Zn3u6DSNGePupdbd4HSydVcBbm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a25:ada7:0:b0:b95:8a6b:da93 with SMTP id
 z39-20020a25ada7000000b00b958a6bda93mr2255931ybi.9.1682667502683; Fri, 28 Apr
 2023 00:38:22 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:26 -0700
Message-Id: <20230428073809.1803624-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 00/43] Fix perf on Intel hybrid CPUs
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TL;DR: hybrid doesn't crash, json metrics work on hybrid on both PMUs
or individually, event parsing doesn't always scan all PMUs, more and
new tests that also run without hybrid, less code.

The first 3 patches are proposed to address Linux 6.4 issues with the
remainder to be the basis for 6.5. The first patch is a 1 liner, plus
comment, workaround for Intel hybrid platforms crashing perf stat when
running with no events/metrics. The second patch works around an issue
with platforms like Skylake where certain events fail to open at
higher paranoia levels even if kernel and hypervisor profiling is
disabled. Events are marked as skippable and not placed in the output,
while remaining events are and metrics are computed. The third patch
makes it so that TopdownL1 and TopdownL2 json metric groups don't
group events on Intel, this is done via a new json flag. Adding the
json flag in each of the json files is two-thirds of the 300 lines of
these patches. Patch 42 removes the disabling of TopdownL1 on hybrid
as the underlying problems are fixed. The json file updates are
created with the usual script updated in:
https://github.com/intel/perfmon/pull/73

The next 5 patches avoid grouping events for metrics where is could
never succeed and were previously posted as:
"perf vendor events intel: Add xxx metric constraints"
https://lore.kernel.org/all/20230419005423.343862-1-irogers@google.com/

Next are some general and test improvements.

Next event parsing is rewritten to not scan all PMUs for the benefit
of raw and legacy cache parsing, instead these are handled by the
lexer and a new term type. This ultimately removes the need for the
event parser for hybrid to be recursive as legacy cache can be just a
term. Tests are re-enabled for events with hyphens, so AMD's
branch-brs event is now parsable.

The cputype option is made a generic pmu filter flag and is tested
even on non-hybrid systems.

The final patches address specific json metric issues on hybrid, in
both the json metrics and the metric code.

The patches add slightly more code than they remove, in areas like
better json metric constraints and tests, but in the core util code,
the removal of hybrid is a net reduction:
 20 files changed, 641 insertions(+), 960 deletions(-)

Sample output is contained in the v1 patch set:
https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/

Tested on Tigerlake, Skylake and Alderlake CPUs.

The v2 patch set:
 - restructures the 3 Linux 6.4 patches first;
 - makes it so that is_event_supported isn't called during core event parsing;
 - displays skippable 0 count events that were enabled;
 - addresses output formatting review comments;
 - addresses some test issues and an uninitialized variable use in strchr;
 - addresses checkpatch.pl reported issues;
 - adds reviewed-by to some patches.

Ian Rogers (43):
  perf stat: Disable TopdownL1 on hybrid
  perf stat: Introduce skippable evsels
  perf metric: Json flag to not group events if gathering a metric group
  perf vendor events intel: Add alderlake metric constraints
  perf vendor events intel: Add icelake metric constraints
  perf vendor events intel: Add icelakex metric constraints
  perf vendor events intel: Add sapphirerapids metric constraints
  perf vendor events intel: Add tigerlake metric constraints
  perf stat: Avoid segv on counter->name
  perf test: Test more sysfs events
  perf test: Use valid for PMU tests
  perf test: Mask config then test
  perf test: Test more with config_cache
  perf test: Roundtrip name, don't assume 1 event per name
  perf parse-events: Set attr.type to PMU type early
  perf parse-events: Set pmu_name whenever a pmu is given
  perf print-events: Avoid unnecessary strlist
  perf parse-events: Avoid scanning PMUs before parsing
  perf evsel: Modify group pmu name for software events
  perf test: Move x86 hybrid tests to arch/x86
  perf test x86 hybrid: Update test expectations
  perf parse-events: Support PMUs for legacy cache events
  perf parse-events: Wildcard legacy cache events
  perf print-events: Print legacy cache events for each PMU
  perf parse-events: Support wildcards on raw events
  perf parse-events: Remove now unused hybrid logic
  perf parse-events: Minor type safety cleanup
  perf parse-events: Add pmu filter
  perf stat: Make cputype filter generic
  perf test: Add cputype testing to perf stat
  perf test: Fix parse-events tests for >1 core PMU
  perf parse-events: Support hardware events as terms
  perf parse-events: Avoid error when assigning a term
  perf parse-events: Avoid error when assigning a legacy cache term
  perf parse-events: Don't auto merge hybrid wildcard events
  perf parse-events: Don't reorder atom cpu events
  perf metrics: Be PMU specific for referenced metrics.
  perf stat: Command line PMU metric filtering
  perf vendor events intel: Correct alderlake metrics
  perf jevents: Don't rewrite metrics across PMUs
  perf metrics: Be PMU specific in event match
  perf stat: Don't disable TopdownL1 metric on hybrid
  perf parse-events: Reduce scope of is_event_supported

 tools/perf/arch/x86/include/arch-tests.h      |   1 +
 tools/perf/arch/x86/tests/Build               |   1 +
 tools/perf/arch/x86/tests/arch-tests.c        |  10 +
 tools/perf/arch/x86/tests/hybrid.c            | 275 ++++++
 tools/perf/arch/x86/util/evlist.c             |   4 +-
 tools/perf/builtin-list.c                     |  19 +-
 tools/perf/builtin-record.c                   |  13 +-
 tools/perf/builtin-stat.c                     |  73 +-
 tools/perf/builtin-top.c                      |   5 +-
 tools/perf/builtin-trace.c                    |   5 +-
 .../arch/x86/alderlake/adl-metrics.json       | 275 +++---
 .../arch/x86/alderlaken/adln-metrics.json     |  20 +-
 .../arch/x86/broadwell/bdw-metrics.json       |  12 +
 .../arch/x86/broadwellde/bdwde-metrics.json   |  12 +
 .../arch/x86/broadwellx/bdx-metrics.json      |  12 +
 .../arch/x86/cascadelakex/clx-metrics.json    |  12 +
 .../arch/x86/haswell/hsw-metrics.json         |  12 +
 .../arch/x86/haswellx/hsx-metrics.json        |  12 +
 .../arch/x86/icelake/icl-metrics.json         |  23 +
 .../arch/x86/icelakex/icx-metrics.json        |  23 +
 .../arch/x86/ivybridge/ivb-metrics.json       |  12 +
 .../arch/x86/ivytown/ivt-metrics.json         |  12 +
 .../arch/x86/jaketown/jkt-metrics.json        |  12 +
 .../arch/x86/sandybridge/snb-metrics.json     |  12 +
 .../arch/x86/sapphirerapids/spr-metrics.json  |  23 +
 .../arch/x86/skylake/skl-metrics.json         |  12 +
 .../arch/x86/skylakex/skx-metrics.json        |  12 +
 .../arch/x86/tigerlake/tgl-metrics.json       |  23 +
 tools/perf/pmu-events/jevents.py              |  10 +-
 tools/perf/pmu-events/metric.py               |  28 +-
 tools/perf/pmu-events/metric_test.py          |   6 +-
 tools/perf/pmu-events/pmu-events.h            |   2 +
 tools/perf/tests/evsel-roundtrip-name.c       | 119 +--
 tools/perf/tests/parse-events.c               | 836 +++++++++---------
 tools/perf/tests/pmu-events.c                 |  12 +-
 tools/perf/tests/shell/stat.sh                |  44 +
 tools/perf/util/Build                         |   1 -
 tools/perf/util/evlist.h                      |   1 -
 tools/perf/util/evsel.c                       |  30 +-
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/metricgroup.c                 | 111 ++-
 tools/perf/util/metricgroup.h                 |   3 +-
 tools/perf/util/parse-events-hybrid.c         | 214 -----
 tools/perf/util/parse-events-hybrid.h         |  25 -
 tools/perf/util/parse-events.c                | 697 ++++++---------
 tools/perf/util/parse-events.h                |  63 +-
 tools/perf/util/parse-events.l                | 108 +--
 tools/perf/util/parse-events.y                | 222 ++---
 tools/perf/util/pmu-hybrid.c                  |  20 -
 tools/perf/util/pmu-hybrid.h                  |   1 -
 tools/perf/util/pmu.c                         |  16 +-
 tools/perf/util/pmu.h                         |   3 +
 tools/perf/util/pmus.c                        |  25 +-
 tools/perf/util/pmus.h                        |   3 +
 tools/perf/util/print-events.c                | 124 ++-
 tools/perf/util/stat-display.c                |  13 +-
 56 files changed, 2000 insertions(+), 1675 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/hybrid.c
 delete mode 100644 tools/perf/util/parse-events-hybrid.c
 delete mode 100644 tools/perf/util/parse-events-hybrid.h

-- 
2.40.1.495.gc816e09b53d-goog

