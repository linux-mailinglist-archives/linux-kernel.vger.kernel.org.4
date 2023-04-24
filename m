Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402A26EC973
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjDXJvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjDXJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:51:39 -0400
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A562B30F4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:51:32 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id E94C85EB39;
        Mon, 24 Apr 2023 12:36:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-7EvCIZZi;
        Mon, 24 Apr 2023 12:36:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328968;
        bh=K0s3KX6GF6McSsZMczUuy8UP6UIYgxJXDX0bg9N6kp0=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=dupjRkbZ0vNSlMnwgp9Div0rlFnF/JtZmoUZp22nuI0n/s1QpK9kUuJsnB+7Nl1pS
         izTx810GWSRVg2aUJXiKnXr8GGeWXrx/pZv36sxy2VRBiiCwW90ZdjTkyExsexXOvZ
         mNA0wUpaI3r5I3/zcjWVQvQ/pqlA8kjDO/NowDfM=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 35/43] ARM: ep93xx: DT for the Cirrus ep93xx SoC platforms
Date:   Mon, 24 Apr 2023 15:34:51 +0300
Message-Id: <20230424123522.18302-36-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds compulsory device tree support to the Cirrus ep93xx ARMv4
platform.

- We select PINCTRL_EP93xx
- We select COMMON_CLK_EP93XX, as clock driver moved out of platform
  code
- We select ARCH_HAS_RESET_CONTROLLER

And also we need ARM_ATAG_DTB_COMPAT to update device tree with
information about memory passed from bootloader.

We have to leave all MACH options as they are used for board checking
before decomp, to turn off watchdog and ethernet DMA.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    rfc->v0
    - fixed typo
    - removed board-dt.c completely
    
    Alexander Sverdlin:
    - platfrom -> platform

 arch/arm/Makefile             |  1 -
 arch/arm/mach-ep93xx/Kconfig  | 20 ++++++++++----------
 arch/arm/mach-ep93xx/Makefile | 11 -----------
 3 files changed, 10 insertions(+), 22 deletions(-)
 delete mode 100644 arch/arm/mach-ep93xx/Makefile

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 485a439e22ca..8ad844ba777e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -179,7 +179,6 @@ machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
 machine-$(CONFIG_ARCH_DIGICOLOR)	+= digicolor
 machine-$(CONFIG_ARCH_DOVE)		+= dove
-machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 703f3d232a60..812b71dcf60e 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -3,27 +3,27 @@ menuconfig ARCH_EP93XX
 	bool "EP93xx-based"
 	depends on ATAGS
 	depends on ARCH_MULTI_V4T
+	# CONFIG_ARCH_MULTI_V7 is not set
 	depends on CPU_LITTLE_ENDIAN
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_SPARSEMEM_ENABLE
 	select ARM_AMBA
 	select ARM_VIC
+	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
+	select ARM_ATAG_DTB_COMPAT # we need this to update dt memory node
+	select COMMON_CLK_EP93XX
+	select EP93XX_TIMER
 	select CLKSRC_MMIO
 	select CPU_ARM920T
 	select GPIOLIB
+	select PINCTRL
+	select PINCTRL_EP93XX
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
 if ARCH_EP93XX
 
-menu "Cirrus EP93xx Implementation Options"
-
-config EP93XX_SOC_COMMON
-	bool
-	default y
-	select SOC_BUS
-	select LEDS_GPIO_REGISTER
-
-comment "EP93xx Platforms"
+# menu "EP93xx Platforms"
 
 config MACH_BK3
 	bool "Support Liebherr BK3.1"
@@ -103,6 +103,6 @@ config MACH_VISION_EP9307
 	  Say 'Y' here if you want your kernel to support the
 	  Vision Engraving Systems EP9307 SoM.
 
-endmenu
+# endmenu
 
 endif
diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
deleted file mode 100644
index 62e37403df14..000000000000
--- a/arch/arm/mach-ep93xx/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the linux kernel.
-#
-obj-y			:= core.o clock.o timer-ep93xx.o
-
-obj-$(CONFIG_EP93XX_DMA)	+= dma.o
-
-obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
-obj-$(CONFIG_MACH_TS72XX)	+= ts72xx.o
-obj-$(CONFIG_MACH_VISION_EP9307)+= vision_ep9307.o
-- 
2.39.2

