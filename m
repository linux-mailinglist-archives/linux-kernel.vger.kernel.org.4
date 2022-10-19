Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4CF60395D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJSFtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJSFtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:49:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF8513DCE;
        Tue, 18 Oct 2022 22:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjJH6CrmSSca/kv54AIlGCwmi6TWNVvARpu2fZqFSrhG/sXcOeOuHkm6wZHkWDJYqs54GEAtirAgOerepbRxeYwQ3tyk68abLSgXKal1LjA/FFIDZZbhzxb13+uvff3N2vlCUwAKxziTW1pVjfhcyW5KGMiJl9wkYRHv3bABjtsQzdaAviZPoNdcXfm9kvr5fL4eNo1ygeD7uUCe0ct327TDbLHJ0Co5GjpqT0W+pdQV6PbHwVMp2kdiBbthz7RkeOOz7tMKes/KSVmQkhEWBgjQTfpboRVkDuc2a8wG15DRQiUkcz4gYS5SdCXpewiZq/UDzcKAJDPAHp8RLYX6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsA2i1YT/luMW4/sKxuSUBATmaSk4o0SamoL/Mft28s=;
 b=U4yCEOticWzRrxTDMsoH4hLkfToU8rvyGGCqr3sGKmPWR8i1fv7SAZWuMhv2sZpJ95F2IdZUvVakAqHDIhWx42XmLIJf+Y7xFJWdRO+ADXAQf0isvSSOE3DtNKyAMH4iFQcOFwu87ZYS7hHxSirgmWDiMnz0rf34MSTe12By/unEaZku+k+RCvahlJcKHvv9TZ9ae/euYE42Y3a//Henva4rbgVSESrxgng6bsIRuYD/GDV0oGCgiJyVF+hqXsDhcWkl3a/yYEDLRgtOaQZd3b61DPdTHatELwPJLHsH++tSeGy+Dygp1q/6ieCj/fvAtNORXoUKRKDZ0zJr7Qn78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsA2i1YT/luMW4/sKxuSUBATmaSk4o0SamoL/Mft28s=;
 b=rbrcKdOzXkh/agO3hByL3OJZ3Ke5EVAmlxALA8rh9HaWdNzp5HYb68cEN8q+77Y1HySKzcqqLr8/T4LBs8MnSj5I8HzIR56y4KUcvhYeZSKredKZWVbXZFceeFOG0GGSj0CxjmGreuyxxjs+Xwp9BcKRnBaPj4KCRyLDLqHEU98=
