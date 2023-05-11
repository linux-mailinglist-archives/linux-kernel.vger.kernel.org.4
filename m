Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65B6FEF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbjEKJuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbjEKJuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:50:06 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CE96A79;
        Thu, 11 May 2023 02:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5kfsQECw430tJ6jbTMK/BhJeI11WLWhPIbl5Vwg6+DU8nCGiXAHj0LbMt3e46Frdz97isiYjd6MGvunHMATpb9xa4bh8KJoVk219+1O/b/7lacWXcD1Z0hJuv/3BGBLcuIW9TTmEpj4UMy8ZoT6X7gwzwruSY9zvoSMNxjCgZUE+p2Kvqb/oP5cn72ZI6ywylGh08NStxkmkax0M7vV+uMcv8UoTVIzmJL6+/XsGQH6vcrTRzK6Dj7QAk0tdxmmmssGoA47GP0kj+9qFS+6fh14zFQWbWKwyTOZHss5mp+R8Zjr4QOFcGOKug0k8BNe2ZMl8V/I6wcb4DeAP1ontQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6Lab6wJZrhwm4e0CXGgUo1qCb/jHx1YcR/X6ZfQ4Rs=;
 b=izEBmJzs5YxVxENdvPa4hUfukG39IsaczpTs6Zdt7UXaxjlbtCBJ4PqDH4g6oqu2EaJQnZAep6BbGo3vELvdQH+7YqRIcBncnhASbu7RCJ0ql093ObtRVHbNwh53dznHQolMCK7Iiev77pz+sImNauKr4GPc/x2ubUO/UPdDWrc7vfumR9q2VOt2w+UzQj/JRhJeDEekw2lHeCyQZh1oaGrDZpjP8lk6UWp7vYPeyolBFVH9bSkJUHdAH9mC+vupP9ozPCrMZQrqcU+GvVf57axlcHNTQdOSJcRvFMUlNQYLNnpXyhwHCis8PVo7wJZJVlgq4uj2a43WcTuIOP6X2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 KL1PR0601MB3876.apcprd06.prod.outlook.com (2603:1096:820:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Thu, 11 May
 2023 09:49:59 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::e5e4:d643:2a1b:fea0]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::e5e4:d643:2a1b:fea0%3]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 09:49:59 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, michael.wang@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>
