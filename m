Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6D61548D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiKAV6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiKAV6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:58:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF6862E9;
        Tue,  1 Nov 2022 14:58:29 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1LwBuC114352;
        Tue, 1 Nov 2022 16:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667339891;
        bh=OmJJ6NZBuBxJlMElY8L+QrijTrFREPNLv/QNZTxd4Gs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=I+ieZhPYlQiF9Gj8QtqA5K+oBIqORb+9FUSO8J1E+/9EXFYA637/U/C7b2bzsRU/y
         vBWymYKcNBvXAuJSnzvlVKmxuXHQcp16mxvXtBQTnyAOOz4X5bgKvwSb0PsO9jU000
         9tQ+UesJeEH6ML8Y/d5TLd3TIoTert1ME2jCA3lc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1LwBCD021673
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 16:58:11 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 16:58:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 16:58:11 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1Lw44t117953;
        Tue, 1 Nov 2022 16:58:10 -0500
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v4 8/9] ARM: nspire: Use syscon-reboot to handle restart
Date:   Tue, 1 Nov 2022 16:58:03 -0500
Message-ID: <20221101215804.16262-9-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221101215804.16262-1-afd@ti.com>
References: <20221101215804.16262-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing this bit can be handled by the DT syscon-reboot driver.
Enable that driver and remove the machine_desc version.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Fabian Vogt <fabian@ritter-vogt.de>
Reviewed-by: Fabian Vogt <fabian@ritter-vogt.de>
---
 arch/arm/mach-nspire/Kconfig  |  2 ++
 arch/arm/mach-nspire/mmio.h   |  3 ---
 arch/arm/mach-nspire/nspire.c | 10 ----------
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-nspire/Kconfig b/arch/arm/mach-nspire/Kconfig
index b7a3871876d75..0ffdcaca1e6b4 100644
--- a/arch/arm/mach-nspire/Kconfig
+++ b/arch/arm/mach-nspire/Kconfig
@@ -9,5 +9,7 @@ config ARCH_NSPIRE
 	select ARM_VIC
 	select ARM_TIMER_SP804
 	select NSPIRE_TIMER
+	select POWER_RESET
+	select POWER_RESET_SYSCON
 	help
 	  This enables support for systems using the TI-NSPIRE CPU
diff --git a/arch/arm/mach-nspire/mmio.h b/arch/arm/mach-nspire/mmio.h
index 48e32f13f3119..2ce0656139ece 100644
--- a/arch/arm/mach-nspire/mmio.h
+++ b/arch/arm/mach-nspire/mmio.h
@@ -5,9 +5,6 @@
  *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
 
-#define NSPIRE_MISC_PHYS_BASE		0x900A0000
-#define NSPIRE_MISC_HWRESET		0x08
-
 #define NSPIRE_PWR_PHYS_BASE		0x900B0000
 #define NSPIRE_PWR_VIRT_BASE		0xFEEB0000
 #define NSPIRE_PWR_BUS_DISABLE1		0x18
diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 2d4abb0288b9d..1e13337972dd5 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -27,16 +27,6 @@ static const char *const nspire_dt_match[] __initconst = {
 	NULL,
 };
 
-static void nspire_restart(enum reboot_mode mode, const char *cmd)
-{
-	void __iomem *base = ioremap(NSPIRE_MISC_PHYS_BASE, SZ_4K);
-	if (!base)
-		return;
-
-	writel(2, base + NSPIRE_MISC_HWRESET);
-}
-
 DT_MACHINE_START(NSPIRE, "TI-NSPIRE")
 	.dt_compat	= nspire_dt_match,
-	.restart	= nspire_restart,
 MACHINE_END
-- 
2.37.3

