Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD84E69D1AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjBTQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjBTQsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:48:03 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989352128D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:47:42 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PL7Yt63FVz16Nsv;
        Tue, 21 Feb 2023 00:44:50 +0800 (CST)
Received: from localhost.huawei.com (10.175.126.31) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Feb 2023 00:47:17 +0800
From:   Su Weifeng <suweifeng1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mst@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <zhanghongtao22@huawei.com>, Weifeng Su <suweifeng1@huawei.com>
Subject: [PATCH v2] uio:uio_pci_generic:Don't clear master bit when the process does not exit
Date:   Tue, 21 Feb 2023 01:10:44 +0800
Message-ID: <20230220171045.689736-1-suweifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.126.31]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weifeng Su <suweifeng1@huawei.com>

The /dev/uioX device has concurrent operations in a few scenarios.

For example, when a process using the device exits abnormally,
the management program starts the same process to operate the device.
When the process exits and closes the /dev/uioX device,
the master bit of the device is cleared. In this case, if the
new process is issuing commands, I/Os are suspended and cannot be
automatically recovered.

Therefore, reference counting is added to clear the master bit
only when the last process exits.

Signed-off-by: Weifeng Su <suweifeng1@huawei.com>
---
The difference between the first patch and the first patch is that 
the reference counting operation is performed using the atomic semantics, 
just like other drivers under UIO:
cdfa835c6e5e87d145f("uio_hv_generic: defer opening vmbus until first use").

 drivers/uio/uio_pci_generic.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
index e03f9b532..df436e3d9 100644
--- a/drivers/uio/uio_pci_generic.c
+++ b/drivers/uio/uio_pci_generic.c
@@ -31,6 +31,7 @@
 struct uio_pci_generic_dev {
 	struct uio_info info;
 	struct pci_dev *pdev;
+	atomic_t	refcnt;
 };
 
 static inline struct uio_pci_generic_dev *
@@ -39,10 +40,19 @@ to_uio_pci_generic_dev(struct uio_info *info)
 	return container_of(info, struct uio_pci_generic_dev, info);
 }
 
+static int open(struct uio_info *info, struct inode *inode)
+{
+	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
+
+	atomic_inc(&gdev->refcnt);
+	return 0;
+}
+
 static int release(struct uio_info *info, struct inode *inode)
 {
 	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
 
+
 	/*
 	 * This driver is insecure when used with devices doing DMA, but some
 	 * people (mis)use it with such devices.
@@ -51,7 +61,8 @@ static int release(struct uio_info *info, struct inode *inode)
 	 * Note that there's a non-zero chance doing this will wedge the device
 	 * at least until reset.
 	 */
-	pci_clear_master(gdev->pdev);
+	if (atomic_dec_and_test(&gdev->refcnt))
+		pci_clear_master(gdev->pdev);
 	return 0;
 }
 
@@ -93,7 +104,9 @@ static int probe(struct pci_dev *pdev,
 	gdev->info.name = "uio_pci_generic";
 	gdev->info.version = DRIVER_VERSION;
 	gdev->info.release = release;
+	gdev->info.open = open;
 	gdev->pdev = pdev;
+	atomic_set(&gdev->refcnt, 0);
 	if (pdev->irq && (pdev->irq != IRQ_NOTCONNECTED)) {
 		gdev->info.irq = pdev->irq;
 		gdev->info.irq_flags = IRQF_SHARED;
-- 
2.33.0

