Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8EA64C761
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 11:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiLNKq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 05:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiLNKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:46:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE9516487
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 02:46:51 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A4871EC0742;
        Wed, 14 Dec 2022 11:46:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671014809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=LFWDrVFZnKasPlprZwsJRjXhikh9JEMjCvCB6DWE6Gw=;
        b=ah4hWAw+zwTllTgv68seL6dytmzLdYanHwWDcM82eUL8yjyuiQlAOcdRAOr6PMvcXDUzkZ
        PulFORltkm2SUF5O16T+a1xgmI1UNTwCflSg/UhO4o9Pzvhok7wrUaGNynKdhFwnAb4g1d
        6n+12txVDgV08Torl5FbRXiX8kn3RYg=
Date:   Wed, 14 Dec 2022 11:46:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/core for v6.2
Message-ID: <Y5mplIDz1VX7DMhG@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

as always, we're saving the best for last. This is a pretty big branch
with changes touching stuff all over the place so I fugured I should
send it last.

And because it touches stuff all over the place, it causes a bunch of
merge conflicts against your current state v6.1-9941-ge2ca6ba6ba01.
Therefore, I'm adding at the end of this mail how I've resolved the
merge conflict locally, in case you'd like to compare notes.

Anyway, please pull the huge pile of changes called x86/core for 6.2.

Thx.

---

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v6.2

for you to fetch changes up to f1a033cc6b9eb6d80322008422df3c87aa5d47a0:

  x86/paravirt: Use common macro for creating simple asm paravirt functions (2022-11-24 13:56:44 +0100)

----------------------------------------------------------------
- Add the call depth tracking mitigation for Retbleed which has
been long in the making. It is a lighterweight software-only fix for
Skylake-based cores where enabling IBRS is a big hammer and causes a
significant performance impact.

What it basically does is, it aligns all kernel functions to 16 bytes
boundary and adds a 16-byte padding before the function, objtool
collects all functions' locations and when the mitigation gets applied,
it patches a call accounting thunk which is used to track the call depth
of the stack at any time.

When that call depth reaches a magical, microarchitecture-specific value
for the Return Stack Buffer, the code stuffs that RSB and avoids its
underflow which could otherwise lead to the Intel variant of Retbleed.

This software-only solution brings a lot of the lost performance back,
as benchmarks suggest:

  https://lore.kernel.org/all/20220915111039.092790446@infradead.org/

That page above also contains a lot more detailed explanation of the
whole mechanism

- Implement a new control flow integrity scheme called FineIBT which is
based on the software kCFI implementation and uses hardware IBT support
where present to annotate and track indirect branches using a hash to
validate them

- Other misc fixes and cleanups

----------------------------------------------------------------
Borislav Petkov (1):
      x86/paravirt: Fix a !PARAVIRT build warning

Dan Carpenter (1):
      x86/retpoline: Fix crash printing warning

Ingo Molnar (3):
      Merge branch 'x86/urgent' into x86/core, to resolve conflict
      x86/cpufeatures: Move X86_FEATURE_CALL_DEPTH from bit 18 to bit 19 of word 11, to leave space for WIP X86_FEATURE_SGX_EDECCSSA bit
      Merge tag 'v6.1-rc6' into x86/core, to resolve conflicts

Juergen Gross (1):
      x86/paravirt: Use common macro for creating simple asm paravirt functions

Kees Cook (2):
      x86/Kconfig: Enable kernel IBT by default
      x86/paravirt: Remove clobber bitmask from .parainstructions

