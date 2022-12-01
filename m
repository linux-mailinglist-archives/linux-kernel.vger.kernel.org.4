Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E596863F241
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiLAOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiLAOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:04:58 -0500
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9675AA5193;
        Thu,  1 Dec 2022 06:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669903493;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=2nRu0P8NbWQ922VMs3rl370fEKxsdqVp5TVrGfVLkEU=;
    b=hBcBgRf5ricEvQbkp3SdR3MeaW5NX11qXxx3lj3JSMjsPHPBE4tj0J9EYy8SqrHuTa
    3tVcIDng6W8OOsEHOJKqUcmU1LQnM5wGn5mfm5zO0T0WLK/ld+iPFohrQUxov9h0oAFZ
    bZr7x+3ONyC24GzhsAj5hDKrnSsUu2P4Cvb7V+L/LV/xFNZX26kzk02ahxuks0hsFTpy
    1PPzGN9D4CzROQ0z00LnoPCTdMACDTVDbtXE8sgPH3kegF/QEWaS7DSyodl4FLnh4QYX
    vZ+/22q1B8iaB4JsRT/IbQO5rZ6faUtQq1BIh/DnMKTsNS5oQMDKe491lesrlK/kBsgm
    ZSOQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
X-RZG-CLASS-ID: mo03
Received: from blinux.micron.com
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyB1E4rHob
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 1 Dec 2022 15:04:53 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] ufs: core: Add advanced RPMB support in ufs_bsg
Date:   Thu,  1 Dec 2022 15:04:37 +0100
Message-Id: <20221201140437.549272-8-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201140437.549272-1-beanhuo@iokpp.de>
References: <20221201140437.549272-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Add advanced RPMB support in ufs_bsg. For these reasons, we try to add
Advanced RPMB support in ufs_bsg:

1. According to the UFS specification, only one RPMB operation can be
performed at any time. We can ensure this by using reserved slot and
its dev_cmd sync operation protection mechanism.

2. For the Advanced RPMB, RPMB metadata is packaged in an EHS(Extra
Header Segment) of a command UPIU, and the corresponding reply EHS
(from the device) should also be returned to the user space.
bsg_job->request and bsg_job->reply allow us to pass and return EHS
from/back to userspace.

Compared to normal/legacy RPMB, the advantage of advanced RPMB are:

1. The data length in the Advanced RPBM data read/write command could
be > 4KB. For the legacy RPMB, the data length in a single RPMB data
transfer is 256 bytes.
2.  All of the advanced RPMB operations will be a single command shot.
But for the legacy  RPBM, take the read write-counter value as an example,
you need two commands(first SECURITY PROTOCOL OUT, then the second SECURITY
PROTOCOL IN).

Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufs_bsg.c       |  93 +++++++++++++++++++++++++---
 drivers/ufs/core/ufshcd.c        | 103 +++++++++++++++++++++++++++++++
 include/uapi/scsi/scsi_bsg_ufs.h |  46 +++++++++++++-
 include/ufs/ufs.h                |   5 ++
 include/ufs/ufshcd.h             |   6 +-
 include/ufs/ufshci.h             |   1 +
 6 files changed, 242 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 850a0d798f63..a8e58faa7da2 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bsg-lib.h>
+#include <linux/dma-mapping.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include "ufs_bsg.h"
@@ -68,6 +69,72 @@ static int ufs_bsg_alloc_desc_buffer(struct ufs_hba *hba, struct bsg_job *job,
 	return 0;
 }
 
