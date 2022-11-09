Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740D9622672
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiKIJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiKIJMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:12:40 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A101223BD5;
        Wed,  9 Nov 2022 01:11:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHPd0GiYdrVYcOnTGJcGIvTZP0TsNiMCSRmJBTNPv+w7lhN7TMxVZEk5PdESs6xnDz8Uzwa3zsDL6nih96K0CRbs+NnHmbqO7GSie7gcn+M3YI840qGJbD9Bkgez41qmiWPwjKKmIZKsPVNvQPpYJ2Dd4Y6MsVKz17Ck+9bV7XpE/1E1+m0+I9Mx4evwYm3Tv+GEUZzKcXK39ylmn2mcjxH3VqnpBymn6+IHfdb8A/35erU519YZEvQmNUFMmcIreV9v9L7ouL2AUICcMr+pBvwIYCGd+bcpt3cEsTn88DDFBzx/jpwMcaWmM8VjaXq0XiX0yEw5qcnBubtcvuVRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf4Kmr+RMT+p4uVKVHyZoTkTycjPeqI5IzzD1cJbtlc=;
 b=mA+wSBnMpqt/ck88WtSuogLcHJUs30em04PDJowsmCXOFYGO1SF657IZgLQHykVbERVqt96NyPiOuTChNNIKmBGi4xNhNSZ1fCrl4qTmJkDz2A19VpMMMSaCNlr98wd7bWdXokDOEQYDHCcNPRYhHOfKms4IFSpk1KHQQc+1hSPqr/7OvW4in33hDkTNESB/0KyXz/NxL+wG6ApKhjwjgY/sz1pFWWSs5FLPL+pvEoyriL+0v5N+htPWLiIOCyWZBBB9PW3VR0+WsjA5/vhXvrIHwXNorXyxRb/ZCK1n+Wd6npU/0aqpAiVx40ElsycbtudzOFUFfsBo6IijaMhx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 SEYPR06MB5964.apcprd06.prod.outlook.com (2603:1096:101:d9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 09:11:46 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5%5]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 09:11:46 +0000
