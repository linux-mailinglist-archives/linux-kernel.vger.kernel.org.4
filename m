Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0263362ADE8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKOWL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiKOWLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:11:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1072E2715F;
        Tue, 15 Nov 2022 14:11:53 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so363795pjs.4;
        Tue, 15 Nov 2022 14:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FfC6mdt0ik5bfv6PbUvOpPqpC/h2diKZQ8Yf0+D53Q=;
        b=BYQ5tQkvzOLFVsy7z4h5LEwu9ZW9K3e6AOtPecFt7taLzV5rHyTn55Xg1uaaIl7Hpi
         WP4K6+bDQQqn0FkTGhhy4WAmRds6ZRqSq/KC8JC6lGMFGOlc5boAPvv0/+eYwQtyaROz
         rj4FozwDwZ362ntq7GFkrhABvPa104WIOmGAYUt/39HtPuJ6eyIy5i0hpc21MYv3s420
         rvbzUkzqiJ6X48LjcA2GpqTTa43S4iJWWVD//Vkv1HTvx+E0WKiVE+Ka2Bx6SWsyyJ88
         1UE+UgzlliyqgyrtgFfyIRgAF2i8EAOUEJu+mPl2HwfbJF/z0eFqItO5LBkDdKapoYc0
         8f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FfC6mdt0ik5bfv6PbUvOpPqpC/h2diKZQ8Yf0+D53Q=;
        b=vLrzsxvFK8pwNAJGVo+WKHTETRhluSneTLFdaTPhbcfbORuzdugxEDxdtTAGWFMlCb
         VF+32rR4TH31T39izeUT+wyjq1nDIOPvpNBn3KKtk09xfxPAohBETOzkefqT7KHXJPI1
         iw5h5EWnlfZ2/snL4SzhQGhkqKtcTYm6fWGKwJ8nk7/YpxKqTcXTWdUW6Hl84CYyC3UJ
         QYQu62itWA13QjxKIZ/meybkIbLObibs9yWoYLFp1S3zvoooDw40r2Yvdba/OXkNZBHn
         hbYFA4i0fVhhKPE+Ng5ud2GiN1AVn7Kdejo2okUsvIkq0dJWv3Ctq1P8wZewn+gIggvF
         o7SQ==
X-Gm-Message-State: ANoB5pn4uzSXUNT6yy6GxjBPlf0w0vD1a2txfnsgq/ViwSDlU2xC83QT
        DiLma4NU84PEQ5YHquycRQE=
X-Google-Smtp-Source: AA0mqf7UESuyBq1KyREnRH2NL0PjY3F+RNMglOT+Cd6JzjFAbc6CGOi13nCzRyRapjJNwZ2+xy8Izg==
X-Received: by 2002:a17:902:8d90:b0:187:3bc8:fc56 with SMTP id v16-20020a1709028d9000b001873bc8fc56mr5989374plo.83.1668550312337;
        Tue, 15 Nov 2022 14:11:52 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b00178b6ccc8a0sm10400038pli.51.2022.11.15.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:11:51 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 2/4] media: i2c: s5k5baf: switch to using gpiod API
Date:   Tue, 15 Nov 2022 14:11:43 -0800
Message-Id: <20221115221145.2550572-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
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

This patch switches the driver away from legacy gpio/of_gpio API to
gpiod API, and removes use of of_get_named_gpio_flags() which I want to
make private to gpiolib.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/media/i2c/s5k5baf.c | 64 +++++++++++--------------------------
 1 file changed, 18 insertions(+), 46 deletions(-)

diff --git a/drivers/media/i2c/s5k5baf.c b/drivers/media/i2c/s5k5baf.c
index 5c2253ab3b6f..960fbf6428ea 100644
--- a/drivers/media/i2c/s5k5baf.c
+++ b/drivers/media/i2c/s5k5baf.c
@@ -13,11 +13,10 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/media.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -228,11 +227,6 @@ static const char * const s5k5baf_supply_names[] = {
 };
 #define S5K5BAF_NUM_SUPPLIES ARRAY_SIZE(s5k5baf_supply_names)
 
