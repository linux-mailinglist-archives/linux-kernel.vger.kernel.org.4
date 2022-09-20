Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16A25BE60A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiITMi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiITMim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:38:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5016BD42;
        Tue, 20 Sep 2022 05:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEkQ4PCLJWR8sRGTUpUPdRV/+SuyTifBuqUf6Fao2G6uyJRlV+kWeAig7jzliuTCN0fr29RXvkOT9/gEZXXjfg0++FPDBrnwjACGYwVA5ZbpuHKbnexdPkRjZsmVVr3ufWWeDWPugGrGqmg/STm/+mqPC+gQuh9DnZvg/qgE8RNEMZrz7hS54266JEUP4jFN2IDSoeEh9ykKodlWmJEOi3swrtnhgN8Qqp094/nDYmwrdgxxBfNeZsDWViUfwQN2RyKHBzOD23Y9GozGGv7hl1RDqQt2jAlrODTk4g4oqJvcMUCoRDp0o3aYg769jyc6GU0AY+UV/aUl4Mfg8dDWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+NpXzTkwuFbgmA+L1IHzsiZPSnfF0Q3uYE+MZUe/m0=;
 b=bqCd/J5ap23n6I1fybPnSBCBSzunbkrtbOqFUzmmVF/mUtZfshzNDdFpesOFRTcOqELBwOh9k/8tHZJjNazg2O9f38B+anI1fFCtUovsBdn9+KoahP0rBQBbZfK25ASz9qpz9+zgi9cMzeH7GAHT7tMt6M44PfhbXobj7OeALLimAwm+jiF0kJqOJsSO6egtydc9zOvRTF0o3rGDh9W5R8Ce/cGcvWFbwNcgAcUrt1D5VpEGvl94iEgb621aSkXTxnD0XH/i+vVe2byHdB75OHKgfCIQ22OEX1uc0it6Co99MD9mE+qsNrifrBpfSyKepMEFgqm0Y7cIyHJ+kmSemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+NpXzTkwuFbgmA+L1IHzsiZPSnfF0Q3uYE+MZUe/m0=;
 b=ertJj6LTIfWgjBLLPhzf27TPpvI0YXhCUqJPcw236NigMwbAciFyP8w8fCjUyN/X2Bq40DsmfSNP0Kb6eJKHaxUhPunET56SL6n5CchV3LjzLQ6gjgJdTXhc07UarjtEVyA2vx6MhOOe357dnpPKKj8At6/bbu+S8qrzfmVvcpmzmReyYI31yR03SlEk5NNaJap3r9HZxwxZV4MmJXmfZaTaEOBBcdsfGqjJqmklUY0JOQfVw193lHT091+n8vl1/2ehLaMXX253kS0R78qKDstVGV6LQozmfRlignsn4alZ4DrqcTmRrpUW6UZpSvJ2MsaZkvFV1ncSio+xk7JWww==
Received: from SJ0PR13CA0112.namprd13.prod.outlook.com (2603:10b6:a03:2c5::27)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 12:38:40 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a8) by SJ0PR13CA0112.outlook.office365.com
 (2603:10b6:a03:2c5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 12:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Tue, 20 Sep 2022 12:38:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 20 Sep
 2022 05:38:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 05:38:01 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 20 Sep 2022 05:37:58 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v3 2/4]  mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Tue, 20 Sep 2022 18:07:50 +0530
Message-ID: <20220920123752.21027-2-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920123752.21027-1-pshete@nvidia.com>
References: <20220920123752.21027-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ea4991-6099-42fc-2f3c-08da9b050af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ya4F77tp+9AK0BcKpZ+cogUZO9O4G5Ktajzg0EN0q2H31BWfDSkwo4vacdc/gTKtzkDwOD0y8AsGMl6N0Zfn+cBFH45QM55Pd66hOF+LRY2e8Chq5hHJCzL4Xr6hoc1PgocZA+6nWUhN7AJTADa1LEv/qXpEzbgwdlX8aFY1x/juo87jy4Wi48FtSoajj1MDAC7xf5aTuaPTsveBTVxbp+XiK4fx6wKmRCNn6B353Y1RT8gf+DNmUyQS0nE6EEwUwSUZnfeUQZvSzqufUAld/BItWjX56QgswgNALIgFbPn+lVLWnTAtkVm4j416ei3PgGFky9OJbtEnkoAwC/OaYg9wuFzwR5cspsla7AgJ63m6aZJxiljlMwcMYmw5JOLYFPDmSpp2nK4rrlTKOXhnygZx/KS8ZSZMbbsSD98rXxWP5ExDVL6Y2vd5IN+aBuZvgsCguM0yhBcm4V78Uf7TDHfSJ1ECUhUKPeEWRcqCxGw2HC48czAkOuS4Vdg8QFIv5r9lgq3iOZVIpfIybnNYDt/ONX69FKpuEJf8lys6DzEO9RbW80ePPzk3AI7lniZBoNCMxLcXD6XFYSjaPXd102vnnbRywFtElwvs7bGfHhgoCAPBds56s0F04AItQYlVjZHyN90LydCXM3F2yOLQXbIy6B8FjoITUREyikWne5WorfBfcxCwIqWHaGFDE8npdWq6qKrsdJ12NK1W77AvB077mRso4qu4c09WvBTID+Yjmq2Jzpfn6OyC6ld4rwXmzYAZCHMvmIv0KwxAfmry7g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(8676002)(82310400005)(36860700001)(82740400003)(40460700003)(356005)(36756003)(86362001)(2906002)(5660300002)(478600001)(7636003)(70206006)(40480700001)(4326008)(70586007)(8936002)(47076005)(54906003)(316002)(110136005)(186003)(1076003)(83380400001)(336012)(41300700001)(6666004)(107886003)(2616005)(7696005)(26005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 12:38:38.6260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ea4991-6099-42fc-2f3c-08da9b050af3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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
+#include <linux/iommu.h>
 
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
+	u32 streamid;
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
+	struct iommu_fwspec *fwspec;
 	struct clk *clk;
 	int rc;
 
@@ -1775,6 +1784,23 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_add_host;
 
+	/* Program MC streamID for DMA transfers */
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
+
 	return 0;
 
 err_add_host:
@@ -1861,6 +1887,8 @@ static int sdhci_tegra_suspend(struct device *dev)
 static int sdhci_tegra_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, false);
@@ -1871,6 +1899,13 @@ static int sdhci_tegra_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Re-program MC streamID for DMA transfers */
+	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
+		tegra_sdhci_writel(host, tegra_host->streamid |
+					(tegra_host->streamid << 8),
+					SDHCI_TEGRA_CIF2AXI_CTRL_0);
+	}
+
 	ret = sdhci_resume_host(host);
 	if (ret)
 		goto disable_clk;
-- 
2.17.1

