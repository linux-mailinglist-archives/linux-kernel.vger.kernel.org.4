Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DC9689401
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjBCJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjBCJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:38:11 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A77C1DB81;
        Fri,  3 Feb 2023 01:38:09 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4P7Vp75ZMBz12LRD;
        Fri,  3 Feb 2023 17:33:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 3 Feb 2023 17:38:06 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 3/5] crypto: hisilicon/qm - change function names
Date:   Fri, 3 Feb 2023 17:37:28 +0800
Message-ID: <20230203093730.49314-4-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230203093730.49314-1-qianweili@huawei.com>
References: <20230203093730.49314-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accelerator devices support multiple interrupts.
To better reflect purpose of each interrupt function,
change function name 'qm_irq' to 'qm_eq_irq' and 'do_qm_irq'
to 'do_qm_eq_irq'.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index c440d79f2e84..457dd126bc3d 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -905,7 +905,7 @@ static void qm_work_process(struct work_struct *work)
 	}
 }
 
-static bool do_qm_irq(struct hisi_qm *qm)
+static bool do_qm_eq_irq(struct hisi_qm *qm)
 {
 	struct qm_eqe *eqe = qm->eqe + qm->status.eq_head;
 	struct hisi_qm_poll_data *poll_data;
@@ -925,12 +925,12 @@ static bool do_qm_irq(struct hisi_qm *qm)
 	return false;
 }
 
-static irqreturn_t qm_irq(int irq, void *data)
+static irqreturn_t qm_eq_irq(int irq, void *data)
 {
 	struct hisi_qm *qm = data;
 	bool ret;
 
-	ret = do_qm_irq(qm);
+	ret = do_qm_eq_irq(qm);
 	if (ret)
 		return IRQ_HANDLED;
 
@@ -5035,7 +5035,7 @@ static int qm_register_eq_irq(struct hisi_qm *qm)
 		return 0;
 
 	irq_vector = val & QM_IRQ_VECTOR_MASK;
-	ret = request_irq(pci_irq_vector(pdev, irq_vector), qm_irq, 0, qm->dev_name, qm);
+	ret = request_irq(pci_irq_vector(pdev, irq_vector), qm_eq_irq, 0, qm->dev_name, qm);
 	if (ret)
 		dev_err(&pdev->dev, "failed to request eq irq, ret = %d", ret);
 
-- 
2.33.0

