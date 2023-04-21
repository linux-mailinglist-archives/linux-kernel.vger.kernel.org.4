Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBCD6EA54F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjDUHxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjDUHxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:53:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB4C9038
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:53:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94eee951c70so183137866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1682063591; x=1684655591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0j80qcSlu23/jmLhtBdxoy8KmFI9uUDrbf0yBZqqYw=;
        b=EGUq22nbom73hmdLPgx2EWFvWEH43ZFXXhUsrQaBQNtDYfmb65oe5V/UX2xc8EdpPC
         4taoPMs+y93fz1X0v8nXwUqpQyxXDTmfurkoB/z5pHy7ncqh18OV7anMrlpfCfqVvTzV
         VMtxWq2o2V3xcIGG72uo6yq26L7KBqIfh8hAPEnAaxWk9ozhNoUi10zPg4QlYwCG42i1
         sRyrXy8HS6Ztb3ZXL5Efe8F60JmHh8f5bNdp6/dr+V7vOqt708RjpJW6lTJHWy4X564d
         sit6qklJqKqMQ5ixNOuVRfU+UDM+2Uv+XwpwBjH9d+CMWrNr6oxIPWm2S+3cKM/4ttav
         PiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682063591; x=1684655591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0j80qcSlu23/jmLhtBdxoy8KmFI9uUDrbf0yBZqqYw=;
        b=RIaqBteRx8dp+pMuBZlHLSG1F+SVGhO2RR8eKObveBgc45Q+FnnZp5Iw5of+FedS2I
         Tj49O2oWyQoPPRDoKneizIlp83G0pwIjwLYrWF0G1TytkTH09ChgpnETG0Zv5Quq5baJ
         IFY/Udu25u04mh2fu2LvGzX5z/67L1PymqQz6+qHfNgLvJvW+h097Zg1/jqp5TNPwvw9
         Om/6aVpdX9U67Ii54TBbtQQPjoNtfRPCcjLr+CU0BC+ojdRFiKTvdCTIdhYVWyrCUAtl
         CSa9M/mQispSiZa8wE98M25SOakptYAjlJtU/BMiJUivbK2Drl2uD3VfSA6ZSML4X3vC
         Eh4g==
X-Gm-Message-State: AAQBX9dp34QDW4QBoJ+iVAh0MH8g+/jwEsIE36axJhSC9gyJkDNm2D9N
        sUuRajWhdHV7K3xwJDjfnxl8BQ==
X-Google-Smtp-Source: AKy350bmqsWCNR0ecDOhsne8lm1lP1qCI+kDZVnUGDEv0Qo5zIJEesuxLFhUeUzoUrTxSO7oQ0y+gg==
X-Received: by 2002:a17:907:80c5:b0:94a:a887:c29f with SMTP id io5-20020a17090780c500b0094aa887c29fmr1666414ejc.68.1682063591223;
        Fri, 21 Apr 2023 00:53:11 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id vp3-20020a170907a48300b0094f14286f86sm1716329ejc.48.2023.04.21.00.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 00:53:10 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] leds: lp55xx: configure internal charge pump
Date:   Fri, 21 Apr 2023 09:53:05 +0200
Message-Id: <20230421075305.37597-3-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230421075305.37597-1-maarten.zanders@mind.be>
References: <20230421075305.37597-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LP55xx range of devices have an internal charge pump which
can (automatically) increase the output voltage towards the
LED's, boosting the output voltage to 4.5V.

Implement this option from the devicetree. When the setting
is not present it will operate in automatic mode as before.

Tested on LP55231. Datasheet analysis shows that LP5521, LP5523
and LP8501 are identical in topology and are modified in the
same way.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---

Notes:
    v1: implement as bool to disable charge pump
    v2: rewrite to use string configuration, supporting all modes
    v3: simplification by replacing string from DTS by constant
    v4: added notes
    v5: property type to u32
    v6: cleanup parsing of DT paramter
    v7: formatting

 drivers/leds/leds-lp5521.c                | 11 +++++------
 drivers/leds/leds-lp5523.c                | 14 +++++++++-----
 drivers/leds/leds-lp55xx-common.c         |  9 +++++++++
 drivers/leds/leds-lp8501.c                |  8 +++++---
 include/linux/platform_data/leds-lp55xx.h |  3 +++
 5 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index a004af8e22c7..acd37d0f0e26 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -58,14 +58,11 @@
 /* CONFIG register */
 #define LP5521_PWM_HF			0x40	/* PWM: 0 = 256Hz, 1 = 558Hz */
 #define LP5521_PWRSAVE_EN		0x20	/* 1 = Power save mode */
-#define LP5521_CP_MODE_OFF		0	/* Charge pump (CP) off */
-#define LP5521_CP_MODE_BYPASS		8	/* CP forced to bypass mode */
-#define LP5521_CP_MODE_1X5		0x10	/* CP forced to 1.5x mode */
-#define LP5521_CP_MODE_AUTO		0x18	/* Automatic mode selection */
+#define LP5521_CP_MODE_MASK		0x18	/* Charge pump mode */
+#define LP5521_CP_MODE_SHIFT		3
 #define LP5521_R_TO_BATT		0x04	/* R out: 0 = CP, 1 = Vbat */
 #define LP5521_CLK_INT			0x01	/* Internal clock */
-#define LP5521_DEFAULT_CFG		\
-	(LP5521_PWM_HF | LP5521_PWRSAVE_EN | LP5521_CP_MODE_AUTO)
+#define LP5521_DEFAULT_CFG		(LP5521_PWM_HF | LP5521_PWRSAVE_EN)
 
 /* Status */
 #define LP5521_EXT_CLK_USED		0x08
