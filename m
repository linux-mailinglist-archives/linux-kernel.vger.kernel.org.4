Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5636B6E0C28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDMLLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDMLLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:11:31 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C0FC77687;
        Thu, 13 Apr 2023 04:11:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 2509C18010E345;
        Thu, 13 Apr 2023 19:11:20 +0800 (CST)
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Li Qiong <liqiong@nfschina.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Qiong <liqiong@nfschina.com>
Subject: [PATCH 2/4] scsi: lpfc: Remove unnecessary (void*) conversions
Date:   Thu, 13 Apr 2023 19:10:31 +0800
Message-Id: <20230413111031.9034-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to cast (void*) pointer to other type.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 drivers/scsi/lpfc/lpfc_attr.c    |  2 +-
 drivers/scsi/lpfc/lpfc_debugfs.c |  2 +-
 drivers/scsi/lpfc/lpfc_nvme.c    | 32 ++++++++++++++++----------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 22f2e046e8eb..0a8c872efc02 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -514,7 +514,7 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 				wwn_to_u64(vport->fc_portname.u.wwn));
 		return len;
 	}
-	lport = (struct lpfc_nvme_lport *)localport->private;
+	lport = localport->private;
 	if (strlcat(buf, "\nNVME Initiator Enabled\n", PAGE_SIZE) >= PAGE_SIZE)
 		goto buffer_done;
 
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index f5252e45a48a..99a6d338ed80 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -1166,7 +1166,7 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
 		localport = vport->localport;
 		if (!localport)
 			return len;
-		lport = (struct lpfc_nvme_lport *)localport->private;
+		lport = localport->private;
 		if (!lport)
 			return len;
 
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 152245f7cacc..7aedbc811502 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -91,7 +91,7 @@ lpfc_nvme_create_queue(struct nvme_fc_local_port *pnvme_lport,
 	if (!pnvme_lport->private)
 		return -ENOMEM;
 
-	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
+	lport = pnvme_lport->private;
 	vport = lport->vport;
 
 	if (!vport || vport->load_flag & FC_UNLOADING ||
@@ -151,7 +151,7 @@ lpfc_nvme_delete_queue(struct nvme_fc_local_port *pnvme_lport,
 	if (!pnvme_lport->private)
 		return;
 
-	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
+	lport = pnvme_lport->private;
 	vport = lport->vport;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME,
@@ -370,7 +370,7 @@ lpfc_nvme_ls_req_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	status = bf_get(lpfc_wcqe_c_status, wcqe) & LPFC_IOCB_STATUS_MASK;
 
 	if (vport->localport) {
-		lport = (struct lpfc_nvme_lport *)vport->localport->private;
+		lport = vport->localport->private;
 		if (lport) {
 			atomic_inc(&lport->fc4NvmeLsCmpls);
 			if (status) {
@@ -666,8 +666,8 @@ lpfc_nvme_ls_req(struct nvme_fc_local_port *pnvme_lport,
 	struct lpfc_vport *vport;
 	int ret;
 
-	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
-	rport = (struct lpfc_nvme_rport *)pnvme_rport->private;
+	lport = pnvme_lport->private;
+	rport = pnvme_rport->private;
 	if (unlikely(!lport) || unlikely(!rport))
 		return -EINVAL;
 
@@ -766,7 +766,7 @@ lpfc_nvme_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	if (axchg->phba->pport->load_flag & FC_UNLOADING)
 		return -ENODEV;
 
-	lport = (struct lpfc_nvme_lport *)localport->private;
+	lport = localport->private;
 
 	rc = __lpfc_nvme_xmt_ls_rsp(axchg, ls_rsp, __lpfc_nvme_xmt_ls_rsp_cmp);
 
@@ -803,7 +803,7 @@ lpfc_nvme_ls_abort(struct nvme_fc_local_port *pnvme_lport,
 	struct lpfc_nodelist *ndlp;
 	int ret;
 
-	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
+	lport = pnvme_lport->private;
 	if (unlikely(!lport))
 		return;
 	vport = lport->vport;
@@ -979,7 +979,7 @@ lpfc_nvme_io_cmd_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	phba->sli4_hba.hdwq[idx].nvme_cstat.io_cmpls++;
 
 	if (unlikely(status && vport->localport)) {
-		lport = (struct lpfc_nvme_lport *)vport->localport->private;
+		lport = vport->localport->private;
 		if (lport) {
 			if (bf_get(lpfc_wcqe_c_xb, wcqe))
 				atomic_inc(&lport->cmpl_fcp_xb);
@@ -1545,7 +1545,7 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 	/* Validate pointers. LLDD fault handling with transport does
 	 * have timing races.
 	 */
-	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
+	lport = pnvme_lport->private;
 	if (unlikely(!lport)) {
 		ret = -EINVAL;
 		goto out_fail;
@@ -1585,7 +1585,7 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 	if (phba->ktime_on)
 		start = ktime_get_ns();
 #endif
-	rport = (struct lpfc_nvme_rport *)pnvme_rport->private;
+	rport = pnvme_rport->private;
 	lpfc_queue_info = (struct lpfc_nvme_qhandle *)hw_queue_handle;
 
 	/*
@@ -1866,7 +1866,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	/* Validate pointers. LLDD fault handling with transport does
 	 * have timing races.
 	 */
-	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
+	lport = pnvme_lport->private;
 	if (unlikely(!lport))
 		return;
 
@@ -2192,7 +2192,7 @@ lpfc_nvme_create_localport(struct lpfc_vport *vport)
 				 lpfc_nvme_template.max_sgl_segments);
 
 		/* Private is our lport size declared in the template. */
-		lport = (struct lpfc_nvme_lport *)localport->private;
+		lport = localport->private;
 		vport->localport = localport;
 		lport->vport = vport;
 		vport->nvmei_support = 1;
@@ -2309,7 +2309,7 @@ lpfc_nvme_destroy_localport(struct lpfc_vport *vport)
 	localport = vport->localport;
 	if (!localport)
 		return;
-	lport = (struct lpfc_nvme_lport *)localport->private;
+	lport = localport->private;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME,
 			 "6011 Destroying NVME localport x%px\n",
@@ -2359,7 +2359,7 @@ lpfc_nvme_update_localport(struct lpfc_vport *vport)
 				 "6710 Update NVME fail. No localport\n");
 		return;
 	}
-	lport = (struct lpfc_nvme_lport *)localport->private;
+	lport = localport->private;
 	if (!lport) {
 		lpfc_printf_vlog(vport, KERN_WARNING, LOG_NVME,
 				 "6171 Update NVME fail. localP x%px, No lport\n",
@@ -2404,7 +2404,7 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	if (!localport)
 		return 0;
 
-	lport = (struct lpfc_nvme_lport *)localport->private;
+	lport = localport->private;
 
 	/* NVME rports are not preserved across devloss.
 	 * Just register this instance.  Note, rpinfo->dev_loss_tmo
@@ -2593,7 +2593,7 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	if (!localport)
 		return;
 
-	lport = (struct lpfc_nvme_lport *)localport->private;
+	lport = localport->private;
 	if (!lport)
 		goto input_err;
 
-- 
2.11.0

