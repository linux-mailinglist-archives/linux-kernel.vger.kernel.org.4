Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711AE660F39
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 14:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjAGNhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 08:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjAGNgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 08:36:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDCD5D40D
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 05:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EE3FB810B5
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 13:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACBEC433EF;
        Sat,  7 Jan 2023 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673098597;
        bh=AvMi2X/xYkth6GV87Vc1f+NbbW0P4BDWIfEBjJhc75Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4rJd/lgKcHL/vxcIzhnUBGrLJxRDh34hu+Z04xJG4Ke8JmijM7CzrhOp9Jjpgug4
         mz9UobGi3ASNEVsV7yIHgY/0MqXPn+TzevZsY1mQUGQE4qdEKm7GoQTL5EAhN8i14r
         gBRNqi7MedRmhRSZnzg0owjCzNbZG2ecq4aJIFC8AeQd151zkHURHp3iuiHgao1Rbd
         z+8MwFsNe2wQwIdfXvs7zdCGmtQhBB913/VbmcBfDYiKAq6JwHSV7iwYy1VaJu2IsT
         qUlRMTTH97MNVgQvYByfJHOWtN9j/QoWQhiRNd3azlIo/mmUFv/eVU5O46yW5H4P5K
         mAhg84gZQg95Q==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next V6 6/7] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
Date:   Sat,  7 Jan 2023 08:35:48 -0500
Message-Id: <20230107133549.4192639-7-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230107133549.4192639-1-guoren@kernel.org>
References: <20230107133549.4192639-1-guoren@kernel.org>
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
 arch/riscv/include/asm/ftrace.h | 8 ++++++++
 arch/riscv/kernel/mcount-dyn.S  | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ee0d39b26794..307a9f413edd 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -135,6 +135,7 @@ config RISCV
 	select UACCESS_MEMCPY if !MMU
 	select ZONE_DMA32 if 64BIT
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
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
index d7d4d51b4bd7..552f622ef2b6 100644
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

