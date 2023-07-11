Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D3E74EB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGKKCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGKKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:02:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4B0AA9;
        Tue, 11 Jul 2023 03:02:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB2BC2B;
        Tue, 11 Jul 2023 03:03:16 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.29.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41F8B3F67D;
        Tue, 11 Jul 2023 03:02:31 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, john.g.garry@oracle.com
Cc:     namhyung@kernel.org, acme@kernel.org,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] perf vendor events arm64: Update N2 and V2 metrics and events using Arm telemetry repo
Date:   Tue, 11 Jul 2023 11:02:10 +0100
Message-Id: <20230711100218.1651995-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
  * version -> variant in second commit message
  * Add a bit more detail about version matching in the second commit
    message
  * Update the comments in pmu-events/arch/arm64/mapfile.csv to say that
    variant and revision fields are now used
  * Increase the CC list

Changes since v1:
  * Split last change into two so it doesn't hit the mailing list size
    limit

--------

Hi,

This change introduces a new concept for JSON files on Arm where it's
now possible to provide JSONs for multiple versions of a CPU. This
change is in the second commit of the set. It can be used for the case
where a fix is made to how a metric is calculated or the description or
availability of a PMU event etc.

It has the side effect of sorting the pmu_events_map for all platforms
so I want to make sure that nobody thinks that's an issue. I'm pretty
sure there is no dependency on any ordering currently so it should be
fine IMO, but worth thinking about. The sort is always done, rather than
just for Arm, only to simplify the change. But I suppose it also helps
to have consistency there in case any other platform needs to depend on
the ordering in the future.

I don't see this being used very often, or even ever again, so
I don't think it's worth adding any higher level feature that
deduplicates events and metrics that don't change between versions. It's
better to keep it simple and use the existing mechanism, but just treat
different versions of the same CPU as entirely different CPUs.

Thanks
James

James Clark (5):
  perf: cs-etm: Don't duplicate FIELD_GET()
  perf jevents: Match on highest version of Arm json file available
  perf vendor events arm64: Update scale units and descriptions of
    common topdown metrics
  perf vendor events arm64: Update N2-r0p3 and V2 metrics and events
    using Arm telemetry repo
  perf vendor events arm64: Update N2-r0p0 metrics and events using Arm
    telemetry repo

 tools/perf/arch/arm64/util/header.c           |  61 +++-
 .../arch/arm64/arm/neoverse-n2-v2/branch.json |   8 -
 .../arch/arm64/arm/neoverse-n2-v2/bus.json    |  20 --
 .../arch/arm64/arm/neoverse-n2-v2/cache.json  | 155 --------
 .../arm64/arm/neoverse-n2-v2/exception.json   |  47 ---
 .../arm64/arm/neoverse-n2-v2/instruction.json | 143 --------
 .../arch/arm64/arm/neoverse-n2-v2/memory.json |  41 ---
 .../arm64/arm/neoverse-n2-v2/metrics.json     | 273 --------------
 .../arm64/arm/neoverse-n2-v2/pipeline.json    |  23 --
 .../arch/arm64/arm/neoverse-n2-v2/spe.json    |  14 -
 .../arch/arm64/arm/neoverse-n2-v2/trace.json  |  29 --
 .../arch/arm64/arm/neoverse-n2r0p0/bus.json   |  18 +
 .../arm64/arm/neoverse-n2r0p0/exception.json  |  62 ++++
 .../arm/neoverse-n2r0p0/fp_operation.json     |  22 ++
 .../arm64/arm/neoverse-n2r0p0/general.json    |  10 +
 .../arm64/arm/neoverse-n2r0p0/l1d_cache.json  |  54 +++
 .../arm64/arm/neoverse-n2r0p0/l1i_cache.json  |  14 +
 .../arm64/arm/neoverse-n2r0p0/l2_cache.json   |  50 +++
 .../arm64/arm/neoverse-n2r0p0/l3_cache.json   |  22 ++
 .../arm64/arm/neoverse-n2r0p0/ll_cache.json   |  10 +
 .../arm64/arm/neoverse-n2r0p0/memory.json     |  46 +++
 .../arm64/arm/neoverse-n2r0p0/metrics.json    | 332 ++++++++++++++++++
 .../arm64/arm/neoverse-n2r0p0/retired.json    |  30 ++
 .../arch/arm64/arm/neoverse-n2r0p0/spe.json   |  18 +
 .../arm/neoverse-n2r0p0/spec_operation.json   | 110 ++++++
 .../arch/arm64/arm/neoverse-n2r0p0/stall.json |  30 ++
 .../arch/arm64/arm/neoverse-n2r0p0/sve.json   |  50 +++
 .../arch/arm64/arm/neoverse-n2r0p0/tlb.json   |  66 ++++
 .../arch/arm64/arm/neoverse-n2r0p0/trace.json |  38 ++
 .../arm64/arm/neoverse-n2r0p3-v2/bus.json     |  18 +
 .../arm/neoverse-n2r0p3-v2/exception.json     |  62 ++++
 .../arm/neoverse-n2r0p3-v2/fp_operation.json  |  22 ++
 .../arm64/arm/neoverse-n2r0p3-v2/general.json |  10 +
 .../arm/neoverse-n2r0p3-v2/l1d_cache.json     |  54 +++
 .../arm/neoverse-n2r0p3-v2/l1i_cache.json     |  14 +
 .../arm/neoverse-n2r0p3-v2/l2_cache.json      |  50 +++
 .../arm/neoverse-n2r0p3-v2/l3_cache.json      |  22 ++
 .../arm/neoverse-n2r0p3-v2/ll_cache.json      |  10 +
 .../arm64/arm/neoverse-n2r0p3-v2/memory.json  |  46 +++
 .../arm64/arm/neoverse-n2r0p3-v2/metrics.json | 331 +++++++++++++++++
 .../arm64/arm/neoverse-n2r0p3-v2/retired.json |  30 ++
 .../arm64/arm/neoverse-n2r0p3-v2/spe.json     |  18 +
 .../neoverse-n2r0p3-v2/spec_operation.json    | 110 ++++++
 .../arm64/arm/neoverse-n2r0p3-v2/stall.json   |  30 ++
 .../arm64/arm/neoverse-n2r0p3-v2/sve.json     |  50 +++
 .../arm64/arm/neoverse-n2r0p3-v2/tlb.json     |  66 ++++
 .../arm64/arm/neoverse-n2r0p3-v2/trace.json   |  38 ++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |  17 +-
 tools/perf/pmu-events/arch/arm64/sbsa.json    |  24 +-
 tools/perf/pmu-events/jevents.py              |  49 +--
 tools/perf/tests/pmu-events.c                 |  34 ++
 tools/perf/util/cs-etm.c                      |  14 +-
 52 files changed, 2099 insertions(+), 816 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/bus.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/instruction.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/pipeline.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spe.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/trace.json

-- 
2.34.1

