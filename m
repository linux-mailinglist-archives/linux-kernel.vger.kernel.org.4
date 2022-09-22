Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28865E5FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiIVKf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIVKfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:35:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BCCA9C1B;
        Thu, 22 Sep 2022 03:35:50 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYBRC72N8zWgnD;
        Thu, 22 Sep 2022 18:31:51 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 18:35:49 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <bristot@kernel.org>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <linux-trace-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] rv/monitor: Add __init/__exit annotations to module init/exit funcs
Date:   Thu, 22 Sep 2022 18:32:08 +0800
Message-ID: <20220922103208.162869-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Fixes: 24bce201d798 ("tools/rv: Add dot2k")
Fixes: 8812d21219b9 ("rv/monitor: Add the wip monitor skeleton created by dot2k")
Fixes: ccc319dcb450 ("rv/monitor: Add the wwnr monitor")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
V1 -> V2: add __init/__exit annotations to the monitor templates
---
 kernel/trace/rv/monitors/wip/wip.c                      | 4 ++--
 kernel/trace/rv/monitors/wwnr/wwnr.c                    | 4 ++--
 tools/verification/dot2/dot2k_templates/main_global.c   | 4 ++--
 tools/verification/dot2/dot2k_templates/main_per_cpu.c  | 4 ++--
 tools/verification/dot2/dot2k_templates/main_per_task.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index 83cace53b9fa..6be876e2f405 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -69,13 +69,13 @@ struct rv_monitor rv_wip = {
 	.enabled = 0,
 };
 
-static int register_wip(void)
+static int __init register_wip(void)
 {
 	rv_register_monitor(&rv_wip);
 	return 0;
 }
 
-static void unregister_wip(void)
+static void __exit unregister_wip(void)
 {
 	rv_unregister_monitor(&rv_wip);
 }
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index 599225d9cf38..c1fac4808b02 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -68,13 +68,13 @@ struct rv_monitor rv_wwnr = {
 	.enabled = 0,
 };
 
-static int register_wwnr(void)
+static int __init register_wwnr(void)
 {
 	rv_register_monitor(&rv_wwnr);
 	return 0;
 }
 
-static void unregister_wwnr(void)
+static void __exit unregister_wwnr(void)
 {
 	rv_unregister_monitor(&rv_wwnr);
 }
diff --git a/tools/verification/dot2/dot2k_templates/main_global.c b/tools/verification/dot2/dot2k_templates/main_global.c
index f4b712dbc92e..45fc6709701b 100644
--- a/tools/verification/dot2/dot2k_templates/main_global.c
+++ b/tools/verification/dot2/dot2k_templates/main_global.c
@@ -72,13 +72,13 @@ struct rv_monitor rv_MODEL_NAME = {
 	.enabled = 0,
 };
 
-static int register_MODEL_NAME(void)
+static int __init register_MODEL_NAME(void)
 {
 	rv_register_monitor(&rv_MODEL_NAME);
 	return 0;
 }
 
-static void unregister_MODEL_NAME(void)
+static void __exit unregister_MODEL_NAME(void)
 {
 	rv_unregister_monitor(&rv_MODEL_NAME);
 }
diff --git a/tools/verification/dot2/dot2k_templates/main_per_cpu.c b/tools/verification/dot2/dot2k_templates/main_per_cpu.c
index 4080d1ca3354..9014c9ef657b 100644
--- a/tools/verification/dot2/dot2k_templates/main_per_cpu.c
+++ b/tools/verification/dot2/dot2k_templates/main_per_cpu.c
@@ -72,13 +72,13 @@ struct rv_monitor rv_MODEL_NAME = {
 	.enabled = 0,
 };
 
-static int register_MODEL_NAME(void)
+static int __init register_MODEL_NAME(void)
 {
 	rv_register_monitor(&rv_MODEL_NAME);
 	return 0;
 }
 
-static void unregister_MODEL_NAME(void)
+static void __exit unregister_MODEL_NAME(void)
 {
 	rv_unregister_monitor(&rv_MODEL_NAME);
 }
diff --git a/tools/verification/dot2/dot2k_templates/main_per_task.c b/tools/verification/dot2/dot2k_templates/main_per_task.c
index 89197175384f..13d11620d19f 100644
--- a/tools/verification/dot2/dot2k_templates/main_per_task.c
+++ b/tools/verification/dot2/dot2k_templates/main_per_task.c
@@ -72,13 +72,13 @@ struct rv_monitor rv_MODEL_NAME = {
 	.enabled = 0,
 };
 
-static int register_MODEL_NAME(void)
+static int __init register_MODEL_NAME(void)
 {
 	rv_register_monitor(&rv_MODEL_NAME);
 	return 0;
 }
 
-static void unregister_MODEL_NAME(void)
+static void __exit unregister_MODEL_NAME(void)
 {
 	rv_unregister_monitor(&rv_MODEL_NAME);
 }
-- 
2.17.1

