Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6535E60DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiIVLXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiIVLXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:23:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E318E05FE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:23:06 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYCSt1Y9zzMpQD;
        Thu, 22 Sep 2022 19:18:22 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:23:04 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <minyard@acm.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipmi: Add __init/__exit annotations to module init/exit funcs
Date:   Thu, 22 Sep 2022 19:19:24 +0800
Message-ID: <20220922111924.36044-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/char/ipmi/ipmi_ssif.c         | 4 ++--
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 4 ++--
 drivers/char/ipmi/kcs_bmc_serio.c     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 13da021e7c6b..e1072809fe31 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -2098,7 +2098,7 @@ static struct platform_driver ipmi_driver = {
 	.id_table       = ssif_plat_ids
 };
 
-static int init_ipmi_ssif(void)
+static int __init init_ipmi_ssif(void)
 {
 	int i;
 	int rv;
@@ -2140,7 +2140,7 @@ static int init_ipmi_ssif(void)
 }
 module_init(init_ipmi_ssif);
 
-static void cleanup_ipmi_ssif(void)
+static void __exit cleanup_ipmi_ssif(void)
 {
 	if (!initialized)
 		return;
diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
index 486834a962c3..cf670e891966 100644
--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
@@ -548,7 +548,7 @@ static struct kcs_bmc_driver kcs_bmc_ipmi_driver = {
 	.ops = &kcs_bmc_ipmi_driver_ops,
 };
 
-static int kcs_bmc_ipmi_init(void)
+static int __init kcs_bmc_ipmi_init(void)
 {
 	kcs_bmc_register_driver(&kcs_bmc_ipmi_driver);
 
@@ -556,7 +556,7 @@ static int kcs_bmc_ipmi_init(void)
 }
 module_init(kcs_bmc_ipmi_init);
 
-static void kcs_bmc_ipmi_exit(void)
+static void __exit kcs_bmc_ipmi_exit(void)
 {
 	kcs_bmc_unregister_driver(&kcs_bmc_ipmi_driver);
 }
diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
index 7e2067628a6c..1793358be782 100644
--- a/drivers/char/ipmi/kcs_bmc_serio.c
+++ b/drivers/char/ipmi/kcs_bmc_serio.c
@@ -140,7 +140,7 @@ static struct kcs_bmc_driver kcs_bmc_serio_driver = {
 	.ops = &kcs_bmc_serio_driver_ops,
 };
 
-static int kcs_bmc_serio_init(void)
+static int __init kcs_bmc_serio_init(void)
 {
 	kcs_bmc_register_driver(&kcs_bmc_serio_driver);
 
@@ -148,7 +148,7 @@ static int kcs_bmc_serio_init(void)
 }
 module_init(kcs_bmc_serio_init);
 
-static void kcs_bmc_serio_exit(void)
+static void __exit kcs_bmc_serio_exit(void)
 {
 	kcs_bmc_unregister_driver(&kcs_bmc_serio_driver);
 }
-- 
2.17.1

