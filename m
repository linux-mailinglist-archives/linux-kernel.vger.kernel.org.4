Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2272BE8E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjFLKOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjFLKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:13:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1398A4C18
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOjQL9E6g0LKPhZ4j8t6GmtpNnPWUXNm2asjVg4UEzUvUA6Dh9chAAIAn0wbKhM8JgUySGIVvEeChAnBT8YQQETFNIWZM0POZELOjghIqyS3We2NQrNxtlKx16o5x+gtpnml2fMfg4kK5+A+XRdxpkl25AHSXWBB39VIO8Q5q2Z1b3uSGkNOPm8HVOdlkljd2G26Xuw2lHfDPbOp8Lm/ulHxuyQxyVFQyOavriW1cAT24xwTygQK8tnAK8gOGsxzP+7GtKvRVKtgrR8/Ss0dsjlnCyLgc2uywOgh5SD1y9/Ymw/kC99u5qpwAW2l39ih0S19HiydY9d0D2YRlJfyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tATzW8k4FG2hKzkCd15MHcLc5fdomqld5WA4pNyAAh4=;
 b=WkvHcH/RrhfwXNGHkDDuK/uRHWz8mEsoc0FwA+tz7ZUVace8FRv7QZ5Obl61mtQdeXo30YHypOigVkAsDbzd/KpO7aoxf4D2+kqEc3JHYShlNtRSKawNvd/2GdSosmanvTdDoNjpv7e2IZNQvuN88HShYW12TXIsk7M6a2SClSijmDbANHwuoJRbnKhJuKgV+1W9pSzK3a7Du8HPlo3yZrT82CS79uWpEkQsLudaFs2mxnhdn8UgDMWKIowSaRo6983ZGPQ2fEqzuKc3/UTqFMtKMCJ/PQLpIPXVW2cDpm3gt4YmJbgr7jBiVEU4XVoCrN/XuM3OOwUgG9MRPeJaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tATzW8k4FG2hKzkCd15MHcLc5fdomqld5WA4pNyAAh4=;
 b=OJXD1KLcjVSMmCnECblZt0uj+T3PaQulTPF2Rzoj6kBe85P/O7AFTopwoACjs0yV5RjjyIsQXhNTTNGav1/r+tjnCpw82kYfdMDe1qcJ3x9uV3wNU3h8N/kVI5pJkLVoapzm9c3a7GNUHoec849qwm9e4ShQ71x/gzZdStmQVv0=
Received: from DM6PR03CA0054.namprd03.prod.outlook.com (2603:10b6:5:100::31)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 09:55:27 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::23) by DM6PR03CA0054.outlook.office365.com
 (2603:10b6:5:100::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 09:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 09:55:26 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 04:55:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 12 Jun
 2023 02:55:25 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 12 Jun 2023 04:55:21 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <mario.limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 5/9] ASoC: amd: ps: add support for SoundWire DMA interrupts
