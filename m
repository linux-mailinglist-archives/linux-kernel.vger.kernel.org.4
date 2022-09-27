Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E85EBF48
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiI0KKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiI0KKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:10:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693DA7FE40;
        Tue, 27 Sep 2022 03:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdSNypO9xU1mKq0mqEids3QhlO/76ZU+GthmTD2FrVzSh3nvFiXo+dzZULx9oftnwGApbTLpNUThmM+ZrzzaTwmm7YvaXY5ttGD+JHIAC0QL6Bb9iNYBl5cm9FDyFgDUKf3p1uiR0fFLfOJ5cOLJ8SnWTCsovuR8y07cHTwGMsUew6dmIA0/khb8Db7d0thwn/hNi45gOnim64ndFmIhO/Jr4yzd1hSxcWS1I67t0GySa9MtBKsXJfXm0K1I6xP2TDSwKcdHjw0Fmxkqig9yvLZvcUiOm1vrwmpPO4OBQHijAN8uLaVzYDRO+qq+9xUNyABE5ON7GWG/G5RIObgqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ipct4Y5NPT73PyqKyxCHVgVKzJR75k/mMXi2vpHdDCU=;
 b=kAGC3lLs78MphZJsrp4U/IduXsbc0Cy42i6Rq7k9FFIyFY+PEvwRQ/kmmb/aErz7b2k5E/YSHgPJKpstB9ZrNwk16jZ1hKwer/Eewh4PuABenuE8tIoUZ/R2M5HikKYJRWqwwBrCCV9CykOvyNbt8EZxL5jgsUsT1YiiHoJRRu0IT7hb/m9Tt3Aqp/yPOKd0CFrzMEpNRYZQwcWsz8MUM/2IM78lPyDoGQMla+Rr5VIxLKNU3SF6hU0yL6nxn5pfUCWfvaSflUNS39OxOIk98Sl6izP2hzYOFX4gISbnKXgILsmmgR6GAy11MItY5RYhJu0JbvkZScvzkPxkW3ZP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ipct4Y5NPT73PyqKyxCHVgVKzJR75k/mMXi2vpHdDCU=;
 b=feCiWLV59fzjOgW92gS+Et0e7kpjcRp/+WZK1B9gLVvqGi3aqWhz39jVDE3sWd1bJWiql1KL2aUdDw2xdW8EHq8o8nBdxdyXQoyqKwWCrtnZndh9q6faWk+JzM+ZrG9ECm/EU11Gzo8glNbeSfhj8ISbC8E+gWiXKeziYYmhP/D+Xf53Atj9pd8U5++9uOGXTKk/rfb6v8rk0ExvKjDHuUJrrIP1I/AZ+ePU9TVYW4FKFQw/Y3AyYCVTOZj6a9DHxbKMdaqHFTNcPA5svakkDxT2QpeWQi+h0BvtMeVx2M3Uyyw5S8uUc5uUpmn48QeYRXCHliwxMm+NR7Kbo/gXVQ==
Received: from BN8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:ac::32)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 10:10:07 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::13) by BN8PR07CA0019.outlook.office365.com
 (2603:10b6:408:ac::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 10:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 10:10:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 27 Sep
 2022 03:09:55 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 03:09:55 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 27 Sep 2022 03:09:51 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v4 2/4] mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Tue, 27 Sep 2022 15:39:44 +0530
Message-ID: <20220927100946.19482-2-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927100946.19482-1-pshete@nvidia.com>
References: <91f09a39-57fa-06a9-6e9e-b3e768d9e26a@intel.com>
 <20220927100946.19482-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad13750-cf9b-498b-3e0d-08daa070744f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZN9Uhfxnz95IwejIbl2+pM8i+8+l3OqMMgUzSSNUXT/GxZt98BoiKpDsU8mh+kouJoDz90QMGFtIk2rAH0EA3ywCLz7j8VAhup2xfUKcgB7DUPdVcYenD45GjkqO0+75eWZVrG0xYhrwLCM3arpkH6ub1Ka2fDxY09njeDaGO/dHl2oeRRSAURVg0VhBPzPd5OrHUM8kWbFvzFVExToZbaRUiN4/KOxKpQ7D0MTsAvZ4TFCXyc5mOtt69lRa6k6OIjQ4cFuNNAmQrYqQPU5GA2IrIR+PgBDu6THHr36hP8nkSgBO8A3zgJ2hy3GbU5nxQlJXDIR/mOnoLYrzAVNN4lc5PJZSWD8W0YDNMTlBkKCTLTc9AKLW4ClmA91JJ1liGscx93JXtSnaWz6dBmtSCWo1Q5gqOhvkU7U+PkXXiWUUyrPu4yOf1Q+ca3yJc1Jzve5YJ8YiHYV8snzkaOhyZeGZuQQN71qzy89n536QAAs6A8kkvZwszY58qb/45ZW5UH7WVBZhHIjUptaWDoq5YkhmfajhtK9vJGx2xFbu7ZwyhaSoChv6bCAmV8QV6KKkXNs9F6krLDY7yDlUaM+ZzcQ9D67TODQkl8tt9L+WhAcdh9vpzQvvW2+VSWhB/3WHWvSzPQdqXgL+tCnY2wZZhjdz0gXp6sBP00AC+LERykM+IB2C4E952O4V2dcRxbJzGWpwGc4HETj2Ay9/6PdaoJpKLR/rV3tszDisN0U3y7IW2+Z8edzcjGYY3tlZnB1iZdamObTsaen/z+8Bem5yA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(70586007)(478600001)(82310400005)(8676002)(4326008)(186003)(5660300002)(36756003)(2906002)(107886003)(356005)(70206006)(426003)(47076005)(6666004)(110136005)(54906003)(7696005)(336012)(26005)(40460700003)(316002)(1076003)(8936002)(86362001)(83380400001)(36860700001)(40480700001)(82740400003)(7636003)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 10:10:07.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad13750-cf9b-498b-3e0d-08daa070744f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
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