-struct s5k5baf_gpio {
-	int gpio;
-	int level;
-};
-
 enum s5k5baf_gpio_id {
 	STBY,
 	RSET,
@@ -284,7 +278,7 @@ struct s5k5baf_fw {
 };
 
 struct s5k5baf {
-	struct s5k5baf_gpio gpios[NUM_GPIOS];
+	struct gpio_desc *gpios[NUM_GPIOS];
 	enum v4l2_mbus_type bus_type;
 	u8 nlanes;
 	struct regulator_bulk_data supplies[S5K5BAF_NUM_SUPPLIES];
@@ -936,16 +930,12 @@ static void s5k5baf_hw_set_test_pattern(struct s5k5baf *state, int id)
 
 static void s5k5baf_gpio_assert(struct s5k5baf *state, int id)
 {
-	struct s5k5baf_gpio *gpio = &state->gpios[id];
-
-	gpio_set_value(gpio->gpio, gpio->level);
+	gpiod_set_value_cansleep(state->gpios[id], 1);
 }
 
 static void s5k5baf_gpio_deassert(struct s5k5baf *state, int id)
 {
-	struct s5k5baf_gpio *gpio = &state->gpios[id];
-
-	gpio_set_value(gpio->gpio, !gpio->level);
+	gpiod_set_value_cansleep(state->gpios[id], 0);
 }
 
 static int s5k5baf_power_on(struct s5k5baf *state)
@@ -1799,44 +1789,30 @@ static const struct v4l2_subdev_ops s5k5baf_subdev_ops = {
 
 static int s5k5baf_configure_gpios(struct s5k5baf *state)
 {
-	static const char * const name[] = { "S5K5BAF_STBY", "S5K5BAF_RST" };
+	static const char * const name[] = { "stbyn", "rstn" };
+	static const char * const label[] = { "S5K5BAF_STBY", "S5K5BAF_RST" };
 	struct i2c_client *c = v4l2_get_subdevdata(&state->sd);
-	struct s5k5baf_gpio *g = state->gpios;
+	struct gpio_desc *gpio;
 	int ret, i;
 
 	for (i = 0; i < NUM_GPIOS; ++i) {
-		int flags = GPIOF_DIR_OUT;
-		if (g[i].level)
-			flags |= GPIOF_INIT_HIGH;
-		ret = devm_gpio_request_one(&c->dev, g[i].gpio, flags, name[i]);
-		if (ret < 0) {
-			v4l2_err(c, "failed to request gpio %s\n", name[i]);
+		gpio = devm_gpiod_get(&c->dev, name[i], GPIOD_OUT_HIGH);
+		ret = PTR_ERR_OR_ZERO(gpio);
+		if (ret) {
+			v4l2_err(c, "failed to request gpio %s: %d\n",
+				 name[i], ret);
 			return ret;
 		}
-	}
-	return 0;
-}
-
-static int s5k5baf_parse_gpios(struct s5k5baf_gpio *gpios, struct device *dev)
-{
-	static const char * const names[] = {
-		"stbyn-gpios",
-		"rstn-gpios",
-	};
-	struct device_node *node = dev->of_node;
-	enum of_gpio_flags flags;
-	int ret, i;
 
-	for (i = 0; i < NUM_GPIOS; ++i) {
-		ret = of_get_named_gpio_flags(node, names[i], 0, &flags);
-		if (ret < 0) {
-			dev_err(dev, "no %s GPIO pin provided\n", names[i]);
+		ret = gpiod_set_consumer_name(gpio, label[i]);
+		if (ret) {
+			v4l2_err(c, "failed to set up name for gpio %s: %d\n",
+				 name[i], ret);
 			return ret;
 		}
-		gpios[i].gpio = ret;
-		gpios[i].level = !(flags & OF_GPIO_ACTIVE_LOW);
-	}
 
+		state->gpios[i] = gpio;
+	}
 	return 0;
 }
 
@@ -1860,10 +1836,6 @@ static int s5k5baf_parse_device_node(struct s5k5baf *state, struct device *dev)
 			 state->mclk_frequency);
 	}
 
-	ret = s5k5baf_parse_gpios(state->gpios, dev);
-	if (ret < 0)
-		return ret;
-
 	node_ep = of_graph_get_next_endpoint(node, NULL);
 	if (!node_ep) {
 		dev_err(dev, "no endpoint defined at node %pOF\n", node);
-- 
2.38.1.431.g37b22c650d-goog

