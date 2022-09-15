Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DEB5B97F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIOJqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiIOJpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:45:43 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B180899B5C;
        Thu, 15 Sep 2022 02:45:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663235135; bh=QkNDCDx0U/aAsQx4/+vROBFRgvKACQCU9RfjxhOvKBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=G6xgM0rrHVLyrNxwx9hnKCw0GjK7FUwtZ8nu229+b6GUs0uYBKnGLZ3gj9rI3PZLt
         V54934ZLw4MW4JxK4T/IA0vTQ5qE8ntu6LKxNWH00k7fbsVcoboLhpmniNY+htUAqn
         r44N+3xdMHvacdE3zaukF1x7P7YPEY+otdGf3PFE=
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
Subject: [PATCH v2 06/11] ASoC: cs42l42: Pass component and dai defs into common probe
Date:   Thu, 15 Sep 2022 11:44:39 +0200
Message-Id: <20220915094444.11434-7-povik+lin@cutebit.org>
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

Pass pointers to snd_soc_component_driver and snd_soc_dai_driver
objects into cs42l42_common_probe().

This is in preparation for adding SoundWire support.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/cs42l42.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 156d1b181cef..a4bb6f5d2267 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -579,7 +579,7 @@ static int cs42l42_set_jack(struct snd_soc_component *component, struct snd_soc_
 	return 0;
 }
 
-static const struct snd_soc_component_driver soc_component_dev_cs42l42 = {
+static const struct snd_soc_component_driver cs42l42_soc_component = {
 	.set_jack		= cs42l42_set_jack,
 	.dapm_widgets		= cs42l42_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(cs42l42_dapm_widgets),
@@ -2219,7 +2219,9 @@ static int __maybe_unused cs42l42_i2c_resume(struct device *dev)
 	return 0;
 }
 
-static int cs42l42_common_probe(struct cs42l42_private *cs42l42)
+static int cs42l42_common_probe(struct cs42l42_private *cs42l42,
+				const struct snd_soc_component_driver *component_drv,
+				struct snd_soc_dai_driver *dai)
 {
 	int ret, i;
 
@@ -2275,9 +2277,7 @@ static int cs42l42_common_probe(struct cs42l42_private *cs42l42)
 	}
 
 	/* Register codec now so it can EPROBE_DEFER */
-	ret = devm_snd_soc_register_component(cs42l42->dev,
-					      &soc_component_dev_cs42l42,
-					      &cs42l42_dai, 1);
+	ret = devm_snd_soc_register_component(cs42l42->dev, component_drv, dai, 1);
 	if (ret < 0)
 		goto err;
 
@@ -2416,7 +2416,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	cs42l42->regmap = regmap;
 	cs42l42->irq = i2c_client->irq;
 
-	ret = cs42l42_common_probe(cs42l42);
+	ret = cs42l42_common_probe(cs42l42, &cs42l42_soc_component, &cs42l42_dai);
 	if (ret)
 		return ret;
 
-- 
2.33.0

