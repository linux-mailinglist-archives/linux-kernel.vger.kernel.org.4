Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393F572BE8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjFLKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjFLKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:13:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83FE4C13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzmKK1oZQhNDYCChof991RkL6sCzCDdY9JWOPQmEH59u2QzJS1dw0OrunihFVqZ8RkJiNc2Ula1z106/yK9bA/JjcrUrzbkB8p3d/63ivhxABJNqOQDQp8ZRBOIYcWYBgZD+5zzYJi5D7Pr74CtSzTQ4yJaureXRNl9RAM+GN1szTH7dvheRRj2XaGaS9rJT3TGXnAXJf3/7QDp9R0vKTWGE+gOft6FE2K2/eJROLVwX5CmaPxwSXxOGiSUiiyWrzKyGKlwX9Qk5Af74POoLtrxK3OvI+EFCsMHOFgQqf3Jay0+Zckjbjsr0GWi9HjXADeQhDhn10/+eediTVu6x6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckipioYbPDPwM6XSjV5alveyWtwDOgYBO7PeNsIB8qs=;
 b=cK+5WEAUQrJMDqosovGIASSUyB/0wsCWOP2DbKu7PkW9EI1ew64XWJiSIOG7HgjOPiX3D6kikSKruoehWWDBX90kvL6k1c9stwzW53lLaQ9oButtV6t9LZmdGJngisfy3bVTLlb66nBIOJTO7FZxniOMzFFSIACQkvoBhuQU1JTGjE4qOKYA0AlveFhIOqzdAa18fB3uY89lp4Ym4Oq42c3T+eOJ0BKKR4iIj2uaBVxCvRKwGaq07rV6l29b4LI+NSDBkqT/V9TfgQDgc7DxQkKRbSPStdcRKekRV7+PrXUlnLp0bhEtJFjX7+BOrCQ9Wp6m+/yQesOwyc+gBPEoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckipioYbPDPwM6XSjV5alveyWtwDOgYBO7PeNsIB8qs=;
 b=GKV9IIDWn4A+g9Aw/Ojc55NnCAw4bOFxTU2vmOSa9GAWZ8LytJPIVcUHpHZgZZzYe0KJKFLk1E6VIvGaWWwSGI3mRdv63C3joMtzSJQ5UUS9+WUlD+MCh+IWcrlP7kNkUpOxwHb0HEMDduQaePEBPbxmuxvi5d8XvTcQ0bd1gYA=
