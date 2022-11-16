Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F0462BDEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbiKPMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbiKPMbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:31:00 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E6EDEE0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:30:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j15so29700235wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMcRJuxeNKzK+RXQpDGGFzbRIm01UwZgF0vUOiP8QjU=;
        b=dwW1wbGhQleITUuPQ+cN9PCikMnpSJ0Id+5N6GH/3UlXZuhKO8z14q+9Bo8vKTDlnl
         Cmv6fgzMwChjsltijJ4ztvQx40mqjpDWyM4A7ZAR7JE26yEj5z9Ht35kKKyifAr1xibw
         lkh3L9IhPzfdlmD6A8VULs6y8zSSEkqSuKTJ9WRQqslhWn7fNk7SFmXGGi+V4+wWgx/f
         il4JTFMWXepV8I4AwPAl/qdYLf/+LevZGwUk0RiSrs/2S4J1B+YnHLthLGjnXL3UkOr8
         5KOmSWtY+gNqsEWmOM+FM4qRYPDLl+TJCNA3TBQankmlyf6tspqNKdlUo9uO+E2vdEop
         Odug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMcRJuxeNKzK+RXQpDGGFzbRIm01UwZgF0vUOiP8QjU=;
        b=mIgwDHd6n74uDWkBPjxog0ofWEOwdEi39yUxgTGz0ft2WPzFvSeFiK4P69uQtHvSYI
         u/ymPzLcdRajn2rSVI57S4bHLdX4z1YnfJlOomn3doHwKHghxQ4wI10EVJH2bFy++8BA
         EisIKzJY7OzFtZIWE15Y30Y9uO4beEKcOKs1HbvZz94nrWBeM6PBXsB0XfAuXH+asdAM
         tRahuYZfdX2qlZ1Sj1S7UCLJy7tLWzUJ5KsTFTiVd34gho//GEZDmMVvnIUHNMA/2nMI
         6I6xjaqjWhrsgNhr6UAP6eHfGDKclPoqIJyIjEypFTQq+FQnosqcW7YZ0RHvM9GJ36YQ
         NmgA==
X-Gm-Message-State: ANoB5pkZNomrurG+GodccFVIfeNRN+zgh0cxSlYRa2d/3TxfqpxIqtZ9
        h/pSe3+2WEiMeXblCrplAkMLqw==
X-Google-Smtp-Source: AA0mqf5DBhXsKIbQCm1qCaVipqpcbXdM/qEx2b1qny97+D4PjfQi+7ZmK+KWk5Dq/4d9IFp7+23qqw==
X-Received: by 2002:a5d:6e0c:0:b0:236:5abb:590a with SMTP id h12-20020a5d6e0c000000b002365abb590amr13595607wrz.700.1668601835375;
        Wed, 16 Nov 2022 04:30:35 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cf4eac8e80sm2870991wms.23.2022.11.16.04.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:30:34 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH 1/3] usb: Add USB repeater generic framework
Date:   Wed, 16 Nov 2022 14:30:17 +0200
Message-Id: <20221116123019.2753230-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116123019.2753230-1-abel.vesa@linaro.org>
References: <20221116123019.2753230-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With more SoCs moving towards eUSB2, such platforms will have to use
a USB 2.0 compliance repeater. This repeater HW-wise usually deals with
level shifting, but depending on the implementation it can do much more.
So add a ganeric USB framework that would allow either a generic PHY or
some USB host controller to control and get a repeater from a devicetree
phandle. This framework will further be used by platform specific
drivers to register the repeater and implement platform specific ops.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/usb/Kconfig             |   2 +
 drivers/usb/Makefile            |   2 +
 drivers/usb/repeater/Kconfig    |   9 ++
 drivers/usb/repeater/Makefile   |   6 +
 drivers/usb/repeater/repeater.c | 198 ++++++++++++++++++++++++++++++++
 include/linux/usb/repeater.h    |  78 +++++++++++++
 6 files changed, 295 insertions(+)
 create mode 100644 drivers/usb/repeater/Kconfig
 create mode 100644 drivers/usb/repeater/Makefile
 create mode 100644 drivers/usb/repeater/repeater.c
 create mode 100644 include/linux/usb/repeater.h

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index a871a988829d..c9ad102a0fa9 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -176,6 +176,8 @@ source "drivers/usb/gadget/Kconfig"
 
 source "drivers/usb/typec/Kconfig"
 
+source "drivers/usb/repeater/Kconfig"
+
 source "drivers/usb/roles/Kconfig"
 
 endif # USB_SUPPORT
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index a81e6ef293af..c96c66304edd 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -67,4 +67,6 @@ obj-$(CONFIG_USBIP_CORE)	+= usbip/
 
 obj-$(CONFIG_TYPEC)		+= typec/
 
+obj-$(CONFIG_USB_REPEATER)	+= repeater/
+
 obj-$(CONFIG_USB_ROLE_SWITCH)	+= roles/
