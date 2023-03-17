Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC46BE63B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCQKKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCQKKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:10:05 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB2A37617D;
        Fri, 17 Mar 2023 03:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=l0+rc
        XAx9sjzsHZaRBR/f5UUh1q1PCzp0gO21Al0KDQ=; b=HiUf+8STawQQEKzZkTu1t
        MTBzM9liXFBymei0yOAA81kVC5TCd4Mwgenyb45mp9NrCZrvYzW9xEweAO5uq0oy
        4EgeI9i+Pqn069gRGjRJ0KEXrJKOfCsTKxIWD9o7XCdTr9vK2g4PFFFSy/OkIPTo
        oubgC2TflD0m/23Vb9Fk84=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wCn4kBzPBRk4VRZAQ--.53619S2;
        Fri, 17 Mar 2023 18:09:55 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     valentina.manea.m@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        skhan@linuxfoundation.org, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v3] usbip: vudc: Fix use after free bug in vudc_remove due to  race condition
Date:   Fri, 17 Mar 2023 18:09:54 +0800
Message-Id: <20230317100954.2626573-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCn4kBzPBRk4VRZAQ--.53619S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr15Ww17urWkZrW5Cr1kAFb_yoW8ZrW3pF
        s5WFWxCr1UJFs2vr1xtws0vF1rJanxJryUuFyxK393Zr43A34UXFyDtr1FkFWxAF9rXr4a
        qr4kXw1ruFyvq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziOB_8UUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiQhY1U1aEEsmuWwAAsO
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with v_timer.

When it calls usbip_sockfd_store, it will call v_start_timer to start the
timer work.

When we call vudc_remove to remove the driver, theremay be a sequence as
follows:

Fix it by shutdown the timer work before cleanup in vudc_remove.

Note that removing a driver is a root-only operation, and should never
happen. But the attacker can directly unplug the usb to trigger the remove
function.

CPU0                  CPU1

                     |v_timer
vudc_remove          |
kfree(udc);          |
//free shost         |
                     |udc->gadget
                     |//use

The udc might be removed before v_timer finished, and UAF happens.

This bug was found by Codeql static analysis and might by false positive.

Fixes: b6a0ca111867 ("usbip: vudc: Add UDC specific ops")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
v3:
- fix the issue by adding del_timer_sync in v_stop_timer and
invoke it in vudc_remove

v2:
- add more details about how the bug was found suggested by Shuah
---
 drivers/usb/usbip/vudc_dev.c      | 1 +
 drivers/usb/usbip/vudc_transfer.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
index 2bc428f2e261..dcbfed30806d 100644
--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -633,6 +633,7 @@ int vudc_remove(struct platform_device *pdev)
 {
 	struct vudc *udc = platform_get_drvdata(pdev);
 
+	v_stop_timer(udc);
 	usb_del_gadget_udc(&udc->gadget);
 	cleanup_vudc_hw(udc);
 	kfree(udc);
diff --git a/drivers/usb/usbip/vudc_transfer.c b/drivers/usb/usbip/vudc_transfer.c
index 7e801fee33bf..562ea7b6ea2e 100644
--- a/drivers/usb/usbip/vudc_transfer.c
+++ b/drivers/usb/usbip/vudc_transfer.c
@@ -492,5 +492,7 @@ void v_stop_timer(struct vudc *udc)
 
 	/* timer itself will take care of stopping */
 	dev_dbg(&udc->pdev->dev, "timer stop");
+	
+	del_timer_sync(&t->timer);
 	t->state = VUDC_TR_STOPPED;
 }
-- 
2.25.1

