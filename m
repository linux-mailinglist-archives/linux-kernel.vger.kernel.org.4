Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD476E0BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDMKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDMKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:47:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0273610EA;
        Thu, 13 Apr 2023 03:47:25 -0700 (PDT)
X-UUID: 8fdf625ed9e811eda9a90f0bb45854f4-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zTnxtp6hN8hNECyGyeAIWXn7uB5lZFLas1G7S96mRtQ=;
        b=g96DihSqJhOM7PBGDlsABiml9xXoDlYiH+FRJU5V7ghap7ofZ5HagfigKhBo3RSE4A2llKh3FEcvwI3VTXkSG9Z1gUSsyrVILjd0zIKTldf4uuEnIvW/QHZQWA3aEdAbAxmmlT2xsrsYPHxBT/70FfkDDHANo8c/dqLJaPSdFfM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:5e50eee8-becf-4657-ab8d-400084125424,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:6bbff283-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 8fdf625ed9e811eda9a90f0bb45854f4-20230413
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1865830291; Thu, 13 Apr 2023 18:47:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Apr 2023 18:47:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 13 Apr 2023 18:47:17 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 2/7] ASoC: mediatek: mt8188: complete set_tdm_slot function
Date:   Thu, 13 Apr 2023 18:47:08 +0800
Message-ID: <20230413104713.7174-3-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230413104713.7174-1-trevor.wu@mediatek.com>
References: <20230413104713.7174-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User can configures slot number of TDM mode via set_tdm_slot callback.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
index 7a37752d4244..fddecf5bf7c6 100644
--- a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
@@ -1909,6 +1909,10 @@ static int mtk_dai_etdm_hw_params(struct snd_pcm_substream *substream,
 		if (!is_valid_etdm_dai(mst_dai_id))
 			return -EINVAL;
 
+		mst_etdm_data = afe_priv->dai_priv[mst_dai_id];
+		if (mst_etdm_data->slots)
+			channels = mst_etdm_data->slots;
+
 		ret = mtk_dai_etdm_mclk_configure(afe, mst_dai_id);
 		if (ret)
 			return ret;
@@ -1918,7 +1922,6 @@ static int mtk_dai_etdm_hw_params(struct snd_pcm_substream *substream,
 		if (ret)
 			return ret;
 
-		mst_etdm_data = afe_priv->dai_priv[mst_dai_id];
 		for (i = 0; i < mst_etdm_data->cowork_slv_count; i++) {
 			slv_dai_id = mst_etdm_data->cowork_slv_id[i];
 			ret = mtk_dai_etdm_configure(afe, rate, channels,
@@ -1931,6 +1934,12 @@ static int mtk_dai_etdm_hw_params(struct snd_pcm_substream *substream,
 				return ret;
 		}
 	} else {
+		if (!is_valid_etdm_dai(dai->id))
+			return -EINVAL;
+		mst_etdm_data = afe_priv->dai_priv[dai->id];
+		if (mst_etdm_data->slots)
+			channels = mst_etdm_data->slots;
+
 		ret = mtk_dai_etdm_mclk_configure(afe, dai->id);
 		if (ret)
 			return ret;
@@ -2073,10 +2082,16 @@ static int mtk_dai_etdm_set_tdm_slot(struct snd_soc_dai *dai,
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8188_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_dai_etdm_priv *etdm_data;
+	int dai_id;
 
-	if (!is_valid_etdm_dai(dai->id))
+	if (is_cowork_mode(dai))
+		dai_id = get_etdm_cowork_master_id(dai);
+	else
+		dai_id = dai->id;
+
+	if (!is_valid_etdm_dai(dai_id))
 		return -EINVAL;
-	etdm_data = afe_priv->dai_priv[dai->id];
+	etdm_data = afe_priv->dai_priv[dai_id];
 
 	dev_dbg(dai->dev, "%s id %d slot_width %d\n",
 		__func__, dai->id, slot_width);
-- 
2.18.0

