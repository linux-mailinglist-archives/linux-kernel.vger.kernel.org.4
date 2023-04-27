Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C962D6F0CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245572AbjD0Tfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245501AbjD0Tfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:35:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC333C1B;
        Thu, 27 Apr 2023 12:35:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b4960b015so6995646b3a.3;
        Thu, 27 Apr 2023 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682624137; x=1685216137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aA4RtaJZPtabUlxR3HvRccxE/jFM/xHE97Tk3j3YwIU=;
        b=jN/5Aq2fcW37cE5wkCpZAgVlM9w+/pVq5KrMSJSN/5jl7B8IrC5cAomcZpfB5NV7rw
         5S49rwWxBQXO+VMXlw4CndtAa0ucRQJsMkkbkPBlKBginy73ACP/otpzIHzvzAHBJxOI
         H6HO+Deuv8z7CrxGjajEJIyY/9Aod2LKlgSIn5vwxW66UMNZmYy/H4+no4Xw3YW70L+f
         ym4dWoBOMxpDv8FlS0OsniLLR41Hn0BCTd/UD99Kg+hZ4YaYov0H1LsFKPaKAxwn3qL/
         /gKikzaMhOvr0f2x3lCr8G0adDGgkJx8oHpPxq2ZK8iza+imtmw9YSLV4GhXpSrPI1fk
         HS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682624137; x=1685216137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aA4RtaJZPtabUlxR3HvRccxE/jFM/xHE97Tk3j3YwIU=;
        b=hpLM0wKHbqNHiSZX8QcMhI1LJPTrz4YG1RqhI0KJK7t+DtvNeE1TR0F5SRN59++sbh
         ZBNcSULh69aXdWFciaFlu6CBn0nm8LounxtSWzdsHpaMfbhOhMzreHawHKm1lIgPoJ8S
         /4uNpuTAwgQI7xhZ3JRrHz7HxB9oJByNcFgqEHM+sK+BlKi73nSdBASgR8vkkw2WPs/W
         HYOufxHlMIA6FUxlwcc/VNMChE0buZhrZbaVfNpG9uVdnopfZnorfE1pxhr+v+dXG+he
         7h6rcdIJQP56M7wK675Pwoh47XONSQJ4sCgOwjwf6w9tYdE7v4H2Fc7R90b3eWwdlo4c
         Ay9w==
X-Gm-Message-State: AC+VfDwaV/oCLFgf+ctsUKReE/JBi96NgX6NMf7a3xOvvTxn3rs9rEns
        7qeuoRLsIMYsU77zHo5LqHg=
X-Google-Smtp-Source: ACHHUZ5r+ZOisemFY2bO0EdkobtzYRh7LOKH35Ne1K0dfL3H3FB7VK2CFCCHSf2/7VB8Lwlo7Njv0A==
X-Received: by 2002:a17:902:c948:b0:1a6:abac:9cc with SMTP id i8-20020a170902c94800b001a6abac09ccmr3447712pla.66.1682624137468;
        Thu, 27 Apr 2023 12:35:37 -0700 (PDT)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001a04d27ee92sm11997150plj.241.2023.04.27.12.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 12:35:37 -0700 (PDT)
From:   Scott Smith <scott8440@gmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     Scott Smith <scott8440@gmail.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (pmbus) add ir35215 driver
Date:   Thu, 27 Apr 2023 12:35:31 -0700
Message-Id: <20230427193533.718526-1-scott8440@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IR35215 is a digital multi-phase controller.

Signed-off-by: Scott Smith <scott8440@gmail.com>
---
 drivers/hwmon/pmbus/Kconfig   |  9 +++++
 drivers/hwmon/pmbus/Makefile  |  1 +
 drivers/hwmon/pmbus/ir35215.c | 65 +++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/ir35215.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 270b6336b76d..5c089f7e4423 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -123,6 +123,15 @@ config SENSORS_INSPUR_IPSPS
 	  This driver can also be built as a module. If so, the module will
 	  be called inspur-ipsps.
 
+config SENSORS_IR35215
+       tristate "Infineon IR35215"
+       help
+         If you say yes here you get hardware monitoring support for the
+         Infineon IR35215 controller.
+
+         This driver can also be built as a module. If so, the module will
+         be called ir35215.
+
 config SENSORS_IR35221
 	tristate "Infineon IR35221"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 84ee960a6c2d..fbb9cf048326 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_FSP_3Y)	+= fsp-3y.o
 obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
 obj-$(CONFIG_SENSORS_DPS920AB)	+= dps920ab.o
 obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
+obj-$(CONFIG_SENSORS_IR35215)   += ir35215.o
 obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
 obj-$(CONFIG_SENSORS_IR36021)	+= ir36021.o
 obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
diff --git a/drivers/hwmon/pmbus/ir35215.c b/drivers/hwmon/pmbus/ir35215.c
new file mode 100644
index 000000000000..92d59e78bfd0
--- /dev/null
+++ b/drivers/hwmon/pmbus/ir35215.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for Infineon IR35215
+ *
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
+ */
+
+#include <linux/err.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "pmbus.h"
+
+static const u32 functionality = PMBUS_HAVE_TEMP
+	| PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
+	| PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT
+	| PMBUS_HAVE_PIN | PMBUS_HAVE_POUT
+	| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
+	| PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP;
+
+static struct pmbus_driver_info ir35215_info = {
+	.pages = 2,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.func[0] = functionality,
+	.func[1] = functionality,
+};
+
+static int ir35215_probe(struct i2c_client *client)
+{
+	/*
+	 * IR35215 devices may not stay in page 0 during device
+	 * probe which leads to probe failure (read status word failed).
+	 * So let's set the device to page 0 at the beginning.
+	 */
+	i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	return pmbus_do_probe(client, &ir35215_info);
+}
+
+static const struct i2c_device_id ir35215_id[] = {
+	{ "ir35215", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ir35215_id);
+
+static struct i2c_driver ir35215_driver = {
+	.driver = {
+		   .name = "ir35215",
+	},
+	.probe_new = ir35215_probe,
+	.id_table = ir35215_id,
+};
+
+module_i2c_driver(ir35215_driver);
+
+MODULE_AUTHOR("Tao Ren <rentao.bupt@gmail.com>");
+MODULE_DESCRIPTION("PMBus driver for Infineon IR35215");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.34.1

