Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F19627AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiKNKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbiKNKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:46:15 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA162C2C;
        Mon, 14 Nov 2022 02:46:13 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N9mDw3s1Wz15Mf2;
        Mon, 14 Nov 2022 18:45:52 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 18:46:11 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 18:46:11 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] tracing: Fix potential null-pointer-access of entry in list 'tr->err_log'
Date:   Mon, 14 Nov 2022 18:46:32 +0800
Message-ID: <20221114104632.3547266-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entries in list 'tr->err_log' will be reused after entry number
exceed TRACING_LOG_ERRS_MAX.

The cmd string of the to be reused entry will be freed first then
allocated a new one. If the allocation failed, then the entry will
still be in list 'tr->err_log' but its 'cmd' field is set to be NULL,
later access of 'cmd' is risky.

Currently above problem can cause the loss of 'cmd' information of first
entry in 'tr->err_log'. When execute `cat /sys/kernel/tracing/error_log`,
reproduce logs like:
  [   37.495100] trace_kprobe: error: Maxactive is not for kprobe(null) ^
  [   38.412517] trace_kprobe: error: Maxactive is not for kprobe
    Command: p4:myprobe2 do_sys_openat2
            ^

Fixes: 1581a884b7ca ("tracing: Remove size restriction on tracing_log_err cmd strings")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/trace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 47a44b055a1d..5ae776598106 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7802,6 +7802,7 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr,
 						   int len)
 {
 	struct tracing_log_err *err;
+	char *cmd;
 
 	if (tr->n_err_log_entries < TRACING_LOG_ERRS_MAX) {
 		err = alloc_tracing_log_err(len);
@@ -7810,12 +7811,12 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr,
 
 		return err;
 	}
-
+	cmd = kzalloc(len, GFP_KERNEL);
+	if (!cmd)
+		return ERR_PTR(-ENOMEM);
 	err = list_first_entry(&tr->err_log, struct tracing_log_err, list);
 	kfree(err->cmd);
-	err->cmd = kzalloc(len, GFP_KERNEL);
-	if (!err->cmd)
-		return ERR_PTR(-ENOMEM);
+	err->cmd = cmd;
 	list_del(&err->list);
 
 	return err;
-- 
2.25.1

