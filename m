Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4C60C8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJYJvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiJYJuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:50:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDCE15CB16;
        Tue, 25 Oct 2022 02:48:41 -0700 (PDT)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRtb0Ng1z6HJG9;
        Tue, 25 Oct 2022 17:47:19 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:48:40 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:48:35 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 11/22] scsi: libsas: Add sas_internal_timeout()
Date:   Tue, 25 Oct 2022 18:18:05 +0800
Message-ID: <1666693096-180008-12-git-send-email-john.garry@huawei.com>
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

Add sas_internal_timeout(), which is the timeout handler for reserved
commands, and plug into the libsas LLDDs.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_init.c    |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  1 +
 drivers/scsi/isci/init.c               |  1 +
 drivers/scsi/libsas/sas_scsi_host.c    | 18 ++++++++++++++++++
 drivers/scsi/mvsas/mv_init.c           |  1 +
 drivers/scsi/pm8001/pm8001_init.c      |  1 +
 include/scsi/libsas.h                  |  1 +
 9 files changed, 26 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index e9d2ee5434c2..06c86d7a777a 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -61,6 +61,7 @@ static struct scsi_host_template aic94xx_sht = {
 #endif
 	.track_queue_depth	= 1,
 	.reserved_queuecommand = sas_queuecommand_internal,
+	.reserved_timedout = sas_internal_timeout,
 };
 
 static int asd_map_memio(struct asd_ha_struct *asd_ha)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 6cf660b1212e..9f71cc72cd80 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1761,6 +1761,7 @@ static struct scsi_host_template sht_v1_hw = {
 	.shost_groups		= host_v1_hw_groups,
 	.host_reset             = hisi_sas_host_reset,
 	.reserved_queuecommand = sas_queuecommand_internal,
+	.reserved_timedout = sas_internal_timeout,
 };
 
 static const struct hisi_sas_hw hisi_sas_v1_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index d2bf23ad0833..483a03ed6253 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3579,6 +3579,7 @@ static struct scsi_host_template sht_v2_hw = {
 	.map_queues		= map_queues_v2_hw,
 	.host_tagset		= 1,
 	.reserved_queuecommand = sas_queuecommand_internal,
+	.reserved_timedout = sas_internal_timeout,
 };
 
 static const struct hisi_sas_hw hisi_sas_v2_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index ff56072c7a33..02d96fba510f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3246,6 +3246,7 @@ static struct scsi_host_template sht_v3_hw = {
 	.host_reset             = hisi_sas_host_reset,
 	.host_tagset		= 1,
 	.reserved_queuecommand = sas_queuecommand_internal,
+	.reserved_timedout = sas_internal_timeout,
 };
 
 static const struct hisi_sas_hw hisi_sas_v3_hw = {
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index e970f4b77ed3..9c7869bf6cde 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -178,6 +178,7 @@ static struct scsi_host_template isci_sht = {
 	.shost_groups			= isci_host_groups,
 	.track_queue_depth		= 1,
 	.reserved_queuecommand = sas_queuecommand_internal,
+	.reserved_timedout = sas_internal_timeout,
 };
 
 static struct sas_domain_function_template isci_transport_ops  = {
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 04e8c0575021..b7d1994a8f1b 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -930,6 +930,24 @@ void sas_task_internal_timedout(struct timer_list *t)
 	if (!is_completed)
 		complete(&task->slow_task->completion);
 }
+enum blk_eh_timer_return sas_internal_timeout(struct scsi_cmnd *scmd)
+{
+	struct sas_task *task = TO_SAS_TASK(scmd);
+	bool is_completed = true;
+	unsigned long flags;
+
+	spin_lock_irqsave(&task->task_state_lock, flags);
+	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
+		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
+		is_completed = false;
+	}
+	spin_unlock_irqrestore(&task->task_state_lock, flags);
+
+	if (!is_completed)
+		complete(&task->slow_task->completion);
+	return BLK_EH_DONE;
+}
+EXPORT_SYMBOL_GPL(sas_internal_timeout);
 
 #define TASK_TIMEOUT			(20 * HZ)
 #define TASK_RETRY			3
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 228ab00e180f..7fed0259e1f5 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -55,6 +55,7 @@ static struct scsi_host_template mvs_sht = {
 	.shost_groups		= mvst_host_groups,
 	.track_queue_depth	= 1,
 	.reserved_queuecommand = sas_queuecommand_internal,
+	.reserved_timedout = sas_internal_timeout,
 };
 
 static struct sas_domain_function_template mvs_transport_ops = {
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 1a12c3f97f53..ce9509792bc0 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -124,6 +124,7 @@ static struct scsi_host_template pm8001_sht = {
 	.cmd_per_lun		= 32,
 	.map_queues		= pm8001_map_queues,
 	.reserved_queuecommand = sas_queuecommand_internal,
+	.reserved_timedout = sas_internal_timeout,
 };
 
 /*
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 64035f83c5bd..f02156ccd376 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -711,6 +711,7 @@ int sas_set_phy_speed(struct sas_phy *phy, struct sas_phy_linkrates *rates);
 int sas_phy_reset(struct sas_phy *phy, int hard_reset);
 int sas_phy_enable(struct sas_phy *phy, int enable);
 extern int sas_queuecommand(struct Scsi_Host *, struct scsi_cmnd *);
+extern enum blk_eh_timer_return sas_internal_timeout(struct scsi_cmnd *scmd);
 extern int sas_target_alloc(struct scsi_target *);
 extern int sas_slave_configure(struct scsi_device *);
 extern int sas_change_queue_depth(struct scsi_device *, int new_depth);
-- 
2.35.3

