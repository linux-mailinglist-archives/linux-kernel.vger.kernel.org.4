Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E88E626672
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 03:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiKLCTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 21:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiKLCTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:19:09 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C432FFE7;
        Fri, 11 Nov 2022 18:19:06 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N8K1Y1kM0zJnfv;
        Sat, 12 Nov 2022 10:16:01 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 10:19:05 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 10:19:05 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yekai13@huawei.com>
Subject: [PATCH v3 2/4] crypto: hisilicon/qm - modify the process of regs dfx
Date:   Sat, 12 Nov 2022 02:12:51 +0000
Message-ID: <20221112021253.34862-3-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221112021253.34862-1-yekai13@huawei.com>
References: <20221112021253.34862-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last register logic and different register logic are combined.
Use "u32" instead of 'int' in the regs function input parameter to
simplify some checks.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |   7 +-
 drivers/crypto/hisilicon/qm.c             | 151 ++++++++++++----------
 drivers/crypto/hisilicon/sec2/sec_main.c  |   7 +-
 drivers/crypto/hisilicon/zip/zip_main.c   |   7 +-
 include/linux/hisi_acc_qm.h               |   8 +-
 5 files changed, 99 insertions(+), 81 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 471e5ca720f5..e931304cef5c 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -1101,8 +1101,7 @@ static int hpre_debugfs_init(struct hisi_qm *qm)
 
 	qm->debug.sqe_mask_offset = HPRE_SQE_MASK_OFFSET;
 	qm->debug.sqe_mask_len = HPRE_SQE_MASK_LEN;
-	ret = hisi_qm_diff_regs_init(qm, hpre_diff_regs,
-				ARRAY_SIZE(hpre_diff_regs));
+	ret = hisi_qm_regs_debugfs_init(qm, hpre_diff_regs, ARRAY_SIZE(hpre_diff_regs));
 	if (ret) {
 		dev_warn(dev, "Failed to init HPRE diff regs!\n");
 		goto debugfs_remove;
@@ -1121,7 +1120,7 @@ static int hpre_debugfs_init(struct hisi_qm *qm)
 	return 0;
 
 failed_to_create:
-	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(hpre_diff_regs));
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hpre_diff_regs));
 debugfs_remove:
 	debugfs_remove_recursive(qm->debug.debug_root);
 	return ret;
@@ -1129,7 +1128,7 @@ static int hpre_debugfs_init(struct hisi_qm *qm)
 
 static void hpre_debugfs_exit(struct hisi_qm *qm)
 {
-	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(hpre_diff_regs));
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hpre_diff_regs));
 
 	debugfs_remove_recursive(qm->debug.debug_root);
 }
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 849dc80a7118..441466df7c6d 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1722,8 +1722,21 @@ static int qm_regs_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(qm_regs);
 
