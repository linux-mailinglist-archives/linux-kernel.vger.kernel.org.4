Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950955F6751
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJFNHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiJFNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:07:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A35A6C01;
        Thu,  6 Oct 2022 06:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqhVs+2S4yPTjdRbpsBl7O70D8TAVvyeiEDvNjy9At8KP3A7NWJlYxHFqZMizQzqiNrrxPxrX82MWuoMXCjm+wMYJMo2bYy3UtgHTpQTOVqYOiu6+nc35m4nPIGGKd7petmEeaaJatoSv8cMB0g1UuPMxtuTtBfoeF/+eX2+ggQimDjy0ygDuVYc25Pyq0d7sO1/CFbifV9Kds6CyiF6Z67mPv+IxR2xv6YgwljlmeW5Aoq8i181lejT4+UiXtN9qll0aaxR2hDHA6N5LHV4DLbigLlr2k7X4AU2nxnzENOo3H1onL1mC1kwVdbHFGcOJUhL7GytS6PwsMXLkiKQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L+zg0QWeFm5RjDStDHR5gmMU6hfJIeReAVxjsHgq4U=;
 b=lLqNE3Jn4UKcTy6TDx7u0p5X3ObMGe/mw7aZlrnSf2KJrkDsb8Zt/TVaE91qSAHshg9+rfPPQlVbfcdQG7FjM8JA05eJ49ggBZG4Wh1H9IBnF3Ubo2KM4U8/mXbYf9gFRlG68Ez2F4apDUPcgMxQJo188UGLm2R81UoAlwiokKKfKzyDo5hF0F/gZvanmQ4OzrbEQbgozrjcxNAPBggHg1UDGFto2h9VqaK7fiIHXf3ige7nxygdNj3cZ9MqpHhz4VQMresxpv86QLRmkqsyQbS2tbowOOM5bwIGg9TfsZygXMzoP+kX5aRYMbZh9jG1qwsIBjdW4SNAVxYX1lihUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L+zg0QWeFm5RjDStDHR5gmMU6hfJIeReAVxjsHgq4U=;
 b=qQhzM5CNVUsLZK+G89Dj94kP4ThE0i3hyQUtqViCltT4ixwLZNEvxHBjg8olKDN5xOmxsys3VgPXnEvzF1f0L0jiVIxIevphPzrkbBDOzuJuxtULuRM4AUm61UklCYJb+dwAUewrUJuzKp2HzcNoS7X152nmQ0LwKRjVzz/uRNQ3o7My9w3CMUy9LzjoHQHutZPgkPF6Asf4qNdfSGktwQ8Tl9vP4Er5RbsRYBgTXFazMlYIkst8W+DS4XG+zMl6fz0FY70lBAPS2xuOMVWubtOigDk/ppHhOmaSuRHoYlFy4O2sB5TEz5mGvDjrs6Ou3movdAlETKs7sFQwWu+hJw==
Received: from BN8PR12CA0027.namprd12.prod.outlook.com (2603:10b6:408:60::40)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 13:06:58 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::42) by BN8PR12CA0027.outlook.office365.com
 (2603:10b6:408:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 13:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 13:06:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 06:06:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 06:06:32 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 6 Oct 2022 06:06:29 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v7 2/4] mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Thu, 6 Oct 2022 18:36:20 +0530
