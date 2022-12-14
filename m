Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D71B64C516
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiLNI3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiLNI30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:29:26 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5EF1A3B5;
        Wed, 14 Dec 2022 00:29:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kob93eInKLlfvSSTlVJi2+YD3yovzA2B0qnhjVw5fvPXDO3wHIQMyPsgFfJr53IoJFU+nTAtZQd/HeX0LjjP3D8LroMLyxvWHvCG0L8UBLWeZfFQ5koKYATg93paV38ePPEOurzNO1cF10bGVBp/EijK1TAmY5P6RDPgTau2ubi6B/ynjL+0Mz0rbP2xj5ua9sSo/A+4zRTHSYDPNFc+dPNwuJBnj0ptIl8OJTiN3kxGHnjc+r/1nJt13GUTpyvHhHtEnjr1wianBlOxQZ0s0M99vXdRJO14kx4aXdbvfQkhIU01zSIxFVH0b7M6MZc5gg/tnb/sN1ufbb2hPxrsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhBt9ntamM35T5i2V8v5ODRohWASJv7YXSM6rIQVnTM=;
 b=Ussd3CkuCqs7Ac5bOO4jzX77wbyTAP0XepIA1AxNMg/LWwVN0X9eSZjBiwvKNH+SRJvmxaK0v8qGB5IcQ77xbKXH1hhuI3/EWM1CL5c7T/xu09fEOf5Wjc3wkmv5zZp1ajOaKsZs3v2FSx2UqWGaorqDusbMWqewDcsSTMuwX2JQty3ljUYlL8Oy/Ip1+PBfxPeePVvwgGL3kiHy0Z1LmpG2QhYEkznv7Ih1MdtkU9nBUz8WT5kgvGUX45RuNJt6j58KkjRp2jgn/ZxXM9Ia/cG6HW1FSZK1srDEB7X/SVU2d8DADq6gI3lC2C9HNjfJitn49BBbIKjVj+6f7Usujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhBt9ntamM35T5i2V8v5ODRohWASJv7YXSM6rIQVnTM=;
 b=l+vQNl+bj3rxKRUHaZvPqQYZgcxua9AoVgdG+ImrHRBendcfiUgHHegDX9z+DZshMblUGa4ZWksG33/I2JAJINDyeM63QYhxMkg8LO1aTneeQJV1oozQsTYE1+5Fm7KNyu5YN/T/HqEa4LGtYDh+L3p9jdVEYHBCgwRmw32fsPU=
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 08:29:18 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::1d) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Wed, 14 Dec 2022 08:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 08:29:17 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 02:29:12 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <eranian@google.com>,
        <irogers@google.com>, <jhladky@redhat.com>,
        <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH v2 3/4] perf vendor events amd: Add Zen 4 metrics
