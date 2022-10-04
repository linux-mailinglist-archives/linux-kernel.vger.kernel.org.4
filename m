Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C005F4130
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJDK5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJDK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:57:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B862556BBC;
        Tue,  4 Oct 2022 03:56:58 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MhZMr02dXz67M08;
        Tue,  4 Oct 2022 18:54:32 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 12:56:56 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 11:56:53 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <hare@suse.de>, <damien.lemoal@opensource.wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <ipylypiv@google.com>,
        <changyuanl@google.com>, <yanaijie@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 5/7] scsi: pm8001: Use sas_task_find_rq() for tagging
Date:   Tue, 4 Oct 2022 19:27:11 +0800
Message-ID: <1664882833-39804-6-git-send-email-john.garry@huawei.com>
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

The request associated with a scsi command coming from the block layer
has a unique tag, so use that when possible for getting a CCB.

Unfortunately we don't support reserved commands in the SCSI midlayer yet,
so in the interim continue to manage those tags internally (along with
tags for private commands).

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 12 ++++--------
 drivers/scsi/pm8001/pm8001_sas.c  | 13 +++++++++----
 drivers/scsi/pm8001/pm8001_sas.h  | 11 ++++++++---
 drivers/scsi/pm8001/pm80xx_hwi.c  | 17 +++--------------
 4 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 0edc9857a8bd..abb884ddcaf9 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -196,7 +196,7 @@ static void pm8001_free(struct pm8001_hba_info *pm8001_ha)
 	}
 	PM8001_CHIP_DISP->chip_iounmap(pm8001_ha);
 	flush_workqueue(pm8001_wq);
-	bitmap_free(pm8001_ha->tags);
+	bitmap_free(pm8001_ha->rsvd_tags);
 	kfree(pm8001_ha);
 }
 
@@ -1208,18 +1208,15 @@ static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
 	struct Scsi_Host *shost = pm8001_ha->shost;
 	struct device *dev = pm8001_ha->dev;
 	u32 max_out_io, ccb_count;
-	u32 can_queue;
 	int i;
 
 	max_out_io = pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_out_io;
 	ccb_count = min_t(int, PM8001_MAX_CCB, max_out_io);
 
-	/* Update to the scsi host*/
-	can_queue = ccb_count - PM8001_RESERVE_SLOT;
-	shost->can_queue = can_queue;
+	shost->can_queue = ccb_count - PM8001_RESERVE_SLOT;
 
-	pm8001_ha->tags = bitmap_zalloc(ccb_count, GFP_KERNEL);
-	if (!pm8001_ha->tags)
+	pm8001_ha->rsvd_tags = bitmap_zalloc(PM8001_RESERVE_SLOT, GFP_KERNEL);
+	if (!pm8001_ha->rsvd_tags)
 		goto err_out;
 
 	/* Memory region for ccb_info*/
@@ -1244,7 +1241,6 @@ static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
 		pm8001_ha->ccb_info[i].task = NULL;
 		pm8001_ha->ccb_info[i].ccb_tag = PM8001_INVALID_TAG;
 		pm8001_ha->ccb_info[i].device = NULL;
-		++pm8001_ha->tags_num;
 	}
 
 	return 0;
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 066dfa9f4683..f46588cd5c73 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -65,9 +65,12 @@ static int pm8001_find_tag(struct sas_task *task, u32 *tag)
   */
 void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
 {
-	void *bitmap = pm8001_ha->tags;
+	void *bitmap = pm8001_ha->rsvd_tags;
 	unsigned long flags;
 
+	if (tag >= PM8001_RESERVE_SLOT)
+		return;
+
 	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
 	__clear_bit(tag, bitmap);
 	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
@@ -80,18 +83,20 @@ void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
   */
 int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
 {
-	void *bitmap = pm8001_ha->tags;
+	void *bitmap = pm8001_ha->rsvd_tags;
 	unsigned long flags;
 	unsigned int tag;
 
 	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
-	tag = find_first_zero_bit(bitmap, pm8001_ha->tags_num);
-	if (tag >= pm8001_ha->tags_num) {
+	tag = find_first_zero_bit(bitmap, PM8001_RESERVE_SLOT);
+	if (tag >= PM8001_RESERVE_SLOT) {
 		spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
 		return -SAS_QUEUE_FULL;
 	}
 	__set_bit(tag, bitmap);
 	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
+
+	/* reserved tags are in the lower region of the tagset */
 	*tag_out = tag;
 	return 0;
 }
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 9acaadf02150..b584e68664d8 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -510,8 +510,7 @@ struct pm8001_hba_info {
 	u32			chip_id;
 	const struct pm8001_chip_info	*chip;
 	struct completion	*nvmd_completion;
-	int			tags_num;
-	unsigned long		*tags;
+	unsigned long		*rsvd_tags;
 	struct pm8001_phy	phy[PM8001_MAX_PHYS];
 	struct pm8001_port	port[PM8001_MAX_PHYS];
 	u32			id;
@@ -737,9 +736,15 @@ pm8001_ccb_alloc(struct pm8001_hba_info *pm8001_ha,
 		 struct pm8001_device *dev, struct sas_task *task)
 {
 	struct pm8001_ccb_info *ccb;
+	struct request *rq = NULL;
 	u32 tag;
 
-	if (pm8001_tag_alloc(pm8001_ha, &tag)) {
+	if (task)
+		rq = sas_task_find_rq(task);
+
+	if (rq) {
+		tag = rq->tag + PM8001_RESERVE_SLOT;
+	} else if (pm8001_tag_alloc(pm8001_ha, &tag)) {
 		pm8001_dbg(pm8001_ha, FAIL, "Failed to allocate a tag\n");
 		return NULL;
 	}
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 4484c498bcb6..ed2d65d3749a 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4247,24 +4247,13 @@ static int check_enc_sat_cmd(struct sas_task *task)
 
 static u32 pm80xx_chip_get_q_index(struct sas_task *task)
 {
-	struct scsi_cmnd *scmd = NULL;
+	struct request *rq = sas_task_find_rq(task);
 	u32 blk_tag;
 
-	if (task->uldd_task) {
-		struct ata_queued_cmd *qc;
-
-		if (dev_is_sata(task->dev)) {
-			qc = task->uldd_task;
-			scmd = qc->scsicmd;
-		} else {
-			scmd = task->uldd_task;
-		}
-	}
-
-	if (!scmd)
+	if (!rq)
 		return 0;
 
-	blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
+	blk_tag = blk_mq_unique_tag(rq);
 	return blk_mq_unique_tag_to_hwq(blk_tag);
 }
 
-- 
2.25.1

