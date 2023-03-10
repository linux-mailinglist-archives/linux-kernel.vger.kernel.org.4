Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7856B53FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjCJWMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCJWMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:12:43 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF211D090;
        Fri, 10 Mar 2023 14:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1678486355;
        bh=pKEDiHNodBtSbdBH+JkVvtOLXrAN4puWeOF2S1o7AVY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=mwh3xvdfc2mVvKq5Dsz+vLru0WcITTDO45SJ2ZaK4B5IBG/ymGP54xj6pJpdams4g
         jjEHpXgFYBKgyw+2uShE21JO+/bUEVaB0IhzNd536ozjhD8zN0Rbt2CIcoC8eOgKDh
         EwYS9+0rNvUgbRcl3pGxGHo3EnFYpOiWAErwj4TY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D84321286C6A;
        Fri, 10 Mar 2023 17:12:35 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zpsyu4ww2oX9; Fri, 10 Mar 2023 17:12:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1678486355;
        bh=pKEDiHNodBtSbdBH+JkVvtOLXrAN4puWeOF2S1o7AVY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=mwh3xvdfc2mVvKq5Dsz+vLru0WcITTDO45SJ2ZaK4B5IBG/ymGP54xj6pJpdams4g
         jjEHpXgFYBKgyw+2uShE21JO+/bUEVaB0IhzNd536ozjhD8zN0Rbt2CIcoC8eOgKDh
         EwYS9+0rNvUgbRcl3pGxGHo3EnFYpOiWAErwj4TY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 445B31286B10;
        Fri, 10 Mar 2023 17:12:35 -0500 (EST)
Message-ID: <f34e06d6f44d17ad720e3a62497c612aebf5aab1.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.3-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 10 Mar 2023 17:12:32 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20 Fixes all in drivers except the one zone storage revalidation fix to
sd.  The megaraid_sas fixes are more on the level of a driver update
(enabling crash dump and increasing lun number) but I thought you could
let this slide on -rc1 and the next most extensive update is a load of
fixes to mpi3mr.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Adrien Thierry (1):
      scsi: ufs: core: Add soft dependency on governor_simpleondemand

Asutosh Das (2):
      scsi: ufs: mcq: qcom: Clean the return path of ufs_qcom_mcq_config_resource()
      scsi: ufs: mcq: qcom: Fix passing zero to PTR_ERR

Chandrakanth Patil (3):
      scsi: megaraid_sas: Driver version update to 07.725.01.00-rc1
      scsi: megaraid_sas: Add crash dump mode capability bit in MFI capabilities
      scsi: megaraid_sas: Update max supported LD IDs to 240

Dan Carpenter (1):
      scsi: ufs: ufs-qcom: Remove impossible check

Daniel Wagner (1):
      scsi: qla2xxx: Add option to disable FC2 Target support

Jakob Koschel (1):
      scsi: lpfc: Avoid usage of list iterator variable after loop

Justin Tee (1):
      scsi: lpfc: Check kzalloc() in lpfc_sli4_cgn_params_read()

Kang Chen (1):
      scsi: hisi_sas: Check devm_add_action() return value

Maurizio Lombardi (1):
      scsi: target: iscsi: Fix an error message in iscsi_check_key()

Michael Kelley (1):
      scsi: storvsc: Handle BlockSize change in Hyper-V VHD/VHDX file

Ranjan Kumar (6):
      scsi: mpi3mr: Bad drive in topology results kernel crash
      scsi: mpi3mr: NVMe command size greater than 8K fails
      scsi: mpi3mr: Return proper values for failures in firmware init path
      scsi: mpi3mr: Wait for diagnostic save during controller init
      scsi: mpi3mr: Driver unload crashes host when enhanced logging is enabled
      scsi: mpi3mr: ioctl timeout when disabling/enabling interrupt

Shin'ichiro Kawasaki (1):
      scsi: sd: Fix wrong zone_write_granularity value during revalidate

