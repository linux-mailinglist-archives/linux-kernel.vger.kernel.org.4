Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8460A650763
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 06:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiLSFz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 00:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiLSFzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 00:55:49 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FD521B4;
        Sun, 18 Dec 2022 21:55:47 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c7so5451410pfc.12;
        Sun, 18 Dec 2022 21:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AyBv2yXRlkeeO+f1+H4d1q5PY0y4eC9QhEdscvwNLko=;
        b=a7MCRIQ0ffuurW4I/AzKORy24PQy6iEOw0R9D0PddFYnpa6/o47E2KpKw5c/xHCQci
         ++poYRA9+sEAgcA2ZpfJq7S1U6a8Smrpj4h/KCSMssZmTTimLoJK30aCbVX7ILq0ZrQ6
         srC7ngABRHLSxR2SmKPJJKsFhyRMkjt5BFkmDxZYlldEk38SZ4P4M437oqASMMNAMMUs
         X4TzTzAUs6O0pCxKMR+BsiocI5xKqxCuvGE4v7I/2Sk0jBMTrRjTDEO/7cGQ9IN2OFM3
         16VUlLXlW5HfVTbeSe/yQCM5BsccBQB71/w4s+MToHYF5OHKAw1n60eYid9D4hnpg6v+
         ivgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyBv2yXRlkeeO+f1+H4d1q5PY0y4eC9QhEdscvwNLko=;
        b=bIErkx9lNq8DWKYwEIG8lU3kFoDoAA+0eFWo5TByU0+R7m+C+7tIwQEYLlVNvJFlKg
         9c5s8gJiyYw6AuoqY+IrdvgmV9NXL5BeoJGieFcSzf+Qif2iApUZ47NUvf+Gb+k9+Apt
         ZWzzKavCHTid4rRn4pKNyTy1IoRibXTGT99zYzMIBKSD7qqaebD6QilWmwqT+79Re+5A
         OaDqEVKMC1kjmBlXUCPcRo/45tsjjm6L6M5ql/M0EbLJCNi79Py+fcIDKlzxoY/AIuia
         JDxn+9WUY4Wquv+Fp3m5GfdSRBsLk6F8OIa/CVd4E/bjTaJUs166VnIM8EC1jT1OvLUr
         QFtw==
X-Gm-Message-State: AFqh2kpCRxbpHabEkZzgCWrUDiz9msrn7FDRI2R6XATY6LjyAeOm56Jd
        fg7YssPYaPKcejDQn52DT+k=
X-Google-Smtp-Source: AMrXdXslhaKo3Yl2VN4YoYZIe9fwnTM+MIhC3cQqnUth7HFJ2YAyOmmyVruTo0UdUNmPAFIQIcS/PQ==
X-Received: by 2002:a62:1653:0:b0:578:f6f:efab with SMTP id 80-20020a621653000000b005780f6fefabmr7649033pfw.11.1671429347221;
        Sun, 18 Dec 2022 21:55:47 -0800 (PST)
Received: from localhost ([103.152.220.92])
        by smtp.gmail.com with ESMTPSA id i6-20020a056a00004600b00577adb71f92sm5571562pfk.219.2022.12.18.21.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Dec 2022 21:55:46 -0800 (PST)
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
Subject: [RFC/RFT 3/3] [PR102768] aarch64: Add support for Control Flow Integrity
Date:   Sun, 18 Dec 2022 21:54:31 -0800
Message-Id: <20221219055431.22596-4-ashimida.1990@gmail.com>
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

In the AArch64 platform, typeid can be directly inserted in front
of the function header (offset is -4).

For all functions that will not be called indirectly, insert the
reserved RESERVED_CFI_TYPEID (0x0) as typeid in front of them. If
not, the attacker may use the instruction/data before the function
as typeid to bypass CFI.

All typeids ignore some bits (& AARCH64_UNALLOCATED_INSN_MASK) to
avoid conflicts with the AArch64 instruction set.

Signed-off-by: Dan Li <ashimida.1990@gmail.com>

