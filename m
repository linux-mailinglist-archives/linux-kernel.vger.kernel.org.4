Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1C3645F0F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiLGQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLGQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:36:23 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F6B5CD06;
        Wed,  7 Dec 2022 08:36:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddzBpo0t/CjIn2V+7C1/QCofl3YFNaRZbl/FblAlRHQQuNaVqAcIQRKN1uNXWYq1ph6XlHRPFcrggQPw4OXhuvWDKUHS6gyCoRqV6C6tsC6953AtNyBErswGU9QbqMdVB/V+BQ/Mo8CPblO5DDut8fHjrzJNX1NQ+6LJXMVGsi7pEbRX9hGMDmTg/v78rZRlZncCIcGsRvpqmy1aWJGZAGG3Dtnd4mxptifuX/KHGPSsSBXPimB7q5LB1d1V38CfZcTqI7lwJ4sBqxEpG7EpwF4TpLM1IFpK9nODIYuMsLefDmK8s6qN1oEMV6Uqq64l6ii3V+4ubLExXQsVSybdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUHFZYF9nE2ggMKlYf2oDrh8EH0xIrYmnuJkQXknBf4=;
 b=GaMnulLBnSBV8l221uuXuYZgDq9VAG2T4ZWzG0eh9Ko5Ra31FmBadhtH+YEY/IZAUF3zAkeCjmQjVbYN6FKq/tYOQuQ/F+ovPJ3lsAARmOx8Y+JBRySeuXMhZQPn5O9sj9IBHGDzHvELxcEEeNScvfLd4IKHtvWRjXL1mHzT6OZLxMHPGBii7oBiaPUkNN8SZz9SysUNpVAuj60kC2VjEEOm6HDsiff/GblKUIWilRA8Bt46v1jzXKd+Vkxy5/QQSeNp3CtL+V6Nodyyfttq2NGxfgGOlbfv1GKY9el7TOFpMTvWOtpnwvD+W+Mshgai5mP42Ns0HTUSiIMSecKF6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 PSAPR06MB4278.apcprd06.prod.outlook.com (2603:1096:301:84::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 16:36:18 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::5e0f:1a7d:ea7a:8b81]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::5e0f:1a7d:ea7a:8b81%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 16:36:18 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: [RFC 1/3] mfd: Add support for UP board CPLD/FPGA
