Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301CE611C52
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJ1VQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJ1VPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:15:53 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEFF57887;
        Fri, 28 Oct 2022 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1666991742;
        bh=VQ3F28Of44qPetJGkebsCaZMkD8U23Cs3vL7/hx4eBo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=alVziYbsGYsINI2nThJisp2Xm1LKPvCc3VxaT6s97Ox5uKW3fZIWeTyPgPAMAOlGp
         I4o8TX/mdqT8F4Ef6NWAq9kzVibsESu2+Gqm1G+vcZezFY4wPBzefGml6X6yEMbXpf
         15+BfDnKgYxynNAv2AA4aPUZJFKUWi4B5hNwBm6g=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3AE971281323;
        Fri, 28 Oct 2022 17:15:42 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JLB9fYtSRJs3; Fri, 28 Oct 2022 17:15:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1666991742;
        bh=VQ3F28Of44qPetJGkebsCaZMkD8U23Cs3vL7/hx4eBo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=alVziYbsGYsINI2nThJisp2Xm1LKPvCc3VxaT6s97Ox5uKW3fZIWeTyPgPAMAOlGp
         I4o8TX/mdqT8F4Ef6NWAq9kzVibsESu2+Gqm1G+vcZezFY4wPBzefGml6X6yEMbXpf
         15+BfDnKgYxynNAv2AA4aPUZJFKUWi4B5hNwBm6g=
