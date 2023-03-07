Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796EB6AF11B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjCGSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjCGSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:38:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525278F72C;
        Tue,  7 Mar 2023 10:30:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCE9C61539;
        Tue,  7 Mar 2023 18:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25DDC433A1;
        Tue,  7 Mar 2023 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678213744;
        bh=2W4mTqL66cnI3Q1Av2sbikshcnOcST9Zd6947tR9OmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7Xw7jP+vrqoeZ3kp358N9bDL9hbc/5tMOAw0BN3Zh0SUfsuCIqjHBi9/nxJU32nK
         iz5liu5dZjx8FWdacyOWiLHowKtRI6W0svfKdqsYH4AfK7dGYJ/7MxXpYpu6El+Ahm
         JY7YBdT2AF/j6qcTiT8M2C59cMVZ3qEWuWFXe6lJY4POfXM9m0ycgM54aMrViaPkSQ
         liMfQPba+kTKD7WGXlkgJnXGnFSE38j6w5E08hl+iLoLfn642zZ4rSD24CA+O0K/f2
         B+q8FBSmL7hO0tkUnp0ZR5lArcVYyMirPlX6YtcvonXA2gMzsqCfASw3WUVXE4+qRN
         UPJm8W09shCfg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 07/10] scsi: lpfc: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 12:28:39 -0600
Message-Id: <20230307182842.870378-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307182842.870378-1-helgaas@kernel.org>
References: <20230307182842.870378-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_enable_pcie_error_reporting() enables the device to send ERR_*
Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native"), the PCI core does this for all devices during enumeration, so the
driver doesn't need to do it itself.

Remove the redundant pci_enable_pcie_error_reporting() call from the
driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
from the driver .remove() path.

