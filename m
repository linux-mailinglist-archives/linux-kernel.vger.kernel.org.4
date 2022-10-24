Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EFD60B370
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiJXRGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiJXREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F2DD7E0F;
        Mon, 24 Oct 2022 08:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B95F16148A;
        Mon, 24 Oct 2022 15:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7591C433D7;
        Mon, 24 Oct 2022 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625907;
        bh=tpowaSybpyNA+t6AEvixmC0U/dYh2ATqWHcp/dHVolQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdatf/tkH/vqBh5hbFFM+dlLWLWT9Jqjit2MozXc2qvLMmoD/+dJWyjY0K7i2oj1J
         0hE77wyWGyE52BmwX9BZKeKxEOEaTdMA+zm9O7rkjHHMv0Pz3EU+F1KDcWAhtT+H6X
         fVFBzI/4XPgD8qoZSVAF0OqiTx8aAOIQaTFVY2NvOsUBCCmqOTJm0uZrc1eulmNGDA
         olGxYY9x+jhfDgS0VqEdR+gbnWHDbWlf4HJmR9lYFwanPSuegB05Ghs1J9WoR4+h2s
         wjE7UONPC2iOgWb20xLctUOBeCv3aIo96O4iDT2vDxrzsLtl2ASeUX8HbdFL1QMhwX
         nzyTbw0HXk+cg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/10] ARM: omap2: remove unused USB code
Date:   Mon, 24 Oct 2022 17:38:05 +0200
Message-Id: <20221024153814.254652-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221024153814.254652-1-arnd@kernel.org>
References: <20221024153814.254652-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some musb related code is no longer in use after commit 4d62dbda8561
("ARM: OMAP3: Remove legacy support for am3517-evm") and can be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/common.h            |  2 -
 arch/arm/mach-omap2/omap_phy_internal.c | 87 -------------------------
 arch/arm/mach-omap2/usb.h               | 71 --------------------
 3 files changed, 160 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/usb.h

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index bd5981945239..f8f9cc5b6964 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -40,8 +40,6 @@
 #include "i2c.h"
 #include "serial.h"
 
-#include "usb.h"
-
 #define OMAP_INTC_START		NR_IRQS
 
 extern int (*omap_pm_soc_init)(void);
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 6f6a6a66c981..21c6e7929d37 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -19,7 +19,6 @@
 
 #include "soc.h"
 #include "control.h"
-#include "usb.h"
 
 #define CONTROL_DEV_CONF		0x300
 #define PHY_PD				0x1
@@ -52,89 +51,3 @@ static int __init omap4430_phy_power_down(void)
 	return 0;
 }
 omap_early_initcall(omap4430_phy_power_down);
