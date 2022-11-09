Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E032622D01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKIN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiKIN5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:57:45 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11EFE75;
        Wed,  9 Nov 2022 05:57:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQjL2Ggy4qFcTjeL8AVnQoZXs9cjinZvREP2vAmvbdowAJ45OPcUZiEtipvXkLTbMolCrjCf3OKV5llBYmBQS4Y8LbpczOkubSfgbSiIIz9pOBBxhKmlW62GQLPeEAXZs9gvOyxR8MPUU5O4300dv9TOjxfkJ5PD2l3mY8DjLDo2LqasM8TupB4luBvX2/hV+Y1Oq4VkcGAlbNt1B4H2n843XRGS6OqeSEO2xd4Qso9ow6ddQ4N03+uReQ4k/HD3r/appxHCH8RfYiYSt3P5mHosoMTdkyFvJ1YxGAXAdEFMGvX6IVIx6aTkmZ7iuoYI71yROsWv8P9PNdvjRTYTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9JPFl3HTxIFlPjC6O2C+08p2IFxaFoND+D+EvPN8fM=;
 b=NS/q6/wEbcW7pMy3SVVZBMpCv7pe54t/NOJGa2CzzpI2lnlVA8qjq00Nfnma7LRs8bd4zp5sTDYtgQqrLgvcHPyaFw1Hx2qjIxzV2csXqyLh9qjVm6T6jo3aBmTtqmDgcvDbp61AheoaSCv3dveTH3bnQ6tXoqqrXE8C1nD85gedUacYGWtLHHd8okvmU4bUxoMmlqV9sJXnMoq1RggwWIDSSxzD9Fz5mJ2UXgVPlhSJTnWWguAkwq/sMyBlVXvYFNTtyDkoO728Qr8amNK/nraBLabhOKW9JxRMox5iyxzHEHEhFZq+FQZJQi8vp8/wwe2w+BwfER0KIWko9Dn/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9JPFl3HTxIFlPjC6O2C+08p2IFxaFoND+D+EvPN8fM=;
 b=jru9jVCJn1/UI35JpgStbOwDbs7iRbGg7p6wJORcwGm65qQl+jOXjCpAHSufWkQzckcX3oNnrLRANe4KVqYY1E2KlNYGbJ42BHrrn9yNHdIkTd3cJxy+ExwcOyrumLIVIzXnqGnN6pG3Fd4Mc/ZOW+mjXiRcyiKazzD9pKH/fWzdFAOZV8LdUbD49xf/R4MeMXrkcvfM/XkQYMjg/cd9IBfWD+LBTomSeHc3TInu7QIU6O4MzZ5CiIWBTczUjFeVLCEyAf9OJm14fAy6j+1cUlQpl/w8diV7fbRVfk12fJo5ZRcqYwdL4BTP6HqswLwYn9/nsxb9c5Nr2AiyyLctGg==
Received: from DM6PR07CA0105.namprd07.prod.outlook.com (2603:10b6:5:330::8) by
 CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 13:57:40 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::79) by DM6PR07CA0105.outlook.office365.com
 (2603:10b6:5:330::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 13:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 13:57:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 05:57:36 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 9 Nov 2022 05:57:35 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 05:57:34 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 4/4] soc/tegra: cbb: check firewall before enabling error reporting
