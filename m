Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332F3665D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbjAKOLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjAKOK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:10:58 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1C5E8A;
        Wed, 11 Jan 2023 06:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673446254;
        bh=Z6QWCskzxQAy5YA4YgclS6LLCZOsAgzACMWEKbzWI6I=;
        h=Message-ID:Subject:From:To:Date:From;
        b=YjpuXzaq0fb0K9UKhpEE8ne8NZ0VDH/s6qcVf/PNr8pBg3xQWa+Q1h7X6UijdDyp3
         N9KInqwPBgNOH5haw3WrSkbOWSQaCFmSqCg/v3wl1gzQWF5EmMqcvqk14aU1540/8v
         1H6d3Z4wKG+JPXI4ZPRPgVechosB6ia4VYe2x3b0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C49E41285FCF;
        Wed, 11 Jan 2023 09:10:54 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UYoWIV4Lr-bn; Wed, 11 Jan 2023 09:10:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673446253;
        bh=Z6QWCskzxQAy5YA4YgclS6LLCZOsAgzACMWEKbzWI6I=;
        h=Message-ID:Subject:From:To:Date:From;
        b=F13CaQWqc8xzXaMS9ANrXdf1KVIsjge+sIyd4nIdTkA+6fLM0C8fEvTnwCYhzafUF
         79Dq110AkB3CTLLW+hyu2yzJ7S4g8OpVex8OCRHt5ZKYnGEf46xNDwirOzh0Z9AorR
         OibjXDAYh+/MDm3cG1c/wrtiqgITB5RGVPMIR6bU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7F0861285F5F;
        Wed, 11 Jan 2023 09:10:53 -0500 (EST)
Message-ID: <255063201faa447278f005a52ef3c4cd22409cbd.camel@HansenPartnership.com>
Subject: [GIT PULL resend] SCSI fixes for 6.1-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Jan 2023 09:10:52 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10 small fixes (less the one that cleaned up a reverted removal), 9 in
drivers of which the ufs one is the most critical. The single core
patch is a minor speedup to error handling.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Hannes Reinecke (1):
      scsi: core: scsi_error: Do not queue pointless abort workqueue functions

Jason Yan (1):
      scsi: hisi_sas: Fix tag freeing for reserved tags

John Garry (1):
      scsi: scsi_debug: Delete unreachable code in inquiry_vpd_b0()

Michael Kelley (1):
      scsi: storvsc: Fix swiotlb bounce buffer leak in confidential VM

Peter Wang (1):
      scsi: ufs: core: WLUN suspend SSU/enter hibern8 fail recovery

Shin'ichiro Kawasaki (1):
      scsi: mpi3mr: Refer CONFIG_SCSI_MPI3MR in Makefile

Sreekanth Reddy (2):
      scsi: mpi3mr: Remove usage of dma_get_required_mask() API
      scsi: mpt3sas: Remove usage of dma_get_required_mask() API

Wenchao Hao (1):
      scsi: iscsi: Fix multiple iSCSI session unbind events sent to userspace

Xingui Yang (1):
      scsi: libsas: Grab the ATA port lock in sas_ata_device_link_abort()

And the diffstat:

 drivers/scsi/hisi_sas/hisi_sas_main.c |  2 +-
 drivers/scsi/libsas/sas_ata.c         |  3 +++
 drivers/scsi/mpi3mr/Makefile          |  2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c       |  3 +--
 drivers/scsi/mpt3sas/mpt3sas_base.c   |  3 +--
 drivers/scsi/scsi_debug.c             |  2 --
 drivers/scsi/scsi_error.c             |  5 ++++
 drivers/scsi/scsi_transport_iscsi.c   | 50 +++++++++++++++++++++++++++++++----
 drivers/scsi/storvsc_drv.c            |  3 +++
 drivers/ufs/core/ufshcd.c             | 26 ++++++++++++++++++
 include/scsi/scsi_transport_iscsi.h   |  9 +++++++
 11 files changed, 95 insertions(+), 13 deletions(-)

With full diff below.

