Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DEE70D114
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjEWCUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjEWCTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:19:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DFDE6;
        Mon, 22 May 2023 19:19:42 -0700 (PDT)
X-UUID: 43227586f91011ed9cb5633481061a41-20230523
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=r/ynvpD56p320B6BbN2gG/8wM3GbWN7STgUsQ5UpneI=;
        b=iWYBnI6rpNLzpAzv2T+RpFSa2aYOnZ6HgHolqivwqFy9PIEvzIMfjQuc7krnXQ4NHUrvFmiV1vDUfs11+7tcMBddzRpN5vrHZ+rBJ8cqZr7WdXPkA0yYixPcNq75JI1zZWVqcgUtvWVPIBdBkiT4NiGrKDmJsfvYcAsHGQsqCKI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:3f7817d4-6df5-4c95-8702-757106687252,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.25,REQID:3f7817d4-6df5-4c95-8702-757106687252,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:d5b0ae3,CLOUDID:c7c3063c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:23052310193830T8ATJT,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 43227586f91011ed9cb5633481061a41-20230523
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 467393522; Tue, 23 May 2023 10:19:35 +0800
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
Subject: [PATCH v2 3/7] ASoC: mediatek: mt8188-mt6359: register hdmi/dp jack pins
Date:   Tue, 23 May 2023 10:19:28 +0800
Message-ID: <20230523021933.3422-4-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230523021933.3422-1-trevor.wu@mediatek.com>
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
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

Some userspace applications need jack control events, so register hdmi
and dp jack pins to activate jack control events.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 27 +++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index 833bc362dad2..6c3f36e2fffd 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -151,6 +151,20 @@ struct mt8188_mt6359_priv {
 	struct snd_soc_jack hdmi_jack;
 };
 
+static struct snd_soc_jack_pin mt8188_hdmi_jack_pins[] = {
+	{
+		.pin = "HDMI",
+		.mask = SND_JACK_LINEOUT,
+	},
+};
+
+static struct snd_soc_jack_pin mt8188_dp_jack_pins[] = {
+	{
+		.pin = "DP",
+		.mask = SND_JACK_LINEOUT,
+	},
+};
+
 struct mt8188_card_data {
 	const char *name;
 	unsigned long quirk;
@@ -159,6 +173,8 @@ struct mt8188_card_data {
 static const struct snd_soc_dapm_widget mt8188_mt6359_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_SINK("HDMI"),
+	SND_SOC_DAPM_SINK("DP"),
 };
 
 static const struct snd_kcontrol_new mt8188_mt6359_controls[] = {
@@ -396,8 +412,10 @@ static int mt8188_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
 	int ret = 0;
 
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &priv->hdmi_jack);
+	ret = snd_soc_card_jack_new_pins(rtd->card, "HDMI Jack",
+					 SND_JACK_LINEOUT, &priv->hdmi_jack,
+					 mt8188_hdmi_jack_pins,
+					 ARRAY_SIZE(mt8188_hdmi_jack_pins));
 	if (ret) {
 		dev_info(rtd->dev, "%s, new jack failed: %d\n", __func__, ret);
 		return ret;
@@ -417,8 +435,9 @@ static int mt8188_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
 	int ret = 0;
 
-	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT,
-				    &priv->dp_jack);
+	ret = snd_soc_card_jack_new_pins(rtd->card, "DP Jack", SND_JACK_LINEOUT,
+					 &priv->dp_jack, mt8188_dp_jack_pins,
+					 ARRAY_SIZE(mt8188_dp_jack_pins));
 	if (ret) {
 		dev_info(rtd->dev, "%s, new jack failed: %d\n", __func__, ret);
 		return ret;
-- 
2.18.0

