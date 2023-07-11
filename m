Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257E674EA52
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGKJZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjGKJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:24:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E6619B6;
        Tue, 11 Jul 2023 02:20:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1B6162059E;
        Tue, 11 Jul 2023 09:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689067217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yrG6a18vPr19xyMGpiJuE+vcoBpKkcNTahmnTLig8g=;
        b=rpL5rSN1pJLDNzdiNLUjhLqlFyP+X8UZNy66kSagfNJjHVQQY7SNsS2Ozow9DOtqayqOlL
        9r8hmGgUwgwAlx0L3VkrR80gCQI4yzZS4bioZuNaYrSG2rHzEN6TzRu4NGic6X+dXj6zJp
        1IKBGvW55F6H+TSCK29XOwcokX4JiuE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE14E1390F;
        Tue, 11 Jul 2023 09:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4D11NdAerWSiVwAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Tue, 11 Jul 2023 09:20:16 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mhiramat@kernel.org,
        peterz@infradead.org
Cc:     samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 2/2] x86/retpoline,kprobes: Skip optprobe check for indirect jumps with retpolines and IBT
Date:   Tue, 11 Jul 2023 11:19:52 +0200
Message-Id: <20230711091952.27944-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230711091952.27944-1-petr.pavlu@suse.com>
References: <20230711091952.27944-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kprobes optimization check can_optimize() calls
insn_is_indirect_jump() to detect indirect jump instructions in
a target function. If any is found, creating an optprobe is disallowed
in the function because the jump could be from a jump table and could
potentially land in the middle of the target optprobe.

With retpolines, insn_is_indirect_jump() additionally looks for calls to
indirect thunks which the compiler potentially used to replace original
jumps. This extra check is however unnecessary because jump tables are
disabled when the kernel is built with retpolines. The same is currently
the case with IBT.

Based on this observation, remove the logic to look for calls to
indirect thunks and skip the check for indirect jumps altogether if the
kernel is built with retpolines or IBT. Remove subsequently the symbols
__indirect_thunk_start and __indirect_thunk_end which are no longer
needed.

Dropping this logic indirectly fixes a problem where the range
[__indirect_thunk_start, __indirect_thunk_end] wrongly included also the
return thunk. It caused that machines which used the return thunk as
a mitigation and didn't have it patched by any alternative ended up not
being able to use optprobes in any regular function.

Fixes: 0b53c374b9ef ("x86/retpoline: Use -mfunction-return")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/x86/include/asm/nospec-branch.h |  3 ---
 arch/x86/kernel/kprobes/opt.c        | 40 +++++++++++-----------------
 arch/x86/kernel/vmlinux.lds.S        |  2 --
 tools/perf/util/thread-stack.c       |  4 +--
 4 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 55388c9f7601..c5460be93fa7 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -461,9 +461,6 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_SECCOMP,
 };
 
-extern char __indirect_thunk_start[];
-extern char __indirect_thunk_end[];
-
 static __always_inline
 void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
 {
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 57b0037d0a99..517821b48391 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -226,7 +226,7 @@ static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
 }
 
 /* Check whether insn is indirect jump */
-static int __insn_is_indirect_jump(struct insn *insn)
+static int insn_is_indirect_jump(struct insn *insn)
 {
 	return ((insn->opcode.bytes[0] == 0xff &&
 		(X86_MODRM_REG(insn->modrm.value) & 6) == 4) || /* Jump */
@@ -260,26 +260,6 @@ static int insn_jump_into_range(struct insn *insn, unsigned long start, int len)
 	return (start <= target && target <= start + len);
 }
 
-static int insn_is_indirect_jump(struct insn *insn)
-{
-	int ret = __insn_is_indirect_jump(insn);
-
-#ifdef CONFIG_RETPOLINE
-	/*
-	 * Jump to x86_indirect_thunk_* is treated as an indirect jump.
-	 * Note that even with CONFIG_RETPOLINE=y, the kernel compiled with
-	 * older gcc may use indirect jump. So we add this check instead of
-	 * replace indirect-jump check.
-	 */
-	if (!ret)
-		ret = insn_jump_into_range(insn,
-				(unsigned long)__indirect_thunk_start,
-				(unsigned long)__indirect_thunk_end -
-				(unsigned long)__indirect_thunk_start);
-#endif
-	return ret;
-}
-
 /* Decode whole function to ensure any instructions don't jump into target */
 static int can_optimize(unsigned long paddr)
 {
@@ -334,9 +314,21 @@ static int can_optimize(unsigned long paddr)
 		/* Recover address */
 		insn.kaddr = (void *)addr;
 		insn.next_byte = (void *)(addr + insn.length);
-		/* Check any instructions don't jump into target */
-		if (insn_is_indirect_jump(&insn) ||
-		    insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
+		/*
+		 * Check any instructions don't jump into target, indirectly or
+		 * directly.
+		 *
+		 * The indirect case is present to handle a code with jump
+		 * tables. When the kernel uses retpolines, the check should in
+		 * theory additionally look for jumps to indirect thunks.
+		 * However, the kernel built with retpolines or IBT has jump
+		 * tables disabled so the check can be skipped altogether.
+		 */
+		if (!IS_ENABLED(CONFIG_RETPOLINE) &&
+		    !IS_ENABLED(CONFIG_X86_KERNEL_IBT) &&
+		    insn_is_indirect_jump(&insn))
+			return 0;
+		if (insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
 					 DISP32_SIZE))
 			return 0;
 		addr += insn.length;
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a4cd04c458df..dd5b0a68cf84 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -133,9 +133,7 @@ SECTIONS
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_RETPOLINE
-		__indirect_thunk_start = .;
 		*(.text..__x86.*)
-		__indirect_thunk_end = .;
 #endif
 		STATIC_CALL_TEXT
 
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 374d142e7390..c6a0a27b12c2 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -1038,9 +1038,7 @@ static int thread_stack__trace_end(struct thread_stack *ts,
 
 static bool is_x86_retpoline(const char *name)
 {
-	const char *p = strstr(name, "__x86_indirect_thunk_");
-
-	return p == name || !strcmp(name, "__indirect_thunk_start");
+	return strstr(name, "__x86_indirect_thunk_") == name;
 }
 
 /*
-- 
2.35.3

