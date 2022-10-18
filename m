Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813FF602327
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiJREH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiJREHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:07:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22509836B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:06:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so12885701pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGEPFSeXmgpP6SWnZ8TkpKloKbdyMgANiLcpHmAJx4M=;
        b=cvo2jRMsyz+5GGoQ6WG1fRMx8JJJvCkjG+lg2CrK1DHPyYMUgiRl3+jilDsNafegQQ
         4T15vmi/rjJmZcIyjIdf+0Czaqf/xFQ57a1DOvTms8sd9+OIWy6BSMK1caSof/44kehX
         +qBEnOT1hQzlzinV8sMPvw13Ug81Q4YBxBC7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGEPFSeXmgpP6SWnZ8TkpKloKbdyMgANiLcpHmAJx4M=;
        b=pcnRkUkXprDOHdIp3aZqpHzwSfpHcuytGQAVyXoJyRKE5AoIsjScHrLH/WiUARMVxD
         1xtz4t9VOJgJG5N5GBycPhib49U63Prbr4WXJnS1lswDeXqJVuvYUEnpTAzMBX2hWLWm
         DjvuM8upxqpRr45WyvBT6KSjXmfJhN9h3zqGxvA8cQbIpYlKAgIRVHCfuD+uEg88z+gt
         x+wkKoDnofF0yATsL4lTaO6ciUs+WULT30M46UezxkgaCijkFuQMDB0URUHwBO/oARSD
         xQhaHbl/Dv6giypCQg/rm3eRB4TXvRo2Jvnxs9hc2pHSRbRBIK9vY0oXIJFJtDaiYvtu
         aLug==
X-Gm-Message-State: ACrzQf0Hi3LEN+f/zsIBuxty0vXzWfQ3eooO6E4M21SVRBBs0MG6ltV8
        eEeHB+tl44oiw3SNQ2c9TvugMWvQ3cgSOg==
X-Google-Smtp-Source: AMsMyM4VtBShS3EURV1xWvmsMb9dsVOv3Q1ReUl8wGlQbEvWAwaqdtCOulj5UrlhsQZ+AP4H5kHxyw==
X-Received: by 2002:a17:90a:f8f:b0:20a:302f:92b8 with SMTP id 15-20020a17090a0f8f00b0020a302f92b8mr1333128pjz.80.1666065998031;
        Mon, 17 Oct 2022 21:06:38 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a415:a8ca:5b46:9ad2])
        by smtp.gmail.com with UTF8SMTPSA id z15-20020a17090a170f00b002009db534d1sm6973490pjd.24.2022.10.17.21.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 21:06:37 -0700 (PDT)
From:   Dan Callaghan <dcallagh@chromium.org>
To:     chrome-platform@lists.linux.dev
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Dan Callaghan <dcallagh@chromium.org>
Subject: [PATCH v6] platform/chrome: add a driver for HPS
Date:   Tue, 18 Oct 2022 15:06:23 +1100
Message-Id: <20221018040623.2173441-1-dcallagh@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a driver for the ChromeOS human presence
sensor (aka. HPS). The driver supports a sensor connected to the I2C bus
and identified as "GOOG0020" in the ACPI tables.

When loaded, the driver exports the sensor to userspace through a
character device. This device only supports power management, i.e.,
communication with the sensor must be done through regular I2C
transmissions from userspace.

Power management is implemented by enabling the respective power GPIO
while at least one userspace process holds an open fd on the character
device. By default, the device is powered down if there are no active
clients.

Note that the driver makes no effort to preserve the state of the sensor
between power down and power up events. Userspace is responsible for
reinitializing any needed state once power has been restored.

The device firmware, I2C protocol and other documentation is available
at https://chromium.googlesource.com/chromiumos/platform/hps-firmware.

Co-developed-by: Sami Kyöstilä <skyostil@chromium.org>
Signed-off-by: Sami Kyöstilä <skyostil@chromium.org>
Signed-off-by: Dan Callaghan <dcallagh@chromium.org>
---
Changes in v6:
- Added comments to clarify power enable/disable behaviour.
- Minor cleanups.

Changes in v5:
- Updated MAINTAINERS.

Changes in v4:
- Simplified open/release pm logic.
- Renamed device to "cros-hps".
- Stylistics cleanups.

Changes in v3:
- Moved from drivers/misc to drivers/platform/chrome.

Changes in v2:
- Removed custom ioctl interface.
- Reworked to use miscdev.

 MAINTAINERS                            |   6 +
 drivers/platform/chrome/Kconfig        |  10 ++
 drivers/platform/chrome/Makefile       |   1 +
 drivers/platform/chrome/cros_hps_i2c.c | 162 +++++++++++++++++++++++++
 4 files changed, 179 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_hps_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..4002d61291ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4936,6 +4936,12 @@ S:	Maintained
 F:	drivers/platform/chrome/cros_usbpd_notify.c
 F:	include/linux/platform_data/cros_usbpd_notify.h
 
+CHROMEOS HPS DRIVER
+M:	Dan Callaghan <dcallagh@chromium.org>
+R:	Sami Kyöstilä <skyostil@chromium.org>
+S:	Maintained
+F:	drivers/platform/chrome/cros_hps_i2c.c
+
 CHRONTEL CH7322 CEC DRIVER
 M:	Joe Tessler <jrt@google.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 6b954c5acadb..c1ca247987d2 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -228,6 +228,16 @@ config CROS_EC_TYPEC
 	  To compile this driver as a module, choose M here: the module will be
 	  called cros_ec_typec.
 
