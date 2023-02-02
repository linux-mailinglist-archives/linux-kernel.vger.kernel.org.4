Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B06889EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjBBWhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjBBWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:37:08 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF3C6FD17
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:37:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso3223017pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kk/Ds3iYO+g06J9MUaCKbpwM63c3pdWiJdifunw5dWQ=;
        b=dCC8xtWdTZPk1FSxAoDo4A1N2P49Lt033efUoRwLNaCoK351wo3tgOj2iqOSGKDzzB
         Tnwom7S52nd61fXeCiAjvdEophzja9Qp2yLSVPjeYtaoSu9T8HMk8kZkWFxKwjoXWdkP
         N/mkhBkJegjPQVzfp4FsypiH0CoqgcXls1tww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kk/Ds3iYO+g06J9MUaCKbpwM63c3pdWiJdifunw5dWQ=;
        b=QDqnIzVsdtnoI55VOnyPbSzsZnx88GJyT8DOF459Ino1ORDJoGGq/NI+Ib7GRWgSgz
         heeDX/Q8Bq/jFfZ+qL/cknTi34uAk0rN+nmBYq1Z5dBy/FsaZE/3WsYH8Rn3vI2P+a5k
         5x0s7g59EWGVpb6h5kcEEaKTFTM115X8Plq7R23tO+z1ICj3JvzfcZaUn3GnilIPIQTN
         rTi90B3AvL0SwJ8tbeMqjhRoYenGTwNVKegzx3QibjpbB12Zv6gaAdqYqEbvplR6rrgK
         tZolXer6G0xK1gXhRXo6KKeCMV1UFtRlQjOwSMTJjLxkFncNmfdtE1kgSO46F9FW1nF8
         1o7g==
X-Gm-Message-State: AO0yUKW2/0b7GGEPm3xKyNCgjFkIk+igOBO/16yBX0iJ/f2uOCPXPIRh
        w7BwQ4s99B2wPMBnFOUkexyqng==
X-Google-Smtp-Source: AK7set9JlDQsFrYkTDmC/uB02/oD+EShFPQ3lrUxnvCVhcJ3QTiYgMV1IcQl/5YkPXJkvIj3t8JsNg==
X-Received: by 2002:a17:902:da82:b0:198:9fc3:c2ce with SMTP id j2-20020a170902da8200b001989fc3c2cemr11522814plx.19.1675377422024;
        Thu, 02 Feb 2023 14:37:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b00189393ab02csm180192plb.99.2023.02.02.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:37:01 -0800 (PST)
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
Subject: [PATCH] arm64: Support Clang UBSAN trap codes for better reporting
Date:   Thu,  2 Feb 2023 22:36:57 +0000
Message-Id: <20230202223653.never.473-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7316; h=from:subject:message-id; bh=YbqhocLJrgfNPtk/T1ThzmlG3z+EMOKbLsgT1fxlYXg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3DsJUA0fBD2Hch7KojM8hA+ZWcbm3riOZ43gG69B uQXvXyOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9w7CQAKCRCJcvTf3G3AJoL+EA CF127TwM1aMAmOFNz74XWQ4yu/SwAN6w4ZHfB5/rHfvZk9wipkYZ+Lp/Jli9WwffJG4hZIfTQEGn+K ehHnUG4I/genp+deM4qldZ11xgnGA9O7bG95DAH7ttZ9j1tb7jrluWQiODcA0R1CY91hnsmIMAKBxP yg9MeRBAitq8P0GuVjZ/K9Y0Dr2XfUfcnaC/YFOWrHhTjGornHRWsaHFSLRWsl3ln5fsyH7pe3yKFf L64E1poouR0VJui+gNDD1+ZBi268AraC5pT0VhxJuVlttP2TygERukflloQV8DpP9rziNo4FrNDQpI 9d1UfXNK0ZCcl0JBOKb8GlQzbbd+Fr8/Y4spL9E5LJBFGn4YEA1C8udJoTD1Wfd/xFZjv5VNHm0m14 /pBkHBlrAC9xtYYwA6s/drXtrL34GJr3co0W09zBlGd4z8jeiZPChaw78VA8ehIJoShVhymseOZWiN UIJ2pEXf85Mabxn5B8IMSZdQFVdf3QlkOkBev/SJG5ztCYOG3Vx4DvXpmqpQPTNtgNF78Mmmt69ZvF gC+Nz8KIwpPTp6qXkniUaiwJAd09Yu8wWuceUqqiJf16pf6sQvG8USoBON8jSBxj59s8NhvvkbryQH 5lz/EnaRSUzvy0oNFgIrE7/LpqQc3v5em+KLQqFQaCw3mS8VTNU1yHgHnDcg==
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

