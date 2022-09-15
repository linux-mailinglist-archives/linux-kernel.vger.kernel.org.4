Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FC65B97F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIOJrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiIOJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:45:45 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B206D99B6B;
        Thu, 15 Sep 2022 02:45:41 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663235137; bh=RYvMqhdnzL8RPlR9TpcOtA7UqSXk+T+8HMSs+nwHUT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cFhRzEkoYwohnQsDEnr6aUWMfMKipUR8Feq3jxl40+gC6PjMguEAK/PFnqbft3/oI
         mcqLjLhoX/Ls1umQzkw5gT9hVnfudMaW/qAmIBI0UZYz0EvpNjWP9MIOnJQbCkg3Bd
         bbZ21Kxxj2ZGj/XdWbnvZRH1jQmdqWO2TVpOAggU=
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
Subject: [PATCH v2 10/11] ASoC: cs42l42: Implement 'set_bclk_ratio'
Date:   Thu, 15 Sep 2022 11:44:43 +0200
Message-Id: <20220915094444.11434-11-povik+lin@cutebit.org>
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

The driver wants to know the bit rate on the serial bus and takes that
to be the value set by 'set_sysclk'. The 'set_bclk_ratio' op is a better
fit for figuring out the clocking parameters of the serial bus, so
implement that and give it precedence over the prior methods.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/cs42l42.c | 17 ++++++++++++++++-
 sound/soc/codecs/cs42l42.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index c1d7eb12b0ba..05995ed1d3f5 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -898,7 +898,10 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	cs42l42->srate = params_rate(params);
 
-	if (cs42l42->sclk) {
+	if (cs42l42->bclk_ratio) {
+		/* machine driver has set the BCLK/samp-rate ratio */
+		bclk = cs42l42->bclk_ratio * params_rate(params);
+	} else if (cs42l42->sclk) {
 		/* machine driver has set the SCLK */
 		bclk = cs42l42->sclk;
 	} else {
@@ -984,6 +987,17 @@ static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
 	return -EINVAL;
 }
 
+static int cs42l42_set_bclk_ratio(struct snd_soc_dai *dai,
+				unsigned int bclk_ratio)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
+
+	cs42l42->bclk_ratio = bclk_ratio;
+
+	return 0;
+}
+
 static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	struct snd_soc_component *component = dai->component;
@@ -1087,6 +1101,7 @@ static const struct snd_soc_dai_ops cs42l42_ops = {
 	.hw_params	= cs42l42_pcm_hw_params,
 	.set_fmt	= cs42l42_set_dai_fmt,
 	.set_sysclk	= cs42l42_set_sysclk,
+	.set_bclk_ratio	= cs42l42_set_bclk_ratio,
 	.mute_stream	= cs42l42_mute_stream,
 };
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index bc51bb09da5c..a72136664112 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -35,6 +35,7 @@ struct  cs42l42_private {
 	int irq;
 	int pll_config;
 	u32 sclk;
+	u32 bclk_ratio;
 	u32 srate;
 	u8 plug_state;
 	u8 hs_type;
-- 
2.33.0

