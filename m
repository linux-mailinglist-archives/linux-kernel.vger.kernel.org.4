Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1A687D52
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBBM17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjBBM1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:27:53 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB638B32D;
        Thu,  2 Feb 2023 04:27:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRIp6BDTCE6H6HVbm6o5uW5q0gB3+u49iuJxSWIp6C5p9oi66ikqFdMvY4Lc7nf4kMnrA9J6hVczVxKhdh/8iKNNr4dtCnYX+J0ERPg7BckBKF7chwaknwsPCWq5PCQOhvIyweLGLD+zzMp4zECXTxp4CGPwZjJ2uIJ+NKpIAjuIUd05ERRZa5/h+LAucpaKrDqQFMZOB7PlyYdPcS1WOn8h8PvUlY2bMuEDFTq4yxoDAsQpraM+q44QGt3C9vaZ2IIsbPn1zqfpp63QD01J9SdARBj26WY+QrKReewGB/z0GdVY6Tw1TZ/8Gmsq2V9Csj5qUCf8n8NKkUQo1VeJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YfGmaFE7m5rxYqbGSHX8cAe16dJevny0odHsvL9mwA=;
 b=hc083eL/Af++BlgaW2hnr+et4qMHqxP2bgdRWX6SlV9ZvAw2ajMBZOMT8fvhMm7FCzp3VMfjHx6ZPqrIXK+FzuN4Fbw+pKj/apjb/dJyesXQxlS9suXGEm9pY78UgrKqBuCyyAx6zGIWVBgo93b1OiQdPtTp5a/9ZZz3bwbGUnwY9VJEQRzUvFCCfQv5/gNbVHOK3mIy1dIMJ8Zm1BsO+ec5lxTJ8WUqKdms2w9iZzmm0F5dUu4521NFOxzDwBzwjhuWKsZiWFEpNqwA1LmvtTXTzs7/ffhuh68LtHyHRAvLWgDoP6rE4VKQb61N3+seUN0rnGrgOE2UW1fMhXyh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YfGmaFE7m5rxYqbGSHX8cAe16dJevny0odHsvL9mwA=;
 b=Y0c/cMff+FV7GOfVk4rgHal1wzDzSAaKnBf3zuwiRzMnlCmWRIQn2M5td4g5nMWVYsXKk3yyC+q81QYrsqIh7a8mF9tfwnkuskfhhlPiB69yyvOs7ZcIjgWaeE40eCHhSenhTsgBaD+JInYLQvF7fQjjuAQbakfml1HC7ahgH8A=
Received: from DM6PR11CA0013.namprd11.prod.outlook.com (2603:10b6:5:190::26)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 12:27:49 +0000
Received: from DS1PEPF0000E632.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::f8) by DM6PR11CA0013.outlook.office365.com
 (2603:10b6:5:190::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 12:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E632.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.21 via Frontend Transport; Thu, 2 Feb 2023 12:27:49 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 06:27:42 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <james.clark@arm.com>,
        <irogers@google.com>, <eranian@google.com>, <maddy@linux.ibm.com>,
        <kjain@linux.ibm.com>, <tmricht@linux.ibm.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 4/4] perf test brstack: Update regex to include spec field
Date:   Thu, 2 Feb 2023 17:56:17 +0530
Message-ID: <048d67c9de3cc8e3dbf19aaa7ff718dec91364c5.1675333809.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1675333809.git.sandipan.das@amd.com>
References: <cover.1675333809.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4c1739-9984-47af-e547-08db0518e580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LoKEP9fn9M4+APSWqABLnMf1blGzF/bt+KbayVAAN2Po3O0BQQbcFb6WnJW9bqC96YrYiFLenXuVtHQ14ontfk0JED+X8IY/Cy+4tPqIONBgUIpPwy47dFWey5RcSXN+z2y+l2MlihWxVIdzZRqs8beQ5mwR4owIysIvj7P5PJcM/i5dsXT91KKc4DnK5ive0jAkKxuHkforgL5WaQd3SwgDRdVnHg17kkauvuqQC7kYU0JgUBA8y8mf9Jv4gPqhb0ZCz1vrs3yiRtG/xVzHRRpPz0OPWsjDBgA0Y1uYhCHcY6QVQCgvtm53tJODpU57uApY02mSqR2IB5mUJKQS34TAoNmSyHj66i01GL5Twhqf0+nw8IODT140qWd4UvsgMhJewl9n8R3QjzYje5oZNKOovjgwtYYAuFrh+pWvFKqOEhwlxah2+S9U0RU1K2VdtDWJNlAAXFSsgNONSGcDp/uzV6U7SqaGt2gUSsnO63n5S48/Lqf0c16sslrbaZXyM/GwqWbIuO7JRBmW4kraJg5T+nwWkwtIPECxyTcEwDfETeUW//v4uq6AnNG6YYq8QtFA/eGvcctfjcIN6yTHFoEVY/BvKpyxbiqfcc088F6cfqZoYK+0JSVJk0J36VMx/M7hIoPNQlmh8gA3ENlti8j3F+gCKVXkoVeFCKwPQBj4Xk1dCi/ZjvJD6WIwRbHPG6N3RayIfl5xzi4hECue5AuvGzu9ibYSRiFQrLqDMZg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(316002)(356005)(110136005)(8936002)(2906002)(81166007)(82740400003)(5660300002)(478600001)(8676002)(7416002)(4326008)(36860700001)(86362001)(70586007)(70206006)(83380400001)(6666004)(47076005)(426003)(44832011)(41300700001)(336012)(40480700001)(82310400005)(54906003)(40460700003)(2616005)(36756003)(186003)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 12:27:49.0059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4c1739-9984-47af-e547-08db0518e580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of new branch flags, the "brstacksym" fields in perf
script output now shows speculation information after the branch type.
Change the regular expressions accordingly for the test to pass. Since
branch speculation information may vary across platforms, the test does
not look for specific values.

