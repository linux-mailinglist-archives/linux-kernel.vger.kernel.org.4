Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091B35B3A1B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiIINzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiIINyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:54:45 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE3D5FDD;
        Fri,  9 Sep 2022 06:54:39 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662731677; bh=Z7pYWBxGHGi2ZqyTkPEZO2suk0cCsfJNF1GKYGMYE+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YIrvjtlCimCjWTg2ae3mEonUuQy1i8q8nTG/UASHn9xFMpLmofoXtJV8M9onSKS48
         UptY1jVASNQwNQ6t5KwTomsiqGd+LU/5OUfQyjfCqiI7v+ASWdZTTBiuTk03IZ/9xH
         2wOEezk/qHdL/U+idErfiohqp9IecoqzfSklgT4Q=
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matt Flax <flatmax@flatmax.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH 02/10] ASoC: cs42l42: Add bitclock frequency argument to cs42l42_pll_config()
Date:   Fri,  9 Sep 2022 15:53:26 +0200
Message-Id: <20220909135334.98220-3-povik+lin@cutebit.org>
In-Reply-To: <20220909135334.98220-1-povik+lin@cutebit.org>
References: <20220909135334.98220-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

Clean up the handling of bitclock frequency by keeping all the logic
in cs42l42_pcm_hw_params(), which then simply passes the frequency as
an argument to cs42l42_pll_config().

The previous code had become clunky as a legacy of earlier versions of
the clock handling. The logic was split across cs42l42_pcm_hw_params()
and cs42l42_pll_config(), with the params-derived bclk stashed in
struct cs42l42_private only to pass it to cs42l42_pll_config().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/cs42l42.c | 32 ++++++++++++++++----------------
 sound/soc/codecs/cs42l42.h |  1 -
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index de1e276bdf7d..0048ce977645 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -647,18 +647,12 @@ static const struct cs42l42_pll_params pll_ratio_table[] = {
 	{ 24576000, 1, 0x03, 0x40, 0x000000, 0x03, 0x10, 12288000, 128, 1}
 };
 
-static int cs42l42_pll_config(struct snd_soc_component *component)
+static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int clk)
 {
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	int i;
-	u32 clk;
 	u32 fsync;
 
-	if (!cs42l42->sclk)
-		clk = cs42l42->bclk;
-	else
-		clk = cs42l42->sclk;
-
 	/* Don't reconfigure if there is an audio stream running */
 	if (cs42l42->stream_use) {
 		if (pll_ratio_table[cs42l42->pll_config].sclk == clk)
@@ -895,19 +889,25 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 	unsigned int width = (params_width(params) / 8) - 1;
 	unsigned int slot_width = 0;
 	unsigned int val = 0;
+	unsigned int bclk;
 	int ret;
 
 	cs42l42->srate = params_rate(params);
 
-	/*
-	 * Assume 24-bit samples are in 32-bit slots, to prevent SCLK being
-	 * more than assumed (which would result in overclocking).
-	 */
-	if (params_width(params) == 24)
-		slot_width = 32;
+	if (cs42l42->sclk) {
+		/* machine driver has set the SCLK */
+		bclk = cs42l42->sclk;
+	} else {
+		/*
+		 * Assume 24-bit samples are in 32-bit slots, to prevent SCLK being
+		 * more than assumed (which would result in overclocking).
+		 */
+		if (params_width(params) == 24)
+			slot_width = 32;
 
-	/* I2S frame always has multiple of 2 channels */
-	cs42l42->bclk = snd_soc_tdm_params_to_bclk(params, slot_width, 0, 2);
+		/* I2S frame always has multiple of 2 channels */
+		bclk = snd_soc_tdm_params_to_bclk(params, slot_width, 0, 2);
+	}
 
 	switch (substream->stream) {
 	case SNDRV_PCM_STREAM_CAPTURE:
@@ -947,7 +947,7 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	ret = cs42l42_pll_config(component);
+	ret = cs42l42_pll_config(component, bclk);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 50299c9f283a..b4ba1467c558 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -30,7 +30,6 @@ struct  cs42l42_private {
 	struct snd_soc_jack *jack;
 	struct mutex irq_lock;
 	int pll_config;
-	int bclk;
 	u32 sclk;
 	u32 srate;
 	u8 plug_state;
-- 
2.33.0

