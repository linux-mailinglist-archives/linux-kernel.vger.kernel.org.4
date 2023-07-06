Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D4774A184
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjGFPuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjGFPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:49:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E611FEF;
        Thu,  6 Jul 2023 08:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REEyBJ24989qHfYTD0qXnO62mU8rcWa7F70vvwI/F6ZTJgciQfFWosRDd31pJY2el/Wgp2dgwIgY44dd7tRvhRZpbA060NvfRGB/ytZvYPxsRjgSWDY868H09paPetYEr+CpgnAMyUHG6NIfiaI4N2mfMvNLOjBisnY76jOkTINxL03822nDj/tbN7prHjPYG2kZwNlt6AZUeHiklh1QBPUTOB3uKp8t4hLDJwEDh4qenYvnZpwLHvt/c9mAgt/xSvLEYah5yIHGB3XQOI7wI3pNA/mE3PJtCVPm2mcUlk4B4yTonzD+KgiNTRVYmNuSY1Hz1/+CPAhibnLGeldJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjWlAF+q8RylfW4xvo4zUhpgNcdB6LuQlClMClzvLg8=;
 b=j/OpmLWMihSxIwmJmTWeHqXvuFW3t4tf5R8D+lSF0B5MzFgkBjOyYaqUuzfqVWFrrFithIapLsQfeQ+oCtC12+OWJ+01Bp6/Xh6FZ4mC7aBTzqNlhslmaon/6nDRbAm0UHmIJUUCav5qg/ZiVIuy+gfLHHj/Z5WJqUzK5B58MvML0Mr0WjEu4nJtDPwTVDxI2+iXqREeBDhJQDG8voXaQG7c6Cx9417YbZdd1bv/PBd7WODVGcYGc1idGx9IZ9wbIKWOw5WmIxw4fjEoA4dl1s9C4HEpTi16XAZw2xRpyLXOdDQXiqKbeBeVEww/zU+xNo8O3SMO36OvOlxgXpOmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjWlAF+q8RylfW4xvo4zUhpgNcdB6LuQlClMClzvLg8=;
 b=xCoiZN8RGifE4U+mGrvYVf5AMJCT/3vK2i+BBzY4tH6LnYcnO+59HYNL4Ihf2Ed9rzfvi/yO+G0v/XqJfIIMMBMHZY913/MYXbe16PwU5qfvXlp4OAGKBhI+clucnBUlesIeCsRCtiLxcw6ThYAB5cW58KAQ6Q3yija8p1gdGroSMx4Qq8Xc1YCjqMmDe8RByModLZdig/pgrXoGUGOL+FjWfGURAOVI3GGRksEmpNUYswobDvahfyhfmbKmT4Mu+EUvB2YMx9Wb9/n2HRJ3sijcAk61acHTKi/9eR54FmiD1EiJK0iSLyjI8UCJt1bTW0EIkEurAe10kmpz05qAnQ==
Received: from GV2PEPF00000105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:1:0:1c) by DU0PR10MB7002.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 15:48:44 +0000
Received: from HE1EUR01FT051.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::208) by GV2PEPF00000105.outlook.office365.com
 (2603:1026:900::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 15:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT051.mail.protection.outlook.com (10.152.1.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Thu, 6 Jul 2023 15:48:43 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 17:48:43 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.40) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 6 Jul 2023 17:48:42 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-watchdog@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        "Tobias Schaffner" <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/2] platform/x86: add CMOS battery monitoring for simatic IPCs
