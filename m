Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEAB5ED9B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiI1KCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiI1KCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:02:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395C0A9270;
        Wed, 28 Sep 2022 03:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZxjiR31KY0xtYi+f1ZszxKAjcA4hNE+IP5tWO1e6l907c57VCw/ZoW7vrT40oNKSMm20rpz0+flOE4jOIrEJVxCGDsSem4M5P1/l+Vr5eF81vLSQZf1xDdch+I1kldJMFTDtdvJITArsxDtF0AM4Yr7LQJnU+ygqvhUGxoeh4QexeVvBLDwXjK8oTAfoP8XA7fuREyRONzKvRoiV/I7gLOse2D4XqQzcjjnp9rMSDvv4ZS9RtmvyIJTMnF2cXboTgxjWHyStVsLQJl0HKblN0Xub5RA4DdQFsNnuvGJI3DzHDn92G8ilLt2e4Xg2KnqBMROtwfIMGOTAH74XLGS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ//jadqBXex9UpSWWZNWRdFpScRKpRFGxsmTi2FcI4=;
 b=HRjayBxiQASZ/ki4YUjTuD/CbEY0d0QVV6jLOjqdN1VPjYQT6B+UU3IecDbDIQn5wggqh7uZQ6RBkycFqbaRqeEE0QqFs04Dj7cXkWr8mg7ENgT0pIJxVrUPcr/gzfQ0InUkVQRQ4IXh8nwTL7CVM0fO9WnpNza8M5d+NnO9xiGcWiuXFFUqMxc2C4K0F6/gok34apWBFY7WG+x4ysXf537IItINso7aWwlSly2WJWiaCDJ1+67OMQGa3M46GN8BdRMUXRHAqmr0uQ+mwjJut89lkNJOu8TozLE628zTi1AibVfY57hAqxBYKMBoMuT+j9ZerazTNz8iqIBiiLPBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ//jadqBXex9UpSWWZNWRdFpScRKpRFGxsmTi2FcI4=;
 b=hIaZMstcTD+xAWp3J+DYANV6b7hWFNyIySlg/8HdnXzzrd6zEJVWabR1DMyVrngnkldsyA78wdSiigat0Q0CUEi2MSSvnXr8IFpBDv2FHIAkkRDcVvQ99OYuLv1yULKdx0zIGw0WtgcwZ3f8L2ify2BRZsLOOp0E3idCMATQ59w=
Received: from MW2PR16CA0060.namprd16.prod.outlook.com (2603:10b6:907:1::37)
 by IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 10:01:35 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::a0) by MW2PR16CA0060.outlook.office365.com
 (2603:10b6:907:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Wed, 28 Sep 2022 10:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:01:34 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:01:25 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v3 12/15] perf mem/c2c: Add load store event mappings for AMD
Date:   Wed, 28 Sep 2022 15:28:02 +0530
Message-ID: <20220928095805.596-13-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928095805.596-1-ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ed227b-0391-40af-1ea5-08daa1386d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9JQugRFC3wl/TPwfNBl205k7+7173GF4ozOxAUHQgm9w76fHOQGlJoPjGgOMhRIs2IOxWQXcd2tKhBVyWkfZnAQB/JguxGX5DrO/AXsRq0haIP31Qg6n8jXAcU02W6SrA7+HiRHCFhUGWk9SAR1fBTIZrLVZOS0xglOKgMWWIdrIieZIC76C7q6xVr7moK7PsvB4gXpMBTykS4RjqpEHChhL76UeDAufG8bCuw5kZTFNHlrFpZAlyZ0n26xyGB7Ua08OPb7VZT9SXf/PY/Sa0Pzzc1pgz/ww+ZkDHjK4Ssud3sqgsH0PUZOtX9hmf+Go6p/8xPo9PbPSnYDVkGfw07Fau4sMYdpM1jnmT02FxWjBOKLsAAhijles5XIYpUzOP1JkHwpQaVKOu5qiQiEpcAC/7RVm44LlaOY9LtiIty5hMt0kbm6dyLff/jXseM4FYAIsnOqI+1t/FpXFtxcZGPryayNazHsCwpABguNFlQClzaw3vdZIdxEcVkgXqkuQoZ9cE2HA1xRZUzZ/bmfgN+GReFkcusp0btdvOJ4eGWMTJHH5hH6DnKQ7BhQzwe1sj7RVqMillPIhApnfbRUzvtaVu2ShqiFDP7gmn5AXlLJLqoTDhDs+LTn6m+lfduVh57gpDt5kvXcL1NVyp5B8is2uOM2RTk1nCVcega2rAO4ykCBM/Fi0/ugwdASKIiIo+msFXoTp3XrI6nOHfB5zOMsXZpFLWzWUZjklyNe60MPK7n9g5i6eNFsNpFoGBjooF6Yct/N+oStoQsCHG3pgjbepbU8cgWqsqSgLlmOXKDcf6ovOP6l8Ajh+YQQAUwSRo9FHJwf48bandDXNQT42A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(81166007)(356005)(82740400003)(36860700001)(6666004)(316002)(26005)(7416002)(41300700001)(2906002)(36756003)(2616005)(40460700003)(478600001)(7696005)(54906003)(110136005)(83380400001)(70206006)(4326008)(8676002)(70586007)(966005)(1076003)(186003)(47076005)(8936002)(86362001)(5660300002)(426003)(44832011)(16526019)(336012)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:01:34.8744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ed227b-0391-40af-1ea5-08daa1386d51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf mem and c2c tools are wrappers around perf record with mem load/
store events. IBS tagged load/store sample provides most of the
information needed for these tools. Wire in ibs_op// event as mem-ldst
event for AMD.

