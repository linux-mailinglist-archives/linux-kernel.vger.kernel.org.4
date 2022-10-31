Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B745613BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiJaQrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiJaQrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:47:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910512AD7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:47:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o4so16817507wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xErnWFgaDg+HEqwln9TpU02EEACDpfMaLjEESgcrepc=;
        b=DnnOoSoK2AhVhQBp/Ch2lYXVTR7ui4LvICzoHKNz4sAnqC0sYU/1QnVYTwh8lVheLa
         SOMreBchmy6gq5boDFswK5fLTpE3BIPhA4HE3oAYAe2EyroMSR0EQ9D023dGU+HlEPOn
         ascKLRTN+V0/2aMCpOO14noYbzT6jMaA2zsUs8oxtlUpZECLih0Nr8SixehhZYYcK9rK
         yaE3IeSeL43BFP7rY5YbrfwiCqpq3J7M6v51DUtrp1IloZgld2lAdAe5pa8xwwast+c5
         kBdTiyrvrAIlWOFwh+OrxbO0+vsGjC3cgWMD7HES4Qf2cvE+FkG8HmGTtvtdfRWMgIOZ
         uFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xErnWFgaDg+HEqwln9TpU02EEACDpfMaLjEESgcrepc=;
        b=p5h9htx8wUh1dIxDvXSnHFSV4tSgQ4B7LDAixXmgD0pOqeDh6S2PIDf5fZGvmA07Bf
         CjsvBT3L3XgVzCe38wHUuAAQonUQf4zqMxyrx3z4IBo0+dKj6NDuoAh+a3oLxbO/wjd9
         VVGJUaIM9JLE8mbuHzDGENR1oqc+L1/WiMuJERMKjlybek/Qjck708od1ujMJL/BaGH0
         95MvhFX5+7Cvf1fNs9ArjmhOhvF7fVcVApZuWrOkqPBFTZZ6WnE6ZVxSwlIyPT1ghuqz
         +1NZr4NQLF5UvJrXXuycgYErjCQRnJc6o61DoxTg9NVWy8hj+0gTDBjGHzF8fU27oT9a
         hbiw==
X-Gm-Message-State: ACrzQf1mJwKtVWVwF/hJj9sikOHMzw0cJdHdUaFL9k7sLASXg7l3Q2VY
        Yrf8ydBdAP+cwFvdp1jownTCCw==
X-Google-Smtp-Source: AMsMyM5duokxV3j72AD+s51mhGdvgvu5dn5e7ybRmwDvcGdv24bieBhGb5F6sULHYJrafLR9/yIy0g==
X-Received: by 2002:a5d:6e8e:0:b0:220:5fa1:d508 with SMTP id k14-20020a5d6e8e000000b002205fa1d508mr9151987wrz.337.1667234849903;
        Mon, 31 Oct 2022 09:47:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b003b4868eb71bsm7488871wmo.25.2022.10.31.09.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:47:29 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 31 Oct 2022 17:47:26 +0100
Subject: [PATCH 2/4] power: reset: add Odroid Go Ultra poweroff driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221031-b4-odroid-go-ultra-initial-v1-2-42e3dbea86d5@linaro.org>
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
In-Reply-To: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
to its two PMICs in order, this represents the poweroff scheme needed to complete
a clean poweroff of the system.

This implement this scheme, and overrides the PSCI pm_power_off.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/power/reset/Kconfig                    |   7 ++
 drivers/power/reset/Makefile                   |   1 +
 drivers/power/reset/odroid-go-ultra-poweroff.c | 122 +++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a8c46ba5878f..26860c2e05a9 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -141,6 +141,13 @@ config POWER_RESET_OCELOT_RESET
 	help
 	  This driver supports restart for Microsemi Ocelot SoC and similar.
 
+config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
+	bool "Odroid Go Ultra power-off driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on MFD_RK808
+	help
+	  This driver supports Power off for Odroid Go Ultra device.
+
 config POWER_RESET_OXNAS
 	bool "OXNAS SoC restart driver"
 	depends on ARCH_OXNAS
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0a39424fc558..d763e6735ee3 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_POWER_RESET_MT6323) += mt6323-poweroff.o
 obj-$(CONFIG_POWER_RESET_OXNAS) += oxnas-restart.o
 obj-$(CONFIG_POWER_RESET_QCOM_PON) += qcom-pon.o
 obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
