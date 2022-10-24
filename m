Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6603609F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJXK5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJXK5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:57:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9A62C665;
        Mon, 24 Oct 2022 03:57:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pb15so7839485pjb.5;
        Mon, 24 Oct 2022 03:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygB/99gkhB2Wgp54BRop7rTRTw1oOWgAk2ti784/Vas=;
        b=b+ZBi2ZBmUb96QBWzJon85pHTDol74beKzebiaSQXt8Yqq7tEJ62cFUiJK5SjhyGnK
         p1IuTzQOU1xcvfRe999dMR4SFlB2oasxgfiAWrjKmK6SR/uJSmY4miJpcZU+CJZBDLwP
         3xMPC1mbHdK1obgT+vnsgI3KuJti+YF8lEUIqG4AVYT8s7NBUV8ECCkyeiN2tgKm3MXR
         dya3KfLPCjAwmkQWtNdQdVihohE0Ek0o8xgPyFYVSrdrvCtHno+Tkzovkcfsfvf0bxpp
         +RwVqB6Xf4ictFc9Xir1Bv3t63JoEb7kByx6gAoV4U7UqNZNso/SaS/CHpvvaCmkGOn2
         OE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygB/99gkhB2Wgp54BRop7rTRTw1oOWgAk2ti784/Vas=;
        b=cuWWVpTN/FJfU2LKyhR4M36jcfyW9/LvnRV6I7UCiGByqy1ypuaMdjFu1LG/Tcl1+F
         aEKCtnUCvL4dqmVPDinC7FHdjXSdk3hKbP+r9Fsu71mmHst1MuVvfn/HfnoPTUSilxNY
         aDZhvc3sI2L71x8ptNBF+nD8KqWTM1Y7Hx1vbEz/p/myCYv8gqlG+aM0rqoVakiFQujU
         hwIvIq8Xo6qsXymPUBPQgUiJzv3Jv2/VlJoK8CTFQCVgrFsjJ3StFCIOOZ/4zyMKSPpV
         LE0m9Kl06FrD7yNIyZm4/4AqBGBvoPLsbUPFikRdPNskw08i3uOvp1TV0Meu1OtdN1yj
         O2ow==
X-Gm-Message-State: ACrzQf2j5pIYHY8JB6gBJUDwpSUEdFfX2r2Ay/cf13ebE0CsTacJNLZQ
        YfUPPk6xUZDNMKbVUg8eTpY=
X-Google-Smtp-Source: AMsMyM4cmvw09CEAUFyeWegdS5Zhalzi9Kprn6NwEnypevb+/Fw+m9W6TIAOzoQUvNoZasRx+frMwg==
X-Received: by 2002:a17:902:8c92:b0:178:29d4:600f with SMTP id t18-20020a1709028c9200b0017829d4600fmr33315991plo.40.1666609022630;
        Mon, 24 Oct 2022 03:57:02 -0700 (PDT)
Received: from RD-3580-24288.rt.l (111-82-141-7.emome-ip.hinet.net. [111.82.141.7])
        by smtp.gmail.com with ESMTPSA id a15-20020a631a4f000000b0045751ef6423sm1366696pgm.87.2022.10.24.03.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:57:02 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 2/3] power: supply: rt9467: Add Richtek RT9467 charger driver
Date:   Mon, 24 Oct 2022 18:55:47 +0800
Message-Id: <8074e52edf25327e6459990707b6eee839b2d85a.1666633143.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666633143.git.chiaen_wu@richtek.com>
References: <cover.1666633143.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiaEn Wu <chiaen_wu@richtek.com>

RT9467 is a switch-mode single cell Li-Ion/Li-Polymer battery charger
for portable applications.

It integrates a synchronous PWM controller, power MOSFETs,
input current sensing and regulation, high-accuracy voltage regulation,
and charge termination. The charge current is regulated through
integrated sensing resistors.

The RT9467 also features USB On-The-Go (OTG) support. It also integrates
D+/D- pin for USB host/charging port detection.

Co-developed-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 drivers/power/supply/Kconfig          |   19 +
 drivers/power/supply/Makefile         |    1 +
 drivers/power/supply/rt9467-charger.c | 1282 +++++++++++++++++++++++++++++++++
 3 files changed, 1302 insertions(+)
 create mode 100644 drivers/power/supply/rt9467-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 0bbfe6a..2208ab6 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -793,6 +793,25 @@ config CHARGER_RT9455
 	help
 	  Say Y to enable support for Richtek RT9455 battery charger.
 
+config CHARGER_RT9467
+	tristate "Richtek RT9467 Battery Charger Driver"
+	depends on I2C && GPIOLIB && REGULATOR
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	select LINEAR_RANGES
+	help
+	  Say Y here to enable RT9467 Battery Charger.
+	  RT9467 is a switch-mode single cell Li-Ion/Li-Polymer battery charger
+	  for portable applications. It integrates a synchronous PWM controller,
+	  power MOSFETs, input current sensing and regulation, high-accuracy
+	  voltage regulation, and charge termination. The charge current is
+	  regulated through integrated sensing resistors. It also features
+	  USB On-The-Go (OTG) support and integrates D+/D- pin for USB
+	  host/charging port detection.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called "rt9467-charger".
+
 config CHARGER_CROS_USBPD
 	tristate "ChromeOS EC based USBPD charger"
 	depends on CROS_USBPD_NOTIFY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 0ee8653..9e9a603 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_BATTERY_MAX1721X)	+= max1721x_battery.o
 obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
 obj-$(CONFIG_BATTERY_RT5033)	+= rt5033_battery.o
 obj-$(CONFIG_CHARGER_RT9455)	+= rt9455_charger.o
+obj-$(CONFIG_CHARGER_RT9467)	+= rt9467-charger.o
 obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
 obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
