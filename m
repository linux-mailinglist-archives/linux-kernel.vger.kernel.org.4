Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A353600921
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJQIuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJQIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:50:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E452F65F;
        Mon, 17 Oct 2022 01:50:22 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MrVyZ6F2zz6H7X4;
        Mon, 17 Oct 2022 16:48:38 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 10:50:20 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:50:17 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <niklas.cassel@wdc.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v6 3/8] scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
Date:   Mon, 17 Oct 2022 17:20:30 +0800
Message-ID: <1665998435-199946-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1665998435-199946-1-git-send-email-john.garry@huawei.com>
References: <1665998435-199946-1-git-send-email-john.garry@huawei.com>
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

From: Xingui Yang <yangxingui@huawei.com>

When CQ header dw3 SATA_DISK_ERR is set it means this SATA disk is in error
state and the current IPTT is invalid. An invalid IPTT does not correspond
to any slot.

In this scenario, new I/Os that delivered to disk will be rejected by the
controller and all I/Os remaining in the disk should be aborted, which we
add here with the sas_ata_device_link_abort() call.

In hisi_sas_abort_task() we don't want to issue a softreset as it may
cause info to be lost in the target disk for the ATA EH autopsy. In this
case, just release resources - the disk won't return other I/Os normally
after NCQ Error, so this is safe.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 18 +++++++++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 48 ++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 9aebf4a26b13..6f8a52a1b808 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -104,6 +104,7 @@ enum {
 enum dev_status {
 	HISI_SAS_DEV_INIT,
 	HISI_SAS_DEV_NORMAL,
+	HISI_SAS_DEV_NCQ_ERR,
 };
 
 enum {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 8303aa5eaf25..4c37ae9eb6b6 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1604,13 +1604,26 @@ static int hisi_sas_abort_task(struct sas_task *task)
 	} else if (task->task_proto & SAS_PROTOCOL_SATA ||
 		task->task_proto & SAS_PROTOCOL_STP) {
 		if (task->dev->dev_type == SAS_SATA_DEV) {
+			struct ata_queued_cmd *qc = task->uldd_task;
+
 			rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
 			if (rc < 0) {
 				dev_err(dev, "abort task: internal abort failed\n");
 				goto out;
 			}
 			hisi_sas_dereg_device(hisi_hba, device);
-			rc = hisi_sas_softreset_ata_disk(device);
+
+			/*
+			 * If an ATA internal command times out in ATA EH, it
+			 * need to execute soft reset, so check the scsicmd
+			 */
+			if ((sas_dev->dev_status == HISI_SAS_DEV_NCQ_ERR) &&
+			    qc && qc->scsicmd) {
+				hisi_sas_do_release_task(hisi_hba, task, slot);
+				rc = TMF_RESP_FUNC_COMPLETE;
+			} else {
+				rc = hisi_sas_softreset_ata_disk(device);
+			}
 		}
 	} else if (slot && task->task_proto & SAS_PROTOCOL_SMP) {
 		/* SMP */
@@ -1727,6 +1740,9 @@ static int hisi_sas_I_T_nexus_reset(struct domain_device *device)
 	struct device *dev = hisi_hba->dev;
 	int rc;
 
+	if (sas_dev->dev_status == HISI_SAS_DEV_NCQ_ERR)
+		sas_dev->dev_status = HISI_SAS_DEV_NORMAL;
+
 	rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
 	if (rc < 0) {
 		dev_err(dev, "I_T nexus reset: internal abort (%d)\n", rc);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index d56b4bfd2767..0ae8a60aaf93 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -404,6 +404,11 @@
 #define CMPLT_HDR_CMPLT_MSK		(0x3 << CMPLT_HDR_CMPLT_OFF)
 #define CMPLT_HDR_ERROR_PHASE_OFF   2
 #define CMPLT_HDR_ERROR_PHASE_MSK   (0xff << CMPLT_HDR_ERROR_PHASE_OFF)
+/* bit[9:2] Error Phase */
+#define ERR_PHASE_RESPONSE_FRAME_REV_STAGE_OFF	\
+					8
+#define ERR_PHASE_RESPONSE_FRAME_REV_STAGE_MSK	\
+	(0x1 << ERR_PHASE_RESPONSE_FRAME_REV_STAGE_OFF)
 #define CMPLT_HDR_RSPNS_XFRD_OFF	10
 #define CMPLT_HDR_RSPNS_XFRD_MSK	(0x1 << CMPLT_HDR_RSPNS_XFRD_OFF)
 #define CMPLT_HDR_RSPNS_GOOD_OFF	11
@@ -423,8 +428,15 @@
 #define CMPLT_HDR_DEV_ID_OFF		16
 #define CMPLT_HDR_DEV_ID_MSK		(0xffff << CMPLT_HDR_DEV_ID_OFF)
 /* dw3 */
+#define CMPLT_HDR_SATA_DISK_ERR_OFF	16
+#define CMPLT_HDR_SATA_DISK_ERR_MSK	(0x1 << CMPLT_HDR_SATA_DISK_ERR_OFF)
 #define CMPLT_HDR_IO_IN_TARGET_OFF	17
 #define CMPLT_HDR_IO_IN_TARGET_MSK	(0x1 << CMPLT_HDR_IO_IN_TARGET_OFF)
+/* bit[23:18] ERR_FIS_ATA_STATUS */
+#define FIS_ATA_STATUS_ERR_OFF		18
+#define FIS_ATA_STATUS_ERR_MSK		(0x1 << FIS_ATA_STATUS_ERR_OFF)
+#define FIS_TYPE_SDB_OFF		31
+#define FIS_TYPE_SDB_MSK		(0x1 << FIS_TYPE_SDB_OFF)
 
 /* ITCT header */
 /* qw0 */
@@ -2148,6 +2160,18 @@ static irqreturn_t fatal_axi_int_v3_hw(int irq_no, void *p)
 	return IRQ_HANDLED;
 }
 
+static bool is_ncq_err_v3_hw(struct hisi_sas_complete_v3_hdr *complete_hdr)
+{
+	u32 dw0, dw3;
+
+	dw0 = le32_to_cpu(complete_hdr->dw0);
+	dw3 = le32_to_cpu(complete_hdr->dw3);
+
+	return (dw0 & ERR_PHASE_RESPONSE_FRAME_REV_STAGE_MSK) &&
+	       (dw3 & FIS_TYPE_SDB_MSK) &&
+	       (dw3 & FIS_ATA_STATUS_ERR_MSK);
+}
+
 static bool
 slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	       struct hisi_sas_slot *slot)
@@ -2381,14 +2405,34 @@ static irqreturn_t  cq_thread_v3_hw(int irq_no, void *p)
 	while (rd_point != wr_point) {
 		struct hisi_sas_complete_v3_hdr *complete_hdr;
 		struct device *dev = hisi_hba->dev;
-		u32 dw1;
+		u32 dw0, dw1, dw3;
 		int iptt;
 
 		complete_hdr = &complete_queue[rd_point];
+		dw0 = le32_to_cpu(complete_hdr->dw0);
 		dw1 = le32_to_cpu(complete_hdr->dw1);
+		dw3 = le32_to_cpu(complete_hdr->dw3);
 
 		iptt = dw1 & CMPLT_HDR_IPTT_MSK;
-		if (likely(iptt < HISI_SAS_COMMAND_ENTRIES_V3_HW)) {
+		if (unlikely((dw0 & CMPLT_HDR_CMPLT_MSK) == 0x3) &&
+			     (dw3 & CMPLT_HDR_SATA_DISK_ERR_MSK)) {
+			int device_id = (dw1 & CMPLT_HDR_DEV_ID_MSK) >>
+					CMPLT_HDR_DEV_ID_OFF;
+			struct hisi_sas_itct *itct =
+				&hisi_hba->itct[device_id];
+			struct hisi_sas_device *sas_dev =
+				&hisi_hba->devices[device_id];
+			struct domain_device *device = sas_dev->sas_device;
+
+			dev_err(dev, "erroneous completion disk err dev id=%d sas_addr=0x%llx CQ hdr: 0x%x 0x%x 0x%x 0x%x\n",
+				device_id, itct->sas_addr, dw0, dw1,
+				complete_hdr->act, dw3);
+
+			if (is_ncq_err_v3_hw(complete_hdr))
+				sas_dev->dev_status = HISI_SAS_DEV_NCQ_ERR;
+
+			sas_ata_device_link_abort(device, true);
+		} else if (likely(iptt < HISI_SAS_COMMAND_ENTRIES_V3_HW)) {
 			slot = &hisi_hba->slot_info[iptt];
 			slot->cmplt_queue_slot = rd_point;
 			slot->cmplt_queue = queue;
-- 
2.35.3

