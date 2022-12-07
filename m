Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E41645375
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiLGFcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLGFcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:32:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591DC57B70;
        Tue,  6 Dec 2022 21:32:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOkdNxX99dvyvbw5yXqM5kfxt8tFuozNbMZ1elLRbT8l3TknXbIzHIq0deLH2gGn80PL2/MfLRyG5aUCAt4ekqc63/Y8xObiQ/4nJEucRg97E3xIPUPOF14597T59b6vOMDpqjgxwT8IYYX+OaeCHHZyT5nO7RzfTcbh5nsB/KoheVaMF6vMTRxHbbdBT2gNu+FGAW2mLd9wb9ccUGF7Rlh9Q11RVQYc7A5eoNcp13mZKj8SMoUj/s9+bpjJAfuymcB0EG31YamY8z4opZv93I1Ghv72L07u7yieSC4/++gKodeCSwrJ80USLkyJzpivSi2KuR3C0FL7xbIdwurymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Fq7nV59ogYLDadZLCDh93XBw51i+xwtb/RiDs7MOgc=;
 b=k2gFv+bBeY1dyhNPjxF16FV9uDFxHmXwnx8rM4XV8tZnVrmWhn8Rv9qYvY9tyPK+E17Y160mARNJMRrE+BBHeCDuQ+zXKaEeZmLC5jDl+EIpcaWLfJokCK7XbUugmROKBFudXvn2tZjjo3ALMUjfP+KX8pLnWCwLXKJoOy+raWyzl+OB/ijXC4tjq3NT8Mko2JrbRWk542ilrEb+p+oHZ/pHYHxMBD+7Ibeh8tws/nVoNzeZkkUNW6kJALBCbmgE2n10XcjqxUVzDdM3JxxV/20KTqmq0IlqJoV2EOg8Tq9JquLg03htkJx9QK4TfAPJcdkHSxWn0wCIdwg3/Xjvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Fq7nV59ogYLDadZLCDh93XBw51i+xwtb/RiDs7MOgc=;
 b=xBGPuzQ1J38PIgKs72gEn0uDtPGj5OUsLr7iyAiLBFKvuUAsskNErCWHKixncRPaYjrJ6IkT3jDCgUsqznIFRlVqTJzFHofmg5ihOBLzw0HoOIn7xNsbfO+2KzcbbpXhpzvQpfv18Ac3MNZy9NMM4df8BFcYE8Uy4qOU3HhneDk=
Received: from MW4PR04CA0326.namprd04.prod.outlook.com (2603:10b6:303:82::31)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 05:32:00 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::f1) by MW4PR04CA0326.outlook.office365.com
 (2603:10b6:303:82::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 05:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Wed, 7 Dec 2022 05:32:00 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 23:31:51 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <eranian@google.com>,
        <irogers@google.com>, <jhladky@redhat.com>,
        <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 4/4] perf vendor events amd: Add Zen 4 metrics
