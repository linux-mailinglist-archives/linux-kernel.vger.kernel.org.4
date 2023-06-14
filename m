Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3F72F735
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbjFNIAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243461AbjFNH7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:59:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54EA10DA;
        Wed, 14 Jun 2023 00:59:27 -0700 (PDT)
X-UUID: 84cdd0940a8511ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sS/rh0HESZs7GJFffsey9XWbaMAteRe0fmkfhn5dPWY=;
        b=I4BJ1IgZqIB3QRQ/f6R+z/P82IBOVR6CPbW3hJDdHhw0DV1XCCjQebUF0ebWYaBAd7LWsKk3bc1ekhK+0LFvi4tc1q/cJB6hNXRTF1dzcH4kuQvade2JhHwg8iWMtjNwTJFtHnmVfxpZ6a9Sv/i1J8ITukiusq/WFUPhGvDO2yQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:99c46f1c-399e-40d9-be04-bee61d884ea1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:526e623e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 84cdd0940a8511ee9cb5633481061a41-20230614
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1774354053; Wed, 14 Jun 2023 15:31:47 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 15:31:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 15:31:45 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
Subject: [PATCH v2 12/15] soc: mediatek: Add MT8188 VDO1 reset bit map
Date:   Wed, 14 Jun 2023 15:31:22 +0800
Message-ID: <20230614073125.17958-13-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230614073125.17958-1-shawn.sung@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8188 VDO1 reset bit map.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mt8188-mmsys.h | 57 +++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    |  3 +-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mt8188-mmsys.h b/drivers/soc/mediatek/mt8188-mmsys.h
index c3e3c5cfe931..208d4dfedc1a 100644
--- a/drivers/soc/mediatek/mt8188-mmsys.h
+++ b/drivers/soc/mediatek/mt8188-mmsys.h
@@ -144,6 +144,63 @@ static const u8 mmsys_mt8188_vdo0_rst_tb[] = {
 	[MT8188_VDO0_RST_DISP_RSZ0]	= 31,
 };

