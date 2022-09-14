Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C055B89FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiINOJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiINOIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:08:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B3560D7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:08:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c11so25878912wrp.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=vp1E6+QHVOYaULyPFbq5rR84CQlOPmMuTVNHG0IbfvI=;
        b=URZwthzK4v2UZNJsd+y/mzYujfv5YTg18bAXxBGekE1PL1qk7evDBq4AhY+c+gPeUb
         6gHMTmNkBEC8EM9Fwdm/26tD/O+NNm4BP7GIbPRJ5+NGGSFr5cVDBqL8YHA+lAJJRaXU
         KiSoeAfHXoBUoE7bHrCJAfCh1h7VJJAxFS0csYgb4kYtfnwbcHtZkfTQofyzz6Oi87pS
         fbXM0xxb2byAnoPow+hgMrNh6MJBBZQ8eGqkumTLrKkjRaDzSQe/P0BUbQ223u4KaeWD
         XmNZGkT93BAArG/N9GWg54k6izPoGPujciX36oJ7GSHW1Rj3Vjs765gdOoAJ4gFYzM8B
         wsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vp1E6+QHVOYaULyPFbq5rR84CQlOPmMuTVNHG0IbfvI=;
        b=7ZdcPJS7aPQ/LprM5PuEmsGjxot3nMln1VuYhJ9rjBfPyQuhu1DYaikPXIYhrLcabd
         jR4aoZUvX1cJQqMiD8B/17OzvznvTp9N3XAelXtt+RJ0kny888Py7ngRSo5ruzPEMHPY
         dR8qmP8CTq/y4jk2sLlQuTStG20Ajmc4sdvO93xHgpm86WlSZzyVYtL3zoPnPWtNHXNZ
         arz3HEQRCusl1567kP/HA7X+RkargRJjRL4CaGltd5FC8P0YcH4BuFIWqGfbFpSsAgEZ
         1l6idol4vM8BGMQS9Hb3gCsJz1CbkLbXO7awv7bxdLgIz9b/Y0Q1jy7iQWkTpGabOPVQ
         njRQ==
X-Gm-Message-State: ACgBeo05eu1D06oyN/Q2zy7jfnmLBkhQnvee2DV/SxkiHMxBDXVncJSr
        gAShGJub07XFA5+lLtxPLJvRaQ==
X-Google-Smtp-Source: AA6agR7dDW3DXf9UXBWw+SCRY7nWxLcOdJ4P5CX3B8KlKwT0zYPLN4ix3uSvut6Qiu73nyT9cVsLrg==
X-Received: by 2002:adf:e192:0:b0:228:d066:a844 with SMTP id az18-20020adfe192000000b00228d066a844mr22523074wrb.54.1663164496176;
        Wed, 14 Sep 2022 07:08:16 -0700 (PDT)
Received: from jerome-BL.theccd.local ([89.101.193.66])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d654c000000b00228e1e90822sm13303767wrv.112.2022.09.14.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:08:15 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee.jones@linaro.org, tony@atomide.com,
        vigneshr@ti.com, bjorn.andersson@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, arnd@arndb.de, jeff@labundy.com
Cc:     afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v5 5/6] Input: Add tps65219 interrupt driven powerbutton
Date:   Wed, 14 Sep 2022 16:07:57 +0200
Message-Id: <20220914140758.7582-6-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914140758.7582-1-jneanne@baylibre.com>
References: <20220914140758.7582-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

TPS65219 has different interrupts compared to other TPS6521* chips.
TPS65219 defines two interrupts for the powerbutton one for push and one
for release.

This driver is very simple in that it maps the push interrupt to a key
input and the release interrupt to a key release.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 drivers/input/misc/Kconfig              |  10 ++
 drivers/input/misc/Makefile             |   1 +
 drivers/input/misc/tps65219-pwrbutton.c | 149 ++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 drivers/input/misc/tps65219-pwrbutton.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index a18ab7358d8f..18d4a321e7ff 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -468,6 +468,16 @@ config INPUT_TPS65218_PWRBUTTON
 	  To compile this driver as a module, choose M here. The module will
 	  be called tps65218-pwrbutton.
 
+config INPUT_TPS65219_PWRBUTTON
+	tristate "TPS65219 Power button driver"
+	depends on MFD_TPS65219
+	help
+	  Say Y here if you want to enable power button reporting for
+	  TPS65219 Power Management IC devices.
+
+	  To compile this driver as a module, choose M here. The module will
+	  be called tps65219-pwrbutton.
+
 config INPUT_AXP20X_PEK
 	tristate "X-Powers AXP20X power button driver"
 	depends on MFD_AXP20X
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 28dfc444f0a9..fe8f47402d12 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_STPMIC1_ONKEY)  	+= stpmic1_onkey.o
 obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
