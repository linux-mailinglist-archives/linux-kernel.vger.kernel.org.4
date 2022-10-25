Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB2960C8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJYJxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiJYJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:51:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F516CA5A;
        Tue, 25 Oct 2022 02:49:13 -0700 (PDT)
Received: from frapeml100001.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRrj0JLXz686Kq;
        Tue, 25 Oct 2022 17:45:41 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml100001.china.huawei.com (7.182.85.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:49:10 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:49:06 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 18/22] scsi: libsas: Queue SMP commands as requests
Date:   Tue, 25 Oct 2022 18:18:12 +0800
Message-ID: <1666693096-180008-19-git-send-email-john.garry@huawei.com>
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

Send SMP commands through the block layer so that each command gets a
unique tag associated.

Function sas_task_complete_internal() is what the LLDD calls to signal
that the CQ is complete and this calls into the SCSI midlayer. And then
sas_blk_end_sync_rq() is called when the request completes.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c  | 23 ++++++++---------------
 drivers/scsi/libsas/sas_init.c      |  3 +++
 drivers/scsi/libsas/sas_internal.h  |  3 +++
 drivers/scsi/libsas/sas_scsi_host.c | 16 ++++++++++++++++
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index e7cb95683522..cc41127ea5cc 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -43,34 +43,27 @@ static int smp_execute_task_sg(struct domain_device *dev,
 	pm_runtime_get_sync(ha->dev);
 	mutex_lock(&dev->ex_dev.cmd_mutex);
 	for (retry = 0; retry < 3; retry++) {
+		struct request *rq;
+
 		if (test_bit(SAS_DEV_GONE, &dev->state)) {
 			res = -ECOMM;
 			break;
 		}
 
-		task = sas_alloc_slow_task(GFP_KERNEL);
+		task = sas_alloc_slow_task_rq(dev, GFP_KERNEL);
 		if (!task) {
 			res = -ENOMEM;
 			break;
 		}
-		task->dev = dev;
+
+		rq = scsi_cmd_to_rq(task->uldd_task);
+		rq->timeout = SMP_TIMEOUT*HZ;
+
 		task->task_proto = dev->tproto;
 		task->smp_task.smp_req = *req;
 		task->smp_task.smp_resp = *resp;
 
-		task->task_done = sas_task_internal_done;
-
-		task->slow_task->timer.function = sas_task_internal_timedout;
-		task->slow_task->timer.expires = jiffies + SMP_TIMEOUT*HZ;
-		add_timer(&task->slow_task->timer);
-
-		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
-
-		if (res) {
-			del_timer_sync(&task->slow_task->timer);
-			pr_notice("executing SMP task failed:%d\n", res);
-			break;
-		}
+		blk_execute_rq_nowait(rq, true);
 
 		wait_for_completion(&task->slow_task->completion);
 		res = -ECOMM;
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index 90e63ff5e966..5f9e71a54799 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -84,6 +84,7 @@ struct sas_task *sas_alloc_slow_task_rq(struct domain_device *device, gfp_t flag
 		return NULL;
 
 	task->dev = device;
+	task->task_done = sas_task_complete_internal;
 
 	rq = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN,
 				BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
@@ -95,6 +96,8 @@ struct sas_task *sas_alloc_slow_task_rq(struct domain_device *device, gfp_t flag
 	scmd = blk_mq_rq_to_pdu(rq);
 
 	task->uldd_task = scmd;
+
+	rq->end_io = sas_blk_end_sync_rq;
 	rq->end_io_data = task;
 
 	return task;
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index f5ae4de382f7..9b58948c57c2 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -104,6 +104,9 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 		    int para_len, int force_phy_id,
 		    struct sas_tmf_task *tmf);
 
+void sas_task_complete_internal(struct sas_task *task);
+enum rq_end_io_ret sas_blk_end_sync_rq(struct request *rq, blk_status_t error);
+
 #ifdef CONFIG_SCSI_SAS_HOST_SMP
 extern void sas_smp_host_handler(struct bsg_job *job, struct Scsi_Host *shost);
 #else
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index b7d1994a8f1b..2c734a87bb7c 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -913,6 +913,13 @@ void sas_task_internal_done(struct sas_task *task)
 	complete(&task->slow_task->completion);
 }
 
+void sas_task_complete_internal(struct sas_task *task)
+{
+	struct scsi_cmnd *scmd = task->uldd_task;
+
+	scsi_done(scmd);
+}
+
 void sas_task_internal_timedout(struct timer_list *t)
 {
 	struct sas_task_slow *slow = from_timer(slow, t, timer);
@@ -952,6 +959,15 @@ EXPORT_SYMBOL_GPL(sas_internal_timeout);
 #define TASK_TIMEOUT			(20 * HZ)
 #define TASK_RETRY			3
 
+enum rq_end_io_ret sas_blk_end_sync_rq(struct request *rq, blk_status_t error)
+{
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
+	struct sas_task *task = TO_SAS_TASK(scmd);
+	complete(&task->slow_task->completion);
+
+	return RQ_END_IO_NONE;
+}
+
 static int sas_execute_internal_abort(struct domain_device *device,
 				      enum sas_internal_abort type, u16 tag,
 				      unsigned int qid, void *data)
-- 
2.35.3

