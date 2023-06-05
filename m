Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C4722A9E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjFEPNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjFEPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:13:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE2E41;
        Mon,  5 Jun 2023 08:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hD+tbAv1vhnm2JVj5htWrwJG56T+qDfe77fDPK6wiPYAKTj1KgHBrZ2OAEX03Zt9GtAoGbSSp+Q3nCuoSoZ2apQWbPGV+jWsqMXrqURP70Dc7RP1BCOerFlIyTY8cfmrgycAYH5smcceMxGPJxAZz5gCpDzEZRxWaMOIjNKoWYbFVuIUWizCwimyPb28yja0N3rUIins15XldWT+DFYgnDLE8swr0qutv8srcoY8sejaAJJIq/0kfqlJ3VVY2EU+64lnkF0cV15VejiYkSR+AtCj6CSKVAsSSeLVFVpF2xYVVyq2fnZMHayAFmOEvAj6VaLDTMp/B9m7hg1Mn2HoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzQ2KWMXjRSVTAL+fx2erOuQCj62nylaK5GzwzkvDJY=;
 b=UCfTtImEwWVCX1pD2t84FZbL8CMrFDgc3zcx1wNAnWc0hrI8vuaNXQLIrrEwzwXadqkGR9ZjquKmJbnAMyltqdkXs5cZ7Y1Hi7Trgp3iADO8/5rqOblt9HwXI0jopyMAnFFETjV4JGSyYUZvzGSQiVZXsstW6T8AbwIKeF6waZzSAPQ+g8ahROKLPxxjQzOt9VQ7EU3IvJ0IVGVh4oU9N2KvpscgHeQ9q+4fLTVdqwB+QCMKB/H9rsXHUZOCs/ME+sc8P4LgsrgSYm2TCF3Md2rOfo4amYFMrVrfzmkFyz8F4nZ6BeuVTXC13g0br7x591BmtEebNqjGtn2pDsY5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzQ2KWMXjRSVTAL+fx2erOuQCj62nylaK5GzwzkvDJY=;
 b=bs30l8MGsPtHmMPd9UHeAnCyJB8clFaCY6BEQUW4vv60gC3DQC+pIcS4Y5tLBQGX2kFKpU+Wrbf6LWGdMrUcw0M+idMroQWIPD2hffEyn5X4rLzyMx5oq7VLwydM3usHLFLwhJd4b0XAUjOHUrZ1PBueIZVOBT56GCeP1FNn+us=
Received: from BN0PR10CA0024.namprd10.prod.outlook.com (2603:10b6:408:143::15)
 by DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 15:12:07 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::71) by BN0PR10CA0024.outlook.office365.com
 (2603:10b6:408:143::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 15:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 15:12:07 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 10:12:06 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devel@acpica.org>,
        Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
        "Wyes Karny" <Wyes.Karny@amd.com>, Perry Yuan <perry.yuan@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 3/4] cpufreq: amd-pstate: Add a kernel config option to set default mode
Date:   Mon, 5 Jun 2023 10:11:32 -0500
Message-ID: <20230605151133.2615-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605151133.2615-1-mario.limonciello@amd.com>
References: <20230605151133.2615-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|DM6PR12MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: b499e21b-5261-4aba-4869-08db65d73a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkH0RsyjfbUtACG70U6F/fw9qFT5fFXwn7SsHZXXnE/FtETiGCBJhZ1qj1w8Dg6r9u/cLJBIL5GmanFHzVJym/2xUTvkqyTfAdKzs0cOk0Yo7TAUCgngipB5EuxvlDEeQeTwsIf5Qi/+lPmZuZSyrpIS4driwBrWAMuy/iE1HHoZ7yXIaV85ruHL11gUSpQaQ3mK0gXSU68g0iKsaP4szA0X1RJDJginIoyAjM4PBeMXeFFQ6wnw1tYjbPzBgt4pVFPGtC/lHZx4/due34ImiwMj8lLpycsmniJglyk9Y/Zosc5VYVxZeWFu3t8LLdbSuGk8wZdCLGE4Fs8mSeYYl8AOvsv3nmny+QAXzZzlNdDjWijl2h0ysP3URvrn/zC/27yKAWGMq/0hKNi8d+6DxwQ2GjY/ktOoyu94AJyUx6NDRCdMHXRshfRLKZIoqbpWADNjSKeqGS1IPgkBQft0sA2cGlIEGJdXpYOmgyyNGo7W9l0jp14eyS4M/NU+wsoVAooKBPmZyGtHwa+WCEE2K2LqUPVLyJOx//uN9IO3NEVnSyCfgjrTa44yDAGd+EMFiZJgVznDoq05TZk/hGj7BnMnp0YUlszUEbI0k0pjZ/azhz9+FUriblmZUGZd6eqMV7SELwxpWoFJxbax4N+vVQ2CLCivJeamBIuOaymqTA+Cy/fn+nW0XeFABjVnzVbST/aS4nWLU0lZJd0PXe7Gw9ebzHtrYKeFFHUznRM3RWM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(1076003)(16526019)(186003)(26005)(2616005)(966005)(426003)(336012)(83380400001)(47076005)(36756003)(6666004)(36860700001)(82310400005)(7696005)(2906002)(40460700003)(8676002)(8936002)(40480700001)(82740400003)(44832011)(54906003)(110136005)(478600001)(5660300002)(86362001)(4326008)(316002)(41300700001)(356005)(81166007)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:12:07.2606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b499e21b-5261-4aba-4869-08db65d73a43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

