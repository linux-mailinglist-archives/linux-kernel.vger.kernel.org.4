Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C03D605D56
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJTKi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiJTKiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:38:07 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F7941BF86B;
        Thu, 20 Oct 2022 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8q+5K
        QmZUtsBHsbUWdHpgQvm5Sqvk0LcH6V/uuCe82U=; b=YqSK6J3xrDpNC5fpTjqNU
        Etn23TjzS6xBN2Mmw7MPJj5vDHxx/7QQDMOJqQVblMhc6P7RRKz1Zlw7kNqee8v0
        1SQRseLCgHuO8+wRXmearqNvM7087vMGW5fI14YzVUL07WmkUSzv/xhKuAw6rzXI
        1OCRfkZvpbeU42BVrb9T6w=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp10 (Coremail) with SMTP id DsCowABXLkPRJFFj3I0FHg--.50916S2;
        Thu, 20 Oct 2022 18:37:06 +0800 (CST)
From:   wangwenmei168@163.com
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gehao <gehao@kylinos.cn>
Subject: [RESEND PATCH] xhci: Fix Renesas PCIe controllers passthrough issue
Date:   Thu, 20 Oct 2022 18:39:14 +0800
Message-Id: <20221020103914.262202-1-wangwenmei168@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABXLkPRJFFj3I0FHg--.50916S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1kWw4rAw17tr4kWF1rWFg_yoW8WFyrpF
        W5CFW3GFs5tr4rtasruw48Ja4rG3Z7ArW5tr97K3yYvrsxJ34qgFyDtFZ3Z3y7XrWIy34a
        vr1vg345uF4UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjKZXUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: 5zdqw45hqpvxqrwyqiywtou0bp/xtbBWRKgEGAZA+7y+wAAsm
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gehao <gehao@kylinos.cn>

When we use uPD720201 USB 3.0 Host Controller passthrough to VM
guest os will report follow errors and it can not working.

xhci_hcd 0000:09:00.0: Host took too long to start, waited 16000
microseconds.
xhci_hcd 0000:09:00.0: startup error -19.

Because when we passthroug some device to our guest os,
dev->iommu_group =NULL,so it will return from this function,
Actually it still control by host os.
I think that this condition is not necessary.

For host os with IOMMU,it is safe.
For host os with noiommu,doing anything when there is no
iommu is definitely.
For guest os,the addresses we can access are restricted.

After add this path,they all work well.

Signed-off-by: gehao <gehao@kylinos.cn>
---
 drivers/usb/host/xhci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 5176765c4013..e8f4c4ee3ea3 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -241,12 +241,8 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
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

