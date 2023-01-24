Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD167A3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjAXUXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjAXUXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:23:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D20C7AA8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:23:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so11831976wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UICSQ0KGAaDFDCLkijObhcNXoKPNZnLJdEBdbwNAlQE=;
        b=Dz5k9Nf07Dqj3/RKEWR1jVbWe2JasrqI2F2GyAzepJiUyPK7Jlrae9KcaXbASnDVz3
         n3paHvE4ZAHL0bCVD/vHuLW4BWZFmjnQD9eG3KWN1+8KGnHThJWvPNr1tC4VQoeL9kM2
         Si3CJp1hV4H/NOYdwFC/vVJIg3xb7ewXvBZ1PEJ6wNBzFtoqMDbpAAw5ysyEkSk20Itp
         X7lx7yiCkYWYM2D+/hYFh9lGDh9VXvYyyan0M3TLbL/hT0i+KeB14RypbG8XUZPGNGEx
         vZIJvCB6/UsK8GTMxgz6flhHFTl6hNY+CZtewwCLCqwjEDndJCgFxRc4Wnx1enKSlpRS
         2rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UICSQ0KGAaDFDCLkijObhcNXoKPNZnLJdEBdbwNAlQE=;
        b=iMP8FUOWxvfmgfUud6gyII/woyF0CQC8CIIp3yiIxtGndbinG+xHdSACvlbjnaUzbt
         8vcx8AuZBnk6BdPamqIZTyjR0mrMDqo7+HkGZe/gH8xKwPBbkAjq3N+uWLI+/N3N5yYG
         wXJfNzNa1XJza9CyEyo2NkhngU1ACFwKUO3+HQPrT354jbPa3xyO5MRd+5VipwOv8z5v
         rtSlrU/99d33uTd8rN6e6004o+HTbFvRi8Y0ZZtGFYaMmMsM0gqx+dqv+rZPxd/CErz/
         JebmDyBVERDR0DaiszfpsU/ZvoXlNrYmfislaEZKpeUVgHd/kQWM799589V5acMObilp
         hLMA==
X-Gm-Message-State: AFqh2kqk55Eptl2Cujz60fZSaxURpIHkagQzFiZDBg34LQxWL3MOKnMK
        +4R2x3LcQo/bxXQs1kWt/4OhAQ==
X-Google-Smtp-Source: AMrXdXu/xUDrf9o/hA6BewLo6QzV20PMyGf99JVLTS7aC8wuYy0K0IpHpd+RcCeVDJj8RvyS9x55mQ==
X-Received: by 2002:a05:600c:540d:b0:3d9:fb59:c16b with SMTP id he13-20020a05600c540d00b003d9fb59c16bmr26200435wmb.36.1674591818673;
        Tue, 24 Jan 2023 12:23:38 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003d9df9e59c4sm15334737wmq.37.2023.01.24.12.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:23:38 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] hwmon: (pmbus/tda38640) Add driver for Infineon TDA38640 Voltage Regulator
Date:   Tue, 24 Jan 2023 21:23:17 +0100
Message-Id: <20230124202317.3704963-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230124202317.3704963-1-Naresh.Solanki@9elements.com>
References: <20230124202317.3704963-1-Naresh.Solanki@9elements.com>
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

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add the pmbus driver for the Infineon TDA38640 voltage regulator.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/Kconfig    | 16 ++++++++
 drivers/hwmon/pmbus/Makefile   |  1 +
 drivers/hwmon/pmbus/tda38640.c | 74 ++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
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
index 000000000000..c3e781319cd1
--- /dev/null
+++ b/drivers/hwmon/pmbus/tda38640.c
@@ -0,0 +1,74 @@
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
+		.name = "tda38640",
+		.of_match_table = of_match_ptr(tda38640_of_match),
+	},
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

