Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2356D1F64
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjCaLqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjCaLqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:46:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709811B361
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:46:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l37so12712068wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1680263184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsntl9VyZ1WBCTPEmSMfSmA0WsJwJPeY+ZORBqnW36M=;
        b=GEGEAC8yl/LYBGzYoAI+k0nZW2mrk1FBTb1bwxVGmD7+cAT44NBlD+rEODwd65z7ku
         kdw4o2KZjDRnt+/TCXlnUs1IiAwObSOn1hsCSuKIBRn+l9ycsr9h0WH+Z+Z1pubPgEOO
         O+TsMk8to1963Cv2nQL24NNtv9Aj/OIHTPtX/GRmIHjQLpXfOGYrc1KFbdiPygxYrW3H
         DwtPpLDuo0hljmCWs++dd7AHjJA/6MgLUD/GU2kIv02xylJX7KT3oEDhNmQrsRaVUKyz
         gHrgBGonyjhhWIbwGnb5v0X7yG9gdJIvVvleGSxwiCGcnbMjvuOtrVo21MykhLdvZfbA
         h+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680263184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsntl9VyZ1WBCTPEmSMfSmA0WsJwJPeY+ZORBqnW36M=;
        b=Je7ZLTl4DnCrhxaNuLk6elXpGDUklZzn1gByHAN77Dop388bAtHnZ8LXGeXsvUZvl4
         LSZeG0y2UA21A7+4cSR5Rga6ehv+B76mAVpHLMuTAlqJhA/obU4gKsWjXtPq2l2kY/FO
         zbEdnBpNcjLfbMo0qMJOAzEHojdVdHRX5CzaIq0E9/seyFI/ZatvyTkVj/k1sUJOYAgc
         4ei5bcmod0fMKzIHXV/1H8u/GKBRD/piNQu1KXiomn3fbiD+haUNt/+IrEX+k6ZXrcN3
         MJ2mr9Iojo3lZjlYS4KcAVWKIIyHENJpnhODBfZJ6+chIHV/ALkxMCLuX0mebML+jLdt
         JZmA==
X-Gm-Message-State: AO0yUKWvB8SpoM80+Rf/zxlGFW//AV8bsYee/+9Zqj9hbZMNblbvHTWW
        lFiPcJt2zH79wpu/B+iyTbMQPyWJtj7HDk8XKCk=
X-Google-Smtp-Source: AK7set8OTi2Xa7XPGd5RLBUaiux40QYVJVfSiZxMzcsvVGXqfJX5D6GfPMKqU/PlU7lINC8hPFXp0A==
X-Received: by 2002:a7b:cbcc:0:b0:3ee:1afc:c14 with SMTP id n12-20020a7bcbcc000000b003ee1afc0c14mr20499187wmi.11.1680263183955;
        Fri, 31 Mar 2023 04:46:23 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id s17-20020a7bc391000000b003edef091b17sm2404017wmj.37.2023.03.31.04.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 04:46:23 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] leds: lp55xx: configure internal charge pump
Date:   Fri, 31 Mar 2023 13:46:10 +0200
Message-Id: <20230331114610.48111-3-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230331114610.48111-1-maarten.zanders@mind.be>
References: <20230331114610.48111-1-maarten.zanders@mind.be>
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

 drivers/leds/leds-lp5521.c                | 12 ++++++------
 drivers/leds/leds-lp5523.c                | 18 +++++++++++++-----
 drivers/leds/leds-lp55xx-common.c         | 14 ++++++++++++++
 drivers/leds/leds-lp8501.c                |  8 ++++++--
 include/linux/platform_data/leds-lp55xx.h |  3 +++
 5 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index 19478d9c19a7..76c6b81afb38 100644
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
@@ -310,6 +307,9 @@ static int lp5521_post_init_device(struct lp55xx_chip *chip)
 	if (!lp55xx_is_extclk_used(chip))
 		val |= LP5521_CLK_INT;
 
+	val |= (chip->pdata->charge_pump_mode << LP5521_CP_MODE_SHIFT) &
+		LP5521_CP_MODE_MASK;
+
 	ret = lp55xx_write(chip, LP5521_REG_CONFIG, val);
 	if (ret)
 		return ret;
diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index e08e3de1428d..b5d10d4252e6 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -57,8 +57,12 @@
 #define LP5523_AUTO_INC			0x40
 #define LP5523_PWR_SAVE			0x20
 #define LP5523_PWM_PWR_SAVE		0x04
