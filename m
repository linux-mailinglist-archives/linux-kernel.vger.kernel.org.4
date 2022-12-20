Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECEF6525A3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiLTRfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiLTRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:35:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E269D1C434
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:35:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E1661530
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942AFC433EF;
        Tue, 20 Dec 2022 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671557711;
        bh=74nxGtd6FVQBOWPGlgjOv5Cufmb5KWmhsUgAhxcSeSo=;
        h=Date:From:To:Cc:Subject:From;
        b=iImDE5Jm87JD3/H2n5SnFI7/TZMQpSoiGWZbjo3WDfSl1rmKC+OEx1JthQwfpF/an
         t5I6faAzX1pDL3GioJlwbaE50LgpnTjCWI7v4QoLm803lRZRDbIxwCJ9raBqT6oaLk
         jVkUqxaighFMBhIcYDsrXSIXfZthxu/0KVoA7FC7sEVz4E8zVhmUtZ429x8BkIkzwA
         +dvhg+xn3TPcGKTKzHoJ7QMBrSRwEXDodkxc4Gqh71s72235L3mQOd/TXIzU/lGY8b
         yYHNpWrltXCQqchyY6BxamoRiQQUq3Ah/DkCXOHKJVzJJaSf23rW41hlzgvZr/4/B6
         BGLFjFGNLefLg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2BC1040367; Tue, 20 Dec 2022 14:35:08 -0300 (-03)
Date:   Tue, 20 Dec 2022 14:35:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/1 fyi] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <Y6HyTOGRNvKfCVe4@kernel.org>
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

To pick up the changes in:

  97fa21f65c3eb5bb ("x86/resctrl: Move MSR defines into msr-index.h")
  7420ae3bb977b46e ("x86/intel_epb: Set Alder Lake N and Raptor Lake P normal EPB")

Addressing these tools/perf build warnings:

    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'

That makes the beautification scripts to pick some new entries:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2022-12-20 14:28:40.893794072 -0300
  +++ after	2022-12-20 14:28:54.831993914 -0300
  @@ -266,6 +266,7 @@
   	[0xc0000104 - x86_64_specific_MSRs_offset] = "AMD64_TSC_RATIO",
   	[0xc000010e - x86_64_specific_MSRs_offset] = "AMD64_LBR_SELECT",
   	[0xc000010f - x86_64_specific_MSRs_offset] = "AMD_DBG_EXTN_CFG",
  +	[0xc0000200 - x86_64_specific_MSRs_offset] = "IA32_MBA_BW_BASE",
   	[0xc0000300 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_STATUS",
   	[0xc0000301 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_CTL",
   	[0xc0000302 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_STATUS_CLR",
  $

Now one can trace systemwide asking to see backtraces to where that MSR
is being read/written, see this example with a previous update:

  # perf trace -e msr:*_msr/max-stack=32/ --filter="msr>=IA32_U_CET && msr<=IA32_INT_SSP_TAB"
  ^C#

If we use -v (verbose mode) we can see what it does behind the scenes:

  # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr>=IA32_U_CET && msr<=IA32_INT_SSP_TAB"
  Using CPUID AuthenticAMD-25-21-0
  0x6a0
  0x6a8
  New filter for msr:read_msr: (msr>=0x6a0 && msr<=0x6a8) && (common_pid != 597499 && common_pid != 3313)
  0x6a0
  0x6a8
  New filter for msr:write_msr: (msr>=0x6a0 && msr<=0x6a8) && (common_pid != 597499 && common_pid != 3313)
  mmap size 528384B
  ^C#

Example with a frequent msr:

  # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr==IA32_SPEC_CTRL" --max-events 2
  Using CPUID AuthenticAMD-25-21-0
  0x48
  New filter for msr:read_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
  0x48
  New filter for msr:write_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
  mmap size 528384B
  Looking at the vmlinux_path (8 entries long)
  symsrc__init: build id mismatch for vmlinux.
  Using /proc/kcore for kernel data
  Using /proc/kallsyms for symbols
     0.000 Timer/2525383 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       __switch_to_xtra ([kernel.kallsyms])
                                       __switch_to ([kernel.kallsyms])
                                       __schedule ([kernel.kallsyms])
                                       schedule ([kernel.kallsyms])
                                       futex_wait_queue_me ([kernel.kallsyms])
                                       futex_wait ([kernel.kallsyms])
                                       do_futex ([kernel.kallsyms])
                                       __x64_sys_futex ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
                                       __futex_abstimed_wait_common64 (/usr/lib64/libpthread-2.33.so)
     0.030 :0/0 msr:write_msr(msr: IA32_SPEC_CTRL, val: 2)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       __switch_to_xtra ([kernel.kallsyms])
                                       __switch_to ([kernel.kallsyms])
                                       __schedule ([kernel.kallsyms])
                                       schedule_idle ([kernel.kallsyms])
                                       do_idle ([kernel.kallsyms])
                                       cpu_startup_entry ([kernel.kallsyms])
                                       secondary_startup_64_no_verify ([kernel.kallsyms])
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index f17ade084720d508..37ff47552bcb7b57 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -4,12 +4,7 @@
 
 #include <linux/bits.h>
 
-/*
- * CPU model specific register (MSR) numbers.
- *
- * Do not add new entries to this file unless the definitions are shared
- * between multiple compilation units.
- */
+/* CPU model specific register (MSR) numbers. */
 
 /* x86-64 specific MSRs */
 #define MSR_EFER		0xc0000080 /* extended feature register */
@@ -537,7 +532,7 @@
 #define MSR_AMD64_DC_CFG		0xc0011022
 
 #define MSR_AMD64_DE_CFG		0xc0011029
-#define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT	1
+#define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT	 1
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE	BIT_ULL(MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT)
 
 #define MSR_AMD64_BU_CFG2		0xc001102a
@@ -798,6 +793,7 @@
 #define ENERGY_PERF_BIAS_PERFORMANCE		0
 #define ENERGY_PERF_BIAS_BALANCE_PERFORMANCE	4
 #define ENERGY_PERF_BIAS_NORMAL			6
+#define ENERGY_PERF_BIAS_NORMAL_POWERSAVE	7
 #define ENERGY_PERF_BIAS_BALANCE_POWERSAVE	8
 #define ENERGY_PERF_BIAS_POWERSAVE		15
 
@@ -1052,6 +1048,20 @@
 #define VMX_BASIC_MEM_TYPE_WB	6LLU
 #define VMX_BASIC_INOUT		0x0040000000000000LLU
 
+/* Resctrl MSRs: */
+/* - Intel: */
+#define MSR_IA32_L3_QOS_CFG		0xc81
+#define MSR_IA32_L2_QOS_CFG		0xc82
+#define MSR_IA32_QM_EVTSEL		0xc8d
+#define MSR_IA32_QM_CTR			0xc8e
+#define MSR_IA32_PQR_ASSOC		0xc8f
+#define MSR_IA32_L3_CBM_BASE		0xc90
+#define MSR_IA32_L2_CBM_BASE		0xd10
+#define MSR_IA32_MBA_THRTL_BASE		0xd50
+
+/* - AMD: */
+#define MSR_IA32_MBA_BW_BASE		0xc0000200
+
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
 #define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
-- 
2.38.1

