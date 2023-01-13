Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4D166A1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjAMSMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjAMSMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:12:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BBE1A2AA3;
        Fri, 13 Jan 2023 10:04:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B6BC1764;
        Fri, 13 Jan 2023 10:04:56 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 651273F67D;
        Fri, 13 Jan 2023 10:04:12 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org, ndesaulniers@google.com,
        ojeda@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com, rostedt@goodmis.org,
        will@kernel.org
Subject: [PATCH v2 3/8] arm64: Extend support for CONFIG_FUNCTION_ALIGNMENT
Date:   Fri, 13 Jan 2023 18:03:50 +0000
Message-Id: <20230113180355.2930042-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230113180355.2930042-1-mark.rutland@arm.com>
References: <20230113180355.2930042-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 we don't align assembly function in the same way as C
functions. This somewhat limits the utility of
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B for testing, and adds noise when
testing that we're correctly aligning functions as will be necessary for
ftrace in subsequent patches.

Follow the example of x86, and align assembly functions in the same way
as C functions.

I've tested this by selecting CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y,
building and booting a kernel, and looking for misaligned text symbols:

Before, v6.2-rc3:
  # uname -rm
  6.2.0-rc3 aarch64
  # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
  5009

Before, v6.2-rc3 + fixed __cold:
  # uname -rm
  6.2.0-rc3-00001-g2a2bedf8bfa9 aarch64
  # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
  919

Before, v6.2-rc3 + fixed __cold + fixed ACPICA:
  # uname -rm
  6.2.0-rc3-00002-g267bddc38572 aarch64
  # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
  323
  # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep acpi | wc -l
  0

After:
  # uname -rm
  6.2.0-rc3-00003-g71db61ee3ea1 aarch64
  # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
  112

Considering the remaining 112 unaligned text symbols:

* 20 are non-function KVM NVHE assembly symbols, which are never
  instrumented by ftrace:

  # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep __kvm_nvhe | wc -l
  20
  # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep __kvm_nvhe
  ffffbe6483f73784 t __kvm_nvhe___invalid
  ffffbe6483f73788 t __kvm_nvhe___do_hyp_init
  ffffbe6483f73ab0 t __kvm_nvhe_reset
  ffffbe6483f73b8c T __kvm_nvhe___hyp_idmap_text_end
  ffffbe6483f73b8c T __kvm_nvhe___hyp_text_start
  ffffbe6483f77864 t __kvm_nvhe___host_enter_restore_full
  ffffbe6483f77874 t __kvm_nvhe___host_enter_for_panic
  ffffbe6483f778a4 t __kvm_nvhe___host_enter_without_restoring
  ffffbe6483f81178 T __kvm_nvhe___guest_exit_panic
  ffffbe6483f811c8 T __kvm_nvhe___guest_exit
  ffffbe6483f81354 t __kvm_nvhe_abort_guest_exit_start
  ffffbe6483f81358 t __kvm_nvhe_abort_guest_exit_end
  ffffbe6483f81830 t __kvm_nvhe_wa_epilogue
  ffffbe6483f81844 t __kvm_nvhe_el1_trap
  ffffbe6483f81864 t __kvm_nvhe_el1_fiq
  ffffbe6483f81864 t __kvm_nvhe_el1_irq
  ffffbe6483f81884 t __kvm_nvhe_el1_error
  ffffbe6483f818a4 t __kvm_nvhe_el2_sync
  ffffbe6483f81920 t __kvm_nvhe_el2_error
  ffffbe6483f865c8 T __kvm_nvhe___start___kvm_ex_table

* 53 are position-independent functions only used during early boot, which are
  built with '-Os', but are never instrumented by ftrace:

  # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep __pi | wc -l
  53

  We *could* drop '-Os' when building these for consistency, but that is
  not necessary to ensure that ftrace works correctly.

* The remaining 39 are non-function symbols, and 3 runtime BPF
  functions, which are never instrumented by ftrace:

  # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep -v __kvm_nvhe | grep -v __pi | wc -l
  39
  # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep -v __kvm_nvhe | grep -v __pi
  ffffbe6482e1009c T __irqentry_text_end
  ffffbe6482e10358 T __softirqentry_text_end
  ffffbe6482e1435c T __entry_text_end
  ffffbe6482e825f8 T __guest_exit_panic
  ffffbe6482e82648 T __guest_exit
  ffffbe6482e827d4 t abort_guest_exit_start
  ffffbe6482e827d8 t abort_guest_exit_end
  ffffbe6482e83030 t wa_epilogue
  ffffbe6482e83044 t el1_trap
  ffffbe6482e83064 t el1_fiq
  ffffbe6482e83064 t el1_irq
  ffffbe6482e83084 t el1_error
  ffffbe6482e830a4 t el2_sync
  ffffbe6482e83120 t el2_error
  ffffbe6482e93550 T sha256_block_neon
  ffffbe64830f3ae0 t e843419@01cc_00002a0c_3104
  ffffbe648378bd90 t e843419@09b3_0000d7cb_bc4
  ffffbe6483bdab20 t e843419@0c66_000116e2_34c8
  ffffbe6483f62c94 T __noinstr_text_end
  ffffbe6483f70a18 T __sched_text_end
  ffffbe6483f70b2c T __cpuidle_text_end
  ffffbe6483f722d4 T __lock_text_end
  ffffbe6483f73b8c T __hyp_idmap_text_end
  ffffbe6483f73b8c T __hyp_text_start
  ffffbe6483f865c8 T __start___kvm_ex_table
  ffffbe6483f870d0 t init_el1
  ffffbe6483f870f8 t init_el2
  ffffbe6483f87324 t pen
  ffffbe6483f87b48 T __idmap_text_end
  ffffbe64848eb010 T __hibernate_exit_text_start
  ffffbe64848eb124 T __hibernate_exit_text_end
  ffffbe64848eb124 T __relocate_new_kernel_start
  ffffbe64848eb260 T __relocate_new_kernel_end
  ffffbe648498a8e8 T _einittext
  ffffbe648498a8e8 T __exittext_begin
  ffffbe6484999d84 T __exittext_end
  ffff8000080756b4 t bpf_prog_6deef7357e7b4530    [bpf]
  ffff80000808dd78 t bpf_prog_6deef7357e7b4530    [bpf]
  ffff80000809d684 t bpf_prog_6deef7357e7b4530    [bpf]

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/linkage.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
index 1436fa1cde24..df18a3446ce8 100644
--- a/arch/arm64/include/asm/linkage.h
+++ b/arch/arm64/include/asm/linkage.h
@@ -5,8 +5,14 @@
 #include <asm/assembler.h>
 #endif
 
-#define __ALIGN		.align 2
-#define __ALIGN_STR	".align 2"
+#if CONFIG_FUNCTION_ALIGNMENT > 0
+#define ARM64_FUNCTION_ALIGNMENT	CONFIG_FUNCTION_ALIGNMENT
+#else
+#define ARM64_FUNCTION_ALIGNMENT	4
+#endif
+
+#define __ALIGN		.balign ARM64_FUNCTION_ALIGNMENT
+#define __ALIGN_STR	".balign " #ARM64_FUNCTION_ALIGNMENT
 
 /*
  * When using in-kernel BTI we need to ensure that PCS-conformant
-- 
2.30.2

