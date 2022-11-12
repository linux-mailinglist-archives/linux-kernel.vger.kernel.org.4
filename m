Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5344626674
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 03:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiKLCTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 21:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLCTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:19:09 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8847F31362;
        Fri, 11 Nov 2022 18:19:07 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N8K4n6D98z15MWS;
        Sat, 12 Nov 2022 10:18:49 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
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
Subject: [PATCH v3 4/4] crypto: hisilicon/qm - the command dump process is modified
Date:   Sat, 12 Nov 2022 02:12:53 +0000
Message-ID: <20221112021253.34862-5-yekai13@huawei.com>
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

Reduce the function complexity by use the function table in the
process of dumping queue. The function input parameters are
unified. And maintainability is enhanced.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/debugfs.c | 130 ++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 40 deletions(-)

diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index 13bec8b2d723..2cc1591949db 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -36,6 +36,12 @@ struct qm_dfx_item {
 	u32 offset;
 };
 
+struct qm_cmd_dump_item {
+	const char *cmd;
+	char *info_name;
+	int (*dump_fn)(struct hisi_qm *qm, char *cmd, char *info_name);
+};
+
 static struct qm_dfx_item qm_dfx_files[] = {
 	{"err_irq", offsetof(struct qm_dfx, err_irq_cnt)},
 	{"aeq_irq", offsetof(struct qm_dfx, aeq_irq_cnt)},
@@ -128,7 +134,7 @@ static void dump_show(struct hisi_qm *qm, void *info,
 	}
 }
 
-static int qm_sqc_dump(struct hisi_qm *qm, const char *s)
+static int qm_sqc_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	struct device *dev = &qm->pdev->dev;
 	struct qm_sqc *sqc, *sqc_curr;
@@ -162,14 +168,14 @@ static int qm_sqc_dump(struct hisi_qm *qm, const char *s)
 		goto free_ctx;
 	}
 
-	dump_show(qm, sqc, sizeof(*sqc), "SQC");
+	dump_show(qm, sqc, sizeof(*sqc), name);
 
 free_ctx:
 	hisi_qm_ctx_free(qm, sizeof(*sqc), sqc, &sqc_dma);
 	return 0;
 }
 
-static int qm_cqc_dump(struct hisi_qm *qm, const char *s)
+static int qm_cqc_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	struct device *dev = &qm->pdev->dev;
 	struct qm_cqc *cqc, *cqc_curr;
@@ -203,26 +209,35 @@ static int qm_cqc_dump(struct hisi_qm *qm, const char *s)
 		goto free_ctx;
 	}
 
-	dump_show(qm, cqc, sizeof(*cqc), "CQC");
+	dump_show(qm, cqc, sizeof(*cqc), name);
 
 free_ctx:
 	hisi_qm_ctx_free(qm, sizeof(*cqc), cqc, &cqc_dma);
 	return 0;
 }
 
-static int qm_eqc_aeqc_dump(struct hisi_qm *qm, char *s, size_t size,
-			    int cmd, char *name)
+static int qm_eqc_aeqc_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	struct device *dev = &qm->pdev->dev;
 	dma_addr_t xeqc_dma;
+	size_t size;
 	void *xeqc;
 	int ret;
+	u8 cmd;
 
 	if (strsep(&s, " ")) {
 		dev_err(dev, "Please do not input extra characters!\n");
 		return -EINVAL;
 	}
 
+	if (!strcmp(name, "EQC")) {
+		cmd = QM_MB_CMD_EQC;
+		size = sizeof(struct qm_eqc);
+	} else {
+		cmd = QM_MB_CMD_AEQC;
+		size = sizeof(struct qm_aeqc);
+	}
+
 	xeqc = hisi_qm_ctx_alloc(qm, size, &xeqc_dma);
 	if (IS_ERR(xeqc))
 		return PTR_ERR(xeqc);
@@ -278,7 +293,7 @@ static int q_dump_param_parse(struct hisi_qm *qm, char *s,
 	return 0;
 }
 
-static int qm_sq_dump(struct hisi_qm *qm, char *s)
+static int qm_sq_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	u16 sq_depth = qm->qp_array->cq_depth;
 	void *sqe, *sqe_curr;
@@ -300,14 +315,14 @@ static int qm_sq_dump(struct hisi_qm *qm, char *s)
 	memset(sqe_curr + qm->debug.sqe_mask_offset, QM_SQE_ADDR_MASK,
 	       qm->debug.sqe_mask_len);
 
-	dump_show(qm, sqe_curr, qm->sqe_size, "SQE");
+	dump_show(qm, sqe_curr, qm->sqe_size, name);
 
 	kfree(sqe);
 
 	return 0;
 }
 
-static int qm_cq_dump(struct hisi_qm *qm, char *s)
+static int qm_cq_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	struct qm_cqe *cqe_curr;
 	struct hisi_qp *qp;
@@ -320,15 +335,16 @@ static int qm_cq_dump(struct hisi_qm *qm, char *s)
 
 	qp = &qm->qp_array[qp_id];
 	cqe_curr = qp->cqe + cqe_id;
-	dump_show(qm, cqe_curr, sizeof(struct qm_cqe), "CQE");
+	dump_show(qm, cqe_curr, sizeof(struct qm_cqe), name);
 
 	return 0;
 }
 
