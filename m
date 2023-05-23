Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DBB70D504
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjEWHax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjEWHam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:30:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B205E130;
        Tue, 23 May 2023 00:30:04 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6xvr2015035;
        Tue, 23 May 2023 07:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=q7nIQjxy0Rk6zBtMB+Tgpt3ybbAW+kM/J9WXgMAMuZ0=;
 b=JxnzpzEFI0oXQ9y8B37goDvkZnhte0Tjrg6BL6L4/3tyCSK4aAwdLZF+/TqEdYcMRZIY
 emPvixpi8dNhA3CFOoi/aD8ERumLFVgB3Qx6B2H6U2p+UrANQ2+V31+43vYVE7L+bac1
 c+Zt2Rdp26DC6wRq3XyNG/9T813MTTBRDzGqjBzROllT8wI2DKbu2OQ3AidM2hBHBrOp
 Y9MP6bfMBc9O5yxo7bj6oT3FIXFTpwTUaZnVHEgNp0YUUIX3s7B6X7d6FjUwpnG3NJTB
 ZK8acTOJJxDvfQua0oaLdNh1oyAKU9z9SQCBPCVMV//49rYtzNu/R4D5mmV2SMqjWqZ6 8A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qracshpja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:29:01 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N7T0FE020433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:29:00 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 23 May 2023 00:29:00 -0700
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
To:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alice Chao <alice.chao@mediatek.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/7] ufs: mcq: Add supporting functions for mcq abort
Date:   Tue, 23 May 2023 00:28:11 -0700
Message-ID: <cd02547feaf909c45a8d233d797354259f7a1ceb.1684825500.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1684825500.git.quic_nguyenb@quicinc.com>
References: <cover.1684825500.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EtFb9J1aRwf5RIfpH6seQ0PBo34Snv4C
X-Proofpoint-ORIG-GUID: EtFb9J1aRwf5RIfpH6seQ0PBo34Snv4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supporting functions to handle ufs abort in mcq mode.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 167 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  10 +++
 drivers/ufs/core/ufshcd.c      |   1 -
 include/ufs/ufshcd.h           |   3 +
 include/ufs/ufshci.h           |  17 +++++
 5 files changed, 197 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 202ff71..655f220 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -12,6 +12,10 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include "ufshcd-priv.h"
+#include <linux/delay.h>
+#include <scsi/scsi_cmnd.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
 
 #define MAX_QUEUE_SUP GENMASK(7, 0)
 #define UFS_MCQ_MIN_RW_QUEUES 2
@@ -27,6 +31,9 @@
 #define MCQ_ENTRY_SIZE_IN_DWORD	8
 #define CQE_UCD_BA GENMASK_ULL(63, 7)
 
+/* Max mcq register polling time in microseconds */
+#define MCQ_POLL_US 500000
+
 static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(val, kp, UFS_MCQ_MIN_RW_QUEUES,
@@ -419,6 +426,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 		hwq->max_entries = hba->nutrs;
 		spin_lock_init(&hwq->sq_lock);
 		spin_lock_init(&hwq->cq_lock);
+		mutex_init(&hwq->sq_mutex);
 	}
 
 	/* The very first HW queue serves device commands */
@@ -429,3 +437,162 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	host->host_tagset = 1;
 	return 0;
 }
