Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0A56C53F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjCVSn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjCVSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:43:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFB22A162
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5D50B81DAE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02E2C433AC;
        Wed, 22 Mar 2023 18:43:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pf3Qs-000pYX-2K;
        Wed, 22 Mar 2023 14:43:34 -0400
Message-ID: <20230322184334.537784095@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Mar 2023 14:42:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florent Revest <revest@chromium.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-next][PATCH 05/11] ftrace: Store direct called addresses in their ops
References: <20230322184239.594953818@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florent Revest <revest@chromium.org>

All direct calls are now registered using the register_ftrace_direct API
so each ops can jump to only one direct-called trampoline.

By storing the direct called trampoline address directly in the ops we
can save one hashmap lookup in the direct call ops and implement arm64
direct calls on top of call ops.

Link: https://lkml.kernel.org/r/20230321140424.345218-6-revest@chromium.org

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 3 +++
 kernel/trace/ftrace.c  | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index abee60865fc7..6a532dd6789e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -321,6 +321,9 @@ struct ftrace_ops {
 	unsigned long			trampoline_size;
 	struct list_head		list;
 	ftrace_ops_func_t		ops_func;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	unsigned long			direct_call;
+#endif
 #endif
 };
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 845c4012630f..3bef2abc037a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2583,9 +2583,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	unsigned long addr;
+	unsigned long addr = READ_ONCE(ops->direct_call);
 
-	addr = ftrace_find_rec_direct(ip);
 	if (!addr)
 		return;
 
@@ -5381,6 +5380,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->func = call_direct_funcs;
 	ops->flags = MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
+	ops->direct_call = addr;
 
 	err = register_ftrace_function_nolock(ops);
 
@@ -5455,6 +5455,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
+	tmp_ops.direct_call = addr;
 
 	err = register_ftrace_function_nolock(&tmp_ops);
 	if (err)
@@ -5476,6 +5477,8 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 			entry->direct = addr;
 		}
 	}
+	/* Prevent store tearing if a trampoline concurrently accesses the value */
+	WRITE_ONCE(ops->direct_call, addr);
 
 	mutex_unlock(&ftrace_lock);
 
-- 
2.39.1