Date:   Wed, 14 Dec 2022 13:56:51 +0530
Message-ID: <20221214082652.419965-4-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214082652.419965-1-sandipan.das@amd.com>
References: <20221214082652.419965-1-sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 96213bc2-5562-4afb-d3d1-08daddad4a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qb5Wspwf4Vh1MrY5hZhdZL8CVNhDXsKhZXBYucOh8AzP4r/1ITqFrFVF7gbWMjvKktYXG1hvWLeQkVegDvQt59nw0KUnn7tEBbrBOhcm8vdP2/niVuLNKaj1nvSjXXCjrghOT7xq6ZMafodDJlYfBha/jHN46++mBllpLLrRsukwvK7uDBAsicDt4Tw6/UOXDcbFOpNGNTAjAlhhZ7eI9UCciN4xYGMGsAx1YacOGr54tJj40lD/VsxQHRecJVgGatoQW/Brr0Lgn6frqx/0gy6P0wsXAlFBv8rora5xuPpyTZNi/wG3JzP2mx84OSbCfsKbv4SwpXcpRpz55eZyujSvC1RvKfSNqt0vuPDPvGQJzLW8YXiha+gH4hVNfAaXEtGxX/wDIe5TxSQlU644vcIU1+6p2R3ctpiRACqPs5hmda9X1Cd0SE1RKnCfKwLsP2yzzF7EAvfhiuyFv8YWVeJZcAtUi5PtFDVOwc7fmP68XFUI9iBYJROepXA9BFclnkQr2GmwfTeefHgt5vr5fxH3Q9PblAmIiR9Xoi6KC3hUE4vDB4yaLiFebhqlqr3N8VrF/vKzhnHpE1JnCq/7tu+FLo431/Ig3eiGCOBBMqXglZt8faz3JnkFl5EVvlmqGAdMM/TySGiqlo1AFwZd0/2DeXopRpuZiF1XTogKYzQX5M5XTAa0VE51yJF6/DfDnJac1NCH5Hy2aEIpEz84/rCPig/vZ0XheWT+iwcwNIY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(426003)(316002)(36756003)(110136005)(54906003)(47076005)(44832011)(83380400001)(2906002)(336012)(186003)(1076003)(40460700003)(6666004)(40480700001)(86362001)(2616005)(26005)(478600001)(16526019)(70206006)(70586007)(82310400005)(82740400003)(41300700001)(5660300002)(8676002)(7416002)(4326008)(30864003)(36860700001)(81166007)(8936002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 08:29:17.5409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96213bc2-5562-4afb-d3d1-08daddad4a9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435
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
index 000000000000..4ae8316c7507
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
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "bad_speculation",
+    "BriefDescription": "Fraction of dispatched ops that did not retire.",
+    "MetricExpr": "d_ratio(de_src_op_disp.all - ex_ret_ops, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "backend_bound",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of backend stalls.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.backend_stalls, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "smt_contention",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because the other thread was selected.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.smt_contention, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "retiring",
+    "BriefDescription": "Fraction of dispatch slots used by ops that retired.",
+    "MetricExpr": "d_ratio(ex_ret_ops, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "frontend_bound_latency",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of a latency bottleneck in the frontend (such as instruction cache or TLB misses).",
+    "MetricExpr": "d_ratio((6 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x6@), total_dispatch_slots)",
+    "MetricGroup": "PipelineL2;frontend_bound_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "frontend_bound_bandwidth",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of a bandwidth bottleneck in the frontend (such as decode or op cache fetch bandwidth).",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend - (6 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x6@), total_dispatch_slots)",
+    "MetricGroup": "PipelineL2;frontend_bound_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "bad_speculation_mispredicts",
+    "BriefDescription": "Fraction of dispatched ops that were flushed due to branch mispredicts.",
+    "MetricExpr": "d_ratio(bad_speculation * ex_ret_brn_misp, ex_ret_brn_misp + resyncs_or_nc_redirects)",
+    "MetricGroup": "PipelineL2;bad_speculation_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "bad_speculation_pipeline_restarts",
+    "BriefDescription": "Fraction of dispatched ops that were flushed due to pipeline restarts (resyncs).",
+    "MetricExpr": "d_ratio(bad_speculation * resyncs_or_nc_redirects, ex_ret_brn_misp + resyncs_or_nc_redirects)",
+    "MetricGroup": "PipelineL2;bad_speculation_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "backend_bound_memory",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of stalls due to the memory subsystem.",
+    "MetricExpr": "backend_bound * d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete)",
+    "MetricGroup": "PipelineL2;backend_bound_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "backend_bound_cpu",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of stalls not related to the memory subsystem.",
+    "MetricExpr": "backend_bound * (1 - d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete))",
+    "MetricGroup": "PipelineL2;backend_bound_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "retiring_fastpath",
+    "BriefDescription": "Fraction of dispatch slots used by fastpath ops that retired.",
+    "MetricExpr": "retiring * (1 - d_ratio(ex_ret_ucode_ops, ex_ret_ops))",
+    "MetricGroup": "PipelineL2;retiring_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "retiring_microcode",
+    "BriefDescription": "Fraction of dispatch slots used by microcode ops that retired.",
+    "MetricExpr": "retiring * d_ratio(ex_ret_ucode_ops, ex_ret_ops)",
+    "MetricGroup": "PipelineL2;retiring_group",
+    "ScaleUnit": "100%"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
new file mode 100644
index 000000000000..5e6a793acf7b
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
+    "MetricName": "dram_read_data_for_local_processor",
+    "BriefDescription": "DRAM read data for local processor.",
+    "MetricExpr": "local_processor_read_data_beats_cs0 + local_processor_read_data_beats_cs1 + local_processor_read_data_beats_cs2 + local_processor_read_data_beats_cs3 + local_processor_read_data_beats_cs4 + local_processor_read_data_beats_cs5 + local_processor_read_data_beats_cs6 + local_processor_read_data_beats_cs7 + local_processor_read_data_beats_cs8 + local_processor_read_data_beats_cs9 + local_processor_read_data_beats_cs10 + local_processor_read_data_beats_cs11",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "dram_write_data_for_local_processor",
+    "BriefDescription": "DRAM write data for local processor.",
+    "MetricExpr": "local_processor_write_data_beats_cs0 + local_processor_write_data_beats_cs1 + local_processor_write_data_beats_cs2 + local_processor_write_data_beats_cs3 + local_processor_write_data_beats_cs4 + local_processor_write_data_beats_cs5 + local_processor_write_data_beats_cs6 + local_processor_write_data_beats_cs7 + local_processor_write_data_beats_cs8 + local_processor_write_data_beats_cs9 + local_processor_write_data_beats_cs10 + local_processor_write_data_beats_cs11",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "dram_read_data_for_remote_processor",
+    "BriefDescription": "DRAM read data for remote processor.",
+    "MetricExpr": "remote_processor_read_data_beats_cs0 + remote_processor_read_data_beats_cs1 + remote_processor_read_data_beats_cs2 + remote_processor_read_data_beats_cs3 + remote_processor_read_data_beats_cs4 + remote_processor_read_data_beats_cs5 + remote_processor_read_data_beats_cs6 + remote_processor_read_data_beats_cs7 + remote_processor_read_data_beats_cs8 + remote_processor_read_data_beats_cs9 + remote_processor_read_data_beats_cs10 + remote_processor_read_data_beats_cs11",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "dram_write_data_for_remote_processor",
+    "BriefDescription": "DRAM write data for remote processor.",
+    "MetricExpr": "remote_processor_write_data_beats_cs0 + remote_processor_write_data_beats_cs1 + remote_processor_write_data_beats_cs2 + remote_processor_write_data_beats_cs3 + remote_processor_write_data_beats_cs4 + remote_processor_write_data_beats_cs5 + remote_processor_write_data_beats_cs6 + remote_processor_write_data_beats_cs7 + remote_processor_write_data_beats_cs8 + remote_processor_write_data_beats_cs9 + remote_processor_write_data_beats_cs10 + remote_processor_write_data_beats_cs11",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "local_socket_upstream_dma_read_data",
+    "BriefDescription": "Local socket upstream DMA read data.",
+    "MetricExpr": "local_socket_upstream_read_beats_iom0 + local_socket_upstream_read_beats_iom1 + local_socket_upstream_read_beats_iom2 + local_socket_upstream_read_beats_iom3",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "local_socket_upstream_dma_write_data",
+    "BriefDescription": "Local socket upstream DMA write data.",
+    "MetricExpr": "local_socket_upstream_write_beats_iom0 + local_socket_upstream_write_beats_iom1 + local_socket_upstream_write_beats_iom2 + local_socket_upstream_write_beats_iom3",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "remote_socket_upstream_dma_read_data",
+    "BriefDescription": "Remote socket upstream DMA read data.",
+    "MetricExpr": "remote_socket_upstream_read_beats_iom0 + remote_socket_upstream_read_beats_iom1 + remote_socket_upstream_read_beats_iom2 + remote_socket_upstream_read_beats_iom3",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "remote_socket_upstream_dma_write_data",
+    "BriefDescription": "Remote socket upstream DMA write data.",
+    "MetricExpr": "remote_socket_upstream_write_beats_iom0 + remote_socket_upstream_write_beats_iom1 + remote_socket_upstream_write_beats_iom2 + remote_socket_upstream_write_beats_iom3",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "local_socket_inbound_data_to_cpu",
+    "BriefDescription": "Local socket inbound data to the CPU (e.g. read data).",
+    "MetricExpr": "local_socket_inf0_inbound_data_beats_ccm0 + local_socket_inf1_inbound_data_beats_ccm0 + local_socket_inf0_inbound_data_beats_ccm1 + local_socket_inf1_inbound_data_beats_ccm1 + local_socket_inf0_inbound_data_beats_ccm2 + local_socket_inf1_inbound_data_beats_ccm2 + local_socket_inf0_inbound_data_beats_ccm3 + local_socket_inf1_inbound_data_beats_ccm3 + local_socket_inf0_inbound_data_beats_ccm4 + local_socket_inf1_inbound_data_beats_ccm4 + local_socket_inf0_inbound_data_beats_ccm5 + local_socket_inf1_inbound_data_beats_ccm5 + local_socket_inf0_inbound_data_beats_ccm6 + local_socket_inf1_inbound_data_beats_ccm6 + local_socket_inf0_inbound_data_beats_ccm7 + local_socket_inf1_inbound_data_beats_ccm7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "3.0517578125e-5MiB"
+  },
+  {
+    "MetricName": "local_socket_outbound_data_from_cpu",
+    "BriefDescription": "Local socket outbound data from the CPU (e.g. write data).",
+    "MetricExpr": "local_socket_inf0_outbound_data_beats_ccm0 + local_socket_inf1_outbound_data_beats_ccm0 + local_socket_inf0_outbound_data_beats_ccm1 + local_socket_inf1_outbound_data_beats_ccm1 + local_socket_inf0_outbound_data_beats_ccm2 + local_socket_inf1_outbound_data_beats_ccm2 + local_socket_inf0_outbound_data_beats_ccm3 + local_socket_inf1_outbound_data_beats_ccm3 + local_socket_inf0_outbound_data_beats_ccm4 + local_socket_inf1_outbound_data_beats_ccm4 + local_socket_inf0_outbound_data_beats_ccm5 + local_socket_inf1_outbound_data_beats_ccm5 + local_socket_inf0_outbound_data_beats_ccm6 + local_socket_inf1_outbound_data_beats_ccm6 + local_socket_inf0_outbound_data_beats_ccm7 + local_socket_inf1_outbound_data_beats_ccm7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "remote_socket_inbound_data_to_cpu",
+    "BriefDescription": "Remote socket inbound data to the CPU (e.g. read data).",
+    "MetricExpr": "remote_socket_inf0_inbound_data_beats_ccm0 + remote_socket_inf1_inbound_data_beats_ccm0 + remote_socket_inf0_inbound_data_beats_ccm1 + remote_socket_inf1_inbound_data_beats_ccm1 + remote_socket_inf0_inbound_data_beats_ccm2 + remote_socket_inf1_inbound_data_beats_ccm2 + remote_socket_inf0_inbound_data_beats_ccm3 + remote_socket_inf1_inbound_data_beats_ccm3 + remote_socket_inf0_inbound_data_beats_ccm4 + remote_socket_inf1_inbound_data_beats_ccm4 + remote_socket_inf0_inbound_data_beats_ccm5 + remote_socket_inf1_inbound_data_beats_ccm5 + remote_socket_inf0_inbound_data_beats_ccm6 + remote_socket_inf1_inbound_data_beats_ccm6 + remote_socket_inf0_inbound_data_beats_ccm7 + remote_socket_inf1_inbound_data_beats_ccm7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "3.0517578125e-5MiB"
+  },
+  {
+    "MetricName": "remote_socket_outbound_data_from_cpu",
+    "BriefDescription": "Remote socket outbound data from the CPU (e.g. write data).",
+    "MetricExpr": "remote_socket_inf0_outbound_data_beats_ccm0 + remote_socket_inf1_outbound_data_beats_ccm0 + remote_socket_inf0_outbound_data_beats_ccm1 + remote_socket_inf1_outbound_data_beats_ccm1 + remote_socket_inf0_outbound_data_beats_ccm2 + remote_socket_inf1_outbound_data_beats_ccm2 + remote_socket_inf0_outbound_data_beats_ccm3 + remote_socket_inf1_outbound_data_beats_ccm3 + remote_socket_inf0_outbound_data_beats_ccm4 + remote_socket_inf1_outbound_data_beats_ccm4 + remote_socket_inf0_outbound_data_beats_ccm5 + remote_socket_inf1_outbound_data_beats_ccm5 + remote_socket_inf0_outbound_data_beats_ccm6 + remote_socket_inf1_outbound_data_beats_ccm6 + remote_socket_inf0_outbound_data_beats_ccm7 + remote_socket_inf1_outbound_data_beats_ccm7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "local_socket_outbound_data_from_all_links",
+    "BriefDescription": "Outbound data from all links (local socket).",
+    "MetricExpr": "local_socket_outbound_data_beats_link0 + local_socket_outbound_data_beats_link1 + local_socket_outbound_data_beats_link2 + local_socket_outbound_data_beats_link3 + local_socket_outbound_data_beats_link4 + local_socket_outbound_data_beats_link5 + local_socket_outbound_data_beats_link6 + local_socket_outbound_data_beats_link7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.103515625e-5MiB"
+  }
+]
-- 
2.34.1

