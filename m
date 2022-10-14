Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C8F5FF515
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJNVL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJNVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:11:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5499C1C97E7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A51E61C61
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 21:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D93C433D7;
        Fri, 14 Oct 2022 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665781911;
        bh=styfo9t6c8A0hCAF/WmCHXNT0LDmLOn4Sjqa1ndi/hI=;
        h=Date:From:To:Cc:Subject:From;
        b=hi8zmYQVtWt179xSQLkNg7PaiAskrJh+AZUufFyEhgXEUD7s0HuSv45pCxsDlGiyy
         w/aFzTQwgEbwqo8WjwTBxren2v39XAYvcNvXNYhIMwoR7p0W4+tLKW34dzNHj+B8pb
         FA5iPwJWhuOa75t1Xu1vzs5kZyvRjXXrnoVoFMAKJPZz78Zm/A3MmEAoYATKlZ9kfN
         /VwUgvv8SCW9N7bYzT5D27lGyJEQzW1lkXRK953g8eLayFO+uy46+vRIT8tA/XB1s9
         N2AsfspZC63W7p4zr5Amrb81b+K2vPcEEOGKk2EpaL16SXK1rObD3orB8m7Mr7tdJB
         i5ZOOdQIfY2bQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 40D0E403B6; Fri, 14 Oct 2022 18:11:47 -0300 (-03)
Date:   Fri, 14 Oct 2022 18:11:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 1/1 FYI] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <Y0nQkz2TUJxwfXJd@kernel.org>
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

  b8d1d163604bd1e6 ("x86/apic: Don't disable x2APIC if locked")
  ca5b7c0d9621702e ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")

Addressing these tools/perf build warnings:

    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'

That makes the beautification scripts to pick some new entries:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2022-10-14 18:06:34.294561729 -0300
  +++ after	2022-10-14 18:06:41.285744044 -0300
  @@ -264,6 +264,7 @@
   	[0xc0000102 - x86_64_specific_MSRs_offset] = "KERNEL_GS_BASE",
   	[0xc0000103 - x86_64_specific_MSRs_offset] = "TSC_AUX",
   	[0xc0000104 - x86_64_specific_MSRs_offset] = "AMD64_TSC_RATIO",
  +	[0xc000010e - x86_64_specific_MSRs_offset] = "AMD64_LBR_SELECT",
   	[0xc000010f - x86_64_specific_MSRs_offset] = "AMD_DBG_EXTN_CFG",
   	[0xc0000300 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_STATUS",
   	[0xc0000301 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_CTL",
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
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 6674bdb096f346d9..10ac52705892a168 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -155,6 +155,11 @@
 						 * Return Stack Buffer Predictions.
 						 */
 
+#define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
+						 * IA32_XAPIC_DISABLE_STATUS MSR
+						 * supported
+						 */
+
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
 						 * Writeback and invalidate the
@@ -585,6 +590,9 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Last Branch Record MSRs */
+#define MSR_AMD64_LBR_SELECT			0xc000010e
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
@@ -756,6 +764,8 @@
 #define MSR_AMD_DBG_EXTN_CFG		0xc000010f
 #define MSR_AMD_SAMP_BR_FROM		0xc0010300
 
+#define DBG_EXTN_CFG_LBRV2EN		BIT_ULL(6)
+
 #define MSR_IA32_MPERF			0x000000e7
 #define MSR_IA32_APERF			0x000000e8
 
@@ -1054,4 +1064,12 @@
 #define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
 #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
 
+/* x2APIC locked status */
+#define MSR_IA32_XAPIC_DISABLE_STATUS	0xBD
+#define LEGACY_XAPIC_DISABLED		BIT(0) /*
+						* x2APIC mode is locked and
+						* disabling x2APIC will cause
+						* a #GP
+						*/
+
 #endif /* _ASM_X86_MSR_INDEX_H */
-- 
2.37.3

