Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAD3662075
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbjAIIn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbjAIIma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:42:30 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 210CD13F8D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:42:27 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gCo8027420;
        Mon, 9 Jan 2023 09:42:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 01/22] tools/nolibc: make compiler and assembler agree on the section around _start
Date:   Mon,  9 Jan 2023 09:41:47 +0100
Message-Id: <20230109084208.27355-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230109084208.27355-1-w@1wt.eu>
References: <20230109084208.27355-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The out-of-block asm() statement carrying _start does not allow the
compiler to know what section the assembly code is being emitted to,
and there's no easy way to push/pop the current section and restore
it. It sometimes causes issues depending on the include files ordering
and compiler optimizations. For example if a variable is declared
immediately before the asm() block and another one after, the compiler
assumes that the current section is still .bss and doesn't re-emit it,
making the second variable appear inside the .text section instead.
Forcing .bss at the end of the _start block doesn't work either because
at certain optimizations the compiler may reorder blocks and will make
some real code appear just after this block.

A significant number of solutions were attempted, but many of them were
still sensitive to section reordering. In the end, the best way to make
sure the compiler and assembler agree on the current section is to place
this code inside a function. Here the function is directly called _start
and configured not to emit a frame-pointer, hence to have no prologue.
If some future architectures would still emit some prologue, another
working approach consists in naming the function differently and placing
the _start label inside the asm statement. But the current solution is
simpler.

It was tested with nolibc-test at -O,-O0,-O2,-O3,-Os for arm,arm64,i386,
mips,riscv,s390 and x86_64.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-aarch64.h | 29 ++++++++--------
 tools/include/nolibc/arch-arm.h     | 40 +++++++++-------------
 tools/include/nolibc/arch-i386.h    | 38 +++++++++++----------
 tools/include/nolibc/arch-mips.h    | 51 +++++++++++++++--------------
 tools/include/nolibc/arch-riscv.h   | 36 ++++++++++----------
 tools/include/nolibc/arch-s390.h    | 44 +++++++++++++------------
 tools/include/nolibc/arch-x86_64.h  | 30 +++++++++--------
 7 files changed, 135 insertions(+), 133 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index f68baf8f395f..4d263661411f 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -182,18 +182,19 @@ struct sys_stat_struct {
 })
 
 /* startup code */
-__asm__ (".section .text\n"
-    ".weak _start\n"
-    "_start:\n"
-    "ldr x0, [sp]\n"              // argc (x0) was in the stack
-    "add x1, sp, 8\n"             // argv (x1) = sp
-    "lsl x2, x0, 3\n"             // envp (x2) = 8*argc ...
-    "add x2, x2, 8\n"             //           + 8 (skip null)
-    "add x2, x2, x1\n"            //           + argv
-    "and sp, x1, -16\n"           // sp must be 16-byte aligned in the callee
-    "bl main\n"                   // main() returns the status code, we'll exit with it.
-    "mov x8, 93\n"                // NR_exit == 93
-    "svc #0\n"
-    "");
-
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+{
+	__asm__ volatile (
+		"ldr x0, [sp]\n"     // argc (x0) was in the stack
+		"add x1, sp, 8\n"    // argv (x1) = sp
+		"lsl x2, x0, 3\n"    // envp (x2) = 8*argc ...
+		"add x2, x2, 8\n"    //           + 8 (skip null)
+		"add x2, x2, x1\n"   //           + argv
+		"and sp, x1, -16\n"  // sp must be 16-byte aligned in the callee
+		"bl main\n"          // main() returns the status code, we'll exit with it.
+		"mov x8, 93\n"       // NR_exit == 93
+		"svc #0\n"
+	);
+	__builtin_unreachable();
+}
 #endif // _NOLIBC_ARCH_AARCH64_H
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index f31be8e967d6..875b21975137 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -175,30 +175,20 @@ struct sys_stat_struct {
 })
 
 /* startup code */
