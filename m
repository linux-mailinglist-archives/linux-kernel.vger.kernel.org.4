Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AD16BD741
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCPRjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCPRis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:38:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD7FDCF74
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so1729108wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678988322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RknWTQPZwhibubaws4VpF1wT1qJmtFEhJqVyQzYCbBk=;
        b=f56BSsM5F/ldRHe5qOjUptpr+nccSsE5eRA+3mK+BgPce9DTV5LPUavBnVLW47eUr/
         6awV/JtevYfZanAmjonsIB5yDkuEWU+8Bh4+0wwFygu9rthmr6XVcRYgNPxpRsObPeen
         eXqYveVWhsHFhzLC7FwxE+eSuYdf1kpXMZ9V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RknWTQPZwhibubaws4VpF1wT1qJmtFEhJqVyQzYCbBk=;
        b=QaLvFaslwIfL1LG+2lA8vXH3058kvxotbvp+swta2BrfcF+R8U+vsloaEiAuHzkHQt
         qSONq0oBoDna1SJ5eIq5qR1A91xwe/t8m10u8p9ZrpQTBRYMoh6AzMojAcmZgELT3fij
         UXEf5A5XjNdPsezOcU1l6EUelCfvpZrKRw8rsyX1LGXmDC+E3QPTW5+5oaY0w9poQM3H
         mLL22MxUsJWrJI82+PrbCchpnB3m9Nvlawe//XuZ/xZ9KbqGut+zooEdOaGS/vo9/I5x
         f9ODikUuNToKgmutTKjGYZkjJivoagMxgqu6VAorFPBy24uQnZ29tRh7UX1AuH0XawAq
         MVQg==
X-Gm-Message-State: AO0yUKWZ/EfRl+3O1w03EM/4ROCh2v/mrMUzU8vg5MZCgvkE+IK1xB5Y
        JAzuoOTWbSgeGc4AXWkfMcwTgRhguT4t3Qu/8mM=
X-Google-Smtp-Source: AK7set8fQLltLcsZzQ9slScet8GE/Dwu5L9dJC6i/Vr8BgFYq3Cv/RXIIf+pHRdklUlxKFsDAwyCLg==
X-Received: by 2002:a05:600c:314c:b0:3ed:3d89:1b4b with SMTP id h12-20020a05600c314c00b003ed3d891b4bmr4819498wmo.8.1678988322663;
        Thu, 16 Mar 2023 10:38:42 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:24ff:9ff7:736e:20a6])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b003daf7721bb3sm5596436wmi.12.2023.03.16.10.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:38:42 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH 6/7] ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
Date:   Thu, 16 Mar 2023 18:38:10 +0100
Message-Id: <20230316173811.1223508-7-revest@chromium.org>
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

Signed-off-by: Florent Revest <revest@chromium.org>
Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
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
index 66c91fa4b6ab..7a0c7eddf25b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5287,7 +5287,7 @@ static LIST_HEAD(ftrace_direct_funcs);
 
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
-#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
+#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
 
 static int check_direct_multi(struct ftrace_ops *ops)
 {
-- 
2.40.0.rc2.332.ga46443480c-goog