Peter Zijlstra (33):
      arch: Introduce CONFIG_FUNCTION_ALIGNMENT
      x86/error_inject: Align function properly
      objtool: Allow !PC relative relocations
      objtool: Track init section
      objtool: Add .call_sites section
      objtool: Add --hacks=skylake
      objtool: Fix find_{symbol,func}_containing()
      objtool: Allow symbol range comparisons for IBT/ENDBR
      objtool: Rework instruction -> symbol mapping
      objtool: Allow STT_NOTYPE -> STT_FUNC+0 sibling-calls
      x86/entry: Make sync_regs() invocation a tail call
      x86/returnthunk: Allow different return thunks
      x86/asm: Provide ALTERNATIVE_3
      x86/retpoline: Add SKL retthunk retpolines
      static_call: Add call depth tracking support
      kallsyms: Take callthunks into account
      x86/orc: Make it callthunk aware
      x86/ftrace: Remove ftrace_epilogue()
      x86/ftrace: Rebalance RSB
      x86/ftrace: Make it call depth tracking aware
      x86: Unconfuse CONFIG_ and X86_FEATURE_ namespaces
      kallsyms: Revert "Take callthunks into account"
      objtool: Slice up elf_create_section_symbol()
      objtool: Avoid O(bloody terrible) behaviour -- an ode to libelf
      objtool: Add option to generate prefix symbols
      x86: Add prefix symbols for function padding
      objtool: Add --cfi to generate the .cfi_sites section
      x86/ibt: Implement FineIBT
      x86/cfi: Boot time selection of CFI scheme
      x86/cfi: Add boot time hash randomization
      objtool: Optimize elf_dirty_reloc_sym()
      objtool: Fix weak hole vs prefix symbol
      x86,pm: Force out-of-line memcpy()

Peter Zijlstra (Intel) (2):
      x86: Fixup asm-offsets duplicate
      x86/bugs: Add retbleed=force

Sean Christopherson (1):
      x86/debug: Include percpu.h in debugreg.h to get DECLARE_PER_CPU() et al