-#define LP5523_CP_AUTO			0x18
+#define LP5523_CP_MODE_MASK		0x18
+#define LP5523_CP_MODE_SHIFT		3
 #define LP5523_AUTO_CLK			0x02
+#define LP5523_DEFAULT_CONFIG	\
+	(LP5523_AUTO_INC | LP5523_PWR_SAVE |\
+	 LP5523_AUTO_CLK | LP5523_PWM_PWR_SAVE)
 
 #define LP5523_EN_LEDTEST		0x80
 #define LP5523_LEDTEST_DONE		0x80
@@ -125,6 +129,7 @@ static void lp5523_set_led_current(struct lp55xx_led *led, u8 led_current)
 static int lp5523_post_init_device(struct lp55xx_chip *chip)
 {
 	int ret;
+	int val;
 
 	ret = lp55xx_write(chip, LP5523_REG_ENABLE, LP5523_ENABLE);
 	if (ret)
@@ -133,10 +138,13 @@ static int lp5523_post_init_device(struct lp55xx_chip *chip)
 	/* Chip startup time is 500 us, 1 - 2 ms gives some margin */
 	usleep_range(1000, 2000);
 
-	ret = lp55xx_write(chip, LP5523_REG_CONFIG,
-			    LP5523_AUTO_INC | LP5523_PWR_SAVE |
-			    LP5523_CP_AUTO | LP5523_AUTO_CLK |
-			    LP5523_PWM_PWR_SAVE);
+	val = LP5523_DEFAULT_CONFIG;
+
+	val |= (chip->pdata->charge_pump_mode << LP5523_CP_MODE_SHIFT) &
+	       LP5523_CP_MODE_MASK;
+
+	ret = lp55xx_write(chip, LP5523_REG_CONFIG, val);
+
 	if (ret)
 		return ret;
 
diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index c1940964067a..5a02c4a4ec98 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -19,6 +19,8 @@
 #include <linux/slab.h>
 #include <linux/gpio/consumer.h>
 
+#include <dt-bindings/leds/leds-lp55xx.h>
+
 #include "leds-lp55xx-common.h"
 
 /* External clock rate */
@@ -691,6 +693,16 @@ struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
 		i++;
 	}
 
+	if (of_property_read_u32(np, "ti,charge-pump-mode",
+				 &pdata->charge_pump_mode))
+		pdata->charge_pump_mode = LP55XX_CP_AUTO;
+
+	if (pdata->charge_pump_mode > LP55XX_CP_AUTO) {
+		dev_err(dev, "invalid charge pump mode %d\n",
+			pdata->charge_pump_mode);
+		return ERR_PTR(-EINVAL);
+	}
+
 	of_property_read_string(np, "label", &pdata->label);
 	of_property_read_u8(np, "clock-mode", &pdata->clock_mode);
 
diff --git a/drivers/leds/leds-lp8501.c b/drivers/leds/leds-lp8501.c
index ae11a02c0ab2..f0e70e116919 100644
--- a/drivers/leds/leds-lp8501.c
+++ b/drivers/leds/leds-lp8501.c
@@ -53,10 +53,11 @@
 #define LP8501_PWM_PSAVE		BIT(7)
 #define LP8501_AUTO_INC			BIT(6)
 #define LP8501_PWR_SAVE			BIT(5)
-#define LP8501_CP_AUTO			0x18
+#define LP8501_CP_MODE_MASK		0x18
+#define LP8501_CP_MODE_SHIFT		3
 #define LP8501_INT_CLK			BIT(0)
 #define LP8501_DEFAULT_CFG	\
-	(LP8501_PWM_PSAVE | LP8501_AUTO_INC | LP8501_PWR_SAVE | LP8501_CP_AUTO)
+	(LP8501_PWM_PSAVE | LP8501_AUTO_INC | LP8501_PWR_SAVE)
 
 #define LP8501_REG_RESET		0x3D
 #define LP8501_RESET			0xFF
@@ -102,6 +103,9 @@ static int lp8501_post_init_device(struct lp55xx_chip *chip)
 	if (chip->pdata->clock_mode != LP55XX_CLOCK_EXT)
 		val |= LP8501_INT_CLK;
 
+	val |= (chip->pdata->charge_pump_mode << LP8501_CP_MODE_SHIFT) &
+	       LP8501_CP_MODE_MASK;
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

