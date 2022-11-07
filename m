Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDFB61F40D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiKGNLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiKGNLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:11:04 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B9A1C921;
        Mon,  7 Nov 2022 05:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667826655;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=q1J6XpIe/9MO4lE/o05tOqolPRNB84M1cOMhaBrvy1I=;
    b=bj9KSEKpcack2YMlTpUcH/AIRIMFG8T2+OG1Vr5k7aj/3u5UNEa/V6xhg2EKHOcKH4
    izY8GkEJW+J53jAheDT1QJRtTVMoNU89Z1He0No/+XNK5rfdh/U/KAynm/ER1r3hKy8Y
    hnud5sotul4hdhHD5KDY2Jk+5cg4OLzn5U33yV9WMN5mSM/wNB9udUZRiKiqqQGSZSak
    i9l0XcuAL8SXlSbiML68OMj7l7ad5SQ8MX0312YdvPS/vFfU68xgSFCi7SG6Fjgw2hc1
    +vZvh0Ppx+OFgfGyLowrAQE4fUlyN+XaCDKQ2XC1jNRJhLMt9DTzBtJS5u5WO1W9fVnR
    meKw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RvWtIeMr7Q/U8vM/+oObyVBycbphAC+CkWyag=="
X-RZG-CLASS-ID: mo02
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyA7DAtjGB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 7 Nov 2022 14:10:55 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@iokpp.de>
Subject: [RFC PATCH v1 2/2] ufs: core: Add advanced RPMB support in ufs_bsg
Date:   Mon,  7 Nov 2022 14:10:38 +0100
Message-Id: <20221107131038.201724-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107131038.201724-1-beanhuo@iokpp.de>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add advanced RPMB support in ufs_bsg. For these reasons, we try to implement
Advanced RPMB in ufs_bsg:

1. According to the UFS specification, only one RPMB operation can be
performed at any time. We can ensure this by using reserved slot and its
dev_cmd sync operation protection mechanism.

2. Fort the Advanced RPMB, RPMB metadata is packaged in an EHS (to device)
of the UPIU, and the corresponding reply EHS (from the device) should also
be returned to the user space. bsg_job->reuqest and bsg_job->reply allow us
to pass and return EHS from/back to userspace.

Compared to normal/legacy RPMB, the advantage of advanced RPMB are:

1. The data length in the RPBM data read/write command could be > 4KB. For
the legacy RPMB, the data length in a single RPMB data transfer is 256 bytes.
2.  All of the advanced RPMB operations will be a single command shot. but for
the legacy  RPBM, take the read write-counter value  as an example, you need
two commands(first SECURITY PROTOCOL OUT, then the second SECURITY PROTOCOL IN)

Signed-off-by: Bean Huo <beanhuo@iokpp.de>
---
 drivers/ufs/core/ufs_bsg.c       | 115 +++++++++++++---------
 drivers/ufs/core/ufshcd.c        | 157 ++++++++++++++++++++++++-------
 include/uapi/scsi/scsi_bsg_ufs.h |  30 +++++-
 include/ufs/ufshcd.h             |   5 +
 4 files changed, 226 insertions(+), 81 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index b99e3f3dc4ef..6c6a27ad49d5 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -8,8 +8,10 @@
 #include <linux/bsg-lib.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
-#include "ufs_bsg.h"
+#include <linux/dma-mapping.h>
 #include <ufs/ufshcd.h>
