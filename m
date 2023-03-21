Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8B86C339B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjCUOEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjCUOEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:04:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A68A20A3A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v25so10346477wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679407476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WwprlyMlMMHhcPdyuhJ0L2KuDUXGr9VK74fm/Vyg9g=;
        b=nLWVXyspYz9peVqzG15vQujgApPLo7W8YAlDMmwXgMiAA8jyvGC+C9kFU5nQxGTPhi
         zJaGZ+jIs25bcgi3FxZOM/mn7T0TS5RAADcWbBNMT8QkFTxWOR1tGMn9V9jRt+S4/O8J
         vhouX/tHYrYoPpKhnDRpdau1olcLao3K7xi84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WwprlyMlMMHhcPdyuhJ0L2KuDUXGr9VK74fm/Vyg9g=;
        b=oaDEx9slIkW9/qGSs+7QpKxAe8W8AXtcdBJS8qczfv1y1KQl+ojDENOYFreRRqduU9
         32poQOQNyosU0qCRTzU5G9D7acHu1acDRCBv5sivu+YGRFt0zDCRwpnzjWRYTcXSxkOt
         OYWw1nVPb6c+H2o0nfYn6PDyJSa82y7SFy7sMdTebKEY0EHSzDsNzCCeRL1G2hAvRkZG
         gH/+tyCIwM5AZCw31sVVM/VSmp1TIM1N0QsS6Jvsm6kMI/6qZO6mY19lq2AzF1k/ZZCX
         brJsYDJGza5ZpwIfDmVTM6/E8H3iB+lapdpTvEfDgTu5aJuqt5mUEreC7QLtCdiy5fry
         mBPA==
X-Gm-Message-State: AO0yUKU3jJEwA6hhcUzL6bqOi8miiY2CbRrpp1inLjMWDML0nrKdHlru
        2OXS6L8xBp/uk2oQcx1J9c/v2la4WNWquritswg=
X-Google-Smtp-Source: AK7set8j3AWvvYQCOCHio+wE0JelTFbsmhmRg5txzyLp9SsTVqwHubY4XxVeXRxmdO+Rz1x3oFnzoQ==
X-Received: by 2002:a05:6000:105:b0:2d9:eb77:90d2 with SMTP id o5-20020a056000010500b002d9eb7790d2mr182791wrx.70.1679407476066;
        Tue, 21 Mar 2023 07:04:36 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4b8c:8b16:90d:8d9a])
        by smtp.gmail.com with ESMTPSA id f12-20020a1cc90c000000b003e20cf0408esm13620896wmb.40.2023.03.21.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:04:35 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH v2 1/7] ftrace: Let unregister_ftrace_direct_multi() call ftrace_free_filter()
Date:   Tue, 21 Mar 2023 15:04:18 +0100
Message-Id: <20230321140424.345218-2-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
In-Reply-To: <20230321140424.345218-1-revest@chromium.org>
References: <20230321140424.345218-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Acked-by: Mark Rutland <mark.rutland@arm.com>
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

