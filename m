Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848986C8C59
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCYIMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCYIMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:12:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B50B199FB;
        Sat, 25 Mar 2023 01:12:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q16so5029253lfe.10;
        Sat, 25 Mar 2023 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679731928;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EVI9PWrKbiIeMx1fc+DQNAlugQQC+++yZf4X1+sPcKM=;
        b=hjfHrMT/QpQ535X2IHAQ44I7wBRl3GBS4HmqvKMwAftMwOjxkht4kQIPzaygOfBsUJ
         cISDeE0Al1Zn5WFXtKF0+3D3iWFYkMaH4UeLc2l2IaBNPgsBfvBh5HulDBOT7dRxdRx0
         O2L6s4+Qb31BJX+J4CaIC+jViQqTuLT4yBQGxc5+xesgo/yrAvE0usqjsHZhMPGdxYwP
         vigo8z0GBPMXHlPoMzLlvFQ1ejlKITltpW1ys/ekJRmwmE4ycky4EuB4yVAf9BxvRJ9n
         KVUaxjZcu4PCZHRa5kgvgqtosF4AHsoMmPiG+UUahpSbsK4Bcb8HJidrbTWd41zldDAl
         O4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679731928;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVI9PWrKbiIeMx1fc+DQNAlugQQC+++yZf4X1+sPcKM=;
        b=JDDtPD/jI/c3uG1k0ul9Lf/PxhgWaZ/Q6DplslTZ1qs8UJJWhiyJ+tMiaIM2JrrgaU
         fUZZNQH4SYac3sC87y748i7SM91yUYBCceu0nhsysmlO1BjAZfyveE5QelgWeq81B/wd
         UgRKLwutijR8gTYMpGn9T354cp8B6rCuJKWhbV1lBV9F/JJA3Uh9e1GF+3LIm8e4WV4D
         bNc6nnyhIJHWy7hsWsqb1MG6Zww86MSJqD8Mh8iay89O/GY6Sr1U8Hg8GgPhibZVyEil
         H7rEd2dxqRiPXrgPm/oSqjaxt0zy1EoO6y/gGP/ojkcBwYXkY+qSpD/O0WqWdwkbGbWQ
         luiA==
X-Gm-Message-State: AAQBX9cSsZ1FSxgZUh5oTzIIqIYhlhXDveimopp3X7eko2RxGLiMXgo4
        9xenB/BUEewi8D74HIbsk+o=
X-Google-Smtp-Source: AKy350bOHmxFgYjTkNLXepFjdXDkXz8dNiLSKQl0DJYFKEJ+rcFDFbvCvJsVCcqcLUTwmZZDK41N8A==
X-Received: by 2002:ac2:5239:0:b0:4dd:afad:8afe with SMTP id i25-20020ac25239000000b004ddafad8afemr1441964lfl.27.1679731927532;
        Sat, 25 Mar 2023 01:12:07 -0700 (PDT)
Received: from localhost ([188.119.65.94])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004db0d97b053sm3723681lfh.137.2023.03.25.01.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Mar 2023 01:12:07 -0700 (PDT)
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
Subject: [RFC/RFT,V2 2/3] [PR102768] Support CFI: Add basic support for Kernel Control Flow Integrity
Date:   Sat, 25 Mar 2023 01:11:16 -0700
Message-Id: <20230325081117.93245-3-ashimida.1990@gmail.com>
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

The KCFI sanitizer enabled with -fsanitize=kcfi implements a forward
edge control flow integrity scheme for indirect calls, similar to
-fsanitize=kcfi [1] in llvm.

At compile time, it appends a uniform type identifier before the
first instruction of each function and inserts check code before
each indirect call in a function with protection enabled.

At runtime, according to the code order, the check code for each
indirect call will be executed first, and it will:
1. Dynamically obtain the typeid before the callee function.
2. Compare it to the expected typeid of the current call site (caller).
3. If the two match, continue to execute the indirect call, if not,
an exception will be generated, and its user (usually the low-level
code such as the OS kernel) needs to support for the exception handling.

A typeid (type identifier) is a 32-bit constant on all platforms,
whose value depends on the function's prototype, and is invariant
across compilation units. However, different platforms may ignore
some of the bits to avoid conflicts with instructions.

If a program contains indirect calls to assembly functions, they
must be manually annotated with the expected type identifiers to
prevent errors. To make this easier, gcc generates a weak SHN_ABS
__kcfi_typeid_<function> symbol for each address-taken function
declaration, which can be used to annotate functions in assembly
as long as at least one translation unit linked into the program
takes the function address. It should be noted that on different
platforms, the location of typeid insertion (the offset between
it and the function header) may be different, such as [1], and
this patch only implements the platform-independent part.

[1]: https://reviews.llvm.org/D119296

Signed-off-by: Dan Li <ashimida.1990@gmail.com>

