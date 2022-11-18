Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A462F323
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiKRLCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241764AbiKRLBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:01:53 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AAF99E8A;
        Fri, 18 Nov 2022 03:01:38 -0800 (PST)
X-UUID: ccac951579684566863168889488ab0d-20221118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gEw4Gu5Gnt8zOHhIWW+1I9wzg2APCr+opeqeiUE5TEE=;
        b=MCAj3A8P+cjwi6PaRieaXBLrJdn5Lhzqtz6BE/1aqNKlR8CAJVQJuW16N5JYBIpIb3hatk7oNAuRf+/8t8QkdJovjJ8xDwAg1jNqHwFosNY2PDM49h3wc1BmofdiFbMnItGGgRt+18P55FwTDJKFNmVsTFotIjHVELOPkad4XF4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:221a4b70-40e0-44a0-a59a-b0f2fc2dbdfc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:221a4b70-40e0-44a0-a59a-b0f2fc2dbdfc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:e3f7a8f8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:2211181901279D2G2TU4,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ccac951579684566863168889488ab0d-20221118
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1124821661; Fri, 18 Nov 2022 19:01:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 18 Nov 2022 19:01:25 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 18 Nov 2022 19:01:24 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Eddie Hung" <eddie.hung@mediatek.com>
Subject: [PATCH] usb: host: xhci-mtk: omit shared hcd if either root hub has no ports
Date:   Fri, 18 Nov 2022 19:01:16 +0800
Message-ID: <20221118110116.20165-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is error log when add a usb3 root hub without ports:
"hub 4-0:1.0: config failed, hub doesn't have any ports! (err -19)"

so omit the shared hcd if either of the root hubs has no ports, but
usually there is no usb3 port.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 72 +++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 01705e559c42..cff3c4aea036 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -485,6 +485,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	const struct hc_driver *driver;
 	struct xhci_hcd *xhci;
 	struct resource *res;
+	struct usb_hcd *usb3_hcd;
 	struct usb_hcd *hcd;
 	int ret = -ENODEV;
 	int wakeup_irq;
@@ -593,6 +594,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 
 	xhci = hcd_to_xhci(hcd);
 	xhci->main_hcd = hcd;
+	xhci->allow_single_roothub = 1;
 
 	/*
 	 * imod_interval is the interrupt moderation value in nanoseconds.
@@ -602,24 +604,29 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	xhci->imod_interval = 5000;
 	device_property_read_u32(dev, "imod-interval-ns", &xhci->imod_interval);
 
-	xhci->shared_hcd = usb_create_shared_hcd(driver, dev,
-			dev_name(dev), hcd);
-	if (!xhci->shared_hcd) {
-		ret = -ENOMEM;
-		goto disable_device_wakeup;
-	}
-
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret)
-		goto put_usb3_hcd;
+		goto disable_device_wakeup;
 
-	if (HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
+	if (!xhci_has_one_roothub(xhci)) {
+		xhci->shared_hcd = usb_create_shared_hcd(driver, dev,
+							 dev_name(dev), hcd);
+		if (!xhci->shared_hcd) {
+			ret = -ENOMEM;
+			goto dealloc_usb2_hcd;
+		}
+	}
+
+	usb3_hcd = xhci_get_usb3_hcd(xhci);
+	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
 	    !(xhci->quirks & XHCI_BROKEN_STREAMS))
-		xhci->shared_hcd->can_do_streams = 1;
+		usb3_hcd->can_do_streams = 1;
 
-	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
-	if (ret)
-		goto dealloc_usb2_hcd;
+	if (xhci->shared_hcd) {
+		ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
+		if (ret)
+			goto put_usb3_hcd;
+	}
 
 	if (wakeup_irq > 0) {
 		ret = dev_pm_set_dedicated_wake_irq_reverse(dev, wakeup_irq);
@@ -641,13 +648,13 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	usb_remove_hcd(xhci->shared_hcd);
 	xhci->shared_hcd = NULL;
 
-dealloc_usb2_hcd:
-	usb_remove_hcd(hcd);
-
 put_usb3_hcd:
-	xhci_mtk_sch_exit(mtk);
 	usb_put_hcd(xhci->shared_hcd);
 
+dealloc_usb2_hcd:
+	xhci_mtk_sch_exit(mtk);
+	usb_remove_hcd(hcd);
+
 disable_device_wakeup:
 	device_init_wakeup(dev, false);
 
@@ -679,10 +686,15 @@ static int xhci_mtk_remove(struct platform_device *pdev)
 	dev_pm_clear_wake_irq(dev);
 	device_init_wakeup(dev, false);
 
-	usb_remove_hcd(shared_hcd);
-	xhci->shared_hcd = NULL;
+	if (shared_hcd) {
+		usb_remove_hcd(shared_hcd);
+		xhci->shared_hcd = NULL;
+	}
 	usb_remove_hcd(hcd);
-	usb_put_hcd(shared_hcd);
+
+	if (shared_hcd)
+		usb_put_hcd(shared_hcd);
+
 	usb_put_hcd(hcd);
 	xhci_mtk_sch_exit(mtk);
 	clk_bulk_disable_unprepare(BULK_CLKS_NUM, mtk->clks);
@@ -700,13 +712,16 @@ static int __maybe_unused xhci_mtk_suspend(struct device *dev)
 	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
 	struct usb_hcd *hcd = mtk->hcd;
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct usb_hcd *shared_hcd = xhci->shared_hcd;
 	int ret;
 
 	xhci_dbg(xhci, "%s: stop port polling\n", __func__);
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	del_timer_sync(&hcd->rh_timer);
-	clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
-	del_timer_sync(&xhci->shared_hcd->rh_timer);
+	if (shared_hcd) {
+		clear_bit(HCD_FLAG_POLL_RH, &shared_hcd->flags);
+		del_timer_sync(&shared_hcd->rh_timer);
+	}
 
 	ret = xhci_mtk_host_disable(mtk);
 	if (ret)
@@ -718,8 +733,10 @@ static int __maybe_unused xhci_mtk_suspend(struct device *dev)
 
 restart_poll_rh:
 	xhci_dbg(xhci, "%s: restart port polling\n", __func__);
-	set_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
-	usb_hcd_poll_rh_status(xhci->shared_hcd);
+	if (shared_hcd) {
+		set_bit(HCD_FLAG_POLL_RH, &shared_hcd->flags);
+		usb_hcd_poll_rh_status(shared_hcd);
+	}
 	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	usb_hcd_poll_rh_status(hcd);
 	return ret;
@@ -730,6 +747,7 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
 	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
 	struct usb_hcd *hcd = mtk->hcd;
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct usb_hcd *shared_hcd = xhci->shared_hcd;
 	int ret;
 
 	usb_wakeup_set(mtk, false);
@@ -742,8 +760,10 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
 		goto disable_clks;
 
 	xhci_dbg(xhci, "%s: restart port polling\n", __func__);
-	set_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
-	usb_hcd_poll_rh_status(xhci->shared_hcd);
+	if (shared_hcd) {
+		set_bit(HCD_FLAG_POLL_RH, &shared_hcd->flags);
+		usb_hcd_poll_rh_status(shared_hcd);
+	}
 	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	usb_hcd_poll_rh_status(hcd);
 	return 0;
-- 
2.18.0