+static int ufs_bsg_exec_advanced_rpmb_req(struct ufs_hba *hba, struct bsg_job *job)
+{
+	struct ufs_rpmb_request *rpmb_request = job->request;
+	struct ufs_rpmb_reply *rpmb_reply = job->reply;
+	struct bsg_buffer *payload = NULL;
+	enum dma_data_direction dir;
+	struct scatterlist *sg_list;
+	int rpmb_req_type;
+	int sg_cnt;
+	int ret;
+	int data_len;
+
+	if (hba->ufs_version < ufshci_version(4, 0) || !hba->dev_info.b_advanced_rpmb_en ||
+	    !(hba->capabilities & MASK_EHSLUTRD_SUPPORTED))
+		return -EINVAL;
+
+	if (rpmb_request->ehs_req.length != 2 || rpmb_request->ehs_req.ehs_type != 1)
+		return -EINVAL;
+
+	rpmb_req_type = be16_to_cpu(rpmb_request->ehs_req.meta.req_resp_type);
+
+	switch (rpmb_req_type) {
+	case UFS_RPMB_WRITE_KEY:
+	case UFS_RPMB_READ_CNT:
+	case UFS_RPMB_PURGE_ENABLE:
+		dir = DMA_NONE;
+		break;
+	case UFS_RPMB_WRITE:
+	case UFS_RPMB_SEC_CONF_WRITE:
+		dir = DMA_TO_DEVICE;
+		break;
+	case UFS_RPMB_READ:
+	case UFS_RPMB_SEC_CONF_READ:
+	case UFS_RPMB_PURGE_STATUS_READ:
+		dir = DMA_FROM_DEVICE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (dir != DMA_NONE) {
+		payload = &job->request_payload;
+		if (!payload || !payload->payload_len || !payload->sg_cnt)
+			return -EINVAL;
+
+		sg_cnt = dma_map_sg(hba->host->dma_dev, payload->sg_list, payload->sg_cnt, dir);
+		if (unlikely(!sg_cnt))
+			return -ENOMEM;
+		sg_list = payload->sg_list;
+		data_len = payload->payload_len;
+	}
+
+	ret = ufshcd_advanced_rpmb_req_handler(hba, &rpmb_request->bsg_request.upiu_req,
+				   &rpmb_reply->bsg_reply.upiu_rsp, &rpmb_request->ehs_req,
+				   &rpmb_reply->ehs_rsp, sg_cnt, sg_list, dir);
+
+	if (dir != DMA_NONE) {
+		dma_unmap_sg(hba->host->dma_dev, payload->sg_list, payload->sg_cnt, dir);
+
+		if (!ret)
+			rpmb_reply->bsg_reply.reply_payload_rcv_len = data_len;
+	}
+
+	return ret;
+}
+
 static int ufs_bsg_request(struct bsg_job *job)
 {
 	struct ufs_bsg_request *bsg_request = job->request;
@@ -75,10 +142,11 @@ static int ufs_bsg_request(struct bsg_job *job)
 	struct ufs_hba *hba = shost_priv(dev_to_shost(job->dev->parent));
 	struct uic_command uc = {};
 	int msgcode;
-	uint8_t *desc_buff = NULL;
+	uint8_t *buff = NULL;
 	int desc_len = 0;
 	enum query_opcode desc_op = UPIU_QUERY_OPCODE_NOP;
 	int ret;
+	bool rpmb = false;
 
 	bsg_reply->reply_payload_rcv_len = 0;
 
@@ -88,8 +156,7 @@ static int ufs_bsg_request(struct bsg_job *job)
 	switch (msgcode) {
 	case UPIU_TRANSACTION_QUERY_REQ:
 		desc_op = bsg_request->upiu_req.qr.opcode;
-		ret = ufs_bsg_alloc_desc_buffer(hba, job, &desc_buff,
-						&desc_len, desc_op);
+		ret = ufs_bsg_alloc_desc_buffer(hba, job, &buff, &desc_len, desc_op);
 		if (ret)
 			goto out;
 		fallthrough;
@@ -97,25 +164,31 @@ static int ufs_bsg_request(struct bsg_job *job)
 	case UPIU_TRANSACTION_TASK_REQ:
 		ret = ufshcd_exec_raw_upiu_cmd(hba, &bsg_request->upiu_req,
 					       &bsg_reply->upiu_rsp, msgcode,
-					       desc_buff, &desc_len, desc_op);
+					       buff, &desc_len, desc_op);
 		if (ret)
 			dev_err(hba->dev, "exe raw upiu: error code %d\n", ret);
-		else if (desc_op == UPIU_QUERY_OPCODE_READ_DESC && desc_len)
+		else if (desc_op == UPIU_QUERY_OPCODE_READ_DESC && desc_len) {
 			bsg_reply->reply_payload_rcv_len =
 				sg_copy_from_buffer(job->request_payload.sg_list,
 						    job->request_payload.sg_cnt,
-						    desc_buff, desc_len);
+						    buff, desc_len);
+		}
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
+	case UPIU_TRANSACTION_ARPMB_CMD:
+		rpmb = true;
+		ret = ufs_bsg_exec_advanced_rpmb_req(hba, job);
+		if (ret)
+			dev_err(hba->dev, "ARPMB OP failed: error code  %d\n", ret);
+		break;
 	default:
 		ret = -ENOTSUPP;
 		dev_err(hba->dev, "unsupported msgcode 0x%x\n", msgcode);
@@ -125,9 +198,9 @@ static int ufs_bsg_request(struct bsg_job *job)
 
 out:
 	ufshcd_rpm_put_sync(hba);
-	kfree(desc_buff);
+	kfree(buff);
 	bsg_reply->result = ret;
-	job->reply_len = sizeof(struct ufs_bsg_reply);
+	job->reply_len = !rpmb ? sizeof(struct ufs_bsg_reply) : sizeof(struct ufs_rpmb_reply);
 	/* complete the job here only if no error */
 	if (ret == 0)
 		bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bacc94f87ee2..1ecee6507e88 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -56,6 +56,9 @@
 /* Query request timeout */
 #define QUERY_REQ_TIMEOUT 1500 /* 1.5 seconds */
 
+/* Advanced RPMB request timeout */
+#define ADVANCED_RPMB_REQ_TIMEOUT  3000 /* 3 seconds */
+
 /* Task management command timeout */
 #define TM_CMD_TIMEOUT	100 /* msecs */
 
@@ -2954,6 +2957,12 @@ ufshcd_dev_cmd_completion(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
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
@@ -7006,6 +7015,100 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 	return err;
 }
 
+/**
+ * ufshcd_advanced_rpmb_req_handler - handle advanced RPMB request
+ * @hba:	per adapter instance
+ * @req_upiu:	upiu request
+ * @rsp_upiu:	upiu reply
+ * @req_ehs:	EHS field which contains Advanced RPMB Request Message
+ * @rsp_ehs:	EHS field which returns Advanced RPMB Response Message
+ * @sg_cnt:	The number of sg lists actually used
+ * @sg_list:	Pointer to SG list when DATA IN/OUT UPIU is required in ARPMB operation
+ * @dir:	DMA direction
+ *
+ * Returns zero on success, non-zero on failure
+ */
+int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *req_upiu,
+			 struct utp_upiu_req *rsp_upiu, struct ufs_ehs *req_ehs,
+			 struct ufs_ehs *rsp_ehs, int sg_cnt, struct scatterlist *sg_list,
+			 enum dma_data_direction dir)
+{
+	DECLARE_COMPLETION_ONSTACK(wait);
+	const u32 tag = hba->reserved_slot;
+	struct ufshcd_lrb *lrbp;
+	int err = 0;
+	int result;
+	u8 upiu_flags;
+	u8 *ehs_data;
+	u16 ehs_len;
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
+	/* Advanced RPMB starts from UFS 4.0, so its command type is UTP_CMD_TYPE_UFS_STORAGE */
+	lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
+
+	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, dir, 2);
+
+	/* update the task tag and LUN in the request upiu */
+	req_upiu->header.dword_0 |= cpu_to_be32(upiu_flags << 16 | UFS_UPIU_RPMB_WLUN << 8 | tag);
+
+	/* copy the UPIU(contains CDB) request as it is */
+	memcpy(lrbp->ucd_req_ptr, req_upiu, sizeof(*lrbp->ucd_req_ptr));
+	/* Copy EHS, starting with byte32, immediately after the CDB package */
+	memcpy(lrbp->ucd_req_ptr + 1, req_ehs, sizeof(*req_ehs));
+
+	if (dir != DMA_NONE && sg_list)
+		ufshcd_sgl_to_prdt(hba, lrbp, sg_cnt, sg_list);
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
+		/* Just copy the upiu response as it is */
+		memcpy(rsp_upiu, lrbp->ucd_rsp_ptr, sizeof(*rsp_upiu));
+		/* Get the response UPIU result */
+		result = ufshcd_get_rsp_upiu_result(lrbp->ucd_rsp_ptr);
+
+		ehs_len = be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_2) >> 24;
+		/*
+		 * Since the bLength in EHS indicates the total size of the EHS Header and EHS Data
+		 * in 32 Byte units, the value of the bLength Request/Response for Advanced RPMB
+		 * Message is 02h
+		 */
+		if (ehs_len == 2 && rsp_ehs) {
+			/*
+			 * ucd_rsp_ptr points to a buffer with a length of 512 bytes
+			 * (ALIGNED_UPIU_SIZE = 512), and the EHS data just starts from byte32
+			 */
+			ehs_data = (u8 *)lrbp->ucd_rsp_ptr + EHS_OFFSET_IN_RESPONSE;
+			memcpy(rsp_ehs, ehs_data, ehs_len * 32);
+		}
+	}
+
+	up_read(&hba->clk_scaling_lock);
+	mutex_unlock(&hba->dev_cmd.lock);
+	ufshcd_release(hba);
+	return err ? : result;
+}
+
 /**
  * ufshcd_eh_device_reset_handler() - Reset a single logical unit.
  * @cmd: SCSI command pointer
diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_ufs.h
index 64b0cb33e549..276e2772328f 100644
--- a/include/uapi/scsi/scsi_bsg_ufs.h
+++ b/include/uapi/scsi/scsi_bsg_ufs.h
@@ -14,10 +14,27 @@
  */
 
 #define UFS_CDB_SIZE	16
