Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E097E615718
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 02:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKBBnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 21:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBBnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 21:43:49 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0791DEB7;
        Tue,  1 Nov 2022 18:43:47 -0700 (PDT)
X-UUID: 10c1cc75f1bf4145b338109aa4404950-20221102
X-CPASD-INFO: 2a120cf4056a498694c479b3fe2b730e@e7FrUl2VlGRcVXitg3yDcFllk2RnZYK
        CqJ9SkmVjXIWVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3gaNrUmCRlg==
X-CLOUD-ID: 2a120cf4056a498694c479b3fe2b730e
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:184.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:168.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:0,DUF:7207,ACD:128,DCD:128,SL:0,EISP:0,AG:0,CFC:0.423,CFSR:0.041,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 10c1cc75f1bf4145b338109aa4404950-20221102
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 10c1cc75f1bf4145b338109aa4404950-20221102
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 691345329; Wed, 02 Nov 2022 09:43:49 +0800
From:   gehao <gehao@kylinos.cn>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wangwenmei168@163.com, xieming@kylinos.cn, gehao <gehao@kylinos.cn>
Subject: [RESEND PATCH] xhci: Remove iommu condition for Renesas PCIe controllers
Date:   Wed,  2 Nov 2022 09:43:40 +0800
Message-Id: <20221102014340.129587-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use uPD720201 USB 3.0 Host Controller passthrough to VM
guest os will report follow errors and it can not working.

xhci_hcd 0000:09:00.0: Host took too long to start, waited 16000
microseconds.
xhci_hcd 0000:09:00.0: startup error -19.

Renesas controllers preserve the top half of the address in internal,
non visible registers,and end up with half the address coming from the
kernel, and the other half coming from the firmware.

For guest os,although our dev->iommu_group = NULL,but we are still under
iommu control.

This condition is not necessary,because for os with noiommu,doing
anything when there is no iommu is definitely,and when our os with
iommu,it is safe.

Signed-off-by: gehao <gehao@kylinos.cn>
---
 drivers/usb/host/xhci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 79d7931c048a..589d54ecd2a4 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -227,7 +227,6 @@ int xhci_reset(struct xhci_hcd *xhci, u64 timeout_us)
 
 static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	int err, i;
 	u64 val;
 	u32 intrs;
@@ -241,12 +240,8 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
 	 * changing the programming leads to extra accesses even if the
 	 * controller is supposed to be halted. The controller ends up with
 	 * a fatal fault, and is then ripe for being properly reset.
-	 *
-	 * Special care is taken to only apply this if the device is behind
-	 * an iommu. Doing anything when there is no iommu is definitely
-	 * unsafe...
 	 */
-	if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !device_iommu_mapped(dev))
+	if (!(xhci->quirks & XHCI_ZERO_64B_REGS))
 		return;
 
 	xhci_info(xhci, "Zeroing 64bit base registers, expecting fault\n");
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