Date:   Thu, 6 Jul 2023 17:48:31 +0200
Message-ID: <20230706154831.19100-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230706154831.19100-1-henning.schild@siemens.com>
References: <20230706154831.19100-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.40]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT051:EE_|DU0PR10MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 72185135-ed13-4537-4ea7-08db7e387a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVh9/wJ/KKbaUWZ5mzJRa4jaT7iYXVVep1keadeww9yXw8b7aXHx7KtF6CtBOKeCgPKTDPQAFdjHpvqC0cZFHFHFbUebzQNQYukoRa/5miRaXrUFR8IbwQCWZGDR6DBc8wZalZ4vbmXna1cUzcf26QFdjXA0HAP5d9BcQB7iGCCFniLYybPgHHVxmEA7ZIvYUGuqtsip80IHpBZcqSh9gRvvBToIYVNPjRN4AmjQpYRdUPsoqA7MBD/cg9gRR7Pviea8py8LLGSnWg5dj5rhYFesMNsNBxMCbqDRplTWxOyHp7Q+fbbbmzYIV7Ym45khDsdj3+eA6YAM/W+lH1aVJyftO4xE6Six/CmYd7iBCrTgCkSWs1zyA4V9W86UuHBvzmBwlWSjYjqlF03GtM2r/uiZvFE4aWXmnpTCAJ2fT/C/Nuvn3CrVuwmof3c4wJyxA95UP6+pkH45wl46dAZ/BaVipksCbxiGli0eI8SnE6ySkoYL81yJaOlJnHgCQ9x3pkZdjoetuyp6LRNzx/VGld12Ged5pEmMRO6RB4N7OITDT1Jju/uUiWsBe8KUSFjFZGvbB+I6j8ITgf43RE49QWsoQDc6CXV5guX80hOZ9K8JN8brhn5Nx5ui2EpgFiYEZkmaYxPUgsOEPQ/nG1zce5YRxpIZ4iQlny9y2bjnTv+OB1p5NiqEfOkCNwY9mrsUzPCiXZLYUVdKi6CCOYcKcZlL4PieKyc2IaEd+pb7xB0BDez5P/BDe9ehgImhmvv3
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(8936002)(8676002)(70586007)(70206006)(316002)(2906002)(36756003)(4326008)(44832011)(478600001)(30864003)(40460700003)(186003)(41300700001)(336012)(40480700001)(36860700001)(54906003)(110136005)(82310400005)(16526019)(82960400001)(356005)(47076005)(26005)(1076003)(86362001)(6666004)(107886003)(82740400003)(2616005)(7596003)(7636003)(83380400001)(956004);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 15:48:43.8388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72185135-ed13-4537-4ea7-08db7e387a5e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT051.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7002
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Siemens Simatic Industrial PCs can monitor the voltage of the CMOS
battery with two bits that indicate low or empty state. This can be GPIO
or PortIO based.
Here we model that as a hwmon voltage. The core driver does the PortIO
and provides boilerplate for the GPIO versions. Which are split out to
model runtime dependencies while allowing fine-grained kernel
configuration.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/Kconfig                  |  48 ++++
 drivers/platform/x86/Makefile                 |   6 +-
 .../x86/simatic-ipc-batt-apollolake.c         |  51 ++++
 .../x86/simatic-ipc-batt-elkhartlake.c        |  51 ++++
 .../platform/x86/simatic-ipc-batt-f7188x.c    |  70 +++++
 drivers/platform/x86/simatic-ipc-batt.c       | 250 ++++++++++++++++++
 drivers/platform/x86/simatic-ipc-batt.h       |  20 ++
 drivers/platform/x86/simatic-ipc.c            |  65 ++++-
 .../platform_data/x86/simatic-ipc-base.h      |   1 +
 9 files changed, 547 insertions(+), 15 deletions(-)
 create mode 100644 drivers/platform/x86/simatic-ipc-batt-apollolake.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt-f7188x.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt.h

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 49c2c4cd8d00..ad15063e1178 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1086,6 +1086,54 @@ config SIEMENS_SIMATIC_IPC
 	  To compile this driver as a module, choose M here: the module
 	  will be called simatic-ipc.
 
