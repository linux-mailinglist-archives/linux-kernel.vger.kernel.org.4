Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C60267D2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjAZRLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjAZRLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:11:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2486536E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:11:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so2433137wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2pHKQJWH1KmYh2TGTU2wH9BfmH0u+CHZy41N/emBPgk=;
        b=w24l95Uz6BBmWmGf88j0Gi82dTVQBE+FS0LpyNo+Vt5fHlmZEKu3/cQuOx7+V2CnAV
         A6fNrol+i/YH+LKUsZU+E7qCRqio2lATUDapOCd/fk9/zFiXiXcAHApKgWy6ydP+ibNM
         TDKYTFd9WXvvgvYrqRNGAf9d3W7pVl8pBhwIiBtRcm9eFjkmNq620XBOVM0C29u+zHwc
         D0WEC/5JQ5d24OYtq4VTgEBKFiv1YBF4WeEd3mXxi6+qQHJkX0lAHYn2KGUaBuhdjUGS
         U8Pm9GM+wGxohk4CyWHKmanCLhtw+B6z/vXqNkwJzSsQpzLbQJKa/f3rOCfHYO0otHB3
         lzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pHKQJWH1KmYh2TGTU2wH9BfmH0u+CHZy41N/emBPgk=;
        b=GYwkhTgpkKCtSCRTNm5Z5eGXh22Srj/dfoYWq//gjpaZEdf4EpTZU3HkcVzsusI/9V
         Zmj9Xd8gS90ueCrwkB2OCXVcI8t7pl3g0MLPhU3Xg5bTwJ2j1KFetJsjlwbzsX3KuEM8
         WPANJ2balhBoJthdNV3zig1Q35lWfGwIJ2s/xmW2SNDpw9nf+qnJ99jD7MmNvhSQtwQ/
         7DQTsokX5V3iBLBARNmRBRZ4YRhQJRlGM6fDF7SN+2fV8yBNrlWE4tcljkB0DHCXsnp/
         F913QSzFkDY2C2FPcJKNCITV1Ybd8Z3IWPY0wl6uvPxs7aX9umrHzol8Vl2F5m1sJhf0
         QLZQ==
X-Gm-Message-State: AFqh2kqrGS3x96aoX/alaVw+PIKkl9uhbgRf4IpCJKun8hHD5dMDQUxY
        LNH9PgsG4iqf22oNbE0ncSXErtunEdr4Ji+t1Fs=
X-Google-Smtp-Source: AMrXdXurdgjmMvj6kxwr5UCaP/4FD4WnkTDZtww2X0SCWt/zdnMlwB/liKai/m1BDKy/JKcJdXnTHg==
X-Received: by 2002:adf:df02:0:b0:2bd:db66:54eb with SMTP id y2-20020adfdf02000000b002bddb6654ebmr40272833wrl.20.1674753086710;
        Thu, 26 Jan 2023 09:11:26 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f12-20020adfdb4c000000b002bfb1de74absm1903884wrj.114.2023.01.26.09.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:11:26 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 26 Jan 2023 18:11:21 +0100
Subject: [PATCH v2] power: reset: add Odroid Go Ultra poweroff driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-b4-odroid-go-ultra-poweroff-v2-1-a8c50866f4ac@linaro.org>
X-B4-Tracking: v=1; b=H4sIADi00mMC/x2NQQrCMBAAv1L27EJNRNSviIdNsmkXQrZsbBVK/
 27wOHOY2aGxCTd4DDsYb9JEawd3GiDOVCdGSZ3Bjc6PZ3fFcEFNppJwUlzL2wgX/bBpzhhvOUW
 6++w5QC8EaozBqMa5N+paSpeLcZbvf/l8HccPSlXVYYIAAAA=
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
Changes in v2:
- Switched to devm_register_sys_off_handler()
- Link to v1: https://lore.kernel.org/r/20221031-b4-odroid-go-ultra-initial-v1-2-42e3dbea86d5@linaro.org
---
 drivers/power/reset/Kconfig                    |   7 ++
 drivers/power/reset/Makefile                   |   1 +
 drivers/power/reset/odroid-go-ultra-poweroff.c | 151 +++++++++++++++++++++++++
 3 files changed, 159 insertions(+)

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
index 000000000000..51f54e65c927
--- /dev/null
+++ b/drivers/power/reset/odroid-go-ultra-poweroff.c
@@ -0,0 +1,151 @@
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
+	struct rk808 *rk817;
+	struct rk808 *rk818;
+};
+
+static int odroid_go_ultra_poweroff_prepare(struct sys_off_data *data)
+{
+	struct odroid_go_ultra_poweroff_data *poweroff_data = data->cb_data;
+	int ret;
+
+	dev_info(poweroff_data->dev, "Setting PMICs for power off");
+
+	/* RK817 */
+	ret = regmap_update_bits(poweroff_data->rk817->regmap, RK817_SYS_CFG(3), DEV_OFF, DEV_OFF);
+	if (ret) {
+		dev_err(poweroff_data->dev, "failed to poweroff rk817\n");
+		return notifier_from_errno(ret);
+	}
+
+	/* RK818 */
+	ret = regmap_update_bits(poweroff_data->rk818->regmap, RK818_DEVCTRL_REG, DEV_OFF, DEV_OFF);
+	if (ret) {
+		dev_err(poweroff_data->dev, "failed to poweroff rk818\n");
+		return notifier_from_errno(ret);
+	}
+
+	return NOTIFY_OK;
+}
+
+static int odroid_go_ultra_poweroff_get_pmic_drvdata(const char *compatible, struct rk808 **pmic)
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
+	struct odroid_go_ultra_poweroff_data *poweroff_data;
+	int ret;
+
+	poweroff_data = devm_kzalloc(&pdev->dev, sizeof(*poweroff_data), GFP_KERNEL);
+	if (!poweroff_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, poweroff_data);
+
+	/* RK818 */
+	ret = odroid_go_ultra_poweroff_get_pmic_drvdata("rockchip,rk818",
+							&poweroff_data->rk818);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to get rk818 mfd data\n");
+
+	/* RK817 */
+	ret = odroid_go_ultra_poweroff_get_pmic_drvdata("rockchip,rk817",
+							&poweroff_data->rk817);
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
+
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
+	return PTR_ERR_OR_ZERO(pdev);
+}
+
+static void __exit odroid_go_ultra_poweroff_exit(void)
+{
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
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230126-b4-odroid-go-ultra-poweroff-c8fdca93f3eb

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

