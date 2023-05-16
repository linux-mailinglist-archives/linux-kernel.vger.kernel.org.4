Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2333D704A94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjEPKbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjEPKbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:31:18 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B64735A3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmIvUb3BpmBx9bQWST6Uikpwc2kzATSKm+HUMmM4DbJHfY0nPVlWZ4K2FE3qW/o0cqBGRIcsZwPZVrGrVjRHRN+QeA8tnPFhxE3TquCWZFeP1rEcHKAfqDh3qhvFbkO71ytDsQvuFI5kIYx9lsptyfnUits1Huwg+QvM/mS21Yo6ODz8zhaACI7+PEO/gYUo7mZFWAb89TJ2eaNyG5l6Ux/Nz8qZMG6/MoV0yXVCVZbjFhIhXU2Mi/QNw007ocMcFJ9JPFXzeY9uyhSu55mRGsgorZbrDHX5NhNUHZpOVLt9DjYqzZR++ZsnXd/+CyxHuOIpATA0OwHeNH7dsWKNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yes+JFu6NyqP0kMEdNxhUMfMV8CRoBvxwT0wqoP6f/o=;
 b=SDT0reZ7GBJB3ButAtUSaks/COC/EeZYLsxatntgzk76hYpgPOMkJAb11zpybP3qONJBjX00vF5V/SQKzkoZsr5YblCfTHtHMpPb+otnBL7C+q4EK4Nb8TSlIx4MxSoVVf+MIyQdyencEwhoqj2m/h8Jz9lqlSajnRf0sKDnlusdFkxuTNU81BezPJz+D7gAR1xQ5Et1tOqUd+c7URU71ku0j+lXwaDEnklJltKfAeOrK2+e2HaGKFovCset4blVCPyfc147RoeuEhqN9pKZ3obboUtmp+gIFRpJf8stfZlUehNC20B9v0Dvk3/o3tB+PLzZrW4o99Swwg3lbZWuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yes+JFu6NyqP0kMEdNxhUMfMV8CRoBvxwT0wqoP6f/o=;
 b=ihSoRGVNn0m7YByUReUOrjjcB7Metp+suCNShcXOj7Kc48RTbir3/BvEszo5t6yGtOjs060wCyrSxB/024aMRdI40CyN342DWUAgk4PioqOLGWrK7SW3JVPTTDCIWsLnHApnqmta5vuWCtBfLLSOC2+U9KnHbxOv0iUk+PAIMW4=