Thomas Gleixner (38):
      x86/cpu: Remove segment load from switch_to_new_gdt()
      x86/cpu: Get rid of redundant switch_to_new_gdt() invocations
      x86/cpu: Re-enable stackprotector
      x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()
      x86/vdso: Ensure all kernel code is seen by objtool
      x86: Sanitize linker script
      x86/asm: Differentiate between code and function alignment
      x86/paravirt: Properly align PV functions
      x86/entry: Align SYM_CODE_START() variants
      crypto: x86/camellia: Remove redundant alignments
      crypto: x86/cast5: Remove redundant alignments
      crypto: x86/crct10dif-pcl: Remove redundant alignments
      crypto: x86/serpent: Remove redundant alignments
      crypto: x86/sha1: Remove custom alignments
      crypto: x86/sha256: Remove custom alignments
      crypto: x86/sm[34]: Remove redundant alignments
      crypto: twofish: Remove redundant alignments
      crypto: x86/poly1305: Remove custom function alignment
      x86: Put hot per CPU variables into a struct
      x86/percpu: Move preempt_count next to current_task
      x86/percpu: Move cpu_number next to current_task
      x86/percpu: Move current_top_of_stack next to current_task
      x86/percpu: Move irq_stack variables next to current_task
      x86/softirq: Move softirq pending next to current task
      x86/putuser: Provide room for padding
      x86/Kconfig: Add CONFIG_CALL_THUNKS
      x86/Kconfig: Introduce function padding
      x86/retbleed: Add X86_FEATURE_CALL_DEPTH
      x86/alternatives: Provide text_poke_copy_locked()
      x86/entry: Make some entry symbols global
      x86/paravirt: Make struct paravirt_call_site unconditionally available
      x86/callthunks: Add call patching for call depth tracking
      x86/modules: Add call patching
      x86/retbleed: Add SKL return thunk
      x86/retbleed: Add SKL call thunk
      x86/calldepth: Add ret/call counting for debug
      x86/bpf: Emit call depth accounting if required
      x86/retbleed: Add call depth tracking mitigation

 Makefile                                      |   4 +-
 arch/Kconfig                                  |  24 ++
 arch/ia64/Kconfig                             |   1 +
 arch/ia64/Makefile                            |   2 +-
 arch/um/kernel/um_arch.c                      |   5 +
 arch/x86/Kconfig                              |  75 +++-
 arch/x86/Makefile                             |   6 +
 arch/x86/boot/compressed/head_64.S            |   8 +
 arch/x86/crypto/camellia-aesni-avx-asm_64.S   |   2 -
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S  |   4 -
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S     |   2 -
 arch/x86/crypto/crct10dif-pcl-asm_64.S        |   1 -
 arch/x86/crypto/poly1305-x86_64-cryptogams.pl |   1 -
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S   |   2 -
 arch/x86/crypto/serpent-avx2-asm_64.S         |   2 -
 arch/x86/crypto/sha1_ni_asm.S                 |   1 -
 arch/x86/crypto/sha256-avx-asm.S              |   1 -
 arch/x86/crypto/sha256-avx2-asm.S             |   1 -
 arch/x86/crypto/sha256-ssse3-asm.S            |   1 -
 arch/x86/crypto/sha256_ni_asm.S               |   1 -
 arch/x86/crypto/sm3-avx-asm_64.S              |   1 -
 arch/x86/crypto/sm4-aesni-avx-asm_64.S        |   7 -
 arch/x86/crypto/sm4-aesni-avx2-asm_64.S       |   6 -
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S   |   2 -
 arch/x86/entry/entry_32.S                     |   4 +-
 arch/x86/entry/entry_64.S                     |  50 +--
 arch/x86/entry/entry_64_compat.S              |   7 +-
 arch/x86/entry/thunk_64.S                     |   4 +-
 arch/x86/entry/vdso/Makefile                  |  14 +-
 arch/x86/include/asm/alternative.h            |  68 +++-
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/current.h                |  32 +-
 arch/x86/include/asm/debugreg.h               |   2 +-
 arch/x86/include/asm/disabled-features.h      |   9 +-
 arch/x86/include/asm/hardirq.h                |   3 +-
 arch/x86/include/asm/irq_stack.h              |  12 +-
 arch/x86/include/asm/linkage.h                |  63 ++-
 arch/x86/include/asm/nospec-branch.h          | 176 ++++++++-
 arch/x86/include/asm/paravirt.h               |  17 +-
 arch/x86/include/asm/paravirt_types.h         |  89 ++---
 arch/x86/include/asm/preempt.h                |  27 +-
 arch/x86/include/asm/processor.h              |  11 +-
 arch/x86/include/asm/qspinlock_paravirt.h     |  47 +--
 arch/x86/include/asm/smp.h                    |  12 +-
 arch/x86/include/asm/text-patching.h          |   1 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/alternative.c                 | 529 ++++++++++++++++++++++++--
 arch/x86/kernel/asm-offsets.c                 |   5 +
 arch/x86/kernel/asm-offsets_64.c              |   2 +-
 arch/x86/kernel/callthunks.c                  | 388 +++++++++++++++++++
 arch/x86/kernel/cpu/Makefile                  |   3 -
 arch/x86/kernel/cpu/bugs.c                    |  34 +-
 arch/x86/kernel/cpu/common.c                  |  97 +++--
 arch/x86/kernel/dumpstack_32.c                |   4 +-
 arch/x86/kernel/dumpstack_64.c                |   2 +-
 arch/x86/kernel/ftrace.c                      |  20 +-
 arch/x86/kernel/ftrace_64.S                   |  37 +-
 arch/x86/kernel/head_64.S                     |   1 +
 arch/x86/kernel/irq_32.c                      |  13 +-
 arch/x86/kernel/irq_64.c                      |   6 +-
 arch/x86/kernel/kprobes/core.c                |   1 -
 arch/x86/kernel/kvm.c                         |  18 +-
 arch/x86/kernel/module.c                      |  47 ++-
 arch/x86/kernel/paravirt.c                    |  21 +-
 arch/x86/kernel/process_32.c                  |   6 +-
 arch/x86/kernel/process_64.c                  |   6 +-
 arch/x86/kernel/relocate_kernel_64.S          |   5 +-
 arch/x86/kernel/setup_percpu.c                |   7 +-
 arch/x86/kernel/smpboot.c                     |  10 +-
 arch/x86/kernel/static_call.c                 |   3 +-
 arch/x86/kernel/traps.c                       |   4 +-
 arch/x86/kernel/unwind_orc.c                  |  21 +-
 arch/x86/kernel/vmlinux.lds.S                 |  37 +-
 arch/x86/kvm/svm/vmenter.S                    |   1 +
 arch/x86/lib/error-inject.c                   |   1 +
 arch/x86/lib/putuser.S                        |  62 ++-
 arch/x86/lib/retpoline.S                      | 107 +++++-
 arch/x86/net/bpf_jit_comp.c                   |  45 ++-
 arch/x86/power/hibernate.c                    |   2 +-
 arch/x86/xen/enlighten_pv.c                   |   2 +-
 include/asm-generic/vmlinux.lds.h             |   4 +-
 include/linux/linkage.h                       |   4 +-
 include/linux/static_call.h                   |   2 +
 kernel/static_call_inline.c                   |  23 +-
 kernel/trace/trace_selftest.c                 |   9 +-
 lib/Kconfig.debug                             |   1 +
 samples/ftrace/ftrace-direct-modify.c         |   3 +
 samples/ftrace/ftrace-direct-multi-modify.c   |   3 +
 samples/ftrace/ftrace-direct-multi.c          |   2 +
 samples/ftrace/ftrace-direct-too.c            |   2 +
 samples/ftrace/ftrace-direct.c                |   2 +
 scripts/Makefile.lib                          |   3 +
 tools/include/linux/interval_tree_generic.h   | 187 +++++++++
 tools/objtool/arch/x86/decode.c               |  24 ++
 tools/objtool/builtin-check.c                 |   9 +-
 tools/objtool/check.c                         | 391 +++++++++++++++----
 tools/objtool/elf.c                           | 296 +++++++++-----
 tools/objtool/include/objtool/arch.h          |   2 +
 tools/objtool/include/objtool/builtin.h       |   3 +
 tools/objtool/include/objtool/check.h         |  12 +-
 tools/objtool/include/objtool/elf.h           |   9 +-
 tools/objtool/include/objtool/objtool.h       |   1 +
 tools/objtool/objtool.c                       |   1 +
 103 files changed, 2715 insertions(+), 637 deletions(-)
 create mode 100644 arch/x86/kernel/callthunks.c
 create mode 100644 tools/include/linux/interval_tree_generic.h