+
+#include "ufs_bsg.h"
 #include "ufshcd-priv.h"
 
 static int ufs_bsg_get_query_desc_size(struct ufs_hba *hba, int *desc_len,
@@ -30,21 +32,6 @@ static int ufs_bsg_get_query_desc_size(struct ufs_hba *hba, int *desc_len,
 	return 0;
 }
 
-static int ufs_bsg_verify_query_size(struct ufs_hba *hba,
-				     unsigned int request_len,
-				     unsigned int reply_len)
-{
-	int min_req_len = sizeof(struct ufs_bsg_request);
-	int min_rsp_len = sizeof(struct ufs_bsg_reply);
-
-	if (min_req_len > request_len || min_rsp_len > reply_len) {
-		dev_err(hba->dev, "not enough space assigned\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int ufs_bsg_alloc_desc_buffer(struct ufs_hba *hba, struct bsg_job *job,
 				     uint8_t **desc_buff, int *desc_len,
 				     enum query_opcode desc_op)
@@ -83,23 +70,53 @@ static int ufs_bsg_alloc_desc_buffer(struct ufs_hba *hba, struct bsg_job *job,
 	return 0;
 }
 
+static int ufshcd_exec_advanced_rpmb_req(struct ufs_hba *hba, struct bsg_job *job,
+					 struct bsg_buffer *bbuf, int msgcode, int len)
+{
+	struct ufs_rpmb_request *rpmb_request = job->request;
+	struct ufs_rpmb_reply *rpmb_reply = job->reply;
+	enum dma_data_direction dir = DMA_NONE;
+	int mapped_sg_cnt;
+	int ret;
+
+	if (hba->ufs_version < ufshci_version(4, 0) || !hba->dev_info.b_advanced_rpmb_en)
+		return -EINVAL;
+
+	if (msgcode == UPIU_TRANSACTION_ARPMB_DATA_WRITE)
+		dir = DMA_TO_DEVICE;
+	else if (msgcode == UPIU_TRANSACTION_ARPMB_DATA_READ)
+		dir = DMA_FROM_DEVICE;
+
+	if (dir != DMA_NONE && bbuf->sg_cnt) {
+		mapped_sg_cnt = dma_map_sg(hba->host->dma_dev, bbuf->sg_list, bbuf->sg_cnt, dir);
+		if (unlikely(!mapped_sg_cnt))
+			return -ENOMEM;
+	}
+
+	ret = ufshcd_advanced_rpmb_req_handler(hba, &rpmb_request->bsg_request.upiu_req,
+				   &rpmb_reply->bsg_reply.upiu_rsp, &rpmb_request->ehs_req,
+				   &rpmb_reply->ehs_rsp, mapped_sg_cnt, bbuf->sg_list,
+				   dir, len);
+
+	if (dir != DMA_NONE && bbuf->sg_cnt)
+		dma_unmap_sg(hba->host->dma_dev, bbuf->sg_list, bbuf->sg_cnt, dir);
+
+	return ret;
+}
+
 static int ufs_bsg_request(struct bsg_job *job)
 {
 	struct ufs_bsg_request *bsg_request = job->request;
 	struct ufs_bsg_reply *bsg_reply = job->reply;
 	struct ufs_hba *hba = shost_priv(dev_to_shost(job->dev->parent));
-	unsigned int req_len = job->request_len;
-	unsigned int reply_len = job->reply_len;
 	struct uic_command uc = {};
 	int msgcode;
-	uint8_t *desc_buff = NULL;
+	uint8_t *buff = NULL;
 	int desc_len = 0;
 	enum query_opcode desc_op = UPIU_QUERY_OPCODE_NOP;
 	int ret;
-
-	ret = ufs_bsg_verify_query_size(hba, req_len, reply_len);
-	if (ret)
-		goto out;
+	struct bsg_buffer *bbuf = NULL;
+	bool rpmb = false;
 
 	bsg_reply->reply_payload_rcv_len = 0;
 
@@ -109,34 +126,52 @@ static int ufs_bsg_request(struct bsg_job *job)
 	switch (msgcode) {
 	case UPIU_TRANSACTION_QUERY_REQ:
 		desc_op = bsg_request->upiu_req.qr.opcode;
-		ret = ufs_bsg_alloc_desc_buffer(hba, job, &desc_buff,
+		ret = ufs_bsg_alloc_desc_buffer(hba, job, &buff,
 						&desc_len, desc_op);
-		if (ret) {
-			ufshcd_rpm_put_sync(hba);
+		if (ret)
 			goto out;
-		}
 
 		fallthrough;
 	case UPIU_TRANSACTION_NOP_OUT:
 	case UPIU_TRANSACTION_TASK_REQ:
 		ret = ufshcd_exec_raw_upiu_cmd(hba, &bsg_request->upiu_req,
 					       &bsg_reply->upiu_rsp, msgcode,
-					       desc_buff, &desc_len, desc_op);
+					       buff, &desc_len, desc_op);
 		if (ret)
-			dev_err(hba->dev,
-				"exe raw upiu: error code %d\n", ret);
+			dev_err(hba->dev, "exe raw upiu: error code %d\n", ret);
+		else if (desc_op == UPIU_QUERY_OPCODE_READ_DESC && desc_len)
+			bsg_reply->reply_payload_rcv_len =
+				sg_copy_from_buffer(job->request_payload.sg_list,
+						    job->request_payload.sg_cnt, buff, desc_len);
 
 		break;
 	case UPIU_TRANSACTION_UIC_CMD:
 		memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE);
 		ret = ufshcd_send_uic_cmd(hba, &uc);
 		if (ret)
-			dev_err(hba->dev,
-				"send uic cmd: error code %d\n", ret);
+			dev_err(hba->dev, "send uic cmd: error code %d\n", ret);
 
 		memcpy(&bsg_reply->upiu_rsp.uc, &uc, UIC_CMD_SIZE);
 
 		break;
+	case UPIU_TRANSACTION_ARPMB_DATA_READ:
+	case UPIU_TRANSACTION_ARPMB_DATA_WRITE:
+		if (!job->request_payload.payload_len || job->request_payload.payload_len > 4096) {
+			ret =  -EINVAL;
+			goto out;
+		}
+		bbuf = &job->request_payload;
+		fallthrough;
+	case UPIU_TRANSACTION_ARPMB_PROGRAM_KEY:
+	case UPIU_TRANSACTION_ARPMB_READ_COUNTER:
+		rpmb = true;
+		ret = ufshcd_exec_advanced_rpmb_req(hba, job, bbuf, msgcode,
+						    job->request_payload.payload_len);
+		if (ret)
+			dev_err(hba->dev, "RPMB OP failed: error code  %d\n", ret);
+		else if (msgcode == UPIU_TRANSACTION_ARPMB_READ_COUNTER)
+			bsg_reply->reply_payload_rcv_len = job->request_payload.payload_len;
+		break;
 	default:
 		ret = -ENOTSUPP;
 		dev_err(hba->dev, "unsupported msgcode 0x%x\n", msgcode);
@@ -144,22 +179,12 @@ static int ufs_bsg_request(struct bsg_job *job)
 		break;
 	}
 
+out:
 	ufshcd_rpm_put_sync(hba);
+	kfree(buff);
 
-	if (!desc_buff)
-		goto out;
-
-	if (desc_op == UPIU_QUERY_OPCODE_READ_DESC && desc_len)
-		bsg_reply->reply_payload_rcv_len =
-			sg_copy_from_buffer(job->request_payload.sg_list,
-					    job->request_payload.sg_cnt,
-					    desc_buff, desc_len);
-
-	kfree(desc_buff);
-
-out:
 	bsg_reply->result = ret;
-	job->reply_len = sizeof(struct ufs_bsg_reply);
+	job->reply_len = !rpmb ? sizeof(struct ufs_bsg_reply) : sizeof(struct ufs_rpmb_reply);
 	/* complete the job here only if no error */
 	if (ret == 0)
 		bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d49e7a0b82ca..592ee3809c16 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -56,6 +56,9 @@
 /* Query request timeout */
 #define QUERY_REQ_TIMEOUT 1500 /* 1.5 seconds */
 
+/* Advanced RPMB request timeout */
+#define ADVANCED_RPMB_REQ_TIMEOUT  4500 /* 3 seconds */
+
 /* Task management command timeout */
 #define TM_CMD_TIMEOUT	100 /* msecs */
 
@@ -2399,40 +2402,32 @@ int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 }
 
 /**
- * ufshcd_map_sg - Map scatter-gather list to prdt
- * @hba: per adapter instance
- * @lrbp: pointer to local reference block
- *
- * Returns 0 in case of success, non-zero value in case of failure
+ * ufshcd_sgl_to_prdt - SG list to PRTD (Physical Region Description Table, 4DW format)
+ * @hba:	per-adapter instance
+ * @lrbp:	pointer to local reference block
+ * @sg_entries:	The number of sg lists actually used
+ * @sg_list:	Pointer to SG list
  */
-static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
+static void ufshcd_sgl_to_prdt(struct ufs_hba *hba, struct ufshcd_lrb *lrbp, int sg_entries,
+		    struct scatterlist *sg_list)
+
 {
 	struct ufshcd_sg_entry *prd_table;
 	struct scatterlist *sg;
-	struct scsi_cmnd *cmd;
-	int sg_segments;
 	int i;
 
-	cmd = lrbp->cmd;
-	sg_segments = scsi_dma_map(cmd);
-	if (sg_segments < 0)
-		return sg_segments;
-
-	if (sg_segments) {
+	if (sg_entries) {
 
 		if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN)
 			lrbp->utr_descriptor_ptr->prd_table_length =
-				cpu_to_le16((sg_segments *
-					sizeof(struct ufshcd_sg_entry)));
+				cpu_to_le16((sg_entries * sizeof(struct ufshcd_sg_entry)));
 		else
-			lrbp->utr_descriptor_ptr->prd_table_length =
-				cpu_to_le16(sg_segments);
+			lrbp->utr_descriptor_ptr->prd_table_length = cpu_to_le16(sg_entries);
 
 		prd_table = lrbp->ucd_prdt_ptr;
 
-		scsi_for_each_sg(cmd, sg, sg_segments, i) {
+		for_each_sg(sg_list, sg, sg_entries, i) {
 			const unsigned int len = sg_dma_len(sg);
-
 			/*
 			 * From the UFSHCI spec: "Data Byte Count (DBC): A '0'
 			 * based value that indicates the length, in bytes, of
@@ -2449,6 +2444,26 @@ static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	} else {
 		lrbp->utr_descriptor_ptr->prd_table_length = 0;
 	}
+}
+
+/**
+ * ufshcd_map_sg - Map scatter-gather list to prdt
+ * @hba: per adapter instance
+ * @lrbp: pointer to local reference block
+ *
+ * Returns 0 in case of success, non-zero value in case of failure
+ */
+static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
+{
+	struct scsi_cmnd *cmd;
+	int sg_segments;
+
+	cmd = lrbp->cmd;
+	sg_segments = scsi_dma_map(cmd);
+	if (sg_segments < 0)
+		return sg_segments;
+
+	ufshcd_sgl_to_prdt(hba, lrbp, sg_segments, scsi_sglist(cmd));
 
 	return 0;
 }
@@ -2496,14 +2511,14 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
 }
 
 /**
- * ufshcd_prepare_req_desc_hdr() - Fills the requests header
- * descriptor according to request
- * @lrbp: pointer to local reference block
+ * ufshcd_prepare_req_desc_hdr - Fills UTP Transfer request descriptor header according to request
+ * @lrbp:	pointer to local reference block
  * @upiu_flags: flags required in the header
- * @cmd_dir: requests data direction
+ * @cmd_dir:	requests data direction
+ * @ehs_length: Total EHS Length (in 32‐bytes units of all Extra Header Segments)
  */
-static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
-			u8 *upiu_flags, enum dma_data_direction cmd_dir)
+static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp, u8 *upiu_flags,
+					enum dma_data_direction cmd_dir, int ehs_length)
 {
 	struct utp_transfer_req_desc *req_desc = lrbp->utr_descriptor_ptr;
 	u32 data_direction;
@@ -2522,8 +2537,9 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 		*upiu_flags = UPIU_CMD_FLAGS_NONE;
 	}
 
-	dword_0 = data_direction | (lrbp->command_type
-				<< UPIU_COMMAND_TYPE_OFFSET);
+	dword_0 = data_direction | (lrbp->command_type << UPIU_COMMAND_TYPE_OFFSET) |
+		ehs_length << 8;
+
 	if (lrbp->intr_cmd)
 		dword_0 |= UTP_REQ_DESC_INT_CMD;
 
@@ -2546,8 +2562,7 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 }
 
 /**
- * ufshcd_prepare_utp_scsi_cmd_upiu() - fills the utp_transfer_req_desc,
- * for scsi commands
+ * ufshcd_prepare_utp_scsi_cmd_upiu() - fills the utp_transfer_req_desc for scsi commands
  * @lrbp: local reference block pointer
  * @upiu_flags: flags
  */
@@ -2578,8 +2593,7 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufshcd_lrb *lrbp, u8 upiu_flags)
 }
 
 /**
- * ufshcd_prepare_utp_query_req_upiu() - fills the utp_transfer_req_desc,
- * for query requsts
+ * ufshcd_prepare_utp_query_req_upiu() - fills the utp_transfer_req_desc for query requsts
  * @hba: UFS hba
  * @lrbp: local reference block pointer
  * @upiu_flags: flags
@@ -2650,7 +2664,7 @@ static int ufshcd_compose_devman_upiu(struct ufs_hba *hba,
 	else
 		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
 
-	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE);
+	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE, 0);
 	if (hba->dev_cmd.type == DEV_CMD_TYPE_QUERY)
 		ufshcd_prepare_utp_query_req_upiu(hba, lrbp, upiu_flags);
 	else if (hba->dev_cmd.type == DEV_CMD_TYPE_NOP)
@@ -2679,7 +2693,7 @@ static int ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 
 	if (likely(lrbp->cmd)) {
 		ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags,
-						lrbp->cmd->sc_data_direction);
+						lrbp->cmd->sc_data_direction, 0);
 		ufshcd_prepare_utp_scsi_cmd_upiu(lrbp, upiu_flags);
 	} else {
 		ret = -EINVAL;
@@ -2945,6 +2959,12 @@ ufshcd_dev_cmd_completion(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 		dev_err(hba->dev, "%s: Reject UPIU not fully implemented\n",
 				__func__);
 		break;
+	case UPIU_TRANSACTION_RESPONSE:
+		if (hba->dev_cmd.type != DEV_CMD_TYPE_RPMB) {
+			err = -EINVAL;
+			dev_err(hba->dev, "%s: unexpected response %x\n", __func__, resp);
+		}
+		break;
 	default:
 		err = -EINVAL;
 		dev_err(hba->dev, "%s: Invalid device management cmd response: %x\n",
@@ -6838,7 +6858,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	/* update the task tag in the request upiu */
 	req_upiu->header.dword_0 |= cpu_to_be32(tag);
 
