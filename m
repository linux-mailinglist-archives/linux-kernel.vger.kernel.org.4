Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3031706723
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEQLwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjEQLw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:52:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8676E3A9F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:52:27 -0700 (PDT)
X-UUID: 485434baf4a911ed9cb5633481061a41-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vnSdSNF6ArbJMg7lhVEfSNwHS80weL+zMJ+b2yfJtQY=;
        b=cG/uV2aYsQGtAXUOO0yKol+XyD4EvGSiEgNQya6vMA1byd2clpudTCI0mDrbssVHedPv+2RrsaKz8k6tSMI98tZO3DMUFmlkk76gD8ubZfJarfInQ9ZuYJwU7IKJAjlVGhYpz3jZihyDnSy0kABpPvxdVH+LGPEgT7hVLoF96Ks=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:ed52561d-5c6e-4c31-8f29-013b0dccb4d4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:49bd793b-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 485434baf4a911ed9cb5633481061a41-20230517
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 629873906; Wed, 17 May 2023 19:52:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 19:52:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 19:52:20 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <bicycle.tsai@mediatek.com>,
        <ting-fang.hou@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND 2/4] ASoC: mediatek: mt6359: fix kselftest error of playback gain
Date:   Wed, 17 May 2023 19:52:17 +0800
Message-ID: <20230517115219.532-3-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230517115219.532-1-trevor.wu@mediatek.com>
References: <20230517115219.532-1-trevor.wu@mediatek.com>
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

