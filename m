Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBBB6F4CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjEBWjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEBWjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:39:09 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52AD10E3
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:39:07 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64115e69e1eso452702b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067147; x=1685659147;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9UOSWZ76A+rTHx87Gk0jmcSron1KdVuHfDDQkzmUxVU=;
        b=Z7n+F4mp7TjJC0Dl5rErNTbta5iR6eVFA/b5Y0PWV/PDbkjMghOqW46bWFvTwRl3wg
         vgxx9+V8OfOVU9u9xnxmrt4USqq07ISvRqvN2fmwu9lhd8ZbYUDClZJjobsdW0mwaPVB
         8e7bLMwQXmSymdhwMCpDVCy0DPM8WJvvAb45fOX5DpawkNGkqt/CgTwCqQb8nSKQz+ju
         3hRmH/0nmNO2rh+lOyybJ9iPoDGSCqsyrpFqWsyAyAz6QYqUb6w3i2Nzw4MdeI2R4TrU
         O4tK5PaOZ9GfGWNDHLC0gkt93q+PdKJpxyFV4+uLbRizeG5V4AGGoDju3BUg3LPFeLU1
         1pIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067147; x=1685659147;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9UOSWZ76A+rTHx87Gk0jmcSron1KdVuHfDDQkzmUxVU=;
        b=H3cAIZAuW/XQHCmsY8fpvT4ijIODD0e29KVqAAnf7cEe+P3ULqQn6HiR5B9dMcwZsM
         Vzwge6gZnN7Eq0dlyjWWCpv3h+zIZgvsu6o0wCuXUepbHcVER99UII/d4pBjqwmJ+dJ6
         bVoni4hOc/Hs1JI2OYUXYgVBwH9Ufd02g9qx4yalaGkkCrjfPIizmUFcb4kQpGoSrfIA
         NCJAuvB0sBQSF9Ndy8sr8DyHDmh2JXtQ9OBg3dCCCDLp562XofC/TZGWzfUHX1Qwr3G3
         xPXOPuHD2+Codw5AnhSDZgbMdvO15XEwRinYNlnUc6Kc+/0d95Mdz415nSXpj1B9WuTZ
         CF2Q==
X-Gm-Message-State: AC+VfDywdST0sdulMfnJWifexXTiWfM8vFuRz2w69cVlB0ZdJMf+q5vu
        VXZmEuOGq5B6+pqFHmjndtqg7/Jr6w+m
X-Google-Smtp-Source: ACHHUZ5OV2MJq/s0c6/9Vs+fO4FhywgOc7b+PCEFOi4BcW8Ui2D0waHDHQO/+r3VzHfXXuJB8T4t+4NB5pNF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a17:903:40c2:b0:1a6:8a07:960a with SMTP id
 t2-20020a17090340c200b001a68a07960amr24007pld.0.1683067147112; Tue, 02 May
 2023 15:39:07 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:07 -0700
Message-Id: <20230502223851.2234828-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 00/44] Fix perf on Intel hybrid CPUs
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TL;DR: hybrid doesn't crash, json metrics work on hybrid on both PMUs
or individually, event parsing doesn't always scan all PMUs, more and
new tests that also run without hybrid, less code.

The first 4 patches are aimed at Linux 6.4 to address issues raised,
in particular by Kan, on the existing perf stat behavior with json
metrics. They avoid duplicated events by removing groups. They don't
hide events and metrics to make event multiplexing obvious. They avoid
terminating perf when paranoia is higher due to certain events that
always fail. They avoid rearranging events by PMUs when the events
aren't in a group.

The next 5 patches avoid grouping events for metrics where they could
never succeed and were previously posted as:
"perf vendor events intel: Add xxx metric constraints"
https://lore.kernel.org/all/20230419005423.343862-1-irogers@google.com/
In general the generated json is coming from:
https://github.com/intel/perfmon/pull/73

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
 22 files changed, 711 insertions(+), 1016 deletions(-)

Sample output is contained in the v1 patch set:
https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/

Tested on Tigerlake, Skylake and Alderlake CPUs.

The v4 patch set:
 - rebase, 1 of the Linux 6.4 recommended patches are merged leaving:
   1) perf metric: Change divide by zero and !support events behavior
   2) perf stat: Introduce skippable evsels
   3) perf metric: Json flag to not group events if gathering a metric group
   4) perf parse-events: Don't reorder ungrouped events by pmu
   whose diffstat is:
    30 files changed, 326 insertions(+), 33 deletions(-)
   but without the vendor event updates (the tend to be large as they
   repeat something per architecture per metric) is just:
    10 files changed, 90 insertions(+), 32 deletions(-)
 - Address review comments from Ravi Bangoria <ravi.bangoria@amd.com>
   that are only in the patches targeting Linux 6.5.

