Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED279686036
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjBAHEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjBAHD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:03:58 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415256884;
        Tue, 31 Jan 2023 23:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edY3ex+JALzPRjMxUOc2Bo9BKpAwJr0IOw8iAx0R9He3q8d+nPwnTOVwOhDEw5THWFvCht3xye4LTbwsnyg0tkVZcOhmAKKhTLL76hFM5jk6CgzAnlHSc62eejKWgNqBv/1vwyFYzcWJ/23mQUfj4CMjjUOOo9fibHQEEd6WlR/RKGzyaRgbTxiA4HzaaTtTi8Fslb1CT2+o3uqkmIdho0pDatS1fhkHpCMfLQxbsOh16zukKw1H/Itu6hu6qaq8rDM8/RZH1VpozzMU+GrFrMTbSC5sy2UNOneMYlHKZuS80r2PIBg9/D6dtlZxG1gtONa0KIP24dopvfyJpZRHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ints53LEHZwvZLUph0iHAnvFkvCtAya8pcuc92Njd3M=;
 b=CBCTupOpIIiNPaPQlNhJurrlyKt3HqFzgccn4RPwAKM7UP6ug3Lib/xLSiCGCRfNhb8lEIcX6yA092jjqaMsYGnc4fJaXadtDGnOmRjaf7txDo8vJDvTddx0c7+P/13y6smRtMeBRFoNWYRZJHw+eQ9MzRIBh40YkyMg9hBhtJgmSK+kc2OaYr4lv0VWuc3z+CGhm2hBOXl/0ZrxSNZjCMdjRRA2ZbfJFl+40/4PPsUApfpAFq0pMTQ2IiJh8AUy4pOfLuSJpSJIFLqeHNzRobwA+VWcSZMQgoBQ6v2cs5mQymrAbkSM7pkFoRChh7cHIlHCx+BSyDCjQBg29LfSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ints53LEHZwvZLUph0iHAnvFkvCtAya8pcuc92Njd3M=;
 b=jMnKdpnDAii9bmAARieL2Nvn1T2/YkFCSElthWK2qPyTFiuZCqIk67W+z/omzw1UFS/tuk+66YrBzqRpaFE7/oeGIkPecw3g73NzgiXvR9IHoLDZR81RmiJFnfXiYhOZSM829pZ4CvEJ7Tf1yeGRrGglhphe2fiLktfI5+e3qDk=
Received: from MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::10)
 by MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23; Wed, 1 Feb
 2023 07:01:06 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::8d) by MW4P221CA0005.outlook.office365.com
 (2603:10b6:303:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 07:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.24 via Frontend Transport; Wed, 1 Feb 2023 07:01:06 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 01:01:00 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Tor Vic <torvic9@mailbox.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 4/6] Documentation: amd_pstate: Move amd_pstate param to alphabetical order
Date:   Wed, 1 Feb 2023 06:58:21 +0000
Message-ID: <20230201065823.189828-5-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201065823.189828-1-wyes.karny@amd.com>
References: <20230201065823.189828-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|MW4PR12MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d7ea46-90bf-4ed4-ce74-08db0422173e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMjMQRYZVuLMLotOhaQ6KVxIiul80d62XhOeJOanD3hs56E+nNerwozXdjK5hcGeztfLPYTjzuTZhsSTUnYFObWiYDMIHbpp4xDU57qYV1zJoR+xMagKToFhSPegTfCEY0pC2SW++mMrYVnc+GFhZ+J7knbn1UXlB0mXHpzheE3EtBgZFT4Y8nbF3z1ArMu4+UM849A72FEuVeo/GXCi1I8BQRYhwH0d8IuJPyU0Lny5/l1CUFdmCtSf/t8JmUWj4ca6klD3d87PcrbjeLOZGEooe3YwNRW2Xqmq67pi/5ZzyQwYBjujVs4nn9OvIxC6NOPvLGmyqvbGkVrgSyPevAA+G5fBOrc+T8asQbt8LZCXpAFpdgU2he5CqLNBbmGabFdRkebPa82kOOJ8B8AFvXt93HWrU/MUmNIHHv3Z22wnJCWlmcmkfL56+nRUbrRTBIA0WoELiTBmpHHYIcyiyB+chmpMVdQyPmhqa+198fDzgh63XK46nc7cPv8WoM94a/iKJOk5CrSJxWeqfIZ9AHn1BxC6v64xG1D07kG8tLwQbW9cVEGwHXboyQer1QH2ATDPKYuA4Kq9Ug3d3QMIqyjm4QhqljF8Pnk2USbFiDBbbqpgE8Nps2vXoV1Gpk4X0Bg4HK2N0QixUchRgwtt/cOdmrqFjV9KblM6HWUHPAYptXXOOJxDmVJ1bWwhqOLkCkY2wwKdQapYhEb+PPaFbADnjQGBFwGqF9W96wNImSg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(36840700001)(40470700004)(46966006)(2616005)(82740400003)(40460700003)(186003)(6636002)(1076003)(36756003)(7416002)(316002)(16526019)(26005)(356005)(40480700001)(81166007)(44832011)(7696005)(6666004)(2906002)(86362001)(478600001)(110136005)(82310400005)(54906003)(5660300002)(8936002)(8676002)(36860700001)(41300700001)(47076005)(70586007)(4326008)(70206006)(336012)(426003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 07:01:06.6885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d7ea46-90bf-4ed4-ce74-08db0422173e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7432
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move amd_pstate command line param description to correct alphabetical
order.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0d8486325c9a..5f6a3a34251e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -339,6 +339,29 @@
 			             This mode requires kvm-amd.avic=1.
 			             (Default when IOMMU HW support is present.)
 
+	amd_pstate=	[X86]
+			disable
+			  Do not enable amd_pstate as the default
+			  scaling driver for the supported processors
+			passive
+			  Use amd_pstate with passive mode as a scaling driver.
+			  In this mode autonomous selection is disabled.
+			  Driver requests a desired performance level and platform
+			  tries to match the same performance level if it is
+			  satisfied by guaranteed performance level.
+			active
+			  Use amd_pstate_epp driver instance as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
+			guided
+			  Activate guided autonomous mode. Driver requests minimum and
+			  maximum performance level and the platform autonomously
+			  selects a performance level in this range and appropriate
+			  to the current workload.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
@@ -7009,26 +7032,3 @@
 				memory, and other data can't be written using
 				xmon commands.
 			off	xmon is disabled.
-
-	amd_pstate=	[X86]
-			disable
-			  Do not enable amd_pstate as the default
-			  scaling driver for the supported processors
-			passive
-			  Use amd_pstate with passive mode as a scaling driver.
-			  In this mode autonomous selection is disabled.
-			  Driver requests a desired performance level and platform
-			  tries to match the same performance level if it is
-			  satisfied by guaranteed performance level.
-			active
-			  Use amd_pstate_epp driver instance as the scaling driver,
-			  driver provides a hint to the hardware if software wants
-			  to bias toward performance (0x0) or energy efficiency (0xff)
-			  to the CPPC firmware. then CPPC power algorithm will
-			  calculate the runtime workload and adjust the realtime cores
-			  frequency.
-			guided
-			  Activate guided autonomous mode. Driver requests minimum and
-			  maximum performance level and the platform autonomously
-			  selects a performance level in this range and appropriate
-			  to the current workload.
-- 
2.34.1

