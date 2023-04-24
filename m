Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD96E4F01
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjDQRQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDQRQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:16:20 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F4B8A47;
        Mon, 17 Apr 2023 10:16:14 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 093E7C0008;
        Mon, 17 Apr 2023 17:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681751773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/Om8xZnzyMjnQhyiLrT7RITRjrIxb9CpQlMzOgxPDY=;
        b=X58u8uCgyCLp/rsVxXXssjT0kMmZYgMLLXILvTX6rgpqxcR+sxdqqmH4RYZj8edVJhLjj0
        quUxsosVlWFusQKshHL0QcQgbrwrKcQ+tZwtEEov7KcuK87hF1FSmPSw5nM7zNBKA2bqvE
        RpL/UvMEdbxN7V3Gi9DyHPK8uPKeB2l1O1JNoNCibw0MM8+b1vNEQbGPwgNNRs7jqCf+I6
        dlfUGktVAlPGwpLnzSttlILS4GYvMg13X8D4SPVPxFWxs7R2/cuZs0oNxknkDOZzkUCZCt
        8KEtsglm1KSIjp1yMWzrcqhjUVtqKKtYYBde1g5f36KdOp/oq+IAa0xPoLDKwA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v6 3/7] mfd: Add support for the Lantiq PEF2256 framer
Date:   Mon, 17 Apr 2023 19:15:57 +0200
Message-Id: <20230417171601.74656-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417171601.74656-1-herve.codina@bootlin.com>
References: <20230417171601.74656-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lantiq PEF2256 is a framer and line interface component designed to
fulfill all required interfacing between an analog E1/T1/J1 line and the
digital PCM system highway/H.100 bus.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/mfd/Kconfig         |  16 +
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/pef2256-regs.h  | 250 ++++++++++
 drivers/mfd/pef2256.c       | 950 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/pef2256.h |  52 ++
 5 files changed, 1269 insertions(+)
 create mode 100644 drivers/mfd/pef2256-regs.h
 create mode 100644 drivers/mfd/pef2256.c
 create mode 100644 include/linux/mfd/pef2256.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index fcc141e067b9..d0c5d1e9f950 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1063,6 +1063,22 @@ config PCF50633_GPIO
 	  Say yes here if you want to include support GPIO for pins on
 	  the PCF50633 chip.
 
+config MFD_PEF2256
+	tristate "Lantiq PEF2256 (FALC56) framer"
+	depends on OF
+	select MFD_CORE
+	select REGMAP_MMIO
+	help
+	  This option enables support for the Lantiq PEF2256 framer, also known
+	  as FALC56. This framer and its line interface component is designed
+	  to fulfill all required interfacing between analog E1/T1/J1 lines and
+	  the digital PCM system highway.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pef2256.
+
 config MFD_PM8XXX
 	tristate "Qualcomm PM8xxx PMIC chips driver"
 	depends on (ARM || HEXAGON || COMPILE_TEST)
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2f6c89d1e277..b2bb6e6a141c 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -195,6 +195,7 @@ obj-$(CONFIG_MFD_SI476X_CORE)	+= si476x-core.o
 
 obj-$(CONFIG_MFD_CS5535)	+= cs5535-mfd.o
 obj-$(CONFIG_MFD_OMAP_USB_HOST)	+= omap-usb-host.o omap-usb-tll.o
+obj-$(CONFIG_MFD_PEF2256)	+= pef2256.o
 obj-$(CONFIG_MFD_PM8XXX) 	+= qcom-pm8xxx.o ssbi.o
 obj-$(CONFIG_MFD_QCOM_RPM)	+= qcom_rpm.o
 obj-$(CONFIG_MFD_SPMI_PMIC)	+= qcom-spmi-pmic.o
