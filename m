Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7650A68A086
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjBCRkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjBCRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:39:53 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D392125
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:39:52 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id o68so2939969pfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WZL1uAcqK22yknIBHg1TH70wLiFVNlCVoM2e8IdO6s=;
        b=Ecbp+KXuzyrUV2HboCAjpxOqKlc1ehRwThuleJqmK4Rg5gCJzoYDSyDd8zyWjYMJwb
         4+ueeh+PKBj/UsDeJakhm2ghqJRq1TgaThyo7eb4WEMbBccGGucMWcNd7N0lgB8+Kn1e
         IWlYmfb5lsV+BtI3pMMy0cReVsarkpuHwAX28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WZL1uAcqK22yknIBHg1TH70wLiFVNlCVoM2e8IdO6s=;
        b=Dlz/jW/gNqBE4ngS4gKCT5a1jQQqOmWduNivG3iSNOYSQAQQLOmdHFqfY2301XMdDq
         hRhnlXf3fevjwEn7DrSuvPW1Gtuup+xu3pdFUpqrHZ2yWIS0iVzci7fC8F/+1fUo2dQb
         QABPR07JZQSK+8ybozwgS8n3szur9Zq4oGDbLMGltzA1SCcRi4yrmqWfi23PAXqNlzv3
         8whvQyct3RUlCXH0zDcxgoq+hD23kkAERZxGaD6B4yt9+jMtLU3gR33x31UQxuQ5LZOv
         ewUbrovzKYWGTl3iD8Vwea8YqZkekRDB9k4RxF+nytl9k4nEDlif6yFCLTMVWWSwEaV5
         Gi7w==
X-Gm-Message-State: AO0yUKV2+5HILvAKr3L9+vBBfsI5tXewsomw72kbq+j/pT01fqukDswJ
        SCFrEvNMnkne7pwZxDTuMoTUHQ==
X-Google-Smtp-Source: AK7set/ILYK/AVwauQAeJLy4eUtsZ9YMt4HTPQCDXUBkX+mTutpn3SPG/Ck17MHzyktHS5kyHhyemA==
X-Received: by 2002:a05:6a00:a22:b0:593:df5a:1592 with SMTP id p34-20020a056a000a2200b00593df5a1592mr11487947pfh.25.1675445991633;
        Fri, 03 Feb 2023 09:39:51 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y66-20020a626445000000b005821db4fd84sm2080287pfb.131.2023.02.03.09.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:39:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] arm64: Support Clang UBSAN trap codes for better reporting
Date:   Fri,  3 Feb 2023 17:39:49 +0000
Message-Id: <20230203173946.gonna.972-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7881; h=from:subject:message-id; bh=Wbj+ROZzkr0HqALXeqBsmNe3SBAa0wKtdW+jf0B3UHA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3Ubl5gpTcIQItZiS4wh1SeVOPr79eIulbKMyIJdz HYVl9/qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY91G5QAKCRCJcvTf3G3AJp6oEA CeSCrebA+oDU4bIvtCx7zDa/L8OePXLAmcx5SUtSpoP4VZoXLZ+EJS6L5MoqZ1k0Y+nclKxuMA2Lar a2DjeKGW36+OmnAk0k94ymtyYsYe2R9fnriEDGjVG1pT9sdM+ZsmYhv0hX2W+4tT0k/IVZDm0mryFj wCerAZ4anWU05BjH6yA/4X75tkzwc+F1d9UoiCpyYA65HcYM6tgGuTm3DCchpTKszGo6viQS/YShiw gtv0GzZfSJkOgIHoI9oErNKSe5L0yrTEmHgmR87+Xupy+nGsKmCGxUbGXRMrrX72xkdJx0TiUCWfzS YH+bCISOR6o+lRzInZSiUbwoegYOrSd6me4Qny+UBg3GJS9bAxP10oyaE6I3UzoOExXh2wtBDqUPqI urzpkZ98p/KlKBXfzNgJvs+mUCtkXg/xWhmM+aMNkiHq1l1BKoP1Wbd0WL19ilGNO8e8binOGhDo6/ 022oIO1EzBedMHyDKC6SB1ShPErNKCKLTc6SKNmg9+HLKa+V/U8T5P9YoN1LCtBRpHz13o5th7rTKS /DI8iceYK1O03avcRzp7Mr2TpnPagtzlzB6DE3qn/gV0f5S4sBMuClBX6f3Ep7KOzna1Jel1Xb8Y4b qSRq66YyDgIHxo3hdoxAjgFZFA/AafrAl6QUYK8EmlvMj3XIhPKpC0O97NHQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_UBSAN_TRAP=y on arm64, Clang encodes the UBSAN
check (handler) type in the esr. Extract this and actually report these
traps as coming from the specific UBSAN check that tripped.

