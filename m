Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2713F62880E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiKNSNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbiKNSNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FD627CFA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:13:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t37-20020a252d25000000b006dcab0e0650so11190752ybt.23
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lOO9C7JbCmkD1UBVZhc67PcVihTD9v0alGeZxPKLO3A=;
        b=ibO/iIFTGjanA6GA/lOfrzAyxKO5GHieanh/jSZ55L5rgRPKAMtZe+9I8Y4RNoGDzI
         BH2oC+kglLsPL0SVwn+DeGgXC5ZoXlPWF11knUMhKtbaBxb4Vfc71PfWtnWIlaItAjbW
         mgXc0QUs4wxKbH0p/H6M/EuEBWJOXHMQVgawwVFFwMIZhdNBLemxDnlhX6fiNPd8Ed2f
         ADaaWJdNuLyXXwxdG49DaescQXLpbsulN0CD85jLEdh2jhImq9Kz+XE07sgDhrWRw1MM
         gWdyPPYpPG5TML6dQCUL+er6xNDPM1fpCtIQMgxNyMKpk/oyFCRTgPo15SIOIJ6RNxsS
         S8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lOO9C7JbCmkD1UBVZhc67PcVihTD9v0alGeZxPKLO3A=;
        b=idT1cntFyG6gM4O4OO9+ird+SpfWmpxvgJY0SCE50aErZ/OAL3DOgHg1Y+SFfI2qdS
         W7xtTif8xJjuG5yjVFW2PiTledpWJQKMfM3ZR4WtE0T0yqhhy6GrwppEm2xZGvpXPGBZ
         0uU52Ge59LFoVjo1qAPjqLLuT2uriJMVUfGkJVbDtVmJ4JqJvYDnhjIOiXaAuJkc7yKz
         Ftxg2VyIXti0pmgW3an+4iwAXm8UtmwqAeEjejQwIS63JRf0aLgjrwIv61jt2pPuIFAT
         lvLL9VOeSGRvBO76eldGZ82ycQxbKAnhcWmb88XDx9DI/QKh9ySJmMZFpVlBEYXvca0u
         V3Cw==
X-Gm-Message-State: ANoB5pmz+WSG53JwxUaq3tgRPoQ9Ar3XGJrT3HYSWEUvQPffNTxAI3No
        O39BEKySGv7wotlJzi5rIktXW70rPhEq
X-Google-Smtp-Source: AA0mqf7MNZsL+9wa64JdJ0Hw2HcuMtgE8QV7P0ONuqSOPgqBRpvEE6y9979LmBwFiTKEVD2AM3He6ijDzbAN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a05:6902:18a:b0:6e0:4bb5:b391 with SMTP id
 t10-20020a056902018a00b006e04bb5b391mr0ybh.533.1668449587340; Mon, 14 Nov
 2022 10:13:07 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:12:42 -0800
Message-Id: <20221114181251.2683871-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 0/9] Restructure perf list and add json output
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

v2. Address feedback from Adrian Hunter <adrian.hunter@intel.com> and
    make kerneldoc work.

Ian Rogers (9):
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
 tools/perf/builtin-list.c              | 503 +++++++++++++++++---
 tools/perf/util/metricgroup.c          | 238 +++-------
 tools/perf/util/metricgroup.h          |   4 +-
 tools/perf/util/pmu.c                  | 279 +++++------
 tools/perf/util/pmu.h                  | 128 ++++-
 tools/perf/util/print-events.c         | 630 ++++++++++---------------
 tools/perf/util/print-events.h         |  40 +-
 10 files changed, 1054 insertions(+), 795 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

