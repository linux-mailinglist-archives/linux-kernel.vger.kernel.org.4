Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA75BC4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiISIuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiISIto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:49:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD73237C3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:49:17 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWJCd39KkzmVVN;
        Mon, 19 Sep 2022 16:45:17 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 19 Sep
 2022 16:49:09 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH] kprobes: Mark ftrace mcount handler functions nokprobe
Date:   Mon, 19 Sep 2022 16:45:33 +0800
Message-ID: <20220919084533.42318-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,LONGWORDS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark ftrace mcount handler functions nokprobe since probing on these
functions probably reaches mcount recursivly during kprobe breakpoint
handler for some architecture(tested for riscv, arm64), and reenter
kprobe is treated as a fatal error, causes kernel panic.

Pesudo code below demonstrate this problem:

  mcount
    function_trace_call (probed)
      arch_breakpoint_handler
        arch_setup_singlestep [mcount]
          function_trace_call (probed)
            arch_breakpoint_handler
              reenter_kprobe
                BUG

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 kernel/trace/trace_functions.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 9f1bfbe105e8..440a678a8c7c 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -16,6 +16,7 @@
 #include <linux/ftrace.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/kprobes.h>
 
 #include "trace.h"
 
@@ -194,6 +195,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	ftrace_test_recursion_unlock(bit);
 }
+NOKPROBE_SYMBOL(function_trace_call);
 
 #ifdef CONFIG_UNWINDER_ORC
 /*
@@ -245,6 +247,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	atomic_dec(&data->disabled);
 	local_irq_restore(flags);
 }
+NOKPROBE_SYMBOL(function_stack_trace_call);
 
 static inline bool is_repeat_check(struct trace_array *tr,
 				   struct trace_func_repeats *last_info,
@@ -321,6 +324,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 out:
 	ftrace_test_recursion_unlock(bit);
 }
+NOKPROBE_SYMBOL(function_no_repeats_trace_call);
 
 static void
 function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
@@ -363,6 +367,7 @@ function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	atomic_dec(&data->disabled);
 	local_irq_restore(flags);
 }
+NOKPROBE_SYMBOL(function_stack_no_repeats_trace_call);
 
 static struct tracer_opt func_opts[] = {
 #ifdef CONFIG_STACKTRACE
-- 
2.17.1

