Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48EC60C9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiJYKMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiJYKKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:10:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8806013669F;
        Tue, 25 Oct 2022 03:03:42 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxS9Q390vz67brF;
        Tue, 25 Oct 2022 18:00:10 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:03:40 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:03:37 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 7/7] scsi: hisi_sas: Remove internal tag handling for reserved commands
Date:   Tue, 25 Oct 2022 18:32:56 +0800
Message-ID: <1666693976-181094-8-git-send-email-john.garry@huawei.com>
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

Now that any sas_task which we're sent has a request associated, we can
use the request tag for slot IPTT.

However, since v2 HW has its own slot IPTT allocation scheme due to badly
broken HW, continue to use it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  3 -
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 82 +++++---------------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  9 +--
 3 files changed, 17 insertions(+), 77 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 6f8a52a1b808..8cd238f75066 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -39,9 +39,6 @@
 #define HISI_SAS_PM_BIT		2
 #define HISI_SAS_HW_FAULT_BIT	3
 #define HISI_SAS_MAX_COMMANDS (HISI_SAS_QUEUE_SLOTS)
-#define HISI_SAS_RESERVED_IPTT  96
-#define HISI_SAS_UNRESERVED_IPTT \
-	(HISI_SAS_MAX_COMMANDS - HISI_SAS_RESERVED_IPTT)
 
 #define HISI_SAS_IOST_ITCT_CACHE_NUM 64
 #define HISI_SAS_IOST_ITCT_CACHE_DW_SZ 10
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 65475775c844..7f784cdacf9f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -161,49 +161,13 @@ static void hisi_sas_slot_index_clear(struct hisi_hba *hisi_hba, int slot_idx)
 
 static void hisi_sas_slot_index_free(struct hisi_hba *hisi_hba, int slot_idx)
 {
-	if (hisi_hba->hw->slot_index_alloc ||
-	    slot_idx >= HISI_SAS_UNRESERVED_IPTT) {
+	if (hisi_hba->hw->slot_index_alloc) {
 		spin_lock(&hisi_hba->lock);
 		hisi_sas_slot_index_clear(hisi_hba, slot_idx);
 		spin_unlock(&hisi_hba->lock);
 	}
 }
 
-static void hisi_sas_slot_index_set(struct hisi_hba *hisi_hba, int slot_idx)
-{
-	void *bitmap = hisi_hba->slot_index_tags;
-
-	__set_bit(slot_idx, bitmap);
-}
-
-static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
-				     struct request *rq)
-{
-	int index;
-	void *bitmap = hisi_hba->slot_index_tags;
-
-	if (rq)
-		return rq->tag + HISI_SAS_RESERVED_IPTT;
-
-	spin_lock(&hisi_hba->lock);
-	index = find_next_zero_bit(bitmap, HISI_SAS_RESERVED_IPTT,
-				   hisi_hba->last_slot_index + 1);
-	if (index >= HISI_SAS_RESERVED_IPTT) {
-		index = find_next_zero_bit(bitmap,
-				HISI_SAS_RESERVED_IPTT,
-				0);
-		if (index >= HISI_SAS_RESERVED_IPTT) {
-			spin_unlock(&hisi_hba->lock);
-			return -SAS_QUEUE_FULL;
-		}
-	}
-	hisi_sas_slot_index_set(hisi_hba, index);
-	hisi_hba->last_slot_index = index;
-	spin_unlock(&hisi_hba->lock);
-
-	return index;
-}
-
 void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba, struct sas_task *task,
 			     struct hisi_sas_slot *slot)
 {
@@ -465,8 +429,10 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	struct hisi_sas_port *port;
 	struct hisi_hba *hisi_hba;
 	struct hisi_sas_slot *slot;
+	unsigned int dq_index;
 	struct request *rq;
 	struct device *dev;
+	u32 blk_tag;
 	int rc;
 
 	if (!sas_port) {
@@ -486,20 +452,9 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	hisi_hba = dev_to_hisi_hba(device);
 	dev = hisi_hba->dev;
 	rq = sas_task_find_rq(task);
-	if (rq) {
-		unsigned int dq_index;
-		u32 blk_tag;
-
-		blk_tag = blk_mq_unique_tag(rq);
-		dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
-		dq = &hisi_hba->dq[dq_index];
-	} else {
-		struct Scsi_Host *shost = hisi_hba->shost;
-		struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
-		int queue = qmap->mq_map[raw_smp_processor_id()];
-
-		dq = &hisi_hba->dq[queue];
-	}
+	blk_tag = blk_mq_unique_tag(rq);
+	dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
+	dq = &hisi_hba->dq[dq_index];
 
 	switch (task->task_proto) {
 	case SAS_PROTOCOL_SSP:
@@ -563,13 +518,13 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 			goto err_out_dma_unmap;
 	}
 
-	if (!internal_abort && hisi_hba->hw->slot_index_alloc)
+	if (hisi_hba->hw->slot_index_alloc) {
 		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
-	else
-		rc = hisi_sas_slot_index_alloc(hisi_hba, rq);
-
-	if (rc < 0)
-		goto err_out_dif_dma_unmap;
+		if (rc < 0)
+			goto err_out_dif_dma_unmap;
+	} else {
+		rc = rq->tag;
+	}
 
 	slot = &hisi_hba->slot_info[rc];
 	slot->n_elem = n_elem;
@@ -2434,17 +2389,8 @@ int hisi_sas_probe(struct platform_device *pdev,
 	shost->max_lun = ~0;
 	shost->max_channel = 1;
 	shost->max_cmd_len = 16;
-	if (hisi_hba->hw->slot_index_alloc) {
-		shost->can_queue = HISI_SAS_MAX_COMMANDS;
-		shost->cmd_per_lun = HISI_SAS_MAX_COMMANDS;
-	} else {
-		/*
-		 * Intentionally use HISI_SAS_UNRESERVED_IPTT for .can_queue until
-		 * every sas_task we're sent has a request associated.
-		 */
-		shost->can_queue = HISI_SAS_UNRESERVED_IPTT;
-		shost->cmd_per_lun = HISI_SAS_UNRESERVED_IPTT;
-	}
+	shost->can_queue = HISI_SAS_MAX_COMMANDS;
+	shost->cmd_per_lun = HISI_SAS_MAX_COMMANDS;
 
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = hisi_hba->dev;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 4caf07306b24..c7963ae8ad50 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4862,12 +4862,9 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->max_lun = ~0;
 	shost->max_channel = 1;
 	shost->max_cmd_len = 16;
-	/*
-	 * Intentionally use HISI_SAS_UNRESERVED_IPTT for .can_queue until
-	 * every sas_task we're sent has a request associated.
-	 */
-	shost->can_queue = HISI_SAS_UNRESERVED_IPTT;
-	shost->cmd_per_lun = HISI_SAS_UNRESERVED_IPTT;
+
+	shost->can_queue = HISI_SAS_MAX_COMMANDS;
+	shost->cmd_per_lun = HISI_SAS_MAX_COMMANDS;
 
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = dev;
-- 
2.35.3

