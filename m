Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6074D7253E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjFGGLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjFGGLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:11:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9437A10DE;
        Tue,  6 Jun 2023 23:11:37 -0700 (PDT)
X-UUID: 2600556804fa11ee9cb5633481061a41-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Q+6OtwkDGzsHh4iL5vqae3PZpZ/xeJwcr55Y8xLAHvE=;
        b=dbx849VDl2vqGFxgL5lgzMm9LhVx6ajFAl7Ieuq/w71PejEsWfJbFw5oONA9SnFIiaaxmo64zy2sJonPI/9g3ZiOAofxepswJhW5g2A9SoGEP5gBpdSbmGqR7WohS1gRyF5XAZcBkYNcQ8YvBiisptFT6dDzotO07hsdQuZ9rCg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:ed4e25fd-8765-42de-8dea-84a36be36336,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:e5d3d33d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 2600556804fa11ee9cb5633481061a41-20230607
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1578779578; Wed, 07 Jun 2023 14:11:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 14:11:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 14:11:31 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        "Hsiao Chein Sung" <shawn.sung@mediatek.com>,
        Fei Shao <fshao@google.com>
Subject: [PATCH v1 3/6] soc: mediatek: mt8188: Support VDOSYS1 in mtk-mmsys
Date:   Wed, 7 Jun 2023 14:11:18 +0800
Message-ID: <20230607061121.6732-4-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230607061121.6732-1-shawn.sung@mediatek.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,UPPERCASE_50_75,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add register definitions for MT8188
- Add VDOSYS1 routing table
- Update MUTEX definitions accordingly
- Set VSYNC length from 0x40 (default) to 1 since ETHDR is bypassed

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mt8188-mmsys.h | 149 ++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    |  13 +++
 drivers/soc/mediatek/mtk-mmsys.h    |   1 +
 drivers/soc/mediatek/mtk-mutex.c    |  35 +++++++
 4 files changed, 198 insertions(+)

diff --git a/drivers/soc/mediatek/mt8188-mmsys.h b/drivers/soc/mediatek/mt8188-mmsys.h
index 448cc3761b43..1b313b979ea1 100644
--- a/drivers/soc/mediatek/mt8188-mmsys.h
+++ b/drivers/soc/mediatek/mt8188-mmsys.h
@@ -67,6 +67,79 @@
 #define MT8188_SOUT_DSC_WRAP0_OUT_TO_VPP_MERGE		BIT(18)
 #define MT8188_SOUT_DSC_WRAP0_OUT_TO_DISP_WDMA0		BIT(19)

