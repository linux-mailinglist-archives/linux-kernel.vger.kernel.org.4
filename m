Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A9261122F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiJ1NDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJ1NDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:03:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D751757A6;
        Fri, 28 Oct 2022 06:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpW38cympu6bTq5myi5gtwX83Saz1ABWToQcHuNOGXPazXSK0ch4v3PIiUIwLDX0Hc03s4LUUj4YBUGHJNHLYyUB/vMYASX05TgjR4XIfyMCihDRRcfM5R93vPKQ6FVnn9xOz6371NaR1GDS9wVobuhUfxrp2hf9EHgWErkQK9QQX3BI9aoSQsKxbcVtRrUsSpOM+1NHqDLD3b0pJ6p+VQqXjOdoHuQ92vS1hvLVT1DXZ9nqFOTVMr1182u7UoD3CpyKZRRLjl33j8wwAXIPtq8CJGjzJQPx9KEck3vM8qjYzy+CYFvUfWGUiosBwVcXHxAIFadjt6DPbu0pfS8L5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/XpF/6nLbeyAOMH+4J1F6F02x2732Gn1BUA6g00/JQ=;
 b=PaLm1Y092EWj0NEXv61SQcUzVeNTqvlOAY1KXknF2nYeJkhfbG0p2z5v68awQ/5eKMo0lRjmAnf2BkjacYFGcBIwM/bpxQdN3TC5/Ab8I5v9NnnEArpP6FZgoLw0GHgxuyVuooDUHgeg4rFwQQLU4OjV8xcdbwZpzgiXJahmTOQXPUC/jUrO21fdu0xwBIgNkzvqrz566rVQpJXFKHapaY04szN9W5n9OF6QCTTWtpIFH315xslS2PnLujfz3eGEIUPClIuOWBqMzbxVqlP2DD4sbXHD+bJWRrbKC7NecCuBbP/QtQREqZjFlQ0Lzhl+gd0T8ZFqP1A56AFulpVdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/XpF/6nLbeyAOMH+4J1F6F02x2732Gn1BUA6g00/JQ=;
 b=rHliPcs0GwfsVQWHnAk/UuTKTmF+/lMPPAyuUC6A36OBzKqAcPTaNaKD1iLiBTvEj6LZdDffBn78Mc5XXMsEaR2PHAet1Y351M8y+riWVSB+MIxUEl83jqDPwgn9wxo3l5KPh75d5qSku1r4G1B/KKr3WtXBfktQsBC2jG/YtvrEzFdoSyLScA1dyFvUAS0z351xdU8KzJns0NwNdxsOvtoP41xRBt/pN4Y/Apbj4HzbJagGMphsJT79vMS1LyTspAcT3fAOPMT1AVeIJhLb8vJNtoMmqAlHto3qCJd6SLC1G225ZYtiQ7aPs+wsqpujpLNFp8yLWZC0IxCfrg+pow==
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 13:03:08 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::17) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 13:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 13:03:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 28 Oct
 2022 06:03:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 28 Oct 2022 06:03:00 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 28 Oct 2022 06:02:56 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <joro@8bytes.org>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
        <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v9 3/4] mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Fri, 28 Oct 2022 18:32:41 +0530
