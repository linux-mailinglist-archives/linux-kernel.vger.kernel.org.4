Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCCD5E60AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiIVLOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiIVLOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:14:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDD7DE0D8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:14:16 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYCKM6r99zHqKS;
        Thu, 22 Sep 2022 19:11:51 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:14:02 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <alexander.shishkin@linux.intel.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] stm: Add __init/__exit annotations to module init/exit funcs
Date:   Thu, 22 Sep 2022 19:10:22 +0800
Message-ID: <20220922111022.245236-1-xiujianfeng@huawei.com>
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
 drivers/hwtracing/stm/console.c   | 4 ++--
 drivers/hwtracing/stm/dummy_stm.c | 4 ++--
 drivers/hwtracing/stm/heartbeat.c | 4 ++--
 drivers/hwtracing/stm/p_basic.c   | 4 ++--
 drivers/hwtracing/stm/p_sys-t.c   | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/stm/console.c b/drivers/hwtracing/stm/console.c
index a00f65e21747..c324122321b9 100644
--- a/drivers/hwtracing/stm/console.c
+++ b/drivers/hwtracing/stm/console.c
@@ -54,12 +54,12 @@ static void stm_console_unlink(struct stm_source_data *data)
 	unregister_console(&sc->console);
 }
 
-static int stm_console_init(void)
+static int __init stm_console_init(void)
 {
 	return stm_source_register_device(NULL, &stm_console.data);
 }
 
-static void stm_console_exit(void)
+static void __exit stm_console_exit(void)
 {
 	stm_source_unregister_device(&stm_console.data);
 }
diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
index 38528ffdc0b3..992e545559ea 100644
--- a/drivers/hwtracing/stm/dummy_stm.c
+++ b/drivers/hwtracing/stm/dummy_stm.c
@@ -66,7 +66,7 @@ static int dummy_stm_link(struct stm_data *data, unsigned int master,
 	return 0;
 }
 
-static int dummy_stm_init(void)
+static int __init dummy_stm_init(void)
 {
 	int i, ret = -ENOMEM;
 
@@ -107,7 +107,7 @@ static int dummy_stm_init(void)
 
 }
 
-static void dummy_stm_exit(void)
+static void __exit dummy_stm_exit(void)
 {
 	int i;
 
diff --git a/drivers/hwtracing/stm/heartbeat.c b/drivers/hwtracing/stm/heartbeat.c
index 81d7b21d31ec..e2930ab803b4 100644
--- a/drivers/hwtracing/stm/heartbeat.c
+++ b/drivers/hwtracing/stm/heartbeat.c
@@ -62,7 +62,7 @@ static void stm_heartbeat_unlink(struct stm_source_data *data)
 	hrtimer_cancel(&heartbeat->hrtimer);
 }
 
-static int stm_heartbeat_init(void)
+static int __init stm_heartbeat_init(void)
 {
 	int i, ret;
 
@@ -102,7 +102,7 @@ static int stm_heartbeat_init(void)
 	return ret;
 }
 
-static void stm_heartbeat_exit(void)
+static void __exit stm_heartbeat_exit(void)
 {
 	int i;
 
diff --git a/drivers/hwtracing/stm/p_basic.c b/drivers/hwtracing/stm/p_basic.c
index 8980a6a5fd6c..921ad66574c5 100644
--- a/drivers/hwtracing/stm/p_basic.c
+++ b/drivers/hwtracing/stm/p_basic.c
@@ -30,12 +30,12 @@ static const struct stm_protocol_driver basic_pdrv = {
 	.write	= basic_write,
 };
 
-static int basic_stm_init(void)
+static int __init basic_stm_init(void)
 {
 	return stm_register_protocol(&basic_pdrv);
 }
 
-static void basic_stm_exit(void)
+static void __exit basic_stm_exit(void)
 {
 	stm_unregister_protocol(&basic_pdrv);
 }
diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
index 8254971c02e7..f7d05915695a 100644
--- a/drivers/hwtracing/stm/p_sys-t.c
+++ b/drivers/hwtracing/stm/p_sys-t.c
@@ -366,12 +366,12 @@ static const struct stm_protocol_driver sys_t_pdrv = {
 	.output_close		= sys_t_output_close,
 };
 
-static int sys_t_stm_init(void)
+static int __init sys_t_stm_init(void)
 {
 	return stm_register_protocol(&sys_t_pdrv);
 }
 
-static void sys_t_stm_exit(void)
+static void __exit sys_t_stm_exit(void)
 {
 	stm_unregister_protocol(&sys_t_pdrv);
 }
-- 
2.17.1

