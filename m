Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9405F56F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJEO6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiJEO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:58:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CE7D1F1;
        Wed,  5 Oct 2022 07:58:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a2so15927472ejx.10;
        Wed, 05 Oct 2022 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=etL2ksIlrrnJJ1KEHn1go3jBhV9FQX3PGBEX2c5GfSI=;
        b=jQ4mkneT5oTogfVdED0WyJA99zvHPfgOnvlVgW6LrBQEprGwjLEKV5HyxtPdnElIdw
         kO6uh3qQ67NgeCOJKOLkOo1qx5OEneDYHZM2xK7cVwNFXqTdzohwxD4QQJb3O/kyvw/A
         aw9rWiqPtsErwNAoMyS8FzbSmUS311WysO3f22ovd2L//NS8Qv6DfnuYlyIfpJXTK6Te
         BANP7TcQUNkWsv+XtXKx3KseghqkLMA1ABDBIaeGGpMWuk6MIyIh+Vbij53KnamK2TUU
         gVP9GReqiw+JOuQVEkB9ugZf1jBJwZxB06JFWZKfHOIA4WEAHzE4JM1XgstkBmt6k5Lf
         g7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=etL2ksIlrrnJJ1KEHn1go3jBhV9FQX3PGBEX2c5GfSI=;
        b=jZs0zNPR+ua6CSHw87FiKFEVu0n5A/y4f9HdXMunjjG5NYNuLYSYx8U2Vmssh7XUVN
         er39cRmFVNbgcz1lLG0EHwHszVm3dx+kaqNxbWHG24HhUWEw8Vz0NiuXo0ZTjFsJ5DMA
         EvmBjnsO3zTaJSQPFc8PfU2PLbKgSNWPVkJSuz2QXxSMgrEQuZbdtpQdPYdmuW4hj/bi
         V8CsghLDxH8trlr5DB1yK3w9GF4SAjf68DWuejdPeIKnrfWDM3Gvu7yMRS4CyVQeOMna
         5sarxEWD43NeqAaS3lPrisHH3rPfgAxzXUvyxyfbNkhp+TsCyImZ1lvh7QqDy0a31Urr
         /M4w==
X-Gm-Message-State: ACrzQf2ZsEGFRq3gAKJ4L5OJs+bNq6q8+EuJK7U6anHs9EGjcSI7+bZi
        NAyenAw/X7N/BsGzpconnow=
X-Google-Smtp-Source: AMsMyM40zfdZshyq3QUevHuMa7d9iPfVJBOZ1r9LcGWYVA/9Mri+D/cvHNV2VMINfmdO1uyKWjDoYw==
X-Received: by 2002:a17:907:1c9d:b0:782:fdeb:a9fc with SMTP id nb29-20020a1709071c9d00b00782fdeba9fcmr28929ejc.308.1664981883594;
        Wed, 05 Oct 2022 07:58:03 -0700 (PDT)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id m5-20020a50cc05000000b004588ef795easm4023941edi.34.2022.10.05.07.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:58:03 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        gregkh@linuxfoundation.org, jeffrey.l.hugo@gmail.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, saravanak@google.com,
        mani@kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [RFCv2 PATCH 2/4] bus: add Wiegand bus driver
Date:   Wed,  5 Oct 2022 16:57:44 +0200
Message-Id: <20221005145746.172138-2-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005145746.172138-1-m.zatovic1@gmail.com>
References: <20221005145746.172138-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The Wiegand bus driver spawns devices and matches them with
drivers.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
The bus driver currently assumes that any new Wiegand driver will
have a matching entry in the devicetree. It is currently sufficient
as I will only be implementing the GPIO driver. If someone
implements a Wiegand driver that will not use devicetree, he will
also have to edit this bus driver, in order to match properly. Is
that a correct approach?
---
 drivers/bus/Kconfig     |   6 +
 drivers/bus/Makefile    |   2 +
 drivers/bus/wiegand.c   | 339 ++++++++++++++++++++++++++++++++++++++++
 include/linux/wiegand.h | 110 +++++++++++++
 4 files changed, 457 insertions(+)
 create mode 100644 drivers/bus/wiegand.c
 create mode 100644 include/linux/wiegand.h

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 7bfe998f3514..9675f5a13ffb 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -241,6 +241,12 @@ config VEXPRESS_CONFIG
 	  Platform configuration infrastructure for the ARM Ltd.
 	  Versatile Express.
 
+config WIEGAND
+    tristate "Wiegand bus"
+    help
+      Wiegand Protocol is a low level 2-wire serial protocol. This
+      enables the support of the bus.
+
 config DA8XX_MSTPRI
 	bool "TI da8xx master peripheral priority driver"
 	depends on ARCH_DAVINCI_DA8XX
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index d90eed189a65..4a9fa6314e54 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -36,6 +36,8 @@ obj-$(CONFIG_TI_SYSC)		+= ti-sysc.o
 obj-$(CONFIG_TS_NBUS)		+= ts-nbus.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
