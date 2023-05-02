Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380396F468D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjEBPCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjEBPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:02:30 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB6E1BDC;
        Tue,  2 May 2023 08:02:26 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-74fc1452fbdso306180685a.2;
        Tue, 02 May 2023 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683039746; x=1685631746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AVsW3V4u50q5sa5lagJfaL7UVEIL2ahaG0045SLIufc=;
        b=kCAXX7y2YjoqZ1r+HoPFEfOqUf4CuwS27yoRPMGTMJr98k5mur2wWRYSO1BXdGt0mW
         KqFjsebhAZV7S0nhrlDjuQWZIIzT8ePZMrDikjM+QEWVIbynP4D6wEsLjrxlOdIiOl7z
         IWVVUgmwCnihPXQ6e1kL6b8I4RhxxRMWtqT0ermQzEEVLLJsk/Z3HRRlm9/CnbrlpXLb
         B6dneFa/YN2iaH3em+DzKTiBOk6XEL1xCfcqlBQ9O6hfelbOPDQrwU0RF6TagDr8p60H
         IjtluR5tQuZUnSBUUW9BkAPhh619FgnMA/2bSHo7joDyD2EjX2mX/NUZI8D+FKQ4gebu
         z5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683039746; x=1685631746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVsW3V4u50q5sa5lagJfaL7UVEIL2ahaG0045SLIufc=;
        b=k5USI3QjpJbUevXwMN77lr8t/7t5FRPrwhehGAzyGYD210DuyMDze8s2lv0kwI0mj6
         vmh0RxqNCwN6KNR8gIxoghqycjvIUB+4ol5V3+8HehUMdEwS8xLHYNpz3FhgyRfZ2iYk
         ZZabWPd8XvRt9OtGHbY/Sv9C+OWhr2sMD1Fu+eE2LvMPbiUIsLmXQfSZwLzDbPdmHXxc
         e+G5NyLchmsP0RQnfr/xZlyZJmRnLgk1tSg16etyoYK3kLVvBOCIq217CVN1fTtJX4cZ
         IN7i80Y0KOnIARva0NvCOAby0vaft7L5Wz9Q83BaeJTb6qoTpnnF2PWxyF32pD7XbVQn
         x21Q==
X-Gm-Message-State: AC+VfDxB5/LBj6D25AGPg8LAFiI6YN0bQ7HMVVXpyjK+SOzSmpzSyZEp
        JdngwCCsvIG4MemkYR9B5g==
X-Google-Smtp-Source: ACHHUZ72mAJODQ/QdwtsFl2FrgKHOnjInqPVv6JuKUJ2oCq+Duwwccz332KOaIMifko6V1/qqngoKg==
X-Received: by 2002:a05:6214:20cf:b0:5ef:8004:e0b0 with SMTP id 15-20020a05621420cf00b005ef8004e0b0mr6592003qve.17.1683039745269;
        Tue, 02 May 2023 08:02:25 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id f14-20020a0caa8e000000b0061b5b399d1csm1403305qvb.104.2023.05.02.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:02:24 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.mvista.com (unknown [IPv6:2001:470:b8f6:1b:fdc2:8f04:3acf:c29d])
        by serve.minyard.net (Postfix) with ESMTPA id 19607180011;
        Tue,  2 May 2023 15:02:23 +0000 (UTC)
From:   minyard@acm.org
To:     im Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] watchdog: Add an IPMI watchdog driver in the watchdog framework
Date:   Tue,  2 May 2023 10:02:15 -0500
Message-Id: <20230502150215.1266526-1-minyard@acm.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

This basically strips out the things from the old watchdog driver that
the standard watchdog doesn't support and ties into the watchdog
framework.  The old driver is left alone, but will be deprecated.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
Something I should have done a long time ago (and was hoping someone
else would do).  Here's the first cut at this.

This creates a new watchdog driver for IPMI in addition to the old one.
It is missing some of the features not supported by the watchdog
framework, but few people if anybody probably use those features.
However, it will integrate with other watchdog drivers cleanly.

 Documentation/driver-api/ipmi.rst |  58 +-
 MAINTAINERS                       |   1 +
 drivers/char/ipmi/Kconfig         |   5 +-
 drivers/watchdog/Kconfig          |  11 +
 drivers/watchdog/Makefile         |   1 +
 drivers/watchdog/ipmi_wdt.c       | 908 ++++++++++++++++++++++++++++++
 6 files changed, 942 insertions(+), 42 deletions(-)
 create mode 100644 drivers/watchdog/ipmi_wdt.c

diff --git a/Documentation/driver-api/ipmi.rst b/Documentation/driver-api/ipmi.rst
index e224e47b6b09..2db717028cb7 100644
--- a/Documentation/driver-api/ipmi.rst
+++ b/Documentation/driver-api/ipmi.rst
@@ -114,9 +114,8 @@ over the SMBus.
 
 ipmi_powernv - A driver for access BMCs on POWERNV systems.
 
-ipmi_watchdog - IPMI requires systems to have a very capable watchdog
-timer.  This driver implements the standard Linux watchdog timer
-interface on top of the IPMI message handler.
+ipmi_watchdog - This is the old IPMI watchdog driver, the new one is
+in the watchdog directory and is in driver/watchdog/ipmi_wdt.c.
 
 ipmi_poweroff - Some systems support the ability to be turned off via
 IPMI commands.
@@ -664,12 +663,11 @@ Watchdog
 --------
 
 A watchdog timer is provided that implements the Linux-standard
