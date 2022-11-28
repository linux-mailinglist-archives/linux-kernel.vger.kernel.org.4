Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370E563A5C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiK1KM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiK1KMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:12:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB3CE96
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:12:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17259B80CB4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60462C433D7;
        Mon, 28 Nov 2022 10:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669630341;
        bh=OR1E22SfIW28jaKNXJ/IaUulMe996ymxezMSEdVKYYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svOz3bsmumYNfOUkFxQf/UNebxKeByl7zQCW8z+bWGmjHi7pbAKwaQmz83I9oTz5w
         dFzgZfkrSfRYRGOiOWMfH4/rwcHKVgt0WYWszRbYzbEmCxjewVYj10mF86mGvAkVrt
         ik4WNd1kLRvqQAIvg3AuuMBEMHGdr43GyrPc/gUUhtmq1LXgn5VH6FuzpL1XRngr+6
         4o29xwf3MpRIrHqDfsaoxpiuqr+xz3OuQj6aIxnAnWxR2SJW2iPQXYb5Mm6MUH7Nz+
         hdMB9ms26bTzJVZyixg9NYLLOQ07WNWZYl8Mi0y43dmr8n/JRgGNsSNCsHGxQT/kGi
         GyhzJhTtpmLjw==
From:   guoren@kernel.org
To:     suagrfillet@gmail.com, guoren@kernel.org
Cc:     aou@eecs.berkeley.edu, bp@suse.de, jolsa@redhat.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        mhiramat@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        peterz@infradead.org, rostedt@goodmis.org
Subject: [PATCH 1/2] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
Date:   Mon, 28 Nov 2022 05:12:00 -0500
Message-Id: <20221128101201.4144527-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAAYs2=hNAwDk7=F077ityNykZJCCvGVyXsxRzZO3s7rKwOPpUg@mail.gmail.com>
References: <CAAYs2=hNAwDk7=F077ityNykZJCCvGVyXsxRzZO3s7rKwOPpUg@mail.gmail.com>
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
Co-developed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 Remove modification of mcount-dyn.S. (Guo Ren)
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ftrace.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

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
index 84f856a3286e..d2c159cdfa5c 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -114,6 +114,32 @@ struct ftrace_regs;
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #define ftrace_graph_func ftrace_graph_func
+
+static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+{
+		/*
+		 * Backup origin detour target (t0) in t1, and set t0 with addr.
+		 *
+		 * Here is the sample code for riscv direct_caller:
+		 *
+		 * addi sp,sp,-16
+		 * move t0,t1
+		 * ^^^^^^^^^^
+		 * sd   t0,0(sp)
+		 * sd   ra,8(sp)
+		 * call my_direct_func1
+		 * ld   t0,0(sp)
+		 * ld   ra,8(sp)
+		 * addi sp,sp,16
+		 * jr t0
+		 *
+		 * (Set t0 with t1 for continuous detour, because t1 contains origin detour
+		 *  target)
+		 */
+		regs->t1 = regs->t0;
+		regs->t0 = addr;
+}
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 #endif /* __ASSEMBLY__ */
-- 
2.36.1

