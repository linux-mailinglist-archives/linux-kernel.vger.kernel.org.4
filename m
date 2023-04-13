Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741F86E0838
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDMHuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDMHuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:50:19 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1238B9EC9;
        Thu, 13 Apr 2023 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6TtIQ
        g09ZmPHNc7fwNMyG9gkvYgQeJ5WuDUEisBpScU=; b=RxNbs3Gjyl9cXI5OkfVXy
        i7frEY3tkxOjz4VRLt/2cmcaWumZfqF4VnegiLRG3Cih6M4EiasHMBn2cyYnzYwu
        NM8sXTsNYFv5foRQDP0rXxlHRUFLcnop0tbmwGHiENR/H4NRow+pxscTn5Wdycc9
        NZmQ8yp4VGmPzdrlbuJy9w=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wDXGOwItDdkTX8uBQ--.1680S2;
        Thu, 13 Apr 2023 15:49:28 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     gregkh@linuxfoundation.org
Cc:     p.zabel@pengutronix.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [RESEND PATCH] usb: renesas_usbhs: Fix use after free bug in usbhs_remove due to race condition
Date:   Thu, 13 Apr 2023 15:49:26 +0800
Message-Id: <20230413074926.239605-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXGOwItDdkTX8uBQ--.1680S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww13Gw1rKw47WF1UAw15CFg_yoW8JF4xpa
        15JFy8G3yrGrWjgan2qr4UXFyrCayqgr17WrZ7WwsxuwnxAa18Za4FqF4j9r13Xa93Ja1Y
        v3Wvyr95CaykCFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi0tC3UUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzglQU2I0YqBUwwAAsH
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

