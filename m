Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862E16B1ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCIFaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCIFaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:30:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340703E617;
        Wed,  8 Mar 2023 21:30:02 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3293fD7Z028917;
        Thu, 9 Mar 2023 05:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xRnQOgbD0NA8TRWR5uPFM7GB2NqfmAADiobXSck346M=;
 b=NAbTPhIqo6Jg9UpJZ7g4QeCfvjfA2u8Ft9B2P8K3BXowo42t+qU/c6MplaSxDMP/ZoNo
 kTwzg4O0SUGq/8kjAErmhBWMmK4m9T4MChh636g9KbSYPFPcU/topppvX+Xjn7SQIjjt
 eRZSRuf057Ez1ezpmgxxigoeKae35+vpTqmN7gkB1W2i7xtELJvLiYU/KjqNazTykbaZ
 49MJ+HESvXpzCZzVQx/al6WsE45oSFonP1XOxYtxPpNxhwlBBi6z73ZIsQJACiwf2yrt
 /PztBCoGlN3yl3k2G560kAxcr2WU9YPGUyaEvSXzDm/pPzesIzqYOiJVeC0ZUGTaEfz5 1Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6vnahv15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 05:29:52 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3295TpJq026938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 05:29:51 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 21:29:50 -0800
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
        open list <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 1/3] ufs: mcq: Add supporting functions for mcq abort
Date:   Wed, 8 Mar 2023 21:28:55 -0800
Message-ID: <68b786f390dbd93218a482d18c513bc332e82da3.1678338926.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1678338926.git.quic_nguyenb@quicinc.com>
References: <cover.1678338926.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u06m_0mr3dUUNMG2ECNY8CTmTBM9DFwH
X-Proofpoint-ORIG-GUID: u06m_0mr3dUUNMG2ECNY8CTmTBM9DFwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_02,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090043
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supporting functions to handle ufs abort in mcq mode.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 181 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  14 ++++
 drivers/ufs/core/ufshcd.c      |   3 +-
 include/ufs/ufshcd.h           |   1 +
 include/ufs/ufshci.h           |  16 ++++
 5 files changed, 214 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 31df052..4c33c1a 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -12,6 +12,9 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include "ufshcd-priv.h"
+#include <linux/delay.h>
+#include <scsi/scsi_cmnd.h>
+#include <linux/bitfield.h>
 
 #define MAX_QUEUE_SUP GENMASK(7, 0)
 #define UFS_MCQ_MIN_RW_QUEUES 2
@@ -27,6 +30,9 @@
 #define MCQ_ENTRY_SIZE_IN_DWORD	8
 #define CQE_UCD_BA GENMASK_ULL(63, 7)
 
+/* Max mcq register polling time in millisecond unit */
+#define MCQ_POLL_MS 500
+
 static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(val, kp, UFS_MCQ_MIN_RW_QUEUES,
@@ -429,3 +435,178 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	host->host_tagset = 1;
 	return 0;
 }
+
+static int ufshcd_mcq_poll_register(void __iomem *reg, u32 mask,
+			u32 val, unsigned long timeout_ms)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	int err = 0;
+
+	/* ignore bits that we don't intend to wait on */
+	val = val & mask;
+
+	while ((readl(reg) & mask) != val) {
+		usleep_range(10, 50);
+		if (time_after(jiffies, timeout)) {
+			err = -ETIMEDOUT;
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int ufshcd_mcq_sq_stop(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
+{
+	void __iomem *reg;
+	u32 i = hwq->id;
+	int err;
+
+	writel(SQ_STOP, mcq_opr_base(hba, OPR_SQD, i) + REG_SQRTC);
+	reg = mcq_opr_base(hba, OPR_SQD, i) + REG_SQRTS;
+	err = ufshcd_mcq_poll_register(reg, SQ_STS, SQ_STS, MCQ_POLL_MS);
+	if (err)
+		dev_err(hba->dev, "%s: failed. hwq-id=%d, err=%d\n",
+			__func__, i, err);
+	return err;
+}
+
+static int ufshcd_mcq_sq_start(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
+{
+	void __iomem *reg;
+	u32 i = hwq->id;
+	int err;
+
+	writel(SQ_START, mcq_opr_base(hba, OPR_SQD, i) + REG_SQRTC);
+	reg = mcq_opr_base(hba, OPR_SQD, i) + REG_SQRTS;
+	err = ufshcd_mcq_poll_register(reg, SQ_STS, 0, MCQ_POLL_MS);
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
+	u32 nexus, i;
+	int err;
+
+	hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
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
+	err = ufshcd_mcq_poll_register(reg, SQ_CUS, SQ_CUS, MCQ_POLL_MS);
+	if (err) {
+		dev_err(hba->dev, "%s: failed. hwq=%d, lun=0x%x, tag=%d\n",
+			__func__, i, lrbp->lun, task_tag);
+		*result = FIELD_GET(SQ_ICU_ERR_CODE_MASK, readl(reg));
+	}
+
+	err = ufshcd_mcq_sq_start(hba, hwq);
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
+	u32 i;
+
+	spin_lock(&hwq->sq_lock);
+
+	ufshcd_mcq_update_sq_head_slot(hwq);
+	if (ufshcd_mcq_is_sq_empty(hwq))
+		goto out;
+
+	addr = ufshcd_mcq_get_cmd_desc_addr(hba, task_tag);
+	i = hwq->sq_head_slot;
+	while (i != hwq->sq_tail_slot) {
+		utrd = (struct utp_transfer_req_desc *)(hwq->sqe_base_addr +
+				i * sizeof(struct utp_transfer_req_desc));
+		match = le64_to_cpu((__le64)utrd->command_desc_base_addr_hi << 32 |
+				utrd->command_desc_base_addr_lo) & CQE_UCD_BA;
+		if (addr == match) {
+			ret = true;
+			goto out;
+		}
+		i = (i + 1) & mask;
+	}
+
+out:
+	spin_unlock(&hwq->sq_lock);
+	return ret;
+}
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 529f850..e25a852 100644
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
@@ -403,4 +405,16 @@ static inline struct cq_entry *ufshcd_mcq_cur_cqe(struct ufs_hw_queue *q)
 
 	return cqe + q->cq_head_slot;
 }
+
+static inline void ufshcd_mcq_update_sq_head_slot(struct ufs_hw_queue *q)
+{
+	u32 val = readl(q->mcq_sq_head);
+
+	q->sq_head_slot = val / sizeof(struct utp_transfer_req_desc);
+}
+
+static inline bool ufshcd_mcq_is_sq_empty(struct ufs_hw_queue *q)
+{
+	return q->sq_head_slot == q->sq_tail_slot;
+}
 #endif /* _UFSHCD_PRIV_H_ */
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 629442c..49a05909 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -56,7 +56,8 @@
 #define NOP_OUT_RETRIES    10
 /* Timeout after 50 msecs if NOP OUT hangs without response */
 #define NOP_OUT_TIMEOUT    50 /* msecs */
-
+/* Maximum MCQ registers polling time */
+#define MCQ_POLL_TIMEOUT   500
 /* Query request retries */
 #define QUERY_REQ_RETRIES 3
 /* Query request timeout */
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 05e4164..6ee532e0 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1105,6 +1105,7 @@ struct ufs_hw_queue {
 	u32 max_entries;
 	u32 id;
 	u32 sq_tail_slot;
+	u32 sq_head_slot;
 	spinlock_t sq_lock;
 	u32 cq_tail_slot;
 	u32 cq_head_slot;
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 11424bb..252e731 100644
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
@@ -111,6 +114,19 @@ enum {
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
-- 
2.7.4