new file mode 100644
index 0000000..96ad0d7
--- /dev/null
+++ b/drivers/power/supply/rt9467-charger.c
@@ -0,0 +1,1282 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Richtek Technology Corp.
+ *
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ *         ChiaEn Wu <chiaen_wu@richtek.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/linear_range.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/units.h>
+#include <linux/sysfs.h>
+
+#define RT9467_REG_CORE_CTRL0		0x00
+#define RT9467_REG_CHG_CTRL1		0x01
+#define RT9467_REG_CHG_CTRL2		0x02
+#define RT9467_REG_CHG_CTRL3		0x03
+#define RT9467_REG_CHG_CTRL4		0x04
+#define RT9467_REG_CHG_CTRL5		0x05
+#define RT9467_REG_CHG_CTRL6		0x06
+#define RT9467_REG_CHG_CTRL7		0x07
+#define RT9467_REG_CHG_CTRL8		0x08
+#define RT9467_REG_CHG_CTRL9		0x09
+#define RT9467_REG_CHG_CTRL10		0x0A
+#define RT9467_REG_CHG_CTRL12		0x0C
+#define RT9467_REG_CHG_CTRL13		0x0D
+#define RT9467_REG_CHG_CTRL14		0x0E
+#define RT9467_REG_CHG_ADC		0x11
+#define RT9467_REG_CHG_DPDM1		0x12
+#define RT9467_REG_CHG_DPDM2		0x13
+#define RT9467_REG_DEVICE_ID		0x40
+#define RT9467_REG_CHG_STAT		0x42
+#define RT9467_REG_ADC_DATA_H		0x44
+#define RT9467_REG_CHG_STATC		0x50
+#define RT9467_REG_CHG_IRQ1		0x53
+#define RT9467_REG_CHG_STATC_CTRL	0x60
+#define RT9467_REG_CHG_IRQ1_CTRL	0x63
+
+#define RT9467_MASK_PWR_RDY		BIT(7)
+#define RT9467_MASK_MIVR_STAT		BIT(6)
+#define RT9467_MASK_OTG_CSEL		GENMASK(2, 0)
+#define RT9467_MASK_OTG_VSEL		GENMASK(7, 2)
+#define RT9467_MASK_OTG_EN		BIT(0)
+#define RT9467_MASK_ADC_IN_SEL		GENMASK(7, 4)
+#define RT9467_MASK_ADC_START		BIT(0)
+
+#define RT9467_NUM_IRQ_REGS		4
+#define RT9467_ICHG_MIN_uA		100000
+#define RT9467_ICHG_MAX_uA		5000000
+#define RT9467_CV_MAX_uV		4710000
+#define RT9467_OTG_MIN_uV		4425000
+#define RT9467_OTG_MAX_uV		5825000
+#define RT9467_OTG_STEP_uV		25000
+#define RT9467_NUM_VOTG			(RT9467_OTG_MAX_uV - RT9467_OTG_MIN_uV + 1)
+#define RT9467_AICLVTH_GAP_uV		200000
+#define RT9467_ADCCONV_TIME_MS		35
+
+#define RT9466_VID			0x8
+#define RT9467_VID			0x9
+
+/* IRQ number */
+#define RT9467_IRQ_TS_STATC	0
+#define RT9467_IRQ_CHG_FAULT	1
+#define RT9467_IRQ_CHG_STATC	2
+#define RT9467_IRQ_CHG_TMR	3
+#define RT9467_IRQ_CHG_BATABS	4
+#define RT9467_IRQ_CHG_ADPBAD	5
+#define RT9467_IRQ_CHG_RVP	6
+#define RT9467_IRQ_OTP		7
+
+#define RT9467_IRQ_CHG_AICLM	8
+#define RT9467_IRQ_CHG_ICHGM	9
+#define RT9467_IRQ_WDTMR	11
+#define RT9467_IRQ_SSFINISH	12
+#define RT9467_IRQ_CHG_RECHG	13
+#define RT9467_IRQ_CHG_TERM	14
+#define RT9467_IRQ_CHG_IEOC	15
+
+#define RT9467_IRQ_ADC_DONE	16
+#define RT9467_IRQ_PUMPX_DONE	17
+#define RT9467_IRQ_BST_BATUV	21
+#define RT9467_IRQ_BST_MIDOV	22
+#define RT9467_IRQ_BST_OLP	23
+
+#define RT9467_IRQ_ATTACH	24
+#define RT9467_IRQ_DETACH	25
+#define RT9467_IRQ_HVDCP_DET	29
+#define RT9467_IRQ_CHGDET	30
+#define RT9467_IRQ_DCDT		31
+
+enum rt9467_fields {
+	/* RT9467_REG_CORE_CTRL0 */
+	F_RST = 0,
+	/* RT9467_REG_CHG_CTRL1 */
+	F_HZ, F_OTG_PIN_EN, F_OPA_MODE,
+	/* RT9467_REG_CHG_CTRL2 */
+	F_SHIP_MODE, F_TE, F_IINLMTSEL, F_CFO_EN, F_CHG_EN,
+	/* RT9467_REG_CHG_CTRL3 */
+	F_IAICR, F_ILIM_EN,
+	/* RT9467_REG_CHG_CTRL4 */
+	F_VOREG,
+	/* RT9467_REG_CHG_CTRL6 */
+	F_VMIVR,
+	/* RT9467_REG_CHG_CTRL7 */
+	F_ICHG,
+	/* RT9467_REG_CHG_CTRL8 */
+	F_IPREC,
+	/* RT9467_REG_CHG_CTRL9 */
+	F_IEOC,
+	/* RT9467_REG_CHG_CTRL12 */
+	F_WT_FC,
+	/* RT9467_REG_CHG_CTRL13 */
+	F_OCP,
+	/* RT9467_REG_CHG_CTRL14 */
+	F_AICL_MEAS, F_AICL_VTH,
+	/* RT9467_REG_CHG_DPDM1 */
+	F_USBCHGEN,
+	/* RT9467_REG_CHG_DPDM2 */
+	F_USB_STATUS,
+	/* RT9467_REG_DEVICE_ID */
+	F_VENDOR,
+	/* RT9467_REG_CHG_STAT */
+	F_CHG_STAT,
+	/* RT9467_REG_CHG_STATC */
+	F_PWR_RDY, F_CHG_MIVR,
+	F_MAX_FIELDS
+};
+
+static const struct regmap_irq rt9467_irqs[] = {
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_TS_STATC, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHG_FAULT, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHG_STATC, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHG_TMR, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHG_BATABS, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHG_ADPBAD, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHG_RVP, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_OTP, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHG_AICLM, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHG_ICHGM, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_WDTMR, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_SSFINISH, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHG_RECHG, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHG_TERM, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHG_IEOC, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_ADC_DONE, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_PUMPX_DONE, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_BST_BATUV, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_BST_MIDOV, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_BST_OLP, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_ATTACH, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_DETACH, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_HVDCP_DET, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_CHGDET, 8),
+	REGMAP_IRQ_REG_LINE(RT9467_IRQ_DCDT, 8)
+};
+
+static const struct regmap_irq_chip rt9467_irq_chip = {
+	.name = "rt9467-irqs",
+	.status_base = RT9467_REG_CHG_IRQ1,
+	.mask_base = RT9467_REG_CHG_IRQ1_CTRL,
+	.num_regs = RT9467_NUM_IRQ_REGS,
+	.irqs = rt9467_irqs,
+	.num_irqs = ARRAY_SIZE(rt9467_irqs),
+};
+
+enum rt9467_ranges {
+	RT9467_RANGE_IAICR = 0,
+	RT9467_RANGE_VOREG,
+	RT9467_RANGE_VMIVR,
+	RT9467_RANGE_ICHG,
+	RT9467_RANGE_IPREC,
+	RT9467_RANGE_IEOC,
+	RT9467_RANGE_AICL_VTH,
+	RT9467_RANGES_MAX
+};
+
+static const struct linear_range rt9467_ranges[RT9467_RANGES_MAX] = {
+	LINEAR_RANGE_IDX(RT9467_RANGE_IAICR, 100000, 0x0, 0x3F, 50000),
+	LINEAR_RANGE_IDX(RT9467_RANGE_VOREG, 3900000, 0x0, 0x51, 10000),
+	LINEAR_RANGE_IDX(RT9467_RANGE_VMIVR, 3900000, 0x0, 0x5F, 100000),
+	LINEAR_RANGE_IDX(RT9467_RANGE_ICHG, 900000, 0x08, 0x31, 100000),
+	LINEAR_RANGE_IDX(RT9467_RANGE_IPREC, 100000, 0x0, 0x0F, 50000),
+	LINEAR_RANGE_IDX(RT9467_RANGE_IEOC, 100000, 0x0, 0x0F, 50000),
+	LINEAR_RANGE_IDX(RT9467_RANGE_AICL_VTH, 4100000, 0x0, 0x7, 100000),
+};
+
+static const struct reg_field rt9467_chg_fields[] = {
+	[F_RST]			= REG_FIELD(RT9467_REG_CORE_CTRL0, 7, 7),
+	[F_HZ]			= REG_FIELD(RT9467_REG_CHG_CTRL1, 2, 2),
+	[F_OTG_PIN_EN]		= REG_FIELD(RT9467_REG_CHG_CTRL1, 1, 1),
+	[F_OPA_MODE]		= REG_FIELD(RT9467_REG_CHG_CTRL1, 0, 0),
+	[F_SHIP_MODE]		= REG_FIELD(RT9467_REG_CHG_CTRL2, 7, 7),
+	[F_TE]			= REG_FIELD(RT9467_REG_CHG_CTRL2, 4, 4),
+	[F_IINLMTSEL]		= REG_FIELD(RT9467_REG_CHG_CTRL2, 2, 3),
+	[F_CFO_EN]		= REG_FIELD(RT9467_REG_CHG_CTRL2, 1, 1),
+	[F_CHG_EN]		= REG_FIELD(RT9467_REG_CHG_CTRL2, 0, 0),
+	[F_IAICR]		= REG_FIELD(RT9467_REG_CHG_CTRL3, 2, 7),
+	[F_ILIM_EN]		= REG_FIELD(RT9467_REG_CHG_CTRL3, 0, 0),
+	[F_VOREG]		= REG_FIELD(RT9467_REG_CHG_CTRL4, 1, 7),
+	[F_VMIVR]		= REG_FIELD(RT9467_REG_CHG_CTRL6, 1, 7),
+	[F_ICHG]		= REG_FIELD(RT9467_REG_CHG_CTRL7, 2, 7),
+	[F_IPREC]		= REG_FIELD(RT9467_REG_CHG_CTRL8, 0, 3),
+	[F_IEOC]		= REG_FIELD(RT9467_REG_CHG_CTRL9, 4, 7),
+	[F_WT_FC]		= REG_FIELD(RT9467_REG_CHG_CTRL12, 5, 7),
+	[F_OCP]			= REG_FIELD(RT9467_REG_CHG_CTRL13, 2, 2),
+	[F_AICL_MEAS]		= REG_FIELD(RT9467_REG_CHG_CTRL14, 7, 7),
+	[F_AICL_VTH]		= REG_FIELD(RT9467_REG_CHG_CTRL14, 0, 2),
+	[F_USBCHGEN]		= REG_FIELD(RT9467_REG_CHG_DPDM1, 7, 7),
+	[F_USB_STATUS]		= REG_FIELD(RT9467_REG_CHG_DPDM2, 0, 2),
+	[F_VENDOR]		= REG_FIELD(RT9467_REG_DEVICE_ID, 4, 7),
+	[F_CHG_STAT]		= REG_FIELD(RT9467_REG_CHG_STAT, 6, 7),
+	[F_PWR_RDY]		= REG_FIELD(RT9467_REG_CHG_STATC, 7, 7),
+	[F_CHG_MIVR]		= REG_FIELD(RT9467_REG_CHG_STATC, 6, 6),
+};
+
+enum {
+	RT9467_STAT_READY = 0,
+	RT9467_STAT_PROGRESS,
+	RT9467_STAT_CHARGE_DONE,
+	RT9467_STAT_FAULT
+};
+
+enum rt9467_adc_chan {
+	RT9467_ADC_VBUS_DIV5 = 0,
+	RT9467_ADC_VBUS_DIV2,
+	RT9467_ADC_VSYS,
+	RT9467_ADC_VBAT,
+	RT9467_ADC_TS_BAT,
+	RT9467_ADC_IBUS,
+	RT9467_ADC_IBAT,
+	RT9467_ADC_REGN,
+	RT9467_ADC_TEMP_JC
+};
+
+enum rt9467_chg_type {
+	RT9467_CHG_TYPE_NOVBUS = 0,
+	RT9467_CHG_TYPE_UNDER_GOING,
+	RT9467_CHG_TYPE_SDP,
+	RT9467_CHG_TYPE_SDPNSTD,
+	RT9467_CHG_TYPE_DCP,
+	RT9467_CHG_TYPE_CDP,
+	RT9467_CHG_TYPE_MAX
+};
+
+enum rt9467_iin_limit_sel {
+	RT9467_IINLMTSEL_3_2A = 0,
+	RT9467_IINLMTSEL_CHG_TYP,
+	RT9467_IINLMTSEL_AICR,
+	RT9467_IINLMTSEL_LOWER_LEVEL, /* lower of above three */
+};
+
+struct rt9467_chg_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regmap_field *rm_field[F_MAX_FIELDS];
+	struct regmap_irq_chip_data *irq_chip_data;
+	struct power_supply *psy;
+	struct mutex adc_lock;
+	struct mutex attach_lock;
+	struct mutex ichg_ieoc_lock;
+	struct regulator_dev *rdev;
+	struct completion aicl_done;
+	enum power_supply_usb_type psy_usb_type;
+	unsigned int old_stat;
+	unsigned int vid;
+	int ichg_ua;
+	int ieoc_ua;
+};
+
+static int rt9467_otg_of_parse_cb(struct device_node *of,
+				  const struct regulator_desc *desc,
+				  struct regulator_config *cfg)
+{
+	struct rt9467_chg_data *data = cfg->driver_data;
+
+	cfg->ena_gpiod = fwnode_gpiod_get_index(of_fwnode_handle(of),
+						"enable", 0, GPIOD_OUT_LOW |
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+						desc->name);
+	if (IS_ERR(cfg->ena_gpiod)) {
+		cfg->ena_gpiod = NULL;
+		return 0;
+	}
+
+	return regmap_field_write(data->rm_field[F_OTG_PIN_EN], 1);
+}
+
+static const struct regulator_ops rt9467_otg_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
+};
+
+static const u32 rt9467_otg_microamp[] = {
+	500000, 700000, 1100000, 1300000, 1800000, 2100000, 2400000, 3000000
+};
+
+static const struct regulator_desc rt9467_otg_desc = {
+	.name = "rt9476-usb-otg-vbus",
+	.of_match = "usb-otg-vbus-regulator",
+	.of_parse_cb = rt9467_otg_of_parse_cb,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.min_uV = RT9467_OTG_MIN_uV,
+	.uV_step = RT9467_OTG_STEP_uV,
+	.n_voltages = RT9467_NUM_VOTG,
+	.curr_table = rt9467_otg_microamp,
+	.n_current_limits = ARRAY_SIZE(rt9467_otg_microamp),
+	.csel_reg = RT9467_REG_CHG_CTRL10,
+	.csel_mask = RT9467_MASK_OTG_CSEL,
+	.vsel_reg = RT9467_REG_CHG_CTRL5,
+	.vsel_mask = RT9467_MASK_OTG_VSEL,
+	.enable_reg = RT9467_REG_CHG_CTRL1,
+	.enable_mask = RT9467_MASK_OTG_EN,
+	.ops = &rt9467_otg_regulator_ops,
+};
+
+static int rt9467_register_otg_regulator(struct rt9467_chg_data *data)
+{
+	struct regulator_config cfg = {
+		.dev = data->dev,
+		.regmap = data->regmap,
+		.driver_data = data,
+	};
+
+	data->rdev = devm_regulator_register(data->dev, &rt9467_otg_desc, &cfg);
+	return PTR_ERR_OR_ZERO(data->rdev);
+}
+
+static int rt9467_get_value_from_ranges(struct rt9467_chg_data *data,
+					enum rt9467_fields field,
+					enum rt9467_ranges rsel,
+					int *value)
+{
+	const struct linear_range *range = rt9467_ranges + rsel;
+	unsigned int sel;
+	int ret;
+
+	ret = regmap_field_read(data->rm_field[field], &sel);
+	if (ret)
+		return ret;
+
+	return linear_range_get_value(range, sel, value);
+}
+
+static int rt9467_set_value_from_ranges(struct rt9467_chg_data *data,
+					enum rt9467_fields field,
+					enum rt9467_ranges rsel,
+					int value)
+{
+	const struct linear_range *range = rt9467_ranges + rsel;
+	unsigned int sel;
+	bool found;
+	int ret;
+
+	if (rsel == RT9467_RANGE_VMIVR) {
+		ret = linear_range_get_selector_high(range, value, &sel, &found);
+		if (ret)
+			value = range->max_sel;
+	} else {
+		linear_range_get_selector_within(range, value, &sel);
+	}
+
+	return regmap_field_write(data->rm_field[field], sel);
+}
+
+static int rt9467_get_adc_sel(enum rt9467_adc_chan chan, int *sel)
+{
+	switch (chan) {
+	case RT9467_ADC_VBUS_DIV5:
+	case RT9467_ADC_VBUS_DIV2:
+	case RT9467_ADC_VSYS:
+	case RT9467_ADC_VBAT:
+		*sel = chan + 1;
+		return 0;
+	case RT9467_ADC_TS_BAT:
+		*sel = chan + 2;
+		return 0;
+	case RT9467_ADC_IBUS:
+	case RT9467_ADC_IBAT:
+		*sel = chan + 3;
+		return 0;
+	case RT9467_ADC_REGN:
+	case RT9467_ADC_TEMP_JC:
+		*sel = chan + 4;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rt9467_get_adc_raw_data(struct rt9467_chg_data *data,
+				   enum rt9467_adc_chan chan, int *val)
+{
+	unsigned int adc_stat, reg_val, adc_sel;
+	__be16 chan_raw_data;
+	int ret;
+
+	mutex_lock(&data->adc_lock);
+
+	ret = rt9467_get_adc_sel(chan, &adc_sel);
+	if (ret)
+		goto adc_unlock;
+
+	ret = regmap_write(data->regmap, RT9467_REG_CHG_ADC, 0);
+	if (ret) {
+		dev_err(data->dev, "Failed to clear ADC enable\n");
+		goto adc_unlock;
+	}
+
+	reg_val = RT9467_MASK_ADC_START | FIELD_PREP(RT9467_MASK_ADC_IN_SEL, adc_sel);
+	ret = regmap_write(data->regmap, RT9467_REG_CHG_ADC, reg_val);
+	if (ret)
+		goto adc_unlock;
+
+	/* Minimum wait time for one channel processing */
+	msleep(RT9467_ADCCONV_TIME_MS);
+
+	ret = regmap_read_poll_timeout(data->regmap, RT9467_REG_CHG_ADC,
+				       adc_stat,
+				       !(adc_stat & RT9467_MASK_ADC_START),
+				       MILLI, RT9467_ADCCONV_TIME_MS * MILLI);
+	if (ret) {
+		dev_err(data->dev, "Failed to wait ADC conversion, chan = %d\n", chan);
+		goto adc_unlock;
+	}
+
+	ret = regmap_raw_read(data->regmap, RT9467_REG_ADC_DATA_H,
+			      &chan_raw_data, sizeof(chan_raw_data));
+	if (ret)
+		goto adc_unlock;
+
+	*val = be16_to_cpu(chan_raw_data);
+
+adc_unlock:
+	mutex_unlock(&data->adc_lock);
+	return ret;
+}
+
+static int rt9467_get_adc(struct rt9467_chg_data *data,
+			  enum rt9467_adc_chan chan, int *val)
+{
+	unsigned int aicr_ua, ichg_ua;
+	int ret;
+
+	ret = rt9467_get_adc_raw_data(data, chan, val);
+	if (ret)
+		return ret;
+
+	switch (chan) {
+	case RT9467_ADC_VBUS_DIV5:
+		*val *= 25000;
+		return 0;
+	case RT9467_ADC_VBUS_DIV2:
+		*val *= 10000;
+		return 0;
+	case RT9467_ADC_VBAT:
+	case RT9467_ADC_VSYS:
+	case RT9467_ADC_REGN:
+		*val *= 5000;
+		return 0;
+	case RT9467_ADC_TS_BAT:
+		*val /= 400;
+		return 0;
+	case RT9467_ADC_IBUS:
+		/* UUG MOS turn-on ratio will affect the IBUS adc scale */
+		ret = rt9467_get_value_from_ranges(data, F_IAICR,
+						   RT9467_RANGE_IAICR, &aicr_ua);
+		if (ret)
+			return ret;
+
+		*val *= aicr_ua < 400000 ? 29480 : 50000;
+		return 0;
+	case RT9467_ADC_IBAT:
+		/* PP MOS turn-on ratio will affect the ICHG adc scale */
+		ret = rt9467_get_value_from_ranges(data, F_ICHG,
+						   RT9467_RANGE_ICHG, &ichg_ua);
+		if (ret)
+			return ret;
+
+		*val *= ichg_ua <= 400000 ? 28500 :
+			ichg_ua <= 800000 ? 31500 : 500000;
+		return 0;
+	case RT9467_ADC_TEMP_JC:
+		*val = ((*val * 2) - 40) * 10;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rt9467_psy_get_status(struct rt9467_chg_data *data, int *state)
+{
+	unsigned int status;
+	int ret;
+
+	ret = regmap_field_read(data->rm_field[F_CHG_STAT], &status);
+	if (ret)
+		return ret;
+
+	switch (status) {
+	case RT9467_STAT_READY:
+		*state = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		return 0;
+	case RT9467_STAT_PROGRESS:
+		*state = POWER_SUPPLY_STATUS_CHARGING;
+		return 0;
+	case RT9467_STAT_CHARGE_DONE:
+		*state = POWER_SUPPLY_STATUS_FULL;
+		return 0;
+	default:
+		*state = POWER_SUPPLY_STATUS_UNKNOWN;
+		return 0;
+	}
+}
+
+static int rt9467_psy_set_ichg(struct rt9467_chg_data *data, int microamp)
+{
+	int ret;
+
+	mutex_lock(&data->ichg_ieoc_lock);
+
+	if (microamp < 500000) {
+		dev_err(data->dev, "Minimum value must be 500mA\n");
+		microamp = 500000;
+	}
+
+	ret = rt9467_set_value_from_ranges(data, F_ICHG, RT9467_RANGE_ICHG, microamp);
+	if (ret)
+		goto out;
+
+	ret = rt9467_get_value_from_ranges(data, F_ICHG, RT9467_RANGE_ICHG,
+					   &data->ichg_ua);
+	if (ret)
+		goto out;
+
+out:
+	mutex_unlock(&data->ichg_ieoc_lock);
+	return ret;
+}
+
+static int rt9467_run_aicl(struct rt9467_chg_data *data)
+{
+	unsigned int statc, aicl_vth;
+	int mivr_vth, aicr_get;
+	int ret = 0;
+
+
+	ret = regmap_read(data->regmap, RT9467_REG_CHG_STATC, &statc);
+	if (ret) {
+		dev_err(data->dev, "Failed to read status\n");
+		return ret;
+	}
+
+	if (!(statc & RT9467_MASK_PWR_RDY) || !(statc & RT9467_MASK_MIVR_STAT)) {
+		dev_info(data->dev, "Condition not matched %d\n", statc);
+		return 0;
+	}
+
+	ret = rt9467_get_value_from_ranges(data, F_VMIVR, RT9467_RANGE_VMIVR,
+					   &mivr_vth);
+	if (ret) {
+		dev_err(data->dev, "Failed to get mivr\n");
+		return ret;
+	}
+
+	/* AICL_VTH = MIVR_VTH + 200mV */
+	aicl_vth = mivr_vth + RT9467_AICLVTH_GAP_uV;
+	ret = rt9467_set_value_from_ranges(data, F_AICL_VTH,
+					   RT9467_RANGE_AICL_VTH, aicl_vth);
+
+	/* Trigger AICL function */
+	ret = regmap_field_write(data->rm_field[F_AICL_MEAS], 1);
+	if (ret) {
+		dev_err(data->dev, "Failed to set aicl measurement\n");
+		return ret;
+	}
+
+	reinit_completion(&data->aicl_done);
+	ret = wait_for_completion_timeout(&data->aicl_done, msecs_to_jiffies(3500));
+	if (ret)
+		return ret;
+
+	ret = rt9467_get_value_from_ranges(data, F_IAICR, RT9467_RANGE_IAICR, &aicr_get);
+	if (ret) {
+		dev_err(data->dev, "Failed to get aicr\n");
+		return ret;
+	}
+
+	dev_info(data->dev, "aicr get = %d uA\n", aicr_get);
+	return 0;
+}
+
+static int rt9467_psy_set_ieoc(struct rt9467_chg_data *data, int microamp)
+{
+	int ret;
+
+	mutex_lock(&data->ichg_ieoc_lock);
+
+	ret = rt9467_set_value_from_ranges(data, F_IEOC, RT9467_RANGE_IEOC, microamp);
+	if (ret)
+		goto out;
+
+	ret = rt9467_get_value_from_ranges(data, F_IEOC, RT9467_RANGE_IEOC, &data->ieoc_ua);
+	if (ret)
+		goto out;
+
+out:
+	mutex_unlock(&data->ichg_ieoc_lock);
+	return ret;
+}
+
+static const enum power_supply_usb_type rt9467_chg_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_UNKNOWN,
+	POWER_SUPPLY_USB_TYPE_SDP,
+	POWER_SUPPLY_USB_TYPE_DCP,
+	POWER_SUPPLY_USB_TYPE_CDP,
+};
+
+static const enum power_supply_property rt9467_chg_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+};
+
+static int rt9467_psy_get_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct rt9467_chg_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return rt9467_psy_get_status(data, &val->intval);
+	case POWER_SUPPLY_PROP_ONLINE:
+		return regmap_field_read(data->rm_field[F_PWR_RDY], &val->intval);
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		mutex_lock(&data->attach_lock);
+		if (data->psy_usb_type == POWER_SUPPLY_USB_TYPE_UNKNOWN ||
+		    data->psy_usb_type == POWER_SUPPLY_USB_TYPE_SDP)
+			val->intval = 500000;
+		else
+			val->intval = 1500000;
+		mutex_unlock(&data->attach_lock);
+		return 0;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		mutex_lock(&data->ichg_ieoc_lock);
+		val->intval = data->ichg_ua;
+		mutex_unlock(&data->ichg_ieoc_lock);
+		return 0;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		val->intval = RT9467_ICHG_MAX_uA;
+		return 0;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		return rt9467_get_value_from_ranges(data, F_VOREG,
+						    RT9467_RANGE_VOREG,
+						    &val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		val->intval = RT9467_CV_MAX_uV;
+		return 0;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return rt9467_get_value_from_ranges(data, F_IAICR,
+						    RT9467_RANGE_IAICR,
+						    &val->intval);
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		return rt9467_get_value_from_ranges(data, F_VMIVR,
+						    RT9467_RANGE_VMIVR,
+						    &val->intval);
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		mutex_lock(&data->attach_lock);
+		val->intval = data->psy_usb_type;
+		mutex_unlock(&data->attach_lock);
+		return 0;
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		return rt9467_get_value_from_ranges(data, F_IPREC,
+						    RT9467_RANGE_IPREC,
+						    &val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		mutex_lock(&data->ichg_ieoc_lock);
+		val->intval = data->ieoc_ua;
+		mutex_unlock(&data->ichg_ieoc_lock);
+		return 0;
+	default:
+		return -ENODATA;
+	}
+}
+
+static int rt9467_psy_set_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   const union power_supply_propval *val)
+{
+	struct rt9467_chg_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return regmap_field_write(data->rm_field[F_CHG_EN], val->intval);
+	case POWER_SUPPLY_PROP_ONLINE:
+		return regmap_field_write(data->rm_field[F_HZ], val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		return rt9467_psy_set_ichg(data, val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		return rt9467_set_value_from_ranges(data, F_VOREG,
+						    RT9467_RANGE_VOREG, val->intval);
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (val->intval == -1)
+			return rt9467_run_aicl(data);
+		else
+			return rt9467_set_value_from_ranges(data, F_IAICR,
+							    RT9467_RANGE_IAICR,
+							    val->intval);
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		return rt9467_set_value_from_ranges(data, F_VMIVR,
+						    RT9467_RANGE_VMIVR, val->intval);
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		return rt9467_set_value_from_ranges(data, F_IPREC,
+						    RT9467_RANGE_IPREC, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		return rt9467_psy_set_ieoc(data, val->intval);
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		return regmap_field_write(data->rm_field[F_USBCHGEN], val->intval);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rt9467_chg_prop_is_writeable(struct power_supply *psy,
+					enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static const struct power_supply_desc rt9467_chg_psy_desc = {
+	.name = "rt9467-charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.usb_types = rt9467_chg_usb_types,
+	.num_usb_types = ARRAY_SIZE(rt9467_chg_usb_types),
+	.properties = rt9467_chg_properties,
+	.num_properties = ARRAY_SIZE(rt9467_chg_properties),
+	.property_is_writeable = rt9467_chg_prop_is_writeable,
+	.get_property = rt9467_psy_get_property,
+	.set_property = rt9467_psy_set_property,
+};
+
+static inline struct rt9467_chg_data *psy_device_to_chip(struct device *dev)
+{
+	return power_supply_get_drvdata(to_power_supply(dev));
+}
+
+static ssize_t sysoff_enable_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct rt9467_chg_data *data = psy_device_to_chip(dev);
+	unsigned int sysoff_enable;
+	int ret;
+
+	ret = regmap_field_read(data->rm_field[F_SHIP_MODE], &sysoff_enable);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", sysoff_enable);
+}
+
+static ssize_t sysoff_enable_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct rt9467_chg_data *data = psy_device_to_chip(dev);
+	unsigned int tmp;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &tmp);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(data->rm_field[F_SHIP_MODE], !!tmp);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(sysoff_enable);
+
+static struct attribute *rt9467_sysfs_attrs[] = {
+	&dev_attr_sysoff_enable.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(rt9467_sysfs);
+
+static int rt9467_register_psy(struct rt9467_chg_data *data)
+{
+	struct power_supply_config cfg = {
+		.drv_data = data,
+		.of_node = dev_of_node(data->dev),
+		.attr_grp = rt9467_sysfs_groups,
+	};
+
+	data->psy = devm_power_supply_register(data->dev, &rt9467_chg_psy_desc,
+					       &cfg);
+	return PTR_ERR_OR_ZERO(data->psy);
+}
+
+static int rt9467_mivr_handler(struct rt9467_chg_data *data)
+{
+	unsigned int mivr_act;
+	int ret, ibus_ma;
+
+	/*
+	 * back-boost workaround
+	 * If (mivr_active & ibus < 100mA), toggle cfo bit
+	 */
+	ret = regmap_field_read(data->rm_field[F_CHG_MIVR], &mivr_act);
+	if (ret) {
+		dev_err(data->dev, "Failed to read MIVR stat\n");
+		return ret;
+	}
+
+	if (!mivr_act)
+		return 0;
+
+	ret = rt9467_get_adc(data, RT9467_ADC_IBUS, &ibus_ma);
+	if (ret) {
+		dev_err(data->dev, "Failed to get IBUS\n");
+		return ret;
+	}
+
+	if (ibus_ma < 100000) {
+		ret = regmap_field_write(data->rm_field[F_CFO_EN], 0);
+		ret |= regmap_field_write(data->rm_field[F_CFO_EN], 1);
+		if (ret)
+			dev_err(data->dev, "Failed to toggle cfo\n");
+	}
+
+	return ret;
+}
+
+static irqreturn_t rt9467_statc_handler(int irq, void *priv)
+{
+	struct rt9467_chg_data *data = priv;
+	unsigned int new_stat, evts = 0;
+	int ret;
+
+	ret = regmap_read(data->regmap, RT9467_REG_CHG_STATC, &new_stat);
+	if (ret) {
+		dev_err(data->dev, "Failed to read chg_statc\n");
+		return IRQ_NONE;
+	}
+
+	evts = data->old_stat ^ new_stat;
+	data->old_stat = new_stat;
+
+	if ((evts & new_stat) & RT9467_MASK_MIVR_STAT) {
+		ret = rt9467_mivr_handler(data);
+		if (ret)
+			dev_err(data->dev, "Failed to handle mivr stat\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rt9467_wdt_handler(int irq, void *priv)
+{
+	struct rt9467_chg_data *data = priv;
+	unsigned int dev_id;
+	int ret;
+
+	/* Any i2c communication can kick watchdog timer */
+	ret = regmap_read(data->regmap, RT9467_REG_DEVICE_ID, &dev_id);
+	if (ret) {
+		dev_err(data->dev, "Failed to kick wdt (%d)\n", ret);
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int rt9467_report_usb_state(struct rt9467_chg_data *data)
+{
+	unsigned int usb_stat, power_ready;
+	bool psy_changed = true;
+	int ret;
+
+	ret = regmap_field_read(data->rm_field[F_USB_STATUS], &usb_stat);
+	ret |= regmap_field_read(data->rm_field[F_PWR_RDY], &power_ready);
+	if (ret)
+		return ret;
+
+	if (!power_ready)
+		usb_stat = RT9467_CHG_TYPE_NOVBUS;
+
+	mutex_lock(&data->attach_lock);
+
+	switch (usb_stat) {
+	case RT9467_CHG_TYPE_NOVBUS:
+		data->psy_usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+		break;
+	case RT9467_CHG_TYPE_SDP:
+		data->psy_usb_type = POWER_SUPPLY_USB_TYPE_SDP;
+		break;
+	case RT9467_CHG_TYPE_SDPNSTD:
+		data->psy_usb_type = POWER_SUPPLY_USB_TYPE_DCP;
+		break;
+	case RT9467_CHG_TYPE_DCP:
+		data->psy_usb_type = POWER_SUPPLY_USB_TYPE_DCP;
+		break;
+	case RT9467_CHG_TYPE_CDP:
+		data->psy_usb_type = POWER_SUPPLY_USB_TYPE_CDP;
+		break;
+	case RT9467_CHG_TYPE_UNDER_GOING:
+	default:
+		psy_changed = false;
+		break;
+	}
+
+	mutex_unlock(&data->attach_lock);
+
+	if (psy_changed)
+		power_supply_changed(data->psy);
+
+	return 0;
+}
+
+static irqreturn_t rt9467_usb_state_handler(int irq, void *priv)
+{
+	struct rt9467_chg_data *data = priv;
+	int ret;
+
+	ret = rt9467_report_usb_state(data);
+	if (ret) {
+		dev_err(data->dev, "Failed to report attache type (%d)\n", ret);
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rt9467_aiclmeas_handler(int irq, void *priv)
+{
+	struct rt9467_chg_data *data = priv;
+
+	complete(&data->aicl_done);
+	return IRQ_HANDLED;
+}
+
+#define RT9467_IRQ_DESC(_name, _handler_func, _hwirq)		\
+{								\
+	.name = #_name,						\
+	.handler = rt9467_##_handler_func##_handler,		\
+	.hwirq = _hwirq,					\
+}
+
+static int rt9467_request_interrupt(struct rt9467_chg_data *data)
+{
+	struct device *dev = data->dev;
+	static const struct {
+		const char *name;
+		int hwirq;
+		irq_handler_t handler;
+	} rt9467_exclusive_irqs[] = {
+		RT9467_IRQ_DESC(statc, statc, RT9467_IRQ_TS_STATC),
+		RT9467_IRQ_DESC(wdt, wdt, RT9467_IRQ_WDTMR),
+		RT9467_IRQ_DESC(attach, usb_state, RT9467_IRQ_ATTACH),
+		RT9467_IRQ_DESC(detach,	usb_state, RT9467_IRQ_DETACH),
+		RT9467_IRQ_DESC(aiclmeas, aiclmeas, RT9467_IRQ_CHG_AICLM),
+	}, rt9466_exclusive_irqs[] = {
+		RT9467_IRQ_DESC(statc, statc, RT9467_IRQ_TS_STATC),
+		RT9467_IRQ_DESC(wdt, wdt, RT9467_IRQ_WDTMR),
+		RT9467_IRQ_DESC(aiclmeas, aiclmeas, RT9467_IRQ_CHG_AICLM),
+	}, *chg_irqs;
+	int num_chg_irqs, i, virq, ret;
+
+	if (data->vid == RT9466_VID) {
+		chg_irqs = rt9466_exclusive_irqs;
+		num_chg_irqs = ARRAY_SIZE(rt9466_exclusive_irqs);
+	} else {
+		chg_irqs = rt9467_exclusive_irqs;
+		num_chg_irqs = ARRAY_SIZE(rt9467_exclusive_irqs);
+	}
+
+	for (i = 0; i < num_chg_irqs; i++) {
+		virq = regmap_irq_get_virq(data->irq_chip_data, chg_irqs[i].hwirq);
+		if (virq <= 0)
+			return dev_err_probe(dev, virq, "Failed to get (%s) irq\n",
+					     chg_irqs[i].name);
+
+		ret = devm_request_threaded_irq(dev, virq, NULL, chg_irqs[i].handler,
+						IRQF_ONESHOT, chg_irqs[i].name, data);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request (%s) irq\n",
+					     chg_irqs[i].name);
+	}
+
+	return 0;
+}
+
+static int rt9467_do_charger_init(struct rt9467_chg_data *data)
+{
+	struct device *dev = data->dev;
+	int ret;
+
+	ret = regmap_write(data->regmap, RT9467_REG_CHG_ADC, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset ADC\n");
+
+	ret = rt9467_get_value_from_ranges(data, F_ICHG, RT9467_RANGE_ICHG,
+					   &data->ichg_ua);
+	ret |= rt9467_get_value_from_ranges(data, F_IEOC, RT9467_RANGE_IEOC,
+					    &data->ieoc_ua);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init ichg/ieoc value\n");
+
+	ret = regmap_update_bits(data->regmap, RT9467_REG_CHG_STATC_CTRL,
+				 RT9467_MASK_PWR_RDY | RT9467_MASK_MIVR_STAT, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to make statc unmask\n");
+
+	/* Select IINLMTSEL to use AICR */
+	ret = regmap_field_write(data->rm_field[F_IINLMTSEL],
+				 RT9467_IINLMTSEL_AICR);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set iinlmtsel to AICR\n");
+
+	/* Wait for AICR Rampping */
+	msleep(150);
+
+	/* Disable hardware ILIM */
+	ret = regmap_field_write(data->rm_field[F_ILIM_EN], 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to disable hardware ILIM\n");
+
+	/* Set inductor OCP to high level */
+	ret = regmap_field_write(data->rm_field[F_OCP], 1);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set higher inductor OCP level\n");
+
+	/* Set charge termination default enable */
+	ret = regmap_field_write(data->rm_field[F_TE], 1);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set TE=1\n");
+
+	/* Set 12hrs fast charger timer */
+	ret = regmap_field_write(data->rm_field[F_WT_FC], 4);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set WT_FC\n");
+
+	/* Toggle BC12 function */
+	ret = regmap_field_write(data->rm_field[F_USBCHGEN], 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to disable BC12\n");
+
+	return regmap_field_write(data->rm_field[F_USBCHGEN], 1);
+}
+
+static bool rt9467_is_accessible_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case 0x00 ... 0x1A:
+	case 0x20 ... 0x38:
+	case 0x40 ... 0x49:
+	case 0x50 ... 0x57:
+	case 0x60 ... 0x67:
+	case 0x70 ... 0x79:
+	case 0x82 ... 0x85:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config rt9467_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x85,
+	.writeable_reg = rt9467_is_accessible_reg,
+	.readable_reg = rt9467_is_accessible_reg,
+};
+
+static int rt9467_check_vendor_info(struct rt9467_chg_data *data)
+{
+	unsigned int vid;
+	int ret;
+
+	ret = regmap_field_read(data->rm_field[F_VENDOR], &vid);
+	if (ret) {
+		dev_err(data->dev, "Failed to get vid\n");
+		return ret;
+	}
+
+	if ((vid != RT9466_VID) && (vid != RT9467_VID))
+		return dev_err_probe(data->dev, -ENODEV,
+				     "VID not correct [0x%02X]\n", vid);
+
+	data->vid = vid;
+	return 0;
+}
+
+static int rt9467_reset_chip(struct rt9467_chg_data *data)
+{
+	int ret;
+
+	/* Disable HZ before reset chip */
+	ret = regmap_field_write(data->rm_field[F_HZ], 0);
+	if (ret)
+		return ret;
+
+	return regmap_field_write(data->rm_field[F_RST], 1);
+}
+
+static void rt9467_chg_destroy_adc_lock(void *data)
+{
+	struct mutex *adc_lock = data;
+
+	mutex_destroy(adc_lock);
+}
+
+static void rt9467_chg_destroy_attach_lock(void *data)
+{
+	struct mutex *attach_lock = data;
+
+	mutex_destroy(attach_lock);
+}
+
+static void rt9467_chg_destroy_ichg_ieoc_lock(void *data)
+{
+	struct mutex *ichg_ieoc_lock = data;
+
+	mutex_destroy(ichg_ieoc_lock);
+}
+
+static void rt9467_chg_complete_aicl_done(void *data)
+{
+	struct completion *aicl_done = data;
+
+	complete(aicl_done);
+}
+
+static int rt9467_charger_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct rt9467_chg_data *data;
+	struct gpio_desc *ceb_gpio;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = &i2c->dev;
+	i2c_set_clientdata(i2c, data);
+
+	/* Default pull charge enable gpio to make 'CHG_EN' by SW control only */
+	ceb_gpio = devm_gpiod_get_optional(dev, "charge-enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ceb_gpio))
+		return dev_err_probe(dev, PTR_ERR(ceb_gpio),
+				     "Failed to config charge enable gpio\n");
+
+	data->regmap = devm_regmap_init_i2c(i2c, &rt9467_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Failed to init regmap\n");
+
+	ret = devm_regmap_field_bulk_alloc(dev, data->regmap,
+					   data->rm_field, rt9467_chg_fields,
+					   ARRAY_SIZE(rt9467_chg_fields));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to alloc regmap fields\n");
+
+	ret = rt9467_check_vendor_info(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to check vendor info");
+
+	ret = rt9467_reset_chip(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset chip\n");
+
+	ret = devm_regmap_add_irq_chip(dev, data->regmap, i2c->irq,
+				       IRQF_TRIGGER_LOW | IRQF_ONESHOT, 0,
+				       &rt9467_irq_chip, &data->irq_chip_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add irq chip\n");
+
+	mutex_init(&data->adc_lock);
+	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_adc_lock,
+				       &data->adc_lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init ADC lock\n");
+
+	mutex_init(&data->attach_lock);
+	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_attach_lock,
+				       &data->attach_lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init attach lock\n");
+
+	mutex_init(&data->ichg_ieoc_lock);
+	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_ichg_ieoc_lock,
+				       &data->ichg_ieoc_lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init ICHG/IEOC lock\n");
+
+	init_completion(&data->aicl_done);
+	ret = devm_add_action_or_reset(dev, rt9467_chg_complete_aicl_done,
+				       &data->aicl_done);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init AICL done completion\n");
+
+	ret = rt9467_do_charger_init(data);
+	if (ret)
+		return ret;
+
+	ret = rt9467_register_otg_regulator(data);
+	if (ret)
+		return ret;
+
+	ret = rt9467_register_psy(data);
+	if (ret)
+		return ret;
+
+	return rt9467_request_interrupt(data);
+}
+
+static const struct of_device_id rt9467_charger_of_match_table[] = {
+	{ .compatible = "richtek,rt9467", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rt9467_charger_of_match_table);
+
+static struct i2c_driver rt9467_charger_driver = {
+	.driver = {
+		.name = "rt9467-charger",
+		.of_match_table = rt9467_charger_of_match_table,
+	},
+	.probe_new = rt9467_charger_probe,
+};
+module_i2c_driver(rt9467_charger_driver);
+
+MODULE_DESCRIPTION("Richtek RT9467 Charger Driver");
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_AUTHOR("ChiaEn Wu <chiaen_wu@richtek.com>");
+MODULE_LICENSE("GPL");
-- 
2.7.4

