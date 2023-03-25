Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DED76C8C5B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjCYIMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjCYIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:12:18 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06BD19C45;
        Sat, 25 Mar 2023 01:12:13 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h9so3931665ljq.2;
        Sat, 25 Mar 2023 01:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679731932;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A4XgPFdc/okcXx2NbhmBkGOEY1T8HTI/lZkH2CUhYRE=;
        b=C//SxJywjFJCBim3f6DyMsplXjZ4WAJfXUaNGINYm4lfjGjLMUse/uAxgZciltCCWG
         7S8tbz/Pj9CzPyyRLzphy/aYo1cmxLBKEvSZNTJ3s77/GiDHzGgq36oQzc7DsNV5c8OC
         CBFltmG8eP3gwIxGF9+ZWZligefahxMz9ar3bYi/F05sxnoRpaLFxbxRZOJIb6g14vWf
         JD33Qp3p0ULL7MRGoDYX7Dnh/9Ccxpepq9E1jVeBH4KAtXzeJNkJIuzl1KaMo+iPJyvt
         oR6vJYg0YYLzW2xlrQxMJ2w3MJGVhLkkCWiDUnu5LzAahvJAvpz44zYMUehRXL0AQAeZ
         tpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679731932;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4XgPFdc/okcXx2NbhmBkGOEY1T8HTI/lZkH2CUhYRE=;
        b=Sa6UsmCeVpZ7p/OvFCMFsJ+QOWbhsZJPf/t6nyO7xkemd7+GbA9m3Gf4Mu2NreqToY
         +LiOUtiP01Rmclz8k99MPbD4k0Thdzm9xHRtZehZ6VjbPxrj5pYrw1ZsUBn48kygFz+S
         mW60dzkY0jsZrz7VSuoH93jk4iOAyEPX06IooSFuQB3SqYkiQ072EfWiMrgxXIItjD8U
         o42SrAtJ1Awx4m32uS5MpA3bgtupQYylFsfqCif9lHhyUIsK997lKaE50FLimRlM9jUQ
         DAVtRkb9uY2WKznIoI/Jn040rcMglYG/sh2K6Qn8yZNhiOzjaFqidfec43ucDH7U4p9+
         qZbw==
X-Gm-Message-State: AAQBX9fKR4aAymFqhgqST71sC/KsTH7DyG0VW1//mC6COXe6/aomMQGf
        XoN4dex3CVtzXi7fJXgXP/I=
X-Google-Smtp-Source: AKy350ZSw9H6KrkYhnBYCdWvbVd4OQ5MwkUCRpmMI4PZZlLnyTuRn6CcIDCfClOBlNuS/0x5UHLXiA==
X-Received: by 2002:a2e:8604:0:b0:290:5166:7c28 with SMTP id a4-20020a2e8604000000b0029051667c28mr2010774lji.20.1679731931733;
        Sat, 25 Mar 2023 01:12:11 -0700 (PDT)
Received: from localhost ([188.119.65.94])
        by smtp.gmail.com with ESMTPSA id s24-20020a2e98d8000000b002996e0e6461sm3715162ljj.29.2023.03.25.01.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Mar 2023 01:12:11 -0700 (PDT)
From:   Dan Li <ashimida.1990@gmail.com>
To:     gcc-patches@gcc.gnu.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [RFC/RFT,V2 3/3] [PR102768] aarch64: Add support for Kernel Control Flow Integrity
Date:   Sat, 25 Mar 2023 01:11:17 -0700
Message-Id: <20230325081117.93245-4-ashimida.1990@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230325081117.93245-1-ashimida.1990@gmail.com>
References: <20221219055431.22596-1-ashimida.1990@gmail.com>
 <20230325081117.93245-1-ashimida.1990@gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the AArch64 platform, typeid can be directly inserted in front
of the function header (offset is patch_area_entry + 4), it should
be assumed that patch_area_entry is the same for all functions.

