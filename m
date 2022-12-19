Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3427A650762
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 06:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiLSFzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 00:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiLSFzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 00:55:48 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A81D7D;
        Sun, 18 Dec 2022 21:55:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so11920405pjp.1;
        Sun, 18 Dec 2022 21:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tVrWeAVs8il56eyCzT4HfeDNn0LJzRC1buWvH0aZI7U=;
        b=D/otjv1dXKsFCPWBHHo7qiyipNwrbFvOQfKb7iZ+2fZK/uNXiDnOoppfVYfsMXmTze
         EhAMuX0I1dVplJswkUSNiwfIqrhDFoVcDQNwTK4yRsCamUcbzTUaBBYCQ1h1Ash7JMpn
         pO3bSv1VycIjQIXL6H4Owf9aWYAAhNYcxkzU0wcDpxQM5PTK7BFbK/SRgPEUQKQZHCD/
         huFJLlqGnjaBPZMRkE5KP2dzxpZe1x57/oDQP/bDn1W4v1zcicmnRLey2JRRM1HwWkAS
         Ud60xCbm1jkzrlc8ZepC8UScwXiok2bfZUXS+8BbGZhEQUkCOCfdOiumHBvy71U15O91
         J+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVrWeAVs8il56eyCzT4HfeDNn0LJzRC1buWvH0aZI7U=;
        b=l3oES6GTXG9xSgd/6xM2JgnYU9w2QvXDk7I60v4ckzfM39kzLEyjLfxNEeqjst4rPG
         QFSMJmskvRrjZhRN1Np6wfAauAL2ASC4482IjlkSjVtwNgY5CDQI611nwRWtY8fHcVCS
         Pz+jTEzRN/DIxOqnuq2yCi7t0YLSFxqUPcuQxipO+vNMsNb3ozw7h4LEFUx8ZtPlgZ2V
         Bqw32x3L4+XGFuJtgoSUEWmFp3Iv4kvHUoFPW0B8YHxNxNw/146kNjJJ1BMMW5cpfwNe
         Wqm0zEwp8DKoBC96MIWp4LGxkwBw7wqCwsq1JzgTqdJ1+IUuv9GZ05SQAiM94J+BY3SS
         URsA==
X-Gm-Message-State: ANoB5pkLgyxKVdkVzZIYmSBJf0M10uSRuAU64l7+PRtGQcqjKqz1k6PC
        wyIOx2b6OG3rV31biIN8VLI=
X-Google-Smtp-Source: AA0mqf7bxqqbVVh15coQkEg14XlP6DheJRiWeDCnELCI/AffxotULOmadONOozLm1upaz5hgkrSkWw==
X-Received: by 2002:a17:903:22cd:b0:189:e16f:c268 with SMTP id y13-20020a17090322cd00b00189e16fc268mr57860942plg.20.1671429344607;
        Sun, 18 Dec 2022 21:55:44 -0800 (PST)
Received: from localhost ([103.152.220.92])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902ea0b00b00178143a728esm6070509plg.275.2022.12.18.21.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Dec 2022 21:55:44 -0800 (PST)
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
Subject: [RFC/RFT 2/3] [PR102768] Support CFI: Add new pass for Control Flow Integrity
Date:   Sun, 18 Dec 2022 21:54:30 -0800
Message-Id: <20221219055431.22596-3-ashimida.1990@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219055431.22596-1-ashimida.1990@gmail.com>
References: <20221219055431.22596-1-ashimida.1990@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CFI sanitizer enabled with -fsanitize=cfi implements a forward
edge control flow integrity scheme for indirect calls, roughly
similar to -fsanitize=kcfi [1] in llvm.

At compile time, it appends a uniform type identifier before the
first instruction of each function and inserts check code before
each indirect call in a function with protection enabled.

At runtime, according to the code order, the check code for each
indirect call will be executed first, and it will:
1. Dynamically obtain the typeid before the callee function.
2. Compare it to the expected typeid of the current call site (caller).
3. If the two match, continue to execute the indirect call, if not,
call the user-defined callback function cfi_check_failed.

