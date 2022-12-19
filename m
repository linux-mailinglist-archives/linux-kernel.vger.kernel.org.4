Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E523A650EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiLSPcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiLSPcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:32:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04907636D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9552961010
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAA1C433D2;
        Mon, 19 Dec 2022 15:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671463936;
        bh=Z9yC3cbOuNgUzFVTmcOIPxxP3Tj5cBtUiG+jINwBNww=;
        h=Date:From:To:Cc:Subject:From;
        b=cdGGHyNKLvKTRq1w9BeEbVaF1I9kffOASmhvJ4juF6J6OOLrxdf5xkH0wlGhVR1m9
         lUsJBD/9teKZDiy0eZwn6pP9THX3mX/JoOOIchPQKOc0MdG3wFTXN+zJfhmm3Zf+E3
         eJgbk96jPiRiSzeWLSwfHLSsaKMVo1PcRmDEUxnBlFxFT1UMN6TnpsN3mQ0HY7sE/z
         oSIYlXHBPf3LTsaWHnqK7hkFuvnx7jzl+DrhLSqdHkz1156HR9ktXYzl2WgiOw4vrp
         10zLp9ST+MxhxxOodZ4O2VSQSYLQxHnSiQ82HsEbRpRAOvGjHJy86V3KlGh7PpkpZr
         KonvxBcDi1Fzg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 52D5D40367; Mon, 19 Dec 2022 12:32:12 -0300 (-03)
Date:   Mon, 19 Dec 2022 12:32:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Kai Huang <kai.huang@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/1 fyi] tools headers cpufeatures: Sync with the kernel
 sources
Message-ID: <Y6CD/IcEbDW5X/pN@kernel.org>
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

  5e85c4ebf206e50c ("x86: KVM: Advertise AVX-IFMA CPUID to user space")
  af2872f622547656 ("x86: KVM: Advertise AMX-FP16 CPUID to user space")
  6a19d7aa5821522e ("x86: KVM: Advertise CMPccXADD CPUID to user space")
  aaa65d17eec372c6 ("x86/tsx: Add a feature bit for TSX control MSR support")
  b1599915f09157e9 ("x86/cpufeatures: Move X86_FEATURE_CALL_DEPTH from bit 18 to bit 19 of word 11, to leave space for WIP X86_FEATURE_SGX_EDECCSSA bit")
  16a7fe3728a8b832 ("KVM/VMX: Allow exposing EDECCSSA user leaf function to KVM guest")
  80e4c1cd42fff110 ("x86/retbleed: Add X86_FEATURE_CALL_DEPTH")
  7df548840c496b01 ("x86/bugs: Add "unknown" reporting for MMIO Stale Data")

This only causes these perf files to be rebuilt:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiaxi Chen <jiaxi.chen@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kai Huang <kai.huang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index b71f4f2ecdd571a4..61012476d66e0e13 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -304,10 +304,16 @@
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
+#define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf function */
+#define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
+#define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
+#define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
+#define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
-- 
2.38.1

