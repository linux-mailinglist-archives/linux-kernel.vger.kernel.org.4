Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DD6703214
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbjEOQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242229AbjEOQDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:03:12 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849CBE5A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:03:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2fxY119239;
        Mon, 15 May 2023 11:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684166561;
        bh=5eShS47428T2bRPRMMSWbirvyOAz0ibuKCszyB2qk5A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=T0g1YukMTvBPw/FF3Y/MfGz4wDGl+wUKxbUp2l7W7rbHwtd3pe+a5/cohNngtfEcF
         nSwFkLcz+ZW8aeCl2HCPktL9kZoKZ7IIwmP5SU/1Ilmj8lBWdIYDDvDXGF2Ls30WSj
         3ISpXQGdvNlluDUX5dAD06b3TQm60fzmp90o0E9w=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FG2fD8060814
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 11:02:41 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 11:02:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 11:02:40 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2ZR8029578;
        Mon, 15 May 2023 11:02:40 -0500
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
Subject: [PATCH 09/10] ARM: mach-lpc18xx: Rework support and directory structure
Date:   Mon, 15 May 2023 11:02:33 -0500
Message-ID: <20230515160234.289631-9-afd@ti.com>
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
index d306cf8107dc..bab3d2485f80 100644
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