Received: from DM6PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:100::40)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 09:55:25 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::e9) by DM6PR03CA0063.outlook.office365.com
 (2603:10b6:5:100::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 09:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 09:55:24 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 04:55:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 12 Jun
 2023 02:55:16 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 12 Jun 2023 04:55:13 -0500
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
Subject: [PATCH V4 4/9] ASoC: amd: ps: add SoundWire dma driver dma ops
Date:   Mon, 12 Jun 2023 15:28:58 +0530
Message-ID: <20230612095903.2113464-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 844077d6-fce6-43e4-4709-08db6b2b24e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29QhMxqm8cS8K3nT9Q/iRBM47VRRiF+kRCHXhHRlyEUmSMqU7GaHL6zBIz2LUPr3sUWR8gnihZJsAbqKsnrvZdHatXe8Iv7UNsE1VOlauzYM4to4RGVj8t/YqH8nocnnpV/CdLhabkPxDO748BTFyrtbtkC2aNncj3o3LRyd/xQBxeNajmJQkjhDYoH4+mUqdcn34DqsSm4FCVFfsuZjm195JQgM8669TuQ6a2uc2b0JphdJvldKhgge14AReAF+3e/gf1DGWX4KBBBeD6zv+LWWH2tf1B8kFcTGM3+mYHivzey/lOs5t6C5IbBtM28KiSFK3HGAFjZK6b2M2GCzlf8rNBAhixA3xx3MhK1lyfftDE6Hc6XeVb+XIF3zL8X3GIk/CDGWU09oN3jMb0wCZstjGW+AH3uPMcB8DnHeNBVjyBj42xiFCQqTPcLmQLFOzMpweG502RxDWF92T7cRbigStKOdq2GyVF0LIsphIuq4zhz98gkvHTfanBkYtGZRDq5bAGWxQxTEG9U4MwM/WjWcahau72oGWpiKzCFivB9mhmuLPgsVzsHhg5TJXQehEhM7pKfAhiKnzSjRkQtjBd99mujQNA/ByqBswnfUdrMEAhzFfnxerrGTIE2nojoT74AkgTBacfVWK2zvZdLxM/PPCJh5sJA+dMUu37U10OHn87gQ/RCK0fN1oIPTcyleW2uJL9RT8u9hiirtWRzYaiA6Jsl1Sh2gxliLaOkXpMRHSvYdNZBH/DkCuGwVatOTzlZ6rQI7wnCTJJXS5lATxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(82310400005)(7696005)(40460700003)(316002)(8676002)(41300700001)(26005)(82740400003)(83380400001)(5660300002)(40480700001)(81166007)(1076003)(356005)(6666004)(36860700001)(8936002)(36756003)(336012)(4326008)(6916009)(426003)(70586007)(47076005)(70206006)(478600001)(186003)(30864003)(2906002)(54906003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 09:55:24.8760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844077d6-fce6-43e4-4709-08db6b2b24e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SoundWire DMA driver dma ops for Pink Sardine platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h      |  73 +++++++
 sound/soc/amd/ps/ps-sdw-dma.c | 391 ++++++++++++++++++++++++++++++++++
 2 files changed, 464 insertions(+)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index c95c57970a27..5f7ddcc31842 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -103,6 +103,49 @@
 #define ACP_SDW1_STAT			BIT(2)
 #define ACP_ERROR_IRQ			BIT(29)
 
+#define ACP_AUDIO0_TX_THRESHOLD		0x1c
+#define ACP_AUDIO1_TX_THRESHOLD		0x1a
+#define ACP_AUDIO2_TX_THRESHOLD		0x18
+#define ACP_AUDIO0_RX_THRESHOLD		0x1b
+#define ACP_AUDIO1_RX_THRESHOLD		0x19
+#define ACP_AUDIO2_RX_THRESHOLD		0x17
+#define ACP_P1_AUDIO1_TX_THRESHOLD	BIT(6)
+#define ACP_P1_AUDIO1_RX_THRESHOLD	BIT(5)
+#define ACP_SDW_DMA_IRQ_MASK		0x1F800000
+#define ACP_P1_SDW_DMA_IRQ_MASK		0x60
+#define ACP63_SDW0_DMA_MAX_STREAMS	6
+#define ACP63_SDW1_DMA_MAX_STREAMS	2
+#define ACP_P1_AUDIO_TX_THRESHOLD	6
+#define SDW0_DMA_TX_IRQ_MASK(i)	(ACP_AUDIO0_TX_THRESHOLD - (2 * (i)))
+#define SDW0_DMA_RX_IRQ_MASK(i)	(ACP_AUDIO0_RX_THRESHOLD - (2 * (i)))
+#define SDW1_DMA_IRQ_MASK(i)	(ACP_P1_AUDIO_TX_THRESHOLD - (i))
+
+#define ACP_DELAY_US		5
+#define ACP_SDW_RING_BUFF_ADDR_OFFSET (128 * 1024)
+#define SDW0_MEM_WINDOW_START	0x4800000
+#define ACP_SDW_SRAM_PTE_OFFSET	0x03800400
+#define SDW0_PTE_OFFSET		0x400
+#define SDW_FIFO_SIZE		0x100
+#define SDW_DMA_SIZE		0x40
+#define ACP_SDW0_FIFO_OFFSET	0x100
+#define ACP_SDW_PTE_OFFSET	0x100
+#define SDW_FIFO_OFFSET		0x100
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
+
 enum acp_config {
 	ACP_CONFIG_0 = 0,
 	ACP_CONFIG_1,
@@ -140,6 +183,36 @@ struct pdm_dev_data {
 struct sdw_dma_dev_data {
 	void __iomem *acp_base;
 	struct mutex *acp_lock; /* used to protect acp common register access */
+	struct snd_pcm_substream *sdw0_dma_stream[ACP63_SDW0_DMA_MAX_STREAMS];
+	struct snd_pcm_substream *sdw1_dma_stream[ACP63_SDW1_DMA_MAX_STREAMS];
+};
+
+struct acp_sdw_dma_stream {
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
+		u32 low;
+		u32 high;
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
 };
 
 /**
diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index f4a8d4022dc8..1de78948f859 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -12,12 +12,403 @@
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
+static u32 sdw0_dma_enable_reg[ACP63_SDW0_DMA_MAX_STREAMS] = {
+	ACP_SW0_AUDIO0_TX_EN,
+	ACP_SW0_AUDIO1_TX_EN,
+	ACP_SW0_AUDIO2_TX_EN,
+	ACP_SW0_AUDIO0_RX_EN,
+	ACP_SW0_AUDIO1_RX_EN,
+	ACP_SW0_AUDIO2_RX_EN,
+};
+
+static u32 sdw1_dma_enable_reg[ACP63_SDW1_DMA_MAX_STREAMS] = {
+	ACP_SW1_AUDIO1_TX_EN,
+	ACP_SW1_AUDIO1_RX_EN,
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
+static void acp63_config_dma(struct acp_sdw_dma_stream *stream, void __iomem *acp_base,
+			     u32 stream_id)
+{
+	u16 page_idx;
+	u32 low, high, val;
+	u32 sdw_dma_pte_offset;
+	dma_addr_t addr;
+
+	addr = stream->dma_addr;
+	sdw_dma_pte_offset = SDW_PTE_OFFSET(stream->instance);
+	val = sdw_dma_pte_offset + (stream_id * ACP_SDW_PTE_OFFSET);
+
+	/* Group Enable */
+	writel(ACP_SDW_SRAM_PTE_OFFSET | BIT(31), acp_base + ACPAXI2AXI_ATU_BASE_ADDR_GRP_2);
+	writel(PAGE_SIZE_4K_ENABLE, acp_base + ACPAXI2AXI_ATU_PAGE_SIZE_GRP_2);
+	for (page_idx = 0; page_idx < stream->num_pages; page_idx++) {
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
+	sdw_fifo_addr = sdw_fifo_offset + (stream_id * SDW_FIFO_OFFSET);
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
+	struct acp_sdw_dma_stream *stream;
+	struct snd_soc_dai *cpu_dai;
+	struct amd_sdw_manager *amd_manager;
+	struct snd_soc_pcm_runtime *prtd = substream->private_data;
+	int ret;
+
+	runtime = substream->runtime;
+	cpu_dai = asoc_rtd_to_cpu(prtd, 0);
+	amd_manager = snd_soc_dai_get_drvdata(cpu_dai);
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
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
+		kfree(stream);
+		return ret;
+	}
+
+	stream->stream_id = cpu_dai->id;
+	stream->instance = amd_manager->instance;
+	runtime->private_data = stream;
+	return ret;
+}
+
+static int acp63_sdw_dma_hw_params(struct snd_soc_component *component,
+				   struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct acp_sdw_dma_stream *stream;
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
+	stream = substream->runtime->private_data;
+	if (!stream)
+		return -EINVAL;
+	stream_id = stream->stream_id;
+	switch (stream->instance) {
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
+	stream->dma_addr = substream->runtime->dma_addr;
+	stream->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
+	acp63_config_dma(stream, sdw_data->acp_base, stream_id);
+	ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, stream_id, size,
+					     stream->instance);
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
+static u64 acp63_sdw_get_byte_count(struct acp_sdw_dma_stream *stream, void __iomem *acp_base)
+{
+	union acp_sdw_dma_count byte_count;
+	u32 pos_low_reg, pos_high_reg;
+
+	byte_count.bytescount = 0;
+	switch (stream->instance) {
+	case ACP_SDW0:
+		pos_low_reg = sdw0_dma_ring_buf_reg[stream->stream_id].pos_low_reg;
+		pos_high_reg = sdw0_dma_ring_buf_reg[stream->stream_id].pos_high_reg;
+		break;
+	case ACP_SDW1:
+		pos_low_reg = sdw1_dma_ring_buf_reg[stream->stream_id].pos_low_reg;
+		pos_high_reg = sdw1_dma_ring_buf_reg[stream->stream_id].pos_high_reg;
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
+					       struct snd_pcm_substream *substream)
+{
+	struct sdw_dma_dev_data *sdw_data;
+	struct acp_sdw_dma_stream *stream;
+	u32 pos, buffersize;
+	u64 bytescount;
+
+	sdw_data = dev_get_drvdata(comp->dev);
+	stream = substream->runtime->private_data;
+	buffersize = frames_to_bytes(substream->runtime,
+				     substream->runtime->buffer_size);
+	bytescount = acp63_sdw_get_byte_count(stream, sdw_data->acp_base);
+	if (bytescount > stream->bytescount)
+		bytescount -= stream->bytescount;
+	pos = do_div(bytescount, buffersize);
+	return bytes_to_frames(substream->runtime, pos);
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
+	struct acp_sdw_dma_stream *stream;
+
+	sdw_data = dev_get_drvdata(component->dev);
+	stream = substream->runtime->private_data;
+	if (!stream)
+		return -EINVAL;
+	switch (stream->instance) {
+	case ACP_SDW0:
+		sdw_data->sdw0_dma_stream[stream->stream_id] = NULL;
+		break;
+	case ACP_SDW1:
+		sdw_data->sdw1_dma_stream[stream->stream_id] = NULL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	kfree(stream);
+	return 0;
+}
+
+static int acp63_sdw_dma_enable(struct snd_pcm_substream *substream,
+				void __iomem *acp_base, bool sdw_dma_enable)
+{
+	struct acp_sdw_dma_stream *stream;
+	u32 stream_id;
+	u32 sdw_dma_en_reg;
+	u32 sdw_dma_en_stat_reg;
+	u32 sdw_dma_stat;
+	u32 dma_enable;
+
+	stream = substream->runtime->private_data;
+	stream_id = stream->stream_id;
+	switch (stream->instance) {
+	case ACP_SDW0:
+		sdw_dma_en_reg = sdw0_dma_enable_reg[stream_id];
+		break;
+	case ACP_SDW1:
+		sdw_dma_en_reg = sdw1_dma_enable_reg[stream_id];
+		break;
+	default:
+		return -EINVAL;
+	}
+	sdw_dma_en_stat_reg = sdw_dma_en_reg + 4;
+	dma_enable = sdw_dma_enable;
+	writel(dma_enable, acp_base + sdw_dma_en_reg);
+	return readl_poll_timeout(acp_base + sdw_dma_en_stat_reg, sdw_dma_stat,
+				  (sdw_dma_stat == dma_enable), ACP_DELAY_US, ACP_COUNTER);
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
+		ret = acp63_sdw_dma_enable(substream, sdw_data->acp_base, true);
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		ret = acp63_sdw_dma_enable(substream, sdw_data->acp_base, false);
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