-
-void am35x_musb_reset(void)
-{
-	u32	regval;
-
-	/* Reset the musb interface */
-	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
-
-	regval |= AM35XX_USBOTGSS_SW_RST;
-	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
-
-	regval &= ~AM35XX_USBOTGSS_SW_RST;
-	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
-
-	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
-}
-
-void am35x_musb_phy_power(u8 on)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(100);
-	u32 devconf2;
-
-	if (on) {
-		/*
-		 * Start the on-chip PHY and its PLL.
-		 */
-		devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
-
-		devconf2 &= ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OTGPWRDN);
-		devconf2 |= CONF2_PHY_PLLON;
-
-		omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
-
-		pr_info("Waiting for PHY clock good...\n");
-		while (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
-				& CONF2_PHYCLKGD)) {
-			cpu_relax();
-
-			if (time_after(jiffies, timeout)) {
-				pr_err("musb PHY clock good timed out\n");
-				break;
-			}
-		}
-	} else {
-		/*
-		 * Power down the on-chip PHY.
-		 */
-		devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
-
-		devconf2 &= ~CONF2_PHY_PLLON;
-		devconf2 |=  CONF2_PHYPWRDN | CONF2_OTGPWRDN;
-		omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
-	}
-}
-
-void am35x_musb_clear_irq(void)
-{
-	u32 regval;
-
-	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-	regval |= AM35XX_USBOTGSS_INT_CLR;
-	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
-	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-}
-
-void am35x_set_mode(u8 musb_mode)
-{
-	u32 devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
-
-	devconf2 &= ~CONF2_OTGMODE;
-	switch (musb_mode) {
-	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
-		devconf2 |= CONF2_FORCE_HOST;
-		break;
-	case MUSB_PERIPHERAL:	/* Force VBUS valid, ID = 1 */
-		devconf2 |= CONF2_FORCE_DEVICE;
-		break;
-	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
-		devconf2 |= CONF2_NO_OVERRIDE;
-		break;
-	default:
-		pr_info("Unsupported mode %u\n", musb_mode);
-	}
-
-	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
-}
diff --git a/arch/arm/mach-omap2/usb.h b/arch/arm/mach-omap2/usb.h
deleted file mode 100644
index 740a499befce..000000000000
--- a/arch/arm/mach-omap2/usb.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/platform_data/usb-omap.h>
-
-/* AM35x */
-/* USB 2.0 PHY Control */
-#define CONF2_PHY_GPIOMODE	(1 << 23)
-#define CONF2_OTGMODE		(3 << 14)
-#define CONF2_NO_OVERRIDE	(0 << 14)
-#define CONF2_FORCE_HOST	(1 << 14)
-#define CONF2_FORCE_DEVICE	(2 << 14)
-#define CONF2_FORCE_HOST_VBUS_LOW (3 << 14)
-#define CONF2_SESENDEN		(1 << 13)
-#define CONF2_VBDTCTEN		(1 << 12)
-#define CONF2_REFFREQ_24MHZ	(2 << 8)
-#define CONF2_REFFREQ_26MHZ	(7 << 8)
-#define CONF2_REFFREQ_13MHZ	(6 << 8)
-#define CONF2_REFFREQ		(0xf << 8)
-#define CONF2_PHYCLKGD		(1 << 7)
-#define CONF2_VBUSSENSE		(1 << 6)
-#define CONF2_PHY_PLLON		(1 << 5)
-#define CONF2_RESET		(1 << 4)
-#define CONF2_PHYPWRDN		(1 << 3)
-#define CONF2_OTGPWRDN		(1 << 2)
-#define CONF2_DATPOL		(1 << 1)
-
-/* TI81XX specific definitions */
-#define USBCTRL0	0x620
-#define USBSTAT0	0x624
-
-/* TI816X PHY controls bits */
-#define TI816X_USBPHY0_NORMAL_MODE	(1 << 0)
-#define TI816X_USBPHY_REFCLK_OSC	(1 << 8)
-
-/* TI814X PHY controls bits */
-#define USBPHY_CM_PWRDN		(1 << 0)
-#define USBPHY_OTG_PWRDN	(1 << 1)
-#define USBPHY_CHGDET_DIS	(1 << 2)
-#define USBPHY_CHGDET_RSTRT	(1 << 3)
-#define USBPHY_SRCONDM		(1 << 4)
-#define USBPHY_SINKONDP		(1 << 5)
-#define USBPHY_CHGISINK_EN	(1 << 6)
-#define USBPHY_CHGVSRC_EN	(1 << 7)
-#define USBPHY_DMPULLUP		(1 << 8)
-#define USBPHY_DPPULLUP		(1 << 9)
-#define USBPHY_CDET_EXTCTL	(1 << 10)
-#define USBPHY_GPIO_MODE	(1 << 12)
-#define USBPHY_DPOPBUFCTL	(1 << 13)
-#define USBPHY_DMOPBUFCTL	(1 << 14)
-#define USBPHY_DPINPUT		(1 << 15)
-#define USBPHY_DMINPUT		(1 << 16)
-#define USBPHY_DPGPIO_PD	(1 << 17)
-#define USBPHY_DMGPIO_PD	(1 << 18)
-#define USBPHY_OTGVDET_EN	(1 << 19)
-#define USBPHY_OTGSESSEND_EN	(1 << 20)
-#define USBPHY_DATA_POLARITY	(1 << 23)
-
-struct usbhs_phy_data {
-	int port;		/* 1 indexed port number */
-	int reset_gpio;
-	int vcc_gpio;
-	bool vcc_polarity;	/* 1 active high, 0 active low */
-};
-
-extern void usb_musb_init(struct omap_musb_board_data *board_data);
-extern void usbhs_init(struct usbhs_omap_platform_data *pdata);
-extern int usbhs_init_phys(struct usbhs_phy_data *phy, int num_phys);
-
-extern void am35x_musb_reset(void);
-extern void am35x_musb_phy_power(u8 on);
-extern void am35x_musb_clear_irq(void);
-extern void am35x_set_mode(u8 musb_mode);
-- 
2.29.2

