Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ED95B401C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIITqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIITqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:46:12 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126FF4D83D;
        Fri,  9 Sep 2022 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1662752536;
        bh=0TA1fcaFjxj+h7LH77I89nvRe2vOysHdnuYBeaVbeOc=;
        h=Message-ID:Subject:From:To:Date:From;
        b=GLengYwFvWR0AxO91XgZjGVCS7jR5seMK4uxIg7pHJHJ82vj6O603zva1IxD4Yrse
         sikmnM6rsANrTe13wom5dR4KD9Lpeso0WDClmEbLkynjFqIR6UQdKP9k/V0WyzCaao
         /tc9jt8cV9dBhNL9gyqCiNCEvIGgGAAcid1yjBq8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C49161281BCA;
        Fri,  9 Sep 2022 15:42:16 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vSxFHI8WL_qV; Fri,  9 Sep 2022 15:42:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1662752536;
        bh=0TA1fcaFjxj+h7LH77I89nvRe2vOysHdnuYBeaVbeOc=;
        h=Message-ID:Subject:From:To:Date:From;
        b=GLengYwFvWR0AxO91XgZjGVCS7jR5seMK4uxIg7pHJHJ82vj6O603zva1IxD4Yrse
         sikmnM6rsANrTe13wom5dR4KD9Lpeso0WDClmEbLkynjFqIR6UQdKP9k/V0WyzCaao
         /tc9jt8cV9dBhNL9gyqCiNCEvIGgGAAcid1yjBq8=
Received: from lingrow.int.hansenpartnership.com (c-67-166-174-65.hsd1.va.comcast.net [67.166.174.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2D0BD1281B54;
        Fri,  9 Sep 2022 15:42:16 -0400 (EDT)
Message-ID: <1dd06978292c5c1979b79b1a94b4af4d7175d7aa.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.0-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 09 Sep 2022 15:42:14 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
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

Eight patches which looks like quite a large core change, but most of
the diffstat is reverting the attempt to rejig reference counting
introduced in the last merge window which caused issues with device and
module removal.  Of the remaining four patches, only the fix use-after-
free is substantial.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Bart Van Assche (5):
      scsi: core: Fix a use-after-free
      scsi: core: Revert "Make sure that targets outlive devices"
      scsi: core: Revert "Make sure that hosts outlive targets"
      scsi: core: Revert "Simplify LLD module reference counting"
      scsi: core: Revert "Call blk_mq_free_tag_set() earlier"

Hannes Reinecke (1):
      scsi: lpfc: Return DID_TRANSPORT_DISRUPTED instead of DID_REQUEUE

Sreekanth Reddy (1):
      scsi: mpt3sas: Fix use-after-free warning

Yang Yingliang (1):
      scsi: lpfc: Add missing destroy_workqueue() in error path

And the diffstat:

 drivers/scsi/hosts.c                 | 28 +++++++++++++++-------------
 drivers/scsi/lpfc/lpfc_init.c        |  5 ++++-
 drivers/scsi/lpfc/lpfc_scsi.c        |  4 ++--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |  2 +-
 drivers/scsi/scsi.c                  |  9 +++------
 drivers/scsi/scsi_lib.c              |  6 +++++-
 drivers/scsi/scsi_priv.h             |  2 +-
 drivers/scsi/scsi_scan.c             | 10 +---------
 drivers/scsi/scsi_sysfs.c            | 30 +++++++++++++-----------------
 include/scsi/scsi_device.h           |  2 --
 include/scsi/scsi_host.h             |  5 ++---
 11 files changed, 47 insertions(+), 56 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 0738238ed6cc..9857dba09c95 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -182,6 +182,15 @@ void scsi_remove_host(struct Scsi_Host *shost)
 	mutex_unlock(&shost->scan_mutex);
 	scsi_proc_host_rm(shost);
 
+	/*
+	 * New SCSI devices cannot be attached anymore because of the SCSI host
+	 * state so drop the tag set refcnt. Wait until the tag set refcnt drops
+	 * to zero because .exit_cmd_priv implementations may need the host
+	 * pointer.
+	 */
+	kref_put(&shost->tagset_refcnt, scsi_mq_free_tags);
+	wait_for_completion(&shost->tagset_freed);
+
 	spin_lock_irqsave(shost->host_lock, flags);
 	if (scsi_host_set_state(shost, SHOST_DEL))
 		BUG_ON(scsi_host_set_state(shost, SHOST_DEL_RECOVERY));
@@ -190,15 +199,6 @@ void scsi_remove_host(struct Scsi_Host *shost)
 	transport_unregister_device(&shost->shost_gendev);
 	device_unregister(&shost->shost_dev);
 	device_del(&shost->shost_gendev);
-
-	/*
-	 * After scsi_remove_host() has returned the scsi LLD module can be
-	 * unloaded and/or the host resources can be released. Hence wait until
-	 * the dependent SCSI targets and devices are gone before returning.
-	 */
-	wait_event(shost->targets_wq, atomic_read(&shost->target_count) == 0);
-
-	scsi_mq_destroy_tags(shost);
 }
 EXPORT_SYMBOL(scsi_remove_host);
 
@@ -254,6 +254,9 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	if (error)
 		goto fail;
 
+	kref_init(&shost->tagset_refcnt);
+	init_completion(&shost->tagset_freed);
+
 	/*
 	 * Increase usage count temporarily here so that calling
 	 * scsi_autopm_put_host() will trigger runtime idle if there is
@@ -309,8 +312,8 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	return error;
 
 	/*
-	 * Any resources associated with the SCSI host in this function except
-	 * the tag set will be freed by scsi_host_dev_release().
+	 * Any host allocation in this function will be freed in
+	 * scsi_host_dev_release().
 	 */
  out_del_dev:
 	device_del(&shost->shost_dev);
@@ -326,7 +329,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	pm_runtime_disable(&shost->shost_gendev);
 	pm_runtime_set_suspended(&shost->shost_gendev);
 	pm_runtime_put_noidle(&shost->shost_gendev);
-	scsi_mq_destroy_tags(shost);
+	kref_put(&shost->tagset_refcnt, scsi_mq_free_tags);
  fail:
 	return error;
 }
