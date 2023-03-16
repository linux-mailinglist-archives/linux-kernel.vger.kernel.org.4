Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08DE6BD73E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCPRio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCPRil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:38:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA031580F1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so3806281wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678988317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wr73ZyuupqiceijaF5zGTVvDhYegbGIToVzUTTBWoEo=;
        b=VwpZzNsFKEFB12MezGJW51gv23+nDYcJDSiuRKrzOFESmkqoK27bNDw+1QAMNLKwh/
         SV0W8Iw92oIhUzNvv97ekwJys2avuGJcUIU4DXi2YLC+twyBMk1Mue961NOfxZSSE45B
         tyEzWPv1zV8sy6Z5/cu5rjYVz57YD5JmHsdDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wr73ZyuupqiceijaF5zGTVvDhYegbGIToVzUTTBWoEo=;
        b=tA+I6Vbq+YzgVTYQXtsYo0+y0molJJNybbb683/kBxhjZeLJKK+mbVaYsUy0I5Tn8D
         cdMctVWoSZfYxIE4yaQ6OkU8kkI/I/SQkgKh6JsqPHzG00JtutDQLb5PCURXGD3n1led
         eoOyVX3wMA33msvQkULfuCOkoI/YVpRHahgPg32DIjCRtdpTmbMBkq1ENp16+TcZo5lH
         TYWAcQ09VHCg9SSkk2zZFcOuCVCKoN4J+e/h5mX9B7WyCCbTnQrOxZVQTbYm0k7a62QU
         261SviknLc1tUGzCU0h4HQsg/IrPTH8D2Q28h3CGijHYpK004nGvrx7yIDvITt+QlggT
         xbGg==
X-Gm-Message-State: AO0yUKX4nc48bp++NTDj/PvuMM/OgPi+mXwIXa5csAwJHgGjNIPhdNp5
        BioJi7OntaqxhsNnQhOpiqlSehM8S3KRHK9UfDY=
X-Google-Smtp-Source: AK7set+klRq0+91u6xbabenj6+0NLVVpoJNbLAhO22sb9pB299//Tytw9W5TDYwDB2xIqSfjTNPuQA==
X-Received: by 2002:a05:600c:1ca3:b0:3ed:2606:d236 with SMTP id k35-20020a05600c1ca300b003ed2606d236mr12750060wms.38.1678988317028;
        Thu, 16 Mar 2023 10:38:37 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:24ff:9ff7:736e:20a6])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b003daf7721bb3sm5596436wmi.12.2023.03.16.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:38:36 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH 1/7] ftrace: Let unregister_ftrace_direct_multi() call ftrace_free_filter()
Date:   Thu, 16 Mar 2023 18:38:05 +0100
Message-Id: <20230316173811.1223508-2-revest@chromium.org>
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

A common pattern when using the ftrace_direct_multi API is to unregister
the ops and also immediately free its filter. We've noticed it's very
easy for users to miss calling ftrace_free_filter().

This adds a "free_filters" argument to unregister_ftrace_direct_multi()
to both remind the user they should free filters and also to make their
life easier.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/ftrace.h                      | 6 ++++--
 kernel/bpf/trampoline.c                     | 2 +-
 kernel/trace/ftrace.c                       | 6 +++++-
 samples/ftrace/ftrace-direct-multi-modify.c | 3 +--
 samples/ftrace/ftrace-direct-multi.c        | 3 +--
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 366c730beaa3..5b68ee874bc1 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -407,7 +407,8 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 				unsigned long new_addr);
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
-int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
+				   bool free_filters);
 int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr);
 
@@ -446,7 +447,8 @@ static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned
 {
 	return -ENODEV;
 }
-static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
+						 bool free_filters)
 {
 	return -ENODEV;
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d0ed7d6f5eec..88bc23f1e10a 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -198,7 +198,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr);
+		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr, false);
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 29baa97d0d53..fa379cf91fdb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5804,7 +5804,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
  *  0 on success
  *  -EINVAL - The @ops object was not properly registered.
  */
-int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
+				   bool free_filters)
 {
 	struct ftrace_hash *hash = ops->func_hash->filter_hash;
 	int err;
@@ -5822,6 +5823,9 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	/* cleanup for possible another register call */
 	ops->func = NULL;
 	ops->trampoline = 0;
+
+	if (free_filters)
+		ftrace_free_filter(ops);
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index b58c594efb51..196b43971cb5 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -151,8 +151,7 @@ static int __init ftrace_direct_multi_init(void)
 static void __exit ftrace_direct_multi_exit(void)
 {
 	kthread_stop(simple_tsk);
-	unregister_ftrace_direct_multi(&direct, my_tramp);
-	ftrace_free_filter(&direct);
+	unregister_ftrace_direct_multi(&direct, my_tramp, true);
 }
 
 module_init(ftrace_direct_multi_init);
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index c27cf130c319..ea0e88ee5e43 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -78,8 +78,7 @@ static int __init ftrace_direct_multi_init(void)
 
 static void __exit ftrace_direct_multi_exit(void)
 {
-	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
-	ftrace_free_filter(&direct);
+	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp, true);
 }
 
 module_init(ftrace_direct_multi_init);
-- 
2.40.0.rc2.332.ga46443480c-goog

