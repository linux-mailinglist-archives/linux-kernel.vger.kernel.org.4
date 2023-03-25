Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCD86C8C57
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCYIMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCYIMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:12:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E3D196B7;
        Sat, 25 Mar 2023 01:12:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s20so3934725ljp.1;
        Sat, 25 Mar 2023 01:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679731923;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xjYjpB0mdpoS0QPDN63hP2X3k7rFnBva/pL54tIDB7M=;
        b=hZcm0cPoMDCQYOYlZ4AqFRciqQRKAMyq859w8tZ6ukPdnWUe5ht4VBhks+QYFTggiu
         EK87mcdtSaVSPp+VhBNb0g24gvnMDa4L9y3FGFwW2+dFAhBLSHMPbWuz1axbAZEX1evE
         UUleU0bNs3lhBZ8QxWmyImZ9cnMAqEuyxCJUniOVWnmW1e0mQJwXwA/zRazbAAdD93qE
         LpPx/M9yfSVDIs8w+tc9hkFYAt80BV/4rw2xZEXZ0onMglSW9JFV1FRMbP+89lHranH9
         Ge+iyXRBZgNFoH+9XZVvxHq4xM0CG3gNnlDw06BS4vdHt5gq2VYS+CpV0P/l+smzZJZ6
         QVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679731923;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjYjpB0mdpoS0QPDN63hP2X3k7rFnBva/pL54tIDB7M=;
        b=MEl5uSYNASon2ps8z+mh65qgUUTZRm1sJiWyfk/39H0n7fkGA7WeG2Cq0kQVyd4T4q
         cJ7sMN4Yb4bsDQMlk0njzEKJVXY9V41ANaC4/oHSR3ngm0u4ipgZ4BoYURkDmbJErExA
         aEtTbKaji4ZinMhB6QT/cm6lndyrABiIvMUaV9/JCg+eb+T/S2fMr4NtzDo+j0rRUOnA
         bHaWH6aFK4NztA1URU7m8jlPDUx0CTe+hg+RawiCY9Y43fx/xEXUjUsTCL2HF2D8ekT2
         OB44f6fjqIZR61LDr4NX7xy0czWY7L1+fsbze1xaH9vzVikhs4h1OiXodWwPbhcg9vc0
         e5SA==
X-Gm-Message-State: AAQBX9eHrWwkOvOWW4TjKhPD/3sfXQyKKC/edzC3jwtEKfBbuzVgxLaX
        t0dBBELD+xYB0rOGHTLx/wM=
X-Google-Smtp-Source: AKy350ZbnysVY8YpoX1s8UEtrWHT57i9q44UXRsKBheZBECbN3RIHkuwUj0KjMBsj8eDBXk3UR2X4g==
X-Received: by 2002:a2e:9843:0:b0:298:aa96:55c2 with SMTP id e3-20020a2e9843000000b00298aa9655c2mr1767051ljj.44.1679731922957;
        Sat, 25 Mar 2023 01:12:02 -0700 (PDT)
Received: from localhost ([188.119.65.94])
        by smtp.gmail.com with ESMTPSA id k20-20020a2e8894000000b00295b1b6e063sm3603036lji.34.2023.03.25.01.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Mar 2023 01:12:02 -0700 (PDT)
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
Subject: [RFC/RFT,V2 1/3] [PR102768] flag-types.h (enum sanitize_code): Extend sanitize_code to 64 bits to support more features
Date:   Sat, 25 Mar 2023 01:11:15 -0700
Message-Id: <20230325081117.93245-2-ashimida.1990@gmail.com>
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

32-bit sanitize_code can no longer accommodate new options,
extending it to 64-bit.

Signed-off-by: Dan Li <ashimida.1990@gmail.com>

gcc/ChangeLog:

	PR c/102768
	* asan.h (sanitize_flags_p): Promote to uint64_t.
	* common.opt: Likewise.
	* dwarf2asm.cc (dw2_output_indirect_constant_1): Likewise.
	* flag-types.h (enum sanitize_code): Likewise.
	* opt-suggestions.cc (option_proposer::build_option_suggestions):
	Likewise.
	* opts.cc (find_sanitizer_argument): Likewise.
	(report_conflicting_sanitizer_options): Likewise.
	(get_closest_sanitizer_option): Likewise.
	(parse_sanitizer_options): Likewise.
	(parse_no_sanitize_attribute): Likewise.
	* opts.h (parse_sanitizer_options): Likewise.
	(parse_no_sanitize_attribute): Likewise.
	* tree-cfg.cc (print_no_sanitize_attr_value): Likewise.