@@ -406,7 +409,6 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	INIT_LIST_HEAD(&shost->starved_list);
 	init_waitqueue_head(&shost->host_wait);
 	mutex_init(&shost->scan_mutex);
-	init_waitqueue_head(&shost->targets_wq);
 
 	index = ida_alloc(&host_index_ida, GFP_KERNEL);
 	if (index < 0) {
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index c69c5a0979ec..55a1ad6eed03 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -8053,7 +8053,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	/* Allocate device driver memory */
 	rc = lpfc_mem_alloc(phba, SGL_ALIGN_SZ);
 	if (rc)
-		return -ENOMEM;
+		goto out_destroy_workqueue;
 
 	/* IF Type 2 ports get initialized now. */
 	if (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) >=
@@ -8481,6 +8481,9 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	lpfc_destroy_bootstrap_mbox(phba);
 out_free_mem:
 	lpfc_mem_free(phba);
+out_destroy_workqueue:
+	destroy_workqueue(phba->wq);
+	phba->wq = NULL;
 	return rc;
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 084c0f9fdc3a..938a5e435943 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4272,7 +4272,7 @@ lpfc_fcp_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 		    lpfc_cmd->result == IOERR_ABORT_REQUESTED ||
 		    lpfc_cmd->result == IOERR_RPI_SUSPENDED ||
 		    lpfc_cmd->result == IOERR_SLER_CMD_RCV_FAILURE) {
-			cmd->result = DID_REQUEUE << 16;
+			cmd->result = DID_TRANSPORT_DISRUPTED << 16;
 			break;
 		}
 		if ((lpfc_cmd->result == IOERR_RX_DMA_FAILED ||
@@ -4562,7 +4562,7 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pIocbIn,
 			    lpfc_cmd->result == IOERR_NO_RESOURCES ||
 			    lpfc_cmd->result == IOERR_ABORT_REQUESTED ||
 			    lpfc_cmd->result == IOERR_SLER_CMD_RCV_FAILURE) {
-				cmd->result = DID_REQUEUE << 16;
+				cmd->result = DID_TRANSPORT_DISRUPTED << 16;
 				break;
 			}
 			if ((lpfc_cmd->result == IOERR_RX_DMA_FAILED ||
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index def37a7e5980..bd6a5f1bd532 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -3670,6 +3670,7 @@ static struct fw_event_work *dequeue_next_fw_event(struct MPT3SAS_ADAPTER *ioc)
 		fw_event = list_first_entry(&ioc->fw_event_list,
 				struct fw_event_work, list);
 		list_del_init(&fw_event->list);
+		fw_event_work_put(fw_event);
 	}
 	spin_unlock_irqrestore(&ioc->fw_event_lock, flags);
 
@@ -3751,7 +3752,6 @@ _scsih_fw_event_cleanup_queue(struct MPT3SAS_ADAPTER *ioc)
 		if (cancel_work_sync(&fw_event->work))
 			fw_event_work_put(fw_event);
 
-		fw_event_work_put(fw_event);
 	}
 	ioc->fw_events_cleanup = 0;
 }
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 086ec5b5862d..c59eac7a32f2 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -586,13 +586,10 @@ EXPORT_SYMBOL(scsi_device_get);
  */
 void scsi_device_put(struct scsi_device *sdev)
 {
-	/*
-	 * Decreasing the module reference count before the device reference
-	 * count is safe since scsi_remove_host() only returns after all
-	 * devices have been removed.
-	 */
-	module_put(sdev->host->hostt->module);
+	struct module *mod = sdev->host->hostt->module;
+
 	put_device(&sdev->sdev_gendev);
+	module_put(mod);
 }
 EXPORT_SYMBOL(scsi_device_put);
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ef08029a0079..96e7e3eaca29 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1983,9 +1983,13 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	return blk_mq_alloc_tag_set(tag_set);
 }
 
