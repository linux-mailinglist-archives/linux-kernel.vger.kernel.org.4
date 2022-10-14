Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75B45FEBFE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJNJoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJNJnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:43:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAD114DF3F;
        Fri, 14 Oct 2022 02:43:50 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MphDH4vnYz1P7RV;
        Fri, 14 Oct 2022 17:39:11 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 17:43:48 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 17:43:48 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 2/3] crypto: hisilicon/qm - add pci bdf number check
Date:   Fri, 14 Oct 2022 09:38:06 +0000
Message-ID: <20221014093807.3101-3-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221014093807.3101-1-yekai13@huawei.com>
References: <20221014093807.3101-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pci bdf number check is added for qos written by using the pci api.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 37 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 335e58018a31..661cc964e2eb 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4591,49 +4591,36 @@ static ssize_t qm_algqos_read(struct file *filp, char __user *buf,
 	return ret;
 }
 
-static ssize_t qm_qos_value_init(const char *buf, unsigned long *val)
-{
-	int buflen = strlen(buf);
-	int ret, i;
-
-	for (i = 0; i < buflen; i++) {
-		if (!isdigit(buf[i]))
-			return -EINVAL;
-	}
-
-	ret = sscanf(buf, "%lu", val);
-	if (ret != QM_QOS_VAL_NUM)
-		return -EINVAL;
-
-	return 0;
-}
-
 static ssize_t qm_get_qos_value(struct hisi_qm *qm, const char *buf,
 			       unsigned long *val,
 			       unsigned int *fun_index)
 {
+	struct bus_type *bus_type = qm->pdev->dev.bus;
 	char tbuf_bdf[QM_DBG_READ_LEN] = {0};
 	char val_buf[QM_DBG_READ_LEN] = {0};
-	u32 tmp1, device, function;
-	int ret, bus;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret;
 
 	ret = sscanf(buf, "%s %s", tbuf_bdf, val_buf);
 	if (ret != QM_QOS_PARAM_NUM)
 		return -EINVAL;
 
-	ret = qm_qos_value_init(val_buf, val);
+	ret = kstrtoul(val_buf, 10, val);
 	if (ret || *val == 0 || *val > QM_QOS_MAX_VAL) {
 		pci_err(qm->pdev, "input qos value is error, please set 1~1000!\n");
 		return -EINVAL;
 	}
 
-	ret = sscanf(tbuf_bdf, "%u:%x:%u.%u", &tmp1, &bus, &device, &function);
-	if (ret != QM_QOS_BDF_PARAM_NUM) {
-		pci_err(qm->pdev, "input pci bdf value is error!\n");
-		return -EINVAL;
+	dev = bus_find_device_by_name(bus_type, NULL, tbuf_bdf);
+	if (!dev) {
+		pci_err(qm->pdev, "input pci bdf number is error!\n");
+		return -ENODEV;
 	}
 
-	*fun_index = PCI_DEVFN(device, function);
+	pdev = container_of(dev, struct pci_dev, dev);
+
+	*fun_index = pdev->devfn;
 
 	return 0;
 }
-- 
2.33.0