Subject: [PATCH V4 1/3] mfd: Add support for UP board CPLD/FPGA
Date:   Thu, 11 May 2023 17:49:32 +0800
Message-Id: <20230511094934.4941-2-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511094934.4941-1-larry.lai@yunjingtech.com>
References: <20230511094934.4941-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|KL1PR0601MB3876:EE_
X-MS-Office365-Filtering-Correlation-Id: e88dec1a-f665-4ae6-52b8-08db5205158b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vfO1Q6e14GF4QA6DcAJSvlVC/e+xbrPntwUtPiEcFEtoLlYKBALezZiVNA3eKoVrWXxiQGxWQnAUFUuY5QkNjATBatNoVGT2z5ihLQSbo3IMvkoEOyTJLlEcpAoVgMAtTgpb+tJuhFb8PWcufrRU5b7OTekWsG8MB5V9dU43jHKui5ZmahPx3jS9znpq2+Tbfh6c1Ogi7q0auLS54At/RpUsjaOCpR1Lj5sH8/3JX4U9hoCPttOBQwVVBIzlxYTWrHgODgd3AyVtXdxSEZ4c3E+HKPLh26u0h0mEPPiW1ZrGyNRiiP4N90l1llWxplb1DJCpBCf+b/NLxFSePoYlV8xtenyS6nlaD7fxLqQevkSKtWxpn0crJ8qJ9j4qEAGn5H+qGIJCP0gjKnhYE150T++vlacXcwLLXZMtrpyqZEzcGb7HH14TKkoWZgFti6xJHdPe6qXmow7BrEysrkjRN2Xo4E/4sSExkNoNv/pwmXk/39X/4VL3mj1YXqKqGV5BTQJLcnmFmhaEKNPF5x0ebgrnGCSk4F8rTHOXgo+LgaewOTho6AKlPtFHLwYXejKS+heCP44Gg+pq/NxlvVomH+DzYj//0vEW8arVs+aRfk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39830400003)(136003)(451199021)(8676002)(2616005)(2906002)(316002)(38100700002)(38350700002)(66946007)(30864003)(41300700001)(86362001)(8936002)(66476007)(4326008)(66556008)(5660300002)(186003)(478600001)(36756003)(6486002)(52116002)(6512007)(6666004)(1076003)(6506007)(26005)(107886003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HsTLG57Ie3T2jDIcrE5kJpVitp2b5kvdgPGqSwkWTZev5xQ6DujeTmsGfGJV?=
 =?us-ascii?Q?07oNGdK8QxsT/KWo1JjLtEfQbjIjH1zm1+Lnh1p+Bt0zPWQFc0myY8p0CTzy?=
 =?us-ascii?Q?r1HoOzwdmvdUFpAS87zzPIXmBYyR13UORFJ7zzJwpxNxvHMBczG4+bpRa7F7?=
 =?us-ascii?Q?CdROo2IXrzwGJXBBT7r+JtG39lctrPZneos8IWZEUcr81XBVEsTrmKCRTCJ8?=
 =?us-ascii?Q?WYlyQ2E2Bb2rGsEM7H3CGMmImUji9sMBViF77Zsd9Fih1bSwTh1zHPM9ksMO?=
 =?us-ascii?Q?k8vASOEuiQWSEYhueIy/ZgcQJDoVNpqIsizQzo0X/x6m+9mKUqROHEpG4MRy?=
 =?us-ascii?Q?Njf1nPijduwnQ3jX1P+mjDXmbKDkB14gEVfq2FTO3avZBex4jcLTjaT417zt?=
 =?us-ascii?Q?eqSWfr6FAC8bYciR/DwHJnxapy2TOTJSZqABX0cnQ9iNJrdmnjQhFDDnGnWQ?=
 =?us-ascii?Q?DBbhYymSxYh1q+CUyN7bTFFjEiWPOXrSTMi3sKgvOoe47BZjDDiPIWfayzXB?=
 =?us-ascii?Q?2Q2j4hjxVwLR5I2q6C+H13wvaIue2t/22fabuUm+u0k4142rEGjYfMrOK91B?=
 =?us-ascii?Q?ZzlLuqHQvvVVRwY02S/GeMpiOthiY39vYTvhggccwtcG2JBdgNqm925QBtkq?=
 =?us-ascii?Q?WgIFvJRMmryjmlPyz0gyXl0UABdxlOGd6ItkJ/idrlHHt7Iy8LRQI/170+UH?=
 =?us-ascii?Q?zElNtVx2NAgjW/zREOzHVEHEuduFJvBLeGnvNOMUHMJ4u6K1wIaa11VtEsST?=
 =?us-ascii?Q?06QKJLtX9J8g+Mk4nLBc1FDEIUUczG13a2A9//5MojYZixSAd6/PAHMwFQgd?=
 =?us-ascii?Q?oF0124b11V6g5DgB2j13FNSp3LadF3XhDa/ackGO4UVtv5+1tiYruO8HIDfD?=
 =?us-ascii?Q?5MqUNc8VPx6u71gyS7VRYwwA7gLL0ZSV/v1Pl2kQSyNG3uzTZAKsTKDBXUvE?=
 =?us-ascii?Q?E6FFjO/1+/FzoYaTr5IMKUotg8ZfXZoFa2lAYRbPJvVE9cIJRC5azSVubWVD?=
 =?us-ascii?Q?uN8Art3cp4sEe0LSlAeeJ4ubrfcc/LKK0P63oFQZw3ChYNfePX6PCNI5gpkJ?=
 =?us-ascii?Q?VlS4UdkHrehQnPgZMNUDcOlAdvZT7lC+44nfc4tnoUi211gKYgq4DV+0yfJ4?=
 =?us-ascii?Q?6I1RXgr2/OsaO4xM1OeoyrpqwZIJY0ZZqFH+tk8Lf7ccWkzxXBAj29eP0Zos?=
 =?us-ascii?Q?we1rfzNJgQ0m/jzO5m2BSK+YyDl9+wW8oA83qReWkMXKvG3esyMajoJmD71k?=
 =?us-ascii?Q?3O/c5ds8HeH6qRfrIA5yvxZ6c1+WupQx7sZgQ8oAxMuau2TebKdK/Z0iFAeb?=
 =?us-ascii?Q?kQ2F7vzBE/zq7tQ8uBYee300xBVRF8GkmJERKERyTVpBt+Z5R/5MQdg98Bf+?=
 =?us-ascii?Q?jcnQ7FQo8SBPp4Qb2lz0FIL7+Aep08wxgUmld+fU45HFcvsxaWK31e7bxJT0?=
 =?us-ascii?Q?7Kr2YfwFiVwOfTaXE/mfCXZ6CBFbL+BjkSymq2HUHRINDzZWV7ZfL5CeNQDM?=
 =?us-ascii?Q?UkP+eZgVN1s2FIHcwkHBViwDX+ERWpiidp1p74AD/MlwuaaTxM+duezpGmaL?=
 =?us-ascii?Q?jj82t5tx51G/EnKDS/7vCvp9vwrufDINQDcL6f2BUWxrV9+N9jeJxqSpXXQQ?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88dec1a-f665-4ae6-52b8-08db5205158b
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 09:49:59.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckQBS03MbvUiZ/9GEYp0oIvZua7jLKkAhtWVm8YdTkqHPWst8zyA4j3YJPkj+oor8L2GhNg6kuEtQlj4Hx/gGFgbLcoMog+6wxwtjUKhEj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3876
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
RFC 2023/04/25 -> PATCH V4
(1) Fixed kernel test robot compiler warning.
(2) Remove mistakes with wrong Reviewed-by tags.
RFC 2022/11/23 -> RFC 2023/04/25
(1) Refer 2022/12/08 Andy Shevchenko review, cleaned up coding style
and addressed review comments.
PATCH V3 -> RFC 2022/11/23:
(1) Refer 2022/11/16 Lee Jones review, cleaned up coding style and
addressed review comments.
(2) Description on the UP Boards FPGA register read/write protocols
PATCH V2 -> V3:
(1) fixed kernel test robot compiler warning.
PATCH V1 -> V2:
(1) Synchronizing upboard github to rc2
(2) Refer 2022/10/31 Lee Jones review, fixed some of the issues.
---
 drivers/mfd/Kconfig              |  12 +
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/upboard-fpga.c       | 526 +++++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h |  61 ++++
 4 files changed, 600 insertions(+)
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
index 000000000000..a9a231e6d431
--- /dev/null
+++ b/drivers/mfd/upboard-fpga.c
@@ -0,0 +1,526 @@
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
+		dev_err(fpga->dev, "Failed to add GPIO LEDs,%d", ret);
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
+	fpga->cpld_config = (struct regmap_config *)fpga_data->cpld_config;
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