+config SIEMENS_SIMATIC_IPC_BATT
+	tristate "CMOS battery driver for Siemens Simatic IPCs"
+	depends on HWMON
+	depends on SIEMENS_SIMATIC_IPC
+	default SIEMENS_SIMATIC_IPC
+	help
+	  This option enables support for monitoring the voltage of the CMOS
+	  batteries of several Industrial PCs from Siemens.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-batt.
+
+config SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE
+	tristate "CMOS Battery monitoring for Simatic IPCs based on Apollo Lake GPIO"
+	depends on PINCTRL_BROXTON
+	depends on SIEMENS_SIMATIC_IPC_BATT
+	default SIEMENS_SIMATIC_IPC_BATT
+	help
+	  This option enables CMOS battery monitoring for Simatic Industrial PCs
+	  from Siemens based on Apollo Lake GPIO.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-batt-apollolake.
+
+config SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE
+	tristate "CMOS Battery monitoring for Simatic IPCs based on Elkhart Lake GPIO"
+	depends on PINCTRL_ELKHARTLAKE
+	depends on SIEMENS_SIMATIC_IPC_BATT
+	default SIEMENS_SIMATIC_IPC_BATT
+	help
+	  This option enables CMOS battery monitoring for Simatic Industrial PCs
+	  from Siemens based on Elkhart Lake GPIO.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-batt-elkhartlake.
+
+config SIEMENS_SIMATIC_IPC_BATT_F7188X
+	tristate "CMOS Battery monitoring for Simatic IPCs based on Nuvoton GPIO"
+	depends on GPIO_F7188X
+	depends on SIEMENS_SIMATIC_IPC_BATT
+	default SIEMENS_SIMATIC_IPC_BATT
+	help
+	  This option enables CMOS battery monitoring for Simatic Industrial PCs
+	  from Siemens based on Nuvoton GPIO.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-batt-elkhartlake.
+
 config WINMATE_FM07_KEYS
 	tristate "Winmate FM07/FM07P front-panel keys driver"
 	depends on INPUT
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 52dfdf574ac2..522da0d1584d 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -131,7 +131,11 @@ obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
 obj-$(CONFIG_X86_INTEL_LPSS)		+= pmc_atom.o
 
 # Siemens Simatic Industrial PCs
-obj-$(CONFIG_SIEMENS_SIMATIC_IPC)	+= simatic-ipc.o
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC)			+= simatic-ipc.o
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT)			+= simatic-ipc-batt.o
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE)	+= simatic-ipc-batt-apollolake.o
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE)	+= simatic-ipc-batt-elkhartlake.o
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_F7188X)		+= simatic-ipc-batt-f7188x.o
 
 # Winmate
 obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
