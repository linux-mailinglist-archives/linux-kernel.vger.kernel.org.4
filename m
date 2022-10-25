Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE6B60C99B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiJYKLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiJYKKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:10:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19A21213D0;
        Tue, 25 Oct 2022 03:03:31 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxS9C4SwBz6H6m1;
        Tue, 25 Oct 2022 17:59:59 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:03:29 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:03:26 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 4/7] ata: libata: Add ata_internal_timeout()
Date:   Tue, 25 Oct 2022 18:32:53 +0800
Message-ID: <1666693976-181094-5-git-send-email-john.garry@huawei.com>
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

Add a internal command timeout handler. Also hook into libsas timeout
handler.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-scsi.c           | 10 ++++++++++
 drivers/scsi/libsas/sas_scsi_host.c |  5 +++++
 include/linux/libata.h              |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 18c60addf943..cbf266c9d4c2 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1138,6 +1138,16 @@ int ata_internal_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
 }
 EXPORT_SYMBOL_GPL(ata_internal_queuecommand);
 
+enum blk_eh_timer_return ata_internal_timeout(struct scsi_cmnd *scmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(scmd);
+	struct completion *wait = rq->end_io_data;
+
+	complete(wait);
+	return BLK_EH_DONE;
+}
+EXPORT_SYMBOL_GPL(ata_internal_timeout);
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 4fdd84868ac2..9d2122e65fba 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -921,10 +921,15 @@ void sas_task_complete_internal(struct sas_task *task)
 
 enum blk_eh_timer_return sas_internal_timeout(struct scsi_cmnd *scmd)
 {
+	struct domain_device *dev = cmd_to_domain_dev(scmd);
 	struct sas_task *task = TO_SAS_TASK(scmd);
 	bool is_completed = true;
 	unsigned long flags;
 
+	/* Handle libata internal command */
+	if (dev_is_sata(dev) && !task->slow_task)
+		return ata_internal_timeout(scmd);
+
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
 		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1a03c7fbb4e6..d5a15d1a5c4d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1143,6 +1143,7 @@ extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern int ata_internal_queuecommand(struct Scsi_Host *shost,
 				struct scsi_cmnd *scmd);
+extern enum blk_eh_timer_return ata_internal_timeout(struct scsi_cmnd *scmd);
 extern int ata_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd);
 extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
@@ -1397,6 +1398,7 @@ extern const struct attribute_group *ata_common_sdev_groups[];
 	.max_sectors		= ATA_MAX_SECTORS_LBA48,\
 	.reserved_queuecommand = ata_internal_queuecommand,\
 	.cmd_size = sizeof(struct ata_queued_cmd),\
+	.reserved_timedout = ata_internal_timeout,\
 	.init_cmd_priv = ata_init_cmd_priv
 
 #define ATA_SUBBASE_SHT(drv_name)				\
-- 
2.35.3

