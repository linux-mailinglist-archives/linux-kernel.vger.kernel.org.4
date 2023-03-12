Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199936B6753
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCLOxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCLOxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:53:36 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64D112201D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SLbIL
        nb3t/Z+sQSGFQnXNsUhmpJHie1CiaHgAtT157Q=; b=MP8woXRV8C3Y3ajlQdNkK
        6zNpXRDqS3MTkDVCE6JPak9PwLXzPvGSjLtfAnHyFGol23g+ZiIFZgiF/XeGRZ00
        g64YVFIZxXZQ8AqreF6TQ5mtsvG0X3iRl1rpz8+2eT4+D2mMxJc3lvhXY1WUySLK
        wouvhMssNUuVMSWnEttnE8=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wBH5bVS5w1ksCV3DA--.7216S2;
        Sun, 12 Mar 2023 22:53:06 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     jstultz@google.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] misc: hisi_hikey_usb: Fix use after free bug in hisi_hikey_usb_remove due to race condition
Date:   Sun, 12 Mar 2023 22:53:05 +0800
Message-Id: <20230312145305.1908607-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBH5bVS5w1ksCV3DA--.7216S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWkGw4UuF1xtrWfZF4xJFb_yoW8GFyxpr
        WxGw1UWrWUtFW7tw47JFsYqFyYga1xJa4UZw4UCw1fZ3s8Aw48XFy8JF4Ygr4xJFZFvFWr
        ZF4xWFyxua48GrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaiiDUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzhkwU2I0Xm-18wAAsV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hisi_hikey_usb_probe, it called hisi_hikey_usb_of_role_switch
and bound &hisi_hikey_usb->work with relay_set_role_switch.
When it calls hub_usb_role_switch_set, it will finally call
schedule_work to start the work.

When we call hisi_hikey_usb_remove to remove the driver, there
may be a sequence as follows:

Fix it by finishing the work before cleanup in hisi_hikey_usb_remove.

CPU0                  CPU1

                    |relay_set_role_switch
hisi_hikey_usb_remove|
  usb_role_switch_put|
    usb_role_switch_release  |
     kfree(sw)     |
                    | usb_role_switch_set_role
                    |   //use

Fixes: 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard USB gpio hub on Hikey960")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/misc/hisi_hikey_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 2165ec35a343..26fc895c4418 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -242,6 +242,7 @@ static int hisi_hikey_usb_probe(struct platform_device *pdev)
 static int  hisi_hikey_usb_remove(struct platform_device *pdev)
 {
 	struct hisi_hikey_usb *hisi_hikey_usb = platform_get_drvdata(pdev);
+	cancel_work_sync(&hisi_hikey_usb->work);
 
 	if (hisi_hikey_usb->hub_role_sw) {
 		usb_role_switch_unregister(hisi_hikey_usb->hub_role_sw);
-- 
2.25.1

