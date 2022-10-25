Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011FC60C8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiJYJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJYJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:50:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D45110B0E;
        Tue, 25 Oct 2022 02:48:37 -0700 (PDT)
Received: from frapeml500004.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRsv12brz67GTC;
        Tue, 25 Oct 2022 17:46:43 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml500004.china.huawei.com (7.182.85.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:48:35 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:48:31 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 10/22] scsi: libsas: Add sas_queuecommand_internal()
Date:   Tue, 25 Oct 2022 18:18:04 +0800
Message-ID: <1666693096-180008-11-git-send-email-john.garry@huawei.com>
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

Add a callback for scsi host template reserved_queuecommand callback, and
plug it into libsas LLDDs.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_init.c    |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  1 +
 drivers/scsi/isci/init.c               |  1 +
 drivers/scsi/libsas/sas_scsi_host.c    | 13 +++++++++++++
 drivers/scsi/mvsas/mv_init.c           |  1 +
 drivers/scsi/pm8001/pm8001_init.c      |  1 +
 include/scsi/libsas.h                  |  1 +
 9 files changed, 21 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 954d0c5ae2e2..e9d2ee5434c2 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -60,6 +60,7 @@ static struct scsi_host_template aic94xx_sht = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.track_queue_depth	= 1,
+	.reserved_queuecommand = sas_queuecommand_internal,
 };
 
 static int asd_map_memio(struct asd_ha_struct *asd_ha)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index d643c5a49aa9..6cf660b1212e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1760,6 +1760,7 @@ static struct scsi_host_template sht_v1_hw = {
 #endif
 	.shost_groups		= host_v1_hw_groups,
 	.host_reset             = hisi_sas_host_reset,
+	.reserved_queuecommand = sas_queuecommand_internal,
 };
 
 static const struct hisi_sas_hw hisi_sas_v1_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index cded42f4ca44..d2bf23ad0833 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3578,6 +3578,7 @@ static struct scsi_host_template sht_v2_hw = {
 	.host_reset		= hisi_sas_host_reset,
 	.map_queues		= map_queues_v2_hw,
 	.host_tagset		= 1,
+	.reserved_queuecommand = sas_queuecommand_internal,
 };
 
 static const struct hisi_sas_hw hisi_sas_v2_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 0c3fcb807806..ff56072c7a33 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3245,6 +3245,7 @@ static struct scsi_host_template sht_v3_hw = {
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 	.host_reset             = hisi_sas_host_reset,
 	.host_tagset		= 1,
+	.reserved_queuecommand = sas_queuecommand_internal,
 };
 
 static const struct hisi_sas_hw hisi_sas_v3_hw = {
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index e294d5d961eb..e970f4b77ed3 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -177,6 +177,7 @@ static struct scsi_host_template isci_sht = {
 #endif
 	.shost_groups			= isci_host_groups,
 	.track_queue_depth		= 1,
+	.reserved_queuecommand = sas_queuecommand_internal,
 };
 
 static struct sas_domain_function_template isci_transport_ops  = {
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index a36fa1c128a8..04e8c0575021 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -158,6 +158,19 @@ static struct sas_task *sas_create_task(struct scsi_cmnd *cmd,
 	return task;
 }
 
+int sas_queuecommand_internal(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
+{
+	struct sas_ha_struct *ha = SHOST_TO_SAS_HA(shost);
+	struct sas_internal *i = to_sas_internal(ha->core.shost->transportt);
+	struct request *rq = blk_mq_rq_from_pdu(cmnd);
+	struct sas_task *task = rq->end_io_data;
+
+	ASSIGN_SAS_TASK(cmnd, task);
+
+	return i->dft->lldd_execute_task(task, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(sas_queuecommand_internal);
+
 int sas_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 {
 	struct sas_internal *i = to_sas_internal(host->transportt);
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index cfe84473a515..228ab00e180f 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -54,6 +54,7 @@ static struct scsi_host_template mvs_sht = {
 #endif
 	.shost_groups		= mvst_host_groups,
 	.track_queue_depth	= 1,
+	.reserved_queuecommand = sas_queuecommand_internal,
 };
 
 static struct sas_domain_function_template mvs_transport_ops = {
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index a1df61205b20..1a12c3f97f53 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -123,6 +123,7 @@ static struct scsi_host_template pm8001_sht = {
 	.track_queue_depth	= 1,
 	.cmd_per_lun		= 32,
 	.map_queues		= pm8001_map_queues,
+	.reserved_queuecommand = sas_queuecommand_internal,
 };
 
 /*
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 4c4d8c91b1c1..64035f83c5bd 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -739,6 +739,7 @@ int  sas_discover_sata(struct domain_device *);
 int  sas_discover_end_dev(struct domain_device *);
 
 void sas_unregister_dev(struct asd_sas_port *port, struct domain_device *);
+int sas_queuecommand_internal(struct Scsi_Host *shost, struct scsi_cmnd *cmnd);
 
 void sas_init_dev(struct domain_device *);
 
-- 
2.35.3

