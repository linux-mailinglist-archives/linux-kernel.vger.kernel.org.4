Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170096CD740
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjC2KEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjC2KEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:04:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5645944A6;
        Wed, 29 Mar 2023 03:04:15 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T9IEXO002899;
        Wed, 29 Mar 2023 10:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rMRX55KI3mgnCM7Qjn8MTx+tJBOj8+CBW9A7BQhp7F0=;
 b=HhWNykZ9xgrxYkeXYlbJXhrIGIYzUKOKE49LRgbbKlw+WenCdYXPdyqNNmqpi5WxugpD
 wbtlUayYxwqK/TjUZdUVEYDSV3sjrVYVi2UCRKwHAJCM3Pka/2KSR4RiXokagAWdu7HC
 KMwSnkTwf3b0OJAVhP0zsMBs+gbXiAVk8NEA6YTCFLL+7eIXdAF+hNcFqFTJ6eXXOQHx
 KV2eXAV7pJqBBkNru9HHc6CGFZkzlGrdWoryjrFYnoPLSCpotMRpv8XmoLaTyHFvc0vG
 +Uv8RAofdVn11Xg4jBfjJC1kuVFZXFO7km2na/Yk+fXJzlEciYRO5rihkdvi8ArXGloW xQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pky0xb32y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 10:02:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32TA2uMH032479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 10:02:56 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 29 Mar 2023 03:02:55 -0700
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
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Eric Biggers <ebiggers@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/5] ufs: mcq: Add supporting functions for mcq abort
Date:   Wed, 29 Mar 2023 03:01:45 -0700
Message-ID: <0351ea8bb5d7b223778367867ca3791cc6ee608d.1680083571.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1680083571.git.quic_nguyenb@quicinc.com>
References: <cover.1680083571.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dRz9PZOud5MDpZ36g1uHvjj1oodd_gWA
X-Proofpoint-ORIG-GUID: dRz9PZOud5MDpZ36g1uHvjj1oodd_gWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_04,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290083
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supporting functions to handle ufs abort in mcq mode.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 174 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  10 +++
 drivers/ufs/core/ufshcd.c      |   2 -
 include/ufs/ufshci.h           |  17 ++++
 4 files changed, 201 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 31df052..6f6b22c 100644
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
 
+/* Max mcq register polling time in micro second unit */
+#define MCQ_POLL_US 500000
+
 static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(val, kp, UFS_MCQ_MIN_RW_QUEUES,
@@ -429,3 +436,170 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	host->host_tagset = 1;
 	return 0;
 }
