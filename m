Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4672696406
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjBNM5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBNM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:57:33 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114192203F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:57:31 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PGLmH3FXPzJsN4;
        Tue, 14 Feb 2023 20:55:43 +0800 (CST)
Received: from localhost.huawei.com (10.175.126.31) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 20:57:29 +0800
From:   Su Weifeng <suweifeng1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mst@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <zhanghongtao22@huawei.com>, Weifeng Su <suweifeng1@huawei.com>
Subject: [PATCH] uio:uio_pci_generic:Don't clear master bit when the process does not exit
Date:   Tue, 14 Feb 2023 21:21:57 +0800
Message-ID: <20230214132157.472753-1-suweifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.126.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weifeng Su <suweifeng1@huawei.com>

The /dev/uioX device is used by multiple processes. The current behavior
is to clear the master bit when a process exits. This affects other
processes that use the device, resulting in command suspension and
timeout. This behavior cannot be sensed by the process itself.
The solution is to add the reference counting. The reference count is
self-incremented and self-decremented each time when the device open and
close. The master bit is cleared only when the last process exited.

Signed-off-by: Weifeng Su <suweifeng1@huawei.com>
---
 drivers/uio/uio_pci_generic.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
index e03f9b532..d36d3e08e 100644
--- a/drivers/uio/uio_pci_generic.c
+++ b/drivers/uio/uio_pci_generic.c
@@ -31,6 +31,7 @@
 struct uio_pci_generic_dev {
 	struct uio_info info;
 	struct pci_dev *pdev;
+	refcount_t  dev_refc;
 };
 
 static inline struct uio_pci_generic_dev *
@@ -39,10 +40,22 @@ to_uio_pci_generic_dev(struct uio_info *info)
 	return container_of(info, struct uio_pci_generic_dev, info);
 }
 
+static int open(struct uio_info *info, struct inode *inode)
+{
+	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
+
+	if (gdev)
+		refcount_inc(&gdev->dev_refc);
+	return 0;
+}
+
 static int release(struct uio_info *info, struct inode *inode)
 {
 	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
 
+	if (gdev && refcount_dec_not_one(&gdev->dev_refc))
+		return 0;
+
 	/*
 	 * This driver is insecure when used with devices doing DMA, but some
 	 * people (mis)use it with such devices.
@@ -51,7 +64,8 @@ static int release(struct uio_info *info, struct inode *inode)
 	 * Note that there's a non-zero chance doing this will wedge the device
 	 * at least until reset.
 	 */
-	pci_clear_master(gdev->pdev);
+	if (refcount_read(&gdev->dev_refc) == 1)
+		pci_clear_master(gdev->pdev);
 	return 0;
 }
 
@@ -93,7 +107,9 @@ static int probe(struct pci_dev *pdev,
 	gdev->info.name = "uio_pci_generic";
 	gdev->info.version = DRIVER_VERSION;
 	gdev->info.release = release;
+	gdev->info.open = open;
 	gdev->pdev = pdev;
+	refcount_set(&gdev->dev_refc, 1);
 	if (pdev->irq && (pdev->irq != IRQ_NOTCONNECTED)) {
 		gdev->info.irq = pdev->irq;
 		gdev->info.irq_flags = IRQF_SHARED;
-- 
2.33.0

