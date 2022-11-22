Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7069863382F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiKVJSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKVJSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:18:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C05349B72
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:18:08 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NGdqS3tcfzqSPv;
        Tue, 22 Nov 2022 17:14:12 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 17:18:06 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND -next] tracing: Make tracepoint_print_iter static
Date:   Tue, 22 Nov 2022 17:14:56 +0800
Message-ID: <20221122091456.72055-1-xiujianfeng@huawei.com>
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

After change in commit 4239174570da ("tracing: Make tracepoint_printk a
static_key"), this symbol is not used outside of the file, so mark it
static.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/trace/trace.c | 2 +-
 kernel/trace/trace.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 47a44b055a1d..11a7214a2f49 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -85,7 +85,7 @@ void __init disable_tracing_selftest(const char *reason)
 #endif
 
 /* Pipe tracepoints to printk */
-struct trace_iterator *tracepoint_print_iter;
+static struct trace_iterator *tracepoint_print_iter;
 int tracepoint_printk;
 static bool tracepoint_printk_stop_on_boot __initdata;
 static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 54ee5711c729..d9b470a0adf2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1941,8 +1941,6 @@ static inline void tracer_hardirqs_on(unsigned long a0, unsigned long a1) { }
 static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
 #endif
 
-extern struct trace_iterator *tracepoint_print_iter;
-
 /*
  * Reset the state of the trace_iterator so that it can read consumed data.
  * Normally, the trace_iterator is used for reading the data when it is not
-- 
2.17.1

