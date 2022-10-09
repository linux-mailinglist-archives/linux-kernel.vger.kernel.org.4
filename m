Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E595F892C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 05:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJIDkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 23:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJIDka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 23:40:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249012E9F2
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 20:40:29 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MlSPd4hxjzVhnd;
        Sun,  9 Oct 2022 11:36:05 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
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
Subject: [PATCH -next 1/3] platform/loongarch: laptop: add missing platform_driver_unregister() in generic_subdriver_exit()
Date:   Sun, 9 Oct 2022 11:40:07 +0800
Message-ID: <20221009034009.60026-2-yangyingliang@huawei.com>
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

If setup_acpi_notify() fails in generic_subdriver_init(),
platform_driver_unregister() need be called. Call it in
generic_subdriver_exit().

Fixes: ee7fa5029de8 ("LoongArch: Add ACPI-based generic laptop driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/platform/loongarch/loongson-laptop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index e61fe7c305e0..d9f82c3991c0 100644
--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -535,6 +535,7 @@ static void generic_subdriver_exit(struct generic_sub_driver *sub_driver)
 					   sub_driver->type, dispatch_acpi_notify);
 		sub_driver->acpi_notify_installed = 0;
 	}
+	platform_driver_unregister(sub_driver->driver);
 }
 
 static struct generic_sub_driver generic_sub_drivers[] __refdata = {
-- 
2.25.1

