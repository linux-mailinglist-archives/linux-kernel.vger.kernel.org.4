Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F327064F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEQKOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjEQKOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:14:35 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17934C3D;
        Wed, 17 May 2023 03:14:30 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1aaea43def7so5208595ad.2;
        Wed, 17 May 2023 03:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684318470; x=1686910470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+hD44ykF8wSz7LDDbcz9xlzND91wuWk4tyOCQtPLDo=;
        b=WNscKMBH6cU0BOPeMggHKfM7mUsm6vQiHbmDtjX7nTy7uvQP/2Eb4dQmIkLfaTUvJm
         CwfeDiR3hus+NAK1+pws+OSf+dB9Jt9rwVy+3ort4NEAI6xrKqdK1UPEqZ5SuRNLPJGz
         76nYGl9Zd1nLBsW+ytiUm6s8e8kWNyY2S+F1/rrMcE2gDQzxGi36kYMJrJ0z65IDZxmt
         MPDKKssty0c60Ppg9wcyeah5S8lkYeQicmvmuVD6RwAfffvhTh21rtwS8Gv1wgrHH4RE
         Xs9jj/24OAINrneNH6IVA9HNUsX2dRB5IT6w6RgYKJjGN+kb+b24jbc6jQIYf6p4v3FK
         ZaUg==
X-Gm-Message-State: AC+VfDxjaf2fsUfaoDV/SowLkEMm79OZevp/7OBMoW8Ma1IB6uXAukt4
        Y/fLfIZRtQYBdMJi9tIlycY=
X-Google-Smtp-Source: ACHHUZ7laVUNaXMGS86cqHoVsqR5++wTb3zhlVGbUppyEY/JF52l6T8wdcbHwTW40P3a92w9XyTfNQ==
X-Received: by 2002:a17:902:ea11:b0:1ac:7f56:de04 with SMTP id s17-20020a170902ea1100b001ac7f56de04mr40374396plg.45.1684318469950;
        Wed, 17 May 2023 03:14:29 -0700 (PDT)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b001ab0669d84csm17164104plk.26.2023.05.17.03.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:14:29 -0700 (PDT)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        xy521521@gmail.com, Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [RFC PATCH -next] tty: serial: add panic serial helper
Date:   Wed, 17 May 2023 18:14:03 +0800
Message-Id: <20230517101403.232594-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was inspired by kgdboc.

Normally you need to attach a debug tool (usually an USB-to-UART device)
or enable kdump before panic happens to get log from kernel after panic.
If you didn't attach a debug device before panic and kdump is not working,
you might not get any log from kernel.

If you do have a USB-to-UART device and the uart port on your
computer is working. This module helps to get all kernel logs after
panic() is called.

It automatically selects the port where you typing the keyword. This is
for those devices with more than 1 uart port and sometimes you need to
disassemble the device to use the console-uart port, now you can use any
uart port on the device after panic.

This module use serial port in poll mode, more stable than other debugging
methods.

It works like this:
    1.Attach the uart side of an USB-to-UART tool to any uart port on your
    device after panic. Attach the USB side of that tool to another PC.
    Open minicom(or other app) on that PC, set /dev/ttyUSB0 with
    "115200 8N1".

    2.press "Enter", you'll get something like,

    "
    wrong password
    Panic now, please input keyword to debug
    "

    3.type "123456" and press "Enter" will prompt a help menu.
    "
    help:
        -a      show all kernel msg
        -3      show S3 msg
        -4      show S4 msg
        -filter-[string]        show msg contains [string]
        -q-     quit
    "

    4.Finally type 'a', '3', '4', 'q' or "filter-xxx" to get what you want.

Tested on an arm64 PC with 6.4.0-rc2.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 MAINTAINERS                              |   5 +
 drivers/tty/serial/Kconfig               |  11 +
 drivers/tty/serial/Makefile              |   1 +
 drivers/tty/serial/panic_serial_helper.c | 635 +++++++++++++++++++++++
 drivers/tty/serial/panic_serial_helper.h |  12 +
 include/linux/panic.h                    |   1 +
 kernel/panic.c                           |  12 +
 7 files changed, 677 insertions(+)
 create mode 100644 drivers/tty/serial/panic_serial_helper.c
 create mode 100644 drivers/tty/serial/panic_serial_helper.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bd0f510f744..951c6804b3cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11552,6 +11552,11 @@ F:	include/linux/kgdb.h
 F:	kernel/debug/
 F:	kernel/module/kdb.c
 
+PANIC SERIAL CONSOLE
+M:	Hongyu Xie <xiehongyu1@kylinos.cn>
+F:	drivers/tty/serial/panic_serial_helper.c
+F:	drivers/tty/serial/panic_serial_helper.h
+
 KHADAS MCU MFD DRIVER
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 L:	linux-amlogic@lists.infradead.org
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 398e5aac2e77..f890f3e3e334 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -198,6 +198,17 @@ config SERIAL_KGDB_NMI
 
 	  If unsure, say N.
 
