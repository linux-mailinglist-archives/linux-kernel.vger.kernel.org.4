Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56936EF44D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbjDZM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbjDZM3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:29:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C855BB3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT+P7tOBd850pBSfdMvFNE9YYsRTa6LSNBhxIu3fBJhkqQ1TBDlRGaDxCktpGRQzyl7jE56utkYONRvn/hG4phLUlyMElP0Ze7+Q4lYkW3r5vwZQVqCYJztLUhBUShTq+iAPmK4LnMKPMfdcEfuweUC0Nh3zGQ+y5YR34jb/eR5Z8MMFUmRKrLdSbkfHkBv90+Y9KPSc6ILqA1Hf8T5JlQx0QBVfALtoyJvFqhw+Ru2tRFr5Z7fz/SSolXEMCs/hpPAamD8iaKbxDCTQefGtEBuNkSWcMdZlr+d9vqXKcJgy0ZCVWiC1cYlJCmn2ij/L/mWKuOyodaEguMD88v1dHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwmb91poY6bw6YlbE7gYoavtwmFLwbvy94O+0G7WBdM=;
 b=afnQD5O+J9OptBV5rp5GNlO1GqbP7P09/Cvrp5EvK9rBuaN59PW2nIVEUjk7anGrH4s+dCuxo8oxKB/80JcuaMNXgCNCRzlGZpOqaTj9DFdaXEJsrsZjv+RuorZXM5PWAvQTAIiRAmlUjIRYuXyndOVm5kr5z/Gdf4ODbGssoensekJBowfuphLVFd0nv6fIZtuQD7aGft6LQzc1bzCnBgFeBS1Grqbfpe9jVcpNiYNXM6tATSUbJuqjmh8PZhNFyc7lo08MFzuwzE78dpzay637izYvE2XQ4ZMmH/NjDUBvCr1W2izzASILA0m7PQ2YrqKDMYT5Lq04gPhCUHfw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwmb91poY6bw6YlbE7gYoavtwmFLwbvy94O+0G7WBdM=;
 b=lFVf7AuS4urIQK+kl/e/856ZMEfzi/hCJhPbWG3NpjnZ8zRVHCmaM1p8VPN2c5d67SEjdKJ++e+A/RysPktMIN40NYxaBKUjdQj5hWL7BRqPiu0pA/6Swdr/j00tK8ERwBrRTOzYUTDUrFPzDJkbsY+jZxKS6XPnPv80FUSP578=
