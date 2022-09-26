Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116F75E9E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiIZJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiIZJto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:49:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753A7A199;
        Mon, 26 Sep 2022 02:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGAAuQeuscA+CJY0RPlQ4DboLLPaDKOpZQKc6i/R7kam2X9crgCkez/thV5lb8HBpdXvacokZDUN7DdeBUAuVsYvCrLK1vGEu0+PNzX+sbqYJphvDdqqVXrLl50d6gc1u7/lScHE8U4/Fmv31Z6GkxOr1mJBcCZAHjaJR9DCJbDsrx40N7luoULzz7sMpIekAwEymRyjiWsVrZUPXVBNKAIP2UrWoe3cKZYJlGGoOdrypC6Ay88UjPg92AZ+RP/d1MQkiKgidbP6jCfnXwMqmNvutAqjgWK6DmQF+yAd0M8ErwMxtlRppKy8AvQFqlQO3UHf/ZsSI497TASpYgeXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhHAL+70hJplfLlj8VQ+lhmIH2wLteZXVHCZJvQaCbs=;
 b=PYVnRyAHEaiFirEhVmZOCnEvqTXWZzaPQ//tYqKeUICcPRd8SvEzUenqgxqb0JUszgmSJ8fxXSMrnlte8iWBfPaKWBLCJp+ng/XUTVOWsh2vwiNF/rIFA2syn3IaPsyNK1471S9hX1e5LxloOw1h5Mfir20eU/xop7ZjiskGhdHj2bGKhV0Rm04PY9aLgPXi0lDw0qFI/iqm4mBgp8jX25h5PSOLJlJYB2PDxFSwR8j++unaV+yeBUOXj8V/QLFJelNOjIL1gLktMnoAOJW3IHx0WJd938RjpsAJ5sJB8NsKjo07wNBC0/MZllZpeM0EkCtMgMD4MgsSF/J9nLqWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhHAL+70hJplfLlj8VQ+lhmIH2wLteZXVHCZJvQaCbs=;
 b=tH9BJZB2Qr9HXraHQ0DOX4utX+TBEBx+8lawruH/mPayJO0y4+jvDuVSNpnnLEHnz2YG5oXXD9oRFK6Je5sEKM/du3d4Gre2KzrMNbw7n8RSvtBxCXg8nwtUtmcyJZpz2BxDr/z4lrmNjWKtfHri4/5y9AiP2NBQPZj2+beGGCAN0MbdszhJQppgrTIbL5kIitNpnyy6IkT+GRLJUWEPOUb8ymQgfi3Ah9rMsZqZlkn6obKLOQd2zUO8I4L/gBR8ay4sd5/4j0BNW2j7yiRxv4HegAvlfSltTRvJgCLaODB3gTXe/KaQI+6zAXGKviwazOUreTGD/cRXk9ENeWQzDg==
Received: from BN8PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:60::39)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 09:49:40 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::92) by BN8PR12CA0026.outlook.office365.com
 (2603:10b6:408:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 09:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 09:49:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 02:49:26 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 02:49:26 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 02:49:22 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v3 2/4]  mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Mon, 26 Sep 2022 15:19:04 +0530
