Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E16F5B85B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiINJ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiINJ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:57:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B396277;
        Wed, 14 Sep 2022 02:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqKKfpbsYgOuD3LzEyJlOwzfcnNbrhk+2yyzbQ1/+48YgNcidBE17CIo/8kWApK+AibA4ulsktjCAiACi6PVYqOna6YZgLd55xwH7fAEPvWnklG1sZlkwUVTSbCkc/Z6GR754yBSIdivhIAFcyOST6gTqwT5n7JSurTj9uAci+2aBuK8Io7fdK98IOKltdgDHenOJ1f1aOAyK0rNOd5d1f/0c587RyPnX717HzQJNMkx6hqcCX9XIvwKeUqFlk6Oyaes+O+q654goUxpNW07WDGuNLalIdG77iya24fYnIqIWuXiHgBbU5QMINbXzbolXnlfFSGU7uNVhqsEOJk8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiUDfNSa/TiAIeG1QGdco6xQkEQ+2rkrw4tqLc46Grs=;
 b=VbOiLnyFhDIRpfuvjOXdDX+rPuB7liiOyBsDlyk1+LE8V6vhh3JMsyJmgcQXvyvWRfqwTfhLt7cy+XO5dYkYjuqBZoChR/Wyyz5z6CqJ6C8+kAgC8klY1li2V2tDekSY8lgHooKzhaRa2yR89sTRWRw5DG9jKkrb424c0CGNITvw7N+pz8eaR2q3m7MAaNUgp/iN8sRMdpoQruf0ARd6iwVIY0pcjKKvSPz8ZvDoDX5aE/YSH0LOFAxK3bZlGzY8nRqDDn9Etcb2qCpyPsJEouQCi5xbIVcA1zD9XutwaFJT6FaRzi7MPWMYk430NvqkcYL2zp5fWLEQqsuxQBmsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiUDfNSa/TiAIeG1QGdco6xQkEQ+2rkrw4tqLc46Grs=;
 b=rteFsjJO8QhMLkCdQuTcdpSCPMOM+1enin9sijtR/J9HxRrwGCm0/7D/2YsSBaGX3RiqaYQFZx9yDG8rWgYThiHguHHHOSa9jsuYE/UXokLE3CA3lmwnb8zBTBuv8iSZ/a9wzFo5b9QCgzWlc2KRrCY8O8yvMnTJmXdUkTX7pw+fiyQfvOPOZ5sVxUGLbFdFXF17fOkDKY42yWLMlT9H7PdkE5gRUaf71BYMf3MN4jK6B+fToqMJHJMtBPkN8x7TmMBMFebBWGAkq23pEQIRjTOhjtgsah8UaVihxmtqdLtA5hjRFKhFgwUVw19MAPHgCqXOxA6ZdazH4N8ae1EoLA==
Received: from MW4PR03CA0084.namprd03.prod.outlook.com (2603:10b6:303:b6::29)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 09:56:59 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::4) by MW4PR03CA0084.outlook.office365.com
 (2603:10b6:303:b6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 09:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 09:56:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 14 Sep
 2022 02:56:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 02:56:40 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 14 Sep 2022 02:56:37 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v2 2/4] mmc: sdhci-tegra: Add support to program MC streamID
