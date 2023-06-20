Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801DC7372D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjFTR1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjFTR1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:27:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820C910F0;
        Tue, 20 Jun 2023 10:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNqNvpL1eeiPxs1+JHniarZjd/EhkUm8i5S/ywlL28fBzgLyhZWgk1QrlHbM92SKZnWC1jVym/VU3/yHLHDX97qfVkqpi1ZYrqfkFElMHfhDhQoVrk2CPjJT0R4rKd0CCdbj6HOayeZ3ElpQDmLDfE95zCTMeaUi/1wpFSUx+zAIY0VVVTJ0fblzVU1u3hwyX37hiMGcr8UcGfDLKrl5EucplhTsG7b5AagidjCH0DaMXucdP6L9Pq7ZJhNyMMgqL6j53jvybct+RAd36Ba+/p7CGgsLDpOQsJyLGlofvu0Fp/AncWv84I4eDhld++c+bckfEvJZgPhozMLWMgGD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta8+Ut5w1j2TSddf4pLUwOfdxFg1ueeTeDxzFvNnTBY=;
 b=A4qGwZbd6sNPgX167BCkFIdIVfRebzwuBunseiV/E6ATVqq4U3a0EB2WHdwmoA3lIxF/N4a+Sf+AnhS62z3E1j9XmOSGZ9t1n/t4F0qFLgthty1gCS9YAwJBBbIZO/qtB1CuyubmvzCtK7HXXIshFzFTujvNAc5JD/WxXuwKrmveLFIO4DhVyBc6ezgMmiYLK1Y1YOa2f73mPNUsx6fraWa5VL/BQY2datQI2r/r5wSpJYdQvLfx8WPjIoMOXtNIuWpGQ08nHLZbY0j5SoiKXVcca9gjaZa55QowrOof6/KotF7G/SIDB10UAjgbc2CHunM2dg6AyJHKwzQburxwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta8+Ut5w1j2TSddf4pLUwOfdxFg1ueeTeDxzFvNnTBY=;
 b=RjZ9FY+Fggm6nPk21i4SfwvqMwXYo+Ln9ZIaMP2IuZl5g/0fcm/+oQboutkSiHkeYiqUbURcE4b/xVJXUMQzbM4kGuEe3cp9YN0Pq5FAJaVtzIiJeI1YKYoUwgnYjCbmcJ+Wr3sLaOi017QjiG20ragiIXWD6IqxQqFxVH1I528=
Received: from PH8PR02CA0017.namprd02.prod.outlook.com (2603:10b6:510:2d0::20)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:27:37 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::b) by PH8PR02CA0017.outlook.office365.com
 (2603:10b6:510:2d0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 17:27:37 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:27:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
        Wyes Karny <Wyes.Karny@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 3/3] cpufreq: amd-pstate: Add a kernel config option to set default mode
Date:   Tue, 20 Jun 2023 12:24:33 -0500
Message-ID: <20230620172433.21325-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620172433.21325-1-mario.limonciello@amd.com>
References: <20230620172433.21325-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be68254-a608-406b-3877-08db71b3a468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcPQK1Rm00DI5SvSXAm5nAfk8XJIP3i41THa6sRF4m9f7MdZaRz+jDv6f6rP5XXVqWDC/EyLh9SLNOc9sEXG8kUuJMgr1Z3JcmWPI5iOQOCvd5bRBvZKiu9lEMervw6WHWaNZo+gsmbUN5Kd91mvsHXltdNcIW6EY631bKYZrPX87XhSQtblleEBRETSP9g/6HeGfzxjGSF9x+W2yb4VRzBnSw9FrRjXgYZ88ZA15U4mKq4fADMnEdSkJU9bJAI+4dbMQEtysBoF4m2YoE+aiaGAfLVHJ4EPI7pMm8FhYDUjoBMxbts8sYN3bsOK1d7AaLy+Ds7hNwuCsk2rBbzCyi8EuRksVOljuCG5jngTV7oZ0jN+zCMBu4b6K66cvzQEHew0r224Mdpi8k4Nl8C/il+TFhpQWkfqzuNfId31aTkMvlfIfrxRYQNF+VE3u/WwEZNeUY8LTg/17EafRiEdxJ9p3fnutljslr/yrP7eoO+xbY9gtYJC4Mo1H+3y+C2dDhuDt7Na1MjAaY6vRooRjiLnbNtdJIGS696G/D0MrWQPYk9DsxFEJkDlGiIjzAotUPn6a9l6v9WB/pg4uihGctudzGpLO0a/yRqzrxsjWS7wFNVE4W8Ava/4GnomA1wehoFyy2MOvmYZEsWtfYkSAQciUE1lbgtoXaunzM2qtwRO6rXT/2yo6vO6lCvNbZYFqCZpHO5Gqlnh8EbLFJdLz59wkK/6EycAUnYYeUDQ6+J0+sxf/FLvMPxhqU+35vW8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(4326008)(7696005)(478600001)(54906003)(1076003)(40460700003)(26005)(16526019)(186003)(40480700001)(966005)(36756003)(2906002)(41300700001)(8676002)(8936002)(70586007)(70206006)(6916009)(316002)(5660300002)(44832011)(82310400005)(86362001)(47076005)(83380400001)(426003)(336012)(81166007)(356005)(2616005)(36860700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:27:37.3810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be68254-a608-406b-3877-08db71b3a468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users are having more success with amd-pstate since the introduction
of EPP and Guided modes.  To expose the driver to more users by default
introduce a kernel configuration option for setting the default mode.

Users can use an integer to map out which default mode they want to use
in lieu of a kernel command line option.

This will default to EPP, but only if:
1) The CPU supports an MSR.
2) The system profile is identified
3) The system profile is identified as a non-server by the FADT.

