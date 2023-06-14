Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04B72F2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbjFNCzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFNCzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:55:21 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC779CE;
        Tue, 13 Jun 2023 19:55:17 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-75d4dd6f012so158445685a.2;
        Tue, 13 Jun 2023 19:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686711317; x=1689303317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YPnRRcHhBNbs+KK4VIGU1jNHdY31UbBB44IEfNrzuo=;
        b=HIr90zUI1BxGax5BbT1Q4j3MQtxMWyOipWD6/9JRkaHhHxbrhup/N6iqv4lY6qdSyP
         VGh8mWEg+OPbMcSF+WzJJq5JjSeN7kp+8XCirBZqxxdAL+F/vh3kdwXd4bqAPqkZRHy3
         eH7ruTzgTLeP8wyRinMoDfDFAZV94YYyAcFdNjUavWehZpaktDPJJR+ugqVP1Z5+ky4D
         f4uDJoyP5AYB8a2Daxf5VBw2BpeM9/q31eilEdUyKhBcPEUY5C8sC2b0A2Qb370fWirA
         oQkQrhHYwgNkxTQ1GjD71UOMN0bYdlngy5FAaF1mouclJVsCNmTeo7YQzfX8mc5Dquj5
         I7LA==
X-Gm-Message-State: AC+VfDzBElP0YOtOxRn4LjO69urAeCf/nj96D/v6iHsjIA17An8Yr770
        R742cVfMXM5LS70VEoQwXtbnNKfWzstBWJEkG2g=
X-Google-Smtp-Source: ACHHUZ7yqNP8I4eSJqFv7bltvLxbmGlAZ7wq9OR8fgcMSV5AC7FE2OejdFISSStxIDjRR6YxUHlp6w==
X-Received: by 2002:a05:620a:22f4:b0:75d:8730:737 with SMTP id p20-20020a05620a22f400b0075d87300737mr12267017qki.9.1686711316571;
        Tue, 13 Jun 2023 19:55:16 -0700 (PDT)
Received: from localhost ([2408:8453:618:be32:38fd:fa17:36d3:1eb9])
        by smtp.gmail.com with ESMTPSA id f11-20020aa782cb000000b00571cdbd0771sm9293073pfn.102.2023.06.13.19.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:55:15 -0700 (PDT)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, corbet@lwn.net
Cc:     rdunlap@infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, xy521521@gmail.com,
        oe-kbuild-all@lists.linux.dev, lkp@intel.com, bagasdotme@gmail.com,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [RESEND PATCH v4 -next] tty: serial: add panic serial helper
Date:   Wed, 14 Jun 2023 10:55:12 +0800
Message-Id: <20230614025512.27746-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was inspired by kgdboc.

This is a debug module that allows you to get all kernel logs
after panic.

Normally you need to attach a USB-to-UART tool or enable kdump
before panic happens to get log from kernel after panic. If you
didn't do that and kdump is not working, you can't get any log to
know what happened before panic. If you have a USB-to-UART tool
and the UART port on your computer is working. This module helps
you to get all kernel log after panic() is called.

To use this, see Documentation/dev-tools/panic_serial_helper.rst.

Tested on an arm64 device.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---

v4: fix some syntax problems in Documentation.

v3: fix problems in Documentation reported by
kernel test robot <lkp@intel.com>.

v2: replace uart with UART for consistency.

 Documentation/dev-tools/index.rst             |   1 +
 .../dev-tools/panic_serial_helper.rst         | 138 ++++
 MAINTAINERS                                   |   5 +
 drivers/tty/serial/Kconfig                    |  25 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/panic_serial_helper.c      | 619 ++++++++++++++++++
 include/linux/panic.h                         |   1 +
 kernel/panic.c                                |  12 +
 8 files changed, 802 insertions(+)
 create mode 100644 Documentation/dev-tools/panic_serial_helper.rst
 create mode 100644 drivers/tty/serial/panic_serial_helper.c

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 6b0663075dc0..0655528e5a83 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -34,6 +34,7 @@ Documentation/dev-tools/testing-overview.rst
    kselftest
    kunit/index
    ktap
+   panic_serial_helper
 
 
 .. only::  subproject and html
