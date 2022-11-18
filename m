Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36CF62EEB8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbiKRH5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241270AbiKRH5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:57:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA18C0A8;
        Thu, 17 Nov 2022 23:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668758223; x=1700294223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WaiGvoMqGilRXLPpH4Iu5oZIJXK4k0rDIhun+gzllkM=;
  b=d72+1Q7fGDzim+tU3h0ZEvg/vBJyXIFsMSA16yg7KocoHRTDieRC4eEI
   8NtP97Ry45As3QjLL0Dx9M2/CazfWoq7QTtNOff4bKA9xrIRupobpA50F
   lyRRMEVrN33vbLyldhSuWV9vZ4/PiTe0AhcuEUsCUurPa/EiuvHf0CM4S
   lzSPqlWgtlYNsBlSe99nmDiPbexT0wQ8LN5dxulxm+9BcNs43S00oCSBs
   okFw54vRPGV+mJLxAY0xFvF4rPFHF2Gi4crO5cOz4Kq/j4NNItOZ7lz3P
   HwCLjU4RMtZplm0mWheRzjiikVfm/7e6gcAa7oroGNot+1l55ND/AWIsl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="399367498"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="399367498"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 23:57:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634348327"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="634348327"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2022 23:57:00 -0800
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 3/5] perf vendor events intel: Add uncore event list for Alderlake-N
Date:   Fri, 18 Nov 2022 15:57:00 +0800
Message-Id: <20221118075702.40689-3-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118075702.40689-1-zhengjun.xing@linux.intel.com>
References: <20221118075702.40689-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Add JSON uncore events for Alderlake-N

Based on JSON list v1.16:

https://github.com/intel/perfmon/tree/main/ADL/events/

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../arch/x86/alderlaken/uncore-memory.json    | 222 ++++++++++++++++++
 .../arch/x86/alderlaken/uncore-other.json     |  87 +++++++
 2 files changed, 309 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json
new file mode 100644
index 000000000000..d82d6f62a6fb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json
@@ -0,0 +1,222 @@
+[
+    {
+        "BriefDescription": "Number of clocks",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC0 read request",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_VC0_REQUESTS_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC0 write request",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_VC0_REQUESTS_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC1 read request",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_VC1_REQUESTS_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC1 write request",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_VC1_REQUESTS_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming read prefetch request from IA",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0A",
+        "EventName": "UNC_M_PREFETCH_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Any Rank at Hot state",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M_DRAM_THERMAL_HOT",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Any Rank at Warm state",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1A",
+        "EventName": "UNC_M_DRAM_THERMAL_WARM",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming read request page status is Page Hit",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M_DRAM_PAGE_HIT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming read request page status is Page Empty",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M_DRAM_PAGE_EMPTY_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming read request page status is Page Miss",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1E",
+        "EventName": "UNC_M_DRAM_PAGE_MISS_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming write request page status is Page Hit",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1F",
+        "EventName": "UNC_M_DRAM_PAGE_HIT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming write request page status is Page Empty",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_DRAM_PAGE_EMPTY_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming write request page status is Page Miss",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_M_DRAM_PAGE_MISS_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS command sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_CAS_COUNT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write CAS command sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x23",
+        "EventName": "UNC_M_CAS_COUNT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command for a read request sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_ACT_COUNT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command for a write request sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x25",
+        "EventName": "UNC_M_ACT_COUNT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x26",
+        "EventName": "UNC_M_ACT_COUNT_TOTAL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PRE command sent to DRAM for a read/write request",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x27",
+        "EventName": "UNC_M_PRE_COUNT_PAGE_MISS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PRE command sent to DRAM due to page table idle timer expiration",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x28",
+        "EventName": "UNC_M_PRE_COUNT_IDLE",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts every 64B read  request entering the Memory Controller 0 to DRAM (sum of all channels)",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC0_RDCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts every 64B read request entering the Memory Controller 1 to DRAM (sum of all channels)",
+        "Counter": "3",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC1_RDCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts every 64B write request entering the Memory Controller 0 to DRAM (sum of all channels). Each write request counts as a new request incrementing this counter. However, same cache line write requests (both full and partial) are combined to a single 64 byte data transfer to DRAM",
+        "Counter": "1",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC0_WRCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts every 64B write request entering the Memory Controller 1 to DRAM (sum of all channels). Each write request counts as a new request incrementing this counter. However, same cache line write requests (both full and partial) are combined to a single 64 byte data transfer to DRAM",
+        "Counter": "4",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC1_WRCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
new file mode 100644
index 000000000000..8a31b0e0a1b7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
@@ -0,0 +1,87 @@
+[
+    {
+        "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of requests allocated in Coherency Tracker",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles",
+        "Counter": "Fixed",
+        "CounterType": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "Unit": "CLOCK"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_DAT_REQUESTS.RD",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_DAT_OCCUPANCY.ALL",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of any coherent request at memory controller that were issued by any core",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of coherent read requests sent to memory controller that were issued by any core",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_DAT_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of coherent reads pending on data return from memory controller that were issued by any core",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "ARB"
+    }
+]
-- 
2.25.1

