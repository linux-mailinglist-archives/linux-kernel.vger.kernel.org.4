Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C576011D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiJQOza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiJQOyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B6167C99;
        Mon, 17 Oct 2022 07:53:56 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39Q88LsBVtB3Xa/s2IiwmaAGoLlcgMrcTEUyJoqB6hM=;
        b=ZvElvfXDZsY8fWpEwiwXksG77jcCmLPRjIlj0Bcqti3z3Yp+SuggLbtAnKrVadu5f3RBLk
        6ycr8u02XIR1coYrfDp3R48x7SepccNse8+7E7+ID+0fA3INxH5ryVB/HDblifbdl5Sk9k
        1Wapjs1w1EcPhMKpaAeYaalDkrtZrsKgIiNEXHbrdTTnDciC/JccU2BsTKRfxkMm/8bUZ8
        QlZO958iphPBggFU4J0kN8d3KWoBUpwPXhN9vAOj4XcQtWQpB43s9KAnpGlUWXl+Bfn5Zp
        6QJaJ81TYG18dnpMjjzQNHKhuVGGtNcrFX/wMnhSrc98NqyhXhU8uio2JCSXrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39Q88LsBVtB3Xa/s2IiwmaAGoLlcgMrcTEUyJoqB6hM=;
        b=GK9pPGtdbOY63Ar3DDbxbccNRxhh0ncaFaWcLLSFvmChsIOL/30NGLmFzVDC97J1H0rja/
        Vv7BJlLoOY5/oPCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/callthunks: Add call patching for call depth tracking
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111147.470877038@infradead.org>
References: <20220915111147.470877038@infradead.org>
MIME-Version: 1.0
Message-ID: <166601842481.401.15757919296873015898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e81dc127ef69887c72735a3e3868930e2bf313ed
Gitweb:        https://git.kernel.org/tip/e81dc127ef69887c72735a3e3868930e2bf313ed
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:13 +02:00

x86/callthunks: Add call patching for call depth tracking

Mitigating the Intel SKL RSB underflow issue in software requires to
track the call depth. That is every CALL and every RET need to be
intercepted and additional code injected.

The existing retbleed mitigations already include means of redirecting
RET to __x86_return_thunk; this can be re-purposed and RET can be
redirected to another function doing RET accounting.

CALL accounting will use the function padding introduced in prior
patches. For each CALL instruction, the destination symbol's padding
is rewritten to do the accounting and the CALL instruction is adjusted
to call into the padding.

This ensures only affected CPUs pay the overhead of this accounting.
Unaffected CPUs will leave the padding unused and have their 'JMP
__x86_return_thunk' replaced with an actual 'RET' instruction.

Objtool has been modified to supply a .call_sites section that lists
all the 'CALL' instructions. Additionally the paravirt instruction
sites are iterated since they will have been patched from an indirect
call to direct calls (or direct instructions in which case it'll be
ignored).

Module handling and the actual thunk code for SKL will be added in
subsequent steps.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111147.470877038@infradead.org
---
 arch/x86/Kconfig                     |  12 +-
 arch/x86/include/asm/alternative.h   |  12 +-
 arch/x86/kernel/Makefile             |   2 +-
 arch/x86/kernel/alternative.c        |   6 +-
 arch/x86/kernel/callthunks.c         | 251 ++++++++++++++++++++++++++-
 arch/x86/kernel/head_64.S            |   1 +-
 arch/x86/kernel/relocate_kernel_64.S |   5 +-
 arch/x86/kernel/vmlinux.lds.S        |   8 +-
 8 files changed, 287 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/kernel/callthunks.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6ae7fa4..a1dae9d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2541,6 +2541,18 @@ config CALL_DEPTH_TRACKING
 	  is unused. On affected SKL systems this results in a significant
 	  performance gain over the IBRS mitigation.
 
+config CALL_THUNKS_DEBUG
+	bool "Enable call thunks and call depth tracking debugging"
+	depends on CALL_DEPTH_TRACKING
+	select FUNCTION_ALIGNMENT_32B
+	default n
+	help
+	  Enable call/ret counters for imbalance detection and build in
+	  a noisy dmesg about callthunks generation and call patching for
+	  trouble shooting. The debug prints need to be enabled on the
+	  kernel command line with 'debug-callthunks'.
+	  Only enable this, when you are debugging call thunks as this
+	  creates a noticable runtime overhead. If unsure say N.
 
 config CPU_IBPB_ENTRY
 	bool "Enable IBPB on kernel entry"
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 9542c58..6b7bbd0 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -80,6 +80,18 @@ extern void apply_returns(s32 *start, s32 *end);
 extern void apply_ibt_endbr(s32 *start, s32 *end);
 
 struct module;
