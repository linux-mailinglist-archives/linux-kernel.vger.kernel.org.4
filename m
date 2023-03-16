Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83C6BCF6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCPM2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCPM2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:28:07 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD9BBAD30;
        Thu, 16 Mar 2023 05:27:59 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 285431BF207;
        Thu, 16 Mar 2023 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678969678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/YAq0XunAetuC/QVSME5G7XtaY3CrHyvdEz9siX8pBY=;
        b=Ef3340DI+P6LXKoyUHWVdFNUJLUd9qT5F+a9bd4lTlg8xtHB4K3eWDgRfgfFyFIV2PqdVk
        WCVaILvCiQ0UPLXSbooT5DrnQxOHtIgOw11kAwIctsKufPqX49RFOArB11PGAsu+pDUaCP
        juwt8tMtpmPZatqzvz/GMMAhTdrKEszlB320/1YQZ3LKMuMouO1xrrKODxfpt0Ucv+qYTr
        zQxyjFZlM8EuF8PfwFspmswmki6OOCNIbEwtt2K9JET+WN0l4oOfaj2ZITUgi+jOHizxJu
        mu0nVcRpS6XQ95tdQctPD/BysV2y2i9kp0WyvX/EdZ3dgL6JtERPktY7uAItyA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 2/7] drivers: misc: Add support for the Lantiq PEF2256 framer
Date:   Thu, 16 Mar 2023 13:27:36 +0100
Message-Id: <20230316122741.577663-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316122741.577663-1-herve.codina@bootlin.com>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/misc/Kconfig    |   17 +
 drivers/misc/Makefile   |    1 +
 drivers/misc/pef2256.c  | 1441 +++++++++++++++++++++++++++++++++++++++
 include/linux/pef2256.h |   36 +
 4 files changed, 1495 insertions(+)
 create mode 100644 drivers/misc/pef2256.c
 create mode 100644 include/linux/pef2256.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 433aa4197785..f03739163c53 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -376,6 +376,23 @@ config HMC6352
 	  This driver provides support for the Honeywell HMC6352 compass,
 	  providing configuration and heading data via sysfs.
 
+config PEF2256
+	tristate "Lantiq PEF2256 (FALC56) framer"
+	depends on HAS_IOMEM
+	select PINCTRL
+	select PINMUX
+	select GENERIC_PINCONF
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
 config DS1682
 	tristate "Dallas DS1682 Total Elapsed Time Recorder with Alarm"
 	depends on I2C
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 56de43943cd5..a26f044ab9dd 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 obj-$(CONFIG_DS1682)		+= ds1682.o
 obj-$(CONFIG_C2PORT)		+= c2port/
 obj-$(CONFIG_HMC6352)		+= hmc6352.o
+obj-$(CONFIG_PEF2256)		+= pef2256.o
 obj-y				+= eeprom/
 obj-y				+= cb710/
 obj-$(CONFIG_VMWARE_BALLOON)	+= vmw_balloon.o