+obj-$(CONFIG_INPUT_TPS65219_PWRBUTTON)	+= tps65219-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
 obj-$(CONFIG_INPUT_TWL6040_VIBRA)	+= twl6040-vibra.o
diff --git a/drivers/input/misc/tps65219-pwrbutton.c b/drivers/input/misc/tps65219-pwrbutton.c
new file mode 100644
index 000000000000..163b545d5a54
--- /dev/null
+++ b/drivers/input/misc/tps65219-pwrbutton.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for TPS65219 Push Button
+//
+// Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/tps65219.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+struct tps65219_pwrbutton {
+	struct device *dev;
+	struct input_dev *idev;
+	char phys[32];
+};
+
+static irqreturn_t tps65219_pb_push_irq(int irq, void *_pwr)
+{
+	struct tps65219_pwrbutton *pwr = _pwr;
+
+	input_report_key(pwr->idev, KEY_POWER, 1);
+	pm_wakeup_event(pwr->dev, 0);
+	input_sync(pwr->idev);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t tps65219_pb_release_irq(int irq, void *_pwr)
+{
+	struct tps65219_pwrbutton *pwr = _pwr;
+
+	input_report_key(pwr->idev, KEY_POWER, 0);
+	input_sync(pwr->idev);
+
+	return IRQ_HANDLED;
+}
+
+static int tps65219_pb_probe(struct platform_device *pdev)
+{
+	struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct tps65219_pwrbutton *pwr;
+	struct input_dev *idev;
+	int error;
+	int push_irq;
+	int release_irq;
+
+	pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
+	if (!pwr)
+		return -ENOMEM;
+
+	idev = devm_input_allocate_device(dev);
+	if (!idev)
+		return -ENOMEM;
+
+	idev->name = pdev->name;
+	snprintf(pwr->phys, sizeof(pwr->phys), "%s/input0",
+		 pdev->name);
+	idev->phys = pwr->phys;
+	idev->dev.parent = dev;
+	idev->id.bustype = BUS_I2C;
+
+	input_set_capability(idev, EV_KEY, KEY_POWER);
+
+	pwr->dev = dev;
+	pwr->idev = idev;
+	device_init_wakeup(dev, true);
+
+	push_irq = platform_get_irq(pdev, 0);
+	if (push_irq < 0)
+		return -EINVAL;
+
+	release_irq = platform_get_irq(pdev, 1);
+	if (release_irq < 0)
+		return -EINVAL;
+
+	error = devm_request_threaded_irq(dev, push_irq, NULL,
+					  tps65219_pb_push_irq,
+					  IRQF_ONESHOT,
+					  dev->init_name, pwr);
+	if (error) {
+		dev_err(dev, "failed to request push IRQ #%d: %d\n", push_irq,
+			error);
+		return error;
+	}
+
+	error = devm_request_threaded_irq(dev, release_irq, NULL,
+					  tps65219_pb_release_irq,
+					  IRQF_ONESHOT,
+					  dev->init_name, pwr);
+	if (error) {
+		dev_err(dev, "failed to request release IRQ #%d: %d\n",
+			release_irq, error);
+		return error;
+	}
+
+	error = input_register_device(idev);
+	if (error) {
+		dev_err(dev, "Can't register power button: %d\n", error);
+		return error;
+	}
+
+	/* Enable interrupts for the pushbutton */
+	regmap_clear_bits(tps->regmap, TPS65219_REG_MASK_CONFIG,
+			  TPS65219_REG_MASK_INT_FOR_PB_MASK);
+
+	/* Set PB/EN/VSENSE pin to be a pushbutton */
+	regmap_update_bits(tps->regmap, TPS65219_REG_MFP_2_CONFIG,
+			   TPS65219_MFP_2_EN_PB_VSENSE_MASK, TPS65219_MFP_2_PB);
+
+	return 0;
+}
+
+static int tps65219_pb_remove(struct platform_device *pdev)
+{
+	struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
+
+	/* Disable interrupt for the pushbutton */
+	return regmap_update_bits(tps->regmap, TPS65219_REG_MASK_CONFIG,
+				  TPS65219_REG_MASK_INT_FOR_PB_MASK,
+				  TPS65219_REG_MASK_INT_FOR_PB_MASK);
+}
+
+static const struct platform_device_id tps65219_pwrbtn_id_table[] = {
+	{ "tps65219-pwrbutton", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, tps65219_pwrbtn_id_table);
+
+static struct platform_driver tps65219_pb_driver = {
+	.probe = tps65219_pb_probe,
+	.remove = tps65219_pb_remove,
+	.driver = {
+		.name = "tps65219_pwrbutton",
+	},
+	.id_table = tps65219_pwrbtn_id_table,
+};
+module_platform_driver(tps65219_pb_driver);
+
+MODULE_DESCRIPTION("TPS65219 Power Button");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Markus Schneider-Pargmann <msp@baylibre.com");
-- 
2.17.1