+struct paravirt_patch_site;
+
+struct callthunk_sites {
+	s32				*call_start, *call_end;
+	struct paravirt_patch_site	*pv_start, *pv_end;
+};
+
+#ifdef CONFIG_CALL_THUNKS
+extern void callthunks_patch_builtin_calls(void);
+#else
+static __always_inline void callthunks_patch_builtin_calls(void) {}
+#endif
 
 #ifdef CONFIG_SMP
 extern void alternatives_smp_module_add(struct module *mod, char *name,
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f901658..c2739a5 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -143,6 +143,8 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
 obj-$(CONFIG_CFI_CLANG)			+= cfi.o
 
+obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index fad3c0e..963872d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -947,6 +947,12 @@ void __init alternative_instructions(void)
 	 */
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
+	/*
+	 * Now all calls are established. Apply the call thunks if
+	 * required.
+	 */
+	callthunks_patch_builtin_calls();
+
 	apply_ibt_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end);
 
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
new file mode 100644
index 0000000..e5275d6
--- /dev/null
+++ b/arch/x86/kernel/callthunks.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "callthunks: " fmt
+
+#include <linux/kallsyms.h>
+#include <linux/memory.h>
+#include <linux/moduleloader.h>
+
+#include <asm/alternative.h>
+#include <asm/cpu.h>
+#include <asm/ftrace.h>
+#include <asm/insn.h>
+#include <asm/kexec.h>
+#include <asm/nospec-branch.h>
+#include <asm/paravirt.h>
+#include <asm/sections.h>
+#include <asm/switch_to.h>
+#include <asm/sync_core.h>
+#include <asm/text-patching.h>
+#include <asm/xen/hypercall.h>
+
+static int __initdata_or_module debug_callthunks;
+
+#define prdbg(fmt, args...)					\
+do {								\
+	if (debug_callthunks)					\
+		printk(KERN_DEBUG pr_fmt(fmt), ##args);		\
+} while(0)
+
+static int __init debug_thunks(char *str)
+{
+	debug_callthunks = 1;
+	return 1;
+}
+__setup("debug-callthunks", debug_thunks);
+
+extern s32 __call_sites[], __call_sites_end[];
+
+struct thunk_desc {
+	void		*template;
+	unsigned int	template_size;
+};
+
+struct core_text {
+	unsigned long	base;
+	unsigned long	end;
+	const char	*name;
+};
+
+static bool thunks_initialized __ro_after_init;
+
+static const struct core_text builtin_coretext = {
+	.base = (unsigned long)_text,
+	.end  = (unsigned long)_etext,
+	.name = "builtin",
+};
+
+static struct thunk_desc callthunk_desc __ro_after_init;
+
+extern void error_entry(void);
+extern void xen_error_entry(void);
+extern void paranoid_entry(void);
+
+static inline bool within_coretext(const struct core_text *ct, void *addr)
+{
+	unsigned long p = (unsigned long)addr;
+
+	return ct->base <= p && p < ct->end;
+}
+
+static inline bool within_module_coretext(void *addr)
+{
+	bool ret = false;
+
+#ifdef CONFIG_MODULES
+	struct module *mod;
+
+	preempt_disable();
+	mod = __module_address((unsigned long)addr);
+	if (mod && within_module_core((unsigned long)addr, mod))
+		ret = true;
+	preempt_enable();
+#endif
+	return ret;
+}
+
+static bool is_coretext(const struct core_text *ct, void *addr)
+{
+	if (ct && within_coretext(ct, addr))
+		return true;
+	if (within_coretext(&builtin_coretext, addr))
+		return true;
+	return within_module_coretext(addr);
+}
+
+static __init_or_module bool skip_addr(void *dest)
+{
+	if (dest == error_entry)
+		return true;
+	if (dest == paranoid_entry)
+		return true;
+	if (dest == xen_error_entry)
+		return true;
+	/* Does FILL_RSB... */
+	if (dest == __switch_to_asm)
+		return true;
+	/* Accounts directly */
+	if (dest == ret_from_fork)
+		return true;
+#ifdef CONFIG_HOTPLUG_CPU
+	if (dest == start_cpu0)
+		return true;
+#endif
+#ifdef CONFIG_FUNCTION_TRACER
+	if (dest == __fentry__)
+		return true;
+#endif
+#ifdef CONFIG_KEXEC_CORE
+	if (dest >= (void *)relocate_kernel &&
+	    dest < (void*)relocate_kernel + KEXEC_CONTROL_CODE_MAX_SIZE)
+		return true;
+#endif
+#ifdef CONFIG_XEN
+	if (dest >= (void *)hypercall_page &&
+	    dest < (void*)hypercall_page + PAGE_SIZE)
+		return true;
+#endif
+	return false;
+}
+
+static __init_or_module void *call_get_dest(void *addr)
+{
+	struct insn insn;
+	void *dest;
+	int ret;
+
+	ret = insn_decode_kernel(&insn, addr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* Patched out call? */
+	if (insn.opcode.bytes[0] != CALL_INSN_OPCODE)
+		return NULL;
+
+	dest = addr + insn.length + insn.immediate.value;
+	if (skip_addr(dest))
+		return NULL;
+	return dest;
+}
+
+static const u8 nops[] = {
+	0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90,
+	0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90,
+	0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90,
+	0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90,
+};
+
+static __init_or_module void *patch_dest(void *dest, bool direct)
+{
+	unsigned int tsize = callthunk_desc.template_size;
+	u8 *pad = dest - tsize;
+
+	/* Already patched? */
+	if (!bcmp(pad, callthunk_desc.template, tsize))
+		return pad;
+
+	/* Ensure there are nops */
+	if (bcmp(pad, nops, tsize)) {
+		pr_warn_once("Invalid padding area for %pS\n", dest);
+		return NULL;
+	}
+
+	if (direct)
+		memcpy(pad, callthunk_desc.template, tsize);
+	else
+		text_poke_copy_locked(pad, callthunk_desc.template, tsize, true);
+	return pad;
+}
+
+static __init_or_module void patch_call(void *addr, const struct core_text *ct)
+{
+	void *pad, *dest;
+	u8 bytes[8];
+
+	if (!within_coretext(ct, addr))
+		return;
+
+	dest = call_get_dest(addr);
+	if (!dest || WARN_ON_ONCE(IS_ERR(dest)))
+		return;
+
+	if (!is_coretext(ct, dest))
+		return;
+
+	pad = patch_dest(dest, within_coretext(ct, dest));
+	if (!pad)
+		return;
+
+	prdbg("Patch call at: %pS %px to %pS %px -> %px \n", addr, addr,
+		dest, dest, pad);
+	__text_gen_insn(bytes, CALL_INSN_OPCODE, addr, pad, CALL_INSN_SIZE);
+	text_poke_early(addr, bytes, CALL_INSN_SIZE);
+}
+
+static __init_or_module void
+patch_call_sites(s32 *start, s32 *end, const struct core_text *ct)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++)
+		patch_call((void *)s + *s, ct);
+}
+
+static __init_or_module void
+patch_paravirt_call_sites(struct paravirt_patch_site *start,
+			  struct paravirt_patch_site *end,
+			  const struct core_text *ct)
+{
+	struct paravirt_patch_site *p;
+
+	for (p = start; p < end; p++)
+		patch_call(p->instr, ct);
+}
+
+static __init_or_module void
+callthunks_setup(struct callthunk_sites *cs, const struct core_text *ct)
+{
+	prdbg("Patching call sites %s\n", ct->name);
+	patch_call_sites(cs->call_start, cs->call_end, ct);
+	patch_paravirt_call_sites(cs->pv_start, cs->pv_end, ct);
+	prdbg("Patching call sites done%s\n", ct->name);
+}
+
+void __init callthunks_patch_builtin_calls(void)
+{
+	struct callthunk_sites cs = {
+		.call_start	= __call_sites,
+		.call_end	= __call_sites_end,
+		.pv_start	= __parainstructions,
+		.pv_end		= __parainstructions_end
+	};
+
+	if (!cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
+		return;
+
+	pr_info("Setting up call depth tracking\n");
+	mutex_lock(&text_mutex);
+	callthunks_setup(&cs, &builtin_coretext);
+	thunks_initialized = true;
+	mutex_unlock(&text_mutex);
+}
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d860d43..222efd4 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -370,6 +370,7 @@ SYM_CODE_END(secondary_startup_64)
  * start_secondary() via .Ljump_to_C_code.
  */
 SYM_CODE_START(start_cpu0)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_EMPTY
 	movq	initial_stack(%rip), %rsp
 	jmp	.Ljump_to_C_code
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 4809c0d..4a73351 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -41,6 +41,7 @@
 	.text
 	.align PAGE_SIZE
 	.code64
+SYM_CODE_START_NOALIGN(relocate_range)
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR
@@ -312,5 +313,5 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	int3
 SYM_CODE_END(swap_pages)
 
-	.globl kexec_control_code_size
-.set kexec_control_code_size, . - relocate_kernel
+	.skip KEXEC_CONTROL_CODE_MAX_SIZE - (. - relocate_kernel), 0xcc
+SYM_CODE_END(relocate_range);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index b69df9e..49f3f86 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -501,11 +501,3 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #endif /* CONFIG_X86_64 */
-
-#ifdef CONFIG_KEXEC_CORE
-#include <asm/kexec.h>
-
-. = ASSERT(kexec_control_code_size <= KEXEC_CONTROL_CODE_MAX_SIZE,
-           "kexec control code size is too big");
-#endif
-
