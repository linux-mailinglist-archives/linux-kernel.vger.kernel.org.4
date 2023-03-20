Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A71B6C232A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCTUxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCTUxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:53:43 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F34D32CF8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:53:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id E712C16C004E;
        Mon, 20 Mar 2023 22:35:25 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ATKV22FdkbbL; Mon, 20 Mar 2023 22:35:24 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1679344524; bh=GC5sVkvOni4mr77iGtpCS30XrOnHNfFi25Iw8L/nRxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwrkcMN/5cd3mPPHPOLS53EvBAgNRnUsMLad6JYLO2a2jtOT76H6k0XfOWmKQtmwG
         cDfmO79n3Z/hyodiC9iIMrBxOSpNyy1rwdnkEG4w8pOhX+tPD86whjfrCVRXGvMFGZ
         8yIKpVnFQWK5PI0CPZ76y/uG4B8SPaRnLUbI4lsI=
To:     Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH 1/4] ASoC: es8316: Enable support for S32 LE format and MCLK div by 2
Date:   Mon, 20 Mar 2023 22:35:16 +0200
Message-Id: <20230320203519.20137-2-posteuca@mutex.one>
In-Reply-To: <20230320203519.20137-1-posteuca@mutex.one>
References: <20230320203519.20137-1-posteuca@mutex.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To properly support a line of Huawei laptops with AMD CPU and a
ES8336 codec connected to the ACP3X module we need to enable
the S32 LE format and the codec option to divide the MCLK by 2.

The option to divide the MCLK will be enabled for one SKU with a
48Mhz MCLK. This frequency seems to be too high for the codec and
leads to distorted sounds when the option is not enabled.

Signed-off-by: Marian Postevca <posteuca@mutex.one>
---
 sound/soc/codecs/es8316.c | 21 +++++++++++++++++----
 sound/soc/codecs/es8316.h |  3 +++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 056c3082fe02..acf21ef59b34 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -26,10 +26,11 @@
 /* In slave mode at single speed, the codec is documented as accepting 5
  * MCLK/LRCK ratios, but we also add ratio 400, which is commonly used on
  * Intel Cherry Trail platforms (19.2MHz MCLK, 48kHz LRCK).
+ * Ratio 1000 is needed for at least one SKU where MCLK is 48Mhz.
  */
-#define NR_SUPPORTED_MCLK_LRCK_RATIOS 6
+#define NR_SUPPORTED_MCLK_LRCK_RATIOS 7
 static const unsigned int supported_mclk_lrck_ratios[] = {
-	256, 384, 400, 512, 768, 1024
+	256, 384, 400, 512, 768, 1000, 1024
 };
 
 struct es8316_priv {
@@ -465,6 +466,8 @@ static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
 	u8 bclk_divider;
 	u16 lrck_divider;
 	int i;
+	bool mclk_div_option = false;
+	unsigned int mclk_div = 1;
 
 	/* Validate supported sample rates that are autodetected from MCLK */
 	for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
@@ -477,7 +480,17 @@ static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 	if (i == NR_SUPPORTED_MCLK_LRCK_RATIOS)
 		return -EINVAL;
-	lrck_divider = es8316->sysclk / params_rate(params);
+
+	mclk_div_option = device_property_read_bool(component->dev,
+						    "everest,mclk-div-by-2");
+	if (mclk_div_option) {
+		snd_soc_component_update_bits(component, ES8316_CLKMGR_CLKSW,
+					      ES8316_CLKMGR_CLKSW_MCLK_DIV,
+					      ES8316_CLKMGR_CLKSW_MCLK_DIV);
+		mclk_div = 2;
+	}
+
+	lrck_divider = es8316->sysclk / params_rate(params) / mclk_div;
 	bclk_divider = lrck_divider / 4;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -520,7 +533,7 @@ static int es8316_mute(struct snd_soc_dai *dai, int mute, int direction)
 }
 
 #define ES8316_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
-			SNDRV_PCM_FMTBIT_S24_LE)
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops es8316_ops = {
 	.startup = es8316_pcm_startup,
diff --git a/sound/soc/codecs/es8316.h b/sound/soc/codecs/es8316.h
index c335138e2837..0ff16f948690 100644
--- a/sound/soc/codecs/es8316.h
+++ b/sound/soc/codecs/es8316.h
@@ -129,4 +129,7 @@
 #define ES8316_GPIO_FLAG_GM_NOT_SHORTED		0x02
 #define ES8316_GPIO_FLAG_HP_NOT_INSERTED	0x04
 
+/* ES8316_CLKMGR_CLKSW */
+#define ES8316_CLKMGR_CLKSW_MCLK_DIV	0x80
+
 #endif
-- 
2.39.1

