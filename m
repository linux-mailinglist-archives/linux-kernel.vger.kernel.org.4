Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4755A6D0C36
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjC3RG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjC3RG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:06:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1604A199E;
        Thu, 30 Mar 2023 10:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0BxrXbJs6uUsisX2dLfBPiaIfaamwfRbyUMQow2ODDqqfv7Plkiu05cJbPS+P4qbqN58/yNuDrMtErRHWBL3ucppHyCUdpugmD070vlHPDjDdBoCdKLfzE6ebwhRwHxhpdsuYpFPsAF4KgDX7k8npj7abV5wI5huYIgDC6YSxtbg56fPlts3HqdwjDwpC4m6DuUhqdt8WCxKolt6H8P07tyjlA4YMTXXq4NLJn+kr6aXtAdguozzV9y53/L42tlcevRymqwM3llamvlwqHi5GkKVsEq1OgjL92BIs2U50+wqq91EfaGRA2znUUak761q9D/HM/RSK300/RXbJL95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPlokCDgn2mJ2gJpqgpzT+Y5j+ltEq+Ly9qfUrqStDM=;
 b=d7nRagsolPgx5WdFWTNGf22szg3tGgk/impkRMyo1g4j8cW4gPcj0uqBgqv4DkiTjRcqWGjWXMdrTVkgoCigZ0B64zoexlY9ih3mMDodIi+4u3kC/ppo3C/E15TmQG0zmSFrz7p73xd7rk/IOw03ueyulZQvWiKzEovJwzEsyHdpsx3at4sOW19s9bxYcVTP2DptYSm8ZWTMq24O6vmB8yweB3PysU8SLXVPUemSfqqsFZ/a1MAn0Pq7pmGEs3Q7en3eL3iv/unAgCc7loA8orEePHGtOOFxirADapm1loR3TrJzk9UtKRFJXY0lP4akzNAgi5xdhgw14oyd9ptF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPlokCDgn2mJ2gJpqgpzT+Y5j+ltEq+Ly9qfUrqStDM=;
 b=NkitazGokgLWf9MJTq3f5RbdFUp4aOO3xoeeskhdWVsfbd51H9GmMy2InalA50/Gw3Dmculmwhenz5qFS+B+ZTWzh627/VhViu6dBw8FFmjj8c98IQ6HbtZQcMR4TfIzla27hhWkZNo0beWjNEk8+4q6CQXhiNyEMX1Sbz3yDN5FNf94Xef6TTvt36cnm18fVJuevRyJo3cjdRE/CA71R7gkv71ttS/vGB8vDkHYL5JvuV6c1J63RgS1mJ1IiCEU42lkBqLhePsRdW3K9fjqVxP/4xNPB52w+zVYpuhtdwSfJU8Jp7Ops0VJi4CWq6ND/OaUllzj5wIdY0CpbAEfxg==
