Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A515E5F08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiIVJyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiIVJxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:53:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39621D588C;
        Thu, 22 Sep 2022 02:53:32 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MY9Yh4symz6883d;
        Thu, 22 Sep 2022 17:52:24 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 11:53:29 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:53:27 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v4 2/7] scsi: hisi_sas: Move slot variable definition in hisi_sas_abort_task()
Date:   Thu, 22 Sep 2022 17:46:53 +0800
Message-ID: <1663840018-50161-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1663840018-50161-1-git-send-email-john.garry@huawei.com>
References: <1663840018-50161-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Each branch currently defines a slot variable independently, and it is
neater to move it to the function head.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 699b07abb6b0..8303aa5eaf25 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1547,6 +1547,7 @@ static int hisi_sas_abort_task(struct sas_task *task)
 	struct hisi_sas_internal_abort_data internal_abort_data = { false };
 	struct domain_device *device = task->dev;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
+	struct hisi_sas_slot *slot = task->lldd_task;
 	struct hisi_hba *hisi_hba;
 	struct device *dev;
 	int rc = TMF_RESP_FUNC_FAILED;
@@ -1560,7 +1561,6 @@ static int hisi_sas_abort_task(struct sas_task *task)
 
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	if (task->task_state_flags & SAS_TASK_STATE_DONE) {
-		struct hisi_sas_slot *slot = task->lldd_task;
 		struct hisi_sas_cq *cq;
 
 		if (slot) {
@@ -1578,8 +1578,7 @@ static int hisi_sas_abort_task(struct sas_task *task)
 	task->task_state_flags |= SAS_TASK_STATE_ABORTED;
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
 
-	if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SSP) {
-		struct hisi_sas_slot *slot = task->lldd_task;
+	if (slot && task->task_proto & SAS_PROTOCOL_SSP) {
 		u16 tag = slot->idx;
 		int rc2;
 
@@ -1613,9 +1612,8 @@ static int hisi_sas_abort_task(struct sas_task *task)
 			hisi_sas_dereg_device(hisi_hba, device);
 			rc = hisi_sas_softreset_ata_disk(device);
 		}
-	} else if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SMP) {
+	} else if (slot && task->task_proto & SAS_PROTOCOL_SMP) {
 		/* SMP */
-		struct hisi_sas_slot *slot = task->lldd_task;
 		u32 tag = slot->idx;
 		struct hisi_sas_cq *cq = &hisi_hba->cq[slot->dlvry_queue];
 
-- 
2.35.3

