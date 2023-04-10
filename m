Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7848E6DCB20
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjDJSs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDJSsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:48:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFEF270B;
        Mon, 10 Apr 2023 11:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt/S79PW/t0okHyi13u1L72dcrGKfsO4SvEpuHG3G6jdavDh6pTuBVximRH+wEiDKJcoRNeYsA5/K7TzKL2g3sjNQwid5e846LHl9KbEjqlp0x2j6k4aKa7ktws3iuEZLxUrm+xc09YpUfh+1oWSLKB2/2MmTW8veziYEhaDM2aZ+jyFC1C/gvkjx2myRuBMkt6aTTxxdT6iJqfPJZ9ZMnbGINw36nFAjJBRc1fjj3WJvKB2c8OBay/IMdJpy/GY8PVAFgsmnTqF8kFBVeE3bPmrIieBqoSSfOVJk7UcxJwKC6lYvqOm9cM7ntxIEGxQ5NtBPaL4VWb1Szu9xGjNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MDls9ITIFGGKkwfzufckKk9fjZ1Lh0w+zr7TA/z5wc=;
 b=R5EG4U1XjNoIlZGxvUik9v/yKuomKYWiBdu12lJKPDUNzLfKZTRPuzrTGCm9FP8hh4B6AYF8Cwoo611RZjG4+L1688ayByncCqDoniHBMthZcbJmP/2Z+KudU7dxobchWdKNu50FuOe2qwMU7ubaSL/7HXXFdSNVv+zOS48mmPxlnfAAcrkq0JYNo4/goHL80IIiLA3g68l42ns4Faa+jGoAo5ic98xmYBawWFVrhmkg7ScMXd7n6LLtgbpNxB+hjynoR4UDIr95ZzxSA0tptPk6U5fl0P/8ys/0nB9t5pnTRnrT23gDnFSJ1ApaMK50oKKGt8OZisLh1vvliDu1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MDls9ITIFGGKkwfzufckKk9fjZ1Lh0w+zr7TA/z5wc=;
 b=E8PGAL62vfNlX5VcOo/yooKWfUKQRQxgs3l1gbVu6Qt94YphGJSOwE0JIx6OxNn0q6M7FLzCdyYTosebrNmJ4njRVMw0ABq4YU1l3v0hg6hUdIKNulieO1pQD4OAtqWpzZHPT/MSysvGYskeOXFIfkk2G5TRvbtKDpb9TcrSAt8=
Received: from DM6PR17CA0013.namprd17.prod.outlook.com (2603:10b6:5:1b3::26)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 18:47:42 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::b) by DM6PR17CA0013.outlook.office365.com
 (2603:10b6:5:1b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34 via Frontend
 Transport; Mon, 10 Apr 2023 18:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Mon, 10 Apr 2023 18:47:41 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:47:38 -0500
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
Subject: [PATCH v13 12/15] mmc: sdhci-cadence: Support device specific init during probe
Date:   Mon, 10 Apr 2023 11:45:23 -0700
Message-ID: <20230410184526.15990-13-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410184526.15990-1-blarson@amd.com>
References: <20230410184526.15990-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fd39ac-ee87-47ac-d675-08db39f410cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StomrXiIKPYT3IzM8nNGaev4Q9WRoc0KfyF198hXnpWfSomz/hNbTq+Ria8QxMe2HdBc7O5Rs9c+LpZp02kuTdlBY3PIoWpQSKhvr7lnESQ2mNzZn6lZlP0Eu2f6SwdsW0znsQhAHIGk6OQWRbiMXhrSMRZRhZN+GE/yTjxzg4CYH/+rtVIaSPVy1+ResF4n5VSxns4VPmarFKch9+8rMKP78p2dUopIrP7mdfVLhqwJ/tvbqpxfjJ2hg4ulUlg6xaB+25a1mPaUrME7miowYcF/o1ArNa4uMB770zB6yoE1VqGuGr9Ctc5RnkMf9lVdcWc7Z6FhOxfWGJwBM/nfxGYVGm/kwbnF5rTWpxbldGHh3/siv/TOttLnV9lIE+pvPcn5Fm+gFm0Gj19DRuZOERls0UFG0Bvy8HjkiB2K5hC0CdUkq8pDpW4GYmP6vP4ZaVYXUmuv+1J2Mn7rI5wA7XoUxvMs7ribc1MVJP8BjmIpk38lrsVQ0eh3UedofEPl7Ec+Smg04sIqss2wLgN7//62hmE4j7rqCJ3Vr/1+3kEWO2oQ7w6tRSqWlsj386mmv39tzPuKiDZ3mV6LlPqq2YB8NOAyClsRCzn/MceDrvpFMM+14rora7Z3ms0twrAxWSWOTQtYdJLeRgZ29MGXsAjIMJSJsjVSj6693sGzgmv/JK1Uv7U1QW/8A81gr3BGDWrSVEpNDuh694pwIBSD7Nl29SUDdjUAcrvFjIHXNlw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(478600001)(40480700001)(83380400001)(47076005)(36756003)(40460700003)(82740400003)(356005)(81166007)(36860700001)(2616005)(426003)(336012)(6666004)(2906002)(316002)(186003)(54906003)(16526019)(1076003)(26005)(7416002)(82310400005)(8936002)(8676002)(6916009)(41300700001)(5660300002)(70586007)(70206006)(4326008)(7406005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:47:41.8873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fd39ac-ee87-47ac-d675-08db39f410cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

