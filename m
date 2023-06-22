Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC173A4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjFVP3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjFVP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:28:20 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659F212C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:27:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM3cEv73hxrKSFU0DCaW6bmnZBzNF9qp2rQ8dijZco7UK0SS0dQEVYWlO04KhKCzK9NWpCD1PyO3rK+Vqvxoz3obV3HUlwppesXMLGOj7/S0NljsdgRlTeTLjOjw8ISY4AdVUMdaghrEd2c7TO4fzbWVq9LL6n7eHKrjgCu9rdnpT+7G+TrQxnKCBlUtc8JfzHreG/wL3PkJ21idjnFYlnZsmLMGaglvMQ9oTIqOOQefpTu3PpxUEgaGVGhqrKlTolJ+tiWurXf9Xa2AQDxugz8j/q/OmEyFp+pk5y2Ue7Ut1MhP0JjluBXdffPagjUtKsVqkDfIR4qX5DASqY+Awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rwq6fDAuv0vFz/YvtKA/oSK/5+p+hkoQrRMmsbd4jtU=;
 b=JJhhf67qHZ5NtivZfsj+TiArhXZda5GYk4nFqwXMajjEyCDCzBTD7rvMVt9d2Bf0H22aiYf7Kw2unHrTHQvF6vtSIWQBP8K2t+3zE+qzKPQHWM3i7piJtM0mpWLxt/3eerVkUW6apoJGJlhsZBl7wfVy50EBnywiRwjTzuBBXMQw9L5+5VYuVfuMdlSTjbzP39+aVdgizG24OZUmVTakb5SrH+4m7s7eHQG/746+WlZBJRLQxOzhdgKTIuS7tLR/bbg46KVuX6uESEi+eBY6mVm9qeXnVpcyL39VosxEdbABYu0uEtOdZfO815ZkhSrLP5F9wDqKGd6NhVecDe9U5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwq6fDAuv0vFz/YvtKA/oSK/5+p+hkoQrRMmsbd4jtU=;
 b=VLkm6y9Cy/tStIM+Jg4JT+FhGdH7zuw3AoB39EI8WYBW7DC9Nw56z+T3fb94eRlBs1WZueTprEYf6ym6Fd3YokPvTT0rxDDePJeG0Pqj1n3ndcvhQkqW1X/kgeTJGcfhukYcKzgdozptEBU12GFSUhRqrcLkABJbiD8a4fNHPxo=
Received: from PH0PR07CA0072.namprd07.prod.outlook.com (2603:10b6:510:f::17)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:27:15 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::ec) by PH0PR07CA0072.outlook.office365.com
 (2603:10b6:510:f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.23 via Frontend Transport; Thu, 22 Jun 2023 15:27:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:27:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 22 Jun
 2023 08:27:14 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:27:10 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/11] ASoC: amd: acp: add pm ops support for rembrandt platform