The v3 patch set:
 - for Linux 6.4 the first 5 patches are recommended:
   - changes skippable evsels to always print in case short running
     benchmarks meet the 0 enable and 0 count condition (suggested by
     Stephane).
   - changes metrics to show "nan" so that it is more obvious they
     couldn't be computed (suggested by Stephane).
   - fixes a reordering issue that reordered events that lacked a
     group, especially when the core PMU isn't "cpu".
 - for Linux 6.5 added extra hybrid type tests in the x86 hybrid test
   as suggested by Kan.
 - note, the patches aren't rebased against the tmp.perf-tools branch
   meaning patches 1 and 11 should be dropped there.
 
The v2 patch set:
 - restructures the 3 Linux 6.4 patches first;
 - makes it so that is_event_supported isn't called during core event parsing;
 - displays skippable 0 count events that were enabled;
 - addresses output formatting review comments;
 - addresses some test issues and an uninitialized variable use in strchr;
 - addresses checkpatch.pl reported issues;
 - adds reviewed-by to some patches.

Ian Rogers (44):
  perf metric: Change divide by zero and !support events behavior
  perf stat: Introduce skippable evsels
  perf metric: Json flag to not group events if gathering a metric group
  perf parse-events: Don't reorder ungrouped events by pmu
  perf vendor events intel: Add alderlake metric constraints
  perf vendor events intel: Add icelake metric constraints
  perf vendor events intel: Add icelakex metric constraints
  perf vendor events intel: Add sapphirerapids metric constraints
  perf vendor events intel: Add tigerlake metric constraints
  perf test: Test more sysfs events
  perf test: Use valid for PMU tests
  perf test: Mask configs with extended types then test
  perf test: Test more with config_cache
  perf test: Roundtrip name, don't assume 1 event per name
  perf parse-events: Set attr.type to PMU type early
  perf parse-events: Set pmu_name whenever a pmu is given
  perf print-events: Avoid unnecessary strlist
  perf parse-events: Avoid scanning PMUs before parsing
  perf evsel: Modify group pmu name for software events
  perf test: Move x86 hybrid tests to arch/x86
  perf test x86 hybrid: Update test expectations
  perf test x86 hybrid: Add hybrid extended type checks
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
 tools/perf/arch/x86/tests/hybrid.c            | 287 ++++++
 tools/perf/arch/x86/util/evlist.c             |   4 +-
 tools/perf/builtin-list.c                     |  21 +-
 tools/perf/builtin-record.c                   |  13 +-
 tools/perf/builtin-stat.c                     |  77 +-
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
 tools/perf/tests/expr.c                       |   3 +-
 tools/perf/tests/parse-events.c               | 858 +++++++++---------
 tools/perf/tests/parse-metric.c               |   1 +
 tools/perf/tests/pmu-events.c                 |  12 +-
 tools/perf/tests/shell/stat.sh                |  44 +
 tools/perf/util/Build                         |   1 -
 tools/perf/util/evlist.h                      |   1 -
 tools/perf/util/evsel.c                       |  30 +-
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/expr.y                        |   6 +-
 tools/perf/util/metricgroup.c                 | 111 ++-
 tools/perf/util/metricgroup.h                 |   3 +-
 tools/perf/util/parse-events-hybrid.c         | 214 -----
 tools/perf/util/parse-events-hybrid.h         |  25 -
 tools/perf/util/parse-events.c                | 720 ++++++---------
 tools/perf/util/parse-events.h                |  63 +-
 tools/perf/util/parse-events.l                | 108 +--
 tools/perf/util/parse-events.y                | 222 ++---
 tools/perf/util/pmu-hybrid.c                  |  20 -
 tools/perf/util/pmu-hybrid.h                  |   1 -
 tools/perf/util/pmu.c                         |  16 +-
 tools/perf/util/pmu.h                         |   3 +
 tools/perf/util/pmus.c                        |  25 +-
 tools/perf/util/pmus.h                        |   3 +
 tools/perf/util/print-events.c                | 127 ++-
 tools/perf/util/stat-display.c                |   2 +-
 tools/perf/util/stat-shadow.c                 |  25 +-
 60 files changed, 2066 insertions(+), 1699 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/hybrid.c
 delete mode 100644 tools/perf/util/parse-events-hybrid.c
 delete mode 100644 tools/perf/util/parse-events-hybrid.h

-- 
2.40.1.495.gc816e09b53d-goog

