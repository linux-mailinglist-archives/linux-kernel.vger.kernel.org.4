Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AB05B349A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiIIJu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiIIJty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:49:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90BE26AF9;
        Fri,  9 Sep 2022 02:49:49 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MPB1S4Sd3zZcHj;
        Fri,  9 Sep 2022 17:45:16 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:48 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:47 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 04/10] crypto: hisilicon/qm - get error type from hardware registers
Date:   Fri, 9 Sep 2022 17:46:58 +0800
Message-ID: <20220909094704.32099-5-qianweili@huawei.com>
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

Hardware V3 and later versions support get error type from
registers. To be compatible with later hardware versions,
get error type from registers instead of fixed marco.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  68 ++++++++++++---
 drivers/crypto/hisilicon/qm.c             | 101 ++++++++++------------
 drivers/crypto/hisilicon/sec2/sec.h       |  11 +++
 drivers/crypto/hisilicon/sec2/sec_main.c  |  51 ++++++++---
 drivers/crypto/hisilicon/zip/zip_main.c   |  74 ++++++++++++----
 include/linux/hisi_acc_qm.h               |  27 +-----
 6 files changed, 206 insertions(+), 126 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index d484105b2716..36177c437c56 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -53,9 +53,7 @@
 #define HPRE_CORE_IS_SCHD_OFFSET	0x90
 
 #define HPRE_RAS_CE_ENB			0x301410
-#define HPRE_HAC_RAS_CE_ENABLE		(BIT(0) | BIT(22) | BIT(23))
 #define HPRE_RAS_NFE_ENB		0x301414
-#define HPRE_HAC_RAS_NFE_ENABLE		0x3ffffe
 #define HPRE_RAS_FE_ENB			0x301418
 #define HPRE_OOO_SHUTDOWN_SEL		0x301a3c
 #define HPRE_HAC_RAS_FE_ENABLE		0
@@ -147,6 +145,28 @@ static const char * const hpre_debug_file_name[] = {
 	[HPRE_CLUSTER_CTRL] = "cluster_ctrl",
 };
 
