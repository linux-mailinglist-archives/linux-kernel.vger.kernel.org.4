Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAD46ACD9E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCFTK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCFTK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:10:56 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A24C6D3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:10:46 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 326GYgfL037933;
        Mon, 6 Mar 2023 10:34:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678120482;
        bh=Ky9tpP149pRwon/LMbangD0GUhnkR2iDx2xe4ye7AHI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uP8GDAhw7bos4Ys+TEDs8FpG/2JD0suowtUuAqsufhxwFSItE31v+PXtXOFdDAlmQ
         lYXZa7Q0wAI4Q2rRwqz4ZiV3ycYz9xAJo63bZYc/0vb9AGfsBr1xKXIA29faLZcnSB
         Nl2OzezQVBi1Y2Ix/EIjq3Ki1xggwIWuhycLz9tg=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 326GYgmf101907
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Mar 2023 10:34:42 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 6
 Mar 2023 10:34:41 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 6 Mar 2023 10:34:41 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 326GYfMC110554;
        Mon, 6 Mar 2023 10:34:41 -0600
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
Subject: [PATCH 07/10] ARM: mach-digicolor: Rework support and directory structure
Date:   Mon, 6 Mar 2023 10:34:38 -0600
Message-ID: <20230306163441.16179-7-afd@ti.com>
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
index e8ac56398f76..90086040de90 100644
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
index d146db4ce15d..c2f5925b15fa 100644
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

