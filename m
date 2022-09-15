Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26415B99CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIOLka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiIOLkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:06 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B94332B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663242004;
  x=1694778004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fWT8qRbiWNa5/mbcYWo86wQNVuPvppjS+ANHTTdMVNE=;
  b=Kx4Ef/2usLPJy8U9d3wAmR7bwFDPA5vW2riuzfNTpJPA8Djv23roDQ3m
   AKO1QkwqGWmnDB5WoeH1OQnvfTR4LLYGIqj0DtyLseDPyQFv7OhrWx38+
   A0RJyHidY++4yVuQJemqXfGXLipG5nHdYFS4asFK6fwTIZ9nKmquo7Om9
   j6Di/13Zb4rGeAFwURLjmmcIZqyw9YjRFl9ABTtOcNNoKzG1jDFie4wH7
   O6g4AZpsLAcRKlO1wJQhRrPSP3lmz580fidu5kjH04NQx8bnmKzdfkgrM
   RjiwFxZynoU+ssid5uIoWQ8Ed8hbULZoU3QcNnsZODKsylJKi3JtnTMDh
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dylan Reid <dgreid@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <kernel@axis.c>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astridr@axis.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v2 3/3] ASoC: ts3a227e: add parameters to control debounce times
Date:   Thu, 15 Sep 2022 13:39:55 +0200
Message-ID: <20220915113955.22521-4-astrid.rost@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220915113955.22521-1-astrid.rost@axis.com>
References: <20220915113955.22521-1-astrid.rost@axis.com>
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

Add devicetree parameters to control the insert, release and press
debounce times.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 sound/soc/codecs/ts3a227e.c | 58 +++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index d8ab0810fceb..f2d1367c46ca 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -78,12 +78,20 @@ static const int ts3a227e_buttons[] = {
 #define ADC_COMPLETE_INT_DISABLE 0x04
 #define INTB_DISABLE 0x08
 
+/* TS3A227E_REG_SETTING_1 0x4 */
+#define DEBOUNCE_INSERTION_SETTING_SFT (0)
+#define DEBOUNCE_INSERTION_SETTING_MASK (0x7 << DEBOUNCE_PRESS_SETTING_SFT)
+
 /* TS3A227E_REG_SETTING_2 0x05 */
 #define KP_ENABLE 0x04
 
 /* TS3A227E_REG_SETTING_3 0x06 */
-#define MICBIAS_SETTING_SFT (3)
+#define MICBIAS_SETTING_SFT 3
 #define MICBIAS_SETTING_MASK (0x7 << MICBIAS_SETTING_SFT)
+#define DEBOUNCE_RELEASE_SETTING_SFT 2
+#define DEBOUNCE_RELEASE_SETTING_MASK (0x1 << DEBOUNCE_RELEASE_SETTING_SFT)
+#define DEBOUNCE_PRESS_SETTING_SFT 0
+#define DEBOUNCE_PRESS_SETTING_MASK (0x3 << DEBOUNCE_PRESS_SETTING_SFT)
 
 /* TS3A227E_REG_ACCESSORY_STATUS  0x0b */
 #define TYPE_3_POLE 0x01
@@ -136,7 +144,7 @@ static bool ts3a227e_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case TS3A227E_REG_INTERRUPT ... TS3A227E_REG_INTERRUPT_DISABLE:
-	case TS3A227E_REG_SETTING_2:
+	case TS3A227E_REG_SETTING_1 ... TS3A227E_REG_SETTING_2:
 	case TS3A227E_REG_SWITCH_STATUS_1 ... TS3A227E_REG_ADC_OUTPUT:
 		return true;
 	default:
@@ -269,14 +277,52 @@ static const struct regmap_config ts3a227e_regmap_config = {
 static int ts3a227e_parse_device_property(struct ts3a227e *ts3a227e,
 				struct device *dev)
 {
-	u32 micbias;
+	u32 value;
+	u32 value_ms;
+	u32 setting3_value = 0;
+	u32 setting3_mask = 0;
 	int err;
 
-	err = device_property_read_u32(dev, "ti,micbias", &micbias);
+	err = device_property_read_u32(dev, "ti,micbias", &value);
+	if (!err) {
+		setting3_mask = MICBIAS_SETTING_MASK;
+		setting3_value =
+			(value << MICBIAS_SETTING_SFT) & MICBIAS_SETTING_MASK;
+	}
+
+	err = device_property_read_u32(dev, "ti,debounce-release-ms", &value_ms);
 	if (!err) {
+		value = (value_ms > 10);
+		setting3_mask |= DEBOUNCE_RELEASE_SETTING_MASK;
+		setting3_value |= (value << DEBOUNCE_RELEASE_SETTING_SFT) &
+				  DEBOUNCE_RELEASE_SETTING_MASK;
+	}
+
+	err = device_property_read_u32(dev, "ti,debounce-press-ms", &value_ms);
+	if (!err) {
+		value = (value_ms + 20) / 40;
+		if (value > 3)
+			value = 3;
+		setting3_mask |= DEBOUNCE_PRESS_SETTING_MASK;
+		setting3_value |= (value << DEBOUNCE_PRESS_SETTING_SFT) &
+				  DEBOUNCE_PRESS_SETTING_MASK;
+	}
+
+	if (setting3_mask)
 		regmap_update_bits(ts3a227e->regmap, TS3A227E_REG_SETTING_3,
-			MICBIAS_SETTING_MASK,
-			(micbias & 0x07) << MICBIAS_SETTING_SFT);
+				   setting3_mask, setting3_value);
+
+	err = device_property_read_u32(dev, "ti,debounce-insertion-ms", &value_ms);
+	if (!err) {
+		if (value_ms < 165)
+			value = (value_ms + 15) / 30;
+		else if (value_ms < 1500)
+			value = 6;
+		else
+			value = 7;
+		regmap_update_bits(ts3a227e->regmap, TS3A227E_REG_SETTING_1,
+			DEBOUNCE_INSERTION_SETTING_MASK, (value << DEBOUNCE_INSERTION_SETTING_SFT)
+			& DEBOUNCE_INSERTION_SETTING_MASK);
 	}
 
 	return 0;
-- 
2.20.1