+enum hpre_cap_type {
+	HPRE_QM_NFE_MASK_CAP,
+	HPRE_QM_RESET_MASK_CAP,
+	HPRE_QM_OOO_SHUTDOWN_MASK_CAP,
+	HPRE_QM_CE_MASK_CAP,
+	HPRE_NFE_MASK_CAP,
+	HPRE_RESET_MASK_CAP,
+	HPRE_OOO_SHUTDOWN_MASK_CAP,
+	HPRE_CE_MASK_CAP,
+};
+
+static const struct hisi_qm_cap_info hpre_basic_info[] = {
+	{HPRE_QM_NFE_MASK_CAP, 0x3124, 0, GENMASK(31, 0), 0x0, 0x1C37, 0x7C37},
+	{HPRE_QM_RESET_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0xC37, 0x6C37},
+	{HPRE_QM_OOO_SHUTDOWN_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0x4, 0x6C37},
+	{HPRE_QM_CE_MASK_CAP, 0x312C, 0, GENMASK(31, 0), 0x0, 0x8, 0x8},
+	{HPRE_NFE_MASK_CAP, 0x3130, 0, GENMASK(31, 0), 0x0, 0x3FFFFE, 0xFFFFFE},
+	{HPRE_RESET_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x3FFFFE, 0xBFFFFE},
+	{HPRE_OOO_SHUTDOWN_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x22, 0xBFFFFE},
+	{HPRE_CE_MASK_CAP, 0x3138, 0, GENMASK(31, 0), 0x0, 0x1, 0x1},
+};
+
 static const struct hpre_hw_error hpre_hw_errors[] = {
 	{
 		.int_msk = BIT(0),
@@ -630,7 +650,8 @@ static void hpre_master_ooo_ctrl(struct hisi_qm *qm, bool enable)
 	val1 = readl(qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
 	if (enable) {
 		val1 |= HPRE_AM_OOO_SHUTDOWN_ENABLE;
-		val2 = HPRE_HAC_RAS_NFE_ENABLE;
+		val2 = hisi_qm_get_hw_info(qm, hpre_basic_info,
+					   HPRE_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
 	} else {
 		val1 &= ~HPRE_AM_OOO_SHUTDOWN_ENABLE;
 		val2 = 0x0;
@@ -644,21 +665,30 @@ static void hpre_master_ooo_ctrl(struct hisi_qm *qm, bool enable)
 
 static void hpre_hw_error_disable(struct hisi_qm *qm)
 {
-	/* disable hpre hw error interrupts */
-	writel(HPRE_CORE_INT_DISABLE, qm->io_base + HPRE_INT_MASK);
+	u32 ce, nfe;
 
+	ce = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_CE_MASK_CAP, qm->cap_ver);
+	nfe = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_NFE_MASK_CAP, qm->cap_ver);
+
+	/* disable hpre hw error interrupts */
+	writel(ce | nfe | HPRE_HAC_RAS_FE_ENABLE, qm->io_base + HPRE_INT_MASK);
 	/* disable HPRE block master OOO when nfe occurs on Kunpeng930 */
 	hpre_master_ooo_ctrl(qm, false);
 }
 
 static void hpre_hw_error_enable(struct hisi_qm *qm)
 {
+	u32 ce, nfe;
+
+	ce = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_CE_MASK_CAP, qm->cap_ver);
+	nfe = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_NFE_MASK_CAP, qm->cap_ver);
+
 	/* clear HPRE hw error source if having */
-	writel(HPRE_CORE_INT_DISABLE, qm->io_base + HPRE_HAC_SOURCE_INT);
+	writel(ce | nfe | HPRE_HAC_RAS_FE_ENABLE, qm->io_base + HPRE_HAC_SOURCE_INT);
 
 	/* configure error type */
-	writel(HPRE_HAC_RAS_CE_ENABLE, qm->io_base + HPRE_RAS_CE_ENB);
-	writel(HPRE_HAC_RAS_NFE_ENABLE, qm->io_base + HPRE_RAS_NFE_ENB);
+	writel(ce, qm->io_base + HPRE_RAS_CE_ENB);
+	writel(nfe, qm->io_base + HPRE_RAS_NFE_ENB);
 	writel(HPRE_HAC_RAS_FE_ENABLE, qm->io_base + HPRE_RAS_FE_ENB);
 
 	/* enable HPRE block master OOO when nfe occurs on Kunpeng930 */
@@ -1125,7 +1155,11 @@ static u32 hpre_get_hw_err_status(struct hisi_qm *qm)
 
 static void hpre_clear_hw_err_status(struct hisi_qm *qm, u32 err_sts)
 {
+	u32 nfe;
+
 	writel(err_sts, qm->io_base + HPRE_HAC_SOURCE_INT);
+	nfe = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_NFE_MASK_CAP, qm->cap_ver);
+	writel(nfe, qm->io_base + HPRE_RAS_NFE_ENB);
 }
 
 static void hpre_open_axi_master_ooo(struct hisi_qm *qm)
@@ -1143,14 +1177,20 @@ static void hpre_err_info_init(struct hisi_qm *qm)
 {
 	struct hisi_qm_err_info *err_info = &qm->err_info;
 
-	err_info->ce = QM_BASE_CE;
-	err_info->fe = 0;
-	err_info->ecc_2bits_mask = HPRE_CORE_ECC_2BIT_ERR |
-				   HPRE_OOO_ECC_2BIT_ERR;
-	err_info->dev_ce_mask = HPRE_HAC_RAS_CE_ENABLE;
+	err_info->fe = HPRE_HAC_RAS_FE_ENABLE;
+	err_info->ce = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_QM_CE_MASK_CAP, qm->cap_ver);
+	err_info->nfe = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_QM_NFE_MASK_CAP, qm->cap_ver);
+	err_info->ecc_2bits_mask = HPRE_CORE_ECC_2BIT_ERR | HPRE_OOO_ECC_2BIT_ERR;
+	err_info->dev_shutdown_mask = hisi_qm_get_hw_info(qm, hpre_basic_info,
+			HPRE_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
+	err_info->qm_shutdown_mask = hisi_qm_get_hw_info(qm, hpre_basic_info,
+			HPRE_QM_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
+	err_info->qm_reset_mask = hisi_qm_get_hw_info(qm, hpre_basic_info,
+			HPRE_QM_RESET_MASK_CAP, qm->cap_ver);
+	err_info->dev_reset_mask = hisi_qm_get_hw_info(qm, hpre_basic_info,
+			HPRE_RESET_MASK_CAP, qm->cap_ver);
 	err_info->msi_wr_port = HPRE_WR_MSI_PORT;
 	err_info->acpi_rst = "HRST";
-	err_info->nfe = QM_BASE_NFE | QM_ACC_DO_TASK_TIMEOUT;
 }
 
 static const struct hisi_qm_err_ini hpre_err_ini = {
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index e227a3e50600..f62e48ccef2b 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -126,7 +126,6 @@
 #define QM_DFX_CNT_CLR_CE		0x100118
 
 #define QM_ABNORMAL_INT_SOURCE		0x100000
-#define QM_ABNORMAL_INT_SOURCE_CLR	GENMASK(14, 0)
 #define QM_ABNORMAL_INT_MASK		0x100004
 #define QM_ABNORMAL_INT_MASK_VALUE	0x7fff
 #define QM_ABNORMAL_INT_STATUS		0x100008
@@ -144,8 +143,10 @@
 #define QM_RAS_NFE_ENABLE		0x1000f4
 #define QM_RAS_CE_THRESHOLD		0x1000f8
 #define QM_RAS_CE_TIMES_PER_IRQ		1
-#define QM_RAS_MSI_INT_SEL		0x1040f4
 #define QM_OOO_SHUTDOWN_SEL		0x1040f8
+#define QM_ECC_MBIT			BIT(2)
+#define QM_DB_TIMEOUT			BIT(10)
+#define QM_OF_FIFO_OF			BIT(11)
 
 #define QM_RESET_WAIT_TIMEOUT		400
 #define QM_PEH_VENDOR_ID		0x1000d8
@@ -454,7 +455,7 @@ struct hisi_qm_hw_ops {
 		      u8 cmd, u16 index, u8 priority);
 	u32 (*get_irq_num)(struct hisi_qm *qm);
 	int (*debug_init)(struct hisi_qm *qm);
-	void (*hw_error_init)(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe);
+	void (*hw_error_init)(struct hisi_qm *qm);
 	void (*hw_error_uninit)(struct hisi_qm *qm);
 	enum acc_err_result (*hw_error_handle)(struct hisi_qm *qm);
 	int (*set_msi)(struct hisi_qm *qm, bool set);
@@ -651,22 +652,17 @@ static u32 qm_get_dev_err_status(struct hisi_qm *qm)
 }
 
 /* Check if the error causes the master ooo block */
-static int qm_check_dev_error(struct hisi_qm *qm)
+static bool qm_check_dev_error(struct hisi_qm *qm)
 {
 	u32 val, dev_val;
 
 	if (qm->fun_type == QM_HW_VF)
-		return 0;
-
-	val = qm_get_hw_error_status(qm);
-	dev_val = qm_get_dev_err_status(qm);
+		return false;
 
-	if (qm->ver < QM_HW_V3)
-		return (val & QM_ECC_MBIT) ||
-		       (dev_val & qm->err_info.ecc_2bits_mask);
+	val = qm_get_hw_error_status(qm) & qm->err_info.qm_shutdown_mask;
+	dev_val = qm_get_dev_err_status(qm) & qm->err_info.dev_shutdown_mask;
 
-	return (val & readl(qm->io_base + QM_OOO_SHUTDOWN_SEL)) ||
-	       (dev_val & (~qm->err_info.dev_ce_mask));
+	return val || dev_val;
 }
 
 static int qm_wait_reset_finish(struct hisi_qm *qm)
@@ -2346,58 +2342,65 @@ static void qm_create_debugfs_file(struct hisi_qm *qm, struct dentry *dir,
 	file->debug = &qm->debug;
 }
 
-static void qm_hw_error_init_v1(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe)
+static void qm_hw_error_init_v1(struct hisi_qm *qm)
 {
 	writel(QM_ABNORMAL_INT_MASK_VALUE, qm->io_base + QM_ABNORMAL_INT_MASK);
 }
 
-static void qm_hw_error_cfg(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe)
+static void qm_hw_error_cfg(struct hisi_qm *qm)
 {
-	qm->error_mask = ce | nfe | fe;
+	struct hisi_qm_err_info *err_info = &qm->err_info;
+
+	qm->error_mask = err_info->nfe | err_info->ce | err_info->fe;
 	/* clear QM hw residual error source */
-	writel(QM_ABNORMAL_INT_SOURCE_CLR,
-	       qm->io_base + QM_ABNORMAL_INT_SOURCE);
+	writel(qm->error_mask, qm->io_base + QM_ABNORMAL_INT_SOURCE);
 
 	/* configure error type */
-	writel(ce, qm->io_base + QM_RAS_CE_ENABLE);
+	writel(err_info->ce, qm->io_base + QM_RAS_CE_ENABLE);
 	writel(QM_RAS_CE_TIMES_PER_IRQ, qm->io_base + QM_RAS_CE_THRESHOLD);
-	writel(nfe, qm->io_base + QM_RAS_NFE_ENABLE);
-	writel(fe, qm->io_base + QM_RAS_FE_ENABLE);
+	writel(err_info->nfe, qm->io_base + QM_RAS_NFE_ENABLE);
+	writel(err_info->fe, qm->io_base + QM_RAS_FE_ENABLE);
 }
 
-static void qm_hw_error_init_v2(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe)
+static void qm_hw_error_init_v2(struct hisi_qm *qm)
 {
-	u32 irq_enable = ce | nfe | fe;
-	u32 irq_unmask = ~irq_enable;
+	u32 irq_unmask;
 
-	qm_hw_error_cfg(qm, ce, nfe, fe);
+	qm_hw_error_cfg(qm);
 
+	irq_unmask = ~qm->error_mask;
 	irq_unmask &= readl(qm->io_base + QM_ABNORMAL_INT_MASK);
 	writel(irq_unmask, qm->io_base + QM_ABNORMAL_INT_MASK);
 }
 
 static void qm_hw_error_uninit_v2(struct hisi_qm *qm)
 {
-	writel(QM_ABNORMAL_INT_MASK_VALUE, qm->io_base + QM_ABNORMAL_INT_MASK);
+	u32 irq_mask = qm->error_mask;
+
+	irq_mask |= readl(qm->io_base + QM_ABNORMAL_INT_MASK);
+	writel(irq_mask, qm->io_base + QM_ABNORMAL_INT_MASK);
 }
 
-static void qm_hw_error_init_v3(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe)
+static void qm_hw_error_init_v3(struct hisi_qm *qm)
 {
-	u32 irq_enable = ce | nfe | fe;
-	u32 irq_unmask = ~irq_enable;
+	u32 irq_unmask;
 
-	qm_hw_error_cfg(qm, ce, nfe, fe);
+	qm_hw_error_cfg(qm);
 
 	/* enable close master ooo when hardware error happened */
-	writel(nfe & (~QM_DB_RANDOM_INVALID), qm->io_base + QM_OOO_SHUTDOWN_SEL);
+	writel(qm->err_info.qm_shutdown_mask, qm->io_base + QM_OOO_SHUTDOWN_SEL);
 
+	irq_unmask = ~qm->error_mask;
 	irq_unmask &= readl(qm->io_base + QM_ABNORMAL_INT_MASK);
 	writel(irq_unmask, qm->io_base + QM_ABNORMAL_INT_MASK);
 }
 
 static void qm_hw_error_uninit_v3(struct hisi_qm *qm)
 {
-	writel(QM_ABNORMAL_INT_MASK_VALUE, qm->io_base + QM_ABNORMAL_INT_MASK);
+	u32 irq_mask = qm->error_mask;
+
+	irq_mask |= readl(qm->io_base + QM_ABNORMAL_INT_MASK);
+	writel(irq_mask, qm->io_base + QM_ABNORMAL_INT_MASK);
 
 	/* disable close master ooo when hardware error happened */
 	writel(0x0, qm->io_base + QM_OOO_SHUTDOWN_SEL);
@@ -2442,7 +2445,7 @@ static void qm_log_hw_error(struct hisi_qm *qm, u32 error_status)
 
 static enum acc_err_result qm_hw_error_handle_v2(struct hisi_qm *qm)
 {
-	u32 error_status, tmp, val;
+	u32 error_status, tmp;
 
 	/* read err sts */
 	tmp = readl(qm->io_base + QM_ABNORMAL_INT_STATUS);
@@ -2453,17 +2456,11 @@ static enum acc_err_result qm_hw_error_handle_v2(struct hisi_qm *qm)
 			qm->err_status.is_qm_ecc_mbit = true;
 
 		qm_log_hw_error(qm, error_status);
-		val = error_status | QM_DB_RANDOM_INVALID | QM_BASE_CE;
-		/* ce error does not need to be reset */
-		if (val == (QM_DB_RANDOM_INVALID | QM_BASE_CE)) {
-			writel(error_status, qm->io_base +
-			       QM_ABNORMAL_INT_SOURCE);
-			writel(qm->err_info.nfe,
-			       qm->io_base + QM_RAS_NFE_ENABLE);
-			return ACC_ERR_RECOVERED;
-		}
+		if (error_status & qm->err_info.qm_reset_mask)
+			return ACC_ERR_NEED_RESET;
 
-		return ACC_ERR_NEED_RESET;
+		writel(error_status, qm->io_base + QM_ABNORMAL_INT_SOURCE);
+		writel(qm->err_info.nfe, qm->io_base + QM_RAS_NFE_ENABLE);
 	}
 
 	return ACC_ERR_RECOVERED;
@@ -4202,14 +4199,12 @@ DEFINE_DEBUGFS_ATTRIBUTE(qm_atomic64_ops, qm_debugfs_atomic64_get,
 
 static void qm_hw_error_init(struct hisi_qm *qm)
 {
-	struct hisi_qm_err_info *err_info = &qm->err_info;
-
 	if (!qm->ops->hw_error_init) {
 		dev_err(&qm->pdev->dev, "QM doesn't support hw error handling!\n");
 		return;
 	}
 
-	qm->ops->hw_error_init(qm, err_info->ce, err_info->nfe, err_info->fe);
+	qm->ops->hw_error_init(qm);
 }
 
 static void qm_hw_error_uninit(struct hisi_qm *qm)
@@ -4963,17 +4958,11 @@ static enum acc_err_result qm_dev_err_handle(struct hisi_qm *qm)
 		if (qm->err_ini->log_dev_hw_err)
 			qm->err_ini->log_dev_hw_err(qm, err_sts);
 
-		/* ce error does not need to be reset */
-		if ((err_sts | qm->err_info.dev_ce_mask) ==
-		     qm->err_info.dev_ce_mask) {
-			if (qm->err_ini->clear_dev_hw_err_status)
-				qm->err_ini->clear_dev_hw_err_status(qm,
-								err_sts);
-
-			return ACC_ERR_RECOVERED;
-		}
+		if (err_sts & qm->err_info.dev_reset_mask)
+			return ACC_ERR_NEED_RESET;
 
-		return ACC_ERR_NEED_RESET;
+		if (qm->err_ini->clear_dev_hw_err_status)
+			qm->err_ini->clear_dev_hw_err_status(qm, err_sts);
 	}
 
 	return ACC_ERR_RECOVERED;
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 04e034abc5e8..895ba9b47554 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -192,6 +192,17 @@ struct sec_dev {
 	bool iommu_used;
 };
 
+enum sec_cap_type {
+	SEC_QM_NFE_MASK_CAP = 0x0,
+	SEC_QM_RESET_MASK_CAP,
+	SEC_QM_OOO_SHUTDOWN_MASK_CAP,
+	SEC_QM_CE_MASK_CAP,
+	SEC_NFE_MASK_CAP,
+	SEC_RESET_MASK_CAP,
+	SEC_OOO_SHUTDOWN_MASK_CAP,
+	SEC_CE_MASK_CAP,
+};
+
 void sec_destroy_qps(struct hisi_qp **qps, int qp_num);
 struct hisi_qp **sec_create_qps(void);
 int sec_register_to_crypto(struct hisi_qm *qm);
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index ea7f85f72b10..e814f94dd0d4 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -41,16 +41,12 @@
 #define SEC_ECC_NUM			16
 #define SEC_ECC_MASH			0xFF
 #define SEC_CORE_INT_DISABLE		0x0
-#define SEC_CORE_INT_ENABLE		0x7c1ff
-#define SEC_CORE_INT_CLEAR		0x7c1ff
 #define SEC_SAA_ENABLE			0x17f
 
 #define SEC_RAS_CE_REG			0x301050
 #define SEC_RAS_FE_REG			0x301054
 #define SEC_RAS_NFE_REG			0x301058
-#define SEC_RAS_CE_ENB_MSK		0x88
 #define SEC_RAS_FE_ENB_MSK		0x0
-#define SEC_RAS_NFE_ENB_MSK		0x7c177
 #define SEC_OOO_SHUTDOWN_SEL		0x301014
 #define SEC_RAS_DISABLE		0x0
 #define SEC_MEM_START_INIT_REG	0x301100
@@ -136,6 +132,17 @@ static struct hisi_qm_list sec_devices = {
 	.unregister_from_crypto	= sec_unregister_from_crypto,
 };
 
+static const struct hisi_qm_cap_info sec_basic_info[] = {
+	{SEC_QM_NFE_MASK_CAP,   0x3124, 0, GENMASK(31, 0), 0x0, 0x1C77, 0x7C77},
+	{SEC_QM_RESET_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0xC77, 0x6C77},
+	{SEC_QM_OOO_SHUTDOWN_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0x4, 0x6C77},
+	{SEC_QM_CE_MASK_CAP,    0x312C, 0, GENMASK(31, 0), 0x0, 0x8, 0x8},
+	{SEC_NFE_MASK_CAP,      0x3130, 0, GENMASK(31, 0), 0x0, 0x177, 0x60177},
+	{SEC_RESET_MASK_CAP,    0x3134, 0, GENMASK(31, 0), 0x0, 0x177, 0x177},
+	{SEC_OOO_SHUTDOWN_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x4, 0x177},
+	{SEC_CE_MASK_CAP,       0x3138, 0, GENMASK(31, 0), 0x0, 0x88, 0xC088},
+};
+
 static const struct sec_hw_error sec_hw_errors[] = {
 	{
 		.int_msk = BIT(0),
@@ -575,7 +582,8 @@ static void sec_master_ooo_ctrl(struct hisi_qm *qm, bool enable)
 	val1 = readl(qm->io_base + SEC_CONTROL_REG);
 	if (enable) {
 		val1 |= SEC_AXI_SHUTDOWN_ENABLE;
-		val2 = SEC_RAS_NFE_ENB_MSK;
+		val2 = hisi_qm_get_hw_info(qm, sec_basic_info,
+					   SEC_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
 	} else {
 		val1 &= SEC_AXI_SHUTDOWN_DISABLE;
 		val2 = 0x0;
@@ -589,25 +597,30 @@ static void sec_master_ooo_ctrl(struct hisi_qm *qm, bool enable)
 
 static void sec_hw_error_enable(struct hisi_qm *qm)
 {
+	u32 ce, nfe;
+
 	if (qm->ver == QM_HW_V1) {
 		writel(SEC_CORE_INT_DISABLE, qm->io_base + SEC_CORE_INT_MASK);
 		pci_info(qm->pdev, "V1 not support hw error handle\n");
 		return;
 	}
 
+	ce = hisi_qm_get_hw_info(qm, sec_basic_info, SEC_CE_MASK_CAP, qm->cap_ver);
+	nfe = hisi_qm_get_hw_info(qm, sec_basic_info, SEC_NFE_MASK_CAP, qm->cap_ver);
+
 	/* clear SEC hw error source if having */
-	writel(SEC_CORE_INT_CLEAR, qm->io_base + SEC_CORE_INT_SOURCE);
+	writel(ce | nfe | SEC_RAS_FE_ENB_MSK, qm->io_base + SEC_CORE_INT_SOURCE);
 
 	/* enable RAS int */
-	writel(SEC_RAS_CE_ENB_MSK, qm->io_base + SEC_RAS_CE_REG);
+	writel(ce, qm->io_base + SEC_RAS_CE_REG);
 	writel(SEC_RAS_FE_ENB_MSK, qm->io_base + SEC_RAS_FE_REG);
-	writel(SEC_RAS_NFE_ENB_MSK, qm->io_base + SEC_RAS_NFE_REG);
+	writel(nfe, qm->io_base + SEC_RAS_NFE_REG);
 
 	/* enable SEC block master OOO when nfe occurs on Kunpeng930 */
 	sec_master_ooo_ctrl(qm, true);
 
 	/* enable SEC hw error interrupts */
-	writel(SEC_CORE_INT_ENABLE, qm->io_base + SEC_CORE_INT_MASK);
+	writel(ce | nfe | SEC_RAS_FE_ENB_MSK, qm->io_base + SEC_CORE_INT_MASK);
 }
 
 static void sec_hw_error_disable(struct hisi_qm *qm)
@@ -938,7 +951,11 @@ static u32 sec_get_hw_err_status(struct hisi_qm *qm)
 
 static void sec_clear_hw_err_status(struct hisi_qm *qm, u32 err_sts)
 {
+	u32 nfe;
+
 	writel(err_sts, qm->io_base + SEC_CORE_INT_SOURCE);
+	nfe = hisi_qm_get_hw_info(qm, sec_basic_info, SEC_NFE_MASK_CAP, qm->cap_ver);
+	writel(nfe, qm->io_base + SEC_RAS_NFE_REG);
 }
 
 static void sec_open_axi_master_ooo(struct hisi_qm *qm)
@@ -954,14 +971,20 @@ static void sec_err_info_init(struct hisi_qm *qm)
 {
 	struct hisi_qm_err_info *err_info = &qm->err_info;
 
-	err_info->ce = QM_BASE_CE;
-	err_info->fe = 0;
+	err_info->fe = SEC_RAS_FE_ENB_MSK;
+	err_info->ce = hisi_qm_get_hw_info(qm, sec_basic_info, SEC_QM_CE_MASK_CAP, qm->cap_ver);
+	err_info->nfe = hisi_qm_get_hw_info(qm, sec_basic_info, SEC_QM_NFE_MASK_CAP, qm->cap_ver);
 	err_info->ecc_2bits_mask = SEC_CORE_INT_STATUS_M_ECC;
-	err_info->dev_ce_mask = SEC_RAS_CE_ENB_MSK;
+	err_info->qm_shutdown_mask = hisi_qm_get_hw_info(qm, sec_basic_info,
+				     SEC_QM_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
+	err_info->dev_shutdown_mask = hisi_qm_get_hw_info(qm, sec_basic_info,
+			SEC_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
+	err_info->qm_reset_mask = hisi_qm_get_hw_info(qm, sec_basic_info,
+			SEC_QM_RESET_MASK_CAP, qm->cap_ver);
+	err_info->dev_reset_mask = hisi_qm_get_hw_info(qm, sec_basic_info,
+			SEC_RESET_MASK_CAP, qm->cap_ver);
 	err_info->msi_wr_port = BIT(0);
 	err_info->acpi_rst = "SRST";
-	err_info->nfe = QM_BASE_NFE | QM_ACC_DO_TASK_TIMEOUT |
-			QM_ACC_WB_NOT_READY_TIMEOUT;
 }
 
 static const struct hisi_qm_err_ini sec_err_ini = {
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 24d5226e0a0a..6ed10ec05a73 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -69,11 +69,10 @@
 #define HZIP_CORE_INT_STATUS_M_ECC	BIT(1)
 #define HZIP_CORE_SRAM_ECC_ERR_INFO	0x301148
 #define HZIP_CORE_INT_RAS_CE_ENB	0x301160
-#define HZIP_CORE_INT_RAS_CE_ENABLE	0x1
 #define HZIP_CORE_INT_RAS_NFE_ENB	0x301164
 #define HZIP_CORE_INT_RAS_FE_ENB        0x301168
+#define HZIP_CORE_INT_RAS_FE_ENB_MASK	0x0
 #define HZIP_OOO_SHUTDOWN_SEL		0x30120C
-#define HZIP_CORE_INT_RAS_NFE_ENABLE	0x1FFE
 #define HZIP_SRAM_ECC_ERR_NUM_SHIFT	16
 #define HZIP_SRAM_ECC_ERR_ADDR_SHIFT	24
 #define HZIP_CORE_INT_MASK_ALL		GENMASK(12, 0)
@@ -186,6 +185,28 @@ struct hisi_zip_ctrl {
 	struct ctrl_debug_file files[HZIP_DEBUG_FILE_NUM];
 };
 
+enum zip_cap_type {
+	ZIP_QM_NFE_MASK_CAP = 0x0,
+	ZIP_QM_RESET_MASK_CAP,
+	ZIP_QM_OOO_SHUTDOWN_MASK_CAP,
+	ZIP_QM_CE_MASK_CAP,
+	ZIP_NFE_MASK_CAP,
+	ZIP_RESET_MASK_CAP,
+	ZIP_OOO_SHUTDOWN_MASK_CAP,
+	ZIP_CE_MASK_CAP,
+};
+
+static struct hisi_qm_cap_info zip_basic_cap_info[] = {
+	{ZIP_QM_NFE_MASK_CAP, 0x3124, 0, GENMASK(31, 0), 0x0, 0x1C57, 0x7C77},
+	{ZIP_QM_RESET_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0xC57, 0x6C77},
+	{ZIP_QM_OOO_SHUTDOWN_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0x4, 0x6C77},
+	{ZIP_QM_CE_MASK_CAP, 0x312C, 0, GENMASK(31, 0), 0x0, 0x8, 0x8},
+	{ZIP_NFE_MASK_CAP, 0x3130, 0, GENMASK(31, 0), 0x0, 0x7FE, 0x1FFE},
+	{ZIP_RESET_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x7FE, 0x7FE},
+	{ZIP_OOO_SHUTDOWN_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x2, 0x7FE},
+	{ZIP_CE_MASK_CAP, 0x3138, 0, GENMASK(31, 0), 0x0, 0x1, 0x1},
+};
+
 enum {
 	HZIP_COMP_CORE0,
 	HZIP_COMP_CORE1,
@@ -457,7 +478,8 @@ static void hisi_zip_master_ooo_ctrl(struct hisi_qm *qm, bool enable)
 	val1 = readl(qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
 	if (enable) {
 		val1 |= HZIP_AXI_SHUTDOWN_ENABLE;
-		val2 = HZIP_CORE_INT_RAS_NFE_ENABLE;
+		val2 = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
+				ZIP_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
 	} else {
 		val1 &= ~HZIP_AXI_SHUTDOWN_ENABLE;
 		val2 = 0x0;
@@ -471,6 +493,8 @@ static void hisi_zip_master_ooo_ctrl(struct hisi_qm *qm, bool enable)
 
 static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
 {
+	u32 nfe, ce;
+
 	if (qm->ver == QM_HW_V1) {
 		writel(HZIP_CORE_INT_MASK_ALL,
 		       qm->io_base + HZIP_CORE_INT_MASK_REG);
@@ -478,17 +502,17 @@ static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
 		return;
 	}
 
+	nfe = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_NFE_MASK_CAP, qm->cap_ver);
+	ce = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CE_MASK_CAP, qm->cap_ver);
+
 	/* clear ZIP hw error source if having */
-	writel(HZIP_CORE_INT_MASK_ALL, qm->io_base + HZIP_CORE_INT_SOURCE);
+	writel(ce | nfe | HZIP_CORE_INT_RAS_FE_ENB_MASK, qm->io_base + HZIP_CORE_INT_SOURCE);
 
 	/* configure error type */
-	writel(HZIP_CORE_INT_RAS_CE_ENABLE,
-	       qm->io_base + HZIP_CORE_INT_RAS_CE_ENB);
-	writel(0x0, qm->io_base + HZIP_CORE_INT_RAS_FE_ENB);
-	writel(HZIP_CORE_INT_RAS_NFE_ENABLE,
-	       qm->io_base + HZIP_CORE_INT_RAS_NFE_ENB);
+	writel(ce, qm->io_base + HZIP_CORE_INT_RAS_CE_ENB);
+	writel(HZIP_CORE_INT_RAS_FE_ENB_MASK, qm->io_base + HZIP_CORE_INT_RAS_FE_ENB);
+	writel(nfe, qm->io_base + HZIP_CORE_INT_RAS_NFE_ENB);
 
-	/* enable ZIP block master OOO when nfe occurs on Kunpeng930 */
 	hisi_zip_master_ooo_ctrl(qm, true);
 
 	/* enable ZIP hw error interrupts */
@@ -497,10 +521,13 @@ static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
 
 static void hisi_zip_hw_error_disable(struct hisi_qm *qm)
 {
+	u32 nfe, ce;
+
 	/* disable ZIP hw error interrupts */
-	writel(HZIP_CORE_INT_MASK_ALL, qm->io_base + HZIP_CORE_INT_MASK_REG);
+	nfe = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_NFE_MASK_CAP, qm->cap_ver);
+	ce = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CE_MASK_CAP, qm->cap_ver);
+	writel(ce | nfe | HZIP_CORE_INT_RAS_FE_ENB_MASK, qm->io_base + HZIP_CORE_INT_MASK_REG);
 
-	/* disable ZIP block master OOO when nfe occurs on Kunpeng930 */
 	hisi_zip_master_ooo_ctrl(qm, false);
 }
 
@@ -900,7 +927,11 @@ static u32 hisi_zip_get_hw_err_status(struct hisi_qm *qm)
 
 static void hisi_zip_clear_hw_err_status(struct hisi_qm *qm, u32 err_sts)
 {
+	u32 nfe;
+
 	writel(err_sts, qm->io_base + HZIP_CORE_INT_SOURCE);
+	nfe = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_NFE_MASK_CAP, qm->cap_ver);
+	writel(nfe, qm->io_base + HZIP_CORE_INT_RAS_NFE_ENB);
 }
 
 static void hisi_zip_open_axi_master_ooo(struct hisi_qm *qm)
@@ -934,16 +965,21 @@ static void hisi_zip_err_info_init(struct hisi_qm *qm)
 {
 	struct hisi_qm_err_info *err_info = &qm->err_info;
 
-	err_info->ce = QM_BASE_CE;
-	err_info->fe = 0;
+	err_info->fe = HZIP_CORE_INT_RAS_FE_ENB_MASK;
+	err_info->ce = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_QM_CE_MASK_CAP, qm->cap_ver);
+	err_info->nfe = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
+					    ZIP_QM_NFE_MASK_CAP, qm->cap_ver);
 	err_info->ecc_2bits_mask = HZIP_CORE_INT_STATUS_M_ECC;
-	err_info->dev_ce_mask = HZIP_CORE_INT_RAS_CE_ENABLE;
+	err_info->qm_shutdown_mask = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
+							 ZIP_QM_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
+	err_info->dev_shutdown_mask = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
+							  ZIP_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
+	err_info->qm_reset_mask = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
+						      ZIP_QM_RESET_MASK_CAP, qm->cap_ver);
+	err_info->dev_reset_mask = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
+						       ZIP_RESET_MASK_CAP, qm->cap_ver);
 	err_info->msi_wr_port = HZIP_WR_PORT;
 	err_info->acpi_rst = "ZRST";
-	err_info->nfe = QM_BASE_NFE | QM_ACC_WB_NOT_READY_TIMEOUT;
-
-	if (qm->ver >= QM_HW_V3)
-		err_info->nfe |= QM_ACC_DO_TASK_TIMEOUT;
 }
 
 static const struct hisi_qm_err_ini hisi_zip_err_ini = {
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 371c0e7ffd27..e230c7c46110 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -87,28 +87,6 @@
 #define PEH_AXUSER_CFG			0x401001
 #define PEH_AXUSER_CFG_ENABLE		0xffffffff
 
-#define QM_AXI_RRESP			BIT(0)
-#define QM_AXI_BRESP			BIT(1)
-#define QM_ECC_MBIT			BIT(2)
-#define QM_ECC_1BIT			BIT(3)
-#define QM_ACC_GET_TASK_TIMEOUT		BIT(4)
-#define QM_ACC_DO_TASK_TIMEOUT		BIT(5)
-#define QM_ACC_WB_NOT_READY_TIMEOUT	BIT(6)
-#define QM_SQ_CQ_VF_INVALID		BIT(7)
-#define QM_CQ_VF_INVALID		BIT(8)
-#define QM_SQ_VF_INVALID		BIT(9)
-#define QM_DB_TIMEOUT			BIT(10)
-#define QM_OF_FIFO_OF			BIT(11)
-#define QM_DB_RANDOM_INVALID		BIT(12)
-#define QM_MAILBOX_TIMEOUT		BIT(13)
-#define QM_FLR_TIMEOUT			BIT(14)
-
-#define QM_BASE_NFE	(QM_AXI_RRESP | QM_AXI_BRESP | QM_ECC_MBIT | \
-			 QM_ACC_GET_TASK_TIMEOUT | QM_DB_TIMEOUT | \
-			 QM_OF_FIFO_OF | QM_DB_RANDOM_INVALID | \
-			 QM_MAILBOX_TIMEOUT | QM_FLR_TIMEOUT)
-#define QM_BASE_CE			QM_ECC_1BIT
-
 #define QM_MIN_QNUM                     2
 #define HISI_ACC_SGL_SGE_NR_MAX		255
 #define QM_SHAPER_CFG			0x100164
@@ -240,7 +218,10 @@ struct hisi_qm_err_info {
 	char *acpi_rst;
 	u32 msi_wr_port;
 	u32 ecc_2bits_mask;
-	u32 dev_ce_mask;
+	u32 qm_shutdown_mask;
+	u32 dev_shutdown_mask;
+	u32 qm_reset_mask;
+	u32 dev_reset_mask;
 	u32 ce;
 	u32 nfe;
 	u32 fe;
-- 
2.33.0

