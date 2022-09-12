Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946B25B52BE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 05:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiILDDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 23:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiILDDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 23:03:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3670819036;
        Sun, 11 Sep 2022 20:03:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h188so6981927pgc.12;
        Sun, 11 Sep 2022 20:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LANjxLMsCfO0PjftxWxuIMkHSaFPDbXCyTX3pauOUF0=;
        b=oFCtH/DD8IYjBzkvDOj/b9iRGcz4/nZ1IaU8VIDsfynqFLkZMdhAOwBas0s9dIvpKi
         H0+azCx3hS5RlRr7M4vT0k/n3X7QJn+b51ALb3c9Np928wc+LcNVNSMVXqkRzOHdLJkN
         AS+IwF4WeFNlmnyPX+JE0tYUTY6I9HphM3aJN/raFYTnrohUMky7RV18ykoJIdTqbQru
         F0YPzgaefpweBJFs0tWhg3GippAgmYw/oabqC/83Y6WJe2RisaO+gTDNZyjYn1JJEM8v
         cL9zaMxmpYva/nn8s9Twryr1fh3k2MM9ysLT76iz0Lu/7llHXapLbEZ4S+hHQeTUox16
         hK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LANjxLMsCfO0PjftxWxuIMkHSaFPDbXCyTX3pauOUF0=;
        b=5YxAq2Y/Cn12Cr380hwociWu9v9HAatpBFzkI+vZVOsUYfZc/u8p08H7OJd+rqpYDW
         tNdrXMuLs7xZtK/UYzfza0EOnekBeAtfGlI/q6NwdCsOjpNypK9lUTfTxTCaGtSG9CWI
         rmk1wEBsJjOLHRFwFfYAjm57sIKcRvXpocUILU0s3FSliiLb+bPxvCMfOQ+6YvxWD0kS
         jEOfP2tY2D0oUlM95M6Sjz1G079FuGKiQNEILEJT6AqJP6cF/HkhuYvZBTgSJnhDbF8D
         7Z5n9cO+sr7KNzGHpIjimN6iXidA7VY5BxHLXz1DT30V2cctwu9PMUbGCeKyqwmztRwD
         D4mQ==
X-Gm-Message-State: ACgBeo1wnEn7Y04/neiY+AB3TtZz8XsqO0zudTuNZVZ5okQCwt0U13Ue
        tMdOxPKamxoUi4p9IbE1pEnWdek/wJlsQw==
X-Google-Smtp-Source: AA6agR7qzs6MT4hdx62Bg+yIfJMlzrxkfCLbJ4hM1nQkjIq63ZYBKMg1/UdUOtFdfUryaNPnabFz7w==
X-Received: by 2002:a63:4e08:0:b0:438:9514:48b3 with SMTP id c8-20020a634e08000000b00438951448b3mr10823184pgb.439.1662951793565;
        Sun, 11 Sep 2022 20:03:13 -0700 (PDT)
Received: from dusj-System-Product-Name.dhcpserver.bu9bmc.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b00172d78876c7sm4627958plh.74.2022.09.11.20.03.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Sep 2022 20:03:13 -0700 (PDT)
From:   Duke Du <dukedu83@gmail.com>
X-Google-Original-From: Duke Du <Duke.Du@quantatw.com>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     fran.hsu@quantatw.com, george.hung@quantatw.com,
        charles.hsu@quantatw.com, duke.du@quantatw.com
Subject: [PATCH v5] hwmon: Add driver for the TEXAS TPS546D24 Buck Converter.
Date:   Mon, 12 Sep 2022 11:01:08 +0800
Message-Id: <1662951668-9849-1-git-send-email-Duke.Du@quantatw.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duke Du <dukedu83@gmail.com>

Add the pmbus driver for TEXAS tps546d24 Buck Converter.
The vout mode of tps546d24 supported relative data format,
which is not supported by the PMBus core.

Signed-off-by: Duke Du <dukedu83@gmail.com>
---
Change in v1:
    Initial patchset.
Change in v2:
    Correct the tps546d24.rst format.
Change in v3:
    1. Modify the patch description.
    2. Put the change log between the dashes and diffstat.
Change in v4:
    1. Modify the patch description.
    2. Clear the bit 7 of PMBUS_VOUT_MODE to change the mode from relative
       to absolute.
    3. Add the vendor prefix.
Change in v5:
    1. Update the patch description.
    2. Extend the title underline at tps546d24.rst line 4.
    3. Add error handler and cover the edge case.
