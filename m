Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9CB6C6167
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjCWIOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCWIOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:14:06 -0400
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE7EF231E6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=y1iqL47HWc
        mrbklPbxjWVb/4DOBBCSIfPPrLV3rQzSk=; b=DhixOMeqZwsZF9XEMxkAbvlbHT
        WjUMCX/e0Z3bH8TuL4VsAgrBmvalwg5Wwn+Wgc/VLk7/jA++/SuV3i/5D7w+Zrr0
        zaCGmoJHih0d0D+0FWF7Zk7z02tB25D38hrKBP0z5JEahh2y1BPfK9iOJNEa4T0t
        iUVYDuGB4K6rHf9/4=
Received: from oslab.. (unknown [10.130.159.144])
        by coremail-app1 (Coremail) with SMTP id OCz+CgCnrmI9ChxkSAXHAg--.30224S4;
        Thu, 23 Mar 2023 16:13:49 +0800 (CST)
From:   Jia-Ju Bai <baijiaju@buaa.edu.cn>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju@buaa.edu.cn>
Subject: [PATCH] usb: host: xhci: Add a NULL check of hcd in xhci_plat_remove()
Date:   Thu, 23 Mar 2023 16:13:29 +0800
Message-Id: <20230323081329.366459-1-baijiaju@buaa.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: OCz+CgCnrmI9ChxkSAXHAg--.30224S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyDCrW3ur4rGF43WrW3ZFb_yoW5Xr18pF
        9Fq3W3Ka1ftr4qqa4fXr4YqF13Cw1xt34qgryfC3WxXwsrtw1vqFW0yF1FvF93Z3s8Gw4x
        Kr1vgFW5uF1jk3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: yrruji46exttoohg3hdfq/
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a previous commit d7de14d74d65 ("usb: xhci_plat_remove: avoid NULL
dereference"), hcd can be NULL in usb_remove_hcd(), and thus it should
be checked before being used.

However, in the call stack of this commit, hci is also used to get xhci:

xhci_plat_remove()
  xhci = hcd_to_xhci(hcd)
    usb_hcd_is_primary_hcd(hcd)
      if (!hcd->primary_hcd) -> No check for hcd
    primary_hcd = hcd->primary_hcd; -> No check for hcd
  usb_remove_hcd(hcd)
    if (!hcd) -> Add a check by the previous commit

Thus, to avoid possible null-pointer dereferences, hci should be checked
before hcd_to_xhci() is called.

These bugs are reported by a static analysis tool implemented by myself,
and they are found by extending a known bug fixed in the previous commit.
Thus, they could be theoretical bugs.

Signed-off-by: Jia-Ju Bai <baijiaju@buaa.edu.cn>
---
 drivers/usb/host/xhci-plat.c | 42 +++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index b9f9625467d6..168530b1e1b3 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -389,30 +389,38 @@ static int xhci_generic_plat_probe(struct platform_device *pdev)
 int xhci_plat_remove(struct platform_device *dev)
 {
 	struct usb_hcd	*hcd = platform_get_drvdata(dev);
-	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
-	struct clk *clk = xhci->clk;
-	struct clk *reg_clk = xhci->reg_clk;
-	struct usb_hcd *shared_hcd = xhci->shared_hcd;
+	struct xhci_hcd	*xhci;
+	struct clk *clk;
+	struct clk *reg_clk;
+	struct usb_hcd *shared_hcd;
 
 	pm_runtime_get_sync(&dev->dev);
-	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
-	if (shared_hcd) {
-		usb_remove_hcd(shared_hcd);
-		xhci->shared_hcd = NULL;
-	}
+	if (hcd) {
+		xhci = hcd_to_xhci(hcd);
+		clk = xhci->clk;
+		reg_clk = xhci->reg_clk;
+		shared_hcd = xhci->shared_hcd;
 
-	usb_phy_shutdown(hcd->usb_phy);
+		xhci->xhc_state |= XHCI_STATE_REMOVING;
 
-	usb_remove_hcd(hcd);
+		if (shared_hcd) {
+			usb_remove_hcd(shared_hcd);
+			xhci->shared_hcd = NULL;
+		}
 
-	if (shared_hcd)
-		usb_put_hcd(shared_hcd);
+		usb_phy_shutdown(hcd->usb_phy);
 
-	clk_disable_unprepare(clk);
-	clk_disable_unprepare(reg_clk);
-	reset_control_assert(xhci->reset);
-	usb_put_hcd(hcd);
+		usb_remove_hcd(hcd);
+
+		if (shared_hcd)
+			usb_put_hcd(shared_hcd);
+	
+		clk_disable_unprepare(clk);
+		clk_disable_unprepare(reg_clk);
+		reset_control_assert(xhci->reset);
+		usb_put_hcd(hcd);
+	}
 
 	pm_runtime_disable(&dev->dev);
 	pm_runtime_put_noidle(&dev->dev);
-- 
2.34.1