diff --git a/drivers/misc/pef2256.c b/drivers/misc/pef2256.c
new file mode 100644
index 000000000000..b21586084408
--- /dev/null
+++ b/drivers/misc/pef2256.c
@@ -0,0 +1,1441 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PEF2256 also known as FALC56 driver
+ *
+ * Copyright 2023 CS GROUP France
+ *
+ * Author: Herve Codina <herve.codina@bootlin.com>
+ */
+
+#include <linux/pef2256.h>
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define PEF2256_CMDR		0x02 /* Command Register */
+#define   PEF2256_CMDR_RRES	  BIT(6)
+#define   PEF2256_CMDR_XRES	  BIT(4)
+#define   PEF2256_CMDR_SRES	  BIT(0)
+#define PEF2256_IMR0	        0x14 /* Interrupt Mask Register 0 */
+#define PEF2256_IMR1	        0x15 /* Interrupt Mask Register 1 */
+#define PEF2256_IMR2	        0x16 /* Interrupt Mask Register 2 */
+#define PEF2256_IMR3	        0x17 /* Interrupt Mask Register 3 */
+#define PEF2256_IMR4	        0x18 /* Interrupt Mask Register 4 */
+#define PEF2256_IMR5	        0x19 /* Interrupt Mask Register 5 */
+#define PEF2256_FMR0	        0x1C /* Framer Mode Register 0 */
+#define   PEF2256_FMR0_XC_MASK	  (0x3 << 6)
+#define     PEF2256_FMR0_XC_NRZ	    (0x0 << 6)
+#define     PEF2256_FMR0_XC_CMI	    (0x1 << 6)
+#define     PEF2256_FMR0_XC_AMI	    (0x2 << 6)
+#define     PEF2256_FMR0_XC_HDB3    (0x3 << 6)
+#define   PEF2256_FMR0_RC_MASK	  (0x3 << 4)
+#define     PEF2256_FMR0_RC_NRZ	    (0x0 << 4)
+#define     PEF2256_FMR0_RC_CMI	    (0x1 << 4)
+#define     PEF2256_FMR0_RC_AMI	    (0x2 << 4)
+#define     PEF2256_FMR0_RC_HDB3    (0x3 << 4)
+#define PEF2256_FMR1	        0x1D /* Framer Mode Register 1 */
+#define   PEF2256_FMR1_XFS	  BIT(3)
+#define   PEF2256_FMR1_ECM	  BIT(2)
+/* SSD is defined on 2 bits. The other bit is on SIC1 register */
+#define   PEF2256_FMR1_SSD_MASK   BIT(1)
+#define     PEF2256_FMR1_SSD_2048   0
+#define     PEF2256_FMR1_SSD_4096   BIT(1)
+#define     PEF2256_FMR1_SSD_8192   0
+#define     PEF2256_FMR1_SSD_16384  BIT(1)
+#define PEF2256_FMR2	        0x1E /* Framer Mode Register 2 */
+#define   PEF2256_FMR2_RFS_MASK	  (0x3 << 6)
+#define     PEF2256_FMR2_RFS_DOUBLEFRAME      (0x0 << 6)
+#define     PEF2256_FMR2_RFS_CRC4_MULTIFRAME  (0x2 << 6)
+#define     PEF2256_FMR2_RFS_AUTO_MULTIFRAME  (0x3 << 6)
+#define   PEF2256_FMR2_AXRA	  BIT(1)
+#define PEF2256_LOOP	        0x1F /* Channel Loop-Back */
+#define PEF2256_XSW	        0x20 /* Transmit Service Word */
+#define   PEF2256_XSW_XSIS	  BIT(7)
+#define   PEF2256_XSW_XTM	  BIT(6)
+#define   PEF2256_XSW_XY_MASK	  (0x1f << 0)
+#define     PEF2256_XSW_XY(_v)	    ((_v) & 0x1f)
+#define PEF2256_XSP	        0x21 /* Transmit Spare Bits */
+#define   PEF2256_XSP_XSIF	  BIT(2)
+#define PEF2256_XC0	        0x22 /* Transmit Control 0 */
+#define PEF2256_XC1	        0x23 /* Transmit Control 1 */
+#define PEF2256_RC0	        0x24 /* Receive Control 0 */
+#define   PEF2256_RC0_SWD	  BIT(7)
+#define   PEF2256_RC0_ASY4	  BIT(6)
+#define PEF2256_RC1	        0x25 /* Receive Control 1 */
+#define PEF2256_XPM0	        0x26 /* Transmit Pulse Mask 0 */
+#define PEF2256_XPM1	        0x27 /* Transmit Pulse Mask 1 */
+#define PEF2256_XPM2	        0x28 /* Transmit Pulse Mask 2 */
+#define   PEF2256_XPM2_XLT	  BIT(6)
+#define PEF2256_TSWM	        0x29 /* Transparent Service Word Mask */
+#define PEF2256_LIM0	        0x36 /* Line Interface Mode 0 */
+#define   PEF2256_2X_LIM0_BIT3	  BIT(3) /* v2.x, described as a forced '1' bit */
+#define   PEF2256_LIM0_MAS	  BIT(0)
+#define PEF2256_LIM1	        0x37 /* Line Interface Mode 1 */
+#define   PEF2256_12_LIM1_RIL_MASK   (0x7 << 4)
+#define     PEF2256_12_LIM1_RIL_910    (0x0 << 4)
+#define     PEF2256_12_LIM1_RIL_740    (0x1 << 4)
+#define     PEF2256_12_LIM1_RIL_590    (0x2 << 4)
+#define     PEF2256_12_LIM1_RIL_420    (0x3 << 4)
+#define     PEF2256_12_LIM1_RIL_320    (0x4 << 4)
+#define     PEF2256_12_LIM1_RIL_210    (0x5 << 4)
+#define     PEF2256_12_LIM1_RIL_160    (0x6 << 4)
+#define     PEF2256_12_LIM1_RIL_100    (0x7 << 4)
+#define   PEF2256_2X_LIM1_RIL_MASK   (0x7 << 4)
+#define     PEF2256_2X_LIM1_RIL_2250   (0x0 << 4)
+#define     PEF2256_2X_LIM1_RIL_1100   (0x1 << 4)
+#define     PEF2256_2X_LIM1_RIL_600    (0x2 << 4)
+#define     PEF2256_2X_LIM1_RIL_350    (0x3 << 4)
+#define     PEF2256_2X_LIM1_RIL_210    (0x4 << 4)
+#define     PEF2256_2X_LIM1_RIL_140    (0x5 << 4)
+#define     PEF2256_2X_LIM1_RIL_100    (0x6 << 4)
+#define     PEF2256_2X_LIM1_RIL_50     (0x7 << 4)
+#define PEF2256_PCD	        0x38 /* Pulse Count Detection */
+#define PEF2256_PCR	        0x39 /* Pulse Count Recovery */
+#define PEF2256_LIM2	        0x3A /* Line Interface Mode 2 */
+#define   PEF2256_LIM2_SLT_MASK	  (0x3 << 4)
+#define     PEF2256_LIM2_SLT_THR55  (0x0 << 4)
+#define     PEF2256_LIM2_SLT_THR67  (0x1 << 4)
+#define     PEF2256_LIM2_SLT_THR50  (0x2 << 4)
+#define     PEF2256_LIM2_SLT_THR45  (0x3 << 4)
+#define   PEF2256_LIM2_ELT	  BIT(2)
+#define PEF2256_SIC1	        0x3E /* System Interface Control 1 */
+#define   PEF2256_SIC1_SSC_MASK   (BIT(7) |  BIT(3))
+#define     PEF2256_SIC1_SSC_2048   (0)
+#define     PEF2256_SIC1_SSC_4096   BIT(3)
+#define     PEF2256_SIC1_SSC_8192   BIT(7)
+#define     PEF2256_SIC1_SSC_16384  (BIT(7) |  BIT(3))
+/* SSD is defined on 2 bits. The other bit is on FMR1 register */
+#define   PEF2256_SIC1_SSD_MASK   BIT(6)
+#define     PEF2256_SIC1_SSD_2048   0
+#define     PEF2256_SIC1_SSD_4096   0
+#define     PEF2256_SIC1_SSD_8192   BIT(6)
+#define     PEF2256_SIC1_SSD_16384  BIT(6)
+#define   PEF2256_SIC1_RBS_MASK	  (0x3 << 4)
+#define     PEF2256_SIC1_RBS_2FRAMES (0x0 << 4)
+#define     PEF2256_SIC1_RBS_1FRAME  (0x1 << 4)
+#define     PEF2256_SIC1_RBS_96BITS  (0x2 << 4)
+#define     PEF2256_SIC1_RBS_BYPASS  (0x3 << 4)
+#define   PEF2256_SIC1_XBS_MASK	  (0x3 << 0)
+#define     PEF2256_SIC1_XBS_BYPASS  (0x0 << 0)
+#define     PEF2256_SIC1_XBS_1FRAME  (0x1 << 0)
+#define     PEF2256_SIC1_XBS_2FRAMES (0x2 << 0)
+#define     PEF2256_SIC1_XBS_96BITS  (0x3 << 0)
+#define PEF2256_SIC2	        0x3F /* System Interface Control 2 */
+#define   PEF2256_SIC2_SICS_MASK       (0x7 << 1)
+#define     PEF2256_SIC2_SICS(_v)        ((_v) << 1)
+#define PEF2256_SIC3	        0x40 /* System Interface Control 3 */
+#define   PEF2256_SIC3_RTRI	  BIT(5)
+#define   PEF2256_SIC3_RESX	  BIT(3)
+#define   PEF2256_SIC3_RESR	  BIT(2)
+#define PEF2256_CMR1	        0x44 /* Clock Mode Register 1 */
+#define   PEF2256_CMR1_RS_MASK	  (0x3 << 4)
+#define     PEF2256_CMR1_RS_DPLL	   (0x0 << 4)
+#define     PEF2256_CMR1_RS_DPLL_LOS_HIGH  (0x1 << 4)
+#define     PEF2256_CMR1_RS_DCOR_2048	   (0x2 << 4)
+#define     PEF2256_CMR1_RS_DCOR_8192	   (0x3 << 4)
+#define   PEF2256_CMR1_DCS	  BIT(3)
+#define PEF2256_CMR2	        0x45 /* Clock Mode Register 2 */
+#define   PEF2256_CMR2_DCOXC	  BIT(5)
+#define PEF2256_GCR	        0x46 /* Global Configuration Register */
+#define   PEF2256_GCR_SCI	  BIT(6)
+#define   PEF2256_GCR_ECMC	  BIT(4)
+#define PEF2256_PC1	        0x80 /* Port Configuration 1 */
+#define PEF2256_PC2	        0x81 /* Port Configuration 2 */
+#define PEF2256_PC3	        0x82 /* Port Configuration 3 */
+#define PEF2256_PC4	        0x83 /* Port Configuration 4 */
+#define   PEF2256_12_PC_RPC_MASK  (0x7 << 4)
+#define     PEF2256_12_PC_RPC_SYPR	(0x0 << 4)
+#define     PEF2256_12_PC_RPC_RFM	(0x1 << 4)
+#define     PEF2256_12_PC_RPC_RFMB	(0x2 << 4)
+#define     PEF2256_12_PC_RPC_RSIGM	(0x3 << 4)
+#define     PEF2256_12_PC_RPC_RSIG	(0x4 << 4)
+#define     PEF2256_12_PC_RPC_DLR	(0x5 << 4)
+#define     PEF2256_12_PC_RPC_FREEZE	(0x6 << 4)
+#define     PEF2256_12_PC_RPC_RFSP	(0x7 << 4)
+#define   PEF2256_12_PC_XPC_MASK  (0xf << 0)
+#define     PEF2256_12_PC_XPC_SYPX	(0x0 << 0)
+#define     PEF2256_12_PC_XPC_XFMS	(0x1 << 0)
+#define     PEF2256_12_PC_XPC_XSIG	(0x2 << 0)
+#define     PEF2256_12_PC_XPC_TCLK	(0x3 << 0)
+#define     PEF2256_12_PC_XPC_XMFB	(0x4 << 0)
+#define     PEF2256_12_PC_XPC_XSIGM	(0x5 << 0)
+#define     PEF2256_12_PC_XPC_DLX	(0x6 << 0)
+#define     PEF2256_12_PC_XPC_XCLK	(0x7 << 0)
+#define     PEF2256_12_PC_XPC_XLT	(0x8 << 0)
+#define   PEF2256_2X_PC_RPC_MASK  (0xf << 4)
+#define     PEF2256_2X_PC_RPC_SYPR	(0x0 << 4)
+#define     PEF2256_2X_PC_RPC_RFM	(0x1 << 4)
+#define     PEF2256_2X_PC_RPC_RFMB	(0x2 << 4)
+#define     PEF2256_2X_PC_RPC_RSIGM	(0x3 << 4)
+#define     PEF2256_2X_PC_RPC_RSIG	(0x4 << 4)
+#define     PEF2256_2X_PC_RPC_DLR	(0x5 << 4)
+#define     PEF2256_2X_PC_RPC_FREEZE	(0x6 << 4)
+#define     PEF2256_2X_PC_RPC_RFSP	(0x7 << 4)
+#define     PEF2256_2X_PC_RPC_GPI	(0x9 << 4)
+#define     PEF2256_2X_PC_RPC_GPOH	(0xa << 4)
+#define     PEF2256_2X_PC_RPC_GPOL	(0xb << 4)
+#define     PEF2256_2X_PC_RPC_LOS	(0xc << 4)
+#define   PEF2256_2X_PC_XPC_MASK  (0xf << 0)
+#define     PEF2256_2X_PC_XPC_SYPX	(0x0 << 0)
+#define     PEF2256_2X_PC_XPC_XFMS	(0x1 << 0)
+#define     PEF2256_2X_PC_XPC_XSIG	(0x2 << 0)
+#define     PEF2256_2X_PC_XPC_TCLK	(0x3 << 0)
+#define     PEF2256_2X_PC_XPC_XMFB	(0x4 << 0)
+#define     PEF2256_2X_PC_XPC_XSIGM	(0x5 << 0)
+#define     PEF2256_2X_PC_XPC_DLX	(0x6 << 0)
+#define     PEF2256_2X_PC_XPC_XCLK	(0x7 << 0)
+#define     PEF2256_2X_PC_XPC_XLT	(0x8 << 0)
+#define     PEF2256_2X_PC_XPC_GPI	(0x9 << 0)
+#define     PEF2256_2X_PC_XPC_GPOH	(0xa << 0)
+#define     PEF2256_2X_PC_XPC_GPOL	(0xb << 0)
+#define PEF2256_PC5	        0x84 /* Port Configuration 5 */
+#define   PEF2256_PC5_CRP         BIT(0)
+#define PEF2256_GPC1	        0x85 /* Global Port Configuration 1 */
+#define   PEF2256_GPC1_CSFP_MASK	  (0x3 << 5)
+#define   PEF2256_GPC1_CSFP_SEC_IN_HIGH   (0x0 << 5)
+#define   PEF2256_GPC1_CSFP_SEC_OUT_HIGH  (0x1 << 5)
+#define   PEF2256_GPC1_CSFP_FSC_OUT_HIGH  (0x2 << 5)
+#define   PEF2256_GPC1_CSFP_FSC_OUT_LOW   (0x3 << 5)
+#define PEF2256_PC6	        0x86 /* Port Configuration 6 */
+#define PEF2256_GCM(_n)         (0x92 + _n - 1) /* Global Counter Mode n=1..8 */
+#define PEF2256_GCM1	        0x92 /* Global Counter Mode 1 */
+#define PEF2256_GCM2	        0x93 /* Global Counter Mode 2 */
+#define PEF2256_GCM3	        0x94 /* Global Counter Mode 3 */
+#define PEF2256_GCM4	        0x95 /* Global Counter Mode 4 */
+#define PEF2256_GCM5	        0x96 /* Global Counter Mode 5 */
+#define PEF2256_GCM6	        0x97 /* Global Counter Mode 6 */
+#define PEF2256_GCM7	        0x98 /* Global Counter Mode 7 */
+#define PEF2256_GCM8	        0x99 /* Global Counter Mode 8 */
+
+#define PEF2256_VSTR	0x4A /* Version Status Register */
+#define   PEF2256_VSTR_VERSION_12  0x00
+#define   PEF2256_VSTR_VERSION_21  0x10
+#define   PEF2256_VSTR_VERSION_2x  0x05
+#define PEF2256_FRS0	0x4C /* Framer Receive Status 0 */
+#define   PEF2256_FRS0_LOS	BIT(7)
+#define   PEF2256_FRS0_AIS	BIT(6)
+#define PEF2256_ISR(_n) (0x68 + n) /* Interrupt Status Register (n=0..5) */
+#define PEF2256_ISR0	0x68 /* Interrupt Status Register 0 */
+#define PEF2256_ISR1	0x69 /* Interrupt Status Register 1 */
+#define PEF2256_ISR2	0x6A /* Interrupt Status Register 2 */
+#define PEF2256_ISR3	0x6B /* Interrupt Status Register 3 */
+#define PEF2256_ISR4	0x6C /* Interrupt Status Register 4 */
+#define PEF2256_ISR5	0x6D /* Interrupt Status Register 5 */
+#define PEF2256_GIS	0x6E /* Global Interrupt Status */
+#define   PEF2256_GIS_ISR(_n)	(1<<(n))
+#define PEF2256_WID	0xEC /* Wafer Identification Register */
+#define   PEF2256_12_WID_MASK        0x03
+#define     PEF2256_12_WID_VERSION_12  0x03
+#define   PEF2256_2X_WID_MASK        0xc0
+#define     PEF2256_2X_WID_VERSION_21  0x00
+#define     PEF2256_2X_WID_VERSION_22  0x40
+
+/* IMR2/ISR2 Interrupts */
+#define PEF2256_INT2_AIS  BIT(3)
+#define PEF2256_INT2_LOS  BIT(2)
+
+enum pef2256_version {
+	PEF2256_VERSION_UNKNOWN,
+	PEF2256_VERSION_1_2,
+	PEF2256_VERSION_2_1,
+	PEF2256_VERSION_2_2,
+};
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
+struct pef2256_pinreg_desc {
+	int offset;
+	u8 mask;
+};
+
+struct pef2256_function_desc {
+	const char *name;
+	const char * const*groups;
+	unsigned int ngroups;
+	u8 func_val;
+};
+
+struct pef2256 {
+	struct device *dev;
+	void *__iomem regs;
+	enum pef2256_version version;
+	spinlock_t lock;
+	struct clk *mclk;
+	struct gpio_desc *reset_gpio;
+	struct {
+		struct pinctrl_desc pctrl_desc;
+		const struct pef2256_function_desc *functions;
+		unsigned int nfunctions;
+	} pinctrl;
+	bool is_e1;
+	u32 sysclk_rate;
+	u32 data_rate;
+	bool is_tx_falling_edge;
+	bool is_subordinate;
+	enum pef2256_frame_type frame_type;
+	u8 channel_phase;
+	bool is_carrier_on;
+	struct atomic_notifier_head event_notifier_list;
+};
+
+static inline u8 pef2256_read8(struct pef2256 *pef2256, int offset)
+{
+	return ioread8(pef2256->regs + offset);
+}
+
+static inline void pef2256_write8(struct pef2256 *pef2256, int offset, u8 val)
+{
+	iowrite8(val, pef2256->regs + offset);
+}
+
+static inline void pef2256_clrbits8(struct pef2256 *pef2256, int offset, u8 clr)
+{
+	u8 v;
+
+	v = pef2256_read8(pef2256, offset);
+	v &= ~clr;
+	pef2256_write8(pef2256, offset, v);
+}
+
+static inline void pef2256_setbits8(struct pef2256 *pef2256, int offset, u8 set)
+{
+	u8 v;
+
+	v = pef2256_read8(pef2256, offset);
+	v |= set;
+	pef2256_write8(pef2256, offset, v);
+}
+
+
+static inline void pef2256_clrsetbits8(struct pef2256 *pef2256, int offset, u8 clr, u8 set)
+{
+	u8 v;
+
+	v = pef2256_read8(pef2256, offset);
+	v &= ~clr;
+	v |= set;
+	pef2256_write8(pef2256, offset, v);
+}
+
+static enum pef2256_version pef2256_get_version(struct pef2256 *pef2256)
+{
+	enum pef2256_version version;
+	const char *version_txt;
+	u8 vstr, wid;
+
+	vstr = pef2256_read8(pef2256, PEF2256_VSTR);
+	wid = pef2256_read8(pef2256, PEF2256_WID);
+
+	switch (vstr) {
+	case PEF2256_VSTR_VERSION_12:
+		if ((wid & PEF2256_12_WID_MASK) == PEF2256_12_WID_VERSION_12) {
+			version_txt = "1.2";
+			version = PEF2256_VERSION_1_2;
+			goto end;
+		}
+		break;
+	case PEF2256_VSTR_VERSION_2x:
+		switch (wid & PEF2256_2X_WID_MASK) {
+		case PEF2256_2X_WID_VERSION_21:
+			version_txt = "2.1 (2.x)";
+			version = PEF2256_VERSION_2_1;
+			goto end;
+		case PEF2256_2X_WID_VERSION_22:
+			version_txt = "2.2 (2.x)";
+			version = PEF2256_VERSION_2_2;
+			goto end;
+		default:
+			break;
+		}
+		break;
+	case PEF2256_VSTR_VERSION_21:
+		version_txt = "2.1";
+		version = PEF2256_VERSION_2_1;
+		goto end;
+	default:
+		break;
+	}
+
+	dev_err(pef2256->dev, "Unknown version (0x%02x, 0x%02x)\n", vstr, wid);
+	return PEF2256_VERSION_UNKNOWN;
+
+end:
+	dev_info(pef2256->dev, "Version %s detected\n", version_txt);
+	return version;
+}
+
+static int pef2256_12_setup_gcm(struct pef2256 *pef2256)
+{
+	static const u8 gcm_1544000[6] = {0xF0, 0x51, 0x00, 0x80, 0x00, 0x15};
+	static const u8 gcm_2048000[6] = {0x00, 0x58, 0xD2, 0xC2, 0x00, 0x10};
+	static const u8 gcm_8192000[6] = {0x00, 0x58, 0xD2, 0xC2, 0x03, 0x10};
+	static const u8 gcm_10000000[6] = {0x90, 0x51, 0x81, 0x8F, 0x04, 0x10};
+	static const u8 gcm_12352000[6] = {0xF0, 0x51, 0x00, 0x80, 0x07, 0x15};
+	static const u8 gcm_16384000[6] = {0x00, 0x58, 0xD2, 0xC2, 0x07, 0x10};
+	unsigned long mclk_rate;
+	const u8 *gcm;
+	int i;
+
+	mclk_rate = clk_get_rate(pef2256->mclk);
+	switch (mclk_rate) {
+	case 1544000:
+		gcm = gcm_1544000;
+		break;
+	case 2048000:
+		gcm = gcm_2048000;
+		break;
+	case 8192000:
+		gcm = gcm_8192000;
+		break;
+	case 10000000:
+		gcm = gcm_10000000;
+		break;
+	case 12352000:
+		gcm = gcm_12352000;
+		break;
+	case 16384000:
+		gcm = gcm_16384000;
+		break;
+	default:
+		dev_err(pef2256->dev, "Unsupported v1.2 MCLK rate %lu\n", mclk_rate);
+		return -EINVAL;
+	}
+	for (i = 0; i < 6; i++)
+		pef2256_write8(pef2256, PEF2256_GCM(i+1), gcm[i]);
+
+	return 0;
+}
+
+static int pef2256_2x_setup_gcm(struct pef2256 *pef2256)
+{
+	static const u8 gcm_1544000[8] = {0x00, 0x15, 0x00, 0x08, 0x00, 0x3F, 0x9C, 0xDF};
+	static const u8 gcm_2048000[8] = {0x00, 0x18, 0xFB, 0x0B, 0x00, 0x2F, 0xDB, 0xDF};
+	static const u8 gcm_8192000[8] = {0x00, 0x18, 0xFB, 0x0B, 0x00, 0x0B, 0xDB, 0xDF};
+	static const u8 gcm_10000000[8] = {0x40, 0x1B, 0x3D, 0x0A, 0x00, 0x07, 0xC9, 0xDC};
+	static const u8 gcm_12352000[8] = {0x00, 0x19, 0x00, 0x08, 0x01, 0x0A, 0x98, 0xDA};
+	static const u8 gcm_16384000[8] = {0x00, 0x18, 0xFB, 0x0B, 0x01, 0x0B, 0xDB, 0xDF};
+	unsigned long mclk_rate;
+	const u8 *gcm;
+	int i;
+
+	mclk_rate = clk_get_rate(pef2256->mclk);
+	switch (mclk_rate) {
+	case 1544000:
+		gcm = gcm_1544000;
+		break;
+	case 2048000:
+		gcm = gcm_2048000;
+		break;
+	case 8192000:
+		gcm = gcm_8192000;
+		break;
+	case 10000000:
+		gcm = gcm_10000000;
+		break;
+	case 12352000:
+		gcm = gcm_12352000;
+		break;
+	case 16384000:
+		gcm = gcm_16384000;
+		break;
+	default:
+		dev_err(pef2256->dev, "Unsupported v2.x MCLK rate %lu\n", mclk_rate);
+		return -EINVAL;
+	}
+	for (i = 0; i < 8; i++)
+		pef2256_write8(pef2256, PEF2256_GCM(i+1), gcm[i]);
+
+	return 0;
+}
+
+static int pef2256_setup_gcm(struct pef2256 *pef2256)
+{
+	return (pef2256->version == PEF2256_VERSION_1_2) ?
+		pef2256_12_setup_gcm(pef2256) : pef2256_2x_setup_gcm(pef2256);
+}
+
+static int pef2256_setup_e1(struct pef2256 *pef2256)
+{
+	u8 fmr1, fmr2, sic1;
+	int ret;
+
+	/* Basic setup, Master clocking mode (GCM8..1) */
+	ret = pef2256_setup_gcm(pef2256);
+	if (ret)
+		return ret;
+
+	/* RCLK output : DPLL clock, DCO-X enabled, DCO-X internal ref clock */
+	pef2256_write8(pef2256, PEF2256_CMR1, 0x00);
+
+	/*
+	 * SCLKR selected, SCLKX selected,
+	 * receive synchro pulse sourced by SYPR,
+	 * transmit synchro pulse sourced by SYPX
+	 */
+	pef2256_write8(pef2256, PEF2256_CMR2, 0x00);
+
+	/* NRZ coding, no alarm simulation */
+	pef2256_write8(pef2256, PEF2256_FMR0, 0x00);
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
+	pef2256_write8(pef2256, PEF2256_FMR1, fmr1);
+	pef2256_write8(pef2256, PEF2256_FMR2, fmr2);
+
+	/* E1 default for the receive slicer threshold */
+	pef2256_write8(pef2256, PEF2256_LIM2, PEF2256_LIM2_SLT_THR50);
+	if (!pef2256->is_subordinate) {
+		/* SEC input, active high */
+		pef2256_write8(pef2256, PEF2256_GPC1, PEF2256_GPC1_CSFP_SEC_IN_HIGH);
+	} else {
+		/* Loop-timed */
+		pef2256_setbits8(pef2256, PEF2256_LIM2, PEF2256_LIM2_ELT);
+		/* FSC output, active high */
+		pef2256_write8(pef2256, PEF2256_GPC1, PEF2256_GPC1_CSFP_FSC_OUT_HIGH);
+	}
+
+	/* internal second timer, power on */
+	pef2256_write8(pef2256, PEF2256_GCR, 0x00);
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
+	/* analog interface selected, remote loop off */
+	pef2256_write8(pef2256, PEF2256_LIM1, 0x00);
+
+	/*
+	 * SCLKR, SCLKX, RCLK configured to inputs,
+	 * XFMS active low, CLK1 and CLK2 pin configuration
+	 */
+	pef2256_write8(pef2256, PEF2256_PC5, 0x00);
+	pef2256_write8(pef2256, PEF2256_PC6, 0x00);
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
+	/* channel loop-back and single frame mode are disabled */
+	pef2256_write8(pef2256, PEF2256_LOOP, 0x00);
+
+	/* all bits of the transmitted service word are cleared */
+	pef2256_write8(pef2256, PEF2256_XSW, PEF2256_XSW_XY(0x1F));
+	/* CAS disabled and clear spare bit values */
+	pef2256_write8(pef2256, PEF2256_XSP, 0x00);
+
+	/* no transparent mode active */
+	pef2256_write8(pef2256, PEF2256_TSWM, 0x00);
+
+	/*
+	 * the transmit clock offset is cleared
+	 * the transmit time slot offset is cleared
+	 */
+	pef2256_write8(pef2256, PEF2256_XC0, 0x00);
+
+	/* Keep default value for the transmit offset */
+	pef2256_write8(pef2256, PEF2256_XC1, 0x9C);
+
+	/*
+	 * transmit pulse mask, default value from datasheet
+	 * transmitter in tristate mode
+	 */
+	if (pef2256->version == PEF2256_VERSION_1_2) {
+		pef2256_write8(pef2256, PEF2256_XPM0, 0x7B);
+		pef2256_write8(pef2256, PEF2256_XPM1, 0x03);
+		pef2256_write8(pef2256, PEF2256_XPM2, PEF2256_XPM2_XLT | 0x00);
+	} else {
+		pef2256_write8(pef2256, PEF2256_XPM0, 0x9C);
+		pef2256_write8(pef2256, PEF2256_XPM1, 0x03);
+		pef2256_write8(pef2256, PEF2256_XPM2, PEF2256_XPM2_XLT | 0x00);
+	}
+
+	/* "master" mode */
+	if (!pef2256->is_subordinate)
+		pef2256_setbits8(pef2256, PEF2256_LIM0, PEF2256_LIM0_MAS);
+
+	/* transmit line in normal operation */
+	pef2256_clrbits8(pef2256, PEF2256_XPM2, PEF2256_XPM2_XLT);
+
+	if (pef2256->version == PEF2256_VERSION_1_2) {
+		/* receive input threshold = 0,21V */
+		pef2256_clrsetbits8(pef2256, PEF2256_LIM1, PEF2256_12_LIM1_RIL_MASK,
+				    PEF2256_12_LIM1_RIL_210);
+	} else {
+		/* receive input threshold = 0,21V */
+		pef2256_clrsetbits8(pef2256, PEF2256_LIM1, PEF2256_2X_LIM1_RIL_MASK,
+				    PEF2256_2X_LIM1_RIL_210);
+	}
+	/* transmit line coding = HDB3 */
+	pef2256_clrsetbits8(pef2256, PEF2256_FMR0, PEF2256_FMR0_XC_MASK,
+			    PEF2256_FMR0_XC_HDB3);
+
+	/* receive line coding = HDB3 */
+	pef2256_clrsetbits8(pef2256, PEF2256_FMR0, PEF2256_FMR0_RC_MASK,
+			    PEF2256_FMR0_RC_HDB3);
+
+	/* detection of LOS alarm = 176 pulses (ie (10 + 1) * 16) */
+	pef2256_write8(pef2256, PEF2256_PCD, 10);
+
+	/* recovery of LOS alarm = 22 pulses (ie 21 + 1) */
+	pef2256_write8(pef2256, PEF2256_PCR, 21);
+
+	/* DCO-X center frequency enabled */
+	pef2256_setbits8(pef2256, PEF2256_CMR2, PEF2256_CMR2_DCOXC);
+
+	if (pef2256->is_subordinate) {
+		/* select RCLK source = 2M */
+		pef2256_clrsetbits8(pef2256, PEF2256_CMR1, PEF2256_CMR1_RS_MASK,
+				    PEF2256_CMR1_RS_DCOR_2048);
+		/* disable switching from RCLK to SYNC */
+		pef2256_setbits8(pef2256, PEF2256_CMR1, PEF2256_CMR1_DCS);
+	}
+
+	if (pef2256->version != PEF2256_VERSION_1_2) {
+		/* during inactive channel phase switch RDO/RSIG into tri-state */
+		pef2256_setbits8(pef2256, PEF2256_SIC3, PEF2256_SIC3_RTRI);
+	}
+
+	if (!pef2256->is_tx_falling_edge) {
+		/* rising edge sync pulse transmit */
+		pef2256_clrsetbits8(pef2256, PEF2256_SIC3,
+				    PEF2256_SIC3_RESR, PEF2256_SIC3_RESX);
+	} else {
+		/* rising edge sync pulse receive */
+		pef2256_clrsetbits8(pef2256, PEF2256_SIC3,
+				    PEF2256_SIC3_RESX, PEF2256_SIC3_RESR);
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
+		dev_err(pef2256->dev, "Unsupported sysclk rate %u\n", pef2256->sysclk_rate);
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
+	if (pef2256->is_subordinate) {
+		/* transmit buffer size = 2 frames */
+		pef2256_clrsetbits8(pef2256, PEF2256_SIC1, PEF2256_SIC1_XBS_MASK,
+				    PEF2256_SIC1_XBS_2FRAMES);
+		/* transmit transparent mode */
+		pef2256_setbits8(pef2256, PEF2256_XSW, PEF2256_XSW_XTM);
+	}
+
+	/* error counter latched every 1s */
+	pef2256_setbits8(pef2256, PEF2256_FMR1, PEF2256_FMR1_ECM);
+	/* error counter mode COFA */
+	pef2256_setbits8(pef2256, PEF2256_GCR, PEF2256_GCR_ECMC);
+	/* errors in service words have no influence */
+	pef2256_setbits8(pef2256, PEF2256_RC0, PEF2256_RC0_SWD);
+	/* 4 consecutive incorrect FAS causes loss of sync */
+	pef2256_setbits8(pef2256, PEF2256_RC0, PEF2256_RC0_ASY4);
+	/* Si-Bit, Spare bit For International, FAS word */
+	pef2256_setbits8(pef2256, PEF2256_XSW, PEF2256_XSW_XSIS);
+	pef2256_setbits8(pef2256, PEF2256_XSP, PEF2256_XSP_XSIF);
+
+	/* port RCLK is output */
+	pef2256_setbits8(pef2256, PEF2256_PC5, PEF2256_PC5_CRP);
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
+	if (!pef2256->is_e1) {
+		dev_err(pef2256->dev, "Only E1 line is currently supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	return pef2256_setup_e1(pef2256);
+}
+
+
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
+	bool is_changed = false;
+	unsigned long flags;
+	bool is_carrier_on;
+
+	if (isr & (PEF2256_INT2_LOS | PEF2256_INT2_AIS)) {
+
+		spin_lock_irqsave(&pef2256->lock, flags);
+		is_carrier_on = pef2256_is_carrier_on(pef2256);
+		if (is_carrier_on != pef2256->is_carrier_on) {
+			pef2256->is_carrier_on = is_carrier_on;
+			is_changed = true;
+		}
+		spin_unlock_irqrestore(&pef2256->lock, flags);
+
+		if (is_changed)
+			atomic_notifier_call_chain(&pef2256->event_notifier_list,
+						   PEF2256_EVENT_CARRIER, NULL);
+	}
+}
+
+static irqreturn_t pef2256_irq_handler(int irq, void *priv)
+{
+	void (*pef2256_isr_handler[])(struct pef2256 *, u8, u8) = {
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
+	for (n = 0; n < ARRAY_SIZE(pef2256_isr_handler) ; n++) {
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
+	dev_dbg(pef2256->dev, "config: %s line\n", pef2256->is_e1 ? "E1" : "T1/J1");
+
+	pef2256->sysclk_rate = 2048000;
+	ret = of_property_read_u32(np, "lantiq,sysclk-rate-hz", &pef2256->sysclk_rate);
+	if (ret && ret != -EINVAL) {
+		dev_err(pef2256->dev, "%pOF: failed to read lantiq,sysclk-rate-hz\n", np);
+		return ret;
+	}
+	dev_dbg(pef2256->dev, "config: sysclk %u Hz\n", pef2256->sysclk_rate);
+
+	pef2256->data_rate = 2048000;
+	ret = of_property_read_u32(np, "lantiq,data-rate-bps", &pef2256->data_rate);
+	if (ret && ret != -EINVAL) {
+		dev_err(pef2256->dev, "%pOF: failed to read lantiq,data-rate-bps\n", np);
+		return ret;
+	}
+	dev_dbg(pef2256->dev, "config: data rate %u bps\n", pef2256->data_rate);
+
+	ret =  pef2256_check_rates(pef2256, pef2256->sysclk_rate, pef2256->data_rate);
+	if (ret)
+		return ret;
+
+	pef2256->is_tx_falling_edge = of_property_read_bool(np, "lantiq,clock-falling-edge");
+	dev_dbg(pef2256->dev, "config: tx on %s edge\n",
+		pef2256->is_tx_falling_edge ? "falling" : "rising");
+
+	pef2256->is_subordinate = of_property_read_bool(np, "lantiq,subordinate");
+	dev_dbg(pef2256->dev, "config: subordinate %s\n",
+		pef2256->is_subordinate ? "on" : "off");
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
+	dev_dbg(pef2256->dev, "config: frame type %d\n", pef2256->frame_type);
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
+	dev_dbg(pef2256->dev, "config: channel phase %u\n", pef2256->channel_phase);
+
+	return 0;
+}
+
+static int pef2256_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct pef2256 *pef2256 = pinctrl_dev_get_drvdata(pctldev);
+
+	/* We map 1 group <-> 1 pin */
+	return pef2256->pinctrl.pctrl_desc.npins;
+}
+
+static const char *pef2256_get_group_name(struct pinctrl_dev *pctldev,
+					  unsigned int selector)
+{
+	struct pef2256 *pef2256 = pinctrl_dev_get_drvdata(pctldev);
+
+	/* We map 1 group <-> 1 pin */
+	return pef2256->pinctrl.pctrl_desc.pins[selector].name;
+}
+
+static int pef2256_get_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
+			     const unsigned int **pins,
+			     unsigned int *num_pins)
+{
+	struct pef2256 *pef2256 = pinctrl_dev_get_drvdata(pctldev);
+
+	/* We map 1 group <-> 1 pin */
+	*pins = &pef2256->pinctrl.pctrl_desc.pins[selector].number;
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const struct pinctrl_ops pef2256_pctlops = {
+	.get_groups_count	= pef2256_get_groups_count,
+	.get_group_name		= pef2256_get_group_name,
+	.get_group_pins		= pef2256_get_group_pins,
+	.dt_node_to_map		= pinconf_generic_dt_node_to_map_pin,
+	.dt_free_map		= pinconf_generic_dt_free_map,
+};
+
+static int pef2256_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct pef2256 *pef2256 = pinctrl_dev_get_drvdata(pctldev);
+
+	return pef2256->pinctrl.nfunctions;
+}
+
+static const char *pef2256_get_function_name(struct pinctrl_dev *pctldev,
+					     unsigned int selector)
+{
+	struct pef2256 *pef2256 = pinctrl_dev_get_drvdata(pctldev);
+
+	return pef2256->pinctrl.functions[selector].name;
+}
+
+
+static int pef2256_get_function_groups(struct pinctrl_dev *pctldev, unsigned int selector,
+			 const char * const **groups,
+			 unsigned * const num_groups)
+{
+	struct pef2256 *pef2256 = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pef2256->pinctrl.functions[selector].groups;
+	*num_groups = pef2256->pinctrl.functions[selector].ngroups;
+	return 0;
+}
+
+static int pef2256_set_mux(struct pinctrl_dev *pctldev, unsigned int func_selector,
+			   unsigned int group_selector)
+{
+	struct pef2256 *pef2256 = pinctrl_dev_get_drvdata(pctldev);
+	const struct pef2256_pinreg_desc *pinreg_desc;
+	u8 func_val;
+
+	dev_dbg(pef2256->dev, "set %s to %s function\n",
+		pef2256->pinctrl.pctrl_desc.pins[group_selector].name,
+		pef2256->pinctrl.functions[func_selector].name);
+
+	/* We map 1 group <-> 1 pin */
+	pinreg_desc = pef2256->pinctrl.pctrl_desc.pins[group_selector].drv_data;
+	func_val = pef2256->pinctrl.functions[func_selector].func_val;
+
+	pef2256_clrsetbits8(pef2256, pinreg_desc->offset, pinreg_desc->mask,
+			    func_val & pinreg_desc->mask);
+
+	return 0;
+}
+
+static const struct pinmux_ops pef2256_pmxops = {
+	.get_functions_count	= pef2256_get_functions_count,
+	.get_function_name	= pef2256_get_function_name,
+	.get_function_groups	= pef2256_get_function_groups,
+	.set_mux		= pef2256_set_mux,
+};
+
+#define PEF2256_PINCTRL_PIN(_number, _name, _offset, _mask) { \
+	.number = _number, \
+	.name = _name, \
+	.drv_data = &(struct pef2256_pinreg_desc) { \
+		.offset = _offset, \
+		.mask = _mask, \
+	}, \
+}
+
+static const struct pinctrl_pin_desc pef2256_v12_pins[] = {
+	PEF2256_PINCTRL_PIN(0, "RPA", PEF2256_PC1, PEF2256_12_PC_RPC_MASK),
+	PEF2256_PINCTRL_PIN(1, "RPB", PEF2256_PC2, PEF2256_12_PC_RPC_MASK),
+	PEF2256_PINCTRL_PIN(2, "RPC", PEF2256_PC3, PEF2256_12_PC_RPC_MASK),
+	PEF2256_PINCTRL_PIN(3, "RPD", PEF2256_PC4, PEF2256_12_PC_RPC_MASK),
+	PEF2256_PINCTRL_PIN(4, "XPA", PEF2256_PC1, PEF2256_12_PC_XPC_MASK),
+	PEF2256_PINCTRL_PIN(5, "XPB", PEF2256_PC2, PEF2256_12_PC_XPC_MASK),
+	PEF2256_PINCTRL_PIN(6, "XPC", PEF2256_PC3, PEF2256_12_PC_XPC_MASK),
+	PEF2256_PINCTRL_PIN(7, "XPD", PEF2256_PC4, PEF2256_12_PC_XPC_MASK),
+};
+
+static const struct pinctrl_pin_desc pef2256_v2x_pins[] = {
+	PEF2256_PINCTRL_PIN(0, "RPA", PEF2256_PC1, PEF2256_2X_PC_RPC_MASK),
+	PEF2256_PINCTRL_PIN(1, "RPB", PEF2256_PC2, PEF2256_2X_PC_RPC_MASK),
+	PEF2256_PINCTRL_PIN(2, "RPC", PEF2256_PC3, PEF2256_2X_PC_RPC_MASK),
+	PEF2256_PINCTRL_PIN(3, "RPD", PEF2256_PC4, PEF2256_2X_PC_RPC_MASK),
+	PEF2256_PINCTRL_PIN(4, "XPA", PEF2256_PC1, PEF2256_2X_PC_XPC_MASK),
+	PEF2256_PINCTRL_PIN(5, "XPB", PEF2256_PC2, PEF2256_2X_PC_XPC_MASK),
+	PEF2256_PINCTRL_PIN(6, "XPC", PEF2256_PC3, PEF2256_2X_PC_XPC_MASK),
+	PEF2256_PINCTRL_PIN(7, "XPD", PEF2256_PC4, PEF2256_2X_PC_XPC_MASK),
+};
+
+static const char *const pef2256_rp_groups[] = { "RPA", "RPB", "RPC", "RPD" };
+static const char *const pef2256_xp_groups[] = { "XPA", "XPB", "XPC", "XPD" };
+static const char *const pef2256_all_groups[] = { "RPA", "RPB", "RPC", "RPD",
+						  "XPA", "XPB", "XPC", "XPD" };
+
+#define PEF2256_FUNCTION(_name, _func_val, _groups) { \
+	.name = _name, \
+	.groups = _groups, \
+	.ngroups = ARRAY_SIZE(_groups), \
+	.func_val = _func_val, \
+}
+
+static const struct pef2256_function_desc pef2256_v2x_functions[] = {
+	PEF2256_FUNCTION("SYPR",   PEF2256_2X_PC_RPC_SYPR,   pef2256_rp_groups),
+	PEF2256_FUNCTION("RFM",    PEF2256_2X_PC_RPC_RFM,    pef2256_rp_groups),
+	PEF2256_FUNCTION("RFMB",   PEF2256_2X_PC_RPC_RFMB,   pef2256_rp_groups),
+	PEF2256_FUNCTION("RSIGM",  PEF2256_2X_PC_RPC_RSIGM,  pef2256_rp_groups),
+	PEF2256_FUNCTION("RSIG",   PEF2256_2X_PC_RPC_RSIG,   pef2256_rp_groups),
+	PEF2256_FUNCTION("DLR",    PEF2256_2X_PC_RPC_DLR,    pef2256_rp_groups),
+	PEF2256_FUNCTION("FREEZE", PEF2256_2X_PC_RPC_FREEZE, pef2256_rp_groups),
+	PEF2256_FUNCTION("RFSP",   PEF2256_2X_PC_RPC_RFSP,   pef2256_rp_groups),
+	PEF2256_FUNCTION("LOS",    PEF2256_2X_PC_RPC_LOS,    pef2256_rp_groups),
+
+	PEF2256_FUNCTION("SYPX",  PEF2256_2X_PC_XPC_SYPX,  pef2256_xp_groups),
+	PEF2256_FUNCTION("XFMS",  PEF2256_2X_PC_XPC_XFMS,  pef2256_xp_groups),
+	PEF2256_FUNCTION("XSIG",  PEF2256_2X_PC_XPC_XSIG,  pef2256_xp_groups),
+	PEF2256_FUNCTION("TCLK",  PEF2256_2X_PC_XPC_TCLK,  pef2256_xp_groups),
+	PEF2256_FUNCTION("XMFB",  PEF2256_2X_PC_XPC_XMFB,  pef2256_xp_groups),
+	PEF2256_FUNCTION("XSIGM", PEF2256_2X_PC_XPC_XSIGM, pef2256_xp_groups),
+	PEF2256_FUNCTION("DLX",   PEF2256_2X_PC_XPC_DLX,   pef2256_xp_groups),
+	PEF2256_FUNCTION("XCLK",  PEF2256_2X_PC_XPC_XCLK,  pef2256_xp_groups),
+	PEF2256_FUNCTION("XLT",   PEF2256_2X_PC_XPC_XLT,   pef2256_xp_groups),
+
+	PEF2256_FUNCTION("GPI",  PEF2256_2X_PC_RPC_GPI | PEF2256_2X_PC_XPC_GPI,
+			 pef2256_all_groups),
+	PEF2256_FUNCTION("GPOH", PEF2256_2X_PC_RPC_GPOH | PEF2256_2X_PC_XPC_GPOH,
+			 pef2256_all_groups),
+	PEF2256_FUNCTION("GPOL", PEF2256_2X_PC_RPC_GPOL | PEF2256_2X_PC_XPC_GPOL,
+			 pef2256_all_groups),
+};
+
+static const struct pef2256_function_desc pef2256_v12_functions[] = {
+	PEF2256_FUNCTION("SYPR",   PEF2256_12_PC_RPC_SYPR,   pef2256_rp_groups),
+	PEF2256_FUNCTION("RFM",    PEF2256_12_PC_RPC_RFM,    pef2256_rp_groups),
+	PEF2256_FUNCTION("RFMB",   PEF2256_12_PC_RPC_RFMB,   pef2256_rp_groups),
+	PEF2256_FUNCTION("RSIGM",  PEF2256_12_PC_RPC_RSIGM,  pef2256_rp_groups),
+	PEF2256_FUNCTION("RSIG",   PEF2256_12_PC_RPC_RSIG,   pef2256_rp_groups),
+	PEF2256_FUNCTION("DLR",    PEF2256_12_PC_RPC_DLR,    pef2256_rp_groups),
+	PEF2256_FUNCTION("FREEZE", PEF2256_12_PC_RPC_FREEZE, pef2256_rp_groups),
+	PEF2256_FUNCTION("RFSP",   PEF2256_12_PC_RPC_RFSP,   pef2256_rp_groups),
+
+	PEF2256_FUNCTION("SYPX",  PEF2256_12_PC_XPC_SYPX,  pef2256_xp_groups),
+	PEF2256_FUNCTION("XFMS",  PEF2256_12_PC_XPC_XFMS,  pef2256_xp_groups),
+	PEF2256_FUNCTION("XSIG",  PEF2256_12_PC_XPC_XSIG,  pef2256_xp_groups),
+	PEF2256_FUNCTION("TCLK",  PEF2256_12_PC_XPC_TCLK,  pef2256_xp_groups),
+	PEF2256_FUNCTION("XMFB",  PEF2256_12_PC_XPC_XMFB,  pef2256_xp_groups),
+	PEF2256_FUNCTION("XSIGM", PEF2256_12_PC_XPC_XSIGM, pef2256_xp_groups),
+	PEF2256_FUNCTION("DLX",   PEF2256_12_PC_XPC_DLX,   pef2256_xp_groups),
+	PEF2256_FUNCTION("XCLK",  PEF2256_12_PC_XPC_XCLK,  pef2256_xp_groups),
+	PEF2256_FUNCTION("XLT",   PEF2256_12_PC_XPC_XLT,   pef2256_xp_groups),
+};
+
+
+static int pef2256_register_pinctrl(struct pef2256 *pef2256)
+{
+	struct pinctrl_dev	*pctrl;
+
+	pef2256->pinctrl.pctrl_desc.name    = dev_name(pef2256->dev);
+	pef2256->pinctrl.pctrl_desc.owner   = THIS_MODULE;
+	pef2256->pinctrl.pctrl_desc.pctlops = &pef2256_pctlops;
+	pef2256->pinctrl.pctrl_desc.pmxops  = &pef2256_pmxops;
+	if (pef2256->version == PEF2256_VERSION_1_2) {
+		pef2256->pinctrl.pctrl_desc.pins  = pef2256_v12_pins;
+		pef2256->pinctrl.pctrl_desc.npins = ARRAY_SIZE(pef2256_v12_pins);
+		pef2256->pinctrl.functions  = pef2256_v12_functions;
+		pef2256->pinctrl.nfunctions = ARRAY_SIZE(pef2256_v12_functions);
+	} else {
+		pef2256->pinctrl.pctrl_desc.pins  = pef2256_v2x_pins;
+		pef2256->pinctrl.pctrl_desc.npins = ARRAY_SIZE(pef2256_v2x_pins);
+		pef2256->pinctrl.functions  = pef2256_v2x_functions;
+		pef2256->pinctrl.nfunctions = ARRAY_SIZE(pef2256_v2x_functions);
+	}
+
+
+	pctrl = devm_pinctrl_register(pef2256->dev, &pef2256->pinctrl.pctrl_desc, pef2256);
+	if (IS_ERR(pctrl)) {
+		dev_err(pef2256->dev, "pinctrl driver registration failed\n");
+		return PTR_ERR(pctrl);
+	}
+
+	return 0;
+}
+
+static void pef2256_reset_pinmux(struct pef2256 *pef2256)
+{
+	u8 val;
+	/*
+	 * Reset values cannot be used.
+	 * They define the SYPR/SYPX pin mux for all the RPx and XPx pins and
+	 * Only one pin can be muxed to SYPR and one pin can be muxed to SYPX.
+	 * Choose here an other reset value.
+	 */
+	if (pef2256->version == PEF2256_VERSION_1_2)
+		val = PEF2256_12_PC_XPC_XCLK | PEF2256_12_PC_RPC_RFSP;
+	else
+		val = PEF2256_2X_PC_XPC_GPI | PEF2256_2X_PC_RPC_GPI;
+
+	pef2256_write8(pef2256, PEF2256_PC1, val);
+	pef2256_write8(pef2256, PEF2256_PC2, val);
+	pef2256_write8(pef2256, PEF2256_PC3, val);
+	pef2256_write8(pef2256, PEF2256_PC4, val);
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
+static int pef2256_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct pef2256 *pef2256;
+	int ret;
+	int irq;
+
+	pef2256 = devm_kzalloc(&pdev->dev, sizeof(*pef2256), GFP_KERNEL);
+	if (!pef2256)
+		return -ENOMEM;
+
+	pef2256->dev = &pdev->dev;
+	spin_lock_init(&pef2256->lock);
+	ATOMIC_INIT_NOTIFIER_HEAD(&pef2256->event_notifier_list);
+
+	pef2256->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pef2256->regs))
+		return PTR_ERR(pef2256->regs);
+
+	pef2256->mclk = devm_clk_get_enabled(&pdev->dev, "mclk");
+	if (IS_ERR(pef2256->mclk))
+		return PTR_ERR(pef2256->mclk);
+	dev_dbg(pef2256->dev, "mclk %lu Hz\n", clk_get_rate(pef2256->mclk));
+
+	/* Reset the component. The MCLK clock must be active during reset */
+	pef2256->reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(pef2256->reset_gpio))
+		return PTR_ERR(pef2256->reset_gpio);
+	if (pef2256->reset_gpio) {
+		gpiod_set_value_cansleep(pef2256->reset_gpio, 1);
+		udelay(10);
+		gpiod_set_value_cansleep(pef2256->reset_gpio, 0);
+		udelay(10);
+	}
+
+	pef2256->version = pef2256_get_version(pef2256);
+	if (pef2256->version == PEF2256_VERSION_UNKNOWN)
+		return -ENODEV;
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
+	pef2256_reset_pinmux(pef2256);
+	ret = pef2256_register_pinctrl(pef2256);
+	if (ret)
+		return ret;
+
+	/*
+	 * We are going to reset the E1 lines during setup() call and the ISR2
+	 * interrupt used to detect the carrier state changed is masked.
+	 * It is time to initialize our internal carrier state flag.
+	 */
+	pef2256->is_carrier_on = false;
+
+	ret = pef2256_setup(pef2256);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, pef2256);
+
+	ret = sysfs_create_group(&pef2256->dev->kobj, &pef2256_attribute_group);
+	if (ret < 0) {
+		dev_err(pef2256->dev, "sysfs registration failed (%d)\n", ret);
+		platform_set_drvdata(pdev, NULL);
+		return ret;
+	}
+
+	return 0;
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
+		.of_match_table = of_match_ptr(pef2256_id_table),
+	},
+	.probe = pef2256_probe,
+	.remove = pef2256_remove,
+};
+module_platform_driver(pef2256_driver);
+
+struct pef2256 *pef2256_get_byphandle(struct device_node *np, const char *phandle_name)
+{
+	struct device_node *pef2256_np;
+	struct platform_device *pdev;
+	struct pef2256 *pef2256;
+
+	pef2256_np = of_parse_phandle(np, phandle_name, 0);
+	if (!pef2256_np)
+		return ERR_PTR(-EINVAL);
+
+	if (!of_match_node(pef2256_driver.driver.of_match_table, pef2256_np)) {
+		of_node_put(pef2256_np);
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdev = of_find_device_by_node(pef2256_np);
+	of_node_put(pef2256_np);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	pef2256 = platform_get_drvdata(pdev);
+	if (!pef2256) {
+		platform_device_put(pdev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	return pef2256;
+}
+EXPORT_SYMBOL(pef2256_get_byphandle);
+
+void pef2256_put(struct pef2256 *pef2256)
+{
+	put_device(pef2256->dev);
+}
+EXPORT_SYMBOL(pef2256_put);
+
+static void devm_pef2256_release(struct device *dev, void *res)
+{
+	struct pef2256 **pef2256 = res;
+
+	pef2256_put(*pef2256);
+}
+
+struct pef2256 *devm_pef2256_get_byphandle(struct device *dev, struct device_node *np,
+					   const char *phandle_name)
+{
+	struct pef2256 *pef2256;
+	struct pef2256 **dr;
+
+	dr = devres_alloc(devm_pef2256_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	pef2256 = pef2256_get_byphandle(np, phandle_name);
+	if (!IS_ERR(pef2256)) {
+		*dr = pef2256;
+		devres_add(dev, dr);
+	} else {
+		devres_free(dr);
+	}
+
+	return pef2256;
+}
+EXPORT_SYMBOL(devm_pef2256_get_byphandle);
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
+	unsigned long flags;
+	bool is_carrier_on;
+
+	spin_lock_irqsave(&pef2256->lock, flags);
+	is_carrier_on = pef2256->is_carrier_on;
+	spin_unlock_irqrestore(&pef2256->lock, flags);
+
+	return is_carrier_on;
+}
+EXPORT_SYMBOL_GPL(pef2256_get_carrier);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("PEF2256 driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pef2256.h b/include/linux/pef2256.h
new file mode 100644
index 000000000000..6c8d173595b1
--- /dev/null
+++ b/include/linux/pef2256.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * PEF2256 management
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
+struct device_node;
+struct device;
+struct notifier_block;
+
+struct pef2256 *pef2256_get_byphandle(struct device_node *np, const char *phandle_name);
+void pef2256_put(struct pef2256 *pef2256);
+struct pef2256 *devm_pef2256_get_byphandle(struct device *dev, struct device_node *np,
+					   const char *phandle_name);
+
+
+enum pef2256_event {
+	PEF2256_EVENT_CARRIER, /* Carrier state changed */
+};
+
+/* The nb.notifier_call function registered must not sleep */
+int pef2256_register_event_notifier(struct pef2256 *pef2256, struct notifier_block *nb);
+int pef2256_unregister_event_notifier(struct pef2256 *pef2256, struct notifier_block *nb);
+
+/* Retrieve carrier state. true: carrier on, false: carrier off */
+bool pef2256_get_carrier(struct pef2256 *pef2256);
+
+#endif /* __PEF2256_H__ */
-- 
2.39.2