Message-ID: <20221006130622.22900-2-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006130622.22900-1-pshete@nvidia.com>
References: <Yz6zfrVq9cP/wrJb@orome>
 <20221006130622.22900-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0ff919-d1ca-43eb-d9e0-08daa79ba6c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdPTKAaTz20q2IWFkLC4LLV+jZmLvCD2XeGBSMEwRAN+wwe3vXj1A5xsFNvQQ1On4JZ4dnYvGkmbEroUjYfSC03LLbUwS7MMyn5Kr7ef+08GzXf39FdZSwekRA93ombSROB1twyQu7+jmeNjcwykAe/6YJdau0xjYh6HLIbk1uaMdMvwSp56jmPlgbs1F4aMpJhf50Zym3+p7ZnS1joyLhX3fEF8qoLUeXfw/YSL4g+3Tyo/ZiGRECYAC6Nt3v8Iee/ySJ5ft4ERd/AdA+FKSepAh8ik32FgJxdWGbMFCDn0KKJ1D3y3h8WqO830agmim16M5vqxly7GMkcE+y/yBhFVNkz5fXNdRvbwTnfZFstKyLA1JyKWDUoUiELkBIEwXqoyE5SwepMfMaPVZkKSNrig0MbYYvR2P3qEWo8eBDSkl3o1BYTIUf7sdutVKQCOGODL8IGS2aODO/rG6PJaSh7kVnZFEiEJ2DqC+16vRmtHSko1Hst4ayup3oHqgruPoksdbJZ4Vq52AnzFKna0v9boZFnzYIAB9OuivLK5KuzK2bqmZbOfQ8dACRMp2X3o7QE9K/ot192UooCuENahFdlQ4MaKvP2xk65zhpFzro3Q3M5QvDioorF7ikBLqYlZBqqHpGU3CBjSzet8Ux4u3uSuQTBIDCoqXR8NZ77G7PpjDSs4fAC+uShn8XhvSsnhPDZm7N9zWWr4iQwqOwZuucEU0mrVQ8MF0f6vAx/SDTZjoLZ9PzxUW9hcowXiJaFRkR1GyznXo9OxBMoZqa7ADg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(1076003)(186003)(2616005)(356005)(2906002)(82310400005)(316002)(70206006)(6666004)(107886003)(54906003)(70586007)(40460700003)(4326008)(110136005)(8676002)(86362001)(478600001)(41300700001)(5660300002)(26005)(336012)(426003)(7696005)(7636003)(8936002)(40480700001)(36756003)(47076005)(82740400003)(83380400001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 13:06:58.4421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0ff919-d1ca-43eb-d9e0-08daa79ba6c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/mmc/host/sdhci-tegra.c | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a6c5bbae77b4..e88294a6912d 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -25,6 +25,10 @@
 #include <linux/mmc/slot-gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/ktime.h>
+#ifdef CONFIG_IOMMU_API
+#include <linux/iommu.h>
+#include <linux/bitops.h>
+#endif
 
 #include <soc/tegra/common.h>
 
@@ -94,6 +98,8 @@
 #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
 #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
 
+#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
+
 #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
 #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
@@ -121,6 +127,7 @@
 #define NVQUIRK_HAS_TMCLK				BIT(10)
 
 #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
+#define NVQUIRK_PROGRAM_STREAMID			BIT(12)
 
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
@@ -177,6 +184,9 @@ struct sdhci_tegra {
 	bool enable_hwcq;
 	unsigned long curr_clk_rate;
 	u8 tuned_tap_delay;
+#ifdef CONFIG_IOMMU_API
+	u32 streamid;
+#endif
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -1564,6 +1574,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_PROGRAM_STREAMID |
 		    NVQUIRK_HAS_TMCLK,
 	.min_tap_delay = 95,
 	.max_tap_delay = 111,
@@ -1775,6 +1786,25 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_add_host;
 
+	/* Program MC streamID for DMA transfers */
+#ifdef CONFIG_IOMMU_API
+	if (soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
+		struct iommu_fwspec *fwspec;
+
+		fwspec = dev_iommu_fwspec_get(&pdev->dev);
+		if (fwspec == NULL) {
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
+#endif
+
 	return 0;
 
 err_add_host:
@@ -1861,6 +1891,10 @@ static int sdhci_tegra_suspend(struct device *dev)
 static int sdhci_tegra_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+#ifdef CONFIG_IOMMU_API
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+#endif
 	int ret;
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, false);
@@ -1871,6 +1905,25 @@ static int sdhci_tegra_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Re-program MC streamID for DMA transfers */
+#ifdef CONFIG_IOMMU_API
+	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
+		struct iommu_fwspec *fwspec;
+
+		fwspec = dev_iommu_fwspec_get(dev);
+		if (fwspec == NULL) {
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
+#endif
+
 	ret = sdhci_resume_host(host);
 	if (ret)
 		goto disable_clk;
-- 
2.17.1

