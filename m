Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A676E887F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 05:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjDTDPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 23:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjDTDOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 23:14:51 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9182103
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 20:14:49 -0700 (PDT)
X-ASG-Debug-ID: 1681960486-1eb14e63872b340001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id KWBNUDq3hfWgjigh (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 20 Apr 2023 11:14:46 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 11:14:46 +0800
Received: from L440.zhaoxin.com (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 11:14:46 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From:   Weitao Wang <WeitaoWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>
Subject: [PATCH] =?UTF-8?q?UHCI=EF=BC=9Aadjust=20zhaoxin=20UHCI=20controll?= =?UTF-8?q?ers=20OverCurrent=20bit=20value?=
Date:   Thu, 20 Apr 2023 19:14:45 +0800
X-ASG-Orig-Subj: [PATCH] =?UTF-8?q?UHCI=EF=BC=9Aadjust=20zhaoxin=20UHCI=20controll?= =?UTF-8?q?ers=20OverCurrent=20bit=20value?=
Message-ID: <20230420111445.5028-1-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1681960486
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1007
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0103 1.0000 -1.9535
X-Barracuda-Spam-Score: 1.16
X-Barracuda-Spam-Status: No, SCORE=1.16 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107661
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

Over Current condition is not standardized in the UHCI spec.
Zhaoxin UHCI controllers report OverCurrent bit active off.
Intel controllers report it active on, so we'll adjust the bit value.

Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
 drivers/usb/host/uhci-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/uhci-pci.c b/drivers/usb/host/uhci-pci.c
index 3592f757fe05..177e3c2aa287 100644
--- a/drivers/usb/host/uhci-pci.c
+++ b/drivers/usb/host/uhci-pci.c
@@ -126,6 +126,10 @@ static int uhci_pci_init(struct usb_hcd *hcd)
 	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_VIA)
 		uhci->oc_low = 1;
 
+	/* ZHAOXIN controllers report OverCurrent bit active off. */
+	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_ZHAOXIN)
+		uhci->oc_low = 1;
+
 	/* HP's server management chip requires a longer port reset delay. */
 	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_HP)
 		uhci->wait_for_hp = 1;
-- 
2.32.0

