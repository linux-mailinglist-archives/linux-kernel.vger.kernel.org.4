Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3B649BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiLLKJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiLLKJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:09:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AC2B49D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:09:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670839746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QhmeWKaRDt4D1ppXkeL7wrFiMbDDqpm4otWbkGCihNA=;
        b=zhnGPDx6meCUMuZH63mrEj0nT9mPB/dAZlzSPuUeqjs/5nZuxM5+uebVI7AkuP683v47HO
        vjsr9YmwU6ZwZEolU/7kNE9GgtiO5yRcFlfklvHlhbA0iGgHHX0iMjw/LkB8nhBmdbQXzX
        rF82X+P/CCBOG5W7O6gldfRZ7vxgFxnZ4e6luv1JZfiTNzpLs5vDQxUswZnCOuXcMNevRW
        WjSs2PRvcXilySrx0jzUezyC2CgoUgh9ePHPa4RWSE/pjoZVWFiJGeNHSwPTxTRPM39+TW
        E8YZ8XNJ4rr8LsKSiKItia0hYRFuq9XgJZBkphna0wVy6rhWT29Kmpw8qg2b1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670839746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QhmeWKaRDt4D1ppXkeL7wrFiMbDDqpm4otWbkGCihNA=;
        b=BfBulc6t9JwbeM3axvOvjVcZiX1k/XvavgSY8HsoCIr/pCHsMBHV/SLspE0uZ6fdQaPzhb
        42VvGa7pzAfhYPCQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/cleanups for v6.2-rc1
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
Message-ID: <167083908533.564878.10400182618682606020.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 12 Dec 2022 11:09:06 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/cleanups branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-202=
2-12-10

up to:  ff4c85c05333: x86/asm/32: Remove setup_once()

A set of x86 cleanups:

  - Rework the handling of x86_regset for 32 and 64 bit. The original
    implementation tried to minimize the allocation size with quite some
    hard to understand and fragile tricks. Make it robust and straight
    forward by separating the register enumerations for 32 and 64 bit
    completely.

  - Add a few missing static annotations

  - Remove the stale unused setup_once() assembly function

  - Address a few minor static analysis and kernel-doc warnings


Thanks,

	tglx

------------------>
Brian Gerst (1):
      x86/asm/32: Remove setup_once()

Chen Lifu (2):
      x86/tsc: Make art_related_clocksource static
      x86/i8259: Make default_legacy_pic static

Jiapeng Chong (2):
      x86: Fix misc small issues
      x86/kaslr: Fix process_mem_region()'s return value

Lukas Bulwahn (1):
      x86/boot: Repair kernel-doc for boot_kstrtoul()

Rick Edgecombe (2):
      x86: Separate out x86_regset for 32 and 64 bit
      x86: Improve formatting of user_regset arrays


 arch/x86/boot/compressed/kaslr.c |   2 +-
 arch/x86/boot/string.c           |   2 +-
 arch/x86/kernel/alternative.c    |   2 +-
 arch/x86/kernel/head_32.S        |  22 -----
 arch/x86/kernel/i8259.c          |   2 +-
 arch/x86/kernel/ptrace.c         | 174 ++++++++++++++++++++++++-------------=
--
 arch/x86/kernel/traps.c          |   4 +-
 arch/x86/kernel/tsc.c            |   2 +-
 8 files changed, 115 insertions(+), 95 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kasl=
r.c
index e476bcbd9b42..454757fbdfe5 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -668,7 +668,7 @@ static bool process_mem_region(struct mem_vector *region,
 		}
 	}
 #endif
-	return 0;
+	return false;
 }
=20
 #ifdef CONFIG_EFI
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 8a3fff9128bb..1c8541ae3b3a 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -350,7 +350,7 @@ static int _kstrtoul(const char *s, unsigned int base, un=
signed long *res)
 }
=20
 /**
- * kstrtoul - convert a string to an unsigned long
+ * boot_kstrtoul - convert a string to an unsigned long
  * @s: The start of the string. The string must be null-terminated, and may =
also
  *  include a single newline before its terminating null. The first character
  *  may also be a plus sign, but not a minus sign.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5cadcea035e0..d5f1e13648ac 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1608,7 +1608,7 @@ static void text_poke_loc_init(struct text_poke_loc *tp=
, void *addr,
=20
 	default:
 		BUG_ON(len !=3D insn.length);
-	};
+	}
=20
=20
 	switch (tp->opcode) {
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 9b7acc9c7874..67c8ed99144b 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -260,16 +260,6 @@ SYM_FUNC_START(startup_32_smp)
 	/* Shift the stack pointer to a virtual address */
 	addl $__PAGE_OFFSET, %esp
