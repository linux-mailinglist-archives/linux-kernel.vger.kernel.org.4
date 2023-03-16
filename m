Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE6C6BD476
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjCPP5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjCPP5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:57:17 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B986DFB47;
        Thu, 16 Mar 2023 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0Npgz
        znfUG0FTA8w9JT9SoHnc6ps6cmc2mZkRGLPt/Q=; b=J9tLXucT6czyyU8n9VAQI
        ZTRDER9y8NE5eKRGJ2jqbXQ4Wj71kX43XsiiNuvM42r73K7/K0jWjJ+hotGyYwci
        e+Kk37gpuI25ffJQSP/tFq+1aPFH1vvDqJqnhqOSQ0P49+wtxGNf/afZI/UQnKxC
        FR/gPCqoOVtgEVwP8R3/ME=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g1-4 (Coremail) with SMTP id _____wDn90c+PBNkQf7QAA--.64656S2;
        Thu, 16 Mar 2023 23:56:46 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     gregkh@linuxfoundation.org
Cc:     p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com,
        phil.edworthy@renesas.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v5] usb: gadget: udc: renesas_usb3: Fix use after free bug in  renesas_usb3_remove due to race condition
Date:   Thu, 16 Mar 2023 23:56:45 +0800
Message-Id: <20230316155645.1565045-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDn90c+PBNkQf7QAA--.64656S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1DGryfJr47ArWxZFyDAwb_yoW8Ar45pF
        WDGFW5Ar4rJFWjq3y7GFykZF1rCF9rKry7ZFW7Kw4xuF1rG3y8JryIqa1jkF1xJFZYyr4F
        q3WDu340qa47u37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziS4EiUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXQI0U1WBo8MhPAAAsR
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

If we remove the driver which will call usbhs_remove, there may be
an unfinished work. The possible sequence is as follows:

Fix it by canceling the work before cleanup in the renesas_usb3_remove.

CPU0                  CPU1

                    |renesas_usb3_role_work
renesas_usb3_remove |
usb_role_switch_unregister  |
device_unregister   |
kfree(sw)  	     |
free usb3->role_sw  |
                    |   usb_role_switch_set_role
                    |   //use usb3->role_sw

Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb role switch")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
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

