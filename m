Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2666B5DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 17:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCKQOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 11:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCKQOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 11:14:01 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EC4228E50;
        Sat, 11 Mar 2023 08:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fz36A
        kXpYMaBUJI+NqgAwqVO9nDPS2Gc+hOC9+rtMto=; b=iun3BZKGbRyvtMGci4XWb
        5+q8Bnul2sk1NAdC2sntb7J5eYYMFXYnV5s9M2WWjTkb5LKgRvfz8HGLLxTMmvM1
        WmwmckcWV0Z87ib5gFa/ajIzlsc9WeQnP98326axnd5o6/iYzL+CTeVQtyRNUtrm
        +CwEsscXWEyf4ysZ5VGKZ8=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wAndn58qAxkIM8FDA--.21310S2;
        Sun, 12 Mar 2023 00:12:44 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     gregkh@linuxfoundation.org
Cc:     p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com,
        phil.edworthy@renesas.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v2] usb: gadget: udc: renesas_usb3: Fix use after free bug in  renesas_usb3_remove due to race condition
Date:   Sun, 12 Mar 2023 00:12:42 +0800
Message-Id: <20230311161242.3773432-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAndn58qAxkIM8FDA--.21310S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1DGryfJr47ArWxZFyDAwb_yoW8Gw13pF
        Z8KFW8Jr4rGFW0q39rGFykZF1rCF9rKry7ZFWxKws7uF1rG3y8tr92qa1j9F1xJFZ3Ar4F
        qa4Du340qay7u37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaZXrUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiQh8vU1aEEn8ixQAAs5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In renesas_usb3_probe, &usb3->role_work is bound with
renesas_usb3_role_work. renesas_usb3_start will be called
to start the work.

to make cleanup, there may be an unfinished work. The possible
sequence is as follows:

Fix it by canceling the work before cleanup in the renesas_usb3_remove

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
---
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

