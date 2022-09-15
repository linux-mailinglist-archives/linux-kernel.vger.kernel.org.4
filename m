Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DE55B97DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiIOJqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIOJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:45:39 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3000660531;
        Thu, 15 Sep 2022 02:45:36 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663235133; bh=RnoRkuWr8/cOTZp+UVU+8HJliq7IWrJl0jk4wjs4inI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rZAk85JGtc7RNq70RU9onoXNJ366+U5FbkK8JLMpr/xsiR1vTr1dgcNidX9cZMkyP
         GnWoEbFNOvDnCLvf/uYdpfCNCMvEl5r0CLcGxWMpKoqP5FkA9AVPJTIiKRYt/Q8rxN
         QoJSA1TcyNpBBa0HkSmwbdoINGWZflsnEMjvflIY=
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Matt Flax <flatmax@flatmax.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH v2 02/11] ASoC: cs42l42: Add bitclock frequency argument to cs42l42_pll_config()
Date:   Thu, 15 Sep 2022 11:44:35 +0200
Message-Id: <20220915094444.11434-3-povik+lin@cutebit.org>
In-Reply-To: <20220915094444.11434-1-povik+lin@cutebit.org>
References: <20220915094444.11434-1-povik+lin@cutebit.org>
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
index 162540c153f9..4b92ee0e67c4 100644
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