Date:   Thu, 22 Jun 2023 20:53:58 +0530
Message-ID: <20230622152406.3709231-21-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bb2c5e-082d-4b7a-d0b3-08db7335287a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxXdfieeATNUsAy+PYx+wjHT2WcSjUMt6xO+6eBNV0Yky/oCdZoFKDmKZlVH2DzU9SJ3yZR8MBpFVzn2mUwuD/26kSc4/luVp64JJ2poGUniTG1+FfSZm/SjZFd7X46bvxyfkB90bME8k9ItlFY4cMltDvcnVqze1+wID6WuZwh+eQ/Q+7qqG34LGbtz+tqeXSopmW3MaSabBm5IlmJYI4uZsevRD65fCcHjxKzfBZi94GSKRbaCBTxf50AEvD1ZijlYuObjm7Y0ZQc4xXtH6AUS6IXHhEVrF2UMje8PBLtZbEMYAuWUZppjaVcmrBcOzsl6yTfuD4ec9xubbPtcB1nJDDYGJc4AN1N4HDXx1mJLKG34EHqlRJ5YMqCqXh56+z0vhfV7xv2Y2Pa95Ku0iaEB4D1x+cStj6y+ZD48LY3hfFub2mwJIAJb03zeIeIe+n0YK+nO2HHQRYIeIPtsqFeOl7tI5zqOwWfuhwGwfcXlUS5AVKYHMML0q0zVpLeMKk0AzAm94zPLLBpnYGOo04C0rw4416SCrkEF6MdqEb2Y0KDBlHg4R8gFoH0BpT/gIzKkw+SaRNdsiDdSY7Ms7z/3EB4BoLdfgSDa5olKxua06k1fFPXXvCSopEWywNy7x99lA6quC5rXqilZxaGVngsvYf+S6cL3gc2TieBgMvV1i82fKGGbYh6ClBZdvS3hLsp5bcqwnEnF+zglJLV6yu4A10aYXKeWJHKp7q9+dcL+IbLpU8S0hnlj15Q0CDevQxEWM46hY8/OlLusQtIvLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(4326008)(8936002)(8676002)(86362001)(2616005)(316002)(81166007)(70206006)(70586007)(336012)(41300700001)(356005)(82740400003)(26005)(6666004)(36756003)(186003)(36860700001)(110136005)(54906003)(5660300002)(30864003)(47076005)(426003)(1076003)(83380400001)(478600001)(7696005)(40460700003)(40480700001)(2906002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:27:15.2030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bb2c5e-082d-4b7a-d0b3-08db7335287a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pm ops for rembrandt platform.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-legacy-common.c | 208 ++++++++++++++++++++++++++
 sound/soc/amd/acp/acp-rembrandt.c     |  42 +++++-
 sound/soc/amd/acp/amd.h               |   9 ++
 3 files changed, 258 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 45a45d002915..ba58165cc6e6 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -37,6 +37,214 @@ void acp_disable_interrupts(struct acp_dev_data *adata)
 }
 EXPORT_SYMBOL_NS_GPL(acp_disable_interrupts, SND_SOC_ACP_COMMON);
 
