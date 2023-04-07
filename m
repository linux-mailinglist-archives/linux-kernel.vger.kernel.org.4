Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A06DAB7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbjDGKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240560AbjDGKXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:23:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E74C05
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 03:23:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l17so7445012ejp.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1680863015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0j80qcSlu23/jmLhtBdxoy8KmFI9uUDrbf0yBZqqYw=;
        b=NcN9T7rKJnBfDCrFXM0/XyvJzBNjm6BecGFBGfw4nhb6Te9Wd4bt79bWvlYZEPhpfY
         HqczKjYYDVL9PayzVHgQCZpttGly0tPo6PWoVjPw+FWeeBXkESf7Kxt/HBxAzawE5FPU
         whSZ2kWs5eRKONsiLRdZ2JLZJDL6Z80dKbhtpRvkAdpb7z4OR0fWnipvHjanE++R//+S
         5IgXIzMhP59dNWL+KHzbv17M22g0vCvLlYP0suwwtNeWvFCESS82qElqfmzVlSseGpM4
         RcUTtUlr9Dp7/yDuqFWOKvbMZ87DxxJ0GVWoEhbiGAkelLt4DBP0zg/dTj62VoaX7OrN
         W3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680863015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0j80qcSlu23/jmLhtBdxoy8KmFI9uUDrbf0yBZqqYw=;
        b=Jjl+1XcL7jSYS9NHavg9T5yxzB4861ODbjFHPITyg498+rDll5aaHX52J2hWO371/Y
         w60ED5PpkTB5y9MelbAy9mhAjOp8kX1kgSs+TGAGPk8CYviBpAS/oQTaSjUJJLnR2loA
         XuJ6nlzKOj0XPJ5z1TaoaGmKVS7uUYLaj1GVsoGklkCmQ6PSy1m3QsNxSp1RenS0yFOB
         eU+KWaB/WVJobvLNtvpDxdNQrTy5bPS2vtgrYP1IQ555ri+YTJO++S6pM+skkL7L27uc
         9ZuL8YioOB79rmnWZEXGPNFYyx2XCTyUTu7uhzEChahVVyGEeWnrdtqevnt5PlsizUjv
         bzWg==
X-Gm-Message-State: AAQBX9cUC/uuw2J0JPzK+XAqEmZNiUWpSbjeUSAtdjo17TY9V6hyT3Ok
        V6ZHQfuenHHRGLCEvaXIouol4Q==
X-Google-Smtp-Source: AKy350bD7xRZ7tOmDmx5AT3Roe79GPkbIalCOholjjnRGGWBECojGvM7tsQgmYWlSF/DaXaiUdEP8A==
X-Received: by 2002:a17:906:1957:b0:878:7a0e:5730 with SMTP id b23-20020a170906195700b008787a0e5730mr1946570eje.56.1680863014924;
        Fri, 07 Apr 2023 03:23:34 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906014700b00932fa67b48fsm1892612ejh.183.2023.04.07.03.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 03:23:34 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] leds: lp55xx: configure internal charge pump
Date:   Fri,  7 Apr 2023 12:23:24 +0200
Message-Id: <20230407102324.42604-3-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230407102324.42604-1-maarten.zanders@mind.be>
References: <20230407102324.42604-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

