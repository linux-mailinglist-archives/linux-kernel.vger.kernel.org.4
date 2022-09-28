Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FEF5EDB11
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiI1LDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiI1LC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:02:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA4EE99B1;
        Wed, 28 Sep 2022 04:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqfByO76+t1eaNcqqSX4Juq9qSijsaaB7mDtgS2AC4yX2nXo/JaOULXWY2rba2475Vs/ECgUlC2FxNEPBv9thiqwP4je2t5uqgN4Sby/yZjyZMV8Xknh9kRFqVAcZ6/3ov39QXVOqSjb0Xkgn1qrPH3HTJkJYAlS1Xsu+6HEZ+XTtTWs1zVCltEAB5t8TbtFvNr2sb3nUAvyIQKP+fwMLx6VurzoM+Be85Pd5GtagLAdpjKqFokbbPBO9JYBc6QDBQtAILJ65bwtvYkJGxlKq8qQA0ndgBSy6044G0PcP0waE+zp6mQHNyRSp5L+7w3NCPtI0bZ9qXN/jxRifS04Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kranzS12+nRcIPlHADi5YkHloSjz3nniNwLGG5ZZl5s=;
 b=doZaFXtVhY0Bck4SfPgsVSu4nEAG5IQ44X2CNqajzHx8EG+2mdjsK+cUhvZW2Em/ixPV/H22OQSHt87CE33DQ3Dy0iWAbDhgj92sFVMl04iy3sgbhIm1nhKYsC+2BP5gYJoAz6k7JTcz4Vro0Ro1yVG9S5xRzvb2gr9o8RyAR7utB7saF+zecg5Q2YC5xuDFAXyOT1q7U1N6SGN8R+YFopLLxFZdsqt5xzAg31SVzC8oyMSmkLieSaIt7EJrWs0sF2ipwvdiHE564rb2NORGiQB4Z4w3WKtTbAWM64KEqqpD/iFvdFdCGVBxQqcfQ8OjU6z78x30/l1EM9l4UQW3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kranzS12+nRcIPlHADi5YkHloSjz3nniNwLGG5ZZl5s=;
 b=WALP7QhjDFrB1ZeN+o91i9LASg6PPs+2tRURnfwGZFezf2rxsRwEPKInyY9Sw6ZKBuSOZmPT6jtWTz1GjJL2jzsUZyL1teBNrL1DQmX7i5UHi7P2iibFsQ5CXnPiruMH2KkuBKv2yDO9keL2NjCEeoQzRJHUVB4cAt611YdpyiE=
Received: from DM6PR02CA0118.namprd02.prod.outlook.com (2603:10b6:5:1b4::20)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 11:01:27 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::ac) by DM6PR02CA0118.outlook.office365.com
 (2603:10b6:5:1b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 11:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 11:01:27 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 06:01:22 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH v2 3/3] perf session: Show branch speculation info in raw dump
Date:   Wed, 28 Sep 2022 16:29:40 +0530
Message-ID: <3b090cf016c8b624a19e6a80240c27f724c6ea50.1664356751.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1664356751.git.sandipan.das@amd.com>
References: <cover.1664356751.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT006:EE_|DM4PR12MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: c01e78cf-2b99-46d5-1199-08daa140cab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4GEY9UnUBOduaj19HrGtBcDBxf1AQFvj73012VsbXOMhHif0sS64DU6PD4y73fGSels5OJPSEY0R3kk516PCXPEsPy9Lhb1Nc039u/ltJuhPKV4RWYBwzWUpfv/d+RTuz2YsfkAG091aRJyUreJ+QBq6YOWiCkhG8n5b+UNHNdkACV6QKnqsRmbDCn4pKWBMhqlcgShfayrtyuXvtXqaUgxUHa0RmlOFhFYRlO+l4P5yoe5DN4OFJLZtRhDgvFOARmCDVj6vLR5JCUTKu1ShGPsy2l6AsnGjYrBRxFXWLgNWE/8Eh0kNiHN0jHXkvAgmTSaXbSgzojN9Ytvb/y3TDv+e4yW6icSCF4qLX2xaA5knokvlN6XDIfu+Ba0F/MiafGpfMojphY6aA5uFL3FJhdg5oWVeMcbEGu84LXx9ru+fbi5zMKmKi4TZfZPerWWOZRLGO/htIbtPW8y8+EyUa/nN94pHlaP1nZ4jNN1BBQgEaH+ulpqiAGqF7rAwa5SwMXiH18CjWneMqcIUuMPb85vD+YN2QERSQCnzI+Sb1A8nfAvcpgPQhvPJXVv2bKH4agSVli//7SDlW7QpBfwdpYvbgQw4GOpi7CaOb7fVRRmfoHiEkvAMshK5WvXGFnSTmORdmCGCgYYZ1LJoxxg+SbvneirWqI5ILGH5ndW0K3rL03jDvHskM1uNDRIcKqC20D+o8zewBzqco2p+mq7dK+BBYJ2AJb3cnvErnQSuLMY6mNxgJkpnRH2eDpFFvQcvOl7VmN77Ka89slizZPHHPZjkYNLKn3H5GhHkoXwJc4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(316002)(336012)(54906003)(82740400003)(26005)(110136005)(16526019)(426003)(186003)(2616005)(36860700001)(86362001)(8936002)(8676002)(70586007)(40480700001)(2906002)(41300700001)(83380400001)(47076005)(4326008)(81166007)(70206006)(478600001)(40460700003)(82310400005)(356005)(6666004)(7416002)(44832011)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 11:01:27.5964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c01e78cf-2b99-46d5-1199-08daa140cab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the branch speculation info if provided by the branch recording
hardware feature. This can be useful for purposes of code optimization.