+config PANIC_SERIAL_HELPER
+	tristate "debug through uart when panic"
+	depends on PANIC_TIMEOUT=0
+	select CONSOLE_POLL
+	default m
+	help
+	    Debug through uart when kernel panic happens.
+	    This module helps you to get full kernel message through uart.
+	    Say Y if you want add this to built-in kernel.
+	    Say M if you want add this as a module driver.
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
index 000000000000..c9d8cf4d146d
--- /dev/null
+++ b/drivers/tty/serial/panic_serial_helper.c
@@ -0,0 +1,635 @@
+// SPDX-License-Identifier: GPL
+/*
+ * panic_serial_helper.c Debug through uart when panic.
+ *
+ * Copyright (C) 2023 Xie Hongyu <xiehongyu1@kylinos.cn>
+ *
+ * Inspired by kgdboc.
+ *
+ */
+
+#define pr_fmt(fmt) "panic-seial-helper: " fmt
+
+#include <linux/kmsg_dump.h>
+#include <linux/bsearch.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/tty_driver.h>
+#include <linux/serial_core.h>
+
+#include "panic_serial_helper.h"
+
+#define INPUT_PWD "Panic now, please input keyword to debug\n"
+#define WRONG_PWD "wrong password\n"
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
+	PSHS_WAIT_PWD_INPUT,
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
+/* whether uart is dumping msg */
+static bool dumping_msg;
+
+/* to filter msg */
+static char filter[256] = {0};
+
+/* keyword */
+static const char _passwd[] = "123456";
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
+/* char handle prototype */
+struct c_handle {
+	char c;
+	int (*handler)(struct psh_serial_dev *dev, void *d);
+};
+
+static inline void psh_show_func_line(struct psh_serial_dev *dev,
+	char *func, int line);
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
+static void psh_input_pwd(struct psh_serial_dev *dev)
+{
+	psh_put_strings(dev, INPUT_PWD, strlen(INPUT_PWD));
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
+static void psh_wrong_passwd(struct psh_serial_dev *dev)
+{
+	psh_put_strings(dev, WRONG_PWD, strlen(WRONG_PWD));
+}
+
+static int psh_check_passwd(struct psh_serial_dev *dev)
+{
+	struct psh_buf *_buf = psh_get_rx_buffer(dev);
+
+	if (!_buf)
+		return -EINVAL;
+
+	if ((strlen(_passwd) == strlen(_buf->buf)) &&
+		!strncmp(_buf->buf, _passwd, strlen(_passwd)))
+		return 0;
+
+	return -1;
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
+		if (print || (start && strstr(p->buf,
+				start))) {
+			psh_put_strings(dev, p->buf, p->size);
+			if (dev->psh_msg_type != PSHM_TYPE_STRINGS)
+				print = true;
+		}
+
+		if (end && strstr(p->buf, end))
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
+	bool wrong_passwd = false;
+
+	if (!dev || !buf)
+		return -EINVAL;
+
+	switch (dev->psh_status) {
+	case PSHS_WAIT_PWD_INPUT:
+		if (!psh_check_passwd(dev)) {
+			dev->psh_status = PSHS_WAIT_HELP_INPUT;
+			help = true;
+			psh_dev = dev;
+		} else {
+			wrong_passwd = true;
+		}
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
+	if (wrong_passwd) {
+		psh_wrong_passwd(dev);
+		psh_input_pwd(dev);
+	}
+
+	psh_clear_rx_buffer(dev);
+	return 0;
+}
+
+static struct c_handle c_handles[] = {
+	{'\b', psh_serial_backspace_handler},
+	{'\r', psh_serial_enter_handler},
+};
+
+static int c_handles_cmp(const void *key, const void *elt)
+{
+	const int *c = (int *)key;
+	const struct c_handle *e = (struct c_handle *)elt;
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
+#ifdef PSH_SERIAL_DEBUG
+static inline void psh_show_func_line(struct psh_serial_dev *dev,
+	char *func, int line)
+{
+	char buff[256] = {0};
+
+	snprintf(buff, sizeof(buff), "%s-%d\n", func, line);
+	psh_put_strings(dev, buff, strlen(buff));
+}
+#else
+static inline void psh_show_func_line(struct psh_serial_dev *dev,
+	char *func, int line)
+{
+}
+
+#endif
+
+static int psh_serial_check_char(struct psh_serial_dev *dev, int ch)
+{
+	struct c_handle *found = NULL;
+	int c = ch;
+
+	size_t num = sizeof(c_handles) / sizeof(struct c_handle);
+
+	found = bsearch(&c, c_handles, num,
+			sizeof(struct c_handle), c_handles_cmp);
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
+struct psh_serial_dev *create_psh_serial_dev(struct uart_driver *drv,
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
+	dev->psh_msg_type = PSHM_TYPE_ALL;
+	return dev;
+err:
+	return NULL;
+}
+
+/* find uart driver by name */
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
+/* try all uart port under the same driver */
+int psh_try_all_uart_port(struct uart_driver *drv)
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
+		dev->psh_status = PSHS_WAIT_PWD_INPUT;
+		psh_input_pwd(dev);
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
+/* try all uart driver */
+int psh_try_all_uart_driver(void)
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
+MODULE_DESCRIPTION("debug through uart when panic");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/panic_serial_helper.h b/drivers/tty/serial/panic_serial_helper.h
new file mode 100644
index 000000000000..678cbbeabfd6
--- /dev/null
+++ b/drivers/tty/serial/panic_serial_helper.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL
+ *
+ * panic_serial_helper.h Debug through uart when panic.
+ *
+ * Copyright (C) 2023 Xie Hongyu <xiehongyu1@kylinos.cn>
+ *
+ * Inspired by kgdboc.
+ */
+#ifndef __PANIC_SERIAL_HELPER_H
+#define __PANIC_SERIAL_HELPER_H
+/*TODO*/
+#endif /* __PANIC_SERIAL_HELPER_H */
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 979b776e3bcb..4ddedbd2253d 100644
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
index 886d2ebd0a0d..a5a92693fa61 100644
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

