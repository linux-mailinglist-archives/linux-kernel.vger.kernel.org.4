Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238806B2DC0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCITdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjCITcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:32:19 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29464F738E;
        Thu,  9 Mar 2023 11:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OLj0E
        EDcClubzWEsb6yI7uXbUc6GnDp13HNII7GwMQE=; b=jBcveBzCfUz30qCgMUmJr
        VASNr0p2y6zNlGygFHgrRwBsPbKHGEubdlA8PmiTkF+K3gw6utYPZDbZDFFph9Lk
        QgrlHfR0BsPM0dny8UQHBGEGdnMWugVKXcMhuGR6IpdTyOngM65oTNjiaNYNiGbw
        vfCtbBIa1DFtxqMjjR9wQ0=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wAHKnjOMwpkcqj6Cg--.38073S2;
        Fri, 10 Mar 2023 03:30:22 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     gregkh@linuxfoundation.org
Cc:     p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com,
        phil.edworthy@renesas.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH]  usb: gadget: udc: renesas_usb3: Fix use after free bug in renesas_usb3_remove due to race condition
Date:   Fri, 10 Mar 2023 03:30:20 +0800
Message-Id: <20230309193020.374950-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHKnjOMwpkcqj6Cg--.38073S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1DGryfJr47CF4fCF15Arb_yoW8GF4DpF
        n8GrWrGr48GFy0qwsrGFyDZFyrCFyDKry3ZFWxKa1kuF1rG3y8Xr9Fqa1jkr17JFZ2yr4S
        q3WUu348tFW7u37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi-eOJUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiQhAtU1aEEmvBkgAAsU
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In renesas_usb3_probe, &usb3->role_work is bound with
renesas_usb3_role_work. renesas_usb3_start will be called
to start the work.

If we remove the module which will call renesas_usb3_remove
  to make cleanup, there may be a unfinished work. The possible
  sequence is as follows:

Fix it by canceling the work before cleanup in the renesas_usb3_remove

CPU0                  CPUc1

                    |renesas_usb3_role_work
renesas_usb3_remove      |
usb_role_switch_unregister  |
device_unregister   |
kfree(sw);  	    |
free usb3->role_sw  |
                    |   usb_role_switch_set_role
                    |   //use usb3->role_sw
Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb role switch")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index bee6bceafc4f..23b5f1706d25 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2658,6 +2658,8 @@ static int renesas_usb3_remove(struct platform_device *pdev)
 {
 	struct renesas_usb3 *usb3 = platform_get_drvdata(pdev);
 
+	cancel_work_sync(&usb3->extcon_work);
+	cancel_work_sync(&usb3->role_work);
 	debugfs_remove_recursive(usb3->dentry);
 	device_remove_file(&pdev->dev, &dev_attr_role);
 
-- 
2.25.1

