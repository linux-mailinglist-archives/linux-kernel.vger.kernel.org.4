Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6886B62D143
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiKQCwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiKQCwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:52:06 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9289145A12;
        Wed, 16 Nov 2022 18:52:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grNl3Y0PVtpLBc8fDfnHl03kBZwQRZzVs+TPK8mXk8fl0Id/1MtwYp+rAdHpXB81n5tC97j1CFBXZD1zUFQOf3u5xkMIKTeuD1GCsAPWpIJhM/8zbluRQDMfw61xu0Yvgd1IcCe9w8D+82oT2pGlPrTbW8b7IkCpH2jvaMShB+ztwFzw5GmmFLbX2cS6uLTaC1/pubZkUoLLjtumIzem3g4XwnDU8NQQM3E6EpeykmM2DVkfpbYh5asKvhMq8vzSWBkg+y2oAwBYeddYoBwsUSMxOgmgQjk7uTICEt5vWcTko0M2zB48t8LjNk7twn9ZR2z5ZWcvNVKh0yvIP+QhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcSIU8qAOy6ZsOorOZuWzhi2F18NrsiwjaSJz4IC7pg=;
 b=YneWIH9j5CzEBgLvXMboWaY2pg70baykOsy12b3AyJiRBucnssegoWfpk5I/xDho5kIOcrLUyp88ls+84dLZQ/nwuAgdjqoI6FzUI9YdpPKHyG6Fh6nTZZgnp8M1NUWE9wNLJOuMrWY6iO9TfDLCmNOnsSWq4Qt5CQhz7XIuHdel3povrNy3F35RhMT7u6TjYbVEP1aO1S2s1qhQPm2DbYn7iQujHNdxlw1+dvlHNtKnqEWBqP0RaKKARN4CxKQuntb6lUQS+4dZWHYg9a5I98KZ9xxPN6y2DI4J2YFGAukSK+X/O2ia6VypXAbHcSj73QdX7hrNmfN5/W37xkidyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcSIU8qAOy6ZsOorOZuWzhi2F18NrsiwjaSJz4IC7pg=;
 b=H7Bzq28b9WSHgqTI6grLBfngb3Q58oUX+hU43/GQFzWyQIDAlNo5KcWsTpzcOXK8MSfwgby1uDn4gLSPzI7QoQcUMM3OQRQ0M/s9g1Z07GMw0ipBtg65uAUmRZGMoYpzyJdxVv3EzUjexiHx/+Xdy1CoJPuJr3/wjexOImzqdpE=
Received: from BN0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:408:e5::13)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 02:52:01 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::ea) by BN0PR02CA0038.outlook.office365.com
 (2603:10b6:408:e5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 02:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Thu, 17 Nov 2022 02:52:01 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 16 Nov 2022 20:51:57 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 3/5] cpufreq: amd-pstate: add amd-pstate driver parameter for mode selection
