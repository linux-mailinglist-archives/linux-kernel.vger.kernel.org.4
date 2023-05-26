Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79F27123B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbjEZJcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242853AbjEZJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:32:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509A10A;
        Fri, 26 May 2023 02:32:01 -0700 (PDT)
X-UUID: 2685717cfba811edb20a276fd37b9834-20230526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6L+uHBH+GT44LFZu9z47mQWC0nQz60GKwD8yOpDVV1M=;
        b=U3H0e6V//cNH3j0GBvsvbdOT4Rh0CsCGOCQDSVDYFwXskADzhLoavtn3RPvYKppi5RQVnLD8Ydvs23Y0DrCiVIP88Fu3HN71resKWkfSkHoHZl2VgWuPX/cX7PBoJ/LYYgC6QPKV2biB3XKCyNSjN+qdKfgm6PK33qOVV/jOLMo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:736b3c7c-babb-4d7c-87e8-b62da33b603d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:890e1a6d-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 2685717cfba811edb20a276fd37b9834-20230526
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2012086621; Fri, 26 May 2023 17:31:53 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 May 2023 17:31:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 May 2023 17:31:52 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <amergnat@baylibre.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 4/7] ASoC: mediatek: common: soundcard driver add dai_fmt support
Date:   Fri, 26 May 2023 17:31:47 +0800
Message-ID: <20230526093150.22923-5-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230526093150.22923-1-trevor.wu@mediatek.com>
References: <20230526093150.22923-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../mediatek/common/mtk-soundcard-driver.c    | 53 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
index 738093451ccb..a58e1e3674de 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -21,8 +21,10 @@ static int set_card_codec_info(struct snd_soc_card *card,
 	int ret;
 
 	codec_node = of_get_child_by_name(sub_node, "codec");
-	if (!codec_node)
-		return -EINVAL;
+	if (!codec_node) {
+		dev_dbg(dev, "%s no specified codec\n", dai_link->name);
+		return 0;
+	}
 
 	/* set card codec info */
 	ret = snd_soc_of_get_dai_link_codecs(dev, codec_node, dai_link);
@@ -36,6 +38,47 @@ static int set_card_codec_info(struct snd_soc_card *card,
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
@@ -67,6 +110,12 @@ int parse_dai_link_info(struct snd_soc_card *card)
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

