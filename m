Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83802731543
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbjFOK10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbjFOK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:27:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C3F2721
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:27:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30e412a852dso5670722f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686824832; x=1689416832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/VIsWWHYp9W1vsM/zTQjB7ygwb8WPrDQ9hfnQ47tKA=;
        b=fsYkmU9ESYYZLv/ex7nVF9LAj7zxKMMU+1UgX4+t5cuaodlaA5cN2k6wZp2Ioj6jBI
         PEjiHQ8rbNpkoz4IOPrzv409lyX52SvIXy7AmKsCpd7R77n76ThFVApzpGFUx6CC2xJM
         g0e+17xrLAnfbNPRGQhI6grBMsViq10NPOBS4JFxHUIOOwp6nH6frVN+2IxUe72HtyHi
         Rwr9/DSfeH9fskFsX6gKg5uniAo2u3p+nc6iEH3pY8Xp47LErcI+x255kBYwZZ3eoQ2j
         sKlhn0749i2hcpEZrxQSjB7rx8y+oYKWW/xfbW1G64K1mPVh7IHW2/K140MARPxWeNCu
         Y2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686824832; x=1689416832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/VIsWWHYp9W1vsM/zTQjB7ygwb8WPrDQ9hfnQ47tKA=;
        b=WmkiKfXtchhGFOJpmQbfPWS2/EViO/doU6AIaxMQH4ktjONG1drPWjqNroomvMVpDn
         fFpadxkxY30YTIaua3vlst4TEI3ieRTDfsRnL+HUeHElwK4ZXLpafrsBfj9jLGanE3Ky
         lrQSZDZWcFzrWRwWvVjfxEndpm+ZLtAzbxK/EMdglrVaDg8L4OZytoN9QuFfzZEO2rZA
         qzliu6LCujjZxhyCYZCJ2ZQGP2VU90pKqahPlQpgDMXw5wvvhWPyG08ksjiUgCjTX3JY
         a1EATF5SLvy9PNH7tYq2nFvS3IVl3M9iTuXlXEbGk2UzymOufyAdLYZvXO3gD5Ix8Rd+
         weTw==
X-Gm-Message-State: AC+VfDxJA3ri16RQZhDrJIDwHHVdBM7EKqX+e0MHIS1VYMDM5E65Ia5h
        roOxR8aPcMdnWJcoj10/XOanlQUQCf0beb9KeaaTJQ==
X-Google-Smtp-Source: ACHHUZ4Z3dfoqzO93CMCBVn9xc2hjY17iLqoybHqyN2roabaE0UC9Jkmn3fvLyqLeANNWz1qGYphHQ==
X-Received: by 2002:a5d:6991:0:b0:30a:e378:76e with SMTP id g17-20020a5d6991000000b0030ae378076emr9457432wru.64.1686824832139;
        Thu, 15 Jun 2023 03:27:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d5145000000b0030fa57d8064sm17332337wrt.52.2023.06.15.03.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:27:11 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 15 Jun 2023 12:27:02 +0200
Subject: [PATCH v2 3/4] input: touchscreen: add I2C support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v2-3-26bc8fe1e90e@linaro.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4427;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=QHOGGZ9YgSGmH3eo15UAb80SbAazpeBZYECMck5eCmA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiud6fvco9i4cWpbxTrvClLAkjjDr+LnoqR4/2T7T
 Oqc8mXeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIrnegAKCRB33NvayMhJ0XVmEA
 CSKJsHHh2rykXQIJQnTFYIlYmVrlEH1JzWVtI3NncnZmadvG+Y235qJ/UoYDCUZOUuyVAam5N8q9Vd
 KAZRW5UHRcMP48/cIC2InZjGF8HbDmMCzlSZMsw+XDfxmSVsliAf46tSQTIhZuFsVmf1iTQiDpF57N
 rZiMtrRv/D164Qj8bhj5FQt88rOkiVkY8eX4A7bZWiylBoyo1xj4VmwZf/zGPxeCau9eyVIPwTeXJe
 KbQF5qcXza8m2QSFGrxjjZ+rEvzOjX0vavFGw6YD6Kc+azSZacTTifiNt9sQVrTWECdRlGQIQd0U1+
 iJNm47io2e+voAh+msvUojqVUIzhEm7weBkJSTaUg2z5C5NBBdHWIJ0mupZUaMa7VOlaNqk5DQ+ocE
 S0Un9sh47XDoCtjA9bHg6GT7H+ev26tThQWgejJpixJIYyrWlQC2Qz3WTgBgo8lvYreNLe7UIS8Ufo
 aOrz16MTZDW9Vkl6PNZ0pie3ip4RzZBaBIl2o1dv4O9P5Do/u2USg/85W0kQvLOY1EYHxjC+SoZMZv
 vDF8ONWpQ8LSBG1hc/yRWWpuMotAbRXdfeHTL2YnTP7nBYJtzCt3jQsJz78UY81kX2adK63+q7IZdz
 H4ZiWUyPWNzkXYtrkHuPHhwM1qUW1V4hS9ipz6vactGhgKkjYcoNffbkS0KQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the new Goodix "Berlin" touchscreen ICs
