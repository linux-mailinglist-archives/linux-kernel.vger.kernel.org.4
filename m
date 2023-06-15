Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FA9730F69
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbjFOGd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243766AbjFOGdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:33:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5BB294C;
        Wed, 14 Jun 2023 23:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz6pe1SliAlfop+z1SR/nB9wSgkCDUTCgwgCCASwjbGUZrD0hZC0Urth5M3ItGMnnWi9USW/05WTwaEVqf1DOednw4dHF+hjaldvgb6UyIfvl8UQNWnBf+JSKedipzoxE6wNLyvYRZae0AKnfF54PhHQAjrYuOYFokGRLOjpn8H2WhbgwnpDqfYptJ3nGQR3jtpYlmai0PkpNlqf5xAGDt8FQtc8uJXHSwfPY6wLUpegsuWC7t+6Jc25jMP6vh1bNJYxwNe+T7oavmVYYjWpb8A2F/tFievkswQfWfnkYvTmCsV1rQFWFpwgtRTVDiSdZo/K+wtuB1AOf8wGVl+6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW1bSWTGoUgntQr5O9COM2ThJGcz34Jg0k6jKp5RHRQ=;
 b=oWwr1mKiMQDBnUPFCRCYJAyIFH/BPpSoUC2PAWerrlLLE7mtxJPhqsHJcK1PWkskVcp69YvjCNtfcfsPCX4qV4PaFbccqmS4+a6hef6WPEZWmOA+bIyi5OZrZOx8yJQ799Px4HYjkU8nJ89LSKz+8Lx1sK1kj/bzI1Tcr2iI+YM5dFGpSvdE8+jwTgU11FNi1A5Pmxz8L58zwGK0d4m6grGa99zdNOvd+047o5ADTkN9dmKNJ0XV+EoTkPSCsOpBhEx8jQjiIU1XcG0/37bg55N+q/GO0QNm1D7PwSJSB2gR6aTmNPzJslaM800Dujr37DX4LC/yRFDDb6dogUrnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW1bSWTGoUgntQr5O9COM2ThJGcz34Jg0k6jKp5RHRQ=;
 b=RZMyGABjqZBu0YnoZcDdPnaUBmS9NH61pqFY3ONUNLmLuNpufUr/DJS+8A6r/Kh0pDVFXKQ6F4Ki6x9jtWQmVE8upka+LDrMHlNhWR76uApl0E6lFk5LRYFGvrO/yXFy+W2UiQ6B0ALKs9iS8jPgSefnw9bJUKlfJwYf1WbNlkM=
Received: from MW4PR04CA0323.namprd04.prod.outlook.com (2603:10b6:303:82::28)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Thu, 15 Jun
 2023 06:33:12 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::1b) by MW4PR04CA0323.outlook.office365.com
 (2603:10b6:303:82::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 06:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Thu, 15 Jun 2023 06:33:12 +0000
Received: from pyuan-Splinter.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 01:33:08 -0500
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, <Mario.Limonciello@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Wyes.Karny@amd.com>,
        <gautham.shenoy@amd.com>, <Sunpeng.Li@amd.com>,
        <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] cpufreq: amd-pstate: Add a kernel config option to set default mode
Date:   Thu, 15 Jun 2023 02:33:00 -0400
Message-ID: <20230615063300.4030172-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea07d0f-def1-401a-8f82-08db6d6a64c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glvBCcbG0TeH3dl5TMTFWEJT+sWabk4/vTlrIY9GU5zIOuignF8aSCfwuMQcLPsOdjfcNyXq39oUN5drZ4xJhKw+2fnzyUDTj3I64dur/b+U8NOPjWo3ETTC3TE//6UPRFZaXWMnUI6Il5t9tsyuysHzORQib9rwabAIkrDcrzrBM9Ken25VmpInUC/oKMd63xAnH0M6nwuIZ7NsDDwrbIqEKZls5ESqGzoVW3y6CXPztmnehkEiCmWuyTcutxxytFqS6fyDqOOUIES4g5JT14gEveXmEyNB9cnOPdF/KghkAP2Ik3RWiL77ImuGBWe5OnJU7lawgTDftlxn6zzKi6EqwTEGUhhx8CwH6CTcuZ1hWeA548fTPyLauvPuav+WipizhJ5E2Wyr5Olgg7VaIFqeG00hTr+oJ0zYZwVscbtAQqIwTcwKLOkOKS93qrGGXfWLmUs8ViwwT5Il3pt1+UIaaj6NXyW7pbUk7nHzmBtCFCQJR0XV+8blGKRXTysM8MaAT+3lHAEu0zHYhkn1Y0JyozM3IA48WX1xu8AkqCM/o66AuMpLz/EwZxYiIHV8qs0msDRqDALz+aEcJBXBiHHmPzwp7e2gsf4t5EGfeHP1zqu9/7BDb1YOYDws0Qs602imTBsOAojnLo+tUpiFDE/2/7fT1jy0/v6OjlOWWHeB3O58r/Y4/qf+ZHwwuYss/0X6G6IbjmRNU7wOm8HOq9WS0wqJ8zhKnLPQr9+qbvA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(36756003)(86362001)(54906003)(70586007)(110136005)(6636002)(4326008)(966005)(70206006)(478600001)(6666004)(316002)(40480700001)(8676002)(8936002)(5660300002)(41300700001)(7696005)(2906002)(82310400005)(44832011)(2616005)(356005)(82740400003)(81166007)(336012)(426003)(26005)(186003)(83380400001)(16526019)(36860700001)(1076003)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 06:33:12.5953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea07d0f-def1-401a-8f82-08db6d6a64c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
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
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Co-developed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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
index c9d296ebf81e..b400d1ee8e64 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -62,7 +62,7 @@
 static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
-static int cppc_state = AMD_PSTATE_DISABLE;
+static int cppc_state = AMD_PSTATE_UNDEFINED;
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -1363,6 +1363,25 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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
@@ -1370,15 +1389,6 @@ static int __init amd_pstate_init(void)
 
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
@@ -1389,6 +1399,33 @@ static int __init amd_pstate_init(void)
 	if (cpufreq_get_current_driver())
 		return -EEXIST;
 
+	switch (cppc_state) {
+	case AMD_PSTATE_UNDEFINED:
+		/* Disable on the following configs by default:
+		 * 1. Undefined platforms
+		 * 2. Server platforms
+		 * 3. Shared memory designs
+		 */
+		if (acpi_pm_profile_undefined() ||
+		    acpi_pm_profile_server() ||
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
@@ -1441,21 +1478,7 @@ static int __init amd_pstate_param(char *str)
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

