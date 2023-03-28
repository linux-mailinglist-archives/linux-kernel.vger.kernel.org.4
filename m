Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14506CB3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjC1CUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjC1CUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:20:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE7C2D4A;
        Mon, 27 Mar 2023 19:19:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so11039365pjb.0;
        Mon, 27 Mar 2023 19:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNvre9lqlj1QYJAxJQhhmY1ZhXVtMVnMFvNeSmsG++w=;
        b=MPm7WsK8zFMjt7aDYbPKTqcsBO3c/vXdfuo9UIY0e8YkQA6aL97kQ8J0fwTjD6MekH
         y7RzhDG7s79P2owcFdntk3/4oiPxF0pv+8tFMhheOiIZDcp8VgIScoonzNoMffZPdoyY
         Oca5PtgL3WnnFNolr1Abcf8jaj6GKvp2TZG11ETjwJSZdbFZItkgJsABYFutk6y0QjQ8
         7xicFSRKDxY0fIgnrhSIngf5hThkEbH7ifpYhWp1rRTjOPyG++bzsi77cSukLTr8hIbo
         g2e8guXE2yI0XJT/bJ0Uu+haBgUld6pbezeJjpkK6d1CoaPJsq823eHIj5KAAE0tw2/Z
         1m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNvre9lqlj1QYJAxJQhhmY1ZhXVtMVnMFvNeSmsG++w=;
        b=fqeMNiM89GW/pLwTFWGGyz4CMFRz8hvdWVXasCXWXEbejuehhPi7zt6nRFekogNztf
         Y+gbtlbcuVSSG6IWyXcIrWiLRGDq/nHxdKFZSr4EydVYk8GA78V0/B+u1a2VJb44fg2n
         ezuiNK+OMdylPoIO9ZxVMX7HKoR3A1HVscqcsWa8CjYxueB6Ka4CEGmeNgpEqQedhBXo
         v6aNIr//GCMhjQ+7pZC7v3JqPHDv4ddJeB9J13hD40DI6msp6wT6axqAtoO0MiDsaqM3
         il6NN4ULhdYMphOpqhJXFh4fsvymFiwNCNYffhKkEVGAU67Sn/FD/hTWZ4C+yjWzKFBM
         7Jzw==
X-Gm-Message-State: AAQBX9fJvwaenzi6EKAX5woNglop2pS7ZmSMQjxbvI+Doh4nXEVQXEQU
        Q6oG5FQiu6mVkguAPYy/tp4=
X-Google-Smtp-Source: AKy350ZbmFEheQDAsTSgrRdo1ocTdYgnob9kZ1xSY06iv58erbvvpj0Aj/7qlkhwjB9JZIgHSP6Z4g==
X-Received: by 2002:a17:90b:3847:b0:233:e1e6:33d4 with SMTP id nl7-20020a17090b384700b00233e1e633d4mr15310856pjb.47.1679969988489;
        Mon, 27 Mar 2023 19:19:48 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ac29100b00232cc61e16bsm5029301pjt.35.2023.03.27.19.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:19:48 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v6 10/12] reset: Add Nuvoton ma35d1 reset driver support
Date:   Tue, 28 Mar 2023 02:19:10 +0000
Message-Id: <20230328021912.177301-11-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328021912.177301-1-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This driver supports individual IP reset for ma35d1. The reset
control registers is a subset of system control registers.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 drivers/reset/Kconfig        |   6 ++
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-ma35d1.c | 152 +++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/reset/reset-ma35d1.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2a52c990d4fe..58477c6ca9b8 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -143,6 +143,12 @@ config RESET_NPCM
 	  This enables the reset controller driver for Nuvoton NPCM
 	  BMC SoCs.
 