+
+static int ufshcd_mcq_sq_stop(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
+{
+	void __iomem *reg;
+	u32 id = hwq->id, val;
+	int err;
+
+	writel(SQ_STOP, mcq_opr_base(hba, OPR_SQD, id) + REG_SQRTC);
+	reg = mcq_opr_base(hba, OPR_SQD, id) + REG_SQRTS;
+	err = read_poll_timeout(readl, val, val & SQ_STS, 20,
+				MCQ_POLL_US, false, reg);
+	if (err)
+		dev_err(hba->dev, "%s: failed. hwq-id=%d, err=%d\n",
+			__func__, id, err);
+	return err;
+}
+
+static int ufshcd_mcq_sq_start(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
+{
+	void __iomem *reg;
+	u32 id = hwq->id, val;
+	int err;
+
+	writel(SQ_START, mcq_opr_base(hba, OPR_SQD, id) + REG_SQRTC);
+	reg = mcq_opr_base(hba, OPR_SQD, id) + REG_SQRTS;
+	err = read_poll_timeout(readl, val, !(val & SQ_STS), 20,
+				MCQ_POLL_US, false, reg);
+	if (err)
+		dev_err(hba->dev, "%s: failed. hwq-id=%d, err=%d\n",
+			__func__, id, err);
+	return err;
+}
+
+/**
+ * ufshcd_mcq_sq_cleanup - Clean up submission queue resources
+ * associated with the pending command.
+ * @hba - per adapter instance.
+ * @task_tag - The command's task tag.
+ *
+ * Returns 0 for success; error code otherwise.
+ */
+int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
+{
+	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
+	struct scsi_cmnd *cmd = lrbp->cmd;
+	struct ufs_hw_queue *hwq;
+	void __iomem *reg, *opr_sqd_base;
+	u32 nexus, id, val;
+	int err;
+
+	if (task_tag != hba->nutrs - UFSHCD_NUM_RESERVED) {
+		if (!cmd)
+			return -EINVAL;
+		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
+	} else {
+		hwq = hba->dev_cmd_queue;
+	}
+
+	id = hwq->id;
+
+	mutex_lock(&hwq->sq_mutex);
+
+	/* stop the SQ fetching before working on it */
+	err = ufshcd_mcq_sq_stop(hba, hwq);
+	if (err)
+		goto unlock;
+
+	/* SQCTI = EXT_IID, IID, LUN, Task Tag */
+	nexus = lrbp->lun << 8 | task_tag;
+	opr_sqd_base = mcq_opr_base(hba, OPR_SQD, id);
+	writel(nexus, opr_sqd_base + REG_SQCTI);
+
+	/* SQRTCy.ICU = 1 */
+	writel(SQ_ICU, opr_sqd_base + REG_SQRTC);
+
+	/* Poll SQRTSy.CUS = 1. Return result from SQRTSy.RTC */
+	reg = opr_sqd_base + REG_SQRTS;
+	err = read_poll_timeout(readl, val, val & SQ_CUS, 20,
+				MCQ_POLL_US, false, reg);
+	if (err)
+		dev_err(hba->dev, "%s: failed. hwq=%d, tag=%d err=%ld\n",
+			__func__, id, task_tag,
+			FIELD_GET(SQ_ICU_ERR_CODE_MASK, readl(reg)));
+
+	if (ufshcd_mcq_sq_start(hba, hwq))
+		err = -ETIMEDOUT;
+
+unlock:
+	mutex_unlock(&hwq->sq_mutex);
+	return err;
+}
+
+/**
+ * ufshcd_mcq_nullify_sqe - Nullify the submission queue entry.
+ * Write the sqe's Command Type to 0xF. The host controller will not
+ * fetch any sqe with Command Type = 0xF.
+ *
+ * @utrd - UTP Transfer Request Descriptor to be nullified.
+ */
+static void ufshcd_mcq_nullify_sqe(struct utp_transfer_req_desc *utrd)
+{
+	u32 dword_0;
+
+	dword_0 = le32_to_cpu(utrd->header.dword_0);
+	dword_0 &= ~UPIU_COMMAND_TYPE_MASK;
+	dword_0 |= FIELD_PREP(UPIU_COMMAND_TYPE_MASK, 0xF);
+	utrd->header.dword_0 = cpu_to_le32(dword_0);
+}
+
+/**
+ * ufshcd_mcq_sqe_search - Search for the command in the submission queue
+ * If the command is in the submission queue and not issued to the device yet,
+ * nullify the sqe so the host controller will skip fetching the sqe.
+ *
+ * @hba - per adapter instance.
+ * @hwq - Hardware Queue to be searched.
+ * @task_tag - The command's task tag.
+ *
+ * Returns true if the SQE containing the command is present in the SQ
+ * (not fetched by the controller); returns false if the SQE is not in the SQ.
+ */
+static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
+				  struct ufs_hw_queue *hwq, int task_tag)
+{
+	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
+	struct utp_transfer_req_desc *utrd;
+	u32 mask = hwq->max_entries - 1;
+	__le64  cmd_desc_base_addr;
+	bool ret = false;
+	u64 addr, match;
+	u32 sq_head_slot;
+
+	mutex_lock(&hwq->sq_mutex);
+
+	ufshcd_mcq_sq_stop(hba, hwq);
+	sq_head_slot = ufshcd_mcq_get_sq_head_slot(hwq);
+	if (sq_head_slot == hwq->sq_tail_slot)
+		goto out;
+
+	cmd_desc_base_addr = lrbp->utr_descriptor_ptr->command_desc_base_addr;
+	addr = le64_to_cpu(cmd_desc_base_addr) & CQE_UCD_BA;
+
+	while (sq_head_slot != hwq->sq_tail_slot) {
+		utrd = hwq->sqe_base_addr +
+				sq_head_slot * sizeof(struct utp_transfer_req_desc);
+		match = le64_to_cpu(utrd->command_desc_base_addr) & CQE_UCD_BA;
+		if (addr == match) {
+			ufshcd_mcq_nullify_sqe(utrd);
+			ret = true;
+			goto out;
+		}
+		sq_head_slot = (sq_head_slot + 1) & mask;
+	}
+
+out:
+	ufshcd_mcq_sq_start(hba, hwq);
+	mutex_unlock(&hwq->sq_mutex);
+	return ret;
+}
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index d53b93c2..40727e8 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -78,6 +78,8 @@ struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq);
 
