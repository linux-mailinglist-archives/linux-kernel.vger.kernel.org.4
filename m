Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2010F63E573
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiK3X3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiK3X3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:29:24 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE388AB033
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:19:45 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id j16-20020a170902da9000b001893d5da3acso19314654plx.23
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=psZEL5ww/2k9YPeWOOCAXsjMZnFtn9I23/0F0XLJjGo=;
        b=dcy27hQ1oZRdKqdf1nM0wAFdLBtZ+drOiDMvLMXuisGs4TsbPgCOMhdNsxgnH+NAXa
         xJa7WfFmbXvg0DT4bOOA6DYjE61uFM+DWtDr7XuRSqoCsH2YSode9+4ARKmqmfRsdbZj
         61FypBgVkQW/bxWqJqcHRWFxEofW+q5RKTf+LsRW5Ib8iQJnJVpmdB/+ht5pM037QwUW
         jcf4AP0OBxWho7Sydm5lO7OdSmqh5BVT7NLQoe6oVA3EanKY5ZKsBw0CgI2YwoCgJJ24
         Mu7s6zKTqMeKRdlB9Mq5AVUv9GRWJL59HwwjrOLXkuDbCUUi9nzKk/eBFADdwvyRCnEc
         h8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psZEL5ww/2k9YPeWOOCAXsjMZnFtn9I23/0F0XLJjGo=;
        b=Ikasfhr8X27JN0byGSovJMGZtSqWXBWwNZGtwz05+P9J2oNwYxEQwud0xuugjuV/oQ
         EXLr/SLdEJ7LJZiM9JYXZHR9dI1JSdVQRb1zalIjst/MHNuvoUb5+/JBAYTLUQX4H7Is
         M0zWJfwItqorMAEgbLPo4IRtpQLNIkjnlAl7O37MvHaBGnjMo40ZbWdffga4EzgI87HD
         lcA+Jqd29ZhXe2AYMs6pbf+zI4rAfmS0G88+J88AXqZ59m+gkybTt8o1tyfy/2pWQ0Uy
         SO057VX5E2Zn9gm54AP5wPtuyca7JQwR6SAXt3N//8hj0fe/rBupJY7lU+Q9/XJ2nwZ1
         Kqjw==
X-Gm-Message-State: ANoB5pmf1yw0sw/0ZtEhvB9oMWKfd8NSSbUbjcVfPNMjdcRx7pZc23CJ
        C40nFjsw3JZyQ86DVrw6JCRwJhj9D+7LgA==
X-Google-Smtp-Source: AA0mqf77VInAyRbXo2x8Y6PwP2A7ZiPUqHPx2P2ELAIIUt9HJqsLDFpW7960UiOr2s39ATpVGmYoW6xoI030WA==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:90b:3c52:b0:219:2b64:cc0e with SMTP
 id pm18-20020a17090b3c5200b002192b64cc0emr20856888pjb.161.1669850379424; Wed,
 30 Nov 2022 15:19:39 -0800 (PST)
Date:   Wed, 30 Nov 2022 23:19:36 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221130231936.1666390-1-wonchung@google.com>
Subject: [PATCH] platform/chrome: Create new USB driver for RGB keyboard in
 ChromeOS devices
From:   Won Chung <wonchung@google.com>
To:     wonchung@google.com, Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without any driver bound to RGB keyboard, it may not be suspended
properly, preventing USB xHCI to be suspended and causing power drain.
Create new USB driver for RGB keyboard so that it can be suspended
properly.

Signed-off-by: Won Chung <wonchung@google.com>
---
 drivers/platform/chrome/Kconfig             |  8 ++++
 drivers/platform/chrome/Makefile            |  1 +
 drivers/platform/chrome/cros_rgb_keyboard.c | 44 +++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_rgb_keyboard.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index c45fb376d653..a7c36df99432 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -265,6 +265,14 @@ config CHROMEOS_PRIVACY_SCREEN
 	  this should probably always be built into the kernel to avoid or
 	  minimize drm probe deferral.
 
+config CROS_RGB_KEYBOARD
+	tristate "ChromeOS RGB keyboard"
+	depends on USB
+	help
+	  This driver supports RGB keyboard in some ChromeOS devices. This shall be
+	  enabled if RGB keyboard is present, otherwise it may not be suspended
+	  properly.
+
 source "drivers/platform/chrome/wilco_ec/Kconfig"
 
 # Kunit test cases
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index f7e74a845afc..e4ffa17c57fc 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros-ec-sensorhub.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
 obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
 obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
+obj-$(CONFIG_CROS_RGB_KEYBOARD)		+= cros_rgb_keyboard.o
 
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
 
diff --git a/drivers/platform/chrome/cros_rgb_keyboard.c b/drivers/platform/chrome/cros_rgb_keyboard.c
new file mode 100644
index 000000000000..1d53fc832d76
--- /dev/null
+++ b/drivers/platform/chrome/cros_rgb_keyboard.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+// RGB keyboard driver for ChromeOS
+//
+// Copyright (C) 2022 Google, Inc.
+
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#define DRV_NAME "cros-rgb-keyboard"
+
+/* vendor ID */
+#define ID_GOOGLE 0x18d1
+/* product ID */
+#define ID_PRISM 0x5022
+
+static const struct usb_device_id cros_rgb_keyboard_table[] = {
+	{USB_DEVICE(ID_GOOGLE, ID_PRISM)},
+	{} // terminating null entry
+};
+
+static int cros_rgb_keyboard_probe(struct usb_interface *interface, const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(interface);
+
+	usb_enable_autosuspend(udev);
+	return 0;
+}
+
+static void cros_rgb_keyboard_disconnect(struct usb_interface *interface)
+{
+}
+
+/* usb specific object needed to register this driver with the usb subsystem */
+static struct usb_driver cros_rgb_keyboard_driver = {
+	.name = DRV_NAME,
+	.id_table = cros_rgb_keyboard_table,
+	.probe = cros_rgb_keyboard_probe,
+	.disconnect = cros_rgb_keyboard_disconnect,
+};
+
+module_usb_driver(cros_rgb_keyboard_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ChromeOS RGB keyboard driver");
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

