Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99DD637BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiKXOvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKXOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:51:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370131369C4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:50:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B82FB8284D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FDCC433B5;
        Thu, 24 Nov 2022 14:50:48 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDYt-001X7T-0O;
        Thu, 24 Nov 2022 09:50:47 -0500
Message-ID: <20221124145046.999511177@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:50:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Shuai <suagrfillet@gmail.com>
Subject: [for-next][PATCH 11/11] ftrace: Avoid needless updates of the ftrace function call
References: <20221124145019.782980678@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Song Shuai reported:

    The list func (ftrace_ops_list_func) will be patched first
    before the transition between old and new calls are set,
    which fixed the race described in this commit `59338f75`.

    While ftrace_trace_function changes from the list func to a
    ftrace_ops func, like unregistering the klp_ops to leave the only
    global_ops in ftrace_ops_list, the ftrace_[regs]_call will be
    replaced with the list func although it already exists. So there
    should be a condition to avoid this.

And suggested using another variable to keep track of what the ftrace
function is set to. But this could be simplified by using a helper
function that does the same with a static variable.

Link: https://lore.kernel.org/lkml/20221026132039.2236233-1-suagrfillet@gmail.com/
Link: https://lore.kernel.org/linux-trace-kernel/20221122180905.737b6f52@gandalf.local.home

Reported-by: Song Shuai <suagrfillet@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 65a5d36463e0..d04552c0c275 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2763,6 +2763,19 @@ void __weak ftrace_arch_code_modify_post_process(void)
 {
 }
 
+static int update_ftrace_func(ftrace_func_t func)
+{
+	static ftrace_func_t save_func;
+
+	/* Avoid updating if it hasn't changed */
+	if (func == save_func)
+		return 0;
+
+	save_func = func;
+
+	return ftrace_update_ftrace_func(func);
+}
+
 void ftrace_modify_all_code(int command)
 {
 	int update = command & FTRACE_UPDATE_TRACE_FUNC;
@@ -2783,7 +2796,7 @@ void ftrace_modify_all_code(int command)
 	 * traced.
 	 */
 	if (update) {
-		err = ftrace_update_ftrace_func(ftrace_ops_list_func);
+		err = update_ftrace_func(ftrace_ops_list_func);
 		if (FTRACE_WARN_ON(err))
 			return;
 	}
@@ -2799,7 +2812,7 @@ void ftrace_modify_all_code(int command)
 		/* If irqs are disabled, we are in stop machine */
 		if (!irqs_disabled())
 			smp_call_function(ftrace_sync_ipi, NULL, 1);
-		err = ftrace_update_ftrace_func(ftrace_trace_function);
+		err = update_ftrace_func(ftrace_trace_function);
 		if (FTRACE_WARN_ON(err))
 			return;
 	}
-- 
2.35.1


