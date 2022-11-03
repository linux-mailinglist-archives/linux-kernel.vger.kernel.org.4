Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9026179E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiKCJ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKCJZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:25:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED24E093;
        Thu,  3 Nov 2022 02:25:40 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N2ysh0kN0zRnxF;
        Thu,  3 Nov 2022 17:20:40 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 17:25:39 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 17:25:38 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] scsi: scsi_transport_spi: Fix unhandled errors in spi_transport_init()
Date:   Thu, 3 Nov 2022 17:22:23 +0800
Message-ID: <20221103092223.192181-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In spi_transport_init(), error return values are not handled, which can
makes memory leak and list node leak.

anon_transport_class_register() calls attribute_container_register()
and add list node to attribute_container_list. If it is not unregistered
and removed, when iterating the list in other modules, already released
memory &spi_device_class will be accessed and cause kernel panic:

KASAN: maybe wild-memory-access in range
[0x8febffffffeac550-0x8febffffffeac557]
CPU: 0 PID: 381 Comm: modprobe
Hardware name: QEMU Standard PC
RIP: 0010:attribute_container_add_device+0xe2/0x320
...
Call Trace:
 <TASK>
 scsi_sysfs_add_host+0x1d/0x40
 scsi_add_host_with_dma.cold+0x73d/0x79c
 sdebug_driver_probe+0x50f/0x6f0 [scsi_debug]
 ...

Add error handling in spi_transport_init() to avoid kernel panic when
module fails to load.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/scsi/scsi_transport_spi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index f569cf0095c2..2af81118a191 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -1620,9 +1620,22 @@ static __init int spi_transport_init(void)
 
 	error = transport_class_register(&spi_transport_class);
 	if (error)
-		return error;
+		goto err_list;
 	error = anon_transport_class_register(&spi_device_class);
-	return transport_class_register(&spi_host_class);
+	if (error)
+		goto err_transport;
+	error = transport_class_register(&spi_host_class);
+	if (error)
+		goto err_device;
+	return 0;
+
+err_device:
+	anon_transport_class_unregister(&spi_device_class);
+err_transport:
+	transport_class_unregister(&spi_transport_class);
+err_list:
+	scsi_dev_info_remove_list(SCSI_DEVINFO_SPI);
+	return error;
 }
 
 static void __exit spi_transport_exit(void)
-- 
2.17.1

