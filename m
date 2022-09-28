Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF4E5ED5E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiI1HWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiI1HWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:22:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF886D5882
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:22:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j3-20020a256e03000000b006bc0294164dso5125003ybc.20
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date;
        bh=0AguHWUqCM3gW3iXUKABpI6T6cvY8qPG4vl+F0YOUJk=;
        b=ACycKxPl5RxTPVOjOf3fgMkLiXaXBE+FzRdLcjmw1b/8wADvw8CPEnD2nkMo2/PT5U
         pJZwIyKXobrBLp+ZbpHGv501tJR+e1SQHPnaYNXc7E4O55288UMCtivWt1MeW+uhfJ1e
         duAycnkus3z51GhUyPzBVLLZXfnN0okVl1H7emzRbUwU+PXYV4bQFkmGD2kTkKl8EUop
         mgmmQeY/VpCBe8k5mtA6VnXofEl7QhkJjubDNXTiYsAChWrLANsUGF0ydkdwJMLXVaHQ
         +aKA5u5drU5nI+Nki39vOfQM11/sIM8UZWmV7MCa9aevgnZoQcAyR6xJuLne5OZygGMJ
         /PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=0AguHWUqCM3gW3iXUKABpI6T6cvY8qPG4vl+F0YOUJk=;
        b=t5A1WHsesW7WDhJ52M+dLHiCJDW4QscxhMVIFAww7e6kck5uNRDTxHFxIEBPw3Uq0d
         gX6HKFqbNMJq4roXqZPipT+MrAHwfKnPG6EG8BNH4i0pdS3T27rXACryis056wd8Wz44
         BJV1FhHRgn92sDpQVi9ronGu/DG304yKVReWSXCNnzw4AFw7f57IzrIiMYlX/DXEB7ij
         NXUo/r9h5wSDOnYWfnPt1KRysTM8V6z5+PfNrRUGz1NAId3YHwEdmFIHL1DbcWjP6DHs
         nuWBX72Cb9VwQldK8p1SJBxtl5ZMv764E/M1Ock55CP96vW7dEuDFK07ZmBrsIXbbbsP
         XvOQ==
X-Gm-Message-State: ACrzQf0tzUOZ+MZ/ksd/PVPmHi4rq+XhXQWZTMo0+I1ic8JnJbWa2Krm
        CI5qPiGAg1v8ecDzUVWm0u+1kzvZPqGW
X-Google-Smtp-Source: AMsMyM40GrNVYExtcDIsey17wAZVlpgtol9KDHZviKRwgr4mepnk90erEMBqYZDAQxUdoPHRdzCUTd8CkbRl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7099:1ccb:612a:5ad6])
 (user=irogers job=sendgmr) by 2002:a81:186:0:b0:34c:d27f:b9b0 with SMTP id
 128-20020a810186000000b0034cd27fb9b0mr29670112ywb.481.1664349728864; Wed, 28
 Sep 2022 00:22:08 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:21:42 -0700
Message-Id: <20220928072204.1613330-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH v1 00/22] Improvements to Intel perf metrics
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

 .../arch/x86/alderlake/adl-metrics.json       | 1215 ++++++++++++++++-
 .../pmu-events/arch/x86/alderlake/cache.json  |  129 +-
 .../arch/x86/alderlake/frontend.json          |   12 +
 .../pmu-events/arch/x86/alderlake/memory.json |   22 +
 .../pmu-events/arch/x86/alderlake/other.json  |   22 +
 .../arch/x86/alderlake/pipeline.json          |   14 +-
 .../arch/x86/broadwell/bdw-metrics.json       |  603 ++++++--
 .../arch/x86/broadwellde/bdwde-metrics.json   |  639 +++++++--
 .../arch/x86/broadwellx/bdx-metrics.json      |  644 +++++++--
 .../arch/x86/broadwellx/uncore-cache.json     |   10 +-
 .../x86/broadwellx/uncore-interconnect.json   |   18 +-
 .../arch/x86/broadwellx/uncore-memory.json    |   18 +-
 .../arch/x86/cascadelakex/clx-metrics.json    |  893 ++++++++----
 .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
 .../arch/x86/cascadelakex/uncore-other.json   |   10 +-
 .../pmu-events/arch/x86/haswell/cache.json    |    4 +-
 .../pmu-events/arch/x86/haswell/frontend.json |   12 +-
 .../arch/x86/haswell/hsw-metrics.json         |  502 +++++--
 .../pmu-events/arch/x86/haswellx/cache.json   |    2 +-
 .../arch/x86/haswellx/frontend.json           |   12 +-
 .../arch/x86/haswellx/hsx-metrics.json        |  707 +++++++---
 .../x86/haswellx/uncore-interconnect.json     |   18 +-
 .../arch/x86/haswellx/uncore-memory.json      |   18 +-
 .../pmu-events/arch/x86/icelake/cache.json    |    6 +-
 .../arch/x86/icelake/icl-metrics.json         |  725 +++++++++-
 .../pmu-events/arch/x86/icelake/pipeline.json |    2 +-
 .../pmu-events/arch/x86/icelakex/cache.json   |    6 +-
 .../arch/x86/icelakex/icx-metrics.json        |  794 ++++++++++-
 .../arch/x86/icelakex/pipeline.json           |    2 +-
 .../arch/x86/icelakex/uncore-other.json       |    2 +-
 .../arch/x86/ivybridge/ivb-metrics.json       |  525 +++++--
 .../pmu-events/arch/x86/ivytown/cache.json    |    4 +-
 .../arch/x86/ivytown/floating-point.json      |    2 +-
 .../pmu-events/arch/x86/ivytown/frontend.json |   18 +-
 .../arch/x86/ivytown/ivt-metrics.json         |  558 ++++++--
 .../arch/x86/ivytown/uncore-cache.json        |   58 +-
 .../arch/x86/ivytown/uncore-interconnect.json |   84 +-
 .../arch/x86/ivytown/uncore-memory.json       |    2 +-
 .../arch/x86/ivytown/uncore-other.json        |    6 +-
 .../arch/x86/ivytown/uncore-power.json        |    8 +-
 .../arch/x86/jaketown/jkt-metrics.json        |  291 ++--
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   18 +-
 .../arch/x86/sandybridge/snb-metrics.json     |  279 +++-
 .../arch/x86/sapphirerapids/cache.json        |    4 +-
 .../arch/x86/sapphirerapids/frontend.json     |   11 +
 .../arch/x86/sapphirerapids/pipeline.json     |    4 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  |  858 +++++++++++-
 .../arch/x86/skylake/skl-metrics.json         |  774 ++++++++---
 .../arch/x86/skylakex/skx-metrics.json        |  859 +++++++++---
 .../arch/x86/skylakex/uncore-memory.json      |   18 +-
 .../arch/x86/skylakex/uncore-other.json       |   19 +-
 .../arch/x86/tigerlake/tgl-metrics.json       |  727 +++++++++-
 tools/perf/tests/expr.c                       |    4 +
 tools/perf/util/expr.c                        |   11 +-
 tools/perf/util/expr.y                        |    2 +-
 tools/perf/util/stat-shadow.c                 |    9 +-
 56 files changed, 10103 insertions(+), 2129 deletions(-)

-- 
2.37.3.998.g577e59143f-goog