For all functions that will not be called indirectly, insert the
reserved RESERVED_CFI_TYPEID (0x0) as typeid in front of them. If
not, the attacker may use the instruction/data before the function
as typeid to bypass CFI.

All typeids ignore some bits (& AARCH64_UNALLOCATED_INSN_MASK) to
avoid conflicts with the AArch64 instruction set (see AAPCS64 for
details).

Signed-off-by: Dan Li <ashimida.1990@gmail.com>

gcc/ChangeLog:

	* config/aarch64/aarch64.cc (RESERVED_CFI_TYPEID): Macro definition.
	(DEFAULT_CFI_TYPEID): Likewise.
	(AARCH64_UNALLOCATED_INSN_MASK): Likewise.
	(aarch64_calc_func_cfi_typeid): Platform-dependent CFI function.
	(cgraph_indirectly_callable): Determine whether a funtion may
	be called indirectly.
	(aarch64_output_func_kcfi_typeid): Platform-dependent CFI function.
	(aarch64_output_icall_kcfi_check): Likewise.
	(TARGET_HAVE_KCFI): New hook.
	(TARGET_CALC_FUNC_CFI_TYPEID): Likewise.
	(TARGET_ASM_OUTPUT_FUNC_KCFI_TYPEID): Likewise.
	(TARGET_ASM_OUTPUT_ICALL_KCFI_CHECK): Likewise.
	* doc/invoke.texi: Document -fsanitize=kcfi.
---
 gcc/config/aarch64/aarch64.cc | 166 ++++++++++++++++++++++++++++++++++
 gcc/doc/invoke.texi           |  36 ++++++++
 2 files changed, 202 insertions(+)

diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64.cc
index 5c9e7791a12..5b55541d437 100644
--- a/gcc/config/aarch64/aarch64.cc
+++ b/gcc/config/aarch64/aarch64.cc
@@ -5450,6 +5450,160 @@ aarch64_output_sve_addvl_addpl (rtx offset)
   return buffer;
 }
 
