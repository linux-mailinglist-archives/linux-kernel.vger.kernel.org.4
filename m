Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453C36A99C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjCCOpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjCCOpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:45:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E185CC34
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:45:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 108FC61842
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 14:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E943C433EF;
        Fri,  3 Mar 2023 14:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677854746;
        bh=b4RwFCESFjNrLBvUVQgpijNy97sPadKeAXyYTE+YkBM=;
        h=Date:From:To:Cc:Subject:From;
        b=nVDB4vD5zWLZKO0IwFueqJ9f7arvN5VFKp6H91MxcMYI4QxadXJ+ljRVXUAaOuv7a
         syJ6eAa5Ef0mOw/qDWTi4Axaykh4Uuk1D8LVuBpi6S4ek4d0dFe2QnlSUT01JNaNYl
         k4mg2+TjLPBdTBKTK7R1RHR7XTLcelRCV/ne5sNP2A3cFc/uhcdnKnRaDghDFiCqlq
         6+CxGmGLbbIKCg2Qo2OC+vQqNTz/EhdZsxSQrioIH2aKxwRh6Jks3u+UkIjiD2FBNp
         PN6QYndV7CPUsfhIJi5JFl8vByixYFhgtKtoa4zWsIG0IGArJ8QikPQVFVqSBZP8Sr
         U04Jz95EkB6FQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B6ADE4049F; Fri,  3 Mar 2023 11:45:43 -0300 (-03)
Date:   Fri, 3 Mar 2023 11:45:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 1/1 fyi] tools headers cpufeatures: Sync with the kernel
 sources
Message-ID: <ZAIIFxz79H1xEz0O@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes from:

  8415a74852d7c247 ("x86/cpu, kvm: Add support for CPUID_80000021_EAX")
  84168ae786f8a15a ("x86/cpu, kvm: Move X86_FEATURE_LFENCE_RDTSC to its native leaf")
  f334f723a63cfc25 ("x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag")
  78335aac6156eada ("x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature flag")
  a018d2e3d4b1abc4 ("x86/cpufeatures: Add Architectural PerfMon Extension bit")
  f8df91e73a6827a4 ("x86/cpufeatures: Add macros for Intel's new fast rep string features")
  a9dc9ec5a1fafc3d ("x86/cpu, kvm: Add the NO_NESTED_DATA_BP feature")
  84168ae786f8a15a ("x86/cpu, kvm: Move X86_FEATURE_LFENCE_RDTSC to its native leaf")
  e7862eda309ecfcc ("x86/cpu: Support AMD Automatic IBRS")
  faabfcb194a8d068 ("x86/cpu, kvm: Add the SMM_CTL MSR not present feature")
  be8de49bea505e77 ("x86/speculation: Identify processors vulnerable to SMT RSB predictions")

This causes these perf files to be rebuilt:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

Addressing these perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
  diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/required-features.h' differs from latest version at 'arch/x86/include/asm/required-features.h'
  diff -u tools/arch/x86/include/asm/required-features.h arch/x86/include/asm/required-features.h
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h       | 18 ++++++++++++++++--
 tools/arch/x86/include/asm/disabled-features.h |  3 ++-
 tools/arch/x86/include/asm/required-features.h |  3 ++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index b70111a75688a794..73c9672c123b980c 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			20	   /* N 32-bit words worth of info */
+#define NCAPINTS			21	   /* N 32-bit words worth of info */
 #define NBUGINTS			1	   /* N 32-bit bug flags */
 
 /*
@@ -97,7 +97,7 @@
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
 #define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
-#define X86_FEATURE_LFENCE_RDTSC	( 3*32+18) /* "" LFENCE synchronizes RDTSC */
+/* FREE, was #define X86_FEATURE_LFENCE_RDTSC		( 3*32+18) "" LFENCE synchronizes RDTSC */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
 #define X86_FEATURE_ALWAYS		( 3*32+21) /* "" Always-present feature */
@@ -307,11 +307,17 @@
 #define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf function */
 #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
+#define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocation */
+#define X86_FEATURE_BMEC		(11*32+22) /* "" Bandwidth Monitoring Event Configuration */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
+#define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* "" Intel Architectural PerfMon Extension */
+#define X86_FEATURE_FZRM		(12*32+10) /* "" Fast zero-length REP MOVSB */
+#define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
+#define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
@@ -427,6 +433,13 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
+/* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
+#define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
+#define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* "" LFENCE always serializing / synchronizes RDTSC */
+#define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* "" Null Selector Clears Base */
+#define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
+#define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* "" SMM_CTL MSR is not present */
+
 /*
  * BUG word(s)
  */
@@ -467,5 +480,6 @@
 #define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* CPU is too old and its MMIO Stale Data status is unknown */
 #define X86_BUG_RETBLEED		X86_BUG(27) /* CPU is affected by RETBleed */
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* EIBRS is vulnerable to Post Barrier RSB Predictions */
+#define X86_BUG_SMT_RSB			X86_BUG(29) /* CPU is vulnerable to Cross-Thread Return Address Predictions */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index c44b56f7ffba0d0e..5dfa4fb76f4b2ba0 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -124,6 +124,7 @@
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK19	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 20)
+#define DISABLED_MASK20	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index aff774775c678434..7ba1726b71c7b8bf 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -98,6 +98,7 @@
 #define REQUIRED_MASK17	0
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK19	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 20)
+#define REQUIRED_MASK20	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
-- 
2.39.2
