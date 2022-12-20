Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F7465211B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiLTNAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiLTNA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:00:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C35DEE7;
        Tue, 20 Dec 2022 05:00:27 -0800 (PST)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NbxVC0T72zmWkd;
        Tue, 20 Dec 2022 20:59:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 21:00:21 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.g.garry@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH] scsi: libsas: Grab the host lock in sas_ata_device_link_abort()
Date:   Tue, 20 Dec 2022 12:53:49 +0000
Message-ID: <20221220125349.45091-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grab the host lock in sas_ata_device_link_abort() before calling
ata_link_abort(), as the comment in ata_link_abort() mentions.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_ata.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index f7439bf9cdc6..4f2017b21e6d 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -889,7 +889,9 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
 {
 	struct ata_port *ap = device->sata_dev.ap;
 	struct ata_link *link = &ap->link;
+	unsigned long flags;
 
+	spin_lock_irqsave(ap->lock, flags);
 	device->sata_dev.fis[2] = ATA_ERR | ATA_DRDY; /* tf status */
 	device->sata_dev.fis[3] = ATA_ABORTED; /* tf error */
 
@@ -897,6 +899,7 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
 	if (force_reset)
 		link->eh_info.action |= ATA_EH_RESET;
 	ata_link_abort(link);
+	spin_unlock_irqrestore(ap->lock, flags);
 }
 EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
 
-- 
2.17.1

