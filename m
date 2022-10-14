Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31225FE8C1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJNGQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJNGP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:15:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E12A1ABEFD;
        Thu, 13 Oct 2022 23:15:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso6969674pja.5;
        Thu, 13 Oct 2022 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=A5V53XHSnULkSMzLm8dzHc7ZEYfYint9kTQilt99YbM=;
        b=SKkTmCu+1WjXS4LppuWj0SOlycLYCL5S68UJeP5hCliiFbTeog2drU62dgBSXBaZmC
         L7WW0lLiwjHgzksgMjsRjXmSUjdjw3LkxevZPwuwT5v1HNC1uDwEqxZEx8nph2VLS6tb
         2cqVt5OJqzSulg4WHpsy4NLGynDBBItZQqM71+EPa+i3y+8sODgYfNSIyPNDYrbmS0ny
         PaR5IFZHWPzvFy/rA9cyk3fVahoH3XMpRvzokDFF3L1lneZ/tuUIXBmEKOlMyzXGeYFh
         DW2p6JECd1Q1HgJGAaKhRYeRyY74Pa6IkC3zAbJLnCnXAF0E4lzHp288qDo6T/nqR8Qz
         vx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5V53XHSnULkSMzLm8dzHc7ZEYfYint9kTQilt99YbM=;
        b=VfEDNXR8k9x/FSHWQ2Xyn8sVpylnnqfyniL9CxLKUQkABQe6l0f7AMOVh4ZN80iNNi
         jC5f9Fd/4D9sDyr80gbbRpt4FQhdd8M/fue0zk80AD5hPlVtxoUOW2dZjSlj52CUMHax
         VT669+A1XfXgHDxuGf5tgy3WwuT5XYOazz0ATvR6rJHK+GaDg3dzo47Tq+BVYKMD8EQw
         IOgcXfhDf/bc4obdSHvHqlRXGVAGvNG9/r9dj2bnqNO0e9IgnTw7Q6smrv+jIKL7/qyX
         o1jlWDaK0jwDBCkKsCAxjlnF6PF/KOOL7APUhC8YdbJCtXuxUHaUcEvuNBBuUXxoBPto
         HniQ==
X-Gm-Message-State: ACrzQf2Tzy+eoAtkiNtenBoblzQAEy1BsjVPlBPH+oAdtiYV84pN9vZk
        1TTIK0yYOI5my4CHDaOWA54=
X-Google-Smtp-Source: AMsMyM7yWUtaBCtlQPMO3mecCEpRlJilWmGgvpprKlKIMgXYfw+lESE3L1GbrIWzCL88NsrYRuCCBQ==
X-Received: by 2002:a17:902:f545:b0:17f:9022:e00d with SMTP id h5-20020a170902f54500b0017f9022e00dmr3530768plf.50.1665728152527;
        Thu, 13 Oct 2022 23:15:52 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:15:52 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCHSET 00/19] perf stat: Cleanup counter aggregation (v2)
Date:   Thu, 13 Oct 2022 23:15:31 -0700
Message-Id: <20221014061550.463644-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Current perf stat code is somewhat hard to follow since it handles
many combinations of PMUs/events for given display and aggregation
options.  This is my attempt to clean it up a little. ;-)

changes in v2)
 * fix a segfault in perf stat report for per-process record  (Jiri)
 * fix metric only display  (Jiri)
 * add evsel__reset_aggr_stat  (ian)
 * add more comments  (Ian)
 * add Acked-by from Ian

My first concern is that aggregation and display routines are intermixed
and processed differently depends on the aggregation mode.  I'd like to
separate them apart and make the logic clearer.

To do that, I added struct perf_stat_aggr to save the aggregated counter
values and other info.  It'll be allocated and processed according to
the aggr_mode and display logic will use it.

