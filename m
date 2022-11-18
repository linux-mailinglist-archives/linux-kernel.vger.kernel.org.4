Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943D462FBBF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiKRReG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242533AbiKRRdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:33:32 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E4976E7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:32:33 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b21so5145453plc.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=um7o47dkwC3+Xw39j9lUuqY5O+T3nm01Mm5u8aYpugQ=;
        b=bKlIx655pe3B+kU4aGQHe83PsarqTSNkJgq+XRCvic+rix3rZvypD7FAQbl8gYsUDD
         2dqZGBtB6qVDypNdijaMpfpWr6w3V1lCNGGYMbnLbA65mBemShhEZCqNslu6hoBVgH9y
         WXM4UVDYWXnn3+7o46j4i9UXJAAji3tVB8cuqQovq73rJGr0HNMVFD/aOkFvchMxaY0H
         ORKxWsayMeW6gda+HNYq5r/Y550hpY8CvB/o/OoYOEvDY1AvF++rH0nH1tAsrxmIHGF9
         uCTu9N9MGMeS0NwwteNRRl39+9BlK7I56LV/O1p4hh2+cWTNLA0GDcKkrGvXwDpZaMBJ
         hMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=um7o47dkwC3+Xw39j9lUuqY5O+T3nm01Mm5u8aYpugQ=;
        b=LkaTZFbwz5MrIS54FyK0pmfR4Vcv7FFSnrRNm58CICeXWkPd+dQSnfW44XW24Ap2E4
         nLoB6vnlq0PDIddVKrfdbDV2QgDW7t85dqPgr0eGJmedDX71xR9rObZl7gF05yIVt95T
         mlGiG9dv7z6uQVqXcV0eIUS5G5itJ/gb9XzmXjJ5hPyjLO1sIB7rlZsYoa4/9pMT30H+
         N4K6ZceTGSRIC5cv1HHi9exkE1Fyt8mB8K/By2mFC5dJ2cAedQewXdgKsEznc+CGmOsW
         b/fBgP64gwHbfWKtLITRl2ydd3IJxnoIYXc5LA22kQSucWX+5Qs9n0SThqBAp/+GQWwl
         wKMA==
X-Gm-Message-State: ANoB5pksatIHaWIR4Pa/Xa8BOx2ppfowE1SXo+j0tCdUndhg//fmh6vc
        h7kK2i5agjeuylteoznrbMU=
X-Google-Smtp-Source: AA0mqf58OB6QcS+3YK1TMkO/KdVKNF6E9CzOlYkfERJcrBVIDQJ6MLk3ufE/xMOPiz3L5aZbV96Y7w==
X-Received: by 2002:a17:90b:3d90:b0:212:de1c:a007 with SMTP id pq16-20020a17090b3d9000b00212de1ca007mr15291940pjb.30.1668792752983;
        Fri, 18 Nov 2022 09:32:32 -0800 (PST)
Received: from localhost.localdomain ([112.2.231.196])
        by smtp.gmail.com with ESMTPSA id u7-20020a656707000000b00476b6b7f339sm3037979pgf.11.2022.11.18.09.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:32:32 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH v3 1/2] riscv/ftrace: add ftrace_graph_func
Date:   Sat, 19 Nov 2022 01:32:16 +0800
Message-Id: <20221118173217.888077-2-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221118173217.888077-1-suagrfillet@gmail.com>
References: <20221118173217.888077-1-suagrfillet@gmail.com>
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

