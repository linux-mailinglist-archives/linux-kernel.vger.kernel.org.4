Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F303860C99F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiJYKLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiJYKKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:10:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F385122BF8;
        Tue, 25 Oct 2022 03:03:35 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxSCm4KSQz67mY4;
        Tue, 25 Oct 2022 18:02:12 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:03:33 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:03:30 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 5/7] ata: libata: Queue ATA internal commands as requests
Date:   Tue, 25 Oct 2022 18:32:54 +0800
Message-ID: <1666693976-181094-6-git-send-email-john.garry@huawei.com>
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

Follow the normal path for requests and queue through the block layer.

Since we now have a scsi_cmnd for every ATA queued command, we can delete
ata_port.qcmd[]. The ATA queue command iterators are fixed to use the
blk-mq tagset iters.

For libsas it's hard to differentiate between a reserved request which
is a libata internal command and SATA "tmf". Normally we can use the
sas_task "is dev sata" check, but that does not work. For now just check
the rq->end_io pointer.

At this point all libsas sas_task should have a rq associated, so let's
WARN just in case.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-core.c           | 141 +++++++++++++++-------------
 drivers/ata/libata-eh.c             |  11 ++-
 drivers/ata/libata-sata.c           |   2 +-
 drivers/ata/libata-scsi.c           |   5 +-
 drivers/scsi/libsas/sas_scsi_host.c |  15 ++-
 include/linux/libata.h              |  48 +++++++++-
 include/scsi/libsas.h               |   8 +-
 7 files changed, 151 insertions(+), 79 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d3ce5c383f3a..72bb1b629264 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1440,9 +1440,21 @@ EXPORT_SYMBOL_GPL(ata_id_xfermask);
 
 static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 {
-	struct completion *waiting = qc->private_data;
+	struct scsi_cmnd *scmd = qc->scsicmd;
+
+	scsi_done(scmd);
+}
+
+static enum rq_end_io_ret ata_internal_end_rq(struct request *rq,
+					       blk_status_t error)
+{
+	struct completion *waiting = rq->end_io_data;
+
+	rq->end_io_data = (void *)(uintptr_t)error;
 
 	complete(waiting);
+
+	return RQ_END_IO_NONE;
 }
 
 /**
@@ -1450,9 +1462,9 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
  *	@dev: Device to which the command is sent
  *	@tf: Taskfile registers for the command and the result
  *	@cdb: CDB for packet command
+ *	@buf: Data buffer of the command
+ *	@buflen: Length of data buffer
  *	@dma_dir: Data transfer direction of the command
- *	@sgl: sg list for the data buffer of the command
- *	@n_elem: Number of sg entries
  *	@timeout: Timeout in msecs (0 for default)
  *
  *	Executes libata internal command with timeout.  @tf contains
@@ -1469,50 +1481,65 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
  */
 static unsigned ata_exec_internal_sg(struct ata_device *dev,
 				     struct ata_taskfile *tf, const u8 *cdb,
-				     int dma_dir, struct scatterlist *sgl,
-				     unsigned int n_elem, unsigned int timeout)
+				     int dma_dir, void *buf,
+				     unsigned int buflen, unsigned int timeout)
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
+	struct scsi_device *sdev = dev->sdev;
 	u8 command = tf->command;
 	int auto_timeout = 0;
 	struct ata_queued_cmd *qc;
-	unsigned int preempted_tag;
-	u32 preempted_sactive;
-	u64 preempted_qc_active;
-	int preempted_nr_active_links;
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long flags;
 	unsigned int err_mask;
-	int rc;
+	struct scsi_cmnd *scmd;
+	struct request *rq;
 
-	spin_lock_irqsave(ap->lock, flags);
+	if (!sdev)
+		return AC_ERR_OTHER;
 