---
---
 Documentation/hwmon/index.rst     |  1 +
 Documentation/hwmon/tps546d24.rst | 35 +++++++++++++++++++
 MAINTAINERS                       |  7 ++++
 drivers/hwmon/pmbus/Kconfig       |  9 +++++
 drivers/hwmon/pmbus/Makefile      |  1 +
 drivers/hwmon/pmbus/tps546d24.c   | 71 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 124 insertions(+)
 create mode 100644 Documentation/hwmon/tps546d24.rst
 create mode 100644 drivers/hwmon/pmbus/tps546d24.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index f7113b0..d3eede4 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -205,6 +205,7 @@ Hardware Monitoring Kernel Drivers
    tps23861
    tps40422
    tps53679
+   tps546d24
    twl4030-madc-hwmon
    ucd9000
    ucd9200
diff --git a/Documentation/hwmon/tps546d24.rst b/Documentation/hwmon/tps546d24.rst
new file mode 100644
index 0000000..97adb8a
--- /dev/null
+++ b/Documentation/hwmon/tps546d24.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver tps546d24
+=======================
+
+Supported chips:
+
+  * TI TPS546D24
+
+    Prefix: 'tps546d24'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.ti.com/lit/gpn/tps546d24
+
+Author: Duke Du <dukedu83@gmail.com>
+
+
+Description
+-----------
+
+The TPS546D24A is a highly integrated, non-isolated DC/DC converter capable
+of high frequency operation and 40-A current output from a 7-mm x 5-mm
+package.
+
+Two, three, and four TPS546D24A devices can be interconnected
+to provide up to 160 A on a single output. The device has an option to
+overdrive the internal 5-V LDO with an external 5-V supply via the VDD5
+pin to improve efficiency and reduce power dissipation of the converter.
+
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012b..fa2d4fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20583,6 +20583,13 @@ Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
 F:	drivers/char/tpm/
 
+TPS546D24 DRIVER
+M:	Duke Du <dukedu83@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/tps546d24.rst
+F:	drivers/hwmon/pmbus/tps546d24.c
+
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Ingo Molnar <mingo@redhat.com>
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 951e4a9..89668af 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -397,6 +397,15 @@ config SENSORS_TPS53679
 	  This driver can also be built as a module. If so, the module will
 	  be called tps53679.
 
+config SENSORS_TPS546D24
+	tristate "TPS546D24"
+	help
+	  If you say yes here you get hardware monitoring support for TEXAS
+	  TPS546D24.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called tps546d24
+
 config SENSORS_UCD9000
 	tristate "TI UCD90120, UCD90124, UCD90160, UCD90320, UCD9090, UCD90910"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index e2fe86f..0002dbe 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
 obj-$(CONFIG_SENSORS_STPDDC60)	+= stpddc60.o
 obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
 obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
+obj-$(CONFIG_SENSORS_TPS546D24)	+= tps546d24.o
 obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
 obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
 obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
diff --git a/drivers/hwmon/pmbus/tps546d24.c b/drivers/hwmon/pmbus/tps546d24.c
new file mode 100644
index 0000000..ef2b0be
--- /dev/null
+++ b/drivers/hwmon/pmbus/tps546d24.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for TEXAS TPS546D24 buck converter
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pmbus.h>
+#include "pmbus.h"
+
+static struct pmbus_driver_info tps546d24_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
+			| PMBUS_HAVE_IOUT | PMBUS_HAVE_VOUT
+			| PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT
+			| PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+};
+
+static int tps546d24_probe(struct i2c_client *client)
+{
+	int reg;
+
+	reg = i2c_smbus_read_byte_data(client, PMBUS_VOUT_MODE);
+	if (reg < 0)
+		return reg;
+
+	if (reg & 0x80) {
+		int err;
+
+		err = i2c_smbus_write_byte_data(client, PMBUS_VOUT_MODE, reg & 0x7f);
+		if (err < 0)
+			return err;
+	}
+	return pmbus_do_probe(client, &tps546d24_info);
+}
+
+static const struct i2c_device_id tps546d24_id[] = {
+	{"tps546d24", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, tps546d24_id);
+
+static const struct of_device_id tps546d24_of_match[] = {
+	{.compatible = "ti,tps546d24"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, tps546d24_of_match);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver tps546d24_driver = {
+	.driver = {
+		   .name = "tps546d24",
+		   .of_match_table = of_match_ptr(tps546d24_of_match),
+	   },
+	.probe_new = tps546d24_probe,
+	.id_table = tps546d24_id,
+};
+
+module_i2c_driver(tps546d24_driver);
+
+MODULE_AUTHOR("Duke Du <dukedu83@gmail.com>");
+MODULE_DESCRIPTION("PMBus driver for TI tps546d24");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.7.4

