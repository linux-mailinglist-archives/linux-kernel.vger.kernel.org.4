Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C21E5B346D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiIIJuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiIIJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:49:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFA9FF7;
        Fri,  9 Sep 2022 02:49:48 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MPB2S3XnlzmV89;
        Fri,  9 Sep 2022 17:46:08 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:46 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:45 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 02/10] crypto: hisilicon/qm - get qp num and depth from hardware registers
Date:   Fri, 9 Sep 2022 17:46:56 +0800
Message-ID: <20220909094704.32099-3-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220909094704.32099-1-qianweili@huawei.com>
References: <20220909094704.32099-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware V3 and later versions can obtain qp num and depth supported
by the hardware from registers. To be compatible with later hardware
versions, get qp num and depth from registers instead of fixed marcos.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c |   4 +-
 drivers/crypto/hisilicon/qm.c               | 166 ++++++++++++--------
 drivers/crypto/hisilicon/sec2/sec.h         |   5 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c  | 148 ++++++++++-------
 drivers/crypto/hisilicon/sec2/sec_main.c    |   1 -
 drivers/crypto/hisilicon/zip/zip_crypto.c   |   6 +-
 drivers/crypto/hisilicon/zip/zip_main.c     |   1 -
 include/linux/hisi_acc_qm.h                 |   5 +-
 8 files changed, 202 insertions(+), 134 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 3ba6f15deafc..2aa91a4f77da 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -147,7 +147,7 @@ static int hpre_alloc_req_id(struct hpre_ctx *ctx)
 	int id;
 
 	spin_lock_irqsave(&ctx->req_lock, flags);
-	id = idr_alloc(&ctx->req_idr, NULL, 0, QM_Q_DEPTH, GFP_ATOMIC);
+	id = idr_alloc(&ctx->req_idr, NULL, 0, ctx->qp->sq_depth, GFP_ATOMIC);
 	spin_unlock_irqrestore(&ctx->req_lock, flags);
 
 	return id;
@@ -488,7 +488,7 @@ static int hpre_ctx_init(struct hpre_ctx *ctx, u8 type)
 	qp->qp_ctx = ctx;
 	qp->req_cb = hpre_alg_cb;
 
-	ret = hpre_ctx_set(ctx, qp, QM_Q_DEPTH);
+	ret = hpre_ctx_set(ctx, qp, qp->sq_depth);
 	if (ret)
 		hpre_stop_qp_and_put(qp);
 
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index fa77b469761b..b3216ee627e5 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -78,6 +78,9 @@
 #define QM_EQ_OVERFLOW			1
 #define QM_CQE_ERROR			2
 
+#define QM_XQ_DEPTH_SHIFT		16
+#define QM_XQ_DEPTH_MASK		GENMASK(15, 0)
+
 #define QM_DOORBELL_CMD_SQ		0
 #define QM_DOORBELL_CMD_CQ		1
 #define QM_DOORBELL_CMD_EQ		2
@@ -88,8 +91,6 @@
 #define QM_DB_INDEX_SHIFT_V1		32
 #define QM_DB_PRIORITY_SHIFT_V1		48
 #define QM_PAGE_SIZE			0x0034
-#define QM_CAPBILITY			0x100158
-#define QM_QP_NUN_MASK			GENMASK(10, 0)
 #define QM_QP_DB_INTERVAL		0x10000
 
 #define QM_MEM_START_INIT		0x100040
@@ -222,7 +223,6 @@
 #define WAIT_PERIOD			20
 #define REMOVE_WAIT_DELAY		10
 #define QM_SQE_ADDR_MASK		GENMASK(7, 0)
-#define QM_EQ_DEPTH			(1024 * 2)
 
 #define QM_DRIVER_REMOVING		0
 #define QM_RST_SCHED			1
@@ -271,8 +271,8 @@
 	((buf_sz) << QM_CQ_BUF_SIZE_SHIFT)	| \
 	((cqe_sz) << QM_CQ_CQE_SIZE_SHIFT))
 
-#define QM_MK_CQC_DW3_V2(cqe_sz) \
-	((QM_Q_DEPTH - 1) | ((cqe_sz) << QM_CQ_CQE_SIZE_SHIFT))
+#define QM_MK_CQC_DW3_V2(cqe_sz, cq_depth) \
+	((((u32)cq_depth) - 1) | ((cqe_sz) << QM_CQ_CQE_SIZE_SHIFT))
 
 #define QM_MK_SQC_W13(priority, orders, alg_type) \
 	(((priority) << QM_SQ_PRIORITY_SHIFT)	| \
@@ -285,8 +285,8 @@
 	((buf_sz) << QM_SQ_BUF_SIZE_SHIFT)	| \
 	((u32)ilog2(sqe_sz) << QM_SQ_SQE_SIZE_SHIFT))
 
-#define QM_MK_SQC_DW3_V2(sqe_sz) \
-	((QM_Q_DEPTH - 1) | ((u32)ilog2(sqe_sz) << QM_SQ_SQE_SIZE_SHIFT))
+#define QM_MK_SQC_DW3_V2(sqe_sz, sq_depth) \
+	((((u32)sq_depth) - 1) | ((u32)ilog2(sqe_sz) << QM_SQ_SQE_SIZE_SHIFT))
 
 #define INIT_QC_COMMON(qc, base, pasid) do {			\
 	(qc)->head = 0;						\
@@ -330,6 +330,13 @@ enum qm_mb_cmd {
 	QM_VF_GET_QOS,
 };
 
