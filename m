Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26061600922
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJQIut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJQIu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:50:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ACA30F58;
        Mon, 17 Oct 2022 01:50:24 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MrVzS4qJ0z6HJYt;
        Mon, 17 Oct 2022 16:49:24 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 10:50:23 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:50:20 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <niklas.cassel@wdc.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v6 4/8] scsi: hisi_sas: Modify v3 HW SATA disk error state completion processing
Date:   Mon, 17 Oct 2022 17:20:31 +0800
Message-ID: <1665998435-199946-5-git-send-email-john.garry@huawei.com>
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

When an NCQ error occurs, the  controller will abnormally complete the I/Os
that are newly delivered to disk, and bit8 in CQ dw3 will be set which
indicates that the SATA disk is in error state. The current processing flow
is to set ts->stat to SAS_OPEN_REJECT and then sas_ata_task_done() will
set FIS stat to ATA_ERR. After analyzing the IO by ata_eh_analyze_tf(),
err_mask will set to AC_ERR_HSM. If media error occurs for four times
within 10 minutes and the chip rejects new I/Os for four times, NCQ will
be disabled due to excessive errors, which is undesirable.

Therefore, use sas_task_abort() to handle abnormally completed I/Os when
SATA disk is in error state, as these abnormally completed I/Os are already
processed by sas_ata_device_link_abort() and qc->flag are set to
ATA_QCFLAG_FAILED. If sas_task_abort() is used, qc->err_mask will not be
modified in EH. Unlike the current process flow, it will not increase
the count of ECAT_TOUT_HSM and not turn off NCQ. Like other I/Os on the
disk that do not have an error but do not return after the NCQ error, they
are retried after the EH.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 0ae8a60aaf93..0c3fcb807806 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -428,6 +428,8 @@
 #define CMPLT_HDR_DEV_ID_OFF		16
 #define CMPLT_HDR_DEV_ID_MSK		(0xffff << CMPLT_HDR_DEV_ID_OFF)
 /* dw3 */
+#define SATA_DISK_IN_ERROR_STATUS_OFF	8
+#define SATA_DISK_IN_ERROR_STATUS_MSK	(0x1 << SATA_DISK_IN_ERROR_STATUS_OFF)
 #define CMPLT_HDR_SATA_DISK_ERR_OFF	16
 #define CMPLT_HDR_SATA_DISK_ERR_MSK	(0x1 << CMPLT_HDR_SATA_DISK_ERR_OFF)
 #define CMPLT_HDR_IO_IN_TARGET_OFF	17
@@ -2219,7 +2221,8 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 		} else if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
 			ts->residual = trans_tx_fail_type;
 			ts->stat = SAS_DATA_UNDERRUN;
-		} else if (dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) {
+		} else if ((dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) ||
+			   (dw3 & SATA_DISK_IN_ERROR_STATUS_MSK)) {
 			ts->stat = SAS_PHY_DOWN;
 			slot->abort = 1;
 		} else {
-- 
2.35.3

