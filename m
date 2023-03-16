Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502506BD740
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCPRiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCPRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:38:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55492BCBA5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so3806374wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678988321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsNYhiaIOtq0nn5ucG+FpbuZEwYeJVaBVWdakwIEYeQ=;
        b=A+DI/l3zXJ7u+2E9u/9ED8O9XkDm7L5deDh9Bp5JeZ4BlaTCin11OJiYZlZiWNMeHK
         NORbJKtpSGs4hb64Ez+t0RvGXX6IIZsvQsR6pZuHLEUmgIXenDXUn7RXvhgPplJGoVoi
         fapDbtMQBytUHt0xr3OiLL5wb0i+nElsmK/qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsNYhiaIOtq0nn5ucG+FpbuZEwYeJVaBVWdakwIEYeQ=;
        b=JFNHSdLSdQ/5ukeIJbrQlnDYP+WEYyna1zcWrn3QHqcAbi6f0993EKMYwy8bvgxofK
         EEtTLWf1/mw2WblX3y1H+Zkd+MPgd2vSVLT6vXNrS+j2V8ebqm+66bqgRUx47WTewVV3
         saORWPZX0c3EOZQbLWfwbhLJtfBQ79gizsz5tLa2qWzXpWhchS7FhJNDg5PdjGb7jLWi
         brY2psks+2bHANPc9EidIlGygbo5U0cQQFevJBlWeBzAEiymaQgO2+WVfGVGNmx0kseJ
         WvO8+AhFKugTr/in2hicmm0AVs5tK7kCicu5uS8YwcqDte9n31M/W1JTk01d7p1QvR2N
         ajmg==
X-Gm-Message-State: AO0yUKUZQu/6Nf9xhL2+URsDsBZNtanDYR+3X9EhjhVvucbOEYM/Yono
        C2XLcLa7dpuNzWtPzZL7g0AiY4Fz9N7/zRIBZGQ=
X-Google-Smtp-Source: AK7set/61e0GanlIj9n8CwavQ973JCIupYejI8etsHeCFaatxNWSIeqqTQtpgkk1fsKSsMZ4ukcyLQ==
X-Received: by 2002:a05:600c:46d2:b0:3ed:3d5a:ac84 with SMTP id q18-20020a05600c46d200b003ed3d5aac84mr5097614wmo.36.1678988321457;
        Thu, 16 Mar 2023 10:38:41 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:24ff:9ff7:736e:20a6])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b003daf7721bb3sm5596436wmi.12.2023.03.16.10.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:38:41 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH 5/7] ftrace: Store direct called addresses in their ops
Date:   Thu, 16 Mar 2023 18:38:09 +0100
Message-Id: <20230316173811.1223508-6-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
In-Reply-To: <20230316173811.1223508-1-revest@chromium.org>
References: <20230316173811.1223508-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 33530198d1ca..66c91fa4b6ab 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2582,9 +2582,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	unsigned long addr;
+	unsigned long addr = ops->direct_call;
 
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

