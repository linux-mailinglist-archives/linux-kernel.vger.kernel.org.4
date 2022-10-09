Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BF95F892E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 05:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJIDkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 23:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJIDka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 23:40:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEE22ED47
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 20:40:29 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MlSNz0jrszHtsW;
        Sun,  9 Oct 2022 11:35:31 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 11:40:27 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 9 Oct
 2022 11:40:27 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <chenhuacai@kernel.org>, <lvjianmin@loongson.cn>,
        <chenhuacai@loongson.cn>
Subject: [PATCH -next 2/3] platform/loongarch: laptop: add missing generic_subdriver_exit() in generic_acpi_laptop_init()
Date:   Sun, 9 Oct 2022 11:40:08 +0800
Message-ID: <20221009034009.60026-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009034009.60026-1-yangyingliang@huawei.com>
References: <20221009034009.60026-1-yangyingliang@huawei.com>
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

Add missing generic_subdriver_exit() in generic_acpi_laptop_init()
in error path.

Fixes: ee7fa5029de8 ("LoongArch: Add ACPI-based generic laptop driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/platform/loongarch/loongson-laptop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index d9f82c3991c0..a9fdfac50f35 100644
--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -582,6 +582,8 @@ static int __init generic_acpi_laptop_init(void)
 	for (i = 0; i < ARRAY_SIZE(generic_sub_drivers); i++) {
 		ret = generic_subdriver_init(&generic_sub_drivers[i]);
 		if (ret < 0) {
+			while (--i >= 0)
+				generic_subdriver_exit(&generic_sub_drivers[i]);
 			input_free_device(generic_inputdev);
 			return ret;
 		}
@@ -589,6 +591,8 @@ static int __init generic_acpi_laptop_init(void)
 
 	ret = input_register_device(generic_inputdev);
 	if (ret < 0) {
+		while (--i >= 0)
+			generic_subdriver_exit(&generic_sub_drivers[i]);
 		input_free_device(generic_inputdev);
 		pr_err("Unable to register input device\n");
 		return ret;
-- 
2.25.1

