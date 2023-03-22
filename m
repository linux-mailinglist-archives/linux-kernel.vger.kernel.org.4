Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A592B6C53F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjCVSoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjCVSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:43:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845702DE50
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A9E6B81DAA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA993C4339E;
        Wed, 22 Mar 2023 18:43:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pf3Qs-000pZ5-2z;
        Wed, 22 Mar 2023 14:43:34 -0400
Message-ID: <20230322184334.744106182@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Mar 2023 14:42:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florent Revest <revest@chromium.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-next][PATCH 06/11] ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
References: <20230322184239.594953818@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florent Revest <revest@chromium.org>

Direct called trampolines can be called in two ways:
- either from the ftrace callsite. In this case, they do not access any
  struct ftrace_regs nor pt_regs
- Or, if a ftrace ops is also attached, from the end of a ftrace
  trampoline. In this case, the call_direct_funcs ops is in charge of
  setting the direct call trampoline's address in a struct ftrace_regs

Since:

commit 9705bc709604 ("ftrace: pass fregs to arch_ftrace_set_direct_caller()")

The later case no longer requires a full pt_regs. It only needs a struct
ftrace_regs so DIRECT_CALLS can work with both WITH_ARGS or WITH_REGS.
With architectures like arm64 already abandoning WITH_REGS in favor of
WITH_ARGS, it's important to have DIRECT_CALLS work WITH_ARGS only.

Link: https://lkml.kernel.org/r/20230321140424.345218-7-revest@chromium.org

Signed-off-by: Florent Revest <revest@chromium.org>
Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 6 ++++++
 kernel/trace/Kconfig   | 2 +-
 kernel/trace/ftrace.c  | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 6a532dd6789e..31f1e1df2af3 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -241,6 +241,12 @@ enum {
 	FTRACE_OPS_FL_DIRECT			= BIT(17),
 };
 
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+#define FTRACE_OPS_FL_SAVE_ARGS                        FTRACE_OPS_FL_SAVE_REGS
+#else
+#define FTRACE_OPS_FL_SAVE_ARGS                        0
+#endif
+
 /*
  * FTRACE_OPS_CMD_* commands allow the ftrace core logic to request changes
  * to a ftrace_ops. Note, the requests may fail.
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a856d4a34c67..5b1e7fa41ca8 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -257,7 +257,7 @@ config DYNAMIC_FTRACE_WITH_REGS
 
 config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	def_bool y
-	depends on DYNAMIC_FTRACE_WITH_REGS
+	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
 	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
 config DYNAMIC_FTRACE_WITH_CALL_OPS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3bef2abc037a..3b46dba3f69b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5288,7 +5288,7 @@ static LIST_HEAD(ftrace_direct_funcs);
 
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
-#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
+#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
 
 static int check_direct_multi(struct ftrace_ops *ops)
 {
-- 
2.39.1
