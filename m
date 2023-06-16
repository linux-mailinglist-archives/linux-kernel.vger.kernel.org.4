Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5BA73302E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345041AbjFPLm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344105AbjFPLlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:41:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA4E30C3;
        Fri, 16 Jun 2023 04:41:35 -0700 (PDT)
X-UUID: b9a528740c3a11eeb20a276fd37b9834-20230616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MW7/jGLdX289Up/yd0BmJ9KJKkudVHsR4iUyu42ZNKM=;
        b=CevVUM3M9/PnVue3su9Flmq19ByCdmfwRb6MxfERYrkkO/Tjb7i60DsJCv1zwTtw98OmsF7JyB2HcqAQOR8avDeXqqNWxmRM2yL7GBcgJZiiXDVOqJF4JIWT7riOEaOxE3MmIx1aN64qUPySsPjs3UrCJvFArDSyD5ytJdAw498=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:1d32281e-f73d-4218-b657-a5c20fb56f81,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:86544d6f-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b9a528740c3a11eeb20a276fd37b9834-20230616
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1202711579; Fri, 16 Jun 2023 19:41:25 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 19:41:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Jun 2023 19:41:24 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
Subject: [PATCH v3 08/13] soc: mediatek: Support MT8188 VDOSYS1 Padding in mtk-mmsys
Date:   Fri, 16 Jun 2023 19:41:06 +0800
Message-ID: <20230616114111.17554-9-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230616114111.17554-1-shawn.sung@mediatek.com>
References: <20230616114111.17554-1-shawn.sung@mediatek.com>
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

- Add Padding components
- Add Mutex module definitions for Padding

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mtk-mutex.c       | 16 ++++++++++++++++
 include/linux/soc/mediatek/mtk-mmsys.h |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 028d2e7026bd..a91cb87f5eaa 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -142,6 +142,14 @@
 #define MT8188_MUTEX_MOD_DISP1_MDP_RDMA5	5
 #define MT8188_MUTEX_MOD_DISP1_MDP_RDMA6	6
 #define MT8188_MUTEX_MOD_DISP1_MDP_RDMA7	7
+#define MT8188_MUTEX_MOD_DISP1_PADDING0		8
+#define MT8188_MUTEX_MOD_DISP1_PADDING1		9
+#define MT8188_MUTEX_MOD_DISP1_PADDING2		10
+#define MT8188_MUTEX_MOD_DISP1_PADDING3		11
+#define MT8188_MUTEX_MOD_DISP1_PADDING4		12
+#define MT8188_MUTEX_MOD_DISP1_PADDING5		13
+#define MT8188_MUTEX_MOD_DISP1_PADDING6		14
+#define MT8188_MUTEX_MOD_DISP1_PADDING7		15
 #define MT8188_MUTEX_MOD_DISP1_VPP_MERGE0	20
 #define MT8188_MUTEX_MOD_DISP1_VPP_MERGE1	21
 #define MT8188_MUTEX_MOD_DISP1_VPP_MERGE2	22
@@ -472,6 +480,14 @@ static const unsigned int mt8188_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_MDP_RDMA5] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA5,
 	[DDP_COMPONENT_MDP_RDMA6] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA6,
 	[DDP_COMPONENT_MDP_RDMA7] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA7,
+	[DDP_COMPONENT_PADDING0] = MT8188_MUTEX_MOD_DISP1_PADDING0,
+	[DDP_COMPONENT_PADDING1] = MT8188_MUTEX_MOD_DISP1_PADDING1,
+	[DDP_COMPONENT_PADDING2] = MT8188_MUTEX_MOD_DISP1_PADDING2,
+	[DDP_COMPONENT_PADDING3] = MT8188_MUTEX_MOD_DISP1_PADDING3,
+	[DDP_COMPONENT_PADDING4] = MT8188_MUTEX_MOD_DISP1_PADDING4,
+	[DDP_COMPONENT_PADDING5] = MT8188_MUTEX_MOD_DISP1_PADDING5,
+	[DDP_COMPONENT_PADDING6] = MT8188_MUTEX_MOD_DISP1_PADDING6,
+	[DDP_COMPONENT_PADDING7] = MT8188_MUTEX_MOD_DISP1_PADDING7,
 	[DDP_COMPONENT_MERGE1] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE0,
 	[DDP_COMPONENT_MERGE2] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE1,
 	[DDP_COMPONENT_MERGE3] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE2,
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 2475ef914746..ae9088a34339 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -49,6 +49,14 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_MDP_RDMA5,
 	DDP_COMPONENT_MDP_RDMA6,
 	DDP_COMPONENT_MDP_RDMA7,
+	DDP_COMPONENT_PADDING0,
+	DDP_COMPONENT_PADDING1,
+	DDP_COMPONENT_PADDING2,
+	DDP_COMPONENT_PADDING3,
+	DDP_COMPONENT_PADDING4,
+	DDP_COMPONENT_PADDING5,
+	DDP_COMPONENT_PADDING6,
+	DDP_COMPONENT_PADDING7,
 	DDP_COMPONENT_MERGE0,
 	DDP_COMPONENT_MERGE1,
 	DDP_COMPONENT_MERGE2,
--
2.18.0

