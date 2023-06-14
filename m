Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4591A72F75F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243506AbjFNIGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbjFNIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:06:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F174113E;
        Wed, 14 Jun 2023 01:06:07 -0700 (PDT)
X-UUID: 84396dd20a8511eeb20a276fd37b9834-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=H/H5pJJ/00kRxIWXFxV9TAThVrMzhZkTzpFWUj1MAn4=;
        b=leJBe9YRDbZ4ImvT3ntbruyeBSP6IQ8o+2hOxOdJE866yAyh8DShamRZewLMoNtx7x1iUVlu2+T98d0P7yEDMV2/dAzZFDzKs3txAQ0ZBfI48KwJ3vCOFtuarlyx7RbJ6yT3dlep/fFlq05nwy6/wa8/2+riRd2i3T3DPtjf02Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:82894c2e-a86b-4860-8175-3973b96a0513,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.26,REQID:82894c2e-a86b-4860-8175-3973b96a0513,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:cb9a4e1,CLOUDID:0649933e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:2306141531482ODHRWJC,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_FAS
X-UUID: 84396dd20a8511eeb20a276fd37b9834-20230614
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 623542009; Wed, 14 Jun 2023 15:31:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
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
Subject: [PATCH v2 10/15] soc: mediatek: Support reset bit mapping in mmsys driver
Date:   Wed, 14 Jun 2023 15:31:20 +0800
Message-ID: <20230614073125.17958-11-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230614073125.17958-1-shawn.sung@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Reset ID must starts from 0 and be consecutive, but
  the reset bits in our hardware design is not continuous,
  some bits are left unused, we need a map to solve the problem
- Use old style 1-to-1 mapping if .rst_tb is not defined

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 9 +++++++++
 drivers/soc/mediatek/mtk-mmsys.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 3a81ef2bcc3c..13249658721f 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -314,6 +314,15 @@ static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned l
 	u32 offset;
 	u32 reg;

+	if (mmsys->data->rst_tb) {
+		if (id >= mmsys->data->num_resets) {
+			dev_err(rcdev->dev, "Invalid reset ID: %lu (>=%u)\n",
+				id, mmsys->data->num_resets);
+			return -EINVAL;
+		}
+		id = mmsys->data->rst_tb[id];
+	}
+
 	offset = (id / MMSYS_SW_RESET_PER_REG) * sizeof(u32);
 	id = id % MMSYS_SW_RESET_PER_REG;
 	reg = mmsys->data->sw0_rst_offset + offset;
diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index e4ab46017430..e18b355527de 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -119,6 +119,7 @@ struct mtk_mmsys_driver_data {
 	const struct mtk_mmsys_routes *routes;
 	const unsigned int num_routes;
 	const u16 sw0_rst_offset;
+	const u8 *rst_tb;
 	const u32 num_resets;
 	const bool is_vppsys;
 	const u8 vsync_len;
--
2.18.0

