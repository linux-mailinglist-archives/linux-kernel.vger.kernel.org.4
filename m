Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BF0630D14
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiKSHyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiKSHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:54:31 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FDA23166;
        Fri, 18 Nov 2022 23:54:29 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NDmBL6wC5z15Mff;
        Sat, 19 Nov 2022 15:54:02 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 15:54:28 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 15:54:28 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        <yekai13@huawei.com>
Subject: [PATCH v10 3/3] crypto: hisilicon/qm - define the device isolation strategy
Date:   Sat, 19 Nov 2022 07:48:17 +0000
Message-ID: <20221119074817.12063-4-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221119074817.12063-1-yekai13@huawei.com>
References: <20221119074817.12063-1-yekai13@huawei.com>
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

Define the device isolation strategy by the device driver. The
user configures a hardware error threshold value by uacce interface.
If the number of hardware errors exceeds the value of setting error
threshold in one hour. The device will not be available in user space.
The VF device use the PF device isolation strategy. All the hardware
errors are processed by PF driver.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 169 +++++++++++++++++++++++++++++++---
 include/linux/hisi_acc_qm.h   |  15 +++
 2 files changed, 169 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 36d70b9f6117..0a0c984a4e7a 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -367,6 +367,16 @@ struct hisi_qm_resource {
 	struct list_head list;
 };
 