-void scsi_mq_destroy_tags(struct Scsi_Host *shost)
+void scsi_mq_free_tags(struct kref *kref)
 {
+	struct Scsi_Host *shost = container_of(kref, typeof(*shost),
+					       tagset_refcnt);
+
 	blk_mq_free_tag_set(&shost->tag_set);
+	complete(&shost->tagset_freed);
 }
 
 /**
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 429663bd78ec..f385b3f04d6e 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -94,7 +94,7 @@ extern void scsi_run_host_queues(struct Scsi_Host *shost);
 extern void scsi_requeue_run_queue(struct work_struct *work);
 extern void scsi_start_queue(struct scsi_device *sdev);
 extern int scsi_mq_setup_tags(struct Scsi_Host *shost);
-extern void scsi_mq_destroy_tags(struct Scsi_Host *shost);
+extern void scsi_mq_free_tags(struct kref *kref);
 extern void scsi_exit_queue(void);
 extern void scsi_evt_thread(struct work_struct *work);
 
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index ac6059702d13..5d27f5196de6 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -340,6 +340,7 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 		kfree(sdev);
 		goto out;
 	}
+	kref_get(&sdev->host->tagset_refcnt);
 	sdev->request_queue = q;
 	q->queuedata = sdev;
 	__scsi_init_queue(sdev->host, q);
@@ -406,14 +407,9 @@ static void scsi_target_destroy(struct scsi_target *starget)
 static void scsi_target_dev_release(struct device *dev)
 {
 	struct device *parent = dev->parent;
-	struct Scsi_Host *shost = dev_to_shost(parent);
 	struct scsi_target *starget = to_scsi_target(dev);
 
 	kfree(starget);
-
-	if (atomic_dec_return(&shost->target_count) == 0)
-		wake_up(&shost->targets_wq);
-
 	put_device(parent);
 }
 
@@ -526,10 +522,6 @@ static struct scsi_target *scsi_alloc_target(struct device *parent,
 	starget->state = STARGET_CREATED;
 	starget->scsi_level = SCSI_2;
 	starget->max_target_blocked = SCSI_DEFAULT_TARGET_BLOCKED;
-	init_waitqueue_head(&starget->sdev_wq);
-
-	atomic_inc(&shost->target_count);
-
  retry:
 	spin_lock_irqsave(shost->host_lock, flags);
 
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 9dad2fd5297f..5d61f58399dc 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -443,15 +443,18 @@ static void scsi_device_cls_release(struct device *class_dev)
 
 static void scsi_device_dev_release_usercontext(struct work_struct *work)
 {
-	struct scsi_device *sdev = container_of(work, struct scsi_device,
-						ew.work);
-	struct scsi_target *starget = sdev->sdev_target;
+	struct scsi_device *sdev;
 	struct device *parent;
 	struct list_head *this, *tmp;
 	struct scsi_vpd *vpd_pg80 = NULL, *vpd_pg83 = NULL;
 	struct scsi_vpd *vpd_pg0 = NULL, *vpd_pg89 = NULL;
 	struct scsi_vpd *vpd_pgb0 = NULL, *vpd_pgb1 = NULL, *vpd_pgb2 = NULL;
 	unsigned long flags;
+	struct module *mod;
+
+	sdev = container_of(work, struct scsi_device, ew.work);
+
+	mod = sdev->host->hostt->module;
 
 	scsi_dh_release_device(sdev);
 
@@ -513,16 +516,19 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
 	kfree(sdev->inquiry);
 	kfree(sdev);
 
-	if (starget && atomic_dec_return(&starget->sdev_count) == 0)
-		wake_up(&starget->sdev_wq);
-
 	if (parent)
 		put_device(parent);
+	module_put(mod);
 }
 
 static void scsi_device_dev_release(struct device *dev)
 {
 	struct scsi_device *sdp = to_scsi_device(dev);
+
+	/* Set module pointer as NULL in case of module unloading */
+	if (!try_module_get(sdp->host->hostt->module))
+		sdp->host->hostt->module = NULL;
+
 	execute_in_process_context(scsi_device_dev_release_usercontext,
 				   &sdp->ew);
 }