Date:   Thu,  8 Dec 2022 00:33:57 +0800
Message-Id: <20221207163359.26564-2-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207163359.26564-1-larry.lai@yunjingtech.com>
References: <20221207163359.26564-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To SG2PR06MB3742.apcprd06.prod.outlook.com
 (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|PSAPR06MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c034090-f865-4177-f236-08dad8712a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3lb5KSAPSR+2W4J8meBzAPORZiGhbtGGRTc/9JPDdmyd9Wd0Eo+Phn6apmJ0/3NBK7qiICrF7BmS4Cfv9pw+ugzijOLUjdfpTLHDtP1BEH2d2I+Tz0+z5OXe4U/UKK7HeAU/DtC+MLXkT61Ps/N2KpVgkJkKDBNz/A/5NB8g9T4T1QiIiFE4hhDjTvw7i6ihmNnqYKdwsP8OkOMXVeIy6UE2h1fjQJNY1GEqnz0Lml52zMW6NghSTWK1GXzhY3qi87maODwvGaobeX7Xcca4Gd/xJWYq76tcIaS2wrw/kbHCD2kAmgfzUi3bZVegWlwCWn77cUoW8DBzmoNFNP/qqCbWoVQnMcLfLqvdUOhSxFBB+QYdMQnyi3S1fLNoSvgFReXqyqi2X618h6kCJ0bSEq2bw6Tmgir/LqDtbF8dh5651WCncF0bZeO1p3fjnXcTgEyif07U6TaGSLZ6O68IVFmRadDZ/buz7ZEoN7cRWtPSLOPgBRD64NbZ/kgKIdcgYyYHrNvh5aFY7PVId3I2GaEvhtrMJZJzY0VeJzfg33eazz8SJHj6KexPwRHUpqKyuHSn/Yg14QvjgpkJApBOm0UgI6QiKU5TxWgIsUwQR1SZ9FdeNld897NgVKWWVJ+AUWMfh3GEdocZlmoboXLPJPiggPGxuXqgUkFppuXAhNqS6mXLAy7Ic5UKHcdJGe32qWqI/nrwUrfHgSPUpKTwHD7cbYI0C8mN6esS1TaJf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39830400003)(396003)(136003)(451199015)(38350700002)(38100700002)(2906002)(6506007)(54906003)(36756003)(2616005)(316002)(1076003)(86362001)(7416002)(5660300002)(52116002)(6512007)(66556008)(26005)(186003)(83380400001)(30864003)(8936002)(41300700001)(4326008)(478600001)(6486002)(8676002)(66946007)(66476007)(966005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j/BbguHbgnwMRj8pfh+w6ItNCmK03I7PFkNs3FZ4+0Mhu/LdwhfFAY4qv/zw?=
 =?us-ascii?Q?5M5vgWtEfv2ixaIlNADfrmyNT+b+X1kVj6ORkrDqgcN4lbCyJ1rrjuf6nlqN?=
 =?us-ascii?Q?KWha+fsbANjfl2vYkmF0EG4xfNAIQMk/5uNQs6DDkpcI7hrj1WMaSEeGSCyh?=
 =?us-ascii?Q?No4UlLjjpU+kmr12JlZ8o7rVSKDesSB025tWPMNeaGy2NJy5uj7l3TgV3OcG?=
 =?us-ascii?Q?kDqN/Qm7FZuoboD7aD+ZspfJFCekdcak6G54zgldeqs3SxjZtCOXfI9fa6BV?=
 =?us-ascii?Q?Fvd6csbX9UaVmRrobIpTOZ6XDRBPf7h+lp9N6kDCmT3gacj5avC1pEdnF4Ko?=
 =?us-ascii?Q?0c49mymo/VmJGYnbg01uRFcO4stiZsh9N40r4gSmNM1OYn0RE+VPASSWZ3BX?=
 =?us-ascii?Q?tn9q2qSLCjSXAFqUZ3VEX9NAkBz4PLZPiybw3XnYk1pHQE8bLIFZikTEYJx2?=
 =?us-ascii?Q?Wrn3qBwGfJv3UkvpC1q7Dr3/VTgKuRLiw3xDlTHhxjD941TMjNZqLi1oekhl?=
 =?us-ascii?Q?gcmO5piEl0N0LNFTdFprin8VnH5PdQJH8/3DW7ngbDRsqks827vQvacJrc1J?=
 =?us-ascii?Q?oxgMN+GNNZ4cKWrT0nZ0KkjAnEAiFMRgftOXUv2woqz//NlvkbT6lcPBrfQi?=
 =?us-ascii?Q?IkET0F89q3h8IarIQhS1pT3QuRh0qjsQ5/WqqM2gKkl012iVgMbLjg1xlPrg?=
 =?us-ascii?Q?W6E6NdrHSGEt/CCd17hf/eim3JI0C2h7WpMTBwrSqmnPwjMf6+gzM0yT9mcI?=
 =?us-ascii?Q?2rIMC41jUsJFJu4EUuUqxAjrd6KlrfipIa5gAYdEOUjM9cxxBXEE2jbiO2Bc?=
 =?us-ascii?Q?jBIGhTtK0Xh8opFwAvzvu6K3OoQAPZHKdJTOd3Zvd354ZkA2N52d1AKVK53u?=
 =?us-ascii?Q?ukhLtirpD8P9jA9SBUXHmaso0KE6Y/wkFunkht/G8twtvRSXdJWpHJAdRYS2?=
 =?us-ascii?Q?z1ruMk2oXRG9Ld5vWvSdb1fnCac7zst3TZf17TqfIbzPW4Q0M+Nd92cnc0xf?=
 =?us-ascii?Q?H/c6o+4iovjye+aZ02vu4ZjbfPwhVWZv/6R7mHEQ4SYVdDDVSAXv4iP5Hy0L?=
 =?us-ascii?Q?QDlcleqS5y0IZ4sns6Ju/Gw4DDblCxC6/iwZl2tPDwnhccsZ3UPuwj5En4wU?=
 =?us-ascii?Q?nQERKyjT3H3vvO4jnyLdi/I48OcI9KPXiEZXk5KShJ24TZDLW5qUDBwzqGTX?=
 =?us-ascii?Q?pudYN0Hkab24kpRaT2NTq+JsAA4mATmctZC2afS6eR7pdtmpcbJSxHhbnyIi?=
 =?us-ascii?Q?8hwpPosjr1c/eYMw8+k7G9sP3tahrjSoJHXLEueTboNNa70nwl9j6vII9wXo?=
 =?us-ascii?Q?vzmY8VqVTvtRHi2Uf5MlXypDigiS7Rw5T3OuxItSEvpHJF83rWC8GKwJ/6td?=
 =?us-ascii?Q?26CEXU8CRCWhbUAzQzZ+LGZtiS7//YUW/3maLiS7eJLjZUKET2BJs3GZdSH4?=
 =?us-ascii?Q?31xJyLuJyMoq0bkQci6SEnv4o9kvaCqIpHnDgn3MkxpjQwfI/xfn8DfrICvL?=
 =?us-ascii?Q?VI5dQZ8t7W8eDtTMEhgzBzx2i9vAqC6rHVogCpFn3JyLJiI3BdJTUM3TFjUz?=
 =?us-ascii?Q?NwlEelavIDmKWLaA4HAuRaKVUH3WqRpiB4cmvls5SsenEolErZnEQP0oXL7S?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c034090-f865-4177-f236-08dad8712a21
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 16:36:17.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TUcq6ZNDOqJ5OfkALqz3h3qfdYmhUFhEmIoh20jWt+3sqpBJQPLsdqmb4VoqSJ9VJ5OWj9DGsKoOAXJ+ROJsC1mfaMONsMqAhe3DTefFPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4278
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
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
 drivers/mfd/Kconfig              |  12 +
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/upboard-fpga.c       | 669 +++++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h |  58 +++
 4 files changed, 740 insertions(+)
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
index 000000000000..123c17b5593e
--- /dev/null
+++ b/drivers/mfd/upboard-fpga.c
@@ -0,0 +1,669 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel AAEON UP Board series platform core driver
+ * and FPGA configuration support
+ *
+ * Copyright (c) 2017, Emutex Ltd. All rights reserved.
+ * Copyright (c) 2022, YunJingTech Ltd.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct upboard_fpga_data {
+	const struct regmap_config *regmapconf;
+	const struct mfd_cell *cells;
+	size_t ncells;
+};
+
+#define AAEON_MANUFACTURER_ID		0x01
+#define SUPPORTED_FW_MAJOR		0x0
+#define MENUFACTURER_ID_MASK		0xFF
+
+#define FIRMWARE_ID_BUILD_OFFSET	12
+#define FIRMWARE_ID_MAJOR_OFFSET	8
+#define FIRMWARE_ID_MINOR_OFFSET	4
+#define FIRMWARE_ID_PATCH_OFFSET	0
+#define FIRMWARE_ID_MASK		0xF
+
+#define UPFPGA_QUIRK_UNINITIALISED	BIT(0)
+#define UPFPGA_QUIRK_HRV1_IS_PROTO2	BIT(1)
+#define UPFPGA_QUIRK_GPIO_LED		BIT(2)
+
+/* Apollo Lake GPIO pin number mapping to FPGA LED */
+#define APL_GPIO_218			507
+
+/* For UP Board Series FPGA register read/write protocols 		      */
+/* EMUTEX specs: 						              */
+/* D0   D1  D2  D3  D4  D5  D6  D7  D8  D9 .... D22  D23                      */
+/* [RW][        address           ][	    DATA        ]                     */
+
+/* Read Sequence:                                                             */
+/*      ___   ____________________________________________________   _________*/
+/* clr:    \_/ <--low-pulse does start the write-readback         \_/<--start */
+/*	          sequence with partital reset of internal 	  new sequence*/
+/*	          registers but the CONF-REG. 	  		              */
+/*        ____________________________________________________________________*/
+/* rst: _/       _   _   _        _   _   _   __       __   __   _            */
+/* stb: STB#1->_/1\_/2\_/3\_...._/7\_/8\_/9\_/10\_..../23\_/24\_/<-STB#25 edge*/
+/*						                   is needed  */
+/*	  						           to ACK     */
+/*             (D0 - D7 stb rising latch)                                     */
+/* data_in:     D0  D1  D2  .... D6  D7  don't ........ care(DC)              */
+/* data_out:    don't ...........care(DC)  D8   D9 ....  D22  D23   	      */
+/*					  (D8 - D23 stb falling latch) 	      */
+/* flag_Read:				  _________...._________              */
+/*      __DC_   ____________...._________/                      \_            */
+/* counter:								      */
+/*    [00]DC[00][01][02] ............[08][9][10]............[24][00]	      */
+/* CONF-REG:					                              */
+/*    [00] [				CONF-REG               ]              */
+/* wreg:   							              */
+/*    [00]DC[00][  wreg=SHFT(wreg)  ][ADR][DATA][wreg=SHFT(wreg]	      */
+/* wreg2:		  						      */
+/*    					  [	   (COPY)=ADDR ]	      */
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
+		gpiod_set_value(fpga->datain_gpio, (reg >> i) & 0x1);
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
+/* Write Sequence:                                                   	      */
+/*      ___   ____________________________________________________   _________*/
+/* clr:    \_/ <--low-pulse does start the write-readback         \_/<--start */
+/*	          sequence with partital reset of internal 	  new sequence*/
+/*	          registers but the CONF-REG. 	  			      */
+/*        ____________________________________________________________________*/
+/* rst: _/       _   _   _        _   _   _   __       __   __   _            */
+/* stb: STB#1->_/1\_/2\_/3\_...._/7\_/8\_/9\_/10\_..../23\_/24\_/<-STB#25 edge*/
+/*						                   is needed  */
+/*								   to ACK     */
+/*             (D0 - D23 stb rising latch)                                    */
+/* data_in:     D0  D1  D2  .... D6  D7  D8  D9 ....  D22  D23                */
+/* data_out:    don't ................................care (DC)               */
+/* flag_Read:			 					      */
+/*      __DC_   ____________....__________________________________            */
+/* counter:								      */
+/*    [00]DC[00][01][02] ............[08][9][10]............[24][00]          */
+/* wreg:								      */
+/*    [00]DC[00][wreg=SHFT(wreg)&dat_in ][SHFT(wreg)&dat_in][DAT]             */
+/* wreg2:							              */
+/*    					 [     (COPY)=ADDR     ]	      */
+/* CONF-REG:								      */
+/*    [00] [	     CONF-REG = OLD VALUE		       ][CONF-REG=DAT]*/
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
+		gpiod_set_value(fpga->datain_gpio, (reg >> i) & 0x1);
+		gpiod_set_value(fpga->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 0);
+
+	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(fpga->datain_gpio, (val >> i) & 0x1);
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
+	.regmapconf = &upboard_up_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+static const struct mfd_cell upboard_pinctrl_cells[] = {
+	{ .name = "upboard-pinctrl" },
+};
+
+static const struct upboard_fpga_data upboard_pinctrl_data = {
+	.regmapconf = &upboard_up_regmap_config,
+	.cells = upboard_pinctrl_cells,
+	.ncells = ARRAY_SIZE(upboard_pinctrl_cells),
+};
+
+/* UP^2 board */
+
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
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[0],
+		       sizeof(*upboard_up2_led_data), 1),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[0],
+		       sizeof(*upboard_up2_led_data), 2),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[0],
+		       sizeof(*upboard_up2_led_data), 3),
+};
+
+static const struct upboard_fpga_data upboard_up2_fpga_data = {
+	.regmapconf = &upboard_up2_regmap_config,
+	.cells = upboard_up2_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up2_mfd_cells),
+};
+
+/* UP-CRST02 carrier board for UP Core */
+
+/* same MAX10 config as UP2, but same LED cells as UP1 */
+static const struct upboard_fpga_data upboard_upcore_crst02_fpga_data = {
+	.regmapconf = &upboard_up2_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+static struct gpio_led upboard_gpio_leds[] = {
+	{
+		.name = "upboard:blue:",
+		.gpio = APL_GPIO_218,
+		.default_state = LEDS_GPIO_DEFSTATE_KEEP,
+	},
+};
+
+static struct gpio_led_platform_data upboard_gpio_led_platform_data = {
+	.num_leds = ARRAY_SIZE(upboard_gpio_leds),
+	.leds = upboard_gpio_leds,
+};
+
+static const struct mfd_cell upboard_gpio_led_cells[] = {
+	MFD_CELL_BASIC("leds-gpio", NULL, &upboard_gpio_led_platform_data,
+		       sizeof(upboard_gpio_led_platform_data), 0)
+};
+
+static int __init upboard_fpga_gpio_init(struct upboard_fpga *fpga)
+{
+	enum gpiod_flags flags;
+
+	flags = fpga->uninitialised ? GPIOD_OUT_LOW : GPIOD_ASIS;
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
+	 * Reset gpio defaults HIGH, get gpio and set to LOW, then set back to
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
+ * MFD upboard-fpga is acpi driver and can recognize the AANT ID from different
+ * kind of upboards. We get the led gpio initialized information from this
+ * then add led-upboard driver.
+ */
+static void upboard_led_gpio_init(struct upboard_fpga *fpga)
+{
+	struct gpio_led blue_led, yellow_led, green_led, red_led;
+	struct gpio_desc *desc;
+	int blue_gpio = -1, yellow_gpio = -1, green_gpio = -1, red_gpio = -1;
+	int leds = 0;
+	static struct gpio_led upboard_gpio_leds[8];
+	static struct gpio_led_platform_data upboard_gpio_led_platform_data;
+	static const struct mfd_cell upboard_gpio_led_cells[] = {
+		MFD_CELL_BASIC("leds-gpio", NULL,
+			       &upboard_gpio_led_platform_data,
+			       sizeof(upboard_gpio_led_platform_data), 0)
+	};
+
+	desc = devm_gpiod_get(fpga->dev, "blue", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		blue_gpio = desc_to_gpio(desc);
+		leds++;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+	desc = devm_gpiod_get(fpga->dev, "yellow", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		yellow_gpio = desc_to_gpio(desc);
+		leds++;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+	desc = devm_gpiod_get(fpga->dev, "green", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		green_gpio = desc_to_gpio(desc);
+		leds++;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+	desc = devm_gpiod_get(fpga->dev, "red", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		red_gpio = desc_to_gpio(desc);
+		leds++;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+
+	/* no leds */
+	if (leds == 0)
+		return;
+
+	leds = 0;
+	if (blue_gpio > -1) {
+		blue_led.name = "upboard:blue:";
+		blue_led.gpio = blue_gpio;
+		blue_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = blue_led;
+	}
+	if (yellow_gpio > -1) {
+		yellow_led.name = "upboard:yellow:";
+		yellow_led.gpio = yellow_gpio;
+		yellow_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = yellow_led;
+	}
+	if (green_gpio > -1) {
+		green_led.name = "upboard:green:";
+		green_led.gpio = green_gpio;
+		green_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = green_led;
+	}
+	if (red_gpio > -1) {
+		red_led.name = "upboard:red:";
+		red_led.gpio = red_gpio;
+		red_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		upboard_gpio_leds[leds++] = red_led;
+	}
+
+	upboard_gpio_led_platform_data.num_leds = leds;
+	upboard_gpio_led_platform_data.leds = upboard_gpio_leds;
+/*
+ *	Refer https://www.kernel.org/doc/htmldocs/writing_musb_glue_layer/device-platform-data.html,
+ *	the id field could be set to -1 (equivalent to PLATFORM_DEVID_NONE),
+ *  -2 (equivalent to PLATFORM_DEVID_AUTO) or start with 0 for the first
+ *	device of this kind if we want a specific id number.
+ */
+	if (devm_mfd_add_devices(fpga->dev, 0,
+				 upboard_gpio_led_cells,
+				 ARRAY_SIZE(upboard_gpio_led_cells),
+				 NULL, 0, NULL)) {
+		dev_info(fpga->dev, "Failed to add GPIO leds");
+	}
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
+static const struct dmi_system_id upboard_dmi_table[] __initconst = {
+	{
+		.matches = { /* UP */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-CHT01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.4"),
+		},
+		.driver_data = (void *)UPFPGA_QUIRK_UNINITIALISED,
+	},
+	{
+		.matches = { /* UP2 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.3"),
+		},
+		.driver_data = (void *)(UPFPGA_QUIRK_UNINITIALISED |
+			UPFPGA_QUIRK_HRV1_IS_PROTO2),
+	},
+	{
+		.matches = { /* UP2 Pro*/
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-APL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V1.0"),
+		},
+		.driver_data = (void *)UPFPGA_QUIRK_HRV1_IS_PROTO2,
+	},
+	{
+		.matches = { /* UP2 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.4"),
+		},
+		.driver_data = (void *)UPFPGA_QUIRK_HRV1_IS_PROTO2,
+	},
+	{
+		.matches = { /* UP APL03 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL03"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V1.0"),
+		},
+		.driver_data = (void *)(UPFPGA_QUIRK_HRV1_IS_PROTO2 |
+			UPFPGA_QUIRK_GPIO_LED),
+	},
+	{
+		.matches = { /* UP Xtreme */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-WHL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.1"),
+		},
+	},
+	{
+		.matches = { /* UP Xtreme i11 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPX-TGL01"),
+		},
+	},
+	{
+		.matches = { /* UP Xtreme i12 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPX-ADLP01"),
+		},
+	},
+	{
+		.matches = { /* UP Squared 6000*/
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-EHL01"),
+		},
+	},
+	{
+		.matches = { /* UPS 6000 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPS-EHL01"),
+		},
+	},
+	{ }
+};
+
+static int __init upboard_fpga_probe(struct platform_device *pdev)
+{
+	struct upboard_fpga *fpga;
+	const struct acpi_device_id *id;
+	const struct upboard_fpga_data *fpga_data;
+	const struct dmi_system_id *system_id;
+	unsigned long long hrv;
+	unsigned long quirks = 0;
+	int ret;
+
+	id = acpi_match_device(upboard_fpga_acpi_match, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	/* get fpga/EC protocol hardware version */
+	acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev), "_HRV", NULL, &hrv);
+
+	system_id = dmi_first_match(upboard_dmi_table);
+	if (system_id)
+		quirks = (unsigned long)system_id->driver_data;
+
+	if (hrv == UPFPGA_PROTOCOL_V1_HRV &&
+	    (quirks & UPFPGA_QUIRK_HRV1_IS_PROTO2))
+		hrv = UPFPGA_PROTOCOL_V2_HRV;
+
+	fpga_data = (const struct upboard_fpga_data *) id->driver_data;
+
+	fpga = devm_kzalloc(&pdev->dev, sizeof(*fpga), GFP_KERNEL);
+	if (!fpga)
+		return -ENOMEM;
+
+	if (quirks & UPFPGA_QUIRK_UNINITIALISED) {
+		dev_info(&pdev->dev, "FPGA not initialised by this BIOS");
+		fpga->uninitialised = true;
+	}
+
+	dev_set_drvdata(&pdev->dev, fpga);
+	fpga->dev = &pdev->dev;
+	fpga->regmap = devm_regmap_init(&pdev->dev, NULL,
+					fpga, fpga_data->regmapconf);
+	fpga->regmapconf = fpga_data->regmapconf;
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
+		dev_info(&pdev->dev,
+			"failed to initialize FPGA common GPIOs: %d", ret);
+	} else {
+		upboard_fpga_show_firmware_info(fpga);
+	}
+
+	/* gpio leds initialize */
+	upboard_led_gpio_init(fpga);
+
+	if (quirks & UPFPGA_QUIRK_GPIO_LED) {
+		ret =  devm_mfd_add_devices(&pdev->dev, 0,
+					    upboard_gpio_led_cells,
+					    ARRAY_SIZE(upboard_gpio_led_cells),
+					    NULL, 0, NULL);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add GPIO leds");
+			return ret;
+		}
+	}
+	return devm_mfd_add_devices(&pdev->dev, 0,
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
+MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
+MODULE_DESCRIPTION("UP Board FPGA driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/upboard-fpga.h b/include/linux/mfd/upboard-fpga.h
new file mode 100644
index 000000000000..c8ca807528be
--- /dev/null
+++ b/include/linux/mfd/upboard-fpga.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Intel AAEON UP Board series platform core driver
+ * and FPGA configuration support
+ *
+ * Copyright (c) 2017, Emutex Ltd. All rights reserved.
+ * Copyright (c) 2022, YunJingTech Ltd.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#ifndef __LINUX_MFD_UPBOARD_FPGA_H
+#define __LINUX_MFD_UPBOARD_FPGA_H
+
+/* fpga/EC protocol hardware version */
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
+	const struct regmap_config	*regmapconf;
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
+
+#endif /*  __LINUX_MFD_UPBOARD_FPGA_H */
-- 
2.17.1