-	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE);
+	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE, 0);
 
 	/* just copy the upiu request as it is */
 	memcpy(lrbp->ucd_req_ptr, req_upiu, sizeof(*lrbp->ucd_req_ptr));
@@ -6961,6 +6981,73 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 	return err;
 }
 
+int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *req_upiu,
+			 struct utp_upiu_req *rsp_upiu, struct ufs_ehs *ehs_req,
+			 struct ufs_ehs *ehs_rsp, int sg_cnt, struct scatterlist *sg_list,
+			 enum dma_data_direction dir, int len)
+{
+	DECLARE_COMPLETION_ONSTACK(wait);
+	const u32 tag = hba->reserved_slot;
+	struct ufshcd_lrb *lrbp;
+	int err = 0;
+	u8 upiu_flags;
+
+	/* Protects use of hba->reserved_slot. */
+	ufshcd_hold(hba, false);
+	mutex_lock(&hba->dev_cmd.lock);
+	down_read(&hba->clk_scaling_lock);
+
+	lrbp = &hba->lrb[tag];
+	WARN_ON(lrbp->cmd);
+	lrbp->cmd = NULL;
+	lrbp->task_tag = tag;
+	lrbp->lun = UFS_UPIU_RPMB_WLUN;
+
+	lrbp->intr_cmd = true;
+	ufshcd_prepare_lrbp_crypto(NULL, lrbp);
+	hba->dev_cmd.type = DEV_CMD_TYPE_RPMB;
+
+	lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
+
+	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, dir, len/32);
+
+	/* update the task tag and LUN in the request upiu */
+	req_upiu->header.dword_0 |= cpu_to_be32(upiu_flags << 16 | UFS_UPIU_RPMB_WLUN << 8 | tag);
+
+	/* copy the upiu request as it is */
+	memcpy(lrbp->ucd_req_ptr, req_upiu, sizeof(*lrbp->ucd_req_ptr));
+	/* copy ehs */
+	memcpy(lrbp->ucd_req_ptr + 1, ehs_req, sizeof(*ehs_req));
+
+	if (dir != DMA_NONE && sg_list)
+		ufshcd_sgl_to_prdt(hba, lrbp, sg_cnt, sg_list);
+
+
+	memset(lrbp->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
+
+	hba->dev_cmd.complete = &wait;
+
+	ufshcd_send_command(hba, tag);
+
+	err = ufshcd_wait_for_dev_cmd(hba, lrbp, ADVANCED_RPMB_REQ_TIMEOUT);
+
+	if (!err) {
+		/* just copy the upiu response as it is */
+		memcpy(rsp_upiu, lrbp->ucd_rsp_ptr, sizeof(*rsp_upiu));
+
+		u8 *descp = (u8 *)lrbp->ucd_rsp_ptr + sizeof(*rsp_upiu);
+		u16 ehs_len = be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_2) >> 24;
+
+		if (ehs_len == 2  && ehs_rsp)
+			memcpy(ehs_rsp, descp, ehs_len * 32);
+	}
+
+	up_read(&hba->clk_scaling_lock);
+	mutex_unlock(&hba->dev_cmd.lock);
+	ufshcd_release(hba);
+	return err;
+}
+
 /**
  * ufshcd_eh_device_reset_handler() - Reset a single logical unit.
  * @cmd: SCSI command pointer
diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_ufs.h
index d55f2176dfd4..a79adbc89cc0 100644
--- a/include/uapi/scsi/scsi_bsg_ufs.h
+++ b/include/uapi/scsi/scsi_bsg_ufs.h
@@ -14,7 +14,16 @@
  */
 
 #define UFS_CDB_SIZE	16
