Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3454706F68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjEQR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjEQR1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:27:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E02728A;
        Wed, 17 May 2023 10:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1QKtHd2jrRycmijHf6EP2es5N3gQssYUO71KFHIqfKukz37yC+o3jEcD8PjsZC9dURF+hgVESU2e2s1X14zoLdJSjxmypNFbuHFpMmbj0f9AdTecCm3OVIcJFya6NunfItqRwjyS8sPiMW6+Ce+bk+qTUMMWmQ3jAY9jCH1yTCmATcJNTTUM7YpicebIO765nb2UfvDxkJm+1htimb0CqJnzkHPDQjrNpAYicuFE8OJ9By8qVF8Koc1yA+NSr82C1tD8RvWc5mrGfjyJz0n2g6mEhC9RImbTWvSsqAJenDxzTSrcykjpte9EYwCzImMg+5sOSaZHj0iDyJjo22lDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSluWF64MeJ9eHXsjmy112XspKRxBS65IOe9nMPLY2o=;
 b=M/fBHYohckAkuKVMBETC3t3H0Q3DWT14xhDT5KKhawYgE2MF7trtL49KesqAIfudVs9H993YYSxsi4e15JUyE2uU20sKMrqse6dvg7wVJsQ7w2EV7x5hAK1chqnJv5zOLp+cgZvZPyttTdPAyJWdFvkVmfX1nUNVs8wp9qdgSHuW84PgM9XC8n2Q2jOfClYUr9fyyBTh/GcrZ7pBIbsSZnNlCR+zB5Z5I0DQYWJLQJ7+mol5Ta03L1xB5mARYyIoFq32Dysni/BV+NKXmYgCVWEj2Vu2woAC059BOx5wVqX4uY7voYDPmXANa/nSzn2QRKdcmTGWikj86zMVqk83pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSluWF64MeJ9eHXsjmy112XspKRxBS65IOe9nMPLY2o=;
 b=r5ooSw0WWbwyupABHp2zLiXFusmsADJqRTfD34eWZimiSUHXPcENIilejLYp7fKB/CQQL75zRfpYfvJB8XzQ76uoPS5rgccxbpTGfHSKh9jN0/RdH5hrR7hvQ60K6AZXgCAy1T+Jy2Vhy0H+Mbg/ABw9hHoLuejLRJwqnJWXkrM=