diff --git a/drivers/platform/x86/simatic-ipc-batt-apollolake.c b/drivers/platform/x86/simatic-ipc-batt-apollolake.c
new file mode 100644
index 000000000000..0503cb89d8f8
--- /dev/null
+++ b/drivers/platform/x86/simatic-ipc-batt-apollolake.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for CMOS battery monitoring
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "simatic-ipc-batt.h"
+
+struct gpiod_lookup_table simatic_ipc_batt_gpio_table_127e = {
+	.table = {
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 55, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 61, NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.1", 41, NULL, 2, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
+	},
+};
+
+static int simatic_ipc_batt_apollolake_remove(struct platform_device *pdev)
+{
+	return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_127e);
+}
+
+static int simatic_ipc_batt_apollolake_probe(struct platform_device *pdev)
+{
+	return simatic_ipc_batt_probe(pdev, &simatic_ipc_batt_gpio_table_127e);
+}
+
+static struct platform_driver simatic_ipc_batt_driver = {
+	.probe = simatic_ipc_batt_apollolake_probe,
+	.remove = simatic_ipc_batt_apollolake_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+
+module_platform_driver(simatic_ipc_batt_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-batt platform:apollolake-pinctrl");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/platform/x86/simatic-ipc-batt-elkhartlake.c b/drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
new file mode 100644
index 000000000000..ecf5ceb167f9
--- /dev/null
+++ b/drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for CMOS battery monitoring
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "simatic-ipc-batt.h"
+
+struct gpiod_lookup_table simatic_ipc_batt_gpio_table_bx_21a = {
+	.table = {
+		GPIO_LOOKUP_IDX("INTC1020:04", 18, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("INTC1020:04", 19, NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("INTC1020:01", 66, NULL, 2, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
+	},
+};
+
+static int simatic_ipc_batt_elkhartlake_remove(struct platform_device *pdev)
+{
+	return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_bx_21a);
+}
+
+static int simatic_ipc_batt_elkhartlake_probe(struct platform_device *pdev)
+{
+	return simatic_ipc_batt_probe(pdev, &simatic_ipc_batt_gpio_table_bx_21a);
+}
+
+static struct platform_driver simatic_ipc_batt_driver = {
+	.probe = simatic_ipc_batt_elkhartlake_probe,
+	.remove = simatic_ipc_batt_elkhartlake_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+
+module_platform_driver(simatic_ipc_batt_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-batt platform:elkhartlake-pinctrl");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/platform/x86/simatic-ipc-batt-f7188x.c b/drivers/platform/x86/simatic-ipc-batt-f7188x.c
new file mode 100644
index 000000000000..a0189b9289f6
--- /dev/null
+++ b/drivers/platform/x86/simatic-ipc-batt-f7188x.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for CMOS battery monitoring
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#include "simatic-ipc-batt.h"
+
+struct gpiod_lookup_table simatic_ipc_batt_gpio_table_227g = {
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-7", 6, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-f7188x-7", 5, NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("INTC1020:01",  66, NULL, 2, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
+	},
+};
+
+struct gpiod_lookup_table simatic_ipc_batt_gpio_table_bx_39a = {
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-6", 4, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-f7188x-6", 3, NULL, 1, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
+	},
+};
+
+static int simatic_ipc_batt_f7188x_remove(struct platform_device *pdev)
+{
+	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+
+	if (plat->devmode == SIMATIC_IPC_DEVICE_227G)
+		return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_227g);
+
+	return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_bx_39a);
+}
+
+static int simatic_ipc_batt_f7188x_probe(struct platform_device *pdev)
+{
+	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+
+	if (plat->devmode == SIMATIC_IPC_DEVICE_227G)
+		return simatic_ipc_batt_probe(pdev, &simatic_ipc_batt_gpio_table_227g);
+
+	return simatic_ipc_batt_probe(pdev, &simatic_ipc_batt_gpio_table_bx_39a);
+}
+
+static struct platform_driver simatic_ipc_batt_driver = {
+	.probe = simatic_ipc_batt_f7188x_probe,
+	.remove = simatic_ipc_batt_f7188x_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+
+module_platform_driver(simatic_ipc_batt_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-batt gpio_f7188x platform:elkhartlake-pinctrl");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/platform/x86/simatic-ipc-batt.c b/drivers/platform/x86/simatic-ipc-batt.c
new file mode 100644
index 000000000000..a83272475b9d
--- /dev/null
+++ b/drivers/platform/x86/simatic-ipc-batt.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for CMOS battery monitoring
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Authors:
+ *  Gerd Haeussler <gerd.haeussler.ext@siemens.com>
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+#include <linux/sizes.h>
+
+#define BATT_DELAY_MS	(1000 * 60 * 60 * 24)	/* 24 h delay */
+
+#define SIMATIC_IPC_BATT_LEVEL_FULL	3000
+#define SIMATIC_IPC_BATT_LEVEL_CRIT	2750
+#define SIMATIC_IPC_BATT_LEVEL_EMPTY	   0
+
+static struct simatic_ipc_batt {
+	u8 devmode;
+	long current_state;
+	struct gpio_desc *gpios[3];
+	unsigned long last_updated_jiffies;
+} priv;
+
+static long simatic_ipc_batt_read_gpio(void)
+{
+	long r = SIMATIC_IPC_BATT_LEVEL_FULL;
+
+	if (priv.gpios[2]) {
+		gpiod_set_value(priv.gpios[2], 1);
+		msleep(150);
+	}
+
+	if (gpiod_get_value_cansleep(priv.gpios[0]))
+		r = SIMATIC_IPC_BATT_LEVEL_EMPTY;
+	else if (gpiod_get_value_cansleep(priv.gpios[1]))
+		r = SIMATIC_IPC_BATT_LEVEL_CRIT;
+
+	if (priv.gpios[2])
+		gpiod_set_value(priv.gpios[2], 0);
+
+	return r;
+}
+
+#define SIMATIC_IPC_BATT_PORT_BASE	0x404D
+static struct resource simatic_ipc_batt_io_res =
+	DEFINE_RES_IO_NAMED(SIMATIC_IPC_BATT_PORT_BASE, SZ_1, KBUILD_MODNAME);
+
+static long simatic_ipc_batt_read_io(struct device *dev)
+{
+	long r = SIMATIC_IPC_BATT_LEVEL_FULL;
+	struct resource *res = &simatic_ipc_batt_io_res;
+	u8 val;
+
+	if (!request_muxed_region(res->start, resource_size(res), res->name)) {
+		dev_err(dev, "Unable to register IO resource at %pR\n", res);
+		return -EBUSY;
+	}
+
+	val = inb(SIMATIC_IPC_BATT_PORT_BASE);
+	release_region(simatic_ipc_batt_io_res.start, resource_size(&simatic_ipc_batt_io_res));
+
+	if (val & (1 << 7))
+		r = SIMATIC_IPC_BATT_LEVEL_EMPTY;
+	else if (val & (1 << 6))
+		r = SIMATIC_IPC_BATT_LEVEL_CRIT;
+
+	return r;
+}
+
+static long simatic_ipc_batt_read_value(struct device *dev)
+{
+	unsigned long next_update;
+
+	next_update = priv.last_updated_jiffies + msecs_to_jiffies(BATT_DELAY_MS);
+	if (time_after(jiffies, next_update) || !priv.last_updated_jiffies) {
+		switch (priv.devmode) {
+		case SIMATIC_IPC_DEVICE_127E:
+		case SIMATIC_IPC_DEVICE_227G:
+		case SIMATIC_IPC_DEVICE_BX_39A:
+			priv.current_state = simatic_ipc_batt_read_gpio();
+			break;
+		case SIMATIC_IPC_DEVICE_227E:
+			priv.current_state = simatic_ipc_batt_read_io(dev);
+			break;
+		}
+		priv.last_updated_jiffies = jiffies;
+		if (priv.current_state < SIMATIC_IPC_BATT_LEVEL_FULL)
+			dev_warn(dev, "CMOS battery needs to be replaced.");
+	}
+
+	return priv.current_state;
+}
+
+static int simatic_ipc_batt_read(struct device *dev, enum hwmon_sensor_types type,
+				 u32 attr, int channel, long *val)
+{
+	switch (attr) {
+	case hwmon_in_input:
+		*val = simatic_ipc_batt_read_value(dev);
+		break;
+	case hwmon_in_lcrit:
+		*val = SIMATIC_IPC_BATT_LEVEL_CRIT;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static umode_t simatic_ipc_batt_is_visible(const void *data, enum hwmon_sensor_types type,
+					   u32 attr, int channel)
+{
+	if (attr == hwmon_in_input || attr == hwmon_in_lcrit)
+		return 0444;
+
+	return 0;
+}
+
+static const struct hwmon_ops simatic_ipc_batt_ops = {
+	.is_visible = simatic_ipc_batt_is_visible,
+	.read = simatic_ipc_batt_read,
+};
+
+static const struct hwmon_channel_info *simatic_ipc_batt_info[] = {
+	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT | HWMON_I_LCRIT),
+	NULL
+};
+
+static const struct hwmon_chip_info simatic_ipc_batt_chip_info = {
+	.ops = &simatic_ipc_batt_ops,
+	.info = simatic_ipc_batt_info,
+};
+
+int simatic_ipc_batt_remove(struct platform_device *pdev, struct gpiod_lookup_table *table)
+{
+	gpiod_remove_lookup_table(table);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(simatic_ipc_batt_remove);
+
+int simatic_ipc_batt_probe(struct platform_device *pdev, struct gpiod_lookup_table *table)
+{
+	struct simatic_ipc_platform *plat;
+	struct device *dev = &pdev->dev;
+	struct device *hwmon_dev;
+	int err;
+
+	plat = pdev->dev.platform_data;
+	priv.devmode = plat->devmode;
+
+	switch (priv.devmode) {
+	case SIMATIC_IPC_DEVICE_127E:
+	case SIMATIC_IPC_DEVICE_227G:
+	case SIMATIC_IPC_DEVICE_BX_39A:
+	case SIMATIC_IPC_DEVICE_BX_21A:
+		table->dev_id = dev_name(dev);
+		gpiod_add_lookup_table(table);
+		break;
+	case SIMATIC_IPC_DEVICE_227E:
+		goto nogpio;
+	default:
+		return -ENODEV;
+	}
+
+	priv.gpios[0] = devm_gpiod_get_index(dev, "CMOSBattery empty", 0, GPIOD_IN);
+	if (IS_ERR(priv.gpios[0])) {
+		err = PTR_ERR(priv.gpios[0]);
+		priv.gpios[0] = NULL;
+		goto out;
+	}
+	priv.gpios[1] = devm_gpiod_get_index(dev, "CMOSBattery low", 1, GPIOD_IN);
+	if (IS_ERR(priv.gpios[1])) {
+		err = PTR_ERR(priv.gpios[1]);
+		priv.gpios[1] = NULL;
+		goto out;
+	}
+
+	if (table->table[2].key) {
+		priv.gpios[2] = devm_gpiod_get_index(dev, "CMOSBattery meter", 2, GPIOD_OUT_HIGH);
+		if (IS_ERR(priv.gpios[2])) {
+			err = PTR_ERR(priv.gpios[1]);
+			priv.gpios[2] = NULL;
+			goto out;
+		}
+	} else {
+		priv.gpios[2] = NULL;
+	}
+
+nogpio:
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, KBUILD_MODNAME,
+							 &priv,
+							 &simatic_ipc_batt_chip_info,
+							 NULL);
+	if (IS_ERR(hwmon_dev)) {
+		err = PTR_ERR(hwmon_dev);
+		goto out;
+	}
+
+	/* warn about aging battery even if userspace never reads hwmon */
+	simatic_ipc_batt_read_value(dev);
+
+	return 0;
+out:
+	simatic_ipc_batt_remove(pdev, table);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(simatic_ipc_batt_probe);
+
+static int simatic_ipc_batt_io_remove(struct platform_device *pdev)
+{
+	return simatic_ipc_batt_remove(pdev, NULL);
+}
+
+static int simatic_ipc_batt_io_probe(struct platform_device *pdev)
+{
+	return simatic_ipc_batt_probe(pdev, NULL);
+}
+
+static struct platform_driver simatic_ipc_batt_driver = {
+	.probe = simatic_ipc_batt_io_probe,
+	.remove = simatic_ipc_batt_io_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+
+module_platform_driver(simatic_ipc_batt_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/platform/x86/simatic-ipc-batt.h b/drivers/platform/x86/simatic-ipc-batt.h
new file mode 100644
index 000000000000..4545cd3e3026
--- /dev/null
+++ b/drivers/platform/x86/simatic-ipc-batt.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Siemens SIMATIC IPC driver for CMOS battery monitoring
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#ifndef _SIMATIC_IPC_BATT_H
+#define _SIMATIC_IPC_BATT_H
+
+int simatic_ipc_batt_probe(struct platform_device *pdev,
+			   struct gpiod_lookup_table *table);
+
+int simatic_ipc_batt_remove(struct platform_device *pdev,
+			    struct gpiod_lookup_table *table);
+
+#endif /* _SIMATIC_IPC_BATT_H */
diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 4402cd354104..6d2c94c17414 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -21,6 +21,7 @@
 
 static struct platform_device *ipc_led_platform_device;
 static struct platform_device *ipc_wdt_platform_device;
+static struct platform_device *ipc_batt_platform_device;
 
 static const struct dmi_system_id simatic_ipc_whitelist[] = {
 	{
@@ -37,38 +38,71 @@ static struct {
 	u32 station_id;
 	u8 led_mode;
 	u8 wdt_mode;
+	u8 batt_mode;
 } device_modes[] = {
-	{SIMATIC_IPC_IPC127E, SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE},
-	{SIMATIC_IPC_IPC227D, SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE},
-	{SIMATIC_IPC_IPC227E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E},
-	{SIMATIC_IPC_IPC227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
-	{SIMATIC_IPC_IPC277E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E},
-	{SIMATIC_IPC_IPC427D, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
-	{SIMATIC_IPC_IPC427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E},
-	{SIMATIC_IPC_IPC477E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E},
-	{SIMATIC_IPC_IPCBX_39A, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
-	{SIMATIC_IPC_IPCPX_39A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G},
-	{SIMATIC_IPC_IPCBX_21A, SIMATIC_IPC_DEVICE_BX_21A, SIMATIC_IPC_DEVICE_NONE},
+	{SIMATIC_IPC_IPC127E,
+		SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_127E},
+	{SIMATIC_IPC_IPC227D,
+		SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE},
+	{SIMATIC_IPC_IPC227E,
+		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E},
+	{SIMATIC_IPC_IPC227G,
+		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
+	{SIMATIC_IPC_IPC277E,
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E},
+	{SIMATIC_IPC_IPC427D,
+		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE},
+	{SIMATIC_IPC_IPC427E,
+		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
+	{SIMATIC_IPC_IPC477E,
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
+	{SIMATIC_IPC_IPCBX_39A,
+		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_BX_39A},
+	{SIMATIC_IPC_IPCPX_39A,
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_BX_39A},
+	{SIMATIC_IPC_IPCBX_21A,
+		SIMATIC_IPC_DEVICE_BX_21A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_21A},
 };
 
 static int register_platform_devices(u32 station_id)
 {
 	u8 ledmode = SIMATIC_IPC_DEVICE_NONE;
 	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
-	char *pdevname = KBUILD_MODNAME "_leds";
+	u8 battmode = SIMATIC_IPC_DEVICE_NONE;
+	char *pdevname;
 	int i;
 
-	platform_data.devmode = SIMATIC_IPC_DEVICE_NONE;
-
 	for (i = 0; i < ARRAY_SIZE(device_modes); i++) {
 		if (device_modes[i].station_id == station_id) {
 			ledmode = device_modes[i].led_mode;
 			wdtmode = device_modes[i].wdt_mode;
+			battmode = device_modes[i].batt_mode;
 			break;
 		}
 	}
 
+	if (battmode != SIMATIC_IPC_DEVICE_NONE) {
+		pdevname = KBUILD_MODNAME "_batt";
+		if (battmode == SIMATIC_IPC_DEVICE_127E)
+			pdevname = KBUILD_MODNAME "_batt_apollolake";
+		if (battmode == SIMATIC_IPC_DEVICE_BX_21A)
+			pdevname = KBUILD_MODNAME "_batt_elkhartlake";
+		if (battmode == SIMATIC_IPC_DEVICE_227G || battmode == SIMATIC_IPC_DEVICE_BX_39A)
+			pdevname = KBUILD_MODNAME "_batt_f7188x";
+		platform_data.devmode = battmode;
+		ipc_batt_platform_device =
+			platform_device_register_data(NULL, pdevname,
+				PLATFORM_DEVID_NONE, &platform_data,
+				sizeof(struct simatic_ipc_platform));
+		if (IS_ERR(ipc_batt_platform_device))
+			return PTR_ERR(ipc_batt_platform_device);
+
+		pr_debug("device=%s created\n",
+			 ipc_batt_platform_device->name);
+	}
+
 	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
+		pdevname = KBUILD_MODNAME "_leds";
 		if (ledmode == SIMATIC_IPC_DEVICE_127E)
 			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
 		if (ledmode == SIMATIC_IPC_DEVICE_227G)
@@ -144,6 +178,9 @@ static void __exit simatic_ipc_exit_module(void)
 
 	platform_device_unregister(ipc_wdt_platform_device);
 	ipc_wdt_platform_device = NULL;
+
+	platform_device_unregister(ipc_batt_platform_device);
+	ipc_batt_platform_device = NULL;
 }
 
 module_init(simatic_ipc_init_module);
diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h b/include/linux/platform_data/x86/simatic-ipc-base.h
index 00bf18ecb160..1ba47dd6939e 100644
--- a/include/linux/platform_data/x86/simatic-ipc-base.h
+++ b/include/linux/platform_data/x86/simatic-ipc-base.h
@@ -21,6 +21,7 @@
 #define SIMATIC_IPC_DEVICE_227E 4
 #define SIMATIC_IPC_DEVICE_227G 5
 #define SIMATIC_IPC_DEVICE_BX_21A 6
+#define SIMATIC_IPC_DEVICE_BX_39A 7
 
 struct simatic_ipc_platform {
 	u8	devmode;
-- 
2.39.3

