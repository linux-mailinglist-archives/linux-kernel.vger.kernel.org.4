Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB7A5FDA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJMNMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJMNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:12:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A786914D8D8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:12:47 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mp8vr6jCmzmVBT;
        Thu, 13 Oct 2022 21:08:08 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:12:45 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 21:12:44 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <lvjianmin@loongson.cn>, <chenhuacai@kernel.org>,
        <chenhuacai@loongson.cn>
Subject: [PATCH] platform/loongarch: laptop: fix possible UAF in generic_acpi_laptop_init()
Date:   Thu, 13 Oct 2022 21:12:09 +0800
Message-ID: <20221013131209.775969-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/platform/loongarch/loongson-laptop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index f0166ad5d2c2..a665fd1042ac 100644
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
-- 
2.25.1

