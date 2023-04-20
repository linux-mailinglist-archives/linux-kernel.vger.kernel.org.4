Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40D26E8DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjDTJVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjDTJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:21:37 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D19C26B6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:21:36 -0700 (PDT)
X-ASG-Debug-ID: 1681982491-1eb14e63872da70003-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id JlSlFQdJwooxcbcw (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 20 Apr 2023 17:21:32 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 17:21:31 +0800
Received: from L440.zhaoxin.com (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 17:21:30 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   Weitao Wang <WeitaoWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>
Subject: [PATCH 2/3] xhci: Add zhaoxin xHCI U1/U2 feature support
Date:   Fri, 21 Apr 2023 01:21:29 +0800
X-ASG-Orig-Subj: [PATCH 2/3] xhci: Add zhaoxin xHCI U1/U2 feature support
Message-ID: <20230420172130.375819-3-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230420172130.375819-1-WeitaoWang-oc@zhaoxin.com>
References: <20230420172130.375819-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1681982492
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2835
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0001 1.0000 -2.0207
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107672
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
        3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add U1/U2 feature support of xHCI for zhaoxin.

Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
 drivers/usb/host/xhci-pci.c |  5 +++++
 drivers/usb/host/xhci.c     | 27 +++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6db07ca419c3..a235effe8e5c 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -334,6 +334,11 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
+	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
+		xhci->quirks |= XHCI_LPM_SUPPORT;
+		xhci->quirks |= XHCI_ZHAOXIN_HOST;
+	}
+
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6307bae9cddf..730c0f68518d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4802,7 +4802,7 @@ static u16 xhci_calculate_u1_timeout(struct xhci_hcd *xhci,
 		}
 	}
 
-	if (xhci->quirks & XHCI_INTEL_HOST)
+	if (xhci->quirks & (XHCI_INTEL_HOST | XHCI_ZHAOXIN_HOST))
 		timeout_ns = xhci_calculate_intel_u1_timeout(udev, desc);
 	else
 		timeout_ns = udev->u1_params.sel;
@@ -4866,7 +4866,7 @@ static u16 xhci_calculate_u2_timeout(struct xhci_hcd *xhci,
 		}
 	}
 
-	if (xhci->quirks & XHCI_INTEL_HOST)
+	if (xhci->quirks & (XHCI_INTEL_HOST | XHCI_ZHAOXIN_HOST))
 		timeout_ns = xhci_calculate_intel_u2_timeout(udev, desc);
 	else
 		timeout_ns = udev->u2_params.sel;
@@ -4938,6 +4938,27 @@ static int xhci_update_timeout_for_interface(struct xhci_hcd *xhci,
 	return 0;
 }
 
+static int xhci_check_zhaoxin_tier_policy(struct usb_device *udev,
+		enum usb3_link_state state)
+{
+	struct usb_device *parent;
+	unsigned int num_hubs;
+
+	/* Don't enable U1/U2 if the device is on an external hub. */
+	for (parent = udev->parent, num_hubs = 0; parent->parent;
+			parent = parent->parent)
+		num_hubs++;
+
+	if (num_hubs < 1)
+		return 0;
+
+	dev_dbg(&udev->dev, "Disabling U1/U2 link state for device"
+			" below external hub.\n");
+	dev_dbg(&udev->dev, "Plug device into root hub "
+			"to decrease power consumption.\n");
+	return -E2BIG;
+}
+
 static int xhci_check_intel_tier_policy(struct usb_device *udev,
 		enum usb3_link_state state)
 {
@@ -4965,6 +4986,8 @@ static int xhci_check_tier_policy(struct xhci_hcd *xhci,
 {
 	if (xhci->quirks & XHCI_INTEL_HOST)
 		return xhci_check_intel_tier_policy(udev, state);
+	else if (xhci->quirks & XHCI_ZHAOXIN_HOST)
+		return xhci_check_zhaoxin_tier_policy(udev, state);
 	else
 		return 0;
 }
-- 
2.32.0

