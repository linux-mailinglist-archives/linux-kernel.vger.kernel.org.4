Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0155BB7AE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 12:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIQKKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 06:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 06:09:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AB91208E;
        Sat, 17 Sep 2022 03:09:55 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MV65W1sVGzlVnc;
        Sat, 17 Sep 2022 18:05:51 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 17 Sep 2022 18:09:53 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 17 Sep
 2022 18:09:52 +0800
From:   y00501072 <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yekai13@huawei.com>
Subject: [PATCH] crypto: hisilicon/qm - fix the qos value initialization
Date:   Sat, 17 Sep 2022 10:03:45 +0000
Message-ID: <20220917100345.37296-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Ye <yekai13@huawei.com>

The default qos value is not initialized when sriov is repeatedly enabled
and disabled. So add the vf qos value initialized in the sriov enable
process.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 30fdf0673f00..8b387de69d22 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4801,6 +4801,14 @@ void hisi_qm_debug_regs_clear(struct hisi_qm *qm)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_debug_regs_clear);
 
+static void hisi_qm_init_vf_qos(struct hisi_qm *qm, int total_func)
+{
+	int i;
+
+	for (i = 1; i <= total_func; i++)
+		qm->factor[i].func_qos = QM_QOS_MAX_VAL;
+}
+
 /**
  * hisi_qm_sriov_enable() - enable virtual functions
  * @pdev: the PCIe device
@@ -4834,6 +4842,10 @@ int hisi_qm_sriov_enable(struct pci_dev *pdev, int max_vfs)
 	}
 
 	num_vfs = max_vfs;
+
+	if (test_bit(QM_SUPPORT_FUNC_QOS, &qm->caps))
+		hisi_qm_init_vf_qos(qm, num_vfs);
+
 	ret = qm_vf_q_assign(qm, num_vfs);
 	if (ret) {
 		pci_err(pdev, "Can't assign queues for VF!\n");
@@ -4869,7 +4881,6 @@ EXPORT_SYMBOL_GPL(hisi_qm_sriov_enable);
 int hisi_qm_sriov_disable(struct pci_dev *pdev, bool is_frozen)
 {
 	struct hisi_qm *qm = pci_get_drvdata(pdev);
-	int total_vfs = pci_sriov_get_totalvfs(qm->pdev);
 	int ret;
 
 	if (pci_vfs_assigned(pdev)) {
@@ -4884,9 +4895,6 @@ int hisi_qm_sriov_disable(struct pci_dev *pdev, bool is_frozen)
 	}
 
 	pci_disable_sriov(pdev);
-	/* clear vf function shaper configure array */
-	if (test_bit(QM_SUPPORT_FUNC_QOS, &qm->caps))
-		memset(qm->factor + 1, 0, sizeof(struct qm_shaper_factor) * total_vfs);
 
 	ret = qm_clear_vft_config(qm);
 	if (ret)
@@ -6297,7 +6305,7 @@ static int hisi_qp_alloc_memory(struct hisi_qm *qm)
 static int hisi_qm_memory_init(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
-	int ret, total_func, i;
+	int ret, total_func;
 	size_t off = 0;
 
 	if (test_bit(QM_SUPPORT_FUNC_QOS, &qm->caps)) {
@@ -6306,8 +6314,8 @@ static int hisi_qm_memory_init(struct hisi_qm *qm)
 		if (!qm->factor)
 			return -ENOMEM;
 
-		for (i = 0; i < total_func; i++)
-			qm->factor[i].func_qos = QM_QOS_MAX_VAL;
+		/* Only the PF value needs to be initialized */
+		qm->factor[0].func_qos = QM_QOS_MAX_VAL;
 	}
 
 #define QM_INIT_BUF(qm, type, num) do { \
-- 
2.17.1