-	/* no internal command while frozen */
-	if (ap->pflags & ATA_PFLAG_FROZEN) {
-		spin_unlock_irqrestore(ap->lock, flags);
-		return AC_ERR_SYSTEM;
+	rq = scsi_alloc_request(sdev->request_queue,
+			dma_dir == DMA_TO_DEVICE ?
+			REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
+			BLK_MQ_REQ_RESERVED);
+	if (IS_ERR(rq))
+		return AC_ERR_OTHER;
+
+
+	if (!timeout) {
+		if (ata_probe_timeout)
+			timeout = ata_probe_timeout * 1000;
+		else {
+			timeout = ata_internal_cmd_timeout(dev, command);
+			auto_timeout = 1;
+		}
 	}
 
-	/* initialize internal qc */
-	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
+	scmd = blk_mq_rq_to_pdu(rq);
+	scmd->allowed = 0;
+	rq->timeout = msecs_to_jiffies(timeout);
+	rq->rq_flags |= RQF_QUIET;
+	scmd->device = sdev;
+
+	qc = ata_scmd_to_qc(scmd);
+
+	if (buflen) {
+		int ret = blk_rq_map_kern(sdev->request_queue, rq,
+					  buf, buflen, GFP_NOIO);
+		if (ret) {
+			blk_mq_free_request(rq);
+			return AC_ERR_OTHER;
+		}
+	}
 
 	qc->tag = ATA_TAG_INTERNAL;
 	qc->hw_tag = 0;
-	qc->scsicmd = NULL;
+	qc->scsicmd = scmd;
 	qc->ap = ap;
 	qc->dev = dev;
 	ata_qc_reinit(qc);
 
-	preempted_tag = link->active_tag;
-	preempted_sactive = link->sactive;
-	preempted_qc_active = ap->qc_active;
-	preempted_nr_active_links = ap->nr_active_links;
-	link->active_tag = ATA_TAG_POISON;
-	link->sactive = 0;
-	ap->qc_active = 0;
-	ap->nr_active_links = 0;
-
 	/* prepare & issue qc */
 	qc->tf = *tf;
 	if (cdb)
@@ -1525,44 +1552,26 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
 	qc->dma_dir = dma_dir;
-	if (dma_dir != DMA_NONE) {
-		unsigned int i, buflen = 0;
-		struct scatterlist *sg;
-
-		for_each_sg(sgl, sg, n_elem, i)
-			buflen += sg->length;
 
-		ata_sg_init(qc, sgl, n_elem);
-		qc->nbytes = buflen;
-	}
-
-	qc->private_data = &wait;
+	qc->private_data = ap;
 	qc->complete_fn = ata_qc_complete_internal;
 
-	ata_qc_issue(qc);
+	rq->end_io_data = &wait;
+	rq->end_io = ata_internal_end_rq;
 
-	spin_unlock_irqrestore(ap->lock, flags);
-
-	if (!timeout) {
-		if (ata_probe_timeout)
-			timeout = ata_probe_timeout * 1000;
-		else {
-			timeout = ata_internal_cmd_timeout(dev, command);
-			auto_timeout = 1;
-		}
-	}
+	blk_execute_rq_nowait(rq, true);
 
 	if (ap->ops->error_handler)
 		ata_eh_release(ap);
 
-	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
+	wait_for_completion(&wait);
 
 	if (ap->ops->error_handler)
 		ata_eh_acquire(ap);
 
 	ata_sff_flush_pio_task(ap);
 
-	if (!rc) {
+	if (rq->rq_flags & RQF_TIMED_OUT) {
 		spin_lock_irqsave(ap->lock, flags);
 
 		/* We're racing with irq here.  If we lose, the
@@ -1610,13 +1619,15 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 	err_mask = qc->err_mask;
 
 	ata_qc_free(qc);
-	link->active_tag = preempted_tag;
-	link->sactive = preempted_sactive;
-	ap->qc_active = preempted_qc_active;
-	ap->nr_active_links = preempted_nr_active_links;
+	link->active_tag = link->preempted_tag;
+	link->sactive = link->preempted_sactive;
+	ap->qc_active = ap->preempted_qc_active;
+	ap->nr_active_links = ap->preempted_nr_active_links;
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
+	blk_mq_free_request(rq);
+
 	if ((err_mask & AC_ERR_TIMEOUT) && auto_timeout)
 		ata_internal_cmd_timed_out(dev, command);
 
@@ -1647,18 +1658,20 @@ unsigned ata_exec_internal(struct ata_device *dev,
 			   int dma_dir, void *buf, unsigned int buflen,
 			   unsigned int timeout)
 {
-	struct scatterlist *psg = NULL, sg;
-	unsigned int n_elem = 0;
+	/* buf may not be aligned, so copy to/from an aligned buffer */
+	void *tmpbuf = kmemdup(buf, buflen, GFP_KERNEL);
+	unsigned res;
 
-	if (dma_dir != DMA_NONE) {
-		WARN_ON(!buf);
-		sg_init_one(&sg, buf, buflen);
-		psg = &sg;
-		n_elem++;
-	}
+	if (!tmpbuf)
+		return AC_ERR_OTHER;
 
-	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem,
+	res = ata_exec_internal_sg(dev, tf, cdb, dma_dir, tmpbuf, buflen,
 				    timeout);
+
+	memcpy(buf, tmpbuf, buflen);
+	kfree(tmpbuf);
+
+	return res;
 }
 
 /**
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1ed5b1b64792..f25f60dff5a2 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -604,6 +604,9 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 			struct ata_queued_cmd *qc;
 
 			ata_qc_for_each_raw(ap, qc, i) {
+				if (!qc)
+					continue;
+
 				if (qc->flags & ATA_QCFLAG_ACTIVE &&
 				    qc->scsicmd == scmd)
 					break;
@@ -1946,7 +1949,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	all_err_mask |= ehc->i.err_mask;
 
 	ata_qc_for_each_raw(ap, qc, tag) {
-		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
+		if (!qc || (qc->flags & ATA_QCFLAG_FAILED) ||
 		    ata_dev_phys_link(qc->dev) != link)
 			continue;
 
@@ -2223,7 +2226,7 @@ static void ata_eh_link_report(struct ata_link *link)
 		desc = ehc->i.desc;
 
 	ata_qc_for_each_raw(ap, qc, tag) {
-		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
+		if (!qc || !(qc->flags & ATA_QCFLAG_FAILED) ||
 		    ata_dev_phys_link(qc->dev) != link ||
 		    ((qc->flags & ATA_QCFLAG_QUIET) &&
 		     qc->err_mask == AC_ERR_DEV))
@@ -2289,7 +2292,7 @@ static void ata_eh_link_report(struct ata_link *link)
 		char data_buf[20] = "";
 		char cdb_buf[70] = "";
 
-		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
+		if (!qc || !(qc->flags & ATA_QCFLAG_FAILED) ||
 		    ata_dev_phys_link(qc->dev) != link || !qc->err_mask)
 			continue;
 
@@ -3795,7 +3798,7 @@ void ata_eh_finish(struct ata_port *ap)
 
 	/* retry or finish qcs */
 	ata_qc_for_each_raw(ap, qc, tag) {
-		if (!(qc->flags & ATA_QCFLAG_FAILED))
+		if (!qc || !(qc->flags & ATA_QCFLAG_FAILED))
 			continue;
 
 		if (qc->err_mask) {
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index e8b828c56542..f03feccb22df 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1432,7 +1432,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 
 	/* has LLDD analyzed already? */
 	ata_qc_for_each_raw(ap, qc, tag) {
-		if (!(qc->flags & ATA_QCFLAG_FAILED))
+		if (!qc || !(qc->flags & ATA_QCFLAG_FAILED))
 			continue;
 
 		if (qc->err_mask)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index cbf266c9d4c2..64c6ab33cdc8 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -657,7 +657,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
 		tag = scsi_cmd_to_rq(cmd)->tag;
 	}
 
-	qc = __ata_qc_from_tag(ap, tag);
+	qc = ata_scmd_to_qc(cmd);
 	qc->tag = qc->hw_tag = tag;
 	qc->ap = ap;
 	qc->dev = dev;
@@ -4007,7 +4007,8 @@ unsigned int ata_scsi_queue_internal(struct scsi_cmnd *scmd,
 		goto did_err;
 
 	/* initialize internal qc */
-	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
+	qc = ata_scmd_to_qc(scmd);
+	qc->scsicmd = scmd;
 	link->preempted_tag = link->active_tag;
 	link->preempted_sactive = link->sactive;
 	ap->preempted_qc_active = ap->qc_active;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 9d2122e65fba..008f57931a57 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -163,8 +163,21 @@ int sas_queuecommand_internal(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	struct sas_ha_struct *ha = SHOST_TO_SAS_HA(shost);
 	struct sas_internal *i = to_sas_internal(ha->core.shost->transportt);
 	struct request *rq = blk_mq_rq_from_pdu(cmnd);
-	struct sas_task *task = rq->end_io_data;
+	struct sas_task *task;
+
+	/* uh, I can't see a better check for now */
+	if (rq->end_io != sas_blk_end_sync_rq) {
+		struct ata_queued_cmd *qc = ata_scmd_to_qc(cmnd);
+		struct ata_port *ap = qc->ap;
+		int res;
+
+		spin_lock_irq(ap->lock);
+		res = ata_sas_queuecmd(cmnd, ap);
+		spin_unlock_irq(ap->lock);
+		return res;
+	}
 
+	task = rq->end_io_data;
 	ASSIGN_SAS_TASK(cmnd, task);
 
 	return i->dft->lldd_execute_task(task, GFP_KERNEL);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d5a15d1a5c4d..613a8b644306 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -19,6 +19,7 @@
 #include <linux/ata.h>
 #include <linux/workqueue.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
 #include <linux/acpi.h>
 #include <linux/cdrom.h>
 #include <linux/sched.h>
@@ -818,7 +819,6 @@ struct ata_port {
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 
-	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE + 1];
 	u64			qc_active;
 	int			nr_active_links; /* #links with active qcs */
 
@@ -1398,6 +1398,7 @@ extern const struct attribute_group *ata_common_sdev_groups[];
 	.max_sectors		= ATA_MAX_SECTORS_LBA48,\
 	.reserved_queuecommand = ata_internal_queuecommand,\
 	.cmd_size = sizeof(struct ata_queued_cmd),\
+	.nr_reserved_cmds = 1,\
 	.reserved_timedout = ata_internal_timeout,\
 	.init_cmd_priv = ata_init_cmd_priv
 
@@ -1750,11 +1751,52 @@ static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
 	qc->tf.ctl |= ATA_NIEN;
 }
 
+static inline struct ata_queued_cmd *ata_scmd_to_qc(struct scsi_cmnd *scmd)
+{
+	return (struct ata_queued_cmd *)(scmd + 1);
+}
+
+struct ata_iter_data {
+	unsigned int tag;
+	struct ata_queued_cmd **qc;
+};
+
+static inline bool ata_check_qc_inflight(struct request *rq, void *priv)
+{
+	struct ata_iter_data *data = priv;
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
+	struct ata_queued_cmd *qc =  ata_scmd_to_qc(scmd);
+
+	if (qc->tag == data->tag) {
+		*(data->qc) = qc;
+		return false;
+	}
+
+	return true;
+}
+
 static inline struct ata_queued_cmd *__ata_qc_from_tag(struct ata_port *ap,
 						       unsigned int tag)
 {
-	if (ata_tag_valid(tag))
-		return &ap->qcmd[tag];
+	struct ata_link *link;
+	struct Scsi_Host *shost = ap->scsi_host;
+
+	ata_for_each_link(link, ap, EDGE) {
+		struct ata_device *dev;
+
+		ata_for_each_dev(dev, link, ALL) {
+			struct ata_queued_cmd *qc = NULL;
+			struct ata_iter_data data = {
+				.tag = tag,
+				.qc = &qc,
+			};
+			blk_mq_tagset_busy_iter(&shost->tag_set,
+						 ata_check_qc_inflight, &data);
+			if (qc)
+				return qc;
+		}
+	}
+
 	return NULL;
 }
 
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index f903be5895a9..0272116d73fc 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -644,15 +644,15 @@ static inline struct request *sas_task_find_rq(struct sas_task *task)
 {
 	struct scsi_cmnd *scmd;
 
-	if (!task->slow_task && task->task_proto & SAS_PROTOCOL_STP_ALL) {
+	if (task->slow_task || !(task->task_proto & SAS_PROTOCOL_STP_ALL)) {
+		scmd = task->uldd_task;
+	} else {
 		struct ata_queued_cmd *qc = task->uldd_task;
 
 		scmd = qc ? qc->scsicmd : NULL;
-	} else {
-		scmd = task->uldd_task;
 	}
 
-	if (!scmd)
+	if (WARN_ON_ONCE(!scmd))
 		return NULL;
 
 	return scsi_cmd_to_rq(scmd);
-- 
2.35.3

