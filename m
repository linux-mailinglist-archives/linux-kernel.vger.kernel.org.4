Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F91162B1B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiKPDNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiKPDNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:13:32 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6499D558C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:13:31 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id io19so15209850plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfjBpdjhy3FRsarxq0mtTibVzLi0v1ap0dEoQSB+eCk=;
        b=HCmzSGbRAwS0Xz3K0YWpt5t1BGt5W3HFACyaOHbIgILZxabfSXhfkANFw6bM2qGYbD
         KT0gAgUO/ptx1Ede2o+OegsXqmyFeG6hMuBNz+iz5bir+2JjrfxSN+2o+JBGM2a0bLvH
         BYxMmfVtXGLOwByy0FY0WYjep6f2KcONrF0Y6SP0LJb11yt5u+CWezM7S4UkCQS9T1wu
         w9eytCB0ND+aNbyDEgLxjbTL8k7kUrGyS9cM8jW2OQcV6/PhXTcUTFFXPUwWiPAcyUSX
         L+leE4UYdnSSKzRlg1ofV+ass5fcCgE4kwe8JKRfhBSViurqpafvfi9En+qpZ4TJtsOa
         o5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfjBpdjhy3FRsarxq0mtTibVzLi0v1ap0dEoQSB+eCk=;
        b=aDmZthL2b3fL4sB2vHXETM1hukHpvVx4Vwo84OapGoDS9vVYsRaxyta3f83TfRiRfO
         ZO0JO16ztAa/OWhFQ6WUONOYeZhFCCgZXGGM6mc+Fg5Yd5aiWDZRZTumyl1h38P53pof
         kgK2TMdrudbobYm3VtebiuOTsvRkebLQK3XCmaQRplfv8u94AggjvMLXSVD+VA85uaJi
         I8w1GN5AKcFz62J7KOmigFZjRdKcu98rs4vyw37DmHbmFe07I0Ir76Xtee6nvgL70X/0
         SbpGkOksaYXVEJNj0cr6c6UQH91PDhIJ3U9H6XGWTDXk53j9yHWgVK5CAN+QiZK6pkmo
         nV2w==
X-Gm-Message-State: ANoB5pmcEPi2dsNdVNRKnO7jKKnuJzzxokn6RFCx9gK8gt5ijnYzlftf
        niF8ujSS7LgjcJQN0VxoDKQ=
X-Google-Smtp-Source: AA0mqf6906E8vnIqvm3Ht/G0BwBICFFZTgDzXIhHEd3G6itTsjMGFeNoVLqdl6f5iKF7o8OuPFNjLA==
X-Received: by 2002:a17:902:b186:b0:185:4ec3:c708 with SMTP id s6-20020a170902b18600b001854ec3c708mr7046411plr.60.1668568410924;
        Tue, 15 Nov 2022 19:13:30 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id ml22-20020a17090b361600b0020b2082e0acsm348295pjb.0.2022.11.15.19.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 19:13:30 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH v2 1/3] riscv/ftrace: add ftrace_graph_func
Date:   Wed, 16 Nov 2022 11:13:03 +0800
Message-Id: <20221116031305.286634-2-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116031305.286634-1-suagrfillet@gmail.com>
References: <20221116031305.286634-1-suagrfillet@gmail.com>
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
ftrace_graph_[regs]_call remain for serving the !FTRACE_WITH_REGS
version ftrace_caller.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/include/asm/ftrace.h | 13 +++++++++++--
 arch/riscv/kernel/ftrace.c      | 16 ++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 04dad3380041..61a8f4be67eb 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -81,8 +81,17 @@ do {									\
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
index 2086f6585773..148a5480076b 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -196,6 +196,20 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
+	unsigned long *parent = (unsigned long *)&regs->ra;
+
+	prepare_ftrace_return(parent, ip, frame_pointer(regs));
+}
+
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
 extern void ftrace_graph_call(void);
 extern void ftrace_graph_regs_call(void);
 int ftrace_enable_ftrace_graph_caller(void)
@@ -223,5 +237,7 @@ int ftrace_disable_ftrace_graph_caller(void)
 	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
 				    (unsigned long)&prepare_ftrace_return, false);
 }
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.20.1

