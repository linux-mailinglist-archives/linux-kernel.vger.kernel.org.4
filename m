Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700A96F953F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjEGAbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjEGAa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:30:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF231992C;
        Sat,  6 May 2023 17:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0E5161467;
        Sun,  7 May 2023 00:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDA0C433D2;
        Sun,  7 May 2023 00:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419449;
        bh=VRBMOAthZcWh7p7Zd4HD+qU//YN0XSOn9uaq3l6VrNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmC7nH+Z7ckZlntkfUjtj0QeIRqjsviLk1NFypvNmMOtZ4LoySqHixcjjE2EhhCDT
         JMGlb6LiKvpWHBACCigyFDrZU0Ctv1z74TW0RsDKmudfnge289cqQrJT8i28PZuy8Q
         LAZr7HABqdui597oOxtstAWoPbqnya003stBqRx8qEoMSHUXyaoT/XIYqK49O3JQs2
         k3uo/ew8DfR2lmtmAzYONVIav2sutKtvxH8BNLHWJtcqULnlJGnPOIrZ2JshgJwX//
         ez3sUnPt8lkbJ3Ksijr5+dD81UGbBst+cI/iqNwBYFF5emH5gcVFF9oVegNK7/Nw3l
         w56DVLGz5xb2Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josue David Hernandez Gutierrez 
        <josue.d.hernandez.gutierrez@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 08/24] xhci: Avoid PCI MSI/MSIX interrupt reinitialization at resume
Date:   Sat,  6 May 2023 20:30:04 -0400
Message-Id: <20230507003022.4070535-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003022.4070535-1-sashal@kernel.org>
References: <20230507003022.4070535-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josue David Hernandez Gutierrez <josue.d.hernandez.gutierrez@intel.com>

[ Upstream commit 944e7deb4238d10cd16905474574236ac8a8e847 ]

xhci MSI setup is currently done at the same time as xHC host is started
in xhci_run(). This couples the generic xhci code with PCI, and will
reconfigure MSI/MSIX interrupts every time xHC is started.

Decouple MSI/MSIX configuration from generic xhci code by moving MSI/MSIX
part to a PCI specific xhci_pci_run() function overriding xhci_run().

This allows us to remove unnecessay MSI/MSIX reconfiguration done every
time PCI xhci resumes from suspend. i.e. remove the xhci_cleanup_msix()
call from xhci_resume() and the xhci_try_enale_msi() call in xhci_run()
called a bit later by xhci_resume()

[minor changes and commit message rewrite -Mathias]

Signed-off-by: Josue David Hernandez Gutierrez <josue.d.hernandez.gutierrez@intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20230317154715.535523-10-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-pci.c | 15 +++++++++++++++
 drivers/usb/host/xhci.c     |  8 ++------
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6db07ca419c31..8060782a2367d 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -78,14 +78,29 @@ static const char hcd_name[] = "xhci_hcd";
 static struct hc_driver __read_mostly xhci_pci_hc_driver;
 
 static int xhci_pci_setup(struct usb_hcd *hcd);
+static int xhci_pci_run(struct usb_hcd *hcd);
 static int xhci_pci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 				      struct usb_tt *tt, gfp_t mem_flags);
 
 static const struct xhci_driver_overrides xhci_pci_overrides __initconst = {
 	.reset = xhci_pci_setup,
+	.start = xhci_pci_run,
 	.update_hub_device = xhci_pci_update_hub_device,
 };
 
+static int xhci_pci_run(struct usb_hcd *hcd)
+{
+	int ret;
+
+	if (usb_hcd_is_primary_hcd(hcd)) {
+		ret = xhci_try_enable_msi(hcd);
+		if (ret)
+			return ret;
+	}
+
+	return xhci_run(hcd);
+}
+
 /* called after powerup, by probe or system-pm "wakeup" */
 static int xhci_pci_reinit(struct xhci_hcd *xhci, struct pci_dev *pdev)
 {
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6307bae9cddff..f498df6b02c80 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -436,7 +436,7 @@ static void __maybe_unused xhci_msix_sync_irqs(struct xhci_hcd *xhci)
 	}
 }
 
-static int xhci_try_enable_msi(struct usb_hcd *hcd)
+int xhci_try_enable_msi(struct usb_hcd *hcd)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct pci_dev  *pdev;
@@ -490,6 +490,7 @@ static int xhci_try_enable_msi(struct usb_hcd *hcd)
 	hcd->irq = pdev->irq;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_try_enable_msi);
 
 #else
 
@@ -705,10 +706,6 @@ int xhci_run(struct usb_hcd *hcd)
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "xhci_run");
 
-	ret = xhci_try_enable_msi(hcd);
-	if (ret)
-		return ret;
-
 	temp_64 = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
 	temp_64 &= ~ERST_PTR_MASK;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
@@ -1250,7 +1247,6 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 		spin_unlock_irq(&xhci->lock);
 		if (retval)
 			return retval;
-		xhci_cleanup_msix(xhci);
 
 		xhci_dbg(xhci, "// Disabling event ring interrupts\n");
 		temp = readl(&xhci->op_regs->status);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 786002bb35db0..26fccc8d90556 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2143,6 +2143,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated);
 
 irqreturn_t xhci_irq(struct usb_hcd *hcd);
 irqreturn_t xhci_msi_irq(int irq, void *hcd);
+int xhci_try_enable_msi(struct usb_hcd *hcd);
 int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_alloc_tt_info(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
-- 
2.39.2

