Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AF73A307
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjFVO3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjFVO3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:29:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880C71BDA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:29:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31110aea814so7571013f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687444147; x=1690036147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/VIsWWHYp9W1vsM/zTQjB7ygwb8WPrDQ9hfnQ47tKA=;
        b=uFRhu6fK3wCIUL69CGihpCcDsB0wDctKvmtB1HVoRIXJgIWUU7k9Xq+IzO6Q925dBQ
         0sWPo0VGpm2x1f9wICHNxlbewMJqES1pa3V8NYWnE/0WVl6Yly9+AGoWSe0L7mh+t5AO
         /v4dnTvXXRRkMntpkaZ9CoSQ2svbGwSWWTJY3QvNiccsGOI+Y8JwLe5mqSWc0gZidOzj
         lgb4fo6KkiLFXtR5VrFptqXsR4o9BoL1RWKbv+5IbD6gYQpzLhkIEdKj/M2kruqzs8PN
         C+J40kjFW8vjdMP68wJ4XbK7tLrUhsuxrUMayDs9rjag7M44WNwqpMXsJYkesE1RFI2J
         1+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687444147; x=1690036147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/VIsWWHYp9W1vsM/zTQjB7ygwb8WPrDQ9hfnQ47tKA=;
        b=EkxK+K8FU6M5zS3Z49llHTesMr2I4aBs8N36fRTn4fI0aVb5Dk7EK030z4tH7xKAeB
         9E1Ln9TsiSFYA4o/IT9X1RS4ggt+ooUaaZ/3nbofCETj/+gj5R7JZHCoJsirhRKQUigK
         q5Dx31CkNgOL+c8ajXhhQ5KjjdqC2Urxkk0RlYydE3gltUMkmd4gpGBrWB9+1kXYy0h1
         z5v96/rO+RZOPuVqyOyNKiayTTVz8VID6jzaiwNQMhvQzbWQ8k+FTnY8ZqhdZQpeMNHn
         DYmwG7tBp8GikJLU9OiFMju+Da5T1tOwX+Y4XflOsKU1k5pIYld8uYVFK5xZrHeSE0Y3
         BR/w==
X-Gm-Message-State: AC+VfDy5KV5+6TN/6H0Bb91of+r5VjEeF57yRPmIjBlR2LUGUaKarhCi
        umyodLo0iww3Z0/siFX8CsyK0g==
X-Google-Smtp-Source: ACHHUZ4VenijTJxTYI6kZMu/p3lcEEHc1Z4mQKH+40tlV4V1DEU3/Jtpi+s7h1PGalU1aKJ4Nsxw7A==
X-Received: by 2002:adf:f847:0:b0:307:cf55:a7d8 with SMTP id d7-20020adff847000000b00307cf55a7d8mr15021585wrq.42.1687444147046;
        Thu, 22 Jun 2023 07:29:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6812000000b0030ae69920c9sm7168361wru.53.2023.06.22.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:29:06 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 22 Jun 2023 16:29:01 +0200
Subject: [PATCH v3 3/4] input: touchscreen: add I2C support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v3-3-f0577cead709@linaro.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4427;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=QHOGGZ9YgSGmH3eo15UAb80SbAazpeBZYECMck5eCmA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklFqtJTXz1Yb3QLVMB2aa+JFRKv2PowPhKbow9/XC
 O+Hvi1GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJRarQAKCRB33NvayMhJ0Y8JD/
 9ivhtmNdp1mrE1aRxjMQ0UKhLpSTc48h/xeXgc3S1km0hnBkfnqEGnWke7YOnghiIgB+q9liGh1b18
 MPVN/QvDLiU04weCkbKxBI1DjBb7pO0H8Sm36YbZv4vv33VcYEl1Vg8XFMxWBD8yV29PB7xk9peO66
 RCXSEphHxCqaNuOqED/yw7LYwU05KE/PBhOI9Q4o1mk9q5BoqZVaYGWRhXtfRsFRMfqml/6mUTKwDM
 6O4bOERw7fKf+pAroqACLTurqp2PXNbdlumlD0pVLv5ABe8oAAxycgLvXeq14wHSwsLJ543DF1dyam
 WIkgvaYM9Wp7KBf19jtqoRsS73akcQ51J/+wEWqqxcccGbSH8U8mXmuW8zvsIl0FfLoRxBREPfbJNL
 dYkn3jHXpjifsmGPpbS22pfAk73gZ2LMa8St9/OceXMC49euEV/iodhhW9AORryvCAVv0YEaRRS2ky
 /62LcuMFzIuID1o96zyVY6OG5PvnLIchbNkhTzYwyv/LlS1d8094wM/tIz/WV9Sx1aUOYUqHcZ1yV9
 HEsyxDcSlYYf/WMnRcGutEqYIxkv7IaMPP/MqvXRG/PBCnGW77j/D3NGg2d14VEykweQIeJ1uItez5
 l6+RyJxoEw7upQI5RXGJiZeRyTjb3c0n2ck8FZns2T5Tm73Kw27kAcJYSzGQ==
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