And the diffstat:

 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c         |  3 +-
 drivers/scsi/lpfc/lpfc_init.c                  |  2 ++
 drivers/scsi/lpfc/lpfc_sli.c                   | 12 +++-----
 drivers/scsi/megaraid/megaraid_sas.h           | 12 +++++---
 drivers/scsi/megaraid/megaraid_sas_fp.c        |  2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c    |  3 ++
 drivers/scsi/mpi3mr/mpi3mr.h                   |  3 ++
 drivers/scsi/mpi3mr/mpi3mr_app.c               |  4 +--
 drivers/scsi/mpi3mr/mpi3mr_fw.c                | 42 +++++++++++++++++++++++---
 drivers/scsi/mpi3mr/mpi3mr_os.c                |  1 +
 drivers/scsi/mpi3mr/mpi3mr_transport.c         | 15 +++++----
 drivers/scsi/qla2xxx/qla_gbl.h                 |  1 +
 drivers/scsi/qla2xxx/qla_init.c                |  3 +-
 drivers/scsi/qla2xxx/qla_os.c                  | 10 +++++-
 drivers/scsi/sd.c                              |  7 ++++-
 drivers/scsi/sd_zbc.c                          |  8 -----
 drivers/scsi/storvsc_drv.c                     | 16 ++++++++++
 drivers/target/iscsi/iscsi_target_parameters.c | 12 +++++---
 drivers/ufs/core/ufshcd.c                      |  1 +
 drivers/ufs/host/ufs-qcom.c                    | 10 +++---
 20 files changed, 117 insertions(+), 50 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 0c3fcb807806..a63279f55d09 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2495,8 +2495,7 @@ static int interrupt_preinit_v3_hw(struct hisi_hba *hisi_hba)
 	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW;
 	shost->nr_hw_queues = hisi_hba->cq_nvecs;
 
