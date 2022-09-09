Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100375B3486
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiIIJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiIIJuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:50:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF2C4CA1C;
        Fri,  9 Sep 2022 02:49:59 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MPB1d5t21zZcmy;
        Fri,  9 Sep 2022 17:45:25 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:48 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:48 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 05/10] crypto: hisilicon/qm - support get device irq information from hardware registers
Date:   Fri, 9 Sep 2022 17:46:59 +0800
Message-ID: <20220909094704.32099-6-qianweili@huawei.com>
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

Support get device irq information from hardware registers
instead of fixed macros.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 294 ++++++++++++++++++++++------------
 1 file changed, 195 insertions(+), 99 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index f62e48ccef2b..e4a506d02d23 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -22,15 +22,11 @@
 #define QM_VF_AEQ_INT_MASK		0x4
 #define QM_VF_EQ_INT_SOURCE		0x8
 #define QM_VF_EQ_INT_MASK		0xc
-#define QM_IRQ_NUM_V1			1
-#define QM_IRQ_NUM_PF_V2		4
-#define QM_IRQ_NUM_VF_V2		2
-#define QM_IRQ_NUM_VF_V3		3
 
-#define QM_EQ_EVENT_IRQ_VECTOR		0
-#define QM_AEQ_EVENT_IRQ_VECTOR		1
-#define QM_CMD_EVENT_IRQ_VECTOR		2
-#define QM_ABNORMAL_EVENT_IRQ_VECTOR	3
+#define QM_IRQ_VECTOR_MASK		GENMASK(15, 0)
+#define QM_IRQ_TYPE_MASK		GENMASK(15, 0)
+#define QM_IRQ_TYPE_SHIFT		16
+#define QM_ABN_IRQ_TYPE_MASK		GENMASK(7, 0)
 
 /* mailbox */
 #define QM_MB_PING_ALL_VFS		0xffff