+config CROS_HPS_I2C
+	tristate "ChromeOS HPS device"
+	depends on HID && I2C && PM
+	help
+	  Say Y here if you want to enable support for the ChromeOS
+	  human presence sensor (HPS), attached via I2C. The driver supports a
+	  sensor connected to the I2C bus and exposes it as a character device.
+	  To save power, the sensor is automatically powered down when no
+	  clients are accessing it.
+
 config CROS_USBPD_LOGGER
 	tristate "Logging driver for USB PD charger"
 	depends on CHARGER_CROS_USBPD
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 2950610101f1..f6068d077a40 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
 cros-ec-sensorhub-objs			:= cros_ec_sensorhub.o cros_ec_sensorhub_ring.o
 obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros-ec-sensorhub.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
+obj-$(CONFIG_CROS_HPS_I2C)		+= cros_hps_i2c.o
 obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
 obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
 
diff --git a/drivers/platform/chrome/cros_hps_i2c.c b/drivers/platform/chrome/cros_hps_i2c.c
new file mode 100644
index 000000000000..92da59d94745
--- /dev/null
+++ b/drivers/platform/chrome/cros_hps_i2c.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the ChromeOS human presence sensor (HPS), attached via I2C.
+ *
+ * The driver exposes HPS as a character device, although currently no read or
+ * write operations are supported. Instead, the driver only controls the power
+ * state of the sensor, keeping it on only while userspace holds an open file
+ * descriptor to the HPS device.
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include <linux/acpi.h>
+#include <linux/fs.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+
+#define HPS_ACPI_ID		"GOOG0020"
+
+struct hps_drvdata {
+	struct i2c_client *client;
+	struct miscdevice misc_device;
+	struct gpio_desc *enable_gpio;
+};
+
+static void hps_set_power(struct hps_drvdata *hps, bool state)
+{
+	gpiod_set_value_cansleep(hps->enable_gpio, state);
+}
+
+static int hps_open(struct inode *inode, struct file *file)
+{
+	struct hps_drvdata *hps = container_of(file->private_data,
+					       struct hps_drvdata, misc_device);
+	struct device *dev = &hps->client->dev;
+
+	return pm_runtime_resume_and_get(dev);
+}
+
+static int hps_release(struct inode *inode, struct file *file)
+{
+	struct hps_drvdata *hps = container_of(file->private_data,
+					       struct hps_drvdata, misc_device);
+	struct device *dev = &hps->client->dev;
+
+	return pm_runtime_put(dev);
+}
+
+static const struct file_operations hps_fops = {
+	.owner = THIS_MODULE,
+	.open = hps_open,
+	.release = hps_release,
+};
+
+static int hps_i2c_probe(struct i2c_client *client)
+{
+	struct hps_drvdata *hps;
+	int ret;
+
+	hps = devm_kzalloc(&client->dev, sizeof(*hps), GFP_KERNEL);
+	if (!hps)
+		return -ENOMEM;
+
+	hps->misc_device.parent = &client->dev;
+	hps->misc_device.minor = MISC_DYNAMIC_MINOR;
+	hps->misc_device.name = "cros-hps";
+	hps->misc_device.fops = &hps_fops;
+
+	i2c_set_clientdata(client, hps);
+	hps->client = client;
+
+	/*
+	 * HPS is powered on from firmware before entering the kernel, so we
+	 * acquire the line with GPIOD_OUT_HIGH here to preserve the existing
+	 * state. The peripheral is powered off after successful probe below.
+	 */
+	hps->enable_gpio = devm_gpiod_get(&client->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(hps->enable_gpio)) {
+		ret = PTR_ERR(hps->enable_gpio);
+		dev_err(&client->dev, "failed to get enable gpio: %d\n", ret);
+		return ret;
+	}
+
+	ret = misc_register(&hps->misc_device);
+	if (ret) {
+		dev_err(&client->dev, "failed to initialize misc device: %d\n", ret);
+		return ret;
+	}
+
+	hps_set_power(hps, false);
+	pm_runtime_enable(&client->dev);
+	return 0;
+}
+
+static int hps_i2c_remove(struct i2c_client *client)
+{
+	struct hps_drvdata *hps = i2c_get_clientdata(client);
+
+	pm_runtime_disable(&client->dev);
+	misc_deregister(&hps->misc_device);
+
+	/*
+	 * Re-enable HPS, in order to return it to its default state
+	 * (i.e. powered on).
+	 */
+	hps_set_power(hps, true);
+
+	return 0;
+}
+
+static int hps_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hps_drvdata *hps = i2c_get_clientdata(client);
+
+	hps_set_power(hps, false);
+	return 0;
+}
+
+static int hps_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hps_drvdata *hps = i2c_get_clientdata(client);
+
+	hps_set_power(hps, true);
+	return 0;
+}
+static UNIVERSAL_DEV_PM_OPS(hps_pm_ops, hps_suspend, hps_resume, NULL);
+
+static const struct i2c_device_id hps_i2c_id[] = {
+	{ "cros-hps", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, hps_i2c_id);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id hps_acpi_id[] = {
+	{ HPS_ACPI_ID, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, hps_acpi_id);
+#endif /* CONFIG_ACPI */
+
+static struct i2c_driver hps_i2c_driver = {
+	.probe_new = hps_i2c_probe,
+	.remove = hps_i2c_remove,
+	.id_table = hps_i2c_id,
+	.driver = {
+		.name = "cros-hps",
+		.pm = &hps_pm_ops,
+		.acpi_match_table = ACPI_PTR(hps_acpi_id),
+	},
+};
+module_i2c_driver(hps_i2c_driver);
+
+MODULE_ALIAS("acpi:" HPS_ACPI_ID);
+MODULE_AUTHOR("Sami Kyöstilä <skyostil@chromium.org>");
+MODULE_DESCRIPTION("Driver for ChromeOS HPS");
+MODULE_LICENSE("GPL");

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.38.0.413.g74048e4d9e-goog

