Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912CC6F7B5C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjEEDEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEEDEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:04:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEBB11B7C;
        Thu,  4 May 2023 20:04:20 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QCFmD5JbfzpV4b;
        Fri,  5 May 2023 11:00:12 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 11:04:17 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.g.garry@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Date:   Fri, 5 May 2023 02:57:12 +0000
Message-ID: <20230505025712.19438-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ata_get_identity() uses the helper ata_scsi_find_dev() to get
the ata_device structure of a scsi device. However, when the ata device is
managed by libsas, ata_scsi_find_dev() returns NULL, turning
ata_get_identity() into a nop and always returns -ENOMSG.

Fix this by checking whether ATA_FLAG_SAS_HOST is set for ap->flags in
ata_scsi_find_dev(), as the flag is only used in libsas. If
ATA_FLAG_SAS_HOST is set, use sas_to_ata_dev() to find associated ATA
device.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
Changes to v1 
- Let ata_scsi_find_dev() return the correct value and don't keep replacing
calls to ata_scsi_find_dev().

 drivers/ata/libata-scsi.c | 12 ++++++++++--
 drivers/ata/libata.h      |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7bb12deab70c..aa580ea341fa 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -26,6 +26,7 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_transport.h>
+#include <scsi/libsas.h>
 #include <linux/libata.h>
 #include <linux/hdreg.h>
 #include <linux/uaccess.h>
@@ -2745,10 +2746,17 @@ static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
  *	Associated ATA device, or %NULL if not found.
  */
 struct ata_device *
-ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
+ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
 {
-	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
+	struct ata_device *dev;
+
+	if (ap->flags & ATA_FLAG_SAS_HOST) {
+		struct domain_device *ddev = sdev_to_domain_dev(scsidev);
+
+		return sas_to_ata_dev(ddev);
+	}
 
+	dev = __ata_scsi_find_dev(ap, scsidev);
 	if (unlikely(!dev || !ata_dev_enabled(dev)))
 		return NULL;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 926d0d33cd29..6d66f46da064 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -109,7 +109,7 @@ static inline void ata_acpi_bind_dev(struct ata_device *dev) {}
 
 /* libata-scsi.c */
 extern struct ata_device *ata_scsi_find_dev(struct ata_port *ap,
-					    const struct scsi_device *scsidev);
+					    struct scsi_device *scsidev);
 extern int ata_scsi_add_hosts(struct ata_host *host,
 			      const struct scsi_host_template *sht);
 extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
-- 
2.17.1