A typeid (type identifier) is a 32-bit constant on all platforms,
whose value depends on the function's prototype, and is invariant
across compilation units. However, different platforms may ignore
some of the bits to avoid conflicts with instructions.

If a program contains indirect calls to assembly functions, they
must be manually annotated with the expected type identifiers to
prevent errors. To make this easier, gcc generates a weak SHN_ABS
__cfi_typeid_<function> symbol for each address-taken function
declaration, which can be used to annotate functions in assembly
as long as at least one translation unit linked into the program
takes the function address.

It should be noted that on different platforms, the location of
typeid insertion (the offset between it and the function header)
may be different, such as [1], and this patch only implements
the platform-independent part.

[1]: https://reviews.llvm.org/D119296

Signed-off-by: Dan Li <ashimida.1990@gmail.com>

gcc/ChangeLog:

	PR c/102768
	* Makefile.in: Add tree-cfi.o.
	* cgraphunit.cc (output_decl_cfi_typeid_symbol): Output the
	CFI typeid corresponding to each external declaration when necessary.
	(output_decl_cfi_typeid_symbols): Likewise.
	* doc/passes.texi: Document it.
	* doc/tm.texi: Regenerate.
	* doc/tm.texi.in: New hooks.
	* flag-types.h (enum sanitize_code):
	Add SANITIZE_CONTROL_FLOW_INTEGRITY.
	* opts.cc (parse_sanitizer_options): Add cfi and exclude
	SANITIZE_CONTROL_FLOW_INTEGRITY.
	* output.h (default_output_func_cfi_typeid): Declare.
	(default_calc_func_cfi_typeid): Declare.
	(default_gimple_get_func_cfi_typeid): Declare.
	* passes.def: Add pass_cfi.
	* target.def: Add new hooks.
	* toplev.cc (process_options): Add CFI compile option check.
	* tree-pass.h (make_pass_cfi): Declare.
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
	(default_output_func_cfi_typeid): New.
	(default_gimple_get_func_cfi_typeid): New.
	(default_calc_func_cfi_typeid): New.
	* tree-cfi.cc: New file.
---
 gcc/Makefile.in     |   1 +
 gcc/cgraphunit.cc   |  34 +++++++
 gcc/doc/passes.texi |  10 ++
 gcc/doc/tm.texi     |  27 ++++++
 gcc/doc/tm.texi.in  |   8 ++
 gcc/flag-types.h    |   2 +
 gcc/opts.cc         |   4 +-
 gcc/output.h        |   3 +
 gcc/passes.def      |   1 +
 gcc/target.def      |  39 ++++++++
 gcc/toplev.cc       |   4 +
 gcc/tree-cfi.cc     | 229 ++++++++++++++++++++++++++++++++++++++++++++
 gcc/tree-pass.h     |   1 +
 gcc/tree.cc         | 144 ++++++++++++++++++++++++++++
 gcc/tree.h          |   1 +
 gcc/varasm.cc       |  29 ++++++
 16 files changed, 536 insertions(+), 1 deletion(-)
 create mode 100644 gcc/tree-cfi.cc

diff --git a/gcc/Makefile.in b/gcc/Makefile.in
index 31ff95500c9..0d23bad6b63 100644
--- a/gcc/Makefile.in
+++ b/gcc/Makefile.in
@@ -1610,6 +1610,7 @@ OBJS = \
 	tree-call-cdce.o \
 	tree-cfg.o \
 	tree-cfgcleanup.o \
+	tree-cfi.o \
 	tree-chrec.o \
 	tree-complex.o \
 	tree-data-ref.o \
diff --git a/gcc/cgraphunit.cc b/gcc/cgraphunit.cc
index 76d541755b8..fb4999559ae 100644
--- a/gcc/cgraphunit.cc
+++ b/gcc/cgraphunit.cc
@@ -2222,6 +2222,37 @@ ipa_passes (void)
   bitmap_obstack_release (NULL);
 }
 
