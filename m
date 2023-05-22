Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2FF70B539
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjEVGnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjEVGng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:43:36 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34FB0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:34 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1ae4ecb00feso31247175ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737814; x=1687329814;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S7430b4ddDPDsp/gKcCWw21mAqA1WsvOmqKtX0cKL3M=;
        b=sVATGoziwWHqBlvimZy+FgJe2u4jxDgNC/Fj6+FN0ul5FT4ZmkM4KEBpj++7Os1Yik
         7/Q5ZAJKpLtKapISL68mXzMp6vCo1471goZ5SsYHPZRhrKNQfccvIyiOTNjfP76rvTtq
         trs1niOWblAwyl6+LcRoB9oh9NmcPLeVuYOdYnZXQbchruNEvmTBUdjhDW19mxM2BO78
         PYeY22Yx2rY/roCumMdVtQgL3/3SA+VmJbf5RUO/Bwo0I1tDDY1Qx7rfjlpLjuCrqDRQ
         uXZWB9hH0eHUe6wlPejoxI3cciVTP+Tx+K1MDIXrtrflJT/n28k4vIjwjd8f/N04Jsat
         nyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737814; x=1687329814;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7430b4ddDPDsp/gKcCWw21mAqA1WsvOmqKtX0cKL3M=;
        b=WClgNLQgQxcjJ1mE1GToBUA+jBT5sQEX5W01+mLy7CG08kM0jc3Bf5ZrYyEJHfbfYK
         EDOwoQJ45hBrpORHhpp6J56DtWRdkv0JG2lLEVjAk+kM8Bp74n7ngCST/+kCa5DBsfeX
         8BBU9MpvkLIUO5Wl2+mUDxePkmvSXPCWwghAGyNFzza0vZ9bosvmqFHa4Kt5gDe5wRmY
         C3k7wmB4czW1yHSwc2lw2CO0ATNzeLgKUrcSm3Q2zgFkiXKyNS8JnoJw4RyPtbJwEDmg
         YWE6GOPNyeYGIm/kahwLcNPmKp4TZpNC8Sd/uzYrLDklnlOiP45B+ptWXVdtzxVdPU92
         LGZQ==
X-Gm-Message-State: AC+VfDx5EGxBK5P2Oq95VZDcHPy7MwKjoxvHanfP6qXXW22mfSwRxev0
        Y6Q+SqCCfN1PA/5NXKYxlK8VQ5M/dh2a
X-Google-Smtp-Source: ACHHUZ4j0wVMys+QvcfVvE+Pvyw4nsgs4E6gnrRloyc8aLROLhprimdMcRpXpb0wJ5JODlYAeX7k1MVTfcwe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a17:903:284b:b0:1af:93cf:5ffc with SMTP id
 kq11-20020a170903284b00b001af93cf5ffcmr1426171plb.2.1684737814157; Sun, 21
 May 2023 23:43:34 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:07 -0700
Message-Id: <20230522064330.189127-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 00/23] PMU refactoring and improvements
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

v2. Address Kan's review comments wrt "cycles" -> "cycles:P" and
    "uncore_pmus" -> "other_pmus".

Ian Rogers (23):
  perf tools: Warn if no user requested CPUs match PMU's CPUs
  perf evlist: Remove evlist__warn_hybrid_group
  perf evlist: Remove __evlist__add_default
  perf evlist: Reduce scope of evlist__has_hybrid
  perf pmu: Remove perf_pmu__hybrid_mounted
  perf pmu: Detect ARM and hybrid PMUs with sysfs
  perf pmu: Add is_core to pmu
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

 tools/perf/arch/arm/util/auxtrace.c   |   7 +-
 tools/perf/arch/arm/util/cs-etm.c     |   4 +-
 tools/perf/arch/arm64/util/pmu.c      |   6 +-
 tools/perf/arch/x86/tests/hybrid.c    |   7 +-
 tools/perf/arch/x86/util/auxtrace.c   |   5 +-
 tools/perf/arch/x86/util/evlist.c     |  25 +-
 tools/perf/arch/x86/util/evsel.c      |  27 +-
 tools/perf/arch/x86/util/intel-bts.c  |   4 +-
 tools/perf/arch/x86/util/intel-pt.c   |   4 +-
 tools/perf/arch/x86/util/mem-events.c |  17 +-
 tools/perf/arch/x86/util/perf_regs.c  |  15 +-
 tools/perf/arch/x86/util/topdown.c    |   5 +-
 tools/perf/bench/pmu-scan.c           |  60 ++--
 tools/perf/builtin-c2c.c              |   9 +-
 tools/perf/builtin-list.c             |   4 +-
 tools/perf/builtin-mem.c              |   9 +-
 tools/perf/builtin-record.c           |  29 +-
 tools/perf/builtin-stat.c             |  15 +-
 tools/perf/builtin-top.c              |  10 +-
 tools/perf/tests/attr.c               |   4 +-
 tools/perf/tests/event_groups.c       |   7 +-
 tools/perf/tests/parse-events.c       |  15 +-
 tools/perf/tests/parse-metric.c       |   4 +-
 tools/perf/tests/pmu-events.c         |   6 +-
 tools/perf/tests/switch-tracking.c    |   4 +-
 tools/perf/tests/topology.c           |   4 +-
 tools/perf/util/Build                 |   2 -
 tools/perf/util/cpumap.h              |   2 +-
 tools/perf/util/cputopo.c             |  16 +-
 tools/perf/util/env.c                 |   5 +-
 tools/perf/util/evlist-hybrid.c       | 162 ---------
 tools/perf/util/evlist-hybrid.h       |  15 -
 tools/perf/util/evlist.c              |  67 +++-
 tools/perf/util/evlist.h              |   9 +-
 tools/perf/util/evsel.c               |  57 +--
 tools/perf/util/evsel.h               |   3 -
 tools/perf/util/header.c              |  27 +-
 tools/perf/util/mem-events.c          |  17 +-
 tools/perf/util/metricgroup.c         |   9 +-
 tools/perf/util/parse-events.c        |  24 +-
 tools/perf/util/parse-events.y        |   3 +-
 tools/perf/util/pfm.c                 |   6 +-
 tools/perf/util/pmu-hybrid.c          |  52 ---
 tools/perf/util/pmu-hybrid.h          |  32 --
 tools/perf/util/pmu.c                 | 482 ++------------------------
 tools/perf/util/pmu.h                 |  26 +-
 tools/perf/util/pmus.c                | 477 ++++++++++++++++++++++++-
 tools/perf/util/pmus.h                |  15 +-
 tools/perf/util/print-events.c        |  15 +-
 tools/perf/util/python-ext-sources    |   1 -
 tools/perf/util/stat-display.c        |  21 +-
 51 files changed, 819 insertions(+), 1032 deletions(-)
 delete mode 100644 tools/perf/util/evlist-hybrid.c
 delete mode 100644 tools/perf/util/evlist-hybrid.h
 delete mode 100644 tools/perf/util/pmu-hybrid.c
 delete mode 100644 tools/perf/util/pmu-hybrid.h

-- 
2.40.1.698.g37aff9b760-goog

