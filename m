Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9D6C111D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCTLq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjCTLqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:46:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE78522039;
        Mon, 20 Mar 2023 04:46:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59B98FEC;
        Mon, 20 Mar 2023 04:47:17 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.18.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6B893F67D;
        Mon, 20 Mar 2023 04:46:29 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        john.g.garry@oracle.com
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf vendor events arm64: Add N1 metrics
Date:   Mon, 20 Mar 2023 11:45:59 +0000
Message-Id: <20230320114601.524958-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generated from the telemetry solution repo[1] with this command:

  ./generate.py <linux-repo>/tools/perf/ --telemetry-files \
    ../../data/pmu/cpu/neoverse/neoverse-n1.json

Since this data source now includes the SPE events for N1, it has
diverged from A76 which means the folder has to be split.

The new data also uses more fine grained grouping, but this will be
consistent for all future products. Long PublicDescriptions are now
included even for common events because this can include product
specific details. For non verbose mode the common BriefDescriptions
remain the same.

[1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../{cortex-a76-n1 => cortex-a76}/branch.json |   0
 .../{cortex-a76-n1 => cortex-a76}/bus.json    |   0
 .../{cortex-a76-n1 => cortex-a76}/cache.json  |   0
 .../exception.json                            |   0
 .../instruction.json                          |   0
 .../{cortex-a76-n1 => cortex-a76}/memory.json |   0
 .../pipeline.json                             |   0
 .../arch/arm64/arm/neoverse-n1/bus.json       |  18 ++
 .../arch/arm64/arm/neoverse-n1/exception.json |  62 +++++
 .../arch/arm64/arm/neoverse-n1/general.json   |   6 +
 .../arch/arm64/arm/neoverse-n1/l1d_cache.json |  50 ++++
 .../arch/arm64/arm/neoverse-n1/l1i_cache.json |  10 +
 .../arch/arm64/arm/neoverse-n1/l2_cache.json  |  46 ++++
 .../arch/arm64/arm/neoverse-n1/l3_cache.json  |  18 ++
 .../arch/arm64/arm/neoverse-n1/ll_cache.json  |  10 +
 .../arch/arm64/arm/neoverse-n1/memory.json    |  22 ++
 .../arch/arm64/arm/neoverse-n1/metrics.json   | 219 ++++++++++++++++++
 .../arch/arm64/arm/neoverse-n1/retired.json   |  26 +++
 .../arch/arm64/arm/neoverse-n1/spe.json       |  18 ++
 .../arm64/arm/neoverse-n1/spec_operation.json | 102 ++++++++
 .../arch/arm64/arm/neoverse-n1/stall.json     |  10 +
 .../arch/arm64/arm/neoverse-n1/tlb.json       |  66 ++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   4 +-
 23 files changed, 685 insertions(+), 2 deletions(-)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/branch.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/bus.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/cache.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/exception.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/instruction.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/memory.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/pipeline.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/tlb.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/branch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/branch.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/bus.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/bus.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/cache.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/cache.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/exception.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/exception.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/instruction.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/instruction.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/memory.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/pipeline.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/pipeline.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/bus.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/bus.json
new file mode 100644
index 000000000000..2e11a8c4a484
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/bus.json
@@ -0,0 +1,18 @@
+[
+    {
+        "ArchStdEvent": "BUS_ACCESS",
+        "PublicDescription": "Counts memory transactions issued by the CPU to the external bus, including snoop requests and snoop responses. Each beat of data is counted individually."
+    },
+    {
+        "ArchStdEvent": "BUS_CYCLES",
+        "PublicDescription": "Counts bus cycles in the CPU. Bus cycles represent a clock cycle in which a transaction could be sent or received on the interface from the CPU to the external bus. Since that interface is driven at the same clock speed as the CPU, this event is a duplicate of CPU_CYCLES."
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD",
+        "PublicDescription": "Counts memory read transactions seen on the external bus. Each beat of data is counted individually."
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_WR",
+        "PublicDescription": "Counts memory write transactions seen on the external bus. Each beat of data is counted individually."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/exception.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/exception.json
new file mode 100644
index 000000000000..4404b8e91690
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/exception.json
@@ -0,0 +1,62 @@
+[
+    {
+        "ArchStdEvent": "EXC_TAKEN",
+        "PublicDescription": "Counts any taken architecturally visible exceptions such as IRQ, FIQ, SError, and other synchronous exceptions. Exceptions are counted whether or not they are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_RETURN",
+        "PublicDescription": "Counts any architecturally executed exception return instructions. Eg: AArch64: ERET"
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF",
+        "PublicDescription": "Counts the number of synchronous exceptions which are taken locally that are due to attempting to execute an instruction that is UNDEFINED. Attempting to execute instruction bit patterns that have not been allocated. Attempting to execute instructions when they are disabled. Attempting to execute instructions at an inappropriate Exception level. Attempting to execute an instruction when the value of PSTATE.IL is 1."
+    },
+    {
+        "ArchStdEvent": "EXC_SVC",
+        "PublicDescription": "Counts SVC exceptions taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT",
+        "PublicDescription": "Counts synchronous exceptions that are taken locally and caused by Instruction Aborts."
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT",
+        "PublicDescription": "Counts exceptions that are taken locally and are caused by data aborts or SErrors. Conditions that could cause those exceptions are attempting to read or write memory where the MMU generates a fault, attempting to read or write memory with a misaligned address, interrupts from the nSEI inputs and internally generated SErrors."
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ",
+        "PublicDescription": "Counts IRQ exceptions including the virtual IRQs that are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ",
+        "PublicDescription": "Counts FIQ exceptions including the virtual FIQs that are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_SMC",
+        "PublicDescription": "Counts SMC exceptions take to EL3."
+    },
+    {
+        "ArchStdEvent": "EXC_HVC",
+        "PublicDescription": "Counts HVC exceptions taken to EL2."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT",
+        "PublicDescription": "Counts exceptions which are traps not taken locally and are caused by Instruction Aborts. For example, attempting to execute an instruction with a misaligned PC."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT",
+        "PublicDescription": "Counts exceptions which are traps not taken locally and are caused by Data Aborts or SError interrupts. Conditions that could cause those exceptions are:\n\n1. Attempting to read or write memory where the MMU generates a fault,\n2. Attempting to read or write memory with a misaligned address,\n3. Interrupts from the SEI input.\n4. internally generated SErrors."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER",
+        "PublicDescription": "Counts the number of synchronous trap exceptions which are not taken locally and are not SVC, SMC, HVC, data aborts, Instruction Aborts, or interrupts."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ",
+        "PublicDescription": "Counts IRQ exceptions including the virtual IRQs that are not taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ",
+        "PublicDescription": "Counts FIQs which are not taken locally but taken from EL0, EL1,\n or EL2 to EL3 (which would be the normal behavior for FIQs when not executing\n in EL3)."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/general.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/general.json
new file mode 100644
index 000000000000..20fada95ef97
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/general.json
@@ -0,0 +1,6 @@
+[
+    {
+        "ArchStdEvent": "CPU_CYCLES",
+        "PublicDescription": "Counts CPU clock cycles (not timer cycles). The clock measured by this event is defined as the physical clock driving the CPU logic."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json
new file mode 100644
index 000000000000..6cd0b3ba5010
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json
@@ -0,0 +1,50 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL",
+        "PublicDescription": "Counts level 1 data cache refills caused by speculatively executed load or store operations that missed in the level 1 data cache. This event only counts one event per cache line. This event does not count cache line allocations from preload instructions or from hardware cache prefetching."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE",
+        "PublicDescription": "Counts level 1 data cache accesses from any load/store operations. Atomic operations that resolve in the CPUs caches (near atomic operations) counts as both a write access and read access. Each access to a cache line is counted including the multiple accesses caused by single instructions such as LDM or STM. Each access to other level 1 data or unified memory structures, for example refill buffers, write buffers, and write-back buffers, are also counted."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB",
+        "PublicDescription": "Counts write-backs of dirty data from the L1 data cache to the L2 cache. This occurs when either a dirty cache line is evicted from L1 data cache and allocated in the L2 cache or dirty data is written to the L2 and possibly to the next level of cache. This event counts both victim cache line evictions and cache write-backs from snoops or cache maintenance operations. The following cache operations are not counted:\n\n1. Invalidations which do not result in data being transferred out of the L1 (such as evictions of clean data),\n2. Full line writes which write to L2 without writing L1, such as write streaming mode."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RD",
+        "PublicDescription": "Counts level 1 data cache accesses from any load operation. Atomic load operations that resolve in the CPUs caches counts as both a write access and read access."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR",
+        "PublicDescription": "Counts level 1 data cache accesses generated by store operations. This event also counts accesses caused by a DC ZVA (data cache zero, specified by virtual address) instruction. Near atomic operations that resolve in the CPUs caches count as a write access and read access."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
+        "PublicDescription": "Counts level 1 data cache refills caused by speculatively executed load instructions where the memory read operation misses in the level 1 data cache. This event only counts one event per cache line."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
+        "PublicDescription": "Counts level 1 data cache refills caused by speculatively executed store instructions where the memory write operation misses in the level 1 data cache. This event only counts one event per cache line."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
+        "PublicDescription": "Counts level 1 data cache refills where the cache line data came from caches inside the immediate cluster of the core."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
+        "PublicDescription": "Counts level 1 data cache refills for which the cache line data came from outside the immediate cluster of the core, like an SLC in the system interconnect or DRAM."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
+        "PublicDescription": "Counts dirty cache line evictions from the level 1 data cache caused by a new cache line allocation. This event does not count evictions caused by cache maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
+        "PublicDescription": "Counts write-backs from the level 1 data cache that are a result of a coherency operation made by another CPU. Event count includes cache maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+        "PublicDescription": "Counts each explicit invalidation of a cache line in the level 1 data cache caused by:\n\n- Cache Maintenance Operations (CMO) that operate by a virtual address.\n- Broadcast cache coherency operations from another CPU in the system.\n\nThis event does not count for the following conditions:\n\n1. A cache refill invalidates a cache line.\n2. A CMO which is executed on that CPU and invalidates a cache line specified by set/way.\n\nNote that CMOs that operate by set/way cannot be broadcast from one CPU to another."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1i_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1i_cache.json
new file mode 100644
index 000000000000..e719b6e7fa77
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1i_cache.json
@@ -0,0 +1,10 @@
+[
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL",
+        "PublicDescription": "Counts cache line refills in the level 1 instruction cache caused by a missed instruction fetch. Instruction fetches may include accessing multiple instructions, but the single cache line allocation is counted once."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE",
+        "PublicDescription": "Counts instruction fetches which access the level 1 instruction cache. Instruction cache accesses caused by cache maintenance operations are not counted."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l2_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l2_cache.json
new file mode 100644
index 000000000000..2f6099889de1
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l2_cache.json
@@ -0,0 +1,46 @@
+[
+    {
+        "ArchStdEvent": "L2D_CACHE",
+        "PublicDescription": "Counts level 2 cache accesses. level 2 cache is a unified cache for data and instruction accesses. Accesses are for misses in the first level caches or translation resolutions due to accesses. This event also counts write back of dirty data from level 1 data cache to the L2 cache."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL",
+        "PublicDescription": "Counts cache line refills into the level 2 cache. level 2 cache is a unified cache for data and instruction accesses. Accesses are for misses in the level 1 caches or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB",
+        "PublicDescription": "Counts write-backs of data from the L2 cache to outside the CPU. This includes snoops to the L2 (from other CPUs) which return data even if the snoops cause an invalidation. L2 cache line invalidations which do not write data outside the CPU and snoops which return data from an L1 cache are not counted. Data would not be written outside the cache when invalidating a clean cache line."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_ALLOCATE",
+        "PublicDescription": "TBD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD",
+        "PublicDescription": "Counts level 2 cache accesses due to memory read operations. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR",
+        "PublicDescription": "Counts level 2 cache accesses due to memory write operations. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
+        "PublicDescription": "Counts refills for memory accesses due to memory read operation counted by L2D_CACHE_RD. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
+        "PublicDescription": "Counts refills for memory accesses due to memory write operation counted by L2D_CACHE_WR. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
+        "PublicDescription": "Counts evictions from the level 2 cache because of a line being allocated into the L2 cache."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
+        "PublicDescription": "Counts write-backs from the level 2 cache that are a result of either:\n\n1. Cache maintenance operations,\n\n2. Snoop responses or,\n\n3. Direct cache transfers to another CPU due to a forwarding snoop request."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL",
+        "PublicDescription": "Counts each explicit invalidation of a cache line in the level 2 cache by cache maintenance operations that operate by a virtual address, or by external coherency operations. This event does not count if either:\n\n1. A cache refill invalidates a cache line or,\n2. A Cache Maintenance Operation (CMO), which invalidates a cache line specified by set/way, is executed on that CPU.\n\nCMOs that operate by set/way cannot be broadcast from one CPU to another."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json
new file mode 100644
index 000000000000..f93e0c9f309a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json
@@ -0,0 +1,18 @@
+[
+    {
+        "ArchStdEvent": "L3D_CACHE_ALLOCATE",
+        "PublicDescription": "Counts level 3 cache line allocates that do not fetch data from outside the level 3 data or unified cache. For example, allocates due to streaming stores."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL",
+        "PublicDescription": "Counts level 3 accesses that receive data from outside the L3 cache."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE",
+        "PublicDescription": "Counts level 3 cache accesses. level 3 cache is a unified cache for data and instruction accesses. Accesses are for misses in the lower level caches or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RD",
+        "PublicDescription": "TBD"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json
new file mode 100644
index 000000000000..bb712d57d58a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json
@@ -0,0 +1,10 @@
+[
+    {
+        "ArchStdEvent": "LL_CACHE_RD",
+        "PublicDescription": "Counts read transactions that were returned from outside the core cluster. This event counts when the system register CPUECTLR.EXTLLC bit is set. This event counts read transactions returned from outside the core if those transactions are either hit in the system level cache or missed in the SLC and are returned from any other external sources."
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_MISS_RD",
+        "PublicDescription": "Counts read transactions that were returned from outside the core cluster but missed in the system level cache. This event counts when the system register CPUECTLR.EXTLLC bit is set. This event counts read transactions returned from outside the core if those transactions are missed in the System level Cache. The data source of the transaction is indicated by a field in the CHI transaction returning to the CPU. This event does not count reads caused by cache maintenance operations."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/memory.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/memory.json
new file mode 100644
index 000000000000..9041f6e0befb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/memory.json
@@ -0,0 +1,22 @@
+[
+    {
+        "ArchStdEvent": "MEM_ACCESS",
+        "PublicDescription": "Counts memory accesses issued by the CPU load store unit, where those accesses are issued due to load or store operations. This event counts memory accesses no matter whether the data is received from any level of cache hierarchy or external memory. If memory accesses are broken up into smaller transactions than what were specified in the load or store instructions, then the event counts those smaller memory transactions."
+    },
+    {
+        "ArchStdEvent": "MEMORY_ERROR",
+        "PublicDescription": "Counts any detected correctable or uncorrectable physical memory errors (ECC or parity) in protected CPUs RAMs. On the core, this event counts errors in the caches (including data and tag rams). Any detected memory error (from either a speculative and abandoned access, or an architecturally executed access) is counted. Note that errors are only detected when the actual protected memory is accessed by an operation."
+    },
+    {
+        "ArchStdEvent": "REMOTE_ACCESS",
+        "PublicDescription": "Counts accesses to another chip, which is implemented as a different CMN mesh in the system. If the CHI bus response back to the core indicates that the data source is from another chip (mesh), then the counter is updated. If no data is returned, even if the system snoops another chip/mesh, then the counter is not updated."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD",
+        "PublicDescription": "Counts memory accesses issued by the CPU due to load operations. The event counts any memory load access, no matter whether the data is received from any level of cache hierarchy or external memory. The event also counts atomic load operations. If memory accesses are broken up by the load/store unit into smaller transactions that are issued by the bus interface, then the event counts those smaller transactions."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR",
+        "PublicDescription": "Counts memory accesses issued by the CPU due to store operations. The event counts any memory store access, no matter whether the data is located in any level of cache or external memory. The event also counts atomic load and store operations. If memory accesses are broken up by the load/store unit into smaller transactions that are issued by the bus interface, then the event counts those smaller transactions."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/metrics.json
new file mode 100644
index 000000000000..dc0f8638f8f5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/metrics.json
@@ -0,0 +1,219 @@
+[
+    {
+        "MetricName": "backend_stalled_cycles",
+        "MetricExpr": "((STALL_BACKEND / CPU_CYCLES) * 100)",
+        "BriefDescription": "This metric is the percentage of cycles that were stalled due to resource constraints in the backend unit of the processor.",
+        "MetricGroup": "Cycle_Accounting",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "branch_misprediction_ratio",
+        "MetricExpr": "(BR_MIS_PRED_RETIRED / BR_RETIRED)",
+        "BriefDescription": "This metric measures the ratio of branches mispredicted to the total number of branches architecturally executed. This gives an indication of the effectiveness of the branch prediction unit.",
+        "MetricGroup": "Miss_Ratio;Branch_Effectiveness",
+        "ScaleUnit": "1per branch"
+    },
+    {
+        "MetricName": "branch_mpki",
+        "MetricExpr": "((BR_MIS_PRED_RETIRED / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of branch mispredictions per thousand instructions executed.",
+        "MetricGroup": "MPKI;Branch_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "branch_percentage",
+        "MetricExpr": "(((BR_IMMED_SPEC + BR_INDIRECT_SPEC) / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures branch operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "crypto_percentage",
+        "MetricExpr": "((CRYPTO_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures crypto operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "dtlb_mpki",
+        "MetricExpr": "((DTLB_WALK / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of data TLB Walks per thousand instructions executed.",
+        "MetricGroup": "MPKI;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "dtlb_walk_ratio",
+        "MetricExpr": "(DTLB_WALK / L1D_TLB)",
+        "BriefDescription": "This metric measures the ratio of instruction TLB Walks to the total number of data TLB accesses. This gives an indication of the effectiveness of the data TLB accesses.",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "MetricName": "frontend_stalled_cycles",
+        "MetricExpr": "((STALL_FRONTEND / CPU_CYCLES) * 100)",
+        "BriefDescription": "This metric is the percentage of cycles that were stalled due to resource constraints in the frontend unit of the processor.",
+        "MetricGroup": "Cycle_Accounting",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "integer_dp_percentage",
+        "MetricExpr": "((DP_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures scalar integer operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "ipc",
+        "MetricExpr": "(INST_RETIRED / CPU_CYCLES)",
+        "BriefDescription": "This metric measures the number of instructions retired per cycle.",
+        "MetricGroup": "General",
+        "ScaleUnit": "1per cycle"
+    },
+    {
+        "MetricName": "itlb_mpki",
+        "MetricExpr": "((ITLB_WALK / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of instruction TLB Walks per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "itlb_walk_ratio",
+        "MetricExpr": "(ITLB_WALK / L1I_TLB)",
+        "BriefDescription": "This metric measures the ratio of instruction TLB Walks to the total number of instruction TLB accesses. This gives an indication of the effectiveness of the instruction TLB accesses.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "MetricName": "l1d_cache_miss_ratio",
+        "MetricExpr": "(L1D_CACHE_REFILL / L1D_CACHE)",
+        "BriefDescription": "This metric measures the ratio of level 1 data cache accesses missed to the total number of level 1 data cache accesses. This gives an indication of the effectiveness of the level 1 data cache.",
+        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "l1d_cache_mpki",
+        "MetricExpr": "((L1D_CACHE_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 1 data cache accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;L1D_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1d_tlb_miss_ratio",
+        "MetricExpr": "(L1D_TLB_REFILL / L1D_TLB)",
+        "BriefDescription": "This metric measures the ratio of level 1 data TLB accesses missed to the total number of level 1 data TLB accesses. This gives an indication of the effectiveness of the level 1 data TLB.",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "MetricName": "l1d_tlb_mpki",
+        "MetricExpr": "((L1D_TLB_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 1 instruction TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1i_cache_miss_ratio",
+        "MetricExpr": "(L1I_CACHE_REFILL / L1I_CACHE)",
+        "BriefDescription": "This metric measures the ratio of level 1 instruction cache accesses missed to the total number of level 1 instruction cache accesses. This gives an indication of the effectiveness of the level 1 instruction cache.",
+        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "l1i_cache_mpki",
+        "MetricExpr": "((L1I_CACHE_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 1 instruction cache accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;L1I_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1i_tlb_miss_ratio",
+        "MetricExpr": "(L1I_TLB_REFILL / L1I_TLB)",
+        "BriefDescription": "This metric measures the ratio of level 1 instruction TLB accesses missed to the total number of level 1 instruction TLB accesses. This gives an indication of the effectiveness of the level 1 instruction TLB.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "MetricName": "l1i_tlb_mpki",
+        "MetricExpr": "((L1I_TLB_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 1 instruction TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l2_cache_miss_ratio",
+        "MetricExpr": "(L2D_CACHE_REFILL / L2D_CACHE)",
+        "BriefDescription": "This metric measures the ratio of level 2 cache accesses missed to the total number of level 2 cache accesses. This gives an indication of the effectiveness of the level 2 cache, which is a unified cache that stores both data and instruction. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
+        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "l2_cache_mpki",
+        "MetricExpr": "((L2D_CACHE_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 2 unified cache accesses missed per thousand instructions executed. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
+        "MetricGroup": "MPKI;L2_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l2_tlb_miss_ratio",
+        "MetricExpr": "(L2D_TLB_REFILL / L2D_TLB)",
+        "BriefDescription": "This metric measures the ratio of level 2 unified TLB accesses missed to the total number of level 2 unified TLB accesses. This gives an indication of the effectiveness of the level 2 TLB.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness;DTLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "MetricName": "l2_tlb_mpki",
+        "MetricExpr": "((L2D_TLB_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 2 unified TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "ll_cache_read_hit_ratio",
+        "MetricExpr": "((LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD)",
+        "BriefDescription": "This metric measures the ratio of last level cache read accesses hit in the cache to the total number of last level cache accesses. This gives an indication of the effectiveness of the last level cache for read traffic. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a system level cache.",
+        "MetricGroup": "LL_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "ll_cache_read_miss_ratio",
+        "MetricExpr": "(LL_CACHE_MISS_RD / LL_CACHE_RD)",
+        "BriefDescription": "This metric measures the ratio of last level cache read accesses missed to the total number of last level cache accesses. This gives an indication of the effectiveness of the last level cache for read traffic. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a system level cache.",
+        "MetricGroup": "Miss_Ratio;LL_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "ll_cache_read_mpki",
+        "MetricExpr": "((LL_CACHE_MISS_RD / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of last level cache read accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;LL_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "load_percentage",
+        "MetricExpr": "((LD_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures load operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "scalar_fp_percentage",
+        "MetricExpr": "((VFP_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures scalar floating point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "simd_percentage",
+        "MetricExpr": "((ASE_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures advanced SIMD operations as a percentage of total operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "store_percentage",
+        "MetricExpr": "((ST_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures store operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/retired.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/retired.json
new file mode 100644
index 000000000000..0c7692ad5108
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/retired.json
@@ -0,0 +1,26 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR",
+        "PublicDescription": "Counts software writes to the PMSWINC_EL0 (software PMU increment) register. The PMSWINC_EL0 register is a manually updated counter for use by application software.\n\nThis event could be used to measure any user program event, such as accesses to a particular data structure (by writing to the PMSWINC_EL0 register each time the data structure is accessed).\n\nTo use the PMSWINC_EL0 register and event, developers must insert instructions that write to the PMSWINC_EL0 register into the source code.\n\nSince the SW_INCR event records writes to the PMSWINC_EL0 register, there is no need to do a read/increment/write sequence to the PMSWINC_EL0 register."
+    },
+    {
+        "ArchStdEvent": "INST_RETIRED",
+        "PublicDescription": "Counts instructions that have been architecturally executed."
+    },
+    {
+        "ArchStdEvent": "CID_WRITE_RETIRED",
+        "PublicDescription": "Counts architecturally executed writes to the CONTEXTIDR register, which usually contain the kernel PID and can be output with hardware trace."
+    },
+    {
+        "ArchStdEvent": "TTBR_WRITE_RETIRED",
+        "PublicDescription": "Counts architectural writes to TTBR0/1_EL1. If virtualization host extensions are enabled (by setting the HCR_EL2.E2H bit to 1), then accesses to TTBR0/1_EL1 that are redirected to TTBR0/1_EL2, or accesses to TTBR0/1_EL12, are counted. TTBRn registers are typically updated when the kernel is swapping user-space threads or applications."
+    },
+    {
+        "ArchStdEvent": "BR_RETIRED",
+        "PublicDescription": "Counts architecturally executed branches, whether the branch is taken or not. Instructions that explicitly write to the PC are also counted."
+    },
+    {
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts branches counted by BR_RETIRED which were mispredicted and caused a pipeline flush."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spe.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spe.json
new file mode 100644
index 000000000000..5de8b0f3a440
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spe.json
@@ -0,0 +1,18 @@
+[
+    {
+        "ArchStdEvent": "SAMPLE_POP",
+        "PublicDescription": "Counts statistical profiling sample population, the count of all operations that could be sampled but may or may not be chosen for sampling."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED",
+        "PublicDescription": "Counts statistical profiling samples taken for sampling."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FILTRATE",
+        "PublicDescription": "Counts statistical profiling samples taken which are not removed by filtering."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_COLLISION",
+        "PublicDescription": "Counts statistical profiling samples that have collided with a previous sample and so therefore not taken."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spec_operation.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spec_operation.json
new file mode 100644
index 000000000000..be8c0667f1d9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spec_operation.json
@@ -0,0 +1,102 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED",
+        "PublicDescription": "Counts branches which are speculatively executed and mispredicted."
+    },
+    {
+        "ArchStdEvent": "BR_PRED",
+        "PublicDescription": "Counts branches speculatively executed and were predicted right."
+    },
+    {
+        "ArchStdEvent": "INST_SPEC",
+        "PublicDescription": "Counts operations that have been speculatively executed."
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC",
+        "PublicDescription": "Counts unaligned memory read operations issued by the CPU. This event counts unaligned accesses (as defined by the actual instruction), even if they are subsequently issued as multiple aligned accesses. The event does not count preload operations (PLD, PLI)."
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC",
+        "PublicDescription": "Counts unaligned memory write operations issued by the CPU. This event counts unaligned accesses (as defined by the actual instruction), even if they are subsequently issued as multiple aligned accesses."
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
+        "PublicDescription": "Counts unaligned memory operations issued by the CPU. This event counts unaligned accesses (as defined by the actual instruction), even if they are subsequently issued as multiple aligned accesses."
+    },
+    {
+        "ArchStdEvent": "LDREX_SPEC",
+        "PublicDescription": "Counts Load-Exclusive operations that have been speculatively executed. Eg: LDREX, LDX"
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC",
+        "PublicDescription": "Counts store-exclusive operations that have been speculatively executed and have successfully completed the store operation."
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC",
+        "PublicDescription": "Counts store-exclusive operations that have been speculatively executed and have not successfully completed the store operation."
+    },
+    {
+        "ArchStdEvent": "STREX_SPEC",
+        "PublicDescription": "Counts store-exclusive operations that have been speculatively executed."
+    },
+    {
+        "ArchStdEvent": "LD_SPEC",
+        "PublicDescription": "Counts speculatively executed load operations including Single Instruction Multiple Data (SIMD) load operations."
+    },
+    {
+        "ArchStdEvent": "ST_SPEC",
+        "PublicDescription": "Counts speculatively executed store operations including Single Instruction Multiple Data (SIMD) store operations."
+    },
+    {
+        "ArchStdEvent": "DP_SPEC",
+        "PublicDescription": "Counts speculatively executed logical or arithmetic instructions such as MOV/MVN operations."
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD operations excluding load, store and move micro-operations that move data to or from SIMD (vector) registers."
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC",
+        "PublicDescription": "Counts speculatively executed floating point operations. This event does not count operations that move data to or from floating point (vector) registers."
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC",
+        "PublicDescription": "Counts speculatively executed operations which cause software changes of the PC. Those operations include all taken branch operations."
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC",
+        "PublicDescription": "Counts speculatively executed cryptographic operations except for PMULL and VMULL operations."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC",
+        "PublicDescription": "Counts immediate branch operations which are speculatively executed."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC",
+        "PublicDescription": "Counts procedure return operations (RET) which are speculatively executed."
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC",
+        "PublicDescription": "Counts indirect branch operations including procedure returns, which are speculatively executed. This includes operations that force a software change of the PC, other than exception-generating operations.  Eg: BR Xn, RET"
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC",
+        "PublicDescription": "Counts ISB operations that are executed."
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC",
+        "PublicDescription": "Counts DSB operations that are speculatively issued to Load/Store unit in the CPU."
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC",
+        "PublicDescription": "Counts DMB operations that are speculatively issued to the Load/Store unit in the CPU. This event does not count implied barriers from load acquire/store release operations."
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC",
+        "PublicDescription": "Counts any load acquire operations that are speculatively executed. Eg: LDAR, LDARH, LDARB"
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC",
+        "PublicDescription": "Counts any store release operations that are speculatively executed. Eg: STLR, STLRH, STLRB'"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/stall.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/stall.json
new file mode 100644
index 000000000000..688afd8a4061
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/stall.json
@@ -0,0 +1,10 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND",
+        "PublicDescription": "Counts cycles when frontend could not send any micro-operations to the rename stage because of frontend resource stalls caused by fetch memory latency or branch prediction flow stalls. All the frontend slots were empty during the cycle when this event counts."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND",
+        "PublicDescription": "Counts cycles whenever the rename unit is unable to send any micro-operations to the backend of the pipeline because of backend resource constraints. Backend resource constraints can include issue stage fullness, execution stage fullness, or other internal pipeline resource fullness. All the backend slots were empty during the cycle when this event counts."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/tlb.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/tlb.json
new file mode 100644
index 000000000000..b550af1831f5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/tlb.json
@@ -0,0 +1,66 @@
+[
+    {
+        "ArchStdEvent": "L1I_TLB_REFILL",
+        "PublicDescription": "Counts level 1 instruction TLB refills from any Instruction fetch. If there are multiple misses in the TLB that are resolved by the refill, then this event only counts once. This event will not count if the translation table walk results in a fault (such as a translation or access fault), since there is no new translation created for the TLB."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL",
+        "PublicDescription": "Counts level 1 data TLB accesses that resulted in TLB refills. If there are multiple misses in the TLB that are resolved by the refill, then this event only counts once. This event counts for refills caused by preload instructions or hardware prefetch accesses. This event counts regardless of whether the miss hits in L2 or results in a translation table walk. This event will not count if the translation table walk results in a fault (such as a translation or access fault), since there is no new translation created for the TLB. This event will not count on an access from an AT(address translation) instruction."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB",
+        "PublicDescription": "Counts level 1 data TLB accesses caused by any memory load or store operation. Note that load or store instructions can be broken up into multiple memory operations. This event does not count TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1I_TLB",
+        "PublicDescription": "Counts level 1 instruction TLB accesses, whether the access hits or misses in the TLB. This event counts both demand accesses and prefetch or preload generated accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL",
+        "PublicDescription": "Counts level 2 TLB refills caused by memory operations from both data and instruction fetch, except for those caused by TLB maintenance operations and hardware prefetches."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB",
+        "PublicDescription": "Counts level 2 TLB accesses except those caused by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK",
+        "PublicDescription": "Counts data memory translation table walks caused by a miss in the L2 TLB driven by a memory access. Note that partial translations that also cause a table walk are counted. This event does not count table walks caused by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK",
+        "PublicDescription": "Counts instruction memory translation table walks caused by a miss in the L2 TLB driven by a memory access. Partial translations that also cause a table walk are counted. This event does not count table walks caused by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
+        "PublicDescription": "Counts level 1 data TLB refills caused by memory read operations. If there are multiple misses in the TLB that are resolved by the refill, then this event only counts once. This event counts for refills caused by preload instructions or hardware prefetch accesses. This event counts regardless of whether the miss hits in L2 or results in a translation table walk. This event will not count if the translation table walk results in a fault (such as a translation or access fault), since there is no new translation created for the TLB. This event will not count on an access from an Address Translation (AT) instruction."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
+        "PublicDescription": "Counts level 1 data TLB refills caused by data side memory write operations. If there are multiple misses in the TLB that are resolved by the refill, then this event only counts once. This event counts for refills caused by preload instructions or hardware prefetch accesses. This event counts regardless of whether the miss hits in L2 or results in a translation table walk. This event will not count if the table walk results in a fault (such as a translation or access fault), since there is no new translation created for the TLB. This event will not count with an access from an Address Translation (AT) instruction."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD",
+        "PublicDescription": "Counts level 1 data TLB accesses caused by memory read operations. This event counts whether the access hits or misses in the TLB. This event does not count TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR",
+        "PublicDescription": "Counts any L1 data side TLB accesses caused by memory write operations. This event counts whether the access hits or misses in the TLB. This event does not count TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD",
+        "PublicDescription": "Counts level 2 TLB refills caused by memory read operations from both data and instruction fetch except for those caused by TLB maintenance operations or hardware prefetches."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR",
+        "PublicDescription": "Counts level 2 TLB refills caused by memory write operations from both data and instruction fetch except for those caused by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD",
+        "PublicDescription": "Counts level 2 TLB accesses caused by memory read operations from both data and instruction fetch except for those caused by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR",
+        "PublicDescription": "Counts level 2 TLB accesses caused by memory write operations from both data and instruction fetch except for those caused by TLB maintenance operations."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index f134e833c069..9d400785d195 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -23,8 +23,8 @@
 0x00000000410fd080,v1,arm/cortex-a57-a72,core
 0x00000000410fd090,v1,arm/cortex-a73,core
 0x00000000410fd0a0,v1,arm/cortex-a75,core
-0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
-0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
+0x00000000410fd0b0,v1,arm/cortex-a76,core
+0x00000000410fd0c0,v1,arm/neoverse-n1,core
 0x00000000410fd0d0,v1,arm/cortex-a77,core
 0x00000000410fd400,v1,arm/neoverse-v1,core
 0x00000000410fd410,v1,arm/cortex-a78,core
-- 
2.34.1