Received: from lingrow.int.hansenpartnership.com (c-67-166-174-65.hsd1.va.comcast.net [67.166.174.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0C1C31280796;
        Fri, 28 Oct 2022 17:15:40 -0400 (EDT)
Message-ID: <849ccec8eca62c218b36853c2be3ae288983d1e5.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.0-rc2
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 28 Oct 2022 17:15:39 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
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

21 small fixes, all in drivers.  Some of these arrived during the merge
window and got held over to make sure of testing on the -rc tree.  The
biggest change is for Standards conformance in the target driver,
closely followed by a set of bug fixes in megaraid_sas.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Christoph Hellwig (1):
      scsi: target: iblock: Fold iblock_emulate_read_cap_with_block_size() into iblock_get_blocks()

Colin Ian King (1):
      scsi: lpfc: Fix spelling mistake "unsolicted" -> "unsolicited"

Dmitry Bogdanov (5):
      scsi: target: core: UA on all LUNs after reset
      scsi: target: core: New key must be used for moved PR
      scsi: target: core: Abort all preempted regs if requested
      scsi: target: core: Fix memory leak in preempt_and_abort
      scsi: target: core: Fix preempt and abort for allreg res

Dukhyun Kwon (1):
      scsi: ufs: core: Fix the error log in ufshcd_query_flag_retry()

Guixin Liu (5):
      scsi: megaraid_sas: Move megasas_dbg_lvl init to megasas_init()
      scsi: megaraid_sas: Remove unnecessary memset()
      scsi: megaraid_sas: Simplify megasas_update_device_list
      scsi: megaraid_sas: Correct an error message
      scsi: megaraid_sas: Correct value passed to scsi_device_lookup()

Igor Pylypiv (1):
      scsi: pm80xx: Display proc_name in sysfs

Keoseong Park (2):
      scsi: ufs: core: Fix typo in comment
      scsi: ufs: core: Fix typo for register name in comments

Manish Rangankar (1):
      scsi: qla2xxx: Use transport-defined speed mask for supported_speeds

Markus Fuchs (1):
      scsi: ufs: core: Remove unneeded casts from void *

Michal Kubecek (1):
      scsi: mpi3mr: Select CONFIG_SCSI_SAS_ATTRS

Rafael Mendonca (1):
      scsi: qla2xxx: Fix serialization of DCBX TLV data request

Shang XiaoJing (1):
      scsi: ufs: qcom: Remove redundant dev_err() call

And the diffstat:

 drivers/scsi/lpfc/lpfc_bsg.c              |  4 ++--
 drivers/scsi/lpfc/lpfc_ct.c               |  2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c | 27 ++++++++-----------------
 drivers/scsi/mpi3mr/Kconfig               |  1 +
 drivers/scsi/pm8001/pm8001_init.c         |  1 +
 drivers/scsi/qla2xxx/qla_attr.c           | 30 +++++++++++++++++++++++++---
 drivers/target/target_core_device.c       | 19 ++++++++++++++++++
 drivers/target/target_core_iblock.c       | 19 ++++--------------
 drivers/target/target_core_internal.h     |  1 +
 drivers/target/target_core_pr.c           | 33 ++++++++++++++++++++++++-------
 drivers/target/target_core_transport.c    |  3 +--
 drivers/ufs/core/ufshcd.c                 |  4 ++--
 drivers/ufs/core/ufshpb.c                 |  6 +++---
 drivers/ufs/host/ufs-qcom-ice.c           |  1 -
 14 files changed, 96 insertions(+), 55 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index ac0c7ccf2eae..852b025e2fec 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -2582,7 +2582,7 @@ static int lpfcdiag_loop_self_unreg(struct lpfc_hba *phba, uint16_t rpi)
  *
  * This function obtains the transmit and receive ids required to send
  * an unsolicited ct command with a payload. A special lpfc FsType and CmdRsp
- * flags are used to the unsolicted response handler is able to process
+ * flags are used to the unsolicited response handler is able to process
  * the ct command sent on the same port.
  **/
 static int lpfcdiag_loop_get_xri(struct lpfc_hba *phba, uint16_t rpi,
@@ -2874,7 +2874,7 @@ diag_cmd_data_alloc(struct lpfc_hba *phba,
  * @len: Number of data bytes
  *
  * This function allocates and posts a data buffer of sufficient size to receive
- * an unsolicted CT command.
+ * an unsolicited CT command.
  **/
 static int lpfcdiag_sli3_loop_post_rxbufs(struct lpfc_hba *phba, uint16_t rxxri,
 					  size_t len)
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 75fd2bfc212b..e941a99aa965 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -90,7 +90,7 @@ lpfc_ct_ignore_hbq_buffer(struct lpfc_hba *phba, struct lpfc_iocbq *piocbq,
 				get_job_ulpstatus(phba, piocbq));
 	}
 	lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
-			"0145 Ignoring unsolicted CT HBQ Size:%d "
+			"0145 Ignoring unsolicited CT HBQ Size:%d "
 			"status = x%x\n",
 			size, get_job_ulpstatus(phba, piocbq));
 }
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 9be4ba61a076..d265a2d9d082 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5874,10 +5874,6 @@ static void megasas_setup_reply_map(struct megasas_instance *instance)
 static
 int megasas_get_device_list(struct megasas_instance *instance)
 {
-	memset(instance->pd_list, 0,
-	       (MEGASAS_MAX_PD * sizeof(struct megasas_pd_list)));
-	memset(instance->ld_ids, 0xff, MEGASAS_MAX_LD_IDS);
-
 	if (instance->enable_fw_dev_list) {
 		if (megasas_host_device_list_query(instance, true))
 			return FAILED;
@@ -7220,7 +7216,7 @@ int megasas_alloc_ctrl_dma_buffers(struct megasas_instance *instance)
 
 		if (!fusion->ioc_init_request) {
 			dev_err(&pdev->dev,
-				"Failed to allocate PD list buffer\n");
+				"Failed to allocate ioc init request\n");
 			return -ENOMEM;
 		}
 
@@ -7439,7 +7435,6 @@ static inline void megasas_init_ctrl_params(struct megasas_instance *instance)
 	    (instance->pdev->device == PCI_DEVICE_ID_LSI_SAS0071SKINNY))
 		instance->flag_ieee = 1;
 
-	megasas_dbg_lvl = 0;
 	instance->flag = 0;
 	instance->unload = 1;
 	instance->last_time = 0;
@@ -8762,33 +8757,26 @@ static
 int megasas_update_device_list(struct megasas_instance *instance,
 			       int event_type)
 {
-	int dcmd_ret = DCMD_SUCCESS;
+	int dcmd_ret;
 
 	if (instance->enable_fw_dev_list) {
-		dcmd_ret = megasas_host_device_list_query(instance, false);
-		if (dcmd_ret != DCMD_SUCCESS)
-			goto out;
+		return megasas_host_device_list_query(instance, false);
 	} else {
 		if (event_type & SCAN_PD_CHANNEL) {
 			dcmd_ret = megasas_get_pd_list(instance);
-
 			if (dcmd_ret != DCMD_SUCCESS)
-				goto out;
+				return dcmd_ret;
 		}
 
 		if (event_type & SCAN_VD_CHANNEL) {
 			if (!instance->requestorId ||
 			megasas_get_ld_vf_affiliation(instance, 0)) {
-				dcmd_ret = megasas_ld_list_query(instance,
+				return megasas_ld_list_query(instance,
 						MR_LD_QUERY_TYPE_EXPOSED_TO_HOST);
-				if (dcmd_ret != DCMD_SUCCESS)
-					goto out;
 			}
 		}
 	}
-
-out:
-	return dcmd_ret;
+	return DCMD_SUCCESS;
 }
 
 /**
@@ -8918,7 +8906,7 @@ megasas_aen_polling(struct work_struct *work)
 			sdev1 = scsi_device_lookup(instance->host,
 						   MEGASAS_MAX_PD_CHANNELS +
 						   (ld_target_id / MEGASAS_MAX_DEV_PER_CHANNEL),
-						   (ld_target_id - MEGASAS_MAX_DEV_PER_CHANNEL),
+						   (ld_target_id % MEGASAS_MAX_DEV_PER_CHANNEL),
 						   0);
 			if (sdev1)
 				megasas_remove_scsi_device(sdev1);
@@ -9016,6 +9004,7 @@ static int __init megasas_init(void)
 	 */
 	pr_info("megasas: %s\n", MEGASAS_VERSION);
 
+	megasas_dbg_lvl = 0;
 	support_poll_for_event = 2;
 	support_device_change = 1;
 	support_nvme_encapsulation = true;
diff --git a/drivers/scsi/mpi3mr/Kconfig b/drivers/scsi/mpi3mr/Kconfig
index 8997531940c2..f48740cd5b95 100644
--- a/drivers/scsi/mpi3mr/Kconfig
+++ b/drivers/scsi/mpi3mr/Kconfig
@@ -4,5 +4,6 @@ config SCSI_MPI3MR
 	tristate "Broadcom MPI3 Storage Controller Device Driver"
 	depends on PCI && SCSI
 	select BLK_DEV_BSGLIB
+	select SCSI_SAS_ATTRS
 	help
 	MPI3 based Storage & RAID Controllers Driver.
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 2ff2fac1e403..7a7d63aa90e2 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -99,6 +99,7 @@ static void pm8001_map_queues(struct Scsi_Host *shost)
 static struct scsi_host_template pm8001_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.proc_name		= DRV_NAME,
 	.queuecommand		= sas_queuecommand,
 	.dma_need_drain		= ata_scsi_dma_need_drain,
 	.target_alloc		= sas_target_alloc,
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index fa1fcbfb946f..b67ad30d56e6 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -951,9 +951,9 @@ qla2x00_sysfs_read_dcbx_tlv(struct file *filp, struct kobject *kobj,
 	if (!capable(CAP_SYS_ADMIN) || off != 0 || count > DCBX_TLV_DATA_SIZE)
 		return 0;
 
+	mutex_lock(&vha->hw->optrom_mutex);
 	if (ha->dcbx_tlv)
 		goto do_read;
-	mutex_lock(&vha->hw->optrom_mutex);
 	if (qla2x00_chip_is_down(vha)) {
 		mutex_unlock(&vha->hw->optrom_mutex);
 		return 0;
@@ -3330,11 +3330,34 @@ struct fc_function_template qla2xxx_transport_vport_functions = {
 	.bsg_timeout = qla24xx_bsg_timeout,
 };
 
+static uint
+qla2x00_get_host_supported_speeds(scsi_qla_host_t *vha, uint speeds)
+{
+	uint supported_speeds = FC_PORTSPEED_UNKNOWN;
+
+	if (speeds & FDMI_PORT_SPEED_64GB)
+		supported_speeds |= FC_PORTSPEED_64GBIT;
+	if (speeds & FDMI_PORT_SPEED_32GB)
+		supported_speeds |= FC_PORTSPEED_32GBIT;
+	if (speeds & FDMI_PORT_SPEED_16GB)
+		supported_speeds |= FC_PORTSPEED_16GBIT;
+	if (speeds & FDMI_PORT_SPEED_8GB)
+		supported_speeds |= FC_PORTSPEED_8GBIT;
+	if (speeds & FDMI_PORT_SPEED_4GB)
+		supported_speeds |= FC_PORTSPEED_4GBIT;
+	if (speeds & FDMI_PORT_SPEED_2GB)
+		supported_speeds |= FC_PORTSPEED_2GBIT;
+	if (speeds & FDMI_PORT_SPEED_1GB)
+		supported_speeds |= FC_PORTSPEED_1GBIT;
+
+	return supported_speeds;
+}
+
 void
 qla2x00_init_host_attr(scsi_qla_host_t *vha)
 {
 	struct qla_hw_data *ha = vha->hw;
-	u32 speeds = FC_PORTSPEED_UNKNOWN;
+	u32 speeds = 0, fdmi_speed = 0;
 
 	fc_host_dev_loss_tmo(vha->host) = ha->port_down_retry_count;
 	fc_host_node_name(vha->host) = wwn_to_u64(vha->node_name);
@@ -3344,7 +3367,8 @@ qla2x00_init_host_attr(scsi_qla_host_t *vha)
 	fc_host_max_npiv_vports(vha->host) = ha->max_npiv_vports;
 	fc_host_npiv_vports_inuse(vha->host) = ha->cur_vport_count;
 
-	speeds = qla25xx_fdmi_port_speed_capability(ha);
+	fdmi_speed = qla25xx_fdmi_port_speed_capability(ha);
+	speeds = qla2x00_get_host_supported_speeds(vha, fdmi_speed);
 
 	fc_host_supported_speeds(vha->host) = speeds;
 }
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index b7f16ee8aa0e..cb4f7cc02f8f 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -284,6 +284,25 @@ void target_pr_kref_release(struct kref *kref)
 	complete(&deve->pr_comp);
 }
 
+/*
+ * Establish UA condition on SCSI device - all LUNs
+ */
+void target_dev_ua_allocate(struct se_device *dev, u8 asc, u8 ascq)
+{
+	struct se_dev_entry *se_deve;
+	struct se_lun *lun;
+
+	spin_lock(&dev->se_port_lock);
+	list_for_each_entry(lun, &dev->dev_sep_list, lun_dev_link) {
+
+		spin_lock(&lun->lun_deve_lock);
+		list_for_each_entry(se_deve, &lun->lun_deve_list, lun_link)
+			core_scsi3_ua_allocate(se_deve, asc, ascq);
+		spin_unlock(&lun->lun_deve_lock);
+	}
+	spin_unlock(&dev->se_port_lock);
+}
+
 static void
 target_luns_data_has_changed(struct se_node_acl *nacl, struct se_dev_entry *new,
 			     bool skip_new)
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 8351c974cee3..d9266cf558dc 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -230,14 +230,12 @@ static void iblock_unplug_device(struct se_dev_plug *se_plug)
 	clear_bit(IBD_PLUGF_PLUGGED, &ib_dev_plug->flags);
 }
 
-static unsigned long long iblock_emulate_read_cap_with_block_size(
-	struct se_device *dev,
-	struct block_device *bd,
-	struct request_queue *q)
+static sector_t iblock_get_blocks(struct se_device *dev)
 {
-	u32 block_size = bdev_logical_block_size(bd);
+	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
+	u32 block_size = bdev_logical_block_size(ib_dev->ibd_bd);
 	unsigned long long blocks_long =
-		div_u64(bdev_nr_bytes(bd), block_size) - 1;
+		div_u64(bdev_nr_bytes(ib_dev->ibd_bd), block_size) - 1;
 
 	if (block_size == dev->dev_attrib.block_size)
 		return blocks_long;
@@ -829,15 +827,6 @@ iblock_execute_rw(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 	return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 }
 
-static sector_t iblock_get_blocks(struct se_device *dev)
-{
-	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
-	struct block_device *bd = ib_dev->ibd_bd;
-	struct request_queue *q = bdev_get_queue(bd);
-
-	return iblock_emulate_read_cap_with_block_size(dev, bd, q);
-}
-
 static sector_t iblock_get_alignment_offset_lbas(struct se_device *dev)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index 30fcf69e1a1d..38a6d08f75b3 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -89,6 +89,7 @@ int	target_configure_device(struct se_device *dev);
 void	target_free_device(struct se_device *);
 int	target_for_each_device(int (*fn)(struct se_device *dev, void *data),
 			       void *data);
+void	target_dev_ua_allocate(struct se_device *dev, u8 asc, u8 ascq);
 
 /* target_core_configfs.c */
 extern struct configfs_item_operations target_core_dev_item_ops;
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index a1d67554709f..1493b1d01194 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -2956,13 +2956,28 @@ core_scsi3_pro_preempt(struct se_cmd *cmd, int type, int scope, u64 res_key,
 			__core_scsi3_complete_pro_preempt(dev, pr_reg_n,
 				(preempt_type == PREEMPT_AND_ABORT) ? &preempt_and_abort_list : NULL,
 				type, scope, preempt_type);
-
-			if (preempt_type == PREEMPT_AND_ABORT)
-				core_scsi3_release_preempt_and_abort(
-					&preempt_and_abort_list, pr_reg_n);
 		}
+
 		spin_unlock(&dev->dev_reservation_lock);
 
+		/*
+		 * SPC-4 5.12.11.2.6 Preempting and aborting
+		 * The actions described in this subclause shall be performed
+		 * for all I_T nexuses that are registered with the non-zero
+		 * SERVICE ACTION RESERVATION KEY value, without regard for
+		 * whether the preempted I_T nexuses hold the persistent
+		 * reservation. If the SERVICE ACTION RESERVATION KEY field is
+		 * set to zero and an all registrants persistent reservation is
+		 * present, the device server shall abort all commands for all
+		 * registered I_T nexuses.
+		 */
+		if (preempt_type == PREEMPT_AND_ABORT) {
+			core_tmr_lun_reset(dev, NULL, &preempt_and_abort_list,
+					   cmd);
+			core_scsi3_release_preempt_and_abort(
+				&preempt_and_abort_list, pr_reg_n);
+		}
+
 		if (pr_tmpl->pr_aptpl_active)
 			core_scsi3_update_and_write_aptpl(cmd->se_dev, true);
 
@@ -3022,7 +3037,7 @@ core_scsi3_pro_preempt(struct se_cmd *cmd, int type, int scope, u64 res_key,
 		if (calling_it_nexus)
 			continue;
 
-		if (pr_reg->pr_res_key != sa_res_key)
+		if (sa_res_key && pr_reg->pr_res_key != sa_res_key)
 			continue;
 
 		pr_reg_nacl = pr_reg->pr_reg_nacl;
@@ -3425,8 +3440,6 @@ core_scsi3_emulate_pro_register_and_move(struct se_cmd *cmd, u64 res_key,
 	 *       transport protocols where port names are not required;
 	 * d) Register the reservation key specified in the SERVICE ACTION
 	 *    RESERVATION KEY field;
-	 * e) Retain the reservation key specified in the SERVICE ACTION
-	 *    RESERVATION KEY field and associated information;
 	 *
 	 * Also, It is not an error for a REGISTER AND MOVE service action to
 	 * register an I_T nexus that is already registered with the same
@@ -3448,6 +3461,12 @@ core_scsi3_emulate_pro_register_and_move(struct se_cmd *cmd, u64 res_key,
 		dest_pr_reg = __core_scsi3_locate_pr_reg(dev, dest_node_acl,
 						iport_ptr);
 		new_reg = 1;
+	} else {
+		/*
+		 * e) Retain the reservation key specified in the SERVICE ACTION
+		 *    RESERVATION KEY field and associated information;
+		 */
+		dest_pr_reg->pr_res_key = sa_res_key;
 	}
 	/*
 	 * f) Release the persistent reservation for the persistent reservation
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 7838dc20f713..5926316252eb 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3531,8 +3531,7 @@ static void target_tmr_work(struct work_struct *work)
 		tmr->response = (!ret) ? TMR_FUNCTION_COMPLETE :
 					 TMR_FUNCTION_REJECTED;
 		if (tmr->response == TMR_FUNCTION_COMPLETE) {
-			target_ua_allocate_lun(cmd->se_sess->se_node_acl,
-					       cmd->orig_fe_lun, 0x29,
+			target_dev_ua_allocate(dev, 0x29,
 					       ASCQ_29H_BUS_DEVICE_RESET_FUNCTION_OCCURRED);
 		}
 		break;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7256e6c43ca6..b1f59a5fe632 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -772,7 +772,7 @@ static inline void ufshcd_utrl_clear(struct ufs_hba *hba, u32 mask)
 }
 
 /**
- * ufshcd_utmrl_clear - Clear a bit in UTRMLCLR register
+ * ufshcd_utmrl_clear - Clear a bit in UTMRLCLR register
  * @hba: per adapter instance
  * @pos: position of the bit to be cleared
  */
@@ -3098,7 +3098,7 @@ static int ufshcd_query_flag_retry(struct ufs_hba *hba,
 
 	if (ret)
 		dev_err(hba->dev,
-			"%s: query attribute, opcode %d, idn %d, failed with error %d after %d retries\n",
+			"%s: query flag, opcode %d, idn %d, failed with error %d after %d retries\n",
 			__func__, opcode, idn, ret, retries);
 	return ret;
 }
diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index 3d69a81c5b17..b7f412d0f301 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -383,7 +383,7 @@ int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	rgn = hpb->rgn_tbl + rgn_idx;
 	srgn = rgn->srgn_tbl + srgn_idx;
 
-	/* If command type is WRITE or DISCARD, set bitmap as drity */
+	/* If command type is WRITE or DISCARD, set bitmap as dirty */
 	if (ufshpb_is_write_or_discard(cmd)) {
 		ufshpb_iterate_rgn(hpb, rgn_idx, srgn_idx, srgn_offset,
 				   transfer_len, true);
@@ -616,7 +616,7 @@ static void ufshpb_activate_subregion(struct ufshpb_lu *hpb,
 static enum rq_end_io_ret ufshpb_umap_req_compl_fn(struct request *req,
 						   blk_status_t error)
 {
-	struct ufshpb_req *umap_req = (struct ufshpb_req *)req->end_io_data;
+	struct ufshpb_req *umap_req = req->end_io_data;
 
 	ufshpb_put_req(umap_req->hpb, umap_req);
 	return RQ_END_IO_NONE;
@@ -625,7 +625,7 @@ static enum rq_end_io_ret ufshpb_umap_req_compl_fn(struct request *req,
 static enum rq_end_io_ret ufshpb_map_req_compl_fn(struct request *req,
 						  blk_status_t error)
 {
-	struct ufshpb_req *map_req = (struct ufshpb_req *) req->end_io_data;
+	struct ufshpb_req *map_req = req->end_io_data;
 	struct ufshpb_lu *hpb = map_req->hpb;
 	struct ufshpb_subregion *srgn;
 	unsigned long flags;
diff --git a/drivers/ufs/host/ufs-qcom-ice.c b/drivers/ufs/host/ufs-qcom-ice.c
index 745e48ec598f..62387ccd5b30 100644
--- a/drivers/ufs/host/ufs-qcom-ice.c
+++ b/drivers/ufs/host/ufs-qcom-ice.c
@@ -118,7 +118,6 @@ int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 	host->ice_mmio = devm_ioremap_resource(dev, res);
 	if (IS_ERR(host->ice_mmio)) {
 		err = PTR_ERR(host->ice_mmio);
-		dev_err(dev, "Failed to map ICE registers; err=%d\n", err);
 		return err;
 	}
 

