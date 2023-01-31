Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3A068280A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjAaJFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjAaJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:04:45 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E6A4F362;
        Tue, 31 Jan 2023 01:01:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRdC4uqKgvJSMPlijlphiqaTjxp1bySxShz5u/Rli0fSkMi3N/2II4Fx6KTdgPvEReu0bI8bPDzW1FDpC79Jxg4XTSZMkX5ULEu8JbkdPdDFNHHkx+25Du8+0ofJeEMkNuoD/z1gRAYyzDo+KAtEXfQXr/SISKT9cUadU6XoHshSq6D+Rg3mSBGTNRdt9MW1GF3wUB2vUHRro3imI4+uIEjvF2M6gcbs6dl+GKC4miXNrnE0rL32piikwZLV0moHVxMdHkba9zJy1hZ06wlZ7pSKsMcXjfCpxu+AyOu3GCzxSr6b+YegEnhNYOVW4rwKN8pCExNTNtW3Kym5A+Rp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+ysrOmzGDJAfktB02vo+He6ojsYnTwZFuFJekRyFqY=;
 b=dm0KpXt5aZ/nnbrOtevC1vphjGPkupCAdshmjADpKmfyXHgDs27h4NLb6UMnbjc1y+XzKnbYFHz55xcRZi+JI/qdfogXdxPRtN/yVi6o6nijR2N8UZVZ31WBb8EJKh91dR7o/Nt8GpphlYGGBkYACzORFp5WmBZTEwaRJGtUZ6KKFOWfRoyUDphkzZbHX0yidizL8rQup1+sSe/oBvokhVjcvbTD5IqgEvWvtkVpnkGEuD4dPE7fLW9QsEV9csUQgYkihlg366+6VwCK7uuuchT4maFlq+hCNcX+68dpe+Z09CJhYB6YYUl6pNT4GIgepGKlpyJe59DpXk9nWI+AsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+ysrOmzGDJAfktB02vo+He6ojsYnTwZFuFJekRyFqY=;
 b=G9mSMUDcNiHEGy+DhcXe/UhJV+cppSkrogGHDsiEP/uZOI51DRMZNRGjq/4+XO1bZJjnAmOuFFebexUOnIJPj+qrFHTV/hIpNDIwBblhNfFFzOuxwHyi3yqZ5Ad/r4CpcRrEAY0Nq1yeQP/KFv7KBt0l3MXTU8t6uxCRrlSnpyY=
Received: from MW4PR03CA0062.namprd03.prod.outlook.com (2603:10b6:303:b6::7)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 09:00:57 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::ce) by MW4PR03CA0062.outlook.office365.com
 (2603:10b6:303:b6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 09:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.33 via Frontend Transport; Tue, 31 Jan 2023 09:00:56 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 03:00:51 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 03/11] cpufreq: amd-pstate: optimize driver working mode selection in amd_pstate_param()
Date:   Tue, 31 Jan 2023 17:00:08 +0800
Message-ID: <20230131090016.3970625-4-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131090016.3970625-1-perry.yuan@amd.com>
References: <20230131090016.3970625-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 4219e735-0a5c-43ca-08f9-08db0369aa79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TssVVWRlYtmCEvtCZ1IG8aqrzsl9k08Gt7SsHEYndp01GHL+kascQnhuIaFn41cXC33vQ+xEDkzqpnvm2DF6sDFm8s0fTFbMjB2NFTp//lH7e10ti3N/aXpiYA7o70Z1XL6h7BDJVyR0niEJ7bqw0pbtKlER/XhF6afRu43gau3dXile9IHFlfF+0e1ffLvHkw/0WRvhhFml3VdQMvJ5Itxnth7HnsFbMjDW4x44H9bBcJZgwBecyjL8PihMB2BXUVASMDhtXsH3Yy/WoQkqnbCjLkkFprAhNwcor5JlMSK5/uX+nKIqZyggYZjZLxXCGBSmWwwS+atpMc52eRv679q6pBHNDsUQVLIBRAxh+otiyQwAJledO9XJecPterfTEsKu9HW4hdSr084QjQgpimmmGg1/1KSbhoA3DGE5NcfH/zsowfdUzXgTSQEDXT+hgyFsqOlFoB0yFN8xHVWseqGVG9RDN5y3qPn1MNTO5VRTtr3qdVlus45VzOjBzd5+UNENpCRqQ50ZgSmYD+JUWIBt9vHGXvXz8nXPnfwy5GRe9+W+Dw8efZKmEx6ZnOCPcrkjg0xFDwaqo9hSwRCpuYsYOh9n3YmuC9ZHMFWWSGLBACpUtVZdu2WZVQYV4bZiPUAu0tUL4mFzpYmjFcSe0TbT43SiANhUIEgXzBTSPPb0ZhZMBYOiDgRiX27Vji89FIzebYlbRASQPWf57Qi/p9/n0qSu2AHWFSgre6gBjA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(8936002)(2906002)(4326008)(8676002)(478600001)(44832011)(36756003)(40460700003)(26005)(5660300002)(6666004)(186003)(7696005)(16526019)(2616005)(86362001)(40480700001)(336012)(426003)(82310400005)(47076005)(41300700001)(356005)(83380400001)(1076003)(70206006)(70586007)(81166007)(316002)(36860700001)(110136005)(82740400003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:00:56.7690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4219e735-0a5c-43ca-08f9-08db0369aa79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wyes Karny <wyes.karny@amd.com>