---

Merge conflict resolve

---

commit 9aba79ae860a5a72a266c880f0ef49a933d18a72
Merge: e2ca6ba6ba01 f1a033cc6b9e
Author: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Wed Dec 14 09:53:46 2022 +0100

    Merge remote-tracking branch 'tip/x86/core' into test-merge
    
     Conflicts:
            arch/x86/include/asm/cpufeatures.h
            arch/x86/include/asm/paravirt_types.h
            arch/x86/net/bpf_jit_comp.c
    
    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

diff --cc arch/x86/entry/entry_64_compat.S
index 59b93901660d,bc45ea7d08ee..70150298f8bd
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@@ -58,10 -58,10 +58,10 @@@ SYM_CODE_START(entry_SYSENTER_compat
  	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
  	popq	%rax
  
- 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+ 	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
  
  	/* Construct struct pt_regs on stack */
 -	pushq	$__USER32_DS		/* pt_regs->ss */
 +	pushq	$__USER_DS		/* pt_regs->ss */
  	pushq	$0			/* pt_regs->sp = 0 (placeholder) */
  
  	/*
diff --cc arch/x86/include/asm/cpufeatures.h
index c9f4730bb113,864c9b0dda68..2dd2691b5ee1
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@@ -304,10 -304,8 +304,9 @@@
  #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
  #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
 -						   /* Hole left for X86_FEATURE_SGX_EDECCSSA */
 +#define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf function */
- 
- 
+ #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
 +#define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
  
  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --cc arch/x86/include/asm/disabled-features.h
index c862552d7d6d,bbb03b25263e..c44b56f7ffba
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@@ -104,10 -104,11 +110,11 @@@
  #define DISABLED_MASK5	0
  #define DISABLED_MASK6	0
  #define DISABLED_MASK7	(DISABLE_PTI)
 -#define DISABLED_MASK8	(DISABLE_TDX_GUEST)
 +#define DISABLED_MASK8	(DISABLE_XENPV|DISABLE_TDX_GUEST)
  #define DISABLED_MASK9	(DISABLE_SGX)
  #define DISABLED_MASK10	0
- #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET)
+ #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
+ 			 DISABLE_CALL_DEPTH_TRACKING)
  #define DISABLED_MASK12	0
  #define DISABLED_MASK13	0
  #define DISABLED_MASK14	0