+/* Output a weak symbol value of a decl's typeid (hash) to the
+   assembly file, like:
+	.weak __cfi_typeid_A
+	.set __cfi_typeid_A, 0x00000ADA
+   typeid is platform-dependent, because the bits in typeid that conflicts
+   with the instruction set of the current platform needs to be ignored.  */
+
+static void
+output_decl_cfi_typeid_symbol (FILE *stream, tree fndecl)
+{
+  unsigned int hash = targetm.calc_func_cfi_typeid (TREE_TYPE (fndecl));
+  const char *name = IDENTIFIER_POINTER (DECL_NAME (fndecl));
+
+  fprintf (stream, ".weak __cfi_typeid_%s\n", name);
+  fprintf (stream, ".set __cfi_typeid_%s, %#010x\n", name, hash);
+}
+
+/* Calculate and output the symbols corresponding to the typeid of all
+   external declarations whose address is taken within the current
+   compilation unit.  If such a function is defined in assembly code,
+   its typeid can be obtained according to this symbol.  */
+
+static void
+output_decl_cfi_typeid_symbols (void)
+{
+  struct cgraph_node *node;
+
+  FOR_EACH_FUNCTION (node)
+    if (!node->definition && node->address_taken)
+      output_decl_cfi_typeid_symbol (asm_out_file, node->decl);
+}
 
 /* Weakrefs may be associated to external decls and thus not output
    at expansion time.  Emit all necessary aliases.  */
@@ -2339,6 +2370,9 @@ symbol_table::compile (void)
       }
 #endif
 