gcc/ChangeLog:

	PR c/102768
	* cfgexpand.cc (expand_call_stmt): Add CFI_TYPEID reg note
	for call insn.
	(pass_expand::execute): Check whether enable KCFI for current
	function according to the attribute.
	* cgraphunit.cc (output_decl_kcfi_typeid_symbol): Output the
	CFI typeid corresponding to each external declaration when necessary.
	(output_decl_kcfi_typeid_symbols): Likewise.
	* combine.cc (distribute_notes): Add REG_CALL_CFI_TYPEID.
	* doc/tm.texi: Regenerate.
	* doc/tm.texi.in: New hooks.
	* emit-rtl.cc (try_split): Add REG_CALL_CFI_TYPEID.
	* emit-rtl.h (struct rtl_data): Add is_kcfi_enabled.
	* final.cc (final_scan_insn_1): Output kcfi check for indirect calls.
	* flag-types.h (enum sanitize_code):
	Add SANITIZE_CONTROL_FLOW_INTEGRITY.
	* gimple.cc (gimple_call_set_cfi_typeid): New.
	(gimple_build_call_1): Calculate cfi_typeid when gcall is created.
	* gimple.h (struct GTY): Add new member cfi_typeid for gcall.
	* opts.cc (parse_sanitizer_options): Add cfi and exclude
	SANITIZE_CONTROL_FLOW_INTEGRITY.
	* output.h (default_output_func_kcfi_typeid): Declare.
	(default_output_icall_kcfi_check): Declare.
	(default_calc_func_cfi_typeid): Declare.
	* reg-notes.def (REG_NOTE): Add new REG_NOTE CALL_CFI_TYPEID.
	* target.def: Add new hooks.
	* toplev.cc (process_options): Add CFI compile option check.
	* tree.cc (tree_node_sizes[): Add the unified tree type hash
	calculation functions.
	(append_unified_type_hash): Likewise.
	(initialize_unified_tree_type_hash_table): Likewise.
	(append_unified_type_name_hash): Likewise.
	(append_unified_type_precision_hash): Likewise.
	(append_unified_function_ret_and_args_hash): Likewise.
	(unified_type_hash): Likewise.
	(init_ttree): Likewise.
	* tree.h (unified_type_hash): Declare.
	* varasm.cc (assemble_start_function): Output the CFI typeid
	of each function.
	(default_output_func_kcfi_typeid): New.
	(default_output_icall_kcfi_check): New.
	(default_calc_func_cfi_typeid): New.
---
 gcc/cfgexpand.cc   |  26 ++++++++
 gcc/cgraphunit.cc  |  34 +++++++++++
 gcc/combine.cc     |   1 +
 gcc/doc/tm.texi    |  27 +++++++++
 gcc/doc/tm.texi.in |   8 +++
 gcc/emit-rtl.cc    |   1 +
 gcc/emit-rtl.h     |   4 ++
 gcc/final.cc       |  24 +++++++-
 gcc/flag-types.h   |   2 +
 gcc/gimple.cc      |  11 ++++
 gcc/gimple.h       |   5 +-
 gcc/opts.cc        |   4 +-
 gcc/output.h       |   3 +
 gcc/reg-notes.def  |   1 +
 gcc/target.def     |  38 ++++++++++++
 gcc/toplev.cc      |   4 ++
 gcc/tree.cc        | 144 +++++++++++++++++++++++++++++++++++++++++++++
 gcc/tree.h         |   1 +
 gcc/varasm.cc      |  26 ++++++++
 19 files changed, 361 insertions(+), 3 deletions(-)

diff --git a/gcc/cfgexpand.cc b/gcc/cfgexpand.cc
index d3cc77d2ca9..69c5fa30c7e 100644
--- a/gcc/cfgexpand.cc
+++ b/gcc/cfgexpand.cc
@@ -2845,6 +2845,18 @@ expand_call_stmt (gcall *stmt)
 	add_reg_note (last, REG_CALL_NOCF_CHECK, const0_rtx);
     }
 
+  if (flag_sanitize & SANITIZE_KERNEL_CONTROL_FLOW_INTEGRITY)
+    {
+      rtx_insn *last = get_last_insn ();
+      rtx datum = gen_rtx_CONST_INT (SImode, stmt->cfi_typeid);
+      while (!CALL_P (last)
+	     && last != before_call)
+	last = PREV_INSN (last);
+
+      if (last != before_call)
+	add_reg_note (last, REG_CALL_CFI_TYPEID, datum);
+    }
+
   mark_transaction_restart_calls (stmt);
 }
 
@@ -6923,10 +6935,16 @@ pass_expand::execute (function *fun)
   if (crtl->tail_call_emit)
     fixup_tail_calls ();
 
+  crtl->is_kcfi_enabled
+    = sanitize_flags_p (SANITIZE_KERNEL_CONTROL_FLOW_INTEGRITY,
+			current_function_decl);
+
   HOST_WIDE_INT patch_area_size, patch_area_entry;
   parse_and_check_patch_area (flag_patchable_function_entry, false,
 			      &patch_area_size, &patch_area_entry);
 
