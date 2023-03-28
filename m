Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BE76CC04A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjC1NLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjC1NLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:11:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4164BBA1;
        Tue, 28 Mar 2023 06:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9897B8184D;
        Tue, 28 Mar 2023 13:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10F9C433D2;
        Tue, 28 Mar 2023 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680009079;
        bh=lJyiBCVdnzxr4yd5Lb2VGLQC1Zp1xb1Nz87QPZwsGSI=;
        h=From:To:Cc:Subject:Date:From;
        b=YsDET0ju8F6Q8xDcaF6krp5Ykg3FLeXzqVIWTebSehbvu2h7XwxXtajYgHgyVEpkR
         f5OmcLAwpQIvg8gYsKPCFTjz1Aw1uK7IKpqkO1GUhcH+rXVO/AQf30RInoCsB2CWFQ
         VPZ65Pzu56PrMr6lNkQ985Q4kiQMgDeGKc67QOIIMbAjeZCpQuU5O/imwyNT6dd48i
         1yGNpf0CmPNEdyRWl2wVydjMke5SS+qtVfFNm3v2h13feTWQJ18ni72fE3wJytnNCB
         OIwy+SZYanGUwoCLlQufQNvxE6ApCUJAEKhwFPd1kxe71w57FBg0tZzbxwyLfXbWe1
         2r46WEmMrjCCw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josue David Hernandez Gutierrez 
        <josue.d.hernandez.gutierrez@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals
Date:   Tue, 28 Mar 2023 15:10:43 +0200
Message-Id: <20230328131114.1296430-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A recent patch caused an unused-function warning in builds with
CONFIG_PM disabled, after the function became marked 'static':

drivers/usb/host/xhci-pci.c:91:13: error: 'xhci_msix_sync_irqs' defined but not used [-Werror=unused-function]
   91 | static void xhci_msix_sync_irqs(struct xhci_hcd *xhci)
      |             ^~~~~~~~~~~~~~~~~~~

This could be solved by adding another #ifdef, but as there is
a trend towards removing CONFIG_PM checks in favor of helper
macros, do the same conversion here and use pm_ptr() to get
either a function pointer or NULL but avoid the warning.

As the hidden functions reference some other symbols, make
sure those are visible at compile time, at the minimal cost of
a few extra bytes for 'struct usb_device'.

Fixes: 9abe15d55dcc ("xhci: Move xhci MSI sync function to to xhci-pci")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/xhci-pci.c | 16 +++++-----------
 include/linux/usb.h         |  3 +--
 include/linux/usb/hcd.h     |  2 --
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a53ecc8ff8c5..bbbb01282038 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -728,7 +728,6 @@ static void xhci_pci_remove(struct pci_dev *dev)
 	usb_hcd_pci_remove(dev);
 }
 
-#ifdef CONFIG_PM
 /*
  * In some Intel xHCI controllers, in order to get D3 working,
  * through a vendor specific SSIC CONFIG register at offset 0x883c,
@@ -927,7 +926,6 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
-#endif /* CONFIG_PM */
 
 /*-------------------------------------------------------------------------*/
 
@@ -970,9 +968,7 @@ static struct pci_driver xhci_pci_driver = {
 
 	.shutdown = 	usb_hcd_pci_shutdown,
 	.driver = {
-#ifdef CONFIG_PM
-		.pm = &usb_hcd_pci_pm_ops,
-#endif
+		.pm = pm_ptr(&usb_hcd_pci_pm_ops),
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
@@ -980,12 +976,10 @@ static struct pci_driver xhci_pci_driver = {
 static int __init xhci_pci_init(void)
 {
 	xhci_init_driver(&xhci_pci_hc_driver, &xhci_pci_overrides);
-#ifdef CONFIG_PM
-	xhci_pci_hc_driver.pci_suspend = xhci_pci_suspend;
-	xhci_pci_hc_driver.pci_resume = xhci_pci_resume;
-	xhci_pci_hc_driver.pci_poweroff_late = xhci_pci_poweroff_late;
-	xhci_pci_hc_driver.shutdown = xhci_pci_shutdown;
-#endif
+	xhci_pci_hc_driver.pci_suspend = pm_ptr(xhci_pci_suspend);
+	xhci_pci_hc_driver.pci_resume = pm_ptr(xhci_pci_resume);
+	xhci_pci_hc_driver.pci_poweroff_late = pm_ptr(xhci_pci_poweroff_late);
+	xhci_pci_hc_driver.shutdown = pm_ptr(xhci_pci_shutdown);
 	xhci_pci_hc_driver.stop = xhci_pci_stop;
 	return pci_register_driver(&xhci_pci_driver);
 }
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 9642ee02d713..d510fabcafa2 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -704,13 +704,12 @@ struct usb_device {
 
 	unsigned long active_duration;
 
-#ifdef CONFIG_PM
 	unsigned long connect_time;
 
 	unsigned do_remote_wakeup:1;
 	unsigned reset_resume:1;
 	unsigned port_is_suspended:1;
-#endif
+
 	struct wusb_dev *wusb_dev;
 	int slot_id;
 	struct usb2_lpm_parameters l1_params;
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index b51c07111729..094c77eaf455 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -488,9 +488,7 @@ extern void usb_hcd_pci_shutdown(struct pci_dev *dev);
 
 extern int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *dev);
 
-#ifdef CONFIG_PM
 extern const struct dev_pm_ops usb_hcd_pci_pm_ops;
-#endif
 #endif /* CONFIG_USB_PCI */
 
 /* pci-ish (pdev null is ok) buffer alloc/mapping support */
-- 
2.39.2

