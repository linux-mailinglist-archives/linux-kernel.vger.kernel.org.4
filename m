Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A91F734671
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 15:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjFRNmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 09:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFRNmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 09:42:47 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A86199;
        Sun, 18 Jun 2023 06:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687095763;
        bh=3P+wpp554brGc4Qb4/TnpmeCSeOk5BPM3FEL2t33Kj0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=BtKqd84dURcGkH0v3k4XKAqeQoLUBBzPm9ereuU3Oyt9dUxifQKjYLWsPMRt4MVzR
         rwIx9ZaBgEvv5Wx2h8UzqkaFwgm7VmWqRsgrI/WsglkV7wuWnyHWVIWaWjPMx4wb7M
         fo+0UIx3Usdi7YDf+ZI7pVOqvcY4QEaK7XZuzVzo=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0ED7E1280712;
        Sun, 18 Jun 2023 09:42:43 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id WxGJA1TxXSzF; Sun, 18 Jun 2023 09:42:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687095762;
        bh=3P+wpp554brGc4Qb4/TnpmeCSeOk5BPM3FEL2t33Kj0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Dx1NM61+kybSWbK6zHn2dGWmT2nQWlVKV1C/nDKx7Yaj0ZkXiRuVr1De+pN2pKjfj
         6rFuCVDIPviai/psRvKp2WRIm929Z7VxrTxR+v5TfKUWpM45pfBeXie2AsYNfJz5DU
         WVqqOMY5VAFSYinpNi20Sb3GbwCgkx19U54p3GYw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D0CC0128039F;
        Sun, 18 Jun 2023 09:42:41 -0400 (EDT)
Message-ID: <cdad87164ce2f62fabccad0b4f6c11a7e8e2914e.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.4-rc6
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 18 Jun 2023 09:42:40 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Four fixes, all in drivers: three fairly obvious small ones and a large
one in aacraid to add block queue completion mapping and fix a CPU
offline hang.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Bob Pearson (1):
      scsi: target: core: Fix error path in target_setup_session()

Justin Tee (1):
      scsi: lpfc: Fix incorrect big endian type assignment in bsg loopback path

Michael Kelley (1):
      scsi: storvsc: Always set no_report_opcodes

Sagar Biradar (1):
      scsi: aacraid: Reply queue mapping to CPUs based on IRQ affinity

And the diffstat:

 drivers/scsi/aacraid/aacraid.h         |  1 +
 drivers/scsi/aacraid/commsup.c         |  6 +++++-
 drivers/scsi/aacraid/linit.c           | 14 ++++++++++++++
 drivers/scsi/aacraid/src.c             | 25 +++++++++++++++++++++++--
 drivers/scsi/lpfc/lpfc_bsg.c           |  8 ++++----
 drivers/scsi/storvsc_drv.c             |  2 ++
 drivers/target/target_core_transport.c |  2 ++
 7 files changed, 51 insertions(+), 7 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 5e115e8b2ba4..7c6efde75da6 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1678,6 +1678,7 @@ struct aac_dev
 	u32			handle_pci_error;
 	bool			init_reset;
 	u8			soft_reset_support;