+#define MT8188_VDO1_SW0_RST_B					0x1d0
+#define MT8188_VDO1_HDR_TOP_CFG					0xd00
+#define MT8188_VDO1_MIXER_IN1_ALPHA				0xd30
+#define MT8188_VDO1_MIXER_IN1_PAD				0xd40
+#define MT8188_VDO1_MERGE0_ASYNC_CFG_WD				0xe30
+#define MT8188_VDO1_HDRBE_ASYNC_CFG_WD				0xe70
+
+#define MT8188_VDO1_VPP_MERGE0_P0_SEL_IN			0xf04
+#define MT8188_VPP_MERGE0_P0_SEL_IN_FROM_MDP_RDMA0			1
+
+#define MT8188_VDO1_VPP_MERGE0_P1_SEL_IN			0xf08
+#define MT8188_VPP_MERGE0_P1_SEL_IN_FROM_MDP_RDMA1			1
+
+#define MT8188_VDO1_DISP_DPI1_SEL_IN				0xf10
+#define MT8188_DISP_DPI1_SEL_IN_FROM_VPP_MERGE4_MOUT			0
+
+#define MT8188_VDO1_DISP_DP_INTF0_SEL_IN			0xf14
+#define MT8188_DISP_DP_INTF0_SEL_IN_FROM_VPP_MERGE4_MOUT		0
+
+#define MT8188_VDO1_MERGE4_SOUT_SEL				0xf18
+#define MT8188_MERGE4_SOUT_TO_DPI1_SEL					BIT(2)
+#define MT8188_MERGE4_SOUT_TO_DP_INTF0_SEL				BIT(3)
+
+#define MT8188_VDO1_MIXER_IN1_SEL_IN				0xf24
+#define MT8188_MIXER_IN1_SEL_IN_FROM_MERGE0_ASYNC_SOUT			1
+
+#define MT8188_VDO1_MIXER_IN2_SEL_IN				0xf28
+#define MT8188_MIXER_IN2_SEL_IN_FROM_MERGE1_ASYNC_SOUT			1
+
+#define MT8188_VDO1_MIXER_IN3_SEL_IN				0xf2c
+#define MT8188_MIXER_IN3_SEL_IN_FROM_MERGE2_ASYNC_SOUT			1
+
+#define MT8188_VDO1_MIXER_IN4_SEL_IN				0xf30
+#define MT8188_MIXER_IN4_SEL_IN_FROM_MERGE3_ASYNC_SOUT			1
+
+#define MT8188_VDO1_MIXER_OUT_SOUT_SEL				0xf34
+#define MT8188_MIXER_SOUT_TO_MERGE4_ASYNC_SEL				1
+
+#define MT8188_VDO1_VPP_MERGE1_P0_SEL_IN			0xf3c
+#define MT8188_VPP_MERGE1_P0_SEL_IN_FROM_MDP_RDMA2			1
+
+#define MT8188_VDO1_MERGE0_ASYNC_SOUT_SEL			0xf40
+#define MT8188_SOUT_TO_MIXER_IN1_SEL					1
+
+#define MT8188_VDO1_MERGE1_ASYNC_SOUT_SEL			0xf44
+#define MT8188_SOUT_TO_MIXER_IN2_SEL					1
+
+#define MT8188_VDO1_MERGE2_ASYNC_SOUT_SEL			0xf48
+#define MT8188_SOUT_TO_MIXER_IN3_SEL					1
+
+#define MT8188_VDO1_MERGE3_ASYNC_SOUT_SEL			0xf4c
+#define MT8188_SOUT_TO_MIXER_IN4_SEL					1
+
+#define MT8188_VDO1_MERGE4_ASYNC_SEL_IN				0xf50
+#define MT8188_MERGE4_ASYNC_SEL_IN_FROM_MIXER_OUT_SOUT			1
+
+#define MT8188_VDO1_MIXER_IN1_SOUT_SEL				0xf58
+#define MT8188_MIXER_IN1_SOUT_TO_DISP_MIXER				0
+
+#define MT8188_VDO1_MIXER_IN2_SOUT_SEL				0xf5c
+#define MT8188_MIXER_IN2_SOUT_TO_DISP_MIXER				0
+
+#define MT8188_VDO1_MIXER_IN3_SOUT_SEL				0xf60
+#define MT8188_MIXER_IN3_SOUT_TO_DISP_MIXER				0
+
+#define MT8188_VDO1_MIXER_IN4_SOUT_SEL				0xf64
+#define MT8188_MIXER_IN4_SOUT_TO_DISP_MIXER				0
+
+#define MT8188_VDO1_MIXER_SOUT_SEL_IN				0xf68
+#define MT8188_MIXER_SOUT_SEL_IN_FROM_DISP_MIXER			0
+
+#define MT8188_VDO1_MIXER_VSYNC_LEN				0xd5c
+
 static const struct mtk_mmsys_routes mmsys_mt8188_routing_table[] = {
 	{
 		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
@@ -146,4 +219,80 @@ static const struct mtk_mmsys_routes mmsys_mt8188_routing_table[] = {
 	},
 };

+static const struct mtk_mmsys_routes mmsys_mt8188_vdo1_routing_table[] = {
+	{
+		DDP_COMPONENT_MDP_RDMA0, DDP_COMPONENT_MERGE1,
+		MT8188_VDO1_VPP_MERGE0_P0_SEL_IN, GENMASK(0, 0),
+		MT8188_VPP_MERGE0_P0_SEL_IN_FROM_MDP_RDMA0
+	}, {
+		DDP_COMPONENT_MDP_RDMA1, DDP_COMPONENT_MERGE1,
+		MT8188_VDO1_VPP_MERGE0_P1_SEL_IN, GENMASK(0, 0),
+		MT8188_VPP_MERGE0_P1_SEL_IN_FROM_MDP_RDMA1
+	}, {
+		DDP_COMPONENT_MDP_RDMA2, DDP_COMPONENT_MERGE2,
+		MT8188_VDO1_VPP_MERGE1_P0_SEL_IN, GENMASK(0, 0),
+		MT8188_VPP_MERGE1_P0_SEL_IN_FROM_MDP_RDMA2
+	}, {
+		DDP_COMPONENT_MERGE1, DDP_COMPONENT_ETHDR_MIXER,
+		MT8188_VDO1_MERGE0_ASYNC_SOUT_SEL, GENMASK(1, 0),
+		MT8188_SOUT_TO_MIXER_IN1_SEL
+	}, {
+		DDP_COMPONENT_MERGE2, DDP_COMPONENT_ETHDR_MIXER,
+		MT8188_VDO1_MERGE1_ASYNC_SOUT_SEL, GENMASK(1, 0),
+		MT8188_SOUT_TO_MIXER_IN2_SEL
+	}, {
+		DDP_COMPONENT_MERGE3, DDP_COMPONENT_ETHDR_MIXER,
+		MT8188_VDO1_MERGE2_ASYNC_SOUT_SEL, GENMASK(1, 0),
+		MT8188_SOUT_TO_MIXER_IN3_SEL
+	}, {
+		DDP_COMPONENT_MERGE4, DDP_COMPONENT_ETHDR_MIXER,
+		MT8188_VDO1_MERGE3_ASYNC_SOUT_SEL, GENMASK(1, 0),
+		MT8188_SOUT_TO_MIXER_IN4_SEL
+	}, {
+		DDP_COMPONENT_ETHDR_MIXER, DDP_COMPONENT_MERGE5,
+		MT8188_VDO1_MIXER_OUT_SOUT_SEL, GENMASK(0, 0),
+		MT8188_MIXER_SOUT_TO_MERGE4_ASYNC_SEL
+	}, {
+		DDP_COMPONENT_MERGE1, DDP_COMPONENT_ETHDR_MIXER,
+		MT8188_VDO1_MIXER_IN1_SEL_IN, GENMASK(0, 0),
+		MT8188_MIXER_IN1_SEL_IN_FROM_MERGE0_ASYNC_SOUT
+	}, {
+		DDP_COMPONENT_MERGE2, DDP_COMPONENT_ETHDR_MIXER,
+		MT8188_VDO1_MIXER_IN2_SEL_IN, GENMASK(0, 0),
+		MT8188_MIXER_IN2_SEL_IN_FROM_MERGE1_ASYNC_SOUT
+	}, {
+		DDP_COMPONENT_MERGE3, DDP_COMPONENT_ETHDR_MIXER,
+		MT8188_VDO1_MIXER_IN3_SEL_IN, GENMASK(0, 0),
+		MT8188_MIXER_IN3_SEL_IN_FROM_MERGE2_ASYNC_SOUT
+	}, {
+		DDP_COMPONENT_MERGE4, DDP_COMPONENT_ETHDR_MIXER,
+		MT8188_VDO1_MIXER_IN4_SEL_IN, GENMASK(0, 0),
+		MT8188_MIXER_IN4_SEL_IN_FROM_MERGE3_ASYNC_SOUT
+	}, {
+		DDP_COMPONENT_ETHDR_MIXER, DDP_COMPONENT_MERGE5,
+		MT8188_VDO1_MIXER_SOUT_SEL_IN, GENMASK(2, 0),
+		MT8188_MIXER_SOUT_SEL_IN_FROM_DISP_MIXER
+	}, {
+		DDP_COMPONENT_ETHDR_MIXER, DDP_COMPONENT_MERGE5,
+		MT8188_VDO1_MERGE4_ASYNC_SEL_IN, GENMASK(2, 0),
+		MT8188_MERGE4_ASYNC_SEL_IN_FROM_MIXER_OUT_SOUT
+	}, {
+		DDP_COMPONENT_MERGE5, DDP_COMPONENT_DPI1,
+		MT8188_VDO1_DISP_DPI1_SEL_IN, GENMASK(1, 0),
+		MT8188_DISP_DPI1_SEL_IN_FROM_VPP_MERGE4_MOUT
+	}, {
+		DDP_COMPONENT_MERGE5, DDP_COMPONENT_DPI1,
+		MT8188_VDO1_MERGE4_SOUT_SEL, GENMASK(1, 0),
+		MT8188_MERGE4_SOUT_TO_DPI1_SEL
+	}, {
+		DDP_COMPONENT_MERGE5, DDP_COMPONENT_DP_INTF1,
+		MT8188_VDO1_DISP_DP_INTF0_SEL_IN, GENMASK(1, 0),
+		MT8188_DISP_DP_INTF0_SEL_IN_FROM_VPP_MERGE4_MOUT
+	}, {
+		DDP_COMPONENT_MERGE5, DDP_COMPONENT_DP_INTF1,
+		MT8188_VDO1_MERGE4_SOUT_SEL, GENMASK(3, 0),
+		MT8188_MERGE4_SOUT_TO_DP_INTF0_SEL
+	}
+};
+
 #endif /* __SOC_MEDIATEK_MT8188_MMSYS_H */
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 9619faa796e8..b1e4695a0a93 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -89,6 +89,15 @@ static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data = {
 	.num_routes = ARRAY_SIZE(mmsys_mt8188_routing_table),
 };

+static const struct mtk_mmsys_driver_data mt8188_vdosys1_driver_data = {
+	.clk_driver = "clk-mt8188-vdo1",
+	.routes = mmsys_mt8188_vdo1_routing_table,
+	.num_routes = ARRAY_SIZE(mmsys_mt8188_vdo1_routing_table),
+	.sw0_rst_offset = MT8188_VDO1_SW0_RST_B,
+	.num_resets = 96,
+	.vsync_len = 1,
+};
+
 static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
 	.clk_driver = "clk-mt8192-mm",
 	.routes = mmsys_mt8192_routing_table,
@@ -213,6 +222,9 @@ void mtk_mmsys_mixer_in_config(struct device *dev, int idx, bool alpha_sel, u16
 			      alpha_sel << (19 + idx), cmdq_pkt);
 	mtk_mmsys_update_bits(mmsys, MT8195_VDO1_MIXER_IN1_PAD + (idx - 1) * 4,
 			      GENMASK(31, 16) | GENMASK(1, 0), biwidth << 16 | mode, cmdq_pkt);
+	if (mmsys->data->vsync_len)
+		mtk_mmsys_update_bits(mmsys, MT8188_VDO1_MIXER_VSYNC_LEN, ~0,
+				      mmsys->data->vsync_len, cmdq_pkt);
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_mixer_in_config);

