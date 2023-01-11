Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA366656BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbjAKJCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbjAKJBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:01:16 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830B5270A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:01:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9A/fHccjdP3/8GEH0mk2kuCvTwF9QA3tKrTrVLVqDuWRXfUlr+Sqa7PThMv1oGApq88cveKJw+J6lsUqDzk7ZvxJOEWACCM5FoeMGlBZOhpvdRyxgb6hZlkoGLek5M3rcFKEed1/1oOJyeIOT3CokViuFwdXBGS4iB9ly+pcFI/HFfHY2VCjWmv2q4kX+W9Gpr+tQu0qTYucitluQVlFRB8OkOXoT9z1+zpvSikigjw3vJyYkkYTxUNB2V34HM/RXBbuIkG966ECSGlXtcSqCxyyMhAGEXB8ojwWtt/ZCPaq1NxGuJlPLBevKxipscQ3QrsDa+H34rishymp9rFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNyCrr8FBj6Slnv5qkjuJdjmBk56Jb0Hi/zmTbxSW4o=;
 b=RA2s1xBkaBYLI4653hPZgsXIaHqPXiJHX1gFCh7lh8Fg0/EatjN6iG/kOHjn1qEBxz3tuIpjai4QaWlKxQ5fpFGX2/yD8HWZ2Rp5pHoo2iadnaDmUTfLUErAa95YqSYG9534QaeMmycV6cwUS9xw7GUyZbSTRceIO+5EX2IotY9WBfyKjTe1b6Pv6tB7HTXCT0gJIzTG7DvPmfNyKSW93TRuOsDs2MfBFubWUsJDyBBoIv/FbieXhgmMjfVg4VNe3U0XQwrnVhif+3tLFGJC8z31scyrxhgLeUiDXLqHGUPgoDhdgzYODdNLZlkHJaPjewuWCASgry6bL7pEvzrGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNyCrr8FBj6Slnv5qkjuJdjmBk56Jb0Hi/zmTbxSW4o=;
 b=mnqV4ph8ww43UW7nH2aVVXmzw/qPStICxD+t34XsneaWArPThtaw5+a/+Zc/WyPEH224pNyXqLKQ6ue4jl6WrT1Vt3JEz1Rt/9oXc/8yfOZ1B3i+rd3YaJk208xbcHfJOBiFBicsrsvuCq1V+Sw4p79n/AlcY8H4+zmr0ftIsLw=
Received: from DM6PR02CA0042.namprd02.prod.outlook.com (2603:10b6:5:177::19)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Wed, 11 Jan 2023 09:01:09 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::e8) by DM6PR02CA0042.outlook.office365.com
 (2603:10b6:5:177::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Wed, 11 Jan 2023 09:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 11 Jan 2023 09:01:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:01:08 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 01:00:36 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:00:33 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <Mastan.Katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/19] ASoC: amd: ps: add soundwire dma driver dma ops