The amd-pstate driver may support multiple working modes.
Introduce a variable to keep track of which mode is currently enabled.
Here we use cppc_state var to indicate which mode is enabled.
This change will help to simplify the the amd_pstate_param() to choose
which mode used for the following driver registration.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 39 +++++++++++++++++++++++++++---------
 include/linux/amd-pstate.h   | 17 ++++++++++++++++
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c17bd845f5fc..65c16edbbb20 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -60,7 +60,18 @@
  * module parameter to be able to enable it manually for debugging.
  */
 static struct cpufreq_driver amd_pstate_driver;
-static int cppc_load __initdata;
+static int cppc_state = AMD_PSTATE_DISABLE;
+
+static inline int get_mode_idx_from_str(const char *str, size_t size)
+{
+	int i;
+
+	for (i=0; i < AMD_PSTATE_MAX; i++) {
+		if (!strncmp(str, amd_pstate_mode_string[i], size))
+			return i;
+	}
+	return -EINVAL;
+}
 
 static inline int pstate_enable(bool enable)
 {
@@ -626,10 +637,10 @@ static int __init amd_pstate_init(void)
 	/*
 	 * by default the pstate driver is disabled to load
 	 * enable the amd_pstate passive mode driver explicitly
-	 * with amd_pstate=passive in kernel command line
+	 * with amd_pstate=passive or other modes in kernel command line
 	 */
-	if (!cppc_load) {
-		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
+	if (cppc_state == AMD_PSTATE_DISABLE) {
+		pr_debug("driver load is disabled, boot with specific mode to enable this\n");
 		return -ENODEV;
 	}
 
@@ -671,16 +682,24 @@ device_initcall(amd_pstate_init);
 
 static int __init amd_pstate_param(char *str)
 {
+	size_t size;
+	int mode_idx;
+
 	if (!str)
 		return -EINVAL;
 
-	if (!strcmp(str, "disable")) {
-		cppc_load = 0;
-		pr_info("driver is explicitly disabled\n");
-	} else if (!strcmp(str, "passive"))
-		cppc_load = 1;
+	size = strlen(str);
+	mode_idx = get_mode_idx_from_str(str, size);
 
-	return 0;
+	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
+		cppc_state = mode_idx;
+		if (cppc_state == AMD_PSTATE_DISABLE)
+			pr_info("driver is explicitly disabled\n");
+
+		return 0;
+	}
+
+	return -EINVAL;
 }
 early_param("amd_pstate", amd_pstate_param);
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 1c4b8659f171..dae2ce0f6735 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -74,4 +74,21 @@ struct amd_cpudata {
 	bool	boost_supported;
 };
 
+/*
+ * enum amd_pstate_mode - driver working mode of amd pstate
+ */
+enum amd_pstate_mode {
+	AMD_PSTATE_DISABLE = 0,
+	AMD_PSTATE_PASSIVE,
+	AMD_PSTATE_ACTIVE,
+	AMD_PSTATE_MAX,
+};
+
+static const char * const amd_pstate_mode_string[] = {
+	[AMD_PSTATE_DISABLE]     = "disable",
+	[AMD_PSTATE_PASSIVE]     = "passive",
+	[AMD_PSTATE_ACTIVE]      = "active",
+	NULL,
+};
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1

