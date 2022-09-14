Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3875B816D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiINGPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiINGPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:15:05 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E75017586
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:15:02 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MS91x4vzqz14QRX;
        Wed, 14 Sep 2022 14:11:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 14:14:59 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 14:14:58 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] tracepoint: Optimize the critical region of mutex_lock in tracepoint_module_coming()
Date:   Wed, 14 Sep 2022 14:14:16 +0800
Message-ID: <20220914061416.1630-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory allocation of 'tp_mod' does not require mutex_lock()
protection, move it out.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/tracepoint.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index ef42c1a1192053c..f23144af5743048 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -640,7 +640,6 @@ static void tp_module_going_check_quiescent(struct tracepoint *tp, void *priv)
 static int tracepoint_module_coming(struct module *mod)
 {
 	struct tp_module *tp_mod;
-	int ret = 0;
 
 	if (!mod->num_tracepoints)
 		return 0;
@@ -652,19 +651,18 @@ static int tracepoint_module_coming(struct module *mod)
 	 */
 	if (trace_module_has_bad_taint(mod))
 		return 0;
-	mutex_lock(&tracepoint_module_list_mutex);
+
 	tp_mod = kmalloc(sizeof(struct tp_module), GFP_KERNEL);
-	if (!tp_mod) {
-		ret = -ENOMEM;
-		goto end;
-	}
+	if (!tp_mod)
+		return -ENOMEM;
 	tp_mod->mod = mod;
+
+	mutex_lock(&tracepoint_module_list_mutex);
 	list_add_tail(&tp_mod->list, &tracepoint_module_list);
 	blocking_notifier_call_chain(&tracepoint_notify_list,
 			MODULE_STATE_COMING, tp_mod);
-end:
 	mutex_unlock(&tracepoint_module_list_mutex);
-	return ret;
+	return 0;
 }
 
 static void tracepoint_module_going(struct module *mod)
-- 
2.25.1

