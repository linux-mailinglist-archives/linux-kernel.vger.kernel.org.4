Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A6D5B7F98
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiINDlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiINDli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:41:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697356F26B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 20:41:31 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MS5d44xVGzcmyV;
        Wed, 14 Sep 2022 11:37:44 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 11:41:29 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 11:41:29 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <joao.m.martins@oracle.com>,
        <akpm@linux-foundation.org>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ACPI: HMAT: Release platform device in case of platform_device_add_data() fails
Date:   Wed, 14 Sep 2022 11:37:55 +0800
Message-ID: <20220914033755.99924-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform device is not released when platform_device_add_data()
fails. And platform_device_put() perfom one more pointer check than
put_device() to check for errors in the 'pdev' pointer.

Use platform_device_put() to release platform device in
platform_device_add()/platform_device_add_data()/
platform_device_add_resources() error case.

Fixes: c01044cc8191 ("ACPI: HMAT: refactor hmat_register_target_device to hmem_register_device")
Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 drivers/dax/hmem/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index cb6401c9e9a4..f87ae005431a 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -47,7 +47,7 @@ void hmem_register_device(int target_nid, struct resource *r)
 	rc = platform_device_add_data(pdev, &info, sizeof(info));
 	if (rc < 0) {
 		pr_err("hmem memregion_info allocation failure for %pr\n", &res);
-		goto out_pdev;
+		goto out_resource;
 	}
 
 	rc = platform_device_add_resources(pdev, &res, 1);
@@ -65,7 +65,7 @@ void hmem_register_device(int target_nid, struct resource *r)
 	return;
 
 out_resource:
-	put_device(&pdev->dev);
+	platform_device_put(pdev);
 out_pdev:
 	memregion_free(id);
 }
-- 
2.17.1

