Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD306627E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjAIN6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237241AbjAIN6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:58:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE339FCA;
        Mon,  9 Jan 2023 05:58:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B4601515;
        Mon,  9 Jan 2023 05:59:22 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C43293F23F;
        Mon,  9 Jan 2023 05:58:38 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org, ndesaulniers@google.com,
        ojeda@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com, rostedt@goodmis.org,
        will@kernel.org
Subject: [PATCH 1/8] Compiler attributes: GCC function alignment workarounds
Date:   Mon,  9 Jan 2023 13:58:21 +0000
Message-Id: <20230109135828.879136-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230109135828.879136-1-mark.rutland@arm.com>
References: <20230109135828.879136-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From local testing, contemporary versions of of GCC (e.g. GCC 12.2.0)
don't respect '-falign-functions=N' in all cases. This is unfortunate,
as (for non-zero values of N) CONFIG_FUNCTION_ALIGNMENT=N will set
'-falign-functions=N', but this won't take effect for all functions.
LLVM appears to respect '-falign-functions=N' in call cases.

Today, for x86 this turns out to be functionally benign, though it does
somewhat undermine the CONFIG_FUNCTION_ALIGNMENT option, and it means
that CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not as robust as we'd
like.

On arm64 we'd like to use CONFIG_FUNCTION_ALIGNMENT to implement ftrace
functionality, and we'll require function alignment to be respected for
functional reasons.

As far as I can tell, GCC doesn't respect '-falign-functions=N':

* When the __weak__ attribute is used

  GCC seems to forget the alignment specified by '-falign-functions=N',
  but will respect the '__aligned__(N)' function attribute. Thus, we can
  work around this by explciitly setting the alignment for weak
  functions.

* When the __cold__ attribute is used

  GCC seems to forget the alignment specified by '-falign-functions=N',
  and also doesn't seem to respect the '__aligned__(N)' function
  attribute. The only way to work around this is to not use the __cold__
  attibute.

This patch implements workarounds for these two cases, using a function
attribute to set the alignment of __weak__ functions, and preventing the
use of the __cold__ attribute when CONFIG_FUNCTION_ALIGNMENT is
non-zero.

I've tested this by selecting CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y,
building and booting a kernel, and looking for misaligned text symbols:

* arm64:

  Before:
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    4939

  After:
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    908

* x86_64:

  Before:
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    7969

  After:
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    2057

With the patch applied, the remaining unaligned text labels are a
combination of static call trampolines, non-function labels in assembly,
and ACPICA functions, which will be dealt with in subsequent patches.

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
 include/linux/compiler_attributes.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 898b3458b24a0..dcb7ac67b764f 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -33,6 +33,17 @@
 #define __aligned(x)                    __attribute__((__aligned__(x)))
 #define __aligned_largest               __attribute__((__aligned__))
 
+/*
+ * Contemporary versions of GCC (e.g. 12.2.0) don't always respect
+ * '-falign-functions=N', and require alignment to be specificed via a function
+ * attribute in some cases.
+ */
+#if CONFIG_FUNCTION_ALIGNMENT > 0
+#define __function_aligned		__aligned(CONFIG_FUNCTION_ALIGNMENT)
+#else
+#define __function_aligned
+#endif
+
 /*
  * Note: do not use this directly. Instead, use __alloc_size() since it is conditionally
  * available and includes other attributes. For GCC < 9.1, __alloc_size__ gets undefined
@@ -78,8 +89,15 @@
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-cold-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html#index-cold-label-attribute
+ *
+ * GCC drops function alignment when the __cold__ attribute is used. Avoid the
+ * __cold__ attribute if function alignment is required.
  */
+#if !defined(CONFIG_CC_IS_GCC) || (CONFIG_FUNCTION_ALIGNMENT == 0)
 #define __cold                          __attribute__((__cold__))
+#else
+#define __cold
+#endif
 
 /*
  * Note the long name.
@@ -369,8 +387,11 @@
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
+ *
+ * GCC drops function alignment when the __weak__ attribute is used. This can
+ * be restored with function attributes.
  */
-#define __weak                          __attribute__((__weak__))
+#define __weak                          __attribute__((__weak__)) __function_aligned
 
 /*
  * Used by functions that use '__builtin_return_address'. These function
-- 
2.30.2

