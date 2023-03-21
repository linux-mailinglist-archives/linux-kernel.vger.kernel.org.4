Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57E6C33A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCUOFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjCUOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:04:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3615321A06
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so11143396wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679407481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2fmFB1FVRjrhf8zh2dvknFsm562JmIp8xz3gFT+UVA=;
        b=VYFq9Y/i+3bznsGRQQidOXTXEdh59n3ImD7f48RqiRuS6jw4VQFeV9Fbwg6JlfWcTe
         QO1ejrsHbmk76zOqsucN8SS14PjoqSzyYKmonbBdC64TObAwdijzLJGlGJXBpsoYghSA
         uXhrwcxvkOVJayviK6NuPHnfY6AB+TBs5H5Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2fmFB1FVRjrhf8zh2dvknFsm562JmIp8xz3gFT+UVA=;
        b=IOFbsNSnWy/i8NJQ31A5KqN7k8FGlRnAK7d7Fhl5rqc2MqTGsHZLaWiZEVYvwJq7nx
         3Fp4/84DTo19Ao1lEZOFJPomPbEdigiLMt/rMRLRO9KoM0Fu+X2gyzUrq2oZrHqRJ1xi
         sopuLywCaYJQkhQZc5oK1bc+6vzX/7J3hCyemgqC9ZOxUMovoozGjTkvCbT2GAy2Xj/q
         Pgc7bksvYh0Kwzn3dUaMP1VcBbQdbz9PkPAr845rkChf5y/TpaoYHIGqRe3kOgsPGZzL
         auOh72FbNuQ1bWII99VYE4hB2mq68LXrmMEsUMqRswgM8KY/66sHA9aEQ6Bexozj5Iez
         2T1A==
X-Gm-Message-State: AO0yUKVYITuQfMyOlp2zRczoBqzqHzj6zX+RJY15arsDEG17faEDPPxa
        TFwH2EaLksOFPLK4Xbs/VB6TTMnCPo0jej/4m4c=
X-Google-Smtp-Source: AK7set9kAZZfIfQYRbzvwWo0ac+ttDsnVfvSDTzDInqjOlaZ/piVfDg6oJq+fKaxQ0vK3lbK9hMqgQ==
X-Received: by 2002:a05:600c:2148:b0:3ed:b6ad:54d with SMTP id v8-20020a05600c214800b003edb6ad054dmr2523905wml.18.1679407481466;
        Tue, 21 Mar 2023 07:04:41 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4b8c:8b16:90d:8d9a])
        by smtp.gmail.com with ESMTPSA id f12-20020a1cc90c000000b003e20cf0408esm13620896wmb.40.2023.03.21.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:04:41 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH v2 5/7] ftrace: Store direct called addresses in their ops
Date:   Tue, 21 Mar 2023 15:04:22 +0100
Message-Id: <20230321140424.345218-6-revest@chromium.org>
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

All direct calls are now registered using the register_ftrace_direct API
so each ops can jump to only one direct-called trampoline.

By storing the direct called trampoline address directly in the ops we
can save one hashmap lookup in the direct call ops and implement arm64
direct calls on top of call ops.

Signed-off-by: Florent Revest <revest@chromium.org>
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
index 33530198d1ca..bf1f857bfe76 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2582,9 +2582,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	unsigned long addr;
+	unsigned long addr = READ_ONCE(ops->direct_call);
 
-	addr = ftrace_find_rec_direct(ip);
 	if (!addr)
 		return;
 
@@ -5380,6 +5379,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->func = call_direct_funcs;
 	ops->flags = MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
+	ops->direct_call = addr;
 
 	err = register_ftrace_function_nolock(ops);
 
@@ -5454,6 +5454,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
+	tmp_ops.direct_call = addr;
 
 	err = register_ftrace_function_nolock(&tmp_ops);
 	if (err)
@@ -5475,6 +5476,8 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 			entry->direct = addr;
 		}
 	}
+	/* Prevent store tearing if a trampoline concurrently accesses the value */
+	WRITE_ONCE(ops->direct_call, addr);
 
 	mutex_unlock(&ftrace_lock);
 
-- 
2.40.0.rc2.332.ga46443480c-goog