+	u8			use_map_queue;
 };
 
 #define aac_adapter_interrupt(dev) \
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index deb32c9f4b3e..3f062e4013ab 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -223,8 +223,12 @@ int aac_fib_setup(struct aac_dev * dev)
 struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd)
 {
 	struct fib *fibptr;
+	u32 blk_tag;
+	int i;
 
-	fibptr = &dev->fibs[scsi_cmd_to_rq(scmd)->tag];
+	blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
+	i = blk_mq_unique_tag_to_tag(blk_tag);
+	fibptr = &dev->fibs[i];
 	/*
 	 *	Null out fields that depend on being zero at the start of
 	 *	each I/O
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 68f4dbcfff49..c4a36c0be527 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -19,6 +19,7 @@
 
 #include <linux/compat.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq-pci.h>
 #include <linux/completion.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -504,6 +505,15 @@ static int aac_slave_configure(struct scsi_device *sdev)
 	return 0;
 }
 
+static void aac_map_queues(struct Scsi_Host *shost)
+{
+	struct aac_dev *aac = (struct aac_dev *)shost->hostdata;
+
+	blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+			      aac->pdev, 0);
+	aac->use_map_queue = true;
+}
+
 /**
  *	aac_change_queue_depth		-	alter queue depths
  *	@sdev:	SCSI device we are considering
@@ -1488,6 +1498,7 @@ static const struct scsi_host_template aac_driver_template = {
 	.bios_param			= aac_biosparm,
 	.shost_groups			= aac_host_groups,
 	.slave_configure		= aac_slave_configure,
+	.map_queues			= aac_map_queues,
 	.change_queue_depth		= aac_change_queue_depth,
 	.sdev_groups			= aac_dev_groups,
 	.eh_abort_handler		= aac_eh_abort,
@@ -1775,6 +1786,8 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->max_lun = AAC_MAX_LUN;
 
 	pci_set_drvdata(pdev, shost);
+	shost->nr_hw_queues = aac->max_msix;
+	shost->host_tagset = 1;
 
 	error = scsi_add_host(shost, &pdev->dev);
 	if (error)
@@ -1906,6 +1919,7 @@ static void aac_remove_one(struct pci_dev *pdev)
 	struct aac_dev *aac = (struct aac_dev *)shost->hostdata;
 
 	aac_cancel_rescan_worker(aac);
+	aac->use_map_queue = false;
 	scsi_remove_host(shost);
 
 	__aac_shutdown(aac);
diff --git a/drivers/scsi/aacraid/src.c b/drivers/scsi/aacraid/src.c
index 11ef58204e96..61949f374188 100644
--- a/drivers/scsi/aacraid/src.c
+++ b/drivers/scsi/aacraid/src.c
@@ -493,6 +493,10 @@ static int aac_src_deliver_message(struct fib *fib)
 #endif
 
 	u16 vector_no;
+	struct scsi_cmnd *scmd;
+	u32 blk_tag;
+	struct Scsi_Host *shost = dev->scsi_host_ptr;
+	struct blk_mq_queue_map *qmap;
 
 	atomic_inc(&q->numpending);
 
@@ -505,8 +509,25 @@ static int aac_src_deliver_message(struct fib *fib)
 		if ((dev->comm_interface == AAC_COMM_MESSAGE_TYPE3)
 			&& dev->sa_firmware)
 			vector_no = aac_get_vector(dev);
-		else
-			vector_no = fib->vector_no;
+		else {
+			if (!fib->vector_no || !fib->callback_data) {
+				if (shost && dev->use_map_queue) {
+					qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+					vector_no = qmap->mq_map[raw_smp_processor_id()];
+				}
+				/*
+				 *	We hardcode the vector_no for
+				 *	reserved commands as a valid shost is
+				 *	absent during the init
+				 */
+				else
+					vector_no = 0;
+			} else {
+				scmd = (struct scsi_cmnd *)fib->callback_data;
+				blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
+				vector_no = blk_mq_unique_tag_to_hwq(blk_tag);
+			}
+		}
 
 		if (native_hba) {
 			if (fib->flags & FIB_CONTEXT_FLAG_NATIVE_HBA_TMF) {
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 9a322a3a2150..595dca92e8db 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -889,7 +889,7 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			struct lpfc_iocbq *piocbq)
 {
 	uint32_t evt_req_id = 0;
-	uint32_t cmd;
+	u16 cmd;
 	struct lpfc_dmabuf *dmabuf = NULL;
 	struct lpfc_bsg_event *evt;
 	struct event_data *evt_dat = NULL;
@@ -915,7 +915,7 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 	ct_req = (struct lpfc_sli_ct_request *)bdeBuf1->virt;
 	evt_req_id = ct_req->FsType;
-	cmd = ct_req->CommandResponse.bits.CmdRsp;
+	cmd = be16_to_cpu(ct_req->CommandResponse.bits.CmdRsp);
 
 	spin_lock_irqsave(&phba->ct_ev_lock, flags);
 	list_for_each_entry(evt, &phba->ct_ev_waiters, node) {
@@ -3186,8 +3186,8 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
 			ctreq->RevisionId.bits.InId = 0;
 			ctreq->FsType = SLI_CT_ELX_LOOPBACK;
 			ctreq->FsSubType = 0;
-			ctreq->CommandResponse.bits.CmdRsp = ELX_LOOPBACK_DATA;
-			ctreq->CommandResponse.bits.Size   = size;
+			ctreq->CommandResponse.bits.CmdRsp = cpu_to_be16(ELX_LOOPBACK_DATA);
+			ctreq->CommandResponse.bits.Size   = cpu_to_be16(size);
 			segment_offset = ELX_LOOPBACK_HEADER_SZ;
 		} else
 			segment_offset = 0;
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index e6bc622954cf..659196a2f63a 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1567,6 +1567,8 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 {
 	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
 
+	/* storvsc devices don't support MAINTENANCE_IN SCSI cmd */
+	sdevice->no_report_opcodes = 1;
 	sdevice->no_write_same = 1;
 
 	/*
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 86adff2a86ed..687adc9e086c 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -504,6 +504,8 @@ target_setup_session(struct se_portal_group *tpg,
 
 free_sess:
 	transport_free_session(sess);
+	return ERR_PTR(rc);
+
 free_cnt:
 	target_free_cmd_counter(cmd_cnt);
 	return ERR_PTR(rc);

