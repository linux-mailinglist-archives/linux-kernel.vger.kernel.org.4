Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B78703218
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242537AbjEOQDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbjEOQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:03:15 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45510F7
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:03:12 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2eD0004423;
        Mon, 15 May 2023 11:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684166560;
        bh=e568jHeft8X7DiMKrnio7Zpsq4AqsydpRcGoANzkNRo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=d7QYdVwR+bkhmgvoarhQnE/68v5IMKhUBl582GpMg0e9iPTkGUgtLAK/ycLdm1+NV
         NfKOUJ6Oh42DwoOCnfmuMhT06KZsFVxM79lkjmr4EdFbZBRXtx3XqXbG28geGZ757w
         wyCs/ThArkeWGMNAPcySMsb2zOWmd5MDvxQklmoU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FG2eR8113800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 11:02:40 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 11:02:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 11:02:40 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2ZR7029578;
        Mon, 15 May 2023 11:02:39 -0500
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 08/10] ARM: mach-hpe: Rework support and directory structure
Date:   Mon, 15 May 2023 11:02:32 -0500
Message-ID: <20230515160234.289631-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515160234.289631-1-afd@ti.com>
References: <20230515160234.289631-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a platform need a mach-* directory should be seen as a negative,
it means the platform needs special non-standard handling. ARM64 support
does not allow mach-* directories at all. While we may not get to that
given all the non-standard architectures we support, we should still try
to get as close as we can and reduce the number of mach directories.

The mach-hpe/ directory and files, provides just one "feature":
having the kernel print the machine name if the DTB does not also contain
a "model" string (which they always do). To reduce the number of mach-*
directories let's do without that feature and remove this directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 MAINTAINERS                |  1 -
 arch/arm/Kconfig           |  2 --
 arch/arm/Kconfig.platforms | 25 +++++++++++++++++++++++++
 arch/arm/Makefile          |  1 -
 arch/arm/mach-hpe/Kconfig  | 23 -----------------------
 arch/arm/mach-hpe/Makefile |  1 -
 arch/arm/mach-hpe/gxp.c    | 16 ----------------
 7 files changed, 25 insertions(+), 44 deletions(-)
 delete mode 100644 arch/arm/mach-hpe/Kconfig
 delete mode 100644 arch/arm/mach-hpe/Makefile
 delete mode 100644 arch/arm/mach-hpe/gxp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b4d226f87413..03ac2c37d22e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2253,7 +2253,6 @@ F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 F:	Documentation/hwmon/gxp-fan-ctrl.rst
 F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
-F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
 F:	drivers/hwmon/gxp-fan-ctrl.c
 F:	drivers/i2c/busses/i2c-gxp.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d4afd5a01307..0024967b08ea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -377,8 +377,6 @@ source "arch/arm/mach-highbank/Kconfig"
 
 source "arch/arm/mach-hisi/Kconfig"
 
-source "arch/arm/mach-hpe/Kconfig"
-
 source "arch/arm/mach-imx/Kconfig"
 
 source "arch/arm/mach-ixp4xx/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index c74392419cc3..60f2140c9ff2 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -98,6 +98,31 @@ config ARCH_DIGICOLOR
 	select PINCTRL
 	select PINCTRL_DIGICOLOR
 
+menuconfig ARCH_HPE
+	bool "HPE SoC support"
+	depends on ARCH_MULTI_V7
+	help
+	  This enables support for HPE ARM based BMC chips.
+
+if ARCH_HPE
+
+config ARCH_HPE_GXP
+	bool "HPE GXP SoC"
+	depends on ARCH_MULTI_V7
+	select ARM_VIC
+	select GENERIC_IRQ_CHIP
+	select CLKSRC_MMIO
+	help
+	  HPE GXP is the name of the HPE Soc. This SoC is used to implement many
+	  BMC features at HPE. It supports ARMv7 architecture based on the Cortex
+	  A9 core. It is capable of using an AXI bus to which a memory controller
+	  is attached. It has multiple SPI interfaces to connect boot flash and
+	  BIOS flash. It uses a 10/100/1000 MAC for network connectivity. It
+	  has multiple i2c engines to drive connectivity with a host
+	  infrastructure.
+
+endif
+
 menuconfig ARCH_MOXART
 	bool "MOXA ART SoC"
 	depends on ARCH_MULTI_V4
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 82ec2c8bd749..d306cf8107dc 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -183,7 +183,6 @@ machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HISI)		+= hisi
-machine-$(CONFIG_ARCH_HPE)		+= hpe
 machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
 machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
 machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
diff --git a/arch/arm/mach-hpe/Kconfig b/arch/arm/mach-hpe/Kconfig
deleted file mode 100644
index 3372bbf38d38..000000000000
--- a/arch/arm/mach-hpe/Kconfig
+++ /dev/null
@@ -1,23 +0,0 @@
-menuconfig ARCH_HPE
-	bool "HPE SoC support"
-	depends on ARCH_MULTI_V7
-	help
-	  This enables support for HPE ARM based BMC chips.
-if ARCH_HPE
-
-config ARCH_HPE_GXP
-	bool "HPE GXP SoC"
-	depends on ARCH_MULTI_V7
-	select ARM_VIC
-	select GENERIC_IRQ_CHIP
-	select CLKSRC_MMIO
-	help
-	  HPE GXP is the name of the HPE Soc. This SoC is used to implement many
-	  BMC features at HPE. It supports ARMv7 architecture based on the Cortex
-	  A9 core. It is capable of using an AXI bus to which a memory controller
-	  is attached. It has multiple SPI interfaces to connect boot flash and
-	  BIOS flash. It uses a 10/100/1000 MAC for network connectivity. It
-	  has multiple i2c engines to drive connectivity with a host
-	  infrastructure.
-
-endif
diff --git a/arch/arm/mach-hpe/Makefile b/arch/arm/mach-hpe/Makefile
deleted file mode 100644
index 8b0a91234df4..000000000000
--- a/arch/arm/mach-hpe/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_ARCH_HPE_GXP) += gxp.o
diff --git a/arch/arm/mach-hpe/gxp.c b/arch/arm/mach-hpe/gxp.c
deleted file mode 100644
index ef3341373006..000000000000
--- a/arch/arm/mach-hpe/gxp.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
-
-#include <linux/of_platform.h>
-#include <asm/mach/arch.h>
-
-static const char * const gxp_board_dt_compat[] = {
-	"hpe,gxp",
-	NULL,
-};
-
-DT_MACHINE_START(GXP_DT, "HPE GXP")
-	.dt_compat	= gxp_board_dt_compat,
-	.l2c_aux_val = 0,
-	.l2c_aux_mask = ~0,
-MACHINE_END
-- 
2.39.2

