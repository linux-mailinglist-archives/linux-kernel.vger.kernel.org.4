Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF36025CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiJRHd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJRHdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:33:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4D2691A8;
        Tue, 18 Oct 2022 00:33:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k9so12600992pll.11;
        Tue, 18 Oct 2022 00:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjbPHXqyVQKTBNGKhAz9KJkxl8OTw4y/RUKXsXL8Wqc=;
        b=YVYyx4KOy//UpLvWWqJsCWYzv2gQjalPRYP7YW+cfdlNxCoWzKNDbj4hjLWeZU5CBY
         FRjw3fbWXFGO3G/A9T+Kajb8Yfjn4wB8/O4D/dO3D6f+6E2Z5qp/42EHMfxkx72kU6VD
         Q+2MJsSmLK7331RQE2lIZraQv9/ryTu64c2heSS6NNXHLY9T/40JLZKCEH5ZCILPke2v
         Wxe80Uv7/nixfEmyc/8K0BMloZvoOL2XGGE+8QlwT0oCtVGJyNP5cmq3YAstg7GKzmZA
         iTfrqKxAJ6Eu3lirzU9FTCXLruWzYWuMstMLDyP1lhjGyOuUd0Wg2LDXl5UOoq6qWRHu
         294A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjbPHXqyVQKTBNGKhAz9KJkxl8OTw4y/RUKXsXL8Wqc=;
        b=nm6ajnGILL89Ap2nZxV8FvfyK18PJkanooi77AwjFaR3bV/fNKY1XKHWIdSsRUS9/Y
         Uqjpru9VBFUtfsHKr4eAxfI3GTTwaHbQbuREzJU73O8iKFn1bHvved4cqKB5+2SoypXs
         gBpvL/bCzzT9Md7er9gt2cCuveLA7PsXp1tcItv2jEP9KWBcn89LzjVqjp7iXZTPGj3v
         oU3Gs4HEMF3scgnj4kaCJey6ZLRh/R1ecbuq8yQyhDfNKj7mueXYMxYtHC4lOB9M7qnk
         ARc67JzOutASU2rN2cypNqlmbAQXF4s76rM38HzF9zmncirDNaIWRvTkhldPQBSIrMZX
         d1pA==
X-Gm-Message-State: ACrzQf2sYIpaKMoeAx8RQdh7eCiifSFLEZN8UvX8w0VnhN4DOB4JEpLg
        XIhTScijN2dmarDdQ/d3KKKj2WRUN8DUng==
X-Google-Smtp-Source: AMsMyM5Jwfp21wPltxo9rtJBcrwJBF3BHn5kv8oRtXdlHz9UJhjMJMdLPpxlYVCzdEyVjr5oRnJGLQ==
X-Received: by 2002:a17:902:a60c:b0:184:fa22:8b3c with SMTP id u12-20020a170902a60c00b00184fa228b3cmr1667837plq.136.1666078393319;
        Tue, 18 Oct 2022 00:33:13 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id s1-20020a170902ea0100b001769206a766sm7853260plg.307.2022.10.18.00.33.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:33:12 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v11 1/2] thermal: Add thermal driver for Sunplus
Date:   Tue, 18 Oct 2022 15:32:51 +0800
Message-Id: <076585e120b64832dcb81e39f3e59d719148816b.1665990345.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1665990345.git.lhjeff911@gmail.com>
References: <cover.1665990345.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1665990345.git.lhjeff911@gmail.com>
References: <cover.1665990345.git.lhjeff911@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal driver for Sunplus.

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v11:
 - Remove the remove function of the platform_driver
 - Fix error reported-by: kernel test robot.

 MAINTAINERS                       |   6 ++
 drivers/thermal/Kconfig           |  10 +++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/sunplus_thermal.c | 130 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/thermal/sunplus_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f185..bf22c53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19753,6 +19753,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 F:	drivers/spi/spi-sunplus-sp7021.c
 
+SUNPLUS THERMAL DRIVER
+M:	Li-hao Kuo <lhjeff911@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/thermal/sunplus_thermal.c
+
 SUNPLUS UART DRIVER
 M:	Hammer Hsieh <hammerh0314@gmail.com>
 S:	Maintained
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e052dae..405b788 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
 	  If you say yes here you get support for the FAN controlled
 	  by the Microcontroller found on the Khadas VIM boards.
 