+  if (flag_sanitize & SANITIZE_CONTROL_FLOW_INTEGRITY)
+    output_decl_cfi_typeid_symbols ();
+
   state = EXPANSION;
 
   /* Output first asm statements and anything ordered. The process
diff --git a/gcc/doc/passes.texi b/gcc/doc/passes.texi
index 1e821d4e513..7d36f196c5b 100644
--- a/gcc/doc/passes.texi
+++ b/gcc/doc/passes.texi
@@ -650,6 +650,16 @@ divisions to multiplications by the reciprocal.  The pass is located
 in @file{tree-ssa-math-opts.cc} and is described by
 @code{pass_cse_reciprocal}.
 
+@item Control Flow Integrity
+
+This pass enables the support for Control Flow Intergity sanitizer.
+The CFI sanitizer, enabled with @option{-fsanitize=cfi}, implements
+a forward-edge control flow integrity scheme for indirect calls.
+It attaches a uniform type identifier to each function that is
+invariant across compilation units and inserts checking code
+before indirect calls.  The pass is located in @file{tree-cfi.cc}
+and is described by @code{pass_cfi}.
+
 @item Full redundancy elimination
 
 This is a simpler form of PRE that only eliminates redundancies that
diff --git a/gcc/doc/tm.texi b/gcc/doc/tm.texi
index c5006afc00d..1b603da309e 100644
--- a/gcc/doc/tm.texi
+++ b/gcc/doc/tm.texi
@@ -1003,6 +1003,21 @@ Return a value, with the same meaning as the C99 macro
 @code{FLT_EVAL_METHOD} that describes which excess precision should be
 applied.
 
+@deftypefn {Target Hook} tree TARGET_GIMPLE_GET_FUNC_CFI_TYPEID (gimple_seq *@var{stmts}, location_t @var{loc}, tree @var{fptr})
+This target hook is used to generate gimple instructions to get
+the typeid in front of the function pointed to by fptr.
+For different platforms, the location of typeid may be different,
+so a platform-dependent function is required.
+@end deftypefn
+
+@deftypefn {Target Hook} {unsigned int} TARGET_CALC_FUNC_CFI_TYPEID (const_tree @var{fntype})
+This target hook is used to calculate a platform-dependent typeid
+of a function.
+Although the length of typeid is always 4bytes on all platforms, different
+platforms may ignore some bits to avoid encoding conflicts with it's
+instruction set, so a platform-dependent function is required.
+@end deftypefn
+
 @deftypefn {Target Hook} machine_mode TARGET_PROMOTE_FUNCTION_MODE (const_tree @var{type}, machine_mode @var{mode}, int *@var{punsignedp}, const_tree @var{funtype}, int @var{for_return})
 Like @code{PROMOTE_MODE}, but it is applied to outgoing function arguments or
 function return values.  The target hook should return the new mode
@@ -8721,6 +8736,13 @@ global; that is, available for reference from other files.
 The default implementation uses the TARGET_ASM_GLOBALIZE_LABEL target hook.
 @end deftypefn
 
+@deftypefn {Target Hook} void TARGET_ASM_OUTPUT_FUNC_CFI_TYPEID (FILE *@var{stream}, tree @var{decl})
+This target hook is used to output a function's typeid before
+its assembly code.
+For different platforms, the output format of typeid may be different,
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
+@deftypevr {Target Hook} bool TARGET_HAVE_CFI
+This value is true if the target platform supports
+@option{-fsanitize=cfi}.  The default value is false.
+@end deftypevr
diff --git a/gcc/doc/tm.texi.in b/gcc/doc/tm.texi.in
index f869ddd5e5b..7b7f2fa0be5 100644
--- a/gcc/doc/tm.texi.in
+++ b/gcc/doc/tm.texi.in
@@ -933,6 +933,10 @@ Return a value, with the same meaning as the C99 macro
 @code{FLT_EVAL_METHOD} that describes which excess precision should be
 applied.
 
+@hook TARGET_GIMPLE_GET_FUNC_CFI_TYPEID
+
+@hook TARGET_CALC_FUNC_CFI_TYPEID
+
 @hook TARGET_PROMOTE_FUNCTION_MODE
 
 @defmac PARM_BOUNDARY
@@ -5568,6 +5572,8 @@ You may wish to use @code{ASM_OUTPUT_SIZE_DIRECTIVE} and/or
 
 @hook TARGET_ASM_GLOBALIZE_DECL_NAME
 
+@hook TARGET_ASM_OUTPUT_FUNC_CFI_TYPEID
+
 @hook TARGET_ASM_ASSEMBLE_UNDEFINED_DECL
 
 @defmac ASM_WEAKEN_LABEL (@var{stream}, @var{name})
@@ -8183,3 +8189,5 @@ maintainer is familiar with.
 @hook TARGET_GCOV_TYPE_SIZE
 
 @hook TARGET_HAVE_SHADOW_CALL_STACK
+
+@hook TARGET_HAVE_CFI
diff --git a/gcc/flag-types.h b/gcc/flag-types.h
index 0aa51e282fb..453549a46f3 100644
--- a/gcc/flag-types.h
+++ b/gcc/flag-types.h
@@ -323,6 +323,8 @@ enum sanitize_code {
   SANITIZE_KERNEL_HWADDRESS = 1ULL << 30,
   /* Shadow Call Stack.  */
   SANITIZE_SHADOW_CALL_STACK = 1ULL << 31,
+  /* Control Flow Integrity.  */
+  SANITIZE_CONTROL_FLOW_INTEGRITY = 1ULL << 32,
   SANITIZE_MAX = 1ULL << 63,
   SANITIZE_SHIFT = SANITIZE_SHIFT_BASE | SANITIZE_SHIFT_EXPONENT,
   SANITIZE_UNDEFINED = SANITIZE_SHIFT | SANITIZE_DIVIDE | SANITIZE_UNREACHABLE
diff --git a/gcc/opts.cc b/gcc/opts.cc
index 11c5d70458f..9abe21e5029 100644
--- a/gcc/opts.cc
+++ b/gcc/opts.cc
@@ -2059,6 +2059,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =
   SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true),
   SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true),
   SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false),
+  SANITIZER_OPT (cfi, SANITIZE_CONTROL_FLOW_INTEGRITY, false),
   SANITIZER_OPT (all, ~0ULL, true),
 #undef SANITIZER_OPT
   { NULL, 0U, 0UL, false }
