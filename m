Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E145704025
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245109AbjEOV6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243377AbjEOV6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:58:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D128172A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:58:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso24456151276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684187928; x=1686779928;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G0bS22CbhPXpB43FjjFU2MCdOSdF0WGgC6o1gyAzyTk=;
        b=tKDweTwEhrOGuI862pQ4U4CM2YB35lZkKhbvxIPHASDN52NaqCLeWYtyDumFyb5CnA
         sBmjGTP+MDWjJkE7BNBgA0ilhiwRmlX+x4fXu1XMbjyu7w1yb5qyyg0UHJgktuCxD73j
         n79Isxboi3hQXWYbXKMkSzbKkEHczizv6/Egn9v7tW7W+7LqB1CotkNylg7glNLFr8Wm
         eBhuCqsW7JBBXOu6ONeKdEqPYN2r+nSIkYyiD98DUaNMdukz3AAjnpEr/AqgKJYPsagT
         1UWx5WTlhfaTnwpz1fBVlF+DT1ZbDA7xH7RF71Yk2fZ2DUAQI0tT4h4U54HTthy2ZoSz
         MucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684187928; x=1686779928;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0bS22CbhPXpB43FjjFU2MCdOSdF0WGgC6o1gyAzyTk=;
        b=hj/5byyGxwX0k+X5Cwsk4qRDZ8SXElJ6Cf1LyFudbUyTWEjWvexSTlm3UDvsemg8LB
         7eq9itr2F9l9DA+Srw5uEeeU8aG7pqj1ZNXXjaFD40wD+kay5M7oZjq1cWQVDzeXAHjR
         PoNxbW58jPkT03AbGDW7bPlOCltwyGgfrWkQyaC/E8qiA1nkvBRdYRZqlSBc3M5l56gV
         Myt9OlNSDNE+xx/PKB9r8UFu9jHlVtEDV0UIXjm77nn2QbirmORGFuw3/z/wZhfS1XJS
         AwtGtLgX+zNnz1/fUsRCEbWwG5pK+ZvspbB68rD/qwPLF/JlpvUy9QZymDiFTrhoDhYM
         s2Bw==
X-Gm-Message-State: AC+VfDxpxy+2Q8GqoGaNM4s7yhdj9K0RJmwQUS6KWbKJeyja0T58Qok9
        CllKaO8fIII3OxX1r6oN4j8EKpo62GYN
X-Google-Smtp-Source: ACHHUZ7ccSQlwjqxFTkNiqhdSjSLdK9/5FKICIdrXLFZa8R+l00Qwad1jpEX7LvuIdL6d9ClIIaCrUBlWwxL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:638e:7eff:a1d9:3b2b])
 (user=irogers job=sendgmr) by 2002:a25:6503:0:b0:ba6:8a90:59b9 with SMTP id
 z3-20020a256503000000b00ba68a9059b9mr7390757ybb.5.1684187928302; Mon, 15 May
 2023 14:58:48 -0700 (PDT)
Date:   Mon, 15 May 2023 14:58:29 -0700
Message-Id: <20230515215844.653610-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 00/15] Event, metric and metric group improvements
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
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