-__asm__ (".section .text\n"
-    ".weak _start\n"
-    "_start:\n"
-#if defined(__THUMBEB__) || defined(__THUMBEL__)
-    /* We enter here in 32-bit mode but if some previous functions were in
-     * 16-bit mode, the assembler cannot know, so we need to tell it we're in
-     * 32-bit now, then switch to 16-bit (is there a better way to do it than
-     * adding 1 by hand ?) and tell the asm we're now in 16-bit mode so that
-     * it generates correct instructions. Note that we do not support thumb1.
-     */
-    ".code 32\n"
-    "add     r0, pc, #1\n"
-    "bx      r0\n"
-    ".code 16\n"
-#endif
-    "pop {%r0}\n"                 // argc was in the stack
-    "mov %r1, %sp\n"              // argv = sp
-    "add %r2, %r1, %r0, lsl #2\n" // envp = argv + 4*argc ...
-    "add %r2, %r2, $4\n"          //        ... + 4
-    "and %r3, %r1, $-8\n"         // AAPCS : sp must be 8-byte aligned in the
-    "mov %sp, %r3\n"              //         callee, an bl doesn't push (lr=pc)
-    "bl main\n"                   // main() returns the status code, we'll exit with it.
-    "movs r7, $1\n"               // NR_exit == 1
-    "svc $0x00\n"
-    "");
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+{
+	__asm__ volatile (
+		"pop {%r0}\n"                 // argc was in the stack
+		"mov %r1, %sp\n"              // argv = sp
+		"add %r2, %r1, %r0, lsl #2\n" // envp = argv + 4*argc ...
+		"add %r2, %r2, $4\n"          //        ... + 4
+		"and %r3, %r1, $-8\n"         // AAPCS : sp must be 8-byte aligned in the
+		"mov %sp, %r3\n"              //         callee, an bl doesn't push (lr=pc)
+		"bl main\n"                   // main() returns the status code, we'll exit with it.
+		"movs r7, $1\n"               // NR_exit == 1
+		"svc $0x00\n"
+	  );
+	__builtin_unreachable();
+}
 
 #endif // _NOLIBC_ARCH_ARM_H
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index d7e7212346e2..b1bed2d87f74 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -197,23 +197,25 @@ struct sys_stat_struct {
  * 2) The deepest stack frame should be set to zero
  *
  */
-__asm__ (".section .text\n"
-    ".weak _start\n"
-    "_start:\n"
-    "pop %eax\n"                // argc   (first arg, %eax)
-    "mov %esp, %ebx\n"          // argv[] (second arg, %ebx)
-    "lea 4(%ebx,%eax,4),%ecx\n" // then a NULL then envp (third arg, %ecx)
-    "xor %ebp, %ebp\n"          // zero the stack frame
-    "and $-16, %esp\n"          // x86 ABI : esp must be 16-byte aligned before
-    "sub $4, %esp\n"            // the call instruction (args are aligned)
-    "push %ecx\n"               // push all registers on the stack so that we
-    "push %ebx\n"               // support both regparm and plain stack modes
-    "push %eax\n"
-    "call main\n"               // main() returns the status code in %eax
-    "mov %eax, %ebx\n"          // retrieve exit code (32-bit int)
-    "movl $1, %eax\n"           // NR_exit == 1
-    "int $0x80\n"               // exit now
-    "hlt\n"                     // ensure it does not
-    "");
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+{
+	__asm__ volatile (
+		"pop %eax\n"                // argc   (first arg, %eax)
+		"mov %esp, %ebx\n"          // argv[] (second arg, %ebx)
+		"lea 4(%ebx,%eax,4),%ecx\n" // then a NULL then envp (third arg, %ecx)
+		"xor %ebp, %ebp\n"          // zero the stack frame
+		"and $-16, %esp\n"          // x86 ABI : esp must be 16-byte aligned before
+		"sub $4, %esp\n"            // the call instruction (args are aligned)
+		"push %ecx\n"               // push all registers on the stack so that we
+		"push %ebx\n"               // support both regparm and plain stack modes
+		"push %eax\n"
+		"call main\n"               // main() returns the status code in %eax
+		"mov %eax, %ebx\n"          // retrieve exit code (32-bit int)
+		"movl $1, %eax\n"           // NR_exit == 1
+		"int $0x80\n"               // exit now
+		"hlt\n"                     // ensure it does not
+	);
+	__builtin_unreachable();
+}
 
 #endif // _NOLIBC_ARCH_I386_H
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 7380093ba9e7..11270ef25ea5 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -189,29 +189,32 @@ struct sys_stat_struct {
 })
 
 /* startup code, note that it's called __start on MIPS */
