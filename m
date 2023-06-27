Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CD373FAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjF0LQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjF0LQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:16:41 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F7A1FE2;
        Tue, 27 Jun 2023 04:16:39 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-39ea511930eso3565593b6e.1;
        Tue, 27 Jun 2023 04:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687864599; x=1690456599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2K0OuQGxCrdsKt9Q57JYfi5owLHsSbU96G7U8K7Wyc=;
        b=CLCvM5Ht93QC4AHE/cHmirC2W6l/TIb1ObX5XhXGP8SHTXzvEs2lCRw+Oeri1hVkQC
         HBmppRBNLP+85jU+6Prb0ahTKN+wZFA5T912jwD8hLJE1CHl6nSV86KRVapsPkxtpxB9
         MGRWGHhT81tjm6G+Tgrec5vxJtGBtncLmbh9QefCTGC1KWQ0cepAUTejlZYJf08Jxrd5
         7bjth7uO4z8JVkSr11qDSFlldY3tfWAYoNy2aHgNxqvRfWjSnAC2tztXuRGciow1vhK+
         h/syJOQewa9LCZ+u/qNZpH4JTGKfxuTOMRIoW5kB1H3Rx6/a1h7OX2Mhar9Rm7tN7v1z
         nWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687864599; x=1690456599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2K0OuQGxCrdsKt9Q57JYfi5owLHsSbU96G7U8K7Wyc=;
        b=VzescK2zvPYFyApaI5fzssmN8OE1gMSPPX31KE24N7Ex4NOklCMruxjVPUfhTHNmKJ
         I80K3gYevu+qGp1IXHEJ6dPo14aGYd3YJcTOCU5d23fYpPHn1KJatW21lCULVMPhv7m8
         jWYNa5HfmqH2d/GyjCY8MnwLq+nLMycbzw+AOmR8T2WGZHZey3F7YP/CwfDvkbBG5jYo
         d+5iwmVLGlDnVwuQdLslSLW9WIElok3PKTXVjAC3ip9CvbenSNJX+gZvMutPdgrVs3f2
         Y7gMptjK2Pze+sZ218ZKY7Y35Kd4m9ovHAvHMPlQzdOdFdfYNQb8ZOwFIvQ2Z7J2Q7vT
         WngQ==
X-Gm-Message-State: AC+VfDwSrHRAJhQUgFpEncZ2GISs7T/dXSGLKk1dVx0PYsXRx4C1nWRq
        6cWLsaEusw7804S+xlJh+2Q=
X-Google-Smtp-Source: ACHHUZ6mnka0WW9MVoMGh7/o2+bdi8ZgTA17NxscHP0+9UmQ8Asw92nbo6Zj8qGPGWMQpIW9ln/+GA==
X-Received: by 2002:a05:6808:2202:b0:3a1:aa90:d486 with SMTP id bd2-20020a056808220200b003a1aa90d486mr17879039oib.26.1687864598842;
        Tue, 27 Jun 2023 04:16:38 -0700 (PDT)
Received: from localhost.localdomain ([58.240.82.166])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b00262d6ac0140sm5438658pjb.9.2023.06.27.04.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:16:38 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, suagrfillet@gmail.com,
        bjorn@rivosinc.com, jszhang@kernel.org, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, songshuaishuai@tinylab.org
Subject: [PATCH V11 3/5] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
Date:   Tue, 27 Jun 2023 19:16:10 +0800
Message-Id: <20230627111612.761164-4-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230627111612.761164-1-suagrfillet@gmail.com>
References: <20230627111612.761164-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ftrace.h |  8 ++++++++
 arch/riscv/kernel/mcount-dyn.S  | 10 ++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 756d854e6cdd..c3e678450acf 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -145,6 +145,7 @@ config RISCV
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