Date:   Thu, 17 Nov 2022 10:49:53 +0800
Message-ID: <20221117024955.3319484-4-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117024955.3319484-1-Perry.Yuan@amd.com>
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 85574f31-c7de-45b9-9f74-08dac846b39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ofc8iJzpBmfj8cUH0s4EL8am6xeCFtE0wisvko3U3aat+2jezlHXh06CCpsO0NQNHio/vX+15JP5xrbVmO3oCI1FqF3itfLz0VZr6/zq1XZl/AYb8HujHZIx6yM5W/gcQlaoICqBU0h1WCzCjdBL4fyafOU/0r5g5yUKsC6cgWw4/ToSe1xITnwgZFpntW95lFRomZMfXe9B0Wb1PQNDGJEmX+lgci+R/T+DVoWqJFJWC1KtlGXc8FoDQNarI2RXhM/uStc1GpelgLLjqD6pydsOYXJQHiJhuVUbBTG4WZ6eWf+PPyDB163bRf02nJ3ZqkBWceOBus0qFHqOQcqEqSH4MHTcl1bMSukxfcznXqM6elhvrCxK8eXUTeAnwypxjCOMex1fSa8XWtGzZjq3YnJzAEFqQeof78ZgTbmwniLfflM0z3ikyFwfJDgeH5bvE6kdlF7YAdNGhwNy30ztGIu2DwT7UbTJee0fzNbN0epAsvmPtRLL8FpC9e6qOxLsQtbj8qfOwxsPNy2tCLuO0Y0+KQb4fGW60NRddfhGPW9nspmNtl1wmVXebKW0sf54hzoKO64otdQApFZLrCFTbwEI9ty8B2CXoHTIqPZFZNofl5pKZpks8k689sLi/502KhRnsGhZODO0r65Y4fwyYsrj+Bdodh+d5sP2oRpROOzdZhzmkVm8NjcpGC4+W2CaqeH+tW+l2TbRN7c3RaS2E8buNi4GkPM1njNTZYcc5cDSO21Ipm8nKfoYoyRczviegKxqqDlrTvzij3oOOX2FcuMAYxtFqg5RZGGRP0f5JuA+JQf3wzb8nTo/fKGIG4rOoQgJhlQnokUgfOWb02TmqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(82740400003)(2906002)(4326008)(81166007)(356005)(8936002)(36860700001)(83380400001)(86362001)(6636002)(8676002)(316002)(2616005)(186003)(336012)(1076003)(426003)(110136005)(16526019)(478600001)(26005)(47076005)(40480700001)(5660300002)(54906003)(40460700003)(41300700001)(82310400005)(70586007)(7696005)(6666004)(70206006)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 02:52:01.2595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85574f31-c7de-45b9-9f74-08dac846b39d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the amd_pstate driver is built-in users still need a method to be
able enable or disable it depending upon their circumstance.
Add support for an early parameter to do this.

There is some performance degradation on a number of ASICs in the
passive mode. This performance issue was originally discovered in
shared memory systems but it has been proven that certain workloads
on MSR systems also suffer performance issues.
Set the amd-pstate driver as disabled by default to temporarily
mitigate the performance problem.

1) with `amd_pstate=disable`, pstate driver will be disabled to load at
kernel booting.

2) with `amd_pstate=passive`, pstate driver will be enabled and loaded as
non-autonomous working mode supported in the low-level power management
firmware.

3) If neither parameter is specified, the driver will be disabled by
default to avoid triggering performance regressions in certain ASICs

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 701f49d6d240..204e39006dda 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -59,12 +59,8 @@
  * we disable it by default to go acpi-cpufreq on these processors and add a
  * module parameter to be able to enable it manually for debugging.
  */
-static bool shared_mem = false;
-module_param(shared_mem, bool, 0444);
-MODULE_PARM_DESC(shared_mem,
-		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
-
 static struct cpufreq_driver amd_pstate_driver;
+static int cppc_load __initdata;
 
 static inline int pstate_enable(bool enable)
 {
@@ -626,6 +622,15 @@ static int __init amd_pstate_init(void)
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
+	/*
+	 * by default the pstate driver is disabled to load
+	 * enable the amd_pstate passive mode driver explicitly
+	 * with amd_pstate=passive in kernel command line
+	 */
+	if (!cppc_load) {
+		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
+		return -ENODEV;
+	}
 
 	if (!acpi_cpc_valid()) {
 		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
@@ -640,13 +645,11 @@ static int __init amd_pstate_init(void)
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
 		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
-	} else if (shared_mem) {
+	} else {
+		pr_debug("AMD CPPC shared memory based functionality is supported\n");
 		static_call_update(amd_pstate_enable, cppc_enable);
 		static_call_update(amd_pstate_init_perf, cppc_init_perf);
 		static_call_update(amd_pstate_update_perf, cppc_update_perf);
-	} else {
-		pr_info("This processor supports shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
-		return -ENODEV;
 	}
 
 	/* enable amd pstate feature */
@@ -665,6 +668,21 @@ static int __init amd_pstate_init(void)
 }
 device_initcall(amd_pstate_init);
 
+static int __init amd_pstate_param(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "disable")) {
+		cppc_load = 0;
+		pr_info("driver is explicitly disabled\n");
+	} else if (!strcmp(str, "passive"))
+		cppc_load = 1;
+
+	return 0;
+}
+early_param("amd_pstate", amd_pstate_param);
+
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