+  HOST_WIDE_INT patch_area_entry_org = patch_area_entry;
+
   tree patchable_function_entry_attr
     = lookup_attribute ("patchable_function_entry",
 			DECL_ATTRIBUTES (cfun->decl));
@@ -6954,6 +6972,14 @@ pass_expand::execute (function *fun)
       patch_area_entry = 0;
     }
 
+  if (crtl->is_kcfi_enabled
+      && (patch_area_entry_org != patch_area_entry))
+    {
+      error_at (DECL_SOURCE_LOCATION (current_function_decl),
+		"%<-fsanitize=kcfi%> conflict with attribute "
+		"%<patchable_function_entry%>");
+    }
+
   crtl->patch_area_size = patch_area_size;
   crtl->patch_area_entry = patch_area_entry;
 
diff --git a/gcc/cgraphunit.cc b/gcc/cgraphunit.cc
index 76d541755b8..23275b5ed36 100644
--- a/gcc/cgraphunit.cc
+++ b/gcc/cgraphunit.cc
@@ -2222,6 +2222,37 @@ ipa_passes (void)
   bitmap_obstack_release (NULL);
 }
 
+/* Output a weak symbol value of a decl's typeid (hash) to the
+   assembly file, like:
+	.weak __kcfi_typeid_A
+	.set __kcfi_typeid_A, 0x00000ADA
+   typeid is platform-dependent, because the bits in typeid that conflicts
+   with the instruction set of the current platform needs to be ignored.  */
+
+static void
+output_decl_kcfi_typeid_symbol (FILE *stream, tree fndecl)
+{
+  unsigned int hash = targetm.calc_func_cfi_typeid (TREE_TYPE (fndecl));
+  const char *name = IDENTIFIER_POINTER (DECL_NAME (fndecl));
+
+  fprintf (stream, ".weak __kcfi_typeid_%s\n", name);
+  fprintf (stream, ".set __kcfi_typeid_%s, %#010x\n", name, hash);
+}
+
+/* Calculate and output the symbols corresponding to the typeid of all
+   external declarations whose address is taken within the current
+   compilation unit.  If such a function is defined in assembly code,
+   its typeid can be obtained according to this symbol.  */
+
+static void
+output_decl_kcfi_typeid_symbols (void)
+{
+  struct cgraph_node *node;
+
+  FOR_EACH_FUNCTION (node)
+    if (!node->definition && node->address_taken)
+      output_decl_kcfi_typeid_symbol (asm_out_file, node->decl);
+}
 
 /* Weakrefs may be associated to external decls and thus not output
    at expansion time.  Emit all necessary aliases.  */
@@ -2339,6 +2370,9 @@ symbol_table::compile (void)
       }
 #endif
 