@@ -310,6 +307,8 @@ static int lp5521_post_init_device(struct lp55xx_chip *chip)
 	if (!lp55xx_is_extclk_used(chip))
 		val |= LP5521_CLK_INT;
 
+	val |= (chip->pdata->charge_pump_mode << LP5521_CP_MODE_SHIFT) & LP5521_CP_MODE_MASK;
+
 	ret = lp55xx_write(chip, LP5521_REG_CONFIG, val);
 	if (ret)
 		return ret;
diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index 55da914b8e5c..a8df22938bdb 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -57,8 +57,11 @@
 #define LP5523_AUTO_INC			0x40
 #define LP5523_PWR_SAVE			0x20
 #define LP5523_PWM_PWR_SAVE		0x04
-#define LP5523_CP_AUTO			0x18
+#define LP5523_CP_MODE_MASK		0x18
+#define LP5523_CP_MODE_SHIFT		3
 #define LP5523_AUTO_CLK			0x02
+#define LP5523_DEFAULT_CONFIG \
+	(LP5523_AUTO_INC | LP5523_PWR_SAVE | LP5523_AUTO_CLK | LP5523_PWM_PWR_SAVE)
 
 #define LP5523_EN_LEDTEST		0x80
 #define LP5523_LEDTEST_DONE		0x80
@@ -125,6 +128,7 @@ static void lp5523_set_led_current(struct lp55xx_led *led, u8 led_current)
 static int lp5523_post_init_device(struct lp55xx_chip *chip)
 {
 	int ret;
+	int val;
 
 	ret = lp55xx_write(chip, LP5523_REG_ENABLE, LP5523_ENABLE);
 	if (ret)
@@ -133,10 +137,10 @@ static int lp5523_post_init_device(struct lp55xx_chip *chip)
 	/* Chip startup time is 500 us, 1 - 2 ms gives some margin */
 	usleep_range(1000, 2000);
 
-	ret = lp55xx_write(chip, LP5523_REG_CONFIG,
-			    LP5523_AUTO_INC | LP5523_PWR_SAVE |
-			    LP5523_CP_AUTO | LP5523_AUTO_CLK |
-			    LP5523_PWM_PWR_SAVE);
+	val = LP5523_DEFAULT_CONFIG;
+	val |= (chip->pdata->charge_pump_mode << LP5523_CP_MODE_SHIFT) & LP5523_CP_MODE_MASK;
+
+	ret = lp55xx_write(chip, LP5523_REG_CONFIG, val);
 	if (ret)
 		return ret;
 
diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index c1940964067a..77bb26906ea6 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -18,6 +18,7 @@
 #include <linux/platform_data/leds-lp55xx.h>
 #include <linux/slab.h>
 #include <linux/gpio/consumer.h>
+#include <dt-bindings/leds/leds-lp55xx.h>
 
 #include "leds-lp55xx-common.h"
 
@@ -691,6 +692,14 @@ struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
 		i++;
 	}
 
+	if (of_property_read_u32(np, "ti,charge-pump-mode", &pdata->charge_pump_mode))
+		pdata->charge_pump_mode = LP55XX_CP_AUTO;
+
+	if (pdata->charge_pump_mode > LP55XX_CP_AUTO) {
+		dev_err(dev, "invalid charge pump mode %d\n", pdata->charge_pump_mode);
+		return ERR_PTR(-EINVAL);
+	}
+
 	of_property_read_string(np, "label", &pdata->label);
 	of_property_read_u8(np, "clock-mode", &pdata->clock_mode);
 
diff --git a/drivers/leds/leds-lp8501.c b/drivers/leds/leds-lp8501.c
index 165d6423a928..878d81dace8a 100644
--- a/drivers/leds/leds-lp8501.c
+++ b/drivers/leds/leds-lp8501.c
@@ -53,10 +53,10 @@
 #define LP8501_PWM_PSAVE		BIT(7)
 #define LP8501_AUTO_INC			BIT(6)
 #define LP8501_PWR_SAVE			BIT(5)
-#define LP8501_CP_AUTO			0x18
+#define LP8501_CP_MODE_MASK		0x18
+#define LP8501_CP_MODE_SHIFT		3
 #define LP8501_INT_CLK			BIT(0)
-#define LP8501_DEFAULT_CFG	\
-	(LP8501_PWM_PSAVE | LP8501_AUTO_INC | LP8501_PWR_SAVE | LP8501_CP_AUTO)
+#define LP8501_DEFAULT_CFG (LP8501_PWM_PSAVE | LP8501_AUTO_INC | LP8501_PWR_SAVE)
 
 #define LP8501_REG_RESET		0x3D
 #define LP8501_RESET			0xFF
@@ -102,6 +102,8 @@ static int lp8501_post_init_device(struct lp55xx_chip *chip)
 	if (chip->pdata->clock_mode != LP55XX_CLOCK_EXT)
 		val |= LP8501_INT_CLK;
 
+	val |= (chip->pdata->charge_pump_mode << LP8501_CP_MODE_SHIFT) & LP8501_CP_MODE_MASK;
+
 	ret = lp55xx_write(chip, LP8501_REG_CONFIG, val);
 	if (ret)
 		return ret;
diff --git a/include/linux/platform_data/leds-lp55xx.h b/include/linux/platform_data/leds-lp55xx.h
index 3441064713a3..3cc8db0b12b5 100644
--- a/include/linux/platform_data/leds-lp55xx.h
+++ b/include/linux/platform_data/leds-lp55xx.h
@@ -73,6 +73,9 @@ struct lp55xx_platform_data {
 	/* Clock configuration */
 	u8 clock_mode;
 
+	/* Charge pump mode */
+	u32 charge_pump_mode;
+
 	/* optional enable GPIO */
 	struct gpio_desc *enable_gpiod;
 
-- 
2.37.3

