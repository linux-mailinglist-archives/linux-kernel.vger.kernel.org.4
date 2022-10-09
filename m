Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1779E5F89EB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJIHLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJIHLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:11:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308BEBC18;
        Sun,  9 Oct 2022 00:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7IaP9g3BUGs9h54R41qjw+2e3yCJkotIuFIN0nCs+LbsS+ZwLtP/vbuJ92Fm3y0evozd2GyoTSjO7jYmexWinq8yhd+oKOUarmfJQJisE1LfXtikfQeJzF3nrd45t7vbamccYybFDkG5h6wN9CSrzAa/+EU1+/7AiqMRFCDQQL9PCzKXsAHyAFMZGuQMB3fWNYlLOE3gcM8ty7oKM76npFYaumF54+o7n3vJMctRL0L8fY+X3ZVjoHoyhykZ4m437oQb1opmugnuv8DDCRCVGB+ZWNhWaLkuS41qC1cPCLIG+rgfGyySZKleYWoPv8jVY3kavgcWyzPvFQohsFM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyOdA0xgsn2S6ntfuGkWBS+LaNrHdTzhR45MQZboLBo=;
 b=Ljk4/Egjjn7KLFq2nLQL+zB2QTu8xYYpWjS3XZ0NTTMKiMJ42diHFNNsvHwZ7TQil7AxVGVk2Mi5nKTV0RhGMMK+guL3iehfXIfEfANynuq9MMxrHoYJMqeHjbuHmnodwjv9Ww5RYM3bdEcG/Xq/D8IQG4p1xOehFAR7Nh4VdBJl6FqieOJ13zeJfiUMD0G92q4zgSOouQ+eHLL0AnVo5SPUZKIxjVvZjGKaaCmK1Bj6tRLuTuMCiLcuEfDIuV71nb+Z9jFtmyX6wE3Tlr4c1s4BjCzWB5nyXTC6GW9iriFEdlQvHGF1RTaw+H4EjXjlMzL2xQYYV7L4JgUfWuu2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyOdA0xgsn2S6ntfuGkWBS+LaNrHdTzhR45MQZboLBo=;
 b=FzvM5T676WfKVH+f9s244VAZaF/xjMpHmKuAKzLjwF0aSWDy+bcAuxuXSfQCI3k/0zAcpLJOiG4zcoHur/tKgNZrDrioKzOyFp7BBW6jll9Wy1LY+nYuULSOH4NEdgioCD7+4tPBYPD70XLWOr1II8jp2pimMRLKH35R6NFYTuE=
Received: from DM6PR03CA0082.namprd03.prod.outlook.com (2603:10b6:5:333::15)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 07:11:28 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::db) by DM6PR03CA0082.outlook.office365.com
 (2603:10b6:5:333::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Sun, 9 Oct 2022 07:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 07:11:28 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 9 Oct 2022 02:11:18 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 4/9] x86/msr: Add the MSR definition for AMD CPPC boost state
Date:   Sun, 9 Oct 2022 15:10:28 +0800
Message-ID: <20221009071033.21170-5-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221009071033.21170-1-Perry.Yuan@amd.com>
References: <20221009071033.21170-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 665b7499-e295-44b7-9350-08daa9c57c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wgk1eTEEbujIYNunLW4hL6kvyuycBIm6DNbTCNab5VYBNcnZHguPyQmARixfvIsZeSErinbtX3TY61tEWY4cbN7Y988bKgBUgUNoit1loWzmCS0MwpjXKenfDs4IBmf6JRMSjXjjayDQaQQXWm9ViYX9AoUXAf/TW5+3xLKmUlpC8BKe1/Yd8WRqZqLI4oLVty/Dvlc9sdjHwxrvVqU0ejXPcwbBcRBBgBe1tK95WlQbgebMVtz2S0jhOzQF9i1VSEYVN7bmkpEdVG8W6/kI42PllA5kHHsdf0xyfItwrcecCsfpL1Wn8jLnazult5hYGKtu+/0wcu5tu/eKf0xDsQzyC77xwshQOwQHulfqhflfD/cHj23SDCFamL+fPqikcXMlvKqRz5pR4LOm2cxy/4VmIrn9IMz9NsVAdwMnpiw0NfhmWBeU8X13DjvlC95lCY+ACh3osvOyO/au/y+vKcypukloYCvjSaXM/e8kB6/LCWQzGbNXcGEAhh678eTAOT3uDdM7QKmrPKQGHxYpVIIWhMKudj8oTp4ey9uDjrYf+ho3EtN5zhdM87BjZ0UjRInserIzQAbajLvaq7ZboGApZdR6GPvQRlfWPnoc2y901hxHdny90l990ul7zjgprt1BO56Ua6GQ4pofxUs3Ea3e1AmUhj9X+3lvutofT3JWr4EoIGOgQvibND0qvDgseC2IM6eD4iPHAAdhYNoN6G9g34WCoBEhcCcxAZmd4krB5y0HevmDBtVbrFo1stSr9k7pzRyD8Ht03e6+pIZ7NqzxevqdTSRYcJMcOtl4VuRwI3y59fGxT4qOC6/RG3DxG69DYwJOqotZGMP9kCQ4L9bFtTHUe4adA2LySqUUxmA2NFW5KfcFbqRci+h8FODFP31VcUy/OXSVow1bzWM0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(36756003)(8936002)(426003)(47076005)(83380400001)(5660300002)(336012)(41300700001)(16526019)(1076003)(186003)(4326008)(2906002)(86362001)(40460700003)(70206006)(2616005)(8676002)(70586007)(316002)(54906003)(110136005)(81166007)(356005)(26005)(7696005)(6666004)(82740400003)(966005)(478600001)(40480700001)(82310400005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 07:11:28.2406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 665b7499-e295-44b7-9350-08daa9c57c28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This MSR can be used to check whether the CPU frequency boost state
is enabled in the hardware control. User can change the boost state in
the BIOS setting,amd_pstate driver will update the boost state according
to this msr value.

AMD Processor Programming Reference (PPR)
Link: https://www.amd.com/system/files/TechDocs/40332.pdf [p1095]
Link: https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip [p162]

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 arch/x86/include/asm/msr-index.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6674bdb096f3..e5ea1c9f747b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -569,6 +569,7 @@
 #define MSR_AMD_CPPC_CAP2		0xc00102b2
 #define MSR_AMD_CPPC_REQ		0xc00102b3
 #define MSR_AMD_CPPC_STATUS		0xc00102b4
+#define MSR_AMD_CPPC_HW_CTL		0xc0010015
 
 #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
 #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
@@ -579,6 +580,8 @@
 #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
 #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
 #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
+#define AMD_CPPC_PRECISION_BOOST_BIT   25
+#define AMD_CPPC_PRECISION_BOOST_ENABLED       BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
 
 /* AMD Performance Counter Global Status and Control MSRs */
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
-- 
2.34.1