Date:   Wed, 7 Dec 2022 11:00:07 +0530
Message-ID: <20221207053007.336806-5-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207053007.336806-1-sandipan.das@amd.com>
References: <20221207053007.336806-1-sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|BN9PR12MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: dd97d30a-dbc1-48d7-bd76-08dad8145d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MDcd/SfNgR0UbiH4DJJ2D1D8ap2/fHmM9f0Fyua0zVJxN3Aij5zjdokMAm5bwgRyMa4bXtTk1/4t8fczWfkamtXAs9G0uUdaCJGRcOry6RDycG5XNhWX/EZinKuy8EKuz91vbd3G0IxOGaxAI4+LgK//b3y0UBkpyWP6lIxNyGm2SANQgjN7FG3oVOpADKX+XYspIzezH8unbjyhyvS9uL13YFT/AbFC8cPJED5ImvS99/rVvwJbBSa4hf709V70E1OXYOdLs02L7kZ8LicaBnPZtOQxhsW1pwCEMVu8rLO8toKDSWbqNsuBcuS+2pIqDawh4ToJ/RZHOoLIMJMWwvQfMGhmHUhS/zEmgNHX2hKdiO+Ngs/czjXPmaMJHO9ARoRpmCs5S8uYjlB+xrWFOMJ1wZUVczs7lkOKXrvFdlIOGNe7OOh61+L3B7D5ICJiWaWjRhmbvnR81Cji1HErdvxpUxegBrxl900rsjv2Va07FCAR/LVa8Zu9X36PP9C4+MTh4apQevdn77rrlZbXhrWDsTucSJKuVcGiwjNZqEYP+OT6QB60fcUfGHTXLYMbo7bgSvUQIqcSrbUd6UIssOhx7LWl6vGilmin2ppCjogTJ8GsnuHGbTFjIw3t50JVTNTSmxzoRYvsbGzMMyPIXaxC0wrPeN74ykUnvYN1qI6OTbGAKZ/DgnM8w0mbXFia2nMlhpcnE4a6sfRwD5FANZpyosk42EI46JSWFaWx74=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(5660300002)(356005)(81166007)(8936002)(44832011)(86362001)(40460700003)(4326008)(41300700001)(2906002)(7416002)(30864003)(36860700001)(83380400001)(8676002)(54906003)(70206006)(316002)(70586007)(2616005)(110136005)(82740400003)(40480700001)(82310400005)(16526019)(478600001)(186003)(47076005)(426003)(6666004)(26005)(336012)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 05:32:00.1760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd97d30a-dbc1-48d7-bd76-08dad8145d57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add metrics taken from Section 2.1.15.2 "Performance Measurement" in
the Processor Programming Reference (PPR) for AMD Family 19h Model 11h
Revision B1 processors.

The recommended metrics are sourced from Table 27 "Guidance for Common
Performance Statistics with Complex Event Selects".

The pipeline utilization metrics are sourced from Table 28 "Guidance
for Pipeline Utilization Analysis Statistics". These are new to Zen 4
processors and useful for finding performance bottlenecks by analyzing
activity at different stages of the pipeline. Metric groups have been
added for Level 1 and Level 2 analysis.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../pmu-events/arch/x86/amdzen4/pipeline.json |  98 +++++
 .../arch/x86/amdzen4/recommended.json         | 334 ++++++++++++++++++
 2 files changed, 432 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/recommended.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json b/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
