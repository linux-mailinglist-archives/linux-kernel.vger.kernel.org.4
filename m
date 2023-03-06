Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505396ACDA0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjCFTLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCFTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:11:06 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B0364AB1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:11:03 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 326GYgNx037939;
        Mon, 6 Mar 2023 10:34:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678120482;
        bh=2eKfzhol0c4m+RnJVt8rmVicFJuZAu5DJSwpJFL3FzQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MTgAeoux9O+lT356Lke77jNwhamTUTHro3BelnwelFmKpleUOOy2C/ck9zObp/cUD
         ZEx6oQ5Z7wN7L86wEINpYdEyS+qtyZhiOV3mkRUkZauZZddQ2BYnwiABFaxp7ReBah
         cWLSD1WpEvKLMtLk05hK1OzmqFJVyoL2MUj/gskc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 326GYgts007882
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Mar 2023 10:34:42 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 6
 Mar 2023 10:34:42 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 6 Mar 2023 10:34:42 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 326GYfMF110554;
        Mon, 6 Mar 2023 10:34:42 -0600
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qin Jian <qinjian@cqplus1.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 10/10] ARM: mach-sunplus: Rework support and directory structure
Date:   Mon, 6 Mar 2023 10:34:41 -0600
Message-ID: <20230306163441.16179-10-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306163441.16179-1-afd@ti.com>
References: <20230306163441.16179-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

The mach-sunplus/ directory and files, provides just one "feature":
having the kernel print the machine name if the DTB does not also contain
a "model" string (which they always do). To reduce the number of mach-*
directories let's do without that feature and remove this directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 MAINTAINERS                    |  1 -
 arch/arm/Kconfig               |  2 --
 arch/arm/Kconfig.platforms     | 29 +++++++++++++++++++++++++++++
 arch/arm/Makefile              |  1 -
 arch/arm/mach-sunplus/Kconfig  | 27 ---------------------------
 arch/arm/mach-sunplus/Makefile |  8 --------
 arch/arm/mach-sunplus/sp7021.c | 16 ----------------
 7 files changed, 29 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-sunplus/Kconfig
 delete mode 100644 arch/arm/mach-sunplus/Makefile
 delete mode 100644 arch/arm/mach-sunplus/sp7021.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7da5ab1d5f6c..4c00960d4e54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2847,7 +2847,6 @@ F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.ya
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 F:	arch/arm/boot/dts/sunplus-sp7021*.dts*
 F:	arch/arm/configs/sp7021_*defconfig
-F:	arch/arm/mach-sunplus/
 F:	drivers/irqchip/irq-sp7021-intc.c
 F:	drivers/reset/reset-sunplus.c
 F:	include/dt-bindings/clock/sunplus,sp7021-clkc.h
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d782631a635e..860538a0c26c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -441,8 +441,6 @@ source "arch/arm/mach-sti/Kconfig"
 
 source "arch/arm/mach-stm32/Kconfig"
 
-source "arch/arm/mach-sunplus/Kconfig"
-
 source "arch/arm/mach-sunxi/Kconfig"
 
 source "arch/arm/mach-tegra/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index 60f2140c9ff2..892a5e309cea 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -159,6 +159,35 @@ config ARCH_RDA
 	help
 	  This enables support for the RDA Micro 8810PL SoC family.
 
+menuconfig ARCH_SUNPLUS
+	bool "Sunplus SoCs"
+	depends on ARCH_MULTI_V7
+	help
+	  Support for Sunplus SoC family: SP7021 and succeeding SoC-based systems,
+	  such as the Banana Pi BPI-F2S development board (and derivatives).
+	  (<http://www.sinovoip.com.cn/ecp_view.asp?id=586>)
+	  (<https://tibbo.com/store/plus1.html>)
+
+if ARCH_SUNPLUS
+
+config SOC_SP7021
+	bool "Sunplus SP7021 SoC support"
+	default ARCH_SUNPLUS
+	select HAVE_ARM_ARCH_TIMER
+	select ARM_GIC
+	select ARM_PSCI
+	select PINCTRL
+	select PINCTRL_SPPCTL
+	select SERIAL_SUNPLUS if TTY
+	select SERIAL_SUNPLUS_CONSOLE if TTY
+	help
+	  Support for Sunplus SP7021 SoC. It is based on ARM 4-core
+	  Cortex-A7 with various peripherals (e.g.: I2C, SPI, SDIO,
+	  Ethernet, etc.), FPGA interface,  chip-to-chip bus.
+	  It is designed for industrial control.
+
+endif
+
 config ARCH_UNIPHIER
 	bool "Socionext UniPhier SoCs"
 	depends on ARCH_MULTI_V7
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 94ebd137f0ec..6240c668268e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -214,7 +214,6 @@ machine-$(CONFIG_ARCH_RENESAS)	 	+= shmobile
 machine-$(CONFIG_ARCH_INTEL_SOCFPGA)	+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
 machine-$(CONFIG_ARCH_STM32)		+= stm32
-machine-$(CONFIG_ARCH_SUNPLUS)		+= sunplus
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U8500)		+= ux500
diff --git a/arch/arm/mach-sunplus/Kconfig b/arch/arm/mach-sunplus/Kconfig
deleted file mode 100644
index d0c2416e6f24..000000000000
--- a/arch/arm/mach-sunplus/Kconfig
+++ /dev/null
@@ -1,27 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-
-menuconfig ARCH_SUNPLUS
-	bool "Sunplus SoCs"
-	depends on ARCH_MULTI_V7
-	help
-	  Support for Sunplus SoC family: SP7021 and succeeding SoC-based systems,
-	  such as the Banana Pi BPI-F2S development board (and derivatives).
-	  (<http://www.sinovoip.com.cn/ecp_view.asp?id=586>)
-	  (<https://tibbo.com/store/plus1.html>)
-
-config SOC_SP7021
-	bool "Sunplus SP7021 SoC support"
-	depends on ARCH_SUNPLUS
-	default ARCH_SUNPLUS
-	select HAVE_ARM_ARCH_TIMER
-	select ARM_GIC
-	select ARM_PSCI
-	select PINCTRL
-	select PINCTRL_SPPCTL
-	select SERIAL_SUNPLUS if TTY
-	select SERIAL_SUNPLUS_CONSOLE if TTY
-	help
-	  Support for Sunplus SP7021 SoC. It is based on ARM 4-core
-	  Cortex-A7 with various peripherals (e.g.: I2C, SPI, SDIO,
-	  Ethernet, etc.), FPGA interface,  chip-to-chip bus.
-	  It is designed for industrial control.
diff --git a/arch/arm/mach-sunplus/Makefile b/arch/arm/mach-sunplus/Makefile
deleted file mode 100644
index d211de6af2db..000000000000
--- a/arch/arm/mach-sunplus/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the linux kernel.
-#
-
-# Object file lists.
-
-obj-$(CONFIG_SOC_SP7021)	+= sp7021.o
diff --git a/arch/arm/mach-sunplus/sp7021.c b/arch/arm/mach-sunplus/sp7021.c
deleted file mode 100644
index 774d0a5bd4eb..000000000000
--- a/arch/arm/mach-sunplus/sp7021.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-/*
- * Copyright (C) Sunplus Technology Co., Ltd.
- *       All rights reserved.
- */
-#include <linux/kernel.h>
-#include <asm/mach/arch.h>
-
-static const char *sp7021_compat[] __initconst = {
-	"sunplus,sp7021",
-	NULL
-};
-
-DT_MACHINE_START(SP7021_DT, "SP7021")
-	.dt_compat	= sp7021_compat,
-MACHINE_END
-- 
2.39.2