+static void set_acp_pdm_ring_buffer(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct acp_stream *stream = runtime->private_data;
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+
+	u32 physical_addr, pdm_size, period_bytes;
+
+	period_bytes = frames_to_bytes(runtime, runtime->period_size);
+	pdm_size = frames_to_bytes(runtime, runtime->buffer_size);
+	physical_addr = stream->reg_offset + MEM_WINDOW_START;
+
+	/* Init ACP PDM Ring buffer */
+	writel(physical_addr, adata->acp_base + ACP_WOV_RX_RINGBUFADDR);
+	writel(pdm_size, adata->acp_base + ACP_WOV_RX_RINGBUFSIZE);
+	writel(period_bytes, adata->acp_base + ACP_WOV_RX_INTR_WATERMARK_SIZE);
+	writel(0x01, adata->acp_base + ACPAXI2AXI_ATU_CTRL);
+}
+
+static void set_acp_pdm_clk(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	unsigned int pdm_ctrl;
+
+	/* Enable default ACP PDM clk */
+	writel(PDM_CLK_FREQ_MASK, adata->acp_base + ACP_WOV_CLK_CTRL);
+	pdm_ctrl = readl(adata->acp_base + ACP_WOV_MISC_CTRL);
+	pdm_ctrl |= PDM_MISC_CTRL_MASK;
+	writel(pdm_ctrl, adata->acp_base + ACP_WOV_MISC_CTRL);
+	set_acp_pdm_ring_buffer(substream, dai);
+}
+
+void restore_acp_pdm_params(struct snd_pcm_substream *substream,
+			    struct acp_dev_data *adata)
+{
+	struct snd_soc_dai *dai;
+	struct snd_soc_pcm_runtime *soc_runtime;
+	u32 ext_int_ctrl;
+
+	soc_runtime = asoc_substream_to_rtd(substream);
+	dai = asoc_rtd_to_cpu(soc_runtime, 0);
+	/* Programming channel mask and sampling rate */
+	writel(adata->ch_mask, adata->acp_base + ACP_WOV_PDM_NO_OF_CHANNELS);
+	writel(PDM_DEC_64, adata->acp_base + ACP_WOV_PDM_DECIMATION_FACTOR);
+
+	/* Enabling ACP Pdm interuppts */
+	ext_int_ctrl = readl(ACP_EXTERNAL_INTR_CNTL(adata, 0));
+	ext_int_ctrl |= PDM_DMA_INTR_MASK;
+	writel(ext_int_ctrl, ACP_EXTERNAL_INTR_CNTL(adata, 0));
+	set_acp_pdm_clk(substream, dai);
+}
+EXPORT_SYMBOL_NS_GPL(restore_acp_pdm_params, SND_SOC_ACP_COMMON);
+
+static int set_acp_i2s_dma_fifo(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	struct acp_resource *rsrc = adata->rsrc;
+	struct acp_stream *stream = substream->runtime->private_data;
+	u32 reg_dma_size, reg_fifo_size, reg_fifo_addr;
+	u32 phy_addr, acp_fifo_addr, ext_int_ctrl;
+	unsigned int dir = substream->stream;
+
+	switch (dai->driver->id) {
+	case I2S_SP_INSTANCE:
+		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
+			reg_dma_size = ACP_I2S_TX_DMA_SIZE;
+			acp_fifo_addr = rsrc->sram_pte_offset +
+					SP_PB_FIFO_ADDR_OFFSET;
+			reg_fifo_addr = ACP_I2S_TX_FIFOADDR;
+			reg_fifo_size = ACP_I2S_TX_FIFOSIZE;
+			phy_addr = I2S_SP_TX_MEM_WINDOW_START + stream->reg_offset;
+			writel(phy_addr, adata->acp_base + ACP_I2S_TX_RINGBUFADDR);
+		} else {
+			reg_dma_size = ACP_I2S_RX_DMA_SIZE;
+			acp_fifo_addr = rsrc->sram_pte_offset +
+					SP_CAPT_FIFO_ADDR_OFFSET;
+			reg_fifo_addr = ACP_I2S_RX_FIFOADDR;
+			reg_fifo_size = ACP_I2S_RX_FIFOSIZE;
+			phy_addr = I2S_SP_RX_MEM_WINDOW_START + stream->reg_offset;
+			writel(phy_addr, adata->acp_base + ACP_I2S_RX_RINGBUFADDR);
+		}
+		break;
+	case I2S_BT_INSTANCE:
+		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
+			reg_dma_size = ACP_BT_TX_DMA_SIZE;
+			acp_fifo_addr = rsrc->sram_pte_offset +
+					BT_PB_FIFO_ADDR_OFFSET;
+			reg_fifo_addr = ACP_BT_TX_FIFOADDR;
+			reg_fifo_size = ACP_BT_TX_FIFOSIZE;
+			phy_addr = I2S_BT_TX_MEM_WINDOW_START + stream->reg_offset;
+			writel(phy_addr, adata->acp_base + ACP_BT_TX_RINGBUFADDR);
+		} else {
+			reg_dma_size = ACP_BT_RX_DMA_SIZE;
+			acp_fifo_addr = rsrc->sram_pte_offset +
+					BT_CAPT_FIFO_ADDR_OFFSET;
+			reg_fifo_addr = ACP_BT_RX_FIFOADDR;
+			reg_fifo_size = ACP_BT_RX_FIFOSIZE;
+			phy_addr = I2S_BT_TX_MEM_WINDOW_START + stream->reg_offset;
+			writel(phy_addr, adata->acp_base + ACP_BT_RX_RINGBUFADDR);
+		}
+		break;
+	case I2S_HS_INSTANCE:
+		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
+			reg_dma_size = ACP_HS_TX_DMA_SIZE;
+			acp_fifo_addr = rsrc->sram_pte_offset +
+					HS_PB_FIFO_ADDR_OFFSET;
+			reg_fifo_addr = ACP_HS_TX_FIFOADDR;
+			reg_fifo_size = ACP_HS_TX_FIFOSIZE;
+			phy_addr = I2S_HS_TX_MEM_WINDOW_START + stream->reg_offset;
+			writel(phy_addr, adata->acp_base + ACP_HS_TX_RINGBUFADDR);
+		} else {
+			reg_dma_size = ACP_HS_RX_DMA_SIZE;
+			acp_fifo_addr = rsrc->sram_pte_offset +
+					HS_CAPT_FIFO_ADDR_OFFSET;
+			reg_fifo_addr = ACP_HS_RX_FIFOADDR;
+			reg_fifo_size = ACP_HS_RX_FIFOSIZE;
+			phy_addr = I2S_HS_RX_MEM_WINDOW_START + stream->reg_offset;
+			writel(phy_addr, adata->acp_base + ACP_HS_RX_RINGBUFADDR);
+		}
+		break;
+	default:
+		dev_err(dev, "Invalid dai id %x\n", dai->driver->id);
+		return -EINVAL;
+	}
+
+	writel(DMA_SIZE, adata->acp_base + reg_dma_size);
+	writel(acp_fifo_addr, adata->acp_base + reg_fifo_addr);
+	writel(FIFO_SIZE, adata->acp_base + reg_fifo_size);
+
+	ext_int_ctrl = readl(ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
+	ext_int_ctrl |= BIT(I2S_RX_THRESHOLD(rsrc->offset)) |
+			BIT(BT_RX_THRESHOLD(rsrc->offset)) |
+			BIT(I2S_TX_THRESHOLD(rsrc->offset)) |
+			BIT(BT_TX_THRESHOLD(rsrc->offset)) |
+			BIT(HS_RX_THRESHOLD(rsrc->offset)) |
+			BIT(HS_TX_THRESHOLD(rsrc->offset));
+
+	writel(ext_int_ctrl, ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
+	return 0;
+}
+
+int restore_acp_i2s_params(struct snd_pcm_substream *substream,
+			   struct acp_dev_data *adata,
+			   struct acp_stream *stream)
+{
+	struct snd_soc_dai *dai;
+	struct snd_soc_pcm_runtime *soc_runtime;
+	u32 tdm_fmt, reg_val, fmt_reg, val;
+
+	soc_runtime = asoc_substream_to_rtd(substream);
+	dai = asoc_rtd_to_cpu(soc_runtime, 0);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		tdm_fmt = adata->tdm_tx_fmt[stream->dai_id - 1];
+		switch (stream->dai_id) {
+		case I2S_BT_INSTANCE:
+			reg_val = ACP_BTTDM_ITER;
+			fmt_reg = ACP_BTTDM_TXFRMT;
+			break;
+		case I2S_SP_INSTANCE:
+			reg_val = ACP_I2STDM_ITER;
+			fmt_reg = ACP_I2STDM_TXFRMT;
+			break;
+		case I2S_HS_INSTANCE:
+			reg_val = ACP_HSTDM_ITER;
+			fmt_reg = ACP_HSTDM_TXFRMT;
+			break;
+		default:
+			pr_err("Invalid dai id %x\n", stream->dai_id);
+			return -EINVAL;
+		}
+		val = adata->xfer_tx_resolution[stream->dai_id - 1] << 3;
+	} else {
+		tdm_fmt = adata->tdm_rx_fmt[stream->dai_id - 1];
+		switch (stream->dai_id) {
+		case I2S_BT_INSTANCE:
+			reg_val = ACP_BTTDM_IRER;
+			fmt_reg = ACP_BTTDM_RXFRMT;
+			break;
+		case I2S_SP_INSTANCE:
+			reg_val = ACP_I2STDM_IRER;
+			fmt_reg = ACP_I2STDM_RXFRMT;
+			break;
+		case I2S_HS_INSTANCE:
+			reg_val = ACP_HSTDM_IRER;
+			fmt_reg = ACP_HSTDM_RXFRMT;
+			break;
+		default:
+			pr_err("Invalid dai id %x\n", stream->dai_id);
+			return -EINVAL;
+		}
+		val = adata->xfer_rx_resolution[stream->dai_id - 1] << 3;
+	}
+	writel(val, adata->acp_base + reg_val);
+	if (adata->tdm_mode == TDM_ENABLE) {
+		writel(tdm_fmt, adata->acp_base + fmt_reg);
+		val = readl(adata->acp_base + reg_val);
+		writel(val | 0x2, adata->acp_base + reg_val);
+	}
+	return set_acp_i2s_dma_fifo(substream, dai);
+}
+EXPORT_SYMBOL_NS_GPL(restore_acp_i2s_params, SND_SOC_ACP_COMMON);
+
 static int acp_power_on(struct acp_chip_info *chip)
 {
 	u32 val, acp_pgfsm_stat_reg, acp_pgfsm_ctrl_reg;
diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index bc8e1de45170..b2b78a69dc24 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -20,6 +20,7 @@
 #include <sound/soc-dai.h>
 #include <linux/dma-mapping.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 
 #include "amd.h"
 
@@ -236,7 +237,11 @@ static int rembrandt_audio_probe(struct platform_device *pdev)
 	acp6x_master_clock_generate(dev);
 	acp_enable_interrupts(adata);
 	acp_platform_register(dev);
-
+	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	return 0;
 }
 
