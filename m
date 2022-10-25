Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1586460C8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiJYJxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiJYJwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:52:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17AF16F748;
        Tue, 25 Oct 2022 02:49:16 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRvF5WDGz6HJXS;
        Tue, 25 Oct 2022 17:47:53 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:49:14 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:49:10 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 19/22] scsi: libsas: Queue TMF commands as requests
Date:   Tue, 25 Oct 2022 18:18:13 +0800
Message-ID: <1666693096-180008-20-git-send-email-john.garry@huawei.com>
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

Like what we did with SMP commands, send TMF commands through the block
layer.

In sas_task_abort() we must ensure to not confuse "TMF" for SATA with
regular SATA command which comes from libata.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_scsi_host.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 2c734a87bb7c..e6ee8dd56a45 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1067,13 +1067,17 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 	int res, retry;
 
 	for (retry = 0; retry < TASK_RETRY; retry++) {
-		task = sas_alloc_slow_task(GFP_KERNEL);
+		struct request *rq;
+
+		task = sas_alloc_slow_task_rq(device, GFP_KERNEL);
 		if (!task)
 			return -ENOMEM;
 
-		task->dev = device;
 		task->task_proto = device->tproto;
 
+		rq = scsi_cmd_to_rq(task->uldd_task);
+		rq->timeout = TASK_TIMEOUT;
+
 		if (dev_is_sata(device)) {
 			task->ata_task.device_control_reg_update = 1;
 			if (force_phy_id >= 0) {
@@ -1085,20 +1089,9 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 			memcpy(&task->ssp_task, parameter, para_len);
 		}
 
-		task->task_done = sas_task_internal_done;
 		task->tmf = tmf;
 
-		task->slow_task->timer.function = sas_task_internal_timedout;
-		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
-		add_timer(&task->slow_task->timer);
-
-		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
-		if (res) {
-			del_timer_sync(&task->slow_task->timer);
-			pr_err("executing TMF task failed %016llx (%d)\n",
-			       SAS_ADDR(device->sas_addr), res);
-			break;
-		}
+		blk_execute_rq_nowait(rq, true);
 
 		wait_for_completion(&task->slow_task->completion);
 
@@ -1270,7 +1263,7 @@ void sas_task_abort(struct sas_task *task)
 		return;
 	}
 
-	if (dev_is_sata(task->dev))
+	if (dev_is_sata(task->dev) && !task->slow_task)
 		sas_ata_task_abort(task);
 	else
 		blk_abort_request(scsi_cmd_to_rq(sc));
-- 
2.35.3

