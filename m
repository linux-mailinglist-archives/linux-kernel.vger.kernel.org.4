Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC086B62D6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 03:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCLCP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 21:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCLCP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 21:15:56 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B138B61
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:15:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e20-20020a25d314000000b00b33355abd3dso4564872ybf.14
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587355;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DiqHA2sh2qjdCAr0BvIE9FBHTrsJoQpwQKJS30o1Ors=;
        b=oKgHsOgp/LJThxtOOD0BmOMUoxa9vj7/aLhUxYKjIbC+sQBspp+SbeZUjwaK3aR3xQ
         iPRiDp6PNbENy8fnbsYvJHvXSRmsGNHrqrAr0eoVzSJwV+u8ylib2UySB1/nQbERcSeO
         AXXpfYnOm6YaoCLJkjprvjW2+nDkYnfgxFd8P8H1msyGG/RMe1yAw/jxxD2Q5Sxh5TNU
         L54mIw6mL/cbafd4xoXpi22zf73afZwjVnTd3MFxqqMMGhi07pOnHvykYR0vK9VuI+wR
         3H94gjSUI05Prvb3SJOJ0LC4Zl6VmJ3mkzkKAyewdx6b54rbDayKDYE51zlD7gzw0wOc
         +ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587355;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DiqHA2sh2qjdCAr0BvIE9FBHTrsJoQpwQKJS30o1Ors=;
        b=bUgIU8CwZ3ogK8Qp+lyabLJpEmTOGYbu5z5GghUW2k3dEW7KR/FOabq2jccTW4oNju
         R8lDGsPHlJz/xWxkB0VQox+qi1LdrCQlnPFKzfEAWaYjFDOeZC2HAdl9Nj36ULsQiHTz
         z0kjVA8PE+mQVulX2m0lf59GeS0Tu7/sR1hgGRitF9Wx/oc8i5Il2r7ID+L85mkbLgrc
         /vmpWnterERAlQIos7CeaTSlR8LrJiKDstm74O8qeAECdo8AX6yZB5pnZp43WPxcfKmH
         taCyuaClxdQB6h/btYtTDV5AZzTSSndbTQIOYsuqsrHAQRupoi5xa0zg95diysgtUkqn
         1FQA==
X-Gm-Message-State: AO0yUKUZDtRVxqOJ8TnfB7jR4rHkRiQZCp8UtReX82kVq3zxxBwWz05u
        6c7y6S8obewikggC/ggISwDGvDiZGHdJ
X-Google-Smtp-Source: AK7set9NvAk7wdlKpPiZi5gsiSFQeqThHIKtHvjJxz+x9tnLa1bWROIho+Z0sdoVs9Tg4jwmqE/Ybr3gQMHD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a81:7bd5:0:b0:52e:f77a:c3c with SMTP id
 w204-20020a817bd5000000b0052ef77a0c3cmr7ywc.454.1678587354723; Sat, 11 Mar
 2023 18:15:54 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:32 -0800
Message-Id: <20230312021543.3060328-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 00/11] Better fixes for  grouping of events
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

v5. Add Adrian's Acked-by on patch 3, add a fix to the warning logic
    for multiple event groups as reported by Adrian.
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
 tools/perf/util/parse-events.c           | 275 ++++++++++++-----------
 tools/perf/util/parse-events.h           |  14 +-
 tools/perf/util/parse-events.y           |  28 +--
 tools/perf/util/pfm.c                    |   1 -
 tools/perf/util/pmu.c                    |   6 +-
 tools/perf/util/python.c                 |   2 +-
 tools/perf/util/stat-shadow.c            |   2 +-
 26 files changed, 284 insertions(+), 246 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog

