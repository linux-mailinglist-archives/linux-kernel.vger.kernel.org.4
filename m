Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81E262ADEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiKOWLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiKOWLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:11:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7FF2715F;
        Tue, 15 Nov 2022 14:11:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k5so14744579pjo.5;
        Tue, 15 Nov 2022 14:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt37wQQQ2UBMRQ+NV2HhjZPCcpOsAKHeXNbqwrzrV88=;
        b=YkwZAzWUea0ahhsPHFNd25jYxc/z63BYkatRQ2FtDZ20WztyLg2G9ADtwKOcdLXmwg
         9GNnJtuIvKz77+f4PyHZ624jBlXJQhAJ4uz/6wDD5BbCsreuX2INetEb5LAqctlCFtd5
         4FuEmhURypmHAR54y1pDv71WKqnsTAcMsJupcgldgICRtd79jfURpN321025tLvFTUBy
         2e8upnFgnSnFhU8UuFc+2fZow7m5WyIDtq3LwA4rEDwVyRRhih2aYL1FOoPlJo6Doz5u
         n7+M7x6b6//TwfoQWFFChE64fUnsuVXnwFmJsm0GYMuGvvbVBszpfrq6RJNlAzltfkGd
         iGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xt37wQQQ2UBMRQ+NV2HhjZPCcpOsAKHeXNbqwrzrV88=;
        b=cqpWU9L3YHpT0VmpJlpG0NH0IoyMpE5Da7notjmYcWN5JsORnXAkzfyi7YX4Yvd1m6
         jqO0GKLMbdf5MDcfx8kKjorBu6fFjiSqrFj01/4jI+WRV4Updjpz4WKKdPaG8KvATFED
         3zTuisV1JZmGCx/4LiQSPcahXmCo5qUvZowonqA6eytyWkktbRPuKNLRYQmHdv2AjvPm
         TOKleL+1yCBNglR/h6ONUaOCFiBR/lM5KTfit+DYbs2Uo0RlQKtBFduOAFIF7orMCu6O
         OgX986irDExbwf6upvH2EQFTg5DjOoOKtQfKLBYY3VdqaAJ5SXlfKSd3N2ZPniVUUc0T
         8inA==
X-Gm-Message-State: ANoB5pkStksMn1HUkldFC22DnmzzFxUYTXOf9Ez9UUxXA8vLnJ8LVmFO
        b6JJCQaDFIPjbXJ2VUQoItp91TlPwBA=
X-Google-Smtp-Source: AA0mqf7bbXanwHaV6IVN6scidQnsDo+47q4SqVoT97rLdr+o1n5XegH70XIp+MivIEYUBLiTx5HnHg==
X-Received: by 2002:a17:90a:ca96:b0:212:d404:5513 with SMTP id y22-20020a17090aca9600b00212d4045513mr505081pjt.27.1668550310433;
        Tue, 15 Nov 2022 14:11:50 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b00178b6ccc8a0sm10400038pli.51.2022.11.15.14.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:11:49 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 1/4] media: i2c: s5k6a3: switch to using gpiod API
Date:   Tue, 15 Nov 2022 14:11:42 -0800
Message-Id: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
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
gpiod API, and removes one of the last uses of of_get_gpio_flags().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/media/i2c/s5k6a3.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/media/i2c/s5k6a3.c b/drivers/media/i2c/s5k6a3.c
index a4efd6d10b43..ef6673b10580 100644
--- a/drivers/media/i2c/s5k6a3.c
+++ b/drivers/media/i2c/s5k6a3.c
@@ -9,12 +9,12 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -59,7 +59,7 @@ struct s5k6a3 {
 	struct v4l2_subdev subdev;
 	struct media_pad pad;
 	struct regulator_bulk_data supplies[S5K6A3_NUM_SUPPLIES];
-	int gpio_reset;
+	struct gpio_desc *gpio_reset;
 	struct mutex lock;
 	struct v4l2_mbus_framefmt format;
 	struct clk *clock;
@@ -216,11 +216,11 @@ static int __s5k6a3_power_on(struct s5k6a3 *sensor)
 			goto error_clk;
 	}
 
-	gpio_set_value(sensor->gpio_reset, 1);
+	gpiod_set_value_cansleep(sensor->gpio_reset, 0);
 	usleep_range(600, 800);
-	gpio_set_value(sensor->gpio_reset, 0);
+	gpiod_set_value_cansleep(sensor->gpio_reset, 1);
 	usleep_range(600, 800);
-	gpio_set_value(sensor->gpio_reset, 1);
+	gpiod_set_value_cansleep(sensor->gpio_reset, 0);
 
 	/* Delay needed for the sensor initialization */
 	msleep(20);
@@ -240,7 +240,7 @@ static int __s5k6a3_power_off(struct s5k6a3 *sensor)
 {
 	int i;
 
-	gpio_set_value(sensor->gpio_reset, 0);
+	gpiod_set_value_cansleep(sensor->gpio_reset, 1);
 
 	for (i = S5K6A3_NUM_SUPPLIES - 1; i >= 0; i--)
 		regulator_disable(sensor->supplies[i].consumer);
@@ -285,32 +285,24 @@ static int s5k6a3_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct s5k6a3 *sensor;
 	struct v4l2_subdev *sd;
-	int gpio, i, ret;
+	int i, ret;
 
 	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
 	if (!sensor)
 		return -ENOMEM;
 
 	mutex_init(&sensor->lock);
-	sensor->gpio_reset = -EINVAL;
-	sensor->clock = ERR_PTR(-EINVAL);
 	sensor->dev = dev;
 
 	sensor->clock = devm_clk_get(sensor->dev, S5K6A3_CLK_NAME);
 	if (IS_ERR(sensor->clock))
 		return PTR_ERR(sensor->clock);
 
-	gpio = of_get_gpio_flags(dev->of_node, 0, NULL);
-	if (!gpio_is_valid(gpio))
-		return gpio;
-
-	ret = devm_gpio_request_one(dev, gpio, GPIOF_OUT_INIT_LOW,
-						S5K6A3_DRV_NAME);
-	if (ret < 0)
+	sensor->gpio_reset = devm_gpiod_get(dev, NULL, GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(sensor->gpio_reset);
+	if (ret)
 		return ret;
 
-	sensor->gpio_reset = gpio;
-
 	if (of_property_read_u32(dev->of_node, "clock-frequency",
 				 &sensor->clock_frequency)) {
 		sensor->clock_frequency = S5K6A3_DEFAULT_CLK_FREQ;
-- 
2.38.1.431.g37b22c650d-goog

