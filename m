Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4685BB5B7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 05:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiIQDF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 23:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIQDFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 23:05:53 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921646554F;
        Fri, 16 Sep 2022 20:05:48 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id c6so18024404qvn.6;
        Fri, 16 Sep 2022 20:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nT9TGyLVJBAxUFmrmFAz1FYx0wO/TBVpb4hszwcCiJw=;
        b=p+Dht6HXZyg/4SW6DbgfKjFgJMMdvVaSbaxweoN7ilajFOcSFclEirPZWeKgfxtmxO
         MCtWjpp0k1u9u/kWSQ5UgR/oNrBbFmVI8rC8VGwBCcK47VGYj3YUxjX09Zn1M4PQrvCm
         xf3+I7Xh/2XnXHwac3UbU86jNM2zm1vy7M2lgBukO8jaHB7/eynd1PXSw5RBuzTo+2Dt
         70Rs1ukbxbGNEJ8zzHp6RMceTdC+OpQil6pKMeSMUTUjQ1llzBRpAx+QzFtpUeNdiphk
         kIggBHdsO/RP9HbhSuz5eP4BI0JqYIKoxJRAxhjWhFVs+Cq2jD01y31KNnUMXxAab110
         hVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nT9TGyLVJBAxUFmrmFAz1FYx0wO/TBVpb4hszwcCiJw=;
        b=kG4pffdZl6s2Scnp6niNZhvvbVBuBRafETa5n+Zq3Bv6pDtKOnlQ0hkXQ55qG+85P8
         l3lhrK14+lg9ch+LAHFFy0Q/ccakKu2hOdlPBukwIL9gfYeLTTmhDj3ySLkGMsaE6RA/
         t5uPhI7NbNj0+AoMN7xwm/vFvLTHA/W81FzuDt79dzZa2D4taT/IbuMK3dE+JHxTEHS5
         G7mni/Ix8X0F0KHRUCZRWeqkcJMeuE68lY22vF0rjeG/Ta/dSHdGIk9AJJLUlBImS+o3
         EeuJIIKJJkhjMpTInVz6zKHDBAwymYTrBov870eZFEJvO3flSyx69uSrJuAqaIsG339W
         ZXpQ==
X-Gm-Message-State: ACrzQf1k7rTRf58FJbCSWqnz2u7/JxknQuiAeFovdSa621km7pPgKAUq
        V8DPX0Ilnk/4wVyHu5InKSGVkqNTvN9fOQ==
X-Google-Smtp-Source: AMsMyM6fHhiRqyMYasRUu1J/hRfQCwqxid2eHyGLkrBsQYGR1VSikibBQ9rzNwJGgyVphEWyFUjKwQ==
X-Received: by 2002:ad4:4eab:0:b0:4a2:8a8:6afc with SMTP id ed11-20020ad44eab000000b004a208a86afcmr6405729qvb.21.1663383947997;
        Fri, 16 Sep 2022 20:05:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:9414:100:7d9f:4703:e9c:52c])
        by smtp.gmail.com with ESMTPSA id d2-20020ac80602000000b0031f0b43629dsm6105937qth.23.2022.09.16.20.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:05:47 -0700 (PDT)
From:   Alexey Klimov <klimov.linux@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        gregkh@linuxfoundation.org, oneukum@suse.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        atishp@rivosinc.com, atishp@atishpatra.org, yury.norov@gmail.com,
        aklimov@redhat.com, atomlin@redhat.com, klimov.linux@gmail.com
Subject: [PATCH v6] watchdog: add driver for StreamLabs USB watchdog device
Date:   Sat, 17 Sep 2022 04:05:34 +0100
Message-Id: <20220917030534.363192-1-klimov.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver supports StreamLabs usb watchdog device. The device plugs
into 9-pin usb header and connects to reset pins and reset button
pins on desktop PC.

USB commands used to communicate with device were reverse
engineered using usbmon.

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
---

Changes since v5:
	-- moved to semaphore lock: down_killable()/up();
	If I have to go with down_timeout() option, then
	I am not sure which timeout value to use, apart
	from maximum or current timeout from device;
	-- implemented {pre,post}_reset methods (thanks, Oliver!);
	-- back to the version where buffer is a part of
	struct streamlabs_wdt and now also ____cacheline_aligned;
	-- watchdog_start() in probe instead of watchdog_stop();
	-- added watchdog_stop_on_reboot() in probe;
	-- other comments from Guenter.