diff --git a/drivers/usb/repeater/Kconfig b/drivers/usb/repeater/Kconfig
new file mode 100644
index 000000000000..e12cd22c0adb
--- /dev/null
+++ b/drivers/usb/repeater/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config USB_REPEATER
+	tristate "USB Repeater Framework"
+	help
+	  Enable this to allow the USB PHY drivers and the connected repeater
+	  driver to bind together and to provide the USB driver ways to perform
+	  set of operations with repeater for USB2 functionality using PHY and
+	  controller driver.
diff --git a/drivers/usb/repeater/Makefile b/drivers/usb/repeater/Makefile
new file mode 100644
index 000000000000..2d1b5f348976
--- /dev/null
+++ b/drivers/usb/repeater/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for USB repeater drivers
+#
+
+obj-$(CONFIG_USB_REPEATER)		+= repeater.o
diff --git a/drivers/usb/repeater/repeater.c b/drivers/usb/repeater/repeater.c
new file mode 100644
index 000000000000..e97a95422735
--- /dev/null
+++ b/drivers/usb/repeater/repeater.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/overflow.h>
+
+#include <linux/usb/repeater.h>
+
+static LIST_HEAD(usb_repeater_list);
+static DEFINE_SPINLOCK(usb_repeater_lock);
+
+/**
+ * usb_put_repeater - release the USB repeater
+ * @rptr: the repeater returned by usb_get_repeater()
+ *
+ * Releases a refcount the caller received from usb_get_repeater().
+ *
+ * For use by USB PHY drivers.
+ */
+void usb_put_repeater(struct usb_repeater *rptr)
+{
+	if (rptr) {
+		put_device(rptr->dev);
+		if (rptr->dev->driver && rptr->dev->driver->owner) {
+			struct module *owner = rptr->dev->driver->owner;
+
+			module_put(owner);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(usb_put_repeater);
+
+static struct usb_repeater *of_usb_find_repeater(struct device_node *node)
+{
+	struct usb_repeater *rptr;
+
+	if (!of_device_is_available(node))
+		return ERR_PTR(-ENODEV);
+
+	list_for_each_entry(rptr, &usb_repeater_list, head) {
+		if (node != rptr->dev->of_node)
+			continue;
+
+		return rptr;
+	}
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static void devm_usb_repeater_release(struct device *dev, void *res)
+{
+	struct usb_repeater *rptr = *(struct usb_repeater **)res;
+
+	usb_put_repeater(rptr);
+}
+
+/**
+ * devm_usb_get_repeater_by_node - find the USB repeater by device_node
+ * @dev: device that requests this USB repeater
+ * @node: the device_node for the USB repeater device.
+ * @nb: a notifier_block to register with the USB repeater.
+ *
+ * Returns the USB repeater driver associated with the given device_node,
+ * after getting a refcount to it, -ENODEV if there is no such repeater or
+ * -EPROBE_DEFER if the device is not yet loaded. While at that, it
+ * also associates the device with
+ * the repeater using devres. On driver detach, release function is invoked
+ * on the devres data, then, devres data is freed.
+ *
+ * For use by peripheral drivers for devices related to a repeater,
+ * such as a charger.
+ */
+struct  usb_repeater *devm_usb_get_repeater_by_node(struct device *dev,
+					  struct device_node *node,
+					  struct notifier_block *nb)
+{
+	struct usb_repeater *rptr = ERR_PTR(-ENOMEM);
+	struct usb_repeater *rptr_devm;
+	unsigned long flags;
+
+	rptr_devm = devres_alloc(devm_usb_repeater_release,
+					sizeof(*rptr_devm), GFP_KERNEL);
+	if (!rptr_devm) {
+		dev_dbg(dev, "failed to allocate memory for devres\n");
+		goto err0;
+	}
+
+	spin_lock_irqsave(&usb_repeater_lock, flags);
+
+	rptr = of_usb_find_repeater(node);
+	if (IS_ERR(rptr)) {
+		devres_free(rptr_devm);
+		goto err0;
+	}
+
+	if (!try_module_get(rptr->dev->driver->owner)) {
+		rptr = ERR_PTR(-ENODEV);
+		devres_free(rptr_devm);
+		goto err0;
+	}
+	devres_add(dev, rptr_devm);
+
+	get_device(rptr->dev);
+err0:
+	spin_unlock_irqrestore(&usb_repeater_lock, flags);
+
+	return rptr;
+}
+EXPORT_SYMBOL_GPL(devm_usb_get_repeater_by_node);
+
+/**
+ * devm_usb_get_repeater_by_phandle - find the USB repeater by phandle
+ * @dev: device that requests this repeater
+ * @phandle: name of the property holding the repeater phandle value
+ * @index: the index of the repeater
+ *
+ * Returns the USB repeater driver associated with the given phandle value,
+ * after getting a refcount to it, -ENODEV if there is no such repeater or
+ * -EPROBE_DEFER if there is a phandle to the repeater, but the device is
+ * not yet loaded. While at that, it also associates the device with
+ * the repeater using devres. On driver detach, release function is invoked
+ * on the devres data, then, devres data is freed.
+ *
+ * For use by USB PHY drivers.
+ */
+struct usb_repeater *devm_usb_get_repeater_by_phandle(struct device *dev,
+	const char *phandle, u8 index)
+{
+	struct device_node *node;
+	struct usb_repeater *rptr;
+
+	if (!dev->of_node) {
+		dev_dbg(dev, "device does not have a device node entry\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	node = of_parse_phandle(dev->of_node, phandle, index);
+	if (!node) {
+		dev_dbg(dev, "failed to get %s phandle in %pOF node\n", phandle,
+			dev->of_node);
+		return ERR_PTR(-ENODEV);
+	}
+	rptr = devm_usb_get_repeater_by_node(dev, node, NULL);
+	of_node_put(node);
+	return rptr;
+}
+EXPORT_SYMBOL_GPL(devm_usb_get_repeater_by_phandle);
+
+/**
+ * usb_add_repeater_dev - declare the USB repeater
+ * @rptr: the USB repeater to be used; or NULL
+ *
+ * This call is exclusively for use by repeater drivers to
+ * register the device to allow the USB phy driver to control it
+ * via repeater specific ops.
+ */
+int usb_add_repeater_dev(struct usb_repeater *rptr)
+{
+	unsigned long flags;
+
+	if (!rptr->dev) {
+		dev_err(rptr->dev, "no device provided for repeater\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&usb_repeater_lock, flags);
+	list_add_tail(&rptr->head, &usb_repeater_list);
+	spin_unlock_irqrestore(&usb_repeater_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_add_repeater_dev);
+
+/**
+ * usb_remove_repeater - remove the USB repeater
+ * @rptr: the USB Repeater to be removed;
+ *
+ * This reverts the effects of usb_add_repeater_dev
+ */
+void usb_remove_repeater_dev(struct usb_repeater *rptr)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&usb_repeater_lock, flags);
+	if (rptr)
+		list_del(&rptr->head);
+	spin_unlock_irqrestore(&usb_repeater_lock, flags);
+}
+EXPORT_SYMBOL_GPL(usb_remove_repeater_dev);
+
+MODULE_DESCRIPTION("USB Repeater Framework");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/usb/repeater.h b/include/linux/usb/repeater.h
new file mode 100644
index 000000000000..e68e0936f1e5
--- /dev/null
+++ b/include/linux/usb/repeater.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * USB Repeater defines
+ */
+
+#ifndef __LINUX_USB_REPEATER_H
+#define __LINUX_USB_REPEATER_H
+
+struct usb_repeater {
+	struct device		*dev;
+	const char		*label;
+	unsigned int		 flags;
+
+	struct list_head	head;
+	int	(*reset)(struct usb_repeater *rptr, bool assert);
+	int	(*init)(struct usb_repeater *rptr);
+	int	(*power_on)(struct usb_repeater *rptr);
+	int	(*power_off)(struct usb_repeater *rptr);
+};
+
+#if IS_ENABLED(CONFIG_USB_REPEATER)
+extern struct usb_repeater *devm_usb_get_repeater_by_phandle(struct device *dev,
+	const char *phandle, u8 index);
+extern struct usb_repeater *devm_usb_get_repeater_by_node(struct device *dev,
+	struct device_node *node, struct notifier_block *nb);
+extern int usb_add_repeater_dev(struct usb_repeater *rptr);
+extern void usb_remove_repeater_dev(struct usb_repeater *rptr);
+#else
+static inline struct usb_repeater *devm_usb_get_repeater_by_phandle(struct device *dev,
+	const char *phandle, u8 index)
+{
+	return ERR_PTR(-ENXIO);
+}
+
+static inline struct usb_repeater *devm_usb_get_repeater_by_node(struct device *dev,
+	struct device_node *node, struct notifier_block *nb)
+{
+	return ERR_PTR(-ENXIO);
+}
+
+static inline int usb_add_repeater_dev(struct usb_repeater *rptr) { return 0; }
+static inline void usb_remove_repeater_dev(struct usb_repeater *rptr) { }
+
+#endif
+
+static inline int usb_repeater_reset(struct usb_repeater *rptr, bool assert)
+{
+	if (rptr && rptr->reset != NULL)
+		return rptr->reset(rptr, assert);
+	else
+		return 0;
+}
+
+static inline int usb_repeater_init(struct usb_repeater *rptr)
+{
+	if (rptr && rptr->init != NULL)
+		return rptr->init(rptr);
+	else
+		return 0;
+}
+
+static inline int usb_repeater_power_on(struct usb_repeater *rptr)
+{
+	if (rptr && rptr->power_on != NULL)
+		return rptr->power_on(rptr);
+	else
+		return 0;
+}
+
+static inline int usb_repeater_power_off(struct usb_repeater *rptr)
+{
+	if (rptr && rptr->power_off != NULL)
+		return rptr->power_off(rptr);
+	else
+		return 0;
+}
+
+#endif /* __LINUX_USB_REPEATER_H */
-- 
2.34.1