Date:   Wed, 9 Nov 2022 19:27:17 +0530
Message-ID: <20221109135717.3809-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109135717.3809-1-sumitg@nvidia.com>
References: <20221109135717.3809-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|CH2PR12MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: 82bb3d52-5f4d-4268-5f3d-08dac25a5dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlhmXChzSbn0lkZSzaEpD7uUilEqaVjkUDnV7Z6yX0mGpe66k9AoAHhjYDqnjgQ77zjshRRDV8oQ0h5+IH1CV+eTEyywZjHFg7xh5ihCCnybf2JI5bKxb915V+kav4EtxVPeAKmFBLFE4otchdcmew++e2A0t0p0yz/jKDxANZgMDK8K29vcxbx5Ah7rA4SgzMSbENjSUgR4U6KKgyBsaOZ6wjcB0XH8vOahs+QUXQfPwkRcKSrkvH8sxcx9WccbaVSeOu9+WZQT0DckDT8TQC/33tWYBNQSeUrivnDIFkUevgB8d5el9EQ8Q06jr+oSRVKIIsXvU13bBqODHftabs1gCTf9C7vxmmOvsIn6cpnJJYaqVlZkdBTbfyZ3Kkyql6Y6/xs7XWgefH47Qgl/P1hbjLfhffpDCGXXL6SNMNO6zLq2GY6MXtO14BsDR1Y6hd53yodDtcU4O6wyO6e6afOyfpnETS70JMyMJ4CPL5zikJE3nHjQ2Mq9B4bfzQ3OeU9z6es1geU7V6ri8kTlA7R3Qtry3UAR6NrgS+v+FSytinUHBUB0KYk9V0VY9e5nwOQiUgOYMppoN3lovXXBl5bM59YMfzXAiC34/RIjdrCPKWmdVCgS0JPh0c0tXDVhglbRlyOrF/hepxbDB6hkdgP08S6SnITC6a/qT4mavqF16N23ELiPxHTnq2s15n+zTlUTdlsINwJavCE+6rx6OAIvEZOWC3zXT4E+GKYLZSeq7uGGLadtr/k3hJdwK+zJWA9P6uJsZADymLIOPldo8A==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(478600001)(82740400003)(82310400005)(7636003)(356005)(6666004)(26005)(316002)(110136005)(36860700001)(54906003)(107886003)(8676002)(70586007)(40480700001)(86362001)(426003)(7696005)(450100002)(83380400001)(5660300002)(4326008)(8936002)(336012)(41300700001)(70206006)(47076005)(2616005)(40460700003)(1076003)(2906002)(36756003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:57:40.3557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bb3d52-5f4d-4268-5f3d-08dac25a5dec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4890
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable error reporting for a fabric to CCPLEX, we need to write
its register for enabling error interrupt to CCPLEX during boot and
later clear the error status register after error occurs. If a fabric's
registers are protected and not accessible from CCPLEX, then accessing
the registers will cause CBB firewall error.
Add support to check whether write access from CCPLEX to the registers
of a fabric is not blocked by it's firewall before enabling error reporting
to CCPLEX for that fabric.

Fixes: fc2f151d2314 ("soc/tegra: cbb: Add driver for Tegra234 CBB 2.0")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/soc/tegra/cbb/tegra234-cbb.c | 83 +++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 0fab9e21d677..f33d094e5ea6 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -72,6 +72,11 @@
 
 #define REQ_SOCKET_ID			GENMASK(27, 24)
 
+#define CCPLEX_MSTRID			0x1
+#define FIREWALL_APERTURE_SZ		0x10000
+/* Write firewall check enable */
+#define WEN				0x20000
+
 enum tegra234_cbb_fabric_ids {
 	CBB_FAB_ID,
 	SCE_FAB_ID,
@@ -92,6 +97,9 @@ struct tegra234_slave_lookup {
 struct tegra234_cbb_fabric {
 	const char *name;
 	phys_addr_t off_mask_erd;
+	phys_addr_t firewall_base;
+	unsigned int firewall_ctl;
+	unsigned int firewall_wr_ctl;
 	const char * const *master_id;
 	unsigned int notifier_offset;
 	const struct tegra_cbb_error *errors;
@@ -129,6 +137,44 @@ static inline struct tegra234_cbb *to_tegra234_cbb(struct tegra_cbb *cbb)
 static LIST_HEAD(cbb_list);
 static DEFINE_SPINLOCK(cbb_lock);
 
+static bool
+tegra234_cbb_write_access_allowed(struct platform_device *pdev, struct tegra234_cbb *cbb)
+{
+	u32 val;
+
+	if (!cbb->fabric->firewall_base ||
+	    !cbb->fabric->firewall_ctl ||
+	    !cbb->fabric->firewall_wr_ctl) {
+		dev_info(&pdev->dev, "SoC data missing for firewall\n");
+		return false;
+	}
+
+	if ((cbb->fabric->firewall_ctl > FIREWALL_APERTURE_SZ) ||
+	    (cbb->fabric->firewall_wr_ctl > FIREWALL_APERTURE_SZ)) {
+		dev_err(&pdev->dev, "wrong firewall offset value\n");
+		return false;
+	}
+
+	val = readl(cbb->regs + cbb->fabric->firewall_base + cbb->fabric->firewall_ctl);
+	/*
+	 * If the firewall check feature for allowing or blocking the
+	 * write accesses through the firewall of a fabric is disabled
+	 * then CCPLEX can write to the registers of that fabric.
+	 */
+	if (!(val & WEN))
+		return true;
+
+	/*
+	 * If the firewall check is enabled then check whether CCPLEX
+	 * has write access to the fabric's error notifier registers
+	 */
+	val = readl(cbb->regs + cbb->fabric->firewall_base + cbb->fabric->firewall_wr_ctl);
+	if (val & (BIT(CCPLEX_MSTRID)))
+		return true;
+
+	return false;
+}
+
 static void tegra234_cbb_fault_enable(struct tegra_cbb *cbb)
 {
 	struct tegra234_cbb *priv = to_tegra234_cbb(cbb);
@@ -551,7 +597,7 @@ static irqreturn_t tegra234_cbb_isr(int irq, void *data)
 			 */
 			if (priv->fabric->off_mask_erd) {
 				mstr_id =  FIELD_GET(USRBITS_MSTR_ID, priv->mn_user_bits);
-				if (mstr_id == 0x1)
+				if (mstr_id == CCPLEX_MSTRID)
 					is_inband_err = 1;
 			}
 		}
@@ -665,6 +711,9 @@ static const struct tegra234_cbb_fabric tegra234_aon_fabric = {
 	.errors = tegra234_cbb_errors,
 	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x17000,
+	.firewall_base = 0x30000,
+	.firewall_ctl = 0x8d0,
+	.firewall_wr_ctl = 0x8c8,
 };
 
 static const struct tegra234_slave_lookup tegra234_bpmp_slave_map[] = {
@@ -683,6 +732,9 @@ static const struct tegra234_cbb_fabric tegra234_bpmp_fabric = {
 	.errors = tegra234_cbb_errors,
 	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x19000,
+	.firewall_base = 0x30000,
+	.firewall_ctl = 0x8f0,
+	.firewall_wr_ctl = 0x8e8,
 };
 
 static const struct tegra234_slave_lookup tegra234_cbb_slave_map[] = {
@@ -757,7 +809,10 @@ static const struct tegra234_cbb_fabric tegra234_cbb_fabric = {
 	.errors = tegra234_cbb_errors,
 	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x60000,
-	.off_mask_erd = 0x3a004
+	.off_mask_erd = 0x3a004,
+	.firewall_base = 0x10000,
+	.firewall_ctl = 0x23f0,
+	.firewall_wr_ctl = 0x23e8,
 };
 
 static const struct tegra234_slave_lookup tegra234_common_slave_map[] = {
@@ -777,6 +832,9 @@ static const struct tegra234_cbb_fabric tegra234_dce_fabric = {
 	.errors = tegra234_cbb_errors,
 	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x19000,
+	.firewall_base = 0x30000,
+	.firewall_ctl = 0x290,
+	.firewall_wr_ctl = 0x288,
 };
 
 static const struct tegra234_cbb_fabric tegra234_rce_fabric = {
@@ -787,6 +845,9 @@ static const struct tegra234_cbb_fabric tegra234_rce_fabric = {
 	.errors = tegra234_cbb_errors,
 	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x19000,
+	.firewall_base = 0x30000,
+	.firewall_ctl = 0x290,
+	.firewall_wr_ctl = 0x288,
 };
 
 static const struct tegra234_cbb_fabric tegra234_sce_fabric = {
@@ -797,6 +858,9 @@ static const struct tegra234_cbb_fabric tegra234_sce_fabric = {
 	.errors = tegra234_cbb_errors,
 	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x19000,
+	.firewall_base = 0x30000,
+	.firewall_ctl = 0x290,
+	.firewall_wr_ctl = 0x288,
 };
 
 static const char * const tegra241_master_id[] = {
@@ -979,6 +1043,9 @@ static const struct tegra234_cbb_fabric tegra241_cbb_fabric = {
 	.max_errors = ARRAY_SIZE(tegra241_cbb_errors),
 	.notifier_offset = 0x60000,
 	.off_mask_erd = 0x40004,
+	.firewall_base = 0x20000,
+	.firewall_ctl = 0x2370,
+	.firewall_wr_ctl = 0x2368,
 };
 
 static const struct tegra234_slave_lookup tegra241_bpmp_slave_map[] = {
@@ -1000,6 +1067,9 @@ static const struct tegra234_cbb_fabric tegra241_bpmp_fabric = {
 	.errors = tegra241_cbb_errors,
 	.max_errors = ARRAY_SIZE(tegra241_cbb_errors),
 	.notifier_offset = 0x19000,
+	.firewall_base = 0x30000,
+	.firewall_ctl = 0x8f0,
+	.firewall_wr_ctl = 0x8e8,
 };
 
 static const struct of_device_id tegra234_cbb_dt_ids[] = {
@@ -1084,6 +1154,15 @@ static int tegra234_cbb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, cbb);
 
+	/*
+	 * Don't enable error reporting for a Fabric if write to it's registers
+	 * is blocked by CBB firewall.
+	 */
+	if (!tegra234_cbb_write_access_allowed(pdev, cbb)) {
+		dev_info(&pdev->dev, "error reporting not enabled due to firewall\n");
+		return 0;
+	}
+
 	spin_lock_irqsave(&cbb_lock, flags);
 	list_add(&cbb->base.node, &cbb_list);
 	spin_unlock_irqrestore(&cbb_lock, flags);
-- 
2.17.1

