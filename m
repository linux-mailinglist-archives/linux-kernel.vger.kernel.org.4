Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBFA70F6DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjEXMrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjEXMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:47:10 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9761BD;
        Wed, 24 May 2023 05:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULc8sjF9D0T1TmTquCEcQxBmrmM/Ri12LUmivxNG7S9HQwpjFutT/MhLuF5jJS0g+2h1opjbziuvI7igElu6iBN4HsuGNoshbRdJmK2kfrOPzrzneUmOvFJrbDcgNtvOmqLWPbfd2WHxw4Nsd/b03w3e41e7ec9R8dtnns3070yiHoqUjE3yXyEvWHxVqz0S0kz5rtKsnsjMwLq7N75hWx358Vq8QeLSfj0KzwfMxTfF67JpHFbB5suk8BnMyLORvtNJ+YTSLDsUv3kRhcs54LLXGxpucIzdDIzXtUQZFnqfPfwtSxmw/t7ORrdlggCeA8nbI6rds+zobElqYzHNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPeQ15n7qmOzwPQai54yq6/WTsgJDW1jLz12XX4r93o=;
 b=NwEdWv8J6TB5E/2Q9nShJNvx7w5lHAn/2fInhsmm/Lf4P28SYp3z9yoglWxIUL/Bzp2JxzH+L4zM9fH4qVFzefckw8pWuzai1KpDJkGQI/QOrQOW90sO+S6X+U2rK64aQleGfQH9l0tBeb8E72w2u+ntJ5+ZEWkdyIoip7RJAWcqTuS8M4a2ixzzNb8Q0y5ZjdD7KL04DtUaADU677BR6e7YazmhwZBzuZNVvScJ/2KKYRJyD7PlcBGXstril7XEIfefN2QproWX1esgE+O8vAVtECJMsdjg+/+VOuqw3dwSTijLxdyGmQXHSOnCmTqAQg5meTbpvlJ8FkNhadOY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPeQ15n7qmOzwPQai54yq6/WTsgJDW1jLz12XX4r93o=;
 b=k4IDnHUGYhg8qubxkjpm/WxNYtlDeOMnwiWLJisc80MAosxZ2sNEhQ28zskMvzJKnhjQZ5co8NGn0KI60eP5dKSiDt7pErY3xAHgW/PREBBltmo42PstVTnTzzWgkpoJv7VFSeEmXpwIjj2EN7yJJIRzh/HJ1T8lwC28wqNB3RLgohwI+ZQ8ynRgg5osY8HErgqbuKKdcdHO44aMwdA7oilJxFN9v3qkN1jBXd8CKEy26j8lkGVudGd8NkXMq8iN49CpVyZ1B0VikY122JmY0Q7xm6D1wB6BVUlJ1Fj/xm+IXP30JJl7+1RP1yOPCFiUT46duTUwN5llZh/HfPu3HQ==