+/* Reserved for all functions that cannot be called indirectly.  */
+#define RESERVED_CFI_TYPEID 0x0U
+
+/* If the typeid of a function that can be called indirectly is equal to
+   RESERVED_CFI_TYPEID, change it to DEFAULT_CFI_TYPEID.  */
+#define DEFAULT_CFI_TYPEID 0x00000ADAU
+
+/* Mask of reserved and unallocated instructions in AArch64 platform.  */
+#define AARCH64_UNALLOCATED_INSN_MASK 0xE7FFFFFFU
+
+static unsigned int
+aarch64_calc_func_cfi_typeid (const_tree fntype)
+{
+  unsigned int hash;
+
+  /* The value of typeid has a probability of being the same as the encoding
+     of an instruction.  If the attacker can find the same encoding as the
+     typeid in the assembly code, then he has found a usable jump location.
+     So here, a platform-related mask is used when generating a typeid to
+     avoid such conflicts as much as possible.  */
+  hash = unified_type_hash (fntype) & AARCH64_UNALLOCATED_INSN_MASK;
+
+  /* RESERVED_CFI_TYPEID is reserved for functions that cannot
+     be called indirectly.  */
+  if (hash == RESERVED_CFI_TYPEID)
+    hash = DEFAULT_CFI_TYPEID;
+
+  return hash;
+}
+
+static bool
+cgraph_indirectly_callable (struct cgraph_node *node,
+			    void *data ATTRIBUTE_UNUSED)
+{
+  if (node->externally_visible || node->address_taken)
+    return true;
+
+  return false;
+}
+
+static void
+aarch64_output_func_kcfi_typeid (FILE * stream, tree decl)
+{
+  struct cgraph_node *node;
+  unsigned int cur_func_typeid;
+
+  node = cgraph_node::get (decl);
+
+  if (!node->call_for_symbol_thunks_and_aliases (cgraph_indirectly_callable,
+						 NULL, true))
+    /* CFI's typeid check always considers that there is a typeid before the
+       target function, so it is also necessary to output typeid for functions
+       that cannot be called indirectly to prevent attackers from bypassing
+       CFI by using instructions/data before those functions.
+       The typeid inserted before such a function is RESERVED_CFI_TYPEID,
+       and the calculation of the typeid must ensure that this value is always
+       reserved.  */
+    cur_func_typeid = RESERVED_CFI_TYPEID;
+  else
+    cur_func_typeid = aarch64_calc_func_cfi_typeid (TREE_TYPE (decl));
+
+  fprintf (stream, "__kcfi_%s:\n", get_name (decl));
+  fprintf (stream, "\t.4byte %#010x\n", cur_func_typeid);
+}
+
+/* This function outputs assembly instructions to check cfi typeid before
+   indirect call (blr Xn), which may destroy x16, x17, x9 registers (according
+   to the AAPCS64 specification, these registers do not need to be restored
+   after the function call).
+   The assembly code output by this function is as follows:
+	ldur    w16, [x1, #-4]
+	movk    w17, #13570
+	movk    w17, #17309, lsl #16
+	cmp     w16, w17
+	b.eq	.Lkcfi8
+	brk     #0x8221
+.Lkcfi8:
+	blr     x1
+ */
+
+static void
+aarch64_output_icall_kcfi_check (rtx reg, unsigned int value)
+{
+  unsigned int addr_reg, scratch_reg1, scratch_reg2;
+  unsigned int esr, addr_index, type_index;
+  char label_buf[256];
+  const char *label_ptr;
+  unsigned HOST_WIDE_INT patch_area_entry = crtl->patch_area_entry;
+  rtx_code_label * tmp_label = gen_label_rtx ();
+
+  gcc_assert (GET_CODE (reg) == REG);
+
+  addr_reg = REGNO (reg);
+
+  /* The typeid read from the front of the callee is saved in the
+     register specified by scratch_reg1, the default is R16_REGNUM.  */
+  scratch_reg1 = R16_REGNUM;
+
+  /* The expected typeid of the caller is saved in the register
+     specified by scratch_reg2, which defaults to R17_REGNUM.  */
+  scratch_reg2 = R17_REGNUM;
+
+  gcc_assert (GP_REGNUM_P (addr_reg));
+
+  /* If one of the scratch registers is used for the call target,
+     we can clobber another caller-saved temporary register instead
+     (in this case, R9_REGNUM) as the check is immediately followed
+     by the call instruction.  */
+  if (addr_reg == R16_REGNUM)
+    {
+      scratch_reg1 = R9_REGNUM;
+    }
+  else if (addr_reg == R17_REGNUM)
+    {
+      scratch_reg2 = R9_REGNUM;
+    }
+
+  gcc_assert ((scratch_reg1 != addr_reg) && (scratch_reg2 != addr_reg));
+
+  ASM_GENERATE_INTERNAL_LABEL (label_buf, "Lkcfi",
+			       CODE_LABEL_NUMBER (tmp_label));
+  label_ptr = targetm.strip_name_encoding (label_buf);
+
+  /* The offset of callee's typeid needs to be adjusted according to
+     patch_area_entry.  This assumes that patch_area_entry is the
+     same for all functions.  */
+  fprintf (asm_out_file, "\tldur\tw%d, [x%d, #-%ld]\n",
+	   scratch_reg1, addr_reg, patch_area_entry * 4 + 4);
+
+  fprintf (asm_out_file, "\tmovk\tw%d, #%d\n", scratch_reg2, value & 0xFFFF);
+
+  fprintf (asm_out_file, "\tmovk\tw%d, #%d, lsl #16\n",
+	   scratch_reg2, (value >> 16) & 0xFFFF);
+
+  fprintf (asm_out_file, "\tcmp\tw%d, w%d\n", scratch_reg1, scratch_reg2);
+
+  fprintf (asm_out_file, "\tb.eq\t%s\n", label_ptr);
+
+  /* The base ESR for brk is 0x8000 and the register information is
+     encoded in bits 0-9 as follows:
+     - 0-4: n, where the register Xn contains the callee address
+     - 5-9: m, where the register Wm contains the expected typeid
+     Where n, m are in[0,30].
+  */
+  addr_index = addr_reg - R0_REGNUM;
+  type_index = scratch_reg2 - R0_REGNUM;
+  esr = 0x8000 | ((type_index & 31) << 5) | (addr_index & 31);
+  fprintf (asm_out_file, "\tbrk\t#0x%x\n", esr);
+
+  fprintf (asm_out_file, "%s:\n", label_ptr);
+
+  return;
+}
+
 /* Return true if X is a valid immediate for an SVE vector INC or DEC
    instruction.  If it is, store the number of elements in each vector
    quadword in *NELTS_PER_VQ_OUT (if nonnull) and store the multiplication
@@ -27823,6 +27977,18 @@ aarch64_libgcc_floating_mode_supported_p
 #undef TARGET_HAVE_SHADOW_CALL_STACK
 #define TARGET_HAVE_SHADOW_CALL_STACK true
 
+#undef TARGET_HAVE_KCFI
+#define TARGET_HAVE_KCFI true
+
+#undef TARGET_CALC_FUNC_CFI_TYPEID
+#define TARGET_CALC_FUNC_CFI_TYPEID aarch64_calc_func_cfi_typeid
+
+#undef TARGET_ASM_OUTPUT_FUNC_KCFI_TYPEID
+#define TARGET_ASM_OUTPUT_FUNC_KCFI_TYPEID aarch64_output_func_kcfi_typeid
+
+#undef TARGET_ASM_OUTPUT_ICALL_KCFI_CHECK
+#define TARGET_ASM_OUTPUT_ICALL_KCFI_CHECK aarch64_output_icall_kcfi_check
+
 struct gcc_target targetm = TARGET_INITIALIZER;
 
 #include "gt-aarch64.h"
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index ff6c338bedb..1b2ba7a0f29 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -15736,6 +15736,42 @@ to turn off exceptions.
 See @uref{https://clang.llvm.org/docs/ShadowCallStack.html} for more
 details.
 
+@item -fsanitize=kcfi
+@opindex fsanitize=kcfi
+The KCFI sanitizer, enabled with @option{-fsanitize=kcfi}, implements a
+forward-edge control flow integrity scheme for indirect calls.  It
+attaches a type identifier (@code{typeid}) for each function and injects
+verification code before indirect calls.
+
+A @code{typeid} is a 32-bit constant, its value is mainly related to the
+return value type and all parameter types of the function, and is invariant
+for each compilation.  Since the value of @code{typeid} may conflict with
+the instruction set encoding of the current platform, some bits may be
+ignored on different platforms.
+
+At compile time, the compiler inserts checking code on all indirect calls,
+and at run time, before any indirect calls occur, the code checks that
+the @code{typeid} before the callee function matches the @code{typeid}
+requested by the caller.  If the match fails, an exception instruction
+will be triggered, such as a @code{brk} in aarch64.  This mechanism is
+mainly designed for low-level codes, such as operating systems, and the
+system needs to handle those exceptions by itself.
+
+If a program contains indirect calls to assembly functions, they must be
+manually annotated with the expected type identifiers to prevent errors.
+To make this easier, CFI generates a weak SHN_ABS
+@code{__kcfi_typeid_<function>} symbol for each address-taken function
+declaration, which can be used to annotate functions in assembly as long
+as at least one C translation unit linked into the program takes the
+function address.
+
+Currently this feature only supports the aarch64 platform, mainly for
+the linux kernel.  Users who want to use this feature in other system
+need to provide their own support for the exception handling.
+
+See @uref{https://clang.llvm.org/docs/ControlFlowIntegrity.html} for
+more details.
+
 @item -fsanitize=thread
 @opindex fsanitize=thread
 Enable ThreadSanitizer, a fast data race detector.
-- 
2.17.1