@@ -2186,7 +2187,8 @@ parse_sanitizer_options (const char *p, location_t loc, int scode,
 		else
 		  flags |= ~(SANITIZE_THREAD | SANITIZE_LEAK
 			     | SANITIZE_UNREACHABLE | SANITIZE_RETURN
-			     | SANITIZE_SHADOW_CALL_STACK);
+			     | SANITIZE_SHADOW_CALL_STACK
+			     | SANITIZE_CONTROL_FLOW_INTEGRITY);
 	      }
 	    else if (value)
 	      {
diff --git a/gcc/output.h b/gcc/output.h
index 6dea630913a..5d17198eb2c 100644
--- a/gcc/output.h
+++ b/gcc/output.h
@@ -606,6 +606,9 @@ extern bool default_binds_local_p_2 (const_tree);
 extern bool default_binds_local_p_3 (const_tree, bool, bool, bool, bool);
 extern void default_globalize_label (FILE *, const char *);
 extern void default_globalize_decl_name (FILE *, tree);
+extern void default_output_func_cfi_typeid (FILE *, tree);
+extern unsigned int default_calc_func_cfi_typeid (const_tree);
+extern tree default_gimple_get_func_cfi_typeid (gimple_seq *, location_t, tree);
 extern void default_emit_unwind_label (FILE *, tree, int, int);
 extern void default_emit_except_table_label (FILE *);
 extern void default_generate_internal_label (char *, const char *,
diff --git a/gcc/passes.def b/gcc/passes.def
index 375d3d62d51..d8b7fd8d6e7 100644
--- a/gcc/passes.def
+++ b/gcc/passes.def
@@ -191,6 +191,7 @@ along with GCC; see the file COPYING3.  If not see
   NEXT_PASS (pass_omp_device_lower);
   NEXT_PASS (pass_omp_target_link);
   NEXT_PASS (pass_adjust_alignment);
+  NEXT_PASS (pass_cfi);
   NEXT_PASS (pass_all_optimizations);
   PUSH_INSERT_PASSES_WITHIN (pass_all_optimizations)
       NEXT_PASS (pass_remove_cgraph_callee_edges);
diff --git a/gcc/target.def b/gcc/target.def
index d85adf36a39..858df4b89a6 100644
--- a/gcc/target.def
+++ b/gcc/target.def
@@ -136,6 +136,16 @@ global; that is, available for reference from other files.\n\
 The default implementation uses the TARGET_ASM_GLOBALIZE_LABEL target hook.",
  void, (FILE *stream, tree decl), default_globalize_decl_name)
 
+/* Output the uniform type identifier in front of a function
+   when cfi is enabled.  */
+DEFHOOK
+(output_func_cfi_typeid,
+ "This target hook is used to output a function's typeid before\n\
+its assembly code.\n\
+For different platforms, the output format of typeid may be different,\n\
+so a platform-dependent function is required.",
+ void, (FILE *stream, tree decl), default_output_func_cfi_typeid)
+
 /* Output code that will declare an external variable.  */
 DEFHOOK
 (assemble_undefined_decl,
@@ -4522,6 +4532,27 @@ by a subtarget.",
  unsigned HOST_WIDE_INT, (void),
  NULL)
 
+/* Generate gimple instructions to get the typeid in front of the
+   function pointed to by fptr.  */
+DEFHOOK
+(gimple_get_func_cfi_typeid,
+ "This target hook is used to generate gimple instructions to get\n\
+the typeid in front of the function pointed to by fptr.\n\
+For different platforms, the location of typeid may be different,\n\
+so a platform-dependent function is required.",
+ tree, (gimple_seq *stmts, location_t loc, tree fptr),
+ default_gimple_get_func_cfi_typeid)
+
+/* Calculate the typeid of a function's type.  */
+DEFHOOK
+(calc_func_cfi_typeid,
+ "This target hook is used to calculate a platform-dependent typeid\n\
+of a function.\n\
+Although the length of typeid is always 4bytes on all platforms, different\n\
+platforms may ignore some bits to avoid encoding conflicts with it's\n\
+instruction set, so a platform-dependent function is required.",
+ unsigned int, (const_tree fntype), default_calc_func_cfi_typeid)
+
 /* Functions relating to calls - argument passing, returns, etc.  */
 /* Members of struct call have no special macro prefix.  */
 HOOK_VECTOR (TARGET_CALLS, calls)
@@ -7111,6 +7142,14 @@ DEFHOOKPOD
 @option{-fsanitize=shadow-call-stack}.  The default value is false.",
  bool, false)
 
