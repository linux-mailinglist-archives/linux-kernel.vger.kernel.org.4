Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780A86F6CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjEDNXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjEDNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:23:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396786EA1;
        Thu,  4 May 2023 06:22:52 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QBvWw4KrczTk3c;
        Thu,  4 May 2023 21:18:20 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 21:22:49 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.g.garry@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH] ata: libata-scsi: Fix get identity data failed
Date:   Thu, 4 May 2023 13:15:45 +0000
Message-ID: <20230504131545.3409-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
the ata_device structure of a scsi device.  However, when the ata device
is managed by libsas, ata_scsi_find_dev() returns NULL, turning
ata_get_identity() into a nop and always returns -ENOMSG.

Fix this by replacing the pointer to the scsi_device struct argument with a
pointer to the ata_device struct in ata_sas_scsi_ioctl() and
ata_get_identity(). This pointer is provided by ata_scsi_ioctl() using
ata_scsi_find_dev() in the case of a libata managed device and by
sas_ioctl() using sas_to_ata_dev() in the case of a libsas managed ata
device.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/ata/libata-scsi.c           | 22 +++++++++++-----------
 drivers/scsi/libsas/sas_scsi_host.c |  3 ++-
 include/linux/libata.h              |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7bb12deab70c..68f2404e61d0 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -327,8 +327,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_unlock_native_capacity);
 
 /**
  *	ata_get_identity - Handler for HDIO_GET_IDENTITY ioctl
- *	@ap: target port
- *	@sdev: SCSI device to get identify data for
+ *	@dev: ATA device to get identify data for
  *	@arg: User buffer area for identify data
  *
  *	LOCKING:
@@ -337,10 +336,8 @@ EXPORT_SYMBOL_GPL(ata_scsi_unlock_native_capacity);
  *	RETURNS:
  *	Zero on success, negative errno on error.
  */
-static int ata_get_identity(struct ata_port *ap, struct scsi_device *sdev,
-			    void __user *arg)
+static int ata_get_identity(struct ata_device *dev, void __user *arg)
 {
-	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
 	u16 __user *dst = arg;
 	char buf[40];
 
@@ -573,7 +570,7 @@ static bool ata_ioc32(struct ata_port *ap)
  * This handles both native and compat commands, so anything added
  * here must have a compatible argument, or check in_compat_syscall()
  */
-int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
+int ata_sas_scsi_ioctl(struct ata_port *ap, struct ata_device *dev,
 		     unsigned int cmd, void __user *arg)
 {
 	unsigned long val;
@@ -608,17 +605,17 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
 		return rc;
 
 	case HDIO_GET_IDENTITY:
-		return ata_get_identity(ap, scsidev, arg);
+		return ata_get_identity(dev, arg);
 
 	case HDIO_DRIVE_CMD:
 		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 			return -EACCES;
-		return ata_cmd_ioctl(scsidev, arg);
+		return ata_cmd_ioctl(dev->sdev, arg);
 
 	case HDIO_DRIVE_TASK:
 		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 			return -EACCES;
-		return ata_task_ioctl(scsidev, arg);
+		return ata_task_ioctl(dev->sdev, arg);
 
 	default:
 		rc = -ENOTTY;
@@ -632,8 +629,11 @@ EXPORT_SYMBOL_GPL(ata_sas_scsi_ioctl);
 int ata_scsi_ioctl(struct scsi_device *scsidev, unsigned int cmd,
 		   void __user *arg)
 {
-	return ata_sas_scsi_ioctl(ata_shost_to_port(scsidev->host),
-				scsidev, cmd, arg);
+	struct ata_port *ap = ata_shost_to_port(scsidev->host);
+
+	return ata_sas_scsi_ioctl(ap,
+			ata_scsi_find_dev(ap, scsidev),
+			cmd, arg);
 }
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index a36fa1c128a8..c7a44ce7b2e2 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -789,7 +789,8 @@ int sas_ioctl(struct scsi_device *sdev, unsigned int cmd, void __user *arg)
 	struct domain_device *dev = sdev_to_domain_dev(sdev);
 
 	if (dev_is_sata(dev))
-		return ata_sas_scsi_ioctl(dev->sata_dev.ap, sdev, cmd, arg);
+		return ata_sas_scsi_ioctl(dev->sata_dev.ap,
+				sas_to_ata_dev(dev), cmd, arg);
 
 	return -EINVAL;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 311cd93377c7..d5dd60530a24 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1085,7 +1085,7 @@ bool ata_scsi_dma_need_drain(struct request *rq);
 #else
 #define ata_scsi_dma_need_drain NULL
 #endif
-extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *dev,
+extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct ata_device *dev,
 			    unsigned int cmd, void __user *arg);
 extern bool ata_link_online(struct ata_link *link);
 extern bool ata_link_offline(struct ata_link *link);
-- 
2.17.1