diff --cc arch/x86/kernel/alternative.c
index a9bea860e22a,aa7f791585c5..23cbfa8d34c5
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@@ -602,24 -687,373 +687,373 @@@ void __init_or_module noinline apply_ib
  	s32 *s;
  
  	for (s = start; s < end; s++) {
- 		u32 endbr, poison = gen_endbr_poison();
  		void *addr = (void *)s + *s;
  
- 		if (WARN_ON_ONCE(get_kernel_nofault(endbr, addr)))
+ 		poison_endbr(addr, true);
+ 		if (IS_ENABLED(CONFIG_FINEIBT))
+ 			poison_endbr(addr - 16, false);
+ 	}
+ }
+ 
+ #else
+ 
 -void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
++void __init_or_module apply_ibt_endbr(s32 *start, s32 *end) { }
+ 
+ #endif /* CONFIG_X86_KERNEL_IBT */
+ 
+ #ifdef CONFIG_FINEIBT
+ 
+ enum cfi_mode {
+ 	CFI_DEFAULT,
+ 	CFI_OFF,
+ 	CFI_KCFI,
+ 	CFI_FINEIBT,
+ };
+ 
+ static enum cfi_mode cfi_mode __ro_after_init = CFI_DEFAULT;
+ static bool cfi_rand __ro_after_init = true;
+ static u32  cfi_seed __ro_after_init;
+ 
+ /*
+  * Re-hash the CFI hash with a boot-time seed while making sure the result is
+  * not a valid ENDBR instruction.
+  */
+ static u32 cfi_rehash(u32 hash)
+ {
+ 	hash ^= cfi_seed;
+ 	while (unlikely(is_endbr(hash) || is_endbr(-hash))) {
+ 		bool lsb = hash & 1;
+ 		hash >>= 1;
+ 		if (lsb)
+ 			hash ^= 0x80200003;
+ 	}
+ 	return hash;
+ }
+ 
+ static __init int cfi_parse_cmdline(char *str)
+ {
+ 	if (!str)
+ 		return -EINVAL;
+ 
+ 	while (str) {
+ 		char *next = strchr(str, ',');
+ 		if (next) {
+ 			*next = 0;
+ 			next++;
+ 		}
+ 
+ 		if (!strcmp(str, "auto")) {
+ 			cfi_mode = CFI_DEFAULT;
+ 		} else if (!strcmp(str, "off")) {
+ 			cfi_mode = CFI_OFF;
+ 			cfi_rand = false;
+ 		} else if (!strcmp(str, "kcfi")) {
+ 			cfi_mode = CFI_KCFI;
+ 		} else if (!strcmp(str, "fineibt")) {
+ 			cfi_mode = CFI_FINEIBT;
+ 		} else if (!strcmp(str, "norand")) {
+ 			cfi_rand = false;
+ 		} else {
+ 			pr_err("Ignoring unknown cfi option (%s).", str);
+ 		}
+ 
+ 		str = next;
+ 	}
+ 
+ 	return 0;
+ }
+ early_param("cfi", cfi_parse_cmdline);
+ 
+ /*
+  * kCFI						FineIBT
+  *
+  * __cfi_\func:					__cfi_\func:
+  *	movl   $0x12345678,%eax		// 5	     endbr64			// 4
+  *	nop					     subl   $0x12345678,%r10d   // 7
+  *	nop					     jz     1f			// 2
+  *	nop					     ud2			// 2
+  *	nop					1:   nop			// 1
+  *	nop
+  *	nop
+  *	nop
+  *	nop
+  *	nop
+  *	nop
+  *	nop
+  *
+  *
+  * caller:					caller:
+  *	movl	$(-0x12345678),%r10d	 // 6	     movl   $0x12345678,%r10d	// 6
+  *	addl	$-15(%r11),%r10d	 // 4	     sub    $16,%r11		// 4
+  *	je	1f			 // 2	     nop4			// 4
+  *	ud2				 // 2
+  * 1:	call	__x86_indirect_thunk_r11 // 5	     call   *%r11; nop2;	// 5
+  *
+  */
+ 
+ asm(	".pushsection .rodata			\n"
+ 	"fineibt_preamble_start:		\n"
+ 	"	endbr64				\n"
+ 	"	subl	$0x12345678, %r10d	\n"
+ 	"	je	fineibt_preamble_end	\n"
+ 	"	ud2				\n"
+ 	"	nop				\n"
+ 	"fineibt_preamble_end:			\n"
+ 	".popsection\n"
+ );
+ 
+ extern u8 fineibt_preamble_start[];
+ extern u8 fineibt_preamble_end[];
+ 
+ #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
+ #define fineibt_preamble_hash 7
+ 
+ asm(	".pushsection .rodata			\n"
+ 	"fineibt_caller_start:			\n"
+ 	"	movl	$0x12345678, %r10d	\n"
+ 	"	sub	$16, %r11		\n"
+ 	ASM_NOP4
+ 	"fineibt_caller_end:			\n"
+ 	".popsection				\n"
+ );
+ 
+ extern u8 fineibt_caller_start[];
+ extern u8 fineibt_caller_end[];
+ 
+ #define fineibt_caller_size (fineibt_caller_end - fineibt_caller_start)
+ #define fineibt_caller_hash 2
+ 
+ #define fineibt_caller_jmp (fineibt_caller_size - 2)
+ 
+ static u32 decode_preamble_hash(void *addr)
+ {
+ 	u8 *p = addr;
+ 
+ 	/* b8 78 56 34 12          mov    $0x12345678,%eax */
+ 	if (p[0] == 0xb8)
+ 		return *(u32 *)(addr + 1);
+ 
+ 	return 0; /* invalid hash value */
+ }
+ 
+ static u32 decode_caller_hash(void *addr)
+ {
+ 	u8 *p = addr;
+ 
+ 	/* 41 ba 78 56 34 12       mov    $0x12345678,%r10d */
+ 	if (p[0] == 0x41 && p[1] == 0xba)
+ 		return -*(u32 *)(addr + 2);
+ 
+ 	/* e8 0c 78 56 34 12	   jmp.d8  +12 */
+ 	if (p[0] == JMP8_INSN_OPCODE && p[1] == fineibt_caller_jmp)
+ 		return -*(u32 *)(addr + 2);
+ 
+ 	return 0; /* invalid hash value */
+ }
+ 
+ /* .retpoline_sites */
+ static int cfi_disable_callers(s32 *start, s32 *end)
+ {
+ 	/*
+ 	 * Disable kCFI by patching in a JMP.d8, this leaves the hash immediate
+ 	 * in tact for later usage. Also see decode_caller_hash() and
+ 	 * cfi_rewrite_callers().
+ 	 */
+ 	const u8 jmp[] = { JMP8_INSN_OPCODE, fineibt_caller_jmp };
+ 	s32 *s;
+ 
+ 	for (s = start; s < end; s++) {
+ 		void *addr = (void *)s + *s;
+ 		u32 hash;
+ 
+ 		addr -= fineibt_caller_size;
+ 		hash = decode_caller_hash(addr);
+ 		if (!hash) /* nocfi callers */
  			continue;
  
- 		if (WARN_ON_ONCE(!is_endbr(endbr)))
+ 		text_poke_early(addr, jmp, 2);
+ 	}
+ 
+ 	return 0;
+ }
+ 
+ static int cfi_enable_callers(s32 *start, s32 *end)
+ {
+ 	/*
+ 	 * Re-enable kCFI, undo what cfi_disable_callers() did.
+ 	 */
+ 	const u8 mov[] = { 0x41, 0xba };
+ 	s32 *s;
+ 
+ 	for (s = start; s < end; s++) {
+ 		void *addr = (void *)s + *s;
+ 		u32 hash;
+ 
+ 		addr -= fineibt_caller_size;
+ 		hash = decode_caller_hash(addr);
+ 		if (!hash) /* nocfi callers */
  			continue;
  
- 		DPRINTK("ENDBR at: %pS (%px)", addr, addr);
+ 		text_poke_early(addr, mov, 2);
+ 	}
  
- 		/*
- 		 * When we have IBT, the lack of ENDBR will trigger #CP
- 		 */
- 		DUMP_BYTES(((u8*)addr), 4, "%px: orig: ", addr);
- 		DUMP_BYTES(((u8*)&poison), 4, "%px: repl: ", addr);
- 		text_poke_early(addr, &poison, 4);
+ 	return 0;
+ }
+ 
+ /* .cfi_sites */
+ static int cfi_rand_preamble(s32 *start, s32 *end)
+ {
+ 	s32 *s;
+ 
+ 	for (s = start; s < end; s++) {
+ 		void *addr = (void *)s + *s;
+ 		u32 hash;
+ 
+ 		hash = decode_preamble_hash(addr);
+ 		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
+ 			 addr, addr, 5, addr))
+ 			return -EINVAL;
+ 
+ 		hash = cfi_rehash(hash);
+ 		text_poke_early(addr + 1, &hash, 4);
+ 	}
+ 
+ 	return 0;
+ }
+ 
+ static int cfi_rewrite_preamble(s32 *start, s32 *end)
+ {
+ 	s32 *s;
+ 
+ 	for (s = start; s < end; s++) {
+ 		void *addr = (void *)s + *s;
+ 		u32 hash;
+ 
+ 		hash = decode_preamble_hash(addr);
+ 		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
+ 			 addr, addr, 5, addr))
+ 			return -EINVAL;
+ 
+ 		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
+ 		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) != 0x12345678);
+ 		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
+ 	}
+ 
+ 	return 0;
+ }
+ 
+ /* .retpoline_sites */
+ static int cfi_rand_callers(s32 *start, s32 *end)
+ {
+ 	s32 *s;
+ 
+ 	for (s = start; s < end; s++) {
+ 		void *addr = (void *)s + *s;
+ 		u32 hash;
+ 
+ 		addr -= fineibt_caller_size;
+ 		hash = decode_caller_hash(addr);
+ 		if (hash) {
+ 			hash = -cfi_rehash(hash);
+ 			text_poke_early(addr + 2, &hash, 4);
+ 		}
+ 	}
+ 
+ 	return 0;
+ }
+ 
+ static int cfi_rewrite_callers(s32 *start, s32 *end)
+ {
+ 	s32 *s;
+ 
+ 	for (s = start; s < end; s++) {
+ 		void *addr = (void *)s + *s;
+ 		u32 hash;
+ 
+ 		addr -= fineibt_caller_size;
+ 		hash = decode_caller_hash(addr);
+ 		if (hash) {
+ 			text_poke_early(addr, fineibt_caller_start, fineibt_caller_size);
+ 			WARN_ON(*(u32 *)(addr + fineibt_caller_hash) != 0x12345678);
+ 			text_poke_early(addr + fineibt_caller_hash, &hash, 4);
+ 		}
+ 		/* rely on apply_retpolines() */
+ 	}
+ 
+ 	return 0;
+ }
+ 
+ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
+ 			    s32 *start_cfi, s32 *end_cfi, bool builtin)
+ {
+ 	int ret;
+ 
+ 	if (WARN_ONCE(fineibt_preamble_size != 16,
+ 		      "FineIBT preamble wrong size: %ld", fineibt_preamble_size))
+ 		return;
+ 
+ 	if (cfi_mode == CFI_DEFAULT) {
+ 		cfi_mode = CFI_KCFI;
+ 		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
+ 			cfi_mode = CFI_FINEIBT;
+ 	}
+ 
+ 	/*
+ 	 * Rewrite the callers to not use the __cfi_ stubs, such that we might
+ 	 * rewrite them. This disables all CFI. If this succeeds but any of the
+ 	 * later stages fails, we're without CFI.
+ 	 */
+ 	ret = cfi_disable_callers(start_retpoline, end_retpoline);
+ 	if (ret)
+ 		goto err;
+ 
+ 	if (cfi_rand) {
+ 		if (builtin)
+ 			cfi_seed = get_random_u32();
+ 
+ 		ret = cfi_rand_preamble(start_cfi, end_cfi);
+ 		if (ret)
+ 			goto err;
+ 
+ 		ret = cfi_rand_callers(start_retpoline, end_retpoline);
+ 		if (ret)
+ 			goto err;
  	}
+ 
+ 	switch (cfi_mode) {
+ 	case CFI_OFF:
+ 		if (builtin)
+ 			pr_info("Disabling CFI\n");
+ 		return;
+ 
+ 	case CFI_KCFI:
+ 		ret = cfi_enable_callers(start_retpoline, end_retpoline);
+ 		if (ret)
+ 			goto err;
+ 
+ 		if (builtin)
+ 			pr_info("Using kCFI\n");
+ 		return;
+ 
+ 	case CFI_FINEIBT:
+ 		ret = cfi_rewrite_preamble(start_cfi, end_cfi);
+ 		if (ret)
+ 			goto err;
+ 
+ 		ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
+ 		if (ret)
+ 			goto err;
+ 
+ 		if (builtin)
+ 			pr_info("Using FineIBT CFI\n");
+ 		return;
+ 
+ 	default:
+ 		break;
+ 	}
+ 
+ err:
+ 	pr_err("Something went horribly wrong trying to rewrite the CFI implementation.\n");
  }
  
  #else