gcc/ChangeLog:

	PR c/102768
	* config/aarch64/aarch64.cc (RESERVED_CFI_TYPEID): Macro definition.
	(DEFAULT_CFI_TYPEID): Likewise.
	(AARCH64_UNALLOCATED_INSN_MASK): Likewise.
	(aarch64_gimple_get_func_cfi_typeid): Platform-dependent
	CFI function.
	(aarch64_calc_func_cfi_typeid): Likewise.
	(cgraph_indirectly_callable): Determine whether a funtion may
	be called indirectly.
	(aarch64_output_func_cfi_typeid): Platform-dependent CFI function.
	(TARGET_HAVE_CFI): New hook.
	(TARGET_CALC_FUNC_CFI_TYPEID): Likewise.
	(TARGET_ASM_OUTPUT_FUNC_CFI_TYPEID): Likewise.
	(TARGET_GIMPLE_GET_FUNC_CFI_TYPEID): Likewise.
	* doc/invoke.texi: Document -fsanitize=cfi.

gcc/testsuite/ChangeLog:

	* gcc.target/aarch64/control_flow_integrity_1.c: New test.
	* gcc.target/aarch64/control_flow_integrity_2.c: New test.
	* gcc.target/aarch64/control_flow_integrity_3.c: New test.
---
 gcc/config/aarch64/aarch64.cc                 | 106 ++++++++++++++++++
 gcc/doc/invoke.texi                           |  35 ++++++
 .../aarch64/control_flow_integrity_1.c        |  14 +++
 .../aarch64/control_flow_integrity_2.c        |  25 +++++
 .../aarch64/control_flow_integrity_3.c        |  23 ++++
 5 files changed, 203 insertions(+)
 create mode 100644 gcc/testsuite/gcc.target/aarch64/control_flow_integrity_1.c
 create mode 100644 gcc/testsuite/gcc.target/aarch64/control_flow_integrity_2.c
 create mode 100644 gcc/testsuite/gcc.target/aarch64/control_flow_integrity_3.c

diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64.cc
index 5c9e7791a12..2796df0cdf3 100644
--- a/gcc/config/aarch64/aarch64.cc
+++ b/gcc/config/aarch64/aarch64.cc
@@ -81,6 +81,7 @@
 #include "rtlanal.h"
 #include "tree-dfa.h"
 #include "asan.h"
+#include "ssa.h"
 
 /* This file should be included last.  */
 #include "target-def.h"