Date:   Wed, 14 Sep 2022 15:26:26 +0530
Message-ID: <20220914095628.26093-2-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914095628.26093-1-pshete@nvidia.com>
References: <20220914095628.26093-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: edb13dc9-6eb1-4e80-c588-08da9637769e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FBzO6sidLVeLAkpwihPZLoF0OqcCpGl+pPOYuA9e5xjoXYjiz6wtVrRACQEZvljHDWj9hzLopdZtxG5ewqaEnxNpSHzCPTgIlaa3knC8ToBiyy25iRTnSZt8iLwIToQ/eCfDx2nuZTzhJgJ9MkGex9mLuqeVzv8jO+yXQxVY2jsnvH3C0FqNROtr75THjcthLLJps8HOdypUN/0OYGkbPQQrD9RJvtASLElJgwyAEZZ8gj2F331JQF915UJ+nbQjI+SNaphTlf18wex2vqpE8WLJUHtOoa3AqKvtjiLhexaaNwibLkjAnP4bec0zh//ids0hskUFqr3am/Db3b90HxSnsh2+yWlR1CNttg7lf+gQCqC0kYI4i+z6FMEolEh5ycgRM6vk5ukz2FT0F9ZQyZmNv+Mpya5hcSIKVaYE7S4S/XtOSLQIi9bBjGx4+G8s2SasXVSAGO2JzW3f85zLRF0SiEF/tGtHnQK6c8esKpf0F/jFGcHmhCTaVNI6IhCHYLGpZTGfn8xc1rU1hrUC2ms6OlyB/QLbAYyBctI7mX88xQ0XqUbdXEkmuU3LK2LQ6t87TFHMN+hCP1XuZHEpFHnfi2DnlbTFxCp0ykw1qjLqFzz8J3hNJ2wlhauifVHIBMZLKqblNhLrXV1k98qobjlsChjNJqsIAGPXz2ZFiynSj4vhHtNbII8C2izzlUeWUI+2EPR+srwmIm3DC0m5EY4XJtQQ1XGPHSoTOvWnkOqEfgDP4hr67pZi/esgLG/0kJtI2jc/kzPfAWn3Q+TMVA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(6666004)(40480700001)(8936002)(7696005)(2906002)(186003)(36860700001)(54906003)(82740400003)(356005)(1076003)(83380400001)(36756003)(107886003)(26005)(478600001)(316002)(110136005)(41300700001)(2616005)(70206006)(40460700003)(336012)(4326008)(5660300002)(8676002)(86362001)(7636003)(426003)(47076005)(70586007)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 09:56:58.2112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb13dc9-6eb1-4e80-c588-08da9637769e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per T23x MSS IAS SMMU clients are supposed
to program streamid from their respective address spaces instead of MC
override
Define NVQUIRK_PROGRAM_MC_STREAMID and use it to program SMMU streamid
from the SDMMC client address space

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a6c5bbae77b4..b66b0cc51497 100644
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
+#define NVQUIRK_PROGRAM_MC_STREAMID			BIT(17)
 
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
@@ -177,6 +181,7 @@ struct sdhci_tegra {
 	bool enable_hwcq;
 	unsigned long curr_clk_rate;
 	u8 tuned_tap_delay;
+	u32 streamid;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -1564,6 +1569,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_PROGRAM_MC_STREAMID |
 		    NVQUIRK_HAS_TMCLK,
 	.min_tap_delay = 95,
 	.max_tap_delay = 111,
@@ -1637,6 +1643,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_tegra *tegra_host;
 	struct clk *clk;
+	struct iommu_fwspec *fwspec;
 	int rc;
 
 	soc_data = of_device_get_match_data(&pdev->dev);
@@ -1775,6 +1782,23 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_add_host;
 
+	/* Program MC streamID for DMA transfers */
+	if (soc_data->nvquirks & NVQUIRK_PROGRAM_MC_STREAMID) {
+		fwspec = dev_iommu_fwspec_get(&pdev->dev);
+		if (fwspec == NULL) {
+			rc = -ENODEV;
+			dev_err(mmc_dev(host->mmc),
+				"failed to get MC streamid: %d\n",
+				rc);
+			goto err_rst_get;
+		} else {
+			tegra_host->streamid = fwspec->ids[0] & 0xffff;
+			tegra_sdhci_writel(host, tegra_host->streamid |
+						(tegra_host->streamid << 8),
+						SDHCI_TEGRA_CIF2AXI_CTRL_0);
+		}
+	}
+
 	return 0;
 
 err_add_host:
@@ -1861,6 +1885,8 @@ static int sdhci_tegra_suspend(struct device *dev)
 static int sdhci_tegra_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, false);
@@ -1871,6 +1897,13 @@ static int sdhci_tegra_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Re-program MC streamID for DMA transfers */
+	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_MC_STREAMID) {
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