I've tested the following combination.

  $ cat test-matrix.sh
  #!/bin/sh

  set -e

  yes > /dev/null &
  TARGET=$!

  ./perf stat true
  ./perf stat -a true
  ./perf stat -C0 true
  ./perf stat -p $TARGET true
  ./perf stat -t $TARGET true

  ./perf stat -a -A true
  ./perf stat -a --per-node true
  ./perf stat -a --per-socket true
  ./perf stat -a --per-die true
  ./perf stat -a --per-core true
  ./perf stat -a --per-thread true

  ./perf stat -a -I 500 sleep 1
  ./perf stat -a -I 500 --summary sleep 1
  ./perf stat -a -I 500 --per-socket sleep 1
  ./perf stat -a -I 500 --summary --per-socket sleep 1

  ./perf stat -a --metric-only true
  ./perf stat -a --metric-only --per-socket true
  ./perf stat -a --metric-only -I 500 sleep 1
  ./perf stat -a --metric-only -I 500 --per-socket sleep 1

  ./perf stat record true && ./perf stat report
  ./perf stat record -p $TARGET true && ./perf stat report
  ./perf stat record -a true && ./perf stat report
  ./perf stat record -a --per-core true && ./perf stat report
  ./perf stat record -a --per-core --metric-only true && ./perf stat report
  ./perf stat record -a -I 500 sleep 1 && ./perf stat report
  ./perf stat record -a -I 500 --per-core sleep 1 && ./perf stat report
  ./perf stat record -a -I 500 --per-core --metric-only sleep 1 && ./perf stat report

  ./perf stat -a -A -e cpu/event=cpu-cycles,percore/ true
  ./perf stat -a -A -e cpu/event=cpu-cycles,percore/ --percore-show-thread true

  kill $TARGET

The code is available at 'perf/stat-aggr-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (19):
  perf tools: Save evsel->pmu in parse_events()
  perf tools: Use pmu info in evsel__is_hybrid()
  perf stat: Use evsel__is_hybrid() more
  perf stat: Add aggr id for global mode
  perf stat: Add cpu aggr id for no aggregation mode
  perf stat: Add 'needs_sort' argument to cpu_aggr_map__new()
  perf stat: Add struct perf_stat_aggr to perf_stat_evsel
  perf stat: Allocate evsel->stats->aggr properly
  perf stat: Aggregate events using evsel->stats->aggr
  perf stat: Aggregate per-thread stats using evsel->stats->aggr
  perf stat: Allocate aggr counts for recorded data
  perf stat: Reset aggr counts for each interval
  perf stat: Split process_counters()
  perf stat: Add perf_stat_merge_counters()
  perf stat: Add perf_stat_process_percore()
  perf stat: Add perf_stat_process_shadow_stats()
  perf stat: Display event stats using aggr counts
  perf stat: Display percore events properly
  perf stat: Remove unused perf_counts.aggr field

 tools/perf/builtin-script.c                   |   4 +-
 tools/perf/builtin-stat.c                     | 186 +++++--
 tools/perf/tests/parse-metric.c               |   2 +-
 tools/perf/tests/pmu-events.c                 |   2 +-
 tools/perf/util/counts.c                      |   1 -
 tools/perf/util/counts.h                      |   1 -
 tools/perf/util/cpumap.c                      |  16 +-
 tools/perf/util/cpumap.h                      |   8 +-
 tools/perf/util/evsel.c                       |  13 +-
 tools/perf/util/parse-events.c                |   1 +
 tools/perf/util/pmu.c                         |   4 +
 .../scripting-engines/trace-event-python.c    |   6 -
 tools/perf/util/stat-display.c                | 462 +++---------------
 tools/perf/util/stat.c                        | 385 ++++++++++++---
 tools/perf/util/stat.h                        |  40 +-
 15 files changed, 602 insertions(+), 529 deletions(-)


base-commit: d79310700590b8b40d8c867012d6c899ea6fd505
-- 
2.38.0.413.g74048e4d9e-goog