+/**
+ * struct qm_hw_err - Structure describing the device errors
+ * @list: hardware error list
+ * @timestamp: timestamp when the error occurred
+ */
+struct qm_hw_err {
+	struct list_head list;
+	unsigned long long timestamp;
+};
+
 struct hisi_qm_hw_ops {
 	int (*get_vft)(struct hisi_qm *qm, u32 *base, u32 *number);
 	void (*qm_db)(struct hisi_qm *qm, u16 qn,
@@ -2469,6 +2479,113 @@ static long hisi_qm_uacce_ioctl(struct uacce_queue *q, unsigned int cmd,
 	return -EINVAL;
 }
 
+/**
+ * qm_hw_err_isolate() - Try to set the isolation status of the uacce device
+ * according to user's configuration of error threshold.
+ * @qm: the uacce device
+ */
+static int qm_hw_err_isolate(struct hisi_qm *qm)
+{
+	struct qm_hw_err *err, *tmp, *hw_err;
+	struct qm_err_isolate *isolate;
+	u32 count = 0;
+
+	isolate = &qm->isolate_data;
+
+#define SECONDS_PER_HOUR	3600
+
+	/* All the hw errs are processed by PF driver */
+	if (qm->uacce->is_vf || isolate->is_isolate || !isolate->err_threshold)
+		return 0;
+
+	hw_err = kzalloc(sizeof(*hw_err), GFP_KERNEL);
+	if (!hw_err)
+		return -ENOMEM;
+
+	/*
+	 * Time-stamp every slot AER error. Then check the AER error log when the
+	 * next device AER error occurred. if the device slot AER error count exceeds
+	 * the setting error threshold in one hour, the isolated state will be set
+	 * to true. And the AER error logs that exceed one hour will be cleared.
+	 */
+	mutex_lock(&isolate->isolate_lock);
+	hw_err->timestamp = jiffies;
+	list_for_each_entry_safe(err, tmp, &isolate->qm_hw_errs, list) {
+		if ((hw_err->timestamp - err->timestamp) / HZ >
+		    SECONDS_PER_HOUR) {
+			list_del(&err->list);
+			kfree(err);
+		} else {
+			count++;
+		}
+	}
+	list_add(&hw_err->list, &isolate->qm_hw_errs);
+	mutex_unlock(&isolate->isolate_lock);
+
+	if (count >= isolate->err_threshold)
+		isolate->is_isolate = true;
+
+	return 0;
+}
+
+static void qm_hw_err_destroy(struct hisi_qm *qm)
+{
+	struct qm_hw_err *err, *tmp;
+
+	mutex_lock(&qm->isolate_data.isolate_lock);
+	list_for_each_entry_safe(err, tmp, &qm->isolate_data.qm_hw_errs, list) {
+		list_del(&err->list);
+		kfree(err);
+	}
+	mutex_unlock(&qm->isolate_data.isolate_lock);
+}
+
+static enum uacce_dev_state hisi_qm_get_isolate_state(struct uacce_device *uacce)
+{
+	struct hisi_qm *qm = uacce->priv;
+	struct hisi_qm *pf_qm;
+
+	if (uacce->is_vf)
+		pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
+	else
+		pf_qm = qm;
+
+	return pf_qm->isolate_data.is_isolate ?
+			UACCE_DEV_ISOLATE : UACCE_DEV_NORMAL;
+}
+
+static int hisi_qm_isolate_threshold_write(struct uacce_device *uacce, u32 num)
+{
+	struct hisi_qm *qm = uacce->priv;
+
+	/* Must be set by PF */
+	if (uacce->is_vf)
+		return -EPERM;
+
+	if (qm->isolate_data.is_isolate)
+		return -EPERM;
+
+	qm->isolate_data.err_threshold = num;
+
+	/* After the policy is updated, need to reset the hardware err list */
+	qm_hw_err_destroy(qm);
+
+	return 0;
+}
+
+static u32 hisi_qm_isolate_threshold_read(struct uacce_device *uacce)
+{
+	struct hisi_qm *qm = uacce->priv;
+	struct hisi_qm *pf_qm;
+
+	if (uacce->is_vf) {
+		pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
+		return pf_qm->isolate_data.err_threshold;
+	}
+
+	return qm->isolate_data.err_threshold;
+}
+
 static const struct uacce_ops uacce_qm_ops = {
 	.get_available_instances = hisi_qm_get_available_instances,
 	.get_queue = hisi_qm_uacce_get_queue,
@@ -2478,8 +2595,22 @@ static const struct uacce_ops uacce_qm_ops = {
 	.mmap = hisi_qm_uacce_mmap,
 	.ioctl = hisi_qm_uacce_ioctl,
 	.is_q_updated = hisi_qm_is_q_updated,
+	.get_isolate_state = hisi_qm_get_isolate_state,
+	.isolate_err_threshold_write = hisi_qm_isolate_threshold_write,
+	.isolate_err_threshold_read = hisi_qm_isolate_threshold_read,
 };
 
+static void qm_remove_uacce(struct hisi_qm *qm)
+{
+	struct uacce_device *uacce = qm->uacce;
+
+	if (qm->use_sva) {
+		qm_hw_err_destroy(qm);
+		uacce_remove(uacce);
+		qm->uacce = NULL;
+	}
+}
+
 static int qm_alloc_uacce(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -2506,8 +2637,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 		qm->use_sva = true;
 	} else {
 		/* only consider sva case */
-		uacce_remove(uacce);
-		qm->uacce = NULL;
+		qm_remove_uacce(qm);
 		return -EINVAL;
 	}
 
@@ -2540,6 +2670,8 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 	uacce->qf_pg_num[UACCE_QFRT_DUS]  = dus_page_nr;
 
 	qm->uacce = uacce;
+	INIT_LIST_HEAD(&qm->isolate_data.qm_hw_errs);
+	mutex_init(&qm->isolate_data.isolate_lock);
 
 	return 0;
 }
@@ -4029,6 +4161,12 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 		return ret;
 	}
 
+	if (qm->use_sva) {
+		ret = qm_hw_err_isolate(qm);
+		if (ret)
+			pci_err(pdev, "failed to isolate hw err!\n");
+	}
+
 	ret = qm_wait_vf_prepare_finish(qm);
 	if (ret)
 		pci_err(pdev, "failed to stop by vfs in soft reset!\n");
@@ -4336,21 +4474,25 @@ static int qm_controller_reset(struct hisi_qm *qm)
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
+
+err_reset:
+	pci_err(pdev, "Controller reset failed (%d)\n", ret);
+	qm_reset_bit_clear(qm);
+
+	/* if resetting fails, isolate the device */
+	if (qm->use_sva)
+		qm->isolate_data.is_isolate = true;
+	return ret;
 }
 
 /**
@@ -5271,10 +5413,7 @@ int hisi_qm_init(struct hisi_qm *qm)
 err_free_qm_memory:
 	hisi_qm_memory_uninit(qm);
 err_alloc_uacce:
-	if (qm->use_sva) {
-		uacce_remove(qm->uacce);
-		qm->uacce = NULL;
-	}
+	qm_remove_uacce(qm);
 err_irq_register:
 	qm_irqs_unregister(qm);
 err_pci_init:
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 61f012d67f60..67f92f696784 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -272,6 +272,20 @@ struct hisi_qm_poll_data {
 	u16 *qp_finish_id;
 };
 
+/**
+ * struct qm_err_isolate
+ * @isolate_lock: protects device error log
+ * @err_threshold: user config error threshold which triggers isolation
+ * @is_isolate: device isolation state
+ * @uacce_hw_errs: index into qm device error list
+ */
+struct qm_err_isolate {
+	struct mutex isolate_lock;
+	u32 err_threshold;
+	bool is_isolate;
+	struct list_head qm_hw_errs;
+};
+
 struct hisi_qm {
 	enum qm_hw_ver ver;
 	enum qm_fun_type fun_type;
@@ -341,6 +355,7 @@ struct hisi_qm {
 	struct qm_shaper_factor *factor;
 	u32 mb_qos;
 	u32 type_rate;
+	struct qm_err_isolate isolate_data;
 };
 
 struct hisi_qp_status {
-- 
2.17.1