Received: from BN9P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::30)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 05:49:37 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::ca) by BN9P222CA0025.outlook.office365.com
 (2603:10b6:408:10c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 05:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 05:49:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 00:49:35 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 19 Oct 2022 00:49:32 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <saikrishna12468@gmail.com>, <git@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Add support for dynamic configuration
Date:   Wed, 19 Oct 2022 11:18:57 +0530
Message-ID: <20221019054857.8286-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|CO6PR12MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: cac1699b-ed77-4495-38ec-08dab195b4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQm27aG3ky3zFVWsiuMQ/2aTfxSICUSHCMgIYY3UMOv1rxLuU357XUiXR6TpqCeIGQ6wlFC4hfnaCwmnAsOsxb+h5CAArxh33OyO9qvM2J+ozIr7EodyWKhlEx3A6bMJkmnEsMkNUhfMBb4lPAGc26cEZ4WTPT4oDF8LNAiY3QZ7aNYLH4mL0CDu/U8N7sTf8bMGxpM9vtH2VwNdl/+H3Q4cdTdalJcbelC0gdmSnH+kSIKaY5uy0SDlYZAEGFUgZldSSMg0wxu8FHebrgzOIGq+mQFFIMeKJbZih/BiWsWzbtijfUeYKKobJ0xISm6CdQJtSW4qw3rWuXbAvVr5dZ9y059vCRfs61dXHm+uERb9f9Um5JmcItLoAT0ZV5OWM9AygBGNNEV1OyH+p5J+qq9GBGV5BHP4bbrM1WiXTKEOIzOYmt7t2/+MOHVjEWu6sqAD8GWvGhMDlA2PZN+JuNEyDTxcVqvV/F2S1FQxrWd6PPZbOFE0wqT6/b72JZri8XMHUanluOFdKfVgJI1w2nLwNknDU6Rrh18RSpcD4PS/ENxLNiAAi8DUrF51ZC8/4nphBVkFfQPj9shCrKKS/kEsds8ua2BVjoWFsq/0nnQYNliJ/FhceOF8t/w+9wWbHjL5q1KOc8dBXVbu80dCm5gTApeKj6S87vzc8gIb4Q+2Ec0+rgo6CWaAvVszesswYWtVZkR6dUTBOyFhkA7ZdNFK7jMYjuR0fEnpYwOx3ILvxAzxUNEr+69jvinaD8B0nn4XHvadUhSsKWEklsU/gxvqlFitNhuT9Wo/trms79Kh+B2yybeePxqgfD8upPoF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(103116003)(2906002)(36756003)(82310400005)(5660300002)(86362001)(8936002)(4326008)(6666004)(186003)(41300700001)(40460700003)(478600001)(2616005)(1076003)(336012)(26005)(8676002)(47076005)(356005)(70586007)(83380400001)(70206006)(81166007)(426003)(40480700001)(82740400003)(54906003)(316002)(110136005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 05:49:36.7469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac1699b-ed77-4495-38ec-08dab195b4cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
X-Spam-Status: No, score=0.7 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dynamic configuration support for Xilinx ZynqMP which takes care of
configuring the SD secure space configuration registers using EEMI APIs,
performing SD reset assert and deassert.
High level sequence:
- Check for the PM dynamic configuration support, if no error proceed with
SD dynamic configurations(next steps) otherwise skip the dynamic
configuration.
- Put the SD Controller in reset.
- Configure SD Fixed configurations.
- Configure the SD Slot Type.
- Configure the BASE_CLOCK.
- Configure the 8-bit support.
- Bring the SD Controller out of reset.
- Wait for 1msec delay.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 69 ++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 3997cad1f793..f051f3802aff 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -21,6 +21,7 @@
 #include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/of.h>
 #include <linux/firmware/xlnx-zynqmp.h>
 
@@ -1521,6 +1522,65 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 	return 0;
 }
 
+static int sdhci_zynqmp_set_dynamic_config(struct device *dev,
+					   struct sdhci_arasan_data *sdhci_arasan)
+{
+	struct sdhci_host *host = sdhci_arasan->host;
+	struct clk_hw *hw = &sdhci_arasan->clk_data.sdcardclk_hw;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 mhz, node_id = !strcmp(clk_name, "clk_out_sd0") ? NODE_SD_0 : NODE_SD_1;
+	struct reset_control *rstc;
+	int ret;
+
+	/* Obtain SDHC reset control */
+	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rstc)) {
+		dev_err(dev, "Cannot get SDHC reset.\n");
+		return PTR_ERR(rstc);
+	}
+
+	ret = reset_control_assert(rstc);
+	if (ret)
+		return ret;
+
+	ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_FIXED, 0);
+	if (ret)
+		return ret;
+
+	ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_EMMC_SEL,
+				      !!(host->mmc->caps & MMC_CAP_NONREMOVABLE));
+	if (ret)
+		return ret;
+
+	mhz = DIV_ROUND_CLOSEST_ULL(clk_get_rate(pltfm_host->clk), 1000000);
+	if (mhz > 100 && mhz <= 200)
+		mhz = 200;
+	else if (mhz > 50 && mhz <= 100)
+		mhz = 100;
+	else if (mhz > 25 && mhz <= 50)
+		mhz = 50;
+	else
+		mhz = 25;
+
+	ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_BASECLK, mhz);
+	if (ret)
+		return ret;
+
+	ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_8BIT,
+				      !!(host->mmc->caps & MMC_CAP_8_BIT_DATA));
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(rstc);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 1500);
+
+	return 0;
+}
+
 static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
 {
 	struct sdhci_host *host = sdhci_arasan->host;
@@ -1685,6 +1745,15 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto unreg_clk;
 	}
 
+	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a")) {
+		ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_SET_SD_CONFIG);
+		if (!ret) {
+			ret = sdhci_zynqmp_set_dynamic_config(dev, sdhci_arasan);
+			if (ret)
+				goto unreg_clk;
+		}
+	}
+
 	sdhci_arasan->phy = ERR_PTR(-ENODEV);
 	if (of_device_is_compatible(np, "arasan,sdhci-5.1")) {
 		sdhci_arasan->phy = devm_phy_get(dev, "phy_arasan");
-- 
2.17.1

