Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C627F687D4C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBBM1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjBBM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:27:16 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC8B3FF12;
        Thu,  2 Feb 2023 04:27:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWhdIXxsfJUtUTnuSJmUb+H/JdnPNUUhIOiKagkKZrr6B1oHwn9GDt1HTSPI4buXlGXrtegPFi8MfQyGv8bxoAov65VRUd+fsFvYfKU7RcIl2f6O3CJ88VoQdFtGbMIQ6NNA0Qsy7yh/KypRBznpxkZloGCiE3ZO66Mseoaz4Cx/77AyJn76mojRZhcUbsGIYf0epZVN6lSAZKpYpYNSxppo8bdFltNTI3JEaif5lFKRGwCWVihmmvOTAIAZp72qSuXlBtIrcUUkrFSL7j403dykPH6VQW5XsIG0VEMwPHFWvEmFb2bx1IP9Zh3TSML9/TaQ9b4QcPZIM1btq1sFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3t70GHC+KZ9uqeaeknYCgT+u2wTzp8TF0kraXSY3dc=;
 b=B1KscAEfjcK2/fbpZ6uwJ9Tnxr6bmHdthks/RB9Va92B1SS/sTpMDfzdCWM90rDUZFDs2KxtM2zh9vWCjhX6/KgP5pLNhQ2Opf0NMB6CTLZkWsDagoFGAKbv7Yc//Pm7wt+x9R+iQ5y0GPuwaRUmTd5D8rCwjcEekaYkC3U5zhMJHXl1p2XWH3PxE0iccqeaP4sBt8FkF8rHNUtelk02CXklSl+NTTY90LipUUWt8BVQUVxXqwoQJpIMN5tfuJb7NUWgZO90MC+DLRPoLyD5B000mJuYvZmCIAB/IaLFO3pJ3yoqW+oqWAoXrq4Ap2jg6ssp/XvGVY10o7udYtZmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3t70GHC+KZ9uqeaeknYCgT+u2wTzp8TF0kraXSY3dc=;
 b=JqaTE6CpBcES53qyuhPsM+9RySVOj4xeuW8+sfJ1tHFLkqP7azR9IFk38h4MCfCnf/oEfu/TULNEtMt3sI/fWXgC4k50WSJ7pZoR6sEBIMgo5LGPkpdjcFvbCOqtvTe1ALj7W+ulaY7uwcja4myUIGh2BjabVTUqLylYTq24uz8=
Received: from DM6PR04CA0007.namprd04.prod.outlook.com (2603:10b6:5:334::12)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 2 Feb
 2023 12:27:10 +0000
Received: from DS1PEPF0000E62E.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::54) by DM6PR04CA0007.outlook.office365.com
 (2603:10b6:5:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28 via Frontend
 Transport; Thu, 2 Feb 2023 12:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62E.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.21 via Frontend Transport; Thu, 2 Feb 2023 12:27:10 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 06:27:03 -0600
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
Subject: [PATCH v4 2/4] perf session: Show branch speculation info in raw dump
Date:   Thu, 2 Feb 2023 17:56:15 +0530
Message-ID: <c0807da24de0a22bdb905f0b0013f0751e903fa5.1675333809.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62E:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 8648c29c-7265-4668-e8da-08db0518ce75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92/r32rqQVHwQhpRnPV2cdSH87NPsWAfwzOi8kg1XLRiGxkIb96HfW6PKFLZF+rw396t7uEpu3M3cEvMlEuLs5qesz3Gb6YIdJjrIK/umZweDAtBxB2Y1qIaUbMORcH/OMf6aN8grKB/VfSDZNuhH5GYPI3mFzs3IsqihkfsvDY8iRNghhPetfxZtpIXMPYhWEtiuyU6ZD1nl3RU/3DlObZdpQSsvMVR/Q0z72jFzpdm/NdhhGmzMWrnivweZJn5YQAiZuX94T053n7wO3oc9SYqP1wuuh2c85fTcRqgdaZpIC1truv3Yy9X7OgEVYnbtxqSTeYKv8HBvdSbSn3TDPhLlists3R1NIzmYqGgviPfWe8IpSUlpMFqEYKquV/6A5vRONPqOhvpAgThnkgyVBDfEk61+n+D0e60FXPbSKzTDvdiCNzgTMA7ueBF04gSfsIh6O/zaBVeeUuPMrFAinncKSJPWVTlZc2OLFCS0KI+DdJ09t6YH/xqi/47IarIq/AnWWY5NOJMbbZ7yO+hgABwr4I1LCeve5eXCRomsD9eLhKaD/tDSQwi/lDhDJn0MPys65O7oC5BXUcTpmpB1ZJ0QD3b4lGY+vzmehNPs4SPPu60ttLlfDVb5qiyXCfOeWX4AwjYmEHRN5px8YSpwBYwOQ50rkjhGmDaZtNwbnKsJxXgsL9iDCjFxi7PzpUp4HOfnkxSWCroKtoVdsxdfbkUQ4/lF9ECncVKqACxVR4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(7416002)(316002)(47076005)(86362001)(478600001)(2616005)(82740400003)(26005)(6666004)(356005)(81166007)(82310400005)(16526019)(186003)(5660300002)(54906003)(110136005)(83380400001)(336012)(36756003)(426003)(2906002)(40480700001)(40460700003)(36860700001)(8936002)(70206006)(8676002)(44832011)(41300700001)(70586007)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 12:27:10.3464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8648c29c-7265-4668-e8da-08db0518ce75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 7c021c6cedb9..a42f051dab9d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1180,7 +1180,7 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 		struct branch_entry *e = &entries[i];
 
 		if (!callstack) {
-			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x %s\n",
+			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x %s %s\n",
 				i, e->from, e->to,
 				(unsigned short)e->flags.cycles,
 				e->flags.mispred ? "M" : " ",
@@ -1188,7 +1188,8 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
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