Date:   Wed, 11 Jan 2023 14:32:11 +0530
Message-ID: <20230111090222.2016499-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 370a8e70-8328-4658-49dd-08daf3b261a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKB7/cJqvqyjVlK3rXO9JmPrpPS+X89Uv7r6Zuw/CnbvOQd+c7e1vOgaqzKVAcQniH4ULYT9ot2iOccTgdDz/yrtGvHmmOQvTE6z8Zgen+5mbwRoT7MnUXgBSGzO7Tg9PFer7rPwm9dBsxXur+x3OHhVH+bcKIGhYr9yCupE3g/+Cq+KjM5bDTZJktmIyCwgUuUKhfqAzUmIpeKEZyj1qHFHWNi3wwuNwuRZmFsez3luknGnBYrGBo3Jr4ZZO/Lugvi3PUAerBXet0Hr6LREc6iTKWRIWgpXIgeqexqow4UMlx+i1+JkCEfWif8AEm+GH2pPrebIBcFHLpfKyBSfFZfot/AhqqdUUzRKs1hROs5hMZnru2Yz2NYrEcWteRzGUpUHF+D/AE0Dq4hkawS2b9XCHk40QQK59D82ApbS16Ejq3gwZ5x8ceGRkN5BVwvPofAQ99MOYgNbkgQoUy3H5dVQIRmPd51Jaj7JIF6iQaIRzBFS919P74zx6D/eZ3oFuy6ft8aq0NEVZQeftbb7Xba8oh7C5Qybg3TwEmRFz3YzebVmVvhNj2gTDpMp2WllWDCAj2VC5oRf2nMXhqzVkmfSrnpH0iTjYtaaSjd9AtaM9KH/5C0IcfVEHd75vPSYv70LxgxwewmkH5FGQrJSqE1uq8S+NdQshDJuriO/wqd0cqdvxVLA699prhwR1GabrSosqQHi8rsrnwsSTFqEdx6S7Pmr/+it8fluhPQFhbE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(47076005)(8936002)(2906002)(5660300002)(81166007)(41300700001)(426003)(70206006)(7696005)(316002)(4326008)(70586007)(8676002)(30864003)(356005)(110136005)(54906003)(26005)(82740400003)(1076003)(40480700001)(2616005)(336012)(86362001)(40460700003)(186003)(36860700001)(83380400001)(36756003)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:01:09.3032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 370a8e70-8328-4658-49dd-08daf3b261a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Soundwire DMA driver dma ops for Pink Sardine platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h      |  61 ++++
 sound/soc/amd/ps/ps-sdw-dma.c | 531 ++++++++++++++++++++++++++++++++++
 2 files changed, 592 insertions(+)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index b462320fdf2a..8963cfb6120d 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -67,6 +67,38 @@
 #define ACP_SDW0_IRQ_MASK	21
 #define ACP_SDW1_IRQ_MASK	2
 #define ACP_ERROR_IRQ_MASK      29
