Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0D56175B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKCEjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiKCEjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:39:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B58017E01;
        Wed,  2 Nov 2022 21:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEG0UPCxIU/yTF5fTW9Jcaw3Bhu1ukfz3Hxte4+UPl2QVSDdAWWH+UrsviaVx3UIrZZbHfv2QcFHLca7CzUC4IhHv3ncX0p+g+aZo9PV5vZQ8WYYYqqb2AtV1rC58J709o/MlfyE6Ki7mLQpnyqEmM04L+IZRlbM8SqoAXviZnUbsFglqg+FKcuDlTNWKCWdGHGFeqcz5PncwwJTa2Ua5fNLpmrmvVCza/DAu4+YfUcyHC5WgoFn5lEMU1tKMOabU7bky1ta6Q9niAhTx9vFoFHynDXeBDv0hJb0EDfR+rml63IeLhm/zsLCzK9fRptozjDY2booDXMOg915KBADxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/XpF/6nLbeyAOMH+4J1F6F02x2732Gn1BUA6g00/JQ=;
 b=MBFpkzkrDaRps7cXlGYmnKpdbcNnOOq2QB4sdEeLZevoamX0klu0U+mXHoZXH2TfZeV2Qfq60XsHVAlCi6q1vGZdWOganuJDhtP9xQfIiLJmusawLZuOLLATiId6OkGvju5uBapXkhHMwbS4UjHnoCXutwMf1LKCfwZbJvHwP3JPlkFpBFtEprvxK4YSLI58HYPSfTt5LRbLjjYX85R0C5Lc0z4SsrjM6XVhtubfuT4PTIfNs/JM76d58Um95/ipPv5Plh9jftrCYKXYqlYPu04oNtXyGBBTX+nDaG0uNw+Hk3yzPzJKNpr/rUH7QFEaEUxzIh6ZjMG73DrIZBCoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/XpF/6nLbeyAOMH+4J1F6F02x2732Gn1BUA6g00/JQ=;
 b=hUVDnx1hKKZNoaiPb1ow6jgLliPQ4QhV1t6JK7QKP1jrkzO9hCQao1D1GYSYpZouDXa+R0fq/5TdBz+V+Pc7JQ9dz8m1OXqRJFuzpPFFeU1BEOOfwcCF44eGBN9gMrPUO6YIvCqyF53G4qXoSNSYl2V+lfDmbYLkR+yj0YNeg5mvVsdeSgxPKpRXKswV9I2NUtfJH2pyvKwK9RGONI4qHmyP1Id6crccMAhjfKZ+b+Y9GB/cWLsQcERG8TtJtrOOcth3+lNUHFONJXusOlNyqOCPsUCmlVtBQXjtasHwQsJ6cyzR/fJq7ocEXY5QqQ4OaRf9/PyN4A+Pza4BNNOGbA==
Received: from MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::31)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 04:39:24 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::2f) by MW4P221CA0026.outlook.office365.com
 (2603:10b6:303:8b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Thu, 3 Nov 2022 04:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 04:39:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 2 Nov 2022
 21:39:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 21:39:13 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 2 Nov 2022 21:39:08 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <joro@8bytes.org>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
        <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v10 3/4] mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Thu, 3 Nov 2022 10:08:51 +0530
Message-ID: <20221103043852.24718-3-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103043852.24718-1-pshete@nvidia.com>
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 22699bfd-5f53-406d-4c09-08dabd5561f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Z31zPf4SGEDv6CX+0vcdymv5ajsD1vq9av3BObP5/AzUyu+6L4Daw28zqrtBRQwu1+eG8ijXYVkPpSWWUHVM6VAAChMXtVkGOKY4z1195Wa6vLnu9JhZGD5celr8ji5wEFxjTA4BQY4AzCTEfTbDYJy2F/KQPEyixTb7nOKa8+4DdoYm6V9ir71HEh41nYPrMmoXKItRtTs2/RnzGVEn1Bom19Yc8uul0NErbmwKEsugloir1hWlNWMGTNg0aqg2fVD30DtXbi6wlbLlL0Dq5gaizUSY/3km+Y8FRHiTqAYG08gRANqsC0rMCZPW534x+Wm17rK1FQPKl2kfZFoFh+YjnW8qknzOc2Uj4F2sLiY6FuWDYHSp3ursG+Jfy/NT3Bprf2asBAqxmlfPsGATNUykHy/aLXtM2NEOkfJd1DNzAJAMa7qz6zSmSVyJajcoAfMK3tzQ2kyKN1hMn9nJ34AYinaZS9QCj/GHdmeenQvodRziYqtLxbnw+D8WCLHj7Z5vmCB77BDniE6mkSrNwrpOlNHczuleCymTNaz/A1Yp4K0aOwi6ffyFPG0wrTU2l+khfMu/agEt5ur5Q/eF3S+45UUPhFISFUY4LUpIjM98vti0ubmURZd10e1y5FIBvJSJg7vtSmUTh0425TOgMj7NLa3+dLu09I+GQax3lUfl2N2x1G4gTCxdgLDaPUeXXyiTN4XV359n3VlGDL+VAkpWMUrSPY756bKQbsIgCa1JcrYcFB242yJNQDCSwLHfVx3JPi906zJFNV8rVMGtA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(36860700001)(82740400003)(6666004)(83380400001)(54906003)(4326008)(70206006)(426003)(82310400005)(8676002)(36756003)(2616005)(70586007)(316002)(110136005)(86362001)(47076005)(7636003)(2906002)(7696005)(26005)(8936002)(1076003)(41300700001)(186003)(478600001)(336012)(5660300002)(7416002)(356005)(107886003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 04:39:23.8548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22699bfd-5f53-406d-4c09-08dabd5561f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

