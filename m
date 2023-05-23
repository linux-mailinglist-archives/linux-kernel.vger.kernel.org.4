Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110D670D112
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjEWCUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjEWCTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:19:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A22CA;
        Mon, 22 May 2023 19:19:39 -0700 (PDT)
X-UUID: 4323e4b6f91011ed9cb5633481061a41-20230523
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wwKjF0dgzn4sw9jpbPBz5pPHmhzAFBmOncmAdxxMpSI=;
        b=s7v70SQRPN6e2O3hrEdUwYBB1jX43IjTLZzwtPHOBmPOHrR6bED+6EXAqb+YZMbU5/2+dtZ1/Vtdz8jhLxFXolLtBnVNwqWxHZ4ZS6m8XzuVPa/Rjjlc/SdpUC+mlVVgSLH/qQ37LBgSymTKeQJXEN63qKzObxTs4XUEnat4dOY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:1bc3b812-f0c1-4218-8af0-8d9fb78750de,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.25,REQID:1bc3b812-f0c1-4218-8af0-8d9fb78750de,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:d5b0ae3,CLOUDID:cac3063c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:23052310193716AOL9LT,BulkQuantity:0,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 4323e4b6f91011ed9cb5633481061a41-20230523
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1474333474; Tue, 23 May 2023 10:19:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 May 2023 10:19:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 23 May 2023 10:19:34 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 4/7] ASoC: mediatek: common: soundcard driver add dai_fmt support
Date:   Tue, 23 May 2023 10:19:29 +0800
Message-ID: <20230523021933.3422-5-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230523021933.3422-1-trevor.wu@mediatek.com>
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two changes included in the patch.

First, add set_dailink_daifmt() function, so dai_fmt can be updated by
the configuration in dai-link sub node.

Second, remove codec phandle from required property in dai-link sub node.
For example, user possibly needs to update dai-format for all etdm
co-clock dai-links, but codec doesn't need to be specified in capture
dai-link for a speaker amp.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../mediatek/common/mtk-soundcard-driver.c    | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
index 738093451ccb..5e291092046b 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -22,7 +22,7 @@ static int set_card_codec_info(struct snd_soc_card *card,
 
 	codec_node = of_get_child_by_name(sub_node, "codec");
 	if (!codec_node)
-		return -EINVAL;
+		return 0;
 
 	/* set card codec info */
 	ret = snd_soc_of_get_dai_link_codecs(dev, codec_node, dai_link);
@@ -36,6 +36,47 @@ static int set_card_codec_info(struct snd_soc_card *card,
 	return 0;
 }
 
+static int set_dailink_daifmt(struct snd_soc_card *card,
+			      struct device_node *sub_node,
+			      struct snd_soc_dai_link *dai_link)
+{
+	unsigned int daifmt;
+	const char *str;
+	int ret;
+	struct {
+		char *name;
+		unsigned int val;
+	} of_clk_table[] = {
+		{ "cpu",	SND_SOC_DAIFMT_CBC_CFC },
+		{ "codec",	SND_SOC_DAIFMT_CBP_CFP },
+	};
+
+	daifmt = snd_soc_daifmt_parse_format(sub_node, NULL);
+	if (daifmt) {
+		dai_link->dai_fmt &= SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
+		dai_link->dai_fmt |= daifmt;
+	}
+
+	/*
+	 * check "mediatek,clk-provider = xxx"
+	 * SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK area
+	 */
+	ret = of_property_read_string(sub_node, "mediatek,clk-provider", &str);
+	if (ret == 0) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(of_clk_table); i++) {
+			if (strcmp(str, of_clk_table[i].name) == 0) {
+				dai_link->dai_fmt &= ~SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
+				dai_link->dai_fmt |= of_clk_table[i].val;
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
 int parse_dai_link_info(struct snd_soc_card *card)
 {
 	struct device *dev = card->dev;
@@ -67,6 +108,12 @@ int parse_dai_link_info(struct snd_soc_card *card)
 			of_node_put(sub_node);
 			return ret;
 		}
+
+		ret = set_dailink_daifmt(card, sub_node, dai_link);
+		if (ret < 0) {
+			of_node_put(sub_node);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.18.0

