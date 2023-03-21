Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCC76C33A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjCUOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjCUOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:04:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E808221974
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so11152083wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679407483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIDv0HpfCsRoXPuddKsYpWNPnYmNvE3dFnM8cxo3FIU=;
        b=b2LI4SsGygoMhWddhT9GHCGiqfGYUGt82i81kxoGuAdMR0Osc8ayZoC6WwLtedJmmd
         nqdnw277p1/7vV3PSBqQUI/JHUOqBdRXoyRoYSiFKTFhLh7UtKbp3vjCjz/BrX2exXOm
         lUeIlSGheMnDt/oK6TrjyxUIkaeB4bBptVOV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIDv0HpfCsRoXPuddKsYpWNPnYmNvE3dFnM8cxo3FIU=;
        b=NmBzy/EkjdbiPwrEl4VpRYKq3DcbRjNzByFT6Nx184Y6f7t9u1MZwBhyfhhCvgKdPc
         ihdoZgWHZndVROeD3GColjjsJ2XiMpJX5D0f6fhjxAVTMfwRCJpBunN3V29UR1cS7x+E
         svgkZmwNeQVO7DkOhmLmzLsMALeJZpb6GjkkN7Wr0fFKqbBUe93yX0RftLfQopYjz4hx
         rWVKj7x65aovg41AMcmUdceYTRGD+gq0F5SXNMgtabXnaa1PdLscmvTyl+Bl62YH+Wck
         vlcL04mfNmWiDvYPmHyUIKlqK74mv8dlPyhlurC5keTAJqqhVpXJuO+D9bn+Wga63OeL
         WnfA==
X-Gm-Message-State: AO0yUKV+ql4OonLfEClEnQ3rVO5BWdWobwt9SRf7cIfbHhPoXz19rvr5
        j2t7o5IGEAkdiEYPZrCUnNpYcRzLSGc3Fs3400s=
X-Google-Smtp-Source: AK7set8GJcU9BuABcJswk+gZoBJsDAAPydBwtlON2FtpmJApiFr+lOWFvVM8cHAnLMXkja8d7mU7+w==
X-Received: by 2002:a7b:cc8c:0:b0:3ed:8079:27d7 with SMTP id p12-20020a7bcc8c000000b003ed807927d7mr2300416wma.40.1679407482669;
        Tue, 21 Mar 2023 07:04:42 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4b8c:8b16:90d:8d9a])
        by smtp.gmail.com with ESMTPSA id f12-20020a1cc90c000000b003e20cf0408esm13620896wmb.40.2023.03.21.07.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:04:42 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH v2 6/7] ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
Date:   Tue, 21 Mar 2023 15:04:23 +0100
Message-Id: <20230321140424.345218-7-revest@chromium.org>
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
index bf1f857bfe76..437ae55a9f51 100644
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

