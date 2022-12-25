Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29B0655DAF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiLYQfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiLYQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:35:32 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C96268;
        Sun, 25 Dec 2022 08:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx8fNhkU9DBi38uoDDTOzUSdspaivgOZlnUhCObYTRvwduPtfS2xikVWPrsoafxvt7AFHiKjCcadrsMhMWHpDyWHXicd5St6xaptGKSH2f0+t270rjcJPGQIvS/xjI6rdeLG6ApALPC+rH8baXKpyfLozz/oFzJ5HzXM0zbDoYMMvtq8kXbhxR2G06tT6mRgpo8L8irmAzd95fKNr7owXboy44mZf1+5Qm4jCzGovW5hjYRRknXrY9t5o6GW/9QvgujRPbQG6wrwGQbQut7Py6t9H2TUGWTIOrdGeUEtoPeJKTpcjRgy0l6Nfq3yE7Rz4pFHRfl4nNM39/lJ6LCSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyaNrW7/x7nEksv3aGo7IuUXThPw1VBfticrfUewgpE=;
 b=fe3yyc3l7ljp4EoWUcM8G8YInoRwN+0FKJPctHch6g6kPnhpj68JiYqjcnFxCKx33R/Ku8cZIPty+ShV2d/oU5E7PmVEblAYf5asfnbHPgg1hlau2Pi8l6wSVIB1ni5rdCVf4qLvFiSslUQcROCh76UzxI3qQ8l3CylqtQLP1PgSKcEX0EwSLOBuZ43iKHcBeUTrhhUY1yyrJa66roaG0FWpscNNi2/HLMU8t0Mx+FEdefTaXw+aUhHkb6CYv4zMy19JWL/UyYkvP+Dyj70EOj4VRvtc3OSO33OuoKUIk/P322HuPPxZXWlY/OpLxM1rt4sWsKU1YCAC2CdFmeN9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyaNrW7/x7nEksv3aGo7IuUXThPw1VBfticrfUewgpE=;
 b=hmOFjnm0fLx6TlwruZb4S88hF5RS0GRv+5W2KlBbqnP4QkfEZ2/A8STi5FIR4zJZbyfS+hx6XClNRpW0sSOJQuLnuOrVEXydicWzFsDqiLn80b1PP43pzKj1qha+jPl1bpeX6Abys2F4PKWk/xGi8NEck9e+5pqZaWRA2dUCZJY=
Received: from MW4PR03CA0255.namprd03.prod.outlook.com (2603:10b6:303:b4::20)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Sun, 25 Dec
 2022 16:35:18 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::1d) by MW4PR03CA0255.outlook.office365.com
 (2603:10b6:303:b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.16 via Frontend Transport; Sun, 25 Dec 2022 16:35:18 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:13 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 05/13] cpufreq: amd-pstate: optimize driver working mode selection in amd_pstate_param()
Date:   Mon, 26 Dec 2022 00:34:34 +0800
Message-ID: <20221225163442.2205660-6-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225163442.2205660-1-perry.yuan@amd.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|DM4PR12MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a432a3f-0251-4447-7e33-08dae6960239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KxXDzerO97oVEZ7TR0WNB/JhyOlVqwio4YJVQMruB79SbUdfuyBlgpq/E32idLZlBZBbLXQzedpj/H3MBcEG9GyN2jmbH2b1sei+eLhmyaMsBAo9+bTS8RnZD98iML1pXEwKpZA0gxK77c5F99QEQmRvqAcLA8qDpVL9naOX8fZ8polWAsNcJ1HcZxossLdU1PwpxF8/kNSuez0nv6+RhIA04rtWGZf8XmQSB0w7HdsNYfPPQNBYLBLUiIm0w99WYZti8PsxjC35ZTpaEXASJSQ6tjm9HHRHioWjcfXC6ar2vFlobiI3XfF6m1d8RybEOBuZYwsIbX3RcJzlRKqVvTdj9ODOf6RqfrdqqxFTZS5YBMfFJRtgJMYEkSAWP+6OSNixJ+17GreVtaRueLw3vgGe6ot7LMaHEL3nz9ugXm7SNJ6d5TqBwBTHYODFnwMPW5YeuVfFRrB60CHjf6ARcjkrU45OM5UkX87M2rmxGebnMCfm5h53pi5sanqZa1xli0kLIvw6UZeUpdm6uyYo5eCB6UT657Bx4e9b5JDdo9rEFdlT1H5Ic9Wl82PI7QoVGerVWuUxIDnsSAxJvuIE+Dsb/e9YtGtKMuTQLtJywQo0pNL/lWQOsIsluNqlyEW2j8rhpuD7mXy2yI6panvd01bMjwJNsPGb97kN7qzVimnCKv/qUhgO1dwcP7W1Ukck9i9T9wlKFzC/YQXioqZgwXq3OQ3uroHzfHIKdXay8Pg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(8936002)(426003)(47076005)(86362001)(6666004)(41300700001)(336012)(1076003)(83380400001)(4326008)(8676002)(5660300002)(82310400005)(70206006)(70586007)(36860700001)(2616005)(44832011)(7696005)(356005)(110136005)(82740400003)(81166007)(36756003)(478600001)(40480700001)(40460700003)(16526019)(186003)(26005)(2906002)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:18.1589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a432a3f-0251-4447-7e33-08dae6960239
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