Previous version:
https://lore.kernel.org/linux-usb/CALW4P+LmMJAm=3PWQfiEgYS7d_q0M0rdSJVhpZw9x9w3fQQMRA@mail.gmail.com/T/


 MAINTAINERS                       |   6 +
 drivers/watchdog/Kconfig          |  15 ++
 drivers/watchdog/Makefile         |   1 +
 drivers/watchdog/streamlabs_wdt.c | 412 ++++++++++++++++++++++++++++++
 4 files changed, 434 insertions(+)
 create mode 100644 drivers/watchdog/streamlabs_wdt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 936490dcc97b..e56fd4d636d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19480,6 +19480,12 @@ W:	http://www.stlinux.com
 F:	Documentation/networking/device_drivers/ethernet/stmicro/
 F:	drivers/net/ethernet/stmicro/stmmac/

+STREAMLABS USB WATCHDOG DRIVER
+M:	Alexey Klimov <klimov.linux@gmail.com>
+L:	linux-watchdog@vger.kernel.org
+S:	Maintained
+F:	drivers/watchdog/streamlabs_wdt.c
+
 SUN3/3X
 M:	Sam Creasey <sammy@sammy.net>
 S:	Maintained
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9295492d24f7..8baf53fef3cc 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2180,6 +2180,21 @@ config USBPCWATCHDOG

 	  Most people will say N.

+config USB_STREAMLABS_WATCHDOG
+	tristate "StreamLabs USB watchdog driver"
+	depends on USB
+	help
+	  This is the driver for the USB Watchdog dongle from StreamLabs.
+	  If you correctly connect reset pins to motherboard Reset pin and
+	  to Reset button then this device will simply watch your kernel to make
+	  sure it doesn't freeze, and if it does, it reboots your computer
+	  after a certain amount of time.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called streamlabs_wdt.
+
+	  Most people will say N. Say yes or M if you want to use such usb device.
+
 config KEEMBAY_WATCHDOG
 	tristate "Intel Keem Bay SoC non-secure watchdog"
 	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index cdeb119e6e61..afc6fdc1b4d9 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_WDTPCI) += wdt_pci.o

 # USB-based Watchdog Cards
 obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
+obj-$(CONFIG_USB_STREAMLABS_WATCHDOG) += streamlabs_wdt.o

 # ALPHA Architecture

