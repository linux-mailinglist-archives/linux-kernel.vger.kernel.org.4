Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5CE7100AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjEXWSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEXWSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:18:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56D113A
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337a5861so874001276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966715; x=1687558715;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ckN71DQD4uD8g3bwACRokN8CwIA0vhRKAJ7PLkv1+q4=;
        b=tNMaC+10F+kkmfLDfPuAI3mX/14s/R5iY25dJcRJL8BiFPeyFhb3s1WtlRymiFWIqN
         Uu6cZ56oG97CK/QMajIj+PzStD3W55VXj7vIba53+PdKVdjVSo3BOEF15i/EjE3sfBRy
         Sm6hcVw3rXejIS9WyqPaCbbLXD2YAh5sCx9T02qlxpzIqrjtulHajd9NmySMmc6+zbQU
         nXFmYWbrz/SEMSL49qYZ78/t3BgH/ePt/lp/sLLvV0E2WiU3O6Q8N+lkun5raHgn/jQi
         cLVe4VSD9ZkS2Yg7Hu8Nx4NHlG/EONDywvaosKGTt6JtZH6JKRVoznDge2V42r6YQ4R7
         Wstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966715; x=1687558715;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckN71DQD4uD8g3bwACRokN8CwIA0vhRKAJ7PLkv1+q4=;
        b=a5wXPWUbB8je1qm9ceycnE0SQSREBK/ESiPsfukJQyDOV8YJtN8g1lcDGNu5NKgtwn
         3KK0fpHsHZeb/jRLJyAyrVxPcvHN9F3Jxx1N2yWfTcZvZ8IDwIBb7w8tArVvsyRwvqO5
         R0y4WPKZQUSZActJ1bYH3ukfjC8xuohoGsp1eeFhCGUZ2rM4cdIR9qzVPeUU7qJCzHSi
         QGmLZDkgpMrvrHKCcJALhkQWDr6wyY4qj9Eg5UH55vFc2S7jyYPmMKOKAd43fZLjIUxQ
         PjVO+VFl8jNcjxzZij61mpScR4D+Cp6g3Ok4KE0EfWrzIltTMWheEXudB6SZLGyrUKSh
         owrQ==
X-Gm-Message-State: AC+VfDyg9ehJScnAGxtQhBiJ3CccbdjN4UQev13eLDzvi0GaACeJOT/a
        ZqFMPiIcW4U56nomZjFRYQ6rN6TerwL4
X-Google-Smtp-Source: ACHHUZ6l3ZSOKA8KOrdtIoChwsfYDat0YckKrNuxFNC9t/YWBNKaYSFn+VcfYMPeqQah5kNVm6ibbODvTA04
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:d68d:0:b0:ba7:8628:93e2 with SMTP id
 n135-20020a25d68d000000b00ba7862893e2mr585143ybg.4.1684966715077; Wed, 24 May
 2023 15:18:35 -0700 (PDT)
Date:   Wed, 24 May 2023 15:17:56 -0700
Message-Id: <20230524221831.1741381-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 00/35]  PMU refactoring and improvements
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the code in pmu.[ch] into the set/list of PMUs and the code
for a particular PMU. Move the set/list of PMUs code into
pmus.[ch]. Clean up hybrid code and remove hybrid PMU list, it is
sufficient to scan PMUs looking for core ones. Add core PMU list and
perf_pmus__scan_core that just reads core PMUs. Switch code that skips
non-core PMUs during a perf_pmus__scan, to use the
perf_pmus__scan_core variant. Don't scan sysfs for PMUs if all such
PMUs have been previously scanned/loaded. Scanning just core PMUs, for
the cases it is applicable, can improve the sysfs reading time by more
than 4 fold on my laptop, as servers generally have many more uncore
PMUs the improvement there should be larger:

```
$ perf bench internals pmu-scan -i 1000
Computing performance of sysfs PMU event scan for 1000 times
  Average core PMU scanning took: 989.231 usec (+- 1.535 usec)
  Average PMU scanning took: 4309.425 usec (+- 74.322 usec)
```

The patch "perf pmu: Separate pmu and pmus" moves and renames a lot of
functions, and is consequently large. The changes are trivial, but
kept together to keep the overall number of patches more reasonable.

v3. Address fixing hybrid user specified CPU maps by doing it in
    propagate maps. Remove nearly all references to cpu_core/cpu_atom
    in particular by removing is_pmu_hybrid - hybrid is now >1 core
    PMU. Addresses comments by Kan and Namhyung.
v2. Address Kan's review comments wrt "cycles" -> "cycles:P" and
    "uncore_pmus" -> "other_pmus".

