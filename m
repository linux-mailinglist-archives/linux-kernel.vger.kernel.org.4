Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0C5645374
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLGFby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLGFbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:31:46 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC89155C8D;
        Tue,  6 Dec 2022 21:31:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQ0KYrQAvHl5+ZuPHJCQM5pbg6PsjbUlk2g2tt8EhIGH947tFOH2dF+n+SIx45wlgtmInTR51BsD2rBG0wyL9oSkM+74kiKBf2s61DLJb0OLSoac+AutDEqvTo5OrJkuZz3skXX2yjDgenR9IzVHRG6tH+CbbIqdDCoRqx5+W9QCiL9NVfo/Gq2GCWuvZXEQm65fb+9ZZDI2GFKdwngyij9FvFucBlX2KVfoAR0ps/wckBH0caQ7u7brfELD6i++Ws/tWiPttk02gq9Ggj6Ve1hD/1J9OghX5xLhUkV7bXzEKI3ZDFaEcjv2YBFNJAGOWmwRjUw7BqfGIYPm5LMuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6peNfk3oMyZcPl4MtPqGtvjdBASP1LncHZIgR+z4bEY=;
 b=BpTlma08QSCDiAwWVD7GP4pEgkNNCZSh7v9jSHy277XPbi1+tluzCpPkNVGgwuEMAGjb90+j7S+/iqFsmYmcOF8TFLLhQmmMWb1DKJmKEAAArBCv+7NkGupbkRDJ2MqdX3kusEF/F3N6x3IN2BokHX38Tz0mQSBmCDUW2+TUxm3mepzEhpvTVFmAjtKe8fZz2UO/UE+4L6rESzTbgntF/IEP+Alfe/noHUmCRQVjJ37Z7XV1NuBFr5gHt6/36ckq5829xfI7MxI4KNO+ZK8LwqPRggzyDpUQzMaRidwDEQApl709ofnCcEOEO07I3G/yJadd6oon9us9ud2I1RMuxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6peNfk3oMyZcPl4MtPqGtvjdBASP1LncHZIgR+z4bEY=;
 b=d2+PHHyWqYxMZMIoHBhlGqdyEdGCYZaioCe2uuNdrXjI+5tKEaF0wiL71SRYfvA6cH+GHtsuP5RY1lL+m9GG5BiKg2oCSAnKpyGta3/DkzowifNUhkgcQugqTEUYWcS/0pEac/jXKk8XvV/5kakW8li2F92a7zrp8gsW0QRCpmI=
Received: from MWH0EPF00056D11.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:14) by DS7PR12MB6141.namprd12.prod.outlook.com
 (2603:10b6:8:9b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 05:31:39 +0000
Received: from CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by MWH0EPF00056D11.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2 via Frontend
 Transport; Wed, 7 Dec 2022 05:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT105.mail.protection.outlook.com (10.13.175.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Wed, 7 Dec 2022 05:31:39 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 23:31:33 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <eranian@google.com>,
        <irogers@google.com>, <jhladky@redhat.com>,
        <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 3/4] perf vendor events amd: Add Zen 4 uncore events
Date:   Wed, 7 Dec 2022 11:00:06 +0530
Message-ID: <20221207053007.336806-4-sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT105:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: ef02b19a-2c7e-4bc8-bd5a-08dad81450e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQWjnOTOHx0kvrz/Iz8BO5n8tNsSrYGrEgNo2mQwWmLpEojuG0HAEFZzyrKE+Yy5UL8QS5DK5nTJymjh7+o4mpf7T9gJuJAr+6vtIWkB/jmCcyLXRddeQlHkkp+0SMBXYrYjQ/MpO0VT8CJizFr2xQfsIrDd0FOnGLF5FvkPP1mGFH3MQOEkaBeWZdL42YRNdvBhV28KZBL/Gzefag4qhUSfD+Cjc3CuzhAfD/PZQgUGQ0qPm5zqu4L8fNaxyLCUynILw0sVxpiZIFg4sMd2ZmOn7+g9c42Nen0++IXgCsoBlx+tL8GzhHFxqTUuO0izhtHUsLieSI1NVZPbWR6Uiji9D0mxnOd58/Jht+Au+ptlmh5LP2f/THVAXev8uETE2wlQzXL6eQYTytMdXAH30YYbihto8GLsrALO+0Zx/6w2gXWVFszufvVXxk87Dn9VMhBZrJQrycYIUaKVrLS78c9vyUdNRZUs1oayMvWoWeWfk+Xapx7u0ifimdcPxWfSxMZXpKRafDwwBKsZOXJiTc6iiE3su+yA79uZ1/YAxKoXcW0WHScwHx/c58ZOkCja0qPrk4nKUycVUY26aWyaLaSGl9AC7myYWs/2lot23S74WdQvH8rBdSlvrMl6eyKowlqsLWxuTZg378p8zqc9TeiwEejJ4bsCjtEeW8kEj3aeom2aICxleB7voCRxO07pHGY2h+T5kNhTj84ngLhHzNIFsW9ODC+9dzBMB7wmQEc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(47076005)(41300700001)(83380400001)(426003)(8936002)(5660300002)(7416002)(30864003)(356005)(70586007)(4326008)(40460700003)(81166007)(36756003)(2906002)(316002)(336012)(44832011)(8676002)(70206006)(6666004)(2616005)(40480700001)(1076003)(16526019)(36860700001)(86362001)(82740400003)(82310400005)(54906003)(478600001)(110136005)(186003)(26005)(36900700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 05:31:39.2766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef02b19a-2c7e-4bc8-bd5a-08dad81450e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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

