Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610E15EDCD5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiI1MeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiI1MeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:34:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F789B861;
        Wed, 28 Sep 2022 05:34:01 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mcwqx2vYkz6864m;
        Wed, 28 Sep 2022 20:32:45 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:33:59 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 13:33:56 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 4/6] scsi: pm8001: Use sas_task_find_rq() for tagging
Date:   Wed, 28 Sep 2022 20:27:12 +0800
Message-ID: <1664368034-114991-5-git-send-email-john.garry@huawei.com>
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
has a unique tag, so use that when possible for getting a CCB.

Unfortunately we don't support reserved commands in the SCSI midlayer yet,
so in the interim continue to manage those tags internally (along with
tags for private commands).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 10 ++++------
 drivers/scsi/pm8001/pm8001_sas.c  |  8 ++++++++
 drivers/scsi/pm8001/pm8001_sas.h  |  6 +++++-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 0edc9857a8bd..0868836e7391 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -1208,17 +1208,14 @@ static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
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
+	pm8001_ha->tags = bitmap_zalloc(PM8001_RESERVE_SLOT, GFP_KERNEL);
 	if (!pm8001_ha->tags)
 		goto err_out;
 
@@ -1244,9 +1241,10 @@ static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
 		pm8001_ha->ccb_info[i].task = NULL;
 		pm8001_ha->ccb_info[i].ccb_tag = PM8001_INVALID_TAG;
 		pm8001_ha->ccb_info[i].device = NULL;
-		++pm8001_ha->tags_num;
 	}
 
+	pm8001_ha->tags_num = PM8001_RESERVE_SLOT;
+
 	return 0;
 
 err_out_noccb:
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 066dfa9f4683..9d25855af657 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -68,6 +68,11 @@ void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
 	void *bitmap = pm8001_ha->tags;
 	unsigned long flags;
 
+	if (tag < pm8001_ha->shost->can_queue)
+		return;
+
+	tag -= pm8001_ha->shost->can_queue;
+
 	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
 	__clear_bit(tag, bitmap);
 	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
@@ -92,6 +97,9 @@ int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
 	}
 	__set_bit(tag, bitmap);
 	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
+
+	/* reserved tags are in the upper region of the tagset */
+	tag += pm8001_ha->shost->can_queue;
 	*tag_out = tag;
 	return 0;
 }
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 9acaadf02150..9ff8d1fa84b0 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -737,9 +737,13 @@ pm8001_ccb_alloc(struct pm8001_hba_info *pm8001_ha,
 		 struct pm8001_device *dev, struct sas_task *task)
 {
 	struct pm8001_ccb_info *ccb;
+	struct request *rq = NULL;
 	u32 tag;
 
-	if (pm8001_tag_alloc(pm8001_ha, &tag)) {
+	rq = sas_task_find_rq(task);
+	if (rq) {
+		tag = rq->tag;
+	} else if (pm8001_tag_alloc(pm8001_ha, &tag)) {
 		pm8001_dbg(pm8001_ha, FAIL, "Failed to allocate a tag\n");
 		return NULL;
 	}
-- 
2.35.3