@@ -5450,6 +5451,99 @@ aarch64_output_sve_addvl_addpl (rtx offset)
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
+/* Generate gimple insns to return the callee's typeid to a tmp var,
+   for aarch64, like:
+	__cfi_tmp = *(fptr - 4);  */
+
+static tree
+aarch64_gimple_get_func_cfi_typeid (gimple_seq *stmts,
+				    location_t loc, tree fptr)
+{
+  gimple *stmt;
+  tree result, rhs;
+
+  result = create_tmp_var (integer_type_node, "__cfi_tmp");
+  result = make_ssa_name (result, NULL);
+
+  rhs = build_pointer_type (integer_type_node);
+  rhs = build_int_cst_type (rhs, -4);
+  rhs = build2 (MEM_REF, integer_type_node, fptr, rhs);
+
+  stmt = gimple_build_assign (result, rhs);
+  gimple_set_location (stmt, loc);
+
+  SSA_NAME_DEF_STMT (result) = stmt;
+
+  gimple_seq_add_stmt (stmts, stmt);
+
+  return result;
+}
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
+aarch64_output_func_cfi_typeid (FILE * stream, tree decl)
+{
+  struct cgraph_node *node;
+  unsigned int cur_func_typeid;
+
+  node = cgraph_node::get (decl);
+
+  if (!node->call_for_symbol_thunks_and_aliases (cgraph_indirectly_callable,
+					       NULL, true))
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
+  fprintf (stream, "__cfi_%s:\n", get_name (decl));
+  fprintf (stream, "\t.4byte %#010x\n", cur_func_typeid);
+}
+
 /* Return true if X is a valid immediate for an SVE vector INC or DEC
    instruction.  If it is, store the number of elements in each vector
    quadword in *NELTS_PER_VQ_OUT (if nonnull) and store the multiplication
@@ -27823,6 +27917,18 @@ aarch64_libgcc_floating_mode_supported_p
 #undef TARGET_HAVE_SHADOW_CALL_STACK
 #define TARGET_HAVE_SHADOW_CALL_STACK true
 
+#undef TARGET_HAVE_CFI
+#define TARGET_HAVE_CFI true
+
+#undef TARGET_CALC_FUNC_CFI_TYPEID
+#define TARGET_CALC_FUNC_CFI_TYPEID aarch64_calc_func_cfi_typeid
+
+#undef TARGET_ASM_OUTPUT_FUNC_CFI_TYPEID
+#define TARGET_ASM_OUTPUT_FUNC_CFI_TYPEID aarch64_output_func_cfi_typeid
+
+#undef TARGET_GIMPLE_GET_FUNC_CFI_TYPEID
+#define TARGET_GIMPLE_GET_FUNC_CFI_TYPEID aarch64_gimple_get_func_cfi_typeid
+
 struct gcc_target targetm = TARGET_INITIALIZER;
 
 #include "gt-aarch64.h"
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index ff6c338bedb..302ae6fe370 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -15736,6 +15736,41 @@ to turn off exceptions.
 See @uref{https://clang.llvm.org/docs/ShadowCallStack.html} for more
 details.
 
+@item -fsanitize=cfi
+@opindex fsanitize=cfi
+The CFI sanitizer, enabled with @option{-fsanitize=cfi}, implements a
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
+requested by the caller.  If the match fails, the @code{cfi_check_failed}
+function will be called.  When enabling cfi, users need to implement this
+function by themselves.
+
+If a program contains indirect calls to assembly functions, they must be
+manually annotated with the expected type identifiers to prevent errors.
+To make this easier, CFI generates a weak SHN_ABS
+@code{__cfi_typeid_<function>} symbol for each address-taken function
+declaration, which can be used to annotate functions in assembly as long
+as at least one C translation unit linked into the program takes the
+function address.
+
+Currently this feature only supports the aarch64 platform, mainly for
+the linux kernel.  Users who want to use this feature in user space
+need to provide their own support for the runtime.
+
+See @uref{https://clang.llvm.org/docs/ControlFlowIntegrity.html} for
+more details.
+
 @item -fsanitize=thread
 @opindex fsanitize=thread
 Enable ThreadSanitizer, a fast data race detector.
diff --git a/gcc/testsuite/gcc.target/aarch64/control_flow_integrity_1.c b/gcc/testsuite/gcc.target/aarch64/control_flow_integrity_1.c
new file mode 100644
index 00000000000..0e53e294a96
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/control_flow_integrity_1.c
@@ -0,0 +1,14 @@
+/* Verify:
+     * typeid is output for an external declaration if and only if
+       its address is token within the current compilation unit.  */
+
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=cfi" } */
+
+extern int func1(void);
+extern int func2(void);
+
+int (*p)(void) = func1;
+
+/* { dg-final { scan-assembler-times {.weak __cfi_typeid_func} 1 } } */
+/* { dg-final { scan-assembler-times {.set __cfi_typeid_func} 1 } } */
diff --git a/gcc/testsuite/gcc.target/aarch64/control_flow_integrity_2.c b/gcc/testsuite/gcc.target/aarch64/control_flow_integrity_2.c
new file mode 100644
index 00000000000..36396a904f0
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/control_flow_integrity_2.c
@@ -0,0 +1,25 @@
+/* Verify:
+     * When CFI is enabled, the default typeid inserted before
+       functions that cannot be called indirectly is 0.
+     * The default typeid inserted before the function that can
+       be called indirectly is not 0.
+     * A __cfi_A symbol is always inserted before function A.  */
+
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=cfi" } */
+
+static int func1(void)
+{
+  return 0;
+}
+
+static int func2(void)
+{
+  return 0;
+}
+
+int (*p)(void) = func1;
+
+/* { dg-final { scan-assembler-times {.4byte} 2 } } */
+/* { dg-final { scan-assembler-times {.4byte 0000000000} 1 } } */
+/* { dg-final { scan-assembler-times {__cfi_func} 2 } } */
diff --git a/gcc/testsuite/gcc.target/aarch64/control_flow_integrity_3.c b/gcc/testsuite/gcc.target/aarch64/control_flow_integrity_3.c
new file mode 100644
index 00000000000..ad8880d526c
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/control_flow_integrity_3.c
@@ -0,0 +1,23 @@
+/* Verify:
+     * A cfi check is always inserted before an indirect function call,
+       and the cfi_check_failed function is called if the check fails.
+     * For functions with cfi disabled, no checks are inserted.  */
+
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=cfi" } */
+
+#define __no_cfi __attribute__((no_sanitize("cfi")))
+
+int (*p)(void);
+
+void __no_cfi func1(void)
+{
+  p();
+}
+
+void func2(void)
+{
+  p();
+}
+
+/* { dg-final { scan-assembler-times {bl\tcfi_check_failed} 1 } } */
-- 
2.17.1

