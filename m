Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48C85EDD44
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiI1M5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiI1M5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:57:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FDF98580;
        Wed, 28 Sep 2022 05:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRZzxqS3Vm8x5N5TVPyu2x15IFxhG0OLpIW/ZxbYqM42779WhxbYLYYas/OSUspYxTunlKQ4yRZe/6qfxyw1HoGnwBl3BFPp+s0UHD/Nu+HJr06TWew/33+tAUJVY91lwtMzV1n/Y0anIEFoisAxYNJ17l18BJpKvPKiCUwb7aL1O8DQtsLfIDuwR84lC/S1TTaX/NWHZ3ndlEqenVKZ27eKNCVz5YxDS8tVyviLCE9uMLxKKpAWKuJSsmzR8QI4rMWwkjdkgps8MWOqSNf2Fp7kDscQcaiJlcIHYzvF/swJHfD8IHbgQMsnNHpXy4oBwlO2QPpHQTSRcVM4/cxw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt2SFqLcav+hZ/lBpn/7PhfyM9sb1S7Ki7Fjfdb/ozI=;
 b=mLnGLZNR1x5o0Jp3mEB09kVP3I9YpHM2zZaclSHmvK3yJj+O+tJiBz8cPdPG6Fq+991NbZRTpvFh0vC4Nu1xH+avfnG8sAOcKE6h9HAdsnaF59QpSbBnHHpUOw53dw812dACeF/TqJZSmX4QszAua68TNiLR0wzN8r1FKp9FsTHYQfOuSiuYApLJ/fjyvm5Ld4fQYDL5AyFqonsCP975Tq+qyE880ZY807DW1DRDLE4ftHOq9nXikfzi3lMd16ZFkAQ3MXXAGD+nxQL1+1PBnr4LNdX4sUgOAYdRE9B1x4jNNRYXrNE0Ef2wNcg22aLkGA6y6m5iyRCN/pG/llq6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt2SFqLcav+hZ/lBpn/7PhfyM9sb1S7Ki7Fjfdb/ozI=;
 b=chTMzie/6BWGtdLiwDOm764miX1jQqX1AoHx5hxr6Mn5Y1UNOhe1gmrRrC9bvIQiBwrdkFuF2dxKQcplQJfFis8/vWJfjmZBrH0T0HrexOqdHXPVkL1GJZ4ZiRNk3fTRx8qrwWhtztwZBlsErK7bZwoClG9ry0+yDqWp+tmpSpv3vSUDET88t9H1P6YAi1dUBAvtPgu5MJRp/W3QJ4xE7VrK42ETbPywgVjriz5BIy4nx8OqDq1qxjkbWkB6oJaVsrxSigcMaNkPCqeCTVjhaU6shpKh828pa1diz4uUBgeq4p5p6b8VbVLji3YhNDwwlK8poE4PyFyugfFTrXz6oQ==
Received: from MW4PR04CA0240.namprd04.prod.outlook.com (2603:10b6:303:87::35)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 12:57:05 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::3b) by MW4PR04CA0240.outlook.office365.com
 (2603:10b6:303:87::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 12:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 12:57:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 05:56:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 05:56:52 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 28 Sep 2022 05:56:49 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v6 1/4] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Wed, 28 Sep 2022 18:26:45 +0530
Message-ID: <20220928125648.19636-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a5c231e8-f28a-e692-5961-58e6838711ed@intel.com>
References: <a5c231e8-f28a-e692-5961-58e6838711ed@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: f93da4f4-820e-4acd-dd0d-08daa150f1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfWd0WXQbqGHYiGoVsZ3FnZd/xEEcJwlZgfBLVa1jc7AK9Fprgo5K3G/x/WX/PepqxrtlVAGWM25OwY6LzOzv4WIqFvdbKlfRCLSJpMtNRcxZoeJET82vRg3UB8tOikmq9d/JyJXcDwRN1xktlVhoPxInvVcUSUdVw2dUmSGJ+T20k2aQtm3Z412QAM4lW1F986syh7E9YlGdc3Rg1Beo5BBtNlj5cWBH/WjGV5MAfvERj98RDW1hv5i6UCKLSd1izhfNQWN9HGHXcYUdlJqpnz7ZPPr+gwUwuzfjue9P0xgI4ll+pnQedPv71SNFAnPgHmAMcTYN5eKxntfKKL/uJx434GMNiraZ+PdsoyOu+iDc/fdyFs4cO2FJXTytmCr0kByAi+9E1V7FpZxrEuPYerhvuW+reg5olOObvUiby7pUtxVEjRXJ567v3dA4w9aCWZZ5KFOG6Rxf68oac24r0+uBNmFj+73wW2d/uALoDIiK2kmIwZE7ivhJN69Cu1Kz6VfuJUfuq1posyx/aC7RLdL37wmjBNHo+EG9BGuTiO0/Qhmh3RgyjyPwL+yfp7VFUIFVzDHXQ698f5bgTCWqhfs3l9e25KO2AIHzebCkslRq6vFmXe32YV511dMFg1qUkaBd6AIt/L9oUhd0nl6hFcNVWQDZxsU0TnuS0PfUBF4pc32t6i9KsdY5yOZT6r0vS7eK+oRZUsglMcog7wpc7m9ShOr8PN8j3Cq0TY47ft0fqNAF2emderdawe7FSHbqQln2SvOcubV1MGBrPD5HQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(336012)(36756003)(426003)(83380400001)(47076005)(82740400003)(356005)(40460700003)(36860700001)(7636003)(70206006)(8676002)(26005)(4326008)(8936002)(70586007)(41300700001)(107886003)(7696005)(86362001)(6666004)(2906002)(5660300002)(54906003)(1076003)(82310400005)(186003)(316002)(40480700001)(478600001)(2616005)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 12:57:05.3827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f93da4f4-820e-4acd-dd0d-08daa150f1ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new SoC data structure for Tegra234 platforms.
Additional features, tap value configurations are added/
updated for Tegra234 platform hence separate Tegra194 and
Tegra234 SoC data.

Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2d2d8260c681..a6c5bbae77b4 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1556,7 +1556,21 @@ static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
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

