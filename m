Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0A6291C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiKOGPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKOGPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:15:40 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04360140D9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:15:40 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k15so13235210pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bUagvGYVwuH85x9VGCmZe8w6n24dTZmrFkDrBOEYew=;
        b=emPzmYPzC6EXM7lNu8jzs6I/yUKvaSt7SnmUL5TAeEXq0fw3Ob0z4XAtUxLFOepNMC
         XVF8aJYgJtHALPKGRj2e5BA53YXB+8R1VkH2Nv89Lwj39rnsyQdHsfWvV0GPwpOnm6PN
         k873s4evosXjprSwTXprETDMQjXww2qUupywX5KjZiSiepdML8s6kssXBwiS+W7kqzud
         8BJD9iRMGKuxB3+/2DW1RJ/Kd8PA6nvNh+PRfopHi8i65nqhSRZZ1pDY9HujtnikiDH9
         PfvjXW/k2UUJWGC0pdq/79C+W8afoMQgwsX+UA4V/6yapLx6Hev/64V6UB1kCyn5ZR7P
         q95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bUagvGYVwuH85x9VGCmZe8w6n24dTZmrFkDrBOEYew=;
        b=uzslvchFp1fivFzvvmom6YpmnyO4aVHqBgbGANHFsxUsJNAKTn/IU3AddLlvLejWtk
         akeQ71Uxw95Ky/YaJygAwSfJa9xf47ULt8y7PK/+9PRVAtY3sMrjZz/iPhdm7fb8bYXo
         3x9IPYwRmCiccZBKtiuEiOMxJQZupZOpXe4WgZDWnN7kgnXQUQUpka6E0+vetvC1Qbw3
         C3n/nHLidu5Y+pQCqq3kfgAqkXyVXmURj5tZvIXZ4aI5u+aSs1TaS9sK82MTKiKAdwRT
         Uyx0RNcGvAmyRzucEZAwcb8zKffkbECjFHNyacK0p2YYFzx1i1hpkCPewJNZfK7LxO6J
         3SPQ==
X-Gm-Message-State: ANoB5pnNdyOt1PwnqTl8gESeFXmH9XH6oq3tHh0010kim+tz/2qhuWWJ
        NIMqMZQWQz3sn72EXmYgkXQ=
X-Google-Smtp-Source: AA0mqf6WWiNknW0Fppg4F1OMPb702hbPzmIMi0Cj5aQFukozBD4C6Ntw5ni/HfJ25nTZ3Ow/tUU9mg==
X-Received: by 2002:a63:4a0f:0:b0:476:837c:1bdf with SMTP id x15-20020a634a0f000000b00476837c1bdfmr6945742pga.587.1668492939465;
        Mon, 14 Nov 2022 22:15:39 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b0017f57787a4asm8736769plb.229.2022.11.14.22.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:15:39 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH 1/3] riscv/ftrace: add ftrace_graph_func
Date:   Tue, 15 Nov 2022 14:15:23 +0800
Message-Id: <20221115061525.112757-2-suagrfillet@gmail.com>
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
index 04dad3380041..b33c98070972 100644
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
+			struct ftrace_ops *op, struct ftrace_regs *fregs);
+#define ftrace_graph_func ftrace_graph_func
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_DYNAMIC_FTRACE */
 
 #endif /* _ASM_RISCV_FTRACE_H */
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 2086f6585773..2d7ce77d4f33 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -196,6 +196,20 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+			struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
+	unsigned long *parent = (unsigned long *)&(regs->ra);
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