+
+static int ufshcd_mcq_sq_stop(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
+{
+	void __iomem *reg;
+	u32 i = hwq->id, val;
+	int err;
+
+	writel(SQ_STOP, mcq_opr_base(hba, OPR_SQD, i) + REG_SQRTC);
+	reg = mcq_opr_base(hba, OPR_SQD, i) + REG_SQRTS;
+	err = read_poll_timeout(readl, val, val & SQ_STS, 20,
+				MCQ_POLL_US, false, reg);
+	if (err)
+		dev_err(hba->dev, "%s: failed. hwq-id=%d, err=%d\n",
+			__func__, i, err);
+	return err;
+}
+
+static int ufshcd_mcq_sq_start(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
+{
+	void __iomem *reg;
+	u32 i = hwq->id, val;
+	int err;
+
+	writel(SQ_START, mcq_opr_base(hba, OPR_SQD, i) + REG_SQRTC);
+	reg = mcq_opr_base(hba, OPR_SQD, i) + REG_SQRTS;
+	err = read_poll_timeout(readl, val, !(val & SQ_STS), 20,
+				MCQ_POLL_US, false, reg);
+	if (err)
+		dev_err(hba->dev, "%s: failed. hwq-id=%d, err=%d\n",
+			__func__, i, err);
+	return err;
+}
+
+/**
+ * ufshcd_mcq_sq_cleanup - Clean up Submission Queue resources
+ * associated with the pending command.
+ * @hba - per adapter instance.
+ * @task_tag - The command's task tag.
+ * @result - Result of the Clean up operation.
+ *
+ * Returns 0 and result on completion. Returns error code if
+ * the operation fails.
+ */
+int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag, int *result)
+{
+	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
+	struct scsi_cmnd *cmd = lrbp->cmd;
+	struct ufs_hw_queue *hwq;
+	void __iomem *reg, *opr_sqd_base;
+	u32 nexus, i, val;
+	int err;
+
+	if (task_tag != hba->nutrs - UFSHCD_NUM_RESERVED) {
+		if (!cmd)
+			return FAILED;
+		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
+	} else {
+		hwq = hba->dev_cmd_queue;
+	}
+
+	i = hwq->id;
+
+	spin_lock(&hwq->sq_lock);
+
+	/* stop the SQ fetching before working on it */
+	err = ufshcd_mcq_sq_stop(hba, hwq);
+	if (err)
+		goto unlock;
+
+	/* SQCTI = EXT_IID, IID, LUN, Task Tag */
+	nexus = lrbp->lun << 8 | task_tag;
+	opr_sqd_base = mcq_opr_base(hba, OPR_SQD, i);
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
+		dev_err(hba->dev, "%s: failed. hwq=%d, lun=0x%x, tag=%d\n",
+			__func__, i, lrbp->lun, task_tag);
+
+	*result = FIELD_GET(SQ_ICU_ERR_CODE_MASK, readl(reg));
+
+	if (ufshcd_mcq_sq_start(hba, hwq))
+		err = FAILED;
+
+unlock:
+	spin_unlock(&hwq->sq_lock);
+	return err;
+}
+
+static u64 ufshcd_mcq_get_cmd_desc_addr(struct ufs_hba *hba,
+					int task_tag)
+{
+	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
+	__le32 hi = lrbp->utr_descriptor_ptr->command_desc_base_addr_hi;
+	__le32 lo = lrbp->utr_descriptor_ptr->command_desc_base_addr_lo;
+
+	return le64_to_cpu((__le64)hi << 32 | lo);
+}
+
+/**
+ * ufshcd_mcq_nullify_cmd - Nullify utrd. Host controller does not fetch
+ * transfer with Command Type = 0xF. post the Completion Queue with OCS=ABORTED.
+ * @hba - per adapter instance.
+ * @hwq - Hardware Queue of the nullified utrd.
+ */
+static void ufshcd_mcq_nullify_cmd(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
+{
+	struct utp_transfer_req_desc *utrd;
+	u32 dword_0;
+
+	utrd = (struct utp_transfer_req_desc *)(hwq->sqe_base_addr +
+			hwq->id * sizeof(struct utp_transfer_req_desc));
+	dword_0 = le32_to_cpu(utrd->header.dword_0);
+	dword_0 &= ~UPIU_COMMAND_TYPE_MASK;
+	dword_0 |= FIELD_PREP(UPIU_COMMAND_TYPE_MASK, 0xF);
+	utrd->header.dword_0 = cpu_to_le32(dword_0);
+}
+
+/**
+ * ufshcd_mcq_sqe_search - Search for the cmd in the Submission Queue (SQ)
+ * @hba - per adapter instance.
+ * @hwq - Hardware Queue to be searched.
+ * @task_tag - The command's task tag.
+ *
+ * Returns true if the SQE containing the command is present in the SQ
+ * (not fetched by the controller); returns false if the SQE is not in the SQ.
+ */
+static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
+		struct ufs_hw_queue *hwq, int task_tag)
+{
+	struct utp_transfer_req_desc *utrd;
+	u32 mask = hwq->max_entries - 1;
+	bool ret = false;
+	u64 addr, match;
+	u32 sq_head_slot;
+
+	spin_lock(&hwq->sq_lock);
+
+	ufshcd_mcq_sq_stop(hba, hwq);
+	sq_head_slot = ufshcd_mcq_get_sq_head_slot(hwq);
+	if (sq_head_slot == hwq->sq_tail_slot)
+		goto out;
+
+	addr = ufshcd_mcq_get_cmd_desc_addr(hba, task_tag);
+	while (sq_head_slot != hwq->sq_tail_slot) {
+		utrd = (struct utp_transfer_req_desc *)(hwq->sqe_base_addr +
+				sq_head_slot * sizeof(struct utp_transfer_req_desc));
+		match = le64_to_cpu((__le64)utrd->command_desc_base_addr_hi << 32 |
+				utrd->command_desc_base_addr_lo) & CQE_UCD_BA;
+		if (addr == match) {
+			ret = true;
+			goto out;
+		}
+		sq_head_slot = (sq_head_slot + 1) & mask;
+	}
+
+out:
+	ufshcd_mcq_sq_start(hba, hwq);
+	spin_unlock(&hwq->sq_lock);
+	return ret;
+}
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 529f850..1a40cf7 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -78,6 +78,8 @@ struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq);
 
+int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag, int *result);
+
 #define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
 #define SD_ASCII_STD true
 #define SD_RAW false
@@ -403,4 +405,12 @@ static inline struct cq_entry *ufshcd_mcq_cur_cqe(struct ufs_hw_queue *q)
 
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
index 35a3bd9..808387c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -56,7 +56,6 @@
 #define NOP_OUT_RETRIES    10
 /* Timeout after 50 msecs if NOP OUT hangs without response */
 #define NOP_OUT_TIMEOUT    50 /* msecs */
-
 /* Query request retries */
 #define QUERY_REQ_RETRIES 3
 /* Query request timeout */
@@ -173,7 +172,6 @@ EXPORT_SYMBOL_GPL(ufshcd_dump_regs);
 enum {
 	UFSHCD_MAX_CHANNEL	= 0,
 	UFSHCD_MAX_ID		= 1,
-	UFSHCD_NUM_RESERVED	= 1,
 	UFSHCD_CMD_PER_LUN	= 32 - UFSHCD_NUM_RESERVED,
 	UFSHCD_CAN_QUEUE	= 32 - UFSHCD_NUM_RESERVED,
 };
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 11424bb..ceb8664 100644
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