+obj-$(CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF) += odroid-go-ultra-poweroff.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
diff --git a/drivers/power/reset/odroid-go-ultra-poweroff.c b/drivers/power/reset/odroid-go-ultra-poweroff.c
new file mode 100644
index 000000000000..89ae21790f65
--- /dev/null
+++ b/drivers/power/reset/odroid-go-ultra-poweroff.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2022 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/mfd/rk808.h>
+#include <linux/regmap.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+
+static struct rk808 *rk817;
+static struct rk808 *rk818;
+
+static void odroid_go_ultra_do_poweroff(void)
+{
+	int ret;
+
+	BUG_ON(!rk817);
+	BUG_ON(!rk818);
+
+	/* RK817 */
+	ret = regmap_update_bits(rk817->regmap, RK817_SYS_CFG(3), DEV_OFF, DEV_OFF);
+	if (ret)
+		pr_err("%s: failed to poweroff rk817\n", __func__);
+
+	/* RK818 */
+	ret = regmap_update_bits(rk818->regmap, RK818_DEVCTRL_REG, DEV_OFF, DEV_OFF);
+	if (ret)
+		pr_err("%s: failed to poweroff rk817\n", __func__);
+
+	WARN_ON(1);
+}
+
+static int odroid_go_ultra_poweroff_get_pmic_drvdata(struct platform_device *pdev,
+						     const char *property,
+						     struct rk808 **pmic)
+{
+	struct device_node *pmic_node;
+	struct i2c_client *pmic_client;
+
+	pmic_node = of_parse_phandle(pdev->dev.of_node, property, 0);
+	if (!pmic_node)
+		return -ENODEV;
+
+	pmic_client = of_find_i2c_device_by_node(pmic_node);
+	of_node_put(pmic_node);
+	if (!pmic_client)
+		return -EPROBE_DEFER;
+
+	*pmic = i2c_get_clientdata(pmic_client);
+
+	put_device(&pmic_client->dev);
+
+	if (!*pmic)
+		return -EPROBE_DEFER;
+
+	return 0;
+}
+
+static int odroid_go_ultra_poweroff_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	/* RK818 */
+	ret = odroid_go_ultra_poweroff_get_pmic_drvdata(pdev, "hardkernel,rk818-pmic", &rk818);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get rk818 mfd data (%d)\n", ret);
+		return ret;
+	}
+
+	/* RK817 */
+	ret = odroid_go_ultra_poweroff_get_pmic_drvdata(pdev, "hardkernel,rk817-pmic", &rk817);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get rk817 mfd data (%d)\n", ret);
+		return ret;
+	}
+
+	/* If a pm_power_off function has already been added, warn we're overriding */
+	if (pm_power_off != NULL)
+		dev_warn(&pdev->dev,
+			"%s: pm_power_off function already registered, overriding\n",
+		       __func__);
+
+	pm_power_off = odroid_go_ultra_do_poweroff;
+
+	return 0;
+}
+
+static int odroid_go_ultra_poweroff_remove(struct platform_device *pdev)
+{
+	if (pm_power_off == &odroid_go_ultra_do_poweroff)
+		pm_power_off = NULL;
+
+	rk817 = NULL;
+	rk818 = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id of_odroid_go_ultra_poweroff_match[] = {
+	{ .compatible = "hardkernel,odroid-go-ultra-poweroff", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_odroid_go_ultra_poweroff_match);
+
+static struct platform_driver odroid_go_ultra_poweroff_driver = {
+	.probe = odroid_go_ultra_poweroff_probe,
+	.remove = odroid_go_ultra_poweroff_remove,
+	.driver = {
+		.name = "odroid-go-ultra-poweroff",
+		.of_match_table = of_odroid_go_ultra_poweroff_match,
+	},
+};
+
+module_platform_driver(odroid_go_ultra_poweroff_driver);
+
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
+MODULE_DESCRIPTION("Odroid Go Ultra poweroff driver");
+MODULE_LICENSE("GPL");

-- 
b4 0.10.1
