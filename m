Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D071D7495AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjGFGe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGFGe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:34:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1651B6;
        Wed,  5 Jul 2023 23:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhBuqQHwYKJDIvker3FwKQkds7WSwrSHhD0o2zJBqshxdLoa2w+AX/l4FmsBT+b4Vw0Jw9QoIdKq77+cMB5lgfE/hIHGGNl7oc4cAl+3tV3zlMIsK/jsaw4GSlU4fCFcOTXQCLoSOtiA6QxJ6zyKqjQXpErayKcbgI/rBtwmRqz1EKvzdoewdXWwCvpg4iuqVHvIDjlxoHWR9K7EVPlYvHzHvXQD5e3z+w7kwaWTidwoGq9tPZJBxgvG9PpGSQflbf2+V+h+/pp7ODxTJwfiHW65xPtaoE5xa3/d04P4FD+y2B+DRiLIa0cihVXUIcqVgmXUJ0LLyOYQ3YmiQQRKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfbKpvkQPcFVC6SQiEyXQzJiBkKJMo/1e4aZnUU/CQ4=;
 b=X0F2xWYB5KXvb7KgHMSzzE4ZimBEqiBdKr4Q9xpHD8cq2X7mKIQpwYp19IsVd8LVdnmsT5OabiKKTj/zW3KvzXhrh3aNUEAbh10dJUmo1UK/N5TWwBNywivpuZ70W4e0JCtVZLB5cmgxHAvCRPuHYZzmzzZ6TuOJgRoGPU6bMuTIu38mrOOjvR214zt9y65v2dwUffEyPabTNUo2SpIjXzAPKjORMiKpCLieZZ5dMDZwhpsPXVNAle/kJGLlN6xXc0qY3BXLCJ4/QcWdvO0BlaKtZ7i9ePEvr1CFAdrNHULu7JPoMmY/AvJz5cShl2/xkzxC6lU3REe2PXUQ+20eUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfbKpvkQPcFVC6SQiEyXQzJiBkKJMo/1e4aZnUU/CQ4=;
 b=HxOAfpipp7kFvT1FOuZ/8rozdPOS0eI1kUFpBOki0+ZIyKADXyR5LZPcedTtxHiQP3GjFe9A11bfUC4iqbh+pKAiXLvE3foh0DRIgYK1KQmPq05y4CPGBVUi8VuXKdmwO5oS9z1bZQouZMFJnU7wqAgRZlBIbGBBJsxtnGA/QDQ=
Received: from DM6PR08CA0050.namprd08.prod.outlook.com (2603:10b6:5:1e0::24)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 06:34:54 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::d9) by DM6PR08CA0050.outlook.office365.com
 (2603:10b6:5:1e0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.34 via Frontend
 Transport; Thu, 6 Jul 2023 06:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 06:34:53 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 01:34:48 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <ayush.jain3@amd.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2] perf vendor events amd: Fix large metrics
Date:   Thu, 6 Jul 2023 12:04:40 +0530
Message-ID: <20230706063440.54189-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb77ee6-21e1-4191-4013-08db7deb1bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5X6EnhqSxyXU7K2U1uP55TwsT5SgBhECuBMH/66K7PfyIuL3hs8AAaLC+f82EriFb4iAmOlyeQrWbSGly5kPljf4XMicJt+JLk9lDeSTFn4kAyPP4sBlHBN4oZlf0ZfIrPReWK3VeSaLAdzaoVy5aNHto3GbHI0bz8ANzX7It0t7bcBhR8pcf64XG1hoDgNNXWeEt/K0BCE5wy1trTe9b9d2BjWCyz+Hq8FpVAYp0MflgFA96G9Q6wl8Au7RjUCbDjUcDzPpg2Tf9291WK34F1lDo3Ii198ukbiVirxk54BbJsTzqrl4fkYJWtu5iSB2iZVkxDTa3g7LNWzY0uMHf6CpsWNv6qNzDvuPM+TEzABJASAIrA49p1SAjxOzT/Zxw1dvnAlQvuKomD3EhMqC3NFYvA5IZrCgoab8vwyZYqSNESDWCVjfnUeOzJx+mDLxoUW2e/MvKunF/yoi7g3wWqCj6xj6fQ2LNT0CEttgVQswOes75AeQ2LOrM1NOvoccnw+evKHQlEFNuJWvgkGD0V+jnFrPH1y/sdQxqDMuu5pSkiGFiH1/rN074IOqL3rQaaOMAQdv5oIJaQMyTHT20HKYBqrdDbt13pOpvZ/G0BDq8yr2aHyKdrKMr4jpxzG4hlcbg4TMO9rjXBvLLhmWh/FjWxaXeU/prNqSZL4DPdLdjax4YBMIrfPqKXNonVQTUL001O93BgBckPSV/IAIwrrRGHlO07o+X6yxJXf75KQEG30YD1QzwvvrsNS3h83uuyxIYjZ3h8SpxAAL70KMNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(44832011)(8936002)(5660300002)(8676002)(70586007)(316002)(7416002)(4326008)(70206006)(2906002)(41300700001)(110136005)(54906003)(6666004)(966005)(2616005)(26005)(1076003)(186003)(16526019)(36860700001)(82740400003)(356005)(83380400001)(47076005)(336012)(426003)(478600001)(81166007)(82310400005)(40460700003)(36756003)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 06:34:53.7991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb77ee6-21e1-4191-4013-08db7deb1bb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases where a metric requires more events than the number of
available counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four
data fabric counters but the "nps1_die_to_dram" metric has eight events.
By default, the constituent events are placed in a group and since the
events cannot be scheduled at the same time, the metric is not computed.
The "all metrics" test also fails because of this.

