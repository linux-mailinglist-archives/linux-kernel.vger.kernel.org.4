Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAAB64C513
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiLNI3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiLNI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:29:07 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B182BE;
        Wed, 14 Dec 2022 00:29:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB+5Iy++AomDRexd7AcUw57ONeJbUTvgsBwcRrxuXg18mQ+bYvdhocmqtEJ8roQ9wOW64VnyBbrM+uzccMsOLlaxhugsyz4sf86i4ECdpnoHrLlFT4pnDXzRefqFLAnMkTP2DiVOqybl96RdZsQho7YAW7TqPXz1aLf+BDmu7Y8/Tu+Dui8rLt9Y/IsI+T0m0sDpSuVSoIhazWXTxRryLaGCxfmyuxfKkjGWli16Iqu6L0XSc+owDwCWaufT81rNLX1W/l3xWpCMi1VAe95wDWM4fIJrTqvj6gnMMFrMfWDAXg4/b9eHTVnfkyM5m1cC1pENwhFQYogmaNj6m7TQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6peNfk3oMyZcPl4MtPqGtvjdBASP1LncHZIgR+z4bEY=;
 b=dhu3HsgHGesZv0+JpeRflH7iorbfeE+ZdMFrpoJG2K+L1y1nixHQ8fa6Fs4Ekga6l8Ci3ojX2lE6Bh4WHdjZtNs38DoLS7nv3zyOsZY4R9qkzHZTSEeIkqxstsow3j/mVp1ke9IUhORnlImxvw6ZlBjkRWp2oW16/5X7DVtlXazvIr4L5zaWwATRnro866DUr5tgehTNWozllFga2RoexlT9hSY0zLG2ZeuNTizFHk49sV5u+Q7q+t8O3Kc/7bUy3ViScMIGpq8pNXuOEeqnDQiGGrfutmwkZ3TURwDV4Hh06smchmygJRcozqyuII84F1WT7SxPQqUiAadi7JyxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6peNfk3oMyZcPl4MtPqGtvjdBASP1LncHZIgR+z4bEY=;
 b=QhZYdCXWAEHzYmlm3QSxdgGhIUfHXwN5nRHpQy8G01j4SpkveLeRB4/nDiuNv2bRXqtbtoijauP0Mowfpqkqp1/2GmiuO6ScDX7Vu7OLcFJGg1PnJT2YAIQRKjCm0LqdyrO3mDf2O+K4wZ5eJohp+uWLP+L6a0MRNQk2dDJ8oXg=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 08:29:00 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::82) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 08:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 08:28:59 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 02:28:53 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <eranian@google.com>,
        <irogers@google.com>, <jhladky@redhat.com>,
        <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH v2 2/4] perf vendor events amd: Add Zen 4 uncore events
