Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F8C5FE97F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJNHZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJNHZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:25:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1B8AA345;
        Fri, 14 Oct 2022 00:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXvndkoNSllzvWuvwumTcQDaw1UgiYLon99dkAvPpKOzPsaxe7ZrqjMQPKenKPe1jQLUn1S5WIu0JQN9xRvhneZ8QFVbDRqnv1qYilBJ/Qv502LyE7As80U1Mp/rbj9FPgrqeo8of1K89MS56+n+U20t8haRTKh65fvuMMnxJxrJPi4AsGCWa+Hx7XMonBk/cZJvs6YYyN8B0sRNovIYtv/v5SDpAiKeTGI3sJ4pf7GVL2DEmg1YRaAKtfENugQmyBbjQTmzgoH3dTiShhfpbuwq268qw1MgD95xhx9sk9sLJkSU88quKzANN9f6aVq9eRzq7oZ1Y8/IuRb+9y7mqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM3rQpckDGtqH8d5PWm534q0U+4aPpCGvH0wvr5GKQo=;
 b=hX/6pNAkniOwqghENk8YiKxuZTTRXUUHBwda9GU37v8e3eEkMqoAwxARoXoO8GraFNmYLStpyv+xQ0j0gAeSTPQfxG4iIJO/9H0NBQ61a/k21FUbAzyi6x7rVT0RZwvoN1vjw5QxNoe1Jd50SIOzCUwn+9zUUVw0/r2ol/ULKYel5YV9VUXmyBCzW6hbyuEPn+CqdYmdK5lFusWguHhOSNqxKC7mvDVaFUzd8foF9fGW1GEoYKRpFOnHWDV9/B9pVYJcsBNxtQLdeFScg3Mpj77cIKbebNJws4MtMB71WWgNAmeOUVwV/aS2K6YeQ7M1H0+TyLocfJG1k9Mf4/4Zug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM3rQpckDGtqH8d5PWm534q0U+4aPpCGvH0wvr5GKQo=;
 b=rcDw/x16l5jnIobzNLLiiCtHrxI0wGmRol3pk/t/AfYcb2Pff9Hgf+tTVqHfbZle5DsMKg8x1sjGJSKx0Z81HMNZiatJTF9xGh6s0O3fArZcw4e6z3FWMoZ6wqt0jBBLbqevYpws1SHwzYvXd6loo0pnLvfeqaI01+K4qDgmDH91gEiPiYgWSuD+WxDNVpUyGgNEMNtQXba4YT8ZhuEnY5vlK9SB1LtiHQSU42ECah9n60fwhrL6mvWIQhcReqLbIu/ec0y4B83YJc44Rsm46sOplNCoOrbpVWy6jKppqtwn96C1Y6CqB/QlYFKtK5GHzNMJ47cR6/BbGXBn2Vf3rQ==
Received: from BN1PR10CA0018.namprd10.prod.outlook.com (2603:10b6:408:e0::23)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Fri, 14 Oct
 2022 07:25:30 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::20) by BN1PR10CA0018.outlook.office365.com
 (2603:10b6:408:e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28 via Frontend
 Transport; Fri, 14 Oct 2022 07:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 07:25:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 14 Oct
 2022 00:25:07 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 14 Oct
 2022 00:25:06 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 14 Oct 2022 00:25:03 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v8 2/3] mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Fri, 14 Oct 2022 12:54:55 +0530
Message-ID: <20221014072456.28953-2-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221014072456.28953-1-pshete@nvidia.com>
References: <CAPDyKFq5hNTdwT7CMvsxG=_5u+xvG2k3-PfbGhAbHfHbGqK81w@mail.gmail.com>
 <20221014072456.28953-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|BN9PR12MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4ad806-cb3d-49c2-33ca-08daadb545f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwyF2vp+QU0rIChpCMDZq7O1usX/N1eboQo1/tPcYcepxbsT6wEzSVDwwxaFJR5yZtp/u4/012J2ONZgOep7rMvXIv+PZ2Vs4Z9nV5FYmDvshAc1DFLC3EkA1BT6AwWWHyPX+NgCUtrdeOmu9aE76xNX+baF9V0iKDA+OQ+HCDnEMLmaSnNhmpJOx95j/XAMrYErjlA4j6BqYEczPoAZmOYJld+cTgLbG4ZCfx5pIaN37bktNCb1gTqx2taBmQiO/iaURi1+MXxGuaQW0j+0vPCzPVAn/UdeIYipHzLixnPz2CbcU+uxeNlid4BUA222mEklh+ZJaHUr2cBdbkkKbYssgarWp6REd2JpKKiTFePZyD3Poxk3t87ytZV8eFVBaFwNg5cSmaQmi2t/HNULXujNE4LLHxUZEoN4VSFqYhEHutcqy9pow6Y7w+uV/zTlP7Z4UErprIHu4rm6w8D0eZ7+Z6iz0TLHTMRUA2Zxsse+rc2ECnc7ecMZo+Ld/fQTOxkIvE82DZhazKEJBxtPur3fwwHbF85nF8t8LNZbt9ahYmLzSzzrBKTUjY5PuEFQ+sKnLhpMti8Nng/YGNwsnWAEIEZzW6I797OIjiRCHIJ+SJBd36L6xjwj1SDQYPFjEWCQIwU+mZHfOjtc2f02d6m8mEkoUGvsb19jVBUu8WnUaHKhm7/Y3lY5jPmfEAhcwHVqp8mVRIBKUs8xSRLSZDZQFfj9zc84T6XmPGi1/5BWNPT3C4OR8Cj2Ov4aEEL7BoAJvLVa75DXE1uk3VjdGA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(336012)(47076005)(2616005)(356005)(7636003)(83380400001)(186003)(1076003)(54906003)(110136005)(2906002)(86362001)(36756003)(5660300002)(8936002)(6666004)(40460700003)(40480700001)(41300700001)(8676002)(107886003)(36860700001)(316002)(26005)(7696005)(426003)(82310400005)(82740400003)(4326008)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 07:25:29.8542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4ad806-cb3d-49c2-33ca-08daadb545f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
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
 drivers/mmc/host/sdhci-tegra.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a6c5bbae77b4..0cd7c3f7e6f4 100644
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
@@ -1630,6 +1641,33 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 	return ret;
 }
 
+/* Program MC streamID for DMA transfers */
+#ifdef CONFIG_IOMMU_API
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
+#else
+static void program_stream_id(struct device *dev) { }
+#endif
+
 static int sdhci_tegra_probe(struct platform_device *pdev)
 {
 	const struct sdhci_tegra_soc_data *soc_data;
@@ -1775,6 +1813,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_add_host;
 
+	program_stream_id(&pdev->dev);
+
 	return 0;
 
 err_add_host:
@@ -1871,6 +1911,8 @@ static int sdhci_tegra_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	program_stream_id(dev);
+
 	ret = sdhci_resume_host(host);
 	if (ret)
 		goto disable_clk;
-- 
2.17.1

