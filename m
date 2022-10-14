Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCC05FE6B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJNBwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJNBwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:52:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFF3189830
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:52:47 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MpTpP3gqPzpVtc;
        Fri, 14 Oct 2022 09:49:33 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 09:52:46 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 09:52:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <lvjianmin@loongson.cn>, <chenhuacai@kernel.org>,
        <chenhuacai@loongson.cn>
Subject: [PATCH] platform/loongarch: laptop: fix possible UAF and simplify return in generic_acpi_laptop_init()
Date:   Fri, 14 Oct 2022 09:52:12 +0800
Message-ID: <20221014015212.1150629-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current the return value of 'sub_driver->init' is not checked,
if sparse_keymap_setup() called in the init function fails,
'generic_inputdev' is freed, then it willl lead a UAF when
using it in generic_acpi_laptop_init(). Fix it by checking
return value. Set generic_inputdev to NULL after free to avoid
double free it.

The error code in generic_subdriver_init() is always negative,
the return of generic_subdriver_init() can be simplified.

Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/platform/loongarch/loongson-laptop.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index f0166ad5d2c2..572290abf151 100644
--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -448,6 +448,7 @@ static int __init event_init(struct generic_sub_driver *sub_driver)
 	if (ret < 0) {
 		pr_err("Failed to setup input device keymap\n");
 		input_free_device(generic_inputdev);
+		generic_inputdev = NULL;
 
 		return ret;
 	}
@@ -502,8 +503,11 @@ static int __init generic_subdriver_init(struct generic_sub_driver *sub_driver)
 	if (ret)
 		return -EINVAL;
 
-	if (sub_driver->init)
-		sub_driver->init(sub_driver);
+	if (sub_driver->init) {
+		ret = sub_driver->init(sub_driver);
+		if (ret)
+			goto err_out;
+	}
 
 	if (sub_driver->notify) {
 		ret = setup_acpi_notify(sub_driver);
@@ -519,7 +523,7 @@ static int __init generic_subdriver_init(struct generic_sub_driver *sub_driver)
 
 err_out:
 	generic_subdriver_exit(sub_driver);
-	return (ret < 0) ? ret : 0;
+	return ret;
 }
 
 static void generic_subdriver_exit(struct generic_sub_driver *sub_driver)
-- 
2.25.1