Use the NO_GROUP_EVENTS constraint for such metrics which anyway expect
the user to run perf with "--metric-no-group".

E.g.

  $ sudo perf test -v 101

Before:

  101: perf all metrics test                                           :
  --- start ---
  test child forked, pid 37131
  Testing branch_misprediction_ratio
  Testing all_remote_links_outbound
  Testing nps1_die_to_dram
  Metric 'nps1_die_to_dram' not printed in:
  Error:
  Invalid event (dram_channel_data_controller_4) in per-thread mode, enable system wide with '-a'.
  Testing macro_ops_dispatched
  Testing all_l2_cache_accesses
  Testing all_l2_cache_hits
  Testing all_l2_cache_misses
  Testing ic_fetch_miss_ratio
  Testing l2_cache_accesses_from_l2_hwpf
  Testing l2_cache_misses_from_l2_hwpf
  Testing op_cache_fetch_miss_ratio
  Testing l3_read_miss_latency
  Testing l1_itlb_misses
  test child finished with -1
  ---- end ----
  perf all metrics test: FAILED!

After:

  101: perf all metrics test                                           :
  --- start ---
  test child forked, pid 43766
  Testing branch_misprediction_ratio
  Testing all_remote_links_outbound
  Testing nps1_die_to_dram
  Testing macro_ops_dispatched
  Testing all_l2_cache_accesses
  Testing all_l2_cache_hits
  Testing all_l2_cache_misses
  Testing ic_fetch_miss_ratio
  Testing l2_cache_accesses_from_l2_hwpf
  Testing l2_cache_misses_from_l2_hwpf
  Testing op_cache_fetch_miss_ratio
  Testing l3_read_miss_latency
  Testing l1_itlb_misses
  test child finished with 0
  ---- end ----
  perf all metrics test: Ok

Reported-by: Ayush Jain <ayush.jain3@amd.com>
Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---

Previous versions can be found at:
v1: https://lore.kernel.org/all/20230614090710.680330-1-sandipan.das@amd.com/

Changes in v2:
- As suggested by Ian, use the NO_GROUP_EVENTS constraint instead of
  retrying the test scenario with --metric-no-group.
- Change the commit message accordingly.

 tools/perf/pmu-events/arch/x86/amdzen1/recommended.json | 3 ++-
 tools/perf/pmu-events/arch/x86/amdzen2/recommended.json | 3 ++-
 tools/perf/pmu-events/arch/x86/amdzen3/recommended.json | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
index bf5083c1c260..4d28177325a0 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
@@ -169,8 +169,9 @@
   },
   {
     "MetricName": "nps1_die_to_dram",
-    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die) (may need --metric-no-group)",
+    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die)",
     "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_controller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_channel_data_controller_6 + dram_channel_data_controller_7",
+    "MetricConstraint": "NO_GROUP_EVENTS",
     "MetricGroup": "data_fabric",
     "PerPkg": "1",
     "ScaleUnit": "6.1e-5MiB"
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
index a71694a043ba..60e19456d4c8 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
@@ -169,8 +169,9 @@
   },
   {
     "MetricName": "nps1_die_to_dram",
-    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die) (may need --metric-no-group)",
+    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die)",
     "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_controller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_channel_data_controller_6 + dram_channel_data_controller_7",
+    "MetricConstraint": "NO_GROUP_EVENTS",
     "MetricGroup": "data_fabric",
     "PerPkg": "1",
     "ScaleUnit": "6.1e-5MiB"
diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
index 988cf68ae825..3e9e1781812e 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
@@ -205,10 +205,11 @@
   },
   {
     "MetricName": "nps1_die_to_dram",
-    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die) (may need --metric-no-group)",
+    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die)",
     "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_controller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_channel_data_controller_6 + dram_channel_data_controller_7",
     "MetricGroup": "data_fabric",
     "PerPkg": "1",
+    "MetricConstraint": "NO_GROUP_EVENTS",
     "ScaleUnit": "6.1e-5MiB"
   }
 ]
-- 
2.34.1