+  if (flag_sanitize & SANITIZE_KERNEL_CONTROL_FLOW_INTEGRITY)
+    output_decl_kcfi_typeid_symbols ();
+
   state = EXPANSION;
 
   /* Output first asm statements and anything ordered. The process
diff --git a/gcc/combine.cc b/gcc/combine.cc
index 9a34ef847aa..ddba4b2ed7d 100644
--- a/gcc/combine.cc
+++ b/gcc/combine.cc
@@ -14273,6 +14273,7 @@ distribute_notes (rtx notes, rtx_insn *from_insn, rtx_insn *i3, rtx_insn *i2,
 	case REG_SETJMP:
 	case REG_TM:
 	case REG_CALL_DECL:
+	case REG_CALL_CFI_TYPEID:
 	case REG_UNTYPED_CALL:
 	case REG_CALL_NOCF_CHECK:
 	  /* These notes must remain with the call.  It should not be
diff --git a/gcc/doc/tm.texi b/gcc/doc/tm.texi
index c5006afc00d..d7e406f3386 100644
--- a/gcc/doc/tm.texi
+++ b/gcc/doc/tm.texi
@@ -1003,6 +1003,14 @@ Return a value, with the same meaning as the C99 macro
 @code{FLT_EVAL_METHOD} that describes which excess precision should be
 applied.
 
+@deftypefn {Target Hook} {unsigned int} TARGET_CALC_FUNC_CFI_TYPEID (const_tree @var{fntype})
+This target hook is used to calculate a platform-dependent typeid
+of a function.
+Although the length of typeid is always 4 bytes on all platforms, different
+platforms may ignore some bits to avoid encoding conflicts with it's
+instruction set, so a platform-dependent function is required.
+@end deftypefn
+
 @deftypefn {Target Hook} machine_mode TARGET_PROMOTE_FUNCTION_MODE (const_tree @var{type}, machine_mode @var{mode}, int *@var{punsignedp}, const_tree @var{funtype}, int @var{for_return})
 Like @code{PROMOTE_MODE}, but it is applied to outgoing function arguments or
 function return values.  The target hook should return the new mode
@@ -8721,6 +8729,20 @@ global; that is, available for reference from other files.
 The default implementation uses the TARGET_ASM_GLOBALIZE_LABEL target hook.
 @end deftypefn
 
+@deftypefn {Target Hook} void TARGET_ASM_OUTPUT_FUNC_KCFI_TYPEID (FILE *@var{stream}, tree @var{decl})
+This target hook is used to output a function's typeid before
+its assembly code.
+For different platforms, the output format of typeid may be different,
+so a platform-dependent function is required.
+@end deftypefn
+
+@deftypefn {Target Hook} void TARGET_ASM_OUTPUT_ICALL_KCFI_CHECK (rtx @var{reg}, unsigned int @var{value})
+This target hook is used to output the assembly codes to check the
+callee's typeid before an indirect call.
+For different platforms, the location of typeid may be different,
+so a platform-dependent function is required.
+@end deftypefn
+
 @deftypefn {Target Hook} void TARGET_ASM_ASSEMBLE_UNDEFINED_DECL (FILE *@var{stream}, const char *@var{name}, const_tree @var{decl})
 This target hook is a function to output to the stdio stream
 @var{stream} some commands that will declare the name associated with
@@ -12608,3 +12630,8 @@ type.
 This value is true if the target platform supports
 @option{-fsanitize=shadow-call-stack}.  The default value is false.
 @end deftypevr
+
+@deftypevr {Target Hook} bool TARGET_HAVE_KCFI
+This value is true if the target platform supports
+@option{-fsanitize=kcfi}.  The default value is false.
+@end deftypevr
diff --git a/gcc/doc/tm.texi.in b/gcc/doc/tm.texi.in
index f869ddd5e5b..424d6ecd435 100644
--- a/gcc/doc/tm.texi.in
+++ b/gcc/doc/tm.texi.in
@@ -933,6 +933,8 @@ Return a value, with the same meaning as the C99 macro
 @code{FLT_EVAL_METHOD} that describes which excess precision should be
 applied.
 
+@hook TARGET_CALC_FUNC_CFI_TYPEID
+
 @hook TARGET_PROMOTE_FUNCTION_MODE
 
 @defmac PARM_BOUNDARY
@@ -5568,6 +5570,10 @@ You may wish to use @code{ASM_OUTPUT_SIZE_DIRECTIVE} and/or
 
 @hook TARGET_ASM_GLOBALIZE_DECL_NAME
 
+@hook TARGET_ASM_OUTPUT_FUNC_KCFI_TYPEID
+
+@hook TARGET_ASM_OUTPUT_ICALL_KCFI_CHECK
+
 @hook TARGET_ASM_ASSEMBLE_UNDEFINED_DECL
 
 @defmac ASM_WEAKEN_LABEL (@var{stream}, @var{name})
@@ -8183,3 +8189,5 @@ maintainer is familiar with.
 @hook TARGET_GCOV_TYPE_SIZE
 
 @hook TARGET_HAVE_SHADOW_CALL_STACK
+
+@hook TARGET_HAVE_KCFI
diff --git a/gcc/emit-rtl.cc b/gcc/emit-rtl.cc
index 1e02ae254d0..5673bd93995 100644
--- a/gcc/emit-rtl.cc
+++ b/gcc/emit-rtl.cc
@@ -3924,6 +3924,7 @@ try_split (rtx pat, rtx_insn *trial, int last)
 	  fixup_args_size_notes (NULL, insn_last, get_args_size (note));
 	  break;
 
+	case REG_CALL_CFI_TYPEID:
 	case REG_CALL_DECL:
 	case REG_UNTYPED_CALL:
 	  gcc_assert (call_insn != NULL_RTX);
diff --git a/gcc/emit-rtl.h b/gcc/emit-rtl.h
index 7a58fedb97a..83bf22a9e53 100644
--- a/gcc/emit-rtl.h
+++ b/gcc/emit-rtl.h
@@ -307,6 +307,10 @@ struct GTY(()) rtl_data {
      pass.  */
   bool bb_reorder_complete;
 
+  /* True if we should add kcfi indirect call check for the current
+     function.  */
+  bool is_kcfi_enabled;
+
   /* Like regs_ever_live, but 1 if a reg is set or clobbered from an
      asm.  Unlike regs_ever_live, elements of this array corresponding
      to eliminable regs (like the frame pointer) are set if an asm
diff --git a/gcc/final.cc b/gcc/final.cc
index a9868861bd2..ef9565516cb 100644
--- a/gcc/final.cc
+++ b/gcc/final.cc
@@ -2823,6 +2823,29 @@ final_scan_insn_1 (rtx_insn *insn, FILE *file, int optimize_p ATTRIBUTE_UNUSED,
 
 	current_output_insn = debug_insn = insn;
 
+	rtx_call_insn *call_insn = dyn_cast <rtx_call_insn *> (insn);
+
+	/* Do not insert cfg checks for functions that disable kcfi.  */
+	if ((call_insn != NULL) && crtl->is_kcfi_enabled)
+	  {
+	    rtx x = call_from_call_insn (call_insn);
+	    x = XEXP (x, 0);
+	    if (x && MEM_P (x))
+	      {
+		x = XEXP (x, 0);
+		if (GET_CODE (x) == REG)
+		  {
+		    rtx note = find_reg_note (insn, REG_CALL_CFI_TYPEID,
+					      NULL_RTX);
+		    gcc_assert (note);
+
+		    unsigned value = (unsigned) XWINT (XEXP (note, 0), 0);
+
+		    targetm.asm_out.output_icall_kcfi_check (x, value);
+		  }
+	      }
+	  }
+
 	/* Find the proper template for this insn.  */
 	templ = get_insn_template (insn_code_number, insn);
 