+#define ACP_AUDIO_TX_THRESHOLD	28
+#define ACP_BT_TX_THRESHOLD	26
+#define ACP_HS_TX_THRESHOLD	24
+#define ACP_AUDIO_RX_THRESHOLD	27
+#define ACP_BT_RX_THRESHOLD	25
+#define ACP_HS_RX_THRESHOLD	23
+#define ACP_P1_BT_TX_THRESHOLD	6
+#define ACP_P1_BT_RX_THRESHOLD	5
+#define ACP_SDW_DMA_IRQ_MASK	0x1F800000
+#define ACP_P1_SDW_DMA_IRQ_MASK	0x60
+#define ACP63_SDW_MAX_STREAMS		8
+
+#define ACP_DELAY_US		5
+#define SDW_MEM_WINDOW_START	0x4800000
+#define ACP_SDW_SRAM_PTE_OFFSET	0x03800400
+#define SDW_PTE_OFFSET		0x400
+#define SDW_FIFO_SIZE		0x100
+#define SDW_DMA_SIZE		0x40
+#define ACP_SDW_FIFO_OFFSET	0x100
+#define ACP_SDW_RING_BUFF_ADDR_OFFSET (128 * 1024)
+
+#define SDW_PLAYBACK_MIN_NUM_PERIODS    2
+#define SDW_PLAYBACK_MAX_NUM_PERIODS    8
+#define SDW_PLAYBACK_MAX_PERIOD_SIZE    8192
+#define SDW_PLAYBACK_MIN_PERIOD_SIZE    1024
+#define SDW_CAPTURE_MIN_NUM_PERIODS     2
+#define SDW_CAPTURE_MAX_NUM_PERIODS     8
+#define SDW_CAPTURE_MAX_PERIOD_SIZE     8192
+#define SDW_CAPTURE_MIN_PERIOD_SIZE     1024
+
+#define SDW_MAX_BUFFER (SDW_PLAYBACK_MAX_PERIOD_SIZE * SDW_PLAYBACK_MAX_NUM_PERIODS)
+#define SDW_MIN_BUFFER SDW_MAX_BUFFER
 
 enum acp_config {
 	ACP_CONFIG_0 = 0,
@@ -93,6 +125,17 @@ enum acp_pdev_mask {
 	ACP63_SDW_PDM_DEV_MASK,
 };
 
+enum channel_type {
+	ACP_SDW_AUDIO_TX = 0,
+	ACP_SDW_BT_TX,
+	ACP_SDW_HS_TX,
+	ACP_SDW_AUDIO_RX,
+	ACP_SDW_BT_RX,
+	ACP_SDW_HS_RX,
+	ACP_SDW1_BT_TX,
+	ACP_SDW1_BT_RX,
+};
+
 struct pdm_stream_instance {
 	u16 num_pages;
 	u16 channels;
@@ -139,4 +182,22 @@ struct acp63_dev_data {
 struct sdw_dma_dev_data {
 	void __iomem *acp_base;
 	struct mutex *acp_lock;
+	struct snd_pcm_substream *sdw_stream[ACP63_SDW_MAX_STREAMS];
+};
+
+struct sdw_stream_instance {
+	u16 num_pages;
+	u16 channels;
+	u32 stream_id;
+	dma_addr_t dma_addr;
+	u64 bytescount;
+	void __iomem *acp_base;
+};
+
+union acp_sdw_dma_count {
+	struct {
+	u32 low;
+	u32 high;
+	} bcount;
+	u64 bytescount;
 };
diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index 388a4b7df715..e94f76053c66 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -12,12 +12,543 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
+#include <linux/soundwire/sdw_amd.h>
 #include "acp63.h"
 
 #define DRV_NAME "amd_ps_sdw_dma"
 
+static const struct snd_pcm_hardware acp63_sdw_hardware_playback = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
+		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	.channels_min = 2,
+	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_48000,
+	.rate_min = 48000,
+	.rate_max = 48000,
+	.buffer_bytes_max = SDW_PLAYBACK_MAX_NUM_PERIODS * SDW_PLAYBACK_MAX_PERIOD_SIZE,
+	.period_bytes_min = SDW_PLAYBACK_MIN_PERIOD_SIZE,
+	.period_bytes_max = SDW_PLAYBACK_MAX_PERIOD_SIZE,
+	.periods_min = SDW_PLAYBACK_MIN_NUM_PERIODS,
+	.periods_max = SDW_PLAYBACK_MAX_NUM_PERIODS,
+};
+
+static const struct snd_pcm_hardware acp63_sdw_hardware_capture = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
+		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	.channels_min = 2,
+	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_48000,
+	.rate_min = 48000,
+	.rate_max = 48000,
+	.buffer_bytes_max = SDW_CAPTURE_MAX_NUM_PERIODS * SDW_CAPTURE_MAX_PERIOD_SIZE,
+	.period_bytes_min = SDW_CAPTURE_MIN_PERIOD_SIZE,
+	.period_bytes_max = SDW_CAPTURE_MAX_PERIOD_SIZE,
+	.periods_min = SDW_CAPTURE_MIN_NUM_PERIODS,
+	.periods_max = SDW_CAPTURE_MAX_NUM_PERIODS,
+};
+
+static void acp63_config_dma(struct sdw_stream_instance *sdw_ins, u32 stream_id)
+{
+	u16 page_idx;
+	u32 low, high, val;
+	dma_addr_t addr;
+
+	addr = sdw_ins->dma_addr;
+	val = SDW_PTE_OFFSET + (stream_id * 256);
+
+	/* Group Enable */
+	acp63_writel(ACP_SDW_SRAM_PTE_OFFSET | BIT(31), sdw_ins->acp_base +
+		     ACPAXI2AXI_ATU_BASE_ADDR_GRP_2);
+	acp63_writel(PAGE_SIZE_4K_ENABLE, sdw_ins->acp_base +
+		     ACPAXI2AXI_ATU_PAGE_SIZE_GRP_2);
+	for (page_idx = 0; page_idx < sdw_ins->num_pages; page_idx++) {
+		/* Load the low address of page int ACP SRAM through SRBM */
+		low = lower_32_bits(addr);
+		high = upper_32_bits(addr);
+
+		acp63_writel(low, sdw_ins->acp_base + ACP_SCRATCH_REG_0 + val);
+		high |= BIT(31);
+		acp63_writel(high, sdw_ins->acp_base + ACP_SCRATCH_REG_0 + val + 4);
+		val += 8;
+		addr += PAGE_SIZE;
+	}
+
+	/*cache Invalidation added for Testing */
+	acp63_writel(0x1, sdw_ins->acp_base + ACPAXI2AXI_ATU_CTRL);
+}
+
+static int acp63_configure_sdw_ringbuffer(void __iomem *acp_base, u32 stream_id, u32 size)
+{
+	u32 reg_dma_size;
+	u32 reg_fifo_addr;
+	u32 reg_fifo_size;
+	u32 reg_ring_buf_size;
+	u32 reg_ring_buf_addr;
+	u32 sdw_fifo_addr;
+	u32 sdw_ring_buf_addr;
+	u32 sdw_ring_buf_size;
+
+	switch (stream_id) {
+	case ACP_SDW_AUDIO_TX:
+		reg_dma_size = ACP_AUDIO_TX_DMA_SIZE;
+		reg_fifo_addr =	ACP_AUDIO_TX_FIFOADDR;
+		reg_fifo_size = ACP_AUDIO_TX_FIFOSIZE;
+		reg_ring_buf_size = ACP_AUDIO_TX_RINGBUFSIZE;
+		reg_ring_buf_addr = ACP_AUDIO_TX_RINGBUFADDR;
+		break;
+	case ACP_SDW_BT_TX:
+		reg_dma_size = ACP_BT_TX_DMA_SIZE;
+		reg_fifo_addr = ACP_BT_TX_FIFOADDR;
+		reg_fifo_size = ACP_BT_TX_FIFOSIZE;
+		reg_ring_buf_size = ACP_BT_TX_RINGBUFSIZE;
+		reg_ring_buf_addr = ACP_BT_TX_RINGBUFADDR;
+		break;
+	case ACP_SDW_HS_TX:
+		reg_dma_size = ACP_HS_TX_DMA_SIZE;
+		reg_fifo_addr = ACP_HS_TX_FIFOADDR;
+		reg_fifo_size = ACP_HS_TX_FIFOSIZE;
+		reg_ring_buf_size = ACP_HS_TX_RINGBUFSIZE;
+		reg_ring_buf_addr = ACP_HS_TX_RINGBUFADDR;
+		break;
+	case ACP_SDW1_BT_TX:
+		reg_dma_size = ACP_P1_BT_TX_DMA_SIZE;
+		reg_fifo_addr = ACP_P1_BT_TX_FIFOADDR;
+		reg_fifo_size = ACP_P1_BT_TX_FIFOSIZE;
+		reg_ring_buf_size = ACP_P1_BT_TX_RINGBUFSIZE;
+		reg_ring_buf_addr = ACP_P1_BT_TX_RINGBUFADDR;
+		break;
+	case ACP_SDW_AUDIO_RX:
+		reg_dma_size = ACP_AUDIO_RX_DMA_SIZE;
+		reg_fifo_addr = ACP_AUDIO_RX_FIFOADDR;
+		reg_fifo_size = ACP_AUDIO_RX_FIFOSIZE;
+		reg_ring_buf_size = ACP_AUDIO_RX_RINGBUFSIZE;
+		reg_ring_buf_addr = ACP_AUDIO_RX_RINGBUFADDR;
+		break;
+	case ACP_SDW_BT_RX:
+		reg_dma_size = ACP_BT_RX_DMA_SIZE;
+		reg_fifo_addr = ACP_BT_RX_FIFOADDR;
+		reg_fifo_size = ACP_BT_RX_FIFOSIZE;
+		reg_ring_buf_size = ACP_BT_RX_RINGBUFSIZE;
+		reg_ring_buf_addr = ACP_BT_RX_RINGBUFADDR;
+		break;
+	case ACP_SDW_HS_RX:
+		reg_dma_size = ACP_HS_RX_DMA_SIZE;
+		reg_fifo_addr = ACP_HS_RX_FIFOADDR;
+		reg_fifo_size = ACP_HS_RX_FIFOSIZE;
+		reg_ring_buf_size = ACP_HS_RX_RINGBUFSIZE;
+		reg_ring_buf_addr = ACP_HS_RX_RINGBUFADDR;
+		break;
+	case ACP_SDW1_BT_RX:
+		reg_dma_size = ACP_P1_BT_RX_DMA_SIZE;
+		reg_fifo_addr = ACP_P1_BT_RX_FIFOADDR;
+		reg_fifo_size = ACP_P1_BT_RX_FIFOSIZE;
+		reg_ring_buf_size = ACP_P1_BT_RX_RINGBUFSIZE;
+		reg_ring_buf_addr = ACP_P1_BT_RX_RINGBUFADDR;
+		break;
+	default:
+		return -EINVAL;
+	}
+	sdw_fifo_addr = ACP_SDW_FIFO_OFFSET * stream_id;
+	sdw_ring_buf_addr = SDW_MEM_WINDOW_START + (stream_id * ACP_SDW_RING_BUFF_ADDR_OFFSET);
+	sdw_ring_buf_size = size;
+	acp63_writel(sdw_ring_buf_size, acp_base + reg_ring_buf_size);
+	acp63_writel(sdw_ring_buf_addr, acp_base + reg_ring_buf_addr);
+	acp63_writel(sdw_fifo_addr, acp_base + reg_fifo_addr);
+	acp63_writel(SDW_DMA_SIZE, acp_base + reg_dma_size);
+	acp63_writel(SDW_FIFO_SIZE, acp_base + reg_fifo_size);
+	return 0;
+}
+
+static int acp63_sdw_dma_open(struct snd_soc_component *component,
+			      struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+	struct sdw_dma_dev_data *sdw_dev_data;
+	struct sdw_stream_instance *sdw_stream_data;
+	struct snd_soc_dai *cpu_dai;
+	struct amd_sdwc_ctrl *ctrl;
+	struct snd_soc_pcm_runtime *prtd = substream->private_data;
+	int ret;
+
+	runtime = substream->runtime;
+	sdw_dev_data = dev_get_drvdata(component->dev);
+	cpu_dai = asoc_rtd_to_cpu(prtd, 0);
+	ctrl = snd_soc_dai_get_drvdata(cpu_dai);
+	sdw_stream_data = kzalloc(sizeof(*sdw_stream_data), GFP_KERNEL);
+	if (!sdw_stream_data)
+		return -EINVAL;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		runtime->hw = acp63_sdw_hardware_playback;
+	else
+		runtime->hw = acp63_sdw_hardware_capture;
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(component->dev, "set integer constraint failed\n");
+		kfree(sdw_stream_data);
+		return ret;
+	}
+
+	if (ctrl->instance == ACP_SDW1)
+		sdw_stream_data->stream_id = cpu_dai->id + ACP_SDW0_MAX_DAI;
+	else
+		sdw_stream_data->stream_id = cpu_dai->id;
+	sdw_stream_data->acp_base = sdw_dev_data->acp_base;
+	runtime->private_data = sdw_stream_data;
+	return ret;
+}
+
+static int acp63_sdw_dma_hw_params(struct snd_soc_component *component,
+				   struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct sdw_stream_instance *sdw_stream_data;
+	struct sdw_dma_dev_data *sdw_data;
+	u32 period_bytes;
+	u32 water_mark_size_reg;
+	u32 irq_mask, ext_intr_ctrl;
+	u64 size;
+	u32 stream_id;
+	u32 acp_ext_intr_cntl_reg;
+	int ret;
+
+	stream_id = 0;
+	sdw_data = dev_get_drvdata(component->dev);
+	sdw_stream_data = substream->runtime->private_data;
+	if (!sdw_stream_data)
+		return -EINVAL;
+	stream_id = sdw_stream_data->stream_id;
+	sdw_data->sdw_stream[stream_id] = substream;
+	size = params_buffer_bytes(params);
+	period_bytes = params_period_bytes(params);
+	sdw_stream_data->dma_addr = substream->runtime->dma_addr;
+	sdw_stream_data->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
+	acp63_config_dma(sdw_stream_data, stream_id);
+	ret = acp63_configure_sdw_ringbuffer(sdw_stream_data->acp_base, stream_id, size);
+	if (ret) {
+		dev_err(component->dev, "Invalid channel type\n");
+		return -EINVAL;
+	}
+	switch (stream_id) {
+	case ACP_SDW_AUDIO_TX:
+		water_mark_size_reg = ACP_AUDIO_TX_INTR_WATERMARK_SIZE;
+		irq_mask = BIT(ACP_AUDIO_TX_THRESHOLD);
+		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
+		break;
+	case ACP_SDW_BT_TX:
+		water_mark_size_reg = ACP_BT_TX_INTR_WATERMARK_SIZE;
+		irq_mask = BIT(ACP_BT_TX_THRESHOLD);
+		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
+		break;
+	case ACP_SDW_HS_TX:
+		water_mark_size_reg = ACP_HS_TX_INTR_WATERMARK_SIZE;
+		irq_mask = BIT(ACP_HS_TX_THRESHOLD);
+		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
+		break;
+	case ACP_SDW1_BT_TX:
+		water_mark_size_reg = ACP_P1_BT_TX_INTR_WATERMARK_SIZE;
+		irq_mask = BIT(ACP_P1_BT_TX_THRESHOLD);
+		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL1;
+		break;
+	case ACP_SDW_AUDIO_RX:
+		water_mark_size_reg = ACP_AUDIO_RX_INTR_WATERMARK_SIZE;
+		irq_mask = BIT(ACP_AUDIO_RX_THRESHOLD);
+		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
+		break;
+	case ACP_SDW_BT_RX:
+		water_mark_size_reg = ACP_BT_RX_INTR_WATERMARK_SIZE;
+		irq_mask = BIT(ACP_BT_RX_THRESHOLD);
+		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
+		break;
+	case ACP_SDW_HS_RX:
+		water_mark_size_reg = ACP_HS_RX_INTR_WATERMARK_SIZE;
+		irq_mask = BIT(ACP_HS_RX_THRESHOLD);
+		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
+		break;
+	case ACP_SDW1_BT_RX:
+		water_mark_size_reg = ACP_P1_BT_RX_INTR_WATERMARK_SIZE;
+		irq_mask = BIT(ACP_P1_BT_RX_THRESHOLD);
+		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL1;
+		break;
+	default:
+		dev_err(component->dev, "%s: Invalid channel type\n", __func__);
+		return -EINVAL;
+	}
+
+	ext_intr_ctrl = acp63_readl(sdw_stream_data->acp_base + acp_ext_intr_cntl_reg);
+	ext_intr_ctrl |= irq_mask;
+	acp63_writel(ext_intr_ctrl, sdw_stream_data->acp_base + acp_ext_intr_cntl_reg);
+	acp63_writel(period_bytes, sdw_stream_data->acp_base + water_mark_size_reg);
+	return 0;
+}
+
+static u64 acp63_sdw_get_byte_count(struct sdw_stream_instance *rtd)
+{
+	union acp_sdw_dma_count byte_count;
+	u32 pos_low_reg, pos_high_reg;
+
+	byte_count.bytescount = 0;
+	switch (rtd->stream_id) {
+	case ACP_SDW_AUDIO_TX:
+		pos_low_reg = ACP_AUDIO_TX_LINEARPOSITIONCNTR_LOW;
+		pos_high_reg = ACP_AUDIO_TX_LINEARPOSITIONCNTR_HIGH;
+		break;
+	case ACP_SDW_BT_TX:
+		pos_low_reg = ACP_BT_TX_LINEARPOSITIONCNTR_LOW;
+		pos_high_reg = ACP_BT_TX_LINEARPOSITIONCNTR_HIGH;
+		break;
+	case ACP_SDW_HS_TX:
+		pos_low_reg = ACP_HS_TX_LINEARPOSITIONCNTR_LOW;
+		pos_high_reg = ACP_HS_TX_LINEARPOSITIONCNTR_HIGH;
+		break;
+	case ACP_SDW1_BT_TX:
+		pos_low_reg = ACP_P1_BT_TX_LINEARPOSITIONCNTR_LOW;
+		pos_high_reg = ACP_P1_BT_TX_LINEARPOSITIONCNTR_HIGH;
+		break;
+	case ACP_SDW_AUDIO_RX:
+		pos_low_reg = ACP_AUDIO_RX_LINEARPOSITIONCNTR_LOW;
+		pos_high_reg = ACP_AUDIO_RX_LINEARPOSITIONCNTR_HIGH;
+		break;
+	case ACP_SDW_BT_RX:
+		pos_low_reg = ACP_BT_RX_LINEARPOSITIONCNTR_LOW;
+		pos_high_reg = ACP_BT_RX_LINEARPOSITIONCNTR_HIGH;
+		break;
+	case ACP_SDW_HS_RX:
+		pos_low_reg = ACP_HS_RX_LINEARPOSITIONCNTR_LOW;
+		pos_high_reg = ACP_HS_RX_LINEARPOSITIONCNTR_HIGH;
+		break;
+	case ACP_SDW1_BT_RX:
+		pos_low_reg = ACP_P1_BT_RX_LINEARPOSITIONCNTR_LOW;
+		pos_high_reg = ACP_P1_BT_RX_LINEARPOSITIONCNTR_HIGH;
+		break;
+	default:
+		pr_err("%s Invalid stream id:%d\n", __func__, rtd->stream_id);
+		return -EINVAL;
+	}
+
+	if (pos_low_reg) {
+		byte_count.bcount.high = acp63_readl(rtd->acp_base + pos_high_reg);
+		byte_count.bcount.low = acp63_readl(rtd->acp_base + pos_low_reg);
+	}
+	return byte_count.bytescount;
+}
+
+static snd_pcm_uframes_t acp63_sdw_dma_pointer(struct snd_soc_component *comp,
+					       struct snd_pcm_substream *stream)
+{
+	struct sdw_stream_instance *sdw_ins;
+	u32 pos, buffersize;
+	u64 bytescount;
+
+	sdw_ins = stream->runtime->private_data;
+	buffersize = frames_to_bytes(stream->runtime,
+				     stream->runtime->buffer_size);
+	bytescount = acp63_sdw_get_byte_count(sdw_ins);
+	if (bytescount > sdw_ins->bytescount)
+		bytescount -= sdw_ins->bytescount;
+	pos = do_div(bytescount, buffersize);
+	return bytes_to_frames(stream->runtime, pos);
+}
+
+static int acp63_sdw_dma_new(struct snd_soc_component *component,
+			     struct snd_soc_pcm_runtime *rtd)
+{
+	struct device *parent = component->dev->parent;
+
+	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
+				       parent, SDW_MIN_BUFFER, SDW_MAX_BUFFER);
+	return 0;
+}
+
+static int acp63_sdw_dma_close(struct snd_soc_component *component,
+			       struct snd_pcm_substream *substream)
+{
+	struct sdw_dma_dev_data *sdw_dma_data;
+	struct snd_soc_pcm_runtime *prtd;
+	struct sdw_stream_instance *sdw_ins;
+
+	prtd = asoc_substream_to_rtd(substream);
+	component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	sdw_dma_data = dev_get_drvdata(component->dev);
+	sdw_ins = substream->runtime->private_data;
+	if (!sdw_ins)
+		return -EINVAL;
+	sdw_dma_data->sdw_stream[sdw_ins->stream_id] = NULL;
+	kfree(sdw_ins);
+	return 0;
+}
+
+static int acp63_sdw_dma_start(struct snd_pcm_substream *stream)
+{
+	struct sdw_stream_instance *sdw_ins;
+	struct snd_soc_pcm_runtime *prtd;
+	u32 stream_id;
+	u32 sdw_dma_reg;
+	u32 sdw_dma_en_stat_reg;
+	u32 sdw_dma_stat;
+	u32 val;
+	int timeout = 0;
+
+	sdw_ins = stream->runtime->private_data;
+	prtd = stream->private_data;
+	stream_id = sdw_ins->stream_id;
+	switch (stream_id) {
+	case ACP_SDW_AUDIO_TX:
+		sdw_dma_reg = ACP_SW_AUDIO_TX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_AUDIO_TX_EN_STATUS;
+		break;
+	case ACP_SDW_BT_TX:
+		sdw_dma_reg = ACP_SW_BT_TX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_BT_TX_EN_STATUS;
+		break;
+	case ACP_SDW_HS_TX:
+		sdw_dma_reg = ACP_SW_HEADSET_TX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_HEADSET_TX_EN_STATUS;
+		break;
+	case ACP_SDW1_BT_TX:
+		sdw_dma_reg = ACP_P1_SW_BT_TX_EN;
+		sdw_dma_en_stat_reg = ACP_P1_SW_BT_TX_EN_STATUS;
+		break;
+	case ACP_SDW_AUDIO_RX:
+		sdw_dma_reg = ACP_SW_AUDIO_RX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_AUDIO_RX_EN_STATUS;
+		break;
+	case ACP_SDW_BT_RX:
+		sdw_dma_reg = ACP_SW_BT_RX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_BT_RX_EN_STATUS;
+		break;
+	case ACP_SDW_HS_RX:
+		sdw_dma_reg = ACP_SW_HEADSET_RX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_HEADSET_RX_EN_STATUS;
+		break;
+	case ACP_SDW1_BT_RX:
+		sdw_dma_reg = ACP_P1_SW_BT_RX_EN;
+		sdw_dma_en_stat_reg = ACP_P1_SW_BT_RX_EN_STATUS;
+		break;
+	default:
+		return -EINVAL;
+	}
+	acp63_writel(0x01, sdw_ins->acp_base + sdw_dma_reg);
+	while (++timeout < ACP_COUNTER) {
+		sdw_dma_stat =  acp63_readl(sdw_ins->acp_base + sdw_dma_en_stat_reg);
+		if (sdw_dma_stat & BIT(0)) {
+			val = acp63_readl(sdw_ins->acp_base + sdw_dma_reg);
+			dev_dbg(prtd->dev, "%s stream_id:0x%x dma_reg[0x%x]:0x%x\n",
+				__func__, stream_id, sdw_dma_reg, val);
+			return 0;
+		}
+		udelay(ACP_DELAY_US);
+	}
+	return -ETIMEDOUT;
+}
+
+static int acp63_sdw_dma_stop(struct snd_pcm_substream *stream)
+{
+	struct sdw_stream_instance *sdw_ins;
+	struct snd_soc_pcm_runtime *prtd;
+	u32 stream_id;
+	u32 sdw_dma_reg;
+	u32 sdw_dma_en_stat_reg;
+	u32 sdw_dma_stat;
+	u32 val;
+	int timeout = 0;
+
+	prtd = stream->private_data;
+	sdw_ins = stream->runtime->private_data;
+	stream_id = sdw_ins->stream_id;
+	switch (stream_id) {
+	case ACP_SDW_AUDIO_TX:
+		sdw_dma_reg = ACP_SW_AUDIO_TX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_AUDIO_TX_EN_STATUS;
+		break;
+	case ACP_SDW_BT_TX:
+		sdw_dma_reg = ACP_SW_BT_TX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_BT_TX_EN_STATUS;
+		break;
+	case ACP_SDW_HS_TX:
+		sdw_dma_reg = ACP_SW_HEADSET_TX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_HEADSET_TX_EN_STATUS;
+		break;
+	case ACP_SDW1_BT_TX:
+		sdw_dma_reg = ACP_P1_SW_BT_TX_EN;
+		sdw_dma_en_stat_reg = ACP_P1_SW_BT_TX_EN_STATUS;
+		break;
+	case ACP_SDW_AUDIO_RX:
+		sdw_dma_reg = ACP_SW_AUDIO_RX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_AUDIO_RX_EN_STATUS;
+		break;
+	case ACP_SDW_BT_RX:
+		sdw_dma_reg = ACP_SW_BT_RX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_BT_RX_EN_STATUS;
+		break;
+	case ACP_SDW_HS_RX:
+		sdw_dma_reg = ACP_SW_HEADSET_RX_EN;
+		sdw_dma_en_stat_reg = ACP_SW_HEADSET_RX_EN_STATUS;
+		break;
+	case ACP_SDW1_BT_RX:
+		sdw_dma_reg = ACP_P1_SW_BT_RX_EN;
+		sdw_dma_en_stat_reg = ACP_P1_SW_BT_RX_EN_STATUS;
+		break;
+	default:
+		return -EINVAL;
+	}
+	acp63_writel(0, sdw_ins->acp_base + sdw_dma_reg);
+	while (++timeout < ACP_COUNTER) {
+		sdw_dma_stat =  acp63_readl(sdw_ins->acp_base + sdw_dma_en_stat_reg);
+		if (sdw_dma_stat == 0) {
+			val = acp63_readl(sdw_ins->acp_base + sdw_dma_reg);
+			dev_dbg(prtd->dev, "%s stream_id:0x%x dma_reg[0x%x]:0x%x\n",
+				__func__, stream_id, sdw_dma_reg, val);
+			return 0;
+		}
+		udelay(ACP_DELAY_US);
+	}
+	return -ETIMEDOUT;
+}
+
+static int acp63_sdw_dma_trigger(struct snd_soc_component *comp,
+				 struct snd_pcm_substream *substream,
+				 int cmd)
+{
+	int ret;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = acp63_sdw_dma_start(substream);
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		ret = acp63_sdw_dma_stop(substream);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	if (ret)
+		dev_err(comp->dev, "trigger %d failed: %d", cmd, ret);
+	return ret;
+}
+
 static const struct snd_soc_component_driver acp63_sdw_component = {
 	.name		= DRV_NAME,
+	.open		= acp63_sdw_dma_open,
+	.close		= acp63_sdw_dma_close,
+	.hw_params	= acp63_sdw_dma_hw_params,
+	.trigger	= acp63_sdw_dma_trigger,
+	.pointer	= acp63_sdw_dma_pointer,
+	.pcm_construct	= acp63_sdw_dma_new,
 };
 
 static int acp63_sdw_platform_probe(struct platform_device *pdev)
-- 
2.34.1

