Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237366155B3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiKAXET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiKAXEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:04:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE7389A;
        Tue,  1 Nov 2022 16:04:11 -0700 (PDT)
Date:   Tue, 01 Nov 2022 23:04:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667343849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WD+G+Uxb+v4ewbeu9TbEWW6KWo1rHolE90Dw44iBr0o=;
        b=zAC6ZC+YghB6aUW6BAYZluADi53ONy0z6dp2pPOSBqD0ipdUM7cbY0kQ1O4SWKXWgjcmN1
        /C/bkH17pide7ms/fQ/2HmV+NpX/xpKTJbRLU7RxP9WUWM9HYs0kl2aielwNz5DXGMdBkx
        m5M6XWkipVu+Vf4zsp0RU9RvNf6VE1UnCuVfyV57ElWS7A8+HhpfDlcMXITgrB5d0+wZWJ
        wF9avn8f/4+wAxWOxeZLizsxW4F7WJhswPW9xCg4acgge/kZR3Esr/wsORegYvvEZNvpf0
        E2cVsFMZ+P1jVm+AyrEFipYoi4U3HUJNMu3LYwfG0w301uDIwn8WtuUk/oQ4CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667343849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WD+G+Uxb+v4ewbeu9TbEWW6KWo1rHolE90Dw44iBr0o=;
        b=LHTftzKn6hBI9SLnbu4Cx2Mze8UMYU5Bu68lC9CShZTJvVSehqoLROz5yxmJyDISvkqjV6
        nWoy9t2NQKWVflBw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Separate out x86_regset for 32 and 64 bit
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166734384866.7716.1523996090665390520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     d28abd23b9270f67a9ad098d9338db6a8109fd59
Gitweb:        https://git.kernel.org/tip/d28abd23b9270f67a9ad098d9338db6a810=
9fd59
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Fri, 21 Oct 2022 15:18:02 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 01 Nov 2022 15:36:52 -07:00

x86: Separate out x86_regset for 32 and 64 bit

In fill_thread_core_info() the ptrace accessible registers are collected
for a core file to be written out as notes. The note array is allocated
from a size calculated by iterating the user regset view, and counting the
regsets that have a non-zero core_note_type. However, this only allows for
there to be non-zero core_note_type at the end of the regset view. If
there are any in the middle, fill_thread_core_info() will overflow the
note allocation, as it iterates over the size of the view and the
allocation would be smaller than that.

To apparently avoid this problem, x86_32_regsets and x86_64_regsets need
to be constructed in a special way. They both draw their indices from a
shared enum x86_regset, but 32 bit and 64 bit don't all support the same
regsets and can be compiled in at the same time in the case of
IA32_EMULATION. So this enum has to be laid out in a special way such that
there are no gaps for both x86_32_regsets and x86_64_regsets. This
involves ordering them just right by creating aliases for enum=E2=80=99s that
are only in one view or the other, or creating multiple versions like
REGSET32_IOPERM/REGSET64_IOPERM.

So the collection of the registers tries to minimize the size of the
allocation, but it doesn=E2=80=99t quite work. Then the x86 ptrace side works
around it by constructing the enum just right to avoid a problem. In the
end there is no functional problem, but it is somewhat strange and
fragile.

It could also be improved like this [1], by better utilizing the smaller
array, but this still wastes space in the regset array=E2=80=99s if they are =
not
carefully crafted to avoid gaps. Instead, just fully separate out the
enums and give them separate 32 and 64 enum names. Add some bitsize-free
defines for REGSET_GENERAL and REGSET_FP since they are the only two
referred to in bitsize generic code.

While introducing a bunch of new 32/64 enums, change the pattern of the
name from REGSET_FOO32 to REGSET32_FOO to better indicate that the 32 is
in reference to the CPU mode and not the register size, as suggested by
Eric Biederman.

This should have no functional change and is only changing how constants
are generated and referred to.

