Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B1E7372D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjFTR1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjFTR1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:27:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12529183;
        Tue, 20 Jun 2023 10:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu8pmPWA+67oyPMP+z/35/zaI17dIvhR51KnWSpv7rFSLnSMWzXPfT/trz8NOqGdq3b0eq3uHPC8EjbFdfTZY+P2Wlt3JGzPZwipcBsjf39vKpgVn3MNsk8LupvWVNXoTnEM0Bbc80QKNNlGRqEL0AvNxlxmm+/g0KWyB6yOqHwm4A+VZprGSCemRPciZyDxJGSnqigxn8LqipPWVBXUq9eytLvjT+LPbspWNZ1adnVqCZbsCHBOn1Pe61yP1l5MdTGq5+hBNNCujtGZU1Ra5Ngf2OdGa7pVOLluTxRmQwYIep/ODlH5wWcuUF1hnqicqF5N2VYx0HaANk5ygi2oFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETYCGfAq/LzCYhOmefnJ5nwq/V+YGaOe9ybE/TYP/OQ=;
 b=JCmQNf5Mam8frAESDZSKkWHLqxuBLhh6NpEfgoXHV3ru4xKuHaPk7xPQv/r/3K5kW5FRoUlW3pYicHoPSFINipblCE0VsVbboWHFIa8rDSNxNiFh5ldxMXYiU+o7wzAKY4qTpkfzBQBR8qq9k6l+UGiREdrwz3I91jRnY5mVuKvkv2P3DQ0KZisQnVNFDVOBayLp75nE4zIZcgZz+ux3n5DuPsAeq6VCZx28LH764Z5rCOqTcciqHNEWrWwPnUDHjlzhKjSw8iEC+CE8tjKCJI4UG4oSo/jxAu/5bokqE3zgyW4nkte7vJVdc8hf2Un4CCoH1cxfPjcov7RF20a1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETYCGfAq/LzCYhOmefnJ5nwq/V+YGaOe9ybE/TYP/OQ=;
 b=NIruZWH37qx5CiGKvHb5niT5PH14sFRUz2oHFfup5Umvp8Cfp2ca+267YHHeNIo28HdF5ofb3yV6fdLQwh4ArObxxrgmyevfKRfrORPLq0LAC+vbpdjS3RydlzB0wg7i0q+LgSxROL1M7odHSy6NmHQYKjDvnpxWuO6zo+FRsKk=
Received: from PH8PR02CA0002.namprd02.prod.outlook.com (2603:10b6:510:2d0::11)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:27:35 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::19) by PH8PR02CA0002.outlook.office365.com
 (2603:10b6:510:2d0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 17:27:35 +0000
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
Subject: [PATCH v3 2/3] cpufreq: amd-pstate: Set a fallback policy based on preferred_profile
Date:   Tue, 20 Jun 2023 12:24:32 -0500
Message-ID: <20230620172433.21325-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: fa29dc9f-4c06-4e8b-cfa6-08db71b3a33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlYJzZhPoMwnvbU++M1XxWehUWOGE6+BNLwgnaWVIBD71oivZpnNjZgkPF4glVsCw3I5TP/CukyNDmaRiaDbMPtx/6Tfq6rLhpujMAIRUuDh49kYhWeWQCYRFV5AVOfnOh8SIiR6u52EqXqUfURrj/Zt4XzEqojblCkANFKE/qJSZxthyWWjTcL8o1FcTXmqhgRn56OYFL4zVMj0iHbnPuTOfiK4PvVxvVE+dr3bnHiLZCDyY8sH2jZ13TfnaMO8/sW5xUALMhdILYIDH+RAM8a9nPaGxhEzcVWsidWy4BEq1PGt2aORi2q/ziiGXLXUE8ZOxomO6rsWMHhlVl9zNxJs800HMAioBgbgd0irZHYgG8kKe2PrKhVaCQGNVG+nXbkSavjlZIPZFjwUnjDGKVAz2mRZhGa8V9/cuon/5/+jbjHMm4PakLDSbYoZ9aez2kceAuB1vL3fzMXoWk1kwxv/qo0NKaiZAQOkKc+LuU9P4vU9et60/5U1wqUABZad8yMsIWBGDFcwkZ7rw8GqxXJtOhEnOIroX9fmrhLvSufXGQXTNnyFpBOvoNMmEGppATO6ri/OBl8Isr45ixpUfXbLZnCYcXgi5di9U+Bs0IfmD1VDTDN50drV5jx8JJMDPwA8yp63FNJa8gOjGxZwMLdIq4u9Yd0Oho4qzLIL28B9U1nUSq3VcmfHBgkst/pLlVmtt+tN2WFwWk04x5dYeuaxLxSFb+wYK49EdtV75jAB7c4oor4mvL8X8JruuWL+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(7696005)(54906003)(316002)(8676002)(8936002)(2616005)(86362001)(36756003)(26005)(1076003)(4326008)(16526019)(186003)(82310400005)(426003)(336012)(41300700001)(5660300002)(70586007)(70206006)(6916009)(44832011)(356005)(40460700003)(82740400003)(966005)(81166007)(40480700001)(478600001)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:27:35.4122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa29dc9f-4c06-4e8b-cfa6-08db71b3a33b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
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

If a user's configuration doesn't explicitly specify the cpufreq
scaling governor then the code currently explicitly falls back to
'powersave'. This default is fine for notebooks and desktops, but
servers and undefined machines should default to 'performance'.

Look at the 'preferred_profile' field from the FADT to set this
policy accordingly.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt
Acked-by: Huang Rui <ray.huang@amd.com>
Suggested-by: Wyes Karny <Wyes.Karny@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Move new symbols out of patch 1 into this patch
 * Add Ray's tag
---
 drivers/cpufreq/amd-pstate.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d8269994322e..3546d7db614d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1071,6 +1071,26 @@ static const struct attribute_group amd_pstate_global_attr_group = {
 	.attrs = pstate_global_attributes,
 };
 
+static bool amd_pstate_acpi_pm_profile_server(void)
+{
+	switch (acpi_gbl_FADT.preferred_profile) {
+	case PM_ENTERPRISE_SERVER:
+	case PM_SOHO_SERVER:
+	case PM_PERFORMANCE_SERVER:
+		return true;
+	}
+	return false;
+}
+
+static bool amd_pstate_acpi_pm_profile_undefined(void)
+{
+	if (acpi_gbl_FADT.preferred_profile == PM_UNSPECIFIED)
+		return true;
+	if (acpi_gbl_FADT.preferred_profile >= NR_PM_PROFILES)
+		return true;
+	return false;
+}
+
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -1128,10 +1148,14 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	policy->max = policy->cpuinfo.max_freq;
 
 	/*
-	 * Set the policy to powersave to provide a valid fallback value in case
+	 * Set the policy to provide a valid fallback value in case
 	 * the default cpufreq governor is neither powersave nor performance.
 	 */
-	policy->policy = CPUFREQ_POLICY_POWERSAVE;
+	if (amd_pstate_acpi_pm_profile_server() ||
+	    amd_pstate_acpi_pm_profile_undefined())
+		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
+	else
+		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
-- 
2.34.1

