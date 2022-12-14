Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C10164C439
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbiLNHHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiLNHHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:07:36 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5366B6570
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:07:26 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3b0af5bcbd3so196520377b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1ar1dADbdU6DENQz+1O8bfsS7Rj7vcSTdNKfRYLHK4=;
        b=Y0BnuVQuCo6vSf8eHHnJ/qgMABwFE1KDrHYvbMKq59Qi7/2tfcLob/qtmQg0ble+kM
         +B5jGvL/4ZcC/N1TEHOEjfIzUEcxavRVb4coNc0sVe/ia0lz1lp5MgYmHwaYoGoRhWCC
         yXfwxeC8nLVZHghItn7IhxQtyOqhcb5Ze1tEjEBnbt7qlGWUrRqqZS+3BPMnGPIBazf9
         7Zk4y4JpQ4d/HS5Gi8/2tWOVQ9FlysDDESiH8XxUA5MsiJSloMSX8lEVVkgLWebC5GFl
         AkF/WVJzD4QY5fycLmTDd0cekmAT232RQs11zitmIFaGryuFMozYq/drxC2gd0641jlS
         G49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1ar1dADbdU6DENQz+1O8bfsS7Rj7vcSTdNKfRYLHK4=;
        b=oe6LaJlnTUSVAoV65aVLAkeuDI3/IWEKpCBFBLyV+dvVHYMj0LTxayacOdV4EWJpKc
         HKJn+TSW3f4XKeDQgUAwgFA8GeEa53KjENtK2/zZ7esYXWHqY1e/FdghfTAbAtgTDNbY
         CQYJCu9apn3LqOBu4sBLjwagiitZ7XUoXTGZVN79EA4KF7T7iwalPQ79FT7lNGrXWr5r
         hkAWNRnGdg/YDY2pDfr0KzoSNjSWKfAsp+n+e6fO2fTfqjUr00TmG/zacKvpngB89qhE
         tACIXfRiPzO6bZY6s/6BQcs7OvsHG2+txEowVzeXUQHT4kcCSHy1FDI5xUwvn9Jndy+7
         SpbQ==
X-Gm-Message-State: ANoB5plDOXVGiQzdWErhDBWacCvdUaHTEEbJ/FLi/IfZmBMSn/bYJf45
        L8EmCww30mswVKBqLutH+wMaLuwzxli4
X-Google-Smtp-Source: AA0mqf6EKelmu9XOooSmJS/Moj+JzDWjsUGWhdROmBGqXOy5TIevw9k2GKGyMbX2jZXqPUJWagflCR/9hM8u
X-Received: from pumahsu.ntc.corp.google.com ([2401:fa00:fc:202:cb1:cbe3:3a49:1751])
 (user=pumahsu job=sendgmr) by 2002:a25:74c7:0:b0:6fb:67c7:33e1 with SMTP id
 p190-20020a2574c7000000b006fb67c733e1mr35977414ybc.255.1671001645440; Tue, 13
 Dec 2022 23:07:25 -0800 (PST)
Date:   Wed, 14 Dec 2022 15:06:49 +0800
In-Reply-To: <20221214070650.703793-1-pumahsu@google.com>
Message-Id: <20221214070650.703793-2-pumahsu@google.com>
Mime-Version: 1.0
References: <20221214070650.703793-1-pumahsu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Subject: [PATCH 1/2] usb: core: add vendor hook for usb suspend and resume
From:   Puma Hsu <pumahsu@google.com>
To:     gregkh@linuxfoundation.org, mka@chromium.org, dianders@chromium.org
Cc:     albertccwang@google.com, raychi@google.com, howardyen@google.com,
        leejj@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the hooks that vendor can design and bypass the suspend/resume.
When the handled is set, skip the original suspend/resume process.

In mobile, a co-processor can be used for USB audio. When the co-processor
is working for USB audio, the co-processor is the user/owner of the USB
driver, and the ACPU is able to sleep in such condition to improve power
consumption. In original process, the ACPU will suspend/resume until the
USB suspend/resume. We add the hooks, so we can control USB suspend/resume
without affecting the ACPU.

Signed-off-by: Puma Hsu <pumahsu@google.com>
---
 drivers/usb/core/Makefile |  2 +-
 drivers/usb/core/driver.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.h    |  5 +++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index 7d338e9c0657..f48f646cd874 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -3,7 +3,7 @@
 # Makefile for USB Core files and filesystem
 #
 
-usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
+usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o usb-hooks-impl-goog.o
 usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
 usbcore-y += devio.o notify.o generic.o quirks.o devices.o
 usbcore-y += phy.o port.o
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 7e7e119c253f..3d2cfb6c2277 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -35,6 +35,25 @@
 #include "usb.h"
 
 
+static struct usb_device_vendor_ops *usb_dev_vendor_ops;
+
+int usb_dev_register_vendor_ops(struct usb_device_vendor_ops *vendor_ops)
+{
+	if (vendor_ops == NULL)
+		return -EINVAL;
+
+	usb_dev_vendor_ops = vendor_ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_dev_register_vendor_ops);
+
+struct usb_device_vendor_ops *usb_vendor_get_ops(void)
+{
+	return usb_dev_vendor_ops;
+}
+EXPORT_SYMBOL_GPL(usb_vendor_get_ops);
+
+
 /*
  * Adds a new dynamic USBdevice ID to this driver,
  * and cause the driver to probe for all devices again.
@@ -1400,11 +1419,19 @@ static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
 	int			status = 0;
 	int			i = 0, n = 0;
 	struct usb_interface	*intf;
+	bool			handled;
+	struct usb_device_vendor_ops *ops = usb_vendor_get_ops();
 
 	if (udev->state == USB_STATE_NOTATTACHED ||
 			udev->state == USB_STATE_SUSPENDED)
 		goto done;
 
+	if (ops && ops->usb_dev_suspend) {
+		handled = ops->usb_dev_suspend(udev, msg);
+		if (handled)
+			goto done;
+	}
+
 	/* Suspend all the interfaces and then udev itself */
 	if (udev->actconfig) {
 		n = udev->actconfig->desc.bNumInterfaces;
@@ -1501,11 +1528,20 @@ static int usb_resume_both(struct usb_device *udev, pm_message_t msg)
 	int			status = 0;
 	int			i;
 	struct usb_interface	*intf;
+	bool			handled;
+	struct usb_device_vendor_ops *ops = usb_vendor_get_ops();
 
 	if (udev->state == USB_STATE_NOTATTACHED) {
 		status = -ENODEV;
 		goto done;
 	}
+
+	if (ops && ops->usb_dev_resume) {
+		handled = ops->usb_dev_resume(udev, msg);
+		if (handled)
+			goto done;
+	}
+
 	udev->can_submit = 1;
 
 	/* Resume the device */
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 82538daac8b8..9ccb8683071d 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -220,3 +220,8 @@ extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
 static inline int usb_acpi_register(void) { return 0; };
 static inline void usb_acpi_unregister(void) { };
 #endif
+
+struct usb_device_vendor_ops {
+	bool (*usb_dev_suspend)(struct usb_device *udev, pm_message_t msg);
+	bool (*usb_dev_resume)(struct usb_device *udev, pm_message_t msg);
+};
-- 
2.39.0.rc1.256.g54fd8350bd-goog

