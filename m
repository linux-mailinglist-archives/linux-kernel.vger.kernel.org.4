Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B05F412A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJDK5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJDK4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:56:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A97656025;
        Tue,  4 Oct 2022 03:56:50 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MhZNs6LyYz687YW;
        Tue,  4 Oct 2022 18:55:25 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 12:56:48 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 11:56:45 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <hare@suse.de>, <damien.lemoal@opensource.wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <ipylypiv@google.com>,
        <changyuanl@google.com>, <yanaijie@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 2/7] scsi: hisi_sas: Use sas_task_find_rq()
Date:   Tue, 4 Oct 2022 19:27:08 +0800
Message-ID: <1664882833-39804-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1664882833-39804-1-git-send-email-john.garry@huawei.com>
References: <1664882833-39804-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
index 4c37ae9eb6b6..1011dffed51f 100644
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
2.25.1

