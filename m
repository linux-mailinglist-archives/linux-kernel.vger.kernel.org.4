Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531756ACF3C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCFUcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCFUbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:31:53 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F3D46082
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:31:51 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 326GYg6K073609;
        Mon, 6 Mar 2023 10:34:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678120482;
        bh=xUV0d0zPHMcB/XpIK1gMEv8UcZgIebHcrjb5lOV2vgg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=A2Up5aTiJvuRE5I87dcth0TbIu9BjWSyWfizCeSohcw2sRWb4XNo/cT3xpFbad1ks
         H7KyDE/P2VAq9v8i6ZDd2ubV3/0l3Y31Nk2pZawVsHQett3OMykF7NLR7QNN9Zw1k/
         H+PUF2w42hwWzdqYruhR/6uikRoytI+ChC0t3xBM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 326GYgfG075741
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Mar 2023 10:34:42 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 6
 Mar 2023 10:34:42 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 6 Mar 2023 10:34:42 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 326GYfME110554;
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
Subject: [PATCH 09/10] ARM: mach-lpc18xx: Rework support and directory structure
Date:   Mon, 6 Mar 2023 10:34:40 -0600
Message-ID: <20230306163441.16179-9-afd@ti.com>
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

The mach-lpc18xx/ directory and files, provides just one "feature":
having the kernel print the machine name if the DTB does not also contain
a "model" string (which they always do). To reduce the number of mach-*
directories let's do without that feature and remove this directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Makefile                |  1 -
 arch/arm/mach-lpc18xx/Makefile   |  2 --
 arch/arm/mach-lpc18xx/board-dt.c | 19 -------------------
 3 files changed, 22 deletions(-)
 delete mode 100644 arch/arm/mach-lpc18xx/Makefile
 delete mode 100644 arch/arm/mach-lpc18xx/board-dt.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ec5adf695a0c..94ebd137f0ec 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -185,7 +185,6 @@ machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HISI)		+= hisi
 machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
 machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
-machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
diff --git a/arch/arm/mach-lpc18xx/Makefile b/arch/arm/mach-lpc18xx/Makefile
deleted file mode 100644
index c80d80c199d3..000000000000
--- a/arch/arm/mach-lpc18xx/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y += board-dt.o
diff --git a/arch/arm/mach-lpc18xx/board-dt.c b/arch/arm/mach-lpc18xx/board-dt.c
deleted file mode 100644
index 4729eb83401a..000000000000
--- a/arch/arm/mach-lpc18xx/board-dt.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Device Tree board file for NXP LPC18xx/43xx
- *
- * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
- */
-
-#include <asm/mach/arch.h>
-
-static const char *const lpc18xx_43xx_compat[] __initconst = {
-	"nxp,lpc1850",
-	"nxp,lpc4350",
-	"nxp,lpc4370",
-	NULL
-};
-
-DT_MACHINE_START(LPC18XXDT, "NXP LPC18xx/43xx (Device Tree)")
-	.dt_compat = lpc18xx_43xx_compat,
-MACHINE_END
-- 
2.39.2

