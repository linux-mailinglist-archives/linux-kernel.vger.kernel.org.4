Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83536AB579
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCFEL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjCFEKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:10:50 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A56126F3;
        Sun,  5 Mar 2023 20:10:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omqq4fMGBMzOaa0RPQBywKbTdowdmKoVyohJ+XCzQEtS+pDTAlAYQmO6GnPaeRaKivbtpmN/6+OzA+63fyRzoU8qN1nO0K+RiGWoAMje2lhE98TYfj0Gi8Spu+mkfJB7IdEBJZeSh9WtVcLhH8kpkl24zDOaJ68ZXnWslGidtj00ghvRnxYDnYp43TIVZ9Qh3ENxMLLPJCQGFU5Az8yJSrBt2DSUVW0JtA5odPaWHb/nhDLkfqJgokbgI1yXYxkgwHCVa0UMWaaelB78iui7BTSf0+wnFm85vrhEivpiHAbutBvmQSScoeMbCFObO3khhSMGb7s3x0GHhnRbZRQaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qipCR0+zBbuXbDMVEXpE+22nGnKAl1M8eVatvYWOYLo=;
 b=bWsLMhNEffxn53NP4IpmFmqkfukXsfuuoM9E8Epf0pG969aZVVGipvR8HktzXhOEvRS63WgC+gw3EOV8OMIl9fmAGQXakzXLQ6EKhMS1M2SgWOIQsffl7MAtheuzIi9vtKxicLkC5stm/LAhlpkov7Tuoa6ImkzT8wVlU5e2tAlq77agLWeMTGE8Yxcb+7cVJGMVo1c1IUIXPT4Zie0JOd7sJ/FHMJFFzkjclC2krUYr0bBjdaccdmZ+K5Ed+Ou94UbUKs5cBwh+1fftZK/45aMxlszbSAA31m67vvt6KxkVRrl2q8+LluSDKvlyZejORt9lGVDhQFMPJOtSDiRNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qipCR0+zBbuXbDMVEXpE+22nGnKAl1M8eVatvYWOYLo=;
 b=R5rTW/XMR3B0MPak1u0k7d0c1o4gIU4Y5HHiNsoH12XZiwYMnbOh91lqRFocBgSx4ZFcZt38KqNaIMQCJBCwLh1DU0p+zjN7Rx+/RJrDpq1+lSMEZu2PdpixramhT419rEBqoncRpITBXg70eppD5VT/C7Jxb++BL0/JwTUl3do=
Received: from BN9PR03CA0277.namprd03.prod.outlook.com (2603:10b6:408:f5::12)
 by DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 04:10:29 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::40) by BN9PR03CA0277.outlook.office365.com
 (2603:10b6:408:f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 04:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:10:29 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:10:25 -0600
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
Subject: [PATCH v10 12/15] mmc: sdhci-cadence: Support device specific init during probe
Date:   Sun, 5 Mar 2023 20:07:36 -0800
Message-ID: <20230306040739.51488-13-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|DM6PR12MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: a14fdc9f-24c1-4639-4387-08db1df8b8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jxw1A1mIH6+nLPndftk45AyxHI3i3W3NeMtit2PcV5mOUV7IfDklpNlUN4+2NtpRaEfpJfdcPnqueDNiXTTu3HMl8ErZMxJrRRQEHPBXWj6PIDp7kwvM3IgmyScIB9pfvfKNY3VALrTVVOkheM+gF962LXDnbkG6gWMAsXzBPLz7GSPIAVEC5bfl0WNWn4w4BYoST4vy1PWBJOeX7SbXZopj0/rKs/dVvvd3z2R3tgC/8LRxhN8TK965bLGWaNH9x6KM5nqZLiMXHqqleZKrGGuhNujyja/m90uuJsb2h2imMA+bWdEI+VLbPNbLNW7bTyBTJz6YFuKn7HLK29RrwlKTSO3kMpHSWP7IeY/3YYgDfQL/9pR+Q3GnRzTkiTDVx9jAU3XLu4yDJv6WUet6QztjKqOuQFHvRTbZtspJHe7h9wofMSHnWly6YybfutAw3M0DetleefdWwgIJ3bBSIZODnCAdgEcAkGk2clXM4YBz2d829C6L3NFGik56j2e8H7Z7FZ0/LyH6BbfG2FRC6TARoS8wBV0Xs+o+DPI5Tg4UhV14oPqlG8V2sWDSMMHqF6IMu1wEqlM1/woPgmhf89hSrc2AhQ9jbUdFGQma9yGTGSn9OaQdMkkBHKCue6QTVopHBMtE5vJ44kLqZNQDcGcXuoONcoc3LspPE5lpGHhec/AOLYR6zazeFL9kPgm8x6/NWxIw0t2ubQAn61zLhd0ZT/jHxpKQ5OHIqcnOqI4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(426003)(6666004)(47076005)(40460700003)(36756003)(8936002)(5660300002)(81166007)(82740400003)(7416002)(7406005)(478600001)(356005)(40480700001)(82310400005)(2906002)(2616005)(186003)(16526019)(336012)(1076003)(26005)(70206006)(70586007)(8676002)(316002)(6916009)(4326008)(54906003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:10:29.5420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14fdc9f-24c1-4639-4387-08db1df8b8ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878
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

