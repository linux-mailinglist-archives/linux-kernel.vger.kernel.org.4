Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9D76FB162
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjEHNVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjEHNVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:21:32 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C713135D9A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:21:16 -0700 (PDT)
X-ASG-Debug-ID: 1683552059-086e237e536e4c0005-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id SFjC4LTWa9kppV52 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 08 May 2023 21:21:01 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 8 May
 2023 21:20:59 +0800
Received: from L440.zhaoxin.com (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 8 May
 2023 21:20:58 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   Weitao Wang <WeitaoWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <WeitaoWang@zhaoxin.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v4 4/4] xhci: Add ZHAOXIN xHCI host U1/U2 feature support
Date:   Tue, 9 May 2023 05:20:58 +0800
X-ASG-Orig-Subj: [PATCH v4 4/4] xhci: Add ZHAOXIN xHCI host U1/U2 feature support
Message-ID: <20230508212058.6307-5-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230508212058.6307-1-WeitaoWang-oc@zhaoxin.com>
References: <20230508212058.6307-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1683552061
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3577
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.108487
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
        3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add U1/U2 feature support of xHCI for ZHAOXIN.
Since both INTEL and ZHAOXIN need to check the tier where the device is
located to determine whether to enabled U1/U2, remove the previous INTEL
U1/U2 tier policy and add common policy in xhci_check_tier_policy.
If vendor has specific U1/U2 enable policy,quirks can be add to declare.

Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
 drivers/usb/host/xhci-pci.c |  1 +
 drivers/usb/host/xhci.c     | 43 ++++++++++++++++---------------------
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 4a025ed50686..31f354352e57 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -529,6 +529,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
 		xhci->quirks |= XHCI_ZHAOXIN_HOST;
+		xhci->quirks |= XHCI_LPM_SUPPORT;
 
 		if (pdev->device == 0x9202) {
 			xhci->quirks |= XHCI_RESET_ON_RESUME;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 78790dc13c5f..cae57f0207a4 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4604,7 +4604,7 @@ static u16 xhci_calculate_u1_timeout(struct xhci_hcd *xhci,
 		}
 	}
 
-	if (xhci->quirks & XHCI_INTEL_HOST)
+	if (xhci->quirks & (XHCI_INTEL_HOST | XHCI_ZHAOXIN_HOST))
 		timeout_ns = xhci_calculate_intel_u1_timeout(udev, desc);
 	else
 		timeout_ns = udev->u1_params.sel;
@@ -4668,7 +4668,7 @@ static u16 xhci_calculate_u2_timeout(struct xhci_hcd *xhci,
 		}
 	}
 
-	if (xhci->quirks & XHCI_INTEL_HOST)
+	if (xhci->quirks & (XHCI_INTEL_HOST | XHCI_ZHAOXIN_HOST))
 		timeout_ns = xhci_calculate_intel_u2_timeout(udev, desc);
 	else
 		timeout_ns = udev->u2_params.sel;
@@ -4740,37 +4740,30 @@ static int xhci_update_timeout_for_interface(struct xhci_hcd *xhci,
 	return 0;
 }
 
-static int xhci_check_intel_tier_policy(struct usb_device *udev,
+static int xhci_check_tier_policy(struct xhci_hcd *xhci,
+		struct usb_device *udev,
 		enum usb3_link_state state)
 {
-	struct usb_device *parent;
-	unsigned int num_hubs;
+	struct usb_device *parent = udev->parent;
+	int tier = 1; /* roothub is tier1 */
 
-	/* Don't enable U1 if the device is on a 2nd tier hub or lower. */
-	for (parent = udev->parent, num_hubs = 0; parent->parent;
-			parent = parent->parent)
-		num_hubs++;
+	while (parent) {
+		parent = parent->parent;
+		tier++;
+	}
 
-	if (num_hubs < 2)
-		return 0;
+	if (xhci->quirks & XHCI_INTEL_HOST && tier > 3)
+		goto fail;
+	if (xhci->quirks & XHCI_ZHAOXIN_HOST && tier > 2)
+		goto fail;
 
-	dev_dbg(&udev->dev, "Disabling U1/U2 link state for device"
-			" below second-tier hub.\n");
-	dev_dbg(&udev->dev, "Plug device into first-tier hub "
-			"to decrease power consumption.\n");
+	return 0;
+fail:
+	dev_dbg(&udev->dev, "Tier policy prevents U1/U2 LPM states for devices at tier %d\n",
+			tier);
 	return -E2BIG;
 }
 
-static int xhci_check_tier_policy(struct xhci_hcd *xhci,
-		struct usb_device *udev,
-		enum usb3_link_state state)
-{
-	if (xhci->quirks & XHCI_INTEL_HOST)
-		return xhci_check_intel_tier_policy(udev, state);
-	else
-		return 0;
-}
-
 /* Returns the U1 or U2 timeout that should be enabled.
  * If the tier check or timeout setting functions return with a non-zero exit
  * code, that means the timeout value has been finalized and we shouldn't look
-- 
2.32.0

