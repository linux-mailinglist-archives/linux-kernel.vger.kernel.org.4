Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FAE6BA95A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCOHcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjCOHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:30:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C969A30FF;
        Wed, 15 Mar 2023 00:29:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so963219pjp.2;
        Wed, 15 Mar 2023 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C/7dHOocUvYT/bJkb/iEmhoYixj6rp1neicTQ7WZYY=;
        b=S3UEvWFoeslbWynQij/ci9XNwWMdl8FiuMzpz3jB/sZR09oKC/fyHwsiF5JUNzA4Bq
         Rz1bJ4+Cwaz1hCLXzG9bJJXE6+uoya4x3/KKyjkRZpvAP2CRdCXSaRuv81en+LzU+vN1
         q6o7ejWiDGhTjKpKoWBHXy1K+GQ0y+7e2OcVFa6WbWd1jqQz9O3Ah/zYHzGBQI10xTBs
         l0pfPBW45ZbYfzp6/o09yItHRQGhaO9qJqm10X/o4E4CATZ/XGjCdR2RxpXrVV1DqOJX
         uzvgJPej7crSzOMEe4TKnDWSZuEE5DmgdN2/McChvBGjUwH0R1tc1G/K/xZvJ1s25AEl
         F9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5C/7dHOocUvYT/bJkb/iEmhoYixj6rp1neicTQ7WZYY=;
        b=cMBMSutcfRlgWSDnya7RFSurzUgSaeDch8uTv6YA9QAg7Tlh7DDX3g6KdD/tIcN2yQ
         h2SdQ7Q7lDlncXqD/1JkRrqk+bOAqzFrAfILhAfU4BP3Ws3HhFOxGKCzA0rtiIfQKIg5
         stAj24f3OtllHdmfY/bk1ubVD5WOh4N58ZWm5w49DuAPUP2icSIaYLcrFUYgJFSXcICD
         cuK7rj8OhBJrzrM8jpAZgJG1o7C3XSndJT0myQNHIwO4bhZyS5nlsqMLHwSGm51cV3Fa
         7O03HiZ5e6n8URKcFtS8lu7AAXMnha8fYb8sXplipQkfIK75Q2ZGeUvnjkI4aPUXqMTx
         Yd9A==
X-Gm-Message-State: AO0yUKXyE781V7TAer58HkIwT9RIBKS/mhfE2TmohCtj2cmIy8BJzq7j
        ivArTDsUlBFflsF6H+QDXwffN094D/njLw==
X-Google-Smtp-Source: AK7set90ygTf/4j4DqK6Z2HdVlWPD/dAZishtU0xRc+tgLW4dizsBDhm0ix+RQGWf1dFO2j6SOsqrg==
X-Received: by 2002:a17:903:2443:b0:19f:3cdc:56dc with SMTP id l3-20020a170903244300b0019f3cdc56dcmr2204489pls.33.1678865381509;
        Wed, 15 Mar 2023 00:29:41 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:41 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 13/15] reset: Add Nuvoton ma35d1 reset driver support
Date:   Wed, 15 Mar 2023 07:29:00 +0000
Message-Id: <20230315072902.9298-14-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
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
index 2a52c990d4fe..47671060d259 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -143,6 +143,12 @@ config RESET_NPCM
 	  This enables the reset controller driver for Nuvoton NPCM
 	  BMC SoCs.
 
+config RESET_NUVOTON_MA35D1
+	bool "Nuvton MA35D1 Reset Driver"
+	default ARCH_NUVOTON
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
index 000000000000..bdd39483ca4e
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
+#include <linux/err.h>
+#include <linux/mfd/syscon.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/mfd/ma35d1-sys.h>
+#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+#include <linux/regmap.h>
+#include <linux/reboot.h>
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
+	regmap_write(data->regmap, REG_SYS_IPRST0, 1 << MA35D1_RESET_CHIP);
+	return -EAGAIN;
+}
+
+static int ma35d1_reset_update(struct reset_controller_dev *rcdev,
+			      unsigned long id, bool assert)
+{
+	int reg;
+	int offset = (id / RST_PRE_REG) * 4;
+	struct ma35d1_reset_data *data =
+			container_of(rcdev, struct ma35d1_reset_data, rcdev);
+
+	regmap_read(data->regmap, REG_SYS_IPRST0 + offset, &reg);
+	if (assert)
+		reg |= 1 << (id % RST_PRE_REG);
+	else
+		reg &= ~(1 << (id % RST_PRE_REG));
+
+	regmap_write(data->regmap, REG_SYS_IPRST0 + offset, reg);
+	return 0;
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
+	int reg;
+	int offset = id / RST_PRE_REG;
+	struct ma35d1_reset_data *data =
+			container_of(rcdev, struct ma35d1_reset_data, rcdev);
+
+	regmap_read(data->regmap, REG_SYS_IPRST0 + offset, &reg);
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
+	struct device *dev = &pdev->dev;
+	struct ma35d1_reset_data *reset_data;
+	struct ma35d1_reboot_data *reboot_data;
+	int err;
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
+	if (!reboot_data) {
+		devm_kfree(dev, reset_data);
+		return -ENOMEM;
+	}
+
+	reset_data->regmap  = syscon_regmap_lookup_by_phandle(
+			      pdev->dev.of_node, "regmap");
+	if (IS_ERR(reset_data->regmap)) {
+		dev_err(&pdev->dev, "Failed to get SYS register base\n");
+		err = PTR_ERR(reset_data->regmap);
+		goto err_out;
+	}
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
+
+err_out:
+	devm_kfree(dev, reset_data);
+	devm_kfree(dev, reboot_data);
+	return err;
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

