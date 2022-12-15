Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D1D64DDEC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiLOPiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLOPiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:38:12 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A6223169;
        Thu, 15 Dec 2022 07:38:10 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NXx8s590fzqT8c;
        Thu, 15 Dec 2022 23:33:49 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 15 Dec 2022 23:38:08 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH v3] ata: libata-eh: Cleanup ata_scsi_cmd_error_handler()
Date:   Thu, 15 Dec 2022 23:37:49 +0800
Message-ID: <20221215153749.1947570-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ap->ops->error_handler is NULL just return. This patch also
fixes some comment style issue.

---
v3:
- Start with a "/*" empty line for multi-line comments.
- Correct the commit subject

v2:
- Check ap->ops->error_handler without taking the spin lock

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/ata/libata-eh.c | 101 +++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 49 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 34303ce67c14..56820b8e953a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -565,13 +565,19 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 {
 	int i;
 	unsigned long flags;
+	struct scsi_cmnd *scmd, *tmp;
+	int nr_timedout = 0;
 
 	/* make sure sff pio task is not running */
 	ata_sff_flush_pio_task(ap);
 
+	if (!ap->ops->error_handler)
+		return;
+
 	/* synchronize with host lock and sort out timeouts */
 
-	/* For new EH, all qcs are finished in one of three ways -
+	/*
+	 * For new EH, all qcs are finished in one of three ways -
 	 * normal completion, error completion, and SCSI timeout.
 	 * Both completions can race against SCSI timeout.  When normal
 	 * completion wins, the qc never reaches EH.  When error
@@ -584,62 +590,59 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 	 * timed out iff its associated qc is active and not failed.
 	 */
 	spin_lock_irqsave(ap->lock, flags);
-	if (ap->ops->error_handler) {
-		struct scsi_cmnd *scmd, *tmp;
-		int nr_timedout = 0;
-
-		/* This must occur under the ap->lock as we don't want
-		   a polled recovery to race the real interrupt handler
-
-		   The lost_interrupt handler checks for any completed but
-		   non-notified command and completes much like an IRQ handler.
 
-		   We then fall into the error recovery code which will treat
-		   this as if normal completion won the race */
-
-		if (ap->ops->lost_interrupt)
-			ap->ops->lost_interrupt(ap);
+	/*
+	 * This must occur under the ap->lock as we don't want
+	 * a polled recovery to race the real interrupt handler
+	 *
+	 * The lost_interrupt handler checks for any completed but
+	 * non-notified command and completes much like an IRQ handler.
+	 *
+	 * We then fall into the error recovery code which will treat
+	 * this as if normal completion won the race
+	 */
+	if (ap->ops->lost_interrupt)
+		ap->ops->lost_interrupt(ap);
 
-		list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
-			struct ata_queued_cmd *qc;
+	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
+		struct ata_queued_cmd *qc;
 
-			ata_qc_for_each_raw(ap, qc, i) {
-				if (qc->flags & ATA_QCFLAG_ACTIVE &&
-				    qc->scsicmd == scmd)
-					break;
-			}
+		ata_qc_for_each_raw(ap, qc, i) {
+			if (qc->flags & ATA_QCFLAG_ACTIVE &&
+			    qc->scsicmd == scmd)
+				break;
+		}
 
-			if (i < ATA_MAX_QUEUE) {
-				/* the scmd has an associated qc */
-				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
-					/* which hasn't failed yet, timeout */
-					qc->err_mask |= AC_ERR_TIMEOUT;
-					qc->flags |= ATA_QCFLAG_FAILED;
-					nr_timedout++;
-				}
-			} else {
-				/* Normal completion occurred after
-				 * SCSI timeout but before this point.
-				 * Successfully complete it.
-				 */
-				scmd->retries = scmd->allowed;
-				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
+		if (i < ATA_MAX_QUEUE) {
+			/* the scmd has an associated qc */
+			if (!(qc->flags & ATA_QCFLAG_FAILED)) {
+				/* which hasn't failed yet, timeout */
+				qc->err_mask |= AC_ERR_TIMEOUT;
+				qc->flags |= ATA_QCFLAG_FAILED;
+				nr_timedout++;
 			}
+		} else {
+			/* Normal completion occurred after
+			 * SCSI timeout but before this point.
+			 * Successfully complete it.
+			 */
+			scmd->retries = scmd->allowed;
+			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
 		}
+	}
 
-		/* If we have timed out qcs.  They belong to EH from
-		 * this point but the state of the controller is
-		 * unknown.  Freeze the port to make sure the IRQ
-		 * handler doesn't diddle with those qcs.  This must
-		 * be done atomically w.r.t. setting QCFLAG_FAILED.
-		 */
-		if (nr_timedout)
-			__ata_port_freeze(ap);
-
+	/*
+	 * If we have timed out qcs.  They belong to EH from
+	 * this point but the state of the controller is
+	 * unknown.  Freeze the port to make sure the IRQ
+	 * handler doesn't diddle with those qcs.  This must
+	 * be done atomically w.r.t. setting QCFLAG_FAILED.
+	 */
+	if (nr_timedout)
+		__ata_port_freeze(ap);
 
-		/* initialize eh_tries */
-		ap->eh_tries = ATA_EH_MAX_TRIES;
-	}
+	/* initialize eh_tries */
+	ap->eh_tries = ATA_EH_MAX_TRIES;
 	spin_unlock_irqrestore(ap->lock, flags);
 
 }
-- 
2.32.0