Received: from BN8PR16CA0014.namprd16.prod.outlook.com (2603:10b6:408:4c::27)
 by BL0PR12MB4850.namprd12.prod.outlook.com (2603:10b6:208:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 17:06:52 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:4c:cafe::c8) by BN8PR16CA0014.outlook.office365.com
 (2603:10b6:408:4c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 17:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 17:06:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 10:06:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 10:06:40 -0700
Received: from build-petlozup-20221211T210255927.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via
 Frontend Transport; Thu, 30 Mar 2023 10:06:40 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>, Viswanath L <viswanathl@nvidia.com>
Subject: [PATCH v2] soc/tegra: pmc: Support software wake-up for SPE
Date:   Thu, 30 Mar 2023 17:06:21 +0000
Message-ID: <20230330170621.258068-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|BL0PR12MB4850:EE_
X-MS-Office365-Filtering-Correlation-Id: a10e8144-aa59-40ad-e6d6-08db31412840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohtG1q+rT1HqqOmZWuWjgrih33N6xguGgcq1keXRZA+2dFQmuPFudWKV2Y9r1LIvRPKo4eXyPLGT+mTjZocTx9V4lDzfP/KNKEAe8Lah792ytOtkjEqVTP7txCgaVyiZF5wLqjRNPUj8yr1q2k3XgGRxrzZ1E9TlAApEfmvusF5N4Nq857sqIwdDUPF6tfguK7rNtrZ9huQq/9dfyspXnaRomysS25qFwiAKrJQcqfz1aVJWLgz3Aqx/TRakbNoS7QZZ1Pl9Ireia+RJujsNzJZI6sZZrxoNIm6WQfEX0R4lp+EGhUtsJgpTdeyuvhOwQFpgzikUS296JFaop8QgFrWvADeKGwLy0iyylFY0BL6NU7jHwStAL7z2F7nJel2FCtfyU7oM6gjq3OmlRbgJ5+zd/kCwEOw9JZeDqjlrxUbVfGHiztc3JiPB+hfJOlY+1UbA1qvNd8P+Nl4hen9DZm92Jo8srqtVBUcL1p5bCjAFh9T8jom1a9ko+0t6bUdw37ff6q7iTl5uYalUq1I19nO/jM1FvCCeY1fK9q3gCHtElnwulDASMKD3KyMv173MUg4KJKMlRBkDK12qiFAbJYnSjZDFWjURSEvAFpbfNkJSh7XgNrv4nzIsdWjocrq2bNeNiSgtYEC8Y0GQzW3I1U07CJDyF0B3W2pMDKL6V45ICkImOC/2R222jGlDZt85yQ4rutxiPsyOL/OMbDMdDVT0bF1vQw5g71FbByHBpdQ=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(70206006)(70586007)(82310400005)(186003)(4326008)(8676002)(478600001)(54906003)(316002)(110136005)(36860700001)(6666004)(40480700001)(107886003)(1076003)(26005)(36756003)(7696005)(8936002)(5660300002)(47076005)(336012)(86362001)(83380400001)(2906002)(426003)(921005)(356005)(41300700001)(82740400003)(2616005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 17:06:51.8846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10e8144-aa59-40ad-e6d6-08db31412840
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4850
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sensor Processing Engine(SPE) can trigger a software wake-up of
the device. To support this wake-up for the SPE, set SR_CAPTURE_EN
bit in WAKE_AOWAKE_CNTRL register associated with the wake-up for
the SPE. This SR capturing logic is expected to be enabled for wakes
with short pulse signalling requirements.

Signed-off-by: Viswanath L <viswanathl@nvidia.com>
Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
v1->v2:
* Rebase the change on latest code.
---
 drivers/soc/tegra/pmc.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index cf4cfbf9f7c5..2a2342eff622 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3,7 +3,7 @@
  * drivers/soc/tegra/pmc.c
  *
  * Copyright (c) 2010 Google, Inc
- * Copyright (c) 2018-2022, NVIDIA CORPORATION. All rights reserved.
+ * Copyright (c) 2018-2023, NVIDIA CORPORATION. All rights reserved.
  *
  * Author:
  *	Colin Cross <ccross@google.com>
@@ -177,6 +177,7 @@
 /* Tegra186 and later */
 #define WAKE_AOWAKE_CNTRL(x) (0x000 + ((x) << 2))
 #define WAKE_AOWAKE_CNTRL_LEVEL (1 << 3)
+#define WAKE_AOWAKE_CNTRL_SR_CAPTURE_EN (1 << 1)
 #define WAKE_AOWAKE_MASK_W(x) (0x180 + ((x) << 2))
 #define WAKE_AOWAKE_MASK_R(x) (0x300 + ((x) << 2))
 #define WAKE_AOWAKE_STATUS_W(x) (0x30c + ((x) << 2))
@@ -191,6 +192,8 @@
 #define WAKE_AOWAKE_CTRL 0x4f4
 #define  WAKE_AOWAKE_CTRL_INTR_POLARITY BIT(0)
 
+#define SW_WAKE_ID		83 /* wake83 */
+
 /* for secure PMC */
 #define TEGRA_SMC_PMC		0xc2fffe00
 #define  TEGRA_SMC_PMC_READ	0xaa
@@ -355,6 +358,7 @@ struct tegra_pmc_soc {
 	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
 				   struct device_node *np,
 				   bool invert);
+	void (*set_wake_filters)(struct tegra_pmc *pmc);
 	int (*irq_set_wake)(struct irq_data *data, unsigned int on);
 	int (*irq_set_type)(struct irq_data *data, unsigned int type);
 	int (*powergate_set)(struct tegra_pmc *pmc, unsigned int id,
@@ -2416,6 +2420,17 @@ static int tegra210_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
+static void tegra186_pmc_set_wake_filters(struct tegra_pmc *pmc)
+{
+	u32 value;
+
+	/* SW Wake (wake83) needs SR_CAPTURE filter to be enabled */
+	value = readl(pmc->wake + WAKE_AOWAKE_CNTRL(SW_WAKE_ID));
+	value |= WAKE_AOWAKE_CNTRL_SR_CAPTURE_EN;
+	writel(value, pmc->wake + WAKE_AOWAKE_CNTRL(SW_WAKE_ID));
+	dev_dbg(pmc->dev, "WAKE_AOWAKE_CNTRL_83 = 0x%x\n", value);
+}
+
 static int tegra186_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
 {
 	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
@@ -3042,6 +3057,10 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pmc);
 	tegra_pm_init_suspend();
 
+	/* Some wakes require specific filter configuration */
+	if (pmc->soc->set_wake_filters)
+		pmc->soc->set_wake_filters(pmc);
+
 	return 0;
 
 cleanup_powergates:
@@ -3938,6 +3957,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.regs = &tegra186_pmc_regs,
 	.init = tegra186_pmc_init,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
+	.set_wake_filters = tegra186_pmc_set_wake_filters,
 	.irq_set_wake = tegra186_pmc_irq_set_wake,
 	.irq_set_type = tegra186_pmc_irq_set_type,
 	.reset_sources = tegra186_reset_sources,
@@ -4122,6 +4142,7 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.regs = &tegra194_pmc_regs,
 	.init = tegra186_pmc_init,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
+	.set_wake_filters = tegra186_pmc_set_wake_filters,
 	.irq_set_wake = tegra186_pmc_irq_set_wake,
 	.irq_set_type = tegra186_pmc_irq_set_type,
 	.reset_sources = tegra194_reset_sources,
@@ -4247,6 +4268,7 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.regs = &tegra234_pmc_regs,
 	.init = tegra186_pmc_init,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
+	.set_wake_filters = tegra186_pmc_set_wake_filters,
 	.irq_set_wake = tegra186_pmc_irq_set_wake,
 	.irq_set_type = tegra186_pmc_irq_set_type,
 	.reset_sources = tegra234_reset_sources,
-- 
2.17.1

