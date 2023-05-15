Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E01703216
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242483AbjEOQDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbjEOQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:03:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3E199
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:03:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2eu5004419;
        Mon, 15 May 2023 11:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684166560;
        bh=af5c91Q+vqJOwLmdyh9Q8efsWJmeqrOcwNcvgIRxRNY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SP84bAZeRgvC/Gc+WsGQ7Atg+Tv8DWL6vow2gLHKiV4vVI80fktSft8/rWehKjmyg
         1rARaYTfCDmsTN0t7R9SryL81T6Dk8AN5yeuyVKCtKNk1hvEw79SOVyQ31s3zlCNO+
         ibuHvZn1lAP0fYhYxV2VMvkEHALeEVEcJG7OmBI0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FG2ee3013210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 11:02:40 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 11:02:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 11:02:39 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2ZR6029578;
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
Subject: [PATCH 07/10] ARM: mach-digicolor: Rework support and directory structure
Date:   Mon, 15 May 2023 11:02:31 -0500
Message-ID: <20230515160234.289631-7-afd@ti.com>
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

The mach-digicolor/ directory and files, provides just one "feature":
having the kernel print the machine name if the DTB does not also contain
a "model" string (which they always do). To reduce the number of mach-*
directories let's do without that feature and remove this directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Kconfig                    |  2 --
 arch/arm/Kconfig.platforms          | 11 +++++++++++
 arch/arm/Makefile                   |  1 -
 arch/arm/mach-digicolor/Kconfig     | 11 -----------
 arch/arm/mach-digicolor/Makefile    |  2 --
 arch/arm/mach-digicolor/digicolor.c | 15 ---------------
 6 files changed, 11 insertions(+), 31 deletions(-)
 delete mode 100644 arch/arm/mach-digicolor/Kconfig
 delete mode 100644 arch/arm/mach-digicolor/Makefile
 delete mode 100644 arch/arm/mach-digicolor/digicolor.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f60e98da58cd..d4afd5a01307 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -363,8 +363,6 @@ source "arch/arm/mach-clps711x/Kconfig"
 
 source "arch/arm/mach-davinci/Kconfig"
 
-source "arch/arm/mach-digicolor/Kconfig"
-
 source "arch/arm/mach-dove/Kconfig"
 
 source "arch/arm/mach-ep93xx/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index 38457d5a18ff..c74392419cc3 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -87,6 +87,17 @@ config MACH_ASM9260
 	help
 	  Support for Alphascale ASM9260 based platform.
 
+config ARCH_DIGICOLOR
+	bool "Conexant Digicolor SoC Support"
+	depends on ARCH_MULTI_V7
+	select CLKSRC_MMIO
+	select DIGICOLOR_TIMER
+	select GENERIC_IRQ_CHIP
+	select GPIOLIB
+	select MFD_SYSCON
+	select PINCTRL
+	select PINCTRL_DIGICOLOR
+
 menuconfig ARCH_MOXART
 	bool "MOXA ART SoC"
 	depends on ARCH_MULTI_V4
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e20c8af34d51..82ec2c8bd749 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -176,7 +176,6 @@ machine-$(CONFIG_ARCH_BCM)		+= bcm
 machine-$(CONFIG_ARCH_BERLIN)		+= berlin
 machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
-machine-$(CONFIG_ARCH_DIGICOLOR)	+= digicolor
 machine-$(CONFIG_ARCH_DOVE)		+= dove
 machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
diff --git a/arch/arm/mach-digicolor/Kconfig b/arch/arm/mach-digicolor/Kconfig
deleted file mode 100644
index 90394433c405..000000000000
--- a/arch/arm/mach-digicolor/Kconfig
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config ARCH_DIGICOLOR
-	bool "Conexant Digicolor SoC Support"
-	depends on ARCH_MULTI_V7
-	select CLKSRC_MMIO
-	select DIGICOLOR_TIMER
-	select GENERIC_IRQ_CHIP
-	select GPIOLIB
-	select MFD_SYSCON
-	select PINCTRL
-	select PINCTRL_DIGICOLOR
diff --git a/arch/arm/mach-digicolor/Makefile b/arch/arm/mach-digicolor/Makefile
deleted file mode 100644
index fc5b7c98c824..000000000000
--- a/arch/arm/mach-digicolor/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ARCH_DIGICOLOR)	+= digicolor.o
diff --git a/arch/arm/mach-digicolor/digicolor.c b/arch/arm/mach-digicolor/digicolor.c
deleted file mode 100644
index 156d0d5996a9..000000000000
--- a/arch/arm/mach-digicolor/digicolor.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Support for Conexant Digicolor SoCs
-*/
-
-#include <asm/mach/arch.h>
-
-static const char *const digicolor_dt_compat[] __initconst = {
-	"cnxt,cx92755",
-	NULL,
-};
-
-DT_MACHINE_START(DIGICOLOR, "Conexant Digicolor (Flattened Device Tree)")
-	.dt_compat	= digicolor_dt_compat,
-MACHINE_END
-- 
2.39.2