Received: from AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) by DBAPR10MB4108.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:1c5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 12:46:55 +0000
Received: from VE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:208:10e:cafe::f2) by AM0PR01CA0089.outlook.office365.com
 (2603:10a6:208:10e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 12:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT011.mail.protection.outlook.com (10.152.2.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.16 via Frontend Transport; Wed, 24 May 2023 12:46:54 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 24 May 2023 14:46:54 +0200
Received: from localhost.localdomain (139.22.37.129) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 24 May 2023 14:46:53 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 3/4] leds: simatic-ipc-leds-gpio: split up into multiple drivers
Date:   Wed, 24 May 2023 14:46:27 +0200
Message-ID: <20230524124628.32295-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230524124628.32295-1-henning.schild@siemens.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.22.37.129]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT011:EE_|DBAPR10MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad04797-18c7-445a-8cba-08db5c54f446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3wCcZYlq09FqjPhTuOng5S2SJ0t+TdsKIHcPwMVEWCV3Fr2HfGU1rz0KLU3rD8fYYzT8+G90Wb6M6OdXKZMhU0BU7wdA3IHgenNii3Ux7gRCb+z6suInPAuS82n+OSZYSpQyb6RIORuLtGW2Xaq2GTHjNyKZMvMDOJ5UOaDAAM8MWCqTeTE1eVuy7aw30O4Dz9PVNX/01Nb6cQEanarSR9XiWWH+xLWjVOH5xLlpqWYYDkOPSCEF6+mt4AYsR74auOfZlyxMNZo2+W3g2DZHfYQn1QpInpYOZp/XUhTb5OAUxHJKwWHd99NRNQqOIORu7n2NJp5w6IuP5rOjITZAI3eVaVckNBpbqKmNjhSC5akqcVTGmjHb0HPKLnUFEr/TRGDuhwt+vRn9piEjMIp6EOziSGervft3giyw3U91mKGaunyQcWpHWeutytVw95aS6x/GSuic9ReAoH/KLHQ3/0UHXzx4btdujttvZEiUoRLQ7Ov3nTvRw+6BAw4nchMADHgCWiypC+AWdVyIWRuTCINpgY3+JARUBMFhveXG/CJREub/caRwEFvzbSEkrdtSDDUkswTK9VjrTputszIwECMS6Ro0jEcTdrvYXVn5kHDS7Vx63eTeikbLJSXhQLXOpTVcPUOzTBa3IJY/p1cTGhApPEf2qJJrCORFEDHaOiBfN1gLFQdKIRlb9Gs8u/hQR4gUpNyTn1qZ+VQqHjxPbsiva62OQQ355akNbjbxJQSfbjhmwao7AbpnQIsHs4/EYWSuQBxwmXqjWt1GYs4iQ==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(336012)(36860700001)(47076005)(83380400001)(4326008)(70586007)(70206006)(107886003)(6666004)(2616005)(956004)(1076003)(110136005)(26005)(16526019)(186003)(478600001)(30864003)(86362001)(2906002)(8676002)(8936002)(44832011)(5660300002)(36756003)(316002)(81166007)(82960400001)(356005)(82740400003)(41300700001)(40480700001)(40460700003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:46:54.7704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad04797-18c7-445a-8cba-08db5c54f446
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4108
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to clearly describe the dependencies between the GPIO
controller drivers and the users the driver is split up into a core,
two drivers and a common header.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/Makefile                  |   4 +-
 .../simple/simatic-ipc-leds-gpio-apollolake.c |  66 +++++++
 .../leds/simple/simatic-ipc-leds-gpio-core.c  | 104 +++++++++++
 .../simple/simatic-ipc-leds-gpio-f7188x.c     |  66 +++++++
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 163 ------------------
 drivers/leds/simple/simatic-ipc-leds-gpio.h   |  22 +++
 drivers/leds/simple/simatic-ipc-leds.c        |   1 -
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 8 files changed, 265 insertions(+), 168 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-core.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
 delete mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.h

diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
index 1c7ef5e1324b..ed9057f7b6da 100644
--- a/drivers/leds/simple/Makefile
+++ b/drivers/leds/simple/Makefile
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)  += simatic-ipc-leds-gpio-core.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-apollolake.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-f7188x.o
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c b/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
new file mode 100644
index 000000000000..e1c712729dcf
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#include "simatic-ipc-leds-gpio.h"
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
+		{} /* Terminating entry */
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
+	.dev_id = NULL, /* Filled during initialization */
+	.table = {
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
+	},
+};
+
+static int simatic_ipc_leds_gpio_apollolake_probe(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_table,
+					   &simatic_ipc_led_gpio_table_extra);
+}
+
+static int simatic_ipc_leds_gpio_apollolake_remove(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
+					    &simatic_ipc_led_gpio_table_extra);
+}
+
+static struct platform_driver simatic_ipc_led_gpio_apollolake_driver = {
+	.probe = simatic_ipc_leds_gpio_apollolake_probe,
+	.remove = simatic_ipc_leds_gpio_apollolake_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+module_platform_driver(simatic_ipc_led_gpio_apollolake_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-leds-gpio-core platform:apollolake-pinctrl");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
new file mode 100644
index 000000000000..2a21b663df87
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#include "simatic-ipc-leds-gpio.h"
+
+static struct platform_device *simatic_leds_pdev;
+
+static const struct gpio_led simatic_ipc_gpio_leds[] = {
+	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
+};
+
+static const struct gpio_led_platform_data simatic_ipc_gpio_leds_pdata = {
+	.num_leds	= ARRAY_SIZE(simatic_ipc_gpio_leds),
+	.leds		= simatic_ipc_gpio_leds,
+};
+
+int simatic_ipc_leds_gpio_remove(struct platform_device *pdev,
+				 struct gpiod_lookup_table *table,
+				 struct gpiod_lookup_table *table_extra)
+{
+	gpiod_remove_lookup_table(table);
+	gpiod_remove_lookup_table(table_extra);
+	platform_device_unregister(simatic_leds_pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(simatic_ipc_leds_gpio_remove);
+
+int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
+				struct gpiod_lookup_table *table,
+				struct gpiod_lookup_table *table_extra)
+{
+	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct gpio_desc *gpiod;
+	int err;
+
+	switch (plat->devmode) {
+	case SIMATIC_IPC_DEVICE_127E:
+	case SIMATIC_IPC_DEVICE_227G:
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	gpiod_add_lookup_table(table);
+	simatic_leds_pdev = platform_device_register_resndata(NULL,
+		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
+		&simatic_ipc_gpio_leds_pdata,
+		sizeof(simatic_ipc_gpio_leds_pdata));
+	if (IS_ERR(simatic_leds_pdev)) {
+		err = PTR_ERR(simatic_leds_pdev);
+		goto out;
+	}
+
+	table_extra->dev_id = dev_name(dev);
+	gpiod_add_lookup_table(table_extra);
+
+	/* PM_BIOS_BOOT_N */
+	gpiod = gpiod_get_index(dev, NULL, 6, GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		goto out;
+	}
+	gpiod_put(gpiod);
+
+	/* PM_WDT_OUT */
+	gpiod = gpiod_get_index(dev, NULL, 7, GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		goto out;
+	}
+	gpiod_put(gpiod);
+
+	return 0;
+out:
+	simatic_ipc_leds_gpio_remove(pdev, table, table_extra);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(simatic_ipc_leds_gpio_probe);
+
+MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: platform:leds-gpio");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
new file mode 100644
index 000000000000..583a6b6c7c22
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#include "simatic-ipc-leds-gpio.h"
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 1, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 2, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
+		{} /* Terminating entry */
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
+	.dev_id = NULL, /* Filled during initialization */
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
+	},
+};
+
+static int simatic_ipc_leds_gpio_f7188x_probe(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_table,
+					   &simatic_ipc_led_gpio_table_extra);
+}
+
+static int simatic_ipc_leds_gpio_f7188x_remove(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
+					    &simatic_ipc_led_gpio_table_extra);
+}
+
+static struct platform_driver simatic_ipc_led_gpio_driver = {
+	.probe = simatic_ipc_leds_gpio_f7188x_probe,
+	.remove = simatic_ipc_leds_gpio_f7188x_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+module_platform_driver(simatic_ipc_led_gpio_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-leds-gpio-core gpio_f7188x");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
deleted file mode 100644
index 0f1fde44e8d9..000000000000
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ /dev/null
@@ -1,163 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Siemens SIMATIC IPC driver for GPIO based LEDs
- *
- * Copyright (c) Siemens AG, 2022
- *
- * Authors:
- *  Henning Schild <henning.schild@siemens.com>
- */
-
-#include <linux/gpio/machine.h>
-#include <linux/gpio/consumer.h>
-#include <linux/leds.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/platform_data/x86/simatic-ipc-base.h>
-
-static struct gpiod_lookup_table *simatic_ipc_led_gpio_table;
-static struct gpiod_lookup_table *simatic_ipc_led_gpio_table_extra;
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
-	.dev_id = "leds-gpio",
-	.table = {
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
-		{} /* Terminating entry */
-	},
-};
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e_extra = {
-	.dev_id = NULL, /* Filled during initialization */
-	.table = {
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
-		{} /* Terminating entry */
-	},
-};
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
-	.dev_id = "leds-gpio",
-	.table = {
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 1, NULL, 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 2, NULL, 2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
-		{} /* Terminating entry */
-	},
-};
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g_extra = {
-	.dev_id = NULL, /* Filled during initialization */
-	.table = {
-		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
-		{} /* Terminating entry */
-	},
-};
-
-static const struct gpio_led simatic_ipc_gpio_leds[] = {
-	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
-	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
-	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
-	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
-	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
-	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
-};
-
-static const struct gpio_led_platform_data simatic_ipc_gpio_leds_pdata = {
-	.num_leds	= ARRAY_SIZE(simatic_ipc_gpio_leds),
-	.leds		= simatic_ipc_gpio_leds,
-};
-
-static struct platform_device *simatic_leds_pdev;
-
-static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
-{
-	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table);
-	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table_extra);
-	platform_device_unregister(simatic_leds_pdev);
-
-	return 0;
-}
-
-static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
-{
-	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
-	struct device *dev = &pdev->dev;
-	struct gpio_desc *gpiod;
-	int err;
-
-	switch (plat->devmode) {
-	case SIMATIC_IPC_DEVICE_127E:
-		if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
-			return -ENODEV;
-		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
-		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_127e_extra;
-		break;
-	case SIMATIC_IPC_DEVICE_227G:
-		if (!IS_ENABLED(CONFIG_GPIO_F7188X))
-			return -ENODEV;
-		request_module("gpio-f7188x");
-		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_227g;
-		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_227g_extra;
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	gpiod_add_lookup_table(simatic_ipc_led_gpio_table);
-	simatic_leds_pdev = platform_device_register_resndata(NULL,
-		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
-		&simatic_ipc_gpio_leds_pdata,
-		sizeof(simatic_ipc_gpio_leds_pdata));
-	if (IS_ERR(simatic_leds_pdev)) {
-		err = PTR_ERR(simatic_leds_pdev);
-		goto out;
-	}
-
-	simatic_ipc_led_gpio_table_extra->dev_id = dev_name(dev);
-	gpiod_add_lookup_table(simatic_ipc_led_gpio_table_extra);
-
-	/* PM_BIOS_BOOT_N */
-	gpiod = gpiod_get_index(dev, NULL, 6, GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod)) {
-		err = PTR_ERR(gpiod);
-		goto out;
-	}
-	gpiod_put(gpiod);
-
-	/* PM_WDT_OUT */
-	gpiod = gpiod_get_index(dev, NULL, 7, GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod)) {
-		err = PTR_ERR(gpiod);
-		goto out;
-	}
-	gpiod_put(gpiod);
-
-	return 0;
-out:
-	simatic_ipc_leds_gpio_remove(pdev);
-
-	return err;
-}
-
-static struct platform_driver simatic_ipc_led_gpio_driver = {
-	.probe = simatic_ipc_leds_gpio_probe,
-	.remove = simatic_ipc_leds_gpio_remove,
-	.driver = {
-		.name = KBUILD_MODNAME,
-	}
-};
-module_platform_driver(simatic_ipc_led_gpio_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" KBUILD_MODNAME);
-MODULE_SOFTDEP("pre: platform:leds-gpio");
-MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.h b/drivers/leds/simple/simatic-ipc-leds-gpio.h
new file mode 100644
index 000000000000..bf258c32f83d
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#ifndef _SIMATIC_IPC_LEDS_GPIO_H
+#define _SIMATIC_IPC_LEDS_GPIO_H
+
+int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
+				struct gpiod_lookup_table *table,
+				struct gpiod_lookup_table *table_extra);
+
+int simatic_ipc_leds_gpio_remove(struct platform_device *pdev,
+				 struct gpiod_lookup_table *table,
+				 struct gpiod_lookup_table *table_extra);
+
+#endif /* _SIMATIC_IPC_LEDS_GPIO_H */
diff --git a/drivers/leds/simple/simatic-ipc-leds.c b/drivers/leds/simple/simatic-ipc-leds.c
index 4894c228c165..2124f6d09930 100644
--- a/drivers/leds/simple/simatic-ipc-leds.c
+++ b/drivers/leds/simple/simatic-ipc-leds.c
@@ -126,7 +126,6 @@ static struct platform_driver simatic_ipc_led_driver = {
 		.name = KBUILD_MODNAME,
 	}
 };
-
 module_platform_driver(simatic_ipc_led_driver);
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index b3622419cd1a..c773995b230d 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -68,9 +68,10 @@ static int register_platform_devices(u32 station_id)
 	}
 
 	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
-		if (ledmode == SIMATIC_IPC_DEVICE_127E ||
-		    ledmode == SIMATIC_IPC_DEVICE_227G)
-			pdevname = KBUILD_MODNAME "_leds_gpio";
+		if (ledmode == SIMATIC_IPC_DEVICE_127E)
+			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
+		if (ledmode == SIMATIC_IPC_DEVICE_227G)
+			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
 		platform_data.devmode = ledmode;
 		ipc_led_platform_device =
 			platform_device_register_data(NULL,
-- 
2.39.3

