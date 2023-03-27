Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0516CA17C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjC0KbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjC0Ka1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:30:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0307712C;
        Mon, 27 Mar 2023 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679913016; x=1711449016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6b+JZbgMIdH+86rT3ucg7q7CshE9iTeKyV7ukqf9I+k=;
  b=LHsIrsONAvBubFxYMDZHtaDNU/hv3S1QLS21WBSsnS7V0Dpw0Xj+fBHK
   D0wFMvaM3MOmy9r19Rrr27bCrV+K7j8ir/Tgysr6q/OZjsTthPQdE9f8r
   St+S7z9Y9dMZFn1FUirZCI2uiBrSJF5r74rW0xD61vIoc7Ctp/RKR6/Yx
   /bwkHpUtPmKV9sz4RnxrPaa0UD5xTFzG13cPH7iXGRoJV650996+Ry9qy
   CCBASgrdXCCAZsYMYqmujioyPzmH3Ws042qvJtd5Ahxi4GElyOYvbwT78
   fV83HPG0e859FND2BMND6ahjkJMos8//LC8nRXM8ZITveutAOyfsLLXnn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="341805390"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="341805390"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 03:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="685926196"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="685926196"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2023 03:30:10 -0700
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
To:     greg@kroah.com, sfr@canb.auug.org.au
Cc:     josue.d.hernandez.gutierrez@intel.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH] xhci: only define xhci_msix_sync_irqs() when CONFIG_PM is set
Date:   Mon, 27 Mar 2023 13:31:03 +0300
Message-Id: <20230327103103.1060696-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZCFHsSkxXAahISuK@kroah.com>
References: <ZCFHsSkxXAahISuK@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci_msic_sync_irqs() function is only called during suspend, when
CONFIG_PM is set, so don't define it unconditionally.

Fixes: 9abe15d55dcc ("xhci: Move xhci MSI sync function to to xhci-pci")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a53ecc8ff8c5..1e826a159b96 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -88,19 +88,6 @@ static const struct xhci_driver_overrides xhci_pci_overrides __initconst = {
 	.update_hub_device = xhci_pci_update_hub_device,
 };
 
-static void xhci_msix_sync_irqs(struct xhci_hcd *xhci)
-{
-	struct usb_hcd *hcd = xhci_to_hcd(xhci);
-
-	if (hcd->msix_enabled) {
-		struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
-		int i;
-
-		for (i = 0; i < xhci->msix_count; i++)
-			synchronize_irq(pci_irq_vector(pdev, i));
-	}
-}
-
 /* Free any IRQs and disable MSI-X */
 static void xhci_cleanup_msix(struct xhci_hcd *xhci)
 {
@@ -729,6 +716,20 @@ static void xhci_pci_remove(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PM
+
+static void xhci_msix_sync_irqs(struct xhci_hcd *xhci)
+{
+	struct usb_hcd *hcd = xhci_to_hcd(xhci);
+
+	if (hcd->msix_enabled) {
+		struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
+		int i;
+
+		for (i = 0; i < xhci->msix_count; i++)
+			synchronize_irq(pci_irq_vector(pdev, i));
+	}
+}
+
 /*
  * In some Intel xHCI controllers, in order to get D3 working,
  * through a vendor specific SSIC CONFIG register at offset 0x883c,
-- 
2.25.1

