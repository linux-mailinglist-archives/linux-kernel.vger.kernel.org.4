Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F09730F76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244017AbjFOGff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243894AbjFOGen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:34:43 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB6F2D63;
        Wed, 14 Jun 2023 23:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLDs5cgiCu0+YDFV/rU3TyW22IgDKaGo6JIIfh4nBsmM43iQje3yRtK3YCAFjrSZ3EEO7W2RADb4wWe0yaUwOlymqWHXWhUR3elr8aFfihOEDRBsd8qR6pgOFBs/uSPOkwLTIilZcg/8/3HGlzVHbxMWY36QYnanUwMOWrYRmkva4oH/0tyfbS0TA11O9w87DDt5AcQuGbFF//aLdYt4n2hI9ijuY/GMlAQLqAyO/FwSPSgsdvjAbHcs1o/DGlv2OexU/IKKXVGAJUjWWUVypOnDcFUoxkFaJeskrZ6Ae/Xeu5taVkLYLSDpu6R44Hw00Nejm+WfP0SjrrluYetNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asPO4U1cn0BlsKDnnobM5/Nm/8F1ZclL6fSxDjSGzz8=;
 b=CdupYzErsh0EMZFjTIsarEB3pgrEiadOTvcoVmvzwSvprahRYRkP2dhWBqWREoUxuiQRf0/tU5FIUijrFrcd34RKa41S4sFjV1ghgcRCS1wRKCzcq9I4Afk10FCr0Bcj8c9ulxvYQ7PIQmADT0knIWyjKagRI7PkpFkR6iWtgSeNXArYgC/ktnwLut04bs1G86+p7ySemeuTEQdjtNCTIaV/GyuGtEZmjiK2jTlh7MwgC0ntZG1eRz9h0a8agUtPKPdYmdUxQktXF/SLROldZZ5XJKXpC5QtaueY/KT7tZd0NnTmG3sqzxC1aCvFSUxIXD9VN/517XbXgy4D5ldS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asPO4U1cn0BlsKDnnobM5/Nm/8F1ZclL6fSxDjSGzz8=;
 b=sXOIluV6TrxH2vw4GYKIVA95PAOIvb2W0QG/DZL2bc42HtJ0eOPtg/GLOcNaQugf0Q7CDFuyxPgFmlHDNyNe7ukboKZIZY/eJimjzAsX94UrWFs4/co7PQnORW1VZRghjfykHCLAaaRuAc20gdGerD0cg0AvMHxbYYjo+ft6/3c=
Received: from MW4PR04CA0354.namprd04.prod.outlook.com (2603:10b6:303:8a::29)
 by SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 06:33:45 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::27) by MW4PR04CA0354.outlook.office365.com
 (2603:10b6:303:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 06:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Thu, 15 Jun 2023 06:33:45 +0000
Received: from pyuan-Splinter.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 01:33:41 -0500
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, <Mario.Limonciello@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Wyes.Karny@amd.com>,
        <gautham.shenoy@amd.com>, <Sunpeng.Li@amd.com>,
        <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] cpufreq: intel_pstate: Use the acpi_pm_profile_server() symbol
Date:   Thu, 15 Jun 2023 02:33:33 -0400
Message-ID: <20230615063333.4030395-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a67034-e88b-46c9-371e-08db6d6a7853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtV0uz3l7+BiLiaGvYOM/VX9XJlDqtdDb61wPsH81ddJHyX5fgmaSMT8OZdf12VaNpH0cabjgSzUPu0DYzWHbRTjf1gjnQoz5cm5wg3KFfy9SX6eGlQPodyb0caFiLDhTHiyYloFLBRA8VOzIjwRbFTYbmZYKdbSdCTOAZMK6bZ2/BGCzJkU2R0FmZZwi36q3Km9Z27FW2d6+89f3qegnmOnIoSAW5OvV2pT7hdER0J0lXR6ZVwNTV9svuJqlt464n5z6Li6BP7SgCU1kAkk3kZrSGgMmjc5wpqrD5e5e92g5cELoltoaWAAkPIQcgDbUHTRT72Od5mbQ43avBYE9BRcf5RMbILqVtCiAA6z5xIetnQCngdIHzXR6keD/TdxHpmGrcMOJKdMmiZzWoMhfDHtS1LGi581CsSPvrlzb8m/nj+pmRS5ttWagftiUy8P+asE0sBwVGP4PznQ9j3OU+ga8fB5wyr1g3dBREGjWIsdyo8aPShmSMEjK2KUrL2vPkhI2y0AjvyO3j88Is1l6ECtttC3Afb8JRmyudrJbic51EJGLsnuTnBoQzOQNzhAinh30qGxiAas3n4cjVytmcMotv6SCMuZVBokPhbuyEEpLQiHlrcZvqkI1YCcC8l4WJA4Pq34++U5bqCT9rTjXjTQEm8n6RrmaWYPJEe5fKimdAS2wkTIhxfydyPtrrNb1u2Y1//7ccRz1GL/o5GFTnMH9fUDyNsJHCXO2XaFWbiGzBHoUoxo9T1Vkeat7rmaFH7fLQ0Erci/z6SnmFBSPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(44832011)(4326008)(6636002)(70586007)(70206006)(36756003)(316002)(40480700001)(5660300002)(2906002)(8676002)(8936002)(41300700001)(40460700003)(47076005)(7696005)(54906003)(110136005)(86362001)(82310400005)(478600001)(16526019)(26005)(6666004)(1076003)(186003)(356005)(82740400003)(426003)(336012)(83380400001)(81166007)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 06:33:45.4331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a67034-e88b-46c9-371e-08db6d6a7853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179
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

Avoid duplication of functionality by using the generic symbol.
This does have a functional change that intel-pstate will now
match "SOHO server" as well.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/intel_pstate.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2548ec92faa2..6401338971c7 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -313,18 +313,9 @@ static DEFINE_MUTEX(intel_pstate_limits_lock);
 
 #ifdef CONFIG_ACPI
 
-static bool intel_pstate_acpi_pm_profile_server(void)
-{
-	if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
-	    acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
-		return true;
-
-	return false;
-}
-
 static bool intel_pstate_get_ppc_enable_status(void)
 {
-	if (intel_pstate_acpi_pm_profile_server())
+	if (acpi_pm_profile_server())
 		return true;
 
 	return acpi_ppc;
@@ -481,10 +472,6 @@ static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 {
 }
 
-static inline bool intel_pstate_acpi_pm_profile_server(void)
-{
-	return false;
-}
 #endif /* CONFIG_ACPI */
 
 #ifndef CONFIG_ACPI_CPPC_LIB
@@ -2407,8 +2394,10 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 		if (hwp_active) {
 			intel_pstate_hwp_enable(cpu);
 
-			if (intel_pstate_acpi_pm_profile_server())
+#ifdef CONFIG_ACPI
+			if (acpi_pm_profile_server())
 				hwp_boost = true;
+#endif
 		}
 	} else if (hwp_active) {
 		/*
-- 
2.34.1