-static int qm_eq_aeq_dump(struct hisi_qm *qm, const char *s,
-			  size_t size, char *name)
+static int qm_eq_aeq_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	struct device *dev = &qm->pdev->dev;
+	u16 xeq_depth;
+	size_t size;
 	void *xeqe;
 	u32 xeqe_id;
 	int ret;
@@ -340,11 +356,16 @@ static int qm_eq_aeq_dump(struct hisi_qm *qm, const char *s,
 	if (ret)
 		return -EINVAL;
 
-	if (!strcmp(name, "EQE") && xeqe_id >= qm->eq_depth) {
-		dev_err(dev, "Please input eqe num (0-%u)", qm->eq_depth - 1);
-		return -EINVAL;
-	} else if (!strcmp(name, "AEQE") && xeqe_id >= qm->aeq_depth) {
-		dev_err(dev, "Please input aeqe num (0-%u)", qm->eq_depth - 1);
+	if (!strcmp(name, "EQE")) {
+		xeq_depth = qm->eq_depth;
+		size = sizeof(struct qm_eqe);
+	} else {
+		xeq_depth = qm->aeq_depth;
+		size = sizeof(struct qm_aeqe);
+	}
+
+	if (xeqe_id >= xeq_depth) {
+		dev_err(dev, "Please input eqe or aeqe num (0-%u)", xeq_depth - 1);
 		return -EINVAL;
 	}
 
@@ -388,11 +409,47 @@ static int qm_dbg_help(struct hisi_qm *qm, char *s)
 	return 0;
 }
 
+static const struct qm_cmd_dump_item qm_cmd_dump_table[] = {
+	{
+		.cmd = "sqc",
+		.info_name = "SQC",
+		.dump_fn = qm_sqc_dump,
+	}, {
+		.cmd = "cqc",
+		.info_name = "CQC",
+		.dump_fn = qm_cqc_dump,
+	}, {
+		.cmd = "eqc",
+		.info_name = "EQC",
+		.dump_fn = qm_eqc_aeqc_dump,
+	}, {
+		.cmd = "aeqc",
+		.info_name = "AEQC",
+		.dump_fn = qm_eqc_aeqc_dump,
+	}, {
+		.cmd = "sq",
+		.info_name = "SQE",
+		.dump_fn = qm_sq_dump,
+	}, {
+		.cmd = "cq",
+		.info_name = "CQE",
+		.dump_fn = qm_cq_dump,
+	}, {
+		.cmd = "eq",
+		.info_name = "EQE",
+		.dump_fn = qm_eq_aeq_dump,
+	}, {
+		.cmd = "aeq",
+		.info_name = "AEQE",
+		.dump_fn = qm_eq_aeq_dump,
+	},
+};
+
 static int qm_cmd_write_dump(struct hisi_qm *qm, const char *cmd_buf)
 {
 	struct device *dev = &qm->pdev->dev;
 	char *presult, *s, *s_tmp;
-	int ret;
+	int table_size, i, ret;
 
 	s = kstrdup(cmd_buf, GFP_KERNEL);
 	if (!s)
@@ -405,31 +462,24 @@ static int qm_cmd_write_dump(struct hisi_qm *qm, const char *cmd_buf)
 		goto err_buffer_free;
 	}
 
-	if (!strcmp(presult, "sqc"))
-		ret = qm_sqc_dump(qm, s);
-	else if (!strcmp(presult, "cqc"))
-		ret = qm_cqc_dump(qm, s);
-	else if (!strcmp(presult, "eqc"))
-		ret = qm_eqc_aeqc_dump(qm, s, sizeof(struct qm_eqc),
-				       QM_MB_CMD_EQC, "EQC");
-	else if (!strcmp(presult, "aeqc"))
-		ret = qm_eqc_aeqc_dump(qm, s, sizeof(struct qm_aeqc),
-				       QM_MB_CMD_AEQC, "AEQC");
-	else if (!strcmp(presult, "sq"))
-		ret = qm_sq_dump(qm, s);
-	else if (!strcmp(presult, "cq"))
-		ret = qm_cq_dump(qm, s);
-	else if (!strcmp(presult, "eq"))
-		ret = qm_eq_aeq_dump(qm, s, sizeof(struct qm_eqe), "EQE");
-	else if (!strcmp(presult, "aeq"))
-		ret = qm_eq_aeq_dump(qm, s, sizeof(struct qm_aeqe), "AEQE");
-	else if (!strcmp(presult, "help"))
+	if (!strcmp(presult, "help")) {
 		ret = qm_dbg_help(qm, s);
-	else
-		ret = -EINVAL;
+		goto err_buffer_free;
+	}
 
-	if (ret)
+	table_size = ARRAY_SIZE(qm_cmd_dump_table);
+	for (i = 0; i < table_size; i++) {
+		if (!strcmp(presult, qm_cmd_dump_table[i].cmd)) {
+			ret = qm_cmd_dump_table[i].dump_fn(qm, s,
+				qm_cmd_dump_table[i].info_name);
+			break;
+		}
+	}
+
+	if (i == table_size) {
 		dev_info(dev, "Please echo help\n");
+		ret = -EINVAL;
+	}
 
 err_buffer_free:
 	kfree(s_tmp);
-- 
2.17.1