+static void dfx_regs_uninit(struct hisi_qm *qm,
+		struct dfx_diff_registers *dregs, int reg_len)
+{
+	int i;
+
+	/* Setting the pointer is NULL to prevent double free */
+	for (i = 0; i < reg_len; i++) {
+		kfree(dregs[i].regs);
+		dregs[i].regs = NULL;
+	}
+	kfree(dregs);
+}
+
 static struct dfx_diff_registers *dfx_regs_init(struct hisi_qm *qm,
-	const struct dfx_diff_registers *cregs, int reg_len)
+	const struct dfx_diff_registers *cregs, u32 reg_len)
 {
 	struct dfx_diff_registers *diff_regs;
 	u32 j, base_offset;
@@ -1762,64 +1775,107 @@ static struct dfx_diff_registers *dfx_regs_init(struct hisi_qm *qm,
 	return ERR_PTR(-ENOMEM);
 }
 
-static void dfx_regs_uninit(struct hisi_qm *qm,
-		struct dfx_diff_registers *dregs, int reg_len)
+static int qm_diff_regs_init(struct hisi_qm *qm,
+		struct dfx_diff_registers *dregs, u32 reg_len)
+{
+	qm->debug.qm_diff_regs = dfx_regs_init(qm, qm_diff_regs, ARRAY_SIZE(qm_diff_regs));
+	if (IS_ERR(qm->debug.qm_diff_regs))
+		return PTR_ERR(qm->debug.qm_diff_regs);
+
+	qm->debug.acc_diff_regs = dfx_regs_init(qm, dregs, reg_len);
+	if (IS_ERR(qm->debug.acc_diff_regs)) {
+		dfx_regs_uninit(qm, qm->debug.qm_diff_regs, ARRAY_SIZE(qm_diff_regs));
+		return PTR_ERR(qm->debug.acc_diff_regs);
+	}
+
+	return 0;
+}
+
+static void qm_last_regs_uninit(struct hisi_qm *qm)
+{
+	struct qm_debug *debug = &qm->debug;
+
+	if (qm->fun_type == QM_HW_VF || !debug->qm_last_words)
+		return;
+
+	kfree(debug->qm_last_words);
+	debug->qm_last_words = NULL;
+}
+
+static int qm_last_regs_init(struct hisi_qm *qm)
 {
+	int dfx_regs_num = ARRAY_SIZE(qm_dfx_regs);
+	struct qm_debug *debug = &qm->debug;
 	int i;
 
-	/* Setting the pointer is NULL to prevent double free */
-	for (i = 0; i < reg_len; i++) {
-		kfree(dregs[i].regs);
-		dregs[i].regs = NULL;
+	if (qm->fun_type == QM_HW_VF)
+		return 0;
+
+	debug->qm_last_words = kcalloc(dfx_regs_num, sizeof(unsigned int), GFP_KERNEL);
+	if (!debug->qm_last_words)
+		return -ENOMEM;
+
+	for (i = 0; i < dfx_regs_num; i++) {
+		debug->qm_last_words[i] = readl_relaxed(qm->io_base +
+			qm_dfx_regs[i].offset);
 	}
-	kfree(dregs);
+
+	return 0;
+}
+
+static void qm_diff_regs_uninit(struct hisi_qm *qm, u32 reg_len)
+{
+	dfx_regs_uninit(qm, qm->debug.acc_diff_regs, reg_len);
+	dfx_regs_uninit(qm, qm->debug.qm_diff_regs, ARRAY_SIZE(qm_diff_regs));
 }
 
 /**
- * hisi_qm_diff_regs_init() - Allocate memory for registers.
+ * hisi_qm_regs_debugfs_init() - Allocate memory for registers.
  * @qm: device qm handle.
  * @dregs: diff registers handle.
  * @reg_len: diff registers region length.
  */
-int hisi_qm_diff_regs_init(struct hisi_qm *qm,
-		struct dfx_diff_registers *dregs, int reg_len)
+int hisi_qm_regs_debugfs_init(struct hisi_qm *qm,
+		struct dfx_diff_registers *dregs, u32 reg_len)
 {
-	if (!qm || !dregs || reg_len <= 0)
+	int ret;
+
+	if (!qm || !dregs)
 		return -EINVAL;
 
 	if (qm->fun_type != QM_HW_PF)
 		return 0;
 
-	qm->debug.qm_diff_regs = dfx_regs_init(qm, qm_diff_regs,
-						ARRAY_SIZE(qm_diff_regs));
-	if (IS_ERR(qm->debug.qm_diff_regs))
-		return PTR_ERR(qm->debug.qm_diff_regs);
+	ret = qm_last_regs_init(qm);
+	if (ret) {
+		dev_info(&qm->pdev->dev, "failed to init qm words memory!\n");
+		return ret;
+	}
 
-	qm->debug.acc_diff_regs = dfx_regs_init(qm, dregs, reg_len);
-	if (IS_ERR(qm->debug.acc_diff_regs)) {
-		dfx_regs_uninit(qm, qm->debug.qm_diff_regs,
-				ARRAY_SIZE(qm_diff_regs));
-		return PTR_ERR(qm->debug.acc_diff_regs);
+	ret = qm_diff_regs_init(qm, dregs, reg_len);
+	if (ret) {
+		qm_last_regs_uninit(qm);
+		return ret;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(hisi_qm_diff_regs_init);
+EXPORT_SYMBOL_GPL(hisi_qm_regs_debugfs_init);
 
 /**
- * hisi_qm_diff_regs_uninit() - Free memory for registers.
+ * hisi_qm_regs_debugfs_uninit() - Free memory for registers.
  * @qm: device qm handle.
  * @reg_len: diff registers region length.
  */
-void hisi_qm_diff_regs_uninit(struct hisi_qm *qm, int reg_len)
+void hisi_qm_regs_debugfs_uninit(struct hisi_qm *qm, u32 reg_len)
 {
-	if (!qm  || reg_len <= 0 || qm->fun_type != QM_HW_PF)
+	if (!qm || qm->fun_type != QM_HW_PF)
 		return;
 
-	dfx_regs_uninit(qm, qm->debug.acc_diff_regs, reg_len);
-	dfx_regs_uninit(qm, qm->debug.qm_diff_regs, ARRAY_SIZE(qm_diff_regs));
+	qm_diff_regs_uninit(qm, reg_len);
+	qm_last_regs_uninit(qm);
 }
-EXPORT_SYMBOL_GPL(hisi_qm_diff_regs_uninit);
+EXPORT_SYMBOL_GPL(hisi_qm_regs_debugfs_uninit);
 
 /**
  * hisi_qm_acc_diff_regs_dump() - Dump registers's value.
@@ -1829,12 +1885,12 @@ EXPORT_SYMBOL_GPL(hisi_qm_diff_regs_uninit);
  * @regs_len: diff registers region length.
  */
 void hisi_qm_acc_diff_regs_dump(struct hisi_qm *qm, struct seq_file *s,
-	struct dfx_diff_registers *dregs, int regs_len)
+	struct dfx_diff_registers *dregs, u32 regs_len)
 {
 	u32 j, val, base_offset;
 	int i, ret;
 
-	if (!qm || !s || !dregs || regs_len <= 0)
+	if (!qm || !s || !dregs)
 		return;
 
 	ret = hisi_qm_get_dfx_access(qm);
@@ -3719,17 +3775,6 @@ static void hisi_qm_set_state(struct hisi_qm *qm, u8 state)
 		writel(state, qm->io_base + QM_VF_STATE);
 }
 
-static void qm_last_regs_uninit(struct hisi_qm *qm)
-{
-	struct qm_debug *debug = &qm->debug;
-
-	if (qm->fun_type == QM_HW_VF || !debug->qm_last_words)
-		return;
-
-	kfree(debug->qm_last_words);
-	debug->qm_last_words = NULL;
-}
-
 static void hisi_qm_unint_work(struct hisi_qm *qm)
 {
 	destroy_workqueue(qm->wq);
@@ -3760,8 +3805,6 @@ static void hisi_qm_memory_uninit(struct hisi_qm *qm)
  */
 void hisi_qm_uninit(struct hisi_qm *qm)
 {
-	qm_last_regs_uninit(qm);
-
 	qm_cmd_uninit(qm);
 	hisi_qm_unint_work(qm);
 	down_write(&qm->qps_lock);
@@ -6339,26 +6382,6 @@ static int hisi_qm_memory_init(struct hisi_qm *qm)
 	return ret;
 }
 
-static void qm_last_regs_init(struct hisi_qm *qm)
-{
-	int dfx_regs_num = ARRAY_SIZE(qm_dfx_regs);
-	struct qm_debug *debug = &qm->debug;
-	int i;
-
-	if (qm->fun_type == QM_HW_VF)
-		return;
-
-	debug->qm_last_words = kcalloc(dfx_regs_num, sizeof(unsigned int),
-								GFP_KERNEL);
-	if (!debug->qm_last_words)
-		return;
-
-	for (i = 0; i < dfx_regs_num; i++) {
-		debug->qm_last_words[i] = readl_relaxed(qm->io_base +
-			qm_dfx_regs[i].offset);
-	}
-}
-
 /**
  * hisi_qm_init() - Initialize configures about qm.
  * @qm: The qm needing init.
@@ -6407,8 +6430,6 @@ int hisi_qm_init(struct hisi_qm *qm)
 	qm_cmd_init(qm);
 	atomic_set(&qm->status.flags, QM_INIT);
 
-	qm_last_regs_init(qm);
-
 	return 0;
 
 err_free_qm_memory:
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 6eb8a16ba0a7..4e24735d95ba 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -899,8 +899,7 @@ static int sec_debugfs_init(struct hisi_qm *qm)
 	qm->debug.sqe_mask_offset = SEC_SQE_MASK_OFFSET;
 	qm->debug.sqe_mask_len = SEC_SQE_MASK_LEN;
 
-	ret = hisi_qm_diff_regs_init(qm, sec_diff_regs,
-				ARRAY_SIZE(sec_diff_regs));
+	ret = hisi_qm_regs_debugfs_init(qm, sec_diff_regs, ARRAY_SIZE(sec_diff_regs));
 	if (ret) {
 		dev_warn(dev, "Failed to init SEC diff regs!\n");
 		goto debugfs_remove;
@@ -915,7 +914,7 @@ static int sec_debugfs_init(struct hisi_qm *qm)
 	return 0;
 
 failed_to_create:
-	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(sec_diff_regs));
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(sec_diff_regs));
 debugfs_remove:
 	debugfs_remove_recursive(sec_debugfs_root);
 	return ret;
@@ -923,7 +922,7 @@ static int sec_debugfs_init(struct hisi_qm *qm)
 
 static void sec_debugfs_exit(struct hisi_qm *qm)
 {
-	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(sec_diff_regs));
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(sec_diff_regs));
 
 	debugfs_remove_recursive(qm->debug.debug_root);
 }
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index c863435e8c75..1549bec3aea5 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -849,8 +849,7 @@ static int hisi_zip_debugfs_init(struct hisi_qm *qm)
 	qm->debug.sqe_mask_offset = HZIP_SQE_MASK_OFFSET;
 	qm->debug.sqe_mask_len = HZIP_SQE_MASK_LEN;
 	qm->debug.debug_root = dev_d;
-	ret = hisi_qm_diff_regs_init(qm, hzip_diff_regs,
-				ARRAY_SIZE(hzip_diff_regs));
+	ret = hisi_qm_regs_debugfs_init(qm, hzip_diff_regs, ARRAY_SIZE(hzip_diff_regs));
 	if (ret) {
 		dev_warn(dev, "Failed to init ZIP diff regs!\n");
 		goto debugfs_remove;
@@ -869,7 +868,7 @@ static int hisi_zip_debugfs_init(struct hisi_qm *qm)
 	return 0;
 
 failed_to_create:
-	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
 debugfs_remove:
 	debugfs_remove_recursive(hzip_debugfs_root);
 	return ret;
@@ -895,7 +894,7 @@ static void hisi_zip_debug_regs_clear(struct hisi_qm *qm)
 
 static void hisi_zip_debugfs_exit(struct hisi_qm *qm)
 {
-	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
 
 	debugfs_remove_recursive(qm->debug.debug_root);
 
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index e230c7c46110..61f012d67f60 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -469,11 +469,11 @@ int hisi_qm_sriov_disable(struct pci_dev *pdev, bool is_frozen);
 int hisi_qm_sriov_configure(struct pci_dev *pdev, int num_vfs);
 void hisi_qm_dev_err_init(struct hisi_qm *qm);
 void hisi_qm_dev_err_uninit(struct hisi_qm *qm);
-int hisi_qm_diff_regs_init(struct hisi_qm *qm,
-		struct dfx_diff_registers *dregs, int reg_len);
-void hisi_qm_diff_regs_uninit(struct hisi_qm *qm, int reg_len);
+int hisi_qm_regs_debugfs_init(struct hisi_qm *qm,
+			  struct dfx_diff_registers *dregs, u32 reg_len);
+void hisi_qm_regs_debugfs_uninit(struct hisi_qm *qm, u32 reg_len);
 void hisi_qm_acc_diff_regs_dump(struct hisi_qm *qm, struct seq_file *s,
-		struct dfx_diff_registers *dregs, int regs_len);
+				struct dfx_diff_registers *dregs, u32 regs_len);
 
 pci_ers_result_t hisi_qm_dev_err_detected(struct pci_dev *pdev,
 					  pci_channel_state_t state);
-- 
2.17.1