@@ -336,6 +332,12 @@ enum qm_basic_type {
 	QM_FUNC_MAX_QP_CAP,
 	QM_XEQ_DEPTH_CAP,
 	QM_QP_DEPTH_CAP,
+	QM_EQ_IRQ_TYPE_CAP,
+	QM_AEQ_IRQ_TYPE_CAP,
+	QM_ABN_IRQ_TYPE_CAP,
+	QM_PF2VF_IRQ_TYPE_CAP,
+	QM_PF_IRQ_NUM_CAP,
+	QM_VF_IRQ_NUM_CAP,
 };
 
 static const struct hisi_qm_cap_info qm_cap_info_comm[] = {
@@ -359,6 +361,12 @@ static const struct hisi_qm_cap_info qm_basic_info[] = {
 	{QM_FUNC_MAX_QP_CAP,    0x100158, 11, GENMASK(10, 0), 0x1000,    0x400,     0x400},
 	{QM_XEQ_DEPTH_CAP,      0x3104,   0,  GENMASK(15, 0), 0x800,     0x4000800, 0x4000800},
 	{QM_QP_DEPTH_CAP,       0x3108,   0,  GENMASK(31, 0), 0x4000400, 0x4000400, 0x4000400},
+	{QM_EQ_IRQ_TYPE_CAP,    0x310c,   0,  GENMASK(31, 0), 0x10000,   0x10000,   0x10000},
+	{QM_AEQ_IRQ_TYPE_CAP,   0x3110,   0,  GENMASK(31, 0), 0x0,       0x10001,   0x10001},
+	{QM_ABN_IRQ_TYPE_CAP,   0x3114,   0,  GENMASK(31, 0), 0x0,       0x10003,   0x10003},
+	{QM_PF2VF_IRQ_TYPE_CAP, 0x3118,   0,  GENMASK(31, 0), 0x0,       0x0,       0x10002},
+	{QM_PF_IRQ_NUM_CAP,     0x311c,   16, GENMASK(15, 0), 0x1,       0x4,       0x4},
+	{QM_VF_IRQ_NUM_CAP,     0x311c,   0,  GENMASK(15, 0), 0x1,       0x2,       0x3},
 };
 
 struct qm_cqe {
@@ -453,7 +461,6 @@ struct hisi_qm_hw_ops {
 	int (*get_vft)(struct hisi_qm *qm, u32 *base, u32 *number);
 	void (*qm_db)(struct hisi_qm *qm, u16 qn,
 		      u8 cmd, u16 index, u8 priority);
-	u32 (*get_irq_num)(struct hisi_qm *qm);
 	int (*debug_init)(struct hisi_qm *qm);
 	void (*hw_error_init)(struct hisi_qm *qm);
 	void (*hw_error_uninit)(struct hisi_qm *qm);
@@ -562,6 +569,8 @@ static struct qm_typical_qos_table shaper_cbs_s[] = {
 	{50100, 100000, 19}
 };
 
+static void qm_irqs_unregister(struct hisi_qm *qm);
+
 static bool qm_avail_state(struct hisi_qm *qm, enum qm_state new)
 {
 	enum qm_state curr = atomic_read(&qm->status.flags);
@@ -904,25 +913,12 @@ static void qm_get_xqc_depth(struct hisi_qm *qm, u16 *low_bits,
 	*low_bits = (depth >> QM_XQ_DEPTH_SHIFT) & QM_XQ_DEPTH_MASK;
 }
 
-static u32 qm_get_irq_num_v1(struct hisi_qm *qm)
-{
-	return QM_IRQ_NUM_V1;
-}
-
-static u32 qm_get_irq_num_v2(struct hisi_qm *qm)
-{
-	if (qm->fun_type == QM_HW_PF)
-		return QM_IRQ_NUM_PF_V2;
-	else
-		return QM_IRQ_NUM_VF_V2;
-}
-
-static u32 qm_get_irq_num_v3(struct hisi_qm *qm)
+static u32 qm_get_irq_num(struct hisi_qm *qm)
 {
 	if (qm->fun_type == QM_HW_PF)
-		return QM_IRQ_NUM_PF_V2;
+		return hisi_qm_get_hw_info(qm, qm_basic_info, QM_PF_IRQ_NUM_CAP, qm->cap_ver);
 
-	return QM_IRQ_NUM_VF_V3;
+	return hisi_qm_get_hw_info(qm, qm_basic_info, QM_VF_IRQ_NUM_CAP, qm->cap_ver);
 }
 
 static int qm_pm_get_sync(struct hisi_qm *qm)
@@ -1196,24 +1192,6 @@ static irqreturn_t qm_aeq_irq(int irq, void *data)
 	return IRQ_WAKE_THREAD;
 }
 
-static void qm_irq_unregister(struct hisi_qm *qm)
-{
-	struct pci_dev *pdev = qm->pdev;
-
-	free_irq(pci_irq_vector(pdev, QM_EQ_EVENT_IRQ_VECTOR), qm);
-
-	if (qm->ver > QM_HW_V1) {
-		free_irq(pci_irq_vector(pdev, QM_AEQ_EVENT_IRQ_VECTOR), qm);
-
-		if (qm->fun_type == QM_HW_PF)
-			free_irq(pci_irq_vector(pdev,
-				 QM_ABNORMAL_EVENT_IRQ_VECTOR), qm);
-	}
-
-	if (qm->ver > QM_HW_V2)
-		free_irq(pci_irq_vector(pdev, QM_CMD_EVENT_IRQ_VECTOR), qm);
-}
-
 static void qm_init_qp_status(struct hisi_qp *qp)
 {
 	struct hisi_qp_status *qp_status = &qp->qp_status;
@@ -2799,7 +2777,6 @@ static int qm_set_msi_v3(struct hisi_qm *qm, bool set)
 
 static const struct hisi_qm_hw_ops qm_hw_ops_v1 = {
 	.qm_db = qm_db_v1,
-	.get_irq_num = qm_get_irq_num_v1,
 	.hw_error_init = qm_hw_error_init_v1,
 	.set_msi = qm_set_msi,
 };
@@ -2807,7 +2784,6 @@ static const struct hisi_qm_hw_ops qm_hw_ops_v1 = {
 static const struct hisi_qm_hw_ops qm_hw_ops_v2 = {
 	.get_vft = qm_get_vft_v2,
 	.qm_db = qm_db_v2,
-	.get_irq_num = qm_get_irq_num_v2,
 	.hw_error_init = qm_hw_error_init_v2,
 	.hw_error_uninit = qm_hw_error_uninit_v2,
 	.hw_error_handle = qm_hw_error_handle_v2,
@@ -2817,7 +2793,6 @@ static const struct hisi_qm_hw_ops qm_hw_ops_v2 = {
 static const struct hisi_qm_hw_ops qm_hw_ops_v3 = {
 	.get_vft = qm_get_vft_v2,
 	.qm_db = qm_db_v2,
-	.get_irq_num = qm_get_irq_num_v3,
 	.hw_error_init = qm_hw_error_init_v3,
 	.hw_error_uninit = qm_hw_error_uninit_v3,
 	.hw_error_handle = qm_hw_error_handle_v2,
@@ -3803,7 +3778,7 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 	hisi_qm_set_state(qm, QM_NOT_READY);
 	up_write(&qm->qps_lock);
 
-	qm_irq_unregister(qm);
+	qm_irqs_unregister(qm);
 	hisi_qm_pci_uninit(qm);
 	if (qm->use_sva) {
 		uacce_remove(qm->uacce);
@@ -5658,51 +5633,6 @@ static irqreturn_t qm_abnormal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int qm_irq_register(struct hisi_qm *qm)
-{
-	struct pci_dev *pdev = qm->pdev;
-	int ret;
-
-	ret = request_irq(pci_irq_vector(pdev, QM_EQ_EVENT_IRQ_VECTOR),
-			  qm_irq, 0, qm->dev_name, qm);
-	if (ret)
-		return ret;
-
-	if (qm->ver > QM_HW_V1) {
-		ret = request_threaded_irq(pci_irq_vector(pdev,
-					   QM_AEQ_EVENT_IRQ_VECTOR),
-					   qm_aeq_irq, qm_aeq_thread,
-					   0, qm->dev_name, qm);
-		if (ret)
-			goto err_aeq_irq;
-
-		if (qm->fun_type == QM_HW_PF) {
-			ret = request_irq(pci_irq_vector(pdev,
-					  QM_ABNORMAL_EVENT_IRQ_VECTOR),
-					  qm_abnormal_irq, 0, qm->dev_name, qm);
-			if (ret)
-				goto err_abonormal_irq;
-		}
-	}
-
-	if (qm->ver > QM_HW_V2) {
-		ret = request_irq(pci_irq_vector(pdev, QM_CMD_EVENT_IRQ_VECTOR),
-				qm_mb_cmd_irq, 0, qm->dev_name, qm);
-		if (ret)
-			goto err_mb_cmd_irq;
-	}
-
-	return 0;
-
-err_mb_cmd_irq:
-	if (qm->fun_type == QM_HW_PF)
-		free_irq(pci_irq_vector(pdev, QM_ABNORMAL_EVENT_IRQ_VECTOR), qm);
-err_abonormal_irq:
-	free_irq(pci_irq_vector(pdev, QM_AEQ_EVENT_IRQ_VECTOR), qm);
-err_aeq_irq:
-	free_irq(pci_irq_vector(pdev, QM_EQ_EVENT_IRQ_VECTOR), qm);
-	return ret;
-}
 
 /**
  * hisi_qm_dev_shutdown() - Shutdown device.
@@ -5983,6 +5913,176 @@ void hisi_qm_alg_unregister(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_alg_unregister);
 
+static void qm_unregister_abnormal_irq(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	u32 irq_vector, val;
+
+	if (qm->fun_type == QM_HW_VF)
+		return;
+
+	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_ABN_IRQ_TYPE_CAP, qm->cap_ver);
+	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_ABN_IRQ_TYPE_MASK))
+		return;
+
+	irq_vector = val & QM_IRQ_VECTOR_MASK;
+	free_irq(pci_irq_vector(pdev, irq_vector), qm);
+}
+
+static int qm_register_abnormal_irq(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	u32 irq_vector, val;
+	int ret;
+
+	if (qm->fun_type == QM_HW_VF)
+		return 0;
+
+	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_ABN_IRQ_TYPE_CAP, qm->cap_ver);
+	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_ABN_IRQ_TYPE_MASK))
+		return 0;
+
+	irq_vector = val & QM_IRQ_VECTOR_MASK;
+	ret = request_irq(pci_irq_vector(pdev, irq_vector), qm_abnormal_irq, 0, qm->dev_name, qm);
+	if (ret)
+		dev_err(&qm->pdev->dev, "failed to request abnormal irq, ret = %d", ret);
+
+	return ret;
+}
+
+static void qm_unregister_mb_cmd_irq(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	u32 irq_vector, val;
+
+	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_PF2VF_IRQ_TYPE_CAP, qm->cap_ver);
+	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
+		return;
+
+	irq_vector = val & QM_IRQ_VECTOR_MASK;
+	free_irq(pci_irq_vector(pdev, irq_vector), qm);
+}
+
+static int qm_register_mb_cmd_irq(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	u32 irq_vector, val;
+	int ret;
+
+	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_PF2VF_IRQ_TYPE_CAP, qm->cap_ver);
+	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
+		return 0;
+
+	irq_vector = val & QM_IRQ_VECTOR_MASK;
+	ret = request_irq(pci_irq_vector(pdev, irq_vector), qm_mb_cmd_irq, 0, qm->dev_name, qm);
+	if (ret)
+		dev_err(&pdev->dev, "failed to request function communication irq, ret = %d", ret);
+
+	return ret;
+}
+
+static void qm_unregister_aeq_irq(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	u32 irq_vector, val;
+
+	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_AEQ_IRQ_TYPE_CAP, qm->cap_ver);
+	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
+		return;
+
+	irq_vector = val & QM_IRQ_VECTOR_MASK;
+	free_irq(pci_irq_vector(pdev, irq_vector), qm);
+}
+
+static int qm_register_aeq_irq(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	u32 irq_vector, val;
+	int ret;
+
+	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_AEQ_IRQ_TYPE_CAP, qm->cap_ver);
+	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
+		return 0;
+
+	irq_vector = val & QM_IRQ_VECTOR_MASK;
+	ret = request_threaded_irq(pci_irq_vector(pdev, irq_vector), qm_aeq_irq,
+						   qm_aeq_thread, 0, qm->dev_name, qm);
+	if (ret)
+		dev_err(&pdev->dev, "failed to request eq irq, ret = %d", ret);
+
+	return ret;
+}
+
+static void qm_unregister_eq_irq(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	u32 irq_vector, val;
+
+	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_EQ_IRQ_TYPE_CAP, qm->cap_ver);
+	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
+		return;
+
+	irq_vector = val & QM_IRQ_VECTOR_MASK;
+	free_irq(pci_irq_vector(pdev, irq_vector), qm);
+}
+
+static int qm_register_eq_irq(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	u32 irq_vector, val;
+	int ret;
+
+	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_EQ_IRQ_TYPE_CAP, qm->cap_ver);
+	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
+		return 0;
+
+	irq_vector = val & QM_IRQ_VECTOR_MASK;
+	ret = request_irq(pci_irq_vector(pdev, irq_vector), qm_irq, 0, qm->dev_name, qm);
+	if (ret)
+		dev_err(&pdev->dev, "failed to request eq irq, ret = %d", ret);
+
+	return ret;
+}
+
+static void qm_irqs_unregister(struct hisi_qm *qm)
+{
+	qm_unregister_mb_cmd_irq(qm);
+	qm_unregister_abnormal_irq(qm);
+	qm_unregister_aeq_irq(qm);
+	qm_unregister_eq_irq(qm);
+}
+
+static int qm_irqs_register(struct hisi_qm *qm)
+{
+	int ret;
+
+	ret = qm_register_eq_irq(qm);
+	if (ret)
+		return ret;
+
+	ret = qm_register_aeq_irq(qm);
+	if (ret)
+		goto free_eq_irq;
+
+	ret = qm_register_abnormal_irq(qm);
+	if (ret)
+		goto free_aeq_irq;
+
+	ret = qm_register_mb_cmd_irq(qm);
+	if (ret)
+		goto free_abnormal_irq;
+
+	return 0;
+
+free_abnormal_irq:
+	qm_unregister_abnormal_irq(qm);
+free_aeq_irq:
+	qm_unregister_aeq_irq(qm);
+free_eq_irq:
+	qm_unregister_eq_irq(qm);
+	return ret;
+}
+
 static int qm_get_qp_num(struct hisi_qm *qm)
 {
 	bool is_db_isolation;
@@ -6117,11 +6217,7 @@ static int hisi_qm_pci_init(struct hisi_qm *qm)
 		goto err_get_pci_res;
 	pci_set_master(pdev);
 
-	if (!qm->ops->get_irq_num) {
-		ret = -EOPNOTSUPP;
-		goto err_get_pci_res;
-	}
-	num_vec = qm->ops->get_irq_num(qm);
+	num_vec = qm_get_irq_num(qm);
 	ret = pci_alloc_irq_vectors(pdev, num_vec, num_vec, PCI_IRQ_MSI);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable MSI vectors!\n");
@@ -6294,7 +6390,7 @@ int hisi_qm_init(struct hisi_qm *qm)
 	if (ret)
 		return ret;
 
-	ret = qm_irq_register(qm);
+	ret = qm_irqs_register(qm);
 	if (ret)
 		goto err_pci_init;
 
@@ -6336,7 +6432,7 @@ int hisi_qm_init(struct hisi_qm *qm)
 		qm->uacce = NULL;
 	}
 err_irq_register:
-	qm_irq_unregister(qm);
+	qm_irqs_unregister(qm);
 err_pci_init:
 	hisi_qm_pci_uninit(qm);
 	return ret;
-- 
2.33.0

