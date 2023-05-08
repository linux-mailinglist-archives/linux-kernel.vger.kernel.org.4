Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274B06FA0C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjEHHQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjEHHPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:15:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EAF199B
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:15:45 -0700 (PDT)
X-UUID: 2041345eed7011edb20a276fd37b9834-20230508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vnSdSNF6ArbJMg7lhVEfSNwHS80weL+zMJ+b2yfJtQY=;
        b=plbRgt8xPDheRZSfUVtSX974hRnrteHUVBEzOENZ6SV8CMyO0PxTsyXciFdCMVtO9CgEgNntpY5q0WSahMSRkVbeB5SAmEU7ZLZJ2JPp6IKnr4oMG3rGN87wBxjQ9IzJqWpDXCdWA3Zl12XmUMu53qH0qUkJtQqtPeNRPRWjl1M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:4d4b6f08-3b15-43ad-9783-7b237b4644bf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:697ab71,CLOUDID:2c8f1ec0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 2041345eed7011edb20a276fd37b9834-20230508
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 554456620; Mon, 08 May 2023 15:15:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 8 May 2023 15:15:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 8 May 2023 15:15:34 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <bicycle.tsai@mediatek.com>,
        <ting-fang.hou@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] ASoC: mediatek: mt6359: fix kselftest error of playback gain
Date:   Mon, 8 May 2023 15:15:30 +0800
Message-ID: <20230508071532.21665-3-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230508071532.21665-1-trevor.wu@mediatek.com>
References: <20230508071532.21665-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kselftest tries to read/write the default value. The default register
value of playback gain is 0x1F(mute), but max gain we specified is 0x12.
The range of the control is 0x0~0x12 and mute(0x1F) is only used in the
driver internally. To solve the problem, implement a new callback
mt6359_get_playback_volsw to report user configured volume instead of
the register value.

In addition, update max of "Headset Volume" to 0x12, so it can match the
maximum seen on latest data sheet.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/codecs/mt6359.c | 88 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index d6a93da2644e..65e6d4d08b6a 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -360,8 +360,34 @@ static int mt6359_put_volsw(struct snd_kcontrol *kcontrol,
 			(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = 0;
 	int index = ucontrol->value.integer.value[0];
+	int orig_gain[2], new_gain[2];
 	int ret;
 
+	switch (mc->reg) {
+	case MT6359_ZCD_CON2:
+		orig_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL];
+		orig_gain[1] = priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTR];
+		break;
+	case MT6359_ZCD_CON1:
+		orig_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTL];
+		orig_gain[1] = priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTR];
+		break;
+	case MT6359_ZCD_CON3:
+		orig_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_HSOUTL];
+		break;
+	case MT6359_AUDENC_ANA_CON0:
+		orig_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP1];
+		break;
+	case MT6359_AUDENC_ANA_CON1:
+		orig_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP2];
+		break;
+	case MT6359_AUDENC_ANA_CON2:
+		orig_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP3];
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	ret = snd_soc_put_volsw(kcontrol, ucontrol);
 	if (ret < 0)
 		return ret;
@@ -373,6 +399,8 @@ static int mt6359_put_volsw(struct snd_kcontrol *kcontrol,
 			(reg >> RG_AUDHPLGAIN_SFT) & RG_AUDHPLGAIN_MASK;
 		priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTR] =
 			(reg >> RG_AUDHPRGAIN_SFT) & RG_AUDHPRGAIN_MASK;
+		new_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL];
+		new_gain[1] = priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTR];
 		break;
 	case MT6359_ZCD_CON1:
 		regmap_read(priv->regmap, MT6359_ZCD_CON1, &reg);
@@ -380,35 +408,82 @@ static int mt6359_put_volsw(struct snd_kcontrol *kcontrol,
 			(reg >> RG_AUDLOLGAIN_SFT) & RG_AUDLOLGAIN_MASK;
 		priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTR] =
 			(reg >> RG_AUDLORGAIN_SFT) & RG_AUDLORGAIN_MASK;
+		new_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTL];
+		new_gain[1] = priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTR];
 		break;
 	case MT6359_ZCD_CON3:
 		regmap_read(priv->regmap, MT6359_ZCD_CON3, &reg);
 		priv->ana_gain[AUDIO_ANALOG_VOLUME_HSOUTL] =
 			(reg >> RG_AUDHSGAIN_SFT) & RG_AUDHSGAIN_MASK;