diff --cc arch/x86/kernel/module.c
index d85a6980e263,0142982e94c5..705fb2a41d7d
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@@ -251,9 -252,10 +252,10 @@@ int module_finalize(const Elf_Ehdr *hdr
  		    const Elf_Shdr *sechdrs,
  		    struct module *me)
  {
 -	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
 +	const Elf_Shdr *s, *alt = NULL, *locks = NULL,
  		*para = NULL, *orc = NULL, *orc_ip = NULL,
- 		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL;
+ 		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL,
+ 		*calls = NULL, *cfi = NULL;
  	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
  
  	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
diff --cc arch/x86/kernel/setup_percpu.c
index b26123c90b4f,c2fc4c41c164..c242dc47e9cb
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@@ -22,10 -21,8 +22,7 @@@
  #include <asm/proto.h>
  #include <asm/cpumask.h>
  #include <asm/cpu.h>
 -#include <asm/stackprotector.h>
  
- DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
- EXPORT_PER_CPU_SYMBOL(cpu_number);
- 
  #ifdef CONFIG_X86_64
  #define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
  #else
diff --cc arch/x86/net/bpf_jit_comp.c
index 36ffe67ad6e5,f46b62029d91..b808be77635e
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@@ -1917,7 -1869,7 +1935,7 @@@ static int invoke_bpf_prog(const struc
  	/* arg2: lea rsi, [rbp - ctx_cookie_off] */
  	EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
  
- 	if (emit_call(&prog, bpf_trampoline_enter(p), prog))
 -	if (emit_rsb_call(&prog, enter, prog))
++	if (emit_rsb_call(&prog, bpf_trampoline_enter(p), prog))
  		return -EINVAL;
  	/* remember prog start time returned by __bpf_prog_enter */
  	emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
@@@ -1962,7 -1914,7 +1980,7 @@@
  	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
  	/* arg3: lea rdx, [rbp - run_ctx_off] */
  	EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
- 	if (emit_call(&prog, bpf_trampoline_exit(p), prog))
 -	if (emit_rsb_call(&prog, exit, prog))
++	if (emit_rsb_call(&prog, bpf_trampoline_exit(p), prog))
  		return -EINVAL;
  
  	*pprog = prog;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