gcc/c-family/ChangeLog:

	* c-attribs.cc (add_no_sanitize_value): Likewise.
	(handle_no_sanitize_attribute): Likewise.
	* c-common.h (add_no_sanitize_value): Likewise.

gcc/c/ChangeLog:

	* c-parser.cc (c_parser_declaration_or_fndef): Likewise.

gcc/cp/ChangeLog:

	* typeck.cc (get_member_function_from_ptrfunc): Likewise.
---
 gcc/asan.h                |  4 +--
 gcc/c-family/c-attribs.cc | 10 +++---
 gcc/c-family/c-common.h   |  2 +-
 gcc/c/c-parser.cc         |  4 +--
 gcc/common.opt            |  4 +--
 gcc/cp/typeck.cc          |  2 +-
 gcc/dwarf2asm.cc          |  2 +-
 gcc/flag-types.h          | 65 ++++++++++++++++++++-------------------
 gcc/opt-suggestions.cc    |  2 +-
 gcc/opts.cc               | 22 ++++++-------
 gcc/opts.h                |  8 ++---
 gcc/tree-cfg.cc           |  2 +-
 12 files changed, 64 insertions(+), 63 deletions(-)

diff --git a/gcc/asan.h b/gcc/asan.h
index d4ea49cb240..5b98172549b 100644
--- a/gcc/asan.h
+++ b/gcc/asan.h
@@ -233,9 +233,9 @@ asan_protect_stack_decl (tree decl)
    remove all flags mentioned in "no_sanitize" of DECL_ATTRIBUTES.  */
 
 static inline bool
