Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB35EDD47
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiI1M5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiI1M5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:57:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C989322F;
        Wed, 28 Sep 2022 05:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9BKp1QE7HOhfapy7VlSC2Si0mqseXhAv9imv4wHygHvGK+uENp9DvxJV0NdANxu1ZbgoUW0Sk3108dprkNmvsdVDslpvaXCXRrcy6x96caOH6DFGpnXfVLByEDiL82SrLSfJdKnLVuIMembhqNNlCySnmAliMw495fvO6Q+Cq0XWdoiegOedvEp4lqd02CKX1OhSD/Yk0KecrG+yNvNG2XBCqGjkFAqHDlY6aXDLXWaFlaS5lZyfLLnHwsHGWMQy/l/p9Uw+lMZIFhNzdVi/6Lgbvhr1XWtVLm1Yi4cp0MBBCDbPRRVbmWbTlAwJlWuD8ttfLzCQfsEtKlsoJNJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls02iz2r2cE89DXgGb4OQ7kR/hDJcTCy4w0ll/CKdik=;
 b=hCMZyMgoZ0onEZj5F13R2ErSesUTb4DhnTWpHAoGeTHRHmYydizO/q2Zd8KKbLAs+QZbgiXcEKj6AuAUI5R7pOccxnS+ts8Ny31vQIkjrXNxrDEKvorxcLomAXl5fj71OhLtJcU2mkJvdT53qPG+ubd1mPS3eQOEplUXfLv4iEmUk1ItD4JzU/q3KfCP8PcD9w8OCXdaCH0RPXAcq28A3Nk3k4fC5B9B/5Ly8WTU+FWmKVNz28w+EL8vVVCvaIZ/H1SuOQrnG42vE011JWIOtVY14sdEgsHPtyBhQ7rYowMprP9zr0FQrCjd4p2AaGnT3lGp4TaMfCpuC7L/d16pZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls02iz2r2cE89DXgGb4OQ7kR/hDJcTCy4w0ll/CKdik=;
 b=WjVTDfpgzOZkWGWgU6rzXFH/+vJialud8MWav3FqQxt+C/MwbVAyIqEBsx/teGIUyiLFF4loMikbdex5BHkcQcxndl3Z5ABUCE9l5n0NEbfavj8uAvZxCAHyU8HqGqnjp9GqhKnQInmmylXjrw5QOGx2M6aGgHrorg5aPXAJhtjiPHHv2hD9w6g8oHCKAOwEQrSFEP59T4ALx9S3sK8Vo2kOz8eiz+WHjB9UCYppR/43Vm4dHdwu8svyeD/zF/KqnxEJG79Olf23+IshkD2kyVodsDygo7nlleiAczT/mjwN2QvOGRdhc+ubtZD58WmbjgN52ikf0FTLjCzE5Fdwew==
Received: from MW4PR04CA0238.namprd04.prod.outlook.com (2603:10b6:303:87::33)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Wed, 28 Sep
 2022 12:57:11 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::39) by MW4PR04CA0238.outlook.office365.com
 (2603:10b6:303:87::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 12:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 12:57:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 05:56:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 05:56:56 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 28 Sep 2022 05:56:53 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v6 2/4] mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Wed, 28 Sep 2022 18:26:46 +0530
Message-ID: <20220928125648.19636-2-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220928125648.19636-1-pshete@nvidia.com>
References: <a5c231e8-f28a-e692-5961-58e6838711ed@intel.com>
 <20220928125648.19636-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: ae831d81-46e1-45aa-be44-08daa150f4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dv7+UhQ7a82e9rEtDsbKlarUG/D6+/MED8i98uC+G477m5h/Xb8f52wlH0yyZOl5QuAPbRGFBm/fRWMLZlAThJ0XudeEeKvVsWFCrvSJKLRP39pBnsALqX2m8tE1IjfWqTf3jGdw6dAONomWa7Ft3NNdntoYrhYtLi9qSH9pdcv6mE5H2sqljQ8Sh++AXuK0KNHKvA3m90oVM9+NmWAVIjoiEvhu1pPbq9T8Hmb5sjO0MWiB18qHzENOsHDcOGmDIXBf/ESRZxQilN2NUeEzbyOEOjeH+sHNxi3z3we/KFS0D8pF1CGvwf/J/rJuVm0SkP+znIWPfDaNCjrXBcOXll8Am09Trm2HL1DR4Vxpytp4FxC0PKzOJSyFCgVBtUTCIumIUKfWdo1URUrOoZbetq3kA90x3pnb1iSp0YXmRonjbEg8rIqHRLc5ReF9IILQbn2jYiWkNbvnRQjBWd2UGGsfHvZhitxzO8taq8R1ZvjJ85qB0rQFXbP1T5yT39TNoR9Ts+7dZ3rUk/KcPQbZOntGcnkFlOPNnB119FAt4qSbOre0OJPAoWDmITGwn4ovYepBaSDZJ6qwaWzter7+9rfgkVNtDBjDHl4GuBLXT3Cp5oBDHOvsdfPFPbokog4o00oziyNb/tORryaV4a9GAWZN5Pv7u/5SsL+LzOh7gvT+1lJMAvRl7ZfkVJuPitRs41ui1+mRSJUvCgJuudeNschJKpVWGYLZNZkt9OnNrTPxHKGxHkNQNV2yfO7aUxGzMD9na0MZNsdTrGocKPuPZQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(26005)(2906002)(6666004)(478600001)(7696005)(40460700003)(107886003)(8936002)(70206006)(70586007)(4326008)(8676002)(36756003)(41300700001)(82740400003)(5660300002)(186003)(336012)(2616005)(426003)(83380400001)(1076003)(356005)(82310400005)(7636003)(47076005)(40480700001)(36860700001)(86362001)(54906003)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 12:57:10.3823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae831d81-46e1-45aa-be44-08daa150f4e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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
 drivers/mmc/host/sdhci-tegra.c | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a6c5bbae77b4..60ce3e80f248 100644
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
@@ -1871,6 +1905,16 @@ static int sdhci_tegra_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Re-program MC streamID for DMA transfers */
+#ifdef CONFIG_IOMMU_API
+	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
+		tegra_sdhci_writel(host, tegra_host->streamid |
+					FIELD_PREP(GENMASK(15, 8),
+					tegra_host->streamid),
+					SDHCI_TEGRA_CIF2AXI_CTRL_0);
+	}
+#endif
+
 	ret = sdhci_resume_host(host);
 	if (ret)
 		goto disable_clk;
-- 
2.17.1