-	devm_add_action(&pdev->dev, hisi_sas_v3_free_vectors, pdev);
-	return 0;
+	return devm_add_action(&pdev->dev, hisi_sas_v3_free_vectors, pdev);
 }
 
 static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 61958a24a43d..60e4ac2b8a6b 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7291,6 +7291,8 @@ lpfc_sli4_cgn_params_read(struct lpfc_hba *phba)
 	/* Find out if the FW has a new set of congestion parameters. */
 	len = sizeof(struct lpfc_cgn_param);
 	pdata = kzalloc(len, GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 	ret = lpfc_read_object(phba, (char *)LPFC_PORT_CFG_NAME,
 			       pdata, len);
 
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index c5b69f313af3..cf630aa6734e 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -21899,20 +21899,20 @@ lpfc_get_io_buf_from_private_pool(struct lpfc_hba *phba,
 static struct lpfc_io_buf *
 lpfc_get_io_buf_from_expedite_pool(struct lpfc_hba *phba)
 {
-	struct lpfc_io_buf *lpfc_ncmd;
+	struct lpfc_io_buf *lpfc_ncmd = NULL, *iter;
 	struct lpfc_io_buf *lpfc_ncmd_next;
 	unsigned long iflag;
 	struct lpfc_epd_pool *epd_pool;
 
 	epd_pool = &phba->epd_pool;
-	lpfc_ncmd = NULL;
 
 	spin_lock_irqsave(&epd_pool->lock, iflag);
 	if (epd_pool->count > 0) {
-		list_for_each_entry_safe(lpfc_ncmd, lpfc_ncmd_next,
+		list_for_each_entry_safe(iter, lpfc_ncmd_next,
 					 &epd_pool->list, list) {
-			list_del(&lpfc_ncmd->list);
+			list_del(&iter->list);
 			epd_pool->count--;
+			lpfc_ncmd = iter;
 			break;
 		}
 	}
@@ -22109,10 +22109,6 @@ lpfc_read_object(struct lpfc_hba *phba, char *rdobject, uint32_t *datap,
 	struct lpfc_dmabuf *pcmd;
 	u32 rd_object_name[LPFC_MBX_OBJECT_NAME_LEN_DW] = {0};
 
-	/* sanity check on queue memory */
-	if (!datap)
-		return -ENODEV;
-
 	mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mbox)
 		return -ENOMEM;
diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 4919ea54b827..63bac3684c19 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -23,8 +23,8 @@
 /*
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION				"07.719.03.00-rc1"
-#define MEGASAS_RELDATE				"Sep 29, 2021"
+#define MEGASAS_VERSION				"07.725.01.00-rc1"
+#define MEGASAS_RELDATE				"Mar 2, 2023"
 
 #define MEGASAS_MSIX_NAME_LEN			32
 
@@ -1519,6 +1519,8 @@ struct megasas_ctrl_info {
 #define MEGASAS_MAX_LD_IDS			(MEGASAS_MAX_LD_CHANNELS * \
 						MEGASAS_MAX_DEV_PER_CHANNEL)
 
+#define MEGASAS_MAX_SUPPORTED_LD_IDS		240
+
 #define MEGASAS_MAX_SECTORS                    (2*1024)
 #define MEGASAS_MAX_SECTORS_IEEE		(2*128)
 #define MEGASAS_DBG_LVL				1
@@ -1758,7 +1760,8 @@ union megasas_sgl_frame {
 typedef union _MFI_CAPABILITIES {
 	struct {
 #if   defined(__BIG_ENDIAN_BITFIELD)
-	u32     reserved:16;
+	u32     reserved:15;
+	u32	support_memdump:1;
 	u32	support_fw_exposed_dev_list:1;
 	u32	support_nvme_passthru:1;
 	u32     support_64bit_mode:1;
@@ -1792,7 +1795,8 @@ typedef union _MFI_CAPABILITIES {
 	u32     support_64bit_mode:1;
 	u32	support_nvme_passthru:1;
 	u32	support_fw_exposed_dev_list:1;
-	u32     reserved:16;
+	u32	support_memdump:1;
+	u32     reserved:15;
 #endif
 	} mfi_capabilities;
 	__le32		reg;
diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
index da1cad1ee123..4463a538102a 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -358,7 +358,7 @@ u8 MR_ValidateMapInfo(struct megasas_instance *instance, u64 map_id)
 		ld = MR_TargetIdToLdGet(i, drv_map);
 
 		/* For non existing VDs, iterate to next VD*/
-		if (ld >= (MAX_LOGICAL_DRIVES_EXT - 1))
+		if (ld >= MEGASAS_MAX_SUPPORTED_LD_IDS)
 			continue;
 
 		raid = MR_LdRaidGet(ld, drv_map);
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 6597e118c805..84c9a55a5794 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -1201,6 +1201,9 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
 	drv_ops->mfi_capabilities.support_nvme_passthru = 1;
 	drv_ops->mfi_capabilities.support_fw_exposed_dev_list = 1;
 
+	if (reset_devices)
+		drv_ops->mfi_capabilities.support_memdump = 1;
+
 	if (instance->consistent_mask_64bit)
 		drv_ops->mfi_capabilities.support_64bit_mode = 1;
 
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 23de2603e71f..40f238fa80cc 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -902,6 +902,7 @@ struct scmd_priv {
  * @admin_reply_ephase:Admin reply queue expected phase
  * @admin_reply_base: Admin reply queue base virtual address
  * @admin_reply_dma: Admin reply queue base dma address
+ * @admin_reply_q_in_use: Queue is handled by poll/ISR
  * @ready_timeout: Controller ready timeout
  * @intr_info: Interrupt cookie pointer
  * @intr_info_count: Number of interrupt cookies
@@ -1055,6 +1056,7 @@ struct mpi3mr_ioc {
 	u8 admin_reply_ephase;
 	void *admin_reply_base;
 	dma_addr_t admin_reply_dma;
+	atomic_t admin_reply_q_in_use;
 
 	u32 ready_timeout;
 
@@ -1390,4 +1392,5 @@ void mpi3mr_add_event_wait_for_device_refresh(struct mpi3mr_ioc *mrioc);
 void mpi3mr_flush_drv_cmds(struct mpi3mr_ioc *mrioc);
 void mpi3mr_flush_cmds_for_unrecovered_controller(struct mpi3mr_ioc *mrioc);
 void mpi3mr_free_enclosure_list(struct mpi3mr_ioc *mrioc);
+int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc);
 #endif /*MPI3MR_H_INCLUDED*/
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index bff637702397..d10c6afb7f9c 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -886,7 +886,7 @@ static int mpi3mr_build_nvme_prp(struct mpi3mr_ioc *mrioc,
 			 * each time through the loop.
 			 */
 			*prp_entry = cpu_to_le64(dma_addr);
-			if (*prp1_entry & sgemod_mask) {
+			if (*prp_entry & sgemod_mask) {
 				dprint_bsg_err(mrioc,
 				    "%s: PRP address collides with SGE modifier\n",
 				    __func__);
@@ -895,7 +895,7 @@ static int mpi3mr_build_nvme_prp(struct mpi3mr_ioc *mrioc,
 			*prp_entry &= ~sgemod_mask;
 			*prp_entry |= sgemod_val;
 			prp_entry++;
-			prp_entry_dma++;
+			prp_entry_dma += prp_size;
 		}
 
 		/*
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 758f7ca9e0ee..29acf6111db3 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -415,7 +415,7 @@ static void mpi3mr_process_admin_reply_desc(struct mpi3mr_ioc *mrioc,
 		    le64_to_cpu(scsi_reply->sense_data_buffer_address));
 }
 
-static int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc)
+int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc)
 {
 	u32 exp_phase = mrioc->admin_reply_ephase;
 	u32 admin_reply_ci = mrioc->admin_reply_ci;
@@ -423,12 +423,17 @@ static int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc)
 	u64 reply_dma = 0;
 	struct mpi3_default_reply_descriptor *reply_desc;
 
+	if (!atomic_add_unless(&mrioc->admin_reply_q_in_use, 1, 1))
+		return 0;
+
 	reply_desc = (struct mpi3_default_reply_descriptor *)mrioc->admin_reply_base +
 	    admin_reply_ci;
 
 	if ((le16_to_cpu(reply_desc->reply_flags) &
-	    MPI3_REPLY_DESCRIPT_FLAGS_PHASE_MASK) != exp_phase)
+	    MPI3_REPLY_DESCRIPT_FLAGS_PHASE_MASK) != exp_phase) {
+		atomic_dec(&mrioc->admin_reply_q_in_use);
 		return 0;
+	}
 
 	do {
 		if (mrioc->unrecoverable)
@@ -454,6 +459,7 @@ static int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc)
 	writel(admin_reply_ci, &mrioc->sysif_regs->admin_reply_queue_ci);
 	mrioc->admin_reply_ci = admin_reply_ci;
 	mrioc->admin_reply_ephase = exp_phase;
+	atomic_dec(&mrioc->admin_reply_q_in_use);
 
 	return num_admin_replies;
 }
@@ -1192,7 +1198,7 @@ mpi3mr_revalidate_factsdata(struct mpi3mr_ioc *mrioc)
  */
 static int mpi3mr_bring_ioc_ready(struct mpi3mr_ioc *mrioc)
 {
-	u32 ioc_config, ioc_status, timeout;
+	u32 ioc_config, ioc_status, timeout, host_diagnostic;
 	int retval = 0;
 	enum mpi3mr_iocstate ioc_state;
 	u64 base_info;
@@ -1246,6 +1252,23 @@ static int mpi3mr_bring_ioc_ready(struct mpi3mr_ioc *mrioc)
 			    retval, mpi3mr_iocstate_name(ioc_state));
 	}
 	if (ioc_state != MRIOC_STATE_RESET) {
+		if (ioc_state == MRIOC_STATE_FAULT) {
+			timeout = MPI3_SYSIF_DIAG_SAVE_TIMEOUT * 10;
+			mpi3mr_print_fault_info(mrioc);
+			do {
+				host_diagnostic =
+					readl(&mrioc->sysif_regs->host_diagnostic);
+				if (!(host_diagnostic &
+				      MPI3_SYSIF_HOST_DIAG_SAVE_IN_PROGRESS))
+					break;
+				if (!pci_device_is_present(mrioc->pdev)) {
+					mrioc->unrecoverable = 1;
+					ioc_err(mrioc, "controller is not present at the bringup\n");
+					goto out_device_not_present;
+				}
+				msleep(100);
+			} while (--timeout);
+		}
 		mpi3mr_print_fault_info(mrioc);
 		ioc_info(mrioc, "issuing soft reset to bring to reset state\n");
 		retval = mpi3mr_issue_reset(mrioc,
@@ -2605,6 +2628,7 @@ static int mpi3mr_setup_admin_qpair(struct mpi3mr_ioc *mrioc)
 	mrioc->admin_reply_ci = 0;
 	mrioc->admin_reply_ephase = 1;
 	mrioc->admin_reply_base = NULL;
+	atomic_set(&mrioc->admin_reply_q_in_use, 0);
 
 	if (!mrioc->admin_req_base) {
 		mrioc->admin_req_base = dma_alloc_coherent(&mrioc->pdev->dev,
@@ -3816,8 +3840,10 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
 	dprint_init(mrioc, "allocating config page buffers\n");
 	mrioc->cfg_page = dma_alloc_coherent(&mrioc->pdev->dev,
 	    MPI3MR_DEFAULT_CFG_PAGE_SZ, &mrioc->cfg_page_dma, GFP_KERNEL);
-	if (!mrioc->cfg_page)
+	if (!mrioc->cfg_page) {
+		retval = -1;
 		goto out_failed_noretry;
+	}
 
 	mrioc->cfg_page_sz = MPI3MR_DEFAULT_CFG_PAGE_SZ;
 
@@ -3879,8 +3905,10 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
 		dprint_init(mrioc, "allocating memory for throttle groups\n");
 		sz = sizeof(struct mpi3mr_throttle_group_info);
 		mrioc->throttle_groups = kcalloc(mrioc->num_io_throttle_group, sz, GFP_KERNEL);
-		if (!mrioc->throttle_groups)
+		if (!mrioc->throttle_groups) {
+			retval = -1;
 			goto out_failed_noretry;
+		}
 	}
 
 	retval = mpi3mr_enable_events(mrioc);
@@ -3900,6 +3928,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
 		mpi3mr_memset_buffers(mrioc);
 		goto retry_init;
 	}
+	retval = -1;
 out_failed_noretry:
 	ioc_err(mrioc, "controller initialization failed\n");
 	mpi3mr_issue_reset(mrioc, MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT,
@@ -4012,6 +4041,7 @@ int mpi3mr_reinit_ioc(struct mpi3mr_ioc *mrioc, u8 is_resume)
 		ioc_err(mrioc,
 		    "cannot create minimum number of operational queues expected:%d created:%d\n",
 		    mrioc->shost->nr_hw_queues, mrioc->num_op_reply_q);
+		retval = -1;
 		goto out_failed_noretry;
 	}
 
@@ -4078,6 +4108,7 @@ int mpi3mr_reinit_ioc(struct mpi3mr_ioc *mrioc, u8 is_resume)
 		mpi3mr_memset_buffers(mrioc);
 		goto retry_init;
 	}
+	retval = -1;
 out_failed_noretry:
 	ioc_err(mrioc, "controller %s is failed\n",
 	    (is_resume)?"resume":"re-initialization");
@@ -4155,6 +4186,7 @@ void mpi3mr_memset_buffers(struct mpi3mr_ioc *mrioc)
 		memset(mrioc->admin_req_base, 0, mrioc->admin_req_q_sz);
 	if (mrioc->admin_reply_base)
 		memset(mrioc->admin_reply_base, 0, mrioc->admin_reply_q_sz);
+	atomic_set(&mrioc->admin_reply_q_in_use, 0);
 
 	if (mrioc->init_cmds.reply) {
 		memset(mrioc->init_cmds.reply, 0, sizeof(*mrioc->init_cmds.reply));
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 6eaeba41072c..a794cc8a1c0b 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -3720,6 +3720,7 @@ int mpi3mr_issue_tm(struct mpi3mr_ioc *mrioc, u8 tm_type,
 		mpi3mr_poll_pend_io_completions(mrioc);
 		mpi3mr_ioc_enable_intr(mrioc);
 		mpi3mr_poll_pend_io_completions(mrioc);
+		mpi3mr_process_admin_reply_q(mrioc);
 	}
 	switch (tm_type) {
 	case MPI3_SCSITASKMGMT_TASKTYPE_TARGET_RESET:
diff --git a/drivers/scsi/mpi3mr/mpi3mr_transport.c b/drivers/scsi/mpi3mr/mpi3mr_transport.c
index 3b61815979da..be25f242fa79 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_transport.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_transport.c
@@ -1552,7 +1552,8 @@ static void mpi3mr_sas_port_remove(struct mpi3mr_ioc *mrioc, u64 sas_address,
 
 	list_for_each_entry_safe(mr_sas_phy, next_phy,
 	    &mr_sas_port->phy_list, port_siblings) {
-		if ((mrioc->logging_level & MPI3_DEBUG_TRANSPORT_INFO))
+		if ((!mrioc->stop_drv_processing) &&
+		    (mrioc->logging_level & MPI3_DEBUG_TRANSPORT_INFO))
 			dev_info(&mr_sas_port->port->dev,
 			    "remove: sas_address(0x%016llx), phy(%d)\n",
 			    (unsigned long long)
@@ -2357,15 +2358,16 @@ int mpi3mr_report_tgtdev_to_sas_transport(struct mpi3mr_ioc *mrioc,
 	tgtdev->host_exposed = 1;
 	if (!mpi3mr_sas_port_add(mrioc, tgtdev->dev_handle,
 	    sas_address_parent, hba_port)) {
-		tgtdev->host_exposed = 0;
 		retval = -1;
-	} else if ((!tgtdev->starget)) {
-		if (!mrioc->is_driver_loading)
+		} else if ((!tgtdev->starget) && (!mrioc->is_driver_loading)) {
 			mpi3mr_sas_port_remove(mrioc, sas_address,
 			    sas_address_parent, hba_port);
-		tgtdev->host_exposed = 0;
 		retval = -1;
 	}
+	if (retval) {
+		tgtdev->dev_spec.sas_sata_inf.hba_port = NULL;
+		tgtdev->host_exposed = 0;
+	}
 	return retval;
 }
 
@@ -2394,6 +2396,7 @@ void mpi3mr_remove_tgtdev_from_sas_transport(struct mpi3mr_ioc *mrioc,
 	mpi3mr_sas_port_remove(mrioc, sas_address, sas_address_parent,
 	    hba_port);
 	tgtdev->host_exposed = 0;
+	tgtdev->dev_spec.sas_sata_inf.hba_port = NULL;
 }
 
 /**
@@ -2450,7 +2453,7 @@ static u8 mpi3mr_get_port_id_by_rphy(struct mpi3mr_ioc *mrioc, struct sas_rphy *
 
 		tgtdev = __mpi3mr_get_tgtdev_by_addr_and_rphy(mrioc,
 			    rphy->identify.sas_address, rphy);
-		if (tgtdev) {
+		if (tgtdev && tgtdev->dev_spec.sas_sata_inf.hba_port) {
 			port_id =
 				tgtdev->dev_spec.sas_sata_inf.hba_port->port_id;
 			mpi3mr_tgtdev_put(tgtdev);
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 9142df876c73..9aba07c7bde4 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -192,6 +192,7 @@ extern int ql2xsecenable;
 extern int ql2xenforce_iocb_limit;
 extern int ql2xabts_wait_nvme;
 extern u32 ql2xnvme_queues;
+extern int ql2xfc2target;
 
 extern int qla2x00_loop_reset(scsi_qla_host_t *);
 extern void qla2x00_abort_all_cmds(scsi_qla_host_t *, int);
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 1dbc1496ebed..ec0423ec6681 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1840,7 +1840,8 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 	case RSCN_PORT_ADDR:
 		fcport = qla2x00_find_fcport_by_nportid(vha, &ea->id, 1);
 		if (fcport) {
-			if (fcport->flags & FCF_FCP2_DEVICE &&
+			if (ql2xfc2target &&
+			    fcport->flags & FCF_FCP2_DEVICE &&
 			    atomic_read(&fcport->state) == FCS_ONLINE) {
 				ql_dbg(ql_dbg_disc, vha, 0x2115,
 				       "Delaying session delete for FCP2 portid=%06x %8phC ",
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 545167627e48..80c4ee9df2a4 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -360,6 +360,13 @@ MODULE_PARM_DESC(ql2xnvme_queues,
 	"1 - Minimum number of queues supported\n"
 	"8 - Default value");
 
+int ql2xfc2target = 1;
+module_param(ql2xfc2target, int, 0444);
+MODULE_PARM_DESC(qla2xfc2target,
+		  "Enables FC2 Target support. "
+		  "0 - FC2 Target support is disabled. "
+		  "1 - FC2 Target support is enabled (default).");
+
 static struct scsi_transport_template *qla2xxx_transport_template = NULL;
 struct scsi_transport_template *qla2xxx_transport_vport_template = NULL;
 
@@ -4085,7 +4092,8 @@ qla2x00_mark_all_devices_lost(scsi_qla_host_t *vha)
 	    "Mark all dev lost\n");
 
 	list_for_each_entry(fcport, &vha->vp_fcports, list) {
-		if (fcport->loop_id != FC_NO_LOOP_ID &&
+		if (ql2xfc2target &&
+		    fcport->loop_id != FC_NO_LOOP_ID &&
 		    (fcport->flags & FCF_FCP2_DEVICE) &&
 		    fcport->port_type == FCT_TARGET &&
 		    !qla2x00_reset_active(vha)) {
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4f28dd617eca..4bb87043e6db 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2988,8 +2988,13 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 	}
 
 	if (sdkp->device->type == TYPE_ZBC) {
-		/* Host-managed */
+		/*
+		 * Host-managed: Per ZBC and ZAC specifications, writes in
+		 * sequential write required zones of host-managed devices must
+		 * be aligned to the device physical block size.
+		 */
 		disk_set_zoned(sdkp->disk, BLK_ZONED_HM);
+		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
 	} else {
 		sdkp->zoned = zoned;
 		if (sdkp->zoned == 1) {
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 6b3a02d4406c..22801c24ea19 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -965,14 +965,6 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 	disk_set_max_active_zones(disk, 0);
 	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
 
-	/*
-	 * Per ZBC and ZAC specifications, writes in sequential write required
-	 * zones of host-managed devices must be aligned to the device physical
-	 * block size.
-	 */
-	if (blk_queue_zoned_model(q) == BLK_ZONED_HM)
-		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
-
 	sdkp->early_zone_info.nr_zones = nr_zones;
 	sdkp->early_zone_info.zone_blocks = zone_blocks;
 
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 33f568b7f54d..d9ce379c4d2e 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -987,6 +987,22 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 				goto do_work;
 			}
 
+			/*
+			 * Check for "Operating parameters have changed"
+			 * due to Hyper-V changing the VHD/VHDX BlockSize
+			 * when adding/removing a differencing disk. This
+			 * causes discard_granularity to change, so do a
+			 * rescan to pick up the new granularity. We don't
+			 * want scsi_report_sense() to output a message
+			 * that a sysadmin wouldn't know what to do with.
+			 */
+			if ((asc == 0x3f) && (ascq != 0x03) &&
+					(ascq != 0x0e)) {
+				process_err_fn = storvsc_device_scan;
+				set_host_byte(scmnd, DID_REQUEUE);
+				goto do_work;
+			}
+
 			/*
 			 * Otherwise, let upper layer deal with the
 			 * error when sense message is present
diff --git a/drivers/target/iscsi/iscsi_target_parameters.c b/drivers/target/iscsi/iscsi_target_parameters.c
index 2317fb077db0..557516c642c3 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.c
+++ b/drivers/target/iscsi/iscsi_target_parameters.c
@@ -1262,18 +1262,20 @@ static struct iscsi_param *iscsi_check_key(
 		return param;
 
 	if (!(param->phase & phase)) {
-		pr_err("Key \"%s\" may not be negotiated during ",
-				param->name);
+		char *phase_name;
+
 		switch (phase) {
 		case PHASE_SECURITY:
-			pr_debug("Security phase.\n");
+			phase_name = "Security";
 			break;
 		case PHASE_OPERATIONAL:
-			pr_debug("Operational phase.\n");
+			phase_name = "Operational";
 			break;
 		default:
-			pr_debug("Unknown phase.\n");
+			phase_name = "Unknown";
 		}
+		pr_err("Key \"%s\" may not be negotiated during %s phase.\n",
+				param->name, phase_name);
 		return NULL;
 	}
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 172d25fef740..05eac965ee27 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10512,4 +10512,5 @@ module_exit(ufshcd_core_exit);
 MODULE_AUTHOR("Santosh Yaragnavi <santosh.sy@samsung.com>");
 MODULE_AUTHOR("Vinayak Holikatti <h.vinayak@samsung.com>");
 MODULE_DESCRIPTION("Generic UFS host controller driver Core");
+MODULE_SOFTDEP("pre: governor_simpleondemand");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 34fc453f3eb1..a02cd866e2f8 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1177,7 +1177,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 			err = ufs_qcom_clk_scale_down_post_change(hba);
 
 
-		if (err || !dev_req_params) {
+		if (err) {
 			ufshcd_uic_hibern8_exit(hba);
 			return err;
 		}
@@ -1451,8 +1451,8 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 		if (IS_ERR(res->base)) {
 			dev_err(hba->dev, "Failed to map res %s, err=%d\n",
 					 res->name, (int)PTR_ERR(res->base));
-			res->base = NULL;
 			ret = PTR_ERR(res->base);
+			res->base = NULL;
 			return ret;
 		}
 	}
@@ -1466,7 +1466,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 	/* Explicitly allocate MCQ resource from ufs_mem */
 	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
 	if (!res_mcq)
-		return ret;
+		return -ENOMEM;
 
 	res_mcq->start = res_mem->start +
 			 MCQ_SQATTR_OFFSET(hba->mcq_capabilities);
@@ -1478,7 +1478,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 	if (ret) {
 		dev_err(hba->dev, "Failed to insert MCQ resource, err=%d\n",
 			ret);
-		goto insert_res_err;
+		return ret;
 	}
 
 	res->base = devm_ioremap_resource(hba->dev, res_mcq);
@@ -1495,8 +1495,6 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 ioremap_err:
 	res->base = NULL;
 	remove_resource(res_mcq);
-insert_res_err:
-	devm_kfree(hba->dev, res_mcq);
 	return ret;
 }
 