@@ -247,13 +252,48 @@ static void rembrandt_audio_remove(struct platform_device *pdev)
 
 	acp_disable_interrupts(adata);
 	acp_platform_unregister(dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
+static int __maybe_unused rmb_pcm_resume(struct device *dev)
+{
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	struct acp_stream *stream;
+	struct snd_pcm_substream *substream;
+	snd_pcm_uframes_t buf_in_frames;
+	u64 buf_size;
+
+	acp6x_master_clock_generate(dev);
+	spin_lock(&adata->acp_lock);
+	list_for_each_entry(stream, &adata->stream_list, list) {
+		if (stream) {
+			substream = stream->substream;
+			if (substream && substream->runtime) {
+				buf_in_frames = (substream->runtime->buffer_size);
+				buf_size = frames_to_bytes(substream->runtime, buf_in_frames);
+				config_pte_for_stream(adata, stream);
+				config_acp_dma(adata, stream, buf_size);
+				if (stream->dai_id)
+					restore_acp_i2s_params(substream, adata, stream);
+				else
+					restore_acp_pdm_params(substream, adata);
+			}
+		}
+	}
+		spin_unlock(&adata->acp_lock);
+		return 0;
 }
 
+static const struct dev_pm_ops rmb_dma_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, rmb_pcm_resume)
+};
+
 static struct platform_driver rembrandt_driver = {
 	.probe = rembrandt_audio_probe,
 	.remove_new = rembrandt_audio_remove,
 	.driver = {
 		.name = "acp_asoc_rembrandt",
+		.pm = &rmb_dma_pm_ops,
 	},
 };
 
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 8dc663c8d98a..1d8457383e3f 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -110,6 +110,7 @@
 
 #define ACP_TIMEOUT		500
 #define DELAY_US		5
+#define ACP_SUSPEND_DELAY_MS   2000
 
 #define PDM_DMA_STAT            0x10
 #define PDM_DMA_INTR_MASK       0x10000
@@ -213,6 +214,14 @@ void acp_disable_interrupts(struct acp_dev_data *adata);
 /* Machine configuration */
 int snd_amd_acp_find_config(struct pci_dev *pci);
 
+void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream *stream);
+void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int size);
+void restore_acp_pdm_params(struct snd_pcm_substream *substream,
+			    struct acp_dev_data *adata);
+
+int restore_acp_i2s_params(struct snd_pcm_substream *substream,
+			   struct acp_dev_data *adata, struct acp_stream *stream);
+
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
 	u64 byte_count, low = 0, high = 0;
-- 
2.25.1

