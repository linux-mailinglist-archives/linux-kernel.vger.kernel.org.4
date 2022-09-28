Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2CF5EDCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiI1Meb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiI1MeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:34:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0051E9C2FC;
        Wed, 28 Sep 2022 05:34:08 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mcwr36m9yz6H75m;
        Wed, 28 Sep 2022 20:32:51 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:34:06 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 13:34:02 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 6/6] scsi: mvsas: Use sas_task_find_rq() for tagging
Date:   Wed, 28 Sep 2022 20:27:14 +0800
Message-ID: <1664368034-114991-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
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

The request associated with a scsi command coming from the block layer
has a unique tag, so use that when possible for getting a slot.

Unfortunately we don't support reserved commands in the SCSI midlayer yet.
As such, SMP tasks - as an example - will not have a request associated, so
in the interim continue to manage those tags for that type of sas_task
internally.

We reserve an arbitrary 4 tags for these internal tags. Indeed, we already
decrement MVS_RSVD_SLOTS by 2 for the shost can_queue when flag
MVF_FLAG_SOC is set. This change was made in commit 20b09c2992fef
("[PATCH] [SCSI] mvsas: add support for 94xx; layout change; bug fixes"),
but what those 2 slots are used for is not obvious.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/mvsas/mv_defs.h |  1 +
 drivers/scsi/mvsas/mv_init.c |  4 ++--
 drivers/scsi/mvsas/mv_sas.c  | 22 +++++++++++++++++-----
 drivers/scsi/mvsas/mv_sas.h  |  1 -
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_defs.h b/drivers/scsi/mvsas/mv_defs.h
index 7123a2efbf58..8ef174cd4d37 100644
--- a/drivers/scsi/mvsas/mv_defs.h
+++ b/drivers/scsi/mvsas/mv_defs.h
@@ -40,6 +40,7 @@ enum driver_configuration {
 	MVS_ATA_CMD_SZ		= 96,	/* SATA command table buffer size */
 	MVS_OAF_SZ		= 64,	/* Open address frame buffer size */
 	MVS_QUEUE_SIZE		= 64,	/* Support Queue depth */
+	MVS_RSVD_SLOTS		= 4,
 	MVS_SOC_CAN_QUEUE	= MVS_SOC_SLOTS - 2,
 };
 
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index c85fb812ad43..d834ed9e8e4a 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -284,7 +284,7 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
 			printk(KERN_DEBUG "failed to create dma pool %s.\n", pool_name);
 			goto err_out;
 	}
-	mvi->tags_num = slot_nr;
+	mvi->tags_num = MVS_RSVD_SLOTS;
 
 	return 0;
 err_out:
@@ -367,7 +367,7 @@ static struct mvs_info *mvs_pci_alloc(struct pci_dev *pdev,
 	mvi->sas = sha;
 	mvi->shost = shost;
 
-	mvi->tags = kzalloc(MVS_CHIP_SLOT_SZ>>3, GFP_KERNEL);
+	mvi->tags = kzalloc(MVS_RSVD_SLOTS, GFP_KERNEL);
 	if (!mvi->tags)
 		goto err_out;
 
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 0810e6c930e1..549d2ec89f60 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -20,7 +20,7 @@ static int mvs_find_tag(struct mvs_info *mvi, struct sas_task *task, u32 *tag)
 	return 0;
 }
 
-void mvs_tag_clear(struct mvs_info *mvi, u32 tag)
+static void mvs_tag_clear(struct mvs_info *mvi, u32 tag)
 {
 	void *bitmap = mvi->tags;
 	clear_bit(tag, bitmap);
@@ -28,6 +28,11 @@ void mvs_tag_clear(struct mvs_info *mvi, u32 tag)
 
 void mvs_tag_free(struct mvs_info *mvi, u32 tag)
 {
+	if (tag < mvi->shost->can_queue)
+		return;
+
+	tag -= mvi->shost->can_queue;
+
 	mvs_tag_clear(mvi, tag);
 }
 
@@ -47,6 +52,7 @@ inline int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out)
 	if (tag >= mvi->tags_num)
 		return -SAS_QUEUE_FULL;
 	mvs_tag_set(mvi, tag);
+	tag += mvi->shost->can_queue;
 	*tag_out = tag;
 	return 0;
 }
@@ -696,6 +702,7 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 	struct mvs_task_exec_info tei;
 	struct mvs_slot_info *slot;
 	u32 tag = 0xdeadbeef, n_elem = 0;
+	struct request *rq;
 	int rc = 0;
 
 	if (!dev->port) {
@@ -760,9 +767,14 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 		n_elem = task->num_scatter;
 	}
 
-	rc = mvs_tag_alloc(mvi, &tag);
-	if (rc)
-		goto err_out;
+	rq = sas_task_find_rq(task);
+	if (rq) {
+		tag = rq->tag;
+	} else {
+		rc = mvs_tag_alloc(mvi, &tag);
+		if (rc)
+			goto err_out;
+	}
 
 	slot = &mvi->slot_info[tag];
 
@@ -857,7 +869,7 @@ int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags)
 static void mvs_slot_free(struct mvs_info *mvi, u32 rx_desc)
 {
 	u32 slot_idx = rx_desc & RXQ_SLOT_MASK;
-	mvs_tag_clear(mvi, slot_idx);
+	mvs_tag_free(mvi, slot_idx);
 }
 
 static void mvs_slot_task_free(struct mvs_info *mvi, struct sas_task *task,
diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
index fe57665bdb50..e6c70786ded9 100644
--- a/drivers/scsi/mvsas/mv_sas.h
+++ b/drivers/scsi/mvsas/mv_sas.h
@@ -424,7 +424,6 @@ struct mvs_task_exec_info {
 
 /******************** function prototype *********************/
 void mvs_get_sas_addr(void *buf, u32 buflen);
-void mvs_tag_clear(struct mvs_info *mvi, u32 tag);
 void mvs_tag_free(struct mvs_info *mvi, u32 tag);
 void mvs_tag_set(struct mvs_info *mvi, unsigned int tag);
 int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out);
-- 
2.35.3

