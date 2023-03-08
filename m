Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F376AFDBA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 05:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCHEEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 23:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCHEEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 23:04:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4965B7BA0E;
        Tue,  7 Mar 2023 20:04:07 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32813aF5015583;
        Wed, 8 Mar 2023 04:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qWd5pKWqmEByBzyZsGGY/jdThnCP/WGL6MHz3xGtiYE=;
 b=VUwmPRpBMrnomi8tjTlcdB4ZoLhODmQKcYoHeKJGXOFplUAyE+idX12ICxKOo5FVY2oX
 F8plnpcg4v7NzcUGlQeilSkm+PAv0NchsX8pBL2C2++X42Bfcoq1y3G6ru3gfubNv9Zc
 way8raZo/UM1dc1+rSePq/C4a6gPkKaAqNJPl//A6sAHwRtZSdPi7bYy3a2nR1s+g+gd
 mRCxj/mE+yHhS2hy5Yr4XYj7Iuj1a/h4MO1j4gN27bviesuVOv0W6Ouwi5uQzoFZKrMc
 QPrAhJrpYKOlC27be5EdvT2/Lk+A5e02km+stJdoxP5QxQM1P1pHT28+lKIHBlM2vQ+0 vQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fga0g02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 04:03:24 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32843Nca020767
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 04:03:23 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 7 Mar 2023 20:03:22 -0800
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
Subject: [RFC PATCH v1 2/4] ufs: mcq: Add supporting functions for mcq abort
Date:   Tue, 7 Mar 2023 20:01:42 -0800
Message-ID: <b84abc7ea5bddc78ab3c70e9a7b5108a5bc9448f.1678247309.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1678247309.git.quic_nguyenb@quicinc.com>
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: InGfjkl9250A0K8acSYtNLvvpSzC8JhN
X-Proofpoint-ORIG-GUID: InGfjkl9250A0K8acSYtNLvvpSzC8JhN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supporting functions to handle ufs abort in mcq mode.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 217 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  14 +++
 drivers/ufs/core/ufshcd.c      |   4 +-
 include/ufs/ufshcd.h           |   3 +
 include/ufs/ufshci.h           |  16 +++
 5 files changed, 253 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 63729dd..e27d8eb 100644
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
@@ -429,3 +432,217 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
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
+	err = ufshcd_mcq_poll_register(reg, SQ_STS, SQ_STS, hba->mcq_poll_ms);
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
+	err = ufshcd_mcq_poll_register(reg, SQ_STS, 0, hba->mcq_poll_ms);
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
+	err = ufshcd_mcq_poll_register(reg, SQ_CUS, SQ_CUS, hba->mcq_poll_ms);
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
+
+/**
+ * ufshcd_mcq_cqe_search - Search for the cmd in the Completion Queue.
+ * @hba - per adapter instance.
+ * @hwq - the Hardware Queue to be searched.
+ * @task_tag - The command's tag.
+ *
+ * Returns true if the CQE containing the command is present in the CQ
+ * (not processed by host SW yet); returns false if the CQE is not in the CQ.
+ */
+static bool ufshcd_mcq_cqe_search(struct ufs_hba *hba,
+		struct ufs_hw_queue *hwq, int task_tag)
+{
+	struct cq_entry *cqe = hwq->cqe_base_addr;
+	u32 mask = hwq->max_entries - 1, i;
+	u64 addr, match;
+	bool ret = false;
+
+	spin_lock(&hwq->cq_lock);
+
+	if (ufshcd_mcq_is_cq_empty(hwq))
+		goto out;
+
+	addr = ufshcd_mcq_get_cmd_desc_addr(hba, task_tag);
+	i = hwq->cq_head_slot;
+	while (i != hwq->cq_tail_slot) {
+		cqe += i;
+		match = (le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA);
+		if (addr == match) {
+			ret = true;
+			goto out;
+		}
+		i = (i + 1) & mask;
+	}
+
+out:
+	spin_unlock(&hwq->cq_lock);
+	return ret;
+}
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 9597e955..0527926 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -76,6 +76,8 @@ struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq);
 
+int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag, int *result);
+
 #define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
 #define SD_ASCII_STD true
 #define SD_RAW false
@@ -401,4 +403,16 @@ static inline struct cq_entry *ufshcd_mcq_cur_cqe(struct ufs_hw_queue *q)
 
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
index e4d1b4e..7e52af6 100644
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
@@ -10065,6 +10066,7 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 	hba->dev = dev;
 	hba->dev_ref_clk_freq = REF_CLK_FREQ_INVAL;
 	hba->nop_out_timeout = NOP_OUT_TIMEOUT;
+	hba->mcq_poll_ms = MCQ_POLL_TIMEOUT;
 	ufshcd_set_sg_entry_size(hba, sizeof(struct ufshcd_sg_entry));
 	INIT_LIST_HEAD(&hba->clk_list_head);
 	spin_lock_init(&hba->outstanding_lock);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 5d7f9b2..9b5bdf3 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -909,6 +909,7 @@ enum ufshcd_mcq_opr {
  * @mcq_base: Multi circular queue registers base address
  * @uhq: array of supported hardware queues
  * @dev_cmd_queue: Queue for issuing device management commands
+ * @mcq_poll_timeout_ms: Max polling time for MCQ registers in ms
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -1072,6 +1073,7 @@ struct ufs_hba {
 	struct ufs_hw_queue *uhq;
 	struct ufs_hw_queue *dev_cmd_queue;
 	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
+	u32 mcq_poll_ms;
 };
 
 /**
@@ -1105,6 +1107,7 @@ struct ufs_hw_queue {
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

