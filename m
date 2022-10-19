Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9340604B12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiJSPTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiJSPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:19:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B61D5E37
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B4DC61908
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2010BC433C1;
        Wed, 19 Oct 2022 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666192257;
        bh=5xA6B6Lhx1HQ5zgGPm0eHA4kLMFysAAeoFzT5uQjs8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HymqCo6Wgbr9158vual4dtY6Z6kWTheel++NX6FxkCDLDPz/WtOfVkY6pPK0X8uIG
         BZ96t2SpLpDVwZW/1dCg+JX60hiU7+EFrNJSniwPjabX+qdr0fVhMM2Ch9Sudgn0GZ
         WngN9wQqMCPg6JUuJ4LtNl369yP2Eh7PNbbehbQyMGNWqFETXrtIAAKxAWGk/6yw4M
         w1zZThnWioAUzYgLmpWGFY+GVY5iXPBSTq5IhETugIBnLxnU4r/iAwJ76A4p0rFURW
         ujP3ZP5IuAyHvVboSDPwXoXqam013eYLrLVgrPyyrgXwp1vIFiRzJpZnsUYYdXQ7Ta
         76wkNub2AdcJw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/17] ARM: orion5x: remove dsa_chip_data references
Date:   Wed, 19 Oct 2022 17:03:30 +0200
Message-Id: <20221019150410.3851944-8-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019150410.3851944-1-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is no longer used anywhere, which means we can kill off
one link to gpio numbers.

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-orion5x/common.c            | 10 --------
 arch/arm/mach-orion5x/common.h            |  2 --
 arch/arm/plat-orion/common.c              | 31 -----------------------
 arch/arm/plat-orion/include/plat/common.h |  3 ---
 4 files changed, 46 deletions(-)

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 2e711b7252c6..df056d60b675 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -18,7 +18,6 @@
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
 #include <linux/cpu.h>
-#include <linux/platform_data/dsa.h>
 #include <asm/page.h>
 #include <asm/setup.h>
 #include <asm/system_misc.h>
@@ -100,15 +99,6 @@ void __init orion5x_eth_init(struct mv643xx_eth_platform_data *eth_data)
 }
 
 
-/*****************************************************************************
- * Ethernet switch
- ****************************************************************************/
-void __init orion5x_eth_switch_init(struct dsa_chip_data *d)
-{
-	orion_ge00_switch_init(d);
-}
-
-
 /*****************************************************************************
  * I2C
  ****************************************************************************/
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index eb96009e21c4..f2e0577bf50f 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -4,7 +4,6 @@
 
 #include <linux/reboot.h>
 
-struct dsa_chip_data;
 struct mv643xx_eth_platform_data;
 struct mv_sata_platform_data;
 
@@ -42,7 +41,6 @@ void orion5x_setup_wins(void);
 void orion5x_ehci0_init(void);
 void orion5x_ehci1_init(void);
 void orion5x_eth_init(struct mv643xx_eth_platform_data *eth_data);
-void orion5x_eth_switch_init(struct dsa_chip_data *d);
 void orion5x_i2c_init(void);
 void orion5x_sata_init(struct mv_sata_platform_data *sata_data);
 void orion5x_spi_init(void);
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 8647cb80a93b..cabe98386245 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -18,7 +18,6 @@
 #include <linux/clkdev.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/mv643xx_i2c.h>
-#include <linux/platform_data/dsa.h>
 #include <linux/platform_data/dma-mv_xor.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <plat/common.h>
@@ -468,36 +467,6 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
 		    eth_data, &orion_ge11);
 }
 
-#ifdef CONFIG_ARCH_ORION5X
-/*****************************************************************************
- * Ethernet switch
- ****************************************************************************/
-static __initdata struct mdio_board_info orion_ge00_switch_board_info = {
-	.bus_id   = "orion-mii",
-	.modalias = "mv88e6085",
-};
-
-void __init orion_ge00_switch_init(struct dsa_chip_data *d)
-{
-	unsigned int i;
-
-	if (!IS_BUILTIN(CONFIG_PHYLIB))
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(d->port_names); i++) {
-		if (!strcmp(d->port_names[i], "cpu")) {
-			d->netdev[i] = &orion_ge00.dev;
-			break;
-		}
-	}
-
-	orion_ge00_switch_board_info.mdio_addr = d->sw_addr;
-	orion_ge00_switch_board_info.platform_data = d;
-
-	mdiobus_register_board_info(&orion_ge00_switch_board_info, 1);
-}
-#endif
-
 /*****************************************************************************
  * I2C
  ****************************************************************************/
diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
index 3647d3b33c20..d2aad95d20cb 100644
--- a/arch/arm/plat-orion/include/plat/common.h
+++ b/arch/arm/plat-orion/include/plat/common.h
@@ -12,7 +12,6 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 
-struct dsa_chip_data;
 struct mv_sata_platform_data;
 
 void __init orion_uart0_init(void __iomem *membase,
@@ -57,8 +56,6 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
 			    unsigned long mapbase,
 			    unsigned long irq);
 
-void __init orion_ge00_switch_init(struct dsa_chip_data *d);
-
 void __init orion_i2c_init(unsigned long mapbase,
 			   unsigned long irq,
 			   unsigned long freq_m);
-- 
2.29.2