-#define UPIU_TRANSACTION_UIC_CMD 0x1F
 /* uic commands are 4DW long, per UFSHCI V2.1 paragraph 5.6.1 */
 #define UIC_CMD_SIZE (sizeof(__u32) * 4)
 
+enum ufs_bsg_msg_code {
+	UPIU_TRANSACTION_UIC_CMD = 0x1F,
+	UPIU_TRANSACTION_ARPMB_CMD,
+};
+
+/* UFS RPMB Request Message Types */
+enum ufs_rpmb_op_type {
+	UFS_RPMB_WRITE_KEY		= 0x01,
+	UFS_RPMB_READ_CNT		= 0x02,
+	UFS_RPMB_WRITE			= 0x03,
+	UFS_RPMB_READ			= 0x04,
+	UFS_RPMB_READ_RESP		= 0x05,
+	UFS_RPMB_SEC_CONF_WRITE		= 0x06,
+	UFS_RPMB_SEC_CONF_READ		= 0x07,
+	UFS_RPMB_PURGE_ENABLE		= 0x08,
+	UFS_RPMB_PURGE_STATUS_READ	= 0x09,
+};
+
 /**
  * struct utp_upiu_header - UPIU header structure
  * @dword_0: UPIU header DW-0
@@ -79,6 +96,23 @@ struct utp_upiu_req {
 	};
 };
 
+struct ufs_arpmb_meta {
+	__u16	req_resp_type;
+	__u8	nonce[16];
+	__u32	write_counter;
+	__u16	addr_lun;
+	__u16	block_count;
+	__u16	result;
+} __attribute__((__packed__));
+
+struct ufs_ehs {
+	__u8	length;
+	__u8	ehs_type;
+	__u16	ehssub_type;
+	struct ufs_arpmb_meta meta;
+	__u8	mac_key[32];
+} __attribute__((__packed__));
+
 /* request (CDB) structure of the sg_io_v4 */
 struct ufs_bsg_request {
 	__u32 msgcode;
@@ -102,4 +136,14 @@ struct ufs_bsg_reply {
 
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
 #endif /* UFS_BSG_H */
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 17e401df674c..0c112195b288 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -49,6 +49,11 @@
  */
 #define UFS_WB_EXCEED_LIFETIME		0x0B
 
+/*
+ * In UFS Spec, the Extra Header Segment (EHS) starts from byte 32 in UPIU request/response packet
+ */
+#define EHS_OFFSET_IN_RESPONSE 32
+
 /* Well known logical unit id in LUN field of UPIU */
 enum {
 	UFS_UPIU_REPORT_LUNS_WLUN	= 0x81,
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 5cf81dff60aa..c3dfa8084b5c 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -30,6 +30,7 @@ struct ufs_hba;
 enum dev_cmd_type {
 	DEV_CMD_TYPE_NOP		= 0x0,
 	DEV_CMD_TYPE_QUERY		= 0x1,
+	DEV_CMD_TYPE_RPMB		= 0x2,
 };
 
 enum ufs_event_type {
@@ -1201,7 +1202,10 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 			     int msgcode,
 			     u8 *desc_buff, int *buff_len,
 			     enum query_opcode desc_op);
-
+int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *req_upiu,
+				     struct utp_upiu_req *rsp_upiu, struct ufs_ehs *ehs_req,
+				     struct ufs_ehs *ehs_rsp, int sg_cnt,
+				     struct scatterlist *sg_list, enum dma_data_direction dir);
 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
 int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
 int ufshcd_suspend_prepare(struct device *dev);
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index f525566a0864..af216296b86e 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -63,6 +63,7 @@ enum {
 enum {
 	MASK_TRANSFER_REQUESTS_SLOTS		= 0x0000001F,
 	MASK_TASK_MANAGEMENT_REQUEST_SLOTS	= 0x00070000,
+	MASK_EHSLUTRD_SUPPORTED			= 0x00400000,
 	MASK_AUTO_HIBERN8_SUPPORT		= 0x00800000,
 	MASK_64_ADDRESSING_SUPPORT		= 0x01000000,
 	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	= 0x02000000,
-- 
2.25.1

