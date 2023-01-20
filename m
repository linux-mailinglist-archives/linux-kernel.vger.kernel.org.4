Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4B675259
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjATK0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjATK0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:26:09 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170399084D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674210365;
  x=1705746365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U2imJO+1R/ob6ECocsNc0QXBaMhDnHjJe1WKPivTPyc=;
  b=cS3zSBYiP6ELvWA5DFzEW/5wbkEsy3SrmwX0mrege+DuFVl8LqKghAPR
   pSJQRRbbTaqKzFNyd5H3XuUdNpJQuHKwxfVJEX5CFyytmu+jfGWmeBTdD
   KO3DA19EP8pX8cE78nEHW8m1xhRxIdU9WPc65kGt/DyKuwMcqoboZXWor
   Yah4mLgIftYbPJ8rvTKEponll+UiA6Trg41M14JNOgNCm1U9vb3KJg1WL
   wKyuZsqcTpMgfwIyhAOD83vxjZyXtZ79l1U+hHaas/AFOqUEu4HlEFz9j
   HbGJ5x1xoUPsErydFBHclJjCdI9plZRHd4QlEYFeKaLVeAxCXIRHJQJ1r
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v2 3/4] ASoC: ts3a227e: add set_jack and get_jack_type
Date:   Fri, 20 Jan 2023 11:25:53 +0100
Message-ID: <20230120102555.1523394-4-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120102555.1523394-1-astrid.rost@axis.com>
References: <20230120102555.1523394-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add set_jack and get_jack_type to allow simple-card-utils to add
a jack for it.

Add a devicetree entry jack-type of type snd_jack_type, in case not
all input types are required.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 sound/soc/codecs/ts3a227e.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 2305a472d132..432a327c6eb7 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -28,6 +28,7 @@ struct ts3a227e {
 	bool mic_present;
 	unsigned int buttons_held;
 	int irq;
+	int jack_type;
 };
 
 /* Button values to be reported on the jack */
@@ -258,7 +259,27 @@ int ts3a227e_enable_jack_detect(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(ts3a227e_enable_jack_detect);
 
-static struct snd_soc_component_driver ts3a227e_soc_driver;
+static int ts3a227e_set_jack(struct snd_soc_component *component,
+			     struct snd_soc_jack *jack, void *data)
+{
+	if (jack == NULL)
+		return -EINVAL;
+
+	return ts3a227e_enable_jack_detect(component, jack);
+}
+
+static int ts3a227e_get_jack_type(struct snd_soc_component *component)
+{
+	struct ts3a227e *ts3a227e = snd_soc_component_get_drvdata(component);
+
+	return ts3a227e->jack_type;
+}
+
+static const struct snd_soc_component_driver ts3a227e_soc_driver = {
+	.name = "ti,ts3a227e",
+	.set_jack = ts3a227e_set_jack,
+	.get_jack_type = ts3a227e_get_jack_type,
+};
 
 static const struct regmap_config ts3a227e_regmap_config = {
 	.val_bits = 8,
@@ -283,6 +304,12 @@ static int ts3a227e_parse_device_property(struct ts3a227e *ts3a227e,
 	u32 setting3_mask = 0;
 	int err;
 
+	err = device_property_read_u32(dev, "jack-type", &value);
+	if (!err)
+		ts3a227e->jack_type = value & SND_JACK_HEADSET;
+	else
+		ts3a227e->jack_type = SND_JACK_HEADSET;
+
 	err = device_property_read_u32(dev, "ti,micbias", &value);
 	if (!err) {
 		setting3_mask = MICBIAS_SETTING_MASK;
-- 
2.30.2

