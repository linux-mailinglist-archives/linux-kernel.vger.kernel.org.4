Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44B86E8795
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDTBrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDTBrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:47:02 -0400
X-Greylist: delayed 653 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Apr 2023 18:47:00 PDT
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0F75591
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:47:00 -0700 (PDT)
X-ASG-Debug-ID: 1681954564-1eb14e63892a7b0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id lcfoYTgH1z6X2Wio (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 20 Apr 2023 09:36:04 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 09:36:03 +0800
Received: from L440.zhaoxin.com (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 09:36:03 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   Weitao Wang <WeitaoWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>
Subject: [PATCH] xhci:fix issue with resume from system Sx state in zhaoxin platform
Date:   Thu, 20 Apr 2023 17:36:03 +0800
X-ASG-Orig-Subj: [PATCH] xhci:fix issue with resume from system Sx state in zhaoxin platform
Message-ID: <20230420093603.3344-1-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1681954564
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 979
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0019 1.0000 -2.0084
X-Barracuda-Spam-Score: 1.10
X-Barracuda-Spam-Status: No, SCORE=1.10 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107658
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

On Zhaoxin ZX-100 project, xHCI can't work normally after resume
from system Sx state. To fix this issue, when resume from system
Sx state, reinitialize xHCI instead of restore.

Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
 drivers/usb/host/xhci-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6db07ca419c3..b0f0ed088f81 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -334,6 +334,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
+	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN && pdev->device == 0x9202)
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
-- 
2.32.0

