Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350156BAEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjCOLKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjCOLJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:09:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247360D76
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:08:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j2so16905654wrh.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678878465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vvEoJHcciKif3PVTSFotDU3SKpAzbw5nYXY47EELYQ=;
        b=aSYfaBX6FrrUUH6A1DPYYmngJqc75EF81PWRZqoJlfoez47wnUczbdlO/4HnXmkCZP
         xunMDib1kBB5jDJV5rLlroQAQHmtq/2sDAuPF7LZtdzD/xzBE8R9Sizz6v1Y67Nrt288
         Uf38socscAQSHZ6GpMeRr8Ba7LREkRQyRJ85GlD3a1A8NHr1PI03r64l11ipWcQs2UXJ
         NBDwk6v3U5WMYMY1hXNGpY0xSAgfGcBPcidsNJeze4TaXYxABGDhMm6IH1XtcD93qeHI
         lRuNLSxxp24aFPzFIIdyo6vlz5V9QZLmIlxfKh9A2Q5dmiwgQd9BdbIj6uDqIHcQfl2x
         4Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vvEoJHcciKif3PVTSFotDU3SKpAzbw5nYXY47EELYQ=;
        b=wdm3ip6ODsxJkb2madqDdtUPrlSW4vgSg0ltk75ZCvJreMpfHfGLlCgRqlP8yjME7V
         OWlKUxhUMUzESAcFU6sr5g5B6zOBijT0WQXpEOJSorGhTSn8mEvOSR7rm1q8iATUKuIx
         2dWul5GG5rvyx2SVmAD+IfBhioK5geiED1pNYuMqEyOI8pZG830TsZiQymCpOUeMNlb+
         pGzaZrCVEguYLyM7stB+dnXAQmIAWC+l9asuaIi94wKQNbww3YdWBFScgpFewc5elOr8
         GM6RAiM6IcHpDkaHT+3O/BYAz0tHHcoshyhzK7agLmcFm9ZCayykAiQ+XW8/GLsfjrYV
         fsaw==
X-Gm-Message-State: AO0yUKVuBxV/Y1zELOCnJ4Yf1tpKdeLs8kvkapXiu3t4lun2ZQv5fB2c
        T1IeSLGEO9avHEPBA6aQ2YcisQ==
X-Google-Smtp-Source: AK7set9HamkJy5VJEje2CKT4k5HaGH1s2Ny8IwnEXoBk5/OXSsOF94qRWloIRehkoZNeM0lcGrHSQg==
X-Received: by 2002:a5d:4f82:0:b0:2cf:e655:f0f1 with SMTP id d2-20020a5d4f82000000b002cfe655f0f1mr1496208wru.67.1678878465763;
        Wed, 15 Mar 2023 04:07:45 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id n5-20020adfe785000000b002c7066a6f77sm4339745wrm.31.2023.03.15.04.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:07:45 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
Subject: [PATCH v2 3/4] misc: tps6594-esm: Add driver for TI TPS6594 ESM
Date:   Wed, 15 Mar 2023 12:07:35 +0100
Message-Id: <20230315110736.35506-4-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230315110736.35506-1-jpanis@baylibre.com>
References: <20230315110736.35506-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for TPS6594 ESM (Error Signal Monitor).
This device monitors the SoC error output signal at its nERR_SOC input pin.
In error condition, ESM toggles its nRSTOUT_SOC pin to reset the SoC.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/misc/Kconfig       |  11 ++++
 drivers/misc/Makefile      |   1 +
 drivers/misc/tps6594-esm.c | 132 +++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/misc/tps6594-esm.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 433aa4197785..c73c02801330 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -538,6 +538,17 @@ config TMR_INJECT
 
 	  Say N here unless you know what you are doing.
 
+config TPS6594_ESM
+	tristate "TI TPS6594 Error Signal Monitor support"
+	depends on MFD_TPS6594
+	default MFD_TPS6594
+	help
+	  Support ESM (Error Signal Monitor) on TPS6594 PMIC devices.
+	  ESM is used typically to reboot the board in error condition.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called tps6594-esm.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 56de43943cd5..3dc69ec69912 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -65,3 +65,4 @@ obj-$(CONFIG_GP_PCI1XXXX)	+= mchp_pci1xxxx/
 obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
 obj-$(CONFIG_TMR_MANAGER)      += xilinx_tmr_manager.o
 obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
+obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
diff --git a/drivers/misc/tps6594-esm.c b/drivers/misc/tps6594-esm.c
new file mode 100644
index 000000000000..db242b50846f
--- /dev/null
+++ b/drivers/misc/tps6594-esm.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ESM (Error Signal Monitor) driver for TI TPS6594/TPS6593/LP8764X PMICs
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/tps6594.h>
+
+static irqreturn_t tps6594_esm_isr(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	int i;
+
+	for (i = 0 ; i < pdev->num_resources ; i++) {
+		if (irq == platform_get_irq_byname(pdev, pdev->resource[i].name)) {
+			dev_err(pdev->dev.parent, "%s error detected\n", pdev->resource[i].name);
+			return IRQ_HANDLED;
+		}
+	}
+
+	return IRQ_NONE;
+}
+
+static int tps6594_esm_probe(struct platform_device *pdev)
+{
+	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	int irq;
+	int ret;
+	int i;
+
+	for (i = 0 ; i < pdev->num_resources ; i++) {
+		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
+		if (irq < 0)
+			return dev_err_probe(dev, irq, "Failed to get %s irq\n",
+					     pdev->resource[i].name);
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						tps6594_esm_isr, IRQF_ONESHOT,
+						pdev->resource[i].name, pdev);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request irq\n");
+	}
+
+	ret = regmap_set_bits(tps->regmap, TPS6594_REG_ESM_SOC_MODE_CFG,
+			      TPS6594_BIT_ESM_SOC_EN | TPS6594_BIT_ESM_SOC_ENDRV);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure ESM\n");
+
+	ret = regmap_set_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
+			      TPS6594_BIT_ESM_SOC_START);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to start ESM\n");
+
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	return 0;
+}
+
+static int tps6594_esm_remove(struct platform_device *pdev)
+{
+	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
+				TPS6594_BIT_ESM_SOC_START);
+	if (ret) {
+		dev_err(dev, "Failed to stop ESM\n");
+		goto out;
+	}
+
+	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_ESM_SOC_MODE_CFG,
+				TPS6594_BIT_ESM_SOC_EN | TPS6594_BIT_ESM_SOC_ENDRV);
+	if (ret)
+		dev_err(dev, "Failed to unconfigure ESM\n");
+
+out:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static int tps6594_esm_suspend(struct device *dev)
+{
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	int ret;
+
+	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
+				TPS6594_BIT_ESM_SOC_START);
+
+	pm_runtime_put_sync(dev);
+
+	return ret;
+}
+
+static int tps6594_esm_resume(struct device *dev)
+{
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+
+	pm_runtime_get_sync(dev);
+
+	return regmap_set_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
+			       TPS6594_BIT_ESM_SOC_START);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(tps6594_esm_pm_ops, tps6594_esm_suspend, tps6594_esm_resume);
+
+static struct platform_driver tps6594_esm_driver = {
+	.driver	= {
+		.name = "tps6594-esm",
+		.pm = pm_sleep_ptr(&tps6594_esm_pm_ops),
+	},
+	.probe = tps6594_esm_probe,
+	.remove = tps6594_esm_remove,
+};
+
+module_platform_driver(tps6594_esm_driver);
+
+MODULE_ALIAS("platform:tps6594-esm");
+MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 Error Signal Monitor Driver");
+MODULE_LICENSE("GPL");
-- 
2.37.3

