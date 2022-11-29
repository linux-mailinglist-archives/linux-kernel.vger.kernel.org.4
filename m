Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CBB63B8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiK2Ddl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiK2DdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:33:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76E22714B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:33:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5622661568
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08F8C43470;
        Tue, 29 Nov 2022 03:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669692794;
        bh=Q4r5Cr1455+nAmA0pA6cVNtfAYv0E4o4IA4S7gjyv7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iL+6eAPGZAdrp5bd4YJJm4y/qkoeRodnB9xt479lkQ9l5rRVTs+xJ/SMenOxueE8i
         U8cx+93fq8faXpWOD6/nMNLwmXjSutYbo8CJtAAR4wGVbLxrPXXo2y40VaHiCzjEp+
         341BnVCNgTd878T06xmIww96gy2FkWHQzHToshXdAncB9ItEMAPs8uKHvbqpY60agX
         wt410YT2vr0jjgzPl76UtUno7o7F5BHNafyDB0mZLqM0L2hq4CiAfdkrAyRpx2gg/a
         YneExp1WylyIotnOApax1/DVh/InyAvPt3BQEOMPUNoeJko0I+uB6pzvghRzEZdXGS
         mG4tk6vZ/zKdw==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        mark.rutland@arm.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V4 6/7] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
Date:   Mon, 28 Nov 2022 22:32:29 -0500
Message-Id: <20221129033230.255947-7-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221129033230.255947-1-guoren@kernel.org>
References: <20221129033230.255947-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Shuai <suagrfillet@gmail.com>

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
 arch/riscv/Kconfig              | 1 +
 arch/riscv/include/asm/ftrace.h | 6 ++++++
 arch/riscv/kernel/mcount-dyn.S  | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 1d0e5838b11b..2828537abfcd 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -278,6 +278,7 @@ config ARCH_RV64I
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 84f856a3286e..4539f10fea56 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -114,6 +114,12 @@ struct ftrace_regs;
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #define ftrace_graph_func ftrace_graph_func
+
+static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+{
+		regs->t1 = addr;
+}
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 466c6ef217b1..fef7c460f991 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -232,6 +232,7 @@ ENDPROC(ftrace_caller)
 
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 ENTRY(ftrace_regs_caller)
+	move	t1, zero
 	SAVE_ABI_REGS 1
 	PREPARE_ARGS
 
@@ -241,7 +242,10 @@ ftrace_regs_call:
 
 
 	RESTORE_ABI_REGS 1
+	bnez	t1,.Ldirect
 	jr t0
+.Ldirect:
+	jr t1
 ENDPROC(ftrace_regs_caller)
 
 ENTRY(ftrace_caller)
-- 
2.36.1