+/* This value represents whether the control flow integrity is implemented
+   on the target platform.  */
+DEFHOOKPOD
+(have_cfi,
+ "This value is true if the target platform supports\n\
+@option{-fsanitize=cfi}.  The default value is false.",
+ bool, false)
+
 /* Close the 'struct gcc_target' definition.  */
 HOOK_VECTOR_END (C90_EMPTY_HACK)
 
diff --git a/gcc/toplev.cc b/gcc/toplev.cc
index 055e0642f77..c4c47d03f73 100644
--- a/gcc/toplev.cc
+++ b/gcc/toplev.cc
@@ -1665,6 +1665,10 @@ process_options (bool no_backend)
 		  "requires %<-fno-exceptions%>");
     }
 
+  if (flag_sanitize & SANITIZE_CONTROL_FLOW_INTEGRITY)
+    if (!targetm.have_cfi)
+      sorry ("%<-fsanitize=cfi%> not supported in current platform");
+
   HOST_WIDE_INT patch_area_size, patch_area_start;
   parse_and_check_patch_area (flag_patchable_function_entry, false,
 			      &patch_area_size, &patch_area_start);
diff --git a/gcc/tree-cfi.cc b/gcc/tree-cfi.cc
new file mode 100644
index 00000000000..c852a961ccf
--- /dev/null
+++ b/gcc/tree-cfi.cc
@@ -0,0 +1,229 @@
+/* The pass of Control Flow Integrity.
+
+This file is part of GCC.
+
+GCC is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 3, or (at your option)
+any later version.
+
+GCC is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with GCC; see the file COPYING3.  If not see
+<http://www.gnu.org/licenses/>.  */
+
+#include "config.h"
+#include "system.h"
+#include "coretypes.h"
+#include "backend.h"
+#include "target.h"
+#include "tree.h"
+#include "gimple.h"
+#include "tree-pass.h"
+#include "ssa.h"
+#include "gimple-pretty-print.h"
+#include "gimple-iterator.h"
+#include "cfgloop.h"
+#include "cfghooks.h"
+#include "attribs.h"
+#include "asan.h"
+#include "diagnostic-core.h"
+#include "print-tree.h"
+
+/* When the typeid matching fails, the compiler will call the cfi_check_failed
+   function to report the failure, which needs to be defined by the user.
+   The prototype of this function is:
+     void cfi_callback (unsigned int caller_hash,
+			unsigned int callee_hash,
+			void *callee_addr);  */
+#define CFI_CALLBACK_FUNC_NAME "cfi_check_failed"
+
+static tree cfi_callback;
+
+static tree
+build_cfi_callback_decl (void)
+{
+  tree ftype = build_function_type_list (void_type_node, integer_type_node,
+					 integer_type_node, ptr_type_node,
+					 NULL_TREE);
+  tree decl = build_fn_decl (CFI_CALLBACK_FUNC_NAME, ftype);
+
+  return decl;
+}
+
+/* Returns a tree node representing the typeid calculated from fntype.  */
+static tree
+gen_func_type_hash_tree (gimple *stmt, tree fntype)
+{
+  unsigned int hash = targetm.calc_func_cfi_typeid (fntype);
+
+  return build_int_cst_type (integer_type_node, hash);
+}
+
+static void
+insert_gcall_cfg_check (gimple_stmt_iterator *gsi)
+{
+  gimple *call_stmt, *new_stmt;
+  gimple_seq stmts = NULL;
+  location_t loc;
+  tree fptr, fntype, callee_hash, caller_expected_hash;
+  basic_block cond_bb, true_bb, false_bb;
+  edge e;
+
+  call_stmt = gsi_stmt (*gsi);
+  loc = gimple_location (call_stmt);
+
+  fptr = gimple_call_fn (call_stmt);
+  fntype = TREE_TYPE (TREE_TYPE (fptr));
+
+  gcc_assert (TREE_CODE (fptr) == SSA_NAME);
+  gcc_assert (TREE_CODE (fntype) == FUNCTION_TYPE);
+
+  /* Get the caller's typeid tree node.  */
+  caller_expected_hash = gen_func_type_hash_tree (call_stmt, fntype);
+
+  /* Get the tree node representing the callee's typeid.  */
+  callee_hash = targetm.gimple_get_func_cfi_typeid (&stmts, loc, fptr);
+  gsi_insert_seq_before (gsi, stmts, GSI_SAME_STMT);
+
+  /* Insert insns to check whether the typeid matches,
+     and jump to the callback function if it fails.  */
+  new_stmt = gimple_build_cond (NE_EXPR, callee_hash,
+				caller_expected_hash, NULL_TREE, NULL_TREE);
+  gimple_set_location (new_stmt, loc);
+
+  gsi_insert_before (gsi, new_stmt, GSI_NEW_STMT);
+  cond_bb = gimple_bb (gsi_stmt (*gsi));
+
+  e = split_block (cond_bb, gsi_stmt (*gsi));
+  e->flags = EDGE_FALSE_VALUE;
+
+  false_bb = e->dest;
+
+  true_bb = create_empty_bb (cond_bb);
+  make_edge (cond_bb, true_bb, EDGE_TRUE_VALUE | EDGE_PRESERVE);
+  make_single_succ_edge (true_bb, false_bb, EDGE_FALLTHRU);
+
+  set_immediate_dominator (CDI_DOMINATORS, true_bb, cond_bb);
+  set_immediate_dominator (CDI_DOMINATORS, false_bb, cond_bb);
+  add_bb_to_loop (true_bb, cond_bb->loop_father);
+
+  /* Call cfi_callback when they mismatch.  */
+  *gsi = gsi_start_bb (true_bb);
+  new_stmt = gimple_build_call (cfi_callback, 3,
+				caller_expected_hash, callee_hash, fptr);
+  gimple_set_location (new_stmt, loc);
+  gsi_insert_after (gsi, new_stmt, GSI_CONTINUE_LINKING);
+
+  *gsi = gsi_start_bb (false_bb);
+}
+
+namespace {
+
+const pass_data pass_data_cfi =
+{
+  GIMPLE_PASS, /* type.  */
+  "cfi", /* name.  */
+  OPTGROUP_NONE, /* optinfo_flags.  */
+  TV_NONE, /* tv_id.  */
+  (PROP_cfg | PROP_ssa), /* properties_required.  */
+  0, /* properties_provided.  */
+  0, /* properties_destroyed.  */
+  0, /* todo_flags_start.  */
+  0, /* todo_flags_finish.  */
+};
+
+class pass_cfi : public gimple_opt_pass
+{
+public:
+  pass_cfi (gcc::context *ctxt)
+    : gimple_opt_pass (pass_data_cfi, ctxt)
+  {}
+
+  /* opt_pass methods: */
+  virtual bool gate (function *);
+  virtual unsigned int execute (function *);
+
+}; // class pass_cfi
+
+bool
+pass_cfi::gate (function *)
+{
+  /* Do not insert cfg checks for functions that disable cfi.  */
+  if (!sanitize_flags_p (SANITIZE_CONTROL_FLOW_INTEGRITY,
+			 current_function_decl))
+    return 0;
+
+  if (!cfi_callback)
+    cfi_callback = build_cfi_callback_decl ();
+
+  return 1;
+}
+
+unsigned int
+pass_cfi::execute (function *fun)
+{
+  tree fptr;
+  gimple *stmt;
+  basic_block bb;
+  gimple_stmt_iterator gsi;
+  int todo = 0;
+
+  loop_optimizer_init (LOOPS_NORMAL);
+  gcc_assert (current_loops);
+
+  calculate_dominance_info (CDI_DOMINATORS);
+  calculate_dominance_info (CDI_POST_DOMINATORS);
+
+  FOR_EACH_BB_FN (bb, cfun)
+    for (gsi = gsi_start_bb (bb); !gsi_end_p (gsi); gsi_next (&gsi))
+      {
+	stmt = gsi_stmt (gsi);
+
+	if (!is_gimple_call (stmt)
+	    || gimple_call_internal_p (as_a <gcall*> (stmt)))
+	  continue;
+
+	fptr = gimple_call_fn (stmt);
+
+	switch (TREE_CODE (fptr))
+	  {
+	  case ADDR_EXPR: /* Ignore non-indirect calls.  */
+	  case INTEGER_CST:
+	    continue;
+
+	  case SSA_NAME:
+	    break;
+
+	  default:
+	    gcc_unreachable ();
+	  }
+
+	gcc_assert (TREE_CODE (TREE_TYPE (fptr)) == POINTER_TYPE);
+
+	insert_gcall_cfg_check (&gsi);
+
+	todo = TODO_remove_unused_locals | TODO_update_ssa
+	       | TODO_cleanup_cfg | TODO_rebuild_cgraph_edges;
+
+	/* Re-acquire the bb where the gcall instruction is located.  */
+	bb = gsi_bb (gsi);
+      }
+
+  free_dominance_info (CDI_DOMINATORS);
+  free_dominance_info (CDI_POST_DOMINATORS);
+  loop_optimizer_finalize ();
+
+  return todo;
+}
+} // anon namespace
+
+gimple_opt_pass *
+make_pass_cfi (gcc::context *ctxt)
+{
+  return new pass_cfi (ctxt);
+}
diff --git a/gcc/tree-pass.h b/gcc/tree-pass.h
index 606d1d60b85..ed10a941740 100644
--- a/gcc/tree-pass.h
+++ b/gcc/tree-pass.h
@@ -412,6 +412,7 @@ extern gimple_opt_pass *make_pass_early_thread_jumps (gcc::context *ctxt);
 extern gimple_opt_pass *make_pass_split_crit_edges (gcc::context *ctxt);
 extern gimple_opt_pass *make_pass_laddress (gcc::context *ctxt);
 extern gimple_opt_pass *make_pass_pre (gcc::context *ctxt);
