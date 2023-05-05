Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7866F8084
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjEEKDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjEEKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:03:44 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2B9EC4;
        Fri,  5 May 2023 03:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvLDc+IHykdFBMm3UxM6UcnVV3u4Ze3VPpuOj/Ic/wf9/C+SG7lVTECsoIY87R6EETnNzRYXkTLL3aPAAsFQLswHRl+HHG3TWiexcHiqhszw8O4e3W7aUn6iBq5J53iI5SC7xwrQ+SRpA+lo+HDhUiwPgPG+p4p4P+4QhalK7V+mdtKHHlHlgQkwSkuVMozR/jIaWlF7gsfbsfBWO7WrEKuVlwTot4BARzTB0fm04siaoRrk7hmQyOJXunRfZzv0aS0+XJoA178kPEg0wyrU+G5rWaJVckYxHAv4hcoNR6g6QEJY7Ms5rZYnPfDVpiWX7fGfL8ot1qiRVXBPjXjRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvb2KFEAG5qxbATKsSz98w+HrNL+FkKLbFmUQSJFqoU=;
 b=NXrOeGTpjKr4SIsF04Ihrc7KLW43Hgsvmw75maTs1CefRgFKcdgKZLNSoyJ8OlyyWn4OrD4fMZwzUd64vuTbrLTqf5S8vIHtxWPvQsBAb0DV7LN/ZkXawCETkVS6DtvhinCkQU14DxDqbZDWzjfqYI1CMi7IZkWdLTZXJYjm3rLcLHMwXmc6Fob7R1SiUFdkZD137Q07ObVuIsXaUXLU27PcgqAX7yIrOgzVChs7OHkBneEx4EmJTDNM8PZAMBjrmnAb89ybhPTG1jVHtMcwvFM+rLFgbjjVbiWiDMM/5aArI1IrFSYgFu+g7Dmh85sC12g2YgJ7bczlJUOUyUaALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvb2KFEAG5qxbATKsSz98w+HrNL+FkKLbFmUQSJFqoU=;
 b=N63VOUquOxSXmc69UzB1zrgYQH+KzCVBwAPxRBdzq6Myzf9UGDfFCiAhZlbwMn4BqRTPkW1dRwjDMqBRRBxLxJhgHDyDOrTRTOvRPB1EGY4051lGTlwkaBQYly/RvjQKPmCr7/zuxOeOyJ/VdsQJqgugEzuIQr5Xc6NWu9zYJHE=
Received: from MW3PR06CA0018.namprd06.prod.outlook.com (2603:10b6:303:2a::23)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 10:03:25 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::75) by MW3PR06CA0018.outlook.office365.com
 (2603:10b6:303:2a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 10:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 10:03:24 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 5 May
 2023 05:03:19 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <terrelln@fb.com>,
        <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 2/2] perf test: Add stat test for record and script
Date:   Fri, 5 May 2023 15:32:54 +0530
Message-ID: <6a5429879764e3dac984cbb11ee2d95cc1604161.1683280603.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <83d6c6c05c54bf00c5a9df32ac160718efca0c7a.1683280603.git.sandipan.das@amd.com>
References: <83d6c6c05c54bf00c5a9df32ac160718efca0c7a.1683280603.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 40192dfc-ec73-41d9-3c72-08db4d4ff73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+sWaEUT3yaJ2v4wnce15cWNFR1iWq/iKmA+rkrfpRBYC9B+0sLZVXImDl7ViYrO8LA74Q2MgbPHOJOtZC6v6+JOajiCJTdbXDK2JXKFjW8SELchjr/UlcgltpPDVU+CTmPmGVb2OzERcSc7Zhf5017Kron66q1f+ohDKVWYUZKOyPu57M8Gi7q+3Ux2d5Ak94DyKDbfnQyXXYFsLAZWBD6WS2RApRPhJoSUypZ9D4LEPX2V2YjTSGnS/urmZ/yEPg+HeAy8xDjVJXMmzOnJn8EnF9VH97yfREGHun9KQWP6+WtJQBg0KNs3hiCD2V3fh8HFGw6+d1NALbQ9B0p5PG6/q8WYLFn2qwX2DbjeVw/m3aBW2ckJNVqQi/fgHQYrEVcoHqdEhIJlL/QfmYyYjpwL2xRovOCrtqaY674cJ52F1GTtPazqyLJMwkw/86lQN1KdadZVoX5tidXyeDeA6nfRJ4AYFUIcme6A77dOpAWBCz3cgBsCiaYNQ0wLEtznd/6B7tHaJ6lgc+Bce+111r0O4mN1ORuUJmiVb4Ps1MH6xo+oq5ooP1XIwFtrpeUD17EO6gOBiQ+PuEp6nN50isPA83aUO86fw4/+VX8OdCzqJpskkfHvhq0XnheL3j0pkeakiesD7OoAdgXZUdhOrMmoD6oMdUB4SVFOsGmCftEWX9T/getszcwEpzfofHOLFQCF7a3mQ8ePK4KxljoG5iuan/GxTtA5wr8A8PIOVt0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(86362001)(36756003)(54906003)(110136005)(316002)(70206006)(4326008)(70586007)(478600001)(6666004)(41300700001)(40480700001)(82310400005)(8676002)(5660300002)(8936002)(2906002)(44832011)(7416002)(82740400003)(356005)(81166007)(16526019)(186003)(2616005)(26005)(36860700001)(426003)(336012)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 10:03:24.7391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40192dfc-ec73-41d9-3c72-08db4d4ff73d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the global aggregation mode, running perf script after perf
stat record can result in a segmentation fault as seen with commit
8b76a3188b85 ("perf stat: Remove unused perf_counts.aggr field"). Add a
basic test to the existing suite of stat-related tests for checking if
that workflow runs without erroring out.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/tests/shell/stat.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 2c1d3f704995..b154fbb15d54 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -28,6 +28,18 @@ test_stat_record_report() {
   echo "stat record and report test [Success]"
 }
 
+test_stat_record_script() {
+  echo "stat record and script test"
+  if ! perf stat record -o - true | perf script -i - 2>&1 | \
+    grep -E -q "CPU[[:space:]]+THREAD[[:space:]]+VAL[[:space:]]+ENA[[:space:]]+RUN[[:space:]]+TIME[[:space:]]+EVENT"
+  then
+    echo "stat record and script test [Failed]"
+    err=1
+    return
+  fi
+  echo "stat record and script test [Success]"
+}
+
 test_stat_repeat_weak_groups() {
   echo "stat repeat weak groups test"
   if ! perf stat -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}' \
@@ -93,6 +105,7 @@ test_topdown_weak_groups() {
 
 test_default_stat
 test_stat_record_report
+test_stat_record_script
 test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
-- 
2.34.1

