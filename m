Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499246FEF52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbjEKJwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbjEKJwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:52:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA637DA9
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso56285415e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683798692; x=1686390692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFwkjW5J5CdRehsc8GlLIX3o+kL5YH8nSEZdD8MaHYM=;
        b=egiR86HgdKqTz6bU8vZGXONfS2Y9yf3bSDU1cz4JtwEXD1gxNvWgxFlsbXgdJSH4bj
         6h7L0SCvVG0JYP467gjdsQFBvrGAU8G92znU5yHGjd5mgzHv7zP75686PSwAD6lWuDzy
         Nu0N5eTj9SmIo4x/q6lGfC5VKQIAzoy3orPX/vFEbyE/6YLjO28+1X6cgYl/pubqW/bE
         7RiNlQhg7Tp8kptjAu5vwpnTPbXfbMxYGSjIwlUFZqupH2jD5wS5It/77XmMTBsLAk6d
         Ny+Wi7D/XPAvulGJxRtkKPxv/83N4vpfFVmJ6qyA/2Zkp6vfDzfLhyIroBN2jTx+cDCD
         1Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798692; x=1686390692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFwkjW5J5CdRehsc8GlLIX3o+kL5YH8nSEZdD8MaHYM=;
        b=WekVAWWJFy5oh+utLvCfWe6/qLA/JdseaHGrV9NGaOGUgh2KsAaMDUP10yBxl+SPxZ
         rOoqXzS6OH6RB5G8tyX25c/EJGrAtjWUatmGFjr+eJMWbgfb5QmqWV4PuUcxry1tWucP
         5FSKHTiHK7RQSv7dpMJM4vVD3EjTRlZV3iaZ9RgM3T29hHMgztdVFS6EWHlgBunnamtS
         cyYDnZSK65fdMXiXyC7jya1+JVAL/7zzmhzsHAzM6RlZ5qB0afCXllCHg0AGYhK3vbhs
         QW1sK7LKWpoRpklbwPI6SC5YgOLOFlpXYocjnHnLxXQAd/E2LQ3Ee41H5et8E37AraeR
         VnEg==
X-Gm-Message-State: AC+VfDwxqFUe6FfTCtfEewLAz7TaE6lRXB3iWlnOve36cL8kSXsg5br9
        BIvewxMayMOd/KNs+0SGA9TEMQ==
X-Google-Smtp-Source: ACHHUZ4/X+Mus6vC0hXw+NrxDQPFjvpNMfpU3fNQEtkKPAry9tUf37xllNrUAgK6GJY/ybadEhUlQg==
X-Received: by 2002:a7b:c007:0:b0:3f4:f011:312d with SMTP id c7-20020a7bc007000000b003f4f011312dmr233544wmb.2.1683798692553;
        Thu, 11 May 2023 02:51:32 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003f4069417absm22389956wmz.24.2023.05.11.02.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:51:32 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com
Cc:     macro@orcam.me.uk, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        jirislaby@kernel.org, rostedt@goodmis.org, revest@chromium.org,
        gehao@kylinos.cn, akpm@linux-foundation.org, jgg@ziepe.ca,
        razor@blackwall.org, stephen@networkplumber.org,
        prabhakar.csengg@gmail.com, contact@emersion.fr,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        me@kloenk.de, milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com
Subject: [PATCH v7 3/6] misc: tps6594-esm: Add driver for TI TPS6594 ESM
Date:   Thu, 11 May 2023 11:51:23 +0200
Message-Id: <20230511095126.105104-4-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230511095126.105104-1-jpanis@baylibre.com>
References: <20230511095126.105104-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

