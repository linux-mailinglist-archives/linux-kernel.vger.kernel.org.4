Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03E564D8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLOJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLOJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:36:37 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E13E1BEA5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:36:35 -0800 (PST)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 777438545C;
        Thu, 15 Dec 2022 10:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671096993;
        bh=oiKjUSVH5uK/pWgVkrX+OK/iXRcHm6MR6HJuO3zfPsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUF8YwVzhNfnzvb2dDSDON3GnjGeDp+Xte59V0mvk320OKZv8SR149C5+CiOYG4nz
         dRgSMkWQyzRJNzYzETcN/eTivqtIjIN1EeENJ1X84a+AXBzdrelL0O9NJnahoDbKEz
         NlBh/e/Pr2JmXDZWPDmIjvi7+/zv14Sx8NQkgKsdeucAw+NoNzXZhfh8WZToY0QIwC
         CtpTNtTJ0xoaFKDd9+kVNYwe10w9G9dA0FzAoYH3GSTE0Al8ms+XfIEdl5TQ2+gzDa
         rshvt+t7PuWf3u781BGu4omBeFZffhbtU8aKltuSYqrbVbsQFzpKtO3Mq/abWavscC
         14AskiGOdRdbg==
From:   Lukasz Majewski <lukma@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Stephen Kitt <steve@sk2.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 2/3] ASoC: wm8940: Rewrite code to set proper clocks
Date:   Thu, 15 Dec 2022 10:36:14 +0100
Message-Id: <20221215093615.3794156-2-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221215093615.3794156-1-lukma@denx.de>
References: <20221214123743.3713843-1-lukma@denx.de>
 <20221215093615.3794156-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables support for internal wm8940's PLL and proper
divider to set proper value for 256x fs clock.

This approach is more flexible and replaces hardcoded clock
values and makes the codec work with the simple-card driver.
Card drivers calling set_pll() and set_clkdiv() directly are
unaffected.

For the reference - code in this commit is based on:
"ASoC: wm8974: configure pll and mclk divider automatically"
(SHA1: 51b2bb3f2568e6d9d81a001d38b8d70c2ba4af99).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Remove not required line add/remove
- Rewrite the commit message to describe more precisely the
  problem
---
 sound/soc/codecs/wm8940.c | 101 +++++++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 0b59020d747f..1b02d5e8a007 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -37,7 +37,9 @@
 #include "wm8940.h"
 
 struct wm8940_priv {
-	unsigned int sysclk;
+	unsigned int mclk;
+	unsigned int fs;
+
 	struct regmap *regmap;
 };
 
@@ -387,17 +389,24 @@ static int wm8940_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int wm8940_update_clocks(struct snd_soc_dai *dai);
 static int wm8940_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct wm8940_priv *priv = snd_soc_component_get_drvdata(component);
 	u16 iface = snd_soc_component_read(component, WM8940_IFACE) & 0xFD9F;
 	u16 addcntrl = snd_soc_component_read(component, WM8940_ADDCNTRL) & 0xFFF1;
 	u16 companding =  snd_soc_component_read(component,
 						WM8940_COMPANDINGCTL) & 0xFFDF;
 	int ret;
 
+	priv->fs = params_rate(params);
+	ret = wm8940_update_clocks(dai);
+	if (ret)
+		return ret;
+
 	/* LoutR control */
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE
 	    && params_channels(params) == 2)
@@ -611,24 +620,6 @@ static int wm8940_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	return 0;
 }
 
-static int wm8940_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-				 int clk_id, unsigned int freq, int dir)
-{
-	struct snd_soc_component *component = codec_dai->component;
-	struct wm8940_priv *wm8940 = snd_soc_component_get_drvdata(component);
-
-	switch (freq) {
-	case 11289600:
-	case 12000000:
-	case 12288000:
-	case 16934400:
-	case 18432000:
-		wm8940->sysclk = freq;
-		return 0;
-	}
-	return -EINVAL;
-}
-
 static int wm8940_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 				 int div_id, int div)
 {
@@ -653,6 +644,78 @@ static int wm8940_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 	return ret;
 }
 
+static unsigned int wm8940_get_mclkdiv(unsigned int f_in, unsigned int f_out,
+				       int *mclkdiv)
+{
+	unsigned int ratio = 2 * f_in / f_out;
+
+	if (ratio <= 2) {
+		*mclkdiv = WM8940_MCLKDIV_1;
+		ratio = 2;
+	} else if (ratio == 3) {
+		*mclkdiv = WM8940_MCLKDIV_1_5;
+	} else if (ratio == 4) {
+		*mclkdiv = WM8940_MCLKDIV_2;
+	} else if (ratio <= 6) {
+		*mclkdiv = WM8940_MCLKDIV_3;
+		ratio = 6;
+	} else if (ratio <= 8) {
+		*mclkdiv = WM8940_MCLKDIV_4;
+		ratio = 8;
+	} else if (ratio <= 12) {
+		*mclkdiv = WM8940_MCLKDIV_6;
+		ratio = 12;
+	} else if (ratio <= 16) {
+		*mclkdiv = WM8940_MCLKDIV_8;
+		ratio = 16;
+	} else {
+		*mclkdiv = WM8940_MCLKDIV_12;
+		ratio = 24;
+	}
+
+	return f_out * ratio / 2;
+}
+
+static int wm8940_update_clocks(struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *codec = dai->component;
+	struct wm8940_priv *priv = snd_soc_component_get_drvdata(codec);
+	unsigned int fs256;
+	unsigned int fpll = 0;
+	unsigned int f;
+	int mclkdiv;
+
+	if (!priv->mclk || !priv->fs)
+		return 0;
+
+	fs256 = 256 * priv->fs;
+
+	f = wm8940_get_mclkdiv(priv->mclk, fs256, &mclkdiv);
+	if (f != priv->mclk) {
+		/* The PLL performs best around 90MHz */
+		fpll = wm8940_get_mclkdiv(22500000, fs256, &mclkdiv);
+	}
+
+	wm8940_set_dai_pll(dai, 0, 0, priv->mclk, fpll);
+	wm8940_set_dai_clkdiv(dai, WM8940_MCLKDIV, mclkdiv);
+
+	return 0;
+}
+
+static int wm8940_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+				 unsigned int freq, int dir)
+{
+	struct snd_soc_component *codec = dai->component;
+	struct wm8940_priv *priv = snd_soc_component_get_drvdata(codec);
+
+	if (dir != SND_SOC_CLOCK_IN)
+		return -EINVAL;
+
+	priv->mclk = freq;
+
+	return wm8940_update_clocks(dai);
+}
+
 #define WM8940_RATES SNDRV_PCM_RATE_8000_48000
 
 #define WM8940_FORMATS (SNDRV_PCM_FMTBIT_S8 |				\
-- 
2.20.1

