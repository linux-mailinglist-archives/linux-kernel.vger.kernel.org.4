Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FDB62EEB7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbiKRH5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241034AbiKRH5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:57:02 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2898C09A;
        Thu, 17 Nov 2022 23:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668758219; x=1700294219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P05y/4u+g4AqA5ovIqnIxXhXVEYuHxPflz6PCRvwsHA=;
  b=V7/u66N/sp8naP1upuLCP7nTJ3n4c2cFF9l1tef6G299419m0/YDytv8
   8WcNj0yk9oLw6fZ9oOhD+zbas8TfHqNkjH/auQy1TS6i4JpmAcLAqpJoX
   ykPhfB30mos9Ede4nKA2VjspdWRkGkBNAXrV+Y/ZHvn7wNrQ+cAazjTbG
   Un/cxwkZgE3sHC55lOJSgGAOOCq/vaLQA/YkxZ1N9e6TL9G3bu3t8S4yO
   rESNJ6UpF6imZ1bgoVSPs0Tbg6Bpb9HT8qv43GpnKajx/PsISw4Y8mjF6
   xqf/w1xggkK1PPaqn3KCUJ+G8xegtgYlCefXcRdfCNzGn9V4yR37bYG5i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="399367489"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="399367489"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 23:56:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634348310"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="634348310"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2022 23:56:54 -0800
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 2/5] perf vendor events intel: Add core event list for Alderlake-N
Date:   Fri, 18 Nov 2022 15:56:59 +0800
Message-Id: <20221118075702.40689-2-zhengjun.xing@linux.intel.com>
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

Alderlake-N only has E-core, it has been moved to non-hybrid code path on
the kernel side. Add core event list for Alderlake-N, it is based on the 
ADL gracemont v1.16 JSON file.

https://github.com/intel/perfmon/tree/main/ADL/events/

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../pmu-events/arch/x86/alderlaken/cache.json | 450 ++++++++++
 .../arch/x86/alderlaken/floating-point.json   |  25 +
 .../arch/x86/alderlaken/frontend.json         |  38 +
 .../arch/x86/alderlaken/memory.json           | 109 +++
 .../pmu-events/arch/x86/alderlaken/other.json |  42 +
 .../arch/x86/alderlaken/pipeline.json         | 774 ++++++++++++++++++
 .../arch/x86/alderlaken/virtual-memory.json   |  71 ++
 7 files changed, 1509 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