E.g.

  $ perf record -j any,u ./test_branch
  $ perf report --dump-raw-trace

Before:

  [...]
  8380958377610 0x40b178 [0x1b0]: PERF_RECORD_SAMPLE(IP, 0x2): 7952/7952: 0x4f851a period: 48973 addr: 0
  ... branch stack: nr:16
  .....  0: 00000000004b52fd -> 00000000004f82c0 0 cycles  P   0
  .....  1: ffffffff8220137c -> 00000000004b52f0 0 cycles M    0
  .....  2: 000000000041d1c4 -> 00000000004b52f0 0 cycles  P   0
  .....  3: 00000000004e7ead -> 000000000041d1b0 0 cycles M    0
  .....  4: 00000000004e7f91 -> 00000000004e7ead 0 cycles  P   0
  .....  5: 00000000004e7ea8 -> 00000000004e7f70 0 cycles  P   0
  .....  6: 00000000004e7e52 -> 00000000004e7e98 0 cycles M    0
  .....  7: 00000000004e7e1f -> 00000000004e7e40 0 cycles M    0
  .....  8: 00000000004e7f60 -> 00000000004e7df0 0 cycles  P   0
  .....  9: 00000000004e7f58 -> 00000000004e7f60 0 cycles M    0
  ..... 10: 000000000041d85d -> 00000000004e7f50 0 cycles  P   0
  ..... 11: 000000000043306a -> 000000000041d840 0 cycles  P   0
  ..... 12: ffffffff8220137c -> 0000000000433040 0 cycles M    0
  ..... 13: 000000000041e4a1 -> 0000000000433040 0 cycles  P   0
  ..... 14: ffffffff8220137c -> 000000000041e490 0 cycles M    0
  ..... 15: 000000000041d89b -> 000000000041e487 0 cycles  P   0
   ... thread: test_branch:7952
   ...... dso: /data/sandipan/test_branch
  [...]

After:

  [...]
  8380958377610 0x40b178 [0x1b0]: PERF_RECORD_SAMPLE(IP, 0x2): 7952/7952: 0x4f851a period: 48973 addr: 0
  ... branch stack: nr:16
  .....  0: 00000000004b52fd -> 00000000004f82c0 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  .....  1: ffffffff8220137c -> 00000000004b52f0 0 cycles M    0  NON_SPEC_CORRECT_PATH
  .....  2: 000000000041d1c4 -> 00000000004b52f0 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  .....  3: 00000000004e7ead -> 000000000041d1b0 0 cycles M    0  NON_SPEC_CORRECT_PATH
  .....  4: 00000000004e7f91 -> 00000000004e7ead 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  .....  5: 00000000004e7ea8 -> 00000000004e7f70 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  .....  6: 00000000004e7e52 -> 00000000004e7e98 0 cycles M    0  SPEC_CORRECT_PATH
  .....  7: 00000000004e7e1f -> 00000000004e7e40 0 cycles M    0  NON_SPEC_CORRECT_PATH
  .....  8: 00000000004e7f60 -> 00000000004e7df0 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  .....  9: 00000000004e7f58 -> 00000000004e7f60 0 cycles M    0  NON_SPEC_CORRECT_PATH
  ..... 10: 000000000041d85d -> 00000000004e7f50 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  ..... 11: 000000000043306a -> 000000000041d840 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  ..... 12: ffffffff8220137c -> 0000000000433040 0 cycles M    0  NON_SPEC_CORRECT_PATH
  ..... 13: 000000000041e4a1 -> 0000000000433040 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  ..... 14: ffffffff8220137c -> 000000000041e490 0 cycles M    0  NON_SPEC_CORRECT_PATH
  ..... 15: 000000000041d89b -> 000000000041e487 0 cycles  P   0  NON_SPEC_CORRECT_PATH
   ... thread: test_branch:7952
   ...... dso: /data/sandipan/test_branch
  [...]

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/util/session.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1a4f10de29ff..71951db535f8 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1177,7 +1177,7 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 		struct branch_entry *e = &entries[i];
 
 		if (!callstack) {
-			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x %s\n",
+			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x %s %s\n",
 				i, e->from, e->to,
 				(unsigned short)e->flags.cycles,
 				e->flags.mispred ? "M" : " ",
@@ -1185,7 +1185,8 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 				e->flags.abort ? "A" : " ",
 				e->flags.in_tx ? "T" : " ",
 				(unsigned)e->flags.reserved,
-				get_branch_type(e));
+				get_branch_type(e),
+				e->flags.spec ? branch_spec_desc(e->flags.spec) : "");
 		} else {
 			if (i == 0) {
 				printf("..... %2"PRIu64": %016" PRIx64 "\n"
-- 
2.34.1

