Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663CC6AA886
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 08:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCDHTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 02:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDHTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 02:19:04 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B7517CC6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 23:19:01 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PTGNH0QN0z16Nj5;
        Sat,  4 Mar 2023 15:16:15 +0800 (CST)
Received: from localhost.huawei.com (10.175.126.31) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 4 Mar 2023 15:18:57 +0800
From:   Su Weifeng <suweifeng1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mst@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <zhanghongtao22@huawei.com>, Weifeng Su <suweifeng1@huawei.com>
Subject: [PATCH v3] uio:uio_pci_generic:Don't clear master bit when the process does not exit
Date:   Sat, 4 Mar 2023 15:43:16 +0800
Message-ID: <20230304074316.736922-1-suweifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.126.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

For example, when a process is operating the uio0 device, someone executes
like "cat /dev/uio0" command. In this case, the bus master bit is cleared
unconditionally. As a result, the running program cannot work commands
or I/Os, which is usually unaware of. This happens after
865a11f("uio/uio_pci_generic: Disable bus-mastering on release");
The restriction on the process that uses the PCI device is added. The new
process can be used only after the process that uses the PCI device exits.
Otherwise, the system returns a message indicating that the device is busy.

Signed-off-by: Weifeng Su <suweifeng1@huawei.com>
---

Change v2 -> v3:
  The process is restricted from using the PCI device. Before the process 
that uses the PCI device exits, the device returns EBUSY.
After the process exits, the master bit is cleared unconditionally 
to ensure DMA security.

 drivers/uio/uio_pci_generic.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
index e03f9b532..19bf5ead9 100644
--- a/drivers/uio/uio_pci_generic.c
+++ b/drivers/uio/uio_pci_generic.c
@@ -31,6 +31,7 @@
 struct uio_pci_generic_dev {
 	struct uio_info info;
 	struct pci_dev *pdev;
+	atomic_t	refcnt;
 };
 
 static inline struct uio_pci_generic_dev *
@@ -39,10 +40,21 @@ to_uio_pci_generic_dev(struct uio_info *info)
 	return container_of(info, struct uio_pci_generic_dev, info);
 }
 
+static int open(struct uio_info *info, struct inode *inode)
+{
+	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
+
+	if (atomic_add_unless(&gdev->refcnt, 1, 1))
+		return 0;
+	else
+		return -EBUSY;
+}
+
 static int release(struct uio_info *info, struct inode *inode)
 {
 	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
 
+	atomic_dec(&gdev->refcnt);
 	/*
 	 * This driver is insecure when used with devices doing DMA, but some
 	 * people (mis)use it with such devices.
@@ -93,7 +105,9 @@ static int probe(struct pci_dev *pdev,
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

