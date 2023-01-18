Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B2E671645
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjARI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjARI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:26:04 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42A35AB69;
        Tue, 17 Jan 2023 23:52:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQgZ9DL1vDdlrJVIWumjxwqajufWvMv8oAn4q/koUe7i8rNv5VqJnUjefHFSNhHyW6iofpgiyxO+npVlP4N8u2/IqpJ17MVrplfV5k63JUkdI0GB6d/IBuLTVAfKZOzVDJ4lPghMRhM+68P23Dl1kpFSzcgR4QrlYA9u5QpubBR3j2M8UIr83TRmM+g2XfkelizVdccdw3i653bXrGKO5VpOP6ZJuvH5KnYi0/CUlOuwQiMNSKxFvJKEoT+PQD07KGt8BmNoEuidmlBVf/9+bxZz3gv3pvciNlCw+orGBjUUmMEpVsoEV1xUl0oGfrK1Xz9gVT2cMkZqeOtKI4ncEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ScW1LtXgXIQDtt8ttZjbM43sDYvxe8vg4oSuwvrVqQ=;
 b=gzAsDWFOgCFFIubjTPO33YcNULqOqju1gCYOeI/4Iyayg98YjOk33kNFlC8SKJboJ6ZJ3pb2jgFJ683HUhscHJNK9K3QuDdnXHf2AswUppFF3C1IiCCTGlj2dNroD9lnOOV68RDlbdCL96nBgSgE+hSK8cM+jTg3bdwsq68rblEbHIRoXHemWM+X+OB2fM+5We9Qxhzwh6loVZJyWq5vFIJFR5ZtqMLsER7yIkuTDO3G868oJk+uf57AfGc9hCeOiTadFGJ6Vk6H7AYwYhPJVG+Zikvf6krZbGrxH+MC1mB+/5sdR8DotV9EqVl/T6o6lGiBv5pvFjQrEn/Zae7pNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ScW1LtXgXIQDtt8ttZjbM43sDYvxe8vg4oSuwvrVqQ=;
 b=K7A4bXYYy4yd8feV5rDi8qBYXR+cVYVicXwprKu/W89dwdmtdqYuQkED+khhLARiUM+3N4PfcqT4bstvMJX0JrtIoZTBEcQy2N+MN5xUZJ/JZGTS8maeki/CB80sBUeFbrOhfP74QVAnepQlBuoCiJCsw5HHg0SunEuhWge+VWE=
Received: from MW4PR03CA0221.namprd03.prod.outlook.com (2603:10b6:303:b9::16)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 07:52:57 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::b1) by MW4PR03CA0221.outlook.office365.com
 (2603:10b6:303:b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 07:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 07:52:56 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 01:52:52 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 03/11] cpufreq: amd-pstate: optimize driver working mode selection in amd_pstate_param()
Date:   Wed, 18 Jan 2023 15:52:02 +0800
Message-ID: <20230118075210.447418-4-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118075210.447418-1-perry.yuan@amd.com>
References: <20230118075210.447418-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 83af8b8f-aed3-4b1f-afab-08daf9290360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVxm22j04Y+5pUNhF7PTfNUsL/dSOMFP8foRVSTtTNdNMSkCn+xuEyNDnSjBuQ/liHkMmCsywi1fF0Wpvl5/krqn942NpG/yZ1I4TMwZjRwOnxHeoJipXxw5lK0VpxRDw6WnIVISUMzI/9V00pj9HPTXCPXZpx16n736gy0abcfenUL/rBiTEiM4zZ/vhSSen4wliek3cz+GRNQ7yRXqmDFkEz60pjUDdMO0HDDIZAoHrdu3DvlgmOC89HFfjhTr7kQMJUgFSrmPBYIdms95e+LJ0eDtUoF0POxpsfBjyb15IPF2reTm2qvdSevrO29lixyVXzO9NRhL9o9RFzRXtLWs0UPF4Fl03dAut0mmacZ0MGSA29JWbp2fVg6fsdZhPS+kDM0enJBkGtVB9qxGjnaTojg/N2rnIVKAIHmeVoOkJtKjsnwHNHFtzt4s7qNV55P0EsyoLgow4OXZSJvVk2uypv4kor3HbxlFWvB5HrbbeU41qN1A6m52mf9UaKryiDiDWYiQvzGuOnFb0p25Oh2pguiDqscPsKjMY1rpDa6ps5E6lM/hv79W9BqGdyLnHbAFJ8JNYtdCv7FKgVjB1DN8IRzJqjaGfygbIH+RvUWxu5sgsaoCeoSf7cGP5NFDItCvZ67T0N8TLuD6/NR1jGrbH1SFManetrEr//Tim6vYrL4F6igD5fZ3TRvZOLJ3cK+m4jFJGixjpvekjgTBJvTi1RJYlpQWefRr5WrApSM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(82310400005)(70586007)(70206006)(4326008)(86362001)(26005)(186003)(8676002)(426003)(16526019)(2616005)(41300700001)(47076005)(316002)(1076003)(54906003)(7696005)(40480700001)(110136005)(40460700003)(44832011)(6666004)(81166007)(356005)(2906002)(478600001)(82740400003)(36860700001)(5660300002)(83380400001)(336012)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:52:56.9802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83af8b8f-aed3-4b1f-afab-08daf9290360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
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
index 204e39006dda..1a8b31277620 100644
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
@@ -625,10 +636,10 @@ static int __init amd_pstate_init(void)
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
 
@@ -670,16 +681,24 @@ device_initcall(amd_pstate_init);
 
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

