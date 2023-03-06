Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299C06AC853
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCFQjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCFQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:37:53 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8B43029B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:36:50 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 326GYg4o037926;
        Mon, 6 Mar 2023 10:34:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678120482;
        bh=36HPc20Av2a4E1MK2c2q9PRaM1msVDPTCRfwCTMDVmM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GW6TUA9JnZPj7xriLfirPHC2BXPjtf5MGbOQdmJEZwB1FmMYeZHSx4ScCYW/SqGgp
         2h1Jex2qD98fxFmcNq9Uwn3nCu1/KTcpb19zv83+/aD+odjZYMItOb79CdUZ3nFuv/
         e2nW3luzD7VjPpLAyRk0jLn1PDaFyt4wG2ah9INk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 326GYg9d075730
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Mar 2023 10:34:42 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 6
 Mar 2023 10:34:42 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 6 Mar 2023 10:34:41 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 326GYfMA110554;
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
Subject: [PATCH 05/10] ARM: mach-moxart: Move MOXA ART support into Kconfig.platforms
Date:   Mon, 6 Mar 2023 10:34:36 -0600
Message-ID: <20230306163441.16179-5-afd@ti.com>
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

This removes the need for a dedicated Kconfig and empty mach directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Kconfig              |  2 --
 arch/arm/Kconfig.platforms    | 28 ++++++++++++++++++++++++++++
 arch/arm/Makefile             |  1 -
 arch/arm/mach-moxart/Kconfig  | 28 ----------------------------
 arch/arm/mach-moxart/Makefile |  4 ----
 arch/arm/mach-moxart/moxart.c |  6 ------
 6 files changed, 28 insertions(+), 41 deletions(-)
 delete mode 100644 arch/arm/mach-moxart/Kconfig
 delete mode 100644 arch/arm/mach-moxart/Makefile
 delete mode 100644 arch/arm/mach-moxart/moxart.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e0b45269aa49..02f284681994 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -408,8 +408,6 @@ source "arch/arm/mach-milbeaut/Kconfig"
 
 source "arch/arm/mach-mmp/Kconfig"
 
-source "arch/arm/mach-moxart/Kconfig"
-
 source "arch/arm/mach-mstar/Kconfig"
 
 source "arch/arm/mach-mv78xx0/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index 0e6d7172bf61..4b5fad18ca8b 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -76,6 +76,34 @@ config MACH_ASM9260
 	help
 	  Support for Alphascale ASM9260 based platform.
 
+menuconfig ARCH_MOXART
+	bool "MOXA ART SoC"
+	depends on ARCH_MULTI_V4
+	depends on CPU_LITTLE_ENDIAN
+	select CPU_FA526
+	select ARM_DMA_MEM_BUFFERABLE
+	select FARADAY_FTINTC010
+	select FTTMR010_TIMER
+	select GPIOLIB
+	select PHYLIB if NETDEVICES
+	help
+	  Say Y here if you want to run your kernel on hardware with a
+	  MOXA ART SoC.
+	  The MOXA ART SoC is based on a Faraday FA526 ARMv4 32-bit
+	  192 MHz CPU with MMU and 16KB/8KB D/I-cache (UC-7112-LX).
+	  Used on models UC-7101, UC-7112/UC-7110, IA240/IA241, IA3341.
+
+if ARCH_MOXART
+
+config MACH_UC7112LX
+	bool "MOXA UC-7112-LX"
+	depends on ARCH_MOXART
+	help
+	  Say Y here if you intend to run this kernel on a MOXA
+	  UC-7112-LX embedded computer.
+
+endif
+
 config ARCH_RDA
 	bool "RDA Micro SoCs"
 	depends on ARCH_MULTI_V7
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 485a439e22ca..f861204fcd4e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -192,7 +192,6 @@ machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
-machine-$(CONFIG_ARCH_MOXART)		+= moxart
 machine-$(CONFIG_ARCH_MV78XX0)		+= mv78xx0
 machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
 machine-$(CONFIG_ARCH_MXC)		+= imx
diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
deleted file mode 100644
index 909c6573ba8b..000000000000
--- a/arch/arm/mach-moxart/Kconfig
+++ /dev/null
@@ -1,28 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_MOXART
-	bool "MOXA ART SoC"
-	depends on ARCH_MULTI_V4
-	depends on CPU_LITTLE_ENDIAN
-	select CPU_FA526
-	select ARM_DMA_MEM_BUFFERABLE
-	select FARADAY_FTINTC010
-	select FTTMR010_TIMER
-	select GPIOLIB
-	select PHYLIB if NETDEVICES
-	help
-	  Say Y here if you want to run your kernel on hardware with a
-	  MOXA ART SoC.
-	  The MOXA ART SoC is based on a Faraday FA526 ARMv4 32-bit
-	  192 MHz CPU with MMU and 16KB/8KB D/I-cache (UC-7112-LX).
-	  Used on models UC-7101, UC-7112/UC-7110, IA240/IA241, IA3341.
-
-if ARCH_MOXART
-
-config MACH_UC7112LX
-	bool "MOXA UC-7112-LX"
-	depends on ARCH_MOXART
-	help
-	  Say Y here if you intend to run this kernel on a MOXA
-	  UC-7112-LX embedded computer.
-
-endif
diff --git a/arch/arm/mach-moxart/Makefile b/arch/arm/mach-moxart/Makefile
deleted file mode 100644
index ded3e38fb98d..000000000000
--- a/arch/arm/mach-moxart/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Object file lists.
-
-obj-$(CONFIG_MACH_UC7112LX)	+= moxart.o
diff --git a/arch/arm/mach-moxart/moxart.c b/arch/arm/mach-moxart/moxart.c
deleted file mode 100644
index f1f58c0c0fa1..000000000000
--- a/arch/arm/mach-moxart/moxart.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/mach-moxart/moxart.c
- *
- * (C) Copyright 2013, Jonas Jensen <jonas.jensen@gmail.com>
- */
-- 
2.39.2