-#define UPIU_TRANSACTION_UIC_CMD 0x1F
+
+enum ufs_bsg_msg_code {
+	UPIU_TRANSACTION_UIC_CMD = 0x1F,
+	UPIU_TRANSACTION_ARPMB_DATA_WRITE,
+	UPIU_TRANSACTION_ARPMB_DATA_READ,
+	UPIU_TRANSACTION_ARPMB_PROGRAM_KEY,
+	UPIU_TRANSACTION_ARPMB_READ_COUNTER,
+
+};
+
 /* uic commands are 4DW long, per UFSHCI V2.1 paragraph 5.6.1 */
 #define UIC_CMD_SIZE (sizeof(__u32) * 4)
 
@@ -79,6 +88,14 @@ struct utp_upiu_req {
 	};
 };
 
+struct ufs_ehs {
+	__u8 blenght;
+	__u8 lehs_type;
+	__u16 wehssub_type;
+	__u8 meta[28];
+	__u8 mac_key[32];
+};
+
 /* request (CDB) structure of the sg_io_v4 */
 struct ufs_bsg_request {
 	__u32 msgcode;
@@ -102,4 +119,15 @@ struct ufs_bsg_reply {
 
 	struct utp_upiu_req upiu_rsp;
 };
+
+struct ufs_rpmb_request {
+	struct ufs_bsg_request bsg_request;
+	struct ufs_ehs ehs_req;
+};
+
+struct ufs_rpmb_reply {
+	struct ufs_bsg_reply bsg_reply;
+	struct ufs_ehs ehs_rsp;
+};
+
 #endif /* UFS_BSG_H */
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 96538eb3a6c0..59906cc7d8d3 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -30,6 +30,7 @@ struct ufs_hba;
 enum dev_cmd_type {
 	DEV_CMD_TYPE_NOP		= 0x0,
 	DEV_CMD_TYPE_QUERY		= 0x1,
+	DEV_CMD_TYPE_RPMB		= 0x2,
 };
 
 enum ufs_event_type {
@@ -1208,6 +1209,10 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 			     u8 *desc_buff, int *buff_len,
 			     enum query_opcode desc_op);
 
+int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *req_upiu,
+			 struct utp_upiu_req *rsp_upiu, struct ufs_ehs *ehs_req,
+			 struct ufs_ehs *ehs_rsp, int sg_cnt, struct scatterlist *sg_list,
+			 enum dma_data_direction dir, int len);
 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
 int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
 int ufshcd_suspend_prepare(struct device *dev);
-- 
2.25.1