Received: from DS7PR03CA0321.namprd03.prod.outlook.com (2603:10b6:8:2b::6) by
 SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 10:31:05 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::7c) by DS7PR03CA0321.outlook.office365.com
 (2603:10b6:8:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 10:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:31:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:31:04 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 16 May 2023 05:31:01 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <--to=broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mastan.Katragadda@amd.com>,
        <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Syed Saba Kareem" <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/9] ASoC: amd: ps: add soundwire dma driver dma ops
Date:   Tue, 16 May 2023 16:05:38 +0530
Message-ID: <20230516103543.2515097-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 752800f5-22ee-43d3-e83c-08db55f8a7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHwKh3QWe0cJqtxf9DuSzOEMAgRlsePcjCbxhXOROjjbEBE4DIcHpSVeABdHJPOSMs8BeWzCpcTjlt6KNBfvz7ZcdYZIUL3rtWt/yu1pMpZDl6oWGBow15ENAna43yiJHaY/boTde1m8I4XzE4W3fBwhVZEyTljWTDYV3LZTihg7/92WTPLALk41NZQxLhqsoNuNKGTP521HQc7S8d8xkU12l7hEEsrPcufFoSUP54sDPiWLITQ3QFoi967rBstie7BGHagWVQGiN55uSw+uY21OZFDBUwimt7Mg8tWGZkfvwlT6plqJ7CbFUyE/iaipdxuFazElQkaky01hmEJDTmGWieuwh3+pI3Qibyk4/HP46Qg4AI+m59xWF8VcFliYvogHuCunIaBIDGK/HOGxN/tiYfBIQXo0A/rNB10ygdGRPWOO4TtPbARnPMSQqENZms8m+Ih8ifkwGCam5Uh9mo98L1JK/O+J1RTZfRr2kMM2cqxzGH1lqmejWiVwgImLAYiq965Yog7TV3pO6HH3oV1Iya1z0i3JJjaJ9t25tGStj48md9Z5Wn39hqMn1THmUZcG1gRcsHkdi4fv9eQNwkFN/tgCoVuAIiLv2FacTDNzgSSNFSgmwUOqhPEf+Pe983y6Duo2Z+FaSrGyJ/pQ/linRzILUG5DHZIX4s4I1DRwl2tQYJrTRxHCmlJLIWF8Umwa2NZzK0YizDzZgN8Tse67HodWmgm3Rbb/FEcelq2j6gUHCRKkBz3ERmuHLVbr4oEz5vTKXQ+ffxWlAuG9rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(186003)(36860700001)(26005)(1076003)(6666004)(2616005)(47076005)(83380400001)(7696005)(82310400005)(336012)(426003)(8936002)(8676002)(478600001)(36756003)(2906002)(40460700003)(54906003)(30864003)(5660300002)(81166007)(82740400003)(356005)(4326008)(41300700001)(70206006)(316002)(70586007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:31:05.6832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752800f5-22ee-43d3-e83c-08db55f8a7be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372
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

Add Soundwire DMA driver dma ops for Pink Sardine platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h      |  76 +++++++
 sound/soc/amd/ps/ps-sdw-dma.c | 417 ++++++++++++++++++++++++++++++++++
 2 files changed, 493 insertions(+)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index f86c60cd1565..7f8e1c76ba4f 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -70,6 +70,45 @@
 #define ACP_SDW0_IRQ_MASK		21
 #define ACP_SDW1_IRQ_MASK		2
 #define ACP_ERROR_IRQ_MASK		29
+#define ACP_AUDIO0_TX_THRESHOLD		28
+#define ACP_AUDIO1_TX_THRESHOLD		26
+#define ACP_AUDIO2_TX_THRESHOLD		24
+#define ACP_AUDIO0_RX_THRESHOLD		27
+#define ACP_AUDIO1_RX_THRESHOLD		25
+#define ACP_AUDIO2_RX_THRESHOLD		23
+#define ACP_P1_AUDIO1_TX_THRESHOLD	6
+#define ACP_P1_AUDIO1_RX_THRESHOLD	5
+#define ACP_SDW_DMA_IRQ_MASK		0x1F800000
+#define ACP_P1_SDW_DMA_IRQ_MASK		0x60
+#define ACP63_SDW0_DMA_MAX_STREAMS	6
+#define ACP63_SDW1_DMA_MAX_STREAMS	2
+#define SDW0_DMA_TX_IRQ_MASK(i)	(ACP_AUDIO0_TX_THRESHOLD - (2 * (i)))
+#define SDW0_DMA_RX_IRQ_MASK(i)	(ACP_AUDIO0_RX_THRESHOLD - (2 * (i)))
+#define SDW1_DMA_IRQ_MASK(i)	(ACP_P1_AUDIO1_TX_THRESHOLD - (i))
+
+#define ACP_DELAY_US		5
+#define ACP_SDW_RING_BUFF_ADDR_OFFSET (128 * 1024)
+#define SDW0_MEM_WINDOW_START	0x4800000
+#define ACP_SDW_SRAM_PTE_OFFSET	0x03800400
+#define SDW0_PTE_OFFSET		0x400
+#define SDW_FIFO_SIZE		0x100
+#define SDW_DMA_SIZE		0x40
+#define ACP_SDW0_FIFO_OFFSET	0x100
+#define SDW_PTE_OFFSET(i)	(SDW0_PTE_OFFSET + ((i) * 0x600))
+#define ACP_SDW_FIFO_OFFSET(i)	(ACP_SDW0_FIFO_OFFSET + ((i) * 0x500))
+#define SDW_MEM_WINDOW_START(i)	(SDW0_MEM_WINDOW_START + ((i) * 0xC0000))
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
@@ -114,6 +153,43 @@ struct pdm_dev_data {
 struct sdw_dma_dev_data {
 	void __iomem *acp_base;
 	struct mutex *acp_lock; /* used to protect acp common register access */
+	struct snd_pcm_substream *sdw0_dma_stream[ACP63_SDW0_DMA_MAX_STREAMS];
+	struct snd_pcm_substream *sdw1_dma_stream[ACP63_SDW1_DMA_MAX_STREAMS];
+};
+
+struct sdw_dma_stream_instance {
+	u16 num_pages;
+	u16 channels;
+	u32 stream_id;
+	u32 instance;
+	dma_addr_t dma_addr;
+	u64 bytescount;
+};
+
+union acp_sdw_dma_count {
+	struct {
+	u32 low;
+	u32 high;
+	} bcount;
+	u64 bytescount;
+};
+
+struct sdw_dma_ring_buf_reg {
+	u32 reg_dma_size;
+	u32 reg_fifo_addr;
+	u32 reg_fifo_size;
+	u32 reg_ring_buf_size;
+	u32 reg_ring_buf_addr;
+	u32 water_mark_size_reg;
+	u32 pos_low_reg;
+	u32 pos_high_reg;
+	u32 sdw_dma_en_reg;
+	u32 sdw_dma_en_stat_reg;
+};
+
+struct sdw_dma_enable_reg {
+	u32 sdw_dma_en_reg;
+	u32 sdw_dma_en_stat_reg;
 };
 
 /**
diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index 0d0889842413..5002ef16d980 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -12,12 +12,429 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
+#include <linux/soundwire/sdw_amd.h>
 #include "acp63.h"
 
 #define DRV_NAME "amd_ps_sdw_dma"
 
+static struct sdw_dma_ring_buf_reg sdw0_dma_ring_buf_reg[ACP63_SDW0_DMA_MAX_STREAMS] = {
+	{ACP_AUDIO0_TX_DMA_SIZE, ACP_AUDIO0_TX_FIFOADDR, ACP_AUDIO0_TX_FIFOSIZE,
+	 ACP_AUDIO0_TX_RINGBUFSIZE, ACP_AUDIO0_TX_RINGBUFADDR, ACP_AUDIO0_TX_INTR_WATERMARK_SIZE,
+	 ACP_AUDIO0_TX_LINEARPOSITIONCNTR_LOW, ACP_AUDIO0_TX_LINEARPOSITIONCNTR_HIGH},
+	{ACP_AUDIO1_TX_DMA_SIZE, ACP_AUDIO1_TX_FIFOADDR, ACP_AUDIO1_TX_FIFOSIZE,
+	 ACP_AUDIO1_TX_RINGBUFSIZE, ACP_AUDIO1_TX_RINGBUFADDR, ACP_AUDIO1_TX_INTR_WATERMARK_SIZE,
+	 ACP_AUDIO1_TX_LINEARPOSITIONCNTR_LOW, ACP_AUDIO1_TX_LINEARPOSITIONCNTR_HIGH},
+	{ACP_AUDIO2_TX_DMA_SIZE, ACP_AUDIO2_TX_FIFOADDR, ACP_AUDIO2_TX_FIFOSIZE,
+	 ACP_AUDIO2_TX_RINGBUFSIZE, ACP_AUDIO2_TX_RINGBUFADDR, ACP_AUDIO2_TX_INTR_WATERMARK_SIZE,
+	 ACP_AUDIO2_TX_LINEARPOSITIONCNTR_LOW, ACP_AUDIO2_TX_LINEARPOSITIONCNTR_HIGH},
+	{ACP_AUDIO0_RX_DMA_SIZE, ACP_AUDIO0_RX_FIFOADDR, ACP_AUDIO0_RX_FIFOSIZE,
+	 ACP_AUDIO0_RX_RINGBUFSIZE, ACP_AUDIO0_RX_RINGBUFADDR, ACP_AUDIO0_RX_INTR_WATERMARK_SIZE,
+	 ACP_AUDIO0_TX_LINEARPOSITIONCNTR_LOW, ACP_AUDIO0_TX_LINEARPOSITIONCNTR_HIGH},
+	{ACP_AUDIO1_RX_DMA_SIZE, ACP_AUDIO1_RX_FIFOADDR, ACP_AUDIO1_RX_FIFOSIZE,
+	 ACP_AUDIO1_RX_RINGBUFSIZE, ACP_AUDIO1_RX_RINGBUFADDR, ACP_AUDIO1_RX_INTR_WATERMARK_SIZE,
+	 ACP_AUDIO1_RX_LINEARPOSITIONCNTR_LOW, ACP_AUDIO1_RX_LINEARPOSITIONCNTR_HIGH},
+	{ACP_AUDIO2_RX_DMA_SIZE, ACP_AUDIO2_RX_FIFOADDR, ACP_AUDIO2_RX_FIFOSIZE,
+	 ACP_AUDIO2_RX_RINGBUFSIZE, ACP_AUDIO2_RX_RINGBUFADDR, ACP_AUDIO2_RX_INTR_WATERMARK_SIZE,
+	 ACP_AUDIO2_RX_LINEARPOSITIONCNTR_LOW, ACP_AUDIO2_RX_LINEARPOSITIONCNTR_HIGH}
+};
+
+static struct sdw_dma_ring_buf_reg sdw1_dma_ring_buf_reg[ACP63_SDW1_DMA_MAX_STREAMS] =  {
+	{ACP_P1_AUDIO1_TX_DMA_SIZE, ACP_P1_AUDIO1_TX_FIFOADDR, ACP_P1_AUDIO1_TX_FIFOSIZE,
+	 ACP_P1_AUDIO1_TX_RINGBUFSIZE, ACP_P1_AUDIO1_TX_RINGBUFADDR,
+	 ACP_P1_AUDIO1_TX_INTR_WATERMARK_SIZE,
+	 ACP_P1_AUDIO1_TX_LINEARPOSITIONCNTR_LOW, ACP_P1_AUDIO1_TX_LINEARPOSITIONCNTR_HIGH},
+	{ACP_P1_AUDIO1_RX_DMA_SIZE, ACP_P1_AUDIO1_RX_FIFOADDR, ACP_P1_AUDIO1_RX_FIFOSIZE,
+	 ACP_P1_AUDIO1_RX_RINGBUFSIZE, ACP_P1_AUDIO1_RX_RINGBUFADDR,
+	 ACP_P1_AUDIO1_RX_INTR_WATERMARK_SIZE,
+	 ACP_P1_AUDIO1_RX_LINEARPOSITIONCNTR_LOW, ACP_P1_AUDIO1_RX_LINEARPOSITIONCNTR_HIGH},
+};
+
+static struct sdw_dma_enable_reg sdw0_dma_enable_reg[ACP63_SDW0_DMA_MAX_STREAMS] = {
+	{ACP_SW0_AUDIO0_TX_EN, ACP_SW0_AUDIO0_TX_EN_STATUS},
+	{ACP_SW0_AUDIO1_TX_EN, ACP_SW0_AUDIO1_TX_EN_STATUS},
+	{ACP_SW0_AUDIO2_TX_EN, ACP_SW0_AUDIO2_TX_EN_STATUS},
+	{ACP_SW0_AUDIO0_RX_EN, ACP_SW0_AUDIO0_RX_EN_STATUS},
+	{ACP_SW0_AUDIO1_RX_EN, ACP_SW0_AUDIO1_RX_EN_STATUS},
+	{ACP_SW0_AUDIO2_RX_EN, ACP_SW0_AUDIO2_RX_EN_STATUS},
+};
+
+static struct sdw_dma_enable_reg sdw1_dma_enable_reg[ACP63_SDW1_DMA_MAX_STREAMS] = {
+	{ACP_SW1_AUDIO1_TX_EN, ACP_SW1_AUDIO1_TX_EN_STATUS},
+	{ACP_SW1_AUDIO1_RX_EN, ACP_SW1_AUDIO1_RX_EN_STATUS},
+};
+
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
+static void acp63_config_dma(struct sdw_dma_stream_instance *sdw_ins, void __iomem *acp_base,
+			     u32 stream_id)
+{
+	u16 page_idx;
+	u32 low, high, val;
+	u32 sdw_dma_pte_offset;
+	dma_addr_t addr;
+
+	addr = sdw_ins->dma_addr;
+	sdw_dma_pte_offset = SDW_PTE_OFFSET(sdw_ins->instance);
+	val = sdw_dma_pte_offset + (stream_id * 256);
+
+	/* Group Enable */
+	writel(ACP_SDW_SRAM_PTE_OFFSET | BIT(31), acp_base + ACPAXI2AXI_ATU_BASE_ADDR_GRP_2);
+	writel(PAGE_SIZE_4K_ENABLE, acp_base + ACPAXI2AXI_ATU_PAGE_SIZE_GRP_2);
+	for (page_idx = 0; page_idx < sdw_ins->num_pages; page_idx++) {
+		/* Load the low address of page int ACP SRAM through SRBM */
+		low = lower_32_bits(addr);
+		high = upper_32_bits(addr);
+
+		writel(low, acp_base + ACP_SCRATCH_REG_0 + val);
+		high |= BIT(31);
+		writel(high, acp_base + ACP_SCRATCH_REG_0 + val + 4);
+		val += 8;
+		addr += PAGE_SIZE;
+	}
+	writel(0x1, acp_base + ACPAXI2AXI_ATU_CTRL);
+}
+
+static int acp63_configure_sdw_ringbuffer(void __iomem *acp_base, u32 stream_id, u32 size,
+					  u32 manager_instance)
+{
+	u32 reg_dma_size;
+	u32 reg_fifo_addr;
+	u32 reg_fifo_size;
+	u32 reg_ring_buf_size;
+	u32 reg_ring_buf_addr;
+	u32 sdw_fifo_addr;
+	u32 sdw_fifo_offset;
+	u32 sdw_ring_buf_addr;
+	u32 sdw_ring_buf_size;
+	u32 sdw_mem_window_offset;
+
+	switch (manager_instance) {
+	case ACP_SDW0:
+		reg_dma_size = sdw0_dma_ring_buf_reg[stream_id].reg_dma_size;
+		reg_fifo_addr =	sdw0_dma_ring_buf_reg[stream_id].reg_fifo_addr;
+		reg_fifo_size = sdw0_dma_ring_buf_reg[stream_id].reg_fifo_size;
+		reg_ring_buf_size = sdw0_dma_ring_buf_reg[stream_id].reg_ring_buf_size;
+		reg_ring_buf_addr = sdw0_dma_ring_buf_reg[stream_id].reg_ring_buf_addr;
+		break;
+	case ACP_SDW1:
+		reg_dma_size = sdw1_dma_ring_buf_reg[stream_id].reg_dma_size;
+		reg_fifo_addr =	sdw1_dma_ring_buf_reg[stream_id].reg_fifo_addr;
+		reg_fifo_size = sdw1_dma_ring_buf_reg[stream_id].reg_fifo_size;
+		reg_ring_buf_size = sdw1_dma_ring_buf_reg[stream_id].reg_ring_buf_size;
+		reg_ring_buf_addr = sdw1_dma_ring_buf_reg[stream_id].reg_ring_buf_addr;
+		break;
+	default:
+		return -EINVAL;
+	}
+	sdw_fifo_offset = ACP_SDW_FIFO_OFFSET(manager_instance);
+	sdw_mem_window_offset = SDW_MEM_WINDOW_START(manager_instance);
+	sdw_fifo_addr = sdw_fifo_offset + (stream_id * 256);
+	sdw_ring_buf_addr = sdw_mem_window_offset + (stream_id * ACP_SDW_RING_BUFF_ADDR_OFFSET);
+	sdw_ring_buf_size = size;
+	writel(sdw_ring_buf_size, acp_base + reg_ring_buf_size);
+	writel(sdw_ring_buf_addr, acp_base + reg_ring_buf_addr);
+	writel(sdw_fifo_addr, acp_base + reg_fifo_addr);
+	writel(SDW_DMA_SIZE, acp_base + reg_dma_size);
+	writel(SDW_FIFO_SIZE, acp_base + reg_fifo_size);
+	return 0;
+}
+
+static int acp63_sdw_dma_open(struct snd_soc_component *component,
+			      struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+	struct sdw_dma_stream_instance *sdw_ins;
+	struct snd_soc_dai *cpu_dai;
+	struct amd_sdw_manager *amd_manager;
+	struct snd_soc_pcm_runtime *prtd = substream->private_data;
+	int ret;
+
+	runtime = substream->runtime;
+	cpu_dai = asoc_rtd_to_cpu(prtd, 0);
+	amd_manager = snd_soc_dai_get_drvdata(cpu_dai);
+	sdw_ins = kzalloc(sizeof(*sdw_ins), GFP_KERNEL);
+	if (!sdw_ins)
+		return -ENOMEM;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		runtime->hw = acp63_sdw_hardware_playback;
+	else
+		runtime->hw = acp63_sdw_hardware_capture;
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(component->dev, "set integer constraint failed\n");
+		kfree(sdw_ins);
+		return ret;
+	}
+
+	sdw_ins->stream_id = cpu_dai->id;
+	sdw_ins->instance = amd_manager->instance;
+	runtime->private_data = sdw_ins;
+	return ret;
+}
+
+static int acp63_sdw_dma_hw_params(struct snd_soc_component *component,
+				   struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct sdw_dma_stream_instance *sdw_ins;
+	struct sdw_dma_dev_data *sdw_data;
+	u32 period_bytes;
+	u32 water_mark_size_reg;
+	u32 irq_mask, ext_intr_ctrl;
+	u64 size;
+	u32 stream_id;
+	u32 acp_ext_intr_cntl_reg;
+	int ret;
+
+	sdw_data = dev_get_drvdata(component->dev);
+	sdw_ins = substream->runtime->private_data;
+	if (!sdw_ins)
+		return -EINVAL;
+	stream_id = sdw_ins->stream_id;
+	switch (sdw_ins->instance) {
+	case ACP_SDW0:
+		sdw_data->sdw0_dma_stream[stream_id] = substream;
+		water_mark_size_reg = sdw0_dma_ring_buf_reg[stream_id].water_mark_size_reg;
+		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			irq_mask = BIT(SDW0_DMA_TX_IRQ_MASK(stream_id));
+		else
+			irq_mask = BIT(SDW0_DMA_RX_IRQ_MASK(stream_id));
+		break;
+	case ACP_SDW1:
+		sdw_data->sdw1_dma_stream[stream_id] = substream;
+		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL1;
+		water_mark_size_reg = sdw1_dma_ring_buf_reg[stream_id].water_mark_size_reg;
+		irq_mask = BIT(SDW1_DMA_IRQ_MASK(stream_id));
+		break;
+	default:
+		return -EINVAL;
+	}
+	size = params_buffer_bytes(params);
+	period_bytes = params_period_bytes(params);
+	sdw_ins->dma_addr = substream->runtime->dma_addr;
+	sdw_ins->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
+	acp63_config_dma(sdw_ins, sdw_data->acp_base, stream_id);
+	ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, stream_id, size,
+					     sdw_ins->instance);
+	if (ret) {
+		dev_err(component->dev, "Invalid DMA channel\n");
+		return -EINVAL;
+	}
+	ext_intr_ctrl = readl(sdw_data->acp_base + acp_ext_intr_cntl_reg);
+	ext_intr_ctrl |= irq_mask;
+	writel(ext_intr_ctrl, sdw_data->acp_base + acp_ext_intr_cntl_reg);
+	writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
+	return 0;
+}
+
+static u64 acp63_sdw_get_byte_count(struct sdw_dma_stream_instance *sdw_ins, void __iomem *acp_base)
+{
+	union acp_sdw_dma_count byte_count;
+	u32 pos_low_reg, pos_high_reg;
+
+	byte_count.bytescount = 0;
+	switch (sdw_ins->instance) {
+	case ACP_SDW0:
+		pos_low_reg = sdw0_dma_ring_buf_reg[sdw_ins->stream_id].pos_low_reg;
+		pos_high_reg = sdw0_dma_ring_buf_reg[sdw_ins->stream_id].pos_high_reg;
+		break;
+	case ACP_SDW1:
+		pos_low_reg = sdw1_dma_ring_buf_reg[sdw_ins->stream_id].pos_low_reg;
+		pos_high_reg = sdw1_dma_ring_buf_reg[sdw_ins->stream_id].pos_high_reg;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (pos_low_reg) {
+		byte_count.bcount.high = readl(acp_base + pos_high_reg);
+		byte_count.bcount.low = readl(acp_base + pos_low_reg);
+	}
+	return byte_count.bytescount;
+}
+
+static snd_pcm_uframes_t acp63_sdw_dma_pointer(struct snd_soc_component *comp,
+					       struct snd_pcm_substream *stream)
+{
+	struct sdw_dma_dev_data *sdw_data;
+	struct sdw_dma_stream_instance *sdw_ins;
+	u32 pos, buffersize;
+	u64 bytescount;
+
+	sdw_data = dev_get_drvdata(comp->dev);
+	sdw_ins = stream->runtime->private_data;
+	buffersize = frames_to_bytes(stream->runtime,
+				     stream->runtime->buffer_size);
+	bytescount = acp63_sdw_get_byte_count(sdw_ins, sdw_data->acp_base);
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
+	struct sdw_dma_dev_data *sdw_data;
+	struct sdw_dma_stream_instance *sdw_ins;
+
+	sdw_data = dev_get_drvdata(component->dev);
+	sdw_ins = substream->runtime->private_data;
+	if (!sdw_ins)
+		return -EINVAL;
+	switch (sdw_ins->instance) {
+	case ACP_SDW0:
+		sdw_data->sdw0_dma_stream[sdw_ins->stream_id] = NULL;
+		break;
+	case ACP_SDW1:
+		sdw_data->sdw1_dma_stream[sdw_ins->stream_id] = NULL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	kfree(sdw_ins);
+	return 0;
+}
+
+static int acp63_sdw_dma_start(struct snd_pcm_substream *stream, void __iomem *acp_base)
+{
+	struct sdw_dma_stream_instance *sdw_ins;
+	u32 stream_id;
+	u32 sdw_dma_en_reg;
+	u32 sdw_dma_en_stat_reg;
+	u32 sdw_dma_stat;
+
+	sdw_ins = stream->runtime->private_data;
+	stream_id = sdw_ins->stream_id;
+	switch (sdw_ins->instance) {
+	case ACP_SDW0:
+		sdw_dma_en_reg = sdw0_dma_enable_reg[stream_id].sdw_dma_en_reg;
+		sdw_dma_en_stat_reg = sdw0_dma_enable_reg[stream_id].sdw_dma_en_stat_reg;
+		break;
+	case ACP_SDW1:
+		sdw_dma_en_reg = sdw1_dma_enable_reg[stream_id].sdw_dma_en_reg;
+		sdw_dma_en_stat_reg = sdw1_dma_enable_reg[stream_id].sdw_dma_en_stat_reg;
+		break;
+	default:
+		return -EINVAL;
+	}
+	writel(0x01, acp_base + sdw_dma_en_reg);
+	return readl_poll_timeout(acp_base + sdw_dma_en_stat_reg, sdw_dma_stat,
+				  (sdw_dma_stat & BIT(0)), ACP_DELAY_US, ACP_COUNTER);
+}
+
+static int acp63_sdw_dma_stop(struct snd_pcm_substream *stream, void __iomem *acp_base)
+{
+	struct sdw_dma_stream_instance *sdw_ins;
+	u32 stream_id;
+	u32 sdw_dma_en_reg;
+	u32 sdw_dma_en_stat_reg;
+	u32 sdw_dma_stat;
+
+	sdw_ins = stream->runtime->private_data;
+	stream_id = sdw_ins->stream_id;
+	switch (sdw_ins->instance) {
+	case ACP_SDW0:
+		sdw_dma_en_reg = sdw0_dma_enable_reg[stream_id].sdw_dma_en_reg;
+		sdw_dma_en_stat_reg = sdw0_dma_enable_reg[stream_id].sdw_dma_en_stat_reg;
+		break;
+	case ACP_SDW1:
+		sdw_dma_en_reg = sdw1_dma_enable_reg[stream_id].sdw_dma_en_reg;
+		sdw_dma_en_stat_reg = sdw1_dma_enable_reg[stream_id].sdw_dma_en_stat_reg;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel(0, acp_base + sdw_dma_en_reg);
+	return readl_poll_timeout(acp_base + sdw_dma_en_stat_reg, sdw_dma_stat, !sdw_dma_stat,
+				  ACP_DELAY_US, ACP_COUNTER);
+}
+
+static int acp63_sdw_dma_trigger(struct snd_soc_component *comp,
+				 struct snd_pcm_substream *substream,
+				 int cmd)
+{
+	struct sdw_dma_dev_data *sdw_data;
+	int ret;
+
+	sdw_data = dev_get_drvdata(comp->dev);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = acp63_sdw_dma_start(substream, sdw_data->acp_base);
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		ret = acp63_sdw_dma_stop(substream, sdw_data->acp_base);
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

