Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5256B83F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCMV3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCMV3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:29:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB2A7203A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:29:32 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A86B4660308F;
        Mon, 13 Mar 2023 21:29:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678742971;
        bh=mWFcFs6EaqxA+zO4mnrYdfWBJNLnPvbamIJ4mjHcCOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mmOtB8Dm37lrB6dpX7uwY8hJ4Rd3Lj3BLfyDMa85FoEWZf9r/NVcsUQeY641Sb7bD
         FSe8vOQuzj1u6pfhd07PpCKZBNuzD4BvaGW2Jko1gEZfKjhu47A73xmFyFUFkoZnaK
         3aP5jrM0DYtJiDNYpgVG+qxXS1d+bFLxV+LywpXCnWs1/FD3gGO7+WNHSpb2KqExkD
         Zw7WI/pyNAF8965JoMRyRdNv1sGb2BT/A1ADCmINjSy3Nfs8Xn2DMrBoKKs7q1RD3f
         av9HyBfR6hm2JRW4dz7EL0U8geAaCczuwwTnnWj97faX2ZkNFxsqO5GmCJAiyHuOnx
         S0WmmPwELnggw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] ASoC: mt8192: Move spammy messages to debug level
Date:   Mon, 13 Mar 2023 17:29:07 -0400
Message-Id: <20230313212908.2282961-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313212908.2282961-1-nfraprado@collabora.com>
References: <20230313212908.2282961-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many log messages throughout the mt8192 sound drivers that
print to the info level and are triggered very frequently. Move these
messages to the debug level to avoid spamming the console.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c    |  2 +-
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c    | 26 +++++++++----------
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 10 +++----
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index a420b78dde89..333e0ee98c5a 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -369,7 +369,7 @@ static int ul_tinyconn_event(struct snd_soc_dapm_widget *w,
 	unsigned int reg_shift;
 	unsigned int reg_mask_shift;
 
-	dev_info(afe->dev, "%s(), event 0x%x\n", __func__, event);
+	dev_dbg(afe->dev, "%s(), event 0x%x\n", __func__, event);
 
 	if (strstr(w->name, "UL1")) {
 		reg_shift = VUL1_USE_TINY_SFT;
diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
index bcd2150c2816..9ce06821c7d0 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
@@ -256,8 +256,8 @@ static int mtk_tdm_en_event(struct snd_soc_dapm_widget *w,
 		return -EINVAL;
 	}
 
-	dev_info(cmpnt->dev, "%s(), name %s, event 0x%x\n",
-		 __func__, w->name, event);
+	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x\n",
+		__func__, w->name, event);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -288,8 +288,8 @@ static int mtk_tdm_bck_en_event(struct snd_soc_dapm_widget *w,
 		return -EINVAL;
 	}
 
-	dev_info(cmpnt->dev, "%s(), name %s, event 0x%x, dai_id %d\n",
-		 __func__, w->name, event, dai_id);
+	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x, dai_id %d\n",
+		__func__, w->name, event, dai_id);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -320,8 +320,8 @@ static int mtk_tdm_mck_en_event(struct snd_soc_dapm_widget *w,
 		return -EINVAL;
 	}
 
-	dev_info(cmpnt->dev, "%s(), name %s, event 0x%x, dai_id %d\n",
-		 __func__, w->name, event, dai_id);
+	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x, dai_id %d\n",
+		__func__, w->name, event, dai_id);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -545,13 +545,13 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 	if (tdm_priv->mclk_rate % tdm_priv->bck_rate != 0)
 		dev_warn(afe->dev, "%s(), bck cannot generate", __func__);
 
-	dev_info(afe->dev, "%s(), id %d, rate %d, channels %d, format %d, mclk_rate %d, bck_rate %d\n",
-		 __func__,
-		 tdm_id, rate, channels, format,
-		 tdm_priv->mclk_rate, tdm_priv->bck_rate);
+	dev_dbg(afe->dev, "%s(), id %d, rate %d, channels %d, format %d, mclk_rate %d, bck_rate %d\n",
+		__func__,
+		tdm_id, rate, channels, format,
+		tdm_priv->mclk_rate, tdm_priv->bck_rate);
 
-	dev_info(afe->dev, "%s(), out_channels_per_sdata = %d\n",
-		 __func__, out_channels_per_sdata);
+	dev_dbg(afe->dev, "%s(), out_channels_per_sdata = %d\n",
+		__func__, out_channels_per_sdata);
 
 	/* set tdm */
 	if (tdm_priv->bck_invert)
@@ -644,7 +644,7 @@ static int mtk_dai_tdm_set_sysclk(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	dev_info(afe->dev, "%s(), freq %d\n", __func__, freq);
+	dev_dbg(afe->dev, "%s(), freq %d\n", __func__, freq);
 
 	return mtk_dai_tdm_cal_mclk(afe, tdm_priv, freq);
 }
diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index 87737d054682..5e163e23a207 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -292,11 +292,11 @@ static int mt8192_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
 	mt8192_afe_gpio_request(afe->dev, false, MT8192_DAI_ADDA_CH34, 0);
 	pm_runtime_put(afe->dev);
 
-	dev_info(afe->dev, "%s(), mtkaif_chosen_phase[0/1/2]:%d/%d/%d\n",
-		 __func__,
-		 afe_priv->mtkaif_chosen_phase[0],
-		 afe_priv->mtkaif_chosen_phase[1],
-		 afe_priv->mtkaif_chosen_phase[2]);
+	dev_dbg(afe->dev, "%s(), mtkaif_chosen_phase[0/1/2]:%d/%d/%d\n",
+		__func__,
+		afe_priv->mtkaif_chosen_phase[0],
+		afe_priv->mtkaif_chosen_phase[1],
+		afe_priv->mtkaif_chosen_phase[2]);
 
 	return 0;
 }
-- 
2.39.2

