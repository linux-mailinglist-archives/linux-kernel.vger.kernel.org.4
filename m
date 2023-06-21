Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6D73799B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjFUDUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjFUDTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:19:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB96B3;
        Tue, 20 Jun 2023 20:19:47 -0700 (PDT)
X-UUID: 764a15fc0fe211ee9cb5633481061a41-20230621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=maHmK3YN9gCUIQVW3/HnNPfU2LhV5DP5WeMDpnhdqoQ=;
        b=ibl10/5lrfHQbKx0wI6rMMLlb3SQpsQNuVYV94wUZomHayUy0/QNFX3PpTVT+OESN2n1RuIG525S2G37oFqpsWSOKssinzChGFNlK8F4RwXbsSbxmflLhNUh0039uIiC0y/NcPKUYZro2kJWx1pF+nawsGSkz6WJoKRqsPj7W/Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:8b502960-bbbe-422b-a8dc-2b0ac355d44d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:bbf4473f-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 764a15fc0fe211ee9cb5633481061a41-20230621
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 824300505; Wed, 21 Jun 2023 11:19:41 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Jun 2023 11:19:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 21 Jun 2023 11:19:40 +0800
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
Subject: [PATCH v4 08/14] soc: mediatek: Support MT8188 VDOSYS1 Padding in mtk-mmsys
Date:   Wed, 21 Jun 2023 11:19:32 +0800
Message-ID: <20230621031938.5884-9-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230621031938.5884-1-shawn.sung@mediatek.com>
References: <20230621031938.5884-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add Padding components
- Add Mutex module definitions for Padding

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c       | 16 ++++++++++++++++
 include/linux/soc/mediatek/mtk-mmsys.h |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index c3067b3c8ec4..f2460d894d78 100644
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
@@ -474,6 +482,14 @@ static const unsigned int mt8188_mutex_mod[DDP_COMPONENT_ID_MAX] = {
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
index 2475ef914746..4885b065b849 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -62,6 +62,14 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_OVL_2L1,
 	DDP_COMPONENT_OVL_2L2,
 	DDP_COMPONENT_OVL1,
+	DDP_COMPONENT_PADDING0,
+	DDP_COMPONENT_PADDING1,
+	DDP_COMPONENT_PADDING2,
+	DDP_COMPONENT_PADDING3,
+	DDP_COMPONENT_PADDING4,
+	DDP_COMPONENT_PADDING5,
+	DDP_COMPONENT_PADDING6,
+	DDP_COMPONENT_PADDING7,
 	DDP_COMPONENT_POSTMASK0,
 	DDP_COMPONENT_PWM0,
 	DDP_COMPONENT_PWM1,
-- 
2.39.2

