Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0272172F8AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbjFNJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjFNJH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:07:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A110C2;
        Wed, 14 Jun 2023 02:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfHLma4SpzUCdN1RiSW7zTaCINykjmblzGlAK+5xjNr31qxwacbs3u6rHUIZ3/D2HDM59YGNX5TWd2fh2agK5SkJzUP9Uz+zQ+zOPNTQDvtGFfpSaD/NHZeszk6ElxYg2DoBHJ3YHfj6Q52TWcEwMsWG95atVtCNyvrUTocRuNO1i0v85Am+EqmK60XaJjmXzMsV/7at6k+n7wNiWovRJ4ptLOFobWlgXqUnwuAFUJatIxrbW51EAmtuyiXOlAZ0Wol6zX2xU3vtWvMXEEk+vRz5USSxK/CMixftwAd3BYNUTQMH475tcVDU+sVKRrSvrZMEtrA3k3sSgIcEMDLI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t++Lwtu/YJZf+goiNLSZ9QAb4BXOhAZarGP2bKrmzZY=;
 b=Anz+HIBGFbMKF+Psn6KsnszD+SbA+SLpdSwWcbJ5qotsCx5j1uaaATTOCC+4Cfgp/fqQqGOkQmwSf652E+eojQC0OY3CHKgyDgjx43sd4aGIKdoMg6M63/HqpuH6b3eeAB8BvH4S0XfuS1KYmNgx8xafE7b0mueJqqULmAiY7aEyGgEa4qYbXiecOuVCClt5PVaGNqdy0yo2gf/A0Nnwu4q6GyCkBR089lBsrKngUGCydbP6yeNdnvAhi0i+u+0e5OftcEGbI03Q4u3fUwW+JZyGIuuzvYWDn8DAhTLTl3o0ESAXZiRZMg1Ejzx/tFvs32cUXPEWaw42KGo8jxi13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t++Lwtu/YJZf+goiNLSZ9QAb4BXOhAZarGP2bKrmzZY=;
 b=WreHyFImIU/7XOUcrOiyNernqpbRBHg04GXdJN42J+Npn/JvysQV2TvVmwq4JoKiSEpLSdzIyqt3pDh8ERQLo/cqzLRgtYexbIL6+mAKq11d911X5j9QtgRPn6moBrw1Wd0ipLqqB9oCXzMNJL7RcCzx1jnFYNZGLcsjAJ7d8+Y=
Received: from SN7PR04CA0029.namprd04.prod.outlook.com (2603:10b6:806:f2::34)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 09:07:24 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::8f) by SN7PR04CA0029.outlook.office365.com
 (2603:10b6:806:f2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 09:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 09:07:24 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 04:07:18 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kjain@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <barnali@linux.ibm.com>,
        <ayush.jain3@amd.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH] perf test: Retry without grouping for all metrics test
Date:   Wed, 14 Jun 2023 14:37:10 +0530
Message-ID: <20230614090710.680330-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e52ab4-1496-48b4-34f5-08db6cb6c4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IiemGv5mL5UMIEonzhjJEqBSrlCJiCwoWhsBaFWPjQ3dK2mEPD/6pw9BVorAkI0RAHY2Uydt2jPGCvWtri4CiZX3VayrdFQ5QeqBXoAHqOh9XSqsuLGPskHKkdzfGF1bd+KkSkPHKeu8dJWT2o+LOY9KA2sss4o3VvevnuRIHLowX40qoQGKkItSKobaQx+WrcsmOyyp9Q/c4BOJfDUtEl9lyo8/08pTBnxZkY0aqV0Win1S7/0vGoMriYLf5mOqS0UKRRMOGijEM02u1erodiG5QavZO7i9i8OKpgyYtjN75aKnbOpuHnW2lOfwgQLBC7bBe1DObmsG//N7P06/2a7fqQZl/5v/2+IJhkbDgbHwFqlQkd1FN7MngpTYRe+1ZmuODC2VCFdftKUMrgxO3jzke+k+t0Xk+NIizlig/qlb5VdKOYkLoNqXE7S8JbK88744s8RBCMfbg3h90ANzumFH2fD8NbzmuAiSk1+ji/i/gD4Aez3T1jeQ/aNP50/YkKFylHBZNlSlCZqqu3QS8w/cbwS9dSUOWqfOunufjX3VcvQLzOPSjpRsL2A1kKiuApxDQbIFpsXIHXkKq+HuW2KFCmC14OO7IG7TcxxlDxRkiO9/WrIxzKG8yJe71OdnutlEu1l78CHut8hkeIJriW4z3aZYQVL+ARNMOU/sH6GYemHOEpama4GCtyVnQ5zHJyuUb9IRanZy4AZKVVw7+3sDhmiHK0ZdFiy8/W8jj5WnvRrnj7lGyNQ7+DwsMvIoZ9TYsZ+go9T7xwJHZ8myw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(7696005)(8936002)(26005)(40460700003)(8676002)(41300700001)(36860700001)(356005)(81166007)(478600001)(82740400003)(36756003)(82310400005)(86362001)(70586007)(70206006)(4326008)(1076003)(316002)(110136005)(54906003)(6666004)(40480700001)(44832011)(5660300002)(83380400001)(426003)(336012)(186003)(2616005)(16526019)(7416002)(47076005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 09:07:24.4586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e52ab4-1496-48b4-34f5-08db6cb6c4d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases where a metric uses more events than the number of
counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four data fabric
counters but the "nps1_die_to_dram" metric has eight events. By default,
the constituent events are placed in a group. Since the events cannot be
scheduled at the same time, the metric is not computed. The all metrics
test also fails because of this.

Before announcing failure, the test can try multiple options for each
available metric. After system-wide mode fails, retry once again with
the "--metric-no-group" option.

E.g.

  $ sudo perf test -v 100

Before:

  100: perf all metrics test                                           :
  --- start ---
  test child forked, pid 672731
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

  100: perf all metrics test                                           :
  --- start ---
  test child forked, pid 672887
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
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 54774525e18a..1e88ea8c5677 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -16,6 +16,13 @@ for m in $(perf list --raw-dump metrics); do
   then
     continue
   fi
+  # Failed again, possibly there are not enough counters so retry system wide
+  # mode but without event grouping.
+  result=$(perf stat -M "$m" --metric-no-group -a sleep 0.01 2>&1)
+  if [[ "$result" =~ ${m:0:50} ]]
+  then
+    continue
+  fi
   # Failed again, possibly the workload was too small so retry with something
   # longer.
   result=$(perf stat -M "$m" perf bench internals synthesize 2>&1)
-- 
2.34.1