On arm64, Clang encodes the UBSAN check type in the esr. Extract this
and actually report UBSAN traps with some specificity when building with
CONFIG_UBSAN_TRAP. Before:

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
 arch/arm64/include/asm/brk-imm.h |  2 ++
 arch/arm64/kernel/traps.c        | 21 +++++++++++++
 include/linux/ubsan.h            |  9 ++++++
 lib/Makefile                     |  2 --
 lib/ubsan.c                      | 54 ++++++++++++++++++++++++++++++++
 lib/ubsan.h                      | 28 +++++++++++++++++
 6 files changed, 114 insertions(+), 2 deletions(-)
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
index 60c7099857a0..98a671ec56e9 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -18,6 +18,58 @@
 
 #include "ubsan.h"
 
+#ifdef CONFIG_UBSAN_TRAP
+const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
+{
+	switch (check_type) {
+	case ubsan_add_overflow:
+		return "UBSAN: addition overflow";
+	case ubsan_builtin_unreachable:
+		return "UBSAN: unreachable code";
+	case ubsan_cfi_check_fail:
+		return "UBSAN: CFI failure";
+	case ubsan_divrem_overflow:
+		return "UBSAN: divide/remainder overflow";
+	case ubsan_function_type_mismatch:
+		return "UBSAN: function type mismatch";
+	case ubsan_implicit_conversion:
+		return "UBSAN: implicit conversion";
+	case ubsan_invalid_builtin:
+		return "UBSAN: invalid builtin";
+	case ubsan_invalid_objc_cast:
+		return "UBSAN: invalid object cast";
+	case ubsan_load_invalid_value:
+		return "UBSAN: loading invalid value";
+	case ubsan_missing_return:
+		return "UBSAN: missing return";
+	case ubsan_mul_overflow:
+		return "UBSAN: multiplication overflow";
+	case ubsan_negate_overflow:
+		return "UBSAN: negation overflow";
+	case ubsan_nonnull_arg:
+		return "UBSAN: non-NULL argument";
+	case ubsan_nonnull_return:
+		return "UBSAN: non-NULL return";
+	case ubsan_out_of_bounds:
+		return "UBSAN: array index out of bounds";
+	case ubsan_pointer_overflow:
+		return "UBSAN: pointer overflow";
+	case ubsan_shift_out_of_bounds:
+		return "UBSAN: shift out of bounds";
+	case ubsan_sub_overflow:
+		return "UBSAN: subtraction overflow";
+	case ubsan_type_mismatch:
+		return "UBSAN: type mismatch";
+	case ubsan_alignment_assumption:
+		return "UBSAN: alignment assumption";
+	case ubsan_vla_bound_not_positive:
+		return "UBSAN: VLA bounds not positive";
+	default:
+		return "UBSAN: unknown failure";
+	}
+}
+
+#else
 static const char * const type_check_kinds[] = {
 	"load of",
 	"store to",
@@ -384,3 +436,5 @@ void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
 	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_alignment_assumption);
+
+#endif /* !CONFIG_UBSAN_TRAP */
diff --git a/lib/ubsan.h b/lib/ubsan.h
index 9a0b71c5ff9f..9c7f00f550f5 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -2,6 +2,34 @@
 #ifndef _LIB_UBSAN_H
 #define _LIB_UBSAN_H
 
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

