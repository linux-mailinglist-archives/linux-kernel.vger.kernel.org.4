Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E1D6276BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiKNHvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiKNHvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:51:43 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C3718E1C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:51:43 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 36-20020a17090a0fa700b00213d5296e13so5407701pjz.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G6SAmxX7apXJc1sZ6rk+vGVz5JqMggUrClmeEtAw6v8=;
        b=bQwfvaqnGgw3iau0Mqw9WIaSEQ3ScV4gxhh1hWdcHbvItifG7Lgv4sbWAj9/Nvv4hx
         O/BTIUqD6HoaIQqaPYVVgL2NwGzTO8oNGQNSQxroakZnguud1K7UqJC/QbXwLUH6U5Cy
         O/0y4jVcpZHLW9fpNt7kx5BpZuOl1Ne1BLvJIvFHI6lUDgWcS2NTrUympRPdB40vmzA8
         4c1VRCNc2W6oAwMAo2DtDDy+diH0NqDkRe7UUo//EVafVgJCZfjprVhdeopeU23gTCxS
         CFFIoHiXogb+9ZvcHksfSuamruT3nJTlM9g8P8PLWMD59AzMAOBQZxmeS6Pc/5ACjFpb
         ADKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6SAmxX7apXJc1sZ6rk+vGVz5JqMggUrClmeEtAw6v8=;
        b=b4ZICZOgxhBc2dsS0U72Z4xX6k94GpEZM+tfUiPv68WmNvaDAb3QgzpooWxwGMPBe1
         PwSsUbLs1Sd9GAZ4idiDJTvf8BGtiU2aZUzz0LUUfrW04jdXohFOvNdD8kHCrRfD5QEP
         lQSD2Z5lnAWuJijLmXR/jjdJW576EM7GGKlxaLY5W5EKsLwxi/vcoMutXo/CVlOYd0n3
         /pvCymla0GlYLaPedqGYZP26u9UqUWhsI2ghM4eT/q+ZY0BON8TTmFLcg8eRRb3XX3W4
         R1EXe1ZUqRCZeT3KpB2XueaVq/H1mrMqBWvwaRt5c62J7QmSaxKTWeSHUxKk5famwg3A
         nCKQ==
X-Gm-Message-State: ANoB5pnhvZ1h5JXpB+HSVGFtDdwEWZ3015xP6OyfbD+FRN8SKiin/tb/
        8IGruZ3xEOrBZMT7Vu79K9RvK0xY8KUp
X-Google-Smtp-Source: AA0mqf6yrRvPV60i0ASJWQGSbHOO4Xlx2AzyaU1Rn44gk+Qrajc3HzCqBUk4zZ0pL/SPC7wYPWWY7pT0o58h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cba6:8279:98e6:3d6e])
 (user=irogers job=sendgmr) by 2002:a17:902:f80a:b0:186:8376:209f with SMTP id
 ix10-20020a170902f80a00b001868376209fmr12625608plb.161.1668412302667; Sun, 13
 Nov 2022 23:51:42 -0800 (PST)
Date:   Sun, 13 Nov 2022 23:51:18 -0800
Message-Id: <20221114075127.2650315-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 0/9] Restructure perf list and add json output
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
 tools/perf/util/pmu.c                  | 277 +++++------
 tools/perf/util/pmu.h                  | 110 ++++-
 tools/perf/util/print-events.c         | 630 ++++++++++---------------
 tools/perf/util/print-events.h         |  40 +-
 10 files changed, 1034 insertions(+), 795 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