[1] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221021221803.10910-2-rick.p.edgecombe%40i=
ntel.com
---
 arch/x86/kernel/ptrace.c | 67 +++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 37c12fb..356495a 100644
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
@@ -1215,25 +1234,25 @@ long compat_arch_ptrace(struct task_struct *child, co=
mpat_long_t request,
 #ifdef CONFIG_X86_64
=20
 static struct user_regset x86_64_regsets[] __ro_after_init =3D {
-	[REGSET_GENERAL] =3D {
+	[REGSET64_GENERAL] =3D {
 		.core_note_type =3D NT_PRSTATUS,
 		.n =3D sizeof(struct user_regs_struct) / sizeof(long),
 		.size =3D sizeof(long), .align =3D sizeof(long),
 		.regset_get =3D genregs_get, .set =3D genregs_set
 	},
-	[REGSET_FP] =3D {
+	[REGSET64_FP] =3D {
 		.core_note_type =3D NT_PRFPREG,
 		.n =3D sizeof(struct fxregs_state) / sizeof(long),
 		.size =3D sizeof(long), .align =3D sizeof(long),
 		.active =3D regset_xregset_fpregs_active, .regset_get =3D xfpregs_get, .se=
t =3D xfpregs_set
 	},
-	[REGSET_XSTATE] =3D {
+	[REGSET64_XSTATE] =3D {
 		.core_note_type =3D NT_X86_XSTATE,
 		.size =3D sizeof(u64), .align =3D sizeof(u64),
 		.active =3D xstateregs_active, .regset_get =3D xstateregs_get,
 		.set =3D xstateregs_set
 	},
-	[REGSET_IOPERM64] =3D {
+	[REGSET64_IOPERM] =3D {
 		.core_note_type =3D NT_386_IOPERM,
 		.n =3D IO_BITMAP_LONGS,
 		.size =3D sizeof(long), .align =3D sizeof(long),
@@ -1256,31 +1275,31 @@ static const struct user_regset_view user_x86_64_view=
 =3D {
=20
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static struct user_regset x86_32_regsets[] __ro_after_init =3D {
-	[REGSET_GENERAL] =3D {
+	[REGSET32_GENERAL] =3D {
 		.core_note_type =3D NT_PRSTATUS,
 		.n =3D sizeof(struct user_regs_struct32) / sizeof(u32),
 		.size =3D sizeof(u32), .align =3D sizeof(u32),
 		.regset_get =3D genregs32_get, .set =3D genregs32_set
 	},
-	[REGSET_FP] =3D {
+	[REGSET32_FP] =3D {
 		.core_note_type =3D NT_PRFPREG,
 		.n =3D sizeof(struct user_i387_ia32_struct) / sizeof(u32),
 		.size =3D sizeof(u32), .align =3D sizeof(u32),
 		.active =3D regset_fpregs_active, .regset_get =3D fpregs_get, .set =3D fpr=
egs_set
 	},
-	[REGSET_XFP] =3D {
+	[REGSET32_XFP] =3D {
 		.core_note_type =3D NT_PRXFPREG,
 		.n =3D sizeof(struct fxregs_state) / sizeof(u32),
 		.size =3D sizeof(u32), .align =3D sizeof(u32),
 		.active =3D regset_xregset_fpregs_active, .regset_get =3D xfpregs_get, .se=
t =3D xfpregs_set
 	},
-	[REGSET_XSTATE] =3D {
+	[REGSET32_XSTATE] =3D {
 		.core_note_type =3D NT_X86_XSTATE,
 		.size =3D sizeof(u64), .align =3D sizeof(u64),
 		.active =3D xstateregs_active, .regset_get =3D xstateregs_get,
 		.set =3D xstateregs_set
 	},
-	[REGSET_TLS] =3D {
+	[REGSET32_TLS] =3D {
 		.core_note_type =3D NT_386_TLS,
 		.n =3D GDT_ENTRY_TLS_ENTRIES, .bias =3D GDT_ENTRY_TLS_MIN,
 		.size =3D sizeof(struct user_desc),
@@ -1288,7 +1307,7 @@ static struct user_regset x86_32_regsets[] __ro_after_i=
nit =3D {
 		.active =3D regset_tls_active,
 		.regset_get =3D regset_tls_get, .set =3D regset_tls_set
 	},
-	[REGSET_IOPERM32] =3D {
+	[REGSET32_IOPERM] =3D {
 		.core_note_type =3D NT_386_IOPERM,
 		.n =3D IO_BITMAP_BYTES / sizeof(u32),
 		.size =3D sizeof(u32), .align =3D sizeof(u32),
@@ -1311,10 +1330,10 @@ u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
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