-__asm__ (".section .text\n"
-    ".weak __start\n"
-    ".set nomips16\n"
-    ".set push\n"
-    ".set    noreorder\n"
-    ".option pic0\n"
-    ".ent __start\n"
-    "__start:\n"
-    "lw $a0,($sp)\n"              // argc was in the stack
-    "addiu  $a1, $sp, 4\n"        // argv = sp + 4
-    "sll $a2, $a0, 2\n"           // a2 = argc * 4
-    "add   $a2, $a2, $a1\n"       // envp = argv + 4*argc ...
-    "addiu $a2, $a2, 4\n"         //        ... + 4
-    "li $t0, -8\n"
-    "and $sp, $sp, $t0\n"         // sp must be 8-byte aligned
-    "addiu $sp,$sp,-16\n"         // the callee expects to save a0..a3 there!
-    "jal main\n"                  // main() returns the status code, we'll exit with it.
-    "nop\n"                       // delayed slot
-    "move $a0, $v0\n"             // retrieve 32-bit exit code from v0
-    "li $v0, 4001\n"              // NR_exit == 4001
-    "syscall\n"
-    ".end __start\n"
-    ".set pop\n"
-    "");
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __start(void)
+{
+	__asm__ volatile (
+		//".set nomips16\n"
+		".set push\n"
+		".set    noreorder\n"
+		".option pic0\n"
+		//".ent __start\n"
+		//"__start:\n"
+		"lw $a0,($sp)\n"        // argc was in the stack
+		"addiu  $a1, $sp, 4\n"  // argv = sp + 4
+		"sll $a2, $a0, 2\n"     // a2 = argc * 4
+		"add   $a2, $a2, $a1\n" // envp = argv + 4*argc ...
+		"addiu $a2, $a2, 4\n"   //        ... + 4
+		"li $t0, -8\n"
+		"and $sp, $sp, $t0\n"   // sp must be 8-byte aligned
+		"addiu $sp,$sp,-16\n"   // the callee expects to save a0..a3 there!
+		"jal main\n"            // main() returns the status code, we'll exit with it.
+		"nop\n"                 // delayed slot
+		"move $a0, $v0\n"       // retrieve 32-bit exit code from v0
+		"li $v0, 4001\n"        // NR_exit == 4001
+		"syscall\n"
+		//".end __start\n"
+		".set pop\n"
+	);
+	__builtin_unreachable();
+}
 
 #endif // _NOLIBC_ARCH_MIPS_H
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index a3bdd9803f8c..bee769e6885c 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -183,22 +183,24 @@ struct sys_stat_struct {
 })
 
 /* startup code */
-__asm__ (".section .text\n"
-    ".weak _start\n"
-    "_start:\n"
-    ".option push\n"
-    ".option norelax\n"
-    "lla   gp, __global_pointer$\n"
-    ".option pop\n"
-    "lw    a0, 0(sp)\n"          // argc (a0) was in the stack
-    "add   a1, sp, "SZREG"\n"    // argv (a1) = sp
-    "slli  a2, a0, "PTRLOG"\n"   // envp (a2) = SZREG*argc ...
-    "add   a2, a2, "SZREG"\n"    //             + SZREG (skip null)
-    "add   a2,a2,a1\n"           //             + argv
-    "andi  sp,a1,-16\n"          // sp must be 16-byte aligned
-    "call  main\n"               // main() returns the status code, we'll exit with it.
-    "li a7, 93\n"                // NR_exit == 93
-    "ecall\n"
-    "");
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+{
+	__asm__ volatile (
+		".option push\n"
+		".option norelax\n"
+		"lla   gp, __global_pointer$\n"
+		".option pop\n"
+		"lw    a0, 0(sp)\n"          // argc (a0) was in the stack
+		"add   a1, sp, "SZREG"\n"    // argv (a1) = sp
+		"slli  a2, a0, "PTRLOG"\n"   // envp (a2) = SZREG*argc ...
+		"add   a2, a2, "SZREG"\n"    //             + SZREG (skip null)
+		"add   a2,a2,a1\n"           //             + argv
+		"andi  sp,a1,-16\n"          // sp must be 16-byte aligned
+		"call  main\n"               // main() returns the status code, we'll exit with it.
+		"li a7, 93\n"                // NR_exit == 93
+		"ecall\n"
+	);
+	__builtin_unreachable();
+}
 
 #endif // _NOLIBC_ARCH_RISCV_H
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 76bc8fdaf922..2c0b8847c050 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -172,27 +172,29 @@ struct sys_stat_struct {
 })
 
 /* startup code */
