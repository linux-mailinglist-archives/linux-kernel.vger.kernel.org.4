Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B8C602991
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJRKqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJRKpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:45:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B28B44A5;
        Tue, 18 Oct 2022 03:45:45 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ms9TF2yy5z67hlj;
        Tue, 18 Oct 2022 18:44:01 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 12:45:44 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 11:45:41 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v4 2/7] scsi: hisi_sas: Use sas_task_find_rq()
Date:   Tue, 18 Oct 2022 19:15:58 +0800
Message-ID: <1666091763-11023-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1666091763-11023-1-git-send-email-john.garry@huawei.com>
References: <1666091763-11023-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Use sas_task_find_rq() to lookup the request per task for its driver tag.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 10813836a728..26e474b0f53f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -177,13 +177,13 @@ static void hisi_sas_slot_index_set(struct hisi_hba *hisi_hba, int slot_idx)
 }
 
 static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
-				     struct scsi_cmnd *scsi_cmnd)
+				     struct request *rq)
 {
 	int index;
 	void *bitmap = hisi_hba->slot_index_tags;
 
-	if (scsi_cmnd)
-		return scsi_cmd_to_rq(scsi_cmnd)->tag;
+	if (rq)
+		return rq->tag;
 
 	spin_lock(&hisi_hba->lock);
 	index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
@@ -461,11 +461,11 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	bool internal_abort = sas_is_internal_abort(task);
-	struct scsi_cmnd *scmd = NULL;
 	struct hisi_sas_dq *dq = NULL;
 	struct hisi_sas_port *port;
 	struct hisi_hba *hisi_hba;
 	struct hisi_sas_slot *slot;
+	struct request *rq = NULL;
 	struct device *dev;
 	int rc;
 
@@ -520,22 +520,12 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 				return -ECOMM;
 		}
 
-		if (task->uldd_task) {
-			struct ata_queued_cmd *qc;
-
-			if (dev_is_sata(device)) {
-				qc = task->uldd_task;
-				scmd = qc->scsicmd;
-			} else {
-				scmd = task->uldd_task;
-			}
-		}
-
-		if (scmd) {
+		rq = sas_task_find_rq(task);
+		if (rq) {
 			unsigned int dq_index;
 			u32 blk_tag;
 
-			blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
+			blk_tag = blk_mq_unique_tag(rq);
 			dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
 			dq = &hisi_hba->dq[dq_index];
 		} else {
@@ -580,7 +570,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	if (!internal_abort && hisi_hba->hw->slot_index_alloc)
 		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
 	else
-		rc = hisi_sas_slot_index_alloc(hisi_hba, scmd);
+		rc = hisi_sas_slot_index_alloc(hisi_hba, rq);
 
 	if (rc < 0)
 		goto err_out_dif_dma_unmap;
-- 
2.35.3