@@ -2875,7 +2898,6 @@ final_scan_insn_1 (rtx_insn *insn, FILE *file, int optimize_p ATTRIBUTE_UNUSED,
 	    && targetm.asm_out.unwind_emit)
 	  targetm.asm_out.unwind_emit (asm_out_file, insn);
 
-	rtx_call_insn *call_insn = dyn_cast <rtx_call_insn *> (insn);
 	if (call_insn != NULL)
 	  {
 	    rtx x = call_from_call_insn (call_insn);
diff --git a/gcc/flag-types.h b/gcc/flag-types.h
index 0aa51e282fb..2c34f04b509 100644
--- a/gcc/flag-types.h
+++ b/gcc/flag-types.h
@@ -323,6 +323,8 @@ enum sanitize_code {
   SANITIZE_KERNEL_HWADDRESS = 1ULL << 30,
   /* Shadow Call Stack.  */
   SANITIZE_SHADOW_CALL_STACK = 1ULL << 31,
+  /* Control Flow Integrity for linux kernel.  */
+  SANITIZE_KERNEL_CONTROL_FLOW_INTEGRITY = 1ULL << 32,
   SANITIZE_MAX = 1ULL << 63,
   SANITIZE_SHIFT = SANITIZE_SHIFT_BASE | SANITIZE_SHIFT_EXPONENT,
   SANITIZE_UNDEFINED = SANITIZE_SHIFT | SANITIZE_DIVIDE | SANITIZE_UNREACHABLE
diff --git a/gcc/gimple.cc b/gcc/gimple.cc
index 9e62da4265b..6d0f840aad0 100644
--- a/gcc/gimple.cc
+++ b/gcc/gimple.cc
@@ -222,9 +222,16 @@ gimple_call_reset_alias_info (gcall *s)
    components of a GIMPLE_CALL statement to function FN with NARGS
    arguments.  */
 
+void
+gimple_call_set_cfi_typeid (gcall *call_stmt, unsigned int cfi_typeid)
+{
+  call_stmt->cfi_typeid = cfi_typeid;
+}
+
 static inline gcall *
 gimple_build_call_1 (tree fn, unsigned nargs)
 {
+  unsigned int cfi_typeid;
   gcall *s
     = as_a <gcall *> (gimple_build_with_ops (GIMPLE_CALL, ERROR_MARK,
 					     nargs + 3));
@@ -233,6 +240,10 @@ gimple_build_call_1 (tree fn, unsigned nargs)
   gimple_set_op (s, 1, fn);
   gimple_call_set_fntype (s, TREE_TYPE (TREE_TYPE (fn)));
   gimple_call_reset_alias_info (s);
+
+  cfi_typeid = targetm.calc_func_cfi_typeid (TREE_TYPE (TREE_TYPE (fn)));
+  gimple_call_set_cfi_typeid (s, cfi_typeid);
+
   return s;
 }
 
diff --git a/gcc/gimple.h b/gcc/gimple.h
index 77a5a07e9b5..e3ce0fa2e44 100644
--- a/gcc/gimple.h
+++ b/gcc/gimple.h
@@ -362,12 +362,15 @@ struct GTY((tag("GSS_CALL")))
   struct pt_solution call_clobbered;
 
   /* [ WORD 14 ]  */
+  unsigned int cfi_typeid;
+
+  /* [ WORD 15 ]  */
   union GTY ((desc ("%1.subcode & GF_CALL_INTERNAL"))) {
     tree GTY ((tag ("0"))) fntype;
     enum internal_fn GTY ((tag ("GF_CALL_INTERNAL"))) internal_fn;
   } u;
 
-  /* [ WORD 15 ]
+  /* [ WORD 16 ]
      Operand vector.  NOTE!  This must always be the last field
      of this structure.  In particular, this means that this
      structure cannot be embedded inside another one.  */
diff --git a/gcc/opts.cc b/gcc/opts.cc
index 11c5d70458f..71bfd786312 100644
--- a/gcc/opts.cc
+++ b/gcc/opts.cc
@@ -2059,6 +2059,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =
   SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true),
   SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true),
   SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false),
