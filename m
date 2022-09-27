Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1455EC0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiI0LN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiI0LNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:13:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC932A41E;
        Tue, 27 Sep 2022 04:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxDf3AMwp2tOK3vFW29NgBuS35uTp7hWznwmb9qBJHMEXsgUlJImp6esA/qzT8RV/UaUvJj2C6OaVTdaGkujSSsvtxTKoVH7AQAfiZUi3/4RQdu+3Fo90dIuTWa2ZoikPdDFONLYQ5fQdyTsMRngT3r5AZd/OGrvW3MB0A8ZoJiW1aEFt4dAm0Qc8ZHLpKd+LIVJAePUBOZKfhNbYgZV3GpC/b0UzBMNaRxP62vzuTS1oVwqNRlJbI7nGDid4YChBVyteBP1i1YO3VTIvTPmGKsEd74Oas5w+1xAlCA4NMlOuvN2p+HdFVJXSb+qyXvcJVd2fIt3fyivQNZH/nVnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ipct4Y5NPT73PyqKyxCHVgVKzJR75k/mMXi2vpHdDCU=;
 b=BYLXZhMdzUY/wYmdWNeALXNX7DXHbt2F0BYAH6OvGQjm2C2iuhS5+oU3AY4pPfSHWODSbm9kH/ViG3wJJ315rx2VHvFUD6v6pK20nc9aEjrbadM6qNhptK6BfsxLdL9gcoy0hbtohVZNm5MIlIQC9eS2qzzTqs4Rz9Dkarrwi36pw1+dXOuSc3iWXt6JlBHTIE4/7aJUhos1ohjE7t6W13xL3E2LqduITOvwYXBrq6AwXSK+q6q4Vg8PLzkB1/H4A6JWuejh3WMNZxgG5cT1lfMHnPVB9DAVaphLTUFWL2dSPvtvcHoiRnCxHQQm9lIgwTJOqgMINZPb8a4/herAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ipct4Y5NPT73PyqKyxCHVgVKzJR75k/mMXi2vpHdDCU=;
 b=EgUvNN3M1WPLICTkPxqUOOGnZH8qoHEPTcb2/dV9ekQlOWzK0VUHH7lLoMMDFknXrMLRKiEQ7tgSrh9WORr996wgghJNC0ViLchBNP8YCpVXl9P/P6+txR8WRDNanwmxQZn9cGxlhmynUlSbQwQ26y0wDbX82zxVTSp4dmXunWajstIaiMhZN6AmBmIRpKOukbADEPSCX2mgGMvNCvOtb7k14CrB0IIcpjl6v5fsP+IdPv+hOYO2LKUX7KZhTMlWjzL3+DKTP6lLJOj0j00gvfv84MqtXgKgsZgyz+tO8kOhQPoBelMn/Yo/bKcNWnEHEQl23anEv3jK4hkYcUfk+w==
Received: from MW4PR04CA0139.namprd04.prod.outlook.com (2603:10b6:303:84::24)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 11:13:37 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::a1) by MW4PR04CA0139.outlook.office365.com
 (2603:10b6:303:84::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 11:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 11:13:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 27 Sep
 2022 04:13:24 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 04:13:23 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 27 Sep 2022 04:13:20 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v5 2/3] mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Tue, 27 Sep 2022 16:43:12 +0530
Message-ID: <20220927111314.32229-2-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927111314.32229-1-pshete@nvidia.com>
References: <df68846a-2a09-ef98-6823-d536d99ccb61@intel.com>
 <20220927111314.32229-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|DM6PR12MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a22bd9-2204-4f45-2f70-08daa0795355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKbrfOTt+hIup28B7jnPbNu27uYTTJDiabbI5ibHYMIzjn6H3fq0I0nwsBTmH4c3QvoRytksgjfohZDTvPVYkyL8ERIKMLQi8dHl+E5Q+jvlVU1rv2LeZZqOTrRVYBOKQL2+pTtt3owmbLt54OxTGHDKd+yADWdri5ERqt+I9JBQhn74x4wQTXflq1eeoB/UGcQ7mb0Ldnzg43yoWD0YWJkK7jFIXnB0bQCG7sRPuiIsnl0Y6wVQJlzRq0yO3JDCUhPgkVU5Xb5BER8ta3bBcey7o5Pm8WryNaeoanSE5qU0dFk9GLLE+TusFgu6GXL5LbumSErir+UgksqYAAn8MzFOrGYNwojiCu5p7qwVtfxoATNIJJFnh7kJaC/4wxNc7AGRqu6MYHVbJdgERmiRBTSAsI7YtsUn+1B6FL28J6rtCfORUriNJKFg3Ab6TPkCxa/R/n7Hyiv9gIJ3Yuy+gm5OADRzXspYggYyZEaugmOjyfIkpwztX7fNHaFDr4cfo6wMGQ8o0PpZYhqpLWEEYndfjF8x/rGcIc19zTVTasElHNExQVOZ9lKS+Hx8JRJ4N9Mk7GvlcTZhdxpIF6Y7/lx8gkxcE/qzgQvSdPlcE/6ahbn2AnAN5/+gOoviwGr8dObqzzpWiXshUwaLV7nF/i2jK7Y2+cwUMyXNyTiHwSR5/hFe8TdfTJHkBHAzlQq0ncMew8teA4mCbaHSIxy7TdSo2yyzj2DpyZezwU939MxwJ+IZImxfReomXZWzJ6Mf2lkrPvNKWdgqW/5gF+1YOg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(26005)(5660300002)(36756003)(41300700001)(36860700001)(6666004)(2616005)(8936002)(2906002)(70586007)(4326008)(7696005)(70206006)(8676002)(107886003)(40480700001)(86362001)(82740400003)(47076005)(186003)(1076003)(336012)(7636003)(82310400005)(356005)(40460700003)(54906003)(110136005)(316002)(426003)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 11:13:37.4831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a22bd9-2204-4f45-2f70-08daa0795355
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/mmc/host/sdhci-tegra.c | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a6c5bbae77b4..46f37cc26dbb 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -25,6 +25,9 @@
 #include <linux/mmc/slot-gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/ktime.h>
