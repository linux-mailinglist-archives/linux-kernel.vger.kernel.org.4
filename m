Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53026ECA24
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjDXKVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjDXKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:41 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B82AB7;
        Mon, 24 Apr 2023 03:20:35 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id E54AE5ED86;
        Mon, 24 Apr 2023 12:35:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-t4H74iah;
        Mon, 24 Apr 2023 12:35:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328938;
        bh=PvL00vRm5IHlg8V2yLW2pdnjxI3j0EFhxWtpI3ZMOWE=;
        h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
        b=s4ONOeaLeO6lqLnoNwMzoFNiDkxUb1hz327oMBZYbtKXz0OBe1MTrU3C+CXBuGiLE
         0YRJp8SVSOHmho6yctm1I7wfaA/8WwnucAcvX3rcuOIqaWJkY+oCBAauNHGIu2pvgb
         JiWg/JRJK6O6PCRRqZsnXTDe6/uhJjWRiec1kS+o=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 04/43] pinctrl: add a Cirrus ep93xx SoC pin controller
Date:   Mon, 24 Apr 2023 15:34:20 +0300
Message-Id: <20230424123522.18302-5-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a pin control (only multiplexing) driver for ep93xx
SoC so we can fully convert ep93xx to device tree.

This driver is capable of muxing ep9301/ep9302/ep9307/ep9312/ep9315
variants, this is chosen based on "compatible" in device tree.

Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

Notes:
    - added ep9307 gpio groups
    
    Linus Walleij:
    - dropped pinconf
    - added tag

 drivers/pinctrl/Kconfig          |    7 +
 drivers/pinctrl/Makefile         |    1 +
 drivers/pinctrl/pinctrl-ep93xx.c | 1698 ++++++++++++++++++++++++++++++
 3 files changed, 1706 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-ep93xx.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index dcb53c4a9584..60c6e3ba706b 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -176,6 +176,13 @@ config PINCTRL_DIGICOLOR
 	select PINMUX
 	select GENERIC_PINCONF
 
+config PINCTRL_EP93XX
+	bool
+	depends on OF && (ARCH_EP93XX || COMPILE_TEST)
+	select PINMUX
+	select GENERIC_PINCONF
+	select MFD_SYSCON
+
 config PINCTRL_EQUILIBRIUM
 	tristate "Generic pinctrl and GPIO driver for Intel Lightning Mountain SoC"
 	depends on OF && HAS_IOMEM
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index d5939840bb2a..9d70c79eadbe 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_PINCTRL_DA850_PUPD) += pinctrl-da850-pupd.o
 obj-$(CONFIG_PINCTRL_DA9062)	+= pinctrl-da9062.o
 obj-$(CONFIG_PINCTRL_DIGICOLOR)	+= pinctrl-digicolor.o
 obj-$(CONFIG_PINCTRL_EQUILIBRIUM)   += pinctrl-equilibrium.o
+obj-$(CONFIG_PINCTRL_EP93XX)	+= pinctrl-ep93xx.o
 obj-$(CONFIG_PINCTRL_GEMINI)	+= pinctrl-gemini.o
 obj-$(CONFIG_PINCTRL_INGENIC)	+= pinctrl-ingenic.o
 obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
