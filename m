Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D701B6D90DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjDFH4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjDFH4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:56:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7047C7EF9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:56:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso2405921wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680767793; x=1683359793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFwkjW5J5CdRehsc8GlLIX3o+kL5YH8nSEZdD8MaHYM=;
        b=iu3VJD/fdtuq43QvdmC/5mzXIDge1MezszU916KAi3PYdnk9KxRluv8/7UTzH+NTm/
         WQoBqp4KufnMpTxLBIktCGir0jQq3khrAMSU3aIYbWsLY0zYVYrr7k5pQht3Y3j5c8MT
         fQD0ZXpzW4gU0HhyWXvVSFuCmgB6qtauy/GorUGkPwN9eihiJaqAGOE7SZxGMmQuBj1n
         2bux1JrpQ6V4DBkvwPPpms2AHR3xTkaHMP43mRR/NoT5taW48AUrRksDNrVoCaH1PKjz
         i7ixx8X8EyMsn2EA/hwwZ0LQbLAac1awgK3+0Iz0Cah6E7cY/VjbEQLneJJhLu0Rvf1C
         n3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680767793; x=1683359793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFwkjW5J5CdRehsc8GlLIX3o+kL5YH8nSEZdD8MaHYM=;
        b=fvMxs3sgTIv2nKckoO/h46S2If9hL1uC8rXvnMcuAySMYgYDOyR0XHlQUNJDXeN0cV
         eqzBQAuGQepz2hTVtXtc8yv2CqxU9ZPUoKnrzH+2ysMqO9CwYloQNdpP8qS6AjIjuNs0
         HShJfa1xiC1te46EKxa8SCl5U0UkpqKoQLr+SgQcT525eo3hCRXh7uq5D0XikrBWOpz3
         rhrQqDtrhnoHavqWyP4p4qN7HJHOvX7ROi3pWHTmfqaiO2/faJS7RkQkhz+QlAGcnqOC
         op4YNBslLT2Tj/e7RhjhJkC+mHyS87j2z1lfbzyhh0o6cbmwlPNlr1ciXG9p2Wmoo2Rj
         gyZA==
X-Gm-Message-State: AAQBX9emNUNdBYcpwgwqgM13ZQSVySqoTICXRDjLcsRT7eD2OntE+kZj
        1glojveCLJPTcBmHbQri0z/Ijg==
X-Google-Smtp-Source: AKy350ZxVqOHogDjg8RS9xJDesv/g/NoaK/UY52Rc6N4RKqnkLYTbYWXiPDQvKC0fzZSOopOKSOyOQ==
X-Received: by 2002:a05:600c:211a:b0:3ef:732e:2d5a with SMTP id u26-20020a05600c211a00b003ef732e2d5amr6680076wml.34.1680767793442;
        Thu, 06 Apr 2023 00:56:33 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b003f03d483966sm4572651wmo.44.2023.04.06.00.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 00:56:33 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     yi.l.liu@intel.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, macro@orcam.me.uk, dsahern@kernel.org,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        keescook@chromium.org, me@kloenk.de, mhiramat@kernel.org,
        milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH v6 3/6] misc: tps6594-esm: Add driver for TI TPS6594 ESM
Date:   Thu,  6 Apr 2023 09:56:19 +0200
Message-Id: <20230406075622.8990-4-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230406075622.8990-1-jpanis@baylibre.com>
References: <20230406075622.8990-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 000000000000..b488f704f104
--- /dev/null
+++ b/drivers/misc/tps6594-esm.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ESM (Error Signal Monitor) driver for TI TPS6594/TPS6593/LP8764 PMICs
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
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