new file mode 100644
index 000000000000..a6aa87d1365b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
@@ -0,0 +1,450 @@
+[
+    {
+        "BriefDescription": "Counts the number of cacheable memory requests that miss in the LLC. Counts on a per core basis.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cacheable memory requests that miss in the Last Level Cache (LLC). Requests include demand loads, reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 cache. Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Counts the number of cacheable memory requests that access the LLC. Counts on a per core basis.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cacheable memory requests that access the Last Level Cache (LLC). Requests include demand loads, reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 cache. Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x4f"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in the L2, LLC, DRAM or MMIO (Non-DRAM).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.IFETCH",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles the core is stalled due to an instruction cache or translation lookaside buffer (TLB) miss which hit in the L2, LLC, DRAM or MMIO (Non-DRAM).",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x38"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in DRAM or MMIO (Non-DRAM).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.IFETCH_DRAM_HIT",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles the core is stalled due to an instruction cache or translation lookaside buffer (TLB) miss which hit in DRAM or MMIO (non-DRAM).",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in the L2 cache.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.IFETCH_L2_HIT",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles the core is stalled due to an instruction cache or Translation Lookaside Buffer (TLB) miss which hit in the L2 cache.",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in the LLC or other core with HITE/F/M.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.IFETCH_LLC_HIT",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles the core is stalled due to an instruction cache or Translation Lookaside Buffer (TLB) miss which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stalled due to a demand load miss which hit in the L2, LLC, DRAM or MMIO (Non-DRAM).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.LOAD",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stalled due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.LOAD_DRAM_HIT",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stalled due to a demand load which hit in the L2 cache.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.LOAD_L2_HIT",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stalled due to a demand load which hit in the LLC or other core with HITE/F/M.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.LOAD_LLC_HIT",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles the core is stalled due to a demand load which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that hit in DRAM.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that hit in the L2 cache.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that hit in the L3 cache.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blocked for any of the following reasons:  load buffer, store buffer or RSV full.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.ALL",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "20003",
+        "Speculative": "1",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blocked due to a load buffer full condition.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.LD_BUF",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "20003",
+        "Speculative": "1",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blocked due to an RSV full condition.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.RSV",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "20003",
+        "Speculative": "1",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blocked due to a store buffer full condition.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.ST_BUF",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "20003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of load uops retired.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x81"
+    },
+    {
+        "BriefDescription": "Counts the number of store uops retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of store uops retired.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x82"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 128 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
+        "L1_Hit_Indication": "1",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x80",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 128 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 16 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
+        "L1_Hit_Indication": "1",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x10",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 16 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 256 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
+        "L1_Hit_Indication": "1",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x100",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 256 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 32 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
+        "L1_Hit_Indication": "1",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x20",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 32 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 4 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
+        "L1_Hit_Indication": "1",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x4",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 4 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 512 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
+        "L1_Hit_Indication": "1",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x200",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 512 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 64 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
+        "L1_Hit_Indication": "1",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x40",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 64 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 8 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
+        "L1_Hit_Indication": "1",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x8",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 8 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of retired split load uops.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Counts the number of stores uops retired. Counts with or without PEBS enabled.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
+        "L1_Hit_Indication": "1",
+        "PEBS": "2",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of stores uops retired. Counts with or without PEBS enabled. If PEBS is enabled and a PEBS record is generated, will populate PEBS Latency and PEBS Data Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to instruction cache misses.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ICACHE",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x20"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json b/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
new file mode 100644
index 000000000000..02eb1af8db00
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
@@ -0,0 +1,25 @@
+[
+    {
+        "BriefDescription": "Counts the number of floating point operations retired that required microcode assist.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FP_ASSIST",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of floating point operations retired that required microcode assist, which is not a reflection of the number of FP operations, instructions or uops.",
+        "SampleAfterValue": "20003",
+        "Speculative": "1",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point divide uops retired (x87 and SSE, including x87 sqrt).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.FPDIV",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/frontend.json b/tools/perf/pmu-events/arch/x86/alderlaken/frontend.json
new file mode 100644
index 000000000000..ed0587945a05
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/frontend.json
@@ -0,0 +1,38 @@
+[
+    {
+        "BriefDescription": "Counts the total number of BACLEARS due to all branch types including conditional and unconditional jumps, returns, and indirect branches.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.ANY",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of BACLEARS, which occur when the Branch Target Buffer (BTB) prediction or lack thereof, was corrected by a later branch predictor in the frontend.  Includes BACLEARS due to all branch types including conditional and unconditional jumps, returns, and indirect branches.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of requests to the instruction cache for one or more bytes of a cache line.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.ACCESSES",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of requests to the instruction cache.  The event only counts new cache line accesses, so that multiple back to back fetches to the exact same cache line or byte chunk count as one.  Specifically, the event counts when accesses from sequential code crosses the cache line boundary, or when a branch target is moved to a new line or to a non-sequential byte chunk of the same line.",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction cache misses.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.MISSES",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of missed requests to the instruction cache.  The event only counts new cache line accesses, so that multiple back to back fetches to the exact same cache line and byte chunk count as one.  Specifically, the event counts when accesses from sequential code crosses the cache line boundary, or when a branch target is moved to a new line or to a non-sequential byte chunk of the same line.",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x2"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
new file mode 100644
index 000000000000..cabf2fc8600f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
@@ -0,0 +1,109 @@
+[
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to any number of reasons, including an L1 miss, WCB full, pagewalk, store address block or store data block, on a load that retires.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ANY_AT_RET",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a core bound stall including a store address match, a DTLB miss or a page walk that detains the load from retiring.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_BOUND_AT_RET",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0xf4"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to other block cases.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.OTHER_AT_RET",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to other block cases such as pipeline conflicts, fences, etc.",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0xc0"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a pagewalk.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.PGWALK_AT_RET",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0xa0"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a store address match.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ST_ADDR_AT_RET",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x84"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to memory ordering caused by a snoop from an external agent. Does not count internally generated machine clears such as those due to memory disambiguation.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "20003",
+        "Speculative": "1",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84400001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84400001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84400002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84400002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/other.json b/tools/perf/pmu-events/arch/x86/alderlaken/other.json
new file mode 100644
index 000000000000..25c7f1f47e28
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/other.json
@@ -0,0 +1,42 @@
+[
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and L2 cache that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.COREWB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10008",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10800",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
new file mode 100644
index 000000000000..f922d96e5aaa
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
@@ -0,0 +1,774 @@
+[
+    {
+        "BriefDescription": "Counts the total number of branch instructions retired for all branch types.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of instructions in which the instruction pointer (IP) of the processor is resteered due to a branch instruction and the branch instruction successfully retires.  All branch type instructions are accounted for.",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.NEAR_CALL",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf9"
+    },
+    {
+        "BriefDescription": "Counts the number of retired JCC (Jump on Conditional Code) branch instructions retired, includes both taken and not taken branches.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e"
+    },
+    {
+        "BriefDescription": "Counts the number of taken JCC (Jump on Conditional Code) branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe"
+    },
+    {
+        "BriefDescription": "Counts the number of far branch instructions retired, includes far jump, far call and return, and interrupt call and return.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xbf"
+    },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP and near indirect CALL branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb"
+    },
+    {
+        "BriefDescription": "Counts the number of near indirect CALL branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.INDIRECT_CALL",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.IND_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.COND",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.JCC",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e"
+    },
+    {
+        "BriefDescription": "Counts the number of near CALL branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf9"
+    },
+    {
+        "BriefDescription": "Counts the number of near RET branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.INDIRECT",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb"
+    },
+    {
+        "BriefDescription": "Counts the number of near relative CALL branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfd"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.NEAR_RETURN",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.RETURN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.COND_TAKEN",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN_JCC",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe"
+    },
+    {
+        "BriefDescription": "Counts the total number of mispredicted branch instructions retired for all branch types.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of mispredicted branch instructions retired.  All branch type instructions are accounted for.  Prediction of the branch target address enables the processor to begin executing instructions before the non-speculative execution path is known. The branch prediction unit (BPU) predicts the target address based on the instruction pointer (IP) of the branch and on the execution path through which execution reached this IP.    A branch misprediction occurs when the prediction is wrong, and results in discarding all instructions executed in the speculative path and re-fetching from the correct path.",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted JCC (Jump on Conditional Code) branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted taken JCC (Jump on Conditional Code) branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indirect JMP and near indirect CALL branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indirect CALL branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event BR_MISP_RETIRED.INDIRECT_CALL",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.IND_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event BR_MISP_RETIRED.COND",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.JCC",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event BR_MISP_RETIRED.INDIRECT",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near RET branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RETURN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event BR_MISP_RETIRED.COND_TAKEN",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
+        "CollectPEBSRecord": "2",
+        "Counter": "Fixed counter 1",
+        "EventName": "CPU_CLK_UNHALTED.CORE",
+        "PEBScounters": "33",
+        "PublicDescription": "Counts the number of core cycles while the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time. This event uses fixed counter 1.",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.CORE_P",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of core cycles while the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time. This event uses a programmable general purpose performance counter.",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted reference clock cycles at TSC frequency. (Fixed event)",
+        "CollectPEBSRecord": "2",
+        "Counter": "Fixed counter 2",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "PEBScounters": "34",
+        "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is not affected by core frequency changes and increments at a fixed frequency that is also used for the Time Stamp Counter (TSC). This event uses fixed counter 2.",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted reference clock cycles at TSC frequency.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is not affected by core frequency changes and increments at a fixed frequency that is also used for the Time Stamp Counter (TSC). This event uses a programmable general purpose performance counter.",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
+        "CollectPEBSRecord": "2",
+        "Counter": "Fixed counter 1",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "PEBScounters": "33",
+        "PublicDescription": "Counts the number of core cycles while the core is not in a halt state.  The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time.  This event uses fixed counter 1.",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of core cycles while the core is not in a halt state.  The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time. This event uses a programmable general purpose performance counter.",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1"
+    },
+    {
+        "BriefDescription": "Counts the total number of instructions retired. (Fixed event)",
+        "CollectPEBSRecord": "2",
+        "Counter": "Fixed counter 0",
+        "EventName": "INST_RETIRED.ANY",
+        "PEBS": "1",
+        "PEBScounters": "32",
+        "PublicDescription": "Counts the total number of instructions that retired. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. This event continues counting during hardware interrupts, traps, and inside interrupt handlers. This event uses fixed counter 0.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the total number of instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of instructions that retired. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. This event continues counting during hardware interrupts, traps, and inside interrupt handlers. This event uses a programmable general purpose performance counter.",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event LD_BLOCKS.ADDRESS_ALIAS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.4K_ALIAS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are blocked because it initially appears to be store forward blocked, but subsequently is shown not to be blocked based on 4K alias check.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are blocked because its address exactly matches an older store whose data is not ready.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.DATA_UNKNOWN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to memory ordering in which an internal load passes an older store within the same CPU.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "20003",
+        "Speculative": "1",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of machines clears due to memory renaming.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MRN_NUKE",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to a page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A page fault occurs when either the page is not present, or an access violation occurs.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.PAGE_FAULT",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "20003",
+        "Speculative": "1",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears that flush the pipeline and restart the machine with the use of microcode due to SMC, MEMORY_ORDERING, FP_ASSISTS, PAGE_FAULT, DISAMBIGUATION, and FPC_VIRTUAL_TRAP.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SLOW",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "20003",
+        "Speculative": "1",
+        "UMask": "0x6f"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to program modifying data (self modifying code) within 1K of a recently fetched code page.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "20003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots not consumed by the backend due to a micro-sequencer (MS) scoreboard, which stalls the front-end from issuing from the UROM until a specified older uop retires.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.NON_C01_MS_SCB",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of issue slots not consumed by the backend due to a micro-sequencer (MS) scoreboard, which stalls the front-end from issuing from the UROM until a specified older uop retires. The most commonly executed instruction with an MS scoreboard is PAUSE.",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear. Only issue slots wasted due to fast nukes such as memory ordering nukes are counted. Other nukes are not accounted for. Counts all issue slots blocked during this recovery window including relevant microcode flows and while uops are not yet available in the instruction queue (IQ) even if an FE_bound event occurs during this period. Also includes the issue slots that were consumed by the backend but were thrown away because they were younger than the mispredict or machine clear.",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to fast nukes such as memory ordering and memory disambiguation machine clears.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a machine clear (nuke) of any kind including memory ordering and memory disambiguation.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to branch mispredicts.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to a machine clear (nuke).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots every cycle that were not consumed by the backend due to backend stalls.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALL",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to certain allocation restrictions.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to memory reservation stalls in which a scheduler is not able to accept uops.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to IEC or FPC RAT stalls, which can be due to FIQ or IEC reservation stalls in which the integer, floating point or SIMD scheduler is not able to accept uops.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to the physical register file unable to accept an entry (marble stalls).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to the reorder buffer being full (ROB stalls).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to scoreboards from the instruction queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots every cycle that were not consumed by the backend due to frontend stalls.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ALL",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BACLEARS.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BACLEARS, which occurs when the Branch Target Buffer (BTB) prediction or lack thereof, was corrected by a later branch predictor in the frontend. Includes BACLEARS due to all branch types including conditional and unconditional jumps, returns, and indirect branches.",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BTCLEARS.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BTCLEARS, which occurs when the Branch Target Buffer (BTB) predicts a taken branch.",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to the microcode sequencer (MS).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.CISC",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to decode stalls.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.DECODE",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to frontend bandwidth restrictions due to decode, predecode, cisc, and other limitations.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x8d"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to a latency related stalls including BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x72"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to ITLB misses.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ITLB",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB) misses.",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to other common frontend stalls not categorized.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.OTHER",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to wrong predecodes.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the total number of consumed retirement slots.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc2",
+        "EventName": "TOPDOWN_RETIRING.ALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the total number of uops retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.ALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Counts the number of integer divide uops retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.IDIV",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of uops that are from complex flows issued by the micro-sequencer (MS).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of uops that are from complex flows issued by the Microcode Sequencer (MS). This includes uops from flows due to complex instructions, faults, assists, and inserted flows.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of x87 uops retired, includes those in MS flows.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.X87",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
new file mode 100644
index 000000000000..77f80d1a7cd4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
@@ -0,0 +1,71 @@
+[
+    {
+        "BriefDescription": "Counts the number of page walks completed due to load DTLB misses to any page size.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of page walks completed due to loads (including SW prefetches) whose address translations missed in all Translation Lookaside Buffer (TLB) levels and were mapped to any page size. Includes page walks that page fault.",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due to store DTLB misses to any page size.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of page walks completed due to stores whose address translations missed in all Translation Lookaside Buffer (TLB) levels and were mapped to any page size.  Includes page walks that page fault.",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks initiated by a instruction fetch that missed the first and second level TLBs.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.MISS_CAUSED_WALK",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks due to an instruction fetch that miss the PDE (Page Directory Entry) cache.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.PDE_CACHE_MISS",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due to instruction fetch misses to any page size.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of page walks completed due to instruction fetches whose address translations missed in all Translation Lookaside Buffer (TLB) levels and were mapped to any page size.  Includes page walks that page fault.",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a DTLB miss.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.DTLB_MISS_AT_RET",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x90"
+    }
+]
-- 
2.25.1