+  SANITIZER_OPT (kcfi, SANITIZE_KERNEL_CONTROL_FLOW_INTEGRITY, false),
   SANITIZER_OPT (all, ~0ULL, true),
 #undef SANITIZER_OPT
   { NULL, 0U, 0UL, false }
@@ -2186,7 +2187,8 @@ parse_sanitizer_options (const char *p, location_t loc, int scode,
 		else
 		  flags |= ~(SANITIZE_THREAD | SANITIZE_LEAK
 			     | SANITIZE_UNREACHABLE | SANITIZE_RETURN
-			     | SANITIZE_SHADOW_CALL_STACK);
+			     | SANITIZE_SHADOW_CALL_STACK
+			     | SANITIZE_KERNEL_CONTROL_FLOW_INTEGRITY);
 	      }
 	    else if (value)
 	      {
diff --git a/gcc/output.h b/gcc/output.h
index 6dea630913a..3fab6bb707f 100644
--- a/gcc/output.h
+++ b/gcc/output.h
@@ -606,6 +606,9 @@ extern bool default_binds_local_p_2 (const_tree);
 extern bool default_binds_local_p_3 (const_tree, bool, bool, bool, bool);
 extern void default_globalize_label (FILE *, const char *);
 extern void default_globalize_decl_name (FILE *, tree);
+extern void default_output_func_kcfi_typeid (FILE *, tree);
+extern void default_output_icall_kcfi_check (rtx reg, unsigned int value);
+extern unsigned int default_calc_func_cfi_typeid (const_tree);
 extern void default_emit_unwind_label (FILE *, tree, int, int);
 extern void default_emit_except_table_label (FILE *);
 extern void default_generate_internal_label (char *, const char *,
diff --git a/gcc/reg-notes.def b/gcc/reg-notes.def
index 704bc75b0e7..0fddd523c23 100644
--- a/gcc/reg-notes.def
+++ b/gcc/reg-notes.def
@@ -247,3 +247,4 @@ REG_NOTE (CALL_NOCF_CHECK)
 
 /* The values passed to callee, for debuginfo purposes.  */
 REG_NOTE (CALL_ARG_LOCATION)
+REG_NOTE (CALL_CFI_TYPEID)
diff --git a/gcc/target.def b/gcc/target.def
index d85adf36a39..ca11f572370 100644
--- a/gcc/target.def
+++ b/gcc/target.def
@@ -136,6 +136,26 @@ global; that is, available for reference from other files.\n\
 The default implementation uses the TARGET_ASM_GLOBALIZE_LABEL target hook.",
  void, (FILE *stream, tree decl), default_globalize_decl_name)
 
+/* Output the uniform type identifier in front of a function
+   when kcfi is enabled.  */
+DEFHOOK
+(output_func_kcfi_typeid,
+ "This target hook is used to output a function's typeid before\n\
+its assembly code.\n\
+For different platforms, the output format of typeid may be different,\n\
+so a platform-dependent function is required.",
+ void, (FILE *stream, tree decl), default_output_func_kcfi_typeid)
+
+/* Output the assembly codes to check an indirect call's cfi typeid
+   when kcfi is enabled.  */
+DEFHOOK
+(output_icall_kcfi_check,
+ "This target hook is used to output the assembly codes to check the\n\
+callee's typeid before an indirect call.\n\
+For different platforms, the location of typeid may be different,\n\
+so a platform-dependent function is required.",
+ void, (rtx reg, unsigned int value), default_output_icall_kcfi_check)
+
 /* Output code that will declare an external variable.  */
 DEFHOOK
 (assemble_undefined_decl,
@@ -4522,6 +4542,16 @@ by a subtarget.",
  unsigned HOST_WIDE_INT, (void),
  NULL)
 
+/* Calculate the typeid of a function's type.  */
+DEFHOOK
+(calc_func_cfi_typeid,
+ "This target hook is used to calculate a platform-dependent typeid\n\
+of a function.\n\
+Although the length of typeid is always 4 bytes on all platforms, different\n\
+platforms may ignore some bits to avoid encoding conflicts with it's\n\
+instruction set, so a platform-dependent function is required.",
+ unsigned int, (const_tree fntype), default_calc_func_cfi_typeid)
+
 /* Functions relating to calls - argument passing, returns, etc.  */
 /* Members of struct call have no special macro prefix.  */
 HOOK_VECTOR (TARGET_CALLS, calls)
@@ -7111,6 +7141,14 @@ DEFHOOKPOD
 @option{-fsanitize=shadow-call-stack}.  The default value is false.",
  bool, false)
 
+/* This value represents whether the control flow integrity is implemented
+   on the target platform.  */
+DEFHOOKPOD
+(have_kcfi,
+ "This value is true if the target platform supports\n\
+@option{-fsanitize=kcfi}.  The default value is false.",
+ bool, false)
+
 /* Close the 'struct gcc_target' definition.  */
 HOOK_VECTOR_END (C90_EMPTY_HACK)
 
