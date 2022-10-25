Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF86D60C8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiJYJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiJYJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:49:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A2615746D;
        Tue, 25 Oct 2022 02:48:33 -0700 (PDT)
Received: from frapeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRtQ3D83z6HJMX;
        Tue, 25 Oct 2022 17:47:10 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:48:31 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:48:27 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 09/22] scsi: libsas: Add sas_alloc_slow_task_rq()
Date:   Tue, 25 Oct 2022 18:18:03 +0800
Message-ID: <1666693096-180008-10-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Add a function to add a slow task with a request associated.

The next step will be to send tasks same as we do for other requests -
through the block layer.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_init.c     | 51 ++++++++++++++++++++++++++++++
 drivers/scsi/libsas/sas_internal.h |  1 +
 include/scsi/libsas.h              |  2 +-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index f2c05ebeb72f..90e63ff5e966 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -56,9 +56,60 @@ struct sas_task *sas_alloc_slow_task(gfp_t flags)
 	return task;
 }
 
+struct sas_task *sas_alloc_slow_task_rq(struct domain_device *device, gfp_t flags)
+{
+	struct sas_ha_struct *sas_ha = device->port->ha;
+	struct Scsi_Host *shost = sas_ha->core.shost;
+	struct scsi_device *sdev, *found_sdev = NULL;
+	struct scsi_cmnd *scmd;
+	struct sas_task *task;
+	struct request *rq;
+
+	shost_for_each_device(sdev, shost) {
+		struct scsi_target *starget = sdev->sdev_target;
+
+		if (starget->hostdata == device) {
+			found_sdev = sdev;
+			break;
+		}
+	}
+
+	if (!found_sdev)
+		return NULL;
+
+	scsi_device_put(found_sdev);
+
+	task = sas_alloc_slow_task(flags);
+	if (!task)
+		return NULL;
+
+	task->dev = device;
+
+	rq = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN,
+				BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	if (IS_ERR(rq)) {
+		sas_free_task(task);
+		return NULL;
+	}
+
+	scmd = blk_mq_rq_to_pdu(rq);
+
+	task->uldd_task = scmd;
+	rq->end_io_data = task;
+
+	return task;
+}
+
 void sas_free_task(struct sas_task *task)
 {
 	if (task) {
+		if (task->slow_task && task->uldd_task) {
+			struct scsi_cmnd *scmd = task->uldd_task;
+			struct request *rq = scsi_cmd_to_rq(scmd);
+
+			BUG_ON(!blk_mq_is_reserved_rq(rq));
+			blk_mq_free_request(rq);
+		}
 		kfree(task->slow_task);
 		kmem_cache_free(sas_task_cache, task);
 	}
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 6cf190ade35e..f5ae4de382f7 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -54,6 +54,7 @@ void sas_free_event(struct asd_sas_event *event);
 
 struct sas_task *sas_alloc_task(gfp_t flags);
 struct sas_task *sas_alloc_slow_task(gfp_t flags);
+struct sas_task *sas_alloc_slow_task_rq(struct domain_device *device, gfp_t flags);
 void sas_free_task(struct sas_task *task);
 
 int  sas_register_ports(struct sas_ha_struct *sas_ha);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 1aee3d0ebbb2..4c4d8c91b1c1 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -648,7 +648,7 @@ static inline struct request *sas_task_find_rq(struct sas_task *task)
 {
 	struct scsi_cmnd *scmd;
 
-	if (task->task_proto & SAS_PROTOCOL_STP_ALL) {
+	if (!task->slow_task && task->task_proto & SAS_PROTOCOL_STP_ALL) {
 		struct ata_queued_cmd *qc = task->uldd_task;
 
 		scmd = qc ? qc->scsicmd : NULL;
-- 
2.35.3

