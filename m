Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0D6B0369
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCHJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCHJwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:52:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C535498873;
        Wed,  8 Mar 2023 01:52:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i34so63283234eda.7;
        Wed, 08 Mar 2023 01:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678269140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXCB+oYW4zw2V6U49JxzpNXli13gSy/i91Jkb3XU6Fk=;
        b=EiJrP86dqDxICaiHjpt0FwCpWlRiaNZglDtvcDTiGUoF4LhEGr3G6hEOy7AenHYMZX
         Ky4VBdYK9/49NcskdAZw9qTSQGBCYwwmoQRDpmKIBpoyhxpsD5Mkcrr+84ble/bSBvGh
         XLp6H9vFRNzmqUlMBzDsCVsdh/cZjVy7YCznA2kI5GBsQSEBG2TwMHRsx5ic+WHvyHeL
         bEOHJa36OLSVB0MYjrJPvJEvNlF8jqzARsAyg9GtC4UPWfljSVsimur8BIN66xUVPMJL
         Aw60EkHbdbhUbJf51T6wNa7nIztPMPeVLe1cgk407MQCehlBmaDruovoNtSV3u0m7WgU
         Mrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678269140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXCB+oYW4zw2V6U49JxzpNXli13gSy/i91Jkb3XU6Fk=;
        b=i9CrVgXuBsyHPFI2N0XFK1EJzX0lfpLQkt3V9tvE12Wo7BPBt9Yz9bF62NarW+LTu+
         WCf75oUqxMVCBXNrFzo++nA9HMFE6+S0Wqh5vZA6g4nZ3SN6Ew9B5QhVinLz9XfdYmu8
         KW72HYF9u1k8nDmMFkmJQi58BA+tTMMrtdzTDfbEQKBKVQpHrNr93KnaXYAyBjO8sWeR
         7CeCZdZ+Y9xiAChF0UWkHBJDyXUTUF2lJJy24cLtF9C3Q9rUri29x9PBilwSBtC/Rg/g
         SDoNFJhJpQJXdjFiOUs6D7hfIeptJKJnSuRGv/YZrfTW+0XLXJdEJdl6h6wFy/1virFH
         w1lg==
X-Gm-Message-State: AO0yUKXj6m0lcJJazB3Myoz4YVD5WpP6UJGsmqLZCNOCNKhLnjZQBaUR
        s15weKUUcsKHLYGzZHI9dlo=
X-Google-Smtp-Source: AK7set9cee6gVfTjgYnaqK00TdNPS55TVloEReQQho9gqYV6+9Q3SG1IFo7LXFA/cTtUT3d+2vqCQQ==
X-Received: by 2002:a17:907:e8d:b0:8af:5752:691f with SMTP id ho13-20020a1709070e8d00b008af5752691fmr21189100ejc.76.1678269139972;
        Wed, 08 Mar 2023 01:52:19 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b008d8f1b238fdsm7369177ejq.149.2023.03.08.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:52:19 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Jean Delvare <jdelvare@suse.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Ldd-Mlp <ldd-mlp@list.ti.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] media: lm3560: convent to OF
Date:   Wed,  8 Mar 2023 11:52:09 +0200
Message-Id: <20230308095209.14700-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308095209.14700-1-clamor95@gmail.com>
References: <20230308095209.14700-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no pdata is available, try to read from device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/media/i2c/lm3560.c | 128 +++++++++++++++++++++++++++----------
 1 file changed, 93 insertions(+), 35 deletions(-)

diff --git a/drivers/media/i2c/lm3560.c b/drivers/media/i2c/lm3560.c
index 5ef613604be7..5541051616b7 100644
--- a/drivers/media/i2c/lm3560.c
+++ b/drivers/media/i2c/lm3560.c
@@ -11,6 +11,7 @@
 
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
@@ -22,16 +23,16 @@
 
 /* registers definitions */
 #define REG_ENABLE		0x10
-#define REG_TORCH_BR	0xa0
-#define REG_FLASH_BR	0xb0
-#define REG_FLASH_TOUT	0xc0
+#define REG_TORCH_BR		0xa0
+#define REG_FLASH_BR		0xb0
+#define REG_FLASH_TOUT		0xc0
 #define REG_FLAG		0xd0
 #define REG_CONFIG1		0xe0
 
 /* fault mask */
