Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E1C6EE4B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjDYP0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjDYP0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:26:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105CDD317;
        Tue, 25 Apr 2023 08:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E15AqRVcGGMZmMxCmmXvNOfkgz69qTSZN6TTClBqmL03xw6CuPBGehPLyYyNJfuEPsq/OCMs8wDpTdRnzTk04rByBZFh2qDGf3VOalN3gZvjvPXJo9zZ6iWsNryDUZVwdrQMlcTSzGZwIayjXVM5d4L5TTol7QYFlvGhdLDoSatvg6QDk7oAkTkrH96Uju6WsREKW4WrOZ7wg1cLosTT2WTjpOCQgXJsDnpaYlI6CACkUgcqfvgkmgCp3DlR/VR6WnLlK2RhGV9xKhQj5tQ6OWDd16bJSVjNAy3jdeCT2ptLibt/0Cnca8Xp/aZS1zoSygPfGPxxLrEIE2BUe/kI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvB3+hhR9xT/iN0PXkq+44lBZKT8Hctq9+6OMrT1yhA=;
 b=ipv+pzGPU23+qges3RGuyBqspMIrZuSYHY/GS8dpyMOSFUTI5AX7ddciCS4d6PO7iglWr/iT5NWP9gn39TkcY8gHvG0TB/D5Hx8L32VdEdUIGPMn7ywYDUZ8sWT77K+jBDqeZYev2Enu6GQCrVwkleTQ1G2Zwbmz0e9NnzcWjvy5DRXuD9LAiO2Re5NMrDP/nbsvujviUoyDQghTwjfKMxEwLsdSjBymeQe2U/AJzdFW3WT9fc1Oy1NZDUbor8QHg3EXHvDl1UxqKZkxsgXpPwO71xXkBQ7ATASSv7uc0KyxUqNHktKHv2LfgQa7toGnC2EC6s7DcW3uYTjMaazYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 SG2PR06MB5154.apcprd06.prod.outlook.com (2603:1096:4:1cd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.29; Tue, 25 Apr 2023 15:26:11 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::71f2:cae4:d8b8:8ea4]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::71f2:cae4:d8b8:8ea4%3]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 15:26:11 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, michael.wang@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: [RFC RESEND 1/3] mfd: Add support for UP board CPLD/FPGA
