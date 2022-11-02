Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEF561726D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiKBXZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiKBXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:24:06 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBA6DF93;
        Wed,  2 Nov 2022 16:20:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v3so175756pgh.4;
        Wed, 02 Nov 2022 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zl1LKmv4RLjwNkqEhUgdxCW+8uunPRUGj73i8adfR+c=;
        b=Zral2Tj/aqfFI6R5Pqa5+FbaXdIvhtCzWT9QuQkI1+iVSW6VPfvqYzp5hZbaGyM9zV
         dviv0OaZpUtGn+8f3wdQhkx8rhgri5HxRR5b7zoIsvQhSHZ/XEpT2lBzZUyHER398uIo
         Q2woa/bwgmHk85q/XSl4Pxxrcfi26Bp8OdIo9KBB2pUKqzhwlgKJwDjQjnO/9PzrfmDG
         lpocig4tQCJfGtwVIIomgjZt2tYopKPbZw7X9iOFDecI9rPcUrz2z+JiyHpgyJFqCVZz
         fTWV6omQ7w4zOLKfWc8vE0NZNN7IFZ6FTIiyRK9O2blO6De32TTBZCVAFxBn3346LjBp
         p+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zl1LKmv4RLjwNkqEhUgdxCW+8uunPRUGj73i8adfR+c=;
        b=VX1Z1iN+Na5Kl1vW4DO50r/+C9UJotVAM1uXxcyXjUiHqnkIZNU/E4TJBfYaWn17zz
         Tr9RtyN2CCLeQnfAcVKRdvmufqXMt++f02sFCb+J8iaLAUpmx5ZwzsQ+D3OwIcp8b/Fw
         JNJpwCe/w9RLsvqgL7zJxLLyLIjz+nkzdimkwUNoPIMoDdL6CGtLBw7Ph29XcJK+vJDU
         hTd+CQ3TRvVRLQlub+Gt5ckrRc1ANcBjdx26sbl3amSIsh3p4z9yz6+/kT2Maf5vJe67
         7jUnRsxKxYMosoq57i/YOCxFAwnUVo0hwWMS0v4ESHeKCC0ei6du4y5tQWIFhndF/Z2A
         Rl4g==
X-Gm-Message-State: ACrzQf2N5e8N6Kyk7CFuBj8Ovyt634u0orh4G6UUEfT5MT3KEVDr0we+
        Xnb7ZGdIVuQMgRlLChEu5zM=
X-Google-Smtp-Source: AMsMyM6dCoQNWzn7ubeBVKYazgU6QRjmm+3+vw/zeNXUI4k5UYmv2ktqNQxKSozLyBhDVQ2DNB2HXQ==
X-Received: by 2002:a63:105e:0:b0:46e:9bac:1c3 with SMTP id 30-20020a63105e000000b0046e9bac01c3mr22873269pgq.388.1667431210664;
        Wed, 02 Nov 2022 16:20:10 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b00186e2123506sm8842073pll.300.2022.11.02.16.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 16:20:09 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ASoC: tlv320aic3x: remove support for platform data
Date:   Wed,  2 Nov 2022 16:20:03 -0700
Message-Id: <20221102232004.1721864-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221102232004.1721864-1-dmitry.torokhov@gmail.com>
References: <20221102232004.1721864-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/sound/tlv320aic3x.h    | 65 ----------------------------------
 sound/soc/codecs/tlv320aic3x.c | 12 +++----
 sound/soc/codecs/tlv320aic3x.h | 43 ++++++++++++++++++++++
 3 files changed, 48 insertions(+), 72 deletions(-)
 delete mode 100644 include/sound/tlv320aic3x.h

