Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B71629486
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiKOJjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbiKOJj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:39:28 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E731D0C2;
        Tue, 15 Nov 2022 01:39:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCaRJcoL0E5jMc4Bl4nryklRTM/RvOMWS6WnFYhf2CMltYFxS7Zh0UbIJ6hsOhjPeRVxziu/rejnbZtsU8DN41BlmYtvVuoLtNFfqwjmyanF7M45fiwsLlRE8KfKaT46jld4zAv4UE7bCBnD5w00CLguB22AmKh0djUm9Jd+Ls4dp6IjnVVYVBAdFYcv/iuQAIUmygomFSyIwTiicm5RRLLphtQG+25cCbFqQix3VY7GN2whwAPpvscqZUQMQrK71SNrFKEbzktE0JCyjKshXklwgT6ptm/mA8a615HhFZe+1+g2M9iJyqfTCh5R6u0pr5jX54aRPw24bcr3xP5g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSPL99dGgd0BPJGm890qE454l+fcaJL7Xw4Zv5c0oOI=;
 b=H95+zDUVpwbxUuESMbFYYhmJ9wAKqlTfQ8XaBQb3kYHH+xzE8VFdvbbfKSpW173pFz38VZ3BGsRfpljdEdDK0a6RqaOgYWrVolQdm++EwOuhS+buWpEqCUryBN2uHotXXYQG3o9I4M8HPJlm2VKd4M5Je5aPhoHf0qei6UPgmBewRk7MX1XxkHIqXZ19HpvJpJmYwW9qADsJDZzC/PyVX9TvnEAFqFVHw4Kr7UOY6q641ZJfGEOI/LyzEJHDitOsnfTu7NkuNy4h6BtLGKiaEwQScltgieN5ghw0jArAcPWiRNMTZVxXTgkyzNyL1nAkPqP4wgj2hi55rIwrGG7KzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSPL99dGgd0BPJGm890qE454l+fcaJL7Xw4Zv5c0oOI=;
 b=Z8wyzsD3zY7p2i5AuIi/92QBCOOecs+V2oRGTwgMPAKbzux6Ay6XHUETaawg6GjzRdx0PG6IuLGPA2fFglMsThgl228GZHOmfRlr6uCXG6i9aZlcPStoC1+MpV/Iot/cZo6KlLAl3LYWjypzsVk+qwBDt9hKGLYd2cSIL+DCLtw=
Received: from DS7PR07CA0006.namprd07.prod.outlook.com (2603:10b6:5:3af::16)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 09:39:22 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::6) by DS7PR07CA0006.outlook.office365.com
 (2603:10b6:5:3af::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 09:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 09:39:21 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 03:39:15 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH] perf/amd/ibs: Make IBS a core pmu
Date:   Tue, 15 Nov 2022 15:09:04 +0530
Message-ID: <20221115093904.1799-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5a9ff8-77fa-49c1-2525-08dac6ed4674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ptl6g7OvQpriWA6cODd03GZstruKJ3kMuOrWvmQJJjmnI4GFmKFdB3XFTOUAe1MA/V/Tvv1cg5DnNS5z5vPgpoOzgUNmwqUZ0ni9KqVArutRj1nm5tQFmSZOp5MsPXW4sAlUSjX6Old0a3QUqlq05aRVB6oyI7zqgEGrzq8VukLOJnM5cu1g4vmgmsxqXguyt0BLkeKSy/og/99jlOvLu+74rYy0jhopxJM19/N4z5HNexzk/82r46RU2kPsjWXpVEO4V6cbdBVfIGd1oWPnzJOqx4SVPm0fh+YWt4sDoK1+3xbc5bPGuk3kwpexSvxY8pBZ3xngvbTs9dEaTgAu+Zrxme0di9DXAxDprdXs98KYeLE01BoIfaDIDQ7wfIQNwTo4llJWl+MAHHJkiPcEb2O+qerUatgzYnt2Xr62bdZj5ygfOJNEVw/1sEQmb9SDml0iysXzNuRH635tL6VLCgGW5sS9OKjPkWD3zmdTdKXbRtjsdxOjQ+ERkEl7osRgeP6lbRSU9PMF4CGZCX/HzXqWESLhWAwR2/XNkpZUELTL2EH1jh90vJXXhutQvTdySfpDZs59vUKh+BngcbUjaeeJS9pxLl1ilinl6BQviUzDTXf+bcq3CWniotRcXn9pq4RXxs8cG5K5Eo2BnmLfkbNI+T0Qdgpz6lwu7iPCUC9l5NFebiSenwP3jJqpfVWNMDoXPNkRurN0hjV7KkxLmPMeMtlKu5S46I8cWlYncS2Z21eBr5P1lxFJeThjCKNf7Zfg316gLZ5VdExaZCr9L8v5WV0rdsXjd21b0ia1Fhd1BVaE1nSb1eS6M0pXUSDbLAhke4Coynh4wlBHJQj3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(8936002)(82310400005)(36756003)(7416002)(5660300002)(44832011)(2906002)(8676002)(316002)(6916009)(36860700001)(54906003)(70206006)(86362001)(70586007)(26005)(41300700001)(6666004)(4326008)(7696005)(1076003)(83380400001)(186003)(426003)(336012)(2616005)(40480700001)(40460700003)(478600001)(356005)(16526019)(81166007)(47076005)(966005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:39:21.6974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5a9ff8-77fa-49c1-2525-08dac6ed4674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, only one pmu was allowed to be registered as core pmu and thus
IBS pmus were being registered as uncore. However, with the event context
rewrite, that limitation no longer exists and thus IBS pmus can also be
registered as core pmu. This makes IBS much more usable, for ex, user
will be able to do per-process precise monitoring on AMD:

Before patch:
  $ sudo perf record -e cycles:pp ls
  Error:
  Invalid event (cycles:pp) in per-thread mode, enable system wide with '-a'

After patch:
  $ sudo perf record -e cycles:pp ls
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.017 MB perf.data (33 samples) ]

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
Note:
This patch is dependent on the event context rewrite patch which is
already present in a tip tree:
  https://git.kernel.org/tip/tip/c/bd27568117664

 arch/x86/events/amd/ibs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3271735f0070..fbc2ce86f4b8 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -631,7 +631,7 @@ static const struct attribute_group *op_attr_update[] = {
 
 static struct perf_ibs perf_ibs_fetch = {
 	.pmu = {
-		.task_ctx_nr	= perf_invalid_context,
+		.task_ctx_nr	= perf_hw_context,
 
 		.event_init	= perf_ibs_init,
 		.add		= perf_ibs_add,
@@ -655,7 +655,7 @@ static struct perf_ibs perf_ibs_fetch = {
 
 static struct perf_ibs perf_ibs_op = {
 	.pmu = {
-		.task_ctx_nr	= perf_invalid_context,
+		.task_ctx_nr	= perf_hw_context,
 
 		.event_init	= perf_ibs_init,
 		.add		= perf_ibs_add,
-- 
2.37.3