+#ifdef CONFIG_IOMMU_API
+#include <linux/iommu.h>
+#endif
 
 #include <soc/tegra/common.h>
 
@@ -94,6 +97,8 @@
 #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
 #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
 
+#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
+
 #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
 #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
@@ -121,6 +126,7 @@
 #define NVQUIRK_HAS_TMCLK				BIT(10)
 
 #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
+#define NVQUIRK_PROGRAM_STREAMID			BIT(12)
 
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
@@ -128,6 +134,8 @@
 #define SDHCI_TEGRA_CQE_TRNS_MODE	(SDHCI_TRNS_MULTI | \
 					 SDHCI_TRNS_BLK_CNT_EN | \
 					 SDHCI_TRNS_DMA)
+#define SDHCI_TEGRA_STREAMID_MASK			0xff
+#define SDHCI_TEGRA_WRITE_STREAMID_SHIFT		0x8
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
@@ -177,6 +185,9 @@ struct sdhci_tegra {
 	bool enable_hwcq;
 	unsigned long curr_clk_rate;
 	u8 tuned_tap_delay;
+#ifdef CONFIG_IOMMU_API
+	u32 streamid;
+#endif
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -1564,6 +1575,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_PROGRAM_STREAMID |
 		    NVQUIRK_HAS_TMCLK,
 	.min_tap_delay = 95,
 	.max_tap_delay = 111,
@@ -1636,6 +1648,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_tegra *tegra_host;
+#ifdef CONFIG_IOMMU_API
+	struct iommu_fwspec *fwspec;
+#endif
 	struct clk *clk;
 	int rc;
 
@@ -1775,6 +1790,25 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_add_host;
 
+	/* Program MC streamID for DMA transfers */
+#ifdef CONFIG_IOMMU_API
+	if (soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
+		fwspec = dev_iommu_fwspec_get(&pdev->dev);
+		if (fwspec == NULL) {
+			dev_warn(mmc_dev(host->mmc),
+				"iommu fwspec is NULL, continue without stream ID\n");
+		} else {
+			tegra_host->streamid = fwspec->ids[0] & 0xffff;
+			tegra_sdhci_writel(host, (tegra_host->streamid &
+						SDHCI_TEGRA_STREAMID_MASK) |
+						((tegra_host->streamid <<
+						SDHCI_TEGRA_WRITE_STREAMID_SHIFT)
+						& SDHCI_TEGRA_STREAMID_MASK),
+						SDHCI_TEGRA_CIF2AXI_CTRL_0);
+		}
+	}
+#endif
+
 	return 0;
 
 err_add_host:
@@ -1861,6 +1895,10 @@ static int sdhci_tegra_suspend(struct device *dev)
 static int sdhci_tegra_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+#ifdef CONFIG_IOMMU_API
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+#endif
 	int ret;
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, false);
@@ -1871,6 +1909,15 @@ static int sdhci_tegra_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Re-program MC streamID for DMA transfers */
+#ifdef CONFIG_IOMMU_API
+	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
+		tegra_sdhci_writel(host, tegra_host->streamid |
+					(tegra_host->streamid << 8),
+					SDHCI_TEGRA_CIF2AXI_CTRL_0);
+	}
+#endif
+
 	ret = sdhci_resume_host(host);
 	if (ret)
 		goto disable_clk;
-- 
2.17.1