+obj-$(CONFIG_WIEGAND)		+= wiegand.o
+
 
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
 
diff --git a/drivers/bus/wiegand.c b/drivers/bus/wiegand.c
new file mode 100644
index 000000000000..c76026d0c3b1
--- /dev/null
+++ b/drivers/bus/wiegand.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/wiegand.h>
+
+static const struct {
+	const char *name;
+	const char *desc;
+} wiegand_module_table[] = {
+	{ NULL,  NULL },
+	{ "wiegand-gpio", "Wiegand GPIO write-only master" },
+};
+
+int wiegand_gpio_calc_parity8(u8 v)
+{
+	v = (v >> 4) ^ (v & ((1 << 4)-1));
+	v = (v >> 2) ^ (v & ((1 << 2)-1));
+	v = (v >> 1) ^ (v & ((1 << 1)-1));
+	return v;
+}
+EXPORT_SYMBOL_GPL(wiegand_gpio_calc_parity8);
+
+void wiegand_gpio_add_parity_to_data(unsigned char *tmp, u8 *data,
+						enum wiegand_format fmt)
+{
+	switch (fmt) {
+	case WIEGAND_V26:
+		data[0] = (tmp[0] >> 1) | (wiegand_gpio_calc_parity8(
+						tmp[0] ^ (tmp[1] & 0xf0)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (!wiegand_gpio_calc_parity8(
+						(tmp[1] & 0x0f) ^ tmp[2]) << 6);
+		break;
+	case WIEGAND_V36:
+		tmp[4] &= 0xc0;
+
+		data[0] = (tmp[0] >> 1) | (wiegand_gpio_calc_parity8(
+				tmp[0] ^ tmp[1] ^ (tmp[2] & 0x80)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (tmp[3] >> 1);
+		data[4] = (tmp[3] << 7) | (tmp[4] >> 1) |
+			(!wiegand_gpio_calc_parity8(
+				(tmp[2] & 0x7f) ^ tmp[3] ^ tmp[4]) << 4);
+		break;
+	case WIEGAND_V37:
+		tmp[4] &= 0xe0;
+
+		data[0] = (tmp[0] >> 1) | (wiegand_gpio_calc_parity8(
+				tmp[0] ^ tmp[1] ^ (tmp[2] & 0xc0)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (tmp[3] >> 1);
+		data[4] = (tmp[3] << 7) | (tmp[4] >> 1) |
+				(!wiegand_gpio_calc_parity8(
+				(tmp[2] & 0x7f) ^ tmp[3] ^ tmp[4]) << 3);
+		break;
+	default:
+		WARN_ON(fmt != WIEGAND_V37 &&
+			fmt != WIEGAND_V36 &&
+			fmt != WIEGAND_V26);
+	}
+}
+EXPORT_SYMBOL_GPL(wiegand_gpio_add_parity_to_data);
+
+static inline bool wiegand_module_known(unsigned int id)
+{
+	return id >= WIEGAND_MODULE_FIRST && id <= WIEGAND_MODULE_LAST;
+}
+
+static inline const char *wiegand_module_name(unsigned int id)
+{
+	if (wiegand_module_known(id))
+		return wiegand_module_table[id].name;
+	else
+		return "unknown";
+}
+
+static int wiegand_match(struct device *dev, struct device_driver *drv)
+{
+	struct wiegand_device *wdev = to_wiegand_device(dev);
+	struct wiegand_driver *wdrv = to_wiegand_driver(drv);
+	const enum wiegand_module_id *t;
+
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	if (!wdrv->id_table)
+		return 0;
+
+	for (t = wdrv->id_table; *t; ++t)
+		if (*t == wdev->id)
+			return 1;
+
+	return 0;
+}
+
+static struct bus_type wiegand_bus_type = {
+	.name		= "wiegand",
+	.match		= wiegand_match,
+};
+
+int __wiegand_register_driver(struct module *owner,
+			     struct wiegand_driver *wdrv)
+{
+	wdrv->driver.owner = owner;
+	wdrv->driver.bus = &wiegand_bus_type;
+	return driver_register(&wdrv->driver);
+}
+EXPORT_SYMBOL_GPL(__wiegand_register_driver);
+
+static int wiegand_dev_check(struct device *dev, void *data)
+{
+	struct wiegand_device *wdev = to_wiegand_device(dev);
+	struct wiegand_device *new_dev = data;
+
+	if (wdev->wiegand == new_dev->wiegand && wdev->id == new_dev->id &&
+	    wdev->idx == new_dev->idx)
+		return -EBUSY;
+	return 0;
+}
+
+static void wiegand_dev_release(struct device *dev)
+{
+	struct wiegand_device *wdev = to_wiegand_device(dev);
+
+	put_device(wdev->wiegand->dev);
+	kfree(wdev);
+}
+
+static struct wiegand_device *
+wiegand_alloc_device(struct wiegand *wiegand)
+{
+	struct wiegand_device *dev;
+
+	if (!get_device(wiegand->dev))
+		return NULL;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		put_device(wiegand->dev);
+		return NULL;
+	}
+
+	dev->wiegand = wiegand;
+	dev->dev.parent = wiegand->dev;
+	dev->dev.bus = &wiegand_bus_type;
+	dev->dev.release = wiegand_dev_release;
+
+	device_initialize(&dev->dev);
+
+	return dev;
+}
+
+static int wiegand_add_device(struct wiegand_device *dev)
+{
+	static DEFINE_MUTEX(add_mutex);
+	int ret;
+
+	if (dev->idx >= WIEGAND_MAX_MODULES)
+		return -EINVAL;
+
+	dev_set_name(&dev->dev, "wiegand-%s.%u", wiegand_module_name(dev->id),
+		     dev->idx);
+
+	mutex_lock(&add_mutex);
+
+	ret = bus_for_each_dev(&wiegand_bus_type, NULL, dev,
+			       wiegand_dev_check);
+	if (ret)
+		goto done;
+
+	ret = device_add(&dev->dev);
+	if (ret < 0)
+		dev_err(dev->wiegand->dev, "Can't add %s, status %d\n",
+			dev_name(dev->wiegand->dev), ret);
+
+done:
+	mutex_unlock(&add_mutex);
+	return ret;
+}
+
+static int __unregister(struct device *dev, void *null)
+{
+	if (dev->of_node)
+		of_node_put(dev->of_node);
+
+	device_unregister(dev);
+
+	return 0;
+}
+
+static struct wiegand_device *
+of_register_wiegand_device(struct wiegand *wiegand, struct device_node *nc)
+{
+	struct wiegand_device *dev;
+	const char *val;
+	int ret;
+
+	dev = wiegand_alloc_device(wiegand);
+	if (!dev) {
+		dev_err(wiegand->dev,
+			"Wiegand device alloc error for %pOF\n", nc);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ret = of_property_read_string(nc, "compatible", &val);
+	if (ret) {
+		dev_err(wiegand->dev, "%pOF has no valid 'compatible' property (%d)\n",
+			nc, ret);
+		goto err_put;
+	}
+
+	if (strcmp(val, "wiegand,wiegand-gpio") == 0) {
+		dev->idx = 0;
+		dev->id = WIEGAND_MODULE_GPIO;
+		wiegand->modules[0] = dev->id;
+		wiegand->count++;
+	}
+
+	of_node_get(nc);
+	dev->dev.of_node = nc;
+
+	ret = wiegand_add_device(dev);
+	if (ret) {
+		dev_err(wiegand->dev,
+			"Wiegand device register error for %pOF\n", nc);
+		of_node_put(nc);
+		goto err_put;
+	}
+
+	return dev;
+
+err_put:
+	put_device(&dev->dev);
+	return ERR_PTR(ret);
+}
+
+static void of_register_wiegand_devices(struct wiegand *wiegand)
+{
+	struct wiegand_device *dev;
+	struct device_node *nc;
+
+	if (!wiegand->dev->of_node)
+		return;
+
+	for_each_available_child_of_node(wiegand->dev->of_node, nc) {
+		dev = of_register_wiegand_device(wiegand, nc);
+		if (IS_ERR(dev)) {
+			dev_warn(wiegand->dev,
+				"Failed to create Wiegand device for %pOF\n",
+				nc);
+		}
+	}
+}
+
+static int wiegand_probe(struct platform_device *pdev)
+{
+	struct wiegand *wiegand;
+
+	wiegand = devm_kzalloc(&pdev->dev, sizeof(struct wiegand),
+			      GFP_KERNEL);
+	if (!wiegand)
+		return -ENOMEM;
+
+	wiegand->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, wiegand);
+
+	mutex_init(&wiegand->lock);
+
+	of_register_wiegand_devices(wiegand);
+
+	return 0;
+}
+
+static int wiegand_remove(struct platform_device *pdev)
+{
+	struct wiegand *wiegand = dev_get_drvdata(&pdev->dev);
+
+	device_for_each_child(&pdev->dev, NULL, __unregister);
+
+	mutex_destroy(&wiegand->lock);
+
+	return 0;
+}
+
+static const struct of_device_id wiegand_dt_ids[] = {
+	{ .compatible = "wiegand" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, wiegand_dt_ids);
+
+static struct platform_driver wiegand_driver = {
+	.driver = {
+		.name		= "wiegand",
+		.of_match_table = wiegand_dt_ids,
+	},
+	.probe		= wiegand_probe,
+	.remove		= wiegand_remove,
+};
+
+static int __init wiegand_init(void)
+{
+	int ret;
+
+	ret = bus_register(&wiegand_bus_type);
+	if (ret < 0) {
+		pr_err("Wiegand bus registration failed: %d\n", ret);
+		goto error;
+	}
+
+	ret = platform_driver_register(&wiegand_driver);
+	if (ret < 0) {
+		pr_err("Wiegand driver registration failed: %d\n", ret);
+		goto error_bus;
+	}
+
+	return 0;
+
+error_bus:
+	bus_unregister(&wiegand_bus_type);
+error:
+	return ret;
+}
+postcore_initcall_sync(wiegand_init);
+
+static void __exit wiegand_exit(void)
+{
+	platform_driver_unregister(&wiegand_driver);
+	bus_unregister(&wiegand_bus_type);
+}
+module_exit(wiegand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Wiegand bus driver");
+MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");
diff --git a/include/linux/wiegand.h b/include/linux/wiegand.h
new file mode 100644
index 000000000000..98d8671f042e
--- /dev/null
+++ b/include/linux/wiegand.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef H_LINUX_INCLUDE_LINUX_WIEGAND_H
+#define H_LINUX_INCLUDE_LINUX_WIEGAND_H
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+
+#define WIEGAND_MAX_PAYLEN_BYTES 256
+#define WIEGAND_MAX_MODULES 1
+
+/* The used wiegand format; when data does not end at octet boundaries, the
+ * lower bits of the last octet will be ignored and only the upper ones will be
+ * used.
+ */
+enum wiegand_format {
+	WIEGAND_V26 = 26,
+	WIEGAND_V36 = 36,
+	WIEGAND_V37 = 37,
+	WIEGAND_CUSTOM = 0,
+};
+
+enum wiegand_module_id {
+	WIEGAND_MODULE_FIRST = 0x01,
+	WIEGAND_MODULE_GPIO = 0x01,
+	WIEGAND_MODULE_LAST = 0x01,
+};
+
+enum wiegand_paylen {
+	WIEGAND_V26_PAYLEN = 24,
+	WIEGAND_V36_PAYLEN = 34,
+	WIEGAND_V37_PAYLEN = 35,
+};
+
+extern struct bus_type wiegand_type;
+
+struct wiegand {
+	struct device *dev;
+	struct mutex lock;
+	int count;
+	u8 modules[WIEGAND_MAX_MODULES];
+};
+
+struct wiegand_driver {
+	const enum wiegand_module_id *id_table;
+	struct device_driver driver;
+};
+
+struct wiegand_device {
+	struct device dev;
+	struct wiegand *wiegand;
+	enum wiegand_module_id id;
+	unsigned int idx;
+};
+
+extern int __wiegand_register_driver(struct module *owner,
+				    struct wiegand_driver *mdrv);
+
+static inline void wiegand_unregister_driver(struct wiegand_driver *mdrv)
+{
+	if (mdrv)
+		driver_unregister(&mdrv->driver);
+}
+
+#define wiegand_register_driver(driver) \
+	__wiegand_register_driver(THIS_MODULE, driver)
+
+#define module_wiegand_driver(__wiegand_driver) \
+	module_driver(__wiegand_driver, wiegand_register_driver, \
+			wiegand_unregister_driver)
+
+static inline struct wiegand_driver *
+to_wiegand_driver(struct device_driver *drv)
+{
+	if (!drv)
+		return NULL;
+	return container_of(drv, struct wiegand_driver, driver);
+}
+
+static inline struct wiegand_device *
+to_wiegand_device(struct device *dev)
+{
+	if (!dev)
+		return NULL;
+	return container_of(dev, struct wiegand_device, dev);
+}
+
+/**
+ * struct wiegand_setup - Wiegand communication attributes
+ * @pulse_len: length of the low pulse in usec; defaults to 50us
+ * @interval_len: length of a whole bit (both the pulse and the high phase) in
+ *	usec; defaults to 2000us
+ * @frame_gap: length of the last bit of a frame (both the pulse and the high
+ *	phase) in usec; defaults to interval_len
+ * @format: the used wiegand format
+ * @payload_len: payload of wiegand message in bits
+ */
+struct wiegand_setup {
+	unsigned long		pulse_len;
+	unsigned long		interval_len;
+	unsigned long		frame_gap;
+	enum wiegand_format	format;
+	unsigned long		payload_len;
+};
+
+extern int wiegand_gpio_calc_parity8(u8 v);
+extern void wiegand_gpio_add_parity_to_data(unsigned char *tmp, u8 *data,
+						enum wiegand_format fmt);
+
+#endif	/* H_LINUX_INCLUDE_LINUX_WIEGAND_H */
-- 
2.37.3

