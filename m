Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68A66AA150
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjCCVgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjCCVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:36:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC6E62D86
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 13:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49B786190E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 21:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B92C433D2;
        Fri,  3 Mar 2023 21:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677879404;
        bh=X4YWjg98A+yB54o6Gahn822mKA3bQTcv81Qndlr7248=;
        h=Date:From:To:Cc:Subject:From;
        b=Cbfr/aWm10VnaB+UldfvHcHeqH0u8Ga7bbudXSyrVMkchPXMF1KoSioct1Q3nOhrE
         If0Y4yVKalujYGC4XNuV59JZ8DR8Sbk0mxKfBxkSXHFw9NELppGJNOJqpXui/LmuTm
         X3SkNwpUiwh85xaMulbIuM7nsAptU8aSee2sZ9wa6Xi7yDAn/XYh8j8Mpo3XXgEWb9
         KTYmJXpLRD9WOc0nM/EWVe0zoXTOhnM6H96VpxqQ4fQVS/5rUHqADJNbNg+8b1zes4
         I/DfypfmfwCGjcNikD7FPXWaqaIZDRRdi3ojRpQvKrqct0gWuvyw7O5Pb3dzxSQKkN
         jav0tjkZdVF3Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 78E154049F; Fri,  3 Mar 2023 18:36:41 -0300 (-03)
Date:   Fri, 3 Mar 2023 18:36:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Breno Leitao <leitao@debian.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH 1/1 fyi] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <ZAJoaZ41+rU5H0vL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

  e7862eda309ecfcc ("x86/cpu: Support AMD Automatic IBRS")
  0125acda7d76b943 ("x86/bugs: Reset speculation control settings on init")
  38aaf921e92dc5cf ("perf/x86: Add Meteor Lake support")
  8c29f01654053258 ("x86/sev: Add SEV-SNP guest feature negotiation support")
  5b6fac3fa44bafee ("x86/resctrl: Detect and configure Slow Memory Bandwidth Allocation")
  dc2a3e857981f859 ("x86/resctrl: Add interface to read mbm_total_bytes_config")

Addressing these tools/perf build warnings:

    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'

That makes the beautification scripts to pick some new entries:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2023-03-03 18:26:51.766923522 -0300
  +++ after	2023-03-03 18:27:09.987415481 -0300
  @@ -267,9 +267,11 @@
   	[0xc000010e - x86_64_specific_MSRs_offset] = "AMD64_LBR_SELECT",
   	[0xc000010f - x86_64_specific_MSRs_offset] = "AMD_DBG_EXTN_CFG",
   	[0xc0000200 - x86_64_specific_MSRs_offset] = "IA32_MBA_BW_BASE",
  +	[0xc0000280 - x86_64_specific_MSRs_offset] = "IA32_SMBA_BW_BASE",
   	[0xc0000300 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_STATUS",
   	[0xc0000301 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_CTL",
   	[0xc0000302 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_STATUS_CLR",
  +	[0xc0000400 - x86_64_specific_MSRs_offset] = "IA32_EVT_CFG_BASE",
   };

   #define x86_AMD_V_KVM_MSRs_offset 0xc0010000
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
Cc: Babu Moger <babu.moger@amd.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Breno Leitao <leitao@debian.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nikunj A Dadhania <nikunj@amd.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 37ff47552bcb7b57..ad35355ee43ead14 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -25,6 +25,7 @@
 #define _EFER_SVME		12 /* Enable virtualization */
 #define _EFER_LMSLE		13 /* Long Mode Segment Limit Enable */
 #define _EFER_FFXSR		14 /* Enable Fast FXSAVE/FXRSTOR */
+#define _EFER_AUTOIBRS		21 /* Enable Automatic IBRS */
 
 #define EFER_SCE		(1<<_EFER_SCE)
 #define EFER_LME		(1<<_EFER_LME)
@@ -33,6 +34,7 @@
 #define EFER_SVME		(1<<_EFER_SVME)
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
+#define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
 /* Intel MSRs. Some also available on other CPUs */
 
@@ -49,6 +51,10 @@
 #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
 #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
 
+/* A mask for bits which the kernel toggles when controlling mitigations */
+#define SPEC_CTRL_MITIGATIONS_MASK	(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
+							| SPEC_CTRL_RRSBA_DIS_S)
+
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
 
@@ -189,6 +195,9 @@
 #define MSR_TURBO_RATIO_LIMIT1		0x000001ae
 #define MSR_TURBO_RATIO_LIMIT2		0x000001af
 
+#define MSR_SNOOP_RSP_0			0x00001328
+#define MSR_SNOOP_RSP_1			0x00001329
+
 #define MSR_LBR_SELECT			0x000001c8
 #define MSR_LBR_TOS			0x000001c9
 
@@ -566,6 +575,26 @@
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
 #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
 
+/* SNP feature bits enabled by the hypervisor */
+#define MSR_AMD64_SNP_VTOM			BIT_ULL(3)
+#define MSR_AMD64_SNP_REFLECT_VC		BIT_ULL(4)
+#define MSR_AMD64_SNP_RESTRICTED_INJ		BIT_ULL(5)
+#define MSR_AMD64_SNP_ALT_INJ			BIT_ULL(6)
+#define MSR_AMD64_SNP_DEBUG_SWAP		BIT_ULL(7)
+#define MSR_AMD64_SNP_PREVENT_HOST_IBS		BIT_ULL(8)
+#define MSR_AMD64_SNP_BTB_ISOLATION		BIT_ULL(9)
+#define MSR_AMD64_SNP_VMPL_SSS			BIT_ULL(10)
+#define MSR_AMD64_SNP_SECURE_TSC		BIT_ULL(11)
+#define MSR_AMD64_SNP_VMGEXIT_PARAM		BIT_ULL(12)
+#define MSR_AMD64_SNP_IBS_VIRT			BIT_ULL(14)
+#define MSR_AMD64_SNP_VMSA_REG_PROTECTION	BIT_ULL(16)
+#define MSR_AMD64_SNP_SMT_PROTECTION		BIT_ULL(17)
+
+/* SNP feature bits reserved for future use. */
+#define MSR_AMD64_SNP_RESERVED_BIT13		BIT_ULL(13)
+#define MSR_AMD64_SNP_RESERVED_BIT15		BIT_ULL(15)
+#define MSR_AMD64_SNP_RESERVED_MASK		GENMASK_ULL(63, 18)
+
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
 /* AMD Collaborative Processor Performance Control MSRs */
@@ -1061,6 +1090,8 @@
 
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
+#define MSR_IA32_SMBA_BW_BASE		0xc0000280
+#define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
-- 
2.39.2