diff --git a/include/sound/tlv320aic3x.h b/include/sound/tlv320aic3x.h
deleted file mode 100644
index b660a9ed05ec..000000000000
--- a/include/sound/tlv320aic3x.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Platform data for Texas Instruments TLV320AIC3x codec
- *
- * Author: Jarkko Nikula <jarkko.nikula@bitmer.com>
- */
-#ifndef __TLV320AIC3x_H__
-#define __TLV320AIC3x_H__
-
-/* GPIO API */
-enum {
-	AIC3X_GPIO1_FUNC_DISABLED		= 0,
-	AIC3X_GPIO1_FUNC_AUDIO_WORDCLK_ADC	= 1,
-	AIC3X_GPIO1_FUNC_CLOCK_MUX		= 2,
-	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV2		= 3,
-	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV4		= 4,
-	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV8		= 5,
-	AIC3X_GPIO1_FUNC_SHORT_CIRCUIT_IRQ	= 6,
-	AIC3X_GPIO1_FUNC_AGC_NOISE_IRQ		= 7,
-	AIC3X_GPIO1_FUNC_INPUT			= 8,
-	AIC3X_GPIO1_FUNC_OUTPUT			= 9,
-	AIC3X_GPIO1_FUNC_DIGITAL_MIC_MODCLK	= 10,
-	AIC3X_GPIO1_FUNC_AUDIO_WORDCLK		= 11,
-	AIC3X_GPIO1_FUNC_BUTTON_IRQ		= 12,
-	AIC3X_GPIO1_FUNC_HEADSET_DETECT_IRQ	= 13,
-	AIC3X_GPIO1_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ	= 14,
-	AIC3X_GPIO1_FUNC_ALL_IRQ		= 16
-};
-
-enum {
-	AIC3X_GPIO2_FUNC_DISABLED		= 0,
-	AIC3X_GPIO2_FUNC_HEADSET_DETECT_IRQ	= 2,
-	AIC3X_GPIO2_FUNC_INPUT			= 3,
-	AIC3X_GPIO2_FUNC_OUTPUT			= 4,
-	AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT	= 5,
-	AIC3X_GPIO2_FUNC_AUDIO_BITCLK		= 8,
-	AIC3X_GPIO2_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ = 9,
-	AIC3X_GPIO2_FUNC_ALL_IRQ		= 10,
-	AIC3X_GPIO2_FUNC_SHORT_CIRCUIT_OR_AGC_IRQ = 11,
-	AIC3X_GPIO2_FUNC_HEADSET_OR_BUTTON_PRESS_OR_SHORT_CIRCUIT_IRQ = 12,
-	AIC3X_GPIO2_FUNC_SHORT_CIRCUIT_IRQ	= 13,
-	AIC3X_GPIO2_FUNC_AGC_NOISE_IRQ		= 14,
-	AIC3X_GPIO2_FUNC_BUTTON_PRESS_IRQ	= 15
-};
-
-enum aic3x_micbias_voltage {
-	AIC3X_MICBIAS_OFF = 0,
-	AIC3X_MICBIAS_2_0V = 1,
-	AIC3X_MICBIAS_2_5V = 2,
-	AIC3X_MICBIAS_AVDDV = 3,
-};
-
-struct aic3x_setup_data {
-	unsigned int gpio_func[2];
-};
-
-struct aic3x_pdata {
-	int gpio_reset; /* < 0 if not used */
-	struct aic3x_setup_data *setup;
-
-	/* Selects the micbias voltage */
-	enum aic3x_micbias_voltage micbias_vg;
-};
-
-#endif
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 08938801daec..9b2bb99cc165 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -45,7 +45,6 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
-#include <sound/tlv320aic3x.h>
 
 #include "tlv320aic3x.h"
 
@@ -66,6 +65,10 @@ struct aic3x_disable_nb {
 	struct aic3x_priv *aic3x;
 };
 