=20
-/*
- * start system 32-bit setup. We need to re-do some of the things done
- * in 16-bit mode for the "real" operations.
- */
-	movl setup_once_ref,%eax
-	andl %eax,%eax
-	jz 1f				# Did we do this already?
-	call *%eax
-1:
-
 /*
  * Check if it is 486
  */
@@ -331,18 +321,7 @@ SYM_FUNC_END(startup_32_smp)
=20
 #include "verify_cpu.S"
=20
-/*
- *  setup_once
- *
- *  The setup work we only want to run on the BSP.
- *
- *  Warning: %esi is live across this function.
- */
 __INIT
-setup_once:
-	andl $0,setup_once_ref	/* Once is enough, thanks */
-	RET
-
 SYM_FUNC_START(early_idt_handler_array)
 	# 36(%esp) %eflags
 	# 32(%esp) %cs
@@ -458,7 +437,6 @@ SYM_DATA(early_recursion_flag, .long 0)
 __REFDATA
 	.align 4
 SYM_DATA(initial_code,		.long i386_start_kernel)
-SYM_DATA(setup_once_ref,	.long setup_once)
=20
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 #define	PGD_ALIGN	(2 * PAGE_SIZE)
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 15aefa3f3e18..3aa5304200c5 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -407,7 +407,7 @@ struct legacy_pic null_legacy_pic =3D {
 	.make_irq =3D legacy_pic_uint_noop,
 };