James

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 41ba22f6c7f0..e9c2d306ed87 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -162,7 +162,7 @@ static void hisi_sas_slot_index_clear(struct hisi_hba *hisi_hba, int slot_idx)
 static void hisi_sas_slot_index_free(struct hisi_hba *hisi_hba, int slot_idx)
 {
 	if (hisi_hba->hw->slot_index_alloc ||
-	    slot_idx >= HISI_SAS_UNRESERVED_IPTT) {
+	    slot_idx < HISI_SAS_RESERVED_IPTT) {
 		spin_lock(&hisi_hba->lock);
 		hisi_sas_slot_index_clear(hisi_hba, slot_idx);
 		spin_unlock(&hisi_hba->lock);
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 1ccce706167a..5e80225b5308 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -889,7 +889,9 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
 {
 	struct ata_port *ap = device->sata_dev.ap;
 	struct ata_link *link = &ap->link;
+	unsigned long flags;
 
+	spin_lock_irqsave(ap->lock, flags);
 	device->sata_dev.fis[2] = ATA_ERR | ATA_DRDY; /* tf status */
 	device->sata_dev.fis[3] = ATA_ABORTED; /* tf error */
 
@@ -897,6 +899,7 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
 	if (force_reset)
 		link->eh_info.action |= ATA_EH_RESET;
 	ata_link_abort(link);
+	spin_unlock_irqrestore(ap->lock, flags);
 }
 EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
 
diff --git a/drivers/scsi/mpi3mr/Makefile b/drivers/scsi/mpi3mr/Makefile
index ef86ca46646b..3bf8cf34e1c3 100644
--- a/drivers/scsi/mpi3mr/Makefile
+++ b/drivers/scsi/mpi3mr/Makefile
@@ -1,5 +1,5 @@
 # mpi3mr makefile
-obj-m += mpi3mr.o
+obj-$(CONFIG_SCSI_MPI3MR) += mpi3mr.o
 mpi3mr-y +=  mpi3mr_os.o     \
 		mpi3mr_fw.o \
 		mpi3mr_app.o \
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 0c4aabaefdcc..286a44506578 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3633,8 +3633,7 @@ int mpi3mr_setup_resources(struct mpi3mr_ioc *mrioc)
 	int i, retval = 0, capb = 0;
 	u16 message_control;
 	u64 dma_mask = mrioc->dma_mask ? mrioc->dma_mask :
-	    (((dma_get_required_mask(&pdev->dev) > DMA_BIT_MASK(32)) &&
-	    (sizeof(dma_addr_t) > 4)) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
+	    ((sizeof(dma_addr_t) > 4) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
 
 	if (pci_enable_device_mem(pdev)) {
 		ioc_err(mrioc, "pci_enable_device_mem: failed\n");
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 4e981ccaac41..69061545d9d2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2992,8 +2992,7 @@ _base_config_dma_addressing(struct MPT3SAS_ADAPTER *ioc, struct pci_dev *pdev)
 	struct sysinfo s;
 	u64 coherent_dma_mask, dma_mask;
 
-	if (ioc->is_mcpu_endpoint || sizeof(dma_addr_t) == 4 ||
-	    dma_get_required_mask(&pdev->dev) <= DMA_BIT_MASK(32)) {
+	if (ioc->is_mcpu_endpoint || sizeof(dma_addr_t) == 4) {
 		ioc->dma_mask = 32;
 		coherent_dma_mask = dma_mask = DMA_BIT_MASK(32);
 	/* Set 63 bit DMA mask for all SAS3 and SAS35 controllers */
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index cc6953809a24..8553277effb3 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1511,8 +1511,6 @@ static int inquiry_vpd_b0(unsigned char *arr)
 	put_unaligned_be64(sdebug_write_same_length, &arr[32]);
 
 	return 0x3c; /* Mandatory page length for Logical Block Provisioning */
-
-	return sizeof(vpdb0_data);
 }
 
 /* Block device characteristics VPD page (SBC-3) */
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index a7960ad2d386..2aa2c2aee6e7 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -231,6 +231,11 @@ scsi_abort_command(struct scsi_cmnd *scmd)
 	struct Scsi_Host *shost = sdev->host;
 	unsigned long flags;
 
+	if (!shost->hostt->eh_abort_handler) {
+		/* No abort handler, fail command directly */
+		return FAILED;
+	}
+
 	if (scmd->eh_eflags & SCSI_EH_ABORT_SCHEDULED) {
 		/*
 		 * Retry after abort failed, escalate to next level.
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 13cfd3e317cc..b9b97300e3b3 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1677,6 +1677,13 @@ static const char *iscsi_session_state_name(int state)
 	return name;
 }
 
+static char *iscsi_session_target_state_name[] = {
+	[ISCSI_SESSION_TARGET_UNBOUND]   = "UNBOUND",
+	[ISCSI_SESSION_TARGET_ALLOCATED] = "ALLOCATED",
+	[ISCSI_SESSION_TARGET_SCANNED]   = "SCANNED",
+	[ISCSI_SESSION_TARGET_UNBINDING] = "UNBINDING",
+};
+
 int iscsi_session_chkready(struct iscsi_cls_session *session)
 {
 	int err;
@@ -1786,9 +1793,13 @@ static int iscsi_user_scan_session(struct device *dev, void *data)
 		if ((scan_data->channel == SCAN_WILD_CARD ||
 		     scan_data->channel == 0) &&
 		    (scan_data->id == SCAN_WILD_CARD ||
-		     scan_data->id == id))
+		     scan_data->id == id)) {
 			scsi_scan_target(&session->dev, 0, id,
 					 scan_data->lun, scan_data->rescan);
+			spin_lock_irqsave(&session->lock, flags);
+			session->target_state = ISCSI_SESSION_TARGET_SCANNED;
+			spin_unlock_irqrestore(&session->lock, flags);
+		}
 	}
 
 user_scan_exit:
@@ -1961,31 +1972,41 @@ static void __iscsi_unbind_session(struct work_struct *work)
 	struct iscsi_cls_host *ihost = shost->shost_data;
 	unsigned long flags;
 	unsigned int target_id;
+	bool remove_target = true;
 
 	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
 
 	/* Prevent new scans and make sure scanning is not in progress */
 	mutex_lock(&ihost->mutex);
 	spin_lock_irqsave(&session->lock, flags);
-	if (session->target_id == ISCSI_MAX_TARGET) {
+	if (session->target_state == ISCSI_SESSION_TARGET_ALLOCATED) {
+		remove_target = false;
+	} else if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
 		spin_unlock_irqrestore(&session->lock, flags);
 		mutex_unlock(&ihost->mutex);
-		goto unbind_session_exit;
+		ISCSI_DBG_TRANS_SESSION(session,
+			"Skipping target unbinding: Session is unbound/unbinding.\n");
+		return;
 	}
 
+	session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
 	target_id = session->target_id;
 	session->target_id = ISCSI_MAX_TARGET;
 	spin_unlock_irqrestore(&session->lock, flags);
 	mutex_unlock(&ihost->mutex);
 
-	scsi_remove_target(&session->dev);
+	if (remove_target)
+		scsi_remove_target(&session->dev);
 
 	if (session->ida_used)
 		ida_free(&iscsi_sess_ida, target_id);
 
-unbind_session_exit:
 	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
 	ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
+
+	spin_lock_irqsave(&session->lock, flags);
+	session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
+	spin_unlock_irqrestore(&session->lock, flags);
 }
 
 static void __iscsi_destroy_session(struct work_struct *work)
@@ -2062,6 +2083,9 @@ int iscsi_add_session(struct iscsi_cls_session *session, unsigned int target_id)
 		session->ida_used = true;
 	} else
 		session->target_id = target_id;
+	spin_lock_irqsave(&session->lock, flags);
+	session->target_state = ISCSI_SESSION_TARGET_ALLOCATED;
+	spin_unlock_irqrestore(&session->lock, flags);
 
 	dev_set_name(&session->dev, "session%u", session->sid);
 	err = device_add(&session->dev);
@@ -4369,6 +4393,19 @@ iscsi_session_attr(def_taskmgmt_tmo, ISCSI_PARAM_DEF_TASKMGMT_TMO, 0);
 iscsi_session_attr(discovery_parent_idx, ISCSI_PARAM_DISCOVERY_PARENT_IDX, 0);
 iscsi_session_attr(discovery_parent_type, ISCSI_PARAM_DISCOVERY_PARENT_TYPE, 0);
 
+static ssize_t
+show_priv_session_target_state(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct iscsi_cls_session *session = iscsi_dev_to_session(dev->parent);
+
+	return sysfs_emit(buf, "%s\n",
+			iscsi_session_target_state_name[session->target_state]);
+}
+
+static ISCSI_CLASS_ATTR(priv_sess, target_state, S_IRUGO,
+			show_priv_session_target_state, NULL);
+
 static ssize_t
 show_priv_session_state(struct device *dev, struct device_attribute *attr,
 			char *buf)
@@ -4471,6 +4508,7 @@ static struct attribute *iscsi_session_attrs[] = {
 	&dev_attr_sess_boot_target.attr,
 	&dev_attr_priv_sess_recovery_tmo.attr,
 	&dev_attr_priv_sess_state.attr,
+	&dev_attr_priv_sess_target_state.attr,
 	&dev_attr_priv_sess_creator.attr,
 	&dev_attr_sess_chap_out_idx.attr,
 	&dev_attr_sess_chap_in_idx.attr,
@@ -4584,6 +4622,8 @@ static umode_t iscsi_session_attr_is_visible(struct kobject *kobj,
 		return S_IRUGO | S_IWUSR;
 	else if (attr == &dev_attr_priv_sess_state.attr)
 		return S_IRUGO;
+	else if (attr == &dev_attr_priv_sess_target_state.attr)
+		return S_IRUGO;
 	else if (attr == &dev_attr_priv_sess_creator.attr)
 		return S_IRUGO;
 	else if (attr == &dev_attr_priv_sess_target_id.attr)
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d7a84c0bfaeb..22705eb781b0 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1823,6 +1823,9 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	ret = storvsc_do_io(dev, cmd_request, get_cpu());
 	put_cpu();
 
+	if (ret)
+		scsi_dma_unmap(scmnd);
+
 	if (ret == -EAGAIN) {
 		/* no more space */
 		ret = SCSI_MLQUEUE_DEVICE_BUSY;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index e18c9f4463ec..bda61be5f035 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6056,6 +6056,14 @@ void ufshcd_schedule_eh_work(struct ufs_hba *hba)
 	}
 }
 
+static void ufshcd_force_error_recovery(struct ufs_hba *hba)
+{
+	spin_lock_irq(hba->host->host_lock);
+	hba->force_reset = true;
+	ufshcd_schedule_eh_work(hba);
+	spin_unlock_irq(hba->host->host_lock);
+}
+
 static void ufshcd_clk_scaling_allow(struct ufs_hba *hba, bool allow)
 {
 	down_write(&hba->clk_scaling_lock);
@@ -9083,6 +9091,15 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 		if (!hba->dev_info.b_rpm_dev_flush_capable) {
 			ret = ufshcd_set_dev_pwr_mode(hba, req_dev_pwr_mode);
+			if (ret && pm_op != UFS_SHUTDOWN_PM) {
+				/*
+				 * If return err in suspend flow, IO will hang.
+				 * Trigger error handler and break suspend for
+				 * error recovery.
+				 */
+				ufshcd_force_error_recovery(hba);
+				ret = -EBUSY;
+			}
 			if (ret)
 				goto enable_scaling;
 		}
@@ -9094,6 +9111,15 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	 */
 	check_for_bkops = !ufshcd_is_ufs_dev_deepsleep(hba);
 	ret = ufshcd_link_state_transition(hba, req_link_state, check_for_bkops);
+	if (ret && pm_op != UFS_SHUTDOWN_PM) {
+		/*
+		 * If return err in suspend flow, IO will hang.
+		 * Trigger error handler and break suspend for
+		 * error recovery.
+		 */
+		ufshcd_force_error_recovery(hba);
+		ret = -EBUSY;
+	}
 	if (ret)
 		goto set_dev_active;
 
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index cab52b0f11d0..34c03707fb6e 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -236,6 +236,14 @@ enum {
 	ISCSI_SESSION_FREE,
 };
 
+enum {
+	ISCSI_SESSION_TARGET_UNBOUND,
+	ISCSI_SESSION_TARGET_ALLOCATED,
+	ISCSI_SESSION_TARGET_SCANNED,
+	ISCSI_SESSION_TARGET_UNBINDING,
+	ISCSI_SESSION_TARGET_MAX,
+};
+
 #define ISCSI_MAX_TARGET -1
 
 struct iscsi_cls_session {
@@ -264,6 +272,7 @@ struct iscsi_cls_session {
 	 */
 	pid_t creator;
 	int state;
+	int target_state;			/* session target bind state */
 	int sid;				/* session id */
 	void *dd_data;				/* LLD private data */
 	struct device dev;	/* sysfs transport/container device */

