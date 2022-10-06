Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F345F6AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiJFPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiJFPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:45:17 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4547D58152;
        Thu,  6 Oct 2022 08:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQBlM3fvNEUTIn1OJrlQbHulzPWSFfRR5v1ygH1BlS48Joc+6twccE07OxnYJfzBGgkvgRiVGgdUJHKgc8cYp1WnMjOAt4UvnsavTk0XFZ5wZVJrEsGtBvh7FHuqWhzWPicY/Nim0H36vis6GiZAmFVAbBCfUtineCc4RPZOLl9TAg0wd3KYAkz34VLtsQ6gnijvCgX3MfXK991dibGOikRCBf3aCui+0yc/B638sPzecROoeiAqw7ehwMw2LvWZqUzG8opLEi4jIDhvvSdSfLCQTXuw9tHPR9MNe81k48rxRlHGaLps8dwB/1x672Jbsz1/Kb6Mw8k4emWinmTUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOhZv7mshlIwhAylpL2hI4/npmyBYdh1ja8tz7jrQJQ=;
 b=kkNoJmNfA7J3jH1QI5+hibgNx8Zv9i7HgLlrT4IoWdSHxfqWqLekrFhEo7KQfckCgiG/L/7EP6r2xjBHZ+ACbdhHnPrtUjbyZShKUIF+Qh1A1c+FNT+pcq+cIjT2dfNphd4SG08QBnBiOlR/6aJBafA12pD1I87hMAdJiIUh0NpeuAt+oj6dqDpI3nMsjDmzz8pXGQg+9N360EMaCCp3MWyC/2ekZAhKCXTFD6NPyHrsywL9UNgrzXh3lQCEvfMxhter+39MnTz3FFVbuXW6zf/CR3pWmcJA6nFLugpfTYm6hPoHz03mbuKQJCPv/5i7ktVAWy9L2PpahZ7HO15hXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOhZv7mshlIwhAylpL2hI4/npmyBYdh1ja8tz7jrQJQ=;
 b=GKEdAtN2ZxREWr4bqOTymvB3nimc+TjzNbAXg72Xadql7SAl/sxj7shgklzFb0HXYGzQFWIWXkkPWxNXEsVLCKDYLtF8yIgjJHI764XL6Vv+T3c12FIr1HDPX5LVZXZMV/ZP7QkLRV+xa5z9syIp43EiTfLfh0nH2BT3u/w/N/I=
Received: from MW4PR03CA0194.namprd03.prod.outlook.com (2603:10b6:303:b8::19)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 15:45:11 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::ac) by MW4PR03CA0194.outlook.office365.com
 (2603:10b6:303:b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Thu, 6 Oct 2022 15:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 15:45:11 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 10:44:55 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <peterz@infradead.org>
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
Subject: [PATCH v4 5/8] perf mem/c2c: Add load store event mappings for AMD
Date:   Thu, 6 Oct 2022 21:09:43 +0530
Message-ID: <20221006153946.7816-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006153946.7816-1-ravi.bangoria@amd.com>
References: <20221006153946.7816-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|BL1PR12MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dde0f55-f0d8-4077-c08f-08daa7b1c100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3U/8BEqzVMc8KmW87dbESyWWguk/muwN76t236coIXRmt1RfY1PmvDWGDQOUJMtxuSqgFvWyCP04OQZUwX8yfGCUFqhg5/G0M2QcZQRjGlCdiGWl/9be7ozhrt/4rbuMk5l4G7b1IW8yvvpS8KWU9gXZVtNCPY0G0+kOJVVW3jsIywoiObVIqvHQHdO4f5WbzAO4Z8m+XtvCoWwzZqvgEzoEHSqwdPzaZYzqX3T+L6LiPhwKcTBiTUQXIHD94xB8h7EeEeT1zjpo8U77z2f3B/4hYa/EGaJUX6CnnM9UwTJULAhLes09/rBZP7MRR4tPpxNGE/PDST6hgOuQBHnSzFWl8A+iyBCkfxle9GpTqwprSxaJ1avkE44SdB6OpPWDwH46Nv82AokQf5YlceTU0UfBOXSDuS1UNhMVHTIjvMorSFYAZXvUbXIe2T3a5AvHNSSeB/62yBK/rU8cK9gImeSpmMOWmcalgwJF0PFOoq/GPqde8GaWHJEhpuibDfxIrJAs3X8zVqg8hXctHpIPyt3BpP8Lm122gysr87iS6yavQ3yVSgCQ1+Vbn1x5ZCtkfomlv1sbPZ5utq3/ALfpNORe3O+xpDosqJm9vCYboBbzXID0ZfVex3s+5DpHr8V0xfQ1cReAj+/qc3GjqMbaESBq2mnQfPgLWqMhexihlN4Uv9CFZTaP8pJWyj8RAKHQN64MrsfZ67X4TAM4qc3VSDasNIPCh0kb8dJ/Lzlz42I2P95KAGtqpGP1SNiI31p+9mifCQQUuPrIv+qVGM577dhN/FnMUEVc6C9ZMwBenyNTffy+oTF+SLODjcFRfMqisHKUtNcIWBpKeAh+DmVbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(86362001)(36756003)(82740400003)(81166007)(356005)(316002)(40480700001)(54906003)(966005)(110136005)(8936002)(5660300002)(7416002)(44832011)(8676002)(4326008)(70586007)(70206006)(82310400005)(41300700001)(2906002)(16526019)(47076005)(426003)(336012)(186003)(83380400001)(1076003)(6666004)(7696005)(478600001)(2616005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 15:45:11.3573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dde0f55-f0d8-4077-c08f-08daa7b1c100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
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
2.37.3

