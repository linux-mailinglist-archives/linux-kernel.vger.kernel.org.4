Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566E6631FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKULMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiKULLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:11:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846CEB7393;
        Mon, 21 Nov 2022 03:07:51 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NG4N03g6BzRpQk;
        Mon, 21 Nov 2022 19:06:56 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:07:23 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <giovanni.cabiddu@intel.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <marco.chiappero@intel.com>
CC:     <tomaszx.kowalik@intel.com>, <qat-linux@intel.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH] crypto: qat - fix error return code in adf_probe
Date:   Mon, 21 Nov 2022 19:27:34 +0800
Message-ID: <1669030054-9605-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code -EINVAL instead of 0.

Fixes: 0cec19c761e5 ("crypto: qat - add support for compression for 4xxx")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 drivers/crypto/qat/qat_4xxx/adf_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
index 2f21256..670a58b2 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
@@ -261,6 +261,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw_data->accel_capabilities_mask = hw_data->get_accel_cap(accel_dev);
 	if (!hw_data->accel_capabilities_mask) {
 		dev_err(&pdev->dev, "Failed to get capabilities mask.\n");
+		ret = -EINVAL;
 		goto out_err;
 	}
 
-- 
1.8.3.1

