Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9928F7132E6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjE0HWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjE0HWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:22:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEF2125
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba87bd29e9dso1994383276.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172152; x=1687764152;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NGWf+L/VcfKupqK7RDYqdaWUdhRLep+TBxkX8UJHW6M=;
        b=MEzQsh4plHzLOcg0/U2n7THihasp1FbgrIzFLLb0Etu8rnl7jblXx8JL3Ps++9oZsQ
         rtUL2l32AfsiiTbPhEEvmZ4y364F2Bh3Eg3tQlqUykwAJV96hJW+PQDusC/21QJph/3r
         cxJZUPpPuh8L4DexuF8kKNqM/g3zgNDGeL5EaGURRWsJ8dtGViG+fR6tTJ8sH6TZAcTq
         Skvj9pkfpaqFHwI2G5monT41yYhu1LPUHgcKPlrQR2sAnZymFQScKjXUjjBCx81L524H
         kWQ2umvKDOlR2drwOduAyR4XoU65FfQS96Bj87ms+gwGtvN0+RNYOFYyQ/VFA5XZgUmK
         kbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172152; x=1687764152;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGWf+L/VcfKupqK7RDYqdaWUdhRLep+TBxkX8UJHW6M=;
        b=CqpZNX83YUQBsy2NtMkWKpSJcVnQWuMh9q/5MUzow4K5kj9R2PURP9GKA2t+Q4FIWB
         0sbSPr42HbZKj8GOTgmaQ0CAPkmj7VCfgeq59CaVI9XUOkEH43cJwv+ZZhxnRqob/nD3
         uMcD8HAyy6zRWMVmRag5krqsJfkC/8rZK4X0VvWo9vgpSs4xj+DH9CM96SCclayOB1qx
         LHbEXHzlmGH1JzRm+1zUlxg/NWx5Mu2jrG2STNZ6xdiB2v5yCc0fTP1xRuPm4+UN3UOM
         k1v3jpLPrT4mRaIwlw83jQxyj/oPMn3elhR3ha5XQV7DjZtP7a79zs5qWPc7gzLuQDNA
         oGQg==
X-Gm-Message-State: AC+VfDxmBWVViLpHB2PORojcsxDCY4k6gdhUbgOAUxDwIZTCM5aI4Umj
        4IDu9Et+9oXEjJVTC80vlpmmmOhafZCR
X-Google-Smtp-Source: ACHHUZ63IAJGh1PlsIPDQbimPXfhJjI0hTsX+sAHIiV/TCgtai6V2rd4xbPRvIR/YoJUgHZjA66wrHJFY1Es
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:ad83:0:b0:ba9:9a4f:a40 with SMTP id
 z3-20020a25ad83000000b00ba99a4f0a40mr2289016ybi.13.1685172152019; Sat, 27 May
 2023 00:22:32 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:36 -0700
Message-Id: <20230527072210.2900565-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 00/34] PMU refactoring and improvements
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

v5. Add helper functions for cpumap as suggested by Arnaldo. Fixes
    missing symbols in importing perf into python, found by building
    with:
    https://lore.kernel.org/lkml/20230527055517.2711487-1-irogers@google.com/
v4. On patch 16 (perf pmu: Remove perf_pmu__hybrid_mounted) remove the
    handling of no cpus for a hybrid core PMU following discussion
    with Kan:
    https://lore.kernel.org/lkml/20230524221831.1741381-17-irogers@google.com/
    On patch 9 (perf evlist: Propagate user CPU maps intersecting core
    PMU maps) fix the comment on struct perf_evsel's system_wide
    variable from conversation with Namhyung:
    https://lore.kernel.org/lkml/20230524221831.1741381-10-irogers@google.com/
    Adds Kan's reviewed-by.
v3. Address fixing hybrid user specified CPU maps by doing it in
    propagate maps. Remove nearly all references to cpu_core/cpu_atom
    in particular by removing is_pmu_hybrid - hybrid is now >1 core
    PMU. Addresses comments by Kan and Namhyung.
v2. Address Kan's review comments wrt "cycles" -> "cycles:P" and
    "uncore_pmus" -> "other_pmus".

Ian Rogers (34):
  perf cpumap: Add internal nr and cpu accessors
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

 tools/lib/perf/cpumap.c                 | 100 +++--
 tools/lib/perf/evlist.c                 |  25 +-
 tools/lib/perf/include/internal/evsel.h |  15 +-
 tools/lib/perf/include/perf/cpumap.h    |  12 +
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
 tools/perf/tests/cpumap.c               |  37 ++
 tools/perf/tests/event_groups.c         |   7 +-
 tools/perf/tests/parse-events.c         |  15 +-
 tools/perf/tests/parse-metric.c         |   9 +-
 tools/perf/tests/pmu-events.c           |   6 +-
 tools/perf/tests/switch-tracking.c      |  14 +-
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
 tools/perf/util/pmu.c                   | 470 +-----------------------
 tools/perf/util/pmu.h                   |  25 +-
 tools/perf/util/pmus.c                  | 465 ++++++++++++++++++++++-
 tools/perf/util/pmus.h                  |  15 +-
 tools/perf/util/print-events.c          |  15 +-
 tools/perf/util/python-ext-sources      |   1 -
 tools/perf/util/python.c                |  14 +
 tools/perf/util/stat-display.c          |  19 +-
 tools/perf/util/target.h                |   1 -
 59 files changed, 960 insertions(+), 1112 deletions(-)
 delete mode 100644 tools/perf/util/evlist-hybrid.c
 delete mode 100644 tools/perf/util/evlist-hybrid.h
 delete mode 100644 tools/perf/util/pmu-hybrid.c
 delete mode 100644 tools/perf/util/pmu-hybrid.h

-- 
2.41.0.rc0.172.g3f132b7071-goog

