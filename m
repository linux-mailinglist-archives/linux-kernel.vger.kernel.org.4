Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD03A6F14C7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345531AbjD1J6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345863AbjD1J5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:57:44 -0400
Received: from out187-17.us.a.mail.aliyun.com (out187-17.us.a.mail.aliyun.com [47.90.187.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4077176BC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:56:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.STCEPcc_1682675575;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STCEPcc_1682675575)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:52:56 +0800
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
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Sami Tolvanen" <samitolvanen@google.com>
Subject: [PATCH RFC 20/43] x86/percpu: Adapt percpu references relocation for PIE support
Date:   Fri, 28 Apr 2023 17:51:00 +0800
Message-Id: <62d7e9e73467b711351a84ebce99372d3dccaa73.1682673543.git.houwenlong.hwl@antgroup.com>
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

The original design of percpu references relocation only handles
relative references and ignores absolute references. Because percpu
variable had already been relative based on segment. And .percpu ELF
section has a virtual address of zero and absolute references can be
kept if kaslr is enabled. As for a little relative references, they
needs to be relocated by negative offset.

However, it is not compatible with PIE, because almost all percpu
references would be RIP-relative. But RIP-relative addressing could only
support -2G ~ +2G. In order to move kernel address below top 2G, percpu
relative references wouldn't be relocated, instead, percpu base could be
adjusted. As for absolute references, they would be relocated like
normal variable. After that, percpu references in .altinstr_replacement
section couldn't work right, because no fixups are applied for percpu
references in apply_alternatives(). However, it could be caught by
objtool.  Currently, only call depth tracking uses it, so disable it if
X86_PIE is enabled.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig          |  2 +-
 arch/x86/kernel/head_64.S | 10 ++++++++++
 arch/x86/tools/relocs.c   | 17 ++++++++++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b26941ef50ee..715f0734d065 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2635,7 +2635,7 @@ config CPU_UNRET_ENTRY
 
 config CALL_DEPTH_TRACKING
 	bool "Mitigate RSB underflow with call depth tracking"
-	depends on CPU_SUP_INTEL && HAVE_CALL_THUNKS
+	depends on CPU_SUP_INTEL && HAVE_CALL_THUNKS && !X86_PIE
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 	select CALL_THUNKS
 	default y
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 1eed50b7d1ac..94c5defec8cc 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -72,6 +72,11 @@ SYM_CODE_START_NOALIGN(startup_64)
 	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
 #elif defined(CONFIG_SMP)
 	movabs	$__per_cpu_load, %rdx
+#ifdef CONFIG_X86_PIE
+	movabs	$__per_cpu_start, %rax
+	subq	%rax, %rdx
+	movq	%rdx, __per_cpu_offset(%rip)
+#endif
 #else
 	xorl	%edx, %edx
 #endif
@@ -79,6 +84,11 @@ SYM_CODE_START_NOALIGN(startup_64)
 	shrq	$32,  %rdx
 	wrmsr
 
+#if defined(CONFIG_X86_PIE) && defined(CONFIG_SMP)
+	movq	__per_cpu_offset(%rip), %rdx
+	movq	%rdx, PER_CPU_VAR(this_cpu_off)
+#endif
+
 	pushq	%rsi
 	call	startup_64_setup_env
 	popq	%rsi
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 2925074b9a58..038e9c12fad3 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -848,6 +848,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 
 	case R_X86_64_PC32:
 	case R_X86_64_PLT32:
+#ifndef CONFIG_X86_PIE
 		/*
 		 * PC relative relocations don't need to be adjusted unless
 		 * referencing a percpu symbol.
@@ -856,6 +857,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		 */
 		if (is_percpu_sym(sym, symname))
 			add_reloc(&relocs32neg, offset);
+#endif
 		break;
 
 	case R_X86_64_PC64:
@@ -871,10 +873,18 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 	case R_X86_64_32S:
 	case R_X86_64_64:
 		/*
-		 * References to the percpu area don't need to be adjusted.
+		 * References to the percpu area don't need to be adjusted when
+		 * CONFIG_X86_PIE is not enabled.
 		 */
-		if (is_percpu_sym(sym, symname))
+		if (is_percpu_sym(sym, symname)) {
+#if CONFIG_X86_PIE
+			if (r_type != R_X86_64_64)
+				die("Invalid absolute reference against per-CPU symbol %s\n",
+				    symname);
+			add_reloc(&relocs64, offset);
+#endif
 			break;
+		}
 
 		if (shn_abs) {
 			/*
@@ -1044,7 +1054,8 @@ static int cmp_relocs(const void *va, const void *vb)
 
 static void sort_relocs(struct relocs *r)
 {
-	qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
+	if (r->count)
+		qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
 }
 
 static int write32(uint32_t v, FILE *f)
-- 
2.31.1

