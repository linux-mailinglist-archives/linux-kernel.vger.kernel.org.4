Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308DB628B07
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbiKNVHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiKNVHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:07:39 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F3265
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:07:38 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pq17-20020a17090b3d9100b0020a4c65c3a9so5321823pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bnk6QcACKDHfLaerzSC+1vUeLHtUQc78SZsram1d2Ns=;
        b=cYOIca+NENhdYACfSPVmKjGEQejr4Fzt4sx/bRNYYxGS7WA+7LWkliB7ofeINiW5Ms
         7Mo+vOvxe2sOljrDaJVzTAgD7JZsSDAoswQjxGt7VCm4y6AWk2H4cFa3TudXjUR/v4/n
         Bg5eaxBFhCgr8P/QYJY3wvJQLzAe0PWA57d+3m5El8CMl6WLjEsF27B2awPef3C6ogMM
         7BXVlXXWsdgrha+Z+1awDzFnC2NbxTvkvh6YuuH5+0wlq+r1PTBuurnIsrSoquELUbx/
         Zuxbpw9yOpCqDTyToLd/qn33k7H/fYB5M3mTBVPcxrsaHXvp1V2X28/NGzEUNMQwj3xk
         SZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnk6QcACKDHfLaerzSC+1vUeLHtUQc78SZsram1d2Ns=;
        b=4NKCw+4Qwr6hLZTE8fSzRSem2MXXWmQQdYDR8u/nFWfX+VP0/N6YuMBOHUMWqfQrN9
         Bs52zSON6V/RhPH6GDaoppF1Sj7omci5erYc1IcwM9C9aZYBmtc7YyMlzZw2E63jqWKQ
         Z/KOGooVq0D3CGiu14NGxQnL+q/pxZ/zCbBgODGzf5D/8hrZ2+dklInuWYl64I3eDIBu
         /8sicWnx0KWmJNZng2ohe82ti9oKTrDr6mvHFGhyW+7jx8KURHkRbXCrbnoPMD+89pLh
         czaerEE+A99lSV7YcsmvIJJJtk8E1CE+ARiqBobEjxHa8OtEh03J/dZKODtnqm6xBPIv
         GB4Q==
X-Gm-Message-State: ANoB5plviC5wLZHJGVS84v12H82orhIZR8VZCX4VcrrRkPlztWIib7xZ
        5Xp8DHwjtTqD4eGZSEDrRvvjQLwcxpCD
X-Google-Smtp-Source: AA0mqf5XLHjklsrSGEkkJMrepVuOU97r0u2RyqqeVSUn4+rizrpjePhHSNj9GGDN3SSU11FFNjz6Oy0zOSu1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a63:4f54:0:b0:476:85ee:aee2 with SMTP id
 p20-20020a634f54000000b0047685eeaee2mr5230552pgl.582.1668460058138; Mon, 14
 Nov 2022 13:07:38 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:07:13 -0800
Message-Id: <20221114210723.2749751-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v3 00/10] Restructure perf list and add json output
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Restructure perf list so that it uses callbacks to print events and
metrics. Use the callbacks to implement json output. In the process
add documentation to pmu.h, avoid some sorting of events, fix some
command line and output bugs.

v3. Removes is_hybrid from perf_pmu as suggested by Kan Liang.
    ScaleUnit is added to the json output as suggested by
    Weilin Wang. Some comments are also improved.
v2. Address feedback from Adrian Hunter and make kernel-doc work.

Ian Rogers (10):
  perf pmu: Remove is_hybrid member
  perf pmu: Add documentation
  tools lib api fs tracing_path: Add scandir alphasort
  perf tracepoint: Sort events in iterator
  perf list: Generalize limiting to a PMU name
  perf list: Simplify cache event printing
  perf list: Simplify symbol event printing
  perf pmu: Restructure print_pmu_events
  perf list: Reorganize to use callbacks
  perf list: Add json output option

 tools/lib/api/fs/tracing_path.c        |  16 +
 tools/lib/api/fs/tracing_path.h        |   1 +
 tools/perf/Documentation/perf-list.txt |  10 +-
 tools/perf/builtin-list.c              | 525 +++++++++++++++++---
 tools/perf/util/evsel.c                |   5 +-
 tools/perf/util/evsel.h                |   2 +-
 tools/perf/util/metricgroup.c          | 242 +++-------
 tools/perf/util/metricgroup.h          |   4 +-
 tools/perf/util/pmu.c                  | 288 ++++++-----
 tools/perf/util/pmu.h                  | 128 ++++-
 tools/perf/util/print-events.c         | 638 ++++++++++---------------
 tools/perf/util/print-events.h         |  42 +-
 tools/perf/util/stat.c                 |  11 +-
 13 files changed, 1102 insertions(+), 810 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