Date:   Mon, 12 Jun 2023 15:28:59 +0530
Message-ID: <20230612095903.2113464-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a9983f-50d3-4c56-e95d-08db6b2b2629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SjYniW06bYuUZd+rcWVxIgjlCDAj6OEdc2tBK7ENgSFtGXvhUB3XbTVbcPjLQCyBAltUq2AN/NFXZEEYfy3NuQVzMfsfxt/PxZAdJP2zIVJd2tVSkK9mZMa7y2GU9gNLx8HAQJuSN6d7bVjGy1wJ4mfeL4+IYh9L4rzLN36hJi9ZDjoTuPrAYZT/B7kDbTCaA89R7Ix2VMA7vKPKfGTBAoWlrttWSg6AgRgX/veui9N0F4u2nW/hCJfdEbVA/DmgdZhmzPHAfLrILlUhnJFtzJdMQvvmnF0wjZCl6PbMWblWaEgjDCKtO14cOeqKM/rUKMZ8jZsyEuQDW/KwSJ00P+FAloWepYD8vKWXKM0huZZ72KlpEn+5Tq4DxX/o7jaPl/ZNUEly07zmKyX8UObZZ8/vAUkGiOj/o9+F2PhDsfGMW22D0YnisIq+b0j57qiLz1q/nd+7Sm5HplOFICM9lLPk4cnzvIsn+rAy9NX1QucKgrnA/Dqec5u4pOVnneYUvK8zF4UTui6IvSw4y9Wn7DuIgVfRZ46FubCxKCgdAgAH+LQDWSylyNsKvvBN6avcBakRXWE6VNeew7I/rJMzD8VQ56wfpL6E1bb9FRIqjpA46HWYnCHxTh7nqLll5FMy9fFI8xe8v7uRItw79ir12lTWqc0zdOqRlfzx33Opa5tLZ7ajSVDJc9mfaSuYOHtKNRwD6RAM31kGjBGajUiGlDINerOssP2+RXiHnVRwyI/2djgfvtoWnw9q0XvaI3KEB1eDPEOBzz43MYVOTg59w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(4326008)(70586007)(70206006)(6916009)(40480700001)(5660300002)(41300700001)(8936002)(36756003)(8676002)(316002)(54906003)(40460700003)(2906002)(6666004)(7696005)(82310400005)(426003)(26005)(336012)(186003)(1076003)(478600001)(83380400001)(47076005)(2616005)(36860700001)(356005)(81166007)(82740400003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 09:55:26.5791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a9983f-50d3-4c56-e95d-08db6b2b2629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move to request_threaded_irq and use thread for handling
SoundWire DMA interrupts.
Whenever audio data equal to the SoundWire FIFO watermark level
are produced/consumed, interrupt is generated.
Acknowledge the interrupt and wake up the irq thread.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  | 18 +++++++++
 sound/soc/amd/ps/pci-ps.c | 82 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 5f7ddcc31842..e96e6dc9d90f 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -165,6 +165,20 @@ enum acp_config {
 	ACP_CONFIG_15,
 };
 
+enum amd_sdw0_channel {
+	ACP_SDW0_AUDIO0_TX = 0,
+	ACP_SDW0_AUDIO1_TX,
+	ACP_SDW0_AUDIO2_TX,
+	ACP_SDW0_AUDIO0_RX,
+	ACP_SDW0_AUDIO1_RX,
+	ACP_SDW0_AUDIO2_RX,
+};
+
+enum amd_sdw1_channel {
+	ACP_SDW1_AUDIO1_TX,
+	ACP_SDW1_AUDIO1_RX,
+};
+
 struct pdm_stream_instance {
 	u16 num_pages;
 	u16 channels;
@@ -229,6 +243,8 @@ struct sdw_dma_ring_buf_reg {
  * @sdw0_dev_index: SoundWire Manager-0 platform device index
  * @sdw1_dev_index: SoundWire Manager-1 platform device index
  * @sdw_dma_dev_index: SoundWire DMA controller platform device index
+ * @sdw0-dma_intr_stat: DMA interrupt status array for SoundWire manager-SW0 instance
+ * @sdw_dma_intr_stat: DMA interrupt status array for SoundWire manager-SW1 instance
  * @acp_reset: flag set to true when bus reset is applied across all
  * the active SoundWire manager instances
  */
@@ -246,6 +262,8 @@ struct acp63_dev_data {
 	u16 sdw0_dev_index;
 	u16 sdw1_dev_index;
 	u16 sdw_dma_dev_index;
+	u16 sdw0_dma_intr_stat[ACP63_SDW0_DMA_MAX_STREAMS];
+	u16 sdw1_dma_intr_stat[ACP63_SDW1_DMA_MAX_STREAMS];
 	bool acp_reset;
 };
 
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index ac82dbe13351..ff734a90951b 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -99,14 +99,44 @@ static int acp63_deinit(void __iomem *acp_base, struct device *dev)
 	return 0;
 }
 
+static irqreturn_t acp63_irq_thread(int irq, void *context)
+{
+	struct sdw_dma_dev_data *sdw_dma_data;
+	struct acp63_dev_data *adata = context;
+	u32 stream_index;
+	u16 pdev_index;
+
+	pdev_index = adata->sdw_dma_dev_index;
+	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+
+	for (stream_index = 0; stream_index < ACP63_SDW0_DMA_MAX_STREAMS; stream_index++) {
+		if (adata->sdw0_dma_intr_stat[stream_index]) {
+			if (sdw_dma_data->sdw0_dma_stream[stream_index])
+				snd_pcm_period_elapsed(sdw_dma_data->sdw0_dma_stream[stream_index]);
+			adata->sdw0_dma_intr_stat[stream_index] = 0;
+		}
+	}
+	for (stream_index = 0; stream_index < ACP63_SDW1_DMA_MAX_STREAMS; stream_index++) {
+		if (adata->sdw1_dma_intr_stat[stream_index]) {
+			if (sdw_dma_data->sdw1_dma_stream[stream_index])
+				snd_pcm_period_elapsed(sdw_dma_data->sdw1_dma_stream[stream_index]);
+			adata->sdw1_dma_intr_stat[stream_index] = 0;
+		}
+	}
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 {
 	struct acp63_dev_data *adata;
 	struct pdm_dev_data *ps_pdm_data;
 	struct amd_sdw_manager *amd_manager;
 	u32 ext_intr_stat, ext_intr_stat1;
+	u32 stream_id = 0;
 	u16 irq_flag = 0;
+	u16 sdw_dma_irq_flag = 0;
 	u16 pdev_index;
+	u16 index;
 
 	adata = dev_id;
 	if (!adata)
@@ -153,6 +183,54 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
 		irq_flag = 1;
 	}
+	if (ext_intr_stat & ACP_SDW_DMA_IRQ_MASK) {
+		for (index = ACP_AUDIO2_RX_THRESHOLD; index <= ACP_AUDIO0_TX_THRESHOLD; index++) {
+			if (ext_intr_stat & BIT(index)) {
+				writel(BIT(index), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+				switch (index) {
+				case ACP_AUDIO0_TX_THRESHOLD:
+					stream_id = ACP_SDW0_AUDIO0_TX;
+					break;
+				case ACP_AUDIO1_TX_THRESHOLD:
+					stream_id = ACP_SDW0_AUDIO1_TX;
+					break;
+				case ACP_AUDIO2_TX_THRESHOLD:
+					stream_id = ACP_SDW0_AUDIO2_TX;
+					break;
+				case ACP_AUDIO0_RX_THRESHOLD:
+					stream_id = ACP_SDW0_AUDIO0_RX;
+					break;
+				case ACP_AUDIO1_RX_THRESHOLD:
+					stream_id = ACP_SDW0_AUDIO1_RX;
+					break;
+				case ACP_AUDIO2_RX_THRESHOLD:
+					stream_id = ACP_SDW0_AUDIO2_RX;
+					break;
+				}
+
+				adata->sdw0_dma_intr_stat[stream_id] = 1;
+				sdw_dma_irq_flag = 1;
+			}
+		}
+	}
+
+	if (ext_intr_stat1 & ACP_P1_AUDIO1_RX_THRESHOLD) {
+		writel(ACP_P1_AUDIO1_RX_THRESHOLD,
+		       adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+		adata->sdw1_dma_intr_stat[ACP_SDW1_AUDIO1_RX] = 1;
+		sdw_dma_irq_flag = 1;
+	}
+
+	if (ext_intr_stat1 & ACP_P1_AUDIO1_TX_THRESHOLD) {
+		writel(ACP_P1_AUDIO1_TX_THRESHOLD,
+		       adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+		adata->sdw1_dma_intr_stat[ACP_SDW1_AUDIO1_TX] = 1;
+		sdw_dma_irq_flag = 1;
+	}
+
+	if (sdw_dma_irq_flag)
+		return IRQ_WAKE_THREAD;
+
 	if (irq_flag)
 		return IRQ_HANDLED;
 	else
@@ -553,8 +631,8 @@ static int snd_acp63_probe(struct pci_dev *pci,
 	ret = acp63_init(adata->acp63_base, &pci->dev);
 	if (ret)
 		goto release_regions;
-	ret = devm_request_irq(&pci->dev, pci->irq, acp63_irq_handler,
-			       irqflags, "ACP_PCI_IRQ", adata);
+	ret = devm_request_threaded_irq(&pci->dev, pci->irq, acp63_irq_handler,
+					acp63_irq_thread, irqflags, "ACP_PCI_IRQ", adata);
 	if (ret) {
 		dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
 		goto de_init;
-- 
2.34.1

