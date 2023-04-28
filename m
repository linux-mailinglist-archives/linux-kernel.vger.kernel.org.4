Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8856F14B0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345864AbjD1J4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345892AbjD1JzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:55:18 -0400
Received: from out187-19.us.a.mail.aliyun.com (out187-19.us.a.mail.aliyun.com [47.90.187.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1759FD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:54:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047190;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.STFoGfH_1682675620;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STFoGfH_1682675620)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:41 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Sathvika Vasireddy" <sv@linux.ibm.com>
Subject: [PATCH RFC 34/43] objtool: Adapt indirect call of __fentry__() for PIE support
Date:   Fri, 28 Apr 2023 17:51:14 +0800
Message-Id: <804a7d5a4ef939b767ae540ebbb24a811d99e100.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using PIE with function tracing, the compiler generates a call
through the GOT (call *__fentry__@GOTPCREL). This instruction is an
indirect call (INSN_CALL_DYNAMIC) and wouldn't be collected by
add_call_destinations().  So collect those indirect calls of
__fentry__() individually for PIE support. And replace the 6th byte of
the GOT call by a 1-byte nop so ftrace can handle the previous 5-bytes
as before.

When RETPOLINE is enabled, __fentry__() is still an indirect call, which
generates warnings in objtool. For simplicity, select DYNAMIC_FTRACE to
patch it as NOPs. And regard it as INSN_CALL to omit warnings for jump
table and retpoline checks in ojbtool.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig                |  1 +
 tools/objtool/arch/x86/decode.c | 10 +++++++--
 tools/objtool/check.c           | 39 +++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b753a54e5ea7..5ac5f335855e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2225,6 +2225,7 @@ config X86_PIE
 	def_bool n
 	depends on X86_64
 	select OBJTOOL if HAVE_OBJTOOL
+	select DYNAMIC_FTRACE if FUNCTION_TRACER && RETPOLINE
 
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image (KASLR)"
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 9ef024fd648c..cd9a81002efe 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -747,15 +747,21 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 
 const char *arch_nop_insn(int len)
 {
-	static const char nops[5][5] = {
+	static const char nops[6][6] = {
 		{ BYTES_NOP1 },
 		{ BYTES_NOP2 },
 		{ BYTES_NOP3 },
 		{ BYTES_NOP4 },
 		{ BYTES_NOP5 },
+		/*
+		 * For PIE kernel, use a 5-byte nop
+		 * and 1-byte nop to keep the frace
+		 * hooking algorithm working correct.
+		 */
+		{ BYTES_NOP5, BYTES_NOP1 },
 	};
 
-	if (len < 1 || len > 5) {
+	if (len < 1 || len > 6) {
 		WARN("invalid NOP size: %d\n", len);
 		return NULL;
 	}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d67b80251eec..2456ab931fe5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1785,6 +1785,38 @@ static int add_call_destinations(struct objtool_file *file)
 	return 0;
 }
 
+static int add_indirect_mcount_calls(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct reloc *reloc;
+
+	for_each_insn(file, insn) {
+		if (insn->type != INSN_CALL_DYNAMIC)
+			continue;
+
+		reloc = insn_reloc(file, insn);
+		if (!reloc)
+			continue;
+		if (!reloc->sym->fentry)
+			continue;
+
+		/*
+		 * __fentry__() is an indirect call even in RETPOLINE builiding
+		 * when X86_PIE is enabled, so DYNAMIC_FTRACE is selected. Then
+		 * all indirect calls of __fentry__() would be patched as NOP
+		 * later, so regard it as retpoline safe as a hack here. Also
+		 * regard it as a direct call, otherwise, it would be treat as
+		 * a jump to jump table in insn_jump_table(), because
+		 * _jump_table and _call_dest share the same memory.
+		 */
+		insn->type = INSN_CALL;
+		insn->retpoline_safe = true;
+		add_call_dest(file, insn, reloc->sym, false);
+	}
+
+	return 0;
+}
+
 /*
  * The .alternatives section requires some extra special care over and above
  * other special sections because alternatives are patched in place.
@@ -2668,6 +2700,13 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	/*
+	 * For X86 PIE kernel, __fentry__ call is an indirect call instead
+	 * of direct call.
+	 */
+	if (opts.pie)
+		add_indirect_mcount_calls(file);
+
 	/*
 	 * Must be after add_call_destinations() such that it can override
 	 * dead_end_function() marks.
-- 
2.31.1

