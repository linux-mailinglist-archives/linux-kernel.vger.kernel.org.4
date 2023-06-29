Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95991742342
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjF2J1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjF2J1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:27:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4610D2703
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:27:20 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so728277e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688030838; x=1690622838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHQQhtxRrNw/N73oeu5paGAIKq+Rs5mWhJfd822m5Yo=;
        b=qpOuu0pIwJlg0hPzMAqRehNeBGOfRBcvYghlfHE5ijGolpAN/FsWbEOcdMgV2Dg31i
         mRhkkPtN10JWo/4tkv5h8MbIVvJA1iiRPgbHuU895dGMG4pZm8CeP5AAQ5AbSIqCf81z
         o2k02ixdoQ4DDJgdT/x0qHioMisFOny4q+hRCvLQGGlPQU0g6zpshBztiU9rkoG5vHk7
         kJezHudplA5fT5g/QXvAtddm9F+tsTVnfQpVlfxWajzjc3nDaUmFRo2UPHbw+w5LlgZ6
         NSHepZNpWu08ltPjncMLnpFoTN4bE6RyhxRTPHgFwoImfMEiBTQLM0DaQQ5tc+r/VOdr
         2evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688030838; x=1690622838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHQQhtxRrNw/N73oeu5paGAIKq+Rs5mWhJfd822m5Yo=;
        b=CAUtQrPzxSJDXPGhvEl3FK93KFhWVa7tPAxpBG7Kejji9m1MU5E1f9v2Z+AhPsGyNi
         qrGYXzC1XCHjwt7QAFb6aYZj4Wf5eWcCiH/QIGtbleRLii8eSM9ICoQOB46mR4WI3ZdQ
         LlcPpn5UCh0jM5MmWi6nN9iIsmM6fn9yge0iSJR0Ehw57p9gvB4pcXLwXL3q5Wubs4A9
         48Fqlhop9U4QQi6UuPlmuCpKfL/t4d3xdmQXDNLWS8HQlm53roc4AEwMNAHnKMJLTcdn
         20y+8V9258pXy9DwJKC8t99451wZXgLEUKAiLcHAuGc/Inj25eKWlXmqp+Ps7hxRBdz3
         u78g==
X-Gm-Message-State: AC+VfDyzzVJOrdAA9voXqDUiTgb92jmzffln3eeX9TCEhnm/r76ljJ9l
        /v9Njj0tgvBHy5PVpXi+0qIiUg==
X-Google-Smtp-Source: ACHHUZ48PaTZeRuW/bxQwQSoiosLfqm8lnPaNy5Y2GIXdHk5ceDl8TZLYHWDN1yziev8Ix6qTz8mcA==
X-Received: by 2002:a05:6512:39cb:b0:4fb:9631:4bb with SMTP id k11-20020a05651239cb00b004fb963104bbmr2618068lfu.11.1688030838557;
        Thu, 29 Jun 2023 02:27:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s4-20020adfea84000000b002ca864b807csm15800172wrm.0.2023.06.29.02.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:27:17 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 29 Jun 2023 11:27:12 +0200
Subject: [PATCH v4 3/4] input: touchscreen: add I2C support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v4-3-0947c489be17@linaro.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4476;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=2lAFdePYf/Rc2YPrDd8SFDwhphuN7s7QrVU8qBwj8ls=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknU5xA1C3NCQUd3elc93N00ZSN+49tGful3xUfdIp
 BwsxhLKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ1OcQAKCRB33NvayMhJ0XqbD/
 wNPDRrasmAOurEG5ZU9ORB3WyfxCkEkgeLzeZKMIJXEV80koCBPNv/ucRX98/WZPmxZE1qOl8eLbTT
 fey2AE+tHImA5HIccAQ+VTN/+kNbVLRrYeMaZqfYLZuRleg/1ds6kVy3/DfEVHIjg2Wts3MlM0uyLd
 shj6CC0Yz475fRyVBFQ4ViVguK4EUhghazwKr92mipyuhx/VKs0prPwBiPO8hbrK4Uk4DfOd8psbAU
 hAOF+T7PU1uAy4gyB/PoAU/gIDh/NEY5GmqpH1ze+rkNKbcFceDkayapGyOtqndhTflIObHtus3iBt
 GzOImt6EWnHIoyH+6vTlpS1jU4dmZy4mQdJRzfaHzqsbIfYHQQR428K8lTX3+n2qyaEBOng93kjCQI
 2cOo5Z2okBbNoCpls5DrEFz/MqqR/+yWA1wLnWZ848da4VVKaOtJR97/iCN40qRij7FF6yXTyYfIEh
 rXtXg+bGt9h0mQyMZhAWc62dgFIynIf6YVS3VsOyIJbOKAXIhFrSwy9a3G6+ORV9NZUWegJsi8ENj6
 Nyb6Z5nx72fs8FDq5aINpYgML3XzbrBxph3Omo/2dDnTaV+3UygPFwiM4Y3tcMuPVD7BjS4pZbl8dH
 sMPxtzy3NSa/NfUNg5gPYnV1wMXNc91+bkdN4DxmFxk7fgjPCT3HCrh43Wbw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/input/touchscreen/Kconfig             | 14 ++++++
 drivers/input/touchscreen/Makefile            |  1 +
 drivers/input/touchscreen/goodix_berlin_i2c.c | 69 +++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index f6ed3f334447..d35169cbb499 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -419,6 +419,20 @@ config TOUCHSCREEN_GOODIX
 config TOUCHSCREEN_GOODIX_BERLIN_CORE
 	tristate
 
+config TOUCHSCREEN_GOODIX_BERLIN_I2C
+	tristate "Goodix Berlin I2C touchscreen"
+	depends on I2C
+	select REGMAP_I2C
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