-watchdog timer interface.  It has three module parameters that can be
+watchdog timer interface.  It has module parameters that can be
 used to control it::
 
-  modprobe ipmi_watchdog timeout=<t> pretimeout=<t> action=<action type>
-      preaction=<preaction type> preop=<preop type> start_now=x
-      nowayout=x ifnum_to_use=n panic_wdt_timeout=<t>
+  modprobe ipmi_wdt timeout=<t> pretimeout=<t> nowayout[=x]
+      ifnum_to_use=n panic_wdt_timeout=<t> test_pretimeout[=x]
 
 ifnum_to_use specifies which interface the watchdog timer should use.
 The default is -1, which means to pick the first one registered.
@@ -679,46 +677,26 @@ is the amount of seconds before the reset that the pre-timeout panic will
 occur (if pretimeout is zero, then pretimeout will not be enabled).  Note
 that the pretimeout is the time before the final timeout.  So if the
 timeout is 50 seconds and the pretimeout is 10 seconds, then the pretimeout
-will occur in 40 second (10 seconds before the timeout). The panic_wdt_timeout
-is the value of timeout which is set on kernel panic, in order to let actions
-such as kdump to occur during panic.
+will occur in 40 second (10 seconds before the timeout).
 
-The action may be "reset", "power_cycle", or "power_off", and
-specifies what to do when the timer times out, and defaults to
-"reset".
-
-The preaction may be "pre_smi" for an indication through the SMI
-interface, "pre_int" for an indication through the SMI with an
-interrupts, and "pre_nmi" for a NMI on a preaction.  This is how
-the driver is informed of the pretimeout.
-
-The preop may be set to "preop_none" for no operation on a pretimeout,
-"preop_panic" to set the preoperation to panic, or "preop_give_data"
-to provide data to read from the watchdog device when the pretimeout
-occurs.  A "pre_nmi" setting CANNOT be used with "preop_give_data"
-because you can't do data operations from an NMI.
-
-When preop is set to "preop_give_data", one byte comes ready to read
-on the device when the pretimeout occurs.  Select and fasync work on
-the device, as well.
-
-If start_now is set to 1, the watchdog timer will start running as
-soon as the driver is loaded.
-
-If nowayout is set to 1, the watchdog timer will not stop when the
+If nowayout is enabled, the watchdog timer will not stop when the
 watchdog device is closed.  The default value of nowayout is true
 if the CONFIG_WATCHDOG_NOWAYOUT option is enabled, or false if not.
 
+panic_wdt_timeout is the value of timeout which is set on kernel
+panic, in order to let actions such as kernel dump to occur during
+panic.  It defaults to 255 seconds.
+
+If test_pretimeout is enabled, then a test is done on the NMI timeout
+to verify that it works.  The results are printed to the system log.
+
 When compiled into the kernel, the kernel command line is available
 for configuring the watchdog::
 
-  ipmi_watchdog.timeout=<t> ipmi_watchdog.pretimeout=<t>
-	ipmi_watchdog.action=<action type>
-	ipmi_watchdog.preaction=<preaction type>
-	ipmi_watchdog.preop=<preop type>
-	ipmi_watchdog.start_now=x
-	ipmi_watchdog.nowayout=x
-	ipmi_watchdog.panic_wdt_timeout=<t>
+  ipmi_wdt.timeout=<t> ipmi_wdt.pretimeout=<t>
+	ipmi_wdt.nowayout=x
+	ipmi_wdt.panic_wdt_timeout=<t>
+	ipmi_wdt.test_pretimeout=<t>
 
 The options are the same as the module parameter options.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index edd3d562beee..f408a63154ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10796,6 +10796,7 @@ T:	git https://github.com/cminyard/linux-ipmi.git for-next
 F:	Documentation/driver-api/ipmi.rst
 F:	Documentation/devicetree/bindings/ipmi/
 F:	drivers/char/ipmi/
+F:	drivers/watchdog/ipmi_wdt.c
 F:	include/linux/ipmi*
 F:	include/uapi/linux/ipmi*
 
diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index f4adc6feb3b2..8ef86d0b18e1 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -91,9 +91,10 @@ config IPMI_POWERNV
 	  Provides a driver for OPAL firmware-based IPMI interfaces.
 
 config IPMI_WATCHDOG
-	tristate 'IPMI Watchdog Timer'
+	tristate 'Old IPMI Watchdog Timer'
 	help
-	  This enables the IPMI watchdog timer.
+	  This enables the IPMI watchdog timer.  This is deprecated, use
+	  IPMI_WDT in the watchdog area.
 
 config IPMI_POWEROFF
 	tristate 'IPMI Poweroff'
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 5de74686f12b..fc0f236a450b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -350,6 +350,17 @@ config SL28CPLD_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called sl28cpld_wdt.
 
+config IPMI_WDT
+	tristate "IPMI Watchdog Timer"
+	depends on IPMI_HANDLER
+	select WATCHDOG_CORE
+	help
+	  IPMI watchdog timer integrated into the watchdog framework.
+	  Note that you cannot use this driver with the old IPMI watchdog
+	  driver (IPMI_WATCHDOG).
+
+	  If unsure, say Y.
+
 # ALPHA Architecture
 
 # ARM Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9cbf6580f16c..af12a9dfec3c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -230,3 +230,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
 obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
 obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