Link: https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/121
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Co-developed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Use new symbol names from being folded into this patch
 * Add Ray's tag
---
 drivers/cpufreq/Kconfig.x86  | 17 +++++++++
 drivers/cpufreq/amd-pstate.c | 73 ++++++++++++++++++++++++------------
 include/linux/amd-pstate.h   |  4 +-
 3 files changed, 68 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 00476e94db90..438c9e75a04d 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -51,6 +51,23 @@ config X86_AMD_PSTATE
 
 	  If in doubt, say N.
 
+config X86_AMD_PSTATE_DEFAULT_MODE
+	int "AMD Processor P-State default mode"
+	depends on X86_AMD_PSTATE
+	default 3 if X86_AMD_PSTATE
+	range 1 4
+	help
+	  Select the default mode the amd-pstate driver will use on
+	  supported hardware.
+	  The value set has the following meanings:
+		1 -> Disabled
+		2 -> Passive
+		3 -> Active (EPP)
+		4 -> Guided
+
+	  For details, take a look at:
+	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
+
 config X86_AMD_PSTATE_UT
 	tristate "selftest for AMD Processor P-State driver"
 	depends on X86 && ACPI_PROCESSOR
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3546d7db614d..81fba0dcbee9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -62,7 +62,7 @@
 static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
-static int cppc_state = AMD_PSTATE_DISABLE;
+static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 
 /*
@@ -1410,6 +1410,25 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.attr		= amd_pstate_epp_attr,
 };
 
+static int __init amd_pstate_set_driver(int mode_idx)
+{
+	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
+		cppc_state = mode_idx;
+		if (cppc_state == AMD_PSTATE_DISABLE)
+			pr_info("driver is explicitly disabled\n");
+
+		if (cppc_state == AMD_PSTATE_ACTIVE)
+			current_pstate_driver = &amd_pstate_epp_driver;
+
+		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
+			current_pstate_driver = &amd_pstate_driver;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int __init amd_pstate_init(void)
 {
 	struct device *dev_root;
@@ -1417,15 +1436,6 @@ static int __init amd_pstate_init(void)
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
-	/*
-	 * by default the pstate driver is disabled to load
-	 * enable the amd_pstate passive mode driver explicitly
-	 * with amd_pstate=passive or other modes in kernel command line
-	 */
-	if (cppc_state == AMD_PSTATE_DISABLE) {
-		pr_info("driver load is disabled, boot with specific mode to enable this\n");
-		return -ENODEV;
-	}
 
 	if (!acpi_cpc_valid()) {
 		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
@@ -1436,6 +1446,33 @@ static int __init amd_pstate_init(void)
 	if (cpufreq_get_current_driver())
 		return -EEXIST;
 
+	switch (cppc_state) {
+	case AMD_PSTATE_UNDEFINED:
+		/* Disable on the following configs by default:
+		 * 1. Undefined platforms
+		 * 2. Server platforms
+		 * 3. Shared memory designs
+		 */
+		if (amd_pstate_acpi_pm_profile_undefined() ||
+		    amd_pstate_acpi_pm_profile_server() ||
+		    !boot_cpu_has(X86_FEATURE_CPPC)) {
+			pr_info("driver load is disabled, boot with specific mode to enable this\n");
+			return -ENODEV;
+		}
+		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
+		if (ret)
+			return ret;
+		break;
+	case AMD_PSTATE_DISABLE:
+		return -ENODEV;
+	case AMD_PSTATE_PASSIVE:
+	case AMD_PSTATE_ACTIVE:
+	case AMD_PSTATE_GUIDED:
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
@@ -1488,21 +1525,7 @@ static int __init amd_pstate_param(char *str)
 	size = strlen(str);
 	mode_idx = get_mode_idx_from_str(str, size);
 
-	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
-		cppc_state = mode_idx;
-		if (cppc_state == AMD_PSTATE_DISABLE)
-			pr_info("driver is explicitly disabled\n");
-
-		if (cppc_state == AMD_PSTATE_ACTIVE)
-			current_pstate_driver = &amd_pstate_epp_driver;
-
-		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
-			current_pstate_driver = &amd_pstate_driver;
-
-		return 0;
-	}
-
-	return -EINVAL;
+	return amd_pstate_set_driver(mode_idx);
 }
 early_param("amd_pstate", amd_pstate_param);
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index c10ebf8c42e6..446394f84606 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -94,7 +94,8 @@ struct amd_cpudata {
  * enum amd_pstate_mode - driver working mode of amd pstate
  */
 enum amd_pstate_mode {
-	AMD_PSTATE_DISABLE = 0,
+	AMD_PSTATE_UNDEFINED = 0,
+	AMD_PSTATE_DISABLE,
 	AMD_PSTATE_PASSIVE,
 	AMD_PSTATE_ACTIVE,
 	AMD_PSTATE_GUIDED,
@@ -102,6 +103,7 @@ enum amd_pstate_mode {
 };
 
 static const char * const amd_pstate_mode_string[] = {
+	[AMD_PSTATE_UNDEFINED]   = "undefined",
 	[AMD_PSTATE_DISABLE]     = "disable",
 	[AMD_PSTATE_PASSIVE]     = "passive",
 	[AMD_PSTATE_ACTIVE]      = "active",
-- 
2.34.1

