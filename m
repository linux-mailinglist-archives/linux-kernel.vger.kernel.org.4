Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B016969EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjBNQlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjBNQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:41:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F00E2BF2A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:41:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso14103427wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=30SyWhHcXeQCmwLuKz2hroahSQOV1hg9TM2IX1B5XYM=;
        b=NLRoxDC/X3OQcw1AUFUitV0lw8OBtSVP028kbRsqfwUQNnGDGW4xMUewYmQl3vaRDW
         heYkrs9ziTDrKSntcIvDoEWhVySmf4AAHqeXLDjuPlHIVI2IGaVKQJPh/IWqggKHCihX
         xJXOnZYOz4Bko+li2gyxdQvuLs0SGH9TAxUA/I4Dgmsgmt7caQKPWeekQDEmwjZEO1yE
         aJ711SrbHJguyD7KtnJ9RNT7KgU0DCfsmTb5FpF8kwj4s+yaoLEf9Sh/6f8cMu59+gWf
         qFmWivGuqc+AZ1UL5CUOx97SHsdsZsDGFSjBqZsDdwfM7pQSH7JhAIJ8F5ib95PIyDRC
         j1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30SyWhHcXeQCmwLuKz2hroahSQOV1hg9TM2IX1B5XYM=;
        b=mNaUTT2hHaqLBFt0ogsw+ZtVQ0PpP21lBQZ3KnLc7PIcNg1c9Vu7yy72bG2kmTbQDS
         B09Ry3A4bqVi9whh8PrU8yT8MFAJnQshmiOJdX8hVUYV4+dl0cFhsI9kn6qNGDQX0fXC
         xJFOPHYszeFezjBoIix+AjyWwIGJykQkCJY41UXXzIN0eoPxfetkTXAZkf/P8f2xPJW2
         HiaM/yAL2phZQSdPU/ZZft6nbcgCdN3Y9mc7xx8aJY/MJvE7U5MbxBgCjVwG7fq1uV0z
         PrU99NbMh16DLY9fvOvTc6bu97NMp5NiDdi2C1RLbkPcnfSB9DIC5QhB9ZD5nxt6gTS7
         rBxA==
X-Gm-Message-State: AO0yUKUAkpAIblQVUmqZhqab4eeRmkxQpQzZ4Y/vOTRV54620MTA5UjZ
        r3I7HlL13BU5WVa7EFP7f0AJtw==
X-Google-Smtp-Source: AK7set9tWFGWqjp93dl8Si0fD9QUPlDhi7r+5Dn5r8ciUlQO/1PqNvT//Wl+KhWphviMxSMdtOOhNQ==
X-Received: by 2002:a05:600c:448a:b0:3dc:5a13:c7d1 with SMTP id e10-20020a05600c448a00b003dc5a13c7d1mr2515688wmo.16.1676392881054;
        Tue, 14 Feb 2023 08:41:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm20785505wmm.40.2023.02.14.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:41:20 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 14 Feb 2023 17:41:18 +0100
Subject: [PATCH v4] power: reset: add Odroid Go Ultra poweroff driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-b4-odroid-go-ultra-poweroff-v4-1-979efb6eb3fb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAK2562MC/5XOzQ6CMBAE4FcxPbsGWkD05HsYD9s/aEK6ZIuoM
 by7hZs3Pc4cvpm3SI6DS+K8ewt2c0iBYg7VfidMj7FzEGzOQhZSFaVsQFdAlilY6Ajuw8QIIz0
 ck/dgWm8NnpRXTossaEwONGM0fTbifRhyObLz4blNXm859yFNxK/twSzX9rexWUIJ2Jq6aJvGV
 2guQ4jIdCDuxArP6g9MZazAo7fK1qbS6gtbluUDaMYkFykBAAA=
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
to its two PMICs in order, this represents the poweroff scheme needed to complete
a clean poweroff of the system.

