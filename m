Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349C75B5B13
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiILNXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiILNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:23:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4072229D;
        Mon, 12 Sep 2022 06:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDMQAyYxH7JFRfHMtK65VWbgmI41MwaxIIO1J2ThrcFoGRrqncN90JFC5HjVMcae/RE8w4WU1f+leneInnqLO26Y/GqyC1BwjpE5JInqFBpw4s+4/M8Zk/HyNTg1AqfFeJt+M/vuSbxteIDpbNzX3SMQ5NJXq6NS00YN1NmdGyfHFsLOlNr3iEImOq/fNvEVipDUFbCSH4Psc0N+4Ih7YuzEwrH2rM12Ix3EPn/egTPjkt8AkPRgRu+XRzrDlYki7RUlpfWLy26eceYbKLYm0smvYQKYJ7FTbC+qAEveb+b0cO2E/60rorx2oJqCl1DyKHgZF31cFFTBO1yrP6dQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJObxTWShbDFxsFVtdlqC+pdPx4k6zgESaEnb8VOxt4=;
 b=kfJoOX/f+h0EnDml+giYo/9avXW3Kwdl8RdeB8U5qnbglQaTUyqdQfkOnv4u6Jkam3krYS25/6aB7JIBm/yfB72X/pfOW6Wcz/b5aBe+z/NZ95yxG4okjTbWX6DJq2wgBoKfFuS4FMf92tHKy3U2r5POCaVB6xpvmQhfP9g0g3Tsou1pW3n9Trpk2m7cIAysHqjEdcKu/yOhHLW/j4iUMwGceIbrOOz2B31ntrWhxejrfbQ/p+6DdXyu9E830yPFHV2CRlktlkWc0/Tb7rLh13APYX7BTEDxjL1Nk0ez6IPztcgvnW/dyCdE30MMG1gkPbfLMLtvlFaBn45TQHdyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJObxTWShbDFxsFVtdlqC+pdPx4k6zgESaEnb8VOxt4=;
 b=ZWzrOAgJcnlmpFO7VcFAxp/ab7L2c0S1AvtTrmNZ7+fCzb4N+gF6shCYFYhXJwkAJTmSGo0tHC16i0w1BGXo3jqB0DXwa2pVIWWOrOZSsRQ03l0DvpXtHouK6+09hgw788yW8p3FuMRklSwhq9O7ZO5n3mRIf1yq9VzfDKsONH4QyOKs71NYBKOcMcexofMwlZwcvx451p1MFUzS8NNy4soMR/9BuC5kl38sb0Yqg9jhZleyQ8E6wNWKTkci7w2wmGnPINJuG9/3Vg2nqUT7u2CqY5UmWaznkN//J5s2t5WPWYN3tNl58XcUD3DTxXdW+Kzoe40GhyyEIsWNKXcHpg==
Received: from DM6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:5:134::18)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 13:23:44 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::68) by DM6PR13CA0041.outlook.office365.com
 (2603:10b6:5:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Mon, 12 Sep 2022 13:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 13:23:44 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 12 Sep
 2022 13:23:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 06:23:42 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 12 Sep 2022 06:23:39 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>
Subject: [PATCH 1/2] mmc: sdhci-tegra: Separate T19x and T23x SoC data
Date:   Mon, 12 Sep 2022 18:53:36 +0530
Message-ID: <20220912132337.18159-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa2614e-4c87-4707-da95-08da94c2043c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CySPhZf7WPJCXlg4vNE+yQh98ePl0tw9Kq/n61rof8NAYC+UaI0nl5LSLcFF8OTqABKYZJ3oKW6g9x6IVb/a9YrU/ZKAK8jpEHIqW+fcgHZZsg5v5sXjOHexSlS2tgXEQTuFqr40UA+r8LzUfvDyWHgT8uffpgEuulNzqFbZh6EXta9Soln6/jIZfXPfzKXteHaA1fE3XYTAtvVYUkktAgkjG9hOmPuFmPYT5Ude19IPmPI/GHT2gXx5nqJ3ZYULnnvuy+M0tP4wodX1OzePaZhQywNjOHFX4quCJ0klhcbJDOoUmQsLq62y1YSX8Ms+IOu2GBBBzlqK+En3dHrkqkHsy1cw7fZJOldVV9KeL86B8FuROBF66crb7Fbv5uFh8GdudAlDX58oAZeP/5JapeXOySeKdBBHzAcmpKU3JU9uHYDrPKq/XV4ZAUUGpFmnO5tqnBtSBF3CtaPVHYA4ov0t4IxCTkOa/hUwMmCsgxLN20Hjf9i60+MiAxQNZi5anivyHW2cBOfZXxOcKgLnpigWlfPBDv7Akesg1TdCRkijVqRPiRBBEATEldOxZW6H0zRkixkn9VBn2fiG88B0G+l1Wu17cMOoelHQN//RYhgHQpp4A4G+TJiovcn5nb0Oy97MkfquDC2Sji4D7cjOGQFsC8lWO1u2QaaSqN9/0+C/1j/+6Linl1XrM/BGF2cs/R+wP2QgxIzf3e0sy/y59xQz4NjvR74qNXGAghmlHtRU8p0jlfialfWQ/1PTBfuU6XFn9dt3cnbrmq35zvxVseMLY9azxe4eemvTMZw7fWuDO7iELEt0Z/Ir10s+y38A
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(40470700004)(7696005)(26005)(41300700001)(478600001)(6666004)(107886003)(83380400001)(2616005)(1076003)(426003)(186003)(336012)(2906002)(8936002)(5660300002)(40480700001)(82310400005)(40460700003)(110136005)(54906003)(316002)(47076005)(70586007)(70206006)(4326008)(81166007)(8676002)(82740400003)(36756003)(86362001)(356005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 13:23:44.0916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa2614e-4c87-4707-da95-08da94c2043c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new SoC data structure for T23x platforms.

Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2d2d8260c681..136c045d8f01 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1525,7 +1525,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
 	.ops  = &tegra186_sdhci_ops,
 };
 
@@ -1556,7 +1557,21 @@ static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
 	.max_tap_delay = 139,
 };
 
+static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
+	.pdata = &sdhci_tegra186_pdata,
+	.dma_mask = DMA_BIT_MASK(39),
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
+		    NVQUIRK_ENABLE_SDR50 |
+		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_HAS_TMCLK,
+	.min_tap_delay = 95,
+	.max_tap_delay = 111,
+};
+
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra234-sdhci", .data = &soc_data_tegra234 },
 	{ .compatible = "nvidia,tegra194-sdhci", .data = &soc_data_tegra194 },
 	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
-- 
2.17.1

