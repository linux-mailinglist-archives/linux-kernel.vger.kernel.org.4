Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4904C60C996
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiJYKLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJYKKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:10:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6976B11F487;
        Tue, 25 Oct 2022 03:03:24 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxS942Vhvz689yL;
        Tue, 25 Oct 2022 17:59:52 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:03:22 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:03:19 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 2/7] ata: libata-scsi: Add ata_internal_queuecommand()
Date:   Tue, 25 Oct 2022 18:32:51 +0800
Message-ID: <1666693976-181094-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add callback to queue reserved commands - call it "internal" as this is
what libata uses.

Also add it to the base ATA SHT.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-scsi.c | 14 ++++++++++++++
 include/linux/libata.h    |  5 ++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 30d7c90b0c35..0d6f37d80137 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1118,6 +1118,20 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 	return 0;
 }
 
+int ata_internal_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
+{
+	struct ata_port *ap;
+	int res;
+
+	ap = ata_shost_to_port(shost);
+	spin_lock_irq(ap->lock);
+	res = ata_sas_queuecmd(scmd, ap);
+	spin_unlock_irq(ap->lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(ata_internal_queuecommand);
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8938b584520f..f09c5dca16ce 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1141,6 +1141,8 @@ extern int ata_std_bios_param(struct scsi_device *sdev,
 			      sector_t capacity, int geom[]);
 extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
+extern int ata_internal_queuecommand(struct Scsi_Host *shost,
+				struct scsi_cmnd *scmd);
 extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
@@ -1391,7 +1393,8 @@ extern const struct attribute_group *ata_common_sdev_groups[];
 	.slave_destroy		= ata_scsi_slave_destroy,	\
 	.bios_param		= ata_std_bios_param,		\
 	.unlock_native_capacity	= ata_scsi_unlock_native_capacity,\
-	.max_sectors		= ATA_MAX_SECTORS_LBA48
+	.max_sectors		= ATA_MAX_SECTORS_LBA48,\
+	.reserved_queuecommand = ata_internal_queuecommand
 
 #define ATA_SUBBASE_SHT(drv_name)				\
 	__ATA_BASE_SHT(drv_name),				\
-- 
2.35.3