new file mode 100644
index 000000000000..23d1f35d0903
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
@@ -0,0 +1,98 @@
+[
+  {
+    "MetricName": "total_dispatch_slots",
+    "BriefDescription": "Total dispatch slots (upto 6 instructions can be dispatched in each cycle).",
+    "MetricExpr": "6 * ls_not_halted_cyc"
+  },
+  {
+    "MetricName": "frontend_bound",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because the frontend did not supply enough instructions/ops.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend, total_dispatch_slots)",
+    "MetricGroup": "pipeline_utilization_level1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "bad_speculation",
+    "BriefDescription": "Fraction of dispatched ops that did not retire.",
+    "MetricExpr": "d_ratio(de_src_op_disp.all - ex_ret_ops, total_dispatch_slots)",
+    "MetricGroup": "pipeline_utilization_level1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "backend_bound",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of backend stalls.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.backend_stalls, total_dispatch_slots)",
+    "MetricGroup": "pipeline_utilization_level1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "smt_contention",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because the other thread was selected.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.smt_contention, total_dispatch_slots)",
+    "MetricGroup": "pipeline_utilization_level1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "retiring",
+    "BriefDescription": "Fraction of dispatch slots used by ops that retired.",
+    "MetricExpr": "d_ratio(ex_ret_ops, total_dispatch_slots)",
+    "MetricGroup": "pipeline_utilization_level1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "frontend_bound_latency",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of a latency bottleneck in the frontend (such as instruction cache or TLB misses).",
+    "MetricExpr": "d_ratio((6 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x6@), total_dispatch_slots)",
+    "MetricGroup": "pipeline_utilization_level2;frontend_bound_level2",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "frontend_bound_bandwidth",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of a bandwidth bottleneck in the frontend (such as decode or op cache fetch bandwidth).",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend - (6 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x6@), total_dispatch_slots)",
+    "MetricGroup": "pipeline_utilization_level2;frontend_bound_level2",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "bad_speculation_mispredicts",
+    "BriefDescription": "Fraction of dispatched ops that were flushed due to branch mispredicts.",
+    "MetricExpr": "d_ratio(bad_speculation * ex_ret_brn_misp, ex_ret_brn_misp + resyncs_or_nc_redirects)",
+    "MetricGroup": "pipeline_utilization_level2;bad_speculation_level2",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "bad_speculation_pipeline_restarts",
+    "BriefDescription": "Fraction of dispatched ops that were flushed due to pipeline restarts (resyncs).",
+    "MetricExpr": "d_ratio(bad_speculation * resyncs_or_nc_redirects, ex_ret_brn_misp + resyncs_or_nc_redirects)",
+    "MetricGroup": "pipeline_utilization_level2;bad_speculation_level2",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "backend_bound_memory",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of stalls due to the memory subsystem.",
+    "MetricExpr": "backend_bound * d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete)",
+    "MetricGroup": "pipeline_utilization_level2;backend_bound_level2",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "backend_bound_cpu",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of stalls not related to the memory subsystem.",
+    "MetricExpr": "backend_bound * (1 - d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete))",
+    "MetricGroup": "pipeline_utilization_level2;backend_bound_level2",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "retiring_fastpath",
+    "BriefDescription": "Fraction of dispatch slots used by fastpath ops that retired.",
+    "MetricExpr": "retiring * (1 - d_ratio(ex_ret_ucode_ops, ex_ret_ops))",
+    "MetricGroup": "pipeline_utilization_level2;retiring_level2",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "retiring_microcode",
+    "BriefDescription": "Fraction of dispatch slots used by microcode ops that retired.",
+    "MetricExpr": "retiring * d_ratio(ex_ret_ucode_ops, ex_ret_ops)",
+    "MetricGroup": "pipeline_utilization_level2;retiring_level2",
+    "ScaleUnit": "100%"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
new file mode 100644
index 000000000000..2e3c9d8942b9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
@@ -0,0 +1,334 @@
+[
+  {
+    "MetricName": "branch_misprediction_ratio",
+    "BriefDescription": "Execution-time branch misprediction ratio (non-speculative).",
+    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
+    "MetricGroup": "branch_prediction",
+    "ScaleUnit": "100%"
+  },
+  {
+    "EventName": "all_data_cache_accesses",
+    "EventCode": "0x29",
+    "BriefDescription": "All data cache accesses.",
+    "UMask": "0x07"
+  },
+  {
+    "MetricName": "all_l2_cache_accesses",
+    "BriefDescription": "All L2 cache accesses.",
+    "MetricExpr": "l2_request_g1.all_no_prefetch + l2_pf_hit_l2.all + l2_pf_miss_l2_hit_l3.all + l2_pf_miss_l2_l3.all",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l1_ic_misses",
+    "BriefDescription": "L2 cache accesses from L1 instruction cache misses (including prefetch).",
+    "MetricExpr": "l2_request_g1.cacheable_ic_read",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l1_dc_misses",
+    "BriefDescription": "L2 cache accesses from L1 data cache misses (including prefetch).",
+    "MetricExpr": "l2_request_g1.all_dc",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l2_hwpf",
+    "BriefDescription": "L2 cache accesses from L2 cache hardware prefetcher.",
+    "MetricExpr": "l2_pf_hit_l2.all + l2_pf_miss_l2_hit_l3.all + l2_pf_miss_l2_l3.all",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "all_l2_cache_misses",
+    "BriefDescription": "All L2 cache misses.",
+    "MetricExpr": "l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hit_l3.all + l2_pf_miss_l2_l3.all",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l1_ic_miss",
+    "BriefDescription": "L2 cache misses from L1 instruction cache misses.",
+    "MetricExpr": "l2_cache_req_stat.ic_fill_miss",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l1_dc_miss",
+    "BriefDescription": "L2 cache misses from L1 data cache misses.",
+    "MetricExpr": "l2_cache_req_stat.ls_rd_blk_c",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l2_hwpf",
+    "BriefDescription": "L2 cache misses from L2 cache hardware prefetcher.",
+    "MetricExpr": "l2_pf_miss_l2_hit_l3.all + l2_pf_miss_l2_l3.all",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "all_l2_cache_hits",
+    "BriefDescription": "All L2 cache hits.",
+    "MetricExpr": "l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2.all",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l1_ic_miss",
+    "BriefDescription": "L2 cache hits from L1 instruction cache misses.",
+    "MetricExpr": "l2_cache_req_stat.ic_hit_in_l2",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l1_dc_miss",
+    "BriefDescription": "L2 cache hits from L1 data cache misses.",
+    "MetricExpr": "l2_cache_req_stat.dc_hit_in_l2",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l2_hwpf",
+    "BriefDescription": "L2 cache hits from L2 cache hardware prefetcher.",
+    "MetricExpr": "l2_pf_hit_l2.all",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "l3_cache_accesses",
+    "BriefDescription": "L3 cache accesses.",
+    "MetricExpr": "l3_lookup_state.all_coherent_accesses_to_l3",
+    "MetricGroup": "l3_cache"
+  },
+  {
+    "MetricName": "l3_misses",
+    "BriefDescription": "L3 misses (including cacheline state change requests).",
+    "MetricExpr": "l3_lookup_state.l3_miss",
+    "MetricGroup": "l3_cache"
+  },
+  {
+    "MetricName": "l3_read_miss_latency",
+    "BriefDescription": "Average L3 read miss latency (in core clocks).",
+    "MetricExpr": "(l3_xi_sampled_latency.all * 10) / l3_xi_sampled_latency_requests.all",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1core clocks"
+  },
+  {
+    "MetricName": "op_cache_fetch_miss_ratio",
+    "BriefDescription": "Op cache miss ratio for all fetches.",
+    "MetricExpr": "d_ratio(op_cache_hit_miss.op_cache_miss, op_cache_hit_miss.all_op_cache_accesses)",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "ic_fetch_miss_ratio",
+    "BriefDescription": "Instruction cache miss ratio for all fetches. An instruction cache miss will not be counted by this metric if it is an OC hit.",
+    "MetricExpr": "d_ratio(ic_tag_hit_miss.instruction_cache_miss, ic_tag_hit_miss.all_instruction_cache_accesses)",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_memory",
+    "BriefDescription": "L1 data cache fills from DRAM or MMIO in any NUMA node.",
+    "MetricExpr": "ls_any_fills_from_sys.dram_io_all",
+    "MetricGroup": "l1_dcache"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_remote_node",
+    "BriefDescription": "L1 data cache fills from a different NUMA node.",
+    "MetricExpr": "ls_any_fills_from_sys.far_all",
+    "MetricGroup": "l1_dcache"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_same_ccx",
+    "BriefDescription": "L1 data cache fills from within the same CCX.",
+    "MetricExpr": "ls_any_fills_from_sys.local_all",
+    "MetricGroup": "l1_dcache"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_different_ccx",
+    "BriefDescription": "L1 data cache fills from another CCX cache in any NUMA node.",
+    "MetricExpr": "ls_any_fills_from_sys.remote_cache",
+    "MetricGroup": "l1_dcache"
+  },
+  {
+    "MetricName": "all_l1_data_cache_fills",
+    "BriefDescription": "All L1 data cache fills.",
+    "MetricExpr": "ls_any_fills_from_sys.all",
+    "MetricGroup": "l1_dcache"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_local_l2",
+    "BriefDescription": "L1 demand data cache fills from local L2 cache.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.local_l2",
+    "MetricGroup": "l1_dcache"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_same_ccx",
+    "BriefDescription": "L1 demand data cache fills from within the same CCX.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.local_ccx",
+    "MetricGroup": "l1_dcache"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_near_cache",
+    "BriefDescription": "L1 demand data cache fills from another CCX cache in the same NUMA node.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.near_cache",
+    "MetricGroup": "l1_dcache"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_near_memory",
+    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in the same NUMA node.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_near",
+    "MetricGroup": "l1_dcache"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_far_cache",
+    "BriefDescription": "L1 demand data cache fills from another CCX cache in a different NUMA node.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.far_cache",
+    "MetricGroup": "l1_dcache"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_far_memory",
+    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in a different NUMA node.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_far",
+    "MetricGroup": "l1_dcache"
+  },
+  {
+    "MetricName": "l1_itlb_misses",
+    "BriefDescription": "L1 instruction TLB misses.",
+    "MetricExpr": "bp_l1_tlb_miss_l2_tlb_hit + bp_l1_tlb_miss_l2_tlb_miss.all",
+    "MetricGroup": "tlb"
+  },
+  {
+    "MetricName": "l2_itlb_misses",
+    "BriefDescription": "L2 instruction TLB misses and instruction page walks.",
+    "MetricExpr": "bp_l1_tlb_miss_l2_tlb_miss.all",
+    "MetricGroup": "tlb"
+  },
+  {
+    "MetricName": "l1_dtlb_misses",
+    "BriefDescription": "L1 data TLB misses.",
+    "MetricExpr": "ls_l1_d_tlb_miss.all",
+    "MetricGroup": "tlb"
+  },
+  {
+    "MetricName": "l2_dtlb_misses",
+    "BriefDescription": "L2 data TLB misses and data page walks.",
+    "MetricExpr": "ls_l1_d_tlb_miss.all_l2_miss",
+    "MetricGroup": "tlb"
+  },
+  {
+    "MetricName": "all_tlbs_flushed",
+    "BriefDescription": "All TLBs flushed.",
+    "MetricExpr": "ls_tlb_flush.all",
+    "MetricGroup": "tlb"
+  },
+  {
+    "MetricName": "macro_ops_dispatched",
+    "BriefDescription": "Macro-ops dispatched.",
+    "MetricExpr": "de_src_op_disp.all",
+    "MetricGroup": "decoder"
+  },
+  {
+    "MetricName": "sse_avx_stalls",
+    "BriefDescription": "Mixed SSE/AVX stalls.",
+    "MetricExpr": "fp_disp_faults.sse_avx_all"
+  },
+  {
+    "MetricName": "macro_ops_retired",
+    "BriefDescription": "Macro-ops retired.",
+    "MetricExpr": "ex_ret_ops"
+  },
+  {
+    "MetricName": "dram_read_data_bytes_for_local_processor",
+    "BriefDescription": "DRAM read data bytes for local processor.",
+    "MetricExpr": "local_processor_read_data_beats_cs0 + local_processor_read_data_beats_cs1 + local_processor_read_data_beats_cs2 + local_processor_read_data_beats_cs3 + local_processor_read_data_beats_cs4 + local_processor_read_data_beats_cs5 + local_processor_read_data_beats_cs6 + local_processor_read_data_beats_cs7 + local_processor_read_data_beats_cs8 + local_processor_read_data_beats_cs9 + local_processor_read_data_beats_cs10 + local_processor_read_data_beats_cs11",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "dram_write_data_bytes_for_local_processor",
+    "BriefDescription": "DRAM write data bytes for local processor.",
+    "MetricExpr": "local_processor_write_data_beats_cs0 + local_processor_write_data_beats_cs1 + local_processor_write_data_beats_cs2 + local_processor_write_data_beats_cs3 + local_processor_write_data_beats_cs4 + local_processor_write_data_beats_cs5 + local_processor_write_data_beats_cs6 + local_processor_write_data_beats_cs7 + local_processor_write_data_beats_cs8 + local_processor_write_data_beats_cs9 + local_processor_write_data_beats_cs10 + local_processor_write_data_beats_cs11",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "dram_read_data_bytes_for_remote_processor",
+    "BriefDescription": "DRAM read data bytes for remote processor.",
+    "MetricExpr": "remote_processor_read_data_beats_cs0 + remote_processor_read_data_beats_cs1 + remote_processor_read_data_beats_cs2 + remote_processor_read_data_beats_cs3 + remote_processor_read_data_beats_cs4 + remote_processor_read_data_beats_cs5 + remote_processor_read_data_beats_cs6 + remote_processor_read_data_beats_cs7 + remote_processor_read_data_beats_cs8 + remote_processor_read_data_beats_cs9 + remote_processor_read_data_beats_cs10 + remote_processor_read_data_beats_cs11",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "dram_write_data_bytes_for_remote_processor",
+    "BriefDescription": "DRAM write data bytes for remote processor.",
+    "MetricExpr": "remote_processor_write_data_beats_cs0 + remote_processor_write_data_beats_cs1 + remote_processor_write_data_beats_cs2 + remote_processor_write_data_beats_cs3 + remote_processor_write_data_beats_cs4 + remote_processor_write_data_beats_cs5 + remote_processor_write_data_beats_cs6 + remote_processor_write_data_beats_cs7 + remote_processor_write_data_beats_cs8 + remote_processor_write_data_beats_cs9 + remote_processor_write_data_beats_cs10 + remote_processor_write_data_beats_cs11",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "local_socket_upstream_dma_read_data_bytes",
+    "BriefDescription": "Local socket upstream DMA read data bytes.",
+    "MetricExpr": "local_socket_upstream_read_beats_iom0 + local_socket_upstream_read_beats_iom1 + local_socket_upstream_read_beats_iom2 + local_socket_upstream_read_beats_iom3",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "local_socket_upstream_dma_write_data_bytes",
+    "BriefDescription": "Local socket upstream DMA write data bytes.",
+    "MetricExpr": "local_socket_upstream_write_beats_iom0 + local_socket_upstream_write_beats_iom1 + local_socket_upstream_write_beats_iom2 + local_socket_upstream_write_beats_iom3",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "remote_socket_upstream_dma_read_data_bytes",
+    "BriefDescription": "Remote socket upstream DMA read data bytes.",
+    "MetricExpr": "remote_socket_upstream_read_beats_iom0 + remote_socket_upstream_read_beats_iom1 + remote_socket_upstream_read_beats_iom2 + remote_socket_upstream_read_beats_iom3",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "remote_socket_upstream_dma_write_data_bytes",
+    "BriefDescription": "Remote socket upstream DMA write data bytes.",
+    "MetricExpr": "remote_socket_upstream_write_beats_iom0 + remote_socket_upstream_write_beats_iom1 + remote_socket_upstream_write_beats_iom2 + remote_socket_upstream_write_beats_iom3",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "local_socket_inbound_data_bytes_to_cpu",
+    "BriefDescription": "Local socket inbound data bytes to the CPU (e.g. read data).",
+    "MetricExpr": "local_socket_inf0_inbound_data_beats_ccm0 + local_socket_inf1_inbound_data_beats_ccm0 + local_socket_inf0_inbound_data_beats_ccm1 + local_socket_inf1_inbound_data_beats_ccm1 + local_socket_inf0_inbound_data_beats_ccm2 + local_socket_inf1_inbound_data_beats_ccm2 + local_socket_inf0_inbound_data_beats_ccm3 + local_socket_inf1_inbound_data_beats_ccm3 + local_socket_inf0_inbound_data_beats_ccm4 + local_socket_inf1_inbound_data_beats_ccm4 + local_socket_inf0_inbound_data_beats_ccm5 + local_socket_inf1_inbound_data_beats_ccm5 + local_socket_inf0_inbound_data_beats_ccm6 + local_socket_inf1_inbound_data_beats_ccm6 + local_socket_inf0_inbound_data_beats_ccm7 + local_socket_inf1_inbound_data_beats_ccm7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "3.0517578125e-5MiB"
+  },
+  {
+    "MetricName": "local_socket_outbound_data_bytes_from_cpu",
+    "BriefDescription": "Local socket outbound data bytes from the CPU (e.g. write data).",
+    "MetricExpr": "local_socket_inf0_outbound_data_beats_ccm0 + local_socket_inf1_outbound_data_beats_ccm0 + local_socket_inf0_outbound_data_beats_ccm1 + local_socket_inf1_outbound_data_beats_ccm1 + local_socket_inf0_outbound_data_beats_ccm2 + local_socket_inf1_outbound_data_beats_ccm2 + local_socket_inf0_outbound_data_beats_ccm3 + local_socket_inf1_outbound_data_beats_ccm3 + local_socket_inf0_outbound_data_beats_ccm4 + local_socket_inf1_outbound_data_beats_ccm4 + local_socket_inf0_outbound_data_beats_ccm5 + local_socket_inf1_outbound_data_beats_ccm5 + local_socket_inf0_outbound_data_beats_ccm6 + local_socket_inf1_outbound_data_beats_ccm6 + local_socket_inf0_outbound_data_beats_ccm7 + local_socket_inf1_outbound_data_beats_ccm7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "remote_socket_inbound_data_bytes_to_cpu",
+    "BriefDescription": "Remote socket inbound data bytes to the CPU (e.g. read data).",
+    "MetricExpr": "remote_socket_inf0_inbound_data_beats_ccm0 + remote_socket_inf1_inbound_data_beats_ccm0 + remote_socket_inf0_inbound_data_beats_ccm1 + remote_socket_inf1_inbound_data_beats_ccm1 + remote_socket_inf0_inbound_data_beats_ccm2 + remote_socket_inf1_inbound_data_beats_ccm2 + remote_socket_inf0_inbound_data_beats_ccm3 + remote_socket_inf1_inbound_data_beats_ccm3 + remote_socket_inf0_inbound_data_beats_ccm4 + remote_socket_inf1_inbound_data_beats_ccm4 + remote_socket_inf0_inbound_data_beats_ccm5 + remote_socket_inf1_inbound_data_beats_ccm5 + remote_socket_inf0_inbound_data_beats_ccm6 + remote_socket_inf1_inbound_data_beats_ccm6 + remote_socket_inf0_inbound_data_beats_ccm7 + remote_socket_inf1_inbound_data_beats_ccm7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "3.0517578125e-5MiB"
+  },
+  {
+    "MetricName": "remote_socket_outbound_data_bytes_from_cpu",
+    "BriefDescription": "Remote socket outbound data bytes from the CPU (e.g. write data).",
+    "MetricExpr": "remote_socket_inf0_outbound_data_beats_ccm0 + remote_socket_inf1_outbound_data_beats_ccm0 + remote_socket_inf0_outbound_data_beats_ccm1 + remote_socket_inf1_outbound_data_beats_ccm1 + remote_socket_inf0_outbound_data_beats_ccm2 + remote_socket_inf1_outbound_data_beats_ccm2 + remote_socket_inf0_outbound_data_beats_ccm3 + remote_socket_inf1_outbound_data_beats_ccm3 + remote_socket_inf0_outbound_data_beats_ccm4 + remote_socket_inf1_outbound_data_beats_ccm4 + remote_socket_inf0_outbound_data_beats_ccm5 + remote_socket_inf1_outbound_data_beats_ccm5 + remote_socket_inf0_outbound_data_beats_ccm6 + remote_socket_inf1_outbound_data_beats_ccm6 + remote_socket_inf0_outbound_data_beats_ccm7 + remote_socket_inf1_outbound_data_beats_ccm7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "local_socket_outbound_data_bytes_from_all_links",
+    "BriefDescription": "Outbound data bytes from all links (local socket).",
+    "MetricExpr": "local_socket_outbound_data_beats_link0 + local_socket_outbound_data_beats_link1 + local_socket_outbound_data_beats_link2 + local_socket_outbound_data_beats_link3 + local_socket_outbound_data_beats_link4 + local_socket_outbound_data_beats_link5 + local_socket_outbound_data_beats_link6 + local_socket_outbound_data_beats_link7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  }
+]
-- 
2.34.1