Date:   Tue, 25 Apr 2023 23:21:33 +0800
Message-Id: <20230425152135.30745-2-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230425152135.30745-1-larry.lai@yunjingtech.com>
References: <20230425152135.30745-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0342.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::8) To SG2PR06MB3742.apcprd06.prod.outlook.com
 (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|SG2PR06MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 7006c034-836c-47dd-084e-08db45a1669a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQ5L6kLLJLyRh2ktRwgk4p9D+n+J/ruJM+FgaShc28NShTvd+k2pgnbS5QQdaU7ukcJd1e+I02nJVsmNrCPhjNW91+bVZAsZHmTdDDme4SUW+l0TLL3rtPjVeTo/7rXZuBzdNVeI9PLFSiiiqLs+EEm9LtagTtit6CjqwQxFUJSycL64TZ8LRgu2L8qyIMqAoUbaF3Bx0unMp5YFTBRs8xx9wN7VGI5wFrQtn0CXtsnyKpx7mQE3IQ09Sye5IGxhiHXcOpA5E99vp/aPq+EMY4ofXVV3J6TKskkRnMPDnv2GE6ipt406wKUieKQ6akOH01qN6wVKCVTrzDb01YOKcjizyXdttU+w5Mi+eDY6I1sbOOEFEoK1A9nUp8DnZaGWCknHUxV9d87T14ZABJLALifDtAseOnPu8/B061XUaJk3J0WAL0Dg472560Yet93/HxA5n3Za4L8pdJnoNbePFnyrMiWcX5cuWMOaP5TeFCqaIWUQQ/xlBXMXr4T60eW3Lsll9rkjnmz4lnvS3C5oiBsccoqlUaTwDxBw4dW7ukIZIx8iVrhwqk4rB/WW8eFL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39830400003)(396003)(451199021)(2616005)(7416002)(83380400001)(30864003)(2906002)(5660300002)(38350700002)(8676002)(186003)(1076003)(26005)(6506007)(6512007)(8936002)(38100700002)(41300700001)(66946007)(86362001)(6486002)(36756003)(52116002)(6666004)(478600001)(54906003)(4326008)(66556008)(66476007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8hBF4SugzvEntscHtAG7dQpgr8o0KGbV2OGgvLXw+kMCNDyXu7gFoRUGcT9e?=
 =?us-ascii?Q?B4pBKwogM+82r2jUJgxY+2GA4vxuLGcB0GmUPzAYtIwQFFg54el2ZepkCyEE?=
 =?us-ascii?Q?bQxm6eSGgWC9crMcxAm4NPawG8QVUvHHeryT1nXclFj5x+p/bsvydX1WAYF8?=
 =?us-ascii?Q?ByyZ+aYP6PhmpWUrpe865Sj5Z9/jcwpKob6BJaO8rnrazgseylJDHh2f5Eim?=
 =?us-ascii?Q?R06ix9MaI7NRjD+mV8dnohphwqSQ3HNdag/LMl4lv6GqD6/L8T2tCmTaUAKa?=
 =?us-ascii?Q?0a/rRioHKq4odP+y9w5T0zWhAe4JzLmxThSlyh8uFjuA4quI4XeTyYL2ZzPy?=
 =?us-ascii?Q?uBj3I2kZUgUdqtGb3bxn6td+Q3Ad1M7TEA0tyXJHyumbZeO/Vp49kQ97vDKP?=
 =?us-ascii?Q?WHQUCJYXaCDjgqo5IF9VFbHtV/VK//Os4dGec8G5Bt2UgRITGD87NmuET5xx?=
 =?us-ascii?Q?Au5Gk97TCrkBU+glYYGGeYtb3K212d9JyDy3e+Z9GBuOgr2A/eplwfzfuA5D?=
 =?us-ascii?Q?IdU1qpXIbikuvFucV8aMT2KxfNYbrhjr7SHl9loa3iIHonjelwF3ViJrV1LO?=
 =?us-ascii?Q?lgQU+cWtlFJ0jcEFyj/s8GEmr38yDgjwgWjvdgCNuVAVpnYrDXcJnd+cDzmH?=
 =?us-ascii?Q?jcImCzAy1cfpBgmu/67gDM1Mn/Jog/Doa56QCckWhseEvW2gzYLYFhSPjJSS?=
 =?us-ascii?Q?ip/kAl0Xf5ovbfcZWi4zMEA53OHVxJLQhLOTl0FxTOBrA2GQLA64c1xOHMlv?=
 =?us-ascii?Q?EL9UyL9e2HkSZUhdf0RNOEjBiFc1TCEd+gRuTMdoTcZrdhdsxfWqH8cj2++9?=
 =?us-ascii?Q?C8Jd8MA+y1ISn8KnkVW7o1k6Eg/VSnQFqvAxgtaM9UVsFEK1x1s1gEvWP31o?=
 =?us-ascii?Q?hDY5PGeN6T/qfs9h3A2CunuF9omy8Fi1FYIupMHVEK5MMvVPY+Co4VwT6OkZ?=
 =?us-ascii?Q?pDBdeKYm+m8NLmM5v3WvrFwLOQX9IDh5ZKaN393D5YVVoTm2FE/BJUlMua/R?=
 =?us-ascii?Q?35Zt5DSGc/h+Vhr5lIwtevlfqUnq+1YQvRRtpxXTt9Cbd80FfSuG4hmVtVGu?=
 =?us-ascii?Q?fFSeSJglZ7ZFcx5vVwQ0WaNQ+fH3IceUfKWR/p3lXgxWKKSNelHrdj+yCJVh?=
 =?us-ascii?Q?cW6JTbbn0e2ecS66Eyg9icbMZzSFUhDWjcR025Z7VOSRW4hHxmBbM0FSeC3E?=
 =?us-ascii?Q?Nu6Gr9gj1/yuSzeCkmJVOl3+CNI8Wyz/a7tNfdcsq8XD6rq7T0AEp2zQo7TW?=
 =?us-ascii?Q?+FJHc97vVm2dt6VQ9f/3K/pkFJixmSzktg9MA2iD3MFgJWE9ZebNMCFLSZWp?=
 =?us-ascii?Q?MQm1eGszI7VUsZfzLozEYbM145mbNVZu/zIGQWdd81z8bXUj85rI6QTfwY1M?=
 =?us-ascii?Q?taVZGvSqrGMt3O3eAjefu+LT9ZYUkvsz+z/leXPuUSM9ta9UatohRzz5ZVG7?=
 =?us-ascii?Q?4s0Q8k0GUItGvwV0Hu3gOv9pgP3vzoigJXxfYdoxexDWye8HopcLPkL3vCT3?=
 =?us-ascii?Q?Di1FNmQsBroTBmMTtXrajWd87xE/FEPHCqybqPw32iWtlx6/CSV5yXEmffB4?=
 =?us-ascii?Q?a+toVDrKV0yYc6cDD4YF3jwC22z4BnAnxzFmhvz/2YvJlfyZr4OyFh92VpV1?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7006c034-836c-47dd-084e-08db45a1669a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 15:26:11.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIQXqLSNFJH4vwQJgoNc6bWUzgiuRqzcz7NWhqKut4LPyblFejuphknmgYmjHpCs2zyHITgtBxlZEfkHWPNp4XsV6vo7qaALLbU9kFUYhOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5154
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP Squared board <http://www.upboard.com> implements certain
features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.

This mfd driver implements the line protocol to read and write registers
from the FPGA through regmap. The register address map is also included.

The UP Boards provide a few I/O pin headers (for both GPIO and
functions), including a 40-pin Raspberry Pi compatible header.

This patch implements support for the FPGA-based pin controller that
manages direction and enable state for those header pins.

Partial support UP boards:
* UP core + CREX
* UP core + CRST02

Signed-off-by: Javier Arteaga <javier@emutex.com>
[merge various fixes]
Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
Reviewed-by: Lee Jones <lee@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
RFC 2022/11/23 -> RFC 2023/04/25
(1) Refer 2022/12/08 Andy Shevchenko review, cleaned up coding style
and addressed review comments.
PATCH V3 -> RFC 2022/11/23:
(1) Refer 2022/11/16 Lee Jones review, cleaned up coding style and
addressed review comments.
(2) Description on the UP Boards FPGA register read/write protocols
PATCH V2 -> V3:
(1) fixed kernel test robot compiler warning
PATCH V1 -> V2:
(1) Synchronizing upboard github to rc2
(2) Refer 2022/10/31 Lee Jones review, fixed some of the issues.
---
---
 drivers/mfd/Kconfig              |  12 +
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/upboard-fpga.c       | 527 +++++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h |  61 ++++
 4 files changed, 601 insertions(+)
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 include/linux/mfd/upboard-fpga.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index abb58ab1a1a4..1041e937fc7a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2104,6 +2104,18 @@ config MFD_QCOM_PM8008
 	  under it in the device tree. Additional drivers must be enabled in
 	  order to use the functionality of the device.
 
+config MFD_INTEL_UPBOARD_FPGA
+	tristate "Support for the Intel platform foundation kit UP board FPGA"
+	select MFD_CORE
+	depends on X86 && ACPI
+	help
+	  Select this option to enable the Intel AAEON UP and UP^2 on-board FPGA.
+	  This is core driver for the UP board that implements certain (pin
+	  control, onboard LEDs or CEC) through an on-board FPGA.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called upboard-fpga.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..8374a05f6f43 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -250,6 +250,7 @@ obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
 obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
+obj-$(CONFIG_MFD_INTEL_UPBOARD_FPGA)	+= upboard-fpga.o
 
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
diff --git a/drivers/mfd/upboard-fpga.c b/drivers/mfd/upboard-fpga.c
new file mode 100644
index 000000000000..85fd0f858781
--- /dev/null
+++ b/drivers/mfd/upboard-fpga.c
@@ -0,0 +1,527 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board multi function device driver for control CPLD/FPGA to
+ * provide more GPIO driving power also provide CPLD LEDs and pin mux function
+ * recognize HID AANT0F00 ~ AAANT0F04 in ACPI name space
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/bits.h>
+#include <linux/err.h>
+
+struct upboard_fpga_data {
+	const struct regmap_config *cpld_config;
+	const struct mfd_cell *cells;
+	size_t ncells;
+};
+
+#define AAEON_MANUFACTURER_ID		0x01
+#define SUPPORTED_FW_MAJOR		0x0
+#define MENUFACTURER_ID_MASK		GENMASK(7, 0)
+
+#define FIRMWARE_ID_BUILD_OFFSET	(12)
+#define FIRMWARE_ID_MAJOR_OFFSET	(8)
+#define FIRMWARE_ID_MINOR_OFFSET	(4)
+#define FIRMWARE_ID_PATCH_OFFSET	(0)
+#define FIRMWARE_ID_MASK		GENMASK(3, 0)
+
+/*
+ * For UP Board Series FPGA register read/write protocols
+ * EMUTEX specs:
+ * D0   D1  D2  D3  D4  D5  D6  D7  D8  D9 .... D22  D23
+ * [RW][        address           ][        DATA        ]
+ *
+ * Read Sequence:
+ *      ___   ____________________________________________________   _________
+ * clr:    \_/ <--low-pulse does start the write-readback         \_/<--start
+ *              sequence with partital reset of internal          new sequence
+ *              registers but the CONF-REG.
+ *        ____________________________________________________________________
+ * rst: _/       _   _   _        _   _   _   __       __   __   _
+ * stb: STB#1->_/1\_/2\_/3\_...._/7\_/8\_/9\_/10\_..../23\_/24\_/<-STB#25 edge
+ *                                                                   is needed
+ *                                                                   to ACK
+ *             (D0 - D7 stb rising latch)
+ * data_in:     D0  D1  D2  .... D6  D7  don't ........ care(DC)
+ * data_out:    don't ...........care(DC)  D8   D9 ....  D22  D23
+ *                                   (D8 - D23 stb falling latch)
+ * flag_Read:                             _________...._________
+ *      __DC_   ____________...._________/                      \_
+ * counter:
+ *    [00]DC[00][01][02] ............[08][9][10]............[24][00]
+ * CONF-REG:
+ *    [00] [                     CONF-REG                       ]
+ * wreg:
+ *    [00]DC[00][  wreg=SHFT(wreg)  ][ADR][DATA][wreg=SHFT(wreg)]
+ * wreg2:
+ *                                        [    (COPY)=ADDR      ]
+ */
+static int upboard_fpga_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	gpiod_set_value(fpga->clear_gpio, 0);
+	gpiod_set_value(fpga->clear_gpio, 1);
+
+	reg |= UPFPGA_READ_FLAG;
+
+	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		gpiod_set_value(fpga->datain_gpio, !!(reg & BIT(i)));
+		gpiod_set_value(fpga->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 0);
+	*val = 0;
+
+	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 1);
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		*val |= gpiod_get_value(fpga->dataout_gpio) << i;
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 1);
+
+	return 0;
+}
+
+/*
+ * Write Sequence:
+ *      ___   ____________________________________________________   _________
+ * clr:    \_/ <--low-pulse does start the write-readback         \_/<--start
+ *              sequence with partital reset of internal          new sequence
+ *              registers but the CONF-REG.
+ *        ____________________________________________________________________
+ * rst: _/       _   _   _        _   _   _   __       __   __   _
+ * stb: STB#1->_/1\_/2\_/3\_...._/7\_/8\_/9\_/10\_..../23\_/24\_/<-STB#25 edge
+ *                                                                   is needed
+ *                                                                   to ACK
+ *             (D0 - D23 stb rising latch)
+ * data_in:     D0  D1  D2  .... D6  D7  D8  D9 ....  D22  D23
+ * data_out:    don't ................................care (DC)
+ * flag_Read:
+ *      __DC_   ____________....__________________________________
+ * counter:
+ *    [00]DC[00][01][02] ............[08][9][10]............[24][00]
+ * wreg:
+ *    [00]DC[00][wreg=SHFT(wreg)&dat_in ][SHFT(wreg)&dat_in][DAT]
+ * wreg2:
+ *                                   [     (COPY)=ADDR          ]
+ * CONF-REG:
+ *    [00] [                 CONF-REG = OLD VALUE               ][CONF-REG=DAT]
+ */
+static int upboard_fpga_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	gpiod_set_value(fpga->clear_gpio, 0);
+	gpiod_set_value(fpga->clear_gpio, 1);
+
+	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		gpiod_set_value(fpga->datain_gpio, !!(reg & BIT(i)));
+		gpiod_set_value(fpga->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 0);
+
+	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(fpga->datain_gpio, !!(val & BIT(i)));
+		gpiod_set_value(fpga->strobe_gpio, 1);
+		gpiod_set_value(fpga->strobe_gpio, 0);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 1);
+
+	return 0;
+}
+
+static const struct regmap_range upboard_up_readable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
+};
+
+static const struct regmap_range upboard_up_writable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
+};
+
+static const struct regmap_access_table upboard_up_readable_table = {
+	.yes_ranges = upboard_up_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up_readable_ranges),
+};
+
+static const struct regmap_access_table upboard_up_writable_table = {
+	.yes_ranges = upboard_up_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up_writable_ranges),
+};
+
+static const struct regmap_config upboard_up_regmap_config = {
+	.reg_bits = UPFPGA_ADDRESS_SIZE,
+	.val_bits = UPFPGA_REGISTER_SIZE,
+	.max_register = UPFPGA_REG_MAX,
+	.reg_read = upboard_fpga_read,
+	.reg_write = upboard_fpga_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_RBTREE,
+	.rd_table = &upboard_up_readable_table,
+	.wr_table = &upboard_up_writable_table,
+};
+
+static struct upboard_led_data upboard_up_led_data[] = {
+	{ .bit = 0, .colour = "yellow" },
+	{ .bit = 1, .colour = "green" },
+	{ .bit = 2, .colour = "red" },
+};
+
+static const struct mfd_cell upboard_up_mfd_cells[] = {
+	{ .name = "upboard-pinctrl" },
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[0],
+		       sizeof(*upboard_up_led_data), 0),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[1],
+		       sizeof(*upboard_up_led_data), 1),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[2],
+		       sizeof(*upboard_up_led_data), 2),
+};
+
+/* UP Squared 6000 EHL board */
+
+static const struct upboard_fpga_data upboard_up_fpga_data = {
+	.cpld_config = &upboard_up_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+static const struct mfd_cell upboard_pinctrl_cells[] = {
+	{ .name = "upboard-pinctrl" },
+};
+
+static const struct upboard_fpga_data upboard_pinctrl_data = {
+	.cpld_config = &upboard_up_regmap_config,
+	.cells = upboard_pinctrl_cells,
+	.ncells = ARRAY_SIZE(upboard_pinctrl_cells),
+};
+
+/* UP^2 board */
+static const struct regmap_range upboard_up2_readable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
+	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
+};
+
+static const struct regmap_range upboard_up2_writable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
+	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
+};
+
+static const struct regmap_access_table upboard_up2_readable_table = {
+	.yes_ranges = upboard_up2_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_readable_ranges),
+};
+
+static const struct regmap_access_table upboard_up2_writable_table = {
+	.yes_ranges = upboard_up2_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_writable_ranges),
+};
+
+static const struct regmap_config upboard_up2_regmap_config = {
+	.reg_bits = UPFPGA_ADDRESS_SIZE,
+	.val_bits = UPFPGA_REGISTER_SIZE,
+	.max_register = UPFPGA_REG_MAX,
+	.reg_read = upboard_fpga_read,
+	.reg_write = upboard_fpga_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_NONE,
+	.rd_table = &upboard_up2_readable_table,
+	.wr_table = &upboard_up2_writable_table,
+};
+
+static struct upboard_led_data upboard_up2_led_data[] = {
+	{ .bit = 0, .colour = "blue" },
+	{ .bit = 1, .colour = "yellow" },
+	{ .bit = 2, .colour = "green" },
+	{ .bit = 3, .colour = "red" },
+};
+
+static const struct mfd_cell upboard_up2_mfd_cells[] = {
+	{ .name = "upboard-pinctrl" },
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[0],
+		       sizeof(*upboard_up2_led_data), 0),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[1],
+		       sizeof(*upboard_up2_led_data), 1),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[2],
+		       sizeof(*upboard_up2_led_data), 2),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[3],
+		       sizeof(*upboard_up2_led_data), 3),
+};
+
+static const struct upboard_fpga_data upboard_up2_fpga_data = {
+	.cpld_config = &upboard_up2_regmap_config,
+	.cells = upboard_up2_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up2_mfd_cells),
+};
+
+/* UP-CRST02 carrier board for UP Core */
+
+/* same MAX10 config as UP2, but same LED cells as UP1 */
+static const struct upboard_fpga_data upboard_upcore_crst02_fpga_data = {
+	.cpld_config = &upboard_up2_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+static int __init upboard_fpga_gpio_init(struct upboard_fpga *fpga)
+{
+	enum gpiod_flags flags = fpga->uninitialised ? GPIOD_OUT_LOW : GPIOD_ASIS;
+
+	fpga->enable_gpio = devm_gpiod_get(fpga->dev, "enable", flags);
+	if (IS_ERR(fpga->enable_gpio))
+		return PTR_ERR(fpga->enable_gpio);
+
+	fpga->clear_gpio = devm_gpiod_get(fpga->dev, "clear", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->clear_gpio))
+		return PTR_ERR(fpga->clear_gpio);
+
+	fpga->strobe_gpio = devm_gpiod_get(fpga->dev, "strobe", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->strobe_gpio))
+		return PTR_ERR(fpga->strobe_gpio);
+
+	fpga->datain_gpio = devm_gpiod_get(fpga->dev, "datain", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->datain_gpio))
+		return PTR_ERR(fpga->datain_gpio);
+
+	fpga->dataout_gpio = devm_gpiod_get(fpga->dev, "dataout", GPIOD_IN);
+	if (IS_ERR(fpga->dataout_gpio))
+		return PTR_ERR(fpga->dataout_gpio);
+
+	/*
+	 * The SoC pinctrl driver may not support reserving the GPIO line for
+	 * FPGA reset without causing an undesired reset pulse. This will clear
+	 * any settings on the FPGA, so only do it if we must.
+	 * Reset GPIO defaults HIGH, get GPIO and set to LOW, then set back to
+	 * HIGH as a pulse.
+	 */
+	if (fpga->uninitialised) {
+		fpga->reset_gpio = devm_gpiod_get(fpga->dev, "reset", GPIOD_OUT_LOW);
+		if (IS_ERR(fpga->reset_gpio))
+			return PTR_ERR(fpga->reset_gpio);
+
+		gpiod_set_value(fpga->reset_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->enable_gpio, 1);
+	fpga->uninitialised = false;
+
+	return 0;
+}
+
+/*
+ * This function is for debugging with user for showing firmware information.
+ */
+static int __init upboard_fpga_show_firmware_info(struct upboard_fpga *fpga)
+{
+	unsigned int platform_id, manufacturer_id;
+	unsigned int firmware_id, build, major, minor, patch;
+	int ret;
+
+	if (!fpga)
+		return -ENOMEM;
+
+	ret = regmap_read(fpga->regmap, UPFPGA_REG_PLATFORM_ID, &platform_id);
+	if (ret)
+		return ret;
+
+	manufacturer_id = platform_id & MENUFACTURER_ID_MASK;
+	if (manufacturer_id != AAEON_MANUFACTURER_ID) {
+		dev_err(fpga->dev,
+			"driver not compatible with custom FPGA FW from manufacturer id 0x%02x. Exiting",
+			manufacturer_id);
+
+		return -ENODEV;
+	}
+
+	ret = regmap_read(fpga->regmap, UPFPGA_REG_FIRMWARE_ID, &firmware_id);
+	if (ret)
+		return ret;
+
+	build = (firmware_id >> FIRMWARE_ID_BUILD_OFFSET) & FIRMWARE_ID_MASK;
+	major = (firmware_id >> FIRMWARE_ID_MAJOR_OFFSET) & FIRMWARE_ID_MASK;
+	minor = (firmware_id >> FIRMWARE_ID_MINOR_OFFSET) & FIRMWARE_ID_MASK;
+	patch = (firmware_id >> FIRMWARE_ID_PATCH_OFFSET) & FIRMWARE_ID_MASK;
+
+	if (major != SUPPORTED_FW_MAJOR) {
+		dev_err(fpga->dev, "unsupported FPGA FW v%u.%u.%u build 0x%02x",
+			major, minor, patch, build);
+
+		return -ENODEV;
+	}
+
+	dev_info(fpga->dev, "compatible FPGA FW v%u.%u.%u build 0x%02x",
+		 major, minor, patch, build);
+
+	return 0;
+}
+
+/*
+ * MFD upboard-fpga is ACPI driver and can recognize the AANT ID from different
+ * kind of upboards. We get the LED GPIO initialized information from this
+ * then add led-upboard driver.
+ */
+int upboard_led_gpio_register(struct upboard_fpga *fpga)
+{
+	struct gpio_led blue_led, yellow_led, green_led, red_led;
+	struct gpio_desc *desc;
+	static struct gpio_led upboard_gpio_leds[4];
+	int leds = 0;
+	static struct gpio_led_platform_data upboard_gpio_led_platform_data;
+	static const struct mfd_cell upboard_gpio_led_cells[] = {
+		MFD_CELL_BASIC("leds-gpio", NULL,
+			       &upboard_gpio_led_platform_data,
+			       sizeof(upboard_gpio_led_platform_data), 0)
+	};
+	int ret;
+
+	desc = devm_gpiod_get(fpga->dev, "blue", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		blue_led.name = "upboard:blue:";
+		blue_led.gpio = desc_to_gpio(desc);
+		blue_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = blue_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+	desc = devm_gpiod_get(fpga->dev, "yellow", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		yellow_led.name = "upboard:yellow:";
+		yellow_led.gpio = desc_to_gpio(desc);
+		yellow_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = yellow_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+	desc = devm_gpiod_get(fpga->dev, "green", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		green_led.name = "upboard:green:";
+		green_led.gpio = desc_to_gpio(desc);
+		green_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = green_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+	desc = devm_gpiod_get(fpga->dev, "red", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		red_led.name = "upboard:red:";
+		red_led.gpio = desc_to_gpio(desc);
+		red_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = red_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+
+	/* no LEDs */
+	if (leds == 0)
+		return 0;
+
+	upboard_gpio_led_platform_data.num_leds = leds;
+	upboard_gpio_led_platform_data.leds = upboard_gpio_leds;
+
+	ret = devm_mfd_add_devices(fpga->dev, PLATFORM_DEVID_AUTO,
+				   upboard_gpio_led_cells,
+				   ARRAY_SIZE(upboard_gpio_led_cells),
+				   NULL, 0, NULL);
+	if (ret) {
+		dev_err(fpga->dev, "Failed to add GPIO LEDs", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct acpi_device_id upboard_fpga_acpi_match[] = {
+	{ "AANT0000", (kernel_ulong_t)&upboard_pinctrl_data },
+	{ "AANT0F00", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ "AANT0F01", (kernel_ulong_t)&upboard_up2_fpga_data },
+	{ "AANT0F02", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ "AANT0F03", (kernel_ulong_t)&upboard_upcore_crst02_fpga_data },
+	{ "AANT0F04", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, upboard_fpga_acpi_match);
+
+static int __init upboard_fpga_probe(struct platform_device *pdev)
+{
+	struct upboard_fpga *fpga;
+	const struct acpi_device_id *id;
+	const struct upboard_fpga_data *fpga_data;
+	int ret;
+	struct device *dev = &pdev->dev;
+
+	id = acpi_match_device(upboard_fpga_acpi_match, dev);
+	if (!id)
+		return -ENODEV;
+
+	fpga_data = (const struct upboard_fpga_data *) id->driver_data;
+
+	fpga = devm_kzalloc(dev, sizeof(*fpga), GFP_KERNEL);
+	if (!fpga)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, fpga);
+	fpga->regmap = devm_regmap_init(dev, NULL, fpga, fpga_data->cpld_config);
+	fpga->cpld_config = fpga_data->cpld_config;
+
+	if (IS_ERR(fpga->regmap))
+		return PTR_ERR(fpga->regmap);
+
+	ret = upboard_fpga_gpio_init(fpga);
+	if (ret) {
+		/*
+		 * This is for compatiable with some upboards w/o FPGA firmware,
+		 * so just showing debug info and do not return directly.
+		 */
+		dev_warn(dev, "Failed to initialize FPGA common GPIOs: %d", ret);
+	} else {
+		upboard_fpga_show_firmware_info(fpga);
+	}
+
+	/* register GPIO LEDs */
+	ret = upboard_led_gpio_register(fpga);
+	if (ret) {
+		/*
+		 * This is for compatiable with some upboards w/o LEDs.
+		 */
+		dev_warn(dev, "Failed to register LEDs: %d", ret);
+	}
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
+				    fpga_data->cells,
+				    fpga_data->ncells,
+				    NULL, 0, NULL);
+}
+
+static struct platform_driver upboard_fpga_driver = {
+	.driver = {
+		.name = "upboard-fpga",
+		.acpi_match_table = upboard_fpga_acpi_match,
+	},
+};
+module_platform_driver_probe(upboard_fpga_driver, upboard_fpga_probe);
+
+MODULE_AUTHOR("Gary Wang <garywang@aaeon.com.tw>");
+MODULE_DESCRIPTION("UP Board CPLD/FPGA driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/upboard-fpga.h b/include/linux/mfd/upboard-fpga.h
new file mode 100644
index 000000000000..1fa073e5c53c
--- /dev/null
+++ b/include/linux/mfd/upboard-fpga.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UP Board CPLD/FPGA driver
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
+ *
+ */
+
+#ifndef __LINUX_MFD_UPBOARD_FPGA_H
+#define __LINUX_MFD_UPBOARD_FPGA_H
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+/* CPLD/FPGA protocol version */
+#define UPFPGA_PROTOCOL_V1_HRV		1
+#define UPFPGA_PROTOCOL_V2_HRV		2
+
+#define UPFPGA_ADDRESS_SIZE		7
+#define UPFPGA_REGISTER_SIZE		16
+
+#define UPFPGA_READ_FLAG		(1 << UPFPGA_ADDRESS_SIZE)
+
+enum upboard_fpgareg {
+	UPFPGA_REG_PLATFORM_ID		= 0x10,
+	UPFPGA_REG_FIRMWARE_ID		= 0x11,
+	UPFPGA_REG_FUNC_EN0		= 0x20,
+	UPFPGA_REG_FUNC_EN1		= 0x21,
+	UPFPGA_REG_GPIO_EN0		= 0x30,
+	UPFPGA_REG_GPIO_EN1		= 0x31,
+	UPFPGA_REG_GPIO_EN2		= 0x32,
+	UPFPGA_REG_GPIO_DIR0		= 0x40,
+	UPFPGA_REG_GPIO_DIR1		= 0x41,
+	UPFPGA_REG_GPIO_DIR2		= 0x42,
+	UPFPGA_REG_MAX,
+};
+
+struct upboard_fpga {
+	struct device			*dev;
+	struct regmap			*regmap;
+	struct regmap_config		*cpld_config;
+	struct gpio_desc		*enable_gpio;
+	struct gpio_desc		*reset_gpio;
+	struct gpio_desc		*clear_gpio;
+	struct gpio_desc		*strobe_gpio;
+	struct gpio_desc		*datain_gpio;
+	struct gpio_desc		*dataout_gpio;
+	bool				uninitialised;
+};
+
+struct upboard_led_data {
+	unsigned int			bit;
+	const char			*colour;
+};
+
+bool regmap_check_writeable(struct upboard_fpga *fpga, unsigned int reg);
+int upboard_led_gpio_register(struct upboard_fpga *fpga);
+
+#endif /*  __LINUX_MFD_UPBOARD_FPGA_H */
-- 
2.17.1

