Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E656291C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiKOGP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKOGPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:15:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398D71EC56
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:15:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so12918093pjl.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ui8airw69h4AUo9oSmUgv1gkgt+KqV79d7fg2QkBl5M=;
        b=qjXR2fiv4kg9+omGG4vO16S+uSEZ7V3D5muYTI2e+cCxJKqZZpOed+6egG+gp1pCoX
         pMjy/kZeJ51sujHaYgIFrywHsdJWPuUEjfll30uxR63zU44uRf+jA9fLF2bW9eq2DBXd
         rXT6rpuM6BTdIrnC9l3j06dlpTwwr56h3qwrUbFTYaN461zWfipD9qMnGJFF0FlFoNgp
         w8Qh2rcNICYacRmDfFHyoxT5ebblLdWKa6DTY5pjRq8jGiV6KU9E1CrVvEcQJoJYDDP7
         IQS9IKNrsTM+6a2ohqm0uqAzVykK1ku3PBuu+o7yguxGhUDggkiWEe27PEGe0Xqs/D8n
         7HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ui8airw69h4AUo9oSmUgv1gkgt+KqV79d7fg2QkBl5M=;
        b=o3VIa+b7GgqB6Ur7eR1X89jSJFhB5KYQeAebAj9elhnqLFLO3XZ+njvJ25M5iux3Yo
         fiVxVpT0kVRjw1n0QpQ1Yca+q0MjFYFl8WopJWJ22PDiUfwY63OyKaXBnoE0X/l8n6dy
         iW3hGRwTDCKR3fiWbHivtulixICdQF/Eq53O511CqaPF7WRzJPybDCAx8i7eFAhGSQ1p
         XlVvuQtBXoXamRWSDRMXnWuJF6ZQkdPesGUB3e3HMcm0EYjJdGHwQrFfYXJOAp7RxzHx
         YrUBWsNcZFrydazmvbCpCr2K33uZ3LqoJsJXMEcF1ud0vXbbZtx4r/isGvayV6ES6ogx
         UmGA==
X-Gm-Message-State: ANoB5pmJpWTlHb5DVUUgzewtjE6A6pJM0MPtMsq+hXupyxqsoKjlfEUG
        h7stzkSBWd7TJWUfZCfdr2A=
X-Google-Smtp-Source: AA0mqf6ahWjvyXPj6nTnyXmRe3B+e5AQiDB1hRBcbBS3K1NZio1kDogPfJrNTwZ80MFleU/NGUZNrQ==
X-Received: by 2002:a17:90a:5b08:b0:213:7030:b2ec with SMTP id o8-20020a17090a5b0800b002137030b2ecmr687621pji.95.1668492947682;
        Mon, 14 Nov 2022 22:15:47 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b0017f57787a4asm8736769plb.229.2022.11.14.22.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:15:47 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH 3/3] riscv/ftrace: cleanup ftrace_caller and ftrace_regs_caller
Date:   Tue, 15 Nov 2022 14:15:25 +0800
Message-Id: <20221115061525.112757-4-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221115061525.112757-1-suagrfillet@gmail.com>
References: <20221115061525.112757-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace_caller and ftrace_regs_caller save their regs with the respective
option of SAVE_ALL, then call the tracing function, especially graph_ops's
ftrace_graph_func. So the ftrace_graph_[regs]_call labels aren't needed
anymore if FTRACE_WITH_REGS is defined.

If FTRACE_WITH_REGS isn't defined, the !FTRACE_WITH_REGS version
ftrace_caller remains with the ftrace_graph_call. So the enable/disable
helpers are revised for serving only this ftrace_graph_call.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/kernel/ftrace.c     | 19 ++----------------
 arch/riscv/kernel/mcount-dyn.S | 35 +++++++++++++++-------------------
 2 files changed, 17 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 2d7ce77d4f33..974732207c1f 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -211,30 +211,15 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 extern void ftrace_graph_call(void);
-extern void ftrace_graph_regs_call(void);
 int ftrace_enable_ftrace_graph_caller(void)
 {
-	int ret;
-
-	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, true);
-	if (ret)
-		return ret;
-
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
+	return  __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, true);
 }
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	int ret;
-
-	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, false);
-	if (ret)
-		return ret;
-
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
+	return  __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, false);
 }
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 2f0a280bd7a0..9e4097c6793d 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -215,6 +215,7 @@
 	.endm
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 ENTRY(ftrace_caller)
 	SAVE_ABI
 
@@ -243,33 +244,27 @@ ftrace_graph_call:
 	ret
 ENDPROC(ftrace_caller)
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 ENTRY(ftrace_regs_caller)
-	SAVE_ALL
-
-	addi	a0, ra, -FENTRY_RA_OFFSET
-	la	a1, function_trace_op
-	REG_L	a2, 0(a1)
-	REG_L	a1, PT_SIZE_ON_STACK(sp)
-	mv	a3, sp
+	SAVE_ALL 1
 
 ftrace_regs_call:
 	.global ftrace_regs_call
 	call	ftrace_stub
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	addi	a0, sp, PT_RA
-	REG_L	a1, PT_EPC(sp)
-	addi	a1, a1, -FENTRY_RA_OFFSET
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	mv	a2, s0
-#endif
-ftrace_graph_regs_call:
-	.global ftrace_graph_regs_call
-	call	ftrace_stub
-#endif
 
-	RESTORE_ALL
+	RESTORE_ALL 1
 	ret
 ENDPROC(ftrace_regs_caller)
+
+ENTRY(ftrace_caller)
+	SAVE_ALL 0
+
+ftrace_call:
+	.global ftrace_call
+	call	ftrace_stub
+
+	RESTORE_ALL 0
+	ret
+ENDPROC(ftrace_caller)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
-- 
2.20.1