diff --git a/drivers/pinctrl/pinctrl-ep93xx.c b/drivers/pinctrl/pinctrl-ep93xx.c
new file mode 100644
index 000000000000..c16a3bc585a8
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-ep93xx.c
@@ -0,0 +1,1698 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the EP93xx pin controller
+ * based on linux/drivers/pinctrl/pinmux-gemini.c
+ *
+ * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
+ *
+ * This is a group-only pin controller.
+ */
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+#include <linux/soc/cirrus/ep93xx.h>
+#include <linux/seq_file.h>
+
+#include "pinctrl-utils.h"
+
+#define DRIVER_NAME "pinctrl-ep93xx"
+
+enum ep93xx_pinctrl_model {
+	EP93XX_9301_PINCTRL = 0,
+	EP93XX_9307_PINCTRL,
+	EP93XX_9312_PINCTRL
+};
+
+/**
+ * struct ep93xx_pmx - state holder for the ep93xx pin controller
+ * @dev: a pointer back to containing device
+ * @pctl: the offset to the controller in virtual memory
+ * @map: regmap to access registers
+ * @model: SoC model
+ */
+struct ep93xx_pmx {
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+	struct regmap *map;
+	enum ep93xx_pinctrl_model model;
+};
+
+/**
+ * struct ep93xx_pin_group - describes a ep93xx pin group
+ * @name: the name of this specific pin group
+ * @pins: an array of discrete physical pins used in this group, taken
+ *	from the driver-local pin enumeration space
+ * @num_pins: the number of pins in this group array, i.e. the number of
+ *	elements in .pins so we can iterate over that array
+ * @mask: bits to clear to enable this when doing pin muxing
+ * @value: bits to set to enable this when doing pin muxing
+ */
+struct ep93xx_pin_group {
+	const char *name;
+	const unsigned int *pins;
+	const unsigned int num_pins;
+	u32 mask;
+	u32 value;
+};
+
+#define EP93XX_SYSCON_DEVCFG		0x80
+
+/*
+ * There are several system configuration options selectable by the DeviceCfg and SysCfg
+ * registers. These registers provide the selection of several pin multiplexing options and also
+ * provide software access to the system reset configuration options. Please refer to the
+ * descriptions of the registers, “DeviceCfg” on page 5-25 and “SysCfg” on page 5-34, for a
+ * detailed explanation.
+ */
+#define EP93XX_SYSCON_DEVCFG_D1ONG	BIT(30) /* not used */
+#define EP93XX_SYSCON_DEVCFG_D0ONG	BIT(29) /* not used */
+#define EP93XX_SYSCON_DEVCFG_IONU2	BIT(28) /* not used */
+#define EP93XX_SYSCON_DEVCFG_GONK	BIT(27) /* done */
+#define EP93XX_SYSCON_DEVCFG_TONG	BIT(26) /* not used */
+#define EP93XX_SYSCON_DEVCFG_MONG	BIT(25) /* not used */
+#define EP93XX_SYSCON_DEVCFG_A2ONG	BIT(22) /* not used */
+#define EP93XX_SYSCON_DEVCFG_A1ONG	BIT(21) /* not used */
+#define EP93XX_SYSCON_DEVCFG_HONIDE	BIT(11) /* done */
+#define EP93XX_SYSCON_DEVCFG_GONIDE	BIT(10) /* done */
+#define EP93XX_SYSCON_DEVCFG_PONG	BIT(9) /* done */
+#define EP93XX_SYSCON_DEVCFG_EONIDE	BIT(8) /* done */
+#define EP93XX_SYSCON_DEVCFG_I2SONSSP	BIT(7) /* done */
+#define EP93XX_SYSCON_DEVCFG_I2SONAC97	BIT(6) /* done */
+#define EP93XX_SYSCON_DEVCFG_RASONP3	BIT(4) /* done */
+
+#define PADS_MASK		(GENMASK(30, 25) | BIT(22) | BIT(21) | GENMASK(11, 6) | BIT(4))
+#define PADS_MAXBIT		30
+
+/* Ordered by bit index */
+static const char * const ep93xx_padgroups[] = {
+	NULL, NULL, NULL, NULL,
+	"RasOnP3",
+	NULL,
+	"I2SonAC97",
+	"I2SonSSP",
+	"EonIDE",
+	"PonG",
+	"GonIDE",
+	"HonIDE",
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	"A1onG",
+	"A2onG",
+	NULL, NULL,
+	"MonG",
+	"TonG",
+	"GonK",
+	"IonU2",
+	"D0onG",
+	"D1onG",
+};
+
+/** ep9301, ep9302*/
+static const struct pinctrl_pin_desc ep9301_pins[] = {
+	PINCTRL_PIN(1, "CSn[7]"),
+	PINCTRL_PIN(2, "CSn[6]"),
+	PINCTRL_PIN(3, "CSn[3]"),
+	PINCTRL_PIN(4, "CSn[2]"),
+	PINCTRL_PIN(5, "CSn[1]"),
+	PINCTRL_PIN(6, "AD[25]"),
+	PINCTRL_PIN(7, "vdd_ring"),
+	PINCTRL_PIN(8, "gnd_ring"),
+	PINCTRL_PIN(9, "AD[24]"),
+	PINCTRL_PIN(10, "SDCLK"),
+	PINCTRL_PIN(11, "AD[23]"),
+	PINCTRL_PIN(12, "vdd_core"),
+	PINCTRL_PIN(13, "gnd_core"),
+	PINCTRL_PIN(14, "SDWEn"),
+	PINCTRL_PIN(15, "SDCSn[3]"),
+	PINCTRL_PIN(16, "SDCSn[2]"),
+	PINCTRL_PIN(17, "SDCSn[1]"),
+	PINCTRL_PIN(18, "SDCSn[0]"),
+	PINCTRL_PIN(19, "vdd_ring"),
+	PINCTRL_PIN(20, "gnd_ring"),
+	PINCTRL_PIN(21, "RASn"),
+	PINCTRL_PIN(22, "CASn"),
+	PINCTRL_PIN(23, "DQMn[1]"),
+	PINCTRL_PIN(24, "DQMn[0]"),
+	PINCTRL_PIN(25, "AD[22]"),
+	PINCTRL_PIN(26, "AD[21]"),
+	PINCTRL_PIN(27, "vdd_ring"),
+	PINCTRL_PIN(28, "gnd_ring"),
+	PINCTRL_PIN(29, "DA[15]"),
+	PINCTRL_PIN(30, "AD[7]"),
+	PINCTRL_PIN(31, "DA[14]"),
+	PINCTRL_PIN(32, "AD[6]"),
+	PINCTRL_PIN(33, "DA[13]"),
+	PINCTRL_PIN(34, "vdd_core"),
+	PINCTRL_PIN(35, "gnd_core"),
+	PINCTRL_PIN(36, "AD[5]"),
+	PINCTRL_PIN(37, "DA[12]"),
+	PINCTRL_PIN(38, "AD[4]"),
+	PINCTRL_PIN(39, "DA[11]"),
+	PINCTRL_PIN(40, "AD[3]"),
+	PINCTRL_PIN(41, "vdd_ring"),
+	PINCTRL_PIN(42, "gnd_ring"),
+	PINCTRL_PIN(43, "DA[10]"),
+	PINCTRL_PIN(44, "AD[2]"),
+	PINCTRL_PIN(45, "DA[9]"),
+	PINCTRL_PIN(46, "AD[1]"),
+	PINCTRL_PIN(47, "DA[8]"),
+	PINCTRL_PIN(48, "AD[0]"),
+	PINCTRL_PIN(49, "vdd_ring"),
+	PINCTRL_PIN(50, "gnd_ring"),
+	PINCTRL_PIN(51, "NC"),
+	PINCTRL_PIN(52, "NC"),
+	PINCTRL_PIN(53, "vdd_ring"),
+	PINCTRL_PIN(54, "gnd_ring"),
+	PINCTRL_PIN(55, "AD[15]"),
+	PINCTRL_PIN(56, "DA[7]"),
+	PINCTRL_PIN(57, "vdd_core"),
+	PINCTRL_PIN(58, "gnd_core"),
+	PINCTRL_PIN(59, "AD[14]"),
+	PINCTRL_PIN(60, "DA[6]"),
+	PINCTRL_PIN(61, "AD[13]"),
+	PINCTRL_PIN(62, "DA[5]"),
+	PINCTRL_PIN(63, "AD[12]"),
+	PINCTRL_PIN(64, "DA[4]"),
+	PINCTRL_PIN(65, "AD[11]"),
+	PINCTRL_PIN(66, "vdd_ring"),
+	PINCTRL_PIN(67, "gnd_ring"),
+	PINCTRL_PIN(68, "DA[3]"),
+	PINCTRL_PIN(69, "AD[10]"),
+	PINCTRL_PIN(70, "DA[2]"),
+	PINCTRL_PIN(71, "AD[9]"),
+	PINCTRL_PIN(72, "DA[1]"),
+	PINCTRL_PIN(73, "AD[8]"),
+	PINCTRL_PIN(74, "DA[0]"),
+	PINCTRL_PIN(75, "DSRn"),
+	PINCTRL_PIN(76, "DTRn"),
+	PINCTRL_PIN(77, "TCK"),
+	PINCTRL_PIN(78, "TDI"),
+	PINCTRL_PIN(79, "TDO"),
+	PINCTRL_PIN(80, "TMS"),
+	PINCTRL_PIN(81, "vdd_ring"),
+	PINCTRL_PIN(82, "gnd_ring"),
+	PINCTRL_PIN(83, "BOOT[1]"),
+	PINCTRL_PIN(84, "BOOT[0]"),
+	PINCTRL_PIN(85, "gnd_ring"),
+	PINCTRL_PIN(86, "NC"),
+	PINCTRL_PIN(87, "EECLK"),
+	PINCTRL_PIN(88, "EEDAT"),
+	PINCTRL_PIN(89, "ASYNC"),
+	PINCTRL_PIN(90, "vdd_core"),
+	PINCTRL_PIN(91, "gnd_core"),
+	PINCTRL_PIN(92, "ASDO"),
+	PINCTRL_PIN(93, "SCLK1"),
+	PINCTRL_PIN(94, "SFRM1"),
+	PINCTRL_PIN(95, "SSPRX1"),
+	PINCTRL_PIN(96, "SSPTX1"),
+	PINCTRL_PIN(97, "GRLED"),
+	PINCTRL_PIN(98, "RDLED"),
+	PINCTRL_PIN(99, "vdd_ring"),
+	PINCTRL_PIN(100, "gnd_ring"),
+	PINCTRL_PIN(101, "INT[3]"),
+	PINCTRL_PIN(102, "INT[1]"),
+	PINCTRL_PIN(103, "INT[0]"),
+	PINCTRL_PIN(104, "RTSn"),
+	PINCTRL_PIN(105, "USBm[0]"),
+	PINCTRL_PIN(106, "USBp[0]"),
+	PINCTRL_PIN(107, "ABITCLK"),
+	PINCTRL_PIN(108, "CTSn"),
+	PINCTRL_PIN(109, "RXD[0]"),
+	PINCTRL_PIN(110, "RXD[1]"),
+	PINCTRL_PIN(111, "vdd_ring"),
+	PINCTRL_PIN(112, "gnd_ring"),
+	PINCTRL_PIN(113, "TXD[0]"),
+	PINCTRL_PIN(114, "TXD[1]"),
+	PINCTRL_PIN(115, "CGPIO[0]"),
+	PINCTRL_PIN(116, "gnd_core"),
+	PINCTRL_PIN(117, "PLL_GND"),
+	PINCTRL_PIN(118, "XTALI"),
+	PINCTRL_PIN(119, "XTALO"),
+	PINCTRL_PIN(120, "PLL_VDD"),
+	PINCTRL_PIN(121, "vdd_core"),
+	PINCTRL_PIN(122, "gnd_ring"),
+	PINCTRL_PIN(123, "vdd_ring"),
+	PINCTRL_PIN(124, "RSTOn"),
+	PINCTRL_PIN(125, "PRSTn"),
+	PINCTRL_PIN(126, "CSn[0]"),
+	PINCTRL_PIN(127, "gnd_core"),
+	PINCTRL_PIN(128, "vdd_core"),
+	PINCTRL_PIN(129, "gnd_ring"),
+	PINCTRL_PIN(130, "vdd_ring"),
+	PINCTRL_PIN(131, "ADC[4]"),
+	PINCTRL_PIN(132, "ADC[3]"),
+	PINCTRL_PIN(133, "ADC[2]"),
+	PINCTRL_PIN(134, "ADC[1]"),
+	PINCTRL_PIN(135, "ADC[0]"),
+	PINCTRL_PIN(136, "ADC_VDD"),
+	PINCTRL_PIN(137, "RTCXTALI"),
+	PINCTRL_PIN(138, "RTCXTALO"),
+	PINCTRL_PIN(139, "ADC_GND"),
+	PINCTRL_PIN(140, "EGPIO[11]"),
+	PINCTRL_PIN(141, "EGPIO[10]"),
+	PINCTRL_PIN(142, "EGPIO[9]"),
+	PINCTRL_PIN(143, "EGPIO[8]"),
+	PINCTRL_PIN(144, "EGPIO[7]"),
+	PINCTRL_PIN(145, "EGPIO[6]"),
+	PINCTRL_PIN(146, "EGPIO[5]"),
+	PINCTRL_PIN(147, "EGPIO[4]"),
+	PINCTRL_PIN(148, "EGPIO[3]"),
+	PINCTRL_PIN(149, "gnd_ring"),
+	PINCTRL_PIN(150, "vdd_ring"),
+	PINCTRL_PIN(151, "EGPIO[2]"),
+	PINCTRL_PIN(152, "EGPIO[1]"),
+	PINCTRL_PIN(153, "EGPIO[0]"),
+	PINCTRL_PIN(154, "ARSTn"),
+	PINCTRL_PIN(155, "TRSTn"),
+	PINCTRL_PIN(156, "ASDI"),
+	PINCTRL_PIN(157, "USBm[2]"),
+	PINCTRL_PIN(158, "USBp[2]"),
+	PINCTRL_PIN(159, "WAITn"),
+	PINCTRL_PIN(160, "EGPIO[15]"),
+	PINCTRL_PIN(161, "gnd_ring"),
+	PINCTRL_PIN(162, "vdd_ring"),
+	PINCTRL_PIN(163, "EGPIO[14]"),
+	PINCTRL_PIN(164, "EGPIO[13]"),
+	PINCTRL_PIN(165, "EGPIO[12]"),
+	PINCTRL_PIN(166, "gnd_core"),
+	PINCTRL_PIN(167, "vdd_core"),
+	PINCTRL_PIN(168, "FGPIO[3]"),
+	PINCTRL_PIN(169, "FGPIO[2]"),
+	PINCTRL_PIN(170, "FGPIO[1]"),
+	PINCTRL_PIN(171, "gnd_ring"),
+	PINCTRL_PIN(172, "vdd_ring"),
+	PINCTRL_PIN(173, "CLD"),
+	PINCTRL_PIN(174, "CRS"),
+	PINCTRL_PIN(175, "TXERR"),
+	PINCTRL_PIN(176, "TXEN"),
+	PINCTRL_PIN(177, "MIITXD[0]"),
+	PINCTRL_PIN(178, "MIITXD[1]"),
+	PINCTRL_PIN(179, "MIITXD[2]"),
+	PINCTRL_PIN(180, "MIITXD[3]"),
+	PINCTRL_PIN(181, "TXCLK"),
+	PINCTRL_PIN(182, "RXERR"),
+	PINCTRL_PIN(183, "RXDVAL"),
+	PINCTRL_PIN(184, "MIIRXD[0]"),
+	PINCTRL_PIN(185, "MIIRXD[1]"),
+	PINCTRL_PIN(186, "MIIRXD[2]"),
+	PINCTRL_PIN(187, "gnd_ring"),
+	PINCTRL_PIN(188, "vdd_ring"),
+	PINCTRL_PIN(189, "MIIRXD[3]"),
+	PINCTRL_PIN(190, "RXCLK"),
+	PINCTRL_PIN(191, "MDIO"),
+	PINCTRL_PIN(192, "MDC"),
+	PINCTRL_PIN(193, "RDn"),
+	PINCTRL_PIN(194, "WRn"),
+	PINCTRL_PIN(195, "AD[16]"),
+	PINCTRL_PIN(196, "AD[17]"),
+	PINCTRL_PIN(197, "gnd_core"),
+	PINCTRL_PIN(198, "vdd_core"),
+	PINCTRL_PIN(199, "HGPIO[2]"),
+	PINCTRL_PIN(200, "HGPIO[3]"),
+	PINCTRL_PIN(201, "HGPIO[4]"),
+	PINCTRL_PIN(202, "HGPIO[5]"),
+	PINCTRL_PIN(203, "gnd_ring"),
+	PINCTRL_PIN(204, "vdd_ring"),
+	PINCTRL_PIN(205, "AD[18]"),
+	PINCTRL_PIN(206, "AD[19]"),
+	PINCTRL_PIN(207, "AD[20]"),
+	PINCTRL_PIN(208, "SDCLKEN"),
+};
+
+static const unsigned int ssp_ep9301_pins[] = {
+	93, 94, 95, 96
+};
+
+static const unsigned int ac97_ep9301_pins[] = {
+	89, 92, 107, 154, 156
+};
+
+/*
+ * Note: The EP9307 processor has one PWM with one output, PWMOUT.
+ * Note: The EP9301, EP9302, EP9312, and EP9315 processors each have two PWMs with
+ * two outputs, PWMOUT and PWMO1. PWMO1 is an alternate function for EGPIO14.
+ */
+/* The GPIO14E (14) pin overlap with pwm1 */
+static const unsigned int pwm_9301_pins[] = { 163 };
+
+static const unsigned int gpio1a_9301_pins[] = { 163 };
+
+/* ep9301/9302 have only 4,5 pin of GPIO E Port exposed */
+static const unsigned int gpio4a_9301_pins[] = { 97, 98 };
+
+/* ep9301/9302 have only 4,5 pin of GPIO G Port exposed */
+static const unsigned int gpio6a_9301_pins[] = { 87, 88 };
+
+static const unsigned int gpio7a_9301_pins[] = { 199, 200, 201, 202 };
+
+/* Groups for the ep9301/ep9302 SoC/package */
+static const struct ep93xx_pin_group ep9301_pin_groups[] = {
+	{
+		.name = "ssp",
+		.pins = ssp_ep9301_pins,
+		.num_pins = ARRAY_SIZE(ssp_ep9301_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONSSP,
+	},
+	{
+		.name = "i2s_on_ssp",
+		.pins = ssp_ep9301_pins,
+		.num_pins = ARRAY_SIZE(ssp_ep9301_pins),
+		.value = EP93XX_SYSCON_DEVCFG_I2SONSSP,
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONSSP,
+	},
+	{
+		.name = "ac97",
+		.pins = ac97_ep9301_pins,
+		.num_pins = ARRAY_SIZE(ac97_ep9301_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONAC97,
+	},
+	{
+		.name = "i2s_on_ac97",
+		.pins = ac97_ep9301_pins,
+		.num_pins = ARRAY_SIZE(ac97_ep9301_pins),
+		.value = EP93XX_SYSCON_DEVCFG_I2SONAC97,
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONAC97,
+	},
+	{
+		.name = "pwm1",
+		.pins = pwm_9301_pins,
+		.num_pins = ARRAY_SIZE(pwm_9301_pins),
+		.value = EP93XX_SYSCON_DEVCFG_PONG,
+		.mask = EP93XX_SYSCON_DEVCFG_PONG,
+	},
+	{
+		.name = "gpio1agrp",
+		.pins = gpio1a_9301_pins,
+		.num_pins = ARRAY_SIZE(gpio1a_9301_pins),
+		/* Conflict with PWM1 */
+		.mask = EP93XX_SYSCON_DEVCFG_PONG,
+	},
+	{
+		.name = "gpio4agrp",
+		.pins = gpio4a_9301_pins,
+		.num_pins = ARRAY_SIZE(gpio4a_9301_pins),
+		.value = EP93XX_SYSCON_DEVCFG_EONIDE,
+		.mask = EP93XX_SYSCON_DEVCFG_EONIDE,
+	},
+	{
+		.name = "gpio6agrp",
+		.pins = gpio6a_9301_pins,
+		.num_pins = ARRAY_SIZE(gpio6a_9301_pins),
+		.value = EP93XX_SYSCON_DEVCFG_GONIDE,
+		.mask = EP93XX_SYSCON_DEVCFG_GONIDE,
+	},
+	{
+		.name = "gpio7agrp",
+		.pins = gpio7a_9301_pins,
+		.num_pins = ARRAY_SIZE(gpio7a_9301_pins),
+		.value = EP93XX_SYSCON_DEVCFG_HONIDE,
+		.mask = EP93XX_SYSCON_DEVCFG_HONIDE,
+	},
+};
+
+static const struct pinctrl_pin_desc ep9307_pins[] = {
+	/* Row A */
+	PINCTRL_PIN(0, "CSn[1]"),	/* A1 */
+	PINCTRL_PIN(1, "CSn[7]"),	/* A2 */
+	PINCTRL_PIN(2, "SDCLKEN"),	/* A3 */
+	PINCTRL_PIN(3, "DA[31]"),	/* A4 */
+	PINCTRL_PIN(4, "DA[29]"),	/* A5 */
+	PINCTRL_PIN(5, "DA[27]"),	/* A6 */
+	PINCTRL_PIN(6, "HGPIO[2]"),	/* A7 */
+	PINCTRL_PIN(7, "RDn"),		/* A8 */
+	PINCTRL_PIN(8, "MIIRXD[3]"),	/* A9 */
+	PINCTRL_PIN(9, "RXDVAL"),	/* A10 */
+	PINCTRL_PIN(10, "MIITXD[1]"),	/* A11 */
+	PINCTRL_PIN(11, "CRS"),		/* A12 */
+	PINCTRL_PIN(12, "FGPIO[7]"),	/* A13 */
+	PINCTRL_PIN(13, "FGPIO[0]"),	/* A14 */
+	PINCTRL_PIN(14, "WAITn"),	/* A15 */
+	PINCTRL_PIN(15, "USBm[2]"),	/* A16 */
+	PINCTRL_PIN(16, "ASDI"),		/* A17 */
+	/* Row B*/
+	PINCTRL_PIN(17, "AD[25]"),	/* B1 */
+	PINCTRL_PIN(18, "CSn[2]"),	/* B2 */
+	PINCTRL_PIN(19, "CSn[6]"),	/* B3 */
+	PINCTRL_PIN(20, "AD[20]"),	/* B4 */
+	PINCTRL_PIN(21, "DA[30]"),	/* B5 */
+	PINCTRL_PIN(22, "AD[18]"),	/* B6 */
+	PINCTRL_PIN(23, "HGPIO[3]"),	/* B7 */
+	PINCTRL_PIN(24, "AD[17]"),	/* B8 */
+	PINCTRL_PIN(25, "RXCLK"),	/* B9 */
+	PINCTRL_PIN(26, "MIIRXD[1]"),	/* B10 */
+	PINCTRL_PIN(27, "MIITXD[2]"),	/* B11 */
+	PINCTRL_PIN(28, "TXEN"),		/* B12 */
+	PINCTRL_PIN(29, "FGPIO[5]"),	/* B13 */
+	PINCTRL_PIN(30, "EGPIO[15]"),	/* B14 */
+	PINCTRL_PIN(31, "USBp[2]"),	/* B15 */
+	PINCTRL_PIN(32, "ARSTn"),	/* B16 */
+	PINCTRL_PIN(33, "ADC_VDD"),	/* B17 */
+	/* Row C*/
+	PINCTRL_PIN(34, "AD[23]"),	/* C1 */
+	PINCTRL_PIN(35, "DA[26]"),	/* C2 */
+	PINCTRL_PIN(36, "CSn[3]"),	/* C3 */
+	PINCTRL_PIN(37, "DA[25]"),	/* C4 */
+	PINCTRL_PIN(38, "AD[24]"),	/* C5 */
+	PINCTRL_PIN(39, "AD[19]"),	/* C6 */
+	PINCTRL_PIN(40, "HGPIO[5]"),	/* C7 */
+	PINCTRL_PIN(41, "WRn"),		/* C8 */
+	PINCTRL_PIN(42, "MDIO"),		/* C9 */
+	PINCTRL_PIN(43, "MIIRXD[2]"),	/* C10 */
+	PINCTRL_PIN(44, "TXCLK"),	/* C11 */
+	PINCTRL_PIN(45, "MIITXD[0]"),	/* C12 */
+	PINCTRL_PIN(46, "CLD"),		/* C13 */
+	PINCTRL_PIN(47, "EGPIO[13]"),	/* C14 */
+	PINCTRL_PIN(48, "TRSTn"),	/* C15 */
+	PINCTRL_PIN(49, "Xp"),		/* C16 */
+	PINCTRL_PIN(50, "Xm"),		/* C17 */
+	/* Row D*/
+	PINCTRL_PIN(51, "SDCSn[3]"),	/* D1 */
+	PINCTRL_PIN(52, "DA[23]"),	/* D2 */
+	PINCTRL_PIN(53, "SDCLK"),	/* D3 */
+	PINCTRL_PIN(54, "DA[24]"),	/* D4 */
+	PINCTRL_PIN(55, "HGPIO[7]"),	/* D5 */
+	PINCTRL_PIN(56, "HGPIO[6]"),	/* D6 */
+	PINCTRL_PIN(57, "A[28]"),	/* D7 */
+	PINCTRL_PIN(58, "HGPIO[4]"),	/* D8 */
+	PINCTRL_PIN(59, "AD[16]"),	/* D9 */
+	PINCTRL_PIN(60, "MDC"),		/* D10 */
+	PINCTRL_PIN(61, "RXERR"),	/* D11 */
+	PINCTRL_PIN(62, "MIITXD[3]"),	/* D12 */
+	PINCTRL_PIN(63, "EGPIO[12]"),	/* D13 */
+	PINCTRL_PIN(64, "EGPIO[1]"),	/* D14 */
+	PINCTRL_PIN(65, "EGPIO[0]"),	/* D15 */
+	PINCTRL_PIN(66, "Ym"),		/* D16 */
+	PINCTRL_PIN(67, "Yp"),		/* D17 */
+	/* Row E */
+	PINCTRL_PIN(68, "SDCSn[2]"),	/* E1 */
+	PINCTRL_PIN(69, "SDWEN"),	/* E2 */
+	PINCTRL_PIN(70, "DA[22]"),	/* E3 */
+	PINCTRL_PIN(71, "AD[3]"),	/* E4 */
+	PINCTRL_PIN(72, "DA[15]"),	/* E5 */
+	PINCTRL_PIN(73, "AD[21]"),	/* E6 */
+	PINCTRL_PIN(74, "DA[17]"),	/* E7 */
+	PINCTRL_PIN(75, "vddr"),		/* E8 */
+	PINCTRL_PIN(76, "vddr"),		/* E9 */
+	PINCTRL_PIN(77, "vddr"),		/* E10 */
+	PINCTRL_PIN(78, "MIIRXD[0]"),	/* E11 */
+	PINCTRL_PIN(79, "TXERR"),	/* E12 */
+	PINCTRL_PIN(80, "EGPIO[2]"),	/* E13 */
+	PINCTRL_PIN(81, "EGPIO[4]"),	/* E14 */
+	PINCTRL_PIN(82, "EGPIO[3]"),	/* E15 */
+	PINCTRL_PIN(83, "sXp"),		/* E16 */
+	PINCTRL_PIN(84, "sXm"),		/* E17 */
+	/* Row F*/
+	PINCTRL_PIN(85, "RASn"),		/* F1 */
+	PINCTRL_PIN(86, "SDCSn[1]"),	/* F2 */
+	PINCTRL_PIN(87, "SDCSn[0]"),	/* F3 */
+	PINCTRL_PIN(88, "DQMn[3]"),	/* F4 */
+	PINCTRL_PIN(89, "AD[5]"),	/* F5 */
+	PINCTRL_PIN(90, "gndr"),		/* F6 */
+	PINCTRL_PIN(91, "gndr"),		/* F7 */
+	PINCTRL_PIN(92, "gndr"),		/* F8 */
+	PINCTRL_PIN(93, "vddc"),		/* F9 */
+	PINCTRL_PIN(94, "vddc"),		/* F10 */
+	PINCTRL_PIN(95, "gndr"),		/* F11 */
+	PINCTRL_PIN(96, "EGPIO[7]"),	/* F12 */
+	PINCTRL_PIN(97, "EGPIO[5]"),	/* F13 */
+	PINCTRL_PIN(98, "ADC GND"),	/* F14 */
+	PINCTRL_PIN(99, "EGPIO[6]"),	/* F15 */
+	PINCTRL_PIN(100, "sYm"),		/* F16 */
+	PINCTRL_PIN(101, "syp"),		/* F17 */
+	/* Row G */
+	PINCTRL_PIN(102, "DQMn[0]"),	/* G1 */
+	PINCTRL_PIN(103, "CASn"),	/* G2 */
+	PINCTRL_PIN(104, "DA[21]"),	/* G3 */
+	PINCTRL_PIN(105, "AD[22]"),	/* G4 */
+	PINCTRL_PIN(106, "vddr"),	/* G5 */
+	PINCTRL_PIN(107, "gndr"),	/* G6 */
+	PINCTRL_PIN(108, "gndr"),	/* G12 */
+	PINCTRL_PIN(109, "EGPIO[9]"),	/* G13 */
+	PINCTRL_PIN(110, "EGPIO[10]"),	/* G14 */
+	PINCTRL_PIN(111, "EGPIO[11]"),	/* G15 */
+	PINCTRL_PIN(112, "RTCXTALO"),	/* G16 */
+	PINCTRL_PIN(113, "RTCXTALI"),	/* G17 */
+	/* Row H */
+	PINCTRL_PIN(114, "DA[18]"),	/* H1 */
+	PINCTRL_PIN(115, "DA[20]"),	/* H2 */
+	PINCTRL_PIN(116, "DA[19]"),	/* H3 */
+	PINCTRL_PIN(117, "DA[16]"),	/* H4 */
+	PINCTRL_PIN(118, "vddr"),	/* H5 */
+	PINCTRL_PIN(119, "vddc"),	/* H6 */
+	PINCTRL_PIN(120, "gndc"),	/* H7 */
+	PINCTRL_PIN(121, "gndc"),	/* H9 */
+	PINCTRL_PIN(122, "gndc"),	/* H10 */
+	PINCTRL_PIN(123, "gndr"),	/* H12 */
+	PINCTRL_PIN(124, "vddr"),	/* H13 */
+	PINCTRL_PIN(125, "EGPIO[8]"),	/* H14 */
+	PINCTRL_PIN(126, "PRSTN"),	/* H15 */
+	PINCTRL_PIN(127, "COL[7]"),	/* H16 */
+	PINCTRL_PIN(128, "RSTON"),	/* H17 */
+	/* Row J */
+	PINCTRL_PIN(129, "AD[6]"),	/* J1 */
+	PINCTRL_PIN(130, "DA[14]"),	/* J2 */
+	PINCTRL_PIN(131, "AD[7]"),	/* J3 */
+	PINCTRL_PIN(132, "DA[13]"),	/* J4 */
+	PINCTRL_PIN(133, "vddr"),	/* J5 */
+	PINCTRL_PIN(134, "vddc"),	/* J6 */
+	PINCTRL_PIN(135, "gndc"),	/* J8 */
+	PINCTRL_PIN(136, "gndc"),	/* J10 */
+	PINCTRL_PIN(137, "vddc"),	/* J12 */
+	PINCTRL_PIN(138, "vddr"),	/* J13 */
+	PINCTRL_PIN(139, "COL[5]"),	/* J14 */
+	PINCTRL_PIN(140, "COL[6]"),	/* J15 */
+	PINCTRL_PIN(141, "CSn[0]"),	/* J16 */
+	PINCTRL_PIN(142, "COL[3]"),	/* J17 */
+	/* Row K */
+	PINCTRL_PIN(143, "AD[4]"),	/* K1 */
+	PINCTRL_PIN(144, "DA[12]"),	/* K2 */
+	PINCTRL_PIN(145, "DA[10]"),	/* K3 */
+	PINCTRL_PIN(146, "DA[11]"),	/* K4 */
+	PINCTRL_PIN(147, "vddr"),	/* K5 */
+	PINCTRL_PIN(148, "gndr"),	/* K6 */
+	PINCTRL_PIN(149, "gndc"),	/* K8 */
+	PINCTRL_PIN(150, "gndc"),	/* K9 */
+	PINCTRL_PIN(151, "gndc"),	/* K10 */
+	PINCTRL_PIN(152, "vddc"),	/* K12 */
+	PINCTRL_PIN(153, "COL[4]"),	/* K13 */
+	PINCTRL_PIN(154, "PLL_VDD"),	/* K14 */
+	PINCTRL_PIN(155, "COL[2]"),	/* K15 */
+	PINCTRL_PIN(156, "COL[1]"),	/* K16 */
+	PINCTRL_PIN(157, "COL[0]"),	/* K17 */
+	/* Row L */
+	PINCTRL_PIN(158, "DA[9]"),	/* L1 */
+	PINCTRL_PIN(159, "AD[2]"),	/* L2 */
+	PINCTRL_PIN(160, "AD[1]"),	/* L3 */
+	PINCTRL_PIN(161, "DA[8]"),	/* L4 */
+	PINCTRL_PIN(162, "BLANK"),	/* L5 */
+	PINCTRL_PIN(163, "gndr"),	/* L6 */
+	PINCTRL_PIN(164, "gndr"),	/* L7 */
+	PINCTRL_PIN(165, "ROW[7]"),	/* L8 */
+	PINCTRL_PIN(166, "ROW[5]"),	/* L9 */
+	PINCTRL_PIN(167, "PLL GND"),	/* L10 */
+	PINCTRL_PIN(168, "XTALI"),	/* L11 */
+	PINCTRL_PIN(169, "XTALO"),	/* L12 */
+	/* Row M */
+	PINCTRL_PIN(170, "BRIGHT"),	/* M1 */
+	PINCTRL_PIN(171, "AD[0]"),	/* M2 */
+	PINCTRL_PIN(172, "DQMn[1]"),	/* M3 */
+	PINCTRL_PIN(173, "DQMn[2]"),	/* M4 */
+	PINCTRL_PIN(174, "P[17]"),	/* M5 */
+	PINCTRL_PIN(175, "gndr"),	/* M6 */
+	PINCTRL_PIN(176, "gndr"),	/* M7 */
+	PINCTRL_PIN(177, "vddc"),	/* M8 */
+	PINCTRL_PIN(178, "vddc"),	/* M9 */
+	PINCTRL_PIN(179, "gndr"),	/* M10 */
+	PINCTRL_PIN(180, "gndr"),	/* M11 */
+	PINCTRL_PIN(181, "ROW[6]"),	/* M12 */
+	PINCTRL_PIN(182, "ROW[4]"),	/* M13 */
+	PINCTRL_PIN(183, "ROW[1]"),	/* M14 */
+	PINCTRL_PIN(184, "ROW[0]"),	/* M15 */
+	PINCTRL_PIN(185, "ROW[3]"),	/* M16 */
+	PINCTRL_PIN(186, "ROW[2]"),	/* M17 */
+	/* Row N */
+	PINCTRL_PIN(187, "P[14]"),	/* N1 */
+	PINCTRL_PIN(188, "P[16]"),	/* N2 */
+	PINCTRL_PIN(189, "P[15]"),	/* N3 */
+	PINCTRL_PIN(190, "P[13]"),	/* N4 */
+	PINCTRL_PIN(191, "P[12]"),	/* N5 */
+	PINCTRL_PIN(192, "DA[5]"),	/* N6 */
+	PINCTRL_PIN(193, "vddr"),	/* N7 */
+	PINCTRL_PIN(194, "vddr"),	/* N8 */
+	PINCTRL_PIN(195, "vddr"),	/* N9 */
+	PINCTRL_PIN(196, "vddr"),	/* N10 */
+	PINCTRL_PIN(197, "EECLK"),	/* N11 */
+	PINCTRL_PIN(198, "ASDO"),	/* N12 */
+	PINCTRL_PIN(199, "CTSn"),	/* N13 */
+	PINCTRL_PIN(200, "RXD[0]"),	/* N14 */
+	PINCTRL_PIN(201, "TXD[0]"),	/* N15 */
+	PINCTRL_PIN(202, "TXD[1]"),	/* N16 */
+	PINCTRL_PIN(203, "TXD[2]"),	/* N17 */
+	/* Row P */
+	PINCTRL_PIN(204, "SPCLK"),	/* P1 */
+	PINCTRL_PIN(205, "P[10]"),	/* P2 */
+	PINCTRL_PIN(206, "P[11]"),	/* P3 */
+	PINCTRL_PIN(207, "P[3]"),	/* P4 */
+	PINCTRL_PIN(208, "AD[15]"),	/* P5 */
+	PINCTRL_PIN(209, "AD[13]"),	/* P6 */
+	PINCTRL_PIN(210, "AD[12]"),	/* P7 */
+	PINCTRL_PIN(211, "DA[2]"),	/* P8 */
+	PINCTRL_PIN(212, "AD[8]"),	/* P9 */
+	PINCTRL_PIN(213, "TCK"),		/* P10 */
+	PINCTRL_PIN(214, "BOOT[1]"),	/* P11 */
+	PINCTRL_PIN(215, "EEDAT"),	/* P12 */
+	PINCTRL_PIN(216, "GRLED"),	/* P13 */
+	PINCTRL_PIN(217, "RDLED"),	/* P14 */
+	PINCTRL_PIN(218, "GGPIO[2]"),	/* P15 */
+	PINCTRL_PIN(219, "RXD[1]"),	/* P16 */
+	PINCTRL_PIN(220, "RXD[2]"),	/* P17 */
+	/* Row R */
+	PINCTRL_PIN(221, "P[9]"),	/* R1 */
+	PINCTRL_PIN(222, "HSYNC"),	/* R2 */
+	PINCTRL_PIN(223, "P[6]"),	/* R3 */
+	PINCTRL_PIN(224, "P[5]"),	/* R4 */
+	PINCTRL_PIN(225, "P[0]"),	/* R5 */
+	PINCTRL_PIN(226, "AD[14]"),	/* R6 */
+	PINCTRL_PIN(227, "DA[4]"),	/* R7 */
+	PINCTRL_PIN(228, "DA[1]"),	/* R8 */
+	PINCTRL_PIN(229, "DTRn"),	/* R9 */
+	PINCTRL_PIN(230, "TDI"),		/* R10 */
+	PINCTRL_PIN(231, "BOOT[0]"),	/* R11 */
+	PINCTRL_PIN(232, "ASYNC"),	/* R12 */
+	PINCTRL_PIN(233, "SSPTX[1]"),	/* R13 */
+	PINCTRL_PIN(234, "PWMOUT"),	/* R14 */
+	PINCTRL_PIN(235, "USBm[0]"),	/* R15 */
+	PINCTRL_PIN(236, "ABITCLK"),	/* R16 */
+	PINCTRL_PIN(237, "USBp[0]"),	/* R17 */
+	/* Row T */
+	PINCTRL_PIN(238, "NC"),		/* T1 */
+	PINCTRL_PIN(239, "NC"),		/* T2 */
+	PINCTRL_PIN(240, "V_CSYNC"),	/* T3 */
+	PINCTRL_PIN(241, "P[7]"),	/* T4 */
+	PINCTRL_PIN(242, "P[2]"),	/* T5 */
+	PINCTRL_PIN(243, "DA[7]"),	/* T6 */
+	PINCTRL_PIN(244, "AD[11]"),	/* T7 */
+	PINCTRL_PIN(245, "AD[9]"),	/* T8 */
+	PINCTRL_PIN(246, "DSRn"),	/* T9 */
+	PINCTRL_PIN(247, "TMS"),		/* T10 */
+	PINCTRL_PIN(248, "gndr"),	/* T11 */
+	PINCTRL_PIN(249, "SFRM[1]"),	/* T12 */
+	PINCTRL_PIN(250, "INT[2]"),	/* T13 */
+	PINCTRL_PIN(251, "INT[0]"),	/* T14 */
+	PINCTRL_PIN(252, "USBp[1]"),	/* T15 */
+	PINCTRL_PIN(253, "NC"),		/* T16 */
+	PINCTRL_PIN(254, "NC"),		/* T17 */
+	/* Row U */
+	PINCTRL_PIN(255, "NC"),		/* U1 */
+	PINCTRL_PIN(256, "NC"),		/* U2 */
+	PINCTRL_PIN(257, "P[8]"),	/* U3 */
+	PINCTRL_PIN(258, "P[4]"),	/* U4 */
+	PINCTRL_PIN(259, "P[1]"),	/* U5 */
+	PINCTRL_PIN(260, "DA[6]"),	/* U6 */
+	PINCTRL_PIN(261, "DA[3]"),	/* U7 */
+	PINCTRL_PIN(262, "AD[10]"),	/* U8 */
+	PINCTRL_PIN(263, "DA[0]"),	/* U9 */
+	PINCTRL_PIN(264, "TDO"),		/* U10 */
+	PINCTRL_PIN(265, "NC"),		/* U11 */
+	PINCTRL_PIN(266, "SCLK[1]"),	/* U12 */
+	PINCTRL_PIN(267, "SSPRX[1]"),	/* U13 */
+	PINCTRL_PIN(268, "INT[1]"),	/* U14 */
+	PINCTRL_PIN(269, "RTSn"),	/* U15 */
+	PINCTRL_PIN(270, "USBm[1]"),	/* U16 */
+	PINCTRL_PIN(271, "NC"),		/* U17 */
+};
+
+static const unsigned int ssp_ep9307_pins[] = {
+	233, 249, 266, 267
+};
+
+static const unsigned int ac97_ep9307_pins[] = {
+	16, 32, 198, 232, 236
+};
+
+/* I can't find info on those - it's some internal state */
+static const unsigned int raster_on_sdram0_pins[] = {
+};
+
+static const unsigned int raster_on_sdram3_pins[] = {
+};
+
+/* ROW[N] */
+static const unsigned int gpio2a_9307_pins[] = {
+	165, 166, 181, 182, 183, 184, 185, 186
+};
+
+/* COL[N] */
+static const unsigned int gpio3a_9307_pins[] = {
+	127, 139, 140, 142, 153, 155, 156, 157
+};
+
+static const unsigned int keypad_9307_pins[] = {
+	127, 139, 140, 142, 153, 155, 156, 157,
+	165, 166, 181, 182, 183, 184, 185, 186
+};
+
+/* ep9307 have only 4,5 pin of GPIO E Port exposed */
+static const unsigned int gpio4a_9307_pins[] = { 216, 217 };
+
+/* ep9307 have only 2 pin of GPIO G Port exposed */
+static const unsigned int gpio6a_9307_pins[] = { 219 };
+
+static const unsigned int gpio7a_9307_pins[] = { 7, 24, 41, 56, 57, 59 };
+
+static const struct ep93xx_pin_group ep9307_pin_groups[] = {
+	{
+		.name = "ssp",
+		.pins = ssp_ep9307_pins,
+		.num_pins = ARRAY_SIZE(ssp_ep9307_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONSSP,
+	},
+	{
+		.name = "i2s_on_ssp",
+		.pins = ssp_ep9307_pins,
+		.num_pins = ARRAY_SIZE(ssp_ep9307_pins),
+		.value = EP93XX_SYSCON_DEVCFG_I2SONSSP,
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONSSP,
+	},
+	{
+		.name = "ac97",
+		.pins = ac97_ep9307_pins,
+		.num_pins = ARRAY_SIZE(ac97_ep9307_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONAC97,
+	},
+	{
+		.name = "i2s_on_ac97",
+		.pins = ac97_ep9307_pins,
+		.num_pins = ARRAY_SIZE(ac97_ep9307_pins),
+		.value = EP93XX_SYSCON_DEVCFG_I2SONAC97,
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONAC97,
+	},
+	{
+		.name = "rasteronsdram0grp",
+		.pins = raster_on_sdram0_pins,
+		.num_pins = ARRAY_SIZE(raster_on_sdram0_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_RASONP3,
+	},
+	{
+		.name = "rasteronsdram3grp",
+		.pins = raster_on_sdram3_pins,
+		.num_pins = ARRAY_SIZE(raster_on_sdram3_pins),
+		.value = EP93XX_SYSCON_DEVCFG_RASONP3,
+		.mask = EP93XX_SYSCON_DEVCFG_RASONP3,
+	},
+	{
+		.name = "gpio2agrp",
+		.pins = gpio2a_9307_pins,
+		.num_pins = ARRAY_SIZE(gpio2a_9307_pins),
+		.value = EP93XX_SYSCON_DEVCFG_GONK,
+		.mask = EP93XX_SYSCON_DEVCFG_GONK,
+	},
+	{
+		.name = "gpio3agrp",
+		.pins = gpio3a_9307_pins,
+		.num_pins = ARRAY_SIZE(gpio3a_9307_pins),
+		.value = EP93XX_SYSCON_DEVCFG_GONK,
+		.mask = EP93XX_SYSCON_DEVCFG_GONK,
+	},
+	{
+		.name = "keypadgrp",
+		.pins = keypad_9307_pins,
+		.num_pins = ARRAY_SIZE(keypad_9307_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_GONK,
+	},
+	{
+		.name = "gpio4agrp",
+		.pins = gpio4a_9307_pins,
+		.num_pins = ARRAY_SIZE(gpio4a_9307_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_EONIDE,
+	},
+	{
+		.name = "gpio6agrp",
+		.pins = gpio6a_9307_pins,
+		.num_pins = ARRAY_SIZE(gpio6a_9307_pins),
+		.value = EP93XX_SYSCON_DEVCFG_GONIDE,
+		.mask = EP93XX_SYSCON_DEVCFG_GONIDE,
+	},
+	{
+		.name = "gpio7agrp",
+		.pins = gpio7a_9307_pins,
+		.num_pins = ARRAY_SIZE(gpio7a_9307_pins),
+		.value = EP93XX_SYSCON_DEVCFG_HONIDE,
+		.mask = EP93XX_SYSCON_DEVCFG_HONIDE,
+	},
+};
+
+/* ep9312, ep9315 */
+static const struct pinctrl_pin_desc ep9312_pins[] = {
+	/* Row A */
+	PINCTRL_PIN(0, "CSN[7]"),	/* A1 */
+	PINCTRL_PIN(1, "DA[28]"),	/* A2 */
+	PINCTRL_PIN(2, "AD[18]"),	/* A3 */
+	PINCTRL_PIN(3, "DD[8]"),	/* A4 */
+	PINCTRL_PIN(4, "DD[4]"),	/* A5 */
+	PINCTRL_PIN(5, "AD[17]"),	/* A6 */
+	PINCTRL_PIN(6, "RDN"),		/* A7 */
+	PINCTRL_PIN(7, "RXCLK"),	/* A8 */
+	PINCTRL_PIN(8, "MIIRXD[0]"),	/* A9 */
+	PINCTRL_PIN(9, "RXDVAL"),	/* A10 */
+	PINCTRL_PIN(10, "MIITXD[2]"),	/* A11 */
+	PINCTRL_PIN(11, "TXERR"),	/* A12 */
+	PINCTRL_PIN(12, "CLD"),	/* A13 */
+	PINCTRL_PIN(13, "NC"),		/* A14 */
+	PINCTRL_PIN(14, "NC"),		/* A15 */
+	PINCTRL_PIN(15, "NC"),		/* A16 */
+	PINCTRL_PIN(16, "EGPIO[12]"),	/* A17 */
+	PINCTRL_PIN(17, "EGPIO[15]"),	/* A18 */
+	PINCTRL_PIN(18, "NC"),		/* A19 */
+	PINCTRL_PIN(19, "NC"),		/* A20 */
+	/* Row B */
+	PINCTRL_PIN(20, "CSN[2]"),	/* B1 */
+	PINCTRL_PIN(21, "DA[31]"),	/* B2 */
+	PINCTRL_PIN(22, "DA[30]"),	/* B3 */
+	PINCTRL_PIN(23, "DA[27]"),	/* B4 */
+	PINCTRL_PIN(24, "DD[7]"),	/* B5 */
+	PINCTRL_PIN(25, "DD[3]"),	/* B6 */
+	PINCTRL_PIN(26, "WRN"),	/* B7 */
+	PINCTRL_PIN(27, "MDIO"),	/* B8 */
+	PINCTRL_PIN(28, "MIIRXD[1]"),	/* B9 */
+	PINCTRL_PIN(29, "RXERR"),	/* B10 */
+	PINCTRL_PIN(30, "MIITXD[1]"),	/* B11 */
+	PINCTRL_PIN(31, "CRS"),	/* B12 */
+	PINCTRL_PIN(32, "NC"),		/* B13 */
+	PINCTRL_PIN(33, "NC"),		/* B14 */
+	PINCTRL_PIN(34, "NC"),		/* B15 */
+	PINCTRL_PIN(35, "NC"),		/* B16 */
+	PINCTRL_PIN(36, "EGPIO[13]"),	/* B17 */
+	PINCTRL_PIN(37, "NC"),		/* B18 */
+	PINCTRL_PIN(38, "WAITN"),	/* B19 */
+	PINCTRL_PIN(39, "TRSTN"),	/* B20 */
+	/* Row C */
+	PINCTRL_PIN(40, "CSN[1]"),	/* C1 */
+	PINCTRL_PIN(41, "CSN[3]"),	/* C2 */
+	PINCTRL_PIN(42, "AD[20]"),	/* C3 */
+	PINCTRL_PIN(43, "DA[29]"),	/* C4 */
+	PINCTRL_PIN(44, "DD[10]"),	/* C5 */
+	PINCTRL_PIN(45, "DD[6]"),	/* C6 */
+	PINCTRL_PIN(46, "DD[2]"),	/* C7 */
+	PINCTRL_PIN(47, "MDC"),	/* C8 */
+	PINCTRL_PIN(48, "MIIRXD[3]"),	/* C9 */
+	PINCTRL_PIN(49, "TXCLK"),	/* C10 */
+	PINCTRL_PIN(50, "MIITXD[0]"),	/* C11 */
+	PINCTRL_PIN(51, "NC"),		/* C12 */
+	PINCTRL_PIN(52, "NC"),		/* C13 */
+	PINCTRL_PIN(53, "NC"),		/* C14 */
+	PINCTRL_PIN(54, "NC"),		/* C15 */
+	PINCTRL_PIN(55, "NC"),		/* C16 */
+	PINCTRL_PIN(56, "NC"),		/* C17 */
+	PINCTRL_PIN(57, "USBP[2]"),	/* C18 */
+	PINCTRL_PIN(58, "IORDY"),	/* C19 */
+	PINCTRL_PIN(59, "DMACKN"),	/* C20 */
+	/* Row D */
+	PINCTRL_PIN(60, "AD[24]"),	/* D1 */
+	PINCTRL_PIN(61, "DA[25]"),	/* D2 */
+	PINCTRL_PIN(62, "DD[11]"),	/* D3 */
+	PINCTRL_PIN(63, "SDCLKEN"),	/* D4 */
+	PINCTRL_PIN(64, "AD[19]"),	/* D5 */
+	PINCTRL_PIN(65, "DD[9]"),	/* D6 */
+	PINCTRL_PIN(66, "DD[5]"),	/* D7 */
+	PINCTRL_PIN(67, "AD[16]"),	/* D8 */
+	PINCTRL_PIN(68, "MIIRXD[2]"),	/* D9 */
+	PINCTRL_PIN(69, "MIITXD[3]"),	/* D10 */
+	PINCTRL_PIN(70, "TXEN"),	/* D11 */
+	PINCTRL_PIN(71, "NC"),		/* D12 */
+	PINCTRL_PIN(72, "NC"),		/* D13 */
+	PINCTRL_PIN(73, "NC"),		/* D14 */
+	PINCTRL_PIN(74, "EGPIO[14]"),	/* D15 */
+	PINCTRL_PIN(75, "NC"),		/* D16 */
+	PINCTRL_PIN(76, "USBM[2]"),	/* D17 */
+	PINCTRL_PIN(77, "ARSTN"),	/* D18 */
+	PINCTRL_PIN(78, "DIORN"),	/* D19 */
+	PINCTRL_PIN(79, "EGPIO[1]"),	/* D20 */
+	/* Row E */
+	PINCTRL_PIN(80, "AD[23]"),	/* E1 */
+	PINCTRL_PIN(81, "DA[23]"),	/* E2 */
+	PINCTRL_PIN(82, "DA[26]"),	/* E3 */
+	PINCTRL_PIN(83, "CSN[6]"),	/* E4 */
+	PINCTRL_PIN(84, "GND"),	/* E5 */
+	PINCTRL_PIN(85, "GND"),	/* E6 */
+	PINCTRL_PIN(86, "CVDD"),	/* E7 */
+	PINCTRL_PIN(87, "CVDD"),	/* E8 */
+	PINCTRL_PIN(88, "RVDD"),	/* E9 */
+	PINCTRL_PIN(89, "GND"),	/* E10 */
+	PINCTRL_PIN(90, "GND"),	/* E11 */
+	PINCTRL_PIN(91, "RVDD"),	/* E12 */
+	PINCTRL_PIN(92, "CVDD"),	/* E13 */
+	PINCTRL_PIN(93, "CVDD"),	/* E14 */
+	PINCTRL_PIN(94, "GND"),	/* E15 */
+	PINCTRL_PIN(95, "ASDI"),	/* E16 */
+	PINCTRL_PIN(96, "DIOWN"),	/* E17 */
+	PINCTRL_PIN(97, "EGPIO[0]"),	/* E18 */
+	PINCTRL_PIN(98, "EGPIO[3]"),	/* E19 */
+	PINCTRL_PIN(99, "EGPIO[5]"),	/* E20 */
+	/* Row F */
+	PINCTRL_PIN(100, "SDCSN[3]"),	/* F1 */
+	PINCTRL_PIN(101, "DA[22]"),	/* F2 */
+	PINCTRL_PIN(102, "DA[24]"),	/* F3 */
+	PINCTRL_PIN(103, "AD[25]"),	/* F4 */
+	PINCTRL_PIN(104, "RVDD"),	/* F5 */
+	PINCTRL_PIN(105, "GND"),	/* F6 */
+	PINCTRL_PIN(106, "CVDD"),	/* F7 */
+	PINCTRL_PIN(107, "CVDD"),	/* F14 */
+	PINCTRL_PIN(108, "GND"),	/* F15 */
+	PINCTRL_PIN(109, "GND"),	/* F16 */
+	PINCTRL_PIN(110, "EGPIO[2]"),	/* F17 */
+	PINCTRL_PIN(111, "EGPIO[4]"),	/* F18 */
+	PINCTRL_PIN(112, "EGPIO[6]"),	/* F19 */
+	PINCTRL_PIN(113, "EGPIO[8]"),	/* F20 */
+	/* Row G */
+	PINCTRL_PIN(114, "SDCSN[0]"),	/* G1 */
+	PINCTRL_PIN(115, "SDCSN[1]"),	/* G2 */
+	PINCTRL_PIN(116, "SDWEN"),	/* G3 */
+	PINCTRL_PIN(117, "SDCLK"),	/* G4 */
+	PINCTRL_PIN(118, "RVDD"),	/* G5 */
+	PINCTRL_PIN(119, "RVDD"),	/* G6 */
+	PINCTRL_PIN(120, "RVDD"),	/* G15 */
+	PINCTRL_PIN(121, "RVDD"),	/* G16 */
+	PINCTRL_PIN(122, "EGPIO[7]"),	/* G17 */
+	PINCTRL_PIN(123, "EGPIO[9]"),	/* G18 */
+	PINCTRL_PIN(124, "EGPIO[10]"),	/* G19 */
+	PINCTRL_PIN(125, "EGPIO[11]"),	/* G20 */
+	/* Row H */
+	PINCTRL_PIN(126, "DQMN[3]"),	/* H1 */
+	PINCTRL_PIN(127, "CASN"),	/* H2 */
+	PINCTRL_PIN(128, "RASN"),	/* H3 */
+	PINCTRL_PIN(129, "SDCSN[2]"),	/* H4 */
+	PINCTRL_PIN(130, "CVDD"),	/* H5 */
+	PINCTRL_PIN(131, "GND"),	/* H8 */
+	PINCTRL_PIN(132, "GND"),	/* H9 */
+	PINCTRL_PIN(133, "GND"),	/* H10 */
+	PINCTRL_PIN(134, "GND"),	/* H11 */
+	PINCTRL_PIN(135, "GND"),	/* H12 */
+	PINCTRL_PIN(136, "GND"),	/* H13 */
+	PINCTRL_PIN(137, "RVDD"),	/* H16 */
+	PINCTRL_PIN(138, "RTCXTALO"),	/* H17 */
+	PINCTRL_PIN(139, "ADC_VDD"),	/* H18 */
+	PINCTRL_PIN(140, "ADC_GND"),	/* H19 */
+	PINCTRL_PIN(141, "XP"),	/* H20 */
+	/* Row J */
+	PINCTRL_PIN(142, "DA[21]"),	/* J1 */
+	PINCTRL_PIN(143, "DQMN[0]"),	/* J2 */
+	PINCTRL_PIN(144, "DQMN[1]"),	/* J3 */
+	PINCTRL_PIN(145, "DQMN[2]"),	/* J4 */
+	PINCTRL_PIN(146, "GND"),	/* J5 */
+	PINCTRL_PIN(147, "GND"),	/* J8 */
+	PINCTRL_PIN(148, "GND"),	/* J9 */
+	PINCTRL_PIN(149, "GND"),	/* J10 */
+	PINCTRL_PIN(150, "GND"),	/* J11 */
+	PINCTRL_PIN(151, "GND"),	/* J12 */
+	PINCTRL_PIN(152, "GND"),	/* J13 */
+	PINCTRL_PIN(153, "CVDD"),	/* J16 */
+	PINCTRL_PIN(154, "RTCXTALI"),	/* J17 */
+	PINCTRL_PIN(155, "XM"),	/* J18 */
+	PINCTRL_PIN(156, "YP"),	/* J19 */
+	PINCTRL_PIN(157, "YM"),	/* J20 */
+	/* Row K */
+	PINCTRL_PIN(158, "AD[22]"),	/* K1 */
+	PINCTRL_PIN(159, "DA[20]"),	/* K2 */
+	PINCTRL_PIN(160, "AD[21]"),	/* K3 */
+	PINCTRL_PIN(161, "DA[19]"),	/* K4 */
+	PINCTRL_PIN(162, "RVDD"),	/* K5 */
+	PINCTRL_PIN(163, "GND"),	/* K8 */
+	PINCTRL_PIN(164, "GND"),	/* K9 */
+	PINCTRL_PIN(165, "GND"),	/* K10 */
+	PINCTRL_PIN(166, "GND"),	/* K11 */
+	PINCTRL_PIN(167, "GND"),	/* K12 */
+	PINCTRL_PIN(168, "GND"),	/* K13 */
+	PINCTRL_PIN(169, "CVDD"),	/* K16 */
+	PINCTRL_PIN(170, "SYM"),	/* K17 */
+	PINCTRL_PIN(171, "SYP"),	/* K18 */
+	PINCTRL_PIN(172, "SXM"),	/* K19 */
+	PINCTRL_PIN(173, "SXP"),	/* K20 */
+	/* Row L */
+	PINCTRL_PIN(174, "DA[18]"),	/* L1 */
+	PINCTRL_PIN(175, "DA[17]"),	/* L2 */
+	PINCTRL_PIN(176, "DA[16]"),	/* L3 */
+	PINCTRL_PIN(177, "DA[15]"),	/* L4 */
+	PINCTRL_PIN(178, "GND"),	/* L5 */
+	PINCTRL_PIN(179, "GND"),	/* L8 */
+	PINCTRL_PIN(180, "GND"),	/* L9 */
+	PINCTRL_PIN(181, "GND"),	/* L10 */
+	PINCTRL_PIN(182, "GND"),	/* L11 */
+	PINCTRL_PIN(183, "GND"),	/* L12 */
+	PINCTRL_PIN(184, "GND"),	/* L13 */
+	PINCTRL_PIN(185, "CVDD"),	/* L16 */
+	PINCTRL_PIN(186, "COL[5]"),	/* L17 */
+	PINCTRL_PIN(187, "COL[7]"),	/* L18 */
+	PINCTRL_PIN(188, "RSTON"),	/* L19 */
+	PINCTRL_PIN(189, "PRSTN"),	/* L20 */
+	/* Row M */
+	PINCTRL_PIN(190, "AD[7]"),	/* M1 */
+	PINCTRL_PIN(191, "DA[14]"),	/* M2 */
+	PINCTRL_PIN(192, "AD[6]"),	/* M3 */
+	PINCTRL_PIN(193, "AD[5]"),	/* M4 */
+	PINCTRL_PIN(194, "CVDD"),	/* M5 */
+	PINCTRL_PIN(195, "GND"),	/* M8 */
+	PINCTRL_PIN(196, "GND"),	/* M9 */
+	PINCTRL_PIN(197, "GND"),	/* M10 */
+	PINCTRL_PIN(198, "GND"),	/* M11 */
+	PINCTRL_PIN(199, "GND"),	/* M12 */
+	PINCTRL_PIN(200, "GND"),	/* M13 */
+	PINCTRL_PIN(201, "GND"),	/* M16 */
+	PINCTRL_PIN(202, "COL[4]"),	/* M17 */
+	PINCTRL_PIN(203, "COL[3]"),	/* M18 */
+	PINCTRL_PIN(204, "COL[6]"),	/* M19 */
+	PINCTRL_PIN(205, "CSN[0]"),	/* M20 */
+	/* Row N */
+	PINCTRL_PIN(206, "DA[13]"),	/* N1 */
+	PINCTRL_PIN(207, "DA[12]"),	/* N2 */
+	PINCTRL_PIN(208, "DA[11]"),	/* N3 */
+	PINCTRL_PIN(209, "AD[3]"),	/* N4 */
+	PINCTRL_PIN(210, "CVDD"),	/* N5 */
+	PINCTRL_PIN(211, "CVDD"),	/* N6 */
+	PINCTRL_PIN(212, "GND"),	/* N8 */
+	PINCTRL_PIN(213, "GND"),	/* N9 */
+	PINCTRL_PIN(214, "GND"),	/* N10 */
+	PINCTRL_PIN(215, "GND"),	/* N11 */
+	PINCTRL_PIN(216, "GND"),	/* N12 */
+	PINCTRL_PIN(217, "GND"),	/* N13 */
+	PINCTRL_PIN(218, "GND"),	/* N15 */
+	PINCTRL_PIN(219, "GND"),	/* N16 */
+	PINCTRL_PIN(220, "XTALO"),	/* N17 */
+	PINCTRL_PIN(221, "COL[0]"),	/* N18 */
+	PINCTRL_PIN(222, "COL[1]"),	/* N19 */
+	PINCTRL_PIN(223, "COL[2]"),	/* N20 */
+	/* Row P */
+	PINCTRL_PIN(224, "AD[4]"),	/* P1 */
+	PINCTRL_PIN(225, "DA[10]"),	/* P2 */
+	PINCTRL_PIN(226, "DA[9]"),	/* P3 */
+	PINCTRL_PIN(227, "BRIGHT"),	/* P4 */
+	PINCTRL_PIN(228, "RVDD"),	/* P5 */
+	PINCTRL_PIN(229, "RVDD"),	/* P6 */
+	PINCTRL_PIN(230, "RVDD"),	/* P15 */
+	PINCTRL_PIN(231, "RVDD"),	/* P16 */
+	PINCTRL_PIN(232, "XTALI"),	/* P17 */
+	PINCTRL_PIN(233, "PLL_VDD"),	/* P18 */
+	PINCTRL_PIN(234, "ROW[6]"),	/* P19 */
+	PINCTRL_PIN(235, "ROW[7]"),	/* P20 */
+	/* Row R */
+	PINCTRL_PIN(236, "AD[2]"),	/* R1 */
+	PINCTRL_PIN(237, "AD[1]"),	/* R2 */
+	PINCTRL_PIN(238, "P[17]"),	/* R3 */
+	PINCTRL_PIN(239, "P[14]"),	/* R4 */
+	PINCTRL_PIN(240, "RVDD"),	/* R5 */
+	PINCTRL_PIN(241, "RVDD"),	/* R6 */
+	PINCTRL_PIN(242, "GND"),	/* R7 */
+	PINCTRL_PIN(243, "CVDD"),	/* R8 */
+	PINCTRL_PIN(244, "CVDD"),	/* R13 */
+	PINCTRL_PIN(245, "GND"),	/* R14 */
+	PINCTRL_PIN(246, "RVDD"),	/* R15 */
+	PINCTRL_PIN(247, "RVDD"),	/* R16 */
+	PINCTRL_PIN(248, "ROW[0]"),	/* R17 */
+	PINCTRL_PIN(249, "ROW[3]"),	/* R18 */
+	PINCTRL_PIN(250, "PLL_GND"),	/* R19 */
+	PINCTRL_PIN(251, "ROW[5]"),	/* R20 */
+	/* Row T */
+	PINCTRL_PIN(252, "DA[8]"),	/* T1 */
+	PINCTRL_PIN(253, "BLANK"),	/* T2 */
+	PINCTRL_PIN(254, "P[13]"),	/* T3 */
+	PINCTRL_PIN(255, "SPCLK"),	/* T4 */
+	PINCTRL_PIN(256, "V_CSYNC"),	/* T5 */
+	PINCTRL_PIN(257, "DD[14]"),	/* T6 */
+	PINCTRL_PIN(258, "GND"),	/* T7 */
+	PINCTRL_PIN(259, "CVDD"),	/* T8 */
+	PINCTRL_PIN(260, "RVDD"),	/* T9 */
+	PINCTRL_PIN(261, "GND"),	/* T10 */
+	PINCTRL_PIN(262, "GND"),	/* T11 */
+	PINCTRL_PIN(263, "RVDD"),	/* T12 */
+	PINCTRL_PIN(264, "CVDD"),	/* T13 */
+	PINCTRL_PIN(265, "GND"),	/* T14 */
+	PINCTRL_PIN(266, "INT[0]"),	/* T15 */
+	PINCTRL_PIN(267, "USBM[1]"),	/* T16 */
+	PINCTRL_PIN(268, "RXD[0]"),	/* T17 */
+	PINCTRL_PIN(269, "TXD[2]"),	/* T18 */
+	PINCTRL_PIN(270, "ROW[2]"),	/* T19 */
+	PINCTRL_PIN(271, "ROW[4]"),	/* T20 */
+	/* Row U */
+	PINCTRL_PIN(272, "AD[0]"),	/* U1 */
+	PINCTRL_PIN(273, "P[15]"),	/* U2 */
+	PINCTRL_PIN(274, "P[10]"),	/* U3 */
+	PINCTRL_PIN(275, "P[7]"),	/* U4 */
+	PINCTRL_PIN(276, "P[6]"),	/* U5 */
+	PINCTRL_PIN(277, "P[4]"),	/* U6 */
+	PINCTRL_PIN(278, "P[0]"),	/* U7 */
+	PINCTRL_PIN(279, "AD[13]"),	/* U8 */
+	PINCTRL_PIN(280, "DA[3]"),	/* U9 */
+	PINCTRL_PIN(281, "DA[0]"),	/* U10 */
+	PINCTRL_PIN(282, "DSRN"),	/* U11 */
+	PINCTRL_PIN(283, "BOOT[1]"),	/* U12 */
+	PINCTRL_PIN(284, "NC"),	/* U13 */
+	PINCTRL_PIN(285, "SSPRX1"),	/* U14 */
+	PINCTRL_PIN(286, "INT[1]"),	/* U15 */
+	PINCTRL_PIN(287, "PWMOUT"),	/* U16 */
+	PINCTRL_PIN(288, "USBM[0]"),	/* U17 */
+	PINCTRL_PIN(289, "RXD[1]"),	/* U18 */
+	PINCTRL_PIN(290, "TXD[1]"),	/* U19 */
+	PINCTRL_PIN(291, "ROW[1]"),	/* U20 */
+	/* Row V */
+	PINCTRL_PIN(292, "P[16]"),	/* V1 */
+	PINCTRL_PIN(293, "P[11]"),	/* V2 */
+	PINCTRL_PIN(294, "P[8]"),	/* V3 */
+	PINCTRL_PIN(295, "DD[15]"),	/* V4 */
+	PINCTRL_PIN(296, "DD[13]"),	/* V5 */
+	PINCTRL_PIN(297, "P[1]"),	/* V6 */
+	PINCTRL_PIN(298, "AD[14]"),	/* V7 */
+	PINCTRL_PIN(299, "AD[12]"),	/* V8 */
+	PINCTRL_PIN(300, "DA[2]"),	/* V9 */
+	PINCTRL_PIN(301, "IDECS0N"),	/* V10 */
+	PINCTRL_PIN(302, "IDEDA[2]"),	/* V11 */
+	PINCTRL_PIN(303, "TDI"),	/* V12 */
+	PINCTRL_PIN(304, "GND"),	/* V13 */
+	PINCTRL_PIN(305, "ASYNC"),	/* V14 */
+	PINCTRL_PIN(306, "SSPTX1"),	/* V15 */
+	PINCTRL_PIN(307, "INT[2]"),	/* V16 */
+	PINCTRL_PIN(308, "RTSN"),	/* V17 */
+	PINCTRL_PIN(309, "USBP[0]"),	/* V18 */
+	PINCTRL_PIN(310, "CTSN"),	/* V19 */
+	PINCTRL_PIN(311, "TXD[0]"),	/* V20 */
+	/* Row W */
+	PINCTRL_PIN(312, "P[12]"),	/* W1 */
+	PINCTRL_PIN(313, "P[9]"),	/* W2 */
+	PINCTRL_PIN(314, "DD[0]"),	/* W3 */
+	PINCTRL_PIN(315, "P[5]"),	/* W4 */
+	PINCTRL_PIN(316, "P[3]"),	/* W5 */
+	PINCTRL_PIN(317, "DA[7]"),	/* W6 */
+	PINCTRL_PIN(318, "DA[5]"),	/* W7 */
+	PINCTRL_PIN(319, "AD[11]"),	/* W8 */
+	PINCTRL_PIN(320, "AD[9]"),	/* W9 */
+	PINCTRL_PIN(321, "IDECS1N"),	/* W10 */
+	PINCTRL_PIN(322, "IDEDA[1]"),	/* W11 */
+	PINCTRL_PIN(323, "TCK"),	/* W12 */
+	PINCTRL_PIN(324, "TMS"),	/* W13 */
+	PINCTRL_PIN(325, "EECLK"),	/* W14 */
+	PINCTRL_PIN(326, "SCLK1"),	/* W15 */
+	PINCTRL_PIN(327, "GRLED"),	/* W16 */
+	PINCTRL_PIN(328, "INT[3]"),	/* W17 */
+	PINCTRL_PIN(329, "SLA[1]"),	/* W18 */
+	PINCTRL_PIN(330, "SLA[0]"),	/* W19 */
+	PINCTRL_PIN(331, "RXD[2]"),	/* W20 */
+	/* Row Y */
+	PINCTRL_PIN(332, "HSYNC"),	/* Y1 */
+	PINCTRL_PIN(333, "DD[1]"),	/* Y2 */
+	PINCTRL_PIN(334, "DD[12]"),	/* Y3 */
+	PINCTRL_PIN(335, "P[2]"),	/* Y4 */
+	PINCTRL_PIN(336, "AD[15]"),	/* Y5 */
+	PINCTRL_PIN(337, "DA[6]"),	/* Y6 */
+	PINCTRL_PIN(338, "DA[4]"),	/* Y7 */
+	PINCTRL_PIN(339, "AD[10]"),	/* Y8 */
+	PINCTRL_PIN(340, "DA[1]"),	/* Y9 */
+	PINCTRL_PIN(341, "AD[8]"),	/* Y10 */
+	PINCTRL_PIN(342, "IDEDA[0]"),	/* Y11 */
+	PINCTRL_PIN(343, "DTRN"),	/* Y12 */
+	PINCTRL_PIN(344, "TDO"),	/* Y13 */
+	PINCTRL_PIN(345, "BOOT[0]"),	/* Y14 */
+	PINCTRL_PIN(346, "EEDAT"),	/* Y15 */
+	PINCTRL_PIN(347, "ASDO"),	/* Y16 */
+	PINCTRL_PIN(348, "SFRM1"),	/* Y17 */
+	PINCTRL_PIN(349, "RDLED"),	/* Y18 */
+	PINCTRL_PIN(350, "USBP[1]"),	/* Y19 */
+	PINCTRL_PIN(351, "ABITCLK"),	/* Y20 */
+};
+
+static const unsigned int ssp_ep9312_pins[] = {
+	285, 306, 326, 348
+};
+
+static const unsigned int ac97_ep9312_pins[] = {
+	77, 95, 305, 347, 351
+};
+
+static const unsigned int pwm_ep9312_pins[] = { 74 };
+
+static const unsigned int gpio1a_ep9312_pins[] = { 74 };
+
+static const unsigned int gpio2a_9312_pins[] = {
+	234, 235, 248, 249, 251, 270, 271, 291
+};
+
+static const unsigned int gpio3a_9312_pins[] = {
+	186, 187, 202, 203, 204, 221, 222, 223
+};
+
+static const unsigned int keypad_9312_pins[] = {
+	186, 187, 202, 203, 204, 221, 222, 223,
+	234, 235, 248, 249, 251, 270, 271, 291
+};
+
+static const unsigned int gpio4a_9312_pins[] = {
+	78, 301, 302, 321, 322, 342
+};
+
+static const unsigned int gpio6a_9312_pins[] = {
+	257, 295, 296, 334
+};
+
+static const unsigned int gpio7a_9312_pins[] = {
+	4, 24, 25, 45, 46, 66, 314, 333
+};
+
+static const unsigned int ide_9312_pins[] = {
+	78, 301, 302, 321, 322, 342,
+	257, 295, 296, 334,
+	4, 24, 25, 45, 46, 66, 314, 333
+};
+
+static const struct ep93xx_pin_group ep9312_pin_groups[] = {
+	{
+		.name = "ssp",
+		.pins = ssp_ep9312_pins,
+		.num_pins = ARRAY_SIZE(ssp_ep9312_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONSSP,
+	},
+	{
+		.name = "i2s_on_ssp",
+		.pins = ssp_ep9312_pins,
+		.num_pins = ARRAY_SIZE(ssp_ep9312_pins),
+		.value = EP93XX_SYSCON_DEVCFG_I2SONSSP,
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONSSP,
+	},
+	{
+		.name = "pwm1",
+		.pins = pwm_ep9312_pins,
+		.num_pins = ARRAY_SIZE(pwm_ep9312_pins),
+		.value = EP93XX_SYSCON_DEVCFG_PONG,
+		.mask = EP93XX_SYSCON_DEVCFG_PONG,
+	},
+	{
+		.name = "gpio1agrp",
+		.pins = gpio1a_ep9312_pins,
+		.num_pins = ARRAY_SIZE(gpio1a_ep9312_pins),
+		/* Conflict with PWM1 */
+		.mask = EP93XX_SYSCON_DEVCFG_PONG,
+	},
+	{
+		.name = "ac97",
+		.pins = ac97_ep9312_pins,
+		.num_pins = ARRAY_SIZE(ac97_ep9312_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONAC97,
+	},
+	{
+		.name = "i2s_on_ac97",
+		.pins = ac97_ep9312_pins,
+		.num_pins = ARRAY_SIZE(ac97_ep9312_pins),
+		.value = EP93XX_SYSCON_DEVCFG_I2SONAC97,
+		.mask = EP93XX_SYSCON_DEVCFG_I2SONAC97,
+	},
+	{
+		.name = "rasteronsdram0grp",
+		.pins = raster_on_sdram0_pins,
+		.num_pins = ARRAY_SIZE(raster_on_sdram0_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_RASONP3,
+	},
+	{
+		.name = "rasteronsdram3grp",
+		.pins = raster_on_sdram3_pins,
+		.num_pins = ARRAY_SIZE(raster_on_sdram3_pins),
+		.value = EP93XX_SYSCON_DEVCFG_RASONP3,
+		.mask = EP93XX_SYSCON_DEVCFG_RASONP3,
+	},
+	{
+		.name = "gpio2agrp",
+		.pins = gpio2a_9312_pins,
+		.num_pins = ARRAY_SIZE(gpio2a_9312_pins),
+		.value = EP93XX_SYSCON_DEVCFG_GONK,
+		.mask = EP93XX_SYSCON_DEVCFG_GONK,
+	},
+	{
+		.name = "gpio3agrp",
+		.pins = gpio3a_9312_pins,
+		.num_pins = ARRAY_SIZE(gpio3a_9312_pins),
+		.value = EP93XX_SYSCON_DEVCFG_GONK,
+		.mask = EP93XX_SYSCON_DEVCFG_GONK,
+	},
+	{
+		.name = "keypadgrp",
+		.pins = keypad_9307_pins,
+		.num_pins = ARRAY_SIZE(keypad_9307_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_GONK,
+	},
+	{
+		.name = "gpio4agrp",
+		.pins = gpio4a_9312_pins,
+		.num_pins = ARRAY_SIZE(gpio4a_9312_pins),
+		.value = EP93XX_SYSCON_DEVCFG_EONIDE,
+		.mask = EP93XX_SYSCON_DEVCFG_EONIDE,
+	},
+	{
+		.name = "gpio6agrp",
+		.pins = gpio6a_9312_pins,
+		.num_pins = ARRAY_SIZE(gpio6a_9312_pins),
+		.value = EP93XX_SYSCON_DEVCFG_GONIDE,
+		.mask = EP93XX_SYSCON_DEVCFG_GONIDE,
+	},
+	{
+		.name = "gpio7agrp",
+		.pins = gpio7a_9312_pins,
+		.num_pins = ARRAY_SIZE(gpio7a_9312_pins),
+		.value = EP93XX_SYSCON_DEVCFG_HONIDE,
+		.mask = EP93XX_SYSCON_DEVCFG_HONIDE,
+	},
+	{
+		.name = "idegrp",
+		.pins = ide_9312_pins,
+		.num_pins = ARRAY_SIZE(ide_9312_pins),
+		.mask = EP93XX_SYSCON_DEVCFG_EONIDE | EP93XX_SYSCON_DEVCFG_GONIDE |
+			EP93XX_SYSCON_DEVCFG_HONIDE,
+	},
+};
+
+static int ep93xx_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct ep93xx_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	switch (pmx->model) {
+	case EP93XX_9301_PINCTRL:
+		return ARRAY_SIZE(ep9301_pin_groups);
+	case EP93XX_9307_PINCTRL:
+		return ARRAY_SIZE(ep9307_pin_groups);
+	case EP93XX_9312_PINCTRL:
+		return ARRAY_SIZE(ep9312_pin_groups);
+	}
+
+	return 0;
+}
+
+static const char *ep93xx_get_group_name(struct pinctrl_dev *pctldev,
+					 unsigned int selector)
+{
+	struct ep93xx_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	switch (pmx->model) {
+	case EP93XX_9301_PINCTRL:
+		return ep9301_pin_groups[selector].name;
+	case EP93XX_9307_PINCTRL:
+		return ep9307_pin_groups[selector].name;
+	case EP93XX_9312_PINCTRL:
+		return ep9312_pin_groups[selector].name;
+	}
+
+	return NULL;
+}
+
+static int ep93xx_get_group_pins(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const unsigned int **pins,
+				 unsigned int *num_pins)
+{
+	struct ep93xx_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	switch (pmx->model) {
+	case EP93XX_9301_PINCTRL:
+		*pins = ep9301_pin_groups[selector].pins;
+		*num_pins = ep9301_pin_groups[selector].num_pins;
+		break;
+	case EP93XX_9307_PINCTRL:
+		*pins = ep9307_pin_groups[selector].pins;
+		*num_pins = ep9307_pin_groups[selector].num_pins;
+		break;
+	case EP93XX_9312_PINCTRL:
+		*pins = ep9312_pin_groups[selector].pins;
+		*num_pins = ep9312_pin_groups[selector].num_pins;
+		break;
+	}
+
+	return 0;
+}
+
+static void ep93xx_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+				unsigned int offset)
+{
+	seq_printf(s, " " DRIVER_NAME);
+}
+
+static const struct pinctrl_ops ep93xx_pctrl_ops = {
+	.get_groups_count = ep93xx_get_groups_count,
+	.get_group_name = ep93xx_get_group_name,
+	.get_group_pins = ep93xx_get_group_pins,
+	.pin_dbg_show = ep93xx_pin_dbg_show,
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
+	.dt_free_map = pinconf_generic_dt_free_map,
+};
+
+/**
+ * struct ep93xx_pmx_func - describes ep93xx pinmux functions
+ * @name: the name of this specific function
+ * @groups: corresponding pin groups
+ */
+struct ep93xx_pmx_func {
+	const char *name;
+	const char * const *groups;
+	const unsigned int num_groups;
+};
+
+static const char * const spigrps[] = { "ssp" };
+static const char * const ac97grps[] = { "ac97" };
+static const char * const i2sgrps[] = { "i2s_on_ssp", "i2s_on_ac97" };
+static const char * const pwm1grps[] = { "pwm1" };
+static const char * const gpio1grps[] = { "gpio1agrp" };
+static const char * const gpio2grps[] = { "gpio2agrp" };
+static const char * const gpio3grps[] = { "gpio3agrp" };
+static const char * const gpio4grps[] = { "gpio4agrp" };
+static const char * const gpio6grps[] = { "gpio6agrp" };
+static const char * const gpio7grps[] = { "gpio7agrp" };
+static const char * const rastergrps[] = { "rasteronsdram0grp", "rasteronsdram3grp"};
+static const char * const keypadgrps[] = { "keypadgrp"};
+static const char * const idegrps[] = { "idegrp"};
+
+
+static const struct ep93xx_pmx_func ep93xx_pmx_functions[] = {
+	{
+		.name = "spi",
+		.groups = spigrps,
+		.num_groups = ARRAY_SIZE(spigrps),
+	},
+	{
+		.name = "ac97",
+		.groups = ac97grps,
+		.num_groups = ARRAY_SIZE(ac97grps),
+	},
+	{
+		.name = "i2s",
+		.groups = i2sgrps,
+		.num_groups = ARRAY_SIZE(i2sgrps),
+	},
+	{
+		.name = "pwm",
+		.groups = pwm1grps,
+		.num_groups = ARRAY_SIZE(pwm1grps),
+	},
+	{
+		.name = "keypad",
+		.groups = keypadgrps,
+		.num_groups = ARRAY_SIZE(keypadgrps),
+	},
+	{
+		.name = "pata",
+		.groups = idegrps,
+		.num_groups = ARRAY_SIZE(idegrps),
+	},
+	{
+		.name = "lcd",
+		.groups = rastergrps,
+		.num_groups = ARRAY_SIZE(rastergrps),
+	},
+	{
+		.name = "gpio1",
+		.groups = gpio1grps,
+		.num_groups = ARRAY_SIZE(gpio1grps),
+	},
+	{
+		.name = "gpio2",
+		.groups = gpio2grps,
+		.num_groups = ARRAY_SIZE(gpio2grps),
+	},
+	{
+		.name = "gpio3",
+		.groups = gpio3grps,
+		.num_groups = ARRAY_SIZE(gpio3grps),
+	},
+	{
+		.name = "gpio4",
+		.groups = gpio4grps,
+		.num_groups = ARRAY_SIZE(gpio4grps),
+	},
+	{
+		.name = "gpio6",
+		.groups = gpio6grps,
+		.num_groups = ARRAY_SIZE(gpio6grps),
+	},
+	{
+		.name = "gpio7",
+		.groups = gpio7grps,
+		.num_groups = ARRAY_SIZE(gpio7grps),
+	},
+};
+
+static int ep93xx_pmx_set_mux(struct pinctrl_dev *pctldev,
+			      unsigned int selector,
+			      unsigned int group)
+{
+	struct ep93xx_pmx *pmx;
+	const struct ep93xx_pmx_func *func;
+	const struct ep93xx_pin_group *grp;
+	u32 before, after, expected;
+	unsigned long tmp;
+	int i;
+
+	pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	func = &ep93xx_pmx_functions[selector];
+
+	switch (pmx->model) {
+	case EP93XX_9301_PINCTRL:
+		grp = &ep9301_pin_groups[group];
+		break;
+	case EP93XX_9307_PINCTRL:
+		grp = &ep9307_pin_groups[group];
+		break;
+	case EP93XX_9312_PINCTRL:
+		grp = &ep9312_pin_groups[group];
+		break;
+	}
+
+	dev_dbg(pmx->dev,
+		"ACTIVATE function \"%s\" with group \"%s\" (mask=0x%x, value=0x%x)\n",
+		func->name, grp->name, grp->mask, grp->value);
+
+	regmap_read(pmx->map, EP93XX_SYSCON_DEVCFG, &before);
+	ep93xx_swlocked_update_bits(EP93XX_SYSCON_DEVCFG,
+								grp->mask, grp->value);
+	regmap_read(pmx->map, EP93XX_SYSCON_DEVCFG, &after);
+
+	dev_dbg(pmx->dev,
+		"before=0x%x, after=0x%x, mask=0x%lx\n",
+		before, after, PADS_MASK);
+
+	/* Which bits changed */
+	before &= PADS_MASK;
+	after &= PADS_MASK;
+	expected = before & ~grp->mask;
+	expected |= grp->value;
+	expected &= PADS_MASK;
+
+	/* Print changed states */
+	tmp = expected ^ after;
+	for_each_set_bit(i, &tmp, PADS_MAXBIT) {
+		bool enabled = expected & BIT(i);
+
+		dev_err(pmx->dev,
+			    "pin group %s could not be %s: probably a hardware limitation\n",
+			    ep93xx_padgroups[i], enabled ? "enabled" : "disabled");
+		dev_err(pmx->dev,
+				"DeviceCfg before: %08x, after %08x, expected %08x\n",
+				before, after, expected);
+	}
+
+	return tmp ? -EINVAL : 0;
+};
+
+static int ep93xx_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(ep93xx_pmx_functions);
+}
+
+static const char *ep93xx_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					    unsigned int selector)
+{
+	return ep93xx_pmx_functions[selector].name;
+}
+
+static int ep93xx_pmx_get_groups(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const char * const **groups,
+				 unsigned int * const num_groups)
+{
+	*groups = ep93xx_pmx_functions[selector].groups;
+	*num_groups = ep93xx_pmx_functions[selector].num_groups;
+	return 0;
+}
+
+static const struct pinmux_ops ep93xx_pmx_ops = {
+	.get_functions_count = ep93xx_pmx_get_funcs_count,
+	.get_function_name = ep93xx_pmx_get_func_name,
+	.get_function_groups = ep93xx_pmx_get_groups,
+	.set_mux = ep93xx_pmx_set_mux,
+};
+
+static struct pinctrl_desc ep93xx_pmx_desc = {
+	.name = DRIVER_NAME,
+	.pctlops = &ep93xx_pctrl_ops,
+	.pmxops = &ep93xx_pmx_ops,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id ep93xx_pinctrl_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-pinctrl", .data = (void *)EP93XX_9301_PINCTRL},
+	{ .compatible = "cirrus,ep9307-pinctrl", .data = (void *)EP93XX_9307_PINCTRL},
+	{ .compatible = "cirrus,ep9312-pinctrl", .data = (void *)EP93XX_9312_PINCTRL},
+	{},
+};
+
+static int ep93xx_pmx_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match = of_match_node(ep93xx_pinctrl_of_ids, pdev->dev.of_node);
+	struct ep93xx_pmx *pmx;
+	struct regmap *map;
+	struct device *dev = &pdev->dev;
+	struct device *parent;
+
+	/* Create state holders etc for this driver */
+	pmx = devm_kzalloc(&pdev->dev, sizeof(*pmx), GFP_KERNEL);
+	if (!pmx)
+		return -ENOMEM;
+
+	pmx->dev = &pdev->dev;
+	parent = dev->parent;
+	if (!parent) {
+		dev_err(dev, "no parent to pin controller\n");
+		return -ENODEV;
+	}
+
+	map = syscon_node_to_regmap(parent->of_node);
+	if (IS_ERR(map)) {
+		dev_err(dev, "no syscon regmap\n");
+		return PTR_ERR(map);
+	}
+	pmx->map = map;
+
+	pmx->model = (int) match->data;
+	switch (pmx->model) {
+	case EP93XX_9301_PINCTRL:
+		ep93xx_pmx_desc.pins = ep9301_pins;
+		ep93xx_pmx_desc.npins = ARRAY_SIZE(ep9301_pins);
+		dev_info(dev, "detected 9301/9302 chip variant\n");
+		break;
+	case EP93XX_9307_PINCTRL:
+		ep93xx_pmx_desc.pins = ep9307_pins;
+		ep93xx_pmx_desc.npins = ARRAY_SIZE(ep9307_pins);
+		dev_info(dev, "detected 9307 chip variant\n");
+		break;
+	case EP93XX_9312_PINCTRL:
+		ep93xx_pmx_desc.pins = ep9312_pins;
+		ep93xx_pmx_desc.npins = ARRAY_SIZE(ep9312_pins);
+		dev_info(dev, "detected 9312/9315 chip variant\n");
+		break;
+	}
+
+	pmx->pctl = devm_pinctrl_register(dev, &ep93xx_pmx_desc, pmx);
+	if (IS_ERR(pmx->pctl)) {
+		dev_err(dev, "could not register pinmux driver\n");
+		return PTR_ERR(pmx->pctl);
+	}
+
+	dev_info(dev, "initialized ep93xx pin control driver\n");
+
+	return 0;
+};
+
+static struct platform_driver ep93xx_pmx_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = ep93xx_pinctrl_of_ids,
+	},
+	.probe = ep93xx_pmx_probe,
+};
+
+static int __init ep93xx_pmx_init(void)
+{
+	return platform_driver_register(&ep93xx_pmx_driver);
+}
+arch_initcall(ep93xx_pmx_init);
-- 
2.39.2

