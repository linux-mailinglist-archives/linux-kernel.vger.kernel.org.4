Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46475020F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjGLIws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjGLIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:52:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C71CF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:52:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3159d5e409dso288217f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689151961; x=1691743961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v4UNOf4OnfSq8XVP7LewFMWvi4W/OrdiQXVKL6e3Lc=;
        b=gUfcmiPg4rS4fTc3XWbclJkCLK94142Yok+PgMSFvS9QoQ/dEWGV6ca5v3qfeDOnTf
         8QBOHIZQReFJ+xq5u3vEznEihYKmvcNtwBFVTEtMZjKy/0/zM3ryGxSngIyiqn61cZz9
         farTq0Xj6zruO7R5whaOzcQyDVI9nAE3c+Mx0eg9HbY7tRgCBAsid84zLeIbMbiZjuOB
         cT8sWILoM3rdAK99M/3b+Rfuqf/J86czQr6XGh6ZL/SkypNPL6lZZ5D8aL2DdyG+cBMt
         IcAGxdhY+DqUDUt2OCMy4YMIGQ4414JZ9sYO8l1qByzfyvRZSob6i29Pbrnvyqn3o0pj
         sN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689151961; x=1691743961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3v4UNOf4OnfSq8XVP7LewFMWvi4W/OrdiQXVKL6e3Lc=;
        b=IyU6gP5imZ0Kt/i8W9cXFbLTWzji5zeozMiYWoKkJD1vVB1oTXtg4AmTb7YuwgH0yv
         UBBO9XdsAVzT5s7vj2waijT9WH4ptehxmplRy+lHS7RRmyjZsyoGNnGHsjw0EB4AQ0b8
         /tDV5PkCWBN4YEtXqA2n/C8wNukLeZMUdfEiE+/z6My5dAj6ZqO11bEJiflMSwQ58oeX
         ozYQzLifuxG8scpeLJWp6EERA2uTij1etKdAAI0pQxaYCJICy0QFLakTNUnLumqhF8QC
         SNS9AjebzX3itMZ5jsWEze6bZtSmmNFcXLE5JKAyuS0jC1ghxZlEF86BhMjABo0E7X96
         jdHA==
X-Gm-Message-State: ABy/qLZSFOHzmBoYYzvWPxkSJuXTkfi6mHDo6ZGxTQ8nUzK4vKRkYFwC
        kwYKCzTefepNpBoA0t0lN7h/Uw==
X-Google-Smtp-Source: APBJJlGGeF9HoB77N7GwO+Hyr+ddV1M8ABtSNq/dkr/65Ht2wVGC7PINcIdawjEEC/C8z59wqiPM6Q==
X-Received: by 2002:adf:e651:0:b0:312:849d:acc8 with SMTP id b17-20020adfe651000000b00312849dacc8mr1202100wrn.9.1689151961390;
        Wed, 12 Jul 2023 01:52:41 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id t9-20020a5d5349000000b003143b7449ffsm4475140wrv.25.2023.07.12.01.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 01:52:41 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] pinctrl: cy8c95x0: Add reset support
Date:   Wed, 12 Jul 2023 10:52:35 +0200
Message-ID: <20230712085236.2496651-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712085236.2496651-1-Naresh.Solanki@9elements.com>
References: <20230712085236.2496651-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

This patch adds support for an optional "reset" GPIO pin in the cy8c95x0
pinctrl driver. On probe, the reset pin is pulled low to bring chip out
of reset. The reset pin has an internal pull-down and can be left
floating if not required.

The datasheet doesn't mention any timing related to the reset pin.

Based on empirical tests, it was found that the chip requires a
delay of 250 milliseconds before accepting I2C transfers after driving
the reset pin low. Therefore, a delay of 250ms is added before
proceeding with I2C transfers.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V2:
- None
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 2ecc96691c55..58ca6fac7849 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -164,6 +164,7 @@ struct cy8c95x0_pinctrl {
 	struct pinctrl_desc pinctrl_desc;
 	char name[32];
 	unsigned int tpin;
+	struct gpio_desc *gpio_reset;
 };
 
 static const struct pinctrl_pin_desc cy8c9560_pins[] = {
@@ -1383,6 +1384,20 @@ static int cy8c95x0_probe(struct i2c_client *client)
 		chip->regulator = reg;
 	}
 
+	/* bring the chip out of reset if reset pin is provided */
+	chip->gpio_reset = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(chip->gpio_reset)) {
+		ret = dev_err_probe(chip->dev, PTR_ERR(chip->gpio_reset),
+				    "Failed to get GPIO 'reset'\n");
+		goto err_exit;
+	} else if (chip->gpio_reset) {
+		usleep_range(1000, 2000);
+		gpiod_set_value_cansleep(chip->gpio_reset, 0);
+		usleep_range(250000, 300000);
+
+		gpiod_set_consumer_name(chip->gpio_reset, "CY8C95X0 RESET");
+	}
+
 	chip->regmap = devm_regmap_init_i2c(client, &cy8c95x0_i2c_regmap);
 	if (IS_ERR(chip->regmap)) {
 		ret = PTR_ERR(chip->regmap);
-- 
2.41.0

