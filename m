Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B436A8BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjCBWWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCBWWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:22:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A4F47423
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:22:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x64-20020a25ce43000000b00ae6d5855d78so372470ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677795724;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ToIbaMj5AqTB1LrmzVhyr0yCG3hmCJZiHtcXsiBUWn0=;
        b=bK/Ou+IvLW7si3X25Me0v/zKve3PMk5q3JVIBNXG+5bZjYHwevtKgqCOITdHRtomfs
         kqYzAXKVoNBF7KaqTg7+BpBH5dc/G1z+0B74qn3wGfRqRVmZE+nyyp9XBL+Aai2XJnJw
         Yc0aCxSaSUeZMPOOLxwe2ZLJop1u5Ib4NKTG5BA98kGZKwRNjz70ExMsZJ5DwJAWihCQ
         ektC4WRijV78PufKzYTHT3oxFIjn7zORbRMV5n/a5s2yP4yOHAxG9OuCy2SGOyqannFM
         oUW23lewgRwXliqM24/TBTEkUlQxZFkJtjpxi7PE6HSQKHW0Phhxpqelzef6wwrHX7Lc
         n+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677795724;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToIbaMj5AqTB1LrmzVhyr0yCG3hmCJZiHtcXsiBUWn0=;
        b=oGzxmfPiMgLwzFBgk2DdDmLKzzvhkC1msMa4wtwh6K9gl4j8BSvFvbpt0n+flcjvFH
         cOlKW3t/GLx9N3pmIliT5U3EZAVIXMdHfSQxKbSZ7IWoLx6Xyz0EoUAlqYSPk9mi1sg0
         Yp6LXA0doZXfE+wCh+QQZ3bG/sB2IS1lYEpMowmUNYBUlEyzz5cIIaXv21tmBF0qjoBi
         CXVEXLxb/Q4mdO5JsDyZFVauVS/u7uy7lIUPcAlJXkAM+jDaBqa32V3lnagNokEumn8Y
         josmFfeT6196D0DCo5WofaoFn6rf7B4UM+tddUzqs632BMpqxf0uGTkx7/MEaW00EfvB
         ul/Q==
X-Gm-Message-State: AO0yUKW4XghuwOhDx0APAKHgHygswIHs+VnGkAc3yx/SFOViI/l37HpJ
        /9WrinlQ4wGQRT525rcN0hdy7CFcEVeI
X-Google-Smtp-Source: AK7set+74b/Jodt3t/RYWA8tUfU7KmkGxFW2btv6V1hUUOgY23HbfXPR8ohDHGGONCz9C522bsOXeXAt30U/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a5b:1cb:0:b0:9f5:af8a:3b61 with SMTP id
 f11-20020a5b01cb000000b009f5af8a3b61mr6433739ybp.4.1677792348374; Thu, 02 Mar
 2023 13:25:48 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:21 -0800
Message-Id: <20230302212531.1043318-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 00/10] Better fixes for  grouping of events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rules for grouping events has grown more complex. Topdown events
must be grouped, but flags like --metric-no-group and flags on metrics
don't respect this. Uncore events may be expanded using wild cards for
PMU names, but then the events need reordering so the group members
are adjacent. Rather than fixing metrics, this change fixes the main
event parsing code to first sort and then regroup evsels.

As this is shared functionality changes to it should cause
concern. The change is done with the intent of simplifying and making
more robust the grouping logic, examples are given. If additional
changes are necessary, they are most likely necessary to the
evsel__pmu_name logic as the code avoids breaking groups that are on
the same PMU. The pmu_name is tweaked in the case of software and aux
events, that use groups in a slightly different manner to conventional
events.

The code was manually tested as well as passing perf test on a Intel
tigerlake CPU with intel-pt.

v2. Fix up the commit message on 4/10 (thanks Arnaldo). Drop
    unnecessary v1 5/10 (thanks Kan). evlist->core.nr_groups wasn't
    being correctly maintained after the sort/regrouping and so the
    new patch 10/10 removes that variable and computes it from the
    evlist when necessary, generally just tests.

Ian Rogers (10):
  libperf evlist: Avoid a use of evsel idx
  perf stat: Don't remove all grouped events when CPU maps disagree
  perf record: Early auxtrace initialization before event parsing
  perf stat: Modify the group test
  perf evsel: Allow const evsel for certain accesses
  perf evsel: Add function to compute pmu_name
  perf parse-events: Pass ownership of the group name
  perf parse-events: Sort and group parsed events
  perf evsel: Remove use_uncore_alias
  perf evlist: Remove nr_groups

 tools/lib/perf/evlist.c                  |  31 ++-
 tools/lib/perf/include/internal/evlist.h |   1 -
 tools/lib/perf/include/perf/evlist.h     |   1 +
 tools/perf/arch/x86/util/auxtrace.c      |  17 +-
 tools/perf/arch/x86/util/evlist.c        |  39 ++--
 tools/perf/builtin-record.c              |   8 +-
 tools/perf/builtin-report.c              |   2 +-
 tools/perf/builtin-stat.c                |  24 ++-
 tools/perf/tests/bpf.c                   |   1 -
 tools/perf/tests/parse-events.c          |  22 +-
 tools/perf/tests/pfm.c                   |  12 +-
 tools/perf/util/auxtrace.h               |   2 +
 tools/perf/util/evlist.c                 |   2 +-
 tools/perf/util/evlist.h                 |   8 +-
 tools/perf/util/evsel.c                  |  27 ++-
 tools/perf/util/evsel.h                  |   8 +-
 tools/perf/util/header.c                 |   3 +-
 tools/perf/util/parse-events.c           | 254 +++++++++++------------
 tools/perf/util/parse-events.h           |   7 +-
 tools/perf/util/parse-events.y           |  27 +--
 tools/perf/util/pfm.c                    |   1 -
 tools/perf/util/pmu.c                    |   6 +-
 tools/perf/util/python.c                 |   2 +-
 tools/perf/util/stat-shadow.c            |   2 +-
 24 files changed, 270 insertions(+), 237 deletions(-)

-- 
2.40.0.rc0.216.gc4246ad0f0-goog

