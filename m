Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D353D63AE91
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiK1RKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiK1RJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:09:17 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67565275F3;
        Mon, 28 Nov 2022 09:09:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ccyony7HM5Ah+LzyXX5y02bFdIOOwb7llw3VLMJ/iShX8wHXSBUUFsNJXParraYOGmqOlta6FBqmm9Oo2gnx/FTbjsZx0zFPKM7ilPnNWcwadhyvpopc4uO2rG1cuhK9bQOCXIiUe48X1m3qOF5BKR+/etEIw2j4syouHFte+MVWJfQebykYeRpLMle49WnSAv1PWpQGhLRU6uBUpL0r2qdu+giwzY6TMLMiCBx3MeONQxYeDzGEWscNyvCtrc/srtys5OPmObrv3F32R0vEZVOKRM7rxeNSOaCMe7lju4OxvLFW/H2v2+AtfCPDB48wydXezwyHiqUUW/I1OSheWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA3dFregtyaTgEB1efmTBrFcL17HMyrQI6vWmi+r8XE=;
 b=AplemRkX+obgptr6/AKgowNVlgOsXeAAE8esORWY7/CpzuWUUQ21ckMlhSgNaxPBvy7kGIKkz35KgIMrZdlkpA1uHokMCNxQ3Gn/7quDJnyDKQdqQf/8CgmgktZ17DFb87w0qetUMVKZI94vjfkXmkXCaOfK93uWAFLbSIyILL7MjvnqBMWI3m576a+CNlAaomgFR6PyJa/qC7LEU5wWnOf5na7Z4ojh0e0TnEyt0Mc7kiDy9lVQcOO9Fl/1VEwpiUuUnoJ7bzlAPnIQZz31QHrqpcxeY3PIugeHNZJEOwcspRa2/HtBhswndDCHt2ENZpduT1WuTKr/agC4hUszvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA3dFregtyaTgEB1efmTBrFcL17HMyrQI6vWmi+r8XE=;
 b=aVuer0nnmsRUdmSFBkfD8jqAhtWxEVQC5zDeO0uXRTsVb5pdiICciqQsThcUr/Z6E2kIwbHZDYfiBQblrb/gI99Us/JqINyxoM6Ij0u8YJ4hfTs1LoBSYOZVwm/xjAGcNUitBz3389YPlZ2WKMyrScELZAtfapSWP+kLgo5rXFE=
Received: from BN9PR03CA0071.namprd03.prod.outlook.com (2603:10b6:408:fc::16)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 17:09:01 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::1f) by BN9PR03CA0071.outlook.office365.com
 (2603:10b6:408:fc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Mon, 28 Nov 2022 17:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Mon, 28 Nov 2022 17:09:01 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 28 Nov 2022 11:08:57 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 9/9] Documentation: introduce amd pstate active mode kernel command line options
Date:   Tue, 29 Nov 2022 01:03:14 +0800
Message-ID: <20221128170314.2276636-10-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128170314.2276636-1-perry.yuan@amd.com>
References: <20221128170314.2276636-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f4e328-3a41-44ce-1f02-08dad1633ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dj6A1mE5qrekcsJimKIAPTdb9guvfi7KLfZ/QbaJgmOHHBwjQ484uaGD/x6IzFwYK/tdu0UvkiL1GyCZWznlI9LCKK0bTC3AkkHVMDada5IfdM1so384iFYqvkboFyoqhuCs0fK9nANWex90/e6nXi+6P7rnz5bZwTwB0YhZx35odW6IDhbyOKcr8xZHkTmdh0OigAYkeCCsyXZcXIMbpKPwVOwGYKOCqszS7GfL7iXeA38tVNuWJfHv55ZCuscfDYWRrycEaRUiNUVaf0Wm3+bMYObEvaNpMAd25TgDf21JzmMwy7QEWQNEPKixC40zjBvRd/tFManuQ5U1ZDzNOMxsJjdNeIJcv/SUOohsjdyAL5TAziXDfOBnH7iJ+u3NmgQuzUhKDbdgBLckEmKmw0uKtYfy6PRdZrThaaZwUTwDq6ZPYkH2ARK0yDTzrYoTbrdFx2TVA1DpKG1uEwKHyfbd2EoL+OB8cW56ss1mPSnAN7/2vujxXZ/jnRSt3YC7pS2dItP4wL3DJ27K0qLIYGrw0X35v/ol2tIU9pgEQULNf+zZ0UafgL6OrLsZjzkF2N+kk96ibrOagQl/6KtHDjVSqVVPRFaJ0QzVLHHi7Zuqh+aRmNjD+awl1RA5M20wBgzVKiRkfuq1zWG7YrjTXsYn1lSKxY6bOH+6pRgs+8I2CFCFrKXmu1gip0+gHW4xuA1OUkn4jKWl46gTLqerP68dVPh4drpU53VG70zIu84=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(8676002)(36756003)(40460700003)(4326008)(2906002)(5660300002)(86362001)(41300700001)(36860700001)(8936002)(44832011)(7696005)(47076005)(6666004)(83380400001)(16526019)(26005)(426003)(2616005)(186003)(1076003)(336012)(54906003)(81166007)(110136005)(356005)(316002)(82310400005)(70206006)(70586007)(82740400003)(40480700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 17:09:01.2130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f4e328-3a41-44ce-1f02-08dad1633ed7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pstate driver support another fimware based autonomous mode
with "amd_pstate=active" added to the kernel command line.
In autonomous mode SMU firmware decides frequencies at 1 ms timescale
based on workload utilization, usage in other IPs, infrastructure
limits such as power, thermals and so on.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42af9ca0127e..8fa0d45add03 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6970,3 +6970,10 @@
 			  management firmware translates the requests into actual
 			  hardware states (core frequency, data fabric and memory
 			  clocks etc.)
+			active
+			  Use amd_pstate_epp driver instace as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
-- 
2.34.1