E.g.

  $ perf test -v 110

Before:

  110: Check branch stack sampling                                     :
  --- start ---
  test child forked, pid 54154
  Testing user branch stack sampling
  + grep -E -m1 ^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL$ /tmp/__perf_test.program.AfhUI/perf.script
  + cleanup
  + rm -rf /tmp/__perf_test.program.AfhUI
  test child finished with -1
  ---- end ----
  Check branch stack sampling: FAILED!

After:

  110: Check branch stack sampling                                     :
  --- start ---
  test child forked, pid 43716
  Testing user branch stack sampling
  + grep -E -m1 ^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$ /tmp/__perf_test.program.xgzAi/perf.script
  brstack_bench+0x66/brstack_foo+0x0/P/-/-/0/IND_CALL/NON_SPEC_CORRECT_PATH
  + grep -E -m1 ^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$ /tmp/__perf_test.program.xgzAi/perf.script
  brstack_foo+0x1b/brstack_bar+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
  + grep -E -m1 ^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$ /tmp/__perf_test.program.xgzAi/perf.script
  brstack_bench+0x58/brstack_foo+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
  + grep -E -m1 ^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$ /tmp/__perf_test.program.xgzAi/perf.script
  brstack_bench+0x5d/brstack_bar+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
  + grep -E -m1 ^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$ /tmp/__perf_test.program.xgzAi/perf.script
  brstack_bar+0x31/brstack_foo+0x20/P/-/-/0/RET/NON_SPEC_CORRECT_PATH
  + grep -E -m1 ^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$ /tmp/__perf_test.program.xgzAi/perf.script
  brstack_foo+0x36/brstack_bench+0x5d/P/-/-/0/RET/NON_SPEC_CORRECT_PATH
  + grep -E -m1 ^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$ /tmp/__perf_test.program.xgzAi/perf.script
  brstack_bench+0x76/brstack_bench+0x7d/P/-/-/0/COND/NON_SPEC_CORRECT_PATH
  + grep -E -m1 ^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$ /tmp/__perf_test.program.xgzAi/perf.script
  brstack+0x5a/brstack+0x41/P/-/-/0/UNCOND/NON_SPEC_CORRECT_PATH
  + set +x
  Testing branch stack filtering permutation (any_call,CALL|IND_CALL|COND_CALL|SYSCALL|IRQ)
  Testing branch stack filtering permutation (call,CALL|SYSCALL)
  Testing branch stack filtering permutation (cond,COND)
  Testing branch stack filtering permutation (any_ret,RET|COND_RET|SYSRET|ERET)
  Testing branch stack filtering permutation (call,cond,CALL|SYSCALL|COND)
  Testing branch stack filtering permutation (any_call,cond,CALL|IND_CALL|COND_CALL|IRQ|SYSCALL|COND)
  Testing branch stack filtering permutation (cond,any_call,any_ret,COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|RET|COND_RET|SYSRET|ERET)
  test child finished with 0
  ---- end ----
  Check branch stack sampling: Ok

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/tests/shell/test_brstack.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 59195eb80052..1c49d8293003 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -30,14 +30,14 @@ test_user_branches() {
 	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
 
 	set -x
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET$"		$TMPDIR/perf.script
-	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND$"		$TMPDIR/perf.script
+	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"	$TMPDIR/perf.script
+	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
+	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
+	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
+	grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"		$TMPDIR/perf.script
+	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"	$TMPDIR/perf.script
+	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"	$TMPDIR/perf.script
+	grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"		$TMPDIR/perf.script
 	set +x
 
 	# some branch types are still not being tested:
@@ -57,7 +57,7 @@ test_filter() {
 
 	# fail if we find any branch type that doesn't match any of the expected ones
 	# also consider UNKNOWN branch types (-)
-	if grep -E -vm1 "^[^ ]*/($expect|-|( *))$" $TMPDIR/perf.script; then
+	if grep -E -vm1 "^[^ ]*/($expect|-|( *))/.*$" $TMPDIR/perf.script; then
 		return 1
 	fi
 }
-- 
2.34.1