-sanitize_flags_p (unsigned int flag, const_tree fn = current_function_decl)
+sanitize_flags_p (uint64_t flag, const_tree fn = current_function_decl)
 {
-  unsigned int result_flags = flag_sanitize & flag;
+  uint64_t result_flags = flag_sanitize & flag;
   if (result_flags == 0)
     return false;
 
diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
index 111a33f405a..a73e2364525 100644
--- a/gcc/c-family/c-attribs.cc
+++ b/gcc/c-family/c-attribs.cc
@@ -1118,23 +1118,23 @@ handle_cold_attribute (tree *node, tree name, tree ARG_UNUSED (args),
 /* Add FLAGS for a function NODE to no_sanitize_flags in DECL_ATTRIBUTES.  */
 
 void
-add_no_sanitize_value (tree node, unsigned int flags)
+add_no_sanitize_value (tree node, uint64_t flags)
 {
   tree attr = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (node));
   if (attr)
     {
-      unsigned int old_value = tree_to_uhwi (TREE_VALUE (attr));
+      uint64_t old_value = tree_to_uhwi (TREE_VALUE (attr));
       flags |= old_value;
 
       if (flags == old_value)
 	return;
 
-      TREE_VALUE (attr) = build_int_cst (unsigned_type_node, flags);
+      TREE_VALUE (attr) = build_int_cst (long_long_unsigned_type_node, flags);
     }
   else
     DECL_ATTRIBUTES (node)
       = tree_cons (get_identifier ("no_sanitize"),
-		   build_int_cst (unsigned_type_node, flags),
+		   build_int_cst (long_long_unsigned_type_node, flags),
 		   DECL_ATTRIBUTES (node));
 }
 
@@ -1145,7 +1145,7 @@ static tree
 handle_no_sanitize_attribute (tree *node, tree name, tree args, int,
 			      bool *no_add_attrs)
 {
-  unsigned int flags = 0;
+  uint64_t flags = 0;
   *no_add_attrs = true;
   if (TREE_CODE (*node) != FUNCTION_DECL)
     {
diff --git a/gcc/c-family/c-common.h b/gcc/c-family/c-common.h
index 52a85bfb783..eb91b9703db 100644
--- a/gcc/c-family/c-common.h
+++ b/gcc/c-family/c-common.h
@@ -1500,7 +1500,7 @@ extern enum flt_eval_method
 excess_precision_mode_join (enum flt_eval_method, enum flt_eval_method);
 
 extern int c_flt_eval_method (bool ts18661_p);
-extern void add_no_sanitize_value (tree node, unsigned int flags);
+extern void add_no_sanitize_value (tree node, uint64_t flags);
 
 extern void maybe_add_include_fixit (rich_location *, const char *, bool);
 extern void maybe_suggest_missing_token_insertion (rich_location *richloc,
diff --git a/gcc/c/c-parser.cc b/gcc/c/c-parser.cc
index f679d53706a..9d55ea55fa6 100644
--- a/gcc/c/c-parser.cc
+++ b/gcc/c/c-parser.cc
@@ -2217,7 +2217,7 @@ c_parser_declaration_or_fndef (c_parser *parser, bool fndef_ok,
 		  start_init (NULL_TREE, asm_name, global_bindings_p (), &richloc);
 		  /* A parameter is initialized, which is invalid.  Don't
 		     attempt to instrument the initializer.  */
-		  int flag_sanitize_save = flag_sanitize;
+		  uint64_t flag_sanitize_save = flag_sanitize;
 		  if (nested && !empty_ok)
 		    flag_sanitize = 0;
 		  init = c_parser_expr_no_commas (parser, NULL);
@@ -2275,7 +2275,7 @@ c_parser_declaration_or_fndef (c_parser *parser, bool fndef_ok,
 		  start_init (d, asm_name, global_bindings_p (), &richloc);
 		  /* A parameter is initialized, which is invalid.  Don't
 		     attempt to instrument the initializer.  */
-		  int flag_sanitize_save = flag_sanitize;
+		  uint64_t flag_sanitize_save = flag_sanitize;
 		  if (TREE_CODE (d) == PARM_DECL)
 		    flag_sanitize = 0;
 		  init = c_parser_initializer (parser);
diff --git a/gcc/common.opt b/gcc/common.opt
index 8a0dafc522d..9613c2f8ba0 100644
--- a/gcc/common.opt
+++ b/gcc/common.opt
@@ -217,11 +217,11 @@ bool flag_opts_finished
 
 ; What the sanitizer should instrument
 Variable
-unsigned int flag_sanitize
+uint64_t flag_sanitize
 
 ; What sanitizers should recover from errors
 Variable
-unsigned int flag_sanitize_recover = (SANITIZE_UNDEFINED | SANITIZE_UNDEFINED_NONDEFAULT | SANITIZE_KERNEL_ADDRESS | SANITIZE_KERNEL_HWADDRESS) & ~(SANITIZE_UNREACHABLE | SANITIZE_RETURN)
+uint64_t flag_sanitize_recover = (SANITIZE_UNDEFINED | SANITIZE_UNDEFINED_NONDEFAULT | SANITIZE_KERNEL_ADDRESS | SANITIZE_KERNEL_HWADDRESS) & ~(SANITIZE_UNREACHABLE | SANITIZE_RETURN)
 
 ; Flag whether a prefix has been added to dump_base_name
 Variable
diff --git a/gcc/cp/typeck.cc b/gcc/cp/typeck.cc
index ceb80d9744f..0afaf58d87d 100644
--- a/gcc/cp/typeck.cc
+++ b/gcc/cp/typeck.cc
@@ -4023,7 +4023,7 @@ get_member_function_from_ptrfunc (tree *instance_ptrptr, tree function,
       idx = build1 (NOP_EXPR, vtable_index_type, e3);
       switch (TARGET_PTRMEMFUNC_VBIT_LOCATION)
 	{
-	  int flag_sanitize_save;
+	  uint64_t flag_sanitize_save;
 	case ptrmemfunc_vbit_in_pfn:
 	  e1 = cp_build_binary_op (input_location,
 				   BIT_AND_EXPR, idx, integer_one_node,
diff --git a/gcc/dwarf2asm.cc b/gcc/dwarf2asm.cc
index 274f574f25e..b54d1935d57 100644
--- a/gcc/dwarf2asm.cc
+++ b/gcc/dwarf2asm.cc
@@ -1026,7 +1026,7 @@ dw2_output_indirect_constant_1 (const char *sym, tree id)
   sym_ref = gen_rtx_SYMBOL_REF (Pmode, sym);
   /* Disable ASan for decl because redzones cause ABI breakage between GCC and
      libstdc++ for `.LDFCM*' variables.  See PR 78651 for details.  */
-  unsigned int save_flag_sanitize = flag_sanitize;
+  uint64_t save_flag_sanitize = flag_sanitize;
   flag_sanitize &= ~(SANITIZE_ADDRESS | SANITIZE_USER_ADDRESS
 		     | SANITIZE_KERNEL_ADDRESS);
   /* And also temporarily disable -fsection-anchors.  These indirect constants
diff --git a/gcc/flag-types.h b/gcc/flag-types.h
index 2c8498169e0..0aa51e282fb 100644
--- a/gcc/flag-types.h
+++ b/gcc/flag-types.h
@@ -287,42 +287,43 @@ enum auto_init_type {
 /* Different instrumentation modes.  */
 enum sanitize_code {
   /* AddressSanitizer.  */
-  SANITIZE_ADDRESS = 1UL << 0,
-  SANITIZE_USER_ADDRESS = 1UL << 1,
-  SANITIZE_KERNEL_ADDRESS = 1UL << 2,
+  SANITIZE_ADDRESS = 1ULL << 0,
+  SANITIZE_USER_ADDRESS = 1ULL << 1,
+  SANITIZE_KERNEL_ADDRESS = 1ULL << 2,
   /* ThreadSanitizer.  */
-  SANITIZE_THREAD = 1UL << 3,
+  SANITIZE_THREAD = 1ULL << 3,
   /* LeakSanitizer.  */
-  SANITIZE_LEAK = 1UL << 4,
+  SANITIZE_LEAK = 1ULL << 4,
   /* UndefinedBehaviorSanitizer.  */
-  SANITIZE_SHIFT_BASE = 1UL << 5,
-  SANITIZE_SHIFT_EXPONENT = 1UL << 6,
-  SANITIZE_DIVIDE = 1UL << 7,
-  SANITIZE_UNREACHABLE = 1UL << 8,
-  SANITIZE_VLA = 1UL << 9,
-  SANITIZE_NULL = 1UL << 10,
-  SANITIZE_RETURN = 1UL << 11,
-  SANITIZE_SI_OVERFLOW = 1UL << 12,
-  SANITIZE_BOOL = 1UL << 13,
-  SANITIZE_ENUM = 1UL << 14,
-  SANITIZE_FLOAT_DIVIDE = 1UL << 15,
-  SANITIZE_FLOAT_CAST = 1UL << 16,
-  SANITIZE_BOUNDS = 1UL << 17,
-  SANITIZE_ALIGNMENT = 1UL << 18,
-  SANITIZE_NONNULL_ATTRIBUTE = 1UL << 19,
-  SANITIZE_RETURNS_NONNULL_ATTRIBUTE = 1UL << 20,
-  SANITIZE_OBJECT_SIZE = 1UL << 21,
-  SANITIZE_VPTR = 1UL << 22,
-  SANITIZE_BOUNDS_STRICT = 1UL << 23,
-  SANITIZE_POINTER_OVERFLOW = 1UL << 24,
-  SANITIZE_BUILTIN = 1UL << 25,
-  SANITIZE_POINTER_COMPARE = 1UL << 26,
-  SANITIZE_POINTER_SUBTRACT = 1UL << 27,
-  SANITIZE_HWADDRESS = 1UL << 28,
-  SANITIZE_USER_HWADDRESS = 1UL << 29,
-  SANITIZE_KERNEL_HWADDRESS = 1UL << 30,
+  SANITIZE_SHIFT_BASE = 1ULL << 5,
+  SANITIZE_SHIFT_EXPONENT = 1ULL << 6,
+  SANITIZE_DIVIDE = 1ULL << 7,
+  SANITIZE_UNREACHABLE = 1ULL << 8,
+  SANITIZE_VLA = 1ULL << 9,
+  SANITIZE_NULL = 1ULL << 10,
+  SANITIZE_RETURN = 1ULL << 11,
+  SANITIZE_SI_OVERFLOW = 1ULL << 12,
+  SANITIZE_BOOL = 1ULL << 13,
+  SANITIZE_ENUM = 1ULL << 14,
+  SANITIZE_FLOAT_DIVIDE = 1ULL << 15,
+  SANITIZE_FLOAT_CAST = 1ULL << 16,
+  SANITIZE_BOUNDS = 1ULL << 17,
+  SANITIZE_ALIGNMENT = 1ULL << 18,
+  SANITIZE_NONNULL_ATTRIBUTE = 1ULL << 19,
+  SANITIZE_RETURNS_NONNULL_ATTRIBUTE = 1ULL << 20,
+  SANITIZE_OBJECT_SIZE = 1ULL << 21,
+  SANITIZE_VPTR = 1ULL << 22,
+  SANITIZE_BOUNDS_STRICT = 1ULL << 23,
+  SANITIZE_POINTER_OVERFLOW = 1ULL << 24,
+  SANITIZE_BUILTIN = 1ULL << 25,
+  SANITIZE_POINTER_COMPARE = 1ULL << 26,
+  SANITIZE_POINTER_SUBTRACT = 1ULL << 27,
+  SANITIZE_HWADDRESS = 1ULL << 28,
+  SANITIZE_USER_HWADDRESS = 1ULL << 29,
+  SANITIZE_KERNEL_HWADDRESS = 1ULL << 30,
   /* Shadow Call Stack.  */
-  SANITIZE_SHADOW_CALL_STACK = 1UL << 31,
+  SANITIZE_SHADOW_CALL_STACK = 1ULL << 31,
+  SANITIZE_MAX = 1ULL << 63,
   SANITIZE_SHIFT = SANITIZE_SHIFT_BASE | SANITIZE_SHIFT_EXPONENT,
   SANITIZE_UNDEFINED = SANITIZE_SHIFT | SANITIZE_DIVIDE | SANITIZE_UNREACHABLE
 		       | SANITIZE_VLA | SANITIZE_NULL | SANITIZE_RETURN
diff --git a/gcc/opt-suggestions.cc b/gcc/opt-suggestions.cc
index 33f298560a1..c667e23e66f 100644
--- a/gcc/opt-suggestions.cc
+++ b/gcc/opt-suggestions.cc
@@ -173,7 +173,7 @@ option_proposer::build_option_suggestions (const char *prefix)
 		/* -fsanitize=all is not valid, only -fno-sanitize=all.
 		   So don't register the positive misspelling candidates
 		   for it.  */
-		if (sanitizer_opts[j].flag == ~0U && i == OPT_fsanitize_)
+		if (sanitizer_opts[j].flag == ~0ULL && i == OPT_fsanitize_)
 		  {
 		    optb = *option;
 		    optb.opt_text = opt_text = "-fno-sanitize=";
diff --git a/gcc/opts.cc b/gcc/opts.cc
index 3a89da2dd03..11c5d70458f 100644
--- a/gcc/opts.cc
+++ b/gcc/opts.cc
@@ -966,7 +966,7 @@ vec<const char *> help_option_arguments;
 /* Return the string name describing a sanitizer argument which has been
    provided on the command line and has set this particular flag.  */
 const char *
-find_sanitizer_argument (struct gcc_options *opts, unsigned int flags)
+find_sanitizer_argument (struct gcc_options *opts, uint64_t flags)
 {
   for (int i = 0; sanitizer_opts[i].name != NULL; ++i)
     {
@@ -1000,10 +1000,10 @@ find_sanitizer_argument (struct gcc_options *opts, unsigned int flags)
    set these flags.  */
 static void
 report_conflicting_sanitizer_options (struct gcc_options *opts, location_t loc,
-				      unsigned int left, unsigned int right)
+				      uint64_t left, uint64_t right)
 {
-  unsigned int left_seen = (opts->x_flag_sanitize & left);
-  unsigned int right_seen = (opts->x_flag_sanitize & right);
+  uint64_t left_seen = (opts->x_flag_sanitize & left);
+  uint64_t right_seen = (opts->x_flag_sanitize & right);
   if (left_seen && right_seen)
     {
       const char* left_arg = find_sanitizer_argument (opts, left_seen);
@@ -2059,7 +2059,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =
   SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true),
   SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true),
   SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false),
-  SANITIZER_OPT (all, ~0U, true),
+  SANITIZER_OPT (all, ~0ULL, true),
 #undef SANITIZER_OPT
   { NULL, 0U, 0UL, false }
 };
@@ -2128,7 +2128,7 @@ get_closest_sanitizer_option (const string_fragment &arg,
     {
       /* -fsanitize=all is not valid, so don't offer it.  */
       if (code == OPT_fsanitize_
-	  && opts[i].flag == ~0U
+	  && opts[i].flag == ~0ULL
 	  && value)
 	continue;
 
@@ -2148,9 +2148,9 @@ get_closest_sanitizer_option (const string_fragment &arg,
    adjust previous FLAGS and return new ones.  If COMPLAIN is false,
    don't issue diagnostics.  */
 
-unsigned int
+uint64_t
 parse_sanitizer_options (const char *p, location_t loc, int scode,
-			 unsigned int flags, int value, bool complain)
+			 uint64_t flags, int value, bool complain)
 {
   enum opt_code code = (enum opt_code) scode;
 
@@ -2176,7 +2176,7 @@ parse_sanitizer_options (const char *p, location_t loc, int scode,
 	    && memcmp (p, sanitizer_opts[i].name, len) == 0)
 	  {
 	    /* Handle both -fsanitize and -fno-sanitize cases.  */
-	    if (value && sanitizer_opts[i].flag == ~0U)
+	    if (value && sanitizer_opts[i].flag == ~0ULL)
 	      {
 		if (code == OPT_fsanitize_)
 		  {
@@ -2241,10 +2241,10 @@ parse_sanitizer_options (const char *p, location_t loc, int scode,
 /* Parse string values of no_sanitize attribute passed in VALUE.
    Values are separated with comma.  */
 
-unsigned int
+uint64_t
 parse_no_sanitize_attribute (char *value)
 {
-  unsigned int flags = 0;
+  uint64_t flags = 0;
   unsigned int i;
   char *q = strtok (value, ",");
 
diff --git a/gcc/opts.h b/gcc/opts.h
index a43ce66cffe..17a02cc7c14 100644
--- a/gcc/opts.h
+++ b/gcc/opts.h
@@ -425,10 +425,10 @@ extern void control_warning_option (unsigned int opt_index, int kind,
 extern char *write_langs (unsigned int mask);
 extern void print_ignored_options (void);
 extern void handle_common_deferred_options (void);
-unsigned int parse_sanitizer_options (const char *, location_t, int,
-				      unsigned int, int, bool);
+uint64_t parse_sanitizer_options (const char *, location_t, int,
+				      uint64_t, int, bool);
 
-unsigned int parse_no_sanitize_attribute (char *value);
+uint64_t parse_no_sanitize_attribute (char *value);
 extern bool common_handle_option (struct gcc_options *opts,
 				  struct gcc_options *opts_set,
 				  const struct cl_decoded_option *decoded,
@@ -470,7 +470,7 @@ extern bool opt_enum_arg_to_value (size_t opt_index, const char *arg,
 extern const struct sanitizer_opts_s
 {
   const char *const name;
-  unsigned int flag;
+  uint64_t flag;
   size_t len;
   bool can_recover;
 } sanitizer_opts[];
diff --git a/gcc/tree-cfg.cc b/gcc/tree-cfg.cc
index e321d929fd0..8cc31db9bea 100644
--- a/gcc/tree-cfg.cc
+++ b/gcc/tree-cfg.cc
@@ -8018,7 +8018,7 @@ dump_default_def (FILE *file, tree def, int spc, dump_flags_t flags)
 static void
 print_no_sanitize_attr_value (FILE *file, tree value)
 {
-  unsigned int flags = tree_to_uhwi (value);
+  uint64_t flags = tree_to_uhwi (value);
   bool first = true;
   for (int i = 0; sanitizer_opts[i].name != NULL; ++i)
     {
-- 
2.17.1