+obj-$(CONFIG_IPMI_WDT) += ipmi_wdt.o
diff --git a/drivers/watchdog/ipmi_wdt.c b/drivers/watchdog/ipmi_wdt.c
new file mode 100644
index 000000000000..b72a95529458
--- /dev/null
+++ b/drivers/watchdog/ipmi_wdt.c
@@ -0,0 +1,908 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ipmi_watchdog.c
+ *
+ * A watchdog timer based upon the IPMI interface.
+ *
+ * Author: MontaVista Software, Inc.
+ *         Corey Minyard <minyard@mvista.com>
+ *         source@mvista.com
+ *
+ * Copyright 2002 MontaVista Software Inc.
+ */
+
+#define pr_fmt(fmt) "IPMI Watchdog: " fmt
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/ipmi.h>
+#include <linux/ipmi_smi.h>
+#include <linux/mutex.h>
+#include <linux/watchdog.h>
+#include <linux/miscdevice.h>
+#include <linux/init.h>
+#include <linux/completion.h>
+#include <linux/kdebug.h>
+#include <linux/kstrtox.h>
+#include <linux/rwsem.h>
+#include <linux/errno.h>
+#include <linux/uaccess.h>
+#include <linux/notifier.h>
+#include <linux/nmi.h>
+#include <linux/reboot.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/atomic.h>
+#include <linux/sched/signal.h>
+
+#ifdef CONFIG_X86
+/*
+ * This is ugly, but I've determined that x86 is the only architecture
+ * that can reasonably support the IPMI NMI watchdog timeout at this
+ * time.  If another architecture adds this capability somehow, it
+ * will have to be a somewhat different mechanism and I have no idea
+ * how it will work.  So in the unlikely event that another
+ * architecture supports this, we can figure out a good generic
+ * mechanism for it at that time.
+ */
+#include <linux/nmi.h>
+#define HAVE_DIE_NMI
+#endif
+
+/*
+ * The IPMI command/response information for the watchdog timer.
+ */
+
+/* values for byte 1 of the set command, byte 2 of the get response. */
+#define WDOG_DONT_LOG		(1 << 7)
+#define WDOG_DONT_STOP_ON_SET	(1 << 6)
+#define WDOG_SET_TIMER_USE(byte, use) \
+	(((byte) & 0xf8) | ((use) & 0x7))
+#define WDOG_GET_TIMER_USE(byte) ((byte) & 0x7)
+#define WDOG_TIMER_USE_BIOS_FRB2	1
+#define WDOG_TIMER_USE_BIOS_POST	2
+#define WDOG_TIMER_USE_OS_LOAD		3
+#define WDOG_TIMER_USE_SMS_OS		4
+#define WDOG_TIMER_USE_OEM		5
+
+/* values for byte 2 of the set command, byte 3 of the get response. */
+#define WDOG_SET_PRETIMEOUT_ACT(byte, use) \
+	(((byte) & 0x8f) | (((use) & 0x7) << 4))
+#define WDOG_GET_PRETIMEOUT_ACT(byte) (((byte) >> 4) & 0x7)
+#define WDOG_PRETIMEOUT_NONE		0
+#define WDOG_PRETIMEOUT_SMI		1
+#define WDOG_PRETIMEOUT_NMI		2
+#define WDOG_PRETIMEOUT_MSG_INT		3
+
+/* Actions to perform on a full timeout. */
+#define WDOG_SET_TIMEOUT_ACT(byte, use) \
+	(((byte) & 0xf8) | ((use) & 0x7))
+#define WDOG_GET_TIMEOUT_ACT(byte) ((byte) & 0x7)
+#define WDOG_TIMEOUT_NONE		0
+#define WDOG_TIMEOUT_RESET		1
+#define WDOG_TIMEOUT_POWER_DOWN		2
+#define WDOG_TIMEOUT_POWER_CYCLE	3
+
+/*
+ * Byte 3 of the get command, byte 4 of the get response is the
+ * pre-timeout in seconds.
+ */
+
+/* Bits for setting byte 4 of the set command, byte 5 of the get response. */
+#define WDOG_EXPIRE_CLEAR_BIOS_FRB2	(1 << 1)
+#define WDOG_EXPIRE_CLEAR_BIOS_POST	(1 << 2)
+#define WDOG_EXPIRE_CLEAR_OS_LOAD	(1 << 3)
+#define WDOG_EXPIRE_CLEAR_SMS_OS	(1 << 4)
+#define WDOG_EXPIRE_CLEAR_OEM		(1 << 5)
+
+/*
+ * Setting/getting the watchdog timer value.  This is for bytes 5 and
+ * 6 (the timeout time) of the set command, and bytes 6 and 7 (the
+ * timeout time) and 8 and 9 (the current countdown value) of the
+ * response.  The timeout value is given in seconds (in the command it
+ * is 100ms intervals).
+ */
+static inline void wdog_set_timeout_val(unsigned char *val, int timeout)
+{
+	val[0] = (timeout * 10) & 0xff;
+	val[1] = (timeout * 10) >> 8;
+}
+#define WDOG_GET_TIMEOUT(byte1, byte2) (((byte1) | ((byte2) << 8)) / 10)
+
+#define IPMI_WDOG_RESET_TIMER		0x22
+#define IPMI_WDOG_SET_TIMER		0x24
+#define IPMI_WDOG_GET_TIMER		0x25
+
+#define IPMI_WDOG_TIMER_NOT_INIT_RESP	0x80
+
+static DEFINE_MUTEX(ipmi_watchdog_mutex);
+
+static struct ipmi_user *watchdog_user;
+static int watchdog_ifnum;
+
+/* Default the timeout to 10 seconds. */
+static int timeout = 10;
+
+/* The pre-timeout is disabled by default. */
+static int pretimeout;
+
+/* Whether the timer can be stopped or not. */
+static bool nowayout = WATCHDOG_NOWAYOUT;
+
+/* Default timeout to set on panic, in seconds. */
+static int panic_wdt_timeout = 255;
+
+/* Default action is to reset the board on a timeout. */
+static unsigned char action_val = WDOG_TIMEOUT_RESET;
+
+/* Default state of the timer. */
+static unsigned char ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
+
+/* Default pretimeout is disabled until set_pretimeout is called. */
+static unsigned char pretimeout_state = WDOG_PRETIMEOUT_NONE;
+
+/* Test the NMI pretimeout at startup. */
+static bool test_pretimeout;
+
+static atomic_t pretimeout_since_last_heartbeat;
+
+static int ifnum_to_use = -1;
+
+/* Parameters to ipmi_set_timeout */
+#define IPMI_SET_TIMEOUT_NO_HB			0
+#define IPMI_SET_TIMEOUT_HB_IF_NECESSARY	1
+#define IPMI_SET_TIMEOUT_FORCE_HB		2
+
+static void ipmi_register_watchdog(int ipmi_intf);
+static void ipmi_unregister_watchdog(int ipmi_intf);
+
+static int set_param_wdog_ifnum(const char *val, const struct kernel_param *kp)
+{
+	int rv = param_set_int(val, kp);
+
+	if (rv)
+		return rv;
+	if ((ifnum_to_use < 0) || (ifnum_to_use == watchdog_ifnum))
+		return 0;
+
+	ipmi_unregister_watchdog(watchdog_ifnum);
+	ipmi_register_watchdog(ifnum_to_use);
+	return 0;
+}
+
+static const struct kernel_param_ops param_ops_wdog_ifnum = {
+	.set = set_param_wdog_ifnum,
+	.get = param_get_int,
+};
+
+#define param_check_wdog_ifnum param_check_int
+
+module_param(ifnum_to_use, wdog_ifnum, 0644);
+MODULE_PARM_DESC(ifnum_to_use, "The interface number to use for the watchdog timer.  Setting to -1 defaults to the first registered interface");
+
+module_param(timeout, int, 0644);
+MODULE_PARM_DESC(timeout, "Timeout value in seconds.");
+
+module_param(pretimeout, int, 0644);
+MODULE_PARM_DESC(pretimeout, "Pretimeout value in seconds.");
+
+module_param(nowayout, bool, 0644);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+module_param(panic_wdt_timeout, int, 0644);
+MODULE_PARM_DESC(panic_wdt_timeout, "Timeout value on kernel panic in seconds.");
+
+module_param(test_pretimeout, bool, 0444);
+MODULE_PARM_DESC(test_pretimeout, "Test that the NMI pretimeout works");
+
+/* IPMI version of the BMC. */
+static unsigned char ipmi_version_major;
+static unsigned char ipmi_version_minor;
+
+/* If a pretimeout occurs, this is used to allow only one panic to happen. */
+static atomic_t preop_panic_excl = ATOMIC_INIT(-1);
+
+#ifdef HAVE_DIE_NMI
+static int testing_nmi;
+static int nmi_handler_registered;
+#endif
+
+static int __ipmi_heartbeat(void);
+
+/*
+ * We use a mutex to make sure that only one thing can send a set a
+ * message at one time.  The mutex is claimed when a message is sent
+ * and freed when both the send and receive messages are free.
+ */
+static atomic_t msg_tofree = ATOMIC_INIT(0);
+static DECLARE_COMPLETION(msg_wait);
+static void msg_free_smi(struct ipmi_smi_msg *msg)
+{
+	if (atomic_dec_and_test(&msg_tofree)) {
+		if (!oops_in_progress)
+			complete(&msg_wait);
+	}
+}
+static void msg_free_recv(struct ipmi_recv_msg *msg)
+{
+	if (atomic_dec_and_test(&msg_tofree)) {
+		if (!oops_in_progress)
+			complete(&msg_wait);
+	}
+}
+static struct ipmi_smi_msg smi_msg = INIT_IPMI_SMI_MSG(msg_free_smi);
+static struct ipmi_recv_msg recv_msg = INIT_IPMI_RECV_MSG(msg_free_recv);
+
+static int __ipmi_set_timeout(struct ipmi_smi_msg  *smi_msg,
+			      struct ipmi_recv_msg *recv_msg,
+			      int                  *send_heartbeat_now)
+{
+	struct kernel_ipmi_msg            msg;
+	unsigned char                     data[6];
+	int                               rv;
+	struct ipmi_system_interface_addr addr;
+	int                               hbnow = 0;
+
+
+	data[0] = 0;
+	data[0] = WDOG_SET_TIMER_USE(data[0], WDOG_TIMER_USE_SMS_OS);
+
+	if (ipmi_watchdog_state != WDOG_TIMEOUT_NONE) {
+		if ((ipmi_version_major > 1) ||
+		    ((ipmi_version_major == 1) && (ipmi_version_minor >= 5))) {
+			/* This is an IPMI 1.5-only feature. */
+			data[0] |= WDOG_DONT_STOP_ON_SET;
+		} else {
+			/*
+			 * In ipmi 1.0, setting the timer stops the watchdog, we
+			 * need to start it back up again.
+			 */
+			hbnow = 1;
+		}
+	}
+
+	data[1] = 0;
+	data[1] = WDOG_SET_TIMEOUT_ACT(data[1], ipmi_watchdog_state);
+	if ((pretimeout > 0) && (ipmi_watchdog_state != WDOG_TIMEOUT_NONE)) {
+		data[1] = WDOG_SET_PRETIMEOUT_ACT(data[1], pretimeout_state);
+		data[2] = pretimeout;
+	} else {
+		data[1] = WDOG_SET_PRETIMEOUT_ACT(data[1],
+						  WDOG_PRETIMEOUT_NONE);
+		data[2] = 0; /* No pretimeout. */
+	}
+	data[3] = 0;
+	wdog_set_timeout_val(data + 4, timeout);
+
+	addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	addr.channel = IPMI_BMC_CHANNEL;
+	addr.lun = 0;
+
+	msg.netfn = 0x06;
+	msg.cmd = IPMI_WDOG_SET_TIMER;
+	msg.data = data;
+	msg.data_len = sizeof(data);
+	rv = ipmi_request_supply_msgs(watchdog_user,
+				      (struct ipmi_addr *) &addr,
+				      0,
+				      &msg,
+				      NULL,
+				      smi_msg,
+				      recv_msg,
+				      1);
+	if (rv)
+		pr_warn("set timeout error: %d\n", rv);
+	else if (send_heartbeat_now)
+		*send_heartbeat_now = hbnow;
+
+	return rv;
+}
+
+static int _ipmi_set_timeout(int do_heartbeat)
+{
+	int send_heartbeat_now;
+	int rv;
+
+	if (!watchdog_user)
+		return -ENODEV;
+
+	atomic_set(&msg_tofree, 2);
+
+	rv = __ipmi_set_timeout(&smi_msg,
+				&recv_msg,
+				&send_heartbeat_now);
+	if (rv) {
+		atomic_set(&msg_tofree, 0);
+		return rv;
+	}
+
+	wait_for_completion(&msg_wait);
+
+	if ((do_heartbeat == IPMI_SET_TIMEOUT_FORCE_HB)
+		|| ((send_heartbeat_now)
+		    && (do_heartbeat == IPMI_SET_TIMEOUT_HB_IF_NECESSARY)))
+		rv = __ipmi_heartbeat();
+
+	return rv;
+}
+
+static atomic_t panic_done_count = ATOMIC_INIT(0);
+
+static void panic_smi_free(struct ipmi_smi_msg *msg)
+{
+	atomic_dec(&panic_done_count);
+}
+static void panic_recv_free(struct ipmi_recv_msg *msg)
+{
+	atomic_dec(&panic_done_count);
+}
+
+static struct ipmi_smi_msg panic_halt_heartbeat_smi_msg =
+	INIT_IPMI_SMI_MSG(panic_smi_free);
+static struct ipmi_recv_msg panic_halt_heartbeat_recv_msg =
+	INIT_IPMI_RECV_MSG(panic_recv_free);
+
+static void panic_halt_ipmi_heartbeat(void)
+{
+	struct kernel_ipmi_msg             msg;
+	struct ipmi_system_interface_addr addr;
+	int rv;
+
+	/*
+	 * Don't reset the timer if we have the timer turned off, that
+	 * re-enables the watchdog.
+	 */
+	if (ipmi_watchdog_state == WDOG_TIMEOUT_NONE)
+		return;
+
+	addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	addr.channel = IPMI_BMC_CHANNEL;
+	addr.lun = 0;
+
+	msg.netfn = 0x06;
+	msg.cmd = IPMI_WDOG_RESET_TIMER;
+	msg.data = NULL;
+	msg.data_len = 0;
+	atomic_add(2, &panic_done_count);
+	rv = ipmi_request_supply_msgs(watchdog_user,
+				      (struct ipmi_addr *) &addr,
+				      0,
+				      &msg,
+				      NULL,
+				      &panic_halt_heartbeat_smi_msg,
+				      &panic_halt_heartbeat_recv_msg,
+				      1);
+	if (rv)
+		atomic_sub(2, &panic_done_count);
+}
+
+static struct ipmi_smi_msg panic_halt_smi_msg =
+	INIT_IPMI_SMI_MSG(panic_smi_free);
+static struct ipmi_recv_msg panic_halt_recv_msg =
+	INIT_IPMI_RECV_MSG(panic_recv_free);
+
+/*
+ * Special call, doesn't claim any locks.  This is only to be called
+ * at panic or halt time, in run-to-completion mode, when the caller
+ * is the only CPU and the only thing that will be going is these IPMI
+ * calls.
+ */
+static void panic_halt_ipmi_set_timeout(void)
+{
+	int send_heartbeat_now;
+	int rv;
+
+	/* Wait for the messages to be free. */
+	while (atomic_read(&panic_done_count) != 0)
+		ipmi_poll_interface(watchdog_user);
+	atomic_add(2, &panic_done_count);
+	rv = __ipmi_set_timeout(&panic_halt_smi_msg,
+				&panic_halt_recv_msg,
+				&send_heartbeat_now);
+	if (rv) {
+		atomic_sub(2, &panic_done_count);
+		pr_warn("Unable to extend the watchdog timeout\n");
+	} else {
+		if (send_heartbeat_now)
+			panic_halt_ipmi_heartbeat();
+	}
+	while (atomic_read(&panic_done_count) != 0)
+		ipmi_poll_interface(watchdog_user);
+}
+
+static int __ipmi_heartbeat(void)
+{
+	struct kernel_ipmi_msg msg;
+	int rv;
+	struct ipmi_system_interface_addr addr;
+	int timeout_retries = 0;
+
+restart:
+	/*
+	 * Don't reset the timer if we have the timer turned off, that
+	 * re-enables the watchdog.
+	 */
+	if (ipmi_watchdog_state == WDOG_TIMEOUT_NONE)
+		return 0;
+
+	atomic_set(&msg_tofree, 2);
+
+	addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	addr.channel = IPMI_BMC_CHANNEL;
+	addr.lun = 0;
+
+	msg.netfn = 0x06;
+	msg.cmd = IPMI_WDOG_RESET_TIMER;
+	msg.data = NULL;
+	msg.data_len = 0;
+	rv = ipmi_request_supply_msgs(watchdog_user,
+				      (struct ipmi_addr *) &addr,
+				      0,
+				      &msg,
+				      NULL,
+				      &smi_msg,
+				      &recv_msg,
+				      1);
+	if (rv) {
+		atomic_set(&msg_tofree, 0);
+		pr_warn("heartbeat send failure: %d\n", rv);
+		return rv;
+	}
+
+	/* Wait for the heartbeat to be sent. */
+	wait_for_completion(&msg_wait);
+
+	if (recv_msg.msg.data[0] == IPMI_WDOG_TIMER_NOT_INIT_RESP)  {
+		timeout_retries++;
+		if (timeout_retries > 3) {
+			pr_err("Unable to restore the IPMI watchdog's settings, giving up\n");
+			rv = -EIO;
+			goto out;
+		}
+
+		/*
+		 * The timer was not initialized, that means the BMC was
+		 * probably reset and lost the watchdog information.  Attempt
+		 * to restore the timer's info.  Note that we still hold
+		 * the heartbeat lock, to keep a heartbeat from happening
+		 * in this process, so must say no heartbeat to avoid a
+		 * deadlock on this mutex
+		 */
+		rv = _ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
+		if (rv) {
+			pr_err("Unable to send the command to set the watchdog's settings, giving up\n");
+			goto out;
+		}
+
+		/* Might need a heartbeat send, go ahead and do it. */
+		goto restart;
+	} else if (recv_msg.msg.data[0] != 0) {
+		/*
+		 * Got an error in the heartbeat response.  It was already
+		 * reported in ipmi_wdog_msg_handler, but we should return
+		 * an error here.
+		 */
+		rv = -EINVAL;
+	}
+
+out:
+	return rv;
+}
+
+static int _ipmi_heartbeat(void)
+{
+	int rv;
+
+	if (!watchdog_user)
+		return -ENODEV;
+
+	if (atomic_cmpxchg(&pretimeout_since_last_heartbeat, 1, 0)) {
+		/*
+		 * A pretimeout occurred, make sure we set the timeout.
+		 * We don't want to set the action, though, we want to
+		 * leave that alone (thus it can't be combined with the
+		 * above operation.
+		 */
+		rv = _ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
+	} else {
+		rv = __ipmi_heartbeat();
+	}
+
+	return rv;
+}
+
+int ipmi_wdt_start(struct watchdog_device *wd)
+{
+	int rv;
+
+	mutex_lock(&ipmi_watchdog_mutex);
+	ipmi_watchdog_state = action_val;
+	rv = _ipmi_set_timeout(IPMI_SET_TIMEOUT_FORCE_HB);
+	if (rv)
+		ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
+	mutex_unlock(&ipmi_watchdog_mutex);
+
+	return rv;
+}
+
+int ipmi_wdt_stop(struct watchdog_device *wd)
+{
+	mutex_lock(&ipmi_watchdog_mutex);
+	ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
+	_ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
+	mutex_unlock(&ipmi_watchdog_mutex);
+
+	return 0;
+}
+
+int ipmi_wdt_ping(struct watchdog_device *wd)
+{
+	int rv;
+
+	mutex_lock(&ipmi_watchdog_mutex);
+	rv = _ipmi_heartbeat();
+	mutex_unlock(&ipmi_watchdog_mutex);
+
+	return rv;
+}
+
+int ipmi_wdt_set_timeout(struct watchdog_device *wd, unsigned int to)
+{
+	int rv;
+
+	mutex_lock(&ipmi_watchdog_mutex);
+	timeout = to;
+	rv = _ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
+	mutex_unlock(&ipmi_watchdog_mutex);
+
+	return rv;
+}
+
+#ifdef HAVE_DIE_NMI
+int ipmi_wdt_set_pretimeout(struct watchdog_device *wd, unsigned int pto)
+{
+	int rv;
+
+	mutex_lock(&ipmi_watchdog_mutex);
+	pretimeout = pto;
+	if (pto)
+		pretimeout_state = WDOG_PRETIMEOUT_NMI;
+	else
+		pretimeout_state = WDOG_PRETIMEOUT_NONE;
+
+	rv = _ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
+	mutex_unlock(&ipmi_watchdog_mutex);
+
+	return rv;
+}
+#endif
+
+static const struct watchdog_info ipmi_wdt_info = {
+	.options = (WDIOF_SETTIMEOUT |
+		    WDIOF_MAGICCLOSE |
+#ifdef HAVE_DIE_NMI
+		    WDIOF_PRETIMEOUT |
+#endif
+		    WDIOF_KEEPALIVEPING),
+	.identity = "IPMI",
+};
+
+static const struct watchdog_ops ipmi_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= ipmi_wdt_start,
+	.stop		= ipmi_wdt_stop,
+	.ping		= ipmi_wdt_ping,
+	.set_timeout	= ipmi_wdt_set_timeout,
+#ifdef HAVE_DIE_NMI
+	.set_pretimeout	= ipmi_wdt_set_pretimeout,
+#endif
+};
+
+static struct watchdog_device ipmi_wdt = {
+	.info		= &ipmi_wdt_info,
+	.ops		= &ipmi_wdt_ops,
+	.min_timeout	= 1,
+	.max_timeout	= 255,
+};
+
+static void ipmi_wdog_msg_handler(struct ipmi_recv_msg *msg,
+				  void                 *handler_data)
+{
+	if (msg->msg.cmd == IPMI_WDOG_RESET_TIMER &&
+			msg->msg.data[0] == IPMI_WDOG_TIMER_NOT_INIT_RESP)
+		pr_info("response: The IPMI controller appears to have been reset, will attempt to reinitialize the watchdog timer\n");
+	else if (msg->msg.data[0] != 0)
+		pr_err("response: Error %x on cmd %x\n",
+		       msg->msg.data[0],
+		       msg->msg.cmd);
+
+	ipmi_free_recv_msg(msg);
+}
+
+static void ipmi_wdog_panic_handler(void *user_data)
+{
+	static int panic_event_handled;
+
+	/*
+	 * On a panic, if we have a panic timeout, make sure to extend
+	 * the watchdog timer to a reasonable value to complete the
+	 * panic, if the watchdog timer is running.  Plus the
+	 * pretimeout is meaningless at panic time.
+	 */
+	if (watchdog_user && !panic_event_handled &&
+	    ipmi_watchdog_state != WDOG_TIMEOUT_NONE) {
+		/* Make sure we do this only once. */
+		panic_event_handled = 1;
+
+		timeout = panic_wdt_timeout;
+		pretimeout = 0;
+		panic_halt_ipmi_set_timeout();
+	}
+}
+
+static const struct ipmi_user_hndl ipmi_hndlrs = {
+	.ipmi_recv_hndl           = ipmi_wdog_msg_handler,
+	.ipmi_panic_handler       = ipmi_wdog_panic_handler
+};
+
+static void ipmi_register_watchdog(int ipmi_intf)
+{
+	int rv;
+
+	if (watchdog_user)
+		return;
+
+	if ((ifnum_to_use >= 0) && (ifnum_to_use != ipmi_intf))
+		return;
+
+	watchdog_ifnum = ipmi_intf;
+
+	rv = ipmi_create_user(ipmi_intf, &ipmi_hndlrs, NULL, &watchdog_user);
+	if (rv < 0) {
+		pr_crit("Unable to register with ipmi\n");
+		return;
+	}
+
+	rv = ipmi_get_version(watchdog_user,
+			      &ipmi_version_major,
+			      &ipmi_version_minor);
+	if (rv) {
+		pr_warn("Unable to get IPMI version, assuming 1.0\n");
+		ipmi_version_major = 1;
+		ipmi_version_minor = 0;
+	}
+
+#ifdef HAVE_DIE_NMI
+	if (test_pretimeout && nmi_handler_registered) {
+		int old_pretimeout = pretimeout;
+		int old_timeout = timeout;
+
+		/*
+		 * Set the pretimeout to go off in a second and give
+		 * ourselves plenty of time to stop the timer.
+		 */
+		ipmi_watchdog_state = WDOG_TIMEOUT_RESET;
+		pretimeout_state = WDOG_PRETIMEOUT_NMI;
+		pretimeout = 99;
+		timeout = 100;
+
+		testing_nmi = 1;
+
+		rv = _ipmi_set_timeout(IPMI_SET_TIMEOUT_FORCE_HB);
+		if (rv) {
+			pr_warn("Error starting timer to test NMI: 0x%x.  The NMI pretimeout will likely not work\n",
+				rv);
+			rv = 0;
+			goto out_restore;
+		}
+
+		msleep(1500);
+
+		if (testing_nmi != 2)
+			pr_warn("IPMI NMI didn't seem to occur.  The NMI pretimeout will likely not work\n");
+		else
+			pr_info("IPMI NMI is functional\n");
+
+out_restore:
+		testing_nmi = 0;
+		ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
+		pretimeout_state = WDOG_PRETIMEOUT_NONE;
+		pretimeout = old_pretimeout;
+		timeout = old_timeout;
+		_ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
+	}
+#endif
+
+	ipmi_wdt.timeout = timeout;
+	ipmi_wdt.pretimeout = pretimeout;
+	watchdog_set_nowayout(&ipmi_wdt, nowayout);
+
+	rv = watchdog_register_device(&ipmi_wdt);
+	if (rv < 0) {
+		ipmi_destroy_user(watchdog_user);
+		watchdog_user = NULL;
+		pr_crit("Unable to register watchdog handler\n");
+		return;
+	}
+}
+
+static void ipmi_unregister_watchdog(int ipmi_intf)
+{
+	int rv;
+	struct ipmi_user *loc_user = watchdog_user;
+
+	if (!loc_user)
+		return;
+
+	if (watchdog_ifnum != ipmi_intf)
+		return;
+
+	/* Make sure no one can call us any more. */
+	watchdog_unregister_device(&ipmi_wdt);
+
+	watchdog_user = NULL;
+
+	/*
+	 * Wait to make sure the message makes it out.  The lower layer has
+	 * pointers to our buffers, we want to make sure they are done before
+	 * we release our memory.
+	 */
+	while (atomic_read(&msg_tofree))
+		msg_free_smi(NULL);
+
+	mutex_lock(&ipmi_watchdog_mutex);
+
+	/* Disconnect from IPMI. */
+	rv = ipmi_destroy_user(loc_user);
+	if (rv)
+		pr_warn("error unlinking from IPMI: %d\n",  rv);
+
+	mutex_unlock(&ipmi_watchdog_mutex);
+}
+
+#ifdef HAVE_DIE_NMI
+static int
+ipmi_nmi(unsigned int val, struct pt_regs *regs)
+{
+	/*
+	 * If we get here, it's an NMI that's not a memory or I/O
+	 * error.  We can't truly tell if it's from IPMI or not
+	 * without sending a message, and sending a message is almost
+	 * impossible because of locking.
+	 */
+
+	if (testing_nmi) {
+		testing_nmi = 2;
+		return NMI_HANDLED;
+	}
+
+	/* If we are not expecting a timeout, ignore it. */
+	if (ipmi_watchdog_state == WDOG_TIMEOUT_NONE)
+		return NMI_DONE;
+
+	if (pretimeout_state != WDOG_PRETIMEOUT_NMI)
+		return NMI_DONE;
+
+	/*
+	 * If no one else handled the NMI, we assume it was the IPMI
+	 * watchdog.
+	 */
+
+	/*
+	 * On some machines, the heartbeat will give an error and not
+	 * work unless we re-enable the timer.  So do so.
+	 */
+	atomic_set(&pretimeout_since_last_heartbeat, 1);
+
+	/*
+	 * Don't call watchdog_notify_pretimeout() here.  You really
+	 * need to call nmi_panic from an NMI, and that code doesn't
+	 * do that.
+	 */
+	if (atomic_inc_and_test(&preop_panic_excl))
+		nmi_panic(regs, "ipmi wdt pre-timeout");
+
+	return NMI_HANDLED;
+}
+#endif
+
+static int wdog_reboot_handler(struct notifier_block *this,
+			       unsigned long         code,
+			       void                  *unused)
+{
+	static int reboot_event_handled;
+
+	mutex_lock(&ipmi_watchdog_mutex);
+	if ((watchdog_user) && (!reboot_event_handled)) {
+		/* Make sure we only do this once. */
+		reboot_event_handled = 1;
+
+		if (code == SYS_POWER_OFF || code == SYS_HALT) {
+			/* Disable the WDT if we are shutting down. */
+			ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
+			_ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
+		} else if (ipmi_watchdog_state != WDOG_TIMEOUT_NONE) {
+			/*
+			 * Set a long timer to let the reboot happen or
+			 * reset if it hangs, but only if the watchdog
+			 * timer was already running.
+			 */
+			if (timeout < 120)
+				timeout = 120;
+			pretimeout = 0;
+			ipmi_watchdog_state = WDOG_TIMEOUT_RESET;
+			_ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
+		}
+	}
+	mutex_unlock(&ipmi_watchdog_mutex);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block wdog_reboot_notifier = {
+	.notifier_call	= wdog_reboot_handler,
+	.next		= NULL,
+	.priority	= 0
+};
+
+static void ipmi_new_smi(int if_num, struct device *device)
+{
+	ipmi_register_watchdog(if_num);
+}
+
+static void ipmi_smi_gone(int if_num)
+{
+	ipmi_unregister_watchdog(if_num);
+}
+
+static struct ipmi_smi_watcher smi_watcher = {
+	.owner    = THIS_MODULE,
+	.new_smi  = ipmi_new_smi,
+	.smi_gone = ipmi_smi_gone
+};
+
+static int __init ipmi_wdog_init(void)
+{
+	int rv;
+
+#ifdef HAVE_DIE_NMI
+	rv = register_nmi_handler(NMI_UNKNOWN, ipmi_nmi, 0, "ipmi");
+	if (rv)
+		pr_warn("Can't register nmi handler: %d\n", rv);
+	else
+		nmi_handler_registered = 1;
+#endif
+
+	register_reboot_notifier(&wdog_reboot_notifier);
+
+	rv = ipmi_smi_watcher_register(&smi_watcher);
+	if (rv) {
+#ifdef HAVE_DIE_NMI
+		if (nmi_handler_registered)
+			unregister_nmi_handler(NMI_UNKNOWN, "ipmi");
+#endif
+		unregister_reboot_notifier(&wdog_reboot_notifier);
+		pr_warn("can't register smi watcher\n");
+		return rv;
+	}
+
+	return 0;
+}
+
+static void __exit ipmi_wdog_exit(void)
+{
+	ipmi_smi_watcher_unregister(&smi_watcher);
+	ipmi_unregister_watchdog(watchdog_ifnum);
+
+#ifdef HAVE_DIE_NMI
+	if (nmi_handler_registered)
+		unregister_nmi_handler(NMI_UNKNOWN, "ipmi");
+#endif
+
+	unregister_reboot_notifier(&wdog_reboot_notifier);
+}
+module_exit(ipmi_wdog_exit);
+module_init(ipmi_wdog_init);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Corey Minyard <minyard@mvista.com>");
+MODULE_DESCRIPTION("watchdog timer based upon the IPMI interface.");
-- 
2.34.1