over the I2C interface.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/input/touchscreen/Kconfig             | 14 ++++++
 drivers/input/touchscreen/Makefile            |  1 +
 drivers/input/touchscreen/goodix_berlin_i2c.c | 69 +++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 1a6f6f6da991..5e21cca6025d 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -421,6 +421,20 @@ config TOUCHSCREEN_GOODIX_BERLIN_CORE
 	depends on REGMAP
 	tristate
 
+config TOUCHSCREEN_GOODIX_BERLIN_I2C
+	tristate "Goodix Berlin I2C touchscreen"
+	depends on I2C
+	depends on REGMAP_I2C
+	select TOUCHSCREEN_GOODIX_BERLIN_CORE
+	help
+	  Say Y here if you have a Goodix Berlin IC connected to
+	  your system via I2C.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called goodix_berlin_i2c.
+
 config TOUCHSCREEN_HIDEEP
 	tristate "HiDeep Touch IC"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 29cdb042e104..921a2da0c2be 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
+obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)	+= goodix_berlin_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
 obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
diff --git a/drivers/input/touchscreen/goodix_berlin_i2c.c b/drivers/input/touchscreen/goodix_berlin_i2c.c
new file mode 100644
index 000000000000..6407b2258eb1
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin_i2c.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Goodix Berlin Touchscreen Driver
+ *
+ * Copyright (C) 2020 - 2021 Goodix, Inc.
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Based on goodix_ts_berlin driver.
+ */
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "goodix_berlin.h"
+
+#define I2C_MAX_TRANSFER_SIZE		256
+
+static const struct regmap_config goodix_berlin_i2c_regmap_conf = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.max_raw_read = I2C_MAX_TRANSFER_SIZE,
+	.max_raw_write = I2C_MAX_TRANSFER_SIZE,
+};
+
+/* vendor & product left unassigned here, should probably be updated from fw info */
+static const struct input_id goodix_berlin_i2c_input_id = {
+	.bustype = BUS_I2C,
+};
+
+static int goodix_berlin_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &goodix_berlin_i2c_regmap_conf);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return goodix_berlin_probe(&client->dev, client->irq,
+				   &goodix_berlin_i2c_input_id, regmap);
+}
+
+static const struct i2c_device_id goodix_berlin_i2c_id[] = {
+	{ "gt9916", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, goodix_berlin_i2c_id);
+
+static const struct of_device_id goodix_berlin_i2c_of_match[] = {
+	{ .compatible = "goodix,gt9916", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, goodix_berlin_i2c_of_match);
+
+static struct i2c_driver goodix_berlin_i2c_driver = {
+	.driver = {
+		.name = "goodix-berlin-i2c",
+		.of_match_table = goodix_berlin_i2c_of_match,
+		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
+	},
+	.probe = goodix_berlin_i2c_probe,
+	.id_table = goodix_berlin_i2c_id,
+};
+module_i2c_driver(goodix_berlin_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Goodix Berlin I2C Touchscreen driver");
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");

-- 
2.34.1

