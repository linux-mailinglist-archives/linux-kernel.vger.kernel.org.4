Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C60631320
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 09:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKTIms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 03:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 03:42:44 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B759515718
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 00:42:42 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id k15so8777175pfg.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 00:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=um7o47dkwC3+Xw39j9lUuqY5O+T3nm01Mm5u8aYpugQ=;
        b=gZwm9U6mK3ALwu0oifabLOjV1RxAZrk0HSjZd6PCNBAM9P4WdR+dXylvSF6qvcEqgT
         D9kzlilet4yYsiLACIUkygpVjo9huz8Ow12yGFK/jcgPF6O/sDdtCWWNbJVd809fVL6x
         X+fDh2KVWZgLGP+qc9+Ybvk5H7BachFfwqsxpRz5bod4WIa3eK3EXUjylnwFNo/abn0s
         Zc+6WTgMbTeJ3+i9BW29KtYeIyUXTA9GKQgyDg1RYHte0dkPKWDimw74nJsbOfnPMTus
         67pZXkp5xtq2Zze25eQZm1zoQ7jqdOHope2gWc4Yn69zLpH4HP4BzKBpKRdMwQ5mgeCN
         /47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=um7o47dkwC3+Xw39j9lUuqY5O+T3nm01Mm5u8aYpugQ=;
        b=DTAHVwoOsjqQRNdUL4Tn6hGbRMJSkHbHBbMiRn94Pc/cr6dBaxAAti5QowA0ZNXJfP
         w/DJaoLrLyVl2JIMQOtWfuQ657wzSYIrbcoGMQqemx4/gmDonrbf+FpD2uQbrw3TS7WJ
         f64LjzX6rqH2KrsTWwlTdRdDsNqz7cwhcq5i5cw0K4LePZiWe4W/mrAUT+rCTPtpOzmC
         h4FafqCxfRVVDNwiBsXT/nTwaYU9nBBPOTpm/KMRDQp0/9hP9jEsgziuQxDoTDjwQxlS
         lVDTvl4VNHHdHf4YdAsD26gpCeMFMd/mKU+6cY5YtxGlCKN7JO4qTOleiIiGpbfWjLI7
         n+Mw==
X-Gm-Message-State: ANoB5pm/H8wegrIRuhddOJmZxXWO39P86WzDRzpNxAMMsq1lP+GI6XQZ
        tRpzBRo1rU/6f9SyelQIawU=
X-Google-Smtp-Source: AA0mqf7UlFnYpp1QvFsITWQ1L0YhPDFpdvVHyeYal9N+quNB0CnpslxjtszIsIKD7xxHdpvpVE5RaA==
X-Received: by 2002:a05:6a00:1825:b0:56c:f16d:2f29 with SMTP id y37-20020a056a00182500b0056cf16d2f29mr15603764pfa.53.1668933762210;
        Sun, 20 Nov 2022 00:42:42 -0800 (PST)
Received: from localhost.localdomain ([122.192.14.194])
        by smtp.gmail.com with ESMTPSA id q40-20020a17090a17ab00b00212735c8898sm8188273pja.30.2022.11.20.00.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 00:42:41 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH v4 1/2] riscv/ftrace: add ftrace_graph_func
Date:   Sun, 20 Nov 2022 16:42:29 +0800
Message-Id: <20221120084230.910152-2-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221120084230.910152-1-suagrfillet@gmail.com>
References: <20221120084230.910152-1-suagrfillet@gmail.com>
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

Here implements ftrace_graph_func as the function graph tracing function
with FTRACE_WITH_REGS defined.

function_graph_func gets the point of the parent IP and the frame pointer
from fregs and call prepare_ftrace_return for function graph tracing.

If FTRACE_WITH_REGS isn't defined, the enable/disable helpers of
ftrace_graph_[regs]_call are revised for serving only ftrace_graph_call
in the !FTRACE_WITH_REGS version ftrace_caller.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/include/asm/ftrace.h | 13 +++++++++++--
 arch/riscv/kernel/ftrace.c      | 30 +++++++++++++-----------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 34b0b523865a..01bebb28eabe 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -107,8 +107,17 @@ do {									\
 struct dyn_ftrace;
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
-#endif
 
-#endif
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+struct ftrace_ops;
+struct ftrace_regs;
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs);
+#define ftrace_graph_func ftrace_graph_func
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_DYNAMIC_FTRACE */
 
 #endif /* _ASM_RISCV_FTRACE_H */
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 8c77f236fc71..651ce5808b77 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -169,32 +169,28 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
+	unsigned long *parent = (unsigned long *)&regs->ra;
+
+	prepare_ftrace_return(parent, ip, frame_pointer(regs));
+}
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 extern void ftrace_graph_call(void);
-extern void ftrace_graph_regs_call(void);
 int ftrace_enable_ftrace_graph_caller(void)
 {
-	int ret;
-
-	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, true, true);
-	if (ret)
-		return ret;
-
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
+	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, true, true);
 }
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	int ret;
-
-	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, false, true);
-	if (ret)
-		return ret;
-
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
+	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, false, true);
 }
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.20.1