diff --git a/gcc/toplev.cc b/gcc/toplev.cc
index 055e0642f77..f7feb40e785 100644
--- a/gcc/toplev.cc
+++ b/gcc/toplev.cc
@@ -1665,6 +1665,10 @@ process_options (bool no_backend)
 		  "requires %<-fno-exceptions%>");
     }
 
+  if (flag_sanitize & SANITIZE_KERNEL_CONTROL_FLOW_INTEGRITY)
+    if (!targetm.have_kcfi)
+      sorry ("%<-fsanitize=kcfi%> not supported in current platform");
+
   HOST_WIDE_INT patch_area_size, patch_area_start;
   parse_and_check_patch_area (flag_patchable_function_entry, false,
 			      &patch_area_size, &patch_area_start);
diff --git a/gcc/tree.cc b/gcc/tree.cc
index 4cf3785270b..a493812ebcc 100644
--- a/gcc/tree.cc
+++ b/gcc/tree.cc
@@ -137,6 +137,8 @@ static uint64_t tree_code_counts[MAX_TREE_CODES];
 uint64_t tree_node_counts[(int) all_kinds];
 uint64_t tree_node_sizes[(int) all_kinds];
 
+static unsigned int unified_tree_type_hash_table[MAX_TREE_CODES];
+
 /* Keep in sync with tree.h:enum tree_node_kind.  */
 static const char * const tree_node_kind_names[] = {
   "decls",
@@ -252,6 +254,8 @@ static void print_type_hash_statistics (void);
 static void print_debug_expr_statistics (void);
 static void print_value_expr_statistics (void);
 
+static void append_unified_type_hash (const_tree type, inchash::hash &hstate);
+
 tree global_trees[TI_MAX];
 tree integer_types[itk_none];
 
@@ -694,6 +698,143 @@ initialize_tree_contains_struct (void)
   gcc_assert (tree_contains_struct[NAMELIST_DECL][TS_DECL_COMMON]);
 }
 
+static void
+initialize_unified_tree_type_hash_table (void)
+{
+  unified_tree_type_hash_table[OFFSET_TYPE] = 10;
+  unified_tree_type_hash_table[ENUMERAL_TYPE] = 20;
+  unified_tree_type_hash_table[BOOLEAN_TYPE] = 30;
+  unified_tree_type_hash_table[INTEGER_TYPE] = 40;
+  unified_tree_type_hash_table[REAL_TYPE] = 50;
+  unified_tree_type_hash_table[POINTER_TYPE] = 60;
+  unified_tree_type_hash_table[REFERENCE_TYPE] = 70;
+  unified_tree_type_hash_table[NULLPTR_TYPE] = 80;
+  unified_tree_type_hash_table[FIXED_POINT_TYPE] = 90;
+  unified_tree_type_hash_table[COMPLEX_TYPE] = 100;
+  unified_tree_type_hash_table[VECTOR_TYPE] = 110;
+  unified_tree_type_hash_table[ARRAY_TYPE] = 120;
+  unified_tree_type_hash_table[RECORD_TYPE] = 130;
+  unified_tree_type_hash_table[UNION_TYPE] = 140;
+  unified_tree_type_hash_table[QUAL_UNION_TYPE] = 150;
+  unified_tree_type_hash_table[VOID_TYPE] = 160;
+  unified_tree_type_hash_table[FUNCTION_TYPE] = 170;
+  unified_tree_type_hash_table[METHOD_TYPE] = 180;
+  unified_tree_type_hash_table[LANG_TYPE] = 190;
+  unified_tree_type_hash_table[OPAQUE_TYPE] = 200;
+}
+
+static void
+append_unified_type_name_hash (const_tree type, inchash::hash &hstate)
+{
+  tree n = TYPE_NAME (TYPE_MAIN_VARIANT (type));
+
+  if (!n)
+    return;
+
+  if (TREE_CODE (n) != IDENTIFIER_NODE)
+    n = DECL_NAME (n);
+
+  hstate.add ((const void *) IDENTIFIER_POINTER (n), IDENTIFIER_LENGTH (n));
+}
+
+static void
+append_unified_type_precision_hash (const_tree type, inchash::hash &hstate)
+{
+  unsigned HOST_WIDE_INT size = TYPE_PRECISION (type);
+
+  hstate.add_hwi (size);
+}
+
+/* Add the return and all parameter types of the function
+   to the hash calculation.  */
+
+static void
+append_unified_function_ret_and_args_hash (const_tree fntype,
+					   inchash::hash &hstate)
+{
+  const_tree arg_type;
+  function_args_iterator args_iter;
+
+  append_unified_type_hash (TREE_TYPE (fntype), hstate);
+
+  FOREACH_FUNCTION_ARGS (fntype, arg_type, args_iter)
+    {
+      if (TYPE_READONLY (arg_type) || TYPE_VOLATILE (arg_type))
+	{
+	  int quals = TYPE_QUALS (arg_type)
+		      & ~TYPE_QUAL_CONST & ~TYPE_QUAL_VOLATILE;
+
+	  arg_type = build_qualified_type (CONST_CAST_TREE (arg_type), quals);
+	}
+      append_unified_type_hash (arg_type, hstate);
+    }
+}
+
+static void
+append_unified_type_hash (const_tree type, inchash::hash &hstate)
+{
+  enum tree_code type_code = TREE_CODE (type);
+  unsigned int u_hash = unified_tree_type_hash_table[type_code];
+
+  /* Make sure all type nodes have a unique initial hash.  */
+  if (!u_hash)
+    gcc_unreachable ();
+
+  hstate.add_int (u_hash);
+
+  /* Extra information about the type involved in the hash calculation.  */
+  switch (type_code)
+    {
+    case VOID_TYPE:
+    case BOOLEAN_TYPE:
+      break;
+
+    case INTEGER_TYPE:
+      append_unified_type_name_hash (type, hstate);
+      append_unified_type_precision_hash (type, hstate);
+      break;
+
+    case ENUMERAL_TYPE:
+      append_unified_type_name_hash (type, hstate);
+      append_unified_type_precision_hash (type, hstate);
+      break;
+
+    case REAL_TYPE:
+      append_unified_type_precision_hash (TYPE_MAIN_VARIANT (type), hstate);
+      break;
+
+    case POINTER_TYPE:
+    case REFERENCE_TYPE:
+    case ARRAY_TYPE:
+      append_unified_type_hash (TREE_TYPE (type), hstate);
+      break;
+
+    case UNION_TYPE:
+    case RECORD_TYPE:
+      append_unified_type_name_hash (type, hstate);
+      break;
+
+    case FUNCTION_TYPE:
+      append_unified_function_ret_and_args_hash (type, hstate);
+      break;
+
+    default:
+      break;
+    }
+}
+
+/* Calculate the hash of the type node that are invariant across
+   compilation units.  */
+
+hashval_t
+unified_type_hash (const_tree type)
+{
+  inchash::hash hstate;
+
+  append_unified_type_hash (type, hstate);
+
+  return hstate.end ();
+}
 
 /* Init tree.cc.  */
 
