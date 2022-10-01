Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4B85F1A22
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 08:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiJAGGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 02:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJAGGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:06:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4012B4A2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:06:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p12-20020a259e8c000000b006958480b858so5628794ybq.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date;
        bh=j/kZEnEKhrCLcEhqLKZiMXLEScCwjkeAmRE1uoMjU3E=;
        b=AK0eA4cwzwWjIUpG5EInK6hG6IAuFv/gjvX2CvOLO8MrGvzMnVfOJcp0CvhLrCnwvH
         wDQ3VA5NwkDzu2kY73VgoQvxRzQfFJ4VdMpWvmm25n5dO7FviDAdhsYPXJMsY2ck+NOU
         e4ry5dp11GeMLGuX28m8HN0ZdQh+JBFzqdvvgdA/rtH9EPbsKhz8fVZmevtmZM6rcJFn
         PwL3ZLukL21c8D2BsaB2MaDVej6+uFEMQ7qemjDo0EhHyrA9uUDVkKwrt+0hrRmry73l
         DYPu8r4ZQ7i7LsaPwpYxf7YT7Qzwrim5CaObAY9m1sdykVBM7P750WTABpxMGXJoFh+e
         4wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=j/kZEnEKhrCLcEhqLKZiMXLEScCwjkeAmRE1uoMjU3E=;
        b=155ADg6qSYYci2uwyXA/VQM1GW/fTif3QLqUUm54Rx9ilirdVytfpxf9vBe2uoyEWb
         y9LgrrL5J9esZcy8H1SlbPhYiMryffyYtLhOQp7OpjCREcsKlDrZ61QSa9h1a0PUbNJV
         ZMO1bPbBAEDlF0VQWwljg1NiDyU+TfCSPM0dJqTMjR64iDIDs8gYd5qAMwdF8BGjoTEZ
         1BH/LKa4dKvZA/AH6rlkH7tFQliFRpFLiYFw+BhdYI/cKxOZMOFH79r+NciCgOGRt6na
         c2wTEK4ekGTytUSnqKFSEbb5EI1FcRue+JihKWG4Rz+ioYiZeW5pJUoEMw/KCa1bRy48
         mhag==
X-Gm-Message-State: ACrzQf2VfV0N0KrEAQykTWdWLZXhQnykamKuLhsIkie6jj3PjNu4qmTN
        8JwUSV0bYSC7XPh7zyMDCadqupESihXN
X-Google-Smtp-Source: AMsMyM6AfDeInAXbMHELtXtuE72T5M27ph2akUaHayKPViKMX5man083ndFs2YjWEsjggGHXr2tc5u7G1fIJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:de60:c6ac:8491:ce1e])
 (user=irogers job=sendgmr) by 2002:a05:6902:722:b0:6bc:58d6:5add with SMTP id
 l2-20020a056902072200b006bc58d65addmr11055322ybt.590.1664604402586; Fri, 30
 Sep 2022 23:06:42 -0700 (PDT)
Date:   Fri, 30 Sep 2022 23:06:14 -0700
Message-Id: <20221001060636.2661983-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v2 00/22] Improvements to Intel perf metrics
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
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
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency with:
https://github.com/intel/perfmon-metrics
rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.

Remove _SMT suffix metrics are dropped as the #SMT_On and #EBS_Mode
are correctly expanded in the single main metric. Fix perf expr to
allow a double if to be correctly processed.

Add all 6 levels of TMA metrics. Child metrics are placed in a group
named after their parent allowing children of a metric to be
easily measured using the metric name with a _group suffix.

Don't drop TMA metrics if they contain topdown events.

The ## and ##? operators are correctly expanded.

The locate-with column is added to the long description describing a
sampling event.

Metrics are written in terms of other metrics to reduce the expression
size and increase readability.

Following this the pmu-events/arch/x86 directories match those created
by the script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py
with updates at:
https://github.com/captain5050/event-converter-for-linux-perf

v2. Fixes commit message wrt missing mapfile.csv updates as noted by
    Zhengjun Xing <zhengjun.xing@linux.intel.com>. ScaleUnit is added
    for TMA metrics. Metrics with topdown events have have a missing
    slots event added if necessary. The latest metrics at:
    https://github.com/intel/perfmon-metrics are used, however, the
    event-converter-for-linux-perf scripts now prefer their own
    metrics in case of mismatched units when a metric is written in
    terms of another.  Additional testing was performed on broadwell,
    broadwellde, cascadelakex, haswellx, sapphirerapids and tigerlake
    CPUs.

