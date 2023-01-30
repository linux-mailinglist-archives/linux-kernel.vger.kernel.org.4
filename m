Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D541D680E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbjA3NEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjA3NEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:04:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5537C1724;
        Mon, 30 Jan 2023 05:04:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5A91BCE13AA;
        Mon, 30 Jan 2023 13:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EFDC433D2;
        Mon, 30 Jan 2023 13:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675083872;
        bh=5mD/bBnB3Pzdve9B8z6/18LEwPDu/XSyvFNljbftvFs=;
        h=From:To:Cc:Subject:Date:From;
        b=JhtvhfdT4RoDqW2uaa6eMUqgqIQfikTNGfHGSRs8XBkPOyso+srzHhn/bmOZXC4J8
         vkCfDP3kJp4eslTbO+d3tFVWSucJsSFSj304GJcxS+oMolg5SQumTcHCbN5bbwwTG0
         TqBbYYtcs/0Dh+T2BeNrexrsN+GNmwRnGrsjuFYqi/TAeb96ZtLSF07H+NqGBHkcnV
         f9FvZ7b7ustilJNk/afB/ly9BF4d29m7H5zBg1/OlOR4LDG3dnEbc2WtFcTyTFI1cA
         Z2jbPusJ7ZwKkTPbpnqqi8oUCnAsaGhyswjuu9T+iZanwMkNc5aFRskNAb5phCiNhj
         Z2ojA+rIjlFbQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: host: renesas: drop excessive Kconfig selects
Date:   Mon, 30 Jan 2023 14:03:41 +0100
Message-Id: <20230130130425.310410-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The USB_XHCI_RZV2M and USB_RENESAS_USB3 select other drivers
based on the enabled SoC types, which leads to build failures
when the dependencies are not met:

WARNING: unmet direct dependencies detected for USB_RZV2M_USB3DRD
  Depends on [n]: USB_SUPPORT [=y] && USB_GADGET [=n] && (ARCH_R9A09G011 [=n] || COMPILE_TEST [=y])
  Selected by [m]:
  - USB_XHCI_RZV2M [=m] && USB_SUPPORT [=y] && USB [=y] && USB_XHCI_HCD [=m] && USB_XHCI_PLATFORM [=m] && (ARCH_R9A09G011 [=n] || COMPILE_TEST [=y])
ERROR: modpost: "rzv2m_usb3drd_reset" [drivers/usb/host/xhci-plat-hcd.ko] undefined!

All the selected symbols are actually user visible, so the correct
approach here is to drop the incorrect 'select' statements and
have users turn on those drivers during kernel configuration as
they would for any other driver.

Fixes: c52c9acc415e ("xhci: host: Add Renesas RZ/V2M SoC support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/Kconfig | 1 -
 drivers/usb/host/Kconfig       | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 9b7a1681550f..1821004dd325 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -195,7 +195,6 @@ config USB_RENESAS_USB3
 	tristate 'Renesas USB3.0 Peripheral controller'
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on EXTCON
-	select USB_RZV2M_USB3DRD if ARCH_R9A09G011
 	select USB_ROLE_SWITCH
 	help
 	   Renesas USB3.0 Peripheral controller is a USB peripheral controller
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 4b5c5b1feb40..b975178b38bf 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -53,8 +53,6 @@ config USB_XHCI_PCI_RENESAS
 
 config USB_XHCI_PLATFORM
 	tristate "Generic xHCI driver for a platform device"
-	select USB_XHCI_RCAR if ARCH_RENESAS
-	select USB_XHCI_RZV2M if ARCH_R9A09G011
 	help
 	  Adds an xHCI host driver for a generic platform device, which
 	  provides a memory space and an irq.
@@ -100,7 +98,6 @@ config USB_XHCI_RZV2M
 	tristate "xHCI support for Renesas RZ/V2M SoC"
 	depends on USB_XHCI_PLATFORM
 	depends on ARCH_R9A09G011 || COMPILE_TEST
-	select USB_RZV2M_USB3DRD
 	help
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in Renesas RZ/V2M SoC.
-- 
2.39.0