Message-ID: <20220926094906.14537-2-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926094906.14537-1-pshete@nvidia.com>
References: <20220926094906.14537-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 514d7b8c-f899-4932-cda7-08da9fa46eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgOq+8hHww5NKd3A9seCDz9F/p0GTYKhzqsIufgoPzE8SOqoOKSnpgHmRKgPh6cFDHjTUi6D7v8VkmE+EB6hOICoSyspOMXhIu8+WSRS1D46V5/TRneqPH7g0kCvIbkq9eszUC/M6qlGO6UfXoqAFMGAlFHlCz86TEG1agBREsOXvZ2aVluDzi7+jue9hClnIoji/ivi4nQS0D1y0Vcf3G2VNe59CJeSrSMJ9DMKtS6qurozGWpwPClnZrhqS06shv1EcFk4eAGx80pxT2de7Qei3E3C6uyocwgFIXBQMlspRmKxHH8SfpnzU4XdByjds1DZVrRBnSbCT+yzcVCDUH0VaB62aYVmMkFyi5otqZROxAyk0XCtHilTQipfBaLHTMTAajFymWSWCRhmXcLMZI57AITah3I0rOtITuSaDZ6gjQBpGR6Uwy+EceDbKBSW4ehLY++KlEEPCzdLRx22yEk5L+QY8C+Ow2IXVNURoyYkaWRFMn42gtsykBkhClZWQXFO0IIN2UO0+Gn5ivmKzyZl71qFbQ1SdGbPTSktToCZmFmrh5T2CE6i/5SjaFxSQxpJZ2xro6e9UuO3m2viqaFBY+9cYf1HEhV5cRVOGb9whkCG/cG6PiFlXq+eifFciykHHwC8ELxDCRhC0b4HKoEoZoFomzuNor4szzi1Rz39Na7ZJA+kIQ+IGwUh/ciWjkohdivgAQkBkcT7WO8J+QNd5VKGl52onme2CEoCSij/YlRZA2bg6wCy7EjuGVFqopadAHS12P/+l+C7bT/bKQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(26005)(8936002)(7696005)(107886003)(6666004)(83380400001)(41300700001)(40460700003)(82740400003)(36860700001)(2616005)(186003)(36756003)(1076003)(2906002)(7636003)(336012)(426003)(82310400005)(47076005)(356005)(54906003)(110136005)(40480700001)(70206006)(8676002)(4326008)(86362001)(70586007)(316002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:49:40.4717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 514d7b8c-f899-4932-cda7-08da9fa46eae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/mmc/host/sdhci-tegra.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a6c5bbae77b4..4d32b5bfc424 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -25,6 +25,7 @@
 #include <linux/mmc/slot-gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/ktime.h>
+#ifdef CONFIG_IOMMU_API
+#include <linux/iommu.h>
+#endif
 
 #include <soc/tegra/common.h>
 
@@ -94,6 +95,8 @@
 #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
 #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
 
+#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
+
 #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
 #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
@@ -121,6 +124,7 @@
 #define NVQUIRK_HAS_TMCLK				BIT(10)
 
 #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
+#define NVQUIRK_PROGRAM_STREAMID			BIT(12)
 
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
@@ -128,6 +132,8 @@
 #define SDHCI_TEGRA_CQE_TRNS_MODE	(SDHCI_TRNS_MULTI | \
 					 SDHCI_TRNS_BLK_CNT_EN | \
 					 SDHCI_TRNS_DMA)
+#define SDHCI_TEGRA_STREAMID_MASK			0xff
+#define SDHCI_TEGRA_WRITE_STREAMID_SHIFT		0x8
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
@@ -177,6 +183,7 @@ struct sdhci_tegra {
 	bool enable_hwcq;
 	unsigned long curr_clk_rate;
 	u8 tuned_tap_delay;
+#ifdef CONFIG_IOMMU_API
+	u32 streamid;
+#endif
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -1564,6 +1571,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_PROGRAM_STREAMID |
 		    NVQUIRK_HAS_TMCLK,
 	.min_tap_delay = 95,
 	.max_tap_delay = 111,
@@ -1636,6 +1644,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_tegra *tegra_host;
+#ifdef CONFIG_IOMMU_API
+	struct iommu_fwspec *fwspec;
+#endif
 	struct clk *clk;
 	int rc;
 
@@ -1775,6 +1784,23 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
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
@@ -1861,6 +1887,8 @@ static int sdhci_tegra_suspend(struct device *dev)
 static int sdhci_tegra_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+#ifdef CONFIG_IOMMU_API
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+#endif
 	int ret;
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, false);
@@ -1871,6 +1899,13 @@ static int sdhci_tegra_resume(struct device *dev)
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