Note that this only controls ERR_* Messages from the device.  An ERR_*
Message may cause the Root Port to generate an interrupt, depending on the
AER Root Error Command register managed by the AER service driver.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
---
 drivers/scsi/lpfc/lpfc.h      |  2 -
 drivers/scsi/lpfc/lpfc_attr.c | 96 ++++++++++-------------------------
 drivers/scsi/lpfc/lpfc_init.c |  1 -
 drivers/scsi/lpfc/lpfc_sli.c  | 55 --------------------
 4 files changed, 27 insertions(+), 127 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index cf55f8e3bd9f..5e3a93d13a91 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1036,7 +1036,6 @@ struct lpfc_hba {
 #define FCF_TS_INPROG           0x200 /* FCF table scan in progress */
 #define FCF_RR_INPROG           0x400 /* FCF roundrobin flogi in progress */
 #define HBA_FIP_SUPPORT		0x800 /* FIP support in HBA */
-#define HBA_AER_ENABLED		0x1000 /* AER enabled with HBA */
 #define HBA_DEVLOSS_TMO         0x2000 /* HBA in devloss timeout */
 #define HBA_RRQ_ACTIVE		0x4000 /* process the rrq active list */
 #define HBA_IOQ_FLUSH		0x8000 /* FCP/NVME I/O queues being flushed */
@@ -1190,7 +1189,6 @@ struct lpfc_hba {
 #define LPFC_MAX_ENBL_FC4_TYPE LPFC_ENABLE_FCP
 #define LPFC_DEF_ENBL_FC4_TYPE LPFC_ENABLE_FCP
 #endif
-	uint32_t cfg_aer_support;
 	uint32_t cfg_sriov_nr_virtfn;
 	uint32_t cfg_request_firmware_upgrade;
 	uint32_t cfg_suppress_link_up;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 22f2e046e8eb..5cc7b59b528f 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4365,13 +4365,22 @@ static DEVICE_ATTR_RW(lpfc_link_speed);
 
 /*
 # lpfc_aer_support: Support PCIe device Advanced Error Reporting (AER)
-#       0  = aer disabled or not supported
 #       1  = aer supported and enabled (default)
-# Value range is [0,1]. Default value is 1.
+# PCIe error reporting is always enabled by the PCI core, so this always
+# shows 1.
+#
+# N.B. Parts of LPFC_ATTR open-coded since some of the underlying
+# infrastructure (phba->cfg_aer_support) is gone.
 */
-LPFC_ATTR(aer_support, 1, 0, 1,
-	"Enable PCIe device AER support");
-lpfc_param_show(aer_support)
+static uint lpfc_aer_support = 1;
+module_param(lpfc_aer_support, uint, S_IRUGO);
+MODULE_PARM_DESC(lpfc_aer_support, "Enable PCIe device AER support");
+static ssize_t
+lpfc_aer_support_show(struct device *dev, struct device_attribute *attr,
+		      char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", lpfc_aer_support);
+}
 
 /**
  * lpfc_aer_support_store - Set the adapter for aer support
@@ -4382,76 +4391,27 @@ lpfc_param_show(aer_support)
  * @count: unused variable.
  *
  * Description:
- * If the val is 1 and currently the device's AER capability was not
- * enabled, invoke the kernel's enable AER helper routine, trying to
- * enable the device's AER capability. If the helper routine enabling
- * AER returns success, update the device's cfg_aer_support flag to
- * indicate AER is supported by the device; otherwise, if the device
- * AER capability is already enabled to support AER, then do nothing.
- *
- * If the val is 0 and currently the device's AER support was enabled,
- * invoke the kernel's disable AER helper routine. After that, update
- * the device's cfg_aer_support flag to indicate AER is not supported
- * by the device; otherwise, if the device AER capability is already
- * disabled from supporting AER, then do nothing.
+ * PCIe error reporting is enabled by the PCI core, so drivers don't need
+ * to do anything.  Retain this interface for backwards compatibility,
+ * but do nothing.
  *
  * Returns:
- * length of the buf on success if val is in range the intended mode
- * is supported.
- * -EINVAL if val out of range or intended mode is not supported.
+ * length of the buf on success
+ * -EINVAL if val out of range
  **/
 static ssize_t
 lpfc_aer_support_store(struct device *dev, struct device_attribute *attr,
 		       const char *buf, size_t count)
 {
-	struct Scsi_Host *shost = class_to_shost(dev);
-	struct lpfc_vport *vport = (struct lpfc_vport *)shost->hostdata;
-	struct lpfc_hba *phba = vport->phba;
-	int val = 0, rc = -EINVAL;
+	int val = 0;
 
 	if (!isdigit(buf[0]))
 		return -EINVAL;
 	if (sscanf(buf, "%i", &val) != 1)
 		return -EINVAL;
 
-	switch (val) {
-	case 0:
-		if (phba->hba_flag & HBA_AER_ENABLED) {
-			rc = pci_disable_pcie_error_reporting(phba->pcidev);
-			if (!rc) {
-				spin_lock_irq(&phba->hbalock);
-				phba->hba_flag &= ~HBA_AER_ENABLED;
-				spin_unlock_irq(&phba->hbalock);
-				phba->cfg_aer_support = 0;
-				rc = strlen(buf);
-			} else
-				rc = -EPERM;
-		} else {
-			phba->cfg_aer_support = 0;
-			rc = strlen(buf);
-		}
-		break;
-	case 1:
-		if (!(phba->hba_flag & HBA_AER_ENABLED)) {
-			rc = pci_enable_pcie_error_reporting(phba->pcidev);
-			if (!rc) {
-				spin_lock_irq(&phba->hbalock);
-				phba->hba_flag |= HBA_AER_ENABLED;
-				spin_unlock_irq(&phba->hbalock);
-				phba->cfg_aer_support = 1;
-				rc = strlen(buf);
-			} else
-				 rc = -EPERM;
-		} else {
-			phba->cfg_aer_support = 1;
-			rc = strlen(buf);
-		}
-		break;
-	default:
-		rc = -EINVAL;
-		break;
-	}
-	return rc;
+	dev_info_once(dev, "PCIe error reporting automatically enabled by the PCI core; sysfs write ignored\n");
+	return strlen(buf);
 }
 
 static DEVICE_ATTR_RW(lpfc_aer_support);
@@ -4464,16 +4424,16 @@ static DEVICE_ATTR_RW(lpfc_aer_support);
  * @count: unused variable.
  *
  * Description:
- * If the @buf contains 1 and the device currently has the AER support
- * enabled, then invokes the kernel AER helper routine
+ * If the @buf contains 1, invokes the kernel AER helper routine
  * pci_aer_clear_nonfatal_status() to clean up the uncorrectable
  * error status register.
  *
  * Notes:
  *
  * Returns:
- * -EINVAL if the buf does not contain the 1 or the device is not currently
- * enabled with the AER support.
+ * -EINVAL if the buf does not contain 1
+ * -EPERM if the OS cannot clear AER error status, i.e., when platform
+ * firmware owns the AER Capability
  **/
 static ssize_t
 lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
@@ -4491,8 +4451,7 @@ lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
 	if (val != 1)
 		return -EINVAL;
 
-	if (phba->hba_flag & HBA_AER_ENABLED)
-		rc = pci_aer_clear_nonfatal_status(phba->pcidev);
+	rc = pci_aer_clear_nonfatal_status(phba->pcidev);
 
 	if (rc == 0)
 		return strlen(buf);
@@ -7277,7 +7236,6 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 
 	lpfc_sg_seg_cnt_init(phba, lpfc_sg_seg_cnt);
 	lpfc_hba_queue_depth_init(phba, lpfc_hba_queue_depth);
-	lpfc_aer_support_init(phba, lpfc_aer_support);
 	lpfc_sriov_nr_virtfn_init(phba, lpfc_sriov_nr_virtfn);
 	lpfc_request_firmware_upgrade_init(phba, lpfc_req_fw_upgrade);
 	lpfc_suppress_link_up_init(phba, lpfc_suppress_link_up);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 61958a24a43d..d3d4477dd472 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -32,7 +32,6 @@
 #include <linux/spinlock.h>
 #include <linux/sched/clock.h>
 #include <linux/ctype.h>
-#include <linux/aer.h>
 #include <linux/slab.h>
 #include <linux/firmware.h>
 #include <linux/miscdevice.h>
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index c5b69f313af3..b2294e638e29 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -34,7 +34,6 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_transport_fc.h>
 #include <scsi/fc/fc_fs.h>
-#include <linux/aer.h>
 #include <linux/crash_dump.h>
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
@@ -5204,13 +5203,9 @@ lpfc_sli_brdrestart_s3(struct lpfc_hba *phba)
 	volatile struct MAILBOX_word0 mb;
 	struct lpfc_sli *psli;
 	void __iomem *to_slim;
-	uint32_t hba_aer_enabled;
 
 	spin_lock_irq(&phba->hbalock);
 
-	/* Take PCIe device Advanced Error Reporting (AER) state */
-	hba_aer_enabled = phba->hba_flag & HBA_AER_ENABLED;
-
 	psli = &phba->sli;
 
 	/* Restart HBA */
@@ -5251,10 +5246,6 @@ lpfc_sli_brdrestart_s3(struct lpfc_hba *phba)
 	/* Give the INITFF and Post time to settle. */
 	mdelay(100);
 
-	/* Reset HBA AER if it was enabled, note hba_flag was reset above */
-	if (hba_aer_enabled)
-		pci_disable_pcie_error_reporting(phba->pcidev);
-
 	lpfc_hba_down_post(phba);
 
 	return 0;
@@ -5273,7 +5264,6 @@ static int
 lpfc_sli_brdrestart_s4(struct lpfc_hba *phba)
 {
 	struct lpfc_sli *psli = &phba->sli;
-	uint32_t hba_aer_enabled;
 	int rc;
 
 	/* Restart HBA */
@@ -5281,9 +5271,6 @@ lpfc_sli_brdrestart_s4(struct lpfc_hba *phba)
 			"0296 Restart HBA Data: x%x x%x\n",
 			phba->pport->port_state, psli->sli_flag);
 
-	/* Take PCIe device Advanced Error Reporting (AER) state */
-	hba_aer_enabled = phba->hba_flag & HBA_AER_ENABLED;
-
 	rc = lpfc_sli4_brdreset(phba);
 	if (rc) {
 		phba->link_state = LPFC_HBA_ERROR;
@@ -5301,10 +5288,6 @@ lpfc_sli_brdrestart_s4(struct lpfc_hba *phba)
 	memset(&psli->lnk_stat_offsets, 0, sizeof(psli->lnk_stat_offsets));
 	psli->stats_start = ktime_get_seconds();
 
-	/* Reset HBA AER if it was enabled, note hba_flag was reset above */
-	if (hba_aer_enabled)
-		pci_disable_pcie_error_reporting(phba->pcidev);
-
 hba_down_queue:
 	lpfc_hba_down_post(phba);
 	lpfc_sli4_queue_destroy(phba);
@@ -5725,25 +5708,6 @@ lpfc_sli_hba_setup(struct lpfc_hba *phba)
 	}
 	phba->fcp_embed_io = 0;	/* SLI4 FC support only */
 
-	/* Enable PCIe device Advanced Error Reporting (AER) if configured */
-	if (phba->cfg_aer_support == 1 && !(phba->hba_flag & HBA_AER_ENABLED)) {
-		rc = pci_enable_pcie_error_reporting(phba->pcidev);
-		if (!rc) {
-			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-					"2709 This device supports "
-					"Advanced Error Reporting (AER)\n");
-			spin_lock_irq(&phba->hbalock);
-			phba->hba_flag |= HBA_AER_ENABLED;
-			spin_unlock_irq(&phba->hbalock);
-		} else {
-			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-					"2708 This device does not support "
-					"Advanced Error Reporting (AER): %d\n",
-					rc);
-			phba->cfg_aer_support = 0;
-		}
-	}
-
 	if (phba->sli_rev == 3) {
 		phba->iocb_cmd_size = SLI3_IOCB_CMD_SIZE;
 		phba->iocb_rsp_size = SLI3_IOCB_RSP_SIZE;
@@ -9053,25 +9017,6 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	mod_timer(&phba->eratt_poll,
 		  jiffies + msecs_to_jiffies(1000 * phba->eratt_poll_interval));
 
-	/* Enable PCIe device Advanced Error Reporting (AER) if configured */
-	if (phba->cfg_aer_support == 1 && !(phba->hba_flag & HBA_AER_ENABLED)) {
-		rc = pci_enable_pcie_error_reporting(phba->pcidev);
-		if (!rc) {
-			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-					"2829 This device supports "
-					"Advanced Error Reporting (AER)\n");
-			spin_lock_irq(&phba->hbalock);
-			phba->hba_flag |= HBA_AER_ENABLED;
-			spin_unlock_irq(&phba->hbalock);
-		} else {
-			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-					"2830 This device does not support "
-					"Advanced Error Reporting (AER)\n");
-			phba->cfg_aer_support = 0;
-		}
-		rc = 0;
-	}
-
 	/*
 	 * The port is ready, set the host's link state to LINK_DOWN
 	 * in preparation for link interrupts.
-- 
2.25.1