+extern gimple_opt_pass *make_pass_cfi (gcc::context *ctxt);
 extern unsigned int tail_merge_optimize (bool);
 extern gimple_opt_pass *make_pass_profile (gcc::context *ctxt);
 extern gimple_opt_pass *make_pass_strip_predict_hints (gcc::context *ctxt);
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
index 021e912a37c..c832075e1f3 100644
--- a/gcc/varasm.cc
+++ b/gcc/varasm.cc
@@ -1956,6 +1956,11 @@ assemble_start_function (tree decl, const char *fnname)
   if (!DECL_IGNORED_P (decl))
     (*debug_hooks->begin_function) (decl);
 
+  /* Regardless of whether the function can be called indirectly,
+     a typeid is always required before the function.  */
+  if (flag_sanitize & SANITIZE_CONTROL_FLOW_INTEGRITY)
+    targetm.asm_out.output_func_cfi_typeid (asm_out_file, decl);
+
   /* Make function name accessible from other files, if appropriate.  */
 
   if (TREE_PUBLIC (decl))
@@ -7674,6 +7679,30 @@ default_globalize_decl_name (FILE * stream, tree decl)
   targetm.asm_out.globalize_label (stream, name);
 }
 
+/* Default function to output the function's cfi typeid.  */
+void
+default_output_func_cfi_typeid (FILE * stream ATTRIBUTE_UNUSED,
+				tree decl ATTRIBUTE_UNUSED)
+{
+}
+
+/* Default function to generate gimple instructions to get the
+   typeid in front of the function pointed to by fptr.  */
+tree
+default_gimple_get_func_cfi_typeid (gimple_seq *stmts ATTRIBUTE_UNUSED,
+				    location_t loc ATTRIBUTE_UNUSED,
+				    tree fptr ATTRIBUTE_UNUSED)
+{
+  return NULL_TREE;
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

