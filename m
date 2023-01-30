Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6626805CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjA3GB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbjA3GBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:01:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D488244AA;
        Sun, 29 Jan 2023 22:01:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT3m+4v9st7t/iR2Juf/DJ28/OTTATDKDbfSR8qHSOPrC7mfEOEdRs3wFgr+hUDctfnoBx+WLOGAMZZIYHIOA3GWuWqm5y1QMMBfVdtGfYqALrEFr3VNa8mCPjd3wyczOwqwQP1gDT1f+9RU2LH8is8ERv0FjpTZQqTtIwZ5Zqg7pzhrXnd/zDRp7QNmADmL6iJt8OLLFhcmlVCPz2m9z2u9x7U2EeI99Ztk2j9nF1S27o/tlBAuaElScMtT4tFMFhzc7Px/xaydvWZ2YBzg4hD66DnO5WgH92j3PF3ystXV3n1uYuZVa8KSnkBqWglHXXPcDrah4FRWhRM1oKis3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3t70GHC+KZ9uqeaeknYCgT+u2wTzp8TF0kraXSY3dc=;
 b=efOd6/W1AcVgfpaPnmwsDziZeRUCe0LEdONQMgfbfbWO3MT4w05gndAc6oAoUUG3keS1wM5jyr8+1bLgcBs7rjNGbrnEx5mjVr5QQlHX9fbkt9iDtBIT9+YF4PxRGe3sFbOsmR9QYul9qW3Z3b8pBD4JfF+9YkwW9mAVbZmtq4rUnMw6c0M9CHaho52CsNBhemEpIx2ONmwNhj3f9YObK9YrMDLBNfngvdpi7RMLAE7F8W2+IeXlgJEulPljjNxkx4spXmYlcMHAW7doZRnOexDOQ2ixQoRFkYdr4G4CYnQkQJA+Xg7YcEM9QQv11WmHGxwEZmUB3gg3npTE9mVxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3t70GHC+KZ9uqeaeknYCgT+u2wTzp8TF0kraXSY3dc=;
 b=djxVCKrhDr7FrRIk1zQKOAyiwZnSJRo6cdHP0xL63AU5WMB5kabd018u2VbWb0sZGUHsJ+9CKXvemA1jZR790L7lrbLUvusVOMKm5bpE+CyRcqu4GqDZupsKXwQcc/lbhrl8EpiMvu9hXEL+H/i8wA50jbRmku0MJa0JoEHQbaI=
Received: from DM6PR02CA0125.namprd02.prod.outlook.com (2603:10b6:5:1b4::27)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 06:01:50 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::49) by DM6PR02CA0125.outlook.office365.com
 (2603:10b6:5:1b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 06:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Mon, 30 Jan 2023 06:01:50 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 00:00:59 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <james.clark@arm.com>,
        <irogers@google.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 2/2] perf session: Show branch speculation info in raw dump
Date:   Mon, 30 Jan 2023 11:29:16 +0530
Message-ID: <c0807da24de0a22bdb905f0b0013f0751e903fa5.1675057032.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1675057032.git.sandipan.das@amd.com>
References: <cover.1675057032.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 239335b3-4377-442f-6b6d-08db02877aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lknprbTRdCsG+WY/98kWDa5xFiZNrjq/xWA4T0kV/JkxfxsGKDQkV35D+/5oyehNz5pnUgpgIT5FD+1cMeRl1KWL2okW4ab9ax+gloMx3o4s8FBlVUEM9Y6rRl4M92avDS4xdnzYM7JoYoBuz+dfhsLZoCAtqn51dpxWUZvaIMR1EvIPKW7LwEprJr+qWj2MpttbL+rGsEriUidzFVamjc+jYXASM3OZg2fHygbiiw6hq0ex3FZyVwvJB9u/H0GxsE5T8EY2o6Lrl6UQQGaVNHfJZZf6UfIo7KLu5fCNxbUuVnolXub5GuiMQnRjq2IfbAIoGe380pVQ/BbAf+A5Zq2xMGw5LXf9FLYjnmXMcA6hvixBryWfVmjT6ijjx72lTzsvI19+A3aZMEYpmlHmD4RGiSZxrYwcHc/Q3NF8YJKUzM/VSDGrz/cp5T2IKFQVezCET719guhTyTN8h2yOEnuqRx7RcRVXO3VzwiEh1fsaK1xS3EHKDzyD3EPQ74v7blFslTHYN+viTuaUebbhIQ++tkg6KCxtDWJy2mG+U7Mpsdq4bOEHTbGtGgx6wcOy0dvT8Y93lhasrA6KVwWNhEG73fVe2cBQ55sUHkBMhTPNeLwTEbAZrCB2kdh/q10dEWKLotMwYqbeCciSxFCWCxfvTg9f7TRZv5+TRNaNqIlcTJd4lUP7t6pOeqGjbhLiq7EFP52zdWR9Kc2igJg3JeMHfq/grW/i7R8bqbElDSU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(40470700004)(46966006)(36840700001)(4326008)(41300700001)(8676002)(40480700001)(6666004)(110136005)(8936002)(316002)(70586007)(54906003)(5660300002)(70206006)(7416002)(44832011)(83380400001)(40460700003)(36756003)(36860700001)(81166007)(7696005)(2906002)(26005)(186003)(16526019)(478600001)(2616005)(86362001)(426003)(336012)(47076005)(356005)(82740400003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 06:01:50.3974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 239335b3-4377-442f-6b6d-08db02877aa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

