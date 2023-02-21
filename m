Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C78A69EA34
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjBUWdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBUWdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:33:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB225949
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:33:12 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E82B1EC059E;
        Tue, 21 Feb 2023 23:33:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677018790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=qx90CRTesKnJw2CUnP4R1CUUB5qDm2cUmGugspK2V6I=;
        b=ZMrvKVgW40UpUL1r7wA4UtCpay/588UHAs/zi6iVLef+fyd51om0mFPR7wPg9skCo6GoLt
        zaCSzassXGp0WgXQBBltb5N30Vadr2TI0MzpLI753EdS61CfzENUXiZcZ6VYMMWsseE4g2
        ogwDCaksiCFXGT5dWmBhrfUG1Zy/hWY=
Date:   Tue, 21 Feb 2023 23:33:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v6.3-rc1
Message-ID: <Y/VGorWUI7I6AhL7@zn.tnic>
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

please pull the currently accumulated x86/cpu pile for 6.3.

There are a bunch of easy peasy merge conflicts, an exemplary resolve of
which I'm adding at the end of this message.

Thx.

---

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.3_rc1

for you to fetch changes up to 7914695743d598b189d549f2f57af24aa5633705:

  x86/amd: Cache debug register values in percpu variables (2023-01-31 20:09:26 +0100)

----------------------------------------------------------------
- Cache the AMD debug registers in per-CPU variables to avoid MSR writes
  where possible, when supporting a debug registers swap feature for
  SEV-ES guests

- Add support for AMD's version of eIBRS called Automatic IBRS which is
  a set-and-forget control of indirect branch restriction speculation
  resources on privilege change

- Add support for a new x86 instruction - LKGS - Load kernel GS which is
  part of the FRED infrastructure

- Reset SPEC_CTRL upon init to accomodate use cases like kexec which
  rediscover

- Other smaller fixes and cleanups

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      x86/amd: Cache debug register values in percpu variables

Ashok Raj (1):
      x86/cpu: Remove redundant extern x86_read_arch_cap_msr()

Breno Leitao (1):
      x86/bugs: Reset speculation control settings on init

H. Peter Anvin (Intel) (5):
      x86/cpufeature: Add the CPU feature bit for LKGS
      x86/opcode: Add the LKGS instruction to x86-opcode-map
      x86/gsseg: Make asm_load_gs_index() take an u16
      x86/gsseg: Move load_gs_index() to its own new header file
      x86/gsseg: Use the LKGS instruction if available for load_gs_index()

Ingo Molnar (1):
      x86/gsseg: Add the new <asm/gsseg.h> header to <asm/asm-prototypes.h>

Kim Phillips (8):
      x86/cpu, kvm: Add support for CPUID_80000021_EAX
      KVM: x86: Move open-coded CPUID leaf 0x80000021 EAX bit propagation code
      x86/cpu, kvm: Add the NO_NESTED_DATA_BP feature
      x86/cpu, kvm: Move X86_FEATURE_LFENCE_RDTSC to its native leaf
      x86/cpu, kvm: Add the Null Selector Clears Base feature
      x86/cpu, kvm: Add the SMM_CTL MSR not present feature
      x86/cpu: Support AMD Automatic IBRS
      KVM: x86: Propagate the AMD Automatic IBRS feature to the guest

 Documentation/admin-guide/hw-vuln/spectre.rst   |  6 +--
 Documentation/admin-guide/kernel-parameters.txt |  6 +--
 arch/x86/entry/entry_64.S                       |  2 +-
 arch/x86/include/asm/asm-prototypes.h           |  1 +
 arch/x86/include/asm/cpufeature.h               |  7 ++-
 arch/x86/include/asm/cpufeatures.h              | 12 ++++-
 arch/x86/include/asm/debugreg.h                 |  9 +++-
 arch/x86/include/asm/disabled-features.h        |  3 +-
 arch/x86/include/asm/gsseg.h                    | 66 +++++++++++++++++++++++++
 arch/x86/include/asm/mmu_context.h              |  1 +
 arch/x86/include/asm/msr-index.h                |  6 +++
 arch/x86/include/asm/required-features.h        |  3 +-
 arch/x86/include/asm/special_insns.h            | 21 --------
 arch/x86/kernel/cpu/amd.c                       | 49 ++++++++++++------
 arch/x86/kernel/cpu/bugs.c                      | 31 ++++++++----
 arch/x86/kernel/cpu/common.c                    | 27 +++++-----
 arch/x86/kernel/cpu/cpu.h                       |  2 -
 arch/x86/kernel/cpu/tsx.c                       |  1 +
 arch/x86/kernel/hw_breakpoint.c                 |  4 +-
 arch/x86/kernel/paravirt.c                      |  1 +
 arch/x86/kernel/signal_32.c                     |  1 +
 arch/x86/kernel/tls.c                           |  1 +
 arch/x86/kvm/cpuid.c                            | 41 ++++++++-------
 arch/x86/kvm/reverse_cpuid.h                    |  1 +
 arch/x86/kvm/svm/svm.c                          |  3 ++
 arch/x86/kvm/x86.c                              |  3 ++
 arch/x86/lib/x86-opcode-map.txt                 |  1 +
 arch/x86/xen/enlighten_pv.c                     |  1 +
 tools/arch/x86/include/asm/cpufeatures.h        |  1 +
 tools/arch/x86/lib/x86-opcode-map.txt           |  1 +
 30 files changed, 218 insertions(+), 94 deletions(-)
 create mode 100644 arch/x86/include/asm/gsseg.h

 ---

 merge conflicts resolve:

 ---

diff --cc arch/x86/include/asm/cpufeatures.h
index 49973061b5bd,06909dc7fa63..389ea336258f
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@@ -314,7 -312,7 +314,8 @@@
  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
  #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
  #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
 +#define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* "" Intel Architectural PerfMon Extension */
+ #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
  #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
  #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
  
diff --cc arch/x86/include/asm/special_insns.h
index f358a23f228d,cfd9499b617c..de48d1389936
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@@ -184,19 -173,9 +173,9 @@@ static __always_inline void wbinvd(void
  	native_wbinvd();
  }
  
- 
- static inline void load_gs_index(unsigned int selector)
- {
- #ifdef CONFIG_X86_64
- 	native_load_gs_index(selector);
- #else
- 	loadsegment(gs, selector);
- #endif
- }
- 
  #endif /* CONFIG_PARAVIRT_XXL */
  
 -static inline void clflush(volatile void *__p)
 +static __always_inline void clflush(volatile void *__p)
  {
  	asm volatile("clflush %0" : "+m" (*(volatile char __force *)__p));
  }
diff --cc arch/x86/kernel/cpu/common.c
index 65ceabb2e114,62c73c57f16d..a394bbba7a4b
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@@ -1403,14 -1412,6 +1414,9 @@@ static void __init cpu_set_bug_bits(str
  			setup_force_cpu_bug(X86_BUG_RETBLEED);
  	}
  
- 	if (cpu_has(c, X86_FEATURE_IBRS_ENHANCED) &&
- 	    !cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
- 	    !(ia32_cap & ARCH_CAP_PBRSB_NO))
- 		setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
- 
 +	if (cpu_matches(cpu_vuln_blacklist, SMT_RSB))
 +		setup_force_cpu_bug(X86_BUG_SMT_RSB);
 +
  	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
  		return;
  

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