+enum qm_basic_type {
+	QM_TOTAL_QP_NUM_CAP = 0x0,
+	QM_FUNC_MAX_QP_CAP,
+	QM_XEQ_DEPTH_CAP,
+	QM_QP_DEPTH_CAP,
+};
+
 static const struct hisi_qm_cap_info qm_cap_info_comm[] = {
 	{QM_SUPPORT_DB_ISOLATION, 0x30,   0, BIT(0),  0x0, 0x0, 0x0},
 	{QM_SUPPORT_FUNC_QOS,     0x3100, 0, BIT(8),  0x0, 0x0, 0x1},
@@ -346,6 +353,13 @@ static const struct hisi_qm_cap_info qm_cap_info_vf[] = {
 	{QM_SUPPORT_RPM, 0x3100, 0, BIT(12), 0x0, 0x0, 0x0},
 };
 
+static const struct hisi_qm_cap_info qm_basic_info[] = {
+	{QM_TOTAL_QP_NUM_CAP,   0x100158, 0,  GENMASK(10, 0), 0x1000,    0x400,     0x400},
+	{QM_FUNC_MAX_QP_CAP,    0x100158, 11, GENMASK(10, 0), 0x1000,    0x400,     0x400},
+	{QM_XEQ_DEPTH_CAP,      0x3104,   0,  GENMASK(15, 0), 0x800,     0x4000800, 0x4000800},
+	{QM_QP_DEPTH_CAP,       0x3108,   0,  GENMASK(31, 0), 0x4000400, 0x4000400, 0x4000400},
+};
+
 struct qm_cqe {
 	__le32 rsvd0;
 	__le16 cmd_id;
@@ -884,6 +898,16 @@ u32 hisi_qm_get_hw_info(struct hisi_qm *qm,
 }
 EXPORT_SYMBOL_GPL(hisi_qm_get_hw_info);
 
+static void qm_get_xqc_depth(struct hisi_qm *qm, u16 *low_bits,
+			     u16 *high_bits, enum qm_basic_type type)
+{
+	u32 depth;
+
+	depth = hisi_qm_get_hw_info(qm, qm_basic_info, type, qm->cap_ver);
+	*high_bits = depth & QM_XQ_DEPTH_MASK;
+	*low_bits = (depth >> QM_XQ_DEPTH_SHIFT) & QM_XQ_DEPTH_MASK;
+}
+
 static u32 qm_get_irq_num_v1(struct hisi_qm *qm)
 {
 	return QM_IRQ_NUM_V1;
@@ -935,7 +959,7 @@ static void qm_pm_put_sync(struct hisi_qm *qm)
 
 static void qm_cq_head_update(struct hisi_qp *qp)
 {
-	if (qp->qp_status.cq_head == QM_Q_DEPTH - 1) {
+	if (qp->qp_status.cq_head == qp->cq_depth - 1) {
 		qp->qp_status.cqc_phase = !qp->qp_status.cqc_phase;
 		qp->qp_status.cq_head = 0;
 	} else {
@@ -967,6 +991,7 @@ static int qm_get_complete_eqe_num(struct hisi_qm_poll_data *poll_data)
 {
 	struct hisi_qm *qm = poll_data->qm;
 	struct qm_eqe *eqe = qm->eqe + qm->status.eq_head;
+	u16 eq_depth = qm->eq_depth;
 	int eqe_num = 0;
 	u16 cqn;
 
@@ -975,7 +1000,7 @@ static int qm_get_complete_eqe_num(struct hisi_qm_poll_data *poll_data)
 		poll_data->qp_finish_id[eqe_num] = cqn;
 		eqe_num++;
 
-		if (qm->status.eq_head == QM_EQ_DEPTH - 1) {
+		if (qm->status.eq_head == eq_depth - 1) {
 			qm->status.eqc_phase = !qm->status.eqc_phase;
 			eqe = qm->eqe;
 			qm->status.eq_head = 0;
@@ -984,7 +1009,7 @@ static int qm_get_complete_eqe_num(struct hisi_qm_poll_data *poll_data)
 			qm->status.eq_head++;
 		}
 
-		if (eqe_num == (QM_EQ_DEPTH >> 1) - 1)
+		if (eqe_num == (eq_depth >> 1) - 1)
 			break;
 	}
 
@@ -1124,6 +1149,7 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 {
 	struct hisi_qm *qm = data;
 	struct qm_aeqe *aeqe = qm->aeqe + qm->status.aeq_head;
+	u16 aeq_depth = qm->aeq_depth;
 	u32 type, qp_id;
 
 	while (QM_AEQE_PHASE(aeqe) == qm->status.aeqc_phase) {
@@ -1148,7 +1174,7 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 			break;
 		}
 
-		if (qm->status.aeq_head == QM_Q_DEPTH - 1) {
+		if (qm->status.aeq_head == aeq_depth - 1) {
 			qm->status.aeqc_phase = !qm->status.aeqc_phase;
 			aeqe = qm->aeqe;
 			qm->status.aeq_head = 0;
@@ -2050,7 +2076,7 @@ static int qm_eqc_aeqc_dump(struct hisi_qm *qm, char *s, size_t size,
 }
 
 static int q_dump_param_parse(struct hisi_qm *qm, char *s,
-			      u32 *e_id, u32 *q_id)
+			      u32 *e_id, u32 *q_id, u16 q_depth)
 {
 	struct device *dev = &qm->pdev->dev;
 	unsigned int qp_num = qm->qp_num;
@@ -2076,8 +2102,8 @@ static int q_dump_param_parse(struct hisi_qm *qm, char *s,
 	}
 
 	ret = kstrtou32(presult, 0, e_id);
-	if (ret || *e_id >= QM_Q_DEPTH) {
-		dev_err(dev, "Please input sqe num (0-%d)", QM_Q_DEPTH - 1);
+	if (ret || *e_id >= q_depth) {
+		dev_err(dev, "Please input sqe num (0-%u)", q_depth - 1);
 		return -EINVAL;
 	}
 
@@ -2091,21 +2117,22 @@ static int q_dump_param_parse(struct hisi_qm *qm, char *s,
 
 static int qm_sq_dump(struct hisi_qm *qm, char *s)
 {
+	u16 sq_depth = qm->qp_array->cq_depth;
 	void *sqe, *sqe_curr;
 	struct hisi_qp *qp;
 	u32 qp_id, sqe_id;
 	int ret;
 
-	ret = q_dump_param_parse(qm, s, &sqe_id, &qp_id);
+	ret = q_dump_param_parse(qm, s, &sqe_id, &qp_id, sq_depth);
 	if (ret)
 		return ret;
 
-	sqe = kzalloc(qm->sqe_size * QM_Q_DEPTH, GFP_KERNEL);
+	sqe = kzalloc(qm->sqe_size * sq_depth, GFP_KERNEL);
 	if (!sqe)
 		return -ENOMEM;
 
 	qp = &qm->qp_array[qp_id];
-	memcpy(sqe, qp->sqe, qm->sqe_size * QM_Q_DEPTH);
+	memcpy(sqe, qp->sqe, qm->sqe_size * sq_depth);
 	sqe_curr = sqe + (u32)(sqe_id * qm->sqe_size);
 	memset(sqe_curr + qm->debug.sqe_mask_offset, QM_SQE_ADDR_MASK,
 	       qm->debug.sqe_mask_len);
@@ -2124,7 +2151,7 @@ static int qm_cq_dump(struct hisi_qm *qm, char *s)
 	u32 qp_id, cqe_id;
 	int ret;
 
-	ret = q_dump_param_parse(qm, s, &cqe_id, &qp_id);
+	ret = q_dump_param_parse(qm, s, &cqe_id, &qp_id, qm->qp_array->cq_depth);
 	if (ret)
 		return ret;
 
@@ -2150,11 +2177,11 @@ static int qm_eq_aeq_dump(struct hisi_qm *qm, const char *s,
 	if (ret)
 		return -EINVAL;
 
-	if (!strcmp(name, "EQE") && xeqe_id >= QM_EQ_DEPTH) {
-		dev_err(dev, "Please input eqe num (0-%d)", QM_EQ_DEPTH - 1);
+	if (!strcmp(name, "EQE") && xeqe_id >= qm->eq_depth) {
+		dev_err(dev, "Please input eqe num (0-%u)", qm->eq_depth - 1);
 		return -EINVAL;
-	} else if (!strcmp(name, "AEQE") && xeqe_id >= QM_Q_DEPTH) {
-		dev_err(dev, "Please input aeqe num (0-%d)", QM_Q_DEPTH - 1);
+	} else if (!strcmp(name, "AEQE") && xeqe_id >= qm->aeq_depth) {
+		dev_err(dev, "Please input aeqe num (0-%u)", qm->eq_depth - 1);
 		return -EINVAL;
 	}
 
@@ -2805,7 +2832,7 @@ static void *qm_get_avail_sqe(struct hisi_qp *qp)
 	struct hisi_qp_status *qp_status = &qp->qp_status;
 	u16 sq_tail = qp_status->sq_tail;
 
-	if (unlikely(atomic_read(&qp->qp_status.used) == QM_Q_DEPTH - 1))
+	if (unlikely(atomic_read(&qp->qp_status.used) == qp->sq_depth - 1))
 		return NULL;
 
 	return qp->sqe + sq_tail * qp->qm->sqe_size;
@@ -2846,7 +2873,7 @@ static struct hisi_qp *qm_create_qp_nolock(struct hisi_qm *qm, u8 alg_type)
 
 	qp = &qm->qp_array[qp_id];
 	hisi_qm_unset_hw_reset(qp);
-	memset(qp->cqe, 0, sizeof(struct qm_cqe) * QM_Q_DEPTH);
+	memset(qp->cqe, 0, sizeof(struct qm_cqe) * qp->cq_depth);
 
 	qp->event_cb = NULL;
 	qp->req_cb = NULL;
@@ -2927,9 +2954,9 @@ static int qm_sq_ctx_cfg(struct hisi_qp *qp, int qp_id, u32 pasid)
 	INIT_QC_COMMON(sqc, qp->sqe_dma, pasid);
 	if (ver == QM_HW_V1) {
 		sqc->dw3 = cpu_to_le32(QM_MK_SQC_DW3_V1(0, 0, 0, qm->sqe_size));
-		sqc->w8 = cpu_to_le16(QM_Q_DEPTH - 1);
+		sqc->w8 = cpu_to_le16(qp->sq_depth - 1);
 	} else {
-		sqc->dw3 = cpu_to_le32(QM_MK_SQC_DW3_V2(qm->sqe_size));
+		sqc->dw3 = cpu_to_le32(QM_MK_SQC_DW3_V2(qm->sqe_size, qp->sq_depth));
 		sqc->w8 = 0; /* rand_qc */
 	}
 	sqc->cq_num = cpu_to_le16(qp_id);
@@ -2970,9 +2997,9 @@ static int qm_cq_ctx_cfg(struct hisi_qp *qp, int qp_id, u32 pasid)
 	if (ver == QM_HW_V1) {
 		cqc->dw3 = cpu_to_le32(QM_MK_CQC_DW3_V1(0, 0, 0,
 							QM_QC_CQE_SIZE));
-		cqc->w8 = cpu_to_le16(QM_Q_DEPTH - 1);
+		cqc->w8 = cpu_to_le16(qp->cq_depth - 1);
 	} else {
-		cqc->dw3 = cpu_to_le32(QM_MK_CQC_DW3_V2(QM_QC_CQE_SIZE));
+		cqc->dw3 = cpu_to_le32(QM_MK_CQC_DW3_V2(QM_QC_CQE_SIZE, qp->cq_depth));
 		cqc->w8 = 0; /* rand_qc */
 	}
 	cqc->dw6 = cpu_to_le32(1 << QM_CQ_PHASE_SHIFT | 1 << QM_CQ_FLAG_SHIFT);
@@ -3059,13 +3086,14 @@ static void qp_stop_fail_cb(struct hisi_qp *qp)
 {
 	int qp_used = atomic_read(&qp->qp_status.used);
 	u16 cur_tail = qp->qp_status.sq_tail;
-	u16 cur_head = (cur_tail + QM_Q_DEPTH - qp_used) % QM_Q_DEPTH;
+	u16 sq_depth = qp->sq_depth;
+	u16 cur_head = (cur_tail + sq_depth - qp_used) % sq_depth;
 	struct hisi_qm *qm = qp->qm;
 	u16 pos;
 	int i;
 
 	for (i = 0; i < qp_used; i++) {
-		pos = (i + cur_head) % QM_Q_DEPTH;
+		pos = (i + cur_head) % sq_depth;
 		qp->req_cb(qp, qp->sqe + (u32)(qm->sqe_size * pos));
 		atomic_dec(&qp->qp_status.used);
 	}
@@ -3213,7 +3241,7 @@ int hisi_qp_send(struct hisi_qp *qp, const void *msg)
 {
 	struct hisi_qp_status *qp_status = &qp->qp_status;
 	u16 sq_tail = qp_status->sq_tail;
-	u16 sq_tail_next = (sq_tail + 1) % QM_Q_DEPTH;
+	u16 sq_tail_next = (sq_tail + 1) % qp->sq_depth;
 	void *sqe = qm_get_avail_sqe(qp);
 
 	if (unlikely(atomic_read(&qp->qp_status.flags) == QP_STOP ||
@@ -3442,6 +3470,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 	struct uacce_device *uacce;
 	unsigned long mmio_page_nr;
 	unsigned long dus_page_nr;
+	u16 sq_depth, cq_depth;
 	struct uacce_interface interface = {
 		.flags = UACCE_DEV_SVA,
 		.ops = &uacce_qm_ops,
@@ -3485,9 +3514,11 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 	else
 		mmio_page_nr = qm->db_interval / PAGE_SIZE;
 
+	qm_get_xqc_depth(qm, &sq_depth, &cq_depth, QM_QP_DEPTH_CAP);
+
 	/* Add one more page for device or qp status */
-	dus_page_nr = (PAGE_SIZE - 1 + qm->sqe_size * QM_Q_DEPTH +
-		       sizeof(struct qm_cqe) * QM_Q_DEPTH  + PAGE_SIZE) >>
+	dus_page_nr = (PAGE_SIZE - 1 + qm->sqe_size * sq_depth +
+		       sizeof(struct qm_cqe) * cq_depth  + PAGE_SIZE) >>
 					 PAGE_SHIFT;
 
 	uacce->qf_pg_num[UACCE_QFRT_MMIO] = mmio_page_nr;
@@ -3592,10 +3623,11 @@ static void hisi_qp_memory_uninit(struct hisi_qm *qm, int num)
 	kfree(qm->qp_array);
 }
 
-static int hisi_qp_memory_init(struct hisi_qm *qm, size_t dma_size, int id)
+static int hisi_qp_memory_init(struct hisi_qm *qm, size_t dma_size, int id,
+			       u16 sq_depth, u16 cq_depth)
 {
 	struct device *dev = &qm->pdev->dev;
-	size_t off = qm->sqe_size * QM_Q_DEPTH;
+	size_t off = qm->sqe_size * sq_depth;
 	struct hisi_qp *qp;
 	int ret = -ENOMEM;
 
@@ -3615,6 +3647,8 @@ static int hisi_qp_memory_init(struct hisi_qm *qm, size_t dma_size, int id)
 	qp->cqe = qp->qdma.va + off;
 	qp->cqe_dma = qp->qdma.dma + off;
 	qp->qdma.size = dma_size;
+	qp->sq_depth = sq_depth;
+	qp->cq_depth = cq_depth;
 	qp->qm = qm;
 	qp->qp_id = id;
 
@@ -3858,7 +3892,7 @@ static int qm_eq_ctx_cfg(struct hisi_qm *qm)
 	eqc->base_h = cpu_to_le32(upper_32_bits(qm->eqe_dma));
 	if (qm->ver == QM_HW_V1)
 		eqc->dw3 = cpu_to_le32(QM_EQE_AEQE_SIZE);
-	eqc->dw6 = cpu_to_le32((QM_EQ_DEPTH - 1) | (1 << QM_EQC_PHASE_SHIFT));
+	eqc->dw6 = cpu_to_le32(((u32)qm->eq_depth - 1) | (1 << QM_EQC_PHASE_SHIFT));
 
 	eqc_dma = dma_map_single(dev, eqc, sizeof(struct qm_eqc),
 				 DMA_TO_DEVICE);
@@ -3887,7 +3921,7 @@ static int qm_aeq_ctx_cfg(struct hisi_qm *qm)
 
 	aeqc->base_l = cpu_to_le32(lower_32_bits(qm->aeqe_dma));
 	aeqc->base_h = cpu_to_le32(upper_32_bits(qm->aeqe_dma));
-	aeqc->dw6 = cpu_to_le32((QM_Q_DEPTH - 1) | (1 << QM_EQC_PHASE_SHIFT));
+	aeqc->dw6 = cpu_to_le32(((u32)qm->aeq_depth - 1) | (1 << QM_EQC_PHASE_SHIFT));
 
 	aeqc_dma = dma_map_single(dev, aeqc, sizeof(struct qm_aeqc),
 				  DMA_TO_DEVICE);
@@ -5947,19 +5981,21 @@ EXPORT_SYMBOL_GPL(hisi_qm_alg_unregister);
 
 static int qm_get_qp_num(struct hisi_qm *qm)
 {
-	if (qm->ver == QM_HW_V1)
-		qm->ctrl_qp_num = QM_QNUM_V1;
-	else if (qm->ver == QM_HW_V2)
-		qm->ctrl_qp_num = QM_QNUM_V2;
-	else
-		qm->ctrl_qp_num = readl(qm->io_base + QM_CAPBILITY) &
-					QM_QP_NUN_MASK;
+	bool is_db_isolation;
 
-	if (test_bit(QM_SUPPORT_DB_ISOLATION, &qm->caps))
-		qm->max_qp_num = (readl(qm->io_base + QM_CAPBILITY) >>
-				  QM_QP_MAX_NUM_SHIFT) & QM_QP_NUN_MASK;
-	else
-		qm->max_qp_num = qm->ctrl_qp_num;
+	/* VF's qp_num assigned by PF in v2, and VF can get qp_num by vft. */
+	if (qm->fun_type == QM_HW_VF) {
+		if (qm->ver != QM_HW_V1)
+			/* v2 starts to support get vft by mailbox */
+			return hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
+
+		return 0;
+	}
+
+	is_db_isolation = test_bit(QM_SUPPORT_DB_ISOLATION, &qm->caps);
+	qm->ctrl_qp_num = hisi_qm_get_hw_info(qm, qm_basic_info, QM_TOTAL_QP_NUM_CAP, true);
+	qm->max_qp_num = hisi_qm_get_hw_info(qm, qm_basic_info,
+					     QM_FUNC_MAX_QP_CAP, is_db_isolation);
 
 	/* check if qp number is valid */
 	if (qm->qp_num > qm->max_qp_num) {
@@ -6039,11 +6075,9 @@ static int qm_get_pci_res(struct hisi_qm *qm)
 		qm->db_interval = 0;
 	}
 
-	if (qm->fun_type == QM_HW_PF) {
-		ret = qm_get_qp_num(qm);
-		if (ret)
-			goto err_db_ioremap;
-	}
+	ret = qm_get_qp_num(qm);
+	if (ret)
+		goto err_db_ioremap;
 
 	return 0;
 
@@ -6126,6 +6160,7 @@ static int hisi_qm_init_work(struct hisi_qm *qm)
 static int hisi_qp_alloc_memory(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
+	u16 sq_depth, cq_depth;
 	size_t qp_dma_size;
 	int i, ret;
 
@@ -6139,13 +6174,14 @@ static int hisi_qp_alloc_memory(struct hisi_qm *qm)
 		return -ENOMEM;
 	}
 
+	qm_get_xqc_depth(qm, &sq_depth, &cq_depth, QM_QP_DEPTH_CAP);
+
 	/* one more page for device or qp statuses */
-	qp_dma_size = qm->sqe_size * QM_Q_DEPTH +
-		      sizeof(struct qm_cqe) * QM_Q_DEPTH;
+	qp_dma_size = qm->sqe_size * sq_depth + sizeof(struct qm_cqe) * cq_depth;
 	qp_dma_size = PAGE_ALIGN(qp_dma_size) + PAGE_SIZE;
 	for (i = 0; i < qm->qp_num; i++) {
 		qm->poll_data[i].qm = qm;
-		ret = hisi_qp_memory_init(qm, qp_dma_size, i);
+		ret = hisi_qp_memory_init(qm, qp_dma_size, i, sq_depth, cq_depth);
 		if (ret)
 			goto err_init_qp_mem;
 
@@ -6182,8 +6218,9 @@ static int hisi_qm_memory_init(struct hisi_qm *qm)
 } while (0)
 
 	idr_init(&qm->qp_idr);
-	qm->qdma.size = QMC_ALIGN(sizeof(struct qm_eqe) * QM_EQ_DEPTH) +
-			QMC_ALIGN(sizeof(struct qm_aeqe) * QM_Q_DEPTH) +
+	qm_get_xqc_depth(qm, &qm->eq_depth, &qm->aeq_depth, QM_XEQ_DEPTH_CAP);
+	qm->qdma.size = QMC_ALIGN(sizeof(struct qm_eqe) * qm->eq_depth) +
+			QMC_ALIGN(sizeof(struct qm_aeqe) * qm->aeq_depth) +
 			QMC_ALIGN(sizeof(struct qm_sqc) * qm->qp_num) +
 			QMC_ALIGN(sizeof(struct qm_cqc) * qm->qp_num);
 	qm->qdma.va = dma_alloc_coherent(dev, qm->qdma.size, &qm->qdma.dma,
@@ -6194,8 +6231,8 @@ static int hisi_qm_memory_init(struct hisi_qm *qm)
 		goto err_destroy_idr;
 	}
 
-	QM_INIT_BUF(qm, eqe, QM_EQ_DEPTH);
-	QM_INIT_BUF(qm, aeqe, QM_Q_DEPTH);
+	QM_INIT_BUF(qm, eqe, qm->eq_depth);
+	QM_INIT_BUF(qm, aeqe, qm->aeq_depth);
 	QM_INIT_BUF(qm, sqc, qm->qp_num);
 	QM_INIT_BUF(qm, cqc, qm->qp_num);
 
@@ -6257,13 +6294,6 @@ int hisi_qm_init(struct hisi_qm *qm)
 	if (ret)
 		goto err_pci_init;
 
-	if (qm->fun_type == QM_HW_VF && qm->ver != QM_HW_V1) {
-		/* v2 starts to support get vft by mailbox */
-		ret = hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
-		if (ret)
-			goto err_irq_register;
-	}
-
 	if (qm->fun_type == QM_HW_PF) {
 		qm_disable_clock_gate(qm);
 		ret = qm_dev_mem_reset(qm);
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index d2a0bc93e752..04e034abc5e8 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -17,6 +17,7 @@ struct sec_alg_res {
 	dma_addr_t a_ivin_dma;
 	u8 *out_mac;
 	dma_addr_t out_mac_dma;
+	u16 depth;
 };
 
 /* Cipher request of SEC private */
@@ -115,9 +116,9 @@ struct sec_cipher_ctx {
 /* SEC queue context which defines queue's relatives */
 struct sec_qp_ctx {
 	struct hisi_qp *qp;
-	struct sec_req *req_list[QM_Q_DEPTH];
+	struct sec_req **req_list;
 	struct idr req_idr;
-	struct sec_alg_res res[QM_Q_DEPTH];
+	struct sec_alg_res *res;
 	struct sec_ctx *ctx;
 	spinlock_t req_lock;
 	struct list_head backlog;
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 77c9f13cf69a..db2165e9fcbf 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -59,14 +59,14 @@
 #define SEC_ICV_MASK		0x000E
 #define SEC_SQE_LEN_RATE_MASK	0x3
 
-#define SEC_TOTAL_IV_SZ		(SEC_IV_SIZE * QM_Q_DEPTH)
+#define SEC_TOTAL_IV_SZ(depth)	(SEC_IV_SIZE * (depth))
 #define SEC_SGL_SGE_NR		128
 #define SEC_CIPHER_AUTH		0xfe
 #define SEC_AUTH_CIPHER		0x1
 #define SEC_MAX_MAC_LEN		64
 #define SEC_MAX_AAD_LEN		65535
 #define SEC_MAX_CCM_AAD_LEN	65279
-#define SEC_TOTAL_MAC_SZ	(SEC_MAX_MAC_LEN * QM_Q_DEPTH)
+#define SEC_TOTAL_MAC_SZ(depth) (SEC_MAX_MAC_LEN * (depth))
 
 #define SEC_PBUF_SZ			512
 #define SEC_PBUF_IV_OFFSET		SEC_PBUF_SZ
@@ -74,11 +74,11 @@
 #define SEC_PBUF_PKG		(SEC_PBUF_SZ + SEC_IV_SIZE +	\
 			SEC_MAX_MAC_LEN * 2)
 #define SEC_PBUF_NUM		(PAGE_SIZE / SEC_PBUF_PKG)
-#define SEC_PBUF_PAGE_NUM	(QM_Q_DEPTH / SEC_PBUF_NUM)
-#define SEC_PBUF_LEFT_SZ	(SEC_PBUF_PKG * (QM_Q_DEPTH -	\
-			SEC_PBUF_PAGE_NUM * SEC_PBUF_NUM))
-#define SEC_TOTAL_PBUF_SZ	(PAGE_SIZE * SEC_PBUF_PAGE_NUM +	\
-			SEC_PBUF_LEFT_SZ)
+#define SEC_PBUF_PAGE_NUM(depth)	((depth) / SEC_PBUF_NUM)
+#define SEC_PBUF_LEFT_SZ(depth)		(SEC_PBUF_PKG * ((depth) -	\
+				SEC_PBUF_PAGE_NUM(depth) * SEC_PBUF_NUM))
+#define SEC_TOTAL_PBUF_SZ(depth)	(PAGE_SIZE * SEC_PBUF_PAGE_NUM(depth) +	\
+				SEC_PBUF_LEFT_SZ(depth))
 
 #define SEC_SQE_LEN_RATE	4
 #define SEC_SQE_CFLAG		2
@@ -128,9 +128,7 @@ static int sec_alloc_req_id(struct sec_req *req, struct sec_qp_ctx *qp_ctx)
 	int req_id;
 
 	spin_lock_bh(&qp_ctx->req_lock);
-
-	req_id = idr_alloc_cyclic(&qp_ctx->req_idr, NULL,
-				  0, QM_Q_DEPTH, GFP_ATOMIC);
+	req_id = idr_alloc_cyclic(&qp_ctx->req_idr, NULL, 0, qp_ctx->qp->sq_depth, GFP_ATOMIC);
 	spin_unlock_bh(&qp_ctx->req_lock);
 	if (unlikely(req_id < 0)) {
 		dev_err(req->ctx->dev, "alloc req id fail!\n");
@@ -148,7 +146,7 @@ static void sec_free_req_id(struct sec_req *req)
 	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
 	int req_id = req->req_id;
 
-	if (unlikely(req_id < 0 || req_id >= QM_Q_DEPTH)) {
+	if (unlikely(req_id < 0 || req_id >= qp_ctx->qp->sq_depth)) {
 		dev_err(req->ctx->dev, "free request id invalid!\n");
 		return;
 	}
@@ -300,14 +298,15 @@ static int sec_bd_send(struct sec_ctx *ctx, struct sec_req *req)
 /* Get DMA memory resources */
 static int sec_alloc_civ_resource(struct device *dev, struct sec_alg_res *res)
 {
+	u16 q_depth = res->depth;
 	int i;
 
-	res->c_ivin = dma_alloc_coherent(dev, SEC_TOTAL_IV_SZ,
+	res->c_ivin = dma_alloc_coherent(dev, SEC_TOTAL_IV_SZ(q_depth),
 					 &res->c_ivin_dma, GFP_KERNEL);
 	if (!res->c_ivin)
 		return -ENOMEM;
 
-	for (i = 1; i < QM_Q_DEPTH; i++) {
+	for (i = 1; i < q_depth; i++) {
 		res[i].c_ivin_dma = res->c_ivin_dma + i * SEC_IV_SIZE;
 		res[i].c_ivin = res->c_ivin + i * SEC_IV_SIZE;
 	}
@@ -318,20 +317,21 @@ static int sec_alloc_civ_resource(struct device *dev, struct sec_alg_res *res)
 static void sec_free_civ_resource(struct device *dev, struct sec_alg_res *res)
 {
 	if (res->c_ivin)
-		dma_free_coherent(dev, SEC_TOTAL_IV_SZ,
+		dma_free_coherent(dev, SEC_TOTAL_IV_SZ(res->depth),
 				  res->c_ivin, res->c_ivin_dma);
 }
 
 static int sec_alloc_aiv_resource(struct device *dev, struct sec_alg_res *res)
 {
+	u16 q_depth = res->depth;
 	int i;
 
-	res->a_ivin = dma_alloc_coherent(dev, SEC_TOTAL_IV_SZ,
+	res->a_ivin = dma_alloc_coherent(dev, SEC_TOTAL_IV_SZ(q_depth),
 					 &res->a_ivin_dma, GFP_KERNEL);
 	if (!res->a_ivin)
 		return -ENOMEM;
 
-	for (i = 1; i < QM_Q_DEPTH; i++) {
+	for (i = 1; i < q_depth; i++) {
 		res[i].a_ivin_dma = res->a_ivin_dma + i * SEC_IV_SIZE;
 		res[i].a_ivin = res->a_ivin + i * SEC_IV_SIZE;
 	}
@@ -342,20 +342,21 @@ static int sec_alloc_aiv_resource(struct device *dev, struct sec_alg_res *res)
 static void sec_free_aiv_resource(struct device *dev, struct sec_alg_res *res)
 {
 	if (res->a_ivin)
-		dma_free_coherent(dev, SEC_TOTAL_IV_SZ,
+		dma_free_coherent(dev, SEC_TOTAL_IV_SZ(res->depth),
 				  res->a_ivin, res->a_ivin_dma);
 }
 
 static int sec_alloc_mac_resource(struct device *dev, struct sec_alg_res *res)
 {
+	u16 q_depth = res->depth;
 	int i;
 
-	res->out_mac = dma_alloc_coherent(dev, SEC_TOTAL_MAC_SZ << 1,
+	res->out_mac = dma_alloc_coherent(dev, SEC_TOTAL_MAC_SZ(q_depth) << 1,
 					  &res->out_mac_dma, GFP_KERNEL);
 	if (!res->out_mac)
 		return -ENOMEM;
 
-	for (i = 1; i < QM_Q_DEPTH; i++) {
+	for (i = 1; i < q_depth; i++) {
 		res[i].out_mac_dma = res->out_mac_dma +
 				     i * (SEC_MAX_MAC_LEN << 1);
 		res[i].out_mac = res->out_mac + i * (SEC_MAX_MAC_LEN << 1);
@@ -367,14 +368,14 @@ static int sec_alloc_mac_resource(struct device *dev, struct sec_alg_res *res)
 static void sec_free_mac_resource(struct device *dev, struct sec_alg_res *res)
 {
 	if (res->out_mac)
-		dma_free_coherent(dev, SEC_TOTAL_MAC_SZ << 1,
+		dma_free_coherent(dev, SEC_TOTAL_MAC_SZ(res->depth) << 1,
 				  res->out_mac, res->out_mac_dma);
 }
 
 static void sec_free_pbuf_resource(struct device *dev, struct sec_alg_res *res)
 {
 	if (res->pbuf)
-		dma_free_coherent(dev, SEC_TOTAL_PBUF_SZ,
+		dma_free_coherent(dev, SEC_TOTAL_PBUF_SZ(res->depth),
 				  res->pbuf, res->pbuf_dma);
 }
 
@@ -384,10 +385,12 @@ static void sec_free_pbuf_resource(struct device *dev, struct sec_alg_res *res)
  */
 static int sec_alloc_pbuf_resource(struct device *dev, struct sec_alg_res *res)
 {
+	u16 q_depth = res->depth;
+	int size = SEC_PBUF_PAGE_NUM(q_depth);
 	int pbuf_page_offset;
 	int i, j, k;
 
-	res->pbuf = dma_alloc_coherent(dev, SEC_TOTAL_PBUF_SZ,
+	res->pbuf = dma_alloc_coherent(dev, SEC_TOTAL_PBUF_SZ(q_depth),
 				&res->pbuf_dma, GFP_KERNEL);
 	if (!res->pbuf)
 		return -ENOMEM;
@@ -400,11 +403,11 @@ static int sec_alloc_pbuf_resource(struct device *dev, struct sec_alg_res *res)
 	 * So we need SEC_PBUF_PAGE_NUM numbers of PAGE
 	 * for the SEC_TOTAL_PBUF_SZ
 	 */
-	for (i = 0; i <= SEC_PBUF_PAGE_NUM; i++) {
+	for (i = 0; i <= size; i++) {
 		pbuf_page_offset = PAGE_SIZE * i;
 		for (j = 0; j < SEC_PBUF_NUM; j++) {
 			k = i * SEC_PBUF_NUM + j;
-			if (k == QM_Q_DEPTH)
+			if (k == q_depth)
 				break;
 			res[k].pbuf = res->pbuf +
 				j * SEC_PBUF_PKG + pbuf_page_offset;
@@ -470,36 +473,29 @@ static void sec_alg_resource_free(struct sec_ctx *ctx,
 		sec_free_mac_resource(dev, qp_ctx->res);
 }
 
-static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
-			     int qp_ctx_id, int alg_type)
+static int sec_alloc_qp_ctx_resource(struct hisi_qm *qm, struct sec_ctx *ctx,
+				     struct sec_qp_ctx *qp_ctx)
 {
+	u16 q_depth = qp_ctx->qp->sq_depth;
 	struct device *dev = ctx->dev;
-	struct sec_qp_ctx *qp_ctx;
-	struct hisi_qp *qp;
 	int ret = -ENOMEM;
 
-	qp_ctx = &ctx->qp_ctx[qp_ctx_id];
-	qp = ctx->qps[qp_ctx_id];
-	qp->req_type = 0;
-	qp->qp_ctx = qp_ctx;
-	qp_ctx->qp = qp;
-	qp_ctx->ctx = ctx;
-
-	qp->req_cb = sec_req_cb;
+	qp_ctx->req_list = kcalloc(q_depth, sizeof(struct sec_req *), GFP_KERNEL);
+	if (!qp_ctx->req_list)
+		return ret;
 
-	spin_lock_init(&qp_ctx->req_lock);
-	idr_init(&qp_ctx->req_idr);
-	INIT_LIST_HEAD(&qp_ctx->backlog);
+	qp_ctx->res = kcalloc(q_depth, sizeof(struct sec_alg_res), GFP_KERNEL);
+	if (!qp_ctx->res)
+		goto err_free_req_list;
+	qp_ctx->res->depth = q_depth;
 
-	qp_ctx->c_in_pool = hisi_acc_create_sgl_pool(dev, QM_Q_DEPTH,
-						     SEC_SGL_SGE_NR);
+	qp_ctx->c_in_pool = hisi_acc_create_sgl_pool(dev, q_depth, SEC_SGL_SGE_NR);
 	if (IS_ERR(qp_ctx->c_in_pool)) {
 		dev_err(dev, "fail to create sgl pool for input!\n");
-		goto err_destroy_idr;
+		goto err_free_res;
 	}
 
-	qp_ctx->c_out_pool = hisi_acc_create_sgl_pool(dev, QM_Q_DEPTH,
-						      SEC_SGL_SGE_NR);
+	qp_ctx->c_out_pool = hisi_acc_create_sgl_pool(dev, q_depth, SEC_SGL_SGE_NR);
 	if (IS_ERR(qp_ctx->c_out_pool)) {
 		dev_err(dev, "fail to create sgl pool for output!\n");
 		goto err_free_c_in_pool;
@@ -509,34 +505,72 @@ static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
 	if (ret)
 		goto err_free_c_out_pool;
 
-	ret = hisi_qm_start_qp(qp, 0);
-	if (ret < 0)
-		goto err_queue_free;
-
 	return 0;
 
-err_queue_free:
-	sec_alg_resource_free(ctx, qp_ctx);
 err_free_c_out_pool:
 	hisi_acc_free_sgl_pool(dev, qp_ctx->c_out_pool);
 err_free_c_in_pool:
 	hisi_acc_free_sgl_pool(dev, qp_ctx->c_in_pool);
-err_destroy_idr:
-	idr_destroy(&qp_ctx->req_idr);
+err_free_res:
+	kfree(qp_ctx->res);
+err_free_req_list:
+	kfree(qp_ctx->req_list);
 	return ret;
 }
 
-static void sec_release_qp_ctx(struct sec_ctx *ctx,
-			       struct sec_qp_ctx *qp_ctx)
+static void sec_free_qp_ctx_resource(struct sec_ctx *ctx, struct sec_qp_ctx *qp_ctx)
 {
 	struct device *dev = ctx->dev;
 
-	hisi_qm_stop_qp(qp_ctx->qp);
 	sec_alg_resource_free(ctx, qp_ctx);
-
 	hisi_acc_free_sgl_pool(dev, qp_ctx->c_out_pool);
 	hisi_acc_free_sgl_pool(dev, qp_ctx->c_in_pool);
+	kfree(qp_ctx->res);
+	kfree(qp_ctx->req_list);
+}
+
+static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
+			     int qp_ctx_id, int alg_type)
+{
+	struct sec_qp_ctx *qp_ctx;
+	struct hisi_qp *qp;
+	int ret;
 
+	qp_ctx = &ctx->qp_ctx[qp_ctx_id];
+	qp = ctx->qps[qp_ctx_id];
+	qp->req_type = 0;
+	qp->qp_ctx = qp_ctx;
+	qp_ctx->qp = qp;
+	qp_ctx->ctx = ctx;
+
+	qp->req_cb = sec_req_cb;
+
+	spin_lock_init(&qp_ctx->req_lock);
+	idr_init(&qp_ctx->req_idr);
+	INIT_LIST_HEAD(&qp_ctx->backlog);
+
+	ret = sec_alloc_qp_ctx_resource(qm, ctx, qp_ctx);
+	if (ret)
+		goto err_destroy_idr;
+
+	ret = hisi_qm_start_qp(qp, 0);
+	if (ret < 0)
+		goto err_resource_free;
+
+	return 0;
+
+err_resource_free:
+	sec_free_qp_ctx_resource(ctx, qp_ctx);
+err_destroy_idr:
+	idr_destroy(&qp_ctx->req_idr);
+	return ret;
+}
+
+static void sec_release_qp_ctx(struct sec_ctx *ctx,
+			       struct sec_qp_ctx *qp_ctx)
+{
+	hisi_qm_stop_qp(qp_ctx->qp);
+	sec_free_qp_ctx_resource(ctx, qp_ctx);
 	idr_destroy(&qp_ctx->req_idr);
 }
 
@@ -559,7 +593,7 @@ static int sec_ctx_base_init(struct sec_ctx *ctx)
 	ctx->pbuf_supported = ctx->sec->iommu_used;
 
 	/* Half of queue depth is taken as fake requests limit in the queue. */
-	ctx->fake_req_limit = QM_Q_DEPTH >> 1;
+	ctx->fake_req_limit = ctx->qps[0]->sq_depth >> 1;
 	ctx->qp_ctx = kcalloc(sec->ctx_q_num, sizeof(struct sec_qp_ctx),
 			      GFP_KERNEL);
 	if (!ctx->qp_ctx) {
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 1ec3b06345fd..ea7f85f72b10 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -27,7 +27,6 @@
 #define SEC_BD_ERR_CHK_EN3		0xffffbfff
 
 #define SEC_SQE_SIZE			128
-#define SEC_SQ_SIZE			(SEC_SQE_SIZE * QM_Q_DEPTH)
 #define SEC_PF_DEF_Q_NUM		256
 #define SEC_PF_DEF_Q_BASE		0
 #define SEC_CTX_Q_NUM_DEF		2
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index a6c914d527eb..a7f6884c3ab3 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -599,12 +599,13 @@ static void hisi_zip_ctx_exit(struct hisi_zip_ctx *hisi_zip_ctx)
 
 static int hisi_zip_create_req_q(struct hisi_zip_ctx *ctx)
 {
+	u16 q_depth = ctx->qp_ctx[0].qp->sq_depth;
 	struct hisi_zip_req_q *req_q;
 	int i, ret;
 
 	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
 		req_q = &ctx->qp_ctx[i].req_q;
-		req_q->size = QM_Q_DEPTH;
+		req_q->size = q_depth;
 
 		req_q->req_bitmap = bitmap_zalloc(req_q->size, GFP_KERNEL);
 		if (!req_q->req_bitmap) {
@@ -650,6 +651,7 @@ static void hisi_zip_release_req_q(struct hisi_zip_ctx *ctx)
 
 static int hisi_zip_create_sgl_pool(struct hisi_zip_ctx *ctx)
 {
+	u16 q_depth = ctx->qp_ctx[0].qp->sq_depth;
 	struct hisi_zip_qp_ctx *tmp;
 	struct device *dev;
 	int i;
@@ -657,7 +659,7 @@ static int hisi_zip_create_sgl_pool(struct hisi_zip_ctx *ctx)
 	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
 		tmp = &ctx->qp_ctx[i];
 		dev = &tmp->qp->qm->pdev->dev;
-		tmp->sgl_pool = hisi_acc_create_sgl_pool(dev, QM_Q_DEPTH << 1,
+		tmp->sgl_pool = hisi_acc_create_sgl_pool(dev, q_depth << 1,
 							 sgl_sge_nr);
 		if (IS_ERR(tmp->sgl_pool)) {
 			if (i == 1)
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 36809bae6334..24d5226e0a0a 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -82,7 +82,6 @@
 #define HZIP_CORE_NUM			(HZIP_COMP_CORE_NUM + \
 					 HZIP_DECOMP_CORE_NUM)
 #define HZIP_SQE_SIZE			128
-#define HZIP_SQ_SIZE			(HZIP_SQE_SIZE * QM_Q_DEPTH)
 #define HZIP_PF_DEF_Q_NUM		64
 #define HZIP_PF_DEF_Q_BASE		0
 
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 851c962ba473..371c0e7ffd27 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -109,7 +109,6 @@
 			 QM_MAILBOX_TIMEOUT | QM_FLR_TIMEOUT)
 #define QM_BASE_CE			QM_ECC_1BIT
 
-#define QM_Q_DEPTH			1024
 #define QM_MIN_QNUM                     2
 #define HISI_ACC_SGL_SGE_NR_MAX		255
 #define QM_SHAPER_CFG			0x100164
@@ -310,6 +309,8 @@ struct hisi_qm {
 	u32 max_qp_num;
 	u32 vfs_num;
 	u32 db_interval;
+	u16 eq_depth;
+	u16 aeq_depth;
 	struct list_head list;
 	struct hisi_qm_list *qm_list;
 
@@ -375,6 +376,8 @@ struct hisi_qp_ops {
 
 struct hisi_qp {
 	u32 qp_id;
+	u16 sq_depth;
+	u16 cq_depth;
 	u8 alg_type;
 	u8 req_type;
 
-- 
2.33.0