Received: from MW4PR03CA0355.namprd03.prod.outlook.com (2603:10b6:303:dc::30)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 17:26:55 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::c6) by MW4PR03CA0355.outlook.office365.com
 (2603:10b6:303:dc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.16 via Frontend
 Transport; Wed, 17 May 2023 17:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 17:26:55 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 12:26:47 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>, <irogers@google.com>, <puwen@hygon.cn>
Subject: [PATCH v4 5/5] pert stat: Add tests for the "--per-cache" option
Date:   Wed, 17 May 2023 22:57:45 +0530
Message-ID: <20230517172745.5833-6-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517172745.5833-1-kprateek.nayak@amd.com>
References: <20230517172745.5833-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: d02e8411-b380-46e9-2a09-08db56fbe95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylMWkZW9iFla22BKKr3Hq3Ya5Z5eEMwA0q69RksJ+AL96jlwoRsjyM6WUhjU1kae9t2zHMZCGvy7l4Cqu5mXULcsovje5iopYWvNpBOD+nmKxjM8GQgn9/6Oabp9rRW71lHaa41NWoGzlbqBVLeyNk4+kgUOk2MBRuVS4Ol4ilheoounHVi19X3zppo6BUthAuZ3HKmMUndAQg3ppW9gdxqNb5UzuB4BnyT/FAmWWtM1o+Dn8fuku0G26A+/BllceP327fH2Q4um/VF1JcX+wf9j5Qx6RNI4PcobVsKF4AdLxN86ppyvIAWfkW3krYaZjQ7/3jrYZAWlX+OwMhqh1p6z8jIrbdCBo/Z5GXjKcyWDl+MPV6EPtq2QeP9Zpc7qL7Z9VPXmpITkAAJkuGwRMl/p479bb74ryVSWfW5FJu/PnZoUMPPHLEHR2HpCRQbJqYj2MKZazwELikHBUuCWv8ijvUXSgV8sU9bJFemw5xYGBKqNKI1LQSd0nb4yJfkvjrBp3V7QbDr8un+eZ8ykPLkERxcI6nWYDgoo4bhpzkOvh2aF0RmDOB/9xIfhtK6wHTbfgQJy6kh8IEpcj2Dryzmvf/ym/EiKaPeUjjtfbugCRc5FQNWmziCtTJlN1u7fyzHyW6iw77uHX246Fs3igdcNn9vReiOsx8ax2bFkWDqBhZnLOaZkGSDns0mrxH7UY/B9x9AUzk3pmJjQEzOrg1mnJgW5QzfCOZqJRk+T18JoJCbvBLBCN03fcnvVM5pi1m8qZCm0GQ9BM9lhMQ8srYLBuMPlbKMq0ucAQJ9tqIM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(7416002)(86362001)(8936002)(8676002)(5660300002)(41300700001)(2906002)(70586007)(316002)(54906003)(4326008)(70206006)(82310400005)(81166007)(356005)(82740400003)(110136005)(83380400001)(336012)(426003)(36860700001)(2616005)(40460700003)(47076005)(107886003)(26005)(40480700001)(1076003)(186003)(7696005)(16526019)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:26:55.3602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d02e8411-b380-46e9-2a09-08db56fbe95f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for the new "--per-cache" option in perf stat for CSV and JSON
generation as well as for the JSON linting.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog:
o v3->v4:
  - Previously part of Patch 2.
---
 .../perf/tests/shell/lib/perf_json_output_lint.py  |  4 +++-
 tools/perf/tests/shell/stat+csv_output.sh          | 14 ++++++++++++++
 tools/perf/tests/shell/stat+json_output.sh         | 13 +++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 61f3059ca54b..4acaaed5560d 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -14,6 +14,7 @@ ap.add_argument('--system-wide', action='store_true')
 ap.add_argument('--event', action='store_true')
 ap.add_argument('--per-core', action='store_true')
 ap.add_argument('--per-thread', action='store_true')
+ap.add_argument('--per-cache', action='store_true')
 ap.add_argument('--per-die', action='store_true')
 ap.add_argument('--per-node', action='store_true')
 ap.add_argument('--per-socket', action='store_true')
@@ -47,6 +48,7 @@ def check_json_output(expected_items):
       'counter-value': lambda x: is_counter_value(x),
       'cgroup': lambda x: True,
       'cpu': lambda x: isint(x),
+      'cache': lambda x: True,
       'die': lambda x: True,
       'event': lambda x: True,
       'event-runtime': lambda x: isfloat(x),
@@ -83,7 +85,7 @@ try:
     expected_items = 7
   elif args.interval or args.per_thread or args.system_wide_no_aggr:
     expected_items = 8
-  elif args.per_core or args.per_socket or args.per_node or args.per_die:
+  elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cache_instance:
     expected_items = 9
   else:
     # If no option is specified, don't check the number of items.
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index fb78b6251a4e..a1969f236a0a 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -40,6 +40,7 @@ function commachecker()
 	;; "--per-socket")	exp=8
 	;; "--per-node")	exp=8
 	;; "--per-die")		exp=8
+	;; "--per-cache")	exp=8
 	esac
 
 	while read line
@@ -145,6 +146,18 @@ check_per_thread()
 	echo "[Success]"
 }
 
+check_per_cache_instance()
+{
+	echo -n "Checking CSV output: per cache instance "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat -x$csv_sep --per-cache -a true 2>&1 | commachecker --per-cache
+	echo "[Success]"
+}
+
 check_per_die()
 {
 	echo -n "Checking CSV output: per die "
@@ -222,6 +235,7 @@ if [ $skip_test -ne 1 ]
 then
 	check_system_wide_no_aggr
 	check_per_core
+	check_per_cache_instance
 	check_per_die
 	check_per_socket
 else
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index f3e4967cc72e..c282afa6217c 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -120,6 +120,18 @@ check_per_thread()
 	echo "[Success]"
 }
 
+check_per_cache_instance()
+{
+	echo -n "Checking json output: per cache_instance "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoia and not root"
+		return
+	fi
+	perf stat -j --per-cache -a true 2>&1 | $PYTHON $pythonchecker --per-cache
+	echo "[Success]"
+}
+
 check_per_die()
 {
 	echo -n "Checking json output: per die "
@@ -197,6 +209,7 @@ if [ $skip_test -ne 1 ]
 then
 	check_system_wide_no_aggr
 	check_per_core
+	check_per_cache_instance
 	check_per_die
 	check_per_socket
 else
-- 
2.25.1

