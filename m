Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF03679B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjAXOOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjAXOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:14:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396FB47406
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:14:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h12so10019088wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo1Yi/+DTb6H4LwCmDu+mCgzAi4RW77ZGtpcAUxfPiA=;
        b=WEXqLa+GFSz8MU4EQ4IJ06iPhdghwTb8Henso6XXye73JyJwce1e8oiibkMGG1Xqy1
         4kWynw+u8+WYNUDLDqCCl2PPSJRhsZg7k2WeuW0ALylB70A7XK6xjdYf9ZEqsId+p/on
         6qSlnWxxPEtVr2wxYLqTmUxsopoZAn4vO1mIv7CW7c8MQFeEUTtFx0vuG948bUB87VXT
         ZBhosvV0SxWIJqovNoP2Em1TeOhPY1LsG+OEkstScok3aSLtMU/Xq6PyTHkt3xS2KRTk
         WAcYZA1+Qvlk4J8bb+eepIEiwLVpaPiIhobPuwdkBiChOocxOcWOkKGuD2TZBMgLTprO
         aamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jo1Yi/+DTb6H4LwCmDu+mCgzAi4RW77ZGtpcAUxfPiA=;
        b=7LbOgnbu/y50+9oDcT8F3XWu8BHgYdjeyCwKMEljJ+s6FZYA8PGIp9MSvtk1klF7dF
         1d/X0vcKHP5IVDD8DZT/Hu0iHRREVSEnlVQ5yKbqxrzUnVQVaEs+3WMFpVj+957XsdlZ
         dP31xBoj/SaPoE5QnGYGXfoT489f08et4RdYeI9fG/nbS+MVKBkhGPw4zTVGAQmFkQyK
         4qadGKK9pxeJ7qlbrUAzlrqHX4888LLavpW4ksGcAMdnc9AbvvJHwODtiEJ/mOlYPf6R
         o/4ZIkrxR0AbIqhsKd4S1ZqwY2+zTOiHQMjIGkE84SWXZvO8RmTxTGDk1PJ3cPZyhlbm
         1ddA==
X-Gm-Message-State: AFqh2kpQphV5enmLNqyj+lWW5W4/bFCFNNqOf5TRDfncZub51jYC/naB
        MmyQZP3reyFIr9PIwGQRGT8YOg==
X-Google-Smtp-Source: AMrXdXtmoLxqtwXwBdtjbx7sdmnN0hZwSDLQgYXvIaeVKBhrUpuQXRr2rp6/ipC9bHn99bcWdtNl4A==
X-Received: by 2002:a5d:6b42:0:b0:2bc:7e6c:7cd8 with SMTP id x2-20020a5d6b42000000b002bc7e6c7cd8mr24605625wrw.26.1674569681583;
        Tue, 24 Jan 2023 06:14:41 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id z8-20020a5d4408000000b002b8fe58d6desm1966269wrq.62.2023.01.24.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:14:41 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (pmbus/tda38640) Add driver for Infineon TDA38640 Voltage Regulator
Date:   Tue, 24 Jan 2023 15:14:35 +0100
Message-Id: <20230124141436.1687397-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230124141436.1687397-1-Naresh.Solanki@9elements.com>
References: <20230124141436.1687397-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add the pmbus driver for the Infineon TDA38640 voltage regulator.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/Kconfig    | 16 ++++++++
 drivers/hwmon/pmbus/Makefile   |  1 +
 drivers/hwmon/pmbus/tda38640.c | 73 ++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/tda38640.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 30448e049486..9f4bbb9c487a 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -395,6 +395,22 @@ config SENSORS_STPDDC60
 	  This driver can also be built as a module. If so, the module will
 	  be called stpddc60.
 
+config SENSORS_TDA38640
+	tristate "Infineon TDA38640"
+	help
+	  If you say yes here you get hardware monitoring support for Infineon
+	  TDA38640.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called tda38640.
+
+config SENSORS_TDA38640_REGULATOR
+	bool "Regulator support for TDA38640 and compatibles"
+	depends on SENSORS_TDA38640 && REGULATOR
+	help
+	  If you say yes here you get regulator support for Infineon
+	  TDA38640 as regulator.
+
 config SENSORS_TPS40422
 	tristate "TI TPS40422"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index d9d2fa4bd6f7..3ae019916267 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
 obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
 obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
 obj-$(CONFIG_SENSORS_STPDDC60)	+= stpddc60.o
+obj-$(CONFIG_SENSORS_TDA38640)	+= tda38640.o
 obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
 obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
 obj-$(CONFIG_SENSORS_TPS546D24)	+= tps546d24.o
diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
new file mode 100644
index 000000000000..6099a3cc568e
--- /dev/null
+++ b/drivers/hwmon/pmbus/tda38640.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for Infineon TDA38640
+ *
+ * Copyright (c) 2023 9elements GmbH
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/driver.h>
+#include "pmbus.h"
+
+static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
+	PMBUS_REGULATOR("vout", 0),
+};
+
+static struct pmbus_driver_info tda38640_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_POWER] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
+	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
+	    | PMBUS_HAVE_IIN
+	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
+	    | PMBUS_HAVE_POUT | PMBUS_HAVE_PIN,
+#if IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR)
+	.num_regulators = 1,
+	.reg_desc = tda38640_reg_desc,
+#endif
+};
+
+static int tda38640_probe(struct i2c_client *client)
+{
+	return pmbus_do_probe(client, &tda38640_info);
+}
+
+static const struct i2c_device_id tda38640_id[] = {
+	{"tda38640", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, tda38640_id);
+
+static const struct of_device_id __maybe_unused tda38640_of_match[] = {
+	{ .compatible = "infineon,tda38640"},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tda38640_of_match);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver tda38640_driver = {
+	.driver = {
+		   .name = "tda38640",
+		   },
+	.probe_new = tda38640_probe,
+	.id_table = tda38640_id,
+};
+
+module_i2c_driver(tda38640_driver);
+
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("PMBus driver for Infineon TDA38640");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.38.1