Ian Rogers (22):
  perf expr: Allow a double if expression
  perf expr: Remove jevents case workaround
  perf metrics: Don't scale counts going into metrics
  perf vendor events: Update Intel skylakex
  perf vendor events: Update Intel alderlake
  perf vendor events: Update Intel broadwell
  perf vendor events: Update Intel broadwellx
  perf vendor events: Update Intel cascadelakex
  perf vendor events: Update elkhartlake cpuids
  perf vendor events: Update Intel haswell
  perf vendor events: Update Intel haswellx
  perf vendor events: Update Intel icelake
  perf vendor events: Update Intel icelakex
  perf vendor events: Update Intel ivybridge
  perf vendor events: Update Intel ivytown
  perf vendor events: Update Intel jaketown
  perf vendor events: Update Intel sandybridge
  perf vendor events: Update Intel sapphirerapids
  perf vendor events: Update silvermont cpuids
  perf vendor events: Update Intel skylake
  perf vendor events: Update Intel tigerlake
  perf vendor events: Update Intel broadwellde

 .../arch/x86/alderlake/adl-metrics.json       | 1353 ++++++++++++++++-
 .../pmu-events/arch/x86/alderlake/cache.json  |  129 +-
 .../arch/x86/alderlake/frontend.json          |   12 +
 .../pmu-events/arch/x86/alderlake/memory.json |   22 +
 .../pmu-events/arch/x86/alderlake/other.json  |   22 +
 .../arch/x86/alderlake/pipeline.json          |   14 +-
 .../arch/x86/broadwell/bdw-metrics.json       |  679 +++++++--
 .../arch/x86/broadwellde/bdwde-metrics.json   |  711 +++++++--
 .../arch/x86/broadwellx/bdx-metrics.json      |  965 +++++++-----
 .../arch/x86/broadwellx/uncore-cache.json     |   10 +-
 .../x86/broadwellx/uncore-interconnect.json   |   18 +-
 .../arch/x86/broadwellx/uncore-memory.json    |   18 +-
 .../arch/x86/cascadelakex/clx-metrics.json    | 1285 ++++++++++------
 .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
 .../arch/x86/cascadelakex/uncore-other.json   |   10 +-
 .../pmu-events/arch/x86/haswell/cache.json    |    4 +-
 .../pmu-events/arch/x86/haswell/frontend.json |   12 +-
 .../arch/x86/haswell/hsw-metrics.json         |  570 ++++++-
 .../pmu-events/arch/x86/haswellx/cache.json   |    2 +-
 .../arch/x86/haswellx/frontend.json           |   12 +-
 .../arch/x86/haswellx/hsx-metrics.json        |  919 +++++++----
 .../x86/haswellx/uncore-interconnect.json     |   18 +-
 .../arch/x86/haswellx/uncore-memory.json      |   18 +-
 .../pmu-events/arch/x86/icelake/cache.json    |    6 +-
 .../arch/x86/icelake/icl-metrics.json         |  808 +++++++++-
 .../pmu-events/arch/x86/icelake/pipeline.json |    2 +-
 .../pmu-events/arch/x86/icelakex/cache.json   |    6 +-
 .../arch/x86/icelakex/icx-metrics.json        | 1155 ++++++++++----
 .../arch/x86/icelakex/pipeline.json           |    2 +-
 .../arch/x86/icelakex/uncore-other.json       |    2 +-
 .../arch/x86/ivybridge/ivb-metrics.json       |  594 ++++++--
 .../pmu-events/arch/x86/ivytown/cache.json    |    4 +-
 .../arch/x86/ivytown/floating-point.json      |    2 +-
 .../pmu-events/arch/x86/ivytown/frontend.json |   18 +-
 .../arch/x86/ivytown/ivt-metrics.json         |  630 ++++++--
 .../arch/x86/ivytown/uncore-cache.json        |   58 +-
 .../arch/x86/ivytown/uncore-interconnect.json |   84 +-
 .../arch/x86/ivytown/uncore-memory.json       |    2 +-
 .../arch/x86/ivytown/uncore-other.json        |    6 +-
 .../arch/x86/ivytown/uncore-power.json        |    8 +-
 .../arch/x86/jaketown/jkt-metrics.json        |  327 +++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   18 +-
 .../arch/x86/sandybridge/snb-metrics.json     |  315 +++-
 .../arch/x86/sapphirerapids/cache.json        |    4 +-
 .../arch/x86/sapphirerapids/frontend.json     |   11 +
 .../arch/x86/sapphirerapids/pipeline.json     |    4 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  | 1249 ++++++++++-----
 .../arch/x86/skylake/skl-metrics.json         |  861 ++++++++---
 .../arch/x86/skylakex/skx-metrics.json        | 1262 +++++++++------
 .../arch/x86/skylakex/uncore-memory.json      |   18 +-
 .../arch/x86/skylakex/uncore-other.json       |   19 +-
 .../arch/x86/tigerlake/tgl-metrics.json       |  810 +++++++++-
 tools/perf/tests/expr.c                       |    4 +
 tools/perf/util/expr.c                        |   11 +-
 tools/perf/util/expr.y                        |    2 +-
 tools/perf/util/stat-shadow.c                 |    9 +-
 56 files changed, 11508 insertions(+), 3624 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