Before:

  Internal error: BRK handler: 00000000f20003e8 [#1] PREEMPT SMP

After:

  Internal error: UBSAN: shift out of bounds: 00000000f2005514 [#1] PREEMPT SMP

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: John Stultz <jstultz@google.com>
Cc: Yongqin Liu <yongqin.liu@linaro.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: improve commit log, limit report strings to actual configs, document mappings
v1: https://lore.kernel.org/lkml/20230202223653.never.473-kees@kernel.org/
---
 arch/arm64/include/asm/brk-imm.h |  2 +
 arch/arm64/kernel/traps.c        | 21 ++++++++++
 include/linux/ubsan.h            |  9 +++++
 lib/Makefile                     |  2 -
 lib/ubsan.c                      | 67 ++++++++++++++++++++++++++++++++
 lib/ubsan.h                      | 32 +++++++++++++++
 6 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/ubsan.h

diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
index 6e000113e508..3f0f0d03268b 100644
--- a/arch/arm64/include/asm/brk-imm.h
+++ b/arch/arm64/include/asm/brk-imm.h
@@ -28,6 +28,8 @@
 #define BUG_BRK_IMM			0x800
 #define KASAN_BRK_IMM			0x900
 #define KASAN_BRK_MASK			0x0ff
+#define UBSAN_BRK_IMM			0x5500
+#define UBSAN_BRK_MASK			0x00ff
 
 #define CFI_BRK_IMM_TARGET		GENMASK(4, 0)
 #define CFI_BRK_IMM_TYPE		GENMASK(9, 5)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4c0caa589e12..87f42eb1c950 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/mm_types.h>
 #include <linux/kasan.h>
+#include <linux/ubsan.h>
 #include <linux/cfi.h>
 
 #include <asm/atomic.h>
@@ -1074,6 +1075,19 @@ static struct break_hook kasan_break_hook = {
 };
 #endif
 
+#ifdef CONFIG_UBSAN_TRAP
+static int ubsan_handler(struct pt_regs *regs, unsigned long esr)
+{
+	die(report_ubsan_failure(regs, esr & UBSAN_BRK_MASK), regs, esr);
+	return DBG_HOOK_HANDLED;
+}
+
+static struct break_hook ubsan_break_hook = {
+	.fn	= ubsan_handler,
+	.imm	= UBSAN_BRK_IMM,
+	.mask	= UBSAN_BRK_MASK,
+};
+#endif
 
 #define esr_comment(esr) ((esr) & ESR_ELx_BRK64_ISS_COMMENT_MASK)
 
@@ -1091,6 +1105,10 @@ int __init early_brk64(unsigned long addr, unsigned long esr,
 #ifdef CONFIG_KASAN_SW_TAGS
 	if ((esr_comment(esr) & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
 		return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
+#endif
+#ifdef CONFIG_UBSAN_TRAP
+	if ((esr_comment(esr) & ~UBSAN_BRK_MASK) == UBSAN_BRK_IMM)
+		return ubsan_handler(regs, esr) != DBG_HOOK_HANDLED;
 #endif
 	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
 }
@@ -1104,6 +1122,9 @@ void __init trap_init(void)
 	register_kernel_break_hook(&fault_break_hook);
 #ifdef CONFIG_KASAN_SW_TAGS
 	register_kernel_break_hook(&kasan_break_hook);
+#endif
+#ifdef CONFIG_UBSAN_TRAP
+	register_kernel_break_hook(&ubsan_break_hook);
 #endif
 	debug_traps_init();
 }
diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
new file mode 100644
index 000000000000..bff7445498de
--- /dev/null
+++ b/include/linux/ubsan.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UBSAN_H
+#define _LINUX_UBSAN_H
+
+#ifdef CONFIG_UBSAN_TRAP
+const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type);
+#endif
+
+#endif
diff --git a/lib/Makefile b/lib/Makefile
index 4d9461bfea42..81b988bf9448 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -340,9 +340,7 @@ quiet_cmd_build_OID_registry = GEN     $@
 clean-files	+= oid_registry_data.c
 
 obj-$(CONFIG_UCS2_STRING) += ucs2_string.o
-ifneq ($(CONFIG_UBSAN_TRAP),y)
 obj-$(CONFIG_UBSAN) += ubsan.o
-endif
 
 UBSAN_SANITIZE_ubsan.o := n
 KASAN_SANITIZE_ubsan.o := n
diff --git a/lib/ubsan.c b/lib/ubsan.c
index 60c7099857a0..f05ae85fc268 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -18,6 +18,71 @@
 
 #include "ubsan.h"
 
+#ifdef CONFIG_UBSAN_TRAP
+/*
+ * Only include matches for UBSAN checks that are actually compiled in.
+ * The mappings of struct SanitizerKind (the -fsanitize=xxx args) to
+ * enum SanitizerHandler (the traps) in Clang is in clang/lib/CodeGen/.
+ */
+const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
+{
+	switch (check_type) {
+#ifdef CONFIG_UBSAN_BOUNDS
+	/*
+	 * SanitizerKind::ArrayBounds and SanitizerKind::LocalBounds
+	 * emit SanitizerHandler::OutOfBounds.
+	 */
+	case ubsan_out_of_bounds:
+		return "UBSAN: array index out of bounds";
+#endif
+#ifdef CONFIG_UBSAN_SHIFT
+	/*
+	 * SanitizerKind::ShiftBase and SanitizerKind::ShiftExponent
+	 * emit SanitizerHandler::ShiftOutOfBounds.
+	 */
+	case ubsan_shift_out_of_bounds:
+		return "UBSAN: shift out of bounds";
+#endif
+#ifdef CONFIG_UBSAN_DIV_ZERO
+	/*
+	 * SanitizerKind::IntegerDivideByZero emits
+	 * SanitizerHandler::DivremOverflow.
+	 */
+	case ubsan_divrem_overflow:
+		return "UBSAN: divide/remainder overflow";
+#endif
+#ifdef CONFIG_UBSAN_UNREACHABLE
+	/*
+	 * SanitizerKind::Unreachable emits
+	 * SanitizerHandler::BuiltinUnreachable.
+	 */
+	case ubsan_builtin_unreachable:
+		return "UBSAN: unreachable code";
+#endif
+#if defined(CONFIG_UBSAN_BOOL) || defined(CONFIG_UBSAN_ENUM)
+	/*
+	 * SanitizerKind::Bool and SanitizerKind::Enum emit
+	 * SanitizerHandler::LoadInvalidValue.
+	 */
+	case ubsan_load_invalid_value:
+		return "UBSAN: loading invalid value";
+#endif
+#ifdef CONFIG_UBSAN_ALIGNMENT
+	/*
+	 * SanitizerKind::Alignment emits SanitizerHandler::TypeMismatch
+	 * or SanitizerHandler::AlignmentAssumption.
+	 */
+	case ubsan_alignment_assumption:
+		return "UBSAN: alignment assumption";
+	case ubsan_type_mismatch:
+		return "UBSAN: type mismatch";
+#endif
+	default:
+		return "UBSAN: unrecognized failure code";
+	}
+}
+
+#else
 static const char * const type_check_kinds[] = {
 	"load of",
 	"store to",
@@ -384,3 +449,5 @@ void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
 	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_alignment_assumption);
+
+#endif /* !CONFIG_UBSAN_TRAP */
diff --git a/lib/ubsan.h b/lib/ubsan.h
index 9a0b71c5ff9f..cc5cb94895a6 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -2,6 +2,38 @@
 #ifndef _LIB_UBSAN_H
 #define _LIB_UBSAN_H
 
+/*
+ * ABI defined by Clang's UBSAN enum SanitizerHandler:
+ * https://github.com/llvm/llvm-project/blob/release/16.x/clang/lib/CodeGen/CodeGenFunction.h#L113
+ */
+enum ubsan_checks {
+	ubsan_add_overflow,
+	ubsan_builtin_unreachable,
+	ubsan_cfi_check_fail,
+	ubsan_divrem_overflow,
+	ubsan_dynamic_type_cache_miss,
+	ubsan_float_cast_overflow,
+	ubsan_function_type_mismatch,
+	ubsan_implicit_conversion,
+	ubsan_invalid_builtin,
+	ubsan_invalid_objc_cast,
+	ubsan_load_invalid_value,
+	ubsan_missing_return,
+	ubsan_mul_overflow,
+	ubsan_negate_overflow,
+	ubsan_nullability_arg,
+	ubsan_nullability_return,
+	ubsan_nonnull_arg,
+	ubsan_nonnull_return,
+	ubsan_out_of_bounds,
+	ubsan_pointer_overflow,
+	ubsan_shift_out_of_bounds,
+	ubsan_sub_overflow,
+	ubsan_type_mismatch,
+	ubsan_alignment_assumption,
+	ubsan_vla_bound_not_positive,
+};
+
 enum {
 	type_kind_int = 0,
 	type_kind_float = 1,
-- 
2.34.1

