Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE06B00B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCHIRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCHIRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:17:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6814C574D9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:17:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i11-20020a256d0b000000b0086349255277so17040835ybc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263468;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/COzSLgkLIeXn3ru2UHUKbjCwKMR6TuDI+u2ooPKbi0=;
        b=BsZGOfu5fmj7GMyuBNAoLFz0igLDPtb81KRWfh282pq+isIkgREAIZJ4Jwx5ATDWs9
         khwAvhkV9qV+NypYwYilRVyIkVPwMF+XkfUumVJJqembQ5nvLumVsNUoOm1O5UGTOyJg
         cp2jpkhqkT/HbM4kWwQHmw8ZAF69QLul0/NDaOfC9wSHb9MdNfPhNgNkHHzPdcuPXMBv
         J4EMyLQ2Hw3/y9N+7K+qed9eK/XVfCQBlLh3Bsmi10DRXvdYsFgSVHLN/SjbNE/IH9eb
         YqfKWLp2zBZcd/8Q+N21mqHvRChcARMnCuwNUjRkWlOqpNxgvN8Sag0tBwQpIWvhtpJ4
         XddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263468;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/COzSLgkLIeXn3ru2UHUKbjCwKMR6TuDI+u2ooPKbi0=;
        b=vodnO+/+FTVE9ldJzzmrNZoSqIDDf6/h/UR6i+pgidpp6ZM1a6R7LzyYukV99zlJfx
         kHBeW2jI1r7lmkR7qo9fy9slYxGfUo+SyQM8sVIv8zqJ5hlD4cZG7A6O3bLCNMbGesiA
         2/2UPcGm26UuDnt9IouE9CKf97Tl5aH2/fpD6qRDfaRPky6kZI0XbkUU+AE27GMg0dUb
         GpIci65ADJeA5+tWvnG2Hhuy2Lj40NYklSHp4ucl9wiWQRxE3ij916C7iDJmL6pTVvyg
         QEAFU8j5VNs6lEgqGlZhV6cX5VAJZdEWi6pReRzsKq32CNRezVIlK6IHg35YKW/Iv6Pu
         Z0lw==
X-Gm-Message-State: AO0yUKVNuLvk/l3UqedCfg98P1EY59IwngNHpWtTBk/4bhDkuVVUdQih
        lFBmFWCAqV6Crmk1O6yz68brbGuD+2VX
X-Google-Smtp-Source: AK7set+pDqWMUu4JMQMthAW4mpSF29sGDsh32IqJc0ToyH+IKgDK1ATpEZqtfHvM6b2EenSX1smzfdsleT6B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a05:6902:10e:b0:98e:6280:74ca with SMTP id
 o14-20020a056902010e00b0098e628074camr8503055ybh.1.1678263468638; Wed, 08 Mar
 2023 00:17:48 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:20 -0800
Message-Id: <20230308081731.1887278-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 00/11] Better fixes for  grouping of events
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

v3. Rename pmu_name to group_pmu_name and add patch to warn when events are regrouped
    as requested by Namhyung.
v2. Fix up the commit message on 4/10 (thanks Arnaldo). Drop
    unnecessary v1 5/10 (thanks Kan). evlist->core.nr_groups wasn't
    being correctly maintained after the sort/regrouping and so the
    new patch 10/10 removes that variable and computes it from the
    evlist when necessary, generally just tests.

Ian Rogers (11):
  libperf evlist: Avoid a use of evsel idx
  perf stat: Don't remove all grouped events when CPU maps disagree
  perf record: Early auxtrace initialization before event parsing
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
 tools/perf/arch/x86/util/auxtrace.c      |  17 +-
 tools/perf/arch/x86/util/evlist.c        |  39 ++--
 tools/perf/builtin-record.c              |   8 +-
 tools/perf/builtin-report.c              |   2 +-
 tools/perf/builtin-stat.c                |  24 +-
 tools/perf/tests/bpf.c                   |   1 -
 tools/perf/tests/parse-events.c          |  24 +-
 tools/perf/tests/pfm.c                   |  12 +-
 tools/perf/tests/pmu-events.c            |   2 +-
 tools/perf/util/auxtrace.h               |   2 +
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
 26 files changed, 292 insertions(+), 244 deletions(-)

-- 
2.40.0.rc0.216.gc4246ad0f0-goog