From:   chengwei <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: [PATCH V3 1/3] mfd: Add support for UP board CPLD/FPGA
Date:   Wed,  9 Nov 2022 17:09:55 +0800
Message-Id: <20221109090957.13167-2-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109090957.13167-1-larry.lai@yunjingtech.com>
References: <20221109090957.13167-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::23) To SG2PR06MB3742.apcprd06.prod.outlook.com
 (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|SEYPR06MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 34240231-3568-47b7-71b8-08dac2326d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSoVpOFj8p7zimvOfWR9BDFAsMQyiZtcWwmw6MUGHpGo9JGeWvTZPOfBbpNfDUtJWnjuUNwPlaGvLlWrIjGkNbpxqIxtO+IEj8QoYuA9646wpUa8iggodBpJd9fDqqNEy2oHVBg8Tdi9uUcWVyN5kaFLGMMONUV7y5oB9A9rBhkm/V5bLDyKDAzScvl5inKWI9HMhojnAKdh/cyFgrqE5JTePigHX/RI+TrBSPvlUQPfAhcptMfqTYI0/bw8600DY1UnW/vsu4tANsqI4/TacN+nRg70+vzIzoLL09tvWKnuWBl+kbCQzJttWpfDxd4mDRwWP9f8XH7EMzrUHid5TWLK9fkfKNzL1+CGUZNtmtgyk6q+6/0QKkuKcTFOgHMdD3obywPvYdYo/Sb3Zk/GqxIIV0D6pNLLvKLg4rxKcFsXunoS9mfxEnAG1yJ25pPaz87pLi7nXgt4F5hfkbf9OiRplVwNqHxydRPG2RwIgqYZTR17u6s5yV5/53Upmauo12xhizKiuyBhrNPyO3orAjtaSwmf4f9J4WSbibzcObF4MQvvHNsvPs/kuDTQYVTABpc3bpRqTteBjZmtBNMYxrTlRWEJhtaTP8CRx6sccNKLU06mv97ZBaZA0DOp6NHz2U0xQTpxee7cEEafBpwrctLFBBFDi3idd9gvudTxWzUdXcOeee6FBBWn1uEzJTlylneAsCj1JY8oDSecO7z2+QRy3zYctfb8OV0zuYvi92+c/BYYIH9XCIykfyUK2IMUsHPNNioegzXBA4SfJJgZweZwfaBtZsJdq13ZOl7kg9gfF+u8mqKbdBtG1flBJoFi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(366004)(376002)(39830400003)(451199015)(41300700001)(7416002)(5660300002)(8936002)(6486002)(30864003)(2906002)(6506007)(26005)(1076003)(83380400001)(478600001)(52116002)(38350700002)(2616005)(6666004)(38100700002)(66476007)(66556008)(66946007)(4326008)(186003)(6512007)(316002)(54906003)(86362001)(8676002)(36756003)(43062005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7HGK24v4JIVaXQYFDJVsMNpzlZ8/1m8HDMD8kpQt3wunKbpcUaQjjJ80mk1K?=
 =?us-ascii?Q?/Jj+VeqCGqANj2gCgjn5oIOk/RECSDvfJtU6IS3YL0ueG1fPDxN2CrQ30yZr?=
 =?us-ascii?Q?WMgsm4tNaS5rUSuGtZsGpMl5ykPxTj3D4gcTILVKLf0f9lLj1Y6EY4BbNERv?=
 =?us-ascii?Q?Dz3NOTCMjb8ekWp21nyF64nBHpgr7GBHRtyNQcu827PGea3G21XpRAQd9Ulg?=
 =?us-ascii?Q?nXEGOCGMs6zMIy7IcN4/K6YuaMy++ayzvXPakqZKCisn/5oUZ+Z+/KQba2fQ?=
 =?us-ascii?Q?jJU+5MZ1PiCddlAFoHwGMUxYc30J4jSxBu4qgmNyNs7F6M9kVbrBvSw9d4nQ?=
 =?us-ascii?Q?a0NHAVr4He7MC5Ay5tm+mEMu3Ojy0lK7epsi/KYZcwStBKvB9feeKDuzyEft?=
 =?us-ascii?Q?dfbHEUc5+I/ezZ4o45EQPVVqKVB0/8V4EzGHRskq89/wW68IsKl1V/0t1ZN4?=
 =?us-ascii?Q?JJtA8bTMSetV4zgQtkakAmevyuCwPWqySb2T4qfeb60/F2/9ALsiTxY+no54?=
 =?us-ascii?Q?3aI2PmMDZx6dtVjGRO+F6AOs5mS0Sz5N2aajFguu7eukq0lYLlll0waGSU7k?=
 =?us-ascii?Q?p68fmmzq1k4/6KY7KQodAp9GxZRB1j0jwXS8Sos5MPYhsnAW6WEizw2j/hpN?=
 =?us-ascii?Q?VoP5VPMMmGeZ26u45VHX40J0TqXVPFRRYny06XIW3GMQgaE/6NKqGajq5zdr?=
 =?us-ascii?Q?2s4NgMcXYzyXzCWWAYaIj7dVdvPOITwypa+0FCdG2uSAFlb0HXm4vcDSnLxK?=
 =?us-ascii?Q?HuMicBLm85KZinW1BdzulNj/N/bTZlQxoV1RlTzh6qAXisna469OpVrsy72P?=
 =?us-ascii?Q?eu/erJkf21WnIdiQWR6s+Lb4ekbD/P26Lt4vdQpwPXfaSzF6dkXmK5oSHJ38?=
 =?us-ascii?Q?pTcy//7heOrb4WeNK7MtfJm4CdHro9HfZe9eL2WheMIrGPd22kroMi9Bnw58?=
 =?us-ascii?Q?0iJDV9EUz9OAAsS+F5P1Snsy7RBCXp0TD58fLcQdvkjXDP6SFCcZFOZA4Fuk?=
 =?us-ascii?Q?i/g5J2BJN37LIeIdHr053wJJJlTVy9JuKkv3rUm45x8t+gHnyYvt62cY++KI?=
 =?us-ascii?Q?1ztuScXi32sGG7l5MJm8g8oD8jlPq98SveM5hiJxPXXDwb0qb3ha3AylYe1o?=
 =?us-ascii?Q?qHRP6wCMrKn9FM1hsSKQLq2jLYoeRKBFEbB/1KexJuYCQNxfg7LLFc71zSbU?=
 =?us-ascii?Q?0fU1UdlUBvAnU3YsnpEli/QE9qiaVW6/hYcZKfVSYdXpDGjUnyX2t7YAFamm?=
 =?us-ascii?Q?YPtt9pFWv4g62qwFK9/RGKl9oewvaKWO3hGGsiAVzFze9rzZAPG6k1BnqdtX?=
 =?us-ascii?Q?SE20cP3Hm0ucpOIjuCC0DyjVKIQG4QT0lDhAYsbcFc6bNqkTV5XAroOr6pce?=
 =?us-ascii?Q?h6y56kksgSBMlNQHlY2ytnomG7IvNTBa8zhWTLg5jnoNqW+Muh+zrIuzMDda?=
 =?us-ascii?Q?B9qzV/R4xNz418war41HatubWe5xo/pxIilxIErdsijdNKssxGBmWIacr2ZN?=
 =?us-ascii?Q?fByH9EqsXB3A2t2MFrNwW/iTpCjizeuhNR0/pEJqN8GFLlZ7ZbnxMatq0jBW?=
 =?us-ascii?Q?E3BHSnJn8uuB7gABC90ZgMNDeu3h13TuAKrQHQPHcVVpSt+Z/kbdrTo4D3vp?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34240231-3568-47b7-71b8-08dac2326d23
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 09:11:46.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ch1N/pXQls3YI8iQ6L78L5je8cF7W4z0yr8PciNGfA5LT2nzeXVNGIV8g7TBVA28j92/SVjfZhUECUz9Vt3rzQddIjse8gKqK6dun8h3gdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5964
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
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

PATCH V3:
(1) fixed kernel test robot compiler warning

PATCH V2:
(1) Synchronizing upboard github to rc2
(2) Refer 2022/10/31 Lee Jones review, fixed some of the issues.

Signed-off-by: Javier Arteaga <javier@emutex.com>
[merge various fixes]
Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
Signed-off-by: chengwei <larry.lai@yunjingtech.com>
---
 drivers/mfd/Kconfig              |  12 +
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/upboard-fpga.c       | 620 +++++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h |  56 +++
 4 files changed, 689 insertions(+)
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 include/linux/mfd/upboard-fpga.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index abb58ab1a1a4..c1d72a70e5f2 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2104,6 +2104,18 @@ config MFD_QCOM_PM8008
 	  under it in the device tree. Additional drivers must be enabled in
 	  order to use the functionality of the device.
 
+config MFD_UPBOARD_FPGA
+	tristate "Support for the UP board FPGA"
+	select MFD_CORE
+	depends on X86 && ACPI
+	help
+	  Select this option to enable the Intel AAEON UP and UP^2 on-board FPGA.
+	  The UP board implements certain features (pin control, onboard LEDs or
+	  CEC) through an on-board FPGA.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called upboard-fpga.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..d9d10e3664f7 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -250,6 +250,7 @@ obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
 obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
+obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
 
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
diff --git a/drivers/mfd/upboard-fpga.c b/drivers/mfd/upboard-fpga.c
new file mode 100644
index 000000000000..89d0d36d2d17
--- /dev/null
+++ b/drivers/mfd/upboard-fpga.c
@@ -0,0 +1,620 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board main platform driver and FPGA configuration support
+ *
+ * Copyright (c) 2022, Emutex Ltd. All rights reserved.
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
+#define UPBOARD_LED_CELL(led_data, n)                       \
+	MFD_CELL_BASIC("upboard-led", NULL, &led_data[(n)], \
+		       sizeof(*(led_data)), (n))
+
+#define AAEON_MANUFACTURER_ID 0x01
+#define SUPPORTED_FW_MAJOR 0x0
+#define MENUFACTURER_ID_MASK 0xFF
+
+#define FIRMWARE_ID_BUILD_OFFSET 12
+#define FIRMWARE_ID_MAJOR_OFFSET 8
+#define FIRMWARE_ID_MINOR_OFFSET 4
+#define FIRMWARE_ID_PATCH_OFFSET 0
+#define FIRMWARE_ID_MASK 0xF
+
+#define UPFPGA_QUIRK_UNINITIALISED  BIT(0)
+#define UPFPGA_QUIRK_HRV1_IS_PROTO2 BIT(1)
+#define UPFPGA_QUIRK_GPIO_LED       BIT(2)
+
+#define UPBOARD_DEVID 0
+
+/* UP-CREX carrier board for UP Core */
+
+/* same MAXV config as UP1 (proto2 release) */
+#define upboard_upcore_crex_fpga_data upboard_up_fpga_data
+
+#define APL_GPIO_218	507
+
+/* UP board */
+
+static int upboard_fpga_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	if (IS_ERR(fpga->clear_gpio))	//for none fpga boards
+		return 0;
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
+static int upboard_fpga_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	if (IS_ERR(fpga->clear_gpio))	//for none fpga boards
+		return 0;
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
+	UPBOARD_LED_CELL(upboard_up_led_data, 0),
+	UPBOARD_LED_CELL(upboard_up_led_data, 1),
+	UPBOARD_LED_CELL(upboard_up_led_data, 2),
+};
+
+static const struct upboard_fpga_data upboard_up_fpga_data = {
+	.regmapconf = &upboard_up_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+//UP-EHL
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
+//	.cache_type = REGCACHE_NONE,
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
+	UPBOARD_LED_CELL(upboard_up2_led_data, 0),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 1),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 2),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 3),
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
+	 */
+	if (fpga->uninitialised) {
+		fpga->reset_gpio = devm_gpiod_get(fpga->dev, "reset",
+						  GPIOD_OUT_LOW);
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
+static int __init upboard_fpga_detect_firmware(struct upboard_fpga *fpga)
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
+		dev_dbg(fpga->dev, "unsupported FPGA FW v%u.%u.%u build 0x%02x",
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
+	if (leds == 0)	//no leds
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
+
+	if (devm_mfd_add_devices(fpga->dev, UPBOARD_DEVID,
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
+	{ "AANT0F02", (kernel_ulong_t)&upboard_upcore_crex_fpga_data },
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
+	acpi_handle handle;
+	acpi_status status;
+	unsigned long long hrv;
+	unsigned long quirks = 0;
+	int ret;
+
+	id = acpi_match_device(upboard_fpga_acpi_match, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	status = acpi_evaluate_integer(handle, "_HRV", NULL, &hrv);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&pdev->dev, "failed to get PCTL revision");
+		//return -ENODEV;
+	}
+
+	system_id = dmi_first_match(upboard_dmi_table);
+	if (system_id)
+		quirks = (unsigned long)system_id->driver_data;
+
+	if (hrv == UPFPGA_PROTOCOL_V1_HRV &&
+	    (quirks & UPFPGA_QUIRK_HRV1_IS_PROTO2))
+		hrv = UPFPGA_PROTOCOL_V2_HRV;
+
+	if (hrv != UPFPGA_PROTOCOL_V2_HRV) {
+		dev_info(&pdev->dev, "unsupported PCTL revision: %llu", hrv);
+		//return -ENODEV;
+	}
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
+		dev_err(&pdev->dev,
+			"failed to initialize FPGA common GPIOs: %d", ret);
+		//return ret;	//ignore fpga error
+	} else {
+		ret = upboard_fpga_detect_firmware(fpga);
+		//if (ret)
+		//	return ret;	//ignore fpga error
+	}
+
+	//gpio leds initialize
+	upboard_led_gpio_init(fpga);
+
+	if (quirks & UPFPGA_QUIRK_GPIO_LED) {
+		ret =  devm_mfd_add_devices(&pdev->dev, UPBOARD_DEVID,
+					    upboard_gpio_led_cells,
+					    ARRAY_SIZE(upboard_gpio_led_cells),
+					    NULL, 0, NULL);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add GPIO leds");
+			return ret;
+		}
+	}
+	return devm_mfd_add_devices(&pdev->dev, UPBOARD_DEVID,
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
index 000000000000..48273420b97d
--- /dev/null
+++ b/include/linux/mfd/upboard-fpga.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UP Board main platform driver and FPGA configuration support
+ *
+ * Copyright (c) 2022, Emutex Ltd. All rights reserved.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#ifndef __LINUX_MFD_UPBOARD_FPGA_H
+#define __LINUX_MFD_UPBOARD_FPGA_H
+
+//fpga/EC protocol version
+#define UPFPGA_PROTOCOL_V1_HRV 1
+#define UPFPGA_PROTOCOL_V2_HRV 2
+
+#define UPFPGA_ADDRESS_SIZE  7
+#define UPFPGA_REGISTER_SIZE 16
+
+#define UPFPGA_READ_FLAG     (1 << UPFPGA_ADDRESS_SIZE)
+
+enum upboard_fpgareg {
+	UPFPGA_REG_PLATFORM_ID   = 0x10,
+	UPFPGA_REG_FIRMWARE_ID   = 0x11,
+	UPFPGA_REG_FUNC_EN0      = 0x20,
+	UPFPGA_REG_FUNC_EN1      = 0x21,
+	UPFPGA_REG_GPIO_EN0      = 0x30,
+	UPFPGA_REG_GPIO_EN1      = 0x31,
+	UPFPGA_REG_GPIO_EN2      = 0x32,
+	UPFPGA_REG_GPIO_DIR0     = 0x40,
+	UPFPGA_REG_GPIO_DIR1     = 0x41,
+	UPFPGA_REG_GPIO_DIR2     = 0x42,
+	UPFPGA_REG_MAX,
+};
+
+struct upboard_fpga {
+	struct device *dev;
+	struct regmap *regmap;
+	const struct regmap_config *regmapconf;
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *clear_gpio;
+	struct gpio_desc *strobe_gpio;
+	struct gpio_desc *datain_gpio;
+	struct gpio_desc *dataout_gpio;
+	bool uninitialised;
+};
+
+struct upboard_led_data {
+	unsigned int bit;
+	const char *colour;
+};
+
+bool regmap_check_writeable(struct upboard_fpga *fpga, unsigned int reg);
+
+#endif /*  __LINUX_MFD_UPBOARD_FPGA_H */
-- 
2.17.1