diff --git a/drivers/mfd/pef2256-regs.h b/drivers/mfd/pef2256-regs.h
new file mode 100644
index 000000000000..5d3183c91714
--- /dev/null
+++ b/drivers/mfd/pef2256-regs.h
@@ -0,0 +1,250 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PEF2256 registers definition
+ *
+ * Copyright 2023 CS GROUP France
+ *
+ * Author: Herve Codina <herve.codina@bootlin.com>
+ */
+#ifndef __PEF2256_REGS_H__
+#define __PEF2256_REGS_H__
+
+#include "linux/bitfield.h"
+
+/* Command Register */
+#define PEF2256_CMDR		0x02
+#define PEF2256_CMDR_RRES	BIT(6)
+#define PEF2256_CMDR_XRES	BIT(4)
+#define PEF2256_CMDR_SRES	BIT(0)
+
+/* Interrupt Mask Register 0..5 */
+#define PEF2256_IMR0	        0x14
+#define PEF2256_IMR1	        0x15
+#define PEF2256_IMR2	        0x16
+#define PEF2256_IMR3	        0x17
+#define PEF2256_IMR4	        0x18
+#define PEF2256_IMR5	        0x19
+
+/* Framer Mode Register 0 */
+#define PEF2256_FMR0		0x1C
+#define PEF2256_FMR0_XC_MASK	GENMASK(7, 6)
+#define PEF2256_FMR0_XC_NRZ	FIELD_PREP_CONST(PEF2256_FMR0_XC_MASK, 0x0)
+#define PEF2256_FMR0_XC_CMI	FIELD_PREP_CONST(PEF2256_FMR0_XC_MASK, 0x1)
+#define PEF2256_FMR0_XC_AMI	FIELD_PREP_CONST(PEF2256_FMR0_XC_MASK, 0x2)
+#define PEF2256_FMR0_XC_HDB3	FIELD_PREP_CONST(PEF2256_FMR0_XC_MASK, 0x3)
+#define PEF2256_FMR0_RC_MASK	GENMASK(5, 4)
+#define PEF2256_FMR0_RC_NRZ	FIELD_PREP_CONST(PEF2256_FMR0_RC_MASK, 0x0)
+#define PEF2256_FMR0_RC_CMI	FIELD_PREP_CONST(PEF2256_FMR0_RC_MASK, 0x1)
+#define PEF2256_FMR0_RC_AMI	FIELD_PREP_CONST(PEF2256_FMR0_RC_MASK, 0x2)
+#define PEF2256_FMR0_RC_HDB3	FIELD_PREP_CONST(PEF2256_FMR0_RC_MASK, 0x3)
+
+/* Framer Mode Register 1 */
+#define PEF2256_FMR1		0x1D
+#define PEF2256_FMR1_XFS	BIT(3)
+#define PEF2256_FMR1_ECM	BIT(2)
+/* SSD is defined on 2 bits. The other bit is on SIC1 register */
+#define PEF2256_FMR1_SSD_MASK	GENMASK(1, 1)
+#define PEF2256_FMR1_SSD_2048	FIELD_PREP_CONST(PEF2256_FMR1_SSD_MASK, 0x0)
+#define PEF2256_FMR1_SSD_4096	FIELD_PREP_CONST(PEF2256_FMR1_SSD_MASK, 0x1)
+#define PEF2256_FMR1_SSD_8192	FIELD_PREP_CONST(PEF2256_FMR1_SSD_MASK, 0x0)
+#define PEF2256_FMR1_SSD_16384	FIELD_PREP_CONST(PEF2256_FMR1_SSD_MASK, 0x1)
+
+/* Framer Mode Register 2 */
+#define PEF2256_FMR2			  0x1E
+#define PEF2256_FMR2_RFS_MASK		  GENMASK(7, 6)
+#define PEF2256_FMR2_RFS_DOUBLEFRAME	  FIELD_PREP_CONST(PEF2256_FMR2_RFS_MASK, 0x0)
+#define PEF2256_FMR2_RFS_CRC4_MULTIFRAME  FIELD_PREP_CONST(PEF2256_FMR2_RFS_MASK, 0x2)
+#define PEF2256_FMR2_RFS_AUTO_MULTIFRAME  FIELD_PREP_CONST(PEF2256_FMR2_RFS_MASK, 0x3)
+#define PEF2256_FMR2_AXRA		  BIT(1)
+
+/* Transmit Service Word */
+#define PEF2256_XSW		0x20
+#define PEF2256_XSW_XSIS	BIT(7)
+#define PEF2256_XSW_XTM		BIT(6)
+#define PEF2256_XSW_XY_MASK	GENMASK(5, 0)
+#define PEF2256_XSW_XY(_v)	FIELD_PREP(PEF2256_XSW_XY_MASK, _v)
+
+/* Transmit Spare Bits */
+#define PEF2256_XSP	        0x21
+#define PEF2256_XSP_XSIF	BIT(2)
+
+/* Transmit Control 0..1 */
+#define PEF2256_XC0		0x22
+#define PEF2256_XC1		0x23
+
+/* Receive Control 0 */
+#define PEF2256_RC0		0x24
+#define PEF2256_RC0_SWD		BIT(7)
+#define PEF2256_RC0_ASY4	BIT(6)
+
+/* Receive Control 1 */
+#define PEF2256_RC1		0x25
+
+/* Transmit Pulse Mask 0..1 */
+#define PEF2256_XPM0		0x26
+#define PEF2256_XPM1		0x27
+
+/* Transmit Pulse Mask 2 */
+#define PEF2256_XPM2		0x28
+#define PEF2256_XPM2_XLT	BIT(6)
+
+/* Transparent Service Word Mask */
+#define PEF2256_TSWM		0x29
+
+/* Line Interface Mode 0 */
+#define PEF2256_LIM0		0x36
+#define PEF2256_2X_LIM0_BIT3	BIT(3) /* v2.x, described as a forced '1' bit */
+#define PEF2256_LIM0_MAS	BIT(0)
+
+/* Line Interface Mode 1 */
+#define PEF2256_LIM1		  0x37
+#define PEF2256_12_LIM1_RIL_MASK  GENMASK(6, 4)
+#define PEF2256_12_LIM1_RIL_910	  FIELD_PREP_CONST(PEF2256_12_LIM1_RIL_MASK, 0x0)
+#define PEF2256_12_LIM1_RIL_740	  FIELD_PREP_CONST(PEF2256_12_LIM1_RIL_MASK, 0x1)
+#define PEF2256_12_LIM1_RIL_590	  FIELD_PREP_CONST(PEF2256_12_LIM1_RIL_MASK, 0x2)
+#define PEF2256_12_LIM1_RIL_420	  FIELD_PREP_CONST(PEF2256_12_LIM1_RIL_MASK, 0x3)
+#define PEF2256_12_LIM1_RIL_320	  FIELD_PREP_CONST(PEF2256_12_LIM1_RIL_MASK, 0x4)
+#define PEF2256_12_LIM1_RIL_210	  FIELD_PREP_CONST(PEF2256_12_LIM1_RIL_MASK, 0x5)
+#define PEF2256_12_LIM1_RIL_160	  FIELD_PREP_CONST(PEF2256_12_LIM1_RIL_MASK, 0x6)
+#define PEF2256_12_LIM1_RIL_100	  FIELD_PREP_CONST(PEF2256_12_LIM1_RIL_MASK, 0x7)
+#define PEF2256_2X_LIM1_RIL_MASK  GENMASK(6, 4)
+#define PEF2256_2X_LIM1_RIL_2250  FIELD_PREP_CONST(PEF2256_2X_LIM1_RIL_MASK, 0x0)
+#define PEF2256_2X_LIM1_RIL_1100  FIELD_PREP_CONST(PEF2256_2X_LIM1_RIL_MASK, 0x1)
+#define PEF2256_2X_LIM1_RIL_600	  FIELD_PREP_CONST(PEF2256_2X_LIM1_RIL_MASK, 0x2)
+#define PEF2256_2X_LIM1_RIL_350	  FIELD_PREP_CONST(PEF2256_2X_LIM1_RIL_MASK, 0x3)
+#define PEF2256_2X_LIM1_RIL_210	  FIELD_PREP_CONST(PEF2256_2X_LIM1_RIL_MASK, 0x4)
+#define PEF2256_2X_LIM1_RIL_140	  FIELD_PREP_CONST(PEF2256_2X_LIM1_RIL_MASK, 0x5)
+#define PEF2256_2X_LIM1_RIL_100	  FIELD_PREP_CONST(PEF2256_2X_LIM1_RIL_MASK, 0x6)
+#define PEF2256_2X_LIM1_RIL_50	  FIELD_PREP_CONST(PEF2256_2X_LIM1_RIL_MASK, 0x7)
+
+/* Pulse Count Detection */
+#define PEF2256_PCD		0x38
+
+ /* Pulse Count Recovery */
+#define PEF2256_PCR		0x39
+
+ /* Line Interface Mode 2 */
+#define PEF2256_LIM2		0x3A
+#define PEF2256_LIM2_SLT_MASK	GENMASK(5, 4)
+#define PEF2256_LIM2_SLT_THR55	FIELD_PREP_CONST(PEF2256_LIM2_SLT_MASK, 0x0)
+#define PEF2256_LIM2_SLT_THR67	FIELD_PREP_CONST(PEF2256_LIM2_SLT_MASK, 0x1)
+#define PEF2256_LIM2_SLT_THR50	FIELD_PREP_CONST(PEF2256_LIM2_SLT_MASK, 0x2)
+#define PEF2256_LIM2_SLT_THR45	FIELD_PREP_CONST(PEF2256_LIM2_SLT_MASK, 0x3)
+#define PEF2256_LIM2_ELT	BIT(2)
+
+/* System Interface Control 1 */
+#define PEF2256_SIC1	          0x3E
+#define PEF2256_SIC1_SSC_MASK	  (BIT(7) |  BIT(3))
+#define PEF2256_SIC1_SSC_2048	  (0)
+#define PEF2256_SIC1_SSC_4096	  BIT(3)
+#define PEF2256_SIC1_SSC_8192	  BIT(7)
+#define PEF2256_SIC1_SSC_16384	  (BIT(7) |  BIT(3))
+/* SSD is defined on 2 bits. The other bit is on FMR1 register */
+#define PEF2256_SIC1_SSD_MASK	  GENMASK(6, 6)
+#define PEF2256_SIC1_SSD_2048	  FIELD_PREP_CONST(PEF2256_SIC1_SSD_MASK, 0x0)
+#define PEF2256_SIC1_SSD_4096	  FIELD_PREP_CONST(PEF2256_SIC1_SSD_MASK, 0x0)
+#define PEF2256_SIC1_SSD_8192	  FIELD_PREP_CONST(PEF2256_SIC1_SSD_MASK, 0x1)
+#define PEF2256_SIC1_SSD_16384	  FIELD_PREP_CONST(PEF2256_SIC1_SSD_MASK, 0x1)
+#define PEF2256_SIC1_RBS_MASK	  GENMASK(5, 4)
+#define PEF2256_SIC1_RBS_2FRAMES  FIELD_PREP_CONST(PEF2256_SIC1_RBS_MASK, 0x0)
+#define PEF2256_SIC1_RBS_1FRAME	  FIELD_PREP_CONST(PEF2256_SIC1_RBS_MASK, 0x1)
+#define PEF2256_SIC1_RBS_96BITS	  FIELD_PREP_CONST(PEF2256_SIC1_RBS_MASK, 0x2)
+#define PEF2256_SIC1_RBS_BYPASS	  FIELD_PREP_CONST(PEF2256_SIC1_RBS_MASK, 0x3)
+#define PEF2256_SIC1_XBS_MASK	  GENMASK(1, 0)
+#define PEF2256_SIC1_XBS_BYPASS	  FIELD_PREP_CONST(PEF2256_SIC1_XBS_MASK, 0x0)
+#define PEF2256_SIC1_XBS_1FRAME	  FIELD_PREP_CONST(PEF2256_SIC1_XBS_MASK, 0x1)
+#define PEF2256_SIC1_XBS_2FRAMES  FIELD_PREP_CONST(PEF2256_SIC1_XBS_MASK, 0x2)
+#define PEF2256_SIC1_XBS_96BITS	  FIELD_PREP_CONST(PEF2256_SIC1_XBS_MASK, 0x3)
+
+/* System Interface Control 2 */
+#define PEF2256_SIC2		0x3F
+#define PEF2256_SIC2_SICS_MASK	GENMASK(3, 1)
+#define PEF2256_SIC2_SICS(_v)	FIELD_PREP(PEF2256_SIC2_SICS_MASK, _v)
+
+/* System Interface Control 3 */
+#define PEF2256_SIC3		0x40
+#define PEF2256_SIC3_RTRI	BIT(5)
+#define PEF2256_SIC3_RESX	BIT(3)
+#define PEF2256_SIC3_RESR	BIT(2)
+
+/* Clock Mode Register 1 */
+#define PEF2256_CMR1			0x44
+#define PEF2256_CMR1_RS_MASK		GENMASK(5, 4)
+#define PEF2256_CMR1_RS_DPLL		FIELD_PREP_CONST(PEF2256_CMR1_RS_MASK, 0x0)
+#define PEF2256_CMR1_RS_DPLL_LOS_HIGH	FIELD_PREP_CONST(PEF2256_CMR1_RS_MASK, 0x1)
+#define PEF2256_CMR1_RS_DCOR_2048	FIELD_PREP_CONST(PEF2256_CMR1_RS_MASK, 0x2)
+#define PEF2256_CMR1_RS_DCOR_8192	FIELD_PREP_CONST(PEF2256_CMR1_RS_MASK, 0x3)
+#define PEF2256_CMR1_DCS		BIT(3)
+
+/* Clock Mode Register 2 */
+#define PEF2256_CMR2		0x45
+#define PEF2256_CMR2_DCOXC	BIT(5)
+
+/* Global Configuration Register */
+#define PEF2256_GCR		0x46
+#define PEF2256_GCR_SCI		BIT(6)
+#define PEF2256_GCR_ECMC	BIT(4)
+
+/* Port Configuration 5 */
+#define PEF2256_PC5		0x84
+#define PEF2256_PC5_CRP         BIT(0)
+
+/* Global Port Configuration 1 */
+#define PEF2256_GPC1			0x85
+#define PEF2256_GPC1_CSFP_MASK		GENMASK(7, 5)
+#define PEF2256_GPC1_CSFP_SEC_IN_HIGH	FIELD_PREP_CONST(PEF2256_GPC1_CSFP_MASK, 0x0)
+#define PEF2256_GPC1_CSFP_SEC_OUT_HIGH	FIELD_PREP_CONST(PEF2256_GPC1_CSFP_MASK, 0x1)
+#define PEF2256_GPC1_CSFP_FSC_OUT_HIGH	FIELD_PREP_CONST(PEF2256_GPC1_CSFP_MASK, 0x2)
+#define PEF2256_GPC1_CSFP_FSC_OUT_LOW	FIELD_PREP_CONST(PEF2256_GPC1_CSFP_MASK, 0x3)
+
+/* Port Configuration 6 */
+#define PEF2256_PC6		0x86
+
+/* Global Counter Mode n=1..8 */
+#define PEF2256_GCM(_n)         (0x92 + (_n) - 1)
+#define PEF2256_GCM1	        0x92
+#define PEF2256_GCM2	        0x93
+#define PEF2256_GCM3	        0x94
+#define PEF2256_GCM4	        0x95
+#define PEF2256_GCM5	        0x96
+#define PEF2256_GCM6	        0x97
+#define PEF2256_GCM7	        0x98
+#define PEF2256_GCM8	        0x99
+
+/* Version Status Register */
+#define PEF2256_VSTR		 0x4A
+#define PEF2256_VSTR_VERSION_12	 0x00
+#define PEF2256_VSTR_VERSION_21	 0x10
+#define PEF2256_VSTR_VERSION_2x	 0x05
+
+/* Framer Receive Status 0 */
+#define PEF2256_FRS0		0x4C
+#define PEF2256_FRS0_LOS	BIT(7)
+#define PEF2256_FRS0_AIS	BIT(6)
+
+/* Interrupt Status Register 0..5 */
+#define PEF2256_ISR(_n)		(0x68 + (_n))
+#define PEF2256_ISR0		0x68
+#define PEF2256_ISR1		0x69
+#define PEF2256_ISR2		0x6A
+#define PEF2256_ISR3		0x6B
+#define PEF2256_ISR4		0x6C
+#define PEF2256_ISR5		0x6D
+
+/* Global Interrupt Status */
+#define PEF2256_GIS		0x6E
+#define PEF2256_GIS_ISR(_n)	BIT(_n)
+
+/* Wafer Identification Register */
+#define PEF2256_WID		   0xEC
+#define PEF2256_12_WID_MASK	   GENMASK(1, 0)
+#define PEF2256_12_WID_VERSION_12  FIELD_PREP_CONST(PEF2256_12_WID_MASK, 0x3)
+#define PEF2256_2X_WID_MASK	   GENMASK(7, 6)
+#define PEF2256_2X_WID_VERSION_21  FIELD_PREP_CONST(PEF2256_2X_WID_MASK, 0x0)
+#define PEF2256_2X_WID_VERSION_22  FIELD_PREP_CONST(PEF2256_2X_WID_MASK, 0x1)
+
+/* IMR2/ISR2 Interrupts common bits */
+#define PEF2256_INT2_AIS	BIT(3)
+#define PEF2256_INT2_LOS	BIT(2)
+
+#endif /* __PEF2256_REGS_H__ */
diff --git a/drivers/mfd/pef2256.c b/drivers/mfd/pef2256.c
new file mode 100644
index 000000000000..48717ae425b6
--- /dev/null
+++ b/drivers/mfd/pef2256.c
@@ -0,0 +1,950 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PEF2256 also known as FALC56 driver
+ *
+ * Copyright 2023 CS GROUP France
+ *
+ * Author: Herve Codina <herve.codina@bootlin.com>
+ */
+
+#include <linux/mfd/pef2256.h>
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include "pef2256-regs.h"
+
+enum pef2256_frame_type {
+	PEF2256_FRAME_E1_DOUBLEFRAME,
+	PEF2256_FRAME_E1_CRC4_MULTIFRAME,
+	PEF2256_FRAME_E1_AUTO_MULTIFRAME,
+	PEF2256_FRAME_T1J1_4FRAME,
+	PEF2256_FRAME_T1J1_12FRAME,
+	PEF2256_FRAME_T1J1_24FRAME,
+	PEF2256_FRAME_T1J1_72FRAME,
+};
+
+struct pef2256 {
+	struct device *dev;
+	struct regmap *regmap;
+	enum pef2256_version version;
+	struct clk *mclk;
+	struct clk *sclkr;
+	struct clk *sclkx;
+	struct gpio_desc *reset_gpio;
+	bool is_e1;
+	unsigned long sysclk_rate;
+	u32 data_rate;
+	bool is_tx_falling_edge;
+	bool is_subordinate;
+	enum pef2256_frame_type frame_type;
+	u8 channel_phase;
+	atomic_t carrier;
+	struct atomic_notifier_head event_notifier_list;
+};
+
+static inline u8 pef2256_read8(struct pef2256 *pef2256, int offset)
+{
+	int val;
+
+	regmap_read(pef2256->regmap, offset, &val);
+	return val;
+}
+
+static inline void pef2256_write8(struct pef2256 *pef2256, int offset, u8 val)
+{
+	regmap_write(pef2256->regmap, offset, val);
+}
+
+static inline void pef2256_clrbits8(struct pef2256 *pef2256, int offset, u8 clr)
+{
+	regmap_clear_bits(pef2256->regmap, offset, clr);
+}
+
+static inline void pef2256_setbits8(struct pef2256 *pef2256, int offset, u8 set)
+{
+	regmap_set_bits(pef2256->regmap, offset, set);
+}
+
+static inline void pef2256_clrsetbits8(struct pef2256 *pef2256, int offset, u8 clr, u8 set)
+{
+	regmap_update_bits(pef2256->regmap, offset, clr | set, set);
+}
+
+enum pef2256_version pef2256_get_version(struct pef2256 *pef2256)
+{
+	enum pef2256_version version = PEF2256_VERSION_UNKNOWN;
+	u8 vstr, wid;
+
+	vstr = pef2256_read8(pef2256, PEF2256_VSTR);
+	wid = pef2256_read8(pef2256, PEF2256_WID);
+
+	switch (vstr) {
+	case PEF2256_VSTR_VERSION_12:
+		if ((wid & PEF2256_12_WID_MASK) == PEF2256_12_WID_VERSION_12)
+			version = PEF2256_VERSION_1_2;
+		break;
+	case PEF2256_VSTR_VERSION_2x:
+		switch (wid & PEF2256_2X_WID_MASK) {
+		case PEF2256_2X_WID_VERSION_21:
+			version = PEF2256_VERSION_2_1;
+			break;
+		case PEF2256_2X_WID_VERSION_22:
+			version = PEF2256_VERSION_2_2;
+			break;
+		}
+		break;
+	case PEF2256_VSTR_VERSION_21:
+		version = PEF2256_VERSION_2_1;
+		break;
+	}
+
+	if (version == PEF2256_VERSION_UNKNOWN)
+		dev_err(pef2256->dev, "Unknown version (0x%02x, 0x%02x)\n", vstr, wid);
+
+	return version;
+}
+EXPORT_SYMBOL_GPL(pef2256_get_version);
+
+enum pef2256_gcm_config_item {
+	PEF2256_GCM_CONFIG_1544000 = 0,
+	PEF2256_GCM_CONFIG_2048000,
+	PEF2256_GCM_CONFIG_8192000,
+	PEF2256_GCM_CONFIG_10000000,
+	PEF2256_GCM_CONFIG_12352000,
+	PEF2256_GCM_CONFIG_16384000,
+};
+
+struct pef2256_gcm_config {
+	u8 gcm_12[6];
+	u8 gcm_2x[8];
+};
+
+static const struct pef2256_gcm_config pef2256_gcm_configs[] = {
+	[PEF2256_GCM_CONFIG_1544000] = {
+		.gcm_12 = {0xF0, 0x51, 0x00, 0x80, 0x00, 0x15},
+		.gcm_2x = {0x00, 0x15, 0x00, 0x08, 0x00, 0x3F, 0x9C, 0xDF},
+	},
+	[PEF2256_GCM_CONFIG_2048000] = {
+		.gcm_12 = {0x00, 0x58, 0xD2, 0xC2, 0x00, 0x10},
+		.gcm_2x = {0x00, 0x18, 0xFB, 0x0B, 0x00, 0x2F, 0xDB, 0xDF},
+	},
+	[PEF2256_GCM_CONFIG_8192000] = {
+		.gcm_12 = {0x00, 0x58, 0xD2, 0xC2, 0x03, 0x10},
+		.gcm_2x = {0x00, 0x18, 0xFB, 0x0B, 0x00, 0x0B, 0xDB, 0xDF},
+	},
+	[PEF2256_GCM_CONFIG_10000000] = {
+		.gcm_12 = {0x90, 0x51, 0x81, 0x8F, 0x04, 0x10},
+		.gcm_2x = {0x40, 0x1B, 0x3D, 0x0A, 0x00, 0x07, 0xC9, 0xDC},
+	},
+	[PEF2256_GCM_CONFIG_12352000] = {
+		.gcm_12 = {0xF0, 0x51, 0x00, 0x80, 0x07, 0x15},
+		.gcm_2x = {0x00, 0x19, 0x00, 0x08, 0x01, 0x0A, 0x98, 0xDA},
+	},
+	[PEF2256_GCM_CONFIG_16384000] = {
+		.gcm_12 = {0x00, 0x58, 0xD2, 0xC2, 0x07, 0x10},
+		.gcm_2x = {0x00, 0x18, 0xFB, 0x0B, 0x01, 0x0B, 0xDB, 0xDF},
+	},
+};
+
+static int pef2256_setup_gcm(struct pef2256 *pef2256)
+{
+	enum pef2256_gcm_config_item item;
+	unsigned long mclk_rate;
+	const u8 *gcm;
+	int i, count;
+
+	mclk_rate = clk_get_rate(pef2256->mclk);
+	switch (mclk_rate) {
+	case 1544000:
+		item = PEF2256_GCM_CONFIG_1544000;
+		break;
+	case 2048000:
+		item = PEF2256_GCM_CONFIG_2048000;
+		break;
+	case 8192000:
+		item = PEF2256_GCM_CONFIG_8192000;
+		break;
+	case 10000000:
+		item = PEF2256_GCM_CONFIG_10000000;
+		break;
+	case 12352000:
+		item = PEF2256_GCM_CONFIG_12352000;
+		break;
+	case 16384000:
+		item = PEF2256_GCM_CONFIG_16384000;
+		break;
+	default:
+		dev_err(pef2256->dev, "Unsupported v2.x MCLK rate %lu\n", mclk_rate);
+		return -EINVAL;
+	}
+
+	BUILD_BUG_ON(item >= ARRAY_SIZE(pef2256_gcm_configs));
+
+	if (pef2256->version == PEF2256_VERSION_1_2) {
+		gcm = pef2256_gcm_configs[item].gcm_12;
+		count = ARRAY_SIZE(pef2256_gcm_configs[item].gcm_12);
+	} else {
+		gcm = pef2256_gcm_configs[item].gcm_2x;
+		count = ARRAY_SIZE(pef2256_gcm_configs[item].gcm_2x);
+	}
+
+	for (i = 0; i < count; i++)
+		pef2256_write8(pef2256, PEF2256_GCM(i + 1), *(gcm + i));
+
+	return 0;
+}
+
+static int pef2256_setup_e1_line(struct pef2256 *pef2256)
+{
+	u8 fmr1, fmr2;
+
+	/* RCLK output : DPLL clock, DCO-X enabled, DCO-X internal ref clock */
+	pef2256_write8(pef2256, PEF2256_CMR1, 0x00);
+
+	/*
+	 * SCLKR selected, SCLKX selected,
+	 * receive synchro pulse sourced by SYPR,
+	 * transmit synchro pulse sourced by SYPX,
+	 * DCO-X center frequency enabled
+	 */
+	pef2256_write8(pef2256, PEF2256_CMR2, PEF2256_CMR2_DCOXC);
+
+	if (pef2256->is_subordinate) {
+		/* select RCLK source = 2M,  disable switching from RCLK to SYNC */
+		pef2256_clrsetbits8(pef2256, PEF2256_CMR1, PEF2256_CMR1_RS_MASK,
+				    PEF2256_CMR1_RS_DCOR_2048 | PEF2256_CMR1_DCS);
+	}
+
+	/*
+	 * slave mode, local loop off, mode short-haul
+	 * In v2.x, bit3 is a forced 1 bit in the datasheet -> Need to be set.
+	 */
+	if (pef2256->version == PEF2256_VERSION_1_2)
+		pef2256_write8(pef2256, PEF2256_LIM0, 0x00);
+	else
+		pef2256_write8(pef2256, PEF2256_LIM0, PEF2256_2X_LIM0_BIT3);
+
+	/* "master" mode */
+	if (!pef2256->is_subordinate)
+		pef2256_setbits8(pef2256, PEF2256_LIM0, PEF2256_LIM0_MAS);
+
+	/* analog interface selected, remote loop off */
+	pef2256_write8(pef2256, PEF2256_LIM1, 0x00);
+
+	/* receive input threshold = 0,21V */
+	if (pef2256->version == PEF2256_VERSION_1_2)
+		pef2256_clrsetbits8(pef2256, PEF2256_LIM1, PEF2256_12_LIM1_RIL_MASK,
+				    PEF2256_12_LIM1_RIL_210);
+	else
+		pef2256_clrsetbits8(pef2256, PEF2256_LIM1, PEF2256_2X_LIM1_RIL_MASK,
+				    PEF2256_2X_LIM1_RIL_210);
+
+	/*
+	 * transmit pulse mask, default value from datasheet
+	 * transmit line in normal operation
+	 */
+	if (pef2256->version == PEF2256_VERSION_1_2)
+		pef2256_write8(pef2256, PEF2256_XPM0, 0x7B);
+	else
+		pef2256_write8(pef2256, PEF2256_XPM0, 0x9C);
+	pef2256_write8(pef2256, PEF2256_XPM1, 0x03);
+	pef2256_write8(pef2256, PEF2256_XPM2, 0x00);
+
+	/* HDB3 coding, no alarm simulation */
+	pef2256_write8(pef2256, PEF2256_FMR0, PEF2256_FMR0_XC_HDB3 | PEF2256_FMR0_RC_HDB3);
+
+	/*
+	 * E1, frame format, 2 Mbit/s system data rate, no AIS
+	 * transmission to remote end or system interface, payload loop
+	 * off, transmit remote alarm on
+	 */
+	fmr1 = 0x00;
+	fmr2 = PEF2256_FMR2_AXRA;
+	switch (pef2256->frame_type) {
+	case PEF2256_FRAME_E1_DOUBLEFRAME:
+		fmr2 |= PEF2256_FMR2_RFS_DOUBLEFRAME;
+		break;
+	case PEF2256_FRAME_E1_CRC4_MULTIFRAME:
+		fmr1 |= PEF2256_FMR1_XFS;
+		fmr2 |= PEF2256_FMR2_RFS_CRC4_MULTIFRAME;
+		break;
+	case PEF2256_FRAME_E1_AUTO_MULTIFRAME:
+		fmr1 |= PEF2256_FMR1_XFS;
+		fmr2 |= PEF2256_FMR2_RFS_AUTO_MULTIFRAME;
+		break;
+	default:
+		dev_err(pef2256->dev, "Unsupported frame type %d\n", pef2256->frame_type);
+		return -EINVAL;
+	}
+	pef2256_clrsetbits8(pef2256, PEF2256_FMR1, PEF2256_FMR1_XFS, fmr1);
+	pef2256_write8(pef2256, PEF2256_FMR2, fmr2);
+
+	if (!pef2256->is_subordinate) {
+		/* SEC input, active high */
+		pef2256_write8(pef2256, PEF2256_GPC1, PEF2256_GPC1_CSFP_SEC_IN_HIGH);
+	} else {
+		/* FSC output, active high */
+		pef2256_write8(pef2256, PEF2256_GPC1, PEF2256_GPC1_CSFP_FSC_OUT_HIGH);
+	}
+
+	/*
+	 * SCLKR, SCLKX, RCLK configured to inputs,
+	 * XFMS active low, CLK1 and CLK2 pin configuration
+	 */
+	pef2256_write8(pef2256, PEF2256_PC5, 0x00);
+	pef2256_write8(pef2256, PEF2256_PC6, 0x00);
+
+	/* port RCLK is output */
+	pef2256_setbits8(pef2256, PEF2256_PC5, PEF2256_PC5_CRP);
+
+	return 0;
+}
+
+static void pef2256_setup_e1_los(struct pef2256 *pef2256)
+{
+	/* detection of LOS alarm = 176 pulses (ie (10 + 1) * 16) */
+	pef2256_write8(pef2256, PEF2256_PCD, 10);
+	/* recovery of LOS alarm = 22 pulses (ie 21 + 1) */
+	pef2256_write8(pef2256, PEF2256_PCR, 21);
+	/* E1 default for the receive slicer threshold */
+	pef2256_write8(pef2256, PEF2256_LIM2, PEF2256_LIM2_SLT_THR50);
+	if (pef2256->is_subordinate) {
+		/* Loop-timed */
+		pef2256_setbits8(pef2256, PEF2256_LIM2, PEF2256_LIM2_ELT);
+	}
+}
+
+static int pef2256_setup_e1_system(struct pef2256 *pef2256)
+{
+	u8 sic1, fmr1;
+
+	/*
+	 * 2.048 MHz system clocking rate, receive buffer 2 frames, transmit
+	 * buffer bypass, data sampled and transmitted on the falling edge of
+	 * SCLKR/X, automatic freeze signaling, data is active in the first
+	 * channel phase
+	 */
+	pef2256_write8(pef2256, PEF2256_SIC1, 0x00);
+	pef2256_write8(pef2256, PEF2256_SIC2, 0x00);
+	pef2256_write8(pef2256, PEF2256_SIC3, 0x00);
+
+	if (pef2256->is_subordinate) {
+		/* transmit buffer size = 2 frames, transparent mode */
+		pef2256_clrsetbits8(pef2256, PEF2256_SIC1, PEF2256_SIC1_XBS_MASK,
+				    PEF2256_SIC1_XBS_2FRAMES);
+	}
+
+	if (pef2256->version != PEF2256_VERSION_1_2) {
+		/* during inactive channel phase switch RDO/RSIG into tri-state */
+		pef2256_setbits8(pef2256, PEF2256_SIC3, PEF2256_SIC3_RTRI);
+	}
+
+	if (pef2256->is_tx_falling_edge) {
+		/* falling edge sync pulse transmit, rising edge sync pulse receive */
+		pef2256_clrsetbits8(pef2256, PEF2256_SIC3, PEF2256_SIC3_RESX, PEF2256_SIC3_RESR);
+	} else {
+		/* rising edge sync pulse transmit, falling edge sync pulse receive */
+		pef2256_clrsetbits8(pef2256, PEF2256_SIC3, PEF2256_SIC3_RESR, PEF2256_SIC3_RESX);
+	}
+
+	/* transmit offset counter (XCO10..0) = 4 */
+	pef2256_write8(pef2256, PEF2256_XC0, 0);
+	pef2256_write8(pef2256, PEF2256_XC1, 4);
+	/* receive offset counter (RCO10..0) = 4 */
+	pef2256_write8(pef2256, PEF2256_RC0, 0);
+	pef2256_write8(pef2256, PEF2256_RC1, 4);
+
+	/* system clock rate */
+	switch (pef2256->sysclk_rate) {
+	case 2048000:
+		sic1 = PEF2256_SIC1_SSC_2048;
+		break;
+	case 4096000:
+		sic1 = PEF2256_SIC1_SSC_4096;
+		break;
+	case 8192000:
+		sic1 = PEF2256_SIC1_SSC_8192;
+		break;
+	case 16384000:
+		sic1 = PEF2256_SIC1_SSC_16384;
+		break;
+	default:
+		dev_err(pef2256->dev, "Unsupported sysclk rate %lu\n", pef2256->sysclk_rate);
+		return -EINVAL;
+	}
+	pef2256_clrsetbits8(pef2256, PEF2256_SIC1, PEF2256_SIC1_SSC_MASK, sic1);
+
+	/* data clock rate */
+	switch (pef2256->data_rate) {
+	case 2048000:
+		fmr1 = PEF2256_FMR1_SSD_2048;
+		sic1 = PEF2256_SIC1_SSD_2048;
+		break;
+	case 4096000:
+		fmr1 = PEF2256_FMR1_SSD_4096;
+		sic1 = PEF2256_SIC1_SSD_4096;
+		break;
+	case 8192000:
+		fmr1 = PEF2256_FMR1_SSD_8192;
+		sic1 = PEF2256_SIC1_SSD_8192;
+		break;
+	case 16384000:
+		fmr1 = PEF2256_FMR1_SSD_16384;
+		sic1 = PEF2256_SIC1_SSD_16384;
+		break;
+	default:
+		dev_err(pef2256->dev, "Unsupported data rate %u\n", pef2256->data_rate);
+		return -EINVAL;
+	}
+	pef2256_clrsetbits8(pef2256, PEF2256_FMR1, PEF2256_FMR1_SSD_MASK, fmr1);
+	pef2256_clrsetbits8(pef2256, PEF2256_SIC1, PEF2256_SIC1_SSD_MASK, sic1);
+
+	/* channel phase */
+	pef2256_clrsetbits8(pef2256, PEF2256_SIC2, PEF2256_SIC2_SICS_MASK,
+			    PEF2256_SIC2_SICS(pef2256->channel_phase));
+
+	return 0;
+}
+
+static void pef2256_setup_e1_signaling(struct pef2256 *pef2256)
+{
+	/* All bits of the transmitted service word are cleared */
+	pef2256_write8(pef2256, PEF2256_XSW, PEF2256_XSW_XY(0x1F));
+
+	/* CAS disabled and clear spare bit values */
+	pef2256_write8(pef2256, PEF2256_XSP, 0x00);
+
+	if (pef2256->is_subordinate) {
+		/* transparent mode */
+		pef2256_setbits8(pef2256, PEF2256_XSW, PEF2256_XSW_XTM);
+	}
+
+	/* Si-Bit, Spare bit For International, FAS word */
+	pef2256_setbits8(pef2256, PEF2256_XSW, PEF2256_XSW_XSIS);
+	pef2256_setbits8(pef2256, PEF2256_XSP, PEF2256_XSP_XSIF);
+
+	/* no transparent mode active */
+	pef2256_write8(pef2256, PEF2256_TSWM, 0x00);
+}
+
+static void pef2256_setup_e1_errors(struct pef2256 *pef2256)
+{
+	/* error counter latched every 1s */
+	pef2256_setbits8(pef2256, PEF2256_FMR1, PEF2256_FMR1_ECM);
+
+	/* error counter mode COFA */
+	pef2256_setbits8(pef2256, PEF2256_GCR, PEF2256_GCR_ECMC);
+
+	/* errors in service words have no influence */
+	pef2256_setbits8(pef2256, PEF2256_RC0, PEF2256_RC0_SWD);
+
+	/* 4 consecutive incorrect FAS causes loss of sync */
+	pef2256_setbits8(pef2256, PEF2256_RC0, PEF2256_RC0_ASY4);
+}
+
+static int pef2256_setup_e1(struct pef2256 *pef2256)
+{
+	int ret;
+
+	/* Setup, Master clocking mode (GCM8..1) */
+	ret = pef2256_setup_gcm(pef2256);
+	if (ret)
+		return ret;
+
+	/* Select E1 mode */
+	pef2256_write8(pef2256, PEF2256_FMR1, 0x00);
+
+	/* internal second timer, power on */
+	pef2256_write8(pef2256, PEF2256_GCR, 0x00);
+
+	/* Setup line interface */
+	ret = pef2256_setup_e1_line(pef2256);
+	if (ret)
+		return ret;
+
+	/* Setup Loss-of-signal detection and recovery */
+	pef2256_setup_e1_los(pef2256);
+
+	/* Setup system interface */
+	ret = pef2256_setup_e1_system(pef2256);
+	if (ret)
+		return ret;
+
+	/* Setup signaling */
+	pef2256_setup_e1_signaling(pef2256);
+
+	/* Setup errors counters and condition */
+	pef2256_setup_e1_errors(pef2256);
+
+	/* status changed interrupt at both up and down */
+	pef2256_setbits8(pef2256, PEF2256_GCR, PEF2256_GCR_SCI);
+
+	/* Clear any ISR2 pending interrupts and unmask needed interrupts */
+	pef2256_read8(pef2256, PEF2256_ISR2);
+	pef2256_clrbits8(pef2256, PEF2256_IMR2, PEF2256_INT2_LOS | PEF2256_INT2_AIS);
+
+	/* reset lines */
+	pef2256_write8(pef2256, PEF2256_CMDR, PEF2256_CMDR_RRES | PEF2256_CMDR_XRES);
+	return 0;
+}
+
+static int pef2256_setup(struct pef2256 *pef2256)
+{
+	if (pef2256->is_e1)
+		return pef2256_setup_e1(pef2256);
+
+	dev_err(pef2256->dev, "Only E1 line is currently supported\n");
+	return -EOPNOTSUPP;
+}
+
+static void pef2256_isr_default_handler(struct pef2256 *pef2256, u8 nbr, u8 isr)
+{
+	dev_warn(pef2256->dev, "ISR%u: 0x%02x not handled\n", nbr, isr);
+}
+
+static bool pef2256_is_carrier_on(struct pef2256 *pef2256)
+{
+	u8 frs0;
+
+	frs0 = pef2256_read8(pef2256, PEF2256_FRS0);
+	return !(frs0 & (PEF2256_FRS0_LOS | PEF2256_FRS0_AIS));
+}
+
+static void pef2256_isr2_handler(struct pef2256 *pef2256, u8 nbr, u8 isr)
+{
+	bool carrier;
+
+	if (isr & (PEF2256_INT2_LOS | PEF2256_INT2_AIS)) {
+		carrier = pef2256_is_carrier_on(pef2256);
+		if (atomic_xchg(&pef2256->carrier, carrier) != carrier)
+			atomic_notifier_call_chain(&pef2256->event_notifier_list,
+						   PEF2256_EVENT_CARRIER, NULL);
+	}
+}
+
+static irqreturn_t pef2256_irq_handler(int irq, void *priv)
+{
+	static void (*pef2256_isr_handler[])(struct pef2256 *, u8, u8) = {
+		[0] = pef2256_isr_default_handler,
+		[1] = pef2256_isr_default_handler,
+		[2] = pef2256_isr2_handler,
+		[3] = pef2256_isr_default_handler,
+		[4] = pef2256_isr_default_handler,
+		[5] = pef2256_isr_default_handler
+	};
+	struct pef2256 *pef2256 = (struct pef2256 *)priv;
+	u8 gis;
+	u8 isr;
+	u8 n;
+
+	gis = pef2256_read8(pef2256, PEF2256_GIS);
+
+	for (n = 0; n < ARRAY_SIZE(pef2256_isr_handler); n++) {
+		if (gis & PEF2256_GIS_ISR(n)) {
+			isr = pef2256_read8(pef2256, PEF2256_ISR(n));
+			pef2256_isr_handler[n](pef2256, n, isr);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int pef2256_check_rates(struct pef2256 *pef2256, unsigned long sysclk_rate,
+			       unsigned long data_rate)
+{
+	unsigned long rate;
+
+	switch (sysclk_rate) {
+	case 2048000:
+	case 4096000:
+	case 8192000:
+	case 16384000:
+		break;
+	default:
+		dev_err(pef2256->dev, "Unsupported system clock rate %lu\n", sysclk_rate);
+		return -EINVAL;
+	}
+
+	for (rate = data_rate; rate <= data_rate * 4; rate *= 2) {
+		if (rate == sysclk_rate)
+			return 0;
+	}
+	dev_err(pef2256->dev, "Unsupported data rate %lu with system clock rate %lu\n",
+		data_rate, sysclk_rate);
+	return -EINVAL;
+}
+
+static int pef2556_of_parse(struct pef2256 *pef2256, struct device_node *np)
+{
+	const char *str;
+	int ret;
+
+	str = "e1";
+	ret = of_property_read_string(np, "lantiq,line-interface", &str);
+	if (ret && ret != -EINVAL) {
+		dev_err(pef2256->dev, "%pOF: failed to read lantiq,line-interface\n",
+			np);
+		return ret;
+	}
+	if (!strcmp(str, "e1")) {
+		pef2256->is_e1 = true;
+	} else if (!strcmp(str, "t1j1")) {
+		pef2256->is_e1 = false;
+	} else {
+		dev_err(pef2256->dev, "%pOF: Invalid lantiq,line-interface (%s)\n",
+			np, str);
+		return -EINVAL;
+	}
+
+	pef2256->data_rate = 2048000;
+	ret = of_property_read_u32(np, "lantiq,data-rate-bps", &pef2256->data_rate);
+	if (ret && ret != -EINVAL) {
+		dev_err(pef2256->dev, "%pOF: failed to read lantiq,data-rate-bps\n", np);
+		return ret;
+	}
+
+	ret =  pef2256_check_rates(pef2256, pef2256->sysclk_rate, pef2256->data_rate);
+	if (ret)
+		return ret;
+
+	pef2256->is_tx_falling_edge = of_property_read_bool(np, "lantiq,clock-falling-edge");
+	pef2256->is_subordinate = of_property_read_bool(np, "lantiq,subordinate");
+
+	str = pef2256->is_e1 ? "doubleframe" : "12frame";
+	ret = of_property_read_string(np, "lantiq,frame-format", &str);
+	if (ret && ret != -EINVAL) {
+		dev_err(pef2256->dev, "%pOF: failed to read lantiq,frame-format\n",
+			np);
+		return ret;
+	}
+	if (pef2256->is_e1) {
+		if (!strcmp(str, "doubleframe")) {
+			pef2256->frame_type = PEF2256_FRAME_E1_DOUBLEFRAME;
+		} else if (!strcmp(str, "crc4-multiframe")) {
+			pef2256->frame_type = PEF2256_FRAME_E1_CRC4_MULTIFRAME;
+		} else if (!strcmp(str, "auto-multiframe")) {
+			pef2256->frame_type = PEF2256_FRAME_E1_AUTO_MULTIFRAME;
+		} else {
+			dev_err(pef2256->dev, "%pOF: Invalid lantiq,frame-format (%s)\n",
+				np, str);
+			return -EINVAL;
+		}
+	} else {
+		if (!strcmp(str, "4frame")) {
+			pef2256->frame_type = PEF2256_FRAME_T1J1_4FRAME;
+		} else if (!strcmp(str, "12frame")) {
+			pef2256->frame_type = PEF2256_FRAME_T1J1_12FRAME;
+		} else if (!strcmp(str, "24frame")) {
+			pef2256->frame_type = PEF2256_FRAME_T1J1_24FRAME;
+		} else if (!strcmp(str, "72frame")) {
+			pef2256->frame_type = PEF2256_FRAME_T1J1_72FRAME;
+		} else {
+			dev_err(pef2256->dev, "%pOF: Invalid lantiq,frame-format (%s)\n",
+				np, str);
+			return -EINVAL;
+		}
+	}
+
+	pef2256->channel_phase = 0;
+	ret = of_property_read_u8(np, "lantiq,channel-phase", &pef2256->channel_phase);
+	if (ret && ret != -EINVAL) {
+		dev_err(pef2256->dev, "%pOF: failed to read lantiq,channel-phase\n",
+			np);
+		return ret;
+	}
+	if (pef2256->channel_phase >= pef2256->sysclk_rate / pef2256->data_rate) {
+		dev_err(pef2256->dev, "%pOF: Invalid lantiq,channel-phase %u\n",
+			np, pef2256->channel_phase);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t subordinate_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct pef2256 *pef2256 = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", pef2256->is_subordinate);
+}
+
+static ssize_t subordinate_store(struct device *dev, struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct pef2256 *pef2256 = dev_get_drvdata(dev);
+	int ret;
+
+	if (strtobool(buf, &pef2256->is_subordinate) < 0)
+		return -EINVAL;
+
+	ret = pef2256_setup(pef2256);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(subordinate);
+
+static const struct attribute_group pef2256_attribute_group = {
+	.attrs = (struct attribute *[]) {
+		&dev_attr_subordinate.attr,
+		NULL,
+	},
+};
+
+static const struct regmap_config pef2256_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.max_register = 0xff,
+};
+
+static const struct mfd_cell pef2256_devs[] = {
+	{ .name = "lantiq-pef2256-pinctrl", },
+};
+
+static int pef2256_add_audio_devices(struct pef2256 *pef2256)
+{
+	const char *compatible = "lantiq,pef2256-codec";
+	struct mfd_cell *audio_devs;
+	struct device_node *np;
+	unsigned int count = 0;
+	unsigned int i;
+	int ret;
+
+	for_each_available_child_of_node(pef2256->dev->of_node, np) {
+		if (of_device_is_compatible(np, compatible))
+			count++;
+	}
+
+	if (!count)
+		return 0;
+
+	audio_devs = kcalloc(count, sizeof(*audio_devs), GFP_KERNEL);
+	if (!audio_devs)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		(audio_devs + i)->name = "lantiq-pef2256-codec";
+		(audio_devs + i)->of_compatible = compatible;
+		(audio_devs + i)->id = i;
+	}
+
+	ret = mfd_add_devices(pef2256->dev, 0, audio_devs, count, NULL, 0, NULL);
+	kfree(audio_devs);
+	return ret;
+}
+
+static int pef2256_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	unsigned long sclkr_rate, sclkx_rate;
+	struct pef2256 *pef2256;
+	const char *version_txt;
+	void __iomem *iomem;
+	int ret;
+	int irq;
+
+	pef2256 = devm_kzalloc(&pdev->dev, sizeof(*pef2256), GFP_KERNEL);
+	if (!pef2256)
+		return -ENOMEM;
+
+	pef2256->dev = &pdev->dev;
+	ATOMIC_INIT_NOTIFIER_HEAD(&pef2256->event_notifier_list);
+	atomic_set(&pef2256->carrier, 0);
+
+	iomem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(iomem))
+		return PTR_ERR(iomem);
+
+	pef2256->regmap = devm_regmap_init_mmio(&pdev->dev, iomem,
+						&pef2256_regmap_config);
+	if (IS_ERR(pef2256->regmap)) {
+		dev_err(&pdev->dev, "Failed to initialise Regmap (%ld)\n",
+			PTR_ERR(pef2256->regmap));
+		return PTR_ERR(pef2256->regmap);
+	}
+
+	pef2256->mclk = devm_clk_get_enabled(&pdev->dev, "mclk");
+	if (IS_ERR(pef2256->mclk))
+		return PTR_ERR(pef2256->mclk);
+
+	pef2256->sclkr = devm_clk_get_enabled(&pdev->dev, "sclkr");
+	if (IS_ERR(pef2256->sclkr))
+		return PTR_ERR(pef2256->sclkr);
+
+	pef2256->sclkx = devm_clk_get_enabled(&pdev->dev, "sclkx");
+	if (IS_ERR(pef2256->sclkx))
+		return PTR_ERR(pef2256->sclkx);
+
+	/*
+	 * Both SCLKR (receive) and SCLKX (transmit) must have the same rate,
+	 * stored as sysclk_rate.
+	 * The exact value will be checked at pef2256_check_rates()
+	 */
+	sclkr_rate = clk_get_rate(pef2256->sclkr);
+	sclkx_rate = clk_get_rate(pef2256->sclkx);
+	if (sclkr_rate != sclkx_rate) {
+		dev_err(pef2256->dev, "clk rate mismatch. sclkr %lu Hz, sclkx %lu Hz\n",
+			sclkr_rate, sclkx_rate);
+		return -EINVAL;
+	}
+	pef2256->sysclk_rate = sclkr_rate;
+
+	/* Reset the component. The MCLK clock must be active during reset */
+	pef2256->reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(pef2256->reset_gpio))
+		return PTR_ERR(pef2256->reset_gpio);
+	if (pef2256->reset_gpio) {
+		gpiod_set_value_cansleep(pef2256->reset_gpio, 1);
+		usleep_range(10, 20);
+		gpiod_set_value_cansleep(pef2256->reset_gpio, 0);
+		usleep_range(10, 20);
+	}
+
+	pef2256->version = pef2256_get_version(pef2256);
+	switch (pef2256->version) {
+	case PEF2256_VERSION_1_2:
+		version_txt = "1.2";
+		break;
+	case PEF2256_VERSION_2_1:
+		version_txt = "2.1";
+		break;
+	case PEF2256_VERSION_2_2:
+		version_txt = "2.2";
+		break;
+	default:
+		return -ENODEV;
+	}
+	dev_info(pef2256->dev, "Version %s detected\n", version_txt);
+
+	ret = pef2556_of_parse(pef2256, np);
+	if (ret)
+		return ret;
+
+	/* Disable interrupts */
+	pef2256_write8(pef2256, PEF2256_IMR0, 0xff);
+	pef2256_write8(pef2256, PEF2256_IMR1, 0xff);
+	pef2256_write8(pef2256, PEF2256_IMR2, 0xff);
+	pef2256_write8(pef2256, PEF2256_IMR3, 0xff);
+	pef2256_write8(pef2256, PEF2256_IMR4, 0xff);
+	pef2256_write8(pef2256, PEF2256_IMR5, 0xff);
+
+	/* Clear any pending interrupts */
+	pef2256_read8(pef2256, PEF2256_ISR0);
+	pef2256_read8(pef2256, PEF2256_ISR1);
+	pef2256_read8(pef2256, PEF2256_ISR2);
+	pef2256_read8(pef2256, PEF2256_ISR3);
+	pef2256_read8(pef2256, PEF2256_ISR4);
+	pef2256_read8(pef2256, PEF2256_ISR5);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+	ret = devm_request_irq(pef2256->dev, irq, pef2256_irq_handler, 0, "pef2256", pef2256);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, pef2256);
+
+	ret = mfd_add_devices(pef2256->dev, 0, pef2256_devs,
+			      ARRAY_SIZE(pef2256_devs), NULL, 0, NULL);
+	if (ret) {
+		dev_err(pef2256->dev, "add devices failed (%d)\n", ret);
+		return ret;
+	}
+
+	ret = pef2256_setup(pef2256);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_group(&pef2256->dev->kobj, &pef2256_attribute_group);
+	if (ret < 0) {
+		dev_err(pef2256->dev, "sysfs registration failed (%d)\n", ret);
+		return ret;
+	}
+
+	/* Add audio devices */
+	ret = pef2256_add_audio_devices(pef2256);
+	if (ret < 0) {
+		dev_err(pef2256->dev, "add audio devices failed (%d)\n", ret);
+		goto remove_sysfs_group;
+	}
+
+	return 0;
+
+remove_sysfs_group:
+	sysfs_remove_group(&pef2256->dev->kobj, &pef2256_attribute_group);
+	return ret;
+}
+
+static int pef2256_remove(struct platform_device *pdev)
+{
+	struct pef2256 *pef2256 = platform_get_drvdata(pdev);
+
+	/* Disable interrupts */
+	pef2256_write8(pef2256, PEF2256_IMR0, 0xff);
+	pef2256_write8(pef2256, PEF2256_IMR1, 0xff);
+	pef2256_write8(pef2256, PEF2256_IMR2, 0xff);
+	pef2256_write8(pef2256, PEF2256_IMR3, 0xff);
+	pef2256_write8(pef2256, PEF2256_IMR4, 0xff);
+	pef2256_write8(pef2256, PEF2256_IMR5, 0xff);
+
+	sysfs_remove_group(&pef2256->dev->kobj, &pef2256_attribute_group);
+
+	return 0;
+}
+
+static const struct of_device_id pef2256_id_table[] = {
+	{ .compatible = "lantiq,pef2256" },
+	{} /* sentinel */
+};
+MODULE_DEVICE_TABLE(of, pef2256_id_table);
+
+static struct platform_driver pef2256_driver = {
+	.driver = {
+		.name = "lantiq-pef2256",
+		.of_match_table = pef2256_id_table,
+	},
+	.probe = pef2256_probe,
+	.remove = pef2256_remove,
+};
+module_platform_driver(pef2256_driver);
+
+struct regmap *pef2256_get_regmap(struct pef2256 *pef2256)
+{
+	return pef2256->regmap;
+}
+EXPORT_SYMBOL_GPL(pef2256_get_regmap);
+
+int pef2256_register_event_notifier(struct pef2256 *pef2256, struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&pef2256->event_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(pef2256_register_event_notifier);
+
+int pef2256_unregister_event_notifier(struct pef2256 *pef2256, struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&pef2256->event_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(pef2256_unregister_event_notifier);
+
+bool pef2256_get_carrier(struct pef2256 *pef2256)
+{
+	return !!atomic_read(&pef2256->carrier);
+}
+EXPORT_SYMBOL_GPL(pef2256_get_carrier);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("PEF2256 driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/pef2256.h b/include/linux/mfd/pef2256.h
new file mode 100644
index 000000000000..9931a7116751
--- /dev/null
+++ b/include/linux/mfd/pef2256.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * PEF2256 consumer API
+ *
+ * Copyright 2023 CS GROUP France
+ *
+ * Author: Herve Codina <herve.codina@bootlin.com>
+ */
+#ifndef __PEF2256_H__
+#define __PEF2256_H__
+
+#include <linux/types.h>
+
+struct pef2256;
+struct notifier_block;
+struct regmap;
+
+/* Retrieve the PEF2256 regmap */
+struct regmap *pef2256_get_regmap(struct pef2256 *pef2256);
+
+/* PEF2256 hardware versions */
+enum pef2256_version {
+	PEF2256_VERSION_UNKNOWN,
+	PEF2256_VERSION_1_2,
+	PEF2256_VERSION_2_1,
+	PEF2256_VERSION_2_2,
+};
+
+/* Get the PEF2256 hardware version */
+enum pef2256_version pef2256_get_version(struct pef2256 *pef2256);
+
+/* Event signaled by the PEF2256 notifier */
+enum pef2256_event {
+	PEF2256_EVENT_CARRIER, /* Carrier state changed */
+};
+
+/*
+ * Register/unregister an event notitifier.
+ * The nb.notifier_call function registered must not sleep.
+ * The 'action' parameter of the nb.notifier_call function will be set to one
+ * of the enum pef2256_event values.
+ */
+int pef2256_register_event_notifier(struct pef2256 *pef2256, struct notifier_block *nb);
+int pef2256_unregister_event_notifier(struct pef2256 *pef2256, struct notifier_block *nb);
+
+/*
+ * Retrieve the PEF2256 carrier state.
+ * Returns true: carrier on, false: carrier off
+ */
+bool pef2256_get_carrier(struct pef2256 *pef2256);
+
+#endif /* __PEF2256_H__ */
-- 
2.39.2

