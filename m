Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E2B706CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjEQP1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjEQP1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:27:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544787A83
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:26:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba5fd33fdacso1517213276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684337203; x=1686929203;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/0AHcIK+Y7E8Y5bouoEWy2WopyAV2drMnApTbYsOBvA=;
        b=IyxySHU49v/MHW72Poj1ZcyQznhEySh9NU/6nJsdbAc0zOdOm0uG/l0Iu0oHnv/lrM
         y2jcVqUFJ8a7Fiuz5E2fegk/4qqGXixwXHkQVkjAmGionAEMjF/5BoA4PiZxIhOy5+Or
         XiiQUwACQfENs21vzLPhtQaYkHnM3z4QLlxY23SLtOY4meGJKeowKg95zXfQ8aO1KK0B
         Zjfk4wY1dw3LnHuKTXX8WAIkjzkp4sch9eAiHJa+sLl9QU/a+D043bps4Z5At2cnP+Ot
         DvjV5aBWZM64r6RDZlp7H/rj3JNlTuqJ7eT3ACWKibP77lnvR5Urp2nFpcR8jPvjn2oc
         vyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337203; x=1686929203;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0AHcIK+Y7E8Y5bouoEWy2WopyAV2drMnApTbYsOBvA=;
        b=LyrgjxtQ9L3p8jf/tP9bnUC4v3RF763D54phyeN//ArkGHRnkloRS/qOFPgYe44S0T
         VolzPBTsiRoJ+da707k0mZAd1SgCJQwTLFD2QNboMhNCDxmWb13/zY1T+8TzpAOgYFha
         QZK/aCtpCJYtcjak1/kyQ9o+LaDJPavBtwFUBxUu28DcvdYYOPiArX35wVISRy3cwt9/
         4iKpGaUVlYlGTaUTmlmWbSOvej5o5k7hEoFeGE6F0Br2BIqZvBDYHDrNYwq5NBVyOaep
         4DHRmPpYgpvU7cS9fP07mqzWmTORV9+BMWlAfmPDVHSYa+pcPeog4rViGPztMeQpTp22
         bpog==
X-Gm-Message-State: AC+VfDyCWoqvkODWaTF0PSMDeM+KAbvyHRN3KXMkJEEjXGXvLCVUM1RW
        9XYGb80a6LdUXN6X6BHm6Be7AXMmPSJ3
X-Google-Smtp-Source: ACHHUZ7xzwd4+qLOU0Z8yrjRAtj9SMWzozGnDdYJ8J+ed1/xOtxSTv5ze0GZEmHsc61b/iZ3DojBNnBvpMN4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a05:6902:154f:b0:b78:8bd8:6e77 with SMTP
 id r15-20020a056902154f00b00b788bd86e77mr26229441ybu.8.1684337203617; Wed, 17
 May 2023 08:26:43 -0700 (PDT)
Date:   Wed, 17 May 2023 08:26:11 -0700
Message-Id: <20230517152626.563559-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v2 00/15] Event, metric and metric group improvements
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Intel events to the latest at: https://github.com/intel/perfmon
TMA info metrics are renamed for consistency and a fix is added that
adds back in the Valkyrie metrics such as memory_bandwidth_total,
memory_bandwidth_read and memory_bandwidth_write on icelakex.

Add a new feature to perf list to show a description of a metricgroup
via a new metricgroups.json file, add this for the generated Intel
metrics. The descriptions looks like:

```
$ perf list
...
tma_frontend_bound_group: [Metrics contributing to tma_frontend_bound category]
  tma_fetch_bandwidth
       [This metric represents fraction of slots the CPU
        was stalled due to Frontend bandwidth issues]
  tma_fetch_latency
       [This metric represents fraction of slots the CPU
        was stalled due to Frontend latency issues]
...
```

v2. Reword "Grouping from metrics spreadsheet" to "Grouping from
    Top-down Microarchitecture Analysis Metrics spreadsheet" as
    suggested by Kan Liang.