diff --git a/Documentation/dev-tools/panic_serial_helper.rst b/Documentation/dev-tools/panic_serial_helper.rst
new file mode 100644
index 000000000000..d3c177f56bc4
--- /dev/null
+++ b/Documentation/dev-tools/panic_serial_helper.rst
@@ -0,0 +1,138 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================================
+Using panic serial helper to get kernel logs after panic
+========================================================
+
+:Author: Hongyu Xie <xiehongyu1@kylinos.cn>
+
+What is this?
+=============
+
+A debug module inspired by kgdboc that allows you to get all kernel logs
+after panic.
+
+Why do you need it?
+===================
+
+There are many debugging methods to know what was going on before panic.
+
+The firs is Kdump. When it is enabled, you can get a core image after
+panic. Then use GDB or Crash to debug that core image to know what happened
+before panic (see ``Documentation/admin-guide/kdump/kdump.rst`` for Kdump
+documentation).
+
+Another way is to connect the UART side of a USB-to-UART tool to the
+debugging UART port (normally a 3 pin slot on the motherborad or a RS232
+port on the back panel of your PC) before panic happens. Then connect the
+USB side of a USB-to-UART tool to another PC. You can read all the kernel
+logs coming from that UART port through apps like minicom on another PC.
+So when panic happens you'll know what was going on.
+
+What if Kdump hasn't been enabled? And people don't always connect an
+USB-to-UART device while he/she is using the PC. When panic occurs, it's
+too late to connect the USB-to-UART device.
+
+For both situations, you can use panic_serial_helper module to get all
+necessary kernel logs once it is loaded.
+
+How to use it?
+==============
+
+Prerequisites
+--------------
+
+1. Same as kgdboc, the UART driver must implement two callbacks in the
+   struct uart_ops. See Documentation/dev-tools/kgdb.rst for details.
+
+2. Your PC has an UART port and it's working.
+
+How
+--------------
+
+First you need to enable ``CONFIG_PANIC_SERIAL_HELPER`` in your
+config. To enable it go to
+:menuselection:`Device Drivers-->Character devices-->Enable TTY (TTY [=y])-->Serial drivers`
+and select :menuselection:`debug through UART after panic`.
+
+Then build and deploy the kernel as usual.
+
+When the panic occurs, you need to do the following:
+
+1. connect the UART side of an USB-to-UART tool to any UART
+   port on your device (PC, server, Laptop, etc...).
+   Connect the USB side of that tool to another PC. Open
+   minicom (or other app) on that PC, and set "/dev/ttyUSB0"(or
+   "/dev/ttyUSB1 if there is already another USB-to-UART tool
+   connected to your device) with "115200 8N1".
+
+   It automatically selects the port where you first press the
+   "Enter" key (some keyboard labeled this with "Return").
+
+2. Press Enter and the help menu will appear::
+
+    help:
+
+        -a      show all kernel msg
+
+        -3      show S3 msg
+
+        -4      show S4 msg
+
+        -filter-[string]        show msg containing [string]
+
+        -q-     quit
+
+see ``Help menu options`` for details.
+
+3. Select one of above options and happy hacking!
+
+Help menu options
+-----------------
+Available options:
+
+ - a
+
+   Show all the messages starting from ``Booting Linux on ...``
+
+ - 3
+
+   If STR happened before panic, this will show messages starting from
+   ``PM: suspend entry...``
+
+ - 4
+
+   If STD happened before panic, this will show messages starting from
+   ``PM: hibernation entry...``
+
+ - filter-[string]
+
+   Provide case-ignored filter matching. For example, if you'd like to see
+   message lines that contain ``CPU`` or ``cpu``, you can pass either
+   ``filter-CPU`` or ``filter-cpu``. The corresponding output would be
+   like::
+
+     <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x701f6633
+     <6>[    0.000000] Detected PIPT I-cache on CPU0
+     <6>[    0.000000] CPU features: detected: Kernel page table isolation (K
+
+     ...
+
+     <6>[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000
+     <6>[    0.002411] smp: Bringing up secondary CPUs ...
+     <6>[    0.039105] Detected PIPT I-cache on CPU1
+
+     ...
+
+     <4>[    6.432129] CPU: 3 PID: 392 Comm: (crub_all) Tainted: G        W
+     <4>[    6.560279] CPU: 2 PID: 478 Comm: (ostnamed) Tainted: G        W
+
+     ...
+
+     <4>[  225.297828] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W
+     <2>[  225.297909] SMP: stopping secondary CPUs
+     <0>[  225.297919] CPU features: 0x000000,02000800,0400421b
+
+ - q
+
+   Return to help menu.
diff --git a/MAINTAINERS b/MAINTAINERS
index 74aeae10a151..73fcae8c2f39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15972,6 +15972,11 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/panasonic-laptop.c
 
+PANIC SERIAL CONSOLE
+M:	Hongyu Xie <xiehongyu1@kylinos.cn>
+F:	drivers/tty/serial/panic_serial_helper.c
+F:	drivers/tty/serial/panic_serial_helper.h
+
 PARALLAX PING IIO SENSOR DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3e3fb377d90d..796441b58498 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -198,6 +198,31 @@ config SERIAL_KGDB_NMI
 
 	  If unsure, say N.
 
+config PANIC_SERIAL_HELPER
+	tristate "debug through UART after panic"
+	depends on PANIC_TIMEOUT=0
+	select CONSOLE_POLL
+	help
+	  This is a debug module that allows you to get all kernel logs
+	  after panic.
+
+	  Normally you need to attach a USB-to-UART tool or enable kdump
+	  before panic happens to get log from kernel after panic. If you
+	  didn't do that and kdump is not working, you can't get any log to
+	  know what happened before panic. If you have a USB-to-UART tool
+	  and the UART port on your computer is working, this module helps
+	  you to get all kernel log after panic() is called.
+
+	  This module uses serial port in poll mode, so it's more stable
+	  than other debugging methods.
+
+	  Read <file:Documentation/dev-tools/panic_serial_helper.rst> for
+	  usage.
+
+	  Say Y if you have a working UART port and you want to gather
+	  kernel logs. To compile this as module (which will be called
+	  panic_serial_helper), say M. If unsure, say N.
+
 config SERIAL_MESON
 	tristate "Meson serial port support"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 531ec3a19dae..d7f6fdc8913c 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -93,3 +93,4 @@ obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
 
 obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
+obj-$(CONFIG_PANIC_SERIAL_HELPER) += panic_serial_helper.o
diff --git a/drivers/tty/serial/panic_serial_helper.c b/drivers/tty/serial/panic_serial_helper.c
new file mode 100644
index 000000000000..1d3d57bc6340
--- /dev/null
+++ b/drivers/tty/serial/panic_serial_helper.c
@@ -0,0 +1,619 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * panic_serial_helper.c Debug through UART when panic.
+ *
+ * Copyright (C) 2023 Xie Hongyu <xiehongyu1@kylinos.cn>
+ *
+ * Inspired by kgdboc.
+ *
+ */
+
+#define MODULE_NAME "panic_serial_helper"
+#define pr_fmt(fmt) MODULE_NAME ": " fmt
+
+#include <linux/kmsg_dump.h>
+#include <linux/bsearch.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/tty_driver.h>
+#include <linux/serial_core.h>
+#include <linux/string.h>
+
+#define S3_ENTRY "PM: suspend entry"
+#define S3_EXIT "PM: suspend exit"
+#define S4_ENTRY "PM: hibernation entry"
+#define S4_EXIT "PM: hibernation exit"
+
+/* list to store msg lines */
+static LIST_HEAD(psh_list);
+
+/* msg line prototype */
+struct dmesg_lines {
+	struct list_head entry;
+	char *buf;
+	int size;
+};
+
+/* panic serial helper status*/
+enum PSHS {
+	PSHS_INIT,
+	PSHS_WAIT_HELP_INPUT,
+};
+
+/* panic serial helper msg type */
+enum PSHM_TYPE {
+	PSHM_TYPE_ALL,
+	PSHM_TYPE_S3,
+	PSHM_TYPE_S4,
+	PSHM_TYPE_STRINGS,
+	PSHM_TYPE_QUIT,
+};
+
+/* whether UART is dumping msg */
+static bool dumping_msg;
+
+/* to filter msg */
+static char filter[256] = {0};
+
+struct psh_buf {
+#define PSH_BUF_SIZE 256
+	char buf[PSH_BUF_SIZE];
+	int cur;
+};
+
+static const char psh_tty_types[][32] = {
+	{"ttyAMA"},
+	{"ttyS"},
+	{"ttyPS"},
+	{"ttyLP"},
+	{"ttyARC"},
+	{"ttyAL"},
+	{"ttyUL"},
+};
+
+#define TTY_OPS "115200n8n"
+
+struct psh_serial_dev {
+	struct list_head entry;
+	struct tty_driver *drv;
+	struct psh_buf buf;
+	enum PSHS psh_status;
+	enum PSHM_TYPE psh_msg_type;
+	int line;
+};
+
+struct psh_serial_dev *psh_dev;
+
+/* char handler prototype */
+struct c_handler {
+	char c;
+	int (*handler)(struct psh_serial_dev *dev, void *d);
+};
+
+/* case-ignored matching */
+static char *psh_strcasestr(char *b, char *f)
+{
+	char *tb = b, *tf = f;
+	int b_l = 0;
+	int f_l = 0;
+	int i = 0, l = 0;
+
+	if (!b || !f)
+		return NULL;
+
+	b_l = strlen(b);
+	f_l = strlen(f);
+	if (f_l > b_l)
+		return NULL;
+
+	l = b_l;
+	while (l-- >= 0) {
+		if (tb[0] == tf[0]) {
+			i++;
+			if (i == f_l)
+				return tb - i + 1;
+			tb += 1;
+			tf += 1;
+			continue;
+		} else if ((('a' <= tb[0] && tb[0] <= 'z') ||
+			('A' <= tb[0] && tb[0] <= 'Z')) &&
+			(('a' <= tf[0] && tf[0] <= 'z') ||
+			('A' <= tf[0] && tf[0] <= 'Z'))) {
+			if (((tb[0] - 'A') == (tf[0] - 'a')) ||
+				((tb[0] - 'a') == (tf[0] - 'A'))) {
+				i++;
+				if (i == f_l)
+					return tb - i + 1;
+
+				tb += 1;
+				tf += 1;
+				continue;
+			}
+		}
+		tb += 1;
+		tf = f;
+		i = 0;
+	}
+	return NULL;
+}
+
+static struct psh_buf *psh_get_rx_buffer(struct psh_serial_dev *dev)
+{
+	return !dev ? NULL : &dev->buf;
+}
+
+static int psh_poll_get_char(struct psh_serial_dev *dev)
+{
+	if (!dev || !dev->drv)
+		return -EINVAL;
+
+	return dev->drv->ops->poll_get_char(dev->drv, dev->line);
+}
+
+static void psh_poll_put_char(struct psh_serial_dev *dev, u8 c)
+{
+	if (!dev || !dev->drv)
+		return;
+
+	dev->drv->ops->poll_put_char(dev->drv,
+					dev->line, c);
+}
+
+static void psh_clear_rx_buffer(struct psh_serial_dev *dev)
+{
+	struct psh_buf *_buf = psh_get_rx_buffer(dev);
+
+	if (!_buf)
+		return;
+
+	_buf->cur = 0;
+	memset(_buf->buf, 0, sizeof(_buf->buf));
+}
+
+static int psh_getc(struct psh_serial_dev *dev)
+{
+	return psh_poll_get_char(dev);
+}
+
+static void psh_putc(struct psh_serial_dev *dev, char c)
+{
+	psh_poll_put_char(dev, c);
+}
+
+static void psh_put_strings(struct psh_serial_dev *dev, const char *buf, int size)
+{
+	int i = 0;
+
+	while (i < size) {
+		psh_putc(dev, buf[i]);
+		i++;
+	}
+}
+
+static void psh_help(struct psh_serial_dev *dev)
+{
+	static const char help[] = "\nhelp:\n";
+	static const char show_all[] = "\t-a\tshow all kernel msg\n";
+	static const char show_s3[] = "\t-3\tshow S3 msg\n";
+	static const char show_s4[] = "\t-4\tshow S4 msg\n";
+	static const char _filter[] =
+		"\t-filter-[string]\tshow msg contains [string]\n";
+	static const char _quit[] = "\t-q-\tquit\n";
+
+	psh_put_strings(dev, help, strlen(help));
+	psh_put_strings(dev, show_all, strlen(show_all));
+	psh_put_strings(dev, show_s3, strlen(show_s3));
+	psh_put_strings(dev, show_s4, strlen(show_s4));
+	psh_put_strings(dev, _filter, strlen(_filter));
+	psh_put_strings(dev, _quit, strlen(_quit));
+}
+
+static void psh_dump_msg(struct psh_serial_dev *dev)
+{
+	struct dmesg_lines *p;
+	bool print = false;
+	char *start = NULL;
+	char *end = NULL;
+
+	if (!dev)
+		return;
+
+	dumping_msg = true;
+	switch (dev->psh_msg_type) {
+	case PSHM_TYPE_ALL:
+		print = true;
+		break;
+	case PSHM_TYPE_S3:
+		start = S3_ENTRY;
+		end = S3_EXIT;
+		break;
+	case PSHM_TYPE_S4:
+		start = S4_ENTRY;
+		end = S4_EXIT;
+		break;
+	case PSHM_TYPE_STRINGS:
+		start = filter;
+		end = NULL;
+		break;
+	default:
+		return;
+	}
+
+	psh_putc(dev, '\n');
+	list_for_each_entry_reverse(p, &psh_list, entry) {
+		if (print || (start && psh_strcasestr(p->buf,
+				start))) {
+			psh_put_strings(dev, p->buf, p->size);
+			if (dev->psh_msg_type != PSHM_TYPE_STRINGS)
+				print = true;
+		}
+
+		if (end && psh_strcasestr(p->buf, end))
+			print = false;
+	}
+
+	dumping_msg = false;
+}
+
+static int psh_parse_help_ops(struct psh_serial_dev *dev)
+{
+	char _filter[] = "filter-";
+	struct psh_buf *_buf = psh_get_rx_buffer(dev);
+
+	if (!_buf)
+		return -EINVAL;
+
+	switch (_buf->buf[0]) {
+	case 'a':
+		dev->psh_msg_type = PSHM_TYPE_ALL;
+		break;
+	case '3':
+		dev->psh_msg_type = PSHM_TYPE_S3;
+		break;
+	case '4':
+		dev->psh_msg_type = PSHM_TYPE_S4;
+		break;
+	case 'q':
+		dev->psh_msg_type = PSHM_TYPE_QUIT;
+		break;
+	case 'f':
+		psh_put_strings(dev, _filter, strlen(_filter));
+		psh_putc(dev, '\r');
+		psh_put_strings(dev, _buf->buf, _buf->cur);
+		psh_putc(dev, '\r');
+		if (!strncmp(_buf->buf, _filter, strlen(_filter))) {
+			dev->psh_msg_type =
+				PSHM_TYPE_STRINGS;
+			memset(filter, 0, sizeof(filter));
+			memcpy(filter, &_buf->buf[strlen(_filter)],
+				strlen(_buf->buf) - strlen(_filter));
+		}
+		break;
+	default:
+		break;
+	}
+
+	return dev->psh_msg_type;
+}
+
+static int psh_serial_backspace_handler(struct psh_serial_dev *dev, void *buf)
+{
+	struct psh_buf *_buf = psh_get_rx_buffer(dev);
+
+	if (!_buf)
+		return -EINVAL;
+
+
+	if (_buf->cur > 0) {
+		_buf->cur -= 1;
+		_buf->buf[_buf->cur] = 0;
+	}
+
+	psh_putc(dev, '\b');
+	psh_putc(dev, ' ');
+	psh_putc(dev, '\b');
+	return 0;
+}
+
+static int psh_serial_enter_handler(struct psh_serial_dev *dev, void *buf)
+{
+	bool help = false;
+
+	if (!dev || !buf)
+		return -EINVAL;
+
+	switch (dev->psh_status) {
+	case PSHS_INIT:
+		dev->psh_status = PSHS_WAIT_HELP_INPUT;
+		help = true;
+		psh_dev = dev;
+		break;
+	case PSHS_WAIT_HELP_INPUT:
+		if (psh_parse_help_ops(dev) != PSHM_TYPE_QUIT)
+			psh_dump_msg(dev);
+		else
+			help = true;
+		break;
+	default:
+		break;
+	}
+
+	if (help)
+		psh_help(dev);
+
+	psh_clear_rx_buffer(dev);
+	return 0;
+}
+
+static struct c_handler c_handlers[] = {
+	{'\b', psh_serial_backspace_handler},
+	{'\r', psh_serial_enter_handler},
+};
+
+static int c_handles_cmp(const void *key, const void *elt)
+{
+	const int *c = (int *)key;
+	const struct c_handler *e = (struct c_handler *)elt;
+
+	if (*c < e->c)
+		return -1;
+	else if (*c > e->c)
+		return 1;
+
+	return 0;
+}
+
+static void psh_buffer_input(struct psh_serial_dev *dev, int c)
+{
+	struct psh_buf *_buf = psh_get_rx_buffer(dev);
+
+	if (!_buf)
+		return;
+
+	if ((_buf->cur >= sizeof(_buf->buf)) || (_buf->cur < 0))
+		_buf->cur = 0;
+
+	_buf->buf[_buf->cur] = (char)c;
+	_buf->cur++;
+}
+
+static int psh_serial_check_char(struct psh_serial_dev *dev, int ch)
+{
+	struct c_handler *found = NULL;
+	int c = ch;
+
+	size_t num = sizeof(c_handlers) / sizeof(struct c_handler);
+
+	found = bsearch(&c, c_handlers, num,
+			sizeof(struct c_handler), c_handles_cmp);
+	if (found)
+		return found->handler(dev, &c);
+
+	psh_putc(dev, ch);
+	psh_buffer_input(dev, ch);
+
+	return 1;
+}
+
+static int psh_wait_for_input(struct psh_serial_dev *dev)
+{
+	int c_input = psh_getc(dev);
+
+	if (c_input < 0 || c_input > 127) {
+		mdelay(1);
+		return c_input;
+	}
+
+	return psh_serial_check_char(dev, c_input);
+}
+
+static int psh_msg(struct psh_serial_dev *dev)
+{
+	int ret = 0;
+
+	if (!dumping_msg)
+		ret = psh_wait_for_input(dev);
+
+	return ret;
+}
+
+static struct psh_serial_dev *create_psh_serial_dev(struct uart_driver *drv,
+	int line)
+{
+	struct psh_serial_dev *dev = NULL;
+	struct uart_port *uport = NULL;
+	struct uart_state *state = NULL;
+	struct tty_driver *p = drv->tty_driver;
+
+	state = drv->state + line;
+	uport = state->uart_port;
+	if (!uport)
+		goto err;
+
+	dev = kzalloc(sizeof(struct psh_serial_dev),
+		GFP_KERNEL);
+	if (!dev)
+		goto err;
+
+	dev->buf.cur = 0;
+	dev->drv = p;
+	dev->line = line;
+	dev->psh_status = PSHS_INIT;
+	dev->psh_msg_type = PSHM_TYPE_QUIT;
+	return dev;
+err:
+	return NULL;
+}
+
+/* find UART driver by name */
+static struct uart_driver *psh_find_uart_driver(char *name)
+{
+	struct tty_driver *p = NULL;
+	struct uart_driver *drv = NULL;
+	int tty_line;
+
+	p = tty_find_polling_driver(name, &tty_line);
+	if (!p) {
+		pr_debug("no such tty driver %s\n",
+			name);
+		goto out;
+	}
+
+	drv = (struct uart_driver *)p->driver_state;
+	if (!drv) {
+		pr_debug("no uart_driver %s\n",
+			name);
+		tty_driver_kref_put(p);
+	}
+
+out:
+	return drv;
+}
+
+/* try all UART port under the same driver */
+static int psh_try_all_uart_port(struct uart_driver *drv)
+{
+	struct psh_serial_dev *dev = NULL;
+	struct uart_driver *driver = NULL;
+	char drv_name[64] = {0};
+	int count = 10000;
+	int i = 0, nr = drv->nr;
+
+	for (i = 0; i < nr; i++) {
+		memset(drv_name, 0, sizeof(drv_name));
+		snprintf(drv_name, sizeof(drv_name), "%s%d,%s",
+			drv->driver_name,
+			i, TTY_OPS);
+
+		driver = psh_find_uart_driver(drv_name);
+		if (!driver)
+			continue;
+
+		dev = create_psh_serial_dev(driver, i);
+		if (!dev) {
+			tty_driver_kref_put(driver->tty_driver);
+			driver = NULL;
+			continue;
+		}
+
+		count = 10000;
+		while (count-- > 0) {
+			psh_wait_for_input(dev);
+
+			if (psh_dev)
+				return 0;
+		}
+
+		tty_driver_kref_put(driver->tty_driver);
+		driver = NULL;
+		kfree(dev);
+		dev = NULL;
+	}
+
+	return -1;
+}
+
+/* try all UART driver */
+static int psh_try_all_uart_driver(void)
+{
+	struct uart_driver *drv = NULL;
+	char drv_name[64] = {0};
+	int i = 0;
+
+	for (i = 0; i < ARRAY_SIZE(psh_tty_types); i++) {
+		memset(drv_name, 0, sizeof(drv_name));
+		snprintf(drv_name, sizeof(drv_name), "%s0,%s",
+		psh_tty_types[i], TTY_OPS);
+
+		drv = psh_find_uart_driver(drv_name);
+		if (!drv)
+			continue;
+
+		if (!psh_try_all_uart_port(drv)) {
+			tty_driver_kref_put(drv->tty_driver);
+			return 0;
+		}
+
+		tty_driver_kref_put(drv->tty_driver);
+		drv = NULL;
+	}
+
+	return 0;
+}
+
+static int dump_dmsg(void)
+{
+	if (!psh_dev)
+		return psh_try_all_uart_driver();
+
+	return psh_msg(psh_dev);
+}
+
+static void panic_serial_dump(struct kmsg_dumper *dumper,
+			enum kmsg_dump_reason reason)
+{
+	struct kmsg_dump_iter iter;
+	static char line[1024];
+	size_t len = 0;
+	struct dmesg_lines *p = NULL;
+
+	panic_serial_helper = dump_dmsg;
+
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, true, line, sizeof(line), &len)) {
+		p = kzalloc(sizeof(struct dmesg_lines), GFP_KERNEL);
+		if (!p)
+			continue;
+
+		INIT_LIST_HEAD(&p->entry);
+		p->buf = kzalloc(len + 1, GFP_KERNEL);
+		if (!p->buf) {
+			kfree(p);
+			p = NULL;
+			continue;
+		}
+
+		memcpy(p->buf, line, len);
+		p->buf[len] = '\0';
+		p->size = len;
+		list_add(&p->entry, &psh_list);
+	}
+}
+
+static struct kmsg_dumper panic_serial_dumper = {
+	.dump = panic_serial_dump,
+};
+
+static void __exit panic_serial_helper_exit(void)
+{
+	struct dmesg_lines *line;
+
+	kmsg_dump_unregister(&panic_serial_dumper);
+	list_for_each_entry_reverse(line, &psh_list, entry) {
+		kfree(line->buf);
+		line->buf = NULL;
+		kfree(line);
+		line = NULL;
+	}
+
+	tty_driver_kref_put(psh_dev->drv);
+	kfree(psh_dev);
+}
+
+static int __init panic_serial_helper_init(void)
+{
+	long err = 0;
+
+	err = kmsg_dump_register(&panic_serial_dumper);
+	if (err)
+		pr_info("panic_serial_dumper register failed\n");
+
+	return err;
+}
+
+module_init(panic_serial_helper_init);
+module_exit(panic_serial_helper_exit);
+MODULE_AUTHOR("Hongyu Xie <xiehongyu1@kylinos.cn>");
+MODULE_DESCRIPTION("debug through UART when panic");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 6717b15e798c..90dc2fa99969 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -8,6 +8,7 @@
 struct pt_regs;
 
 extern long (*panic_blink)(int state);
