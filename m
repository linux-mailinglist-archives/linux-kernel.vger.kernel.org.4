Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B5872C5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbjFLN1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbjFLN1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:27:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C523DB;
        Mon, 12 Jun 2023 06:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBFy2+AyP8JH83bfkjP8XORxuwwshwyo1VxB2TuVxeEzMvZsIb8JcwZKBsUvU24YCmEb4cX7w9ihILV6fdI//4p94wt4WlKaYNplP7oDZFuQV4cwWN1QetnDgHMxjfOFqAnfZwIq6/ARU7M4N2xs4WAZe+33P22IUSDKWIOXSCl3BUz182Sn3XDf9EbhnWPgjg+jcGlO5zINwFBvZqKCv+YX44MkRFY7TmXGP06pJlaHKUqTZu95wXtzs9gdFMqOPc+Gc8j3PyPvj99eEs8sHNfOsBlrRhOxEm79ZpuWPRlwJRJNNh9MiGHSS1t2WIfrEzDITAw1DsQwkWPP0AQA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKaGjzIg0X7wyKURCPGlcqPphHpdDF1+5arVR4u+two=;
 b=k2MD/FAg6JBE91sDWxJBrXm6M5mVS8WCrRH2LqhXwOycAPAS3pbm/b9IHixipj/bhM+bHKBlc+A9WIUxjmWSiDkO3nm0kBvvJT0Cm5Zj5ct40iXeSExUFOCxTAvLz2P17Ahxw540oqvEQNeiIeoE9qyz3/DqDRCPi8HvP//K2U7YyKhzQsFmVMMchVYvaD8ZyJziDusf0+PilZHKljXR2jQdtgW9nJW7qHMIQBeM7QR77+D80GvvvXimLM0N+eC4lM3uB0Jvs8BfzHl54CwUFu7fNzNAVV3Ch/61KX0/jOBULHuhY1xEMecX6ClHSb1vlujF8APgJ+/MDELGHo5uxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKaGjzIg0X7wyKURCPGlcqPphHpdDF1+5arVR4u+two=;
 b=C7gRPCjX8+/ZfbFOVtUet85s+PKdidKqFGVNrEubfzzojKu8m07nhgmrQjI+P5RV2G/cZ965d+ozBILd+uXb5sH+FZR1igYKPhIaGBcY0TjIDcDjIl3mPsA8NVmyGcRiMW6/LEOsdsi+ZUeyx1Cd5X+ol+2gaC2wyVJ+uU+nLFg=
Received: from DM6PR04CA0004.namprd04.prod.outlook.com (2603:10b6:5:334::9) by
 IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 13:27:01 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::c1) by DM6PR04CA0004.outlook.office365.com
 (2603:10b6:5:334::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 13:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 13:27:00 +0000
Received: from pyuan-Splinter.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 08:26:56 -0500
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, <Mario.Limonciello@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Wyes.Karny@amd.com>,
        <gautham.shenoy@amd.com>, <Sunpeng.Li@amd.com>,
        <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] cpufreq: amd-pstate: Set default governor to schedutil
Date:   Mon, 12 Jun 2023 09:26:48 -0400
Message-ID: <20230612132648.3181772-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA1PR12MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f11161-46e4-47a8-e109-08db6b48b409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Y03a7q/XLDRQQxoM58jW15s9vAtS2Y8nxti8aIkhqaZPQvcM8NYubvM9uZqzNhKTAxae8E9v2cJqggwAfXVb0AFgKYMlV+f5Uk0oJ6HaaVOGMT7kipBxMJZnkLhrExllUN2KnPgpHNP2gwFpJjc7O8+V0y0pg1ZpDiFPFMiZ5a89GF+Y2Hzhir11eJlCC3Wbnlw3VEPzoN+PuVBfVdMbdCQR9sw4yJte9cE9o2Q3uL9K30j20JuJsxpSUvwiewy2Bz0O0EZUZWgQNLhRkSXwW321PLeraqai7W4+tt7YC+2K/Zwe9Mfvg2qmZTi/FOJ3FeHMVKSDGo+yjNZrI7zR7DbI6mOIgL9rTvkERbfKogVKDdvPiUTXYEN9nwZrYl4o2OEJORMEzrA0H+QFB219hvBdwMCNEX96p8HRHqvkR4JOXs0R6aP4ImAcuGYQBY/vVV5SD22ZMiWWtAYHjYe4b0T+5dx5D+B4Ve/P7EPeMAkF9xekb09pjYNdWnQx1UhjeRDIA0W+6+I0ojZHhGHRsFufxx2W0S/FeT68cqXLSu8iOYvEsHTvTmym8+3ssyxlggEApt7oZZBBdhbUofND3shcmxIe4kqdRL7xZYyamFiVFZcZFMDW4l0W+cnXt6IQEJUn08znp5m+dum9miKmGZqk/DBUa5DGZ+6OJCEMqoO9YQIK9TwuTrallcbmJOZAs6VVlZce1/X1icSdFN8RAJ3FfywEyC2c02xo39gOP65c4Wlbil7yYvXTTViXxvJhQktgZsU/EGWFDXes84xpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(36756003)(6636002)(110136005)(54906003)(478600001)(4326008)(316002)(6666004)(70206006)(70586007)(7696005)(40480700001)(8936002)(8676002)(41300700001)(5660300002)(2906002)(44832011)(82310400005)(356005)(81166007)(82740400003)(2616005)(426003)(336012)(1076003)(26005)(16526019)(186003)(83380400001)(47076005)(36860700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:27:00.4327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f11161-46e4-47a8-e109-08db6b48b409
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

The Kconfig currently defaults the governor to schedutil on x86_64
only when intel-pstate and SMP have been selected.

If the kernel is built only with amd-pstate, the default governor
should also be schedutil.

Cc: Sun Peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Tested-by: Perry Yuan <Perry.Yuan@amd.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2c839bd2b051..a1c51abddbc5 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -38,7 +38,7 @@ choice
 	prompt "Default CPUFreq governor"
 	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1110_CPUFREQ
 	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
-	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
+	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if (X86_INTEL_PSTATE || X86_AMD_PSTATE) && SMP
 	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 	help
 	  This option sets which CPUFreq governor shall be loaded at
-- 
2.34.1

