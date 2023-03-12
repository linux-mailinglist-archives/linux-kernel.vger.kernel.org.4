Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4606B6287
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCLAsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCLAsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:48:21 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598E56BC35;
        Sat, 11 Mar 2023 16:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rs0u4iAvc3JFG1FZcwuOG1fWwfQsruY/e6ChpKSnqgrr3it0QqOQ6nrsqGscOboVmEAXmZ6i7wJcV/Yc7OAjycTNsEwyEDzPpX6dJqkbuva5MxDR59YxB3N8x+qy3tfnNiJf3NQAffJ6RyQYcQeQAjJ+YP3VO9U7X+fkIzSGLGEzsfe7LR6m+NOFv1bUBHD/b16LRucQwZCz2og7QPfawDJtGfCuyZawgEe53hDbIbm1Q6NsY1nYtRbgkoWv7FeI1xWwnzk6ZjqrKPUEnegoHTFgQ1Qj6s9kp6hFSNjHQY8cmbuQjh37O8XtfoyVE+/Z+BebQoeOppzF45rzvTstYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MDls9ITIFGGKkwfzufckKk9fjZ1Lh0w+zr7TA/z5wc=;
 b=LxXrn25eDSOnhNMoibqJ+257WP8YWrWU0PRoc2CsKUW8fKP/nANKZbSv4pkokKXOJfo6cZs48q8uc/JSHmQ8FRi9f8yLJNpO9Qwt4Oua4gkMCeYP9+K0QevTKjjiajC7m+Ft6nGVmOtbayJD6rjqxbhlj3oHKAtB3jID/KNCSh5F6neIvIqxE2lOqtNSSHFiil8iwmq1LSY7k2gqWl+TBvgQCi8EvCh8LD4YOQN5yWtWxAmL6VmqgRtG7pxTZgC39OU/Rxj2qB1EmyjAJ84ZM+1A6hRCF5rPBLPiNhRaw2n+6KWrkV/IEtDRxmx+jsYJTzLWUmCntvclYj3rwraVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MDls9ITIFGGKkwfzufckKk9fjZ1Lh0w+zr7TA/z5wc=;
 b=SxWraxn3mpzS2DzNj4TKmXsM25ADrQoWaTCdiJOg8TIs+qhON1lCralK83eD3M8/KZgU0L79KI7dw/6yJiRbGCBroLn/sPK4OkUP9BW7K/ynzI5qXd/JonHcztOFvOt7LyJDcnHNRXjsUhTPJLDP/IA9msNg8GE2wBVBwlvimqE=
Received: from DM6PR03CA0028.namprd03.prod.outlook.com (2603:10b6:5:40::41) by
 MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Sun, 12 Mar
 2023 00:46:44 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::ed) by DM6PR03CA0028.outlook.office365.com
 (2603:10b6:5:40::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24 via Frontend
 Transport; Sun, 12 Mar 2023 00:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.23 via Frontend Transport; Sun, 12 Mar 2023 00:46:43 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:46:40 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v11 12/15] mmc: sdhci-cadence: Support device specific init during probe
Date:   Sat, 11 Mar 2023 16:44:42 -0800
Message-ID: <20230312004445.15913-13-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230312004445.15913-1-blarson@amd.com>
References: <20230312004445.15913-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b8c91b-7d22-4020-61ee-08db22934052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbssGhvUc5vU4hzozr49hgNmhKxcw9/JcgoHCstWwlck1aUutjYhOQjG/YQfXvI+hxSUDifJN3xPm2Upk9xqW33wYAx2U0dBSsT4t1rVaoGeWivaM92KLYo/OuCSxGrb5v6Ih86jXRX0c2N1AtoorDsCNd8+tJpRPKanQtb1IpCY7C4FZ6Lzi4sz0UdLA2K+be86ZjzB85tIq0MgPmnDVetLCnIO7ruEIm4TGLvYABdjAU07z0PSmX7aH7yioJkwCYgO1+5vvPxxvNVfFrShgecbFyY14EIaxVCQkMj+HCIj6SYnL0cOKjXfmrC9te+IJGJ8FdkHPk8aZdqnNU9L/0W7USAGIhw+EHWcOHO3FSLXA7c/NhphfMgwojfMiFfkmnZsC6td/3a1XwJ0DYcvHjUkiE070v0ZnOxE+YXHWOnp9RJdfuD49iIBhXA0KZ5dU+xFpZreoLGsOF6lniKOl5yuHySZe3f2WuyCqWcM2nNYiHzFs+LRG5NxCNtqX7uNxWRNe220xDrXHGWMr+sqYrH11kkGpML5QgnHyICJciR9tgpfUCH9QDIsW2Rzd6YiTqq0cuwcNJ4RbRcYoBSRNMrB92d1wPJcSOvVXyh9YjJcXG1+aTzUoehC2gy44TSot4EhN/1f7s6VFgg2h2I/fhiKb3J+sO9iQ8/33InAAh2+T58BpRIpYS8+lDz/Bbi0h0UPOjSzFPwWyBPELFQXDdvnSo91dGLKK/byv4HQQCU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199018)(46966006)(36840700001)(40470700004)(356005)(82310400005)(36756003)(36860700001)(81166007)(82740400003)(40480700001)(40460700003)(4326008)(6916009)(70586007)(70206006)(8676002)(41300700001)(54906003)(478600001)(8936002)(316002)(7416002)(7406005)(2906002)(5660300002)(47076005)(336012)(2616005)(426003)(83380400001)(26005)(16526019)(186003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:46:43.6953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b8c91b-7d22-4020-61ee-08db22934052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move struct sdhci_pltfm_data under new struct sdhci_cdns_drv_data.
Add an init() into sdhci_cdns_drv_data for platform specific device
initialization in the device probe which is not used for existing devices.

Signed-off-by: Brad Larson <blarson@amd.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

v10 changes:
- New patch to provide for platform specific init() with no change
  to existing designs.

---
 drivers/mmc/host/sdhci-cadence.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 708d4297f241..c528a25f48b8 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -77,6 +77,11 @@ struct sdhci_cdns_phy_cfg {
 	u8 addr;
 };
 
+struct sdhci_cdns_drv_data {
+	int (*init)(struct platform_device *pdev);
+	const struct sdhci_pltfm_data pltfm_data;
+};
+
 static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
 	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
@@ -325,13 +330,17 @@ static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
 };
 
-static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns_ops,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
 };
 
-static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
+static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns_ops,
+	},
 };
 
 static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
@@ -357,7 +366,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
-	const struct sdhci_pltfm_data *data;
+	const struct sdhci_cdns_drv_data *data;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
@@ -376,10 +385,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(dev);
 	if (!data)
-		data = &sdhci_cdns_pltfm_data;
+		data = &sdhci_cdns_drv_data;
 
 	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
-	host = sdhci_pltfm_init(pdev, data,
+	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
 				struct_size(priv, phy_params, nr_phy_params));
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
@@ -397,6 +406,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
+	if (data->init) {
+		ret = data->init(pdev);
+		if (ret)
+			goto free;
+	}
 	sdhci_enable_v4_mode(host);
 	__sdhci_read_caps(host, &version, NULL, NULL);
 
@@ -461,7 +475,7 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
 static const struct of_device_id sdhci_cdns_match[] = {
 	{
 		.compatible = "socionext,uniphier-sd4hc",
-		.data = &sdhci_cdns_uniphier_pltfm_data,
+		.data = &sdhci_cdns_uniphier_drv_data,
 	},
 	{ .compatible = "cdns,sd4hc" },
 	{ /* sentinel */ }
-- 
2.17.1

