Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16886B3701
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCJHBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJHAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:00:55 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D31BFF98D1;
        Thu,  9 Mar 2023 23:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1z6vh
        FR7cbq9745C+sXleDgCeGXWCt5kCHk83K/xDew=; b=g12hMjc84NJkh25h4Bx4j
        eRcKL/ZdqZd/QifDOK3nYCjtS29tiB/UYY7jLztIQIgRxI/YQ0w9tpoTiCIg9WCP
        RdjIQL/yQdq6ZUsojVgCPkBU6ZQLGKPQnIk11zZah+JvzxZ+qbWY/lw+u78wS7dI
        g07JxS15B5UHuG0gIUc3d0=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by smtp17 (Coremail) with SMTP id NdxpCgCHoGqY1Qpk6BJXHA--.82S2;
        Fri, 10 Mar 2023 15:00:40 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] USB: gadget: udc: Fix use after free bug in udc_plat_remove due to race condition
Date:   Fri, 10 Mar 2023 15:00:39 +0800
Message-Id: <20230310070039.1288927-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NdxpCgCHoGqY1Qpk6BJXHA--.82S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArykXw4xZF4rXr1kCF13XFb_yoW8GF47pF
        Z3KrWxGr4DAryqyr17Gr1rZFW8Ca9rKr95KrW2k3W3Zrn5Kw43ArW8JF1fKF4xJF97ArWa
        qF4v9r10vFWkua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziJUU8UUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzgAuU2I0XlsmAwAAsF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In udc_plat_probe, &udc->drd_work is bound with
udc_drd_work. udc_drd_work may be called by
usbd_connect_notify to start the work.

Besides, there is a invoking chain:
udc_plat_probe
->udc_probe
->usb_add_gadget_udc_release
->usb_add_gadget

It will add a new gadget to the udc class driver
 list. In usb_add_gadget, it uses usb_udc_release
 as its release function, which will kfree(udc)
 to when destroying the gadget.

If we remove the module which will call udc_plat_remove
  to make cleanup, there may be a unfinished work.
The possible sequence is as follows:

Fix it by finishing the work before cleanup in the udc_plat_remove

Fixes: 1b9f35adb0ff ("usb: gadget: udc: Add Synopsys UDC Platform driver")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/usb/gadget/udc/snps_udc_plat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadget/udc/snps_udc_plat.c
index 8bbb89c80348..6228e178cc0a 100644
--- a/drivers/usb/gadget/udc/snps_udc_plat.c
+++ b/drivers/usb/gadget/udc/snps_udc_plat.c
@@ -230,6 +230,7 @@ static int udc_plat_remove(struct platform_device *pdev)
 	struct udc *dev;
 
 	dev = platform_get_drvdata(pdev);
+	cancel_delayed_work_sync(&dev->drd_work);
 
 	usb_del_gadget_udc(&dev->gadget);
 	/* gadget driver must not be registered */
-- 
2.25.1

