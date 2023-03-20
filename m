Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C5E6C0A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjCTGaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCTGaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:30:04 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E33DDBEF;
        Sun, 19 Mar 2023 23:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+cK5s
        djG2f6eCmqfChn9RZ11JmPlxYp8lmMC3DuUyt8=; b=N1hyjII0lGKPcPYApYmwk
        oWoSNqe/WHS1m8kBAHUeTuMwBAV0WJ1zlxokY86sUXd7yO4YZjcn6CgmxxSKUH4L
        MD87H9cHkbNje89jIS910EHhkE9UPktBDIZCdm1yGmeyMX7nHAQddmWqc7xhSAjX
        I/g4ZZtRGh3wn1ce6UWdUA=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wDHcQRM_Rdkg4AHAg--.24891S2;
        Mon, 20 Mar 2023 14:29:32 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     gregkh@linuxfoundation.org
Cc:     skhan@linuxfoundation.org, p.zabel@pengutronix.de,
        biju.das.jz@bp.renesas.com, phil.edworthy@renesas.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v10] usb: gadget: udc: renesas_usb3: Fix use after free bug in  renesas_usb3_remove due to race condition
Date:   Mon, 20 Mar 2023 14:29:31 +0800
Message-Id: <20230320062931.505170-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHcQRM_Rdkg4AHAg--.24891S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr45Xr15Jry8JFW3Zr4UCFg_yoW8KrW5pF
        WDKFW5Ar4rJFWqv3y7GFykZFyruFnrKryUZFWxGw48uF1rG3y0qry2qF45CrnrJFZ3AF40
        vayDu34jva47Ca7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziIJPiUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiQg04U1aEEuBELQAAst
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In renesas_usb3_probe, role_work is bound with renesas_usb3_role_work.
renesas_usb3_start will be called to start the work.

If we remove the driver which will call usbhs_remove, there may be
an unfinished work. The possible sequence is as follows:

CPU0                  			CPU1

                    			 renesas_usb3_role_work
renesas_usb3_remove
usb_role_switch_unregister
device_unregister
kfree(sw)
//free usb3->role_sw
                    			 usb_role_switch_set_role
                    			 //use usb3->role_sw

The usb3->role_sw could be freed under such circumstance and then
used in usb_role_switch_set_role.

This bug was found by static analysis. And note that removing a 
driver is a root-only operation, and should never happen in normal
case. But the root user may directly remove the device which
will also trigger the remove function.

Fix it by canceling the work before cleanup in the renesas_usb3_remove.

Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb role switch")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
v10:
- modify the commit message suggested by Yoshihiro Shimoda
v9:
- append with more information suggested by Greg KH
v8:
- replace | with spaces to make line up suggested by Greg KH
v7:
- add more details about how the bug was found suggested by Shuah
v6:
- beautify the format and add note suggested by Greg KH
v5:
- fix typo
v4:
- add Reviewed-by label and resubmit v4 suggested by Greg KH
v3:
- modify the commit message to make it clearer suggested by Yoshihiro Shimoda
v2:
- fix typo, use clearer commit message and only cancel the UAF-related work suggested by Yoshihiro Shimoda
---
 drivers/usb/gadget/udc/renesas_usb3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index bee6bceafc4f..a301af66bd91 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2661,6 +2661,7 @@ static int renesas_usb3_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(usb3->dentry);
 	device_remove_file(&pdev->dev, &dev_attr_role);
 
+	cancel_work_sync(&usb3->role_work);
 	usb_role_switch_unregister(usb3->role_sw);
 
 	usb_del_gadget_udc(&usb3->gadget);
-- 
2.25.1