-__asm__ (".section .text\n"
-	 ".weak _start\n"
-	 "_start:\n"
-	 "lg	%r2,0(%r15)\n"		/* argument count */
-	 "la	%r3,8(%r15)\n"		/* argument pointers */
-
-	 "xgr	%r0,%r0\n"		/* r0 will be our NULL value */
-	 /* search for envp */
-	 "lgr	%r4,%r3\n"		/* start at argv */
-	 "0:\n"
-	 "clg	%r0,0(%r4)\n"		/* entry zero? */
-	 "la	%r4,8(%r4)\n"		/* advance pointer */
-	 "jnz	0b\n"			/* no -> test next pointer */
-					/* yes -> r4 now contains start of envp */
-
-	 "aghi	%r15,-160\n"		/* allocate new stackframe */
-	 "xc	0(8,%r15),0(%r15)\n"	/* clear backchain */
-	 "brasl	%r14,main\n"		/* ret value of main is arg to exit */
-	 "lghi	%r1,1\n"		/* __NR_exit */
-	 "svc	0\n"
-	 "");
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+{
+	__asm__ volatile (
+		"lg	%r2,0(%r15)\n"		/* argument count */
+		"la	%r3,8(%r15)\n"		/* argument pointers */
+
+		"xgr	%r0,%r0\n"		/* r0 will be our NULL value */
+		/* search for envp */
+		"lgr	%r4,%r3\n"		/* start at argv */
+		"0:\n"
+		"clg	%r0,0(%r4)\n"		/* entry zero? */
+		"la	%r4,8(%r4)\n"		/* advance pointer */
+		"jnz	0b\n"			/* no -> test next pointer */
+						/* yes -> r4 now contains start of envp */
+
+		"aghi	%r15,-160\n"		/* allocate new stackframe */
+		"xc	0(8,%r15),0(%r15)\n"	/* clear backchain */
+		"brasl	%r14,main\n"		/* ret value of main is arg to exit */
+		"lghi	%r1,1\n"		/* __NR_exit */
+		"svc	0\n"
+	);
+	__builtin_unreachable();
+}
 
 struct s390_mmap_arg_struct {
 	unsigned long addr;
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 0e1e9eb8545d..c70a84612a9e 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -197,19 +197,21 @@ struct sys_stat_struct {
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-__asm__ (".section .text\n"
-    ".weak _start\n"
-    "_start:\n"
-    "pop %rdi\n"                // argc   (first arg, %rdi)
-    "mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
-    "lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
-    "xor %ebp, %ebp\n"          // zero the stack frame
-    "and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned before call
-    "call main\n"               // main() returns the status code, we'll exit with it.
-    "mov %eax, %edi\n"          // retrieve exit code (32 bit)
-    "mov $60, %eax\n"           // NR_exit == 60
-    "syscall\n"                 // really exit
-    "hlt\n"                     // ensure it does not return
-    "");
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+{
+	__asm__ volatile (
+		"pop %rdi\n"                // argc   (first arg, %rdi)
+		"mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
+		"lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
+		"xor %ebp, %ebp\n"          // zero the stack frame
+		"and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned before call
+		"call main\n"               // main() returns the status code, we'll exit with it.
+		"mov %eax, %edi\n"          // retrieve exit code (32 bit)
+		"mov $60, %eax\n"           // NR_exit == 60
+		"syscall\n"                 // really exit
+		"hlt\n"                     // ensure it does not return
+	);
+	__builtin_unreachable();
+}
 
 #endif // _NOLIBC_ARCH_X86_64_H
-- 
2.17.5