There are some limitations though: Only load/store micro-ops provide
mem/c2c information. Whereas, IBS does not have a way to choose a
particular type of micro-op to tag. This results in many non-LS
micro-ops being tagged which appear as N/A in the perf report. IBS,
being an uncore pmu from kernel point of view[1], does not support per
process monitoring. Thus, perf mem/c2c on AMD are currently supported
in per-cpu mode only.

Example:
  $ sudo ./perf mem record -- -c 10000
  ^C[ perf record: Woken up 227 times to write data ]
  [ perf record: Captured and wrote 58.760 MB perf.data (836978 samples) ]

  $ sudo ./perf mem report -F mem,sample,snoop
  Samples: 836K of event 'ibs_op//', Event count (approx.): 8418762
  Memory access                  Samples  Snoop
  N/A                             700620  N/A
  L1 hit                          126675  N/A
  L2 hit                             424  N/A
  L3 hit                             664  HitM
  L3 hit                              10  N/A
  Local RAM hit                        2  N/A
  Remote RAM (1 hop) hit            8558  N/A
  Remote Cache (1 hop) hit             3  N/A
  Remote Cache (1 hop) hit             2  HitM
  Remote Cache (2 hops) hit            10  HitM
  Remote Cache (2 hops) hit             6  N/A
  Uncached hit                         4  N/A

[1]: https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-c2c.txt | 14 ++++++++----
 tools/perf/Documentation/perf-mem.txt |  3 ++-
 tools/perf/arch/x86/util/mem-events.c | 31 +++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index f1f7ae6b08d1..5c5eb2def83e 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -19,9 +19,10 @@ C2C stands for Cache To Cache.
 The perf c2c tool provides means for Shared Data C2C/HITM analysis. It allows
 you to track down the cacheline contentions.
 
-On x86, the tool is based on load latency and precise store facility events
+On Intel, the tool is based on load latency and precise store facility events
 provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling
-with thresholding feature.
+with thresholding feature. On AMD, the tool uses IBS op pmu (due to hardware
+limitations, perf c2c is not supported on Zen3 cpus).
 
 These events provide:
   - memory address of the access
@@ -49,7 +50,8 @@ RECORD OPTIONS
 
 -l::
 --ldlat::
-	Configure mem-loads latency. (x86 only)
+	Configure mem-loads latency. Supported on Intel and Arm64 processors
+	only. Ignored on other archs.
 
 -k::
 --all-kernel::
@@ -135,11 +137,15 @@ Following perf record options are configured by default:
   -W,-d,--phys-data,--sample-cpu
 
 Unless specified otherwise with '-e' option, following events are monitored by
-default on x86:
+default on Intel:
 
   cpu/mem-loads,ldlat=30/P
   cpu/mem-stores/P
 
+following on AMD:
+
+  ibs_op//
+
 and following on PowerPC:
 
   cpu/mem-loads/
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 66177511c5c4..005c95580b1e 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -85,7 +85,8 @@ RECORD OPTIONS
 	Be more verbose (show counter open errors, etc)
 
 --ldlat <n>::
-	Specify desired latency for loads event. (x86 only)
+	Specify desired latency for loads event. Supported on Intel and Arm64
+	processors only. Ignored on other archs.
 
 In addition, for report all perf report options are valid, and for record
 all perf record options.
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index 5214370ca4e4..f683ac702247 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/pmu.h"
+#include "util/env.h"
 #include "map_symbol.h"
 #include "mem-events.h"
+#include "linux/string.h"
 
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
@@ -12,18 +14,43 @@ static char mem_stores_name[100];
 
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
-static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+static struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
 	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
 	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores"),
 	E(NULL,			NULL,				NULL),
 };
 
+static struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
+	E(NULL,		NULL,		NULL),
+	E(NULL,		NULL,		NULL),
+	E("mem-ldst",	"ibs_op//",	"ibs_op"),
+};
+
+static int perf_mem_is_amd_cpu(void)
+{
+	struct perf_env env = { .total_mem = 0, };
+
+	perf_env__cpuid(&env);
+	if (env.cpuid && strstarts(env.cpuid, "AuthenticAMD"))
+		return 1;
+	return -1;
+}
+
 struct perf_mem_event *perf_mem_events__ptr(int i)
 {
+	/* 0: Uninitialized, 1: Yes, -1: No */
+	static int is_amd;
+
 	if (i >= PERF_MEM_EVENTS__MAX)
 		return NULL;
 
-	return &perf_mem_events[i];
+	if (!is_amd)
+		is_amd = perf_mem_is_amd_cpu();
+
+	if (is_amd == 1)
+		return &perf_mem_events_amd[i];
+
+	return &perf_mem_events_intel[i];
 }
 
 bool is_mem_loads_aux_event(struct evsel *leader)
-- 
2.31.1

