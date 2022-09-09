Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0785B3409
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiIIJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiIIJcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:32:20 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87410D51DC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662715810;
  x=1694251810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5kDWDLM4dvskJrZT61dQQhMEV6z9clf/KDjy1daE//E=;
  b=ZBVMNSVRckIYBdIBpFJIJG2LzwctJylgvHmyLc+IxR0LjKdug3P0Y20f
   fgXmqHTX7dtIrz4c/7hPzWbPyMtDnUwrVnlJJNAaWbztc0nWr09Y4Y0LW
   jKTgmfT/uL3ukAyTR9GEjOa+Lo7PLOVp80Gyka3BaHtBTO6vpjOTk2q/w
   HdmSonO/HEsVTU1DeAyHJtcL54YZik/6w5BC93Fc1bW1vwvaFCbnytNYR
   rvhxddNhFobVHBt1eWpy2+C8Wz5X3QlWGEgTWSuusNJkwXoNayqfbxV37
   Ze6lCm0/w7+1RN93tyI/i7P2gQuVAnlz0xyXFNGgr6tDB1/2mnAtaaYX8
   A==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <kernel@axis.com>,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        Astrid Rost <astrid.rost@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: ts3a227e: allow enabling the jack detect in driver
Date:   Fri, 9 Sep 2022 11:30:01 +0200
Message-ID: <20220909093001.13110-1-astrid.rost@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ti,jack-detect enables the jack detection input device

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 sound/soc/codecs/Kconfig    |  2 ++
 sound/soc/codecs/ts3a227e.c | 62 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d16b4efb88a7..cb86e52cd02f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1671,6 +1671,8 @@ config SND_SOC_TLV320ADCX140
 config SND_SOC_TS3A227E
 	tristate "TI Headset/Mic detect and keypress chip"
 	depends on I2C
+	select SND_JACK
+	select SND_JACK_INPUT_DEV
 
 config SND_SOC_TSCS42XX
 	tristate "Tempo Semiconductor TSCS42xx CODEC"
diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index d8ab0810fceb..b5d0d32cafdb 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -38,6 +38,32 @@ static const int ts3a227e_buttons[] = {
 	SND_JACK_BTN_3,
 };
 
+/* Headphones jack detection DAPM pin */
+static struct snd_soc_jack_pin ts3a227e_jack_pins[] = {
+
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Internal Speaker",
+		/* disable speaker when hp jack is inserted */
+		.mask = SND_JACK_HEADPHONE,
+		.invert	= 1,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Internal Mic",
+		/* disable microphone when microphone jack is inserted */
+		.mask = SND_JACK_MICROPHONE,
+		.invert	= 1,
+	},
+
+};
+
 #define TS3A227E_NUM_BUTTONS 4
 #define TS3A227E_JACK_MASK (SND_JACK_HEADPHONE | \
 			    SND_JACK_MICROPHONE | \
@@ -250,7 +276,12 @@ int ts3a227e_enable_jack_detect(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(ts3a227e_enable_jack_detect);
 
-static struct snd_soc_component_driver ts3a227e_soc_driver;
+static int ts3a227e_probe(struct snd_soc_component *component);
+
+static const struct snd_soc_component_driver ts3a227e_soc_driver = {
+	.name = "Audio Accessory Detection ts3a227e",
+	.probe = ts3a227e_probe,
+};
 
 static const struct regmap_config ts3a227e_regmap_config = {
 	.val_bits = 8,
@@ -355,6 +386,35 @@ static int ts3a227e_resume(struct device *dev)
 }
 #endif
 
+static int ts3a227e_probe(struct snd_soc_component *component)
+{
+	int ret = 0;
+	bool enable = 0;
+	struct snd_soc_card *card = component->card;
+	struct ts3a227e *ts3a227e = snd_soc_component_get_drvdata(component);
+
+	enable = device_property_read_bool(component->dev, "ti,jack-detect");
+	if (enable) {
+		/* Enable Headset and 4 Buttons Jack detection */
+		ts3a227e->jack = devm_kzalloc(component->dev,
+				sizeof(struct snd_soc_jack), GFP_KERNEL);
+
+		ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					    SND_JACK_HEADSET |
+					    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					    SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					    ts3a227e->jack,
+					    ts3a227e_jack_pins,
+					    ARRAY_SIZE(ts3a227e_jack_pins));
+		if (ret)
+			return ret;
+
+		ret = ts3a227e_enable_jack_detect(component, ts3a227e->jack);
+	}
+
+	return ret;
+}
+
 static const struct dev_pm_ops ts3a227e_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(ts3a227e_suspend, ts3a227e_resume)
 };
-- 
2.20.1