diff --git a/drivers/watchdog/streamlabs_wdt.c b/drivers/watchdog/streamlabs_wdt.c
new file mode 100644
index 000000000000..cc4f48f1fd36
--- /dev/null
+++ b/drivers/watchdog/streamlabs_wdt.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StreamLabs USB Watchdog driver
+ *
+ * Copyright (c) 2016-2017,2022 Alexey Klimov <klimov.linux@gmail.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/usb.h>
+#include <linux/watchdog.h>
+#include <asm/byteorder.h>
+
+/*
+ * USB Watchdog device from Streamlabs:
+ * https://www.stream-labs.com/products/devices/watch-dog/
+ *
+ * USB commands have been reverse engineered using usbmon.
+ */
+
+#define DRIVER_AUTHOR "Alexey Klimov <klimov.linux@gmail.com>"
+#define DRIVER_DESC "StreamLabs USB watchdog driver"
+#define DRIVER_NAME "usb_streamlabs_wdt"
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+#define USB_STREAMLABS_WATCHDOG_VENDOR	0x13c0
+#define USB_STREAMLABS_WATCHDOG_PRODUCT	0x0011
+
+/*
+ * one buffer is used for communication, however transmitted message is only
+ * 32 bytes long
+ */
+#define BUFFER_TRANSFER_LENGTH	32
+#define BUFFER_LENGTH		64
+#define USB_TIMEOUT		350	/* 350 ms */
+
+#define STREAMLABS_CMD_START	0xaacc
+#define STREAMLABS_CMD_STOP	0xbbff
+
+/* timeout values are taken from windows program */
+#define STREAMLABS_WDT_MIN_TIMEOUT	1
+#define STREAMLABS_WDT_MAX_TIMEOUT	46
+
+struct streamlabs_wdt {
+	struct watchdog_device wdt_dev;
+	struct usb_interface *intf;
+	/* Serialises usb communication with a device */
+	struct semaphore lock;
+	__le16 buffer[BUFFER_LENGTH] ____cacheline_aligned;
+};
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+/* USB call wrappers to send and receive messages to/from the device. */
+static int usb_streamlabs_send_msg(struct usb_device *usbdev, __le16 *buf)
+{
+	int retval;
+	int size;
+
+	retval = usb_interrupt_msg(usbdev, usb_sndintpipe(usbdev, 0x02),
+				   buf, BUFFER_TRANSFER_LENGTH,
+				   &size, USB_TIMEOUT);
+
+	if (retval)
+		return retval;
+
+	if (size != BUFFER_TRANSFER_LENGTH)
+		return -EIO;
+
+	return 0;
+}
+
+static int usb_streamlabs_get_msg(struct usb_device *usbdev, __le16 *buf)
+{
+	int retval;
+	int size;
+
+	retval = usb_interrupt_msg(usbdev, usb_rcvintpipe(usbdev, 0x81),
+				   buf, BUFFER_LENGTH,
+				   &size, USB_TIMEOUT);
+
+	if (retval)
+		return retval;
+
+	if (size != BUFFER_LENGTH)
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * This function is used to check if watchdog timeout in the received buffer
+ * matches the timeout passed from watchdog subsystem.
+ */
+static int usb_streamlabs_wdt_check_timeout(__le16 *buf, unsigned long timeout)
+{
+	if (buf[3] != cpu_to_le16(timeout))
+		return -EPROTO;
+
+	return 0;
+}
+
+static int usb_streamlabs_wdt_check_response(u8 *buf)
+{
+	/*
+	 * If watchdog device understood the command it will acknowledge
+	 * with values 1,2,3,4 at indexes 10, 11, 12, 13 in response message
+	 * when response treated as 8bit message.
+	 */
+	if (buf[10] != 1 || buf[11] != 2 || buf[12] != 3 || buf[13] != 4)
+		return -EPROTO;
+
+	return 0;
+}
+
+/*
+ * This function is used to check if watchdog command in the received buffer
+ * matches the command passed to the device.
+ */
+static int usb_streamlabs_wdt_check_command(__le16 *buf, u16 cmd)
+{
+	if (buf[0] != cpu_to_le16(cmd))
+		return -EPROTO;
+
+	return 0;
+}
+
+static int usb_streamlabs_wdt_validate_response(__le16 *buf, u16 cmd,
+						unsigned long timeout_msec)
+{
+	int retval;
+
+	retval = usb_streamlabs_wdt_check_response((u8 *)buf);
+	if (retval)
+		return retval;
+
+	retval = usb_streamlabs_wdt_check_command(buf, cmd);
+	if (retval)
+		return retval;
+
+	return usb_streamlabs_wdt_check_timeout(buf, timeout_msec);
+}
+
+static void usb_streamlabs_wdt_prepare_buf(__le16 *buf, u16 cmd,
+					   unsigned long timeout_msec)
+{
+	memset(buf, 0, BUFFER_LENGTH);
+
+	buf[0] = cpu_to_le16(cmd);
+	buf[1] = cpu_to_le16(0x8000);
+	buf[3] = cpu_to_le16(timeout_msec);
+}
+
+static int __usb_streamlabs_wdt_cmd(struct streamlabs_wdt *wdt, u16 cmd)
+{
+	struct usb_device *usbdev;
+	unsigned long timeout_msec;
+	/* how many times to re-try getting the state of the device */
+	unsigned int retry_counter = 10;
+	int retval;
+
+	if (unlikely(!wdt->intf))
+		return -ENODEV;
+
+	usbdev = interface_to_usbdev(wdt->intf);
+	timeout_msec = wdt->wdt_dev.timeout * MSEC_PER_SEC;
+
+	usb_streamlabs_wdt_prepare_buf(wdt->buffer, cmd, timeout_msec);
+
+	/* send command to watchdog */
+	retval = usb_streamlabs_send_msg(usbdev, wdt->buffer);
+	if (retval)
+		return retval;
+
+	/*
+	 * Transition from one state to another in this device
+	 * doesn't happen immediately, especially stopping the device
+	 * is not observed on the first reading of the response.
+	 * Plus to avoid potentially stale response message in the device
+	 * we keep reading the state of the device until we see:
+	 * -- that device recognised the sent command;
+	 * -- the received state (started or stopped) matches the state
+	 * that was requested;
+	 * -- the timeout passed matches the timeout value read from
+	 * the device.
+	 * Keep retrying 10 times and if watchdog device doesn't respond
+	 * correctly as expected we bail out and return an error.
+	 */
+	do {
+		retval = usb_streamlabs_get_msg(usbdev, wdt->buffer);
+		if (retval)
+			break;
+
+		retval = usb_streamlabs_wdt_validate_response(wdt->buffer, cmd,
+							      timeout_msec);
+	} while (retval && retry_counter--);
+
+	return retry_counter ? retval : -EIO;
+}
+
+static int usb_streamlabs_wdt_cmd(struct streamlabs_wdt *streamlabs_wdt, u16 cmd)
+{
+	int retval;
+
+	retval = down_killable(&streamlabs_wdt->lock);
+	if (retval)
+		return retval;
+	retval = __usb_streamlabs_wdt_cmd(streamlabs_wdt, cmd);
+	up(&streamlabs_wdt->lock);
+
+	return retval;
+}
+
+static int usb_streamlabs_wdt_start(struct watchdog_device *wdt_dev)
+{
+	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
+
+	return usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_START);
+}
+
+static int usb_streamlabs_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
+
+	return usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_STOP);
+}
+
+static const struct watchdog_info streamlabs_wdt_ident = {
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity	= DRIVER_NAME,
+};
+
+static const struct watchdog_ops usb_streamlabs_wdt_ops = {
+	.owner	= THIS_MODULE,
+	.start	= usb_streamlabs_wdt_start,
+	.stop	= usb_streamlabs_wdt_stop,
+};
+
+static int usb_streamlabs_wdt_probe(struct usb_interface *intf,
+				    const struct usb_device_id *id)
+{
+	struct usb_device *usbdev = interface_to_usbdev(intf);
+	struct streamlabs_wdt *streamlabs_wdt;
+	int retval;
+
+	/*
+	 * USB IDs of this device appear to be weird/unregistered. Hence, do
+	 * an additional check on product and manufacturer.
+	 * If there is similar device in the field with same values then
+	 * there is stop command in probe() below that checks if the device
+	 * behaves as a watchdog.
+	 */
+	if (!usbdev->product || !usbdev->manufacturer ||
+	    strncmp(usbdev->product, "USBkit", 6) ||
+	    strncmp(usbdev->manufacturer, "STREAM LABS", 11))
+		return -ENODEV;
+
+	streamlabs_wdt = devm_kzalloc(&intf->dev, sizeof(struct streamlabs_wdt),
+				      GFP_KERNEL);
+	if (!streamlabs_wdt)
+		return -ENOMEM;
+
+	sema_init(&streamlabs_wdt->lock, 1);
+
+	streamlabs_wdt->wdt_dev.info = &streamlabs_wdt_ident;
+	streamlabs_wdt->wdt_dev.ops = &usb_streamlabs_wdt_ops;
+	streamlabs_wdt->wdt_dev.timeout = STREAMLABS_WDT_MAX_TIMEOUT;
+	streamlabs_wdt->wdt_dev.max_timeout = STREAMLABS_WDT_MAX_TIMEOUT;
+	streamlabs_wdt->wdt_dev.min_timeout = STREAMLABS_WDT_MIN_TIMEOUT;
+	streamlabs_wdt->wdt_dev.parent = &intf->dev;
+
+	streamlabs_wdt->intf = intf;
+	usb_set_intfdata(intf, &streamlabs_wdt->wdt_dev);
+	watchdog_set_drvdata(&streamlabs_wdt->wdt_dev, streamlabs_wdt);
+	watchdog_set_nowayout(&streamlabs_wdt->wdt_dev, nowayout);
+	watchdog_stop_on_reboot(&streamlabs_wdt->wdt_dev);
+
+	retval = usb_streamlabs_wdt_start(&streamlabs_wdt->wdt_dev);
+	if (retval)
+		return -ENODEV;
+	set_bit(WDOG_HW_RUNNING, &streamlabs_wdt->wdt_dev.status);
+
+	retval = devm_watchdog_register_device(&intf->dev,
+					       &streamlabs_wdt->wdt_dev);
+	if (retval) {
+		dev_err(&intf->dev, "failed to register watchdog device\n");
+		return retval;
+	}
+
+	dev_info(&intf->dev, "StreamLabs USB watchdog driver loaded.\n");
+	return 0;
+}
+
+static int usb_streamlabs_wdt_suspend(struct usb_interface *intf,
+				      pm_message_t message)
+{
+	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
+
+	if (watchdog_active(&streamlabs_wdt->wdt_dev))
+		return usb_streamlabs_wdt_stop(&streamlabs_wdt->wdt_dev);
+
+	return 0;
+}
+
+static int usb_streamlabs_wdt_resume(struct usb_interface *intf)
+{
+	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
+
+	if (watchdog_active(&streamlabs_wdt->wdt_dev))
+		return usb_streamlabs_wdt_start(&streamlabs_wdt->wdt_dev);
+
+	return 0;
+}
+
+static void usb_streamlabs_wdt_disconnect(struct usb_interface *intf)
+{
+	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
+	int retval;
+
+	retval = down_killable(&streamlabs_wdt->lock);
+	if (retval) {
+		dev_warn(&intf->dev,
+			 "failed to acquire semaphore in disconnect\n");
+		return;
+	}
+
+	/*
+	 * If disconnect happens via sysfs or on rmmod, then try to stop
+	 * the watchdog. In case of physical detachment of the device this call
+	 * will fail but we continue.
+	 */
+	if (!nowayout)
+		__usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_STOP);
+
+	/* Stop sending (new) messages to the device */
+	streamlabs_wdt->intf = NULL;
+	up(&streamlabs_wdt->lock);
+}
+
+static int usb_streamlabs_wdt_pre_reset(struct usb_interface *intf)
+{
+	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
+	int retval;
+
+	retval = down_killable(&streamlabs_wdt->lock);
+	if (retval) {
+		dev_warn(&intf->dev,
+			 "failed to acquire semaphore in pre_reset\n");
+		return retval;
+	}
+
+	if (watchdog_active(&streamlabs_wdt->wdt_dev)) {
+		retval =  __usb_streamlabs_wdt_cmd(streamlabs_wdt,
+						   STREAMLABS_CMD_STOP);
+		/*
+		 * If ->pre_reset() callback fails, the ->disconnect()
+		 * callback will be called. To let it work we should
+		 * unlock semaphore here.
+		 */
+		if (retval)
+			up(&streamlabs_wdt->lock);
+	}
+
+	return retval;
+}
+
+static int usb_streamlabs_wdt_post_reset(struct usb_interface *intf)
+{
+	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
+	int retval = 0;
+
+	/* FIXME: potential race here, watchdog_active() check is unreliable? */
+	if (watchdog_active(&streamlabs_wdt->wdt_dev))
+		retval = __usb_streamlabs_wdt_cmd(streamlabs_wdt,
+						  STREAMLABS_CMD_START);
+
+	up(&streamlabs_wdt->lock);
+
+	return retval;
+}
+
+static const struct usb_device_id usb_streamlabs_wdt_device_table[] = {
+	{ USB_DEVICE(USB_STREAMLABS_WATCHDOG_VENDOR, USB_STREAMLABS_WATCHDOG_PRODUCT) },
+	{ }	/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, usb_streamlabs_wdt_device_table);
+
+static struct usb_driver usb_streamlabs_wdt_driver = {
+	.name		= DRIVER_NAME,
+	.probe		= usb_streamlabs_wdt_probe,
+	.disconnect	= usb_streamlabs_wdt_disconnect,
+	.suspend	= usb_streamlabs_wdt_suspend,
+	.resume		= usb_streamlabs_wdt_resume,
+	.reset_resume	= usb_streamlabs_wdt_resume,
+	.pre_reset	= usb_streamlabs_wdt_pre_reset,
+	.post_reset	= usb_streamlabs_wdt_post_reset,
+	.id_table	= usb_streamlabs_wdt_device_table,
+	.soft_unbind	= 1,
+};
+
+module_usb_driver(usb_streamlabs_wdt_driver);
--
2.37.2