@@ -431,6 +443,7 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 	{ .compatible = "mediatek,mt8183-mmsys", .data = &mt8183_mmsys_driver_data },
 	{ .compatible = "mediatek,mt8186-mmsys", .data = &mt8186_mmsys_driver_data },
 	{ .compatible = "mediatek,mt8188-vdosys0", .data = &mt8188_vdosys0_driver_data },
+	{ .compatible = "mediatek,mt8188-vdosys1", .data = &mt8188_vdosys1_driver_data },
 	{ .compatible = "mediatek,mt8192-mmsys", .data = &mt8192_mmsys_driver_data },
 	/* "mediatek,mt8195-mmsys" compatible is deprecated */
 	{ .compatible = "mediatek,mt8195-mmsys", .data = &mt8195_vdosys0_driver_data },
diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index 6725403d2e3a..b9cc1d9e46fa 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -93,6 +93,7 @@ struct mtk_mmsys_driver_data {
 	const u16 sw0_rst_offset;
 	const u32 num_resets;
 	const bool is_vppsys;
+	const u8 vsync_len;
 };

 /*
diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 26f3d9a41496..11dda20eb462 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -134,6 +134,22 @@
 #define MT8188_MUTEX_MOD_DISP_POSTMASK0		24
 #define MT8188_MUTEX_MOD2_DISP_PWM0		33

+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA0	0
+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA1	1
+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA2	2
+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA3	3
+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA4	4
+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA5	5
+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA6	6
+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA7	7
+#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE0	20
+#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE1	21
+#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE2	22
+#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE3	23
+#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE4	24
+#define MT8188_MUTEX_MOD_DISP1_DISP_MIXER	30
+#define MT8188_MUTEX_MOD_DISP1_DP_INTF1		39
+
 #define MT8195_MUTEX_MOD_DISP_OVL0		0
 #define MT8195_MUTEX_MOD_DISP_WDMA0		1
 #define MT8195_MUTEX_MOD_DISP_RDMA0		2
@@ -265,6 +281,7 @@
 #define MT8183_MUTEX_SOF_DPI0			2
 #define MT8188_MUTEX_SOF_DSI0			1
 #define MT8188_MUTEX_SOF_DP_INTF0		3
+#define MT8188_MUTEX_SOF_DP_INTF1		4
 #define MT8195_MUTEX_SOF_DSI0			1
 #define MT8195_MUTEX_SOF_DSI1			2
 #define MT8195_MUTEX_SOF_DP_INTF0		3
@@ -276,6 +293,7 @@
 #define MT8183_MUTEX_EOF_DPI0			(MT8183_MUTEX_SOF_DPI0 << 6)
 #define MT8188_MUTEX_EOF_DSI0			(MT8188_MUTEX_SOF_DSI0 << 7)
 #define MT8188_MUTEX_EOF_DP_INTF0		(MT8188_MUTEX_SOF_DP_INTF0 << 7)
+#define MT8188_MUTEX_EOF_DP_INTF1		(MT8188_MUTEX_SOF_DP_INTF1 << 7)
 #define MT8195_MUTEX_EOF_DSI0			(MT8195_MUTEX_SOF_DSI0 << 7)
 #define MT8195_MUTEX_EOF_DSI1			(MT8195_MUTEX_SOF_DSI1 << 7)
 #define MT8195_MUTEX_EOF_DP_INTF0		(MT8195_MUTEX_SOF_DP_INTF0 << 7)
@@ -446,6 +464,21 @@ static const unsigned int mt8188_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_DSI0] = MT8188_MUTEX_MOD_DISP_DSI0,
 	[DDP_COMPONENT_PWM0] = MT8188_MUTEX_MOD2_DISP_PWM0,
 	[DDP_COMPONENT_DP_INTF0] = MT8188_MUTEX_MOD_DISP_DP_INTF0,
+	[DDP_COMPONENT_MDP_RDMA0] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA0,
+	[DDP_COMPONENT_MDP_RDMA1] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA1,
+	[DDP_COMPONENT_MDP_RDMA2] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA2,
+	[DDP_COMPONENT_MDP_RDMA3] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA3,
+	[DDP_COMPONENT_MDP_RDMA4] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA4,
+	[DDP_COMPONENT_MDP_RDMA5] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA5,
+	[DDP_COMPONENT_MDP_RDMA6] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA6,
+	[DDP_COMPONENT_MDP_RDMA7] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA7,
+	[DDP_COMPONENT_MERGE1] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE0,
+	[DDP_COMPONENT_MERGE2] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE1,
+	[DDP_COMPONENT_MERGE3] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE2,
+	[DDP_COMPONENT_MERGE4] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE3,
+	[DDP_COMPONENT_ETHDR_MIXER] = MT8188_MUTEX_MOD_DISP1_DISP_MIXER,
+	[DDP_COMPONENT_MERGE5] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE4,
+	[DDP_COMPONENT_DP_INTF1] = MT8188_MUTEX_MOD_DISP1_DP_INTF1,
 };

 static const unsigned int mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] = {
@@ -606,6 +639,8 @@ static const unsigned int mt8188_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 		MT8188_MUTEX_SOF_DSI0 | MT8188_MUTEX_EOF_DSI0,
 	[MUTEX_SOF_DP_INTF0] =
 		MT8188_MUTEX_SOF_DP_INTF0 | MT8188_MUTEX_EOF_DP_INTF0,
+	[MUTEX_SOF_DP_INTF1] =
+		MT8188_MUTEX_SOF_DP_INTF1 | MT8188_MUTEX_EOF_DP_INTF1,
 };

 static const unsigned int mt8195_mutex_sof[DDP_MUTEX_SOF_MAX] = {
--
2.18.0

