Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA04636088
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbiKWNyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbiKWNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:54:29 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EBDF22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:48:32 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHMrn5c6LzHw3y;
        Wed, 23 Nov 2022 21:47:53 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 21:48:30 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <oohall@gmail.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <aneesh.kumar@linux.ibm.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] libnvdimm/of_pmem: Fix memory leak in of_pmem_region_probe()
Date:   Wed, 23 Nov 2022 21:45:27 +0800
Message-ID: <20221123134527.119441-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After changes in commit 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique
name for bus provider"), @priv->bus_desc.provider_name is no longer a
const string, but a dynamic string allocated by kstrdup(), it should be
freed on the error path, and when driver is removed.

Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/nvdimm/of_pmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 10dbdcdfb9ce..1292ffca7b2e 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -36,6 +36,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 
 	priv->bus = bus = nvdimm_bus_register(&pdev->dev, &priv->bus_desc);
 	if (!bus) {
+		kfree(priv->bus_desc.provider_name);
 		kfree(priv);
 		return -ENODEV;
 	}
@@ -83,6 +84,7 @@ static int of_pmem_region_remove(struct platform_device *pdev)
 	struct of_pmem_private *priv = platform_get_drvdata(pdev);
 
 	nvdimm_bus_unregister(priv->bus);
+	kfree(priv->bus_desc.provider_name);
 	kfree(priv);
 
 	return 0;
-- 
2.17.1