+struct aic3x_setup_data {
+	unsigned int gpio_func[2];
+};
+
 /* codec private data */
 struct aic3x_priv {
 	struct snd_soc_component *component;
@@ -1748,7 +1751,6 @@ static const struct reg_sequence aic3007_class_d[] = {
 
 int aic3x_probe(struct device *dev, struct regmap *regmap, kernel_ulong_t driver_data)
 {
-	struct aic3x_pdata *pdata = dev->platform_data;
 	struct aic3x_priv *aic3x;
 	struct aic3x_setup_data *ai3x_setup;
 	struct device_node *np = dev->of_node;
@@ -1768,11 +1770,7 @@ int aic3x_probe(struct device *dev, struct regmap *regmap, kernel_ulong_t driver
 	regcache_cache_only(aic3x->regmap, true);
 
 	dev_set_drvdata(dev, aic3x);
-	if (pdata) {
-		aic3x->gpio_reset = pdata->gpio_reset;
-		aic3x->setup = pdata->setup;
-		aic3x->micbias_vg = pdata->micbias_vg;
-	} else if (np) {
+	if (np) {
 		ai3x_setup = devm_kzalloc(dev, sizeof(*ai3x_setup), GFP_KERNEL);
 		if (!ai3x_setup)
 			return -ENOMEM;
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 14298f9e6d9b..066e5a6322b8 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -298,4 +298,47 @@ enum {
 #define AIC3X_BUTTON_DEBOUNCE_SHIFT 	0
 #define AIC3X_BUTTON_DEBOUNCE_MASK	3
 
+/* GPIO API */
+enum {
+	AIC3X_GPIO1_FUNC_DISABLED		= 0,
+	AIC3X_GPIO1_FUNC_AUDIO_WORDCLK_ADC	= 1,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX		= 2,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV2		= 3,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV4		= 4,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV8		= 5,
+	AIC3X_GPIO1_FUNC_SHORT_CIRCUIT_IRQ	= 6,
+	AIC3X_GPIO1_FUNC_AGC_NOISE_IRQ		= 7,
+	AIC3X_GPIO1_FUNC_INPUT			= 8,
+	AIC3X_GPIO1_FUNC_OUTPUT			= 9,
+	AIC3X_GPIO1_FUNC_DIGITAL_MIC_MODCLK	= 10,
+	AIC3X_GPIO1_FUNC_AUDIO_WORDCLK		= 11,
+	AIC3X_GPIO1_FUNC_BUTTON_IRQ		= 12,
+	AIC3X_GPIO1_FUNC_HEADSET_DETECT_IRQ	= 13,
+	AIC3X_GPIO1_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ	= 14,
+	AIC3X_GPIO1_FUNC_ALL_IRQ		= 16
+};
+
+enum {
+	AIC3X_GPIO2_FUNC_DISABLED		= 0,
+	AIC3X_GPIO2_FUNC_HEADSET_DETECT_IRQ	= 2,
+	AIC3X_GPIO2_FUNC_INPUT			= 3,
+	AIC3X_GPIO2_FUNC_OUTPUT			= 4,
+	AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT	= 5,
+	AIC3X_GPIO2_FUNC_AUDIO_BITCLK		= 8,
+	AIC3X_GPIO2_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ = 9,
+	AIC3X_GPIO2_FUNC_ALL_IRQ		= 10,
+	AIC3X_GPIO2_FUNC_SHORT_CIRCUIT_OR_AGC_IRQ = 11,
+	AIC3X_GPIO2_FUNC_HEADSET_OR_BUTTON_PRESS_OR_SHORT_CIRCUIT_IRQ = 12,
+	AIC3X_GPIO2_FUNC_SHORT_CIRCUIT_IRQ	= 13,
+	AIC3X_GPIO2_FUNC_AGC_NOISE_IRQ		= 14,
+	AIC3X_GPIO2_FUNC_BUTTON_PRESS_IRQ	= 15
+};
+
+enum aic3x_micbias_voltage {
+	AIC3X_MICBIAS_OFF = 0,
+	AIC3X_MICBIAS_2_0V = 1,
+	AIC3X_MICBIAS_2_5V = 2,
+	AIC3X_MICBIAS_AVDDV = 3,
+};
+
 #endif /* _AIC3X_H */
-- 
2.38.1.273.g43a17bfeac-goog