=20
-struct legacy_pic default_legacy_pic =3D {
+static struct legacy_pic default_legacy_pic =3D {
 	.nr_legacy_irqs =3D NR_IRQS_LEGACY,
 	.chip  =3D &i8259A_chip,
 	.mask =3D mask_8259A_irq,
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 37c12fb92906..dfaa270a7cc9 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -44,16 +44,35 @@
=20
 #include "tls.h"
=20
-enum x86_regset {
-	REGSET_GENERAL,
-	REGSET_FP,
-	REGSET_XFP,
-	REGSET_IOPERM64 =3D REGSET_XFP,
-	REGSET_XSTATE,
-	REGSET_TLS,
-	REGSET_IOPERM32,
+enum x86_regset_32 {
+	REGSET32_GENERAL,
+	REGSET32_FP,
+	REGSET32_XFP,
+	REGSET32_XSTATE,
+	REGSET32_TLS,
+	REGSET32_IOPERM,
 };
=20
+enum x86_regset_64 {
+	REGSET64_GENERAL,
+	REGSET64_FP,
+	REGSET64_IOPERM,
+	REGSET64_XSTATE,
+};
+
+#define REGSET_GENERAL \
+({ \
+	BUILD_BUG_ON((int)REGSET32_GENERAL !=3D (int)REGSET64_GENERAL); \
+	REGSET32_GENERAL; \
+})
+
+#define REGSET_FP \
+({ \
+	BUILD_BUG_ON((int)REGSET32_FP !=3D (int)REGSET64_FP); \
+	REGSET32_FP; \
+})
+
+
 struct pt_regs_offset {
 	const char *name;
 	int offset;
@@ -788,13 +807,13 @@ long arch_ptrace(struct task_struct *child, long reques=
t,
 #ifdef CONFIG_X86_32
 	case PTRACE_GETFPXREGS:	/* Get the child extended FPU state. */
 		return copy_regset_to_user(child, &user_x86_32_view,
-					   REGSET_XFP,
+					   REGSET32_XFP,
 					   0, sizeof(struct user_fxsr_struct),
 					   datap) ? -EIO : 0;
=20
 	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
 		return copy_regset_from_user(child, &user_x86_32_view,
-					     REGSET_XFP,
+					     REGSET32_XFP,
 					     0, sizeof(struct user_fxsr_struct),
 					     datap) ? -EIO : 0;
 #endif
@@ -1086,13 +1105,13 @@ static long ia32_arch_ptrace(struct task_struct *chil=
d, compat_long_t request,
=20
 	case PTRACE_GETFPXREGS:	/* Get the child extended FPU state. */
 		return copy_regset_to_user(child, &user_x86_32_view,
-					   REGSET_XFP, 0,
+					   REGSET32_XFP, 0,
 					   sizeof(struct user32_fxsr_struct),
 					   datap);
=20
 	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
 		return copy_regset_from_user(child, &user_x86_32_view,
-					     REGSET_XFP, 0,
+					     REGSET32_XFP, 0,
 					     sizeof(struct user32_fxsr_struct),
 					     datap);
=20
@@ -1215,29 +1234,38 @@ long compat_arch_ptrace(struct task_struct *child, co=
mpat_long_t request,
 #ifdef CONFIG_X86_64
=20
 static struct user_regset x86_64_regsets[] __ro_after_init =3D {
-	[REGSET_GENERAL] =3D {
-		.core_note_type =3D NT_PRSTATUS,
-		.n =3D sizeof(struct user_regs_struct) / sizeof(long),
-		.size =3D sizeof(long), .align =3D sizeof(long),
-		.regset_get =3D genregs_get, .set =3D genregs_set
+	[REGSET64_GENERAL] =3D {
+		.core_note_type	=3D NT_PRSTATUS,
+		.n		=3D sizeof(struct user_regs_struct) / sizeof(long),
+		.size		=3D sizeof(long),
+		.align		=3D sizeof(long),
+		.regset_get	=3D genregs_get,
+		.set		=3D genregs_set
 	},
-	[REGSET_FP] =3D {
-		.core_note_type =3D NT_PRFPREG,
-		.n =3D sizeof(struct fxregs_state) / sizeof(long),
-		.size =3D sizeof(long), .align =3D sizeof(long),
-		.active =3D regset_xregset_fpregs_active, .regset_get =3D xfpregs_get, .se=
t =3D xfpregs_set
+	[REGSET64_FP] =3D {
+		.core_note_type	=3D NT_PRFPREG,
+		.n		=3D sizeof(struct fxregs_state) / sizeof(long),
+		.size		=3D sizeof(long),
+		.align		=3D sizeof(long),
+		.active		=3D regset_xregset_fpregs_active,
+		.regset_get	=3D xfpregs_get,
+		.set		=3D xfpregs_set
 	},
-	[REGSET_XSTATE] =3D {
-		.core_note_type =3D NT_X86_XSTATE,
-		.size =3D sizeof(u64), .align =3D sizeof(u64),
-		.active =3D xstateregs_active, .regset_get =3D xstateregs_get,
-		.set =3D xstateregs_set
+	[REGSET64_XSTATE] =3D {
+		.core_note_type	=3D NT_X86_XSTATE,
+		.size		=3D sizeof(u64),
+		.align		=3D sizeof(u64),
+		.active		=3D xstateregs_active,
+		.regset_get	=3D xstateregs_get,
+		.set		=3D xstateregs_set
 	},
-	[REGSET_IOPERM64] =3D {
-		.core_note_type =3D NT_386_IOPERM,
-		.n =3D IO_BITMAP_LONGS,
-		.size =3D sizeof(long), .align =3D sizeof(long),
-		.active =3D ioperm_active, .regset_get =3D ioperm_get
+	[REGSET64_IOPERM] =3D {
+		.core_note_type	=3D NT_386_IOPERM,
+		.n		=3D IO_BITMAP_LONGS,
+		.size		=3D sizeof(long),
+		.align		=3D sizeof(long),
+		.active		=3D ioperm_active,
+		.regset_get	=3D ioperm_get
 	},
 };
=20
@@ -1256,43 +1284,57 @@ static const struct user_regset_view user_x86_64_view=
 =3D {
=20
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static struct user_regset x86_32_regsets[] __ro_after_init =3D {
-	[REGSET_GENERAL] =3D {
-		.core_note_type =3D NT_PRSTATUS,
-		.n =3D sizeof(struct user_regs_struct32) / sizeof(u32),
-		.size =3D sizeof(u32), .align =3D sizeof(u32),
-		.regset_get =3D genregs32_get, .set =3D genregs32_set
+	[REGSET32_GENERAL] =3D {
+		.core_note_type	=3D NT_PRSTATUS,
+		.n		=3D sizeof(struct user_regs_struct32) / sizeof(u32),
+		.size		=3D sizeof(u32),
+		.align		=3D sizeof(u32),
+		.regset_get	=3D genregs32_get,
+		.set		=3D genregs32_set
 	},
-	[REGSET_FP] =3D {
-		.core_note_type =3D NT_PRFPREG,
-		.n =3D sizeof(struct user_i387_ia32_struct) / sizeof(u32),
-		.size =3D sizeof(u32), .align =3D sizeof(u32),
-		.active =3D regset_fpregs_active, .regset_get =3D fpregs_get, .set =3D fpr=
egs_set
+	[REGSET32_FP] =3D {
+		.core_note_type	=3D NT_PRFPREG,
+		.n		=3D sizeof(struct user_i387_ia32_struct) / sizeof(u32),
+		.size		=3D sizeof(u32),
+		.align		=3D sizeof(u32),
+		.active		=3D regset_fpregs_active,
+		.regset_get	=3D fpregs_get,
+		.set		=3D fpregs_set
 	},
-	[REGSET_XFP] =3D {
-		.core_note_type =3D NT_PRXFPREG,
-		.n =3D sizeof(struct fxregs_state) / sizeof(u32),
-		.size =3D sizeof(u32), .align =3D sizeof(u32),
-		.active =3D regset_xregset_fpregs_active, .regset_get =3D xfpregs_get, .se=
t =3D xfpregs_set
+	[REGSET32_XFP] =3D {
+		.core_note_type	=3D NT_PRXFPREG,
+		.n		=3D sizeof(struct fxregs_state) / sizeof(u32),
+		.size		=3D sizeof(u32),
+		.align		=3D sizeof(u32),
+		.active		=3D regset_xregset_fpregs_active,
+		.regset_get	=3D xfpregs_get,
+		.set		=3D xfpregs_set
 	},
-	[REGSET_XSTATE] =3D {
-		.core_note_type =3D NT_X86_XSTATE,
-		.size =3D sizeof(u64), .align =3D sizeof(u64),
-		.active =3D xstateregs_active, .regset_get =3D xstateregs_get,
-		.set =3D xstateregs_set
+	[REGSET32_XSTATE] =3D {
+		.core_note_type	=3D NT_X86_XSTATE,
+		.size		=3D sizeof(u64),
+		.align		=3D sizeof(u64),
+		.active		=3D xstateregs_active,
+		.regset_get	=3D xstateregs_get,
+		.set		=3D xstateregs_set
 	},
-	[REGSET_TLS] =3D {
-		.core_note_type =3D NT_386_TLS,
-		.n =3D GDT_ENTRY_TLS_ENTRIES, .bias =3D GDT_ENTRY_TLS_MIN,
-		.size =3D sizeof(struct user_desc),
-		.align =3D sizeof(struct user_desc),
-		.active =3D regset_tls_active,
-		.regset_get =3D regset_tls_get, .set =3D regset_tls_set
+	[REGSET32_TLS] =3D {
+		.core_note_type	=3D NT_386_TLS,
+		.n		=3D GDT_ENTRY_TLS_ENTRIES,
+		.bias		=3D GDT_ENTRY_TLS_MIN,
+		.size		=3D sizeof(struct user_desc),
+		.align		=3D sizeof(struct user_desc),
+		.active		=3D regset_tls_active,
+		.regset_get	=3D regset_tls_get,
+		.set		=3D regset_tls_set
 	},
-	[REGSET_IOPERM32] =3D {
-		.core_note_type =3D NT_386_IOPERM,
-		.n =3D IO_BITMAP_BYTES / sizeof(u32),
-		.size =3D sizeof(u32), .align =3D sizeof(u32),
-		.active =3D ioperm_active, .regset_get =3D ioperm_get
+	[REGSET32_IOPERM] =3D {
+		.core_note_type	=3D NT_386_IOPERM,
+		.n		=3D IO_BITMAP_BYTES / sizeof(u32),
+		.size		=3D sizeof(u32),
+		.align		=3D sizeof(u32),
+		.active		=3D ioperm_active,
+		.regset_get	=3D ioperm_get
 	},
 };
=20
@@ -1311,10 +1353,10 @@ u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 void __init update_regset_xstate_info(unsigned int size, u64 xstate_mask)
 {
 #ifdef CONFIG_X86_64
-	x86_64_regsets[REGSET_XSTATE].n =3D size / sizeof(u64);
+	x86_64_regsets[REGSET64_XSTATE].n =3D size / sizeof(u64);
 #endif
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
-	x86_32_regsets[REGSET_XSTATE].n =3D size / sizeof(u64);
+	x86_32_regsets[REGSET32_XSTATE].n =3D size / sizeof(u64);
 #endif
 	xstate_fx_sw_bytes[USER_XSTATE_XCR0_WORD] =3D xstate_mask;
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 178015a820f0..c3bff64ee55e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -67,13 +67,13 @@
=20
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
-#include <asm/proto.h>
 #else
 #include <asm/processor-flags.h>
 #include <asm/setup.h>
-#include <asm/proto.h>
 #endif
=20
+#include <asm/proto.h>
+
 DECLARE_BITMAP(system_vectors, NR_VECTORS);
=20
 static inline void cond_local_irq_enable(struct pt_regs *regs)
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..a78e73da4a74 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -51,7 +51,7 @@ int tsc_clocksource_reliable;
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
-struct clocksource *art_related_clocksource;
+static struct clocksource *art_related_clocksource;
=20
 struct cyc2ns {
 	struct cyc2ns_data data[2];	/*  0 + 2*16 =3D 32 */