+config RESET_NUVOTON_MA35D1
+	bool "Nuvton MA35D1 Reset Driver"
+	default ARCH_NUVOTON || COMPILE_TEST
+	help
+	  This enables the reset controller driver for Nuvoton MA35D1 SoC.
+
 config RESET_OXNAS
 	bool
 
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 3e7e5fd633a8..fd52dcf66a99 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
+obj-$(CONFIG_RESET_NUVOTON_MA35D1) += reset-ma35d1.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_POLARFIRE_SOC) += reset-mpfs.o
diff --git a/drivers/reset/reset-ma35d1.c b/drivers/reset/reset-ma35d1.c
new file mode 100644
index 000000000000..221299e7b873
--- /dev/null
+++ b/drivers/reset/reset-ma35d1.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Nuvoton Technology Corp.
+ * Author: Chi-Fang Li <cfli0@nuvoton.com>
+ */
+
+#include <linux/device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+#define REG_SYS_IPRST0		0x020
+#define REG_SYS_IPRST1		0x024
+#define REG_SYS_IPRST2		0x028
+#define REG_SYS_IPRST3		0x02C
+
+#define RST_PRE_REG	32
+
+struct ma35d1_reset_data {
+	struct reset_controller_dev rcdev;
+	struct regmap *regmap;
+};
+
+struct ma35d1_reboot_data {
+	struct notifier_block restart_handler;
+	struct regmap *regmap;
+};
+
+static int ma35d1_restart_handler(struct notifier_block *this,
+				  unsigned long mode, void *cmd)
+{
+	struct ma35d1_reboot_data *data =
+			container_of(this, struct ma35d1_reboot_data,
+				     restart_handler);
+	return regmap_write(data->regmap, REG_SYS_IPRST0, 1 << MA35D1_RESET_CHIP);
+}
+
+static int ma35d1_reset_update(struct reset_controller_dev *rcdev,
+			       unsigned long id, bool assert)
+{
+	unsigned int reg;
+	int ret;
+	int offset = (id / RST_PRE_REG) * 4;
+	struct ma35d1_reset_data *data =
+			container_of(rcdev, struct ma35d1_reset_data, rcdev);
+
+	ret = regmap_read(data->regmap, REG_SYS_IPRST0 + offset, &reg);
+	if (ret < 0)
+		return ret;
+	if (assert)
+		reg |= 1 << (id % RST_PRE_REG);
+	else
+		reg &= ~(1 << (id % RST_PRE_REG));
+
+	return regmap_write(data->regmap, REG_SYS_IPRST0 + offset, reg);
+}
+
+static int ma35d1_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return ma35d1_reset_update(rcdev, id, true);
+}
+
+static int ma35d1_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return ma35d1_reset_update(rcdev, id, false);
+}
+
+static int ma35d1_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	int reg, ret;
+	int offset = id / RST_PRE_REG;
+	struct ma35d1_reset_data *data =
+			container_of(rcdev, struct ma35d1_reset_data, rcdev);
+
+	ret = regmap_read(data->regmap, REG_SYS_IPRST0 + offset, &reg);
+	if (ret < 0)
+		return ret;
+	return !!(reg & BIT(id % RST_PRE_REG));
+}
+
+static const struct reset_control_ops ma35d1_reset_ops = {
+	.assert = ma35d1_reset_assert,
+	.deassert = ma35d1_reset_deassert,
+	.status = ma35d1_reset_status,
+};
+
+static const struct of_device_id ma35d1_reset_dt_ids[] = {
+	{ .compatible = "nuvoton,ma35d1-reset" },
+	{ },
+};
+
+static int ma35d1_reset_probe(struct platform_device *pdev)
+{
+	int err;
+	struct device *dev = &pdev->dev;
+	struct device_node *parent;
+	struct ma35d1_reset_data *reset_data;
+	struct ma35d1_reboot_data *reboot_data;
+
+	if (!pdev->dev.of_node) {
+		dev_err(&pdev->dev, "Device tree node not found\n");
+		return -EINVAL;
+	}
+
+	reset_data = devm_kzalloc(dev, sizeof(*reset_data), GFP_KERNEL);
+	if (!reset_data)
+		return -ENOMEM;
+
+	reboot_data = devm_kzalloc(dev, sizeof(*reboot_data), GFP_KERNEL);
+	if (!reboot_data)
+		return -ENOMEM;
+
+	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
+	reset_data->regmap = syscon_node_to_regmap(parent);
+	of_node_put(parent);
+	if (IS_ERR(reset_data->regmap)) {
+		dev_err(&pdev->dev, "Failed to get SYS register base\n");
+		return PTR_ERR(reset_data->regmap);
+	}
+
+	reset_data->rcdev.owner = THIS_MODULE;
+	reset_data->rcdev.nr_resets = MA35D1_RESET_COUNT;
+	reset_data->rcdev.ops = &ma35d1_reset_ops;
+	reset_data->rcdev.of_node = dev->of_node;
+
+	reboot_data->regmap = reset_data->regmap;
+	reboot_data->restart_handler.notifier_call = ma35d1_restart_handler;
+	reboot_data->restart_handler.priority = 192;
+
+	err = register_restart_handler(&reboot_data->restart_handler);
+	if (err)
+		dev_warn(&pdev->dev, "failed to register restart handler\n");
+
+	return devm_reset_controller_register(dev, &reset_data->rcdev);
+}
+
+static struct platform_driver ma35d1_reset_driver = {
+	.probe = ma35d1_reset_probe,
+	.driver = {
+		.name = "ma35d1-reset",
+		.of_match_table	= ma35d1_reset_dt_ids,
+	},
+};
+
+builtin_platform_driver(ma35d1_reset_driver);
-- 
2.34.1

