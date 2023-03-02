Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39A66A7A4E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 05:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCBEMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 23:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBEMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:12:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC6444A4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 20:12:37 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o3-20020a257303000000b00a131264017aso2814072ybc.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 20:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730356;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9LAF/AgK1HRYrzi87aj0ZroDBvPnZklwy00LEUIfbuo=;
        b=CPfp8goIzicDcS9LgF3shufrgSj4gAVtdqdQCkjveYkYtd+xXUW+MJN1gUC6qCnokc
         dP2+dLPHZzpcAhqmyCXrs+xxDsCscpum0pL8YvQPgdmHg39/KqCrdL+ioIV2nfASnBom
         xFPsZxfRSH5T2O4DJXDWqANz7sD2FvuWUZRmb/EBXTwIWIflLLJCu0Zuz29s6qRGmHeT
         aMVVtMkuxHYaXQR0GXY7bKELBtXj/GSGddlEn9Ci60/AAsZ9N0hyIDlQap3yMp2tgDWF
         2FAT03oYpxxWd1cU1lrNJFotT/4srvQkpLyyZ5gdruq9Uu6ulMtFB4ltT5zPBe6y9JMk
         LpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730356;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LAF/AgK1HRYrzi87aj0ZroDBvPnZklwy00LEUIfbuo=;
        b=dA6wmPw43pSXOdBPHa5Bj6cppm6bVTuifUn0udpWweqln6J8N4953MzILtwu/1cnlb
         I0120DscI6pu+dqZ8H/Elia6Zc/kFdnlFK7cG7sTXhQdBw2Oxm8Zy2IbemLpFfaQqk3l
         mF6CQ3taGua7+bJ2+1s+T+rzfoN+hP6ORzcjWzMTjGLLtCv+U5qixkgbaJkcptQ4eMyZ
         /JesJ8lye+9bMIuSrosAlFM/gXf3u5jas91BGEsrk+5yMKEp+l9bcWCbZM4XPWItGD6t
         cWNvpBJCx5V9c5z2f+zt3NVMb8wu+IuqS17oe7VeYOKnsvEOClHZPMpK2QnA0NxvOZUH
         sbbw==
X-Gm-Message-State: AO0yUKXr7AdYxoXjR1VjRfVyPVJ39e7s+t+dOToueWfg4j2WpveXlXrQ
        9rysMjWxLzmnmyH9IbMtG0919VgbEFJ+
X-Google-Smtp-Source: AK7set9B05gBEoUSyInp6RerniFlMwoQQi++2P7JiMO6aVzPT3ulpltquldvz486F4UNhwF4d4jx94UQet5C
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a81:ac61:0:b0:53c:7047:14c4 with SMTP id
 z33-20020a81ac61000000b0053c704714c4mr2497162ywj.8.1677730356300; Wed, 01 Mar
 2023 20:12:36 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:01 -0800
Message-Id: <20230302041211.852330-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 00/10] Better fixes for  grouping of events
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
        Qi Liu <liuqi115@huawei.com>,
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

Ian Rogers (10):
  libperf evlist: Avoid a use of evsel idx
  perf stat: Don't remove all grouped events when CPU maps disagree
  perf record: Early auxtrace initialization before event parsing
  perf stat: Modify the group test
  perf evsel: Limit in group test to CPUs
  perf evsel: Allow const evsel for certain accesses
  perf evsel: Add function to compute pmu_name
  perf parse-events: Pass ownership of the group name
  perf parse-events: Sort and group parsed events
  perf evsel: Remove use_uncore_alias

 tools/lib/perf/evlist.c             |  13 +-
 tools/perf/arch/x86/util/auxtrace.c |  17 +-
 tools/perf/arch/x86/util/evlist.c   |  39 ++---
 tools/perf/arch/x86/util/evsel.c    |   3 +
 tools/perf/builtin-record.c         |   6 +
 tools/perf/builtin-stat.c           |  24 ++-
 tools/perf/util/auxtrace.h          |   2 +
 tools/perf/util/evlist.h            |   2 +-
 tools/perf/util/evsel.c             |  27 ++-
 tools/perf/util/evsel.h             |   8 +-
 tools/perf/util/parse-events.c      | 253 +++++++++++++---------------
 tools/perf/util/parse-events.h      |   6 +-
 tools/perf/util/parse-events.y      |  17 +-
 tools/perf/util/pmu.c               |   6 +-
 tools/perf/util/python.c            |   2 +-
 tools/perf/util/stat-shadow.c       |   2 +-
 16 files changed, 228 insertions(+), 199 deletions(-)

-- 
2.39.2.722.g9855ee24e9-goog

