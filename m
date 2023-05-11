Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C766FEEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbjEKJdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbjEKJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:32:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A0C83D4;
        Thu, 11 May 2023 02:32:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64388cf3263so5948492b3a.3;
        Thu, 11 May 2023 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683797574; x=1686389574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNfO2sYqLGwvbXj7b+RBDP96xK5wbSnAMcdu5du1sJ8=;
        b=eoMulosYXlZJab5DJ69Z7eSwNjOXQGja17mHz30M633x9kOzrdRevDa7ABGzmw7SDZ
         WJ7Dn+AnRqSj4SDHUmxIey0NyfZ2maR18lo93vDroKlJTTNy/NVP+6DVApP0URcFiLeM
         hW9yllx9OXV9nUBrCVl8purextKsoxykUtXedYHSE50X1LrYe/85Zvwj9MT2BLFkWzhG
         pN9wzYBuSe70XKzqkzDcMM0VcE9LEjwVJwha4px900CbJ2hQXXgCUZgK00MYiF1KxUp0
         mqpzj+Ys5QXW8oFfW9Z3kVo+NZoAJ3lMfQkKC74MfTXJFZ4aBgDuLq2Acp2ODRqYfaXS
         zasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797574; x=1686389574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNfO2sYqLGwvbXj7b+RBDP96xK5wbSnAMcdu5du1sJ8=;
        b=HzGzv+5WJveOGcc2YF+g1JCq2FUj5cY0yIHFKGdfVTHcpIM2XnyeZoRR6yDJRqOk4i
         cO4oLncB9QdQqR5Ec8fpFZsNcvEYUAq9pATf8HTqJPQUZ0wxiIWpjH8WOK23IcrtM5U/
         91AZjMPl0xQ4a0OY8ZNXSoehBjNeJKFyh7ARAJFTYatQh/j5JofTuLB13HAcd2zta4Mu
         fiYCrnZFrZ5PJ28ZR4Z1/DYnyPEb/6a4hBwessup64vZ16ePYem2M1iZGCgFOfROD4FD
         ClFF+JsKnUUxRcO8EsBkkTX3Dy54x5YpPMgN+/Dh6s/k8A8jtINCOUol4D47KGjy3IWq
         /L6Q==
X-Gm-Message-State: AC+VfDyEwe3CGsKKE82E7eQiNjT4/98t74zAcTVVW1bkFaZxH+vuOHPj
        SLhx3qhRfic5yXndqh4NHHs=
X-Google-Smtp-Source: ACHHUZ5tqFUzRUER4uYbdBP0mJZhbBdjxE25Tip8/gF5MrL7qlT/u9FSLspRUNnm8mXPQ+UM4wzM5g==
X-Received: by 2002:a05:6a20:8e07:b0:101:8f00:595f with SMTP id y7-20020a056a208e0700b001018f00595fmr8918036pzj.44.1683797573963;
        Thu, 11 May 2023 02:32:53 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78510000000b00627e87f51a5sm4875400pfn.161.2023.05.11.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:32:53 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, suagrfillet@gmail.com,
        jszhang@kernel.org, e.shatokhin@yadro.com, bjorn@rivosinc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH V10 3/4] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
Date:   Thu, 11 May 2023 17:32:33 +0800
Message-Id: <20230511093234.3123181-4-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230511093234.3123181-1-suagrfillet@gmail.com>
References: <20230511093234.3123181-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.

select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
register_ftrace_direct[_multi] interfaces allowing users to register
the customed trampoline (direct_caller) as the mcount for one or
more target functions. And modify_ftrace_direct[_multi] are also
provided for modifying direct_caller.

To make the direct_caller and the other ftrace hooks (eg. function/fgraph
tracer, k[ret]probes) co-exist, a temporary register is nominated to
store the address of direct_caller in ftrace_regs_caller. After the
setting of the address direct_caller by direct_ops->func and the
RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
by the `jr` inst.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ftrace.h |  8 ++++++++
 arch/riscv/kernel/mcount-dyn.S  | 10 ++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e0632493482f..fdf0b219a02c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -144,6 +144,7 @@ config RISCV
 	select UACCESS_MEMCPY if !MMU
 	select ZONE_DMA32 if 64BIT
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 84f856a3286e..84904c1e4369 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -114,6 +114,14 @@ struct ftrace_regs;
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #define ftrace_graph_func ftrace_graph_func
+
+static inline void
+__arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+{
+		regs->t1 = addr;
+}
+#define arch_ftrace_set_direct_caller(fregs, addr) \
+	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index fb8286b80cfc..b6f4e1847d61 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -231,6 +231,7 @@ ENDPROC(ftrace_caller)
 
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 ENTRY(ftrace_regs_caller)
+	mv	t1, zero
 	SAVE_ABI_REGS 1
 	PREPARE_ARGS
 
@@ -239,7 +240,10 @@ ftrace_regs_call:
 	call	ftrace_stub
 
 	RESTORE_ABI_REGS 1
+	bnez	t1,.Ldirect
 	jr	t0
+.Ldirect:
+	jr	t1
 ENDPROC(ftrace_regs_caller)
 
 ENTRY(ftrace_caller)
@@ -254,3 +258,9 @@ ftrace_call:
 	jr	t0
 ENDPROC(ftrace_caller)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+SYM_CODE_START(ftrace_stub_direct_tramp)
+	jr	t0
+SYM_CODE_END(ftrace_stub_direct_tramp)
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
-- 
2.20.1