+		new_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_HSOUTL];
 		break;
 	case MT6359_AUDENC_ANA_CON0:
 		regmap_read(priv->regmap, MT6359_AUDENC_ANA_CON0, &reg);
 		priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP1] =
 			(reg >> RG_AUDPREAMPLGAIN_SFT) & RG_AUDPREAMPLGAIN_MASK;
+		new_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP1];
 		break;
 	case MT6359_AUDENC_ANA_CON1:
 		regmap_read(priv->regmap, MT6359_AUDENC_ANA_CON1, &reg);
 		priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP2] =
 			(reg >> RG_AUDPREAMPRGAIN_SFT) & RG_AUDPREAMPRGAIN_MASK;
+		new_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP2];
 		break;
 	case MT6359_AUDENC_ANA_CON2:
 		regmap_read(priv->regmap, MT6359_AUDENC_ANA_CON2, &reg);
 		priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP3] =
 			(reg >> RG_AUDPREAMP3GAIN_SFT) & RG_AUDPREAMP3GAIN_MASK;
+		new_gain[0] = priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP3];
 		break;
 	}
 
+	ret = 0;
+	if (orig_gain[0] != new_gain[0]) {
+		ret = 1;
+	} else if (snd_soc_volsw_is_stereo(mc)) {
+		if (orig_gain[1] != new_gain[1])
+			ret = 1;
+	}
+
 	dev_dbg(priv->dev, "%s(), name %s, reg(0x%x) = 0x%x, set index = %x\n",
 		__func__, kcontrol->id.name, mc->reg, reg, index);
 
 	return ret;
 }
 
+static int mt6359_get_playback_volsw(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+			snd_soc_kcontrol_component(kcontrol);
+	struct mt6359_priv *priv = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+			(struct soc_mixer_control *)kcontrol->private_value;
+
+	switch (mc->reg) {
+	case MT6359_ZCD_CON2:
+		ucontrol->value.integer.value[0] =
+			priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL];
+		ucontrol->value.integer.value[1] =
+			priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTR];
+		break;
+	case MT6359_ZCD_CON1:
+		ucontrol->value.integer.value[0] =
+			priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTL];
+		ucontrol->value.integer.value[1] =
+			priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTR];
+		break;
+	case MT6359_ZCD_CON3:
+		ucontrol->value.integer.value[0] =
+			priv->ana_gain[AUDIO_ANALOG_VOLUME_HSOUTL];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* MUX */
 
 /* LOL MUX */
@@ -2701,22 +2776,23 @@ static void mt6359_codec_remove(struct snd_soc_component *cmpnt)
 	cmpnt->regmap = NULL;
 }
 
-static const DECLARE_TLV_DB_SCALE(hp_playback_tlv, -2200, 100, 0);
 static const DECLARE_TLV_DB_SCALE(playback_tlv, -1000, 100, 0);
 static const DECLARE_TLV_DB_SCALE(capture_tlv, 0, 600, 0);
 
 static const struct snd_kcontrol_new mt6359_snd_controls[] = {
 	/* dl pga gain */
 	SOC_DOUBLE_EXT_TLV("Headset Volume",
-			   MT6359_ZCD_CON2, 0, 7, 0x1E, 0,
-			   snd_soc_get_volsw, mt6359_put_volsw,
-			   hp_playback_tlv),
+			   MT6359_ZCD_CON2, 0, 7, 0x12, 0,
+			   mt6359_get_playback_volsw, mt6359_put_volsw,
+			   playback_tlv),
 	SOC_DOUBLE_EXT_TLV("Lineout Volume",
 			   MT6359_ZCD_CON1, 0, 7, 0x12, 0,
-			   snd_soc_get_volsw, mt6359_put_volsw, playback_tlv),
+			   mt6359_get_playback_volsw, mt6359_put_volsw,
+			   playback_tlv),
 	SOC_SINGLE_EXT_TLV("Handset Volume",
 			   MT6359_ZCD_CON3, 0, 0x12, 0,
-			   snd_soc_get_volsw, mt6359_put_volsw, playback_tlv),
+			   mt6359_get_playback_volsw, mt6359_put_volsw,
+			   playback_tlv),
 
 	/* ul pga gain */
 	SOC_SINGLE_EXT_TLV("PGA1 Volume",
-- 
2.18.0

