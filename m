Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10686EAA90
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjDUMja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjDUMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:39:04 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C45BCC3A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:39:01 -0700 (PDT)
X-ASG-Debug-ID: 1682080734-1eb14e6388386f0004-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id VSV32zGVYm9kDjkW (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 21 Apr 2023 20:38:56 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 21 Apr
 2023 20:38:55 +0800
Received: from L440.zhaoxin.com (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 21 Apr
 2023 20:38:54 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   Weitao Wang <WeitaoWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>
Subject: [PATCH v2 3/4] xhci: Show zhaoxin xHCI root hub speed correctly
Date:   Sat, 22 Apr 2023 04:38:52 +0800
X-ASG-Orig-Subj: [PATCH v2 3/4] xhci: Show zhaoxin xHCI root hub speed correctly
Message-ID: <20230421203853.387210-4-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230421203853.387210-1-WeitaoWang-oc@zhaoxin.com>
References: <20230421203853.387210-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1682080735
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1770
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0004 1.0000 -2.0184
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107724
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

Some zhaoxin xHCI controllers follow usb3.1 spec,
but only support gen1 speed 5G. While in Linux kernel,
if xHCI suspport usb3.1,root hub speed will show on 10G.
To fix this issue of zhaoxin xHCI platforms, read usb speed ID
supported by xHCI to determine root hub speed.

Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
 drivers/usb/host/xhci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6307bae9cddf..31d6ace9cace 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5294,6 +5294,7 @@ static void xhci_hcd_init_usb2_data(struct xhci_hcd *xhci, struct usb_hcd *hcd)
 static void xhci_hcd_init_usb3_data(struct xhci_hcd *xhci, struct usb_hcd *hcd)
 {
 	unsigned int minor_rev;
+	unsigned int i, j;
 
 	/*
 	 * Early xHCI 1.1 spec did not mention USB 3.1 capable hosts
@@ -5323,6 +5324,27 @@ static void xhci_hcd_init_usb3_data(struct xhci_hcd *xhci, struct usb_hcd *hcd)
 		hcd->self.root_hub->ssp_rate = USB_SSP_GEN_2x1;
 		break;
 	}
+
+	/* Usb3.1 has gen1 and gen2, Some zhaoxin's xHCI controller
+	 * that follow usb3.1 spec but only support gen1.
+	 */
+	if (xhci->quirks & XHCI_ZHAOXIN_HOST) {
+		minor_rev = 0;
+		for (j = 0; j < xhci->num_port_caps; j++) {
+			for (i = 0; i < xhci->port_caps[j].psi_count; i++) {
+				if (XHCI_EXT_PORT_PSIV(xhci->port_caps[j].psi[i]) >= 5) {
+					minor_rev = 1;
+					break;
+				}
+			}
+			if (minor_rev)
+				break;
+		}
+		if (minor_rev != 1) {
+			hcd->speed = HCD_USB3;
+			hcd->self.root_hub->speed = USB_SPEED_SUPER;
+		}
+	}
 	xhci_info(xhci, "Host supports USB 3.%x %sSuperSpeed\n",
 		  minor_rev, minor_rev ? "Enhanced " : "");
 
-- 
2.32.0

