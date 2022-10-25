Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9B60C9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiJYKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJYKKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:10:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6018F12741E;
        Tue, 25 Oct 2022 03:03:39 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxS9L6lMFz67MQZ;
        Tue, 25 Oct 2022 18:00:06 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:03:37 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:03:33 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 6/7] scsi: mvsas: Remove internal tag handling
Date:   Tue, 25 Oct 2022 18:32:55 +0800
Message-ID: <1666693976-181094-7-git-send-email-john.garry@huawei.com>
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

Now that any sas_task which we're sent has a request associated, delete
internal tag management.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/mvsas/mv_init.c | 11 --------
 drivers/scsi/mvsas/mv_sas.c  | 55 ++----------------------------------
 drivers/scsi/mvsas/mv_sas.h  |  1 -
 3 files changed, 2 insertions(+), 65 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index e1b6cc196cef..9cb8d5b315db 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -147,7 +147,6 @@ static void mvs_free(struct mvs_info *mvi)
 		scsi_host_put(mvi->shost);
 	list_for_each_entry(mwq, &mvi->wq_list, entry)
 		cancel_delayed_work(&mwq->work_q);
-	kfree(mvi->rsvd_tags);
 	kfree(mvi);
 }
 
@@ -371,10 +370,6 @@ static struct mvs_info *mvs_pci_alloc(struct pci_dev *pdev,
 	mvi->sas = sha;
 	mvi->shost = shost;
 
-	mvi->rsvd_tags = bitmap_zalloc(MVS_RSVD_SLOTS, GFP_KERNEL);
-	if (!mvi->rsvd_tags)
-		goto err_out;
-
 	if (MVS_CHIP_DISP->chip_ioremap(mvi))
 		goto err_out;
 	if (!mvs_alloc(mvi, shost))
@@ -473,12 +468,6 @@ static void  mvs_post_sas_ha_init(struct Scsi_Host *shost,
 	else
 		can_queue = MVS_CHIP_SLOT_SZ;
 
-	/*
-	 * Carve out MVS_RSVD_SLOTS slots internally until every sas_task we're sent
-	 * has a request associated.
-	 */
-	can_queue -= MVS_RSVD_SLOTS;
-
 	shost->sg_tablesize = min_t(u16, SG_ALL, MVS_MAX_SG);
 	shost->can_queue = can_queue;
 	mvi->shost->cmd_per_lun = MVS_QUEUE_SIZE;
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 9978c424214c..3c92fc48680d 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -20,40 +20,6 @@ static int mvs_find_tag(struct mvs_info *mvi, struct sas_task *task, u32 *tag)
 	return 0;
 }
 
-static void mvs_tag_clear(struct mvs_info *mvi, u32 tag)
-{
-	void *bitmap = mvi->rsvd_tags;
-	clear_bit(tag, bitmap);
-}
-
-static void mvs_tag_free(struct mvs_info *mvi, u32 tag)
-{
-	if (tag >= MVS_RSVD_SLOTS)
-		return;
-
-	mvs_tag_clear(mvi, tag);
-}
-
-static void mvs_tag_set(struct mvs_info *mvi, unsigned int tag)
-{
-	void *bitmap = mvi->rsvd_tags;
-	set_bit(tag, bitmap);
-}
-
-static int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out)
-{
-	unsigned int index, tag;
-	void *bitmap = mvi->rsvd_tags;
-
-	index = find_first_zero_bit(bitmap, MVS_RSVD_SLOTS);
-	tag = index;
-	if (tag >= MVS_RSVD_SLOTS)
-		return -SAS_QUEUE_FULL;
-	mvs_tag_set(mvi, tag);
-	*tag_out = tag;
-	return 0;
-}
-
 static struct mvs_info *mvs_find_dev_mvi(struct domain_device *dev)
 {
 	unsigned long i = 0, j = 0, hi = 0;
@@ -765,13 +731,7 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 	}
 
 	rq = sas_task_find_rq(task);
-	if (rq) {
-		tag = rq->tag + MVS_RSVD_SLOTS;
-	} else {
-		rc = mvs_tag_alloc(mvi, &tag);
-		if (rc)
-			goto err_out;
-	}
+	tag = rq->tag;
 
 	slot = &mvi->slot_info[tag];
 
@@ -782,7 +742,7 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 	slot->buf = dma_pool_zalloc(mvi->dma_pool, GFP_ATOMIC, &slot->buf_dma);
 	if (!slot->buf) {
 		rc = -ENOMEM;
-		goto err_out_tag;
+		goto err_out;
 	}
 
 	tei.task = task;
@@ -826,8 +786,6 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 
 err_out_slot_buf:
 	dma_pool_free(mvi->dma_pool, slot->buf, slot->buf_dma);
-err_out_tag:
-	mvs_tag_free(mvi, tag);
 err_out:
 
 	dev_printk(KERN_ERR, mvi->dev, "mvsas prep failed[%d]!\n", rc);
@@ -863,12 +821,6 @@ int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	return rc;
 }
 
-static void mvs_slot_free(struct mvs_info *mvi, u32 rx_desc)
-{
-	u32 slot_idx = rx_desc & RXQ_SLOT_MASK;
-	mvs_tag_free(mvi, slot_idx);
-}
-
 static void mvs_slot_task_free(struct mvs_info *mvi, struct sas_task *task,
 			  struct mvs_slot_info *slot, u32 slot_idx)
 {
@@ -906,7 +858,6 @@ static void mvs_slot_task_free(struct mvs_info *mvi, struct sas_task *task,
 	slot->task = NULL;
 	slot->port = NULL;
 	slot->slot_tag = 0xFFFFFFFF;
-	mvs_slot_free(mvi, slot_idx);
 }
 
 static void mvs_update_wideport(struct mvs_info *mvi, int phy_no)
@@ -1913,8 +1864,6 @@ int mvs_int_rx(struct mvs_info *mvi, bool self_clear)
 		} else if (rx_desc & RXQ_ERR) {
 			if (!(rx_desc & RXQ_DONE))
 				mvs_slot_complete(mvi, rx_desc, 0);
-		} else if (rx_desc & RXQ_SLOT_RESET) {
-			mvs_slot_free(mvi, rx_desc);
 		}
 	}
 
diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
index 68df771e2975..bc3b5711fc07 100644
--- a/drivers/scsi/mvsas/mv_sas.h
+++ b/drivers/scsi/mvsas/mv_sas.h
@@ -370,7 +370,6 @@ struct mvs_info {
 	u32 chip_id;
 	const struct mvs_chip_info *chip;
 
-	unsigned long *rsvd_tags;
 	/* further per-slot information */
 	struct mvs_phy phy[MVS_MAX_PHYS];
 	struct mvs_port port[MVS_MAX_PHYS];
-- 
2.35.3

