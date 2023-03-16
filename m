Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062076BD73F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCPRiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCPRim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:38:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01021B2F0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay8so1825060wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678988318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g31w0jns46SiUigtcWxrUaCJsT0rxK7Gtz3lyL2N27Y=;
        b=Rdz0P0DpnEnTeFQiAuFZVppD0b30ckuyrKJyZU2K/9cfhB0dor3UYOLdupm9loaFol
         0UN3FTvX061/5y5GWghC4yUDJlnesBoo4+0mvHdG3JD6K7c++tuoQg6KulJK+wtj+WUr
         vlKBek2MHOCZ0hRjtkBujMzoqtctc/lEmLLoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g31w0jns46SiUigtcWxrUaCJsT0rxK7Gtz3lyL2N27Y=;
        b=XcNa3WvdnraVDZ3zUBkZ++rrEQ13gbb22S4NbYhQ1M/CFZBD88og8jGg0jOrlfQNPO
         S011r15KA2AdgzjazmoaUIHFuJm7AXUPkieTEsL0bOI9Mq+VPLtw1BT/P2GelMyzm3eb
         hV8j9kkgS8F5ANwwJsxBAcmXaacD3m0xTQ+DAYOg6IugRYDVT0F+kKSCa/TVAgdc4zhK
         e5Ezy7aYeFZT/09dQBk79nruVOD8cvEwMwUHSenwd9CW/dnhdix07Jr5gN4DwCmMtwZa
         YroiPWZsmYhAonQDDvwAtUt5ehvICtXWOHMxCoqfA2FU/1/VMq8tww3VYkhI1gauXw4a
         8pbA==
X-Gm-Message-State: AO0yUKUOE7XK413FCm90sVEXwf0dcSKrxals0hsAMs3Cb7JpenG6BrDI
        XxC4NEPZz9rgY3DHhw1jjDlqFjSMjo0w/K0e8DY=
X-Google-Smtp-Source: AK7set/RoxlGgg55XZf1Mu6j3RPKd3r9JCB7d4v6Bj9ZSqPkcqVZ1soNwVlwJgk42QZ1enWHk3FPqg==
X-Received: by 2002:a1c:7c01:0:b0:3e5:4fb9:ea60 with SMTP id x1-20020a1c7c01000000b003e54fb9ea60mr170569wmc.9.1678988318182;
        Thu, 16 Mar 2023 10:38:38 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:24ff:9ff7:736e:20a6])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b003daf7721bb3sm5596436wmi.12.2023.03.16.10.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:38:37 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH 2/7] ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
Date:   Thu, 16 Mar 2023 18:38:06 +0100
Message-Id: <20230316173811.1223508-3-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
In-Reply-To: <20230316173811.1223508-1-revest@chromium.org>
References: <20230316173811.1223508-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _multi API requires that users keep their own ops but can enforce
that an op is only associated to one direct call.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
 kernel/trace/trace_selftest.c         | 10 ++++++----
 samples/ftrace/ftrace-direct-modify.c | 12 ++++++++----
 samples/ftrace/ftrace-direct-too.c    | 12 +++++++-----
 samples/ftrace/ftrace-direct.c        | 12 +++++++-----
 4 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index ff0536cea968..9ce80b3ad06d 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -785,6 +785,7 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+static struct ftrace_ops direct;
 #ifndef CALL_DEPTH_ACCOUNT
 #define CALL_DEPTH_ACCOUNT ""
 #endif
@@ -870,8 +871,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 * Register direct function together with graph tracer
 	 * and make sure we get graph trace.
 	 */
-	ret = register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
-				     (unsigned long) trace_direct_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
+	ret = register_ftrace_direct_multi(&direct, (unsigned long)trace_direct_tramp);
 	if (ret)
 		goto out;
 
@@ -891,8 +892,9 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 
 	unregister_ftrace_graph(&fgraph_ops);
 
-	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
-				       (unsigned long) trace_direct_tramp);
+	ret = unregister_ftrace_direct_multi(&direct,
+					     (unsigned long) trace_direct_tramp,
+					     true);
 	if (ret)
 		goto out;
 
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index d93abbcb1f4c..f01ac74bac10 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -96,6 +96,8 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static unsigned long my_tramp = (unsigned long)my_tramp1;
 static unsigned long tramps[2] = {
 	(unsigned long)my_tramp1,
@@ -114,7 +116,7 @@ static int simple_thread(void *arg)
 		if (ret)
 			continue;
 		t ^= 1;
-		ret = modify_ftrace_direct(my_ip, my_tramp, tramps[t]);
+		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
 		if (!ret)
 			my_tramp = tramps[t];
 		WARN_ON_ONCE(ret);
@@ -129,7 +131,9 @@ static int __init ftrace_direct_init(void)
 {
 	int ret;
 
-	ret = register_ftrace_direct(my_ip, my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
+	ret = register_ftrace_direct_multi(&direct, my_tramp);
+
 	if (!ret)
 		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
 	return ret;
@@ -138,12 +142,12 @@ static int __init ftrace_direct_init(void)
 static void __exit ftrace_direct_exit(void)
 {
 	kthread_stop(simple_tsk);
-	unregister_ftrace_direct(my_ip, my_tramp);
+	unregister_ftrace_direct_multi(&direct, my_tramp, true);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 8139dce2a31c..05c3585ac15e 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -70,21 +70,23 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static int __init ftrace_direct_init(void)
 {
-	return register_ftrace_direct((unsigned long)handle_mm_fault,
-				     (unsigned long)my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) handle_mm_fault, 0, 0);
+
+	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct((unsigned long)handle_mm_fault,
-				 (unsigned long)my_tramp);
+	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp, true);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct()");
+MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 1d3d307ca33d..42ec9e39453b 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -63,21 +63,23 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static int __init ftrace_direct_init(void)
 {
-	return register_ftrace_direct((unsigned long)wake_up_process,
-				     (unsigned long)my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
+
+	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct((unsigned long)wake_up_process,
-				 (unsigned long)my_tramp);
+	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp, true);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
+MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
-- 
2.40.0.rc2.332.ga46443480c-goog