+int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag);
+
 #define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
 #define SD_ASCII_STD true
 #define SD_RAW false
@@ -404,4 +406,12 @@ static inline struct cq_entry *ufshcd_mcq_cur_cqe(struct ufs_hw_queue *q)
 
 	return cqe + q->cq_head_slot;
 }
+
+static inline u32 ufshcd_mcq_get_sq_head_slot(struct ufs_hw_queue *q)
+{
+	u32 val = readl(q->mcq_sq_head);
+
+	return val / sizeof(struct utp_transfer_req_desc);
+}
+
 #endif /* _UFSHCD_PRIV_H_ */
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a37e1eb..140ab15 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -173,7 +173,6 @@ EXPORT_SYMBOL_GPL(ufshcd_dump_regs);
 enum {
 	UFSHCD_MAX_CHANNEL	= 0,
 	UFSHCD_MAX_ID		= 1,
-	UFSHCD_NUM_RESERVED	= 1,
 	UFSHCD_CMD_PER_LUN	= 32 - UFSHCD_NUM_RESERVED,
 	UFSHCD_CAN_QUEUE	= 32 - UFSHCD_NUM_RESERVED,
 };
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 721ae4c..3c9ecda 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1088,6 +1088,7 @@ struct ufs_hba {
  * @cq_tail_slot: current slot to which CQ tail pointer is pointing
  * @cq_head_slot: current slot to which CQ head pointer is pointing
  * @cq_lock: Synchronize between multiple polling instances
+ * @sq_mutex: prevent submission queue concurrent access
  */
 struct ufs_hw_queue {
 	void __iomem *mcq_sq_head;
@@ -1106,6 +1107,8 @@ struct ufs_hw_queue {
 	u32 cq_tail_slot;
 	u32 cq_head_slot;
 	spinlock_t cq_lock;
+	/* prevent concurrent access to submission queue */
+	struct mutex sq_mutex;
 };
 
 static inline bool is_mcq_enabled(struct ufs_hba *hba)
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 7c5a76b..9d291ca 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -99,6 +99,9 @@ enum {
 enum {
 	REG_SQHP		= 0x0,
 	REG_SQTP		= 0x4,
+	REG_SQRTC		= 0x8,
+	REG_SQCTI		= 0xC,
+	REG_SQRTS		= 0x10,
 };
 
 enum {
@@ -111,12 +114,26 @@ enum {
 	REG_CQIE		= 0x4,
 };
 
+enum {
+	SQ_START		= 0x0,
+	SQ_STOP			= 0x1,
+	SQ_ICU			= 0x2,
+};
+
+enum {
+	SQ_STS			= 0x1,
+	SQ_CUS			= 0x2,
+};
+
+#define SQ_ICU_ERR_CODE_MASK		GENMASK(7, 4)
+#define UPIU_COMMAND_TYPE_MASK		GENMASK(31, 28)
 #define UFS_MASK(mask, offset)		((mask) << (offset))
 
 /* UFS Version 08h */
 #define MINOR_VERSION_NUM_MASK		UFS_MASK(0xFFFF, 0)
 #define MAJOR_VERSION_NUM_MASK		UFS_MASK(0xFFFF, 16)
 
+#define UFSHCD_NUM_RESERVED	1
 /*
  * Controller UFSHCI version
  * - 2.x and newer use the following scheme:
-- 
2.7.4

