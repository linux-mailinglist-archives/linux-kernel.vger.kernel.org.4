Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F665BDBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiITE0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiITE0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:26:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A04C56B94;
        Mon, 19 Sep 2022 21:26:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fv3so1804415pjb.0;
        Mon, 19 Sep 2022 21:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pIGkYbf9yJq729wkfcXhqGqwyONGFWTL2PsMGXYGRvA=;
        b=b1A/UY/etRaIToqRoaqAcmDdOu0iH5cXbcOhn+YhlJosnosC1rD7s7QfxhFGiRikNE
         /zYKEgqwFVesX6Qcky1cciscr/9ZSZXXlVlQCSdy/oFiJfPpSDUrSkSSGegMYdyM9rS/
         ubmH2jI8lBtJ0qjtYexMwjJKAFRorbONbNTqS0vIQvhsnoqPxQXQ4NWGdZ9rkA/oARy6
         /6rsAK6w/rIKrVamDDJa/WNYOdhEROcdUebOcI+6MFNZ2k/N0OYt45cxfQ07aQqKu12W
         I7+csj1oIBRGJYKbVwt8hgAak8Da7iXHXlyCFhG3c8A2rn6ZkcuJW81OzJoSr1BtORKb
         ORvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pIGkYbf9yJq729wkfcXhqGqwyONGFWTL2PsMGXYGRvA=;
        b=BQWhnk8z9Xf19sKwRd+Q1AiYs1xYl5tYHULpodrSCeMjv/OES58T5nt/FqpPE/gUet
         ZFt6eyvI2HwXy4hZtCtgpKF3/GvyuiNLO2UlVD8xisvq5FdYCWZos3/79oCGwX12ogjP
         DqZhIDw8EgHln+NAXtzRURAyWHYmXG362lkAirv0xhVNjSzXePH87fWDxJlhqLRWw9gy
         ObdAs2oMLC/RBaw4KhVLWlH54QiJxOofYqz5zlJNGubq9IS/LWnlakKkR87Tdstxmd/l
         qaZS9R73k0hcA07PIzsZEMDW2C3lAgPQvMMGYNzXXER7kbBHdqjPyBW+70jjJzaGEY/6
         nZ3w==
X-Gm-Message-State: ACrzQf2ogjS+vRmlpySOh5P8veCl3pemEsKapbhE8hG6cN58vZL+iJl5
        3FtMyJsOdXeGiFFpbeVHtH4=
X-Google-Smtp-Source: AMsMyM57I0D9KIVw5AL4bdyaT/GSXFo5QhBvAjAk5tjNPB7zD3KhkddmqgVNM5gMV4mJBMN9PV5OmQ==
X-Received: by 2002:a17:902:c941:b0:177:e69a:a517 with SMTP id i1-20020a170902c94100b00177e69aa517mr3090266pla.144.1663647975125;
        Mon, 19 Sep 2022 21:26:15 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:b095:5d5d:4c28:8088])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a024f00b001fab208523esm337518pje.3.2022.09.19.21.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 21:26:14 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-input@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Input: egalax_ts - switch to using gpiod API
Date:   Mon, 19 Sep 2022 21:26:07 -0700
Message-Id: <20220920042608.1865560-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220920042608.1865560-1-dmitry.torokhov@gmail.com>
References: <20220920042608.1865560-1-dmitry.torokhov@gmail.com>
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

This updates the driver to gpiod API, and removes yet another use of
of_get_named_gpio().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/egalax_ts.c | 42 +++++++++++----------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 83ac8c128192..9e9b1c52720d 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -14,17 +14,17 @@
   - auto idle mode support
 */
 
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/input/mt.h>
-#include <linux/of_gpio.h>
 
 /*
  * Mouse Mode: some panel may configure the controller to mouse mode,
@@ -119,32 +119,26 @@ static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
 /* wake up controller by an falling edge of interrupt gpio.  */
 static int egalax_wake_up_device(struct i2c_client *client)
 {
-	struct device_node *np = client->dev.of_node;
-	int gpio;
+	struct gpio_desc *gpio;
 	int ret;
 
-	if (!np)
-		return -ENODEV;
-
-	gpio = of_get_named_gpio(np, "wakeup-gpios", 0);
-	if (!gpio_is_valid(gpio))
-		return -ENODEV;
-
-	ret = gpio_request(gpio, "egalax_irq");
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"request gpio failed, cannot wake up controller: %d\n",
-			ret);
+	/* wake up controller via an falling edge on IRQ gpio. */
+	gpio = gpiod_get(&client->dev, "wakeup", GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(gpio);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"failed to request wakeup gpio, cannot wake up controller: %d\n",
+				ret);
 		return ret;
 	}
 
-	/* wake up controller via an falling edge on IRQ gpio. */
-	gpio_direction_output(gpio, 0);
-	gpio_set_value(gpio, 1);
+	/* release the line */
+	gpiod_set_value_cansleep(gpio, 0);
 
-	/* controller should be waken up, return irq.  */
-	gpio_direction_input(gpio);
-	gpio_free(gpio);
+	/* controller should be woken up, return irq.  */
+	gpiod_direction_input(gpio);
+	gpiod_put(gpio);
 
 	return 0;
 }
@@ -185,10 +179,8 @@ static int egalax_ts_probe(struct i2c_client *client,
 
 	/* controller may be in sleep, wake it up. */
 	error = egalax_wake_up_device(client);
-	if (error) {
-		dev_err(&client->dev, "Failed to wake up the controller\n");
+	if (error)
 		return error;
-	}
 
 	error = egalax_firmware_version(client);
 	if (error < 0) {
-- 
2.37.3.968.ga6b4b080e4-goog

