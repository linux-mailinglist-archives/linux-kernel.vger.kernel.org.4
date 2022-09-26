Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380E95E98EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiIZFol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiIZFo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:44:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CCF25EB4;
        Sun, 25 Sep 2022 22:44:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso11857681pjq.1;
        Sun, 25 Sep 2022 22:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rmZyxvqJS4w1YWyS2TPCQ1j0LXsRQHSN+Zm/YuUv3a8=;
        b=gT3voX5F2D8qbASe1iVUSB8yWCqIarzamN2aZnk1f3Mdcmqm7z4P0fWhkKa+RzxYB3
         HzJaL7J97hpJJoQG09AvMymrvAqbM+VSWuSy7FgPE5HMRK7oj0SGzFVQOuRrwczICdem
         gDhEGE/U9MxK3gmiqARnQ0N9fh2vomz9eU4PoP06Tzj9z6FTJg+oaoM/2Qe9W8KEoJfT
         QKjYjQfIf+T1tbprGuksXWbfElgFlBLMG+k6rFr1yz8Wm8AalANbA3Xxsvv6EA+BQZee
         7wMfCXR1iXxpn1AQ9A7EO4NTRQHdAIbBxdbFoID7OT/1wEkuBtVhpJ6vm03+LQx2BjoB
         RYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rmZyxvqJS4w1YWyS2TPCQ1j0LXsRQHSN+Zm/YuUv3a8=;
        b=gJxugA2yJokEmhJgsRX9x5MFAS8f2fg9T1xHouewTDIP0SIvFXOj5jUYWuqGIKzq8P
         0df3J6aTozEvEq+rxm58jbpEeBuyo5f3sf2D38HKEZxOmUe6pHuy4cyiTOFmrLoo+mVb
         rVxYXbXKCcESpP2LqgrhNzEvdPXmcKaAjaTzo1z6YTSrnrOyVM/LImZo62ybV6ZQRorI
         cpPZ7Paee3IBAh/+tEkPubLjGu2riQn3zmTQoTh0ef5iIYA1zSzvQwOA0ifEkqiOhIRb
         tyqJOdUhEWTptiKAdysEdVtyqunqo8ZpYdPFLrVkRWpRUUzJxs9DNz5r3DNy3tIi9Tf6
         9QsA==
X-Gm-Message-State: ACrzQf2wiVLyp5G9mSVX72HKVIRFYkcb5UTA+WizHvsWQtjwdgJ/pPff
        mJeozXcoMEwkBo4DhnOWpw0=
X-Google-Smtp-Source: AMsMyM42JEQj/WD9RW+9fbeDVH0vFY1tQ41Vb31wAlXZWaf16qfoBB+9ZIOMmPs5AffajTDl3ZuRBg==
X-Received: by 2002:a17:90b:38c5:b0:202:98df:208c with SMTP id nn5-20020a17090b38c500b0020298df208cmr34459962pjb.129.1664171067571;
        Sun, 25 Sep 2022 22:44:27 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:7e1b:858c:19dc:934])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902be0b00b00176c0e055f8sm10110489pls.64.2022.09.25.22.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 22:44:26 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 4/5] mfd: twl6040: switch to using gpiod API
Date:   Sun, 25 Sep 2022 22:44:20 -0700
Message-Id: <20220926054421.1546436-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
References: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
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

This patch switches the dirver from legacy gpio API to a newer gpiod
API so that we can eventually drop the former.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mfd/twl6040.c       | 29 +++++++++++++----------------
 include/linux/mfd/twl6040.h |  5 +++--
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index f429b8f00db6..4a7cdac5e10d 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -17,9 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -251,7 +250,7 @@ static int twl6040_power_up_automatic(struct twl6040 *twl6040)
 {
 	int time_left;
 
-	gpio_set_value(twl6040->audpwron, 1);
+	gpiod_set_value_cansleep(twl6040->audpwron, 1);
 
 	time_left = wait_for_completion_timeout(&twl6040->ready,
 						msecs_to_jiffies(144));
@@ -262,7 +261,7 @@ static int twl6040_power_up_automatic(struct twl6040 *twl6040)
 		intid = twl6040_reg_read(twl6040, TWL6040_REG_INTID);
 		if (!(intid & TWL6040_READYINT)) {
 			dev_err(twl6040->dev, "automatic power-up failed\n");
-			gpio_set_value(twl6040->audpwron, 0);
+			gpiod_set_value_cansleep(twl6040->audpwron, 0);
 			return -ETIMEDOUT;
 		}
 	}
@@ -290,7 +289,7 @@ int twl6040_power(struct twl6040 *twl6040, int on)
 		/* Allow writes to the chip */
 		regcache_cache_only(twl6040->regmap, false);
 
-		if (gpio_is_valid(twl6040->audpwron)) {
+		if (twl6040->audpwron) {
 			/* use automatic power-up sequence */
 			ret = twl6040_power_up_automatic(twl6040);
 			if (ret) {
@@ -337,9 +336,9 @@ int twl6040_power(struct twl6040 *twl6040, int on)
 		if (--twl6040->power_count)
 			goto out;
 
-		if (gpio_is_valid(twl6040->audpwron)) {
+		if (twl6040->audpwron) {
 			/* use AUDPWRON line */
-			gpio_set_value(twl6040->audpwron, 0);
+			gpiod_set_value_cansleep(twl6040->audpwron, 0);
 
 			/* power-down sequence latency */
 			usleep_range(500, 700);
@@ -712,18 +711,16 @@ static int twl6040_probe(struct i2c_client *client,
 	}
 
 	/* ERRATA: Automatic power-up is not possible in ES1.0 */
-	if (twl6040_get_revid(twl6040) > TWL6040_REV_ES1_0)
-		twl6040->audpwron = of_get_named_gpio(node,
-						      "ti,audpwron-gpio", 0);
-	else
-		twl6040->audpwron = -EINVAL;
-
-	if (gpio_is_valid(twl6040->audpwron)) {
-		ret = devm_gpio_request_one(&client->dev, twl6040->audpwron,
-					    GPIOF_OUT_INIT_LOW, "audpwron");
+	if (twl6040_get_revid(twl6040) > TWL6040_REV_ES1_0) {
+		twl6040->audpwron = devm_gpiod_get_optional(&client->dev,
+							    "ti,audpwron",
+							    GPIOD_OUT_LOW);
+		ret = PTR_ERR_OR_ZERO(twl6040->audpwron);
 		if (ret)
 			goto gpio_err;
 
+		gpiod_set_consumer_name(twl6040->audpwron, "audpwron");
+
 		/* Clear any pending interrupt */
 		twl6040_reg_read(twl6040, TWL6040_REG_INTID);
 	}
diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index 1fc7450bd8ab..cb1e7a9ce317 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -196,13 +196,14 @@ struct twl6040_gpo_data {
 };
 
 struct twl6040_platform_data {
-	int audpwron_gpio;	/* audio power-on gpio */
+	struct gpio_desc *audpwron_gpio;	/* audio power-on gpio */
 
 	struct twl6040_codec_data *codec;
 	struct twl6040_vibra_data *vibra;
 	struct twl6040_gpo_data *gpo;
 };
 
+struct gpio_desc;
 struct regmap;
 struct regmap_irq_chips_data;
 
@@ -218,7 +219,7 @@ struct twl6040 {
 	struct mfd_cell cells[TWL6040_CELLS];
 	struct completion ready;
 
-	int audpwron;
+	struct gpio_desc *audpwron;
 	int power_count;
 	int rev;
 
-- 
2.37.3.998.g577e59143f-goog