+config SUNPLUS_THERMAL
+	tristate "Sunplus thermal drivers"
+	depends on SOC_SP7021 || COMPILE_TEST
+	help
+	  This enable the Sunplus SP7021 thermal driver, which supports the primitive
+	  temperature sensor embedded in Sunplus SP7021 SoC.
+
+	  If you have a Sunplus SP7021 platform say Y here and enable this option
+	  to have support for thermal management.
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 2506c6c..4512193 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_SUNPLUS_THERMAL)	+= sunplus_thermal.o
\ No newline at end of file
diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_thermal.c
new file mode 100644
index 0000000..20ea7d9
--- /dev/null
+++ b/drivers/thermal/sunplus_thermal.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Sunplus Inc.
+ * Author: Li-hao Kuo <lhjeff911@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/thermal.h>
+
+#define ENABLE_THERMAL		BIT(31)
+#define SP_THERMAL_MASK		GENMASK(10, 0)
+
+#define TEMP_RATE		608
+#define TEMP_BASE		3500
+#define TEMP_OTP_BASE		1518
+
+#define SP_THERMAL_CTL0_REG	0x0000
+#define SP_THERMAL_STS0_REG	0x0030
+
+/* common data structures */
+struct sp_thermal_data {
+	struct thermal_zone_device *pcb_tz;
+	void __iomem *regs;
+	int *otp_temp0;
+};
+
+static int sunplus_get_otp_temp_coef(struct sp_thermal_data *sp_data, struct device *dev)
+{
+	struct nvmem_cell *cell;
+	ssize_t otp_l;
+
+	cell = nvmem_cell_get(dev, "calib");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	sp_data->otp_temp0 = nvmem_cell_read(cell, &otp_l);
+	nvmem_cell_put(cell);
+
+	if (*sp_data->otp_temp0 == 0)
+		*sp_data->otp_temp0 = TEMP_OTP_BASE;
+
+	return 0;
+}
+
+/*
+ * There is a thermal sensor instance for Sunplus Soc
+ * T_CODE is the ADC of the thermal sensor
+ * T_CODE : 11 digits in total
+ * When remanufacturing, the 35 degree T_CODE will be read and stored in nvcell.
+ * otp_temp0 is the 35 degree T_CODE obtained from nvcell
+ * The function will get 35 degree T_CODE for thermal calibration.
+ * TEMP_RATE is the Sunplus thermal temperature slope.
+ */
+
+static int sp_thermal_get_sensor_temp(void *data, int *temp)
+{
+	struct sp_thermal_data *sp_data = data;
+	int t_code;
+
+	t_code = readl(sp_data->regs + SP_THERMAL_STS0_REG);
+	t_code = FIELD_GET(SP_THERMAL_MASK, t_code);
+	*temp = ((*sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + TEMP_BASE;
+	*temp *= 10;
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops sp_of_thermal_ops = {
+	.get_temp = sp_thermal_get_sensor_temp,
+};
+
+static int sunplus_thermal_probe(struct platform_device *pdev)
+{
+	struct sp_thermal_data *sp_data;
+	int ret;
+
+	sp_data = devm_kzalloc(&pdev->dev, sizeof(*sp_data), GFP_KERNEL);
+	if (!sp_data)
+		return -ENOMEM;
+
+	sp_data->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sp_data->regs)) {
+		dev_err(&pdev->dev, "resource get fail\n");
+		return PTR_ERR(sp_data->regs);
+	}
+
+	writel(ENABLE_THERMAL, sp_data->regs + SP_THERMAL_CTL0_REG);
+
+	platform_set_drvdata(pdev, sp_data);
+	ret = sunplus_get_otp_temp_coef(sp_data, &pdev->dev);
+	if (ret)
+		return ret;
+
+	sp_data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
+							    0,
+							    sp_data, &sp_of_thermal_ops);
+
+	if (IS_ERR(sp_data->pcb_tz)) {
+		ret = PTR_ERR(sp_data->pcb_tz);
+		dev_err(&pdev->dev, "failed to register tsensor: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct of_device_id of_sunplus_thermal_ids[] = {
+	{ .compatible = "sunplus,sp7021-thermal" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_sunplus_thermal_ids);
+
+static struct platform_driver sunplus_thermal_driver = {
+	.probe	= sunplus_thermal_probe,
+	.driver	= {
+		.name	= "sunplus-thermal",
+		.of_match_table = of_sunplus_thermal_ids,
+		},
+};
+module_platform_driver(sunplus_thermal_driver);
+
+MODULE_AUTHOR("Li-hao Kuo <lhjeff911@gmail.com>");
+MODULE_DESCRIPTION("Thermal driver for Sunplus SoC");
+MODULE_LICENSE("GPL");
-- 
2.7.4

