Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD0F624534
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKJPJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKJPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:09:47 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB6523EA9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:09:46 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7QGk5P2bzHvj4;
        Thu, 10 Nov 2022 23:09:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 23:09:44 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 23:09:44 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <jassisinghbrar@gmail.com>, <michal.simek@xilinx.com>
Subject: [PATCH] mailbox: zynq-ipi: fix error handling while device_register() fails
Date:   Thu, 10 Nov 2022 23:08:22 +0800
Message-ID: <20221110150822.392385-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If device_register() fails, it has two issues:
1. The name allocated by dev_set_name() is leaked.
2. The parent of device is not NULL, device_unregister() is called
   in zynqmp_ipi_free_mboxes(), it will lead a kernel crash because
   of removing not added device.

Call put_device() to give up the reference, so the name is freed in
kobject_cleanup(). Add device registered check in zynqmp_ipi_free_mboxes()
to avoid null-ptr-deref.

Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 31a0fa914274..12e004ff1a14 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -493,6 +493,7 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 	ret = device_register(&ipi_mbox->dev);
 	if (ret) {
 		dev_err(dev, "Failed to register ipi mbox dev.\n");
+		put_device(&ipi_mbox->dev);
 		return ret;
 	}
 	mdev = &ipi_mbox->dev;
@@ -619,7 +620,8 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
 		ipi_mbox = &pdata->ipi_mboxes[i];
 		if (ipi_mbox->dev.parent) {
 			mbox_controller_unregister(&ipi_mbox->mbox);
-			device_unregister(&ipi_mbox->dev);
+			if (device_is_registered(&ipi_mbox->dev))
+				device_unregister(&ipi_mbox->dev);
 		}
 	}
 }
-- 
2.25.1

