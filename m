Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13006B3FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjCJNDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCJNDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:03:09 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4F43423E;
        Fri, 10 Mar 2023 05:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6TtIQ
        g09ZmPHNc7fwNMyG9gkvYgQeJ5WuDUEisBpScU=; b=nZ9APEsOjKa0oCV2VufXM
        iPmsciw9JwNWjzWhqcS3KCkJrgiOmSmpQUev6wg30ffX2OcX3MI0MdjgmPJY4/dz
        cN4EJ0fetkCfvQHk2wHZsFbP7Wmod9vXzh0g0howXh6gjFWobi+HadxJLt/N9+fj
        oOyTRGpDRvYHyOMJo4mXlc=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wDXhZJnKgtkMLlkCw--.5392S2;
        Fri, 10 Mar 2023 21:02:32 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     gregkh@linuxfoundation.org
Cc:     p.zabel@pengutronix.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] usb: renesas_usbhs: Fix use after free bug in usbhs_remove due to race condition
Date:   Fri, 10 Mar 2023 21:02:30 +0800
Message-Id: <20230310130230.1732896-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXhZJnKgtkMLlkCw--.5392S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww13Gw1rKw47WF1UAw15CFg_yoW8JF4xpa
        15JFy8G3yrGrWjgan2qr4UXFyrCayqgr17WrZ7WwsxuwnxAa18Za4FqF4j9r13Xa93Ja1Y
        v3Wvyr95CaykCFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziFdg_UUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzgAuU2I0Xl15awABs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In usbhs_probe, &priv->notify_hotplug_work is bound with
usbhsc_notify_hotplug. It will be started then.

If we remove the driver which will call usbhs_remove
  to make cleanup, there may be a unfinished work.

The possible sequence is as follows:

Fix it by finishing the work before cleanup in the usbhs_remove

CPU0                  CPU1

                    |usbhsc_notify_hotplug
usbhs_remove         |
usbhs_mod_remove     |
usbhs_mod_gadget_remove|
kfree(gpriv);       |
                    |usbhsc_hotplug
                    |usbhs_mod_call start
                    |usbhsg_start
                    |usbhsg_try_start
                    |//use gpriv
Fixes: bc57381e6347 ("usb: renesas_usbhs: use delayed_work instead of work_struct")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/usb/renesas_usbhs/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 96f3939a65e2..17a0987ef4f5 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -768,6 +768,7 @@ static int usbhs_remove(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "usb remove\n");
 
+	cancel_delayed_work_sync(&priv->notify_hotplug_work);
 	/* power off */
 	if (!usbhs_get_dparam(priv, runtime_pwctrl))
 		usbhsc_power_ctrl(priv, 0);
-- 
2.25.1

