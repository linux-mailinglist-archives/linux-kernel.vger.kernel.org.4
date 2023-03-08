Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48F06B15B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCHW72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCHW70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:59:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D021AFBB4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:59:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i11-20020a256d0b000000b0086349255277so245327ybc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316363;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qq2+WbA4CZB7R5+5mu+QD0vLjVM2X0KIBKUyv0u83m4=;
        b=LfLD77ZHpduvLiNrC1U75xe3jFTFomqIZUMWJ49iMQmXRm3mDbwab7Juk3PoCo6aqo
         YwrVGnocEQ7NUPKP9XtH/8K8vxCnPyxIZcYQuJzdWqtik8FDoZUgUkexltsq/oLN0NZm
         X95qXOHNI73VPrM2AZ66atX95bZEJSXsJYdwGcI54XRxRY4JVVq9CK2l3HoutfgcPuRE
         H+Wg6of+wVveAYQ8+J70/3pp1+3WXOIOTUEQWWN5WKWyT6RcPYL/b0Suq5gyzJQISiYs
         1JV5kMfSYi6D0OxFF1SlPPUEoPFHmGnAfLoB0hqsiovvTv/Sm/cgkhDoe1RGXGF3wn0u
         EO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316363;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qq2+WbA4CZB7R5+5mu+QD0vLjVM2X0KIBKUyv0u83m4=;
        b=O7RorlL525Qz7rDQCgL4aRDTlr52Ig9AFLF2PbjgMCCL+2XYLo7PoxtjbLfZyEsCDc
         yRxE3n8THxp0t/PGtl5olhDe2Zhw/gRaJVu9hh8aF1NPTexdyO3jMGhckjjoPFkwxOCw
         YpZC6nURJeV8d3+xgzinjkHy70yaye8D2cIM+xft5U/Nwh7wHb9kVWNthuh3BxOhZyoW
         4NL8eMBsl63xfBXTwr5IswaF825Bk/BxtdCaMDI0RSd//v2niR3HdC1eauE7Lt+gYW43
         ZdCQasm1V5XL06yHtNQ0DMWfSPLJH1VPY/zIO3Nd0dDlonHwL71oxFkyhKWo0JdD5WHH
         wLwg==
X-Gm-Message-State: AO0yUKUb7QlTNSJBU/WXxH0Nqkg+e4N36Pq/Ekj6ojOvZ3XTjJzn8vef
        2tbjJMSNc+b/OHh6Acu71Lq5NSA1uSi3
X-Google-Smtp-Source: AK7set9TI82AzpgyqtsTt7dn+S+kHo/akNycgOG8+GdhJ6NpnIqqI96aiieVz1xc5TxYGWdEEtfGUAwf6zgF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a81:4ac3:0:b0:527:a386:a4e9 with SMTP id
 x186-20020a814ac3000000b00527a386a4e9mr2ywa.17.1678316363481; Wed, 08 Mar
 2023 14:59:23 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:01 -0800
Message-Id: <20230308225912.1960990-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 00/11] Better fixes for  grouping of events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
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

The rules for grouping events have grown more complex. Topdown events
must be grouped, but flags like --metric-no-group and flags on metrics
don't respect this. Uncore events may be expanded using wild cards for
PMU names, but then the events need reordering so the group members
are adjacent. Rather than fixing metrics, this change fixes the main
event parsing code to first sort and then regroup evsels.

As this is shared functionality changes to it should cause
concern. The change is done with the intent of simplifying and making
more robust the grouping logic, examples are given. If additional
changes are necessary, they are most likely necessary to the
evsel__group_pmu_name logic as the code avoids breaking groups that
are on the same "group" PMU. The group_pmu_name is a variant of the
pmu_name tweaked in the case of software and aux events, that use
groups in a slightly different manner to conventional events.

The code was manually tested as well as passing perf test on a Intel
tigerlake CPU with intel-pt.

v4. Move the Intel pmu->auxtrace initialization to the existing
    perf_pmu__get_default_config as suggested by Adrian Hunter.
v3. Rename pmu_name to group_pmu_name and add patch to warn when
    events are regrouped as requested by Namhyung.
v2. Fix up the commit message on 4/10 (thanks Arnaldo). Drop
    unnecessary v1 5/10 (thanks Kan). evlist->core.nr_groups wasn't
    being correctly maintained after the sort/regrouping and so the
    new patch 10/10 removes that variable and computes it from the
    evlist when necessary, generally just tests.

Ian Rogers (11):
  libperf evlist: Avoid a use of evsel idx
  perf stat: Don't remove all grouped events when CPU maps disagree
  perf pmu: Earlier PMU auxtrace initialization
  perf stat: Modify the group test
  perf evsel: Allow const evsel for certain accesses
  perf evsel: Add function to compute group PMU name
  perf parse-events: Pass ownership of the group name
  perf parse-events: Sort and group parsed events
  perf evsel: Remove use_uncore_alias
  perf evlist: Remove nr_groups
  perf parse-events: Warn when events are regrouped

 tools/lib/perf/evlist.c                  |  31 ++-
 tools/lib/perf/include/internal/evlist.h |   1 -
 tools/lib/perf/include/perf/evlist.h     |   1 +
 tools/perf/arch/x86/util/auxtrace.c      |   4 -
 tools/perf/arch/x86/util/evlist.c        |  39 ++--
 tools/perf/arch/x86/util/pmu.c           |   8 +-
 tools/perf/builtin-record.c              |   2 +-
 tools/perf/builtin-report.c              |   2 +-
 tools/perf/builtin-stat.c                |  24 +-
 tools/perf/tests/bpf.c                   |   1 -
 tools/perf/tests/parse-events.c          |  24 +-
 tools/perf/tests/pfm.c                   |  12 +-
 tools/perf/tests/pmu-events.c            |   2 +-
 tools/perf/util/evlist.c                 |   2 +-
 tools/perf/util/evlist.h                 |   8 +-
 tools/perf/util/evsel.c                  |  27 ++-
 tools/perf/util/evsel.h                  |   8 +-
 tools/perf/util/header.c                 |   3 +-
 tools/perf/util/metricgroup.c            |   3 +-
 tools/perf/util/parse-events.c           | 268 +++++++++++------------
 tools/perf/util/parse-events.h           |  14 +-
 tools/perf/util/parse-events.y           |  28 +--
 tools/perf/util/pfm.c                    |   1 -
 tools/perf/util/pmu.c                    |   6 +-
 tools/perf/util/python.c                 |   2 +-
 tools/perf/util/stat-shadow.c            |   2 +-
 26 files changed, 277 insertions(+), 246 deletions(-)

-- 
2.40.0.rc0.216.gc4246ad0f0-goog