@@ -1470,6 +1476,7 @@ void __scsi_remove_device(struct scsi_device *sdev)
 	mutex_unlock(&sdev->state_mutex);
 
 	blk_mq_destroy_queue(sdev->request_queue);
+	kref_put(&sdev->host->tagset_refcnt, scsi_mq_free_tags);
 	cancel_work_sync(&sdev->requeue_work);
 
 	if (sdev->host->hostt->slave_destroy)
@@ -1529,14 +1536,6 @@ static void __scsi_remove_target(struct scsi_target *starget)
 		goto restart;
 	}
 	spin_unlock_irqrestore(shost->host_lock, flags);
-
-	/*
-	 * After scsi_remove_target() returns its caller can remove resources
-	 * associated with @starget, e.g. an rport or session. Wait until all
-	 * devices associated with @starget have been removed to prevent that
-	 * a SCSI error handling callback function triggers a use-after-free.
-	 */
-	wait_event(starget->sdev_wq, atomic_read(&starget->sdev_count) == 0);
 }
 
 /**
@@ -1647,9 +1646,6 @@ void scsi_sysfs_device_initialize(struct scsi_device *sdev)
 	list_add_tail(&sdev->same_target_siblings, &starget->devices);
 	list_add_tail(&sdev->siblings, &shost->__devices);
 	spin_unlock_irqrestore(shost->host_lock, flags);
-
-	atomic_inc(&starget->sdev_count);
-
 	/*
 	 * device can now only be removed via __scsi_remove_device() so hold
 	 * the target.  Target will be held in CREATED state until something
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 3113471ca375..2493bd65351a 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -309,8 +309,6 @@ struct scsi_target {
 	struct list_head	devices;
 	struct device		dev;
 	struct kref		reap_ref; /* last put renders target invisible */
-	atomic_t		sdev_count;
-	wait_queue_head_t	sdev_wq;
 	unsigned int		channel;
 	unsigned int		id; /* target id ... replace
 				     * scsi_device.id eventually */
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index aa7b7496c93a..9b0a028bf053 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -557,6 +557,8 @@ struct Scsi_Host {
 	struct scsi_host_template *hostt;
 	struct scsi_transport_template *transportt;
 
+	struct kref		tagset_refcnt;
+	struct completion	tagset_freed;
 	/* Area to keep a shared tag map */
 	struct blk_mq_tag_set	tag_set;
 
@@ -690,9 +692,6 @@ struct Scsi_Host {
 	/* ldm bits */
 	struct device		shost_gendev, shost_dev;
 
-	atomic_t		target_count;
-	wait_queue_head_t	targets_wq;
-
 	/*
 	 * Points to the transport data (if any) which is allocated
 	 * separately

