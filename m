Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B828677CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjAWNqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjAWNqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:46:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A873425283;
        Mon, 23 Jan 2023 05:46:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CBD01474;
        Mon, 23 Jan 2023 05:46:59 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 857443F64C;
        Mon, 23 Jan 2023 05:46:15 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org, ndesaulniers@google.com,
        ojeda@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com, rostedt@goodmis.org,
        will@kernel.org
Subject: [PATCH v3 2/8] Compiler attributes: GCC cold function alignment workarounds
Date:   Mon, 23 Jan 2023 13:45:57 +0000
Message-Id: <20230123134603.1064407-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123134603.1064407-1-mark.rutland@arm.com>
References: <20230123134603.1064407-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contemporary versions of GCC (e.g. GCC 12.2.0) drop the alignment
specified by '-falign-functions=N' for functions marked with the
__cold__ attribute, and potentially for callees of __cold__ functions as
these may be implicitly marked as __cold__ by the compiler. LLVM appears
to respect '-falign-functions=N' in such cases.

This has been reported to GCC in bug 88345:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345

... which also covers alignment being dropped when '-Os' is used, which
will be addressed in a separate patch.

Currently, use of '-falign-functions=N' is limited to
CONFIG_FUNCTION_ALIGNMENT, which is largely used for performance and/or
analysis reasons (e.g. with CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B), but
isn't necessary for correct functionality. However, this dropped
alignment isn't great for the performance and/or analysis cases.

Subsequent patches will use CONFIG_FUNCTION_ALIGNMENT as part of arm64's
ftrace implementation, which will require all instrumented functions to
be aligned to at least 8-bytes.

This patch works around the dropped alignment by avoiding the use of the
__cold__ attribute when CONFIG_FUNCTION_ALIGNMENT is non-zero, and by
specifically aligning abort(), which GCC implicitly marks as __cold__.
As the __cold macro is now dependent upon config options (which is
against the policy described at the top of compiler_attributes.h), it is
moved into compiler_types.h.

I've tested this by building and booting a kernel configured with
defconfig + CONFIG_EXPERT=y + CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y,
and looking for misaligned text symbols in /proc/kallsyms:

* arm64:

  Before:
    # uname -rm
    6.2.0-rc3 aarch64
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    5009

  After:
    # uname -rm
    6.2.0-rc3-00001-g2a2bedf8bfa9 aarch64
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    919

* x86_64:

  Before:
    # uname -rm
    6.2.0-rc3 x86_64
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    11537

  After:
    # uname -rm
    6.2.0-rc3-00001-g2a2bedf8bfa9 x86_64
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    2805

There's clearly a substantial reduction in the number of misaligned
symbols. From manual inspection, the remaining unaligned text labels are
a combination of ACPICA functions (due to the use of '-Os'), static call
trampolines, and non-function labels in assembly, which will be dealt
with in subsequent patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler_attributes.h |  6 ------
 include/linux/compiler_types.h      | 27 +++++++++++++++++++++++++++
 kernel/exit.c                       |  9 ++++++++-
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 898b3458b24a..b83126452c65 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -75,12 +75,6 @@
 # define __assume_aligned(a, ...)
 #endif
 
-/*
- *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-cold-function-attribute
- *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html#index-cold-label-attribute
- */
-#define __cold                          __attribute__((__cold__))
-
 /*
  * Note the long name.
  *
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 7c1afe0f4129..aab34e30128e 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -79,6 +79,33 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 /* Attributes */
 #include <linux/compiler_attributes.h>
 
+#if CONFIG_FUNCTION_ALIGNMENT > 0
+#define __function_aligned		__aligned(CONFIG_FUNCTION_ALIGNMENT)
+#else
+#define __function_aligned
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-cold-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html#index-cold-label-attribute
+ *
+ * When -falign-functions=N is in use, we must avoid the cold attribute as
+ * contemporary versions of GCC drop the alignment for cold functions. Worse,
+ * GCC can implicitly mark callees of cold functions as cold themselves, so
+ * it's not sufficient to add __function_aligned here as that will not ensure
+ * that callees are correctly aligned.
+ *
+ * See:
+ *
+ *   https://lore.kernel.org/lkml/Y77%2FqVgvaJidFpYt@FVFF77S0Q05N
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345#c9
+ */
+#if !defined(CONFIG_CC_IS_GCC) || (CONFIG_FUNCTION_ALIGNMENT == 0)
+#define __cold				__attribute__((__cold__))
+#else
+#define __cold
+#endif
+
 /* Builtins */
 
 /*
diff --git a/kernel/exit.c b/kernel/exit.c
index 15dc2ec80c46..c8e0375705f4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1898,7 +1898,14 @@ bool thread_group_exited(struct pid *pid)
 }
 EXPORT_SYMBOL(thread_group_exited);
 
-__weak void abort(void)
+/*
+ * This needs to be __function_aligned as GCC implicitly makes any
+ * implementation of abort() cold and drops alignment specified by
+ * -falign-functions=N.
+ *
+ * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345#c11
+ */
+__weak __function_aligned void abort(void)
 {
 	BUG();
 
-- 
2.30.2