+extern int (*panic_serial_helper)(void);
 __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
 void nmi_panic(struct pt_regs *regs, const char *msg);
diff --git a/kernel/panic.c b/kernel/panic.c
index 10effe40a3fa..3086e67e75ca 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -134,10 +134,18 @@ static long no_blink(int state)
 	return 0;
 }
 
+static int no_panic_serial_helper(void)
+{
+	return 0;
+}
+
 /* Returns how long it waited in ms */
 long (*panic_blink)(int state);
 EXPORT_SYMBOL(panic_blink);
 
+int (*panic_serial_helper)(void);
+EXPORT_SYMBOL(panic_serial_helper);
+
 /*
  * Stop ourself in panic -- architecture code may override this
  */
@@ -400,6 +408,9 @@ void panic(const char *fmt, ...)
 	if (!panic_blink)
 		panic_blink = no_blink;
 
+	if (!panic_serial_helper)
+		panic_serial_helper = no_panic_serial_helper;
+
 	if (panic_timeout > 0) {
 		/*
 		 * Delay timeout seconds before rebooting the machine.
@@ -449,6 +460,7 @@ void panic(const char *fmt, ...)
 			i += panic_blink(state ^= 1);
 			i_next = i + 3600 / PANIC_BLINK_SPD;
 		}
+		panic_serial_helper();
 		mdelay(PANIC_TIMER_STEP);
 	}
 }
-- 
2.34.1