Received: from CY5PR19CA0039.namprd19.prod.outlook.com (2603:10b6:930:1a::29)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 12:29:03 +0000
Received: from CY4PEPF0000C96F.namprd02.prod.outlook.com
 (2603:10b6:930:1a:cafe::f) by CY5PR19CA0039.outlook.office365.com
 (2603:10b6:930:1a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 12:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96F.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 12:29:02 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 07:29:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 05:28:59 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 26 Apr 2023 07:28:55 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <basavaraj.hiregoudar@amd.com>,
        <sunil-kumar.dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: amd: ps: remove the register read and write wrappers.
Date:   Wed, 26 Apr 2023 17:52:01 +0530
Message-ID: <20230426122219.3745586-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96F:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: c55418bb-39eb-4669-ad19-08db4651d1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34xupvBkAuppmVOAHsC4Dd4KO9xBmGr+fWEIilo8+F42HuGIN/UVS1jQEy8KxPIL3JpMyLwJqClqXw1sZ+KHTpA3Uq+PvDwNM1cCsiVHMTpGnPPQJ/4+C4ExS3Lfj3fKax2k1w/S3pVy7cfH1ycHcwhVdjN8f34LlLOIyRIj05pp5Wo7NXV6DPkfKl59rk0DfuObGv0aPTVk7tyf6AwaofNTHLDbQunmUk4PwPNrIYT7ZVynW9ezuk+dvyDhmbMx9JCz5fIfMh7mcM0jnHVYrDXcdVS0tjhBGvu1nJLLLiGdQ9j0c6Kp4K155rRjvCrc3Bg67x7IoV/sRQ2MKStBfT32ryyuO8nkgzlnut5MO4OW0pYlSHes7Nv3Tgjd8YfdO1KztTrjmptivOpk6RjslKhvhQtDASsewVrXSg8J2NqLYZB7ySiD9jXoctRAp87BxTfxMvpy7JtjSxP/CJ2aedf+70GteFRAGDH25sDSeNcVtL5r4m5xYH6svC3V9o5cQm67JsB98+vjCGhSvKDMCbKuGWhJIHfWGIdTZ6ktZHcW9EY0M1rHJq6Au68pplExyq0yBtUQGKM1gVPwCRalQiyta/sPNJaTi/HUrsSAcsHSGLKYXBVL9RhR6yhwJFKhffKfRwiqCzBal5as2uAs+TM7NvqSRIXrlW5SNQfT2SnYxEx1Lo5bNo2dyoBlsp3w3SFvcQ9frmuCOTCB6/hqh4nzPdit68x5aEjdSdj1/5U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(30864003)(2906002)(7696005)(36860700001)(336012)(47076005)(83380400001)(86362001)(36756003)(40460700003)(426003)(82310400005)(70586007)(8936002)(316002)(478600001)(40480700001)(186003)(6666004)(26005)(2616005)(41300700001)(1076003)(70206006)(4326008)(82740400003)(81166007)(356005)(54906003)(110136005)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:29:02.7782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c55418bb-39eb-4669-ad19-08db4651d1c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of acp63_readl() and acp63_writel() wrappers
readl and writel functions can be used directly.
Remove acp63_readl() and acp63_writel() wrappers.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h      | 10 ------
 sound/soc/amd/ps/pci-ps.c     | 33 +++++++++---------
 sound/soc/amd/ps/ps-pdm-dma.c | 63 +++++++++++++++++------------------
 3 files changed, 46 insertions(+), 60 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index dd36790b25ae..16eeda3fbdbd 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -92,16 +92,6 @@ struct pdm_dev_data {
 	struct snd_pcm_substream *capture_stream;
 };
 
-static inline u32 acp63_readl(void __iomem *base_addr)
-{
-	return readl(base_addr);
-}
-
-static inline void acp63_writel(u32 val, void __iomem *base_addr)
-{
-	writel(val, base_addr);
-}
-
 struct acp63_dev_data {
 	void __iomem *acp63_base;
 	struct resource *res;
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index afddb9a77ba4..097fd5488534 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -22,16 +22,16 @@ static int acp63_power_on(void __iomem *acp_base)
 	u32 val;
 	int timeout;
 
-	val = acp63_readl(acp_base + ACP_PGFSM_STATUS);
+	val = readl(acp_base + ACP_PGFSM_STATUS);
 
 	if (!val)
 		return val;
 
 	if ((val & ACP_PGFSM_STATUS_MASK) != ACP_POWER_ON_IN_PROGRESS)
-		acp63_writel(ACP_PGFSM_CNTL_POWER_ON_MASK, acp_base + ACP_PGFSM_CONTROL);
+		writel(ACP_PGFSM_CNTL_POWER_ON_MASK, acp_base + ACP_PGFSM_CONTROL);
 	timeout = 0;
 	while (++timeout < 500) {
-		val = acp63_readl(acp_base + ACP_PGFSM_STATUS);
+		val = readl(acp_base + ACP_PGFSM_STATUS);
 		if (!val)
 			return 0;
 		udelay(1);
@@ -44,18 +44,18 @@ static int acp63_reset(void __iomem *acp_base)
 	u32 val;
 	int timeout;
 
-	acp63_writel(1, acp_base + ACP_SOFT_RESET);
+	writel(1, acp_base + ACP_SOFT_RESET);
 	timeout = 0;
 	while (++timeout < 500) {
-		val = acp63_readl(acp_base + ACP_SOFT_RESET);
+		val = readl(acp_base + ACP_SOFT_RESET);
 		if (val & ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK)
 			break;
 		cpu_relax();
 	}
-	acp63_writel(0, acp_base + ACP_SOFT_RESET);
+	writel(0, acp_base + ACP_SOFT_RESET);
 	timeout = 0;
 	while (++timeout < 500) {
-		val = acp63_readl(acp_base + ACP_SOFT_RESET);
+		val = readl(acp_base + ACP_SOFT_RESET);
 		if (!val)
 			return 0;
 		cpu_relax();
@@ -65,15 +65,14 @@ static int acp63_reset(void __iomem *acp_base)
 
 static void acp63_enable_interrupts(void __iomem *acp_base)
 {
-	acp63_writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
+	writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
 }
 
 static void acp63_disable_interrupts(void __iomem *acp_base)
 {
-	acp63_writel(ACP_EXT_INTR_STAT_CLEAR_MASK, acp_base +
-		     ACP_EXTERNAL_INTR_STAT);
-	acp63_writel(0, acp_base + ACP_EXTERNAL_INTR_CNTL);
-	acp63_writel(0, acp_base + ACP_EXTERNAL_INTR_ENB);
+	writel(ACP_EXT_INTR_STAT_CLEAR_MASK, acp_base + ACP_EXTERNAL_INTR_STAT);
+	writel(0, acp_base + ACP_EXTERNAL_INTR_CNTL);
+	writel(0, acp_base + ACP_EXTERNAL_INTR_ENB);
 }
 
 static int acp63_init(void __iomem *acp_base, struct device *dev)
@@ -85,7 +84,7 @@ static int acp63_init(void __iomem *acp_base, struct device *dev)
 		dev_err(dev, "ACP power on failed\n");
 		return ret;
 	}
-	acp63_writel(0x01, acp_base + ACP_CONTROL);
+	writel(0x01, acp_base + ACP_CONTROL);
 	ret = acp63_reset(acp_base);
 	if (ret) {
 		dev_err(dev, "ACP reset failed\n");
@@ -105,7 +104,7 @@ static int acp63_deinit(void __iomem *acp_base, struct device *dev)
 		dev_err(dev, "ACP reset failed\n");
 		return ret;
 	}
-	acp63_writel(0, acp_base + ACP_CONTROL);
+	writel(0, acp_base + ACP_CONTROL);
 	return 0;
 }
 
@@ -120,11 +119,11 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 	if (!adata)
 		return IRQ_NONE;
 
-	val = acp63_readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+	val = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
 	if (val & BIT(PDM_DMA_STAT)) {
 		pdev_index = adata->pdm_dev_index;
 		ps_pdm_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
-		acp63_writel(BIT(PDM_DMA_STAT), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+		writel(BIT(PDM_DMA_STAT), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
 		if (ps_pdm_data->capture_stream)
 			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
 		return IRQ_HANDLED;
@@ -302,7 +301,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
 		goto de_init;
 	}
-	val = acp63_readl(adata->acp63_base + ACP_PIN_CONFIG);
+	val = readl(adata->acp63_base + ACP_PIN_CONFIG);
 	get_acp63_device_config(val, pci, adata);
 	ret = create_acp63_platform_devs(pci, adata, addr);
 	if (ret < 0) {
diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index 46b91327168f..3ecc6cf3fd34 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -45,10 +45,10 @@ static const struct snd_pcm_hardware acp63_pdm_hardware_capture = {
 static void acp63_init_pdm_ring_buffer(u32 physical_addr, u32 buffer_size,
 				       u32 watermark_size, void __iomem *acp_base)
 {
-	acp63_writel(physical_addr, acp_base + ACP_WOV_RX_RINGBUFADDR);
-	acp63_writel(buffer_size, acp_base + ACP_WOV_RX_RINGBUFSIZE);
-	acp63_writel(watermark_size, acp_base + ACP_WOV_RX_INTR_WATERMARK_SIZE);
-	acp63_writel(0x01, acp_base + ACPAXI2AXI_ATU_CTRL);
+	writel(physical_addr, acp_base + ACP_WOV_RX_RINGBUFADDR);
+	writel(buffer_size, acp_base + ACP_WOV_RX_RINGBUFSIZE);
+	writel(watermark_size, acp_base + ACP_WOV_RX_INTR_WATERMARK_SIZE);
+	writel(0x01, acp_base + ACPAXI2AXI_ATU_CTRL);
 }
 
 static void acp63_enable_pdm_clock(void __iomem *acp_base)
@@ -58,11 +58,11 @@ static void acp63_enable_pdm_clock(void __iomem *acp_base)
 	pdm_clk_enable = ACP_PDM_CLK_FREQ_MASK;
 	pdm_ctrl = 0x00;
 
-	acp63_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
-	pdm_ctrl = acp63_readl(acp_base + ACP_WOV_MISC_CTRL);
+	writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
+	pdm_ctrl = readl(acp_base + ACP_WOV_MISC_CTRL);
 	pdm_ctrl &= ~ACP_WOV_GAIN_CONTROL;
 	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, clamp(pdm_gain, 0, 3));
-	acp63_writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);
+	writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);
 }
 
 static void acp63_enable_pdm_interrupts(struct pdm_dev_data *adata)
@@ -70,9 +70,9 @@ static void acp63_enable_pdm_interrupts(struct pdm_dev_data *adata)
 	u32 ext_int_ctrl;
 
 	mutex_lock(adata->acp_lock);
-	ext_int_ctrl = acp63_readl(adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
+	ext_int_ctrl = readl(adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
 	ext_int_ctrl |= PDM_DMA_INTR_MASK;
-	acp63_writel(ext_int_ctrl, adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
+	writel(ext_int_ctrl, adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
 	mutex_unlock(adata->acp_lock);
 }
 
@@ -81,9 +81,9 @@ static void acp63_disable_pdm_interrupts(struct pdm_dev_data *adata)
 	u32 ext_int_ctrl;
 
 	mutex_lock(adata->acp_lock);
-	ext_int_ctrl = acp63_readl(adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
+	ext_int_ctrl = readl(adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
 	ext_int_ctrl &= ~PDM_DMA_INTR_MASK;
-	acp63_writel(ext_int_ctrl, adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
+	writel(ext_int_ctrl, adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
 	mutex_unlock(adata->acp_lock);
 }
 
@@ -93,8 +93,8 @@ static bool acp63_check_pdm_dma_status(void __iomem *acp_base)
 	u32 pdm_enable, pdm_dma_enable;
 
 	pdm_dma_status = false;
-	pdm_enable = acp63_readl(acp_base + ACP_WOV_PDM_ENABLE);
-	pdm_dma_enable = acp63_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+	pdm_enable = readl(acp_base + ACP_WOV_PDM_ENABLE);
+	pdm_dma_enable = readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
 	if ((pdm_enable & ACP_PDM_ENABLE) && (pdm_dma_enable & ACP_PDM_DMA_EN_STATUS))
 		pdm_dma_status = true;
 
@@ -111,11 +111,11 @@ static int acp63_start_pdm_dma(void __iomem *acp_base)
 	pdm_dma_enable  = 0x01;
 
 	acp63_enable_pdm_clock(acp_base);
-	acp63_writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
-	acp63_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
+	writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
+	writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
 	timeout = 0;
 	while (++timeout < ACP_COUNTER) {
-		pdm_dma_enable = acp63_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+		pdm_dma_enable = readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
 		if ((pdm_dma_enable & 0x02) == ACP_PDM_DMA_EN_STATUS)
 			return 0;
 		udelay(DELAY_US);
@@ -131,14 +131,14 @@ static int acp63_stop_pdm_dma(void __iomem *acp_base)
 	pdm_enable = 0x00;
 	pdm_dma_enable  = 0x00;
 
-	pdm_enable = acp63_readl(acp_base + ACP_WOV_PDM_ENABLE);
-	pdm_dma_enable = acp63_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+	pdm_enable = readl(acp_base + ACP_WOV_PDM_ENABLE);
+	pdm_dma_enable = readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
 	if (pdm_dma_enable & 0x01) {
 		pdm_dma_enable = 0x02;
-		acp63_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
+		writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
 		timeout = 0;
 		while (++timeout < ACP_COUNTER) {
-			pdm_dma_enable = acp63_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+			pdm_dma_enable = readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
 			if ((pdm_dma_enable & 0x02) == 0x00)
 				break;
 			udelay(DELAY_US);
@@ -148,9 +148,9 @@ static int acp63_stop_pdm_dma(void __iomem *acp_base)
 	}
 	if (pdm_enable == ACP_PDM_ENABLE) {
 		pdm_enable = ACP_PDM_DISABLE;
-		acp63_writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
+		writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
 	}
-	acp63_writel(0x01, acp_base + ACP_WOV_PDM_FIFO_FLUSH);
+	writel(0x01, acp_base + ACP_WOV_PDM_FIFO_FLUSH);
 	return 0;
 }
 
@@ -164,18 +164,16 @@ static void acp63_config_dma(struct pdm_stream_instance *rtd, int direction)
 	val = PDM_PTE_OFFSET;
 
 	/* Group Enable */
-	acp63_writel(ACP_SRAM_PTE_OFFSET | BIT(31), rtd->acp63_base +
-		     ACPAXI2AXI_ATU_BASE_ADDR_GRP_1);
-	acp63_writel(PAGE_SIZE_4K_ENABLE, rtd->acp63_base +
-		     ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1);
+	writel(ACP_SRAM_PTE_OFFSET | BIT(31), rtd->acp63_base + ACPAXI2AXI_ATU_BASE_ADDR_GRP_1);
+	writel(PAGE_SIZE_4K_ENABLE, rtd->acp63_base + ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1);
 	for (page_idx = 0; page_idx < rtd->num_pages; page_idx++) {
 		/* Load the low address of page int ACP SRAM through SRBM */
 		low = lower_32_bits(addr);
 		high = upper_32_bits(addr);
 
-		acp63_writel(low, rtd->acp63_base + ACP_SCRATCH_REG_0 + val);
+		writel(low, rtd->acp63_base + ACP_SCRATCH_REG_0 + val);
 		high |= BIT(31);
-		acp63_writel(high, rtd->acp63_base + ACP_SCRATCH_REG_0 + val + 4);
+		writel(high, rtd->acp63_base + ACP_SCRATCH_REG_0 + val + 4);
 		val += 8;
 		addr += PAGE_SIZE;
 	}
@@ -242,9 +240,9 @@ static u64 acp63_pdm_get_byte_count(struct pdm_stream_instance *rtd,
 	u32 high, low;
 	u64 byte_count;
 
-	high = acp63_readl(rtd->acp63_base + ACP_WOV_RX_LINEARPOSITIONCNTR_HIGH);
+	high = readl(rtd->acp63_base + ACP_WOV_RX_LINEARPOSITIONCNTR_HIGH);
 	byte_count = high;
-	low = acp63_readl(rtd->acp63_base + ACP_WOV_RX_LINEARPOSITIONCNTR_LOW);
+	low = readl(rtd->acp63_base + ACP_WOV_RX_LINEARPOSITIONCNTR_LOW);
 	byte_count = (byte_count << 32) | low;
 	return byte_count;
 }
@@ -309,9 +307,8 @@ static int acp63_pdm_dai_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		acp63_writel(ch_mask, rtd->acp63_base + ACP_WOV_PDM_NO_OF_CHANNELS);
-		acp63_writel(PDM_DECIMATION_FACTOR, rtd->acp63_base +
-			     ACP_WOV_PDM_DECIMATION_FACTOR);
+		writel(ch_mask, rtd->acp63_base + ACP_WOV_PDM_NO_OF_CHANNELS);
+		writel(PDM_DECIMATION_FACTOR, rtd->acp63_base + ACP_WOV_PDM_DECIMATION_FACTOR);
 		rtd->bytescount = acp63_pdm_get_byte_count(rtd, substream->stream);
 		pdm_status = acp63_check_pdm_dma_status(rtd->acp63_base);
 		if (!pdm_status)
-- 
2.25.1