-#define FAULT_TIMEOUT	(1<<0)
-#define FAULT_OVERTEMP	(1<<1)
-#define FAULT_SHORT_CIRCUIT	(1<<2)
+#define FAULT_TIMEOUT		BIT(0)
+#define FAULT_OVERTEMP		BIT(1)
+#define FAULT_SHORT_CIRCUIT	BIT(2)
 
 enum led_enable {
 	MODE_SHDN = 0x0,
@@ -54,6 +55,7 @@ struct lm3560_flash {
 	struct device *dev;
 	struct lm3560_platform_data *pdata;
 	struct regmap *regmap;
+	struct gpio_desc *hwen_gpio;
 	struct mutex lock;
 
 	enum v4l2_flash_led_mode led_mode;
@@ -356,12 +358,19 @@ static int lm3560_subdev_init(struct lm3560_flash *flash,
 	flash->subdev_led[led_no].flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	strscpy(flash->subdev_led[led_no].name, led_name,
 		sizeof(flash->subdev_led[led_no].name));
+
 	rval = lm3560_init_controls(flash, led_no);
-	if (rval)
+	if (rval) {
+		dev_err(flash->dev, "failed to init controls: %d\n", rval);
 		goto err_out;
+	}
+
 	rval = media_entity_pads_init(&flash->subdev_led[led_no].entity, 0, NULL);
-	if (rval < 0)
+	if (rval < 0) {
+		dev_err(flash->dev, "failed to init media entity pads: %d\n", rval);
 		goto err_out;
+	}
+
 	flash->subdev_led[led_no].entity.function = MEDIA_ENT_F_FLASH;
 
 	return rval;
@@ -391,6 +400,49 @@ static int lm3560_init_device(struct lm3560_flash *flash)
 	return rval;
 }
 
+static int lm3560_of_probe(struct lm3560_flash *flash)
+{
+	struct lm3560_platform_data *pdata;
+	struct fwnode_handle *node;
+	int ret, reg;
+
+	pdata = devm_kzalloc(flash->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENODEV;
+
+	ret = device_property_read_u32(flash->dev,
+				       "ti,peak-current", &pdata->peak);
+	if (ret)
+		pdata->peak = LM3560_PEAK_3600mA;
+
+	ret = device_property_read_u32(flash->dev,
+				       "ti,max-flash-timeout",
+				       &pdata->max_flash_timeout);
+	if (ret)
+		pdata->max_flash_timeout = LM3560_FLASH_TOUT_MAX;
+
+	device_for_each_child_node(flash->dev, node) {
+		fwnode_property_read_u32(node, "reg", &reg);
+
+		if (reg == LM3560_LED0 || reg == LM3560_LED1) {
+			ret = device_property_read_u32(flash->dev,
+						       "ti,max-flash-current",
+						       &pdata->max_flash_brt[reg]);
+			if (ret)
+				pdata->max_flash_brt[reg] = LM3560_FLASH_TOUT_MAX;
+
+			ret = device_property_read_u32(flash->dev,
+						       "ti,max-torch-current",
+						       &pdata->max_torch_brt[reg]);
+			if (ret)
+				pdata->max_torch_brt[reg] = LM3560_TORCH_BRT_MAX;
+		}
+	}
+	flash->pdata = pdata;
+
+	return 0;
+}
+
 static int lm3560_probe(struct i2c_client *client)
 {
 	struct lm3560_flash *flash;
@@ -398,44 +450,41 @@ static int lm3560_probe(struct i2c_client *client)
 	int rval;
 
 	flash = devm_kzalloc(&client->dev, sizeof(*flash), GFP_KERNEL);
-	if (flash == NULL)
+	if (!flash)
 		return -ENOMEM;
 
 	flash->regmap = devm_regmap_init_i2c(client, &lm3560_regmap);
-	if (IS_ERR(flash->regmap)) {
-		rval = PTR_ERR(flash->regmap);
-		return rval;
-	}
+	if (IS_ERR(flash->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(flash->regmap),
+				     "failed to init regmap\n");
 
-	/* if there is no platform data, use chip default value */
-	if (pdata == NULL) {
-		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
-		if (pdata == NULL)
-			return -ENODEV;
-		pdata->peak = LM3560_PEAK_3600mA;
-		pdata->max_flash_timeout = LM3560_FLASH_TOUT_MAX;
-		/* led 1 */
-		pdata->max_flash_brt[LM3560_LED0] = LM3560_FLASH_BRT_MAX;
-		pdata->max_torch_brt[LM3560_LED0] = LM3560_TORCH_BRT_MAX;
-		/* led 2 */
-		pdata->max_flash_brt[LM3560_LED1] = LM3560_FLASH_BRT_MAX;
-		pdata->max_torch_brt[LM3560_LED1] = LM3560_TORCH_BRT_MAX;
-	}
-	flash->pdata = pdata;
 	flash->dev = &client->dev;
 	mutex_init(&flash->lock);
 
+	/* if there is no platform data, try to read from device tree */
+	if (!pdata)
+		lm3560_of_probe(flash);
+
+	flash->hwen_gpio = devm_gpiod_get_optional(flash->dev, "enable",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(flash->hwen_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(flash->hwen_gpio),
+				     "failed to get hwen gpio\n");
+
 	rval = lm3560_subdev_init(flash, LM3560_LED0, "lm3560-led0");
 	if (rval < 0)
-		return rval;
+		return dev_err_probe(&client->dev, rval,
+				     "failed to init led0 subdev\n");
 
 	rval = lm3560_subdev_init(flash, LM3560_LED1, "lm3560-led1");
 	if (rval < 0)
-		return rval;
+		return dev_err_probe(&client->dev, rval,
+				     "failed to init led1 subdev\n");
 
 	rval = lm3560_init_device(flash);
 	if (rval < 0)
-		return rval;
+		return dev_err_probe(&client->dev, rval,
+				     "failed to init device\n");
 
 	i2c_set_clientdata(client, flash);
 
@@ -452,21 +501,30 @@ static void lm3560_remove(struct i2c_client *client)
 		v4l2_ctrl_handler_free(&flash->ctrls_led[i]);
 		media_entity_cleanup(&flash->subdev_led[i].entity);
 	}
+
+	gpiod_set_value_cansleep(flash->hwen_gpio, 0);
 }
 
+static const struct of_device_id lm3560_match[] = {
+	{ .compatible = "ti,lm3559" },
+	{ .compatible = "ti,lm3560" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lm3560_match);
+
 static const struct i2c_device_id lm3560_id_table[] = {
 	{LM3559_NAME, 0},
 	{LM3560_NAME, 0},
 	{}
 };
-
 MODULE_DEVICE_TABLE(i2c, lm3560_id_table);
 
 static struct i2c_driver lm3560_i2c_driver = {
 	.driver = {
-		   .name = LM3560_NAME,
-		   .pm = NULL,
-		   },
+		.name = LM3560_NAME,
+		.pm = NULL,
+		.of_match_table = lm3560_match,
+	},
 	.probe_new = lm3560_probe,
 	.remove = lm3560_remove,
 	.id_table = lm3560_id_table,
-- 
2.37.2

