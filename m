Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF756BD76E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCPRsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCPRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:48:44 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9068F6F4AC;
        Thu, 16 Mar 2023 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nEAMn
        AlTlhmBc3GQSHDUq/SQ1R/Wav9t7BfHo/zL+ZI=; b=kFQb4+KZ4yjfok7VWHGT/
        r2FnzTJMcN3+jiIMsKs5gej5yxzBiJi0JNk2J5ASyv1A7fXOGux9glugkK5O0X2v
        6eF7G4pnfSLSSBG/bS8kqnR8Ahphe3fu7X5oZ5ySWxlvI5abOpATF/pYaqMBq29T
        7BU1MouBKdYC/Jej5E6sDU=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wDXJldjVhNkdFzYAA--.63147S2;
        Fri, 17 Mar 2023 01:48:19 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     valentina.manea.m@gmail.com
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH RESEND] usbip: vudc: Fix use after free bug in vudc_remove due to race condition
Date:   Fri, 17 Mar 2023 01:48:18 +0800
Message-Id: <20230316174818.1593588-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXJldjVhNkdFzYAA--.63147S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1UGFy5Jw45ZF18GrWkXrb_yoWkXwc_ua
        4ruF4xGF4rCanxKF17XwnxZrWUKFyDXrn3XFs29F4fWa4xGr15Zw17Ars7uF47uF98GFyD
        Cws8t395Zw47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKApntUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzgo0U2I0XqssLwAAsD
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
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

