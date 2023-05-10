Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33B96FD899
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjEJHvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbjEJHvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:51:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D447D116;
        Wed, 10 May 2023 00:51:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34A7pNtM5009224, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34A7pNtM5009224
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 10 May 2023 15:51:24 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 10 May 2023 15:51:30 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 10 May 2023 15:51:29 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 10 May 2023 15:51:29 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Klaus Kudielka <klaus.kudielka@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] usb: xhci: plat: remove error log for failure to get usb-phy
Date:   Wed, 10 May 2023 15:51:29 +0800
Message-ID: <20230510075129.28047-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove this log to avoid non-error conditions.
If CONFIG_USB_PHY is disabled, the following error message appears:
[    0.231609] xhci-hcd f10f0000.usb3: xhci_plat_probe get usb3phy fail (ret=-6)
[    0.239716] xhci-hcd f10f8000.usb3: xhci_plat_probe get usb3phy fail (ret=-6)
In this case, devm_usb_get_phy_by_phandle is declared static inline
and returns -ENXIO.

It is easy to pinpoint the failure to get the usb-phy using the debug
log in drivers/usb/phy/phy.c. Therefore, it can be removed.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 drivers/usb/host/xhci-plat.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index b0c8e8efc43b..6a45ee431945 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -294,10 +294,6 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		xhci->shared_hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev,
 			    "usb-phy", 1);
 		if (IS_ERR(xhci->shared_hcd->usb_phy)) {
-			if (PTR_ERR(xhci->shared_hcd->usb_phy) != -ENODEV)
-				dev_err(sysdev, "%s get usb3phy fail (ret=%d)\n",
-					     __func__,
-					    (int)PTR_ERR(xhci->shared_hcd->usb_phy));
 			xhci->shared_hcd->usb_phy = NULL;
 		} else {
 			ret = usb_phy_init(xhci->shared_hcd->usb_phy);
-- 
2.34.1