@@ -723,6 +864,9 @@ init_ttree (void)
 
   /* Initialize the tree_contains_struct array.  */
   initialize_tree_contains_struct ();
+
+  initialize_unified_tree_type_hash_table ();
+
   lang_hooks.init_ts ();
 }
 
diff --git a/gcc/tree.h b/gcc/tree.h
index 8844471e9a5..dd8e0bfba7b 100644
--- a/gcc/tree.h
+++ b/gcc/tree.h
@@ -4813,6 +4813,7 @@ extern tree build_variant_type_copy (tree CXX_MEM_STAT_INFO);
 
 extern hashval_t type_hash_canon_hash (tree);
 extern tree type_hash_canon (unsigned int, tree);
+extern hashval_t unified_type_hash (const_tree);
 
 extern tree convert (tree, tree);
 extern tree size_in_bytes_loc (location_t, const_tree);
diff --git a/gcc/varasm.cc b/gcc/varasm.cc
index 021e912a37c..5ae68a77142 100644
--- a/gcc/varasm.cc
+++ b/gcc/varasm.cc
@@ -1956,6 +1956,11 @@ assemble_start_function (tree decl, const char *fnname)
   if (!DECL_IGNORED_P (decl))
     (*debug_hooks->begin_function) (decl);
 
+  /* Regardless of whether the function can be called indirectly,
+     a typeid is always required before the function.  */
+  if (flag_sanitize & SANITIZE_KERNEL_CONTROL_FLOW_INTEGRITY)
+    targetm.asm_out.output_func_kcfi_typeid (asm_out_file, decl);
+
   /* Make function name accessible from other files, if appropriate.  */
 
   if (TREE_PUBLIC (decl))
@@ -7674,6 +7679,27 @@ default_globalize_decl_name (FILE * stream, tree decl)
   targetm.asm_out.globalize_label (stream, name);
 }
 
+/* Default function to output the function's kcfi typeid.  */
+void
+default_output_func_kcfi_typeid (FILE * stream ATTRIBUTE_UNUSED,
+				 tree decl ATTRIBUTE_UNUSED)
+{
+}
+
+/* Default function to output the kcfi check for an indirect call.  */
+void
+default_output_icall_kcfi_check (rtx reg ATTRIBUTE_UNUSED,
+				 unsigned int value ATTRIBUTE_UNUSED)
+{
+}
+
+/* Default function to calculate the typeid of a function type.  */
+unsigned int
+default_calc_func_cfi_typeid (const_tree fntype ATTRIBUTE_UNUSED)
+{
+  return 0;
+}
+
 /* Default function to output a label for unwind information.  The
    default is to do nothing.  A target that needs nonlocal labels for
    unwind information must provide its own function to do this.  */
-- 
2.17.1

