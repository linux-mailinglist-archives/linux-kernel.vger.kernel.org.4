Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0D76BD761
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCPRpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCPRot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:44:49 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AA3749F3;
        Thu, 16 Mar 2023 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nEAMn
        AlTlhmBc3GQSHDUq/SQ1R/Wav9t7BfHo/zL+ZI=; b=eFIIFAUwP5fDPLIp7KfFk
        55oJJ5VNga9gWULLyFnBxMJEwVyYIPd0/yM18xNy31DuP0Fmx1oUfVw91R8YHcUQ
        RFbXqF1bzzDhS3t4jiqB1GQrRgxgmVzToi2m0Vrsc3EFd+B0hcJlbXCOxQ0kYPdW
        12oS+GZipHGfykDngcnBCA=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wD3_8eBVRNkg0sdAQ--.31373S2;
        Fri, 17 Mar 2023 01:44:33 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     valentina.manea.m@gmail.com
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v3] usbip: vudc: Fix use after free bug in vudc_remove due to race condition
Date:   Fri, 17 Mar 2023 01:44:32 +0800
Message-Id: <20230316174432.1592087-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_8eBVRNkg0sdAQ--.31373S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1UGFy5Jw45ZF18GrWkXrb_yoWkXwc_ua
        4ruF4xGF4rCanxKF17XwnxZrWUKFyDXrn3XFs29F4fWa4xGr15Zw17Ars7uF47uF98GFyD
        Cws8t395Zw47ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRK9NVJUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXQU0U1WBo8O2kQAAss
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
happen.

CPU0                  CPU1

                     |v_timer
vudc_remove          |
kfree(udc);          |
//free shost         |
                     |udc->gadget
                     |//use

Fixes: b6a0ca111867 ("usbip: vudc: Add UDC specific ops")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/usb/usbip/vudc_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
index 2bc428f2e261..33d0991755bb 100644
--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -633,6 +633,7 @@ int vudc_remove(struct platform_device *pdev)
 {
 	struct vudc *udc = platform_get_drvdata(pdev);
 
+	timer_shutdown_sync(&udc->timer);
 	usb_del_gadget_udc(&udc->gadget);
 	cleanup_vudc_hw(udc);
 	kfree(udc);
-- 
2.25.1

