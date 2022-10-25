Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044360CC60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiJYMsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiJYMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:47:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052E71958FE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:45:26 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxWkW4tPXzVj6j;
        Tue, 25 Oct 2022 20:40:35 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 20:45:21 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 20:45:21 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH v9 3/3] crypto: hisilicon/qm - add the device isolation feature for acc
Date:   Tue, 25 Oct 2022 12:39:31 +0000
Message-ID: <20221025123931.42161-4-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025123931.42161-1-yekai13@huawei.com>
References: <20221025123931.42161-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record every AER error by uacce api. And isolate the device directly
when the controller reset fail. The VF device use the PF device
isolation strategy. Once the PF device is isolated, its VF device will
also be isolated.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 66 ++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 363a02810a16..aa953ce86f70 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3397,6 +3397,29 @@ static void qm_set_sqctype(struct uacce_queue *q, u16 type)
 	up_write(&qm->qps_lock);
 }
 
+static int qm_uacce_isolate_init(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	struct uacce_device *pf_uacce, *uacce;
+	struct device *pf_dev = &(pci_physfn(pdev)->dev);
+
+	uacce = qm->uacce;
+	if (uacce->is_vf) {
+		/* VF uses PF's isoalte data */
+		pf_uacce = dev_to_uacce(pf_dev);
+		if (!pf_uacce) {
+			pci_err(pdev, "fail to PF device!\n");
+			return -ENODEV;
+		}
+
+		uacce->isolate_ctx = &pf_uacce->isolate_data;
+	} else {
+		uacce->isolate_ctx = &uacce->isolate_data;
+	}
+
+	return 0;
+}
+
 static long hisi_qm_uacce_ioctl(struct uacce_queue *q, unsigned int cmd,
 				unsigned long arg)
 {
@@ -3450,6 +3473,14 @@ static const struct uacce_ops uacce_qm_ops = {
 	.is_q_updated = hisi_qm_is_q_updated,
 };
 
+static void qm_remove_uacce(struct hisi_qm *qm)
+{
+	if (qm->use_sva) {
+		uacce_remove(qm->uacce);
+		qm->uacce = NULL;
+	}
+}
+
 static int qm_alloc_uacce(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -3511,7 +3542,14 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 
 	qm->uacce = uacce;
 
+	ret = qm_uacce_isolate_init(qm);
+	if (ret)
+		goto err_rm_uacce;
+
 	return 0;
+err_rm_uacce:
+	qm_remove_uacce(qm);
+	return ret;
 }
 
 /**
@@ -5133,6 +5171,12 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 		return ret;
 	}
 
+	if (qm->use_sva) {
+		ret = uacce_hw_err_isolate(qm->uacce);
+		if (ret)
+			pci_err(pdev, "failed to isolate hw err!\n");
+	}
+
 	ret = qm_wait_vf_prepare_finish(qm);
 	if (ret)
 		pci_err(pdev, "failed to stop by vfs in soft reset!\n");
@@ -5458,21 +5502,25 @@ static int qm_controller_reset(struct hisi_qm *qm)
 		qm->err_ini->show_last_dfx_regs(qm);
 
 	ret = qm_soft_reset(qm);
-	if (ret) {
-		pci_err(pdev, "Controller reset failed (%d)\n", ret);
-		qm_reset_bit_clear(qm);
-		return ret;
-	}
+	if (ret)
+		goto err_reset;
 
 	ret = qm_controller_reset_done(qm);
-	if (ret) {
-		qm_reset_bit_clear(qm);
-		return ret;
-	}
+	if (ret)
+		goto err_reset;
 
 	pci_info(pdev, "Controller reset complete\n");
 
 	return 0;
+err_reset:
+	pci_info(pdev, "Controller reset failed (%d)\n", ret);
+	qm_reset_bit_clear(qm);
+
+	/* if resetting fails, isolate the device */
+	if (qm->use_sva && !qm->uacce->is_vf)
+		qm->uacce->isolate_ctx->is_isolate = true;
+
+	return ret;
 }
 
 /**
-- 
2.17.1