+static const u8 mmsys_mt8188_vdo1_rst_tb[] = {
+	[MT8188_VDO1_RST_SMI_LARB2]			= 0,
+	[MT8188_VDO1_RST_SMI_LARB3]			= 1,
+	[MT8188_VDO1_RST_GALS]				= 2,
+	[MT8188_VDO1_RST_FAKE_ENG0]			= 3,
+	[MT8188_VDO1_RST_FAKE_ENG1]			= 4,
+	[MT8188_VDO1_RST_MDP_RDMA0]			= 5,
+	[MT8188_VDO1_RST_MDP_RDMA1]			= 6,
+	[MT8188_VDO1_RST_MDP_RDMA2]			= 7,
+	[MT8188_VDO1_RST_MDP_RDMA3]			= 8,
+	[MT8188_VDO1_RST_VPP_MERGE0]			= 9,
+	[MT8188_VDO1_RST_VPP_MERGE1]			= 10,
+	[MT8188_VDO1_RST_VPP_MERGE2]			= 11,
+	[MT8188_VDO1_RST_VPP_MERGE3]			= 32 + 0,
+	[MT8188_VDO1_RST_VPP_MERGE4]			= 32 + 1,
+	[MT8188_VDO1_RST_VPP2_TO_VDO1_DL_ASYNC]		= 32 + 2,
+	[MT8188_VDO1_RST_VPP3_TO_VDO1_DL_ASYNC]		= 32 + 3,
+	[MT8188_VDO1_RST_DISP_MUTEX]			= 32 + 4,
+	[MT8188_VDO1_RST_MDP_RDMA4]			= 32 + 5,
+	[MT8188_VDO1_RST_MDP_RDMA5]			= 32 + 6,
+	[MT8188_VDO1_RST_MDP_RDMA6]			= 32 + 7,
+	[MT8188_VDO1_RST_MDP_RDMA7]			= 32 + 8,
+	[MT8188_VDO1_RST_DP_INTF1_MMCK]			= 32 + 9,
+	[MT8188_VDO1_RST_DPI0_MM_CK]			= 32 + 10,
+	[MT8188_VDO1_RST_DPI1_MM_CK]			= 32 + 11,
+	[MT8188_VDO1_RST_MERGE0_DL_ASYNC]		= 32 + 13,
+	[MT8188_VDO1_RST_MERGE1_DL_ASYNC]		= 32 + 14,
+	[MT8188_VDO1_RST_MERGE2_DL_ASYNC]		= 32 + 15,
+	[MT8188_VDO1_RST_MERGE3_DL_ASYNC]		= 32 + 16,
+	[MT8188_VDO1_RST_MERGE4_DL_ASYNC]		= 32 + 17,
+	[MT8188_VDO1_RST_VDO0_DSC_TO_VDO1_DL_ASYNC]	= 32 + 18,
+	[MT8188_VDO1_RST_VDO0_MERGE_TO_VDO1_DL_ASYNC]	= 32 + 19,
+	[MT8188_VDO1_RST_PADDING0]			= 32 + 20,
+	[MT8188_VDO1_RST_PADDING1]			= 32 + 21,
+	[MT8188_VDO1_RST_PADDING2]			= 32 + 22,
+	[MT8188_VDO1_RST_PADDING3]			= 32 + 23,
+	[MT8188_VDO1_RST_PADDING4]			= 32 + 24,
+	[MT8188_VDO1_RST_PADDING5]			= 32 + 25,
+	[MT8188_VDO1_RST_PADDING6]			= 32 + 26,
+	[MT8188_VDO1_RST_PADDING7]			= 32 + 27,
+	[MT8188_VDO1_RST_DISP_RSZ0]			= 32 + 28,
+	[MT8188_VDO1_RST_DISP_RSZ1]			= 32 + 29,
+	[MT8188_VDO1_RST_DISP_RSZ2]			= 32 + 30,
+	[MT8188_VDO1_RST_DISP_RSZ3]			= 32 + 31,
+	[MT8188_VDO1_RST_HDR_VDO_FE0]			= 64 + 0,
+	[MT8188_VDO1_RST_HDR_GFX_FE0]			= 64 + 1,
+	[MT8188_VDO1_RST_HDR_VDO_BE]			= 64 + 2,
+	[MT8188_VDO1_RST_HDR_VDO_FE1]			= 64 + 16,
+	[MT8188_VDO1_RST_HDR_GFX_FE1]			= 64 + 17,
+	[MT8188_VDO1_RST_DISP_MIXER]			= 64 + 18,
+	[MT8188_VDO1_RST_HDR_VDO_FE0_DL_ASYNC]		= 64 + 19,
+	[MT8188_VDO1_RST_HDR_VDO_FE1_DL_ASYNC]		= 64 + 20,
+	[MT8188_VDO1_RST_HDR_GFX_FE0_DL_ASYNC]		= 64 + 21,
+	[MT8188_VDO1_RST_HDR_GFX_FE1_DL_ASYNC]		= 64 + 22,
+	[MT8188_VDO1_RST_HDR_VDO_BE_DL_ASYNC]		= 64 + 23,
+};
+
 static const struct mtk_mmsys_routes mmsys_mt8188_routing_table[] = {
 	{
 		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 88029500ed4d..7a6221f87669 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -97,7 +97,8 @@ static const struct mtk_mmsys_driver_data mt8188_vdosys1_driver_data = {
 	.routes = mmsys_mt8188_vdo1_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_mt8188_vdo1_routing_table),
 	.sw0_rst_offset = MT8188_VDO1_SW0_RST_B,
-	.num_resets = 96,
+	.rst_tb = mmsys_mt8188_vdo1_rst_tb,
+	.num_resets = ARRAY_SIZE(mmsys_mt8188_vdo1_rst_tb),
 	.vsync_len = 1,
 };

--
2.18.0

