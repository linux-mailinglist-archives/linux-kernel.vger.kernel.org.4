Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9738687D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjBBM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBBM1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:27:32 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F821448C;
        Thu,  2 Feb 2023 04:27:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6yxOXin+b6sD8Debskaz9SvYYRNlse0qX2a0TjSNvJofBZueqBRSujKht/gUoIuqtoh0CcNedKlTd6LUgAlyWrnkokQv/vhYhojz7B0OdcmMksqzRrGv7RKlVvBVjQGxqDkbZSty7f8aXSToDG+pwvxgVXT+AticOcNYJogzEAPCk/QvzEHvsCXcZvm6FH1a+tC4z6u07B2JsysBqkKfZnZUSZ9urAxRIpbVYt8PF2JsaxHvUUtnw58jn3kBSM9O69uBoG0KOOp8r8JL4lAmzcRd4sw5cxkUdf7LbSV+PuhO5vRjBXCz0NOEAGTypJadyOxogMkVcrBBf65MHg/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSfOvvWBr9ba0itMMof2yQVIqCNwurrKdmvKfV9TwRA=;
 b=PbA0DLOZEdxi1T2mmt2OGPnC7IA2UsClqBDwsLiRhnE4CG07RTk6YSzhcBAWHWzuW7lCfuXFv4weQi7zi5a8MB4lARz512y7NKPsh9XoD85F8N9aKFb9S07vaIDLXghNy50vVn2h1ZWdtznM7jGUeQ420xRsK/MEA9dxDoP1yzXdRwosvE+JX/bHo3KHybSxhK7swM9AwRSoNYnLzhFG5wExjtC1V1SeT7wvu2jtsEmWtVjZIW20+b885hLpvKJ6Dma8RN6yGPnoH8dmG8MFt7XqLb7vA9j7j5TT8+5RjqituQD7c+LLAdJll0pbL6ZAeuIZHriFfIDOTIphiXAkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSfOvvWBr9ba0itMMof2yQVIqCNwurrKdmvKfV9TwRA=;
 b=4ZxXyjTOrXuKpT+rayBy+iORXUdmVHuh24uHUKKL4F83twOMaN3dJocuv94Jln5RNdStPvnftDplfia2Q3MzO2qRQQ08tYqwx0y/xByT9XgFug+bdwtY1BIXUldNxa0sQpWNkrRQZKNFTtbH4o8YTJDskgA4xlPyAhR0RfmiwnI=
Received: from DM6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:5:14c::29)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 12:27:29 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:5:14c:cafe::63) by DM6PR11CA0052.outlook.office365.com
 (2603:10b6:5:14c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 12:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.21 via Frontend Transport; Thu, 2 Feb 2023 12:27:29 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 06:27:23 -0600
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
Subject: [PATCH v4 3/4] perf test sample-parsing: Update expected branch flags
Date:   Thu, 2 Feb 2023 17:56:16 +0530
Message-ID: <56e272583552526e999ba0b536ac009ae3613966.1675333809.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2cee29-634c-4aab-c877-08db0518d9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CntnYP7dIqKKfZZYlRJwJRJdFzIIhfKT0of52pM2t1UH/VPawft/FP8uFnco6PUSewaojkhX0o7UMMsL9/F7UwRnCLP2oJi0m5jrw0W+meGObhztuZhfHfG2mht/jLYuyGUS1uU+lOMAQHYxjM+47HL65lQTfHoz9zNYj8d+bjr1OIGSspSmlPmcPaM/6sH+wkurfEP2uyhzeH7YgX107ADo7S0FcvBFpQM46V4B/GJxvWyRZY70BOuk1xFnhUEEVmV2oUBRs1t+e7b/WgFxInSyUGXnRMbQupdpQv3N4zVQoYFGVSxlryCEZFaraL238d6QiLZCVc0OFwwryP2pt/0wD2GHB+hWFg36IQVacT//ILRDQSQfIyAseb8zGJ7KPRVtcULFxZQxuLbEv6PrpWycfUcZI2ZvYWXgS+oM3mMyzvbB0+QrpWmeN4eefQsspvXDbmfr6YjbVuYP1mgOwVa3w4hkceoZ4ZOtL6gIv75dgcrY1/JmfBhOdUUdd3ckSvInzsZbD8FDOYuDERYnZ9Pa7nn8Ay2g2xgAHFXAYQAT1qsSpZd/9AMyi2qGRpjcLb9T51epO8xjmjP5FspfTyWcg5ZEmq5rKuQFYvU57twZuZiDYJGFNgBWcSpbQX9447b0Ln3W0Sh6cdbsOE66j15cRgdIJxXAKjBZT9pv20kK5Hz2AHDx10gW5oFX7WlIV6qDZdhuB6HtzHoCi0ZpIlMUoCZiK1Wg5VXSTmrej0w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(41300700001)(8676002)(4326008)(83380400001)(70586007)(70206006)(8936002)(36756003)(5660300002)(40460700003)(44832011)(186003)(81166007)(26005)(7416002)(16526019)(356005)(36860700001)(2906002)(40480700001)(110136005)(426003)(54906003)(6666004)(316002)(47076005)(86362001)(82740400003)(336012)(478600001)(82310400005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 12:27:29.6761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2cee29-634c-4aab-c877-08db0518d9fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitfield swapping scheme used duing sample parsing has changed
because of the addition of new branch flags, namely "spec", "new_type"
and "priv". Earlier, these were all part of the "reserved" field but
now, each of these fields get swapped separately. Change the expected
flag values accordingly for the test to pass.

E.g.

  $ perf test -v 27

Before:

   27: Sample parsing                                                  :
  --- start ---
  test child forked, pid 61979
  parsing failed for sample_type 0x800
  test child finished with -1
  ---- end ----
  Sample parsing: FAILED!

After:

   27: Sample parsing                                                  :
  --- start ---
  test child forked, pid 63293
  test child finished with 0
  ---- end ----
  Sample parsing: Ok

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/tests/sample-parsing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 927c7f0cc4cc..25a3f6cece50 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -37,7 +37,7 @@
  * in branch_stack variable.
  */
 #define BS_EXPECTED_BE	0xa000d00000000000
-#define BS_EXPECTED_LE	0xd5000000
+#define BS_EXPECTED_LE	0x1aa00000000
 #define FLAG(s)	s->branch_stack->entries[i].flags
 
 static bool samples_same(const struct perf_sample *s1,
-- 
2.34.1