Ian Rogers (15):
  perf vendor events intel: Update alderlake events/metrics
  perf vendor events intel: Update broadwell variant events/metrics
  perf vendor events intel: Update cascadelakex events/metrics
  perf vendor events intel: Update elkhartlake events
  perf vendor events intel: Update haswell(x) metrics
  perf vendor events intel: Update icelake/icelakex events/metrics
  perf vendor events intel: Update ivybridge/ivytown metrics
  perf vendor events intel: Update jaketown metrics
  perf vendor events intel: Update sandybridge metrics
  perf vendor events intel: Update sapphirerapids events/metrics
  perf vendor events intel: Update skylake/skylakex events/metrics
  perf vendor events intel: Update snowridgex events
  perf vendor events intel: Update tigerlake events/metrics
  perf jevents: Add support for metricgroup descriptions
  perf vendor events intel: Add metricgroup descriptions for all models

 tools/perf/builtin-list.c                     |   11 +-
 .../arch/x86/alderlake/adl-metrics.json       | 1314 ++++++++--------
 .../pmu-events/arch/x86/alderlake/cache.json  |    9 +
 .../pmu-events/arch/x86/alderlake/memory.json |    6 +-
 .../arch/x86/alderlake/metricgroups.json      |  122 ++
 .../arch/x86/alderlaken/adln-metrics.json     |  276 ++--
 .../arch/x86/alderlaken/metricgroups.json     |   26 +
 .../arch/x86/broadwell/bdw-metrics.json       |  580 +++----
 .../arch/x86/broadwell/floating-point.json    |   15 +
 .../arch/x86/broadwell/metricgroups.json      |  107 ++
 .../arch/x86/broadwellde/bdwde-metrics.json   |  556 +++----
 .../arch/x86/broadwellde/floating-point.json  |   15 +
 .../arch/x86/broadwellde/metricgroups.json    |  107 ++
 .../arch/x86/broadwellx/bdx-metrics.json      |  796 ++++++----
 .../arch/x86/broadwellx/floating-point.json   |   15 +
 .../arch/x86/broadwellx/metricgroups.json     |  107 ++
 .../arch/x86/cascadelakex/clx-metrics.json    | 1231 +++++++++------
 .../arch/x86/cascadelakex/floating-point.json |   31 +
 .../arch/x86/cascadelakex/metricgroups.json   |  114 ++
 .../arch/x86/cascadelakex/pipeline.json       |   23 +-
 .../arch/x86/elkhartlake/cache.json           |    7 +
 .../arch/x86/elkhartlake/memory.json          |    2 +
 .../arch/x86/elkhartlake/other.json           |   10 +
 .../arch/x86/elkhartlake/pipeline.json        |    3 +
 .../arch/x86/haswell/hsw-metrics.json         |  484 +++---
 .../arch/x86/haswell/metricgroups.json        |  107 ++
 .../arch/x86/haswellx/hsx-metrics.json        |  700 ++++++---
 .../arch/x86/haswellx/metricgroups.json       |  107 ++
 .../pmu-events/arch/x86/icelake/cache.json    |   18 +
 .../arch/x86/icelake/icl-metrics.json         |  950 ++++++------
 .../arch/x86/icelake/metricgroups.json        |  113 ++
 .../arch/x86/icelakex/icx-metrics.json        | 1306 +++++++++-------
 .../arch/x86/icelakex/metricgroups.json       |  114 ++
 .../arch/x86/ivybridge/ivb-metrics.json       |  526 +++----
 .../arch/x86/ivybridge/metricgroups.json      |  107 ++
 .../arch/x86/ivytown/ivt-metrics.json         |  534 +++----
 .../arch/x86/ivytown/metricgroups.json        |  107 ++
 .../arch/x86/jaketown/jkt-metrics.json        |  224 +--
 .../arch/x86/jaketown/metricgroups.json       |  100 ++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   26 +-
 .../arch/x86/sandybridge/metricgroups.json    |  100 ++
 .../arch/x86/sandybridge/snb-metrics.json     |  222 +--
 .../arch/x86/sapphirerapids/memory.json       |    6 +-
 .../arch/x86/sapphirerapids/metricgroups.json |  118 ++
 .../arch/x86/sapphirerapids/spr-metrics.json  | 1357 ++++++++++-------
 .../sapphirerapids/uncore-interconnect.json   |    2 +-
 .../x86/sapphirerapids/uncore-memory.json     |    8 +-
 .../arch/x86/skylake/floating-point.json      |    8 +
 .../arch/x86/skylake/metricgroups.json        |  113 ++
 .../pmu-events/arch/x86/skylake/pipeline.json |   15 +-
 .../arch/x86/skylake/skl-metrics.json         |  875 ++++++-----
 .../arch/x86/skylakex/floating-point.json     |   31 +
 .../arch/x86/skylakex/metricgroups.json       |  114 ++
 .../arch/x86/skylakex/pipeline.json           |   23 +-
 .../arch/x86/skylakex/skx-metrics.json        | 1183 ++++++++------
 .../pmu-events/arch/x86/snowridgex/cache.json |    7 +
 .../arch/x86/snowridgex/memory.json           |    2 +
 .../pmu-events/arch/x86/snowridgex/other.json |   10 +
 .../arch/x86/snowridgex/pipeline.json         |    3 +
 .../x86/snowridgex/uncore-interconnect.json   |   14 +-
 .../arch/x86/snowridgex/uncore-io.json        |    8 -
 .../arch/x86/snowridgex/uncore-memory.json    |    7 +-
 .../arch/x86/snowridgex/uncore-power.json     |    6 +-
 .../pmu-events/arch/x86/tigerlake/cache.json  |   18 +
 .../arch/x86/tigerlake/metricgroups.json      |  113 ++
 .../arch/x86/tigerlake/pipeline.json          |    1 +
 .../arch/x86/tigerlake/tgl-metrics.json       |  970 ++++++------
 tools/perf/pmu-events/empty-pmu-events.c      |    5 +
 tools/perf/pmu-events/jevents.py              |   49 +-
 tools/perf/pmu-events/pmu-events.h            |    2 +
 70 files changed, 9985 insertions(+), 6411 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswell/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/metricgroups.json

-- 
2.40.1.606.ga4b1b128d6-goog