Ian Rogers (35):
  perf cpumap: Add intersect function
  perf tests: Organize cpu_map tests into a single suite
  perf cpumap: Add equal function
  libperf cpumap: Add "any CPU"/dummy test function
  perf pmu: Detect ARM and hybrid PMUs with sysfs
  perf pmu: Add is_core to pmu
  perf evsel: Add is_pmu_core inorder to interpret own_cpus
  perf pmu: Add CPU map for "cpu" PMUs
  perf evlist: Propagate user CPU maps intersecting core PMU maps
  perf evlist: Allow has_user_cpus to be set on hybrid
  perf target: Remove unused hybrid value
  perf tools: Warn if no user requested CPUs match PMU's CPUs
  perf evlist: Remove evlist__warn_hybrid_group
  perf evlist: Remove __evlist__add_default
  perf evlist: Reduce scope of evlist__has_hybrid
  perf pmu: Remove perf_pmu__hybrid_mounted
  perf pmu: Rewrite perf_pmu__has_hybrid to avoid list
  perf x86: Iterate hybrid PMUs as core PMUs
  perf topology: Avoid hybrid list for hybrid topology
  perf evsel: Compute is_hybrid from PMU being core
  perf header: Avoid hybrid PMU list in write_pmu_caps
  perf metrics: Remove perf_pmu__is_hybrid use
  perf stat: Avoid hybrid PMU list
  perf mem: Avoid hybrid PMU list
  perf pmu: Remove perf_pmu__hybrid_pmus list
  perf pmus: Prefer perf_pmu__scan over perf_pmus__for_each_pmu
  perf x86 mem: minor refactor to is_mem_loads_aux_event
  perf pmu: Separate pmu and pmus
  perf pmus: Split pmus list into core and other
  perf pmus: Allow just core PMU scanning
  perf pmus: Avoid repeated sysfs scanning
  perf pmus: Ensure all PMUs are read for find_by_type
  perf pmus: Add function to return count of core PMUs
  perf pmus: Remove perf_pmus__has_hybrid
  perf pmu: Remove is_pmu_hybrid

 tools/lib/perf/cpumap.c                 |  61 +++
 tools/lib/perf/evlist.c                 |  25 +-
 tools/lib/perf/include/internal/evsel.h |   9 +
 tools/lib/perf/include/perf/cpumap.h    |  14 +
 tools/perf/arch/arm/util/auxtrace.c     |   7 +-
 tools/perf/arch/arm/util/cs-etm.c       |   4 +-
 tools/perf/arch/arm64/util/pmu.c        |   6 +-
 tools/perf/arch/x86/tests/hybrid.c      |   7 +-
 tools/perf/arch/x86/util/auxtrace.c     |   5 +-
 tools/perf/arch/x86/util/evlist.c       |  25 +-
 tools/perf/arch/x86/util/evsel.c        |  27 +-
 tools/perf/arch/x86/util/intel-bts.c    |   4 +-
 tools/perf/arch/x86/util/intel-pt.c     |   4 +-
 tools/perf/arch/x86/util/mem-events.c   |  17 +-
 tools/perf/arch/x86/util/perf_regs.c    |  15 +-
 tools/perf/arch/x86/util/topdown.c      |   5 +-
 tools/perf/bench/pmu-scan.c             |  60 +--
 tools/perf/builtin-c2c.c                |   9 +-
 tools/perf/builtin-list.c               |   4 +-
 tools/perf/builtin-mem.c                |   9 +-
 tools/perf/builtin-record.c             |  29 +-
 tools/perf/builtin-stat.c               |  14 +-
 tools/perf/builtin-top.c                |  10 +-
 tools/perf/tests/attr.c                 |  11 +-
 tools/perf/tests/builtin-test.c         |   4 +-
 tools/perf/tests/cpumap.c               |  92 ++++-
 tools/perf/tests/event_groups.c         |   7 +-
 tools/perf/tests/parse-events.c         |  15 +-
 tools/perf/tests/parse-metric.c         |   9 +-
 tools/perf/tests/pmu-events.c           |   6 +-
 tools/perf/tests/switch-tracking.c      |  14 +-
 tools/perf/tests/tests.h                |   4 +-
 tools/perf/tests/topology.c             |  16 +-
 tools/perf/util/Build                   |   2 -
 tools/perf/util/cpumap.c                |   4 +-
 tools/perf/util/cpumap.h                |   4 +-
 tools/perf/util/cputopo.c               |  12 +-
 tools/perf/util/env.c                   |   5 +-
 tools/perf/util/evlist-hybrid.c         | 162 --------
 tools/perf/util/evlist-hybrid.h         |  15 -
 tools/perf/util/evlist.c                |  64 +++-
 tools/perf/util/evlist.h                |   9 +-
 tools/perf/util/evsel.c                 |  60 +--
 tools/perf/util/evsel.h                 |   3 -
 tools/perf/util/header.c                |  27 +-
 tools/perf/util/mem-events.c            |  25 +-
 tools/perf/util/metricgroup.c           |   9 +-
 tools/perf/util/parse-events.c          |  25 +-
 tools/perf/util/parse-events.y          |   3 +-
 tools/perf/util/pfm.c                   |   6 +-
 tools/perf/util/pmu-hybrid.c            |  52 ---
 tools/perf/util/pmu-hybrid.h            |  32 --
 tools/perf/util/pmu.c                   | 483 ++----------------------
 tools/perf/util/pmu.h                   |  25 +-
 tools/perf/util/pmus.c                  | 465 ++++++++++++++++++++++-
 tools/perf/util/pmus.h                  |  15 +-
 tools/perf/util/print-events.c          |  15 +-
 tools/perf/util/python-ext-sources      |   1 -
 tools/perf/util/stat-display.c          |  19 +-
 tools/perf/util/target.h                |   1 -
 60 files changed, 1002 insertions(+), 1089 deletions(-)
 delete mode 100644 tools/perf/util/evlist-hybrid.c
 delete mode 100644 tools/perf/util/evlist-hybrid.h
 delete mode 100644 tools/perf/util/pmu-hybrid.c
 delete mode 100644 tools/perf/util/pmu-hybrid.h

-- 
2.40.1.698.g37aff9b760-goog

