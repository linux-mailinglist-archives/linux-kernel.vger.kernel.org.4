Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A16D5B347C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiIIJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiIIJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:49:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E431DF3;
        Fri,  9 Sep 2022 02:49:50 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MPB2V5ymczmV99;
        Fri,  9 Sep 2022 17:46:10 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:47 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:46 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 03/10] crypto: hisilicon/qm - add UACCE_CMD_QM_SET_QP_INFO support
Date:   Fri, 9 Sep 2022 17:46:57 +0800
Message-ID: <20220909094704.32099-4-qianweili@huawei.com>
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

To be compatible with accelerator devices of different
versions, 'UACCE_CMD_QM_SET_QP_INFO' ioctl is added to obtain
queue information in userspace, including queue depth and buffer
description size.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c     | 21 ++++++++++++++++++---
 include/uapi/misc/uacce/hisi_qm.h | 17 ++++++++++++++++-
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index b3216ee627e5..e227a3e50600 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3430,6 +3430,7 @@ static long hisi_qm_uacce_ioctl(struct uacce_queue *q, unsigned int cmd,
 				unsigned long arg)
 {
 	struct hisi_qp *qp = q->priv;
+	struct hisi_qp_info qp_info;
 	struct hisi_qp_ctx qp_ctx;
 
 	if (cmd == UACCE_CMD_QM_SET_QP_CTX) {
@@ -3446,11 +3447,25 @@ static long hisi_qm_uacce_ioctl(struct uacce_queue *q, unsigned int cmd,
 		if (copy_to_user((void __user *)arg, &qp_ctx,
 				 sizeof(struct hisi_qp_ctx)))
 			return -EFAULT;
-	} else {
-		return -EINVAL;
+
+		return 0;
+	} else if (cmd == UACCE_CMD_QM_SET_QP_INFO) {
+		if (copy_from_user(&qp_info, (void __user *)arg,
+				   sizeof(struct hisi_qp_info)))
+			return -EFAULT;
+
+		qp_info.sqe_size = qp->qm->sqe_size;
+		qp_info.sq_depth = qp->sq_depth;
+		qp_info.cq_depth = qp->cq_depth;
+
+		if (copy_to_user((void __user *)arg, &qp_info,
+				  sizeof(struct hisi_qp_info)))
+			return -EFAULT;
+
+		return 0;
 	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static const struct uacce_ops uacce_qm_ops = {
diff --git a/include/uapi/misc/uacce/hisi_qm.h b/include/uapi/misc/uacce/hisi_qm.h
index 1faef5ff87ef..3e66dbc2f323 100644
--- a/include/uapi/misc/uacce/hisi_qm.h
+++ b/include/uapi/misc/uacce/hisi_qm.h
@@ -14,11 +14,26 @@ struct hisi_qp_ctx {
 	__u16 qc_type;
 };
 
+/**
+ * struct hisi_qp_info - User data for hisi qp.
+ * @sqe_size: Submission queue element size
+ * @sq_depth: The number of sqe
+ * @cq_depth: The number of cqe
+ * @reserved: Reserved data
+ */
+struct hisi_qp_info {
+	__u32 sqe_size;
+	__u16 sq_depth;
+	__u16 cq_depth;
+	__u64 reserved;
+};
+
 #define HISI_QM_API_VER_BASE "hisi_qm_v1"
 #define HISI_QM_API_VER2_BASE "hisi_qm_v2"
 #define HISI_QM_API_VER3_BASE "hisi_qm_v3"
 
 /* UACCE_CMD_QM_SET_QP_CTX: Set qp algorithm type */
 #define UACCE_CMD_QM_SET_QP_CTX	_IOWR('H', 10, struct hisi_qp_ctx)
-
+/* UACCE_CMD_QM_SET_QP_INFO: Set qp depth and BD size */
+#define UACCE_CMD_QM_SET_QP_INFO _IOWR('H', 11, struct hisi_qp_info)
 #endif
-- 
2.33.0