Message-ID: <20221028130242.20900-3-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028130242.20900-1-pshete@nvidia.com>
References: <CAPDyKFpG9ZjVTiK3HEqioDN8ksGpRYiXL_SLSmOfm9fjJfcrsw@mail.gmail.com>
 <20221028130242.20900-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: e76e6100-9a7c-4fe0-51e1-08dab8e4c2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fy2cBmYw+7jdoNdz9u8vf0yt0Krxrv4h6yL9LpPzY6E4LmEM8opIRG/6CcokAFQKKt9ewXedSZSGsAZCHUaWTOVnN9UmM44Wl/O/o4HvIVggPQWzNWvwIITQ1dCUhK0y5HRL6rsj7s3TlOBjmJiVQooa/xDiPDRVnPRH+vD8XdZW3cTK3YnI2KZXdRgD1CYSkr5gyeNC2/GYfah4g1ixzJi3mUwFaNS5ai4PGwFk3FwpEwJhj+WVdzCCvddHVaoFcG7FVfzlv9Y7sCcf7ryFu5xnPShrPfWmnAsY6v8vpxovz9ns53VyT6hcIggoNyD0KdAe1AnTAh2/aaQ9+Uk9WaHyQbFWUZBzeCvyFBx0BE9DVrD6ZoLR88zbYPzCbTzZDlRjdF1hJI5EVYjtycPHWsrkGkox95eI+o6f6DaKjqm+ACtSI3WtfIvO8V7AnFuDK/wpiWhOo74P3Lz8+4th56wSPUxkXG0/px9SpQGwTAX/IJO18s6ao/s0I8yFF+mKecx75qOo5PaV+4Kk8jTgy39qghMQgkrnnnbgZqbp8KNm006F4GSNzy00zYPIHtkIC0t9gsQhUisChueuvnW1eyopG4evWKCQ/FX+l3iBF83aNNKYPeD40wqx9nSHDNh0MoBN0IrDfSippUkIxnhagOAp6cu7mZHVXUOpjbO9SctU5KT02j9UddK2Qh+25aLufZFyK0J29xVfh99ck/3GHRgE81h9lzolH45jqX1l9NAMuQ14KczSbpIQXfBMBPB3PQ5Rc2sDnn+59Gh3SgIG/g==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(5660300002)(478600001)(86362001)(7416002)(41300700001)(70206006)(40460700003)(70586007)(8676002)(82740400003)(7636003)(356005)(8936002)(36756003)(40480700001)(110136005)(316002)(4326008)(336012)(2616005)(1076003)(426003)(186003)(2906002)(82310400005)(47076005)(7696005)(36860700001)(107886003)(26005)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 13:03:08.2649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e76e6100-9a7c-4fe0-51e1-08dab8e4c2a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMMU clients are supposed to program stream ID from
their respective address spaces instead of MC override.
Define NVQUIRK_PROGRAM_STREAMID and use it to program
SMMU stream ID from the SDMMC client address space.

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a6c5bbae77b4..e44060cceb68 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -25,6 +25,8 @@
 #include <linux/mmc/slot-gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/ktime.h>
+#include <linux/iommu.h>
+#include <linux/bitops.h>
 
 #include <soc/tegra/common.h>
 
@@ -94,6 +96,8 @@
 #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
 #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
 
+#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
+
 #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
 #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
@@ -121,6 +125,7 @@
 #define NVQUIRK_HAS_TMCLK				BIT(10)
 
 #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
+#define NVQUIRK_PROGRAM_STREAMID			BIT(12)
 
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
@@ -177,6 +182,7 @@ struct sdhci_tegra {
 	bool enable_hwcq;
 	unsigned long curr_clk_rate;
 	u8 tuned_tap_delay;
+	u32 streamid;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -1564,6 +1570,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_PROGRAM_STREAMID |
 		    NVQUIRK_HAS_TMCLK,
 	.min_tap_delay = 95,
 	.max_tap_delay = 111,
@@ -1630,6 +1637,29 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 	return ret;
 }
 
+/* Program MC streamID for DMA transfers */
+static void program_stream_id(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	struct iommu_fwspec *fwspec;
+
+	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
+		fwspec = dev_iommu_fwspec_get(dev);
+		if (!fwspec) {
+			dev_warn(mmc_dev(host->mmc),
+				"iommu fwspec is NULL, continue without stream ID\n");
+		} else {
+			tegra_host->streamid = fwspec->ids[0] & 0xff;
+			tegra_sdhci_writel(host, tegra_host->streamid |
+						FIELD_PREP(GENMASK(15, 8),
+						tegra_host->streamid),
+						SDHCI_TEGRA_CIF2AXI_CTRL_0);
+		}
+	}
+}
+
 static int sdhci_tegra_probe(struct platform_device *pdev)
 {
 	const struct sdhci_tegra_soc_data *soc_data;
@@ -1775,6 +1805,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_add_host;
 
+	program_stream_id(&pdev->dev);
+
 	return 0;
 
 err_add_host:
@@ -1871,6 +1903,8 @@ static int sdhci_tegra_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	program_stream_id(dev);
+
 	ret = sdhci_resume_host(host);
 	if (ret)
 		goto disable_clk;
-- 
2.17.1

