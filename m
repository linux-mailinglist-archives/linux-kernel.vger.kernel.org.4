Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302135F97D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiJJFgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiJJFgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42AC61;
        Sun,  9 Oct 2022 22:36:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gf8so8965407pjb.5;
        Sun, 09 Oct 2022 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RVA4JJdT2Z+v9/KhnhYIqf9xYvMnR3eukQaugJJM+U8=;
        b=bLIZ3d3eHeOaDGt1urkqoq2g6Y78PHAGlXq567mdLeHoXSw9+xhGdENQk8DLp9edDc
         KoNvuys7RZq0/9yG+zMr0l/LQv153dOBNC076WuOqN+qG3tr1xb0pUgOdo3YMBUdlQZP
         iGDRIUhP6LOYW/b6Vn9ZmMF34KKUfcKYRL00GQVKNGbD9Ybxtwx5o6Q8WVF/PAsoMGar
         L525d1qKjmkL6/gRWikKKDcCp8h21yKImRZ9+dHcGobbgrYiXceFx5IpzJ6ORuqHdxe+
         GSMutzSbZh85lbfyiDFZDJ9kwTqAop7F+ZxoBNZFtFCVZpmubk75s+HrxTYHdO0xNDHY
         VJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVA4JJdT2Z+v9/KhnhYIqf9xYvMnR3eukQaugJJM+U8=;
        b=AekTw1mfelHnTZPEKHqtSUla85QsloSM/z+HA9bcL2LU/0OHCk4h0tRJJJa1ffQw0d
         le9OBj/EG3t1Xhxu9aZuU6oJSfaL/HuxO3Mv5taDTr1gSD1HaQ8s77Jllswm4UKV/A3h
         OXk5yT7owBLQu7eEOyavR5GQkGI43x7N2i7ijhOSChIbh/sZsUcNVfzWTSPpOqQcQNZ0
         aXrswnFGv1ioD30xwxRL2eJG+yJunuXLEVFOPgv6kO8S54pDFeUio9hJ9UX4UyBxXdSZ
         xZDjxTu1YkEVk7j62psAMWyBn9PZ3M2uoq1L6HZD4aWnerNBAqDrvk9Pl5KITIjsWkTs
         WYWw==
X-Gm-Message-State: ACrzQf1nuuRe6gdQB9cvsRw3+IXZEUqfDlaxf1PShNrxqmGvHGo9zmcf
        U46ubXmZEmFBnWckg8nGFmk=
X-Google-Smtp-Source: AMsMyM4NNv/w6yg8VVoGSh7fu9xHl5THSzfo/1bKk08Wadsu5JPji3guNF7tPdYTqXigfsWpcih45g==
X-Received: by 2002:a17:90b:4b87:b0:202:d760:9b00 with SMTP id lr7-20020a17090b4b8700b00202d7609b00mr29997403pjb.194.1665380163139;
        Sun, 09 Oct 2022 22:36:03 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:02 -0700 (PDT)
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
Subject: [RFC/PATCHSET 00/19] perf stat: Cleanup counter aggregation (v1)
Date:   Sun,  9 Oct 2022 22:35:41 -0700
Message-Id: <20221010053600.272854-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

My first concern is that aggregation and display routines are intermixed
and processed differently depends on the aggregation mode.  I'd like to
separate them apart and make the logic clearer.

To do that, I added struct perf_stat_aggr to save the aggregated counter
values and other info.  It'll be allocated and processed according to
the aggr_mode and display logic will use it.

The code is available at 'perf/stat-aggr-v1' branch in

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
 tools/perf/builtin-stat.c                     | 177 +++++--
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
 tools/perf/util/stat-display.c                | 472 +++---------------
 tools/perf/util/stat.c                        | 383 +++++++++++---
 tools/perf/util/stat.h                        |  29 +-
 15 files changed, 590 insertions(+), 529 deletions(-)


base-commit: d79310700590b8b40d8c867012d6c899ea6fd505
-- 
2.38.0.rc1.362.ged0d419d3c-goog

