Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69AB60C993
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiJYKLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiJYKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:10:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FE3112ABB;
        Tue, 25 Oct 2022 03:03:21 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxS906YwQz67ZwS;
        Tue, 25 Oct 2022 17:59:48 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:03:19 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:03:15 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 1/7] ata: libata-scsi: Add ata_scsi_queue_internal()
Date:   Tue, 25 Oct 2022 18:32:50 +0800
Message-ID: <1666693976-181094-2-git-send-email-john.garry@huawei.com>
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

Add a function to handle queued ATA internal SCSI cmnds - does much the
same as ata_exec_internal_sg() does (which will be fixed up later to
actually queue internal cmnds through this function).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-sata.c |  3 +++
 drivers/ata/libata-scsi.c | 43 +++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata.h      |  3 ++-
 include/linux/libata.h    |  6 ++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index b6806d41a8c5..e8b828c56542 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1258,6 +1258,9 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 {
 	int rc = 0;
 
+	if (blk_mq_is_reserved_rq(scsi_cmd_to_rq(cmd)))
+		return ata_scsi_queue_internal(cmd, ap->link.device);
+
 	if (likely(ata_dev_enabled(ap->link.device)))
 		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
 	else {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 476e0ef4bd29..30d7c90b0c35 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3965,6 +3965,49 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 	return NULL;
 }
 
+unsigned int ata_scsi_queue_internal(struct scsi_cmnd *scmd,
+				     struct ata_device *dev)
+{
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
+	struct ata_queued_cmd *qc;
+
+	/* no internal command while frozen */
+	if (ap->pflags & ATA_PFLAG_FROZEN)
+		goto did_err;
+
+	/* initialize internal qc */
+	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
+	link->preempted_tag = link->active_tag;
+	link->preempted_sactive = link->sactive;
+	ap->preempted_qc_active = ap->qc_active;
+	ap->preempted_nr_active_links = ap->nr_active_links;
+	link->active_tag = ATA_TAG_POISON;
+	link->sactive = 0;
+	ap->qc_active = 0;
+	ap->nr_active_links = 0;
+
+	if (qc->dma_dir != DMA_NONE) {
+		int n_elem;
+
+		n_elem = 1;
+		qc->n_elem = n_elem;
+		qc->sg = scsi_sglist(scmd);
+		qc->nbytes = qc->sg->length;
+		ata_sg_init(qc, qc->sg, n_elem);
+	}
+
+	scmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
+
+	ata_qc_issue(qc);
+
+	return 0;
+did_err:
+	scmd->result = (DID_ERROR << 16);
+	scsi_done(scmd);
+	return 0;
+}
+
 int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 {
 	u8 scsi_op = scmd->cmnd[0];
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0c2df1e60768..15cd1cd618b8 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -82,7 +82,6 @@ extern int ata_port_probe(struct ata_port *ap);
 extern void __ata_port_probe(struct ata_port *ap);
 extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 				      u8 page, void *buf, unsigned int sectors);
-
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
 /* libata-acpi.c */
@@ -130,6 +129,8 @@ extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 void ata_scsi_sdev_config(struct scsi_device *sdev);
 int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev);
 int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
+unsigned int ata_scsi_queue_internal(struct scsi_cmnd *scmd,
+				     struct ata_device *dev);
 
 /* libata-eh.c */
 extern unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 827d5838cd23..8938b584520f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -764,7 +764,9 @@ struct ata_link {
 
 	struct device		tdev;
 	unsigned int		active_tag;	/* active tag on this link */
+	unsigned int		preempted_tag;
 	u32			sactive;	/* active NCQ commands */
+	u32			preempted_sactive;
 
 	unsigned int		flags;		/* ATA_LFLAG_xxx */
 
@@ -857,6 +859,10 @@ struct ata_port {
 #ifdef CONFIG_ATA_ACPI
 	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
+
+	u64 preempted_qc_active;
+	int preempted_nr_active_links;
+
 	/* owned by EH */
 	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
 };
-- 
2.35.3