Date:   Wed, 14 Dec 2022 13:56:50 +0530
Message-ID: <20221214082652.419965-3-sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fab111d-87ca-434b-3ff1-08daddad3ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSZO09Kwe8F0BmwIHq+MUhtkP/ZVHNMuj8yZ/z3pYAZpns/PzbcavhG5SGujRV06e/vRQpgte/t7ktTKByT8eYY0KqaQaZtAv6F/ZtqERYXL5/TRNGV39T2bZhdyjzOdez8EsQDcktzUoi8iMC9NFAhimkbELSkjqljBkNUjNCJgey0gxsgQmFvQcNKmUDdSfAJWYiOJnnAgMJNGUqSZG4Qbw8zpKTRBePiw5dXJLJrF2Rb/QokldxNNQxzM7Ez36lQyjaIhstkk3MLwSlVwyyU3ZylkQXNDK5YeApq9IMLFloEtoxaIk2ifirL4mEvkRBpWMjD5FYG0Q/eK+aEjkGlnLKkCIBXWZ3BnlfXC8GaF2d6moMFBFV7Bl1Gnb2T3o9aP/B2cOSuhkWpPcXihbzIIHjQFDu9Al1WEreWrPEBmHEGWc4P0R3pE0qEW4AKELVGvWq5rnhMj6LBWh/uPqnobl0Q4FVgZan6dwd+/dvl5I/OPvdrK1MuxFZlKMc5E8yrks4c9qbDXKS+RJL7ZOBsw3eD6CcK9G12W069jxu16k5dCs9l5GXKfw+y4LHWV9X1pTFQ7uitE4RcyPZ3PowMtQCcb6CRPnC95kXhHi2xHZHZfi34NRL+Nb+NS3femznl2dPnX81wHtbjfyWNJy5TSn9xquQhEoKvtyIht6ykqR27Xtf+VvR2QNPvC7O9vUZeryNkioWEXlUQKIPXJBM5gAyhaDe4Xq/8azA7mPPU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(86362001)(356005)(82740400003)(83380400001)(30864003)(70586007)(81166007)(44832011)(5660300002)(2906002)(7416002)(8676002)(4326008)(70206006)(8936002)(426003)(82310400005)(40480700001)(2616005)(26005)(47076005)(316002)(54906003)(336012)(1076003)(186003)(40460700003)(16526019)(110136005)(41300700001)(478600001)(36756003)(36900700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 08:28:59.7204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fab111d-87ca-434b-3ff1-08daddad3ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uncore events taken from Section 2.1.15.5 "L3 Cache Performance
Monitor Counter"s and Section 7.1 "Fabric Performance Monitor Counter
(PMC) Events" in the Processor Programming Reference (PPR) for AMD
Family 19h Model 11h Revision B1 processors. This constitutes events
which capture L3 cache activity and data bandwidth for various links
and interfaces in the Data Fabric.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../pmu-events/arch/x86/amdzen4/cache.json    |  119 ++
 .../arch/x86/amdzen4/data-fabric.json         | 1090 +++++++++++++++++
 2 files changed, 1209 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/data-fabric.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/cache.json b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
index 323ffd4b1423..ecbe9660b2b3 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
@@ -649,5 +649,124 @@
     "EventCode": "0x28f",
     "BriefDescription": "Op cache accesses of all types.",
     "UMask": "0x07"
+  },
+  {
+    "EventName": "l3_lookup_state.l3_miss",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 cache misses.",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.l3_hit",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 cache hits.",
+    "UMask": "0xfe",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.all_coherent_accesses_to_l3",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 cache requests for all coherent accesses.",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.dram_near",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from DRAM in the same NUMA node.",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.dram_far",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from DRAM in a different NUMA node.",
+    "UMask": "0x02",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.near_cache",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from another CCX's cache when the address was in the same NUMA node.",
+    "UMask": "0x04",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.far_cache",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from another CCX's cache when the address was in a different NUMA node.",
+    "UMask": "0x08",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.ext_near",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from extension memory (CXL) in the same NUMA node.",
+    "UMask": "0x10",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.ext_far",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from extension memory (CXL) in a different NUMA node.",
+    "UMask": "0x20",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.all",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency from all data sources.",
+    "UMask": "0x3f",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.dram_near",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from DRAM in the same NUMA node.",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.dram_far",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from DRAM in a different NUMA node.",
+    "UMask": "0x02",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.near_cache",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from another CCX's cache when the address was in the same NUMA node.",
+    "UMask": "0x04",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.far_cache",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from another CCX's cache when the address was in a different NUMA node.",
+    "UMask": "0x08",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.ext_near",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from extension memory (CXL) in the same NUMA node.",
+    "UMask": "0x10",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.ext_far",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from extension memory (CXL) in a different NUMA node.",
+    "UMask": "0x20",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.all",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from all data sources.",
+    "UMask": "0x3f",
+    "Unit": "L3PMC"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/data-fabric.json b/tools/perf/pmu-events/arch/x86/amdzen4/data-fabric.json
new file mode 100644
index 000000000000..cf8f13075e62
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/data-fabric.json
@@ -0,0 +1,1090 @@
+[
+  {
+    "EventName": "local_processor_read_data_beats_cs0",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 0.",
+    "EventCode": "0x1f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_read_data_beats_cs1",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 1.",
+    "EventCode": "0x5f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_read_data_beats_cs2",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 2.",
+    "EventCode": "0x9f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_read_data_beats_cs3",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 3.",
+    "EventCode": "0xdf",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_read_data_beats_cs4",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 4.",
+    "EventCode": "0x11f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_read_data_beats_cs5",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 5.",
+    "EventCode": "0x15f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_read_data_beats_cs6",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 6.",
+    "EventCode": "0x19f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_read_data_beats_cs7",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 7.",
+    "EventCode": "0x1df",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_read_data_beats_cs8",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 8.",
+    "EventCode": "0x21f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_read_data_beats_cs9",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 9.",
+    "EventCode": "0x25f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_read_data_beats_cs10",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 10.",
+    "EventCode": "0x29f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_read_data_beats_cs11",
+    "PublicDescription": "Read data beats (64 bytes) for local processor at Coherent Station (CS) 11.",
+    "EventCode": "0x2df",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs0",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 0.",
+    "EventCode": "0x1f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs1",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 1.",
+    "EventCode": "0x5f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs2",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 2.",
+    "EventCode": "0x9f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs3",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 3.",
+    "EventCode": "0xdf",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs4",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 4.",
+    "EventCode": "0x11f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs5",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 5.",
+    "EventCode": "0x15f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs6",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 6.",
+    "EventCode": "0x19f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs7",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 7.",
+    "EventCode": "0x1df",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs8",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 8.",
+    "EventCode": "0x21f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs9",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 9.",
+    "EventCode": "0x25f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs10",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 10.",
+    "EventCode": "0x29f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_processor_write_data_beats_cs11",
+    "PublicDescription": "Write data beats (64 bytes) for local processor at Coherent Station (CS) 11.",
+    "EventCode": "0x2df",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs0",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 0.",
+    "EventCode": "0x1f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs1",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 1.",
+    "EventCode": "0x5f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs2",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 2.",
+    "EventCode": "0x9f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs3",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 3.",
+    "EventCode": "0xdf",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs4",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 4.",
+    "EventCode": "0x11f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs5",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 5.",
+    "EventCode": "0x15f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs6",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 6.",
+    "EventCode": "0x19f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs7",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 7.",
+    "EventCode": "0x1df",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs8",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 8.",
+    "EventCode": "0x21f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs9",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 9.",
+    "EventCode": "0x25f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs10",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 10.",
+    "EventCode": "0x29f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_read_data_beats_cs11",
+    "PublicDescription": "Read data beats (64 bytes) for remote processor at Coherent Station (CS) 11.",
+    "EventCode": "0x2df",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs0",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 0.",
+    "EventCode": "0x1f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs1",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 1.",
+    "EventCode": "0x5f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs2",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 2.",
+    "EventCode": "0x9f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs3",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 3.",
+    "EventCode": "0xdf",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs4",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 4.",
+    "EventCode": "0x11f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs5",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 5.",
+    "EventCode": "0x15f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs6",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 6.",
+    "EventCode": "0x19f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs7",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 7.",
+    "EventCode": "0x1df",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs8",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 8.",
+    "EventCode": "0x21f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs9",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 9.",
+    "EventCode": "0x25f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs10",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 10.",
+    "EventCode": "0x29f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_processor_write_data_beats_cs11",
+    "PublicDescription": "Write data beats (64 bytes) for remote processor at Coherent Station (CS) 11.",
+    "EventCode": "0x2df",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_beats_iom0",
+    "PublicDescription": "Read data beats (64 bytes) for local socket upstream DMA at IO Moderator (IOM) 0.",
+    "EventCode": "0x81f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_beats_iom1",
+    "PublicDescription": "Read data beats (64 bytes) for local socket upstream DMA at IO Moderator (IOM) 1.",
+    "EventCode": "0x85f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_beats_iom2",
+    "PublicDescription": "Read data beats (64 bytes) for local socket upstream DMA at IO Moderator (IOM) 2.",
+    "EventCode": "0x89f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_beats_iom3",
+    "PublicDescription": "Read data beats (64 bytes) for local socket upstream DMA at IO Moderator (IOM) 3.",
+    "EventCode": "0x8df",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_beats_iom0",
+    "PublicDescription": "Write data beats (64 bytes) for local socket upstream DMA at IO Moderator (IOM) 0.",
+    "EventCode": "0x81f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_beats_iom1",
+    "PublicDescription": "Write data beats (64 bytes) for local socket upstream DMA at IO Moderator (IOM) 1.",
+    "EventCode": "0x85f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_beats_iom2",
+    "PublicDescription": "Write data beats (64 bytes) for local socket upstream DMA at IO Moderator (IOM) 2.",
+    "EventCode": "0x89f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_beats_iom3",
+    "PublicDescription": "Write data beats (64 bytes) for local socket upstream DMA at IO Moderator (IOM) 3.",
+    "EventCode": "0x8df",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_beats_iom0",
+    "PublicDescription": "Read data beats (64 bytes) for remote socket upstream DMA at IO Moderator (IOM) 0.",
+    "EventCode": "0x81f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_beats_iom1",
+    "PublicDescription": "Read data beats (64 bytes) for remote socket upstream DMA at IO Moderator (IOM) 1.",
+    "EventCode": "0x85f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_beats_iom2",
+    "PublicDescription": "Read data beats (64 bytes) for remote socket upstream DMA at IO Moderator (IOM) 2.",
+    "EventCode": "0x89f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_beats_iom3",
+    "PublicDescription": "Read data beats (64 bytes) for remote socket upstream DMA at IO Moderator (IOM) 3.",
+    "EventCode": "0x8df",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_beats_iom0",
+    "PublicDescription": "Write data beats (64 bytes) for remote socket upstream DMA at IO Moderator (IOM) 0.",
+    "EventCode": "0x81f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_beats_iom1",
+    "PublicDescription": "Write data beats (64 bytes) for remote socket upstream DMA at IO Moderator (IOM) 1.",
+    "EventCode": "0x85f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_beats_iom2",
+    "PublicDescription": "Write data beats (64 bytes) for remote socket upstream DMA at IO Moderator (IOM) 2.",
+    "EventCode": "0x89f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_beats_iom3",
+    "PublicDescription": "Write data beats (64 bytes) for remote socket upstream DMA at IO Moderator (IOM) 3.",
+    "EventCode": "0x8df",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_inbound_data_beats_ccm0",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for local socket inbound data to CPU Moderator (CCM) 0.",
+    "EventCode": "0x41e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_inbound_data_beats_ccm1",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for local socket inbound data to CPU Moderator (CCM) 1.",
+    "EventCode": "0x45e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_inbound_data_beats_ccm2",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for local socket inbound data to CPU Moderator (CCM) 2.",
+    "EventCode": "0x49e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_inbound_data_beats_ccm3",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for local socket inbound data to CPU Moderator (CCM) 3.",
+    "EventCode": "0x4de",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_inbound_data_beats_ccm4",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for local socket inbound data to CPU Moderator (CCM) 4.",
+    "EventCode": "0x51e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_inbound_data_beats_ccm5",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for local socket inbound data to CPU Moderator (CCM) 5.",
+    "EventCode": "0x55e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_inbound_data_beats_ccm6",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for local socket inbound data to CPU Moderator (CCM) 6.",
+    "EventCode": "0x59e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_inbound_data_beats_ccm7",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for local socket inbound data to CPU Moderator (CCM) 7.",
+    "EventCode": "0x5de",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_inbound_data_beats_ccm0",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for local socket inbound data to CPU Moderator (CCM) 0.",
+    "EventCode": "0x41f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_inbound_data_beats_ccm1",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for local socket inbound data to CPU Moderator (CCM) 1.",
+    "EventCode": "0x45f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_inbound_data_beats_ccm2",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for local socket inbound data to CPU Moderator (CCM) 2.",
+    "EventCode": "0x49f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_inbound_data_beats_ccm3",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for local socket inbound data to CPU Moderator (CCM) 3.",
+    "EventCode": "0x4df",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_inbound_data_beats_ccm4",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for local socket inbound data to CPU Moderator (CCM) 4.",
+    "EventCode": "0x51f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_inbound_data_beats_ccm5",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for local socket inbound data to CPU Moderator (CCM) 5.",
+    "EventCode": "0x55f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_inbound_data_beats_ccm6",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for local socket inbound data to CPU Moderator (CCM) 6.",
+    "EventCode": "0x59f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_inbound_data_beats_ccm7",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for local socket inbound data to CPU Moderator (CCM) 7.",
+    "EventCode": "0x5df",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_outbound_data_beats_ccm0",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for local socket outbound data from CPU Moderator (CCM) 0.",
+    "EventCode": "0x41e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_outbound_data_beats_ccm1",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for local socket outbound data from CPU Moderator (CCM) 1.",
+    "EventCode": "0x45e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_outbound_data_beats_ccm2",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for local socket outbound data from CPU Moderator (CCM) 2.",
+    "EventCode": "0x49e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_outbound_data_beats_ccm3",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for local socket outbound data from CPU Moderator (CCM) 3.",
+    "EventCode": "0x4de",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_outbound_data_beats_ccm4",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for local socket outbound data from CPU Moderator (CCM) 4.",
+    "EventCode": "0x51e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_outbound_data_beats_ccm5",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for local socket outbound data from CPU Moderator (CCM) 5.",
+    "EventCode": "0x55e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_outbound_data_beats_ccm6",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for local socket outbound data from CPU Moderator (CCM) 6.",
+    "EventCode": "0x59e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf0_outbound_data_beats_ccm7",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for local socket outbound data from CPU Moderator (CCM) 7.",
+    "EventCode": "0x5de",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_outbound_data_beats_ccm0",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for local socket outbound data from CPU Moderator (CCM) 0.",
+    "EventCode": "0x41f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_outbound_data_beats_ccm1",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for local socket outbound data from CPU Moderator (CCM) 1.",
+    "EventCode": "0x45f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_outbound_data_beats_ccm2",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for local socket outbound data from CPU Moderator (CCM) 2.",
+    "EventCode": "0x49f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_outbound_data_beats_ccm3",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for local socket outbound data from CPU Moderator (CCM) 3.",
+    "EventCode": "0x4df",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_outbound_data_beats_ccm4",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for local socket outbound data from CPU Moderator (CCM) 4.",
+    "EventCode": "0x51f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_outbound_data_beats_ccm5",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for local socket outbound data from CPU Moderator (CCM) 5.",
+    "EventCode": "0x55f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_outbound_data_beats_ccm6",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for local socket outbound data from CPU Moderator (CCM) 6.",
+    "EventCode": "0x59f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inf1_outbound_data_beats_ccm7",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for local socket outbound data from CPU Moderator (CCM) 7.",
+    "EventCode": "0x5df",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_inbound_data_beats_ccm0",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for remote socket inbound data to CPU Moderator (CCM) 0.",
+    "EventCode": "0x41e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_inbound_data_beats_ccm1",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for remote socket inbound data to CPU Moderator (CCM) 1.",
+    "EventCode": "0x45e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_inbound_data_beats_ccm2",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for remote socket inbound data to CPU Moderator (CCM) 2.",
+    "EventCode": "0x49e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_inbound_data_beats_ccm3",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for remote socket inbound data to CPU Moderator (CCM) 3.",
+    "EventCode": "0x4de",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_inbound_data_beats_ccm4",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for remote socket inbound data to CPU Moderator (CCM) 4.",
+    "EventCode": "0x51e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_inbound_data_beats_ccm5",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for remote socket inbound data to CPU Moderator (CCM) 5.",
+    "EventCode": "0x55e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_inbound_data_beats_ccm6",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for remote socket inbound data to CPU Moderator (CCM) 6.",
+    "EventCode": "0x59e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_inbound_data_beats_ccm7",
+    "PublicDescription": "Data beats (32 bytes) at interface 0 for remote socket inbound data to CPU Moderator (CCM) 7.",
+    "EventCode": "0x5de",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_inbound_data_beats_ccm0",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for remote socket inbound data to CPU Moderator (CCM) 0.",
+    "EventCode": "0x41f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_inbound_data_beats_ccm1",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for remote socket inbound data to CPU Moderator (CCM) 1.",
+    "EventCode": "0x45f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_inbound_data_beats_ccm2",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for remote socket inbound data to CPU Moderator (CCM) 2.",
+    "EventCode": "0x49f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_inbound_data_beats_ccm3",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for remote socket inbound data to CPU Moderator (CCM) 3.",
+    "EventCode": "0x4df",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_inbound_data_beats_ccm4",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for remote socket inbound data to CPU Moderator (CCM) 4.",
+    "EventCode": "0x51f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_inbound_data_beats_ccm5",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for remote socket inbound data to CPU Moderator (CCM) 5.",
+    "EventCode": "0x55f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_inbound_data_beats_ccm6",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for remote socket inbound data to CPU Moderator (CCM) 6.",
+    "EventCode": "0x59f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_inbound_data_beats_ccm7",
+    "PublicDescription": "Data beats (32 bytes) at interface 1 for remote socket inbound data to CPU Moderator (CCM) 7.",
+    "EventCode": "0x5df",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_outbound_data_beats_ccm0",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for remote socket outbound data from CPU Moderator (CCM) 0.",
+    "EventCode": "0x41e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_outbound_data_beats_ccm1",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for remote socket outbound data from CPU Moderator (CCM) 1.",
+    "EventCode": "0x45e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_outbound_data_beats_ccm2",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for remote socket outbound data from CPU Moderator (CCM) 2.",
+    "EventCode": "0x49e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_outbound_data_beats_ccm3",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for remote socket outbound data from CPU Moderator (CCM) 3.",
+    "EventCode": "0x4de",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_outbound_data_beats_ccm4",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for remote socket outbound data from CPU Moderator (CCM) 4.",
+    "EventCode": "0x51e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_outbound_data_beats_ccm5",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for remote socket outbound data from CPU Moderator (CCM) 5.",
+    "EventCode": "0x55e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_outbound_data_beats_ccm6",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for remote socket outbound data from CPU Moderator (CCM) 6.",
+    "EventCode": "0x59e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf0_outbound_data_beats_ccm7",
+    "PublicDescription": "Data beats (64 bytes) at interface 0 for remote socket outbound data from CPU Moderator (CCM) 7.",
+    "EventCode": "0x5de",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_outbound_data_beats_ccm0",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for remote socket outbound data from CPU Moderator (CCM) 0.",
+    "EventCode": "0x41f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_outbound_data_beats_ccm1",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for remote socket outbound data from CPU Moderator (CCM) 1.",
+    "EventCode": "0x45f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_outbound_data_beats_ccm2",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for remote socket outbound data from CPU Moderator (CCM) 2.",
+    "EventCode": "0x49f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_outbound_data_beats_ccm3",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for remote socket outbound data from CPU Moderator (CCM) 3.",
+    "EventCode": "0x4df",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_outbound_data_beats_ccm4",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for remote socket outbound data from CPU Moderator (CCM) 4.",
+    "EventCode": "0x51f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_outbound_data_beats_ccm5",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for remote socket outbound data from CPU Moderator (CCM) 5.",
+    "EventCode": "0x55f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_outbound_data_beats_ccm6",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for remote socket outbound data from CPU Moderator (CCM) 6.",
+    "EventCode": "0x59f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inf1_outbound_data_beats_ccm7",
+    "PublicDescription": "Data beats (64 bytes) at interface 1 for remote socket outbound data from CPU Moderator (CCM) 7.",
+    "EventCode": "0x5df",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link0",
+    "PublicDescription": "Data beats (64 bytes) for local socket outbound data from inter-socket xGMI link 0.",
+    "EventCode": "0xb5f",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link1",
+    "PublicDescription": "Data beats (64 bytes) for local socket outbound data from inter-socket xGMI link 1.",
+    "EventCode": "0xb9f",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link2",
+    "PublicDescription": "Data beats (64 bytes) for local socket outbound data from inter-socket xGMI link 2.",
+    "EventCode": "0xbdf",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link3",
+    "PublicDescription": "Data beats (64 bytes) for local socket outbound data from inter-socket xGMI link 3.",
+    "EventCode": "0xc1f",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link4",
+    "PublicDescription": "Data beats (64 bytes) for local socket outbound data from inter-socket xGMI link 4.",
+    "EventCode": "0xc5f",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link5",
+    "PublicDescription": "Data beats (64 bytes) for local socket outbound data from inter-socket xGMI link 5.",
+    "EventCode": "0xc9f",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link6",
+    "PublicDescription": "Data beats (64 bytes) for local socket outbound data from inter-socket xGMI link 6.",
+    "EventCode": "0xcdf",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link7",
+    "PublicDescription": "Data beats (64 bytes) for local socket outbound data from inter-socket xGMI link 7.",
+    "EventCode": "0xd1f",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  }
+]
-- 
2.34.1