This implement this scheme by implementing a self registering driver to permit
using probe defer until both pmics are finally probed.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Previous submission was at [1], but I converted it to an independent
platform device with device auto registration to permit waiting for
both the PMICs drivers to probe.

[1] https://lore.kernel.org/all/20221031-b4-odroid-go-ultra-initial-v1-2-42e3dbea86d5@linaro.org/
---
Changes in v4:
- handle pmic struct device removal by devm_add_action_or_reset()
- add dependency on I2C for of_find_i2c_device_by_node() after kernel test robot reports
- Link to v3: https://lore.kernel.org/r/20230126-b4-odroid-go-ultra-poweroff-v3-1-0a7fd3d5c4b3@linaro.org

Changes in v3:
- Removed dependency with rk08
- Switched to storing struct device of pmics
- Fixed module init/exit
- Link to v2: https://lore.kernel.org/r/20230126-b4-odroid-go-ultra-poweroff-v2-1-a8c50866f4ac@linaro.org

Changes in v2:
- Switched to devm_register_sys_off_handler()
- Link to v1: https://lore.kernel.org/r/20221031-b4-odroid-go-ultra-initial-v1-2-42e3dbea86d5@linaro.org
---
 drivers/power/reset/Kconfig                    |   7 +
 drivers/power/reset/Makefile                   |   1 +
 drivers/power/reset/odroid-go-ultra-poweroff.c | 177 +++++++++++++++++++++++++
 3 files changed, 185 insertions(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a8c46ba5878f..7059bd1f2ee7 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -141,6 +141,13 @@ config POWER_RESET_OCELOT_RESET
 	help
 	  This driver supports restart for Microsemi Ocelot SoC and similar.
 
+config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
+	bool "Odroid Go Ultra power-off driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on I2C && OF
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
index 000000000000..f46271da4e8e
--- /dev/null
+++ b/drivers/power/reset/odroid-go-ultra-poweroff.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/mfd/rk808.h>
+#include <linux/regmap.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/i2c.h>
+
+/*
+ * The Odroid Go Ultra has 2 PMICs:
+ * - RK818 (manages the battery and USB-C power supply)
+ * - RK817
+ * Both PMICs feeds power to the S922X SoC, so they must be powered-off in sequence.
+ * Vendor does power-off the RK817 first, then the RK818 so here we follow this sequence.
+ */
+
+struct odroid_go_ultra_poweroff_data {
+	struct device *dev;
+	struct device *rk817;
+	struct device *rk818;
+};
+
+static int odroid_go_ultra_poweroff_prepare(struct sys_off_data *data)
+{
+	struct odroid_go_ultra_poweroff_data *poweroff_data = data->cb_data;
+	struct regmap *rk817, *rk818;
+	int ret;
+
+	/* RK817 Regmap */
+	rk817 = dev_get_regmap(poweroff_data->rk817, NULL);
+	if (!rk817) {
+		dev_err(poweroff_data->dev, "failed to get rk817 regmap\n");
+		return notifier_from_errno(-EINVAL);
+	}
+
+	/* RK818 Regmap */
+	rk818 = dev_get_regmap(poweroff_data->rk818, NULL);
+	if (!rk818) {
+		dev_err(poweroff_data->dev, "failed to get rk818 regmap\n");
+		return notifier_from_errno(-EINVAL);
+	}
+
+	dev_info(poweroff_data->dev, "Setting PMICs for power off");
+
+	/* RK817 */
+	ret = regmap_update_bits(rk817, RK817_SYS_CFG(3), DEV_OFF, DEV_OFF);
+	if (ret) {
+		dev_err(poweroff_data->dev, "failed to poweroff rk817\n");
+		return notifier_from_errno(ret);
+	}
+
+	/* RK818 */
+	ret = regmap_update_bits(rk818, RK818_DEVCTRL_REG, DEV_OFF, DEV_OFF);
+	if (ret) {
+		dev_err(poweroff_data->dev, "failed to poweroff rk818\n");
+		return notifier_from_errno(ret);
+	}
+
+	return NOTIFY_OK;
+}
+
+static void odroid_go_ultra_poweroff_put_pmic_device(void *data)
+{
+	struct device *dev = data;
+
+	put_device(dev);
+}
+
+static int odroid_go_ultra_poweroff_get_pmic_device(struct device *dev, const char *compatible,
+						    struct device **pmic)
+{
+	struct device_node *pmic_node;
+	struct i2c_client *pmic_client;
+
+	pmic_node = of_find_compatible_node(NULL, NULL, compatible);
+	if (!pmic_node)
+		return -ENODEV;
+
+	pmic_client = of_find_i2c_device_by_node(pmic_node);
+	of_node_put(pmic_node);
+	if (!pmic_client)
+		return -EPROBE_DEFER;
+
+	*pmic = &pmic_client->dev;
+
+	return devm_add_action_or_reset(dev, odroid_go_ultra_poweroff_put_pmic_device, *pmic);
+}
+
+static int odroid_go_ultra_poweroff_probe(struct platform_device *pdev)
+{
+	struct odroid_go_ultra_poweroff_data *poweroff_data;
+	int ret;
+
+	poweroff_data = devm_kzalloc(&pdev->dev, sizeof(*poweroff_data), GFP_KERNEL);
+	if (!poweroff_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, poweroff_data);
+
+	/* RK818 PMIC Device */
+	ret = odroid_go_ultra_poweroff_get_pmic_device(&pdev->dev, "rockchip,rk818",
+						       &poweroff_data->rk818);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to get rk818 mfd data\n");
+
+	/* RK817 PMIC Device */
+	ret = odroid_go_ultra_poweroff_get_pmic_device(&pdev->dev, "rockchip,rk817",
+						       &poweroff_data->rk817);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to get rk817 mfd data\n");
+
+	/* Register as SYS_OFF_MODE_POWER_OFF_PREPARE because regmap_update_bits may sleep */
+	ret = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_POWER_OFF_PREPARE,
+					    SYS_OFF_PRIO_DEFAULT,
+					    odroid_go_ultra_poweroff_prepare,
+					    poweroff_data);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register sys-off handler\n");
+
+	dev_info(&pdev->dev, "Registered Power-Off handler\n");
+
+	return 0;
+}
+static struct platform_device *pdev;
+
+static struct platform_driver odroid_go_ultra_poweroff_driver = {
+	.driver = {
+		.name	= "odroid-go-ultra-poweroff",
+	},
+	.probe = odroid_go_ultra_poweroff_probe,
+};
+
+static int __init odroid_go_ultra_poweroff_init(void)
+{
+	int ret;
+
+	/* Only create when running on the Odroid Go Ultra device */
+	if (!of_device_is_compatible(of_root, "hardkernel,odroid-go-ultra"))
+		return -ENODEV;
+
+	ret = platform_driver_register(&odroid_go_ultra_poweroff_driver);
+	if (ret)
+		return ret;
+
+	pdev = platform_device_register_resndata(NULL, "odroid-go-ultra-poweroff", -1,
+						 NULL, 0, NULL, 0);
+
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&odroid_go_ultra_poweroff_driver);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+
+static void __exit odroid_go_ultra_poweroff_exit(void)
+{
+	/* Only delete when running on the Odroid Go Ultra device */
+	if (!of_device_is_compatible(of_root, "hardkernel,odroid-go-ultra"))
+		return;
+
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&odroid_go_ultra_poweroff_driver);
+}
+
+module_init(odroid_go_ultra_poweroff_init);
+module_exit(odroid_go_ultra_poweroff_exit);
+
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
+MODULE_DESCRIPTION("Odroid Go Ultra poweroff driver");
+MODULE_LICENSE("GPL");

---
base-commit: 38d2b86a665b5e86371a1a30228bce259aa6c101
change-id: 20230126-b4-odroid-go-ultra-poweroff-c8fdca93f3eb

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

