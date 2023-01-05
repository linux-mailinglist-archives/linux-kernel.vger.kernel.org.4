Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A805165EA43
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjAEL6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjAEL6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:58:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744CC58D0D;
        Thu,  5 Jan 2023 03:58:08 -0800 (PST)
Date:   Thu, 05 Jan 2023 11:58:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672919886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEs33ii6X7cBT+PKAxY4c/UzJXbc6RD2HXH3HSkJih8=;
        b=zJervcP26TRsRLgkuiIPfKB06EmMl2M+aGUKWbTXyQ7xc7qlL6Q4SFTKmaW67n6l/xKq6d
        GO6rovIAqltm7VkKRGQby5PEqQj4b6pG1WlLPqDu+WiDrNLQVyPxCZ7uwObKgLtM3HwHwm
        nC6LTsPGEE/+Z96Kw9UPUEVf6cqsgbzVQmKiwAKqlmpmDIXDOf0h4eoA6fFRKHn4yPj2sG
        +5lsR3G+MYPCakePsSlMbVhjlevYCH9TPGQbPCd/mhkrkOfm+EmMG+bk4WgJFyOGoPVGk7
        Hl0XnCeMkwBj3x3Z6KYkkWSu/fbEjCJhkTmmeXatOteVH9P2CzpG5yiWf7AAZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672919886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEs33ii6X7cBT+PKAxY4c/UzJXbc6RD2HXH3HSkJih8=;
        b=4Y+NZjX0saQkIvlesBF1sqPEMH1N0xZyV13kVeXkQdTxadEx7X9gFW/eSfyAuiyo4WZJRz
        CPOxvbE6oCQaZmDQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Add alt_instr.flags
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y6RCoJEtxxZWwotd@zn.tnic>
References: <Y6RCoJEtxxZWwotd@zn.tnic>
MIME-Version: 1.0
Message-ID: <167291988533.4906.1009298798479125447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     5d1dd961e74334a2178264193ea813d44ce5e725
Gitweb:        https://git.kernel.org/tip/5d1dd961e74334a2178264193ea813d44ce5e725
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 22 Dec 2022 12:42:24 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 05 Jan 2023 12:46:47 +01:00

x86/alternatives: Add alt_instr.flags

Add a struct alt_instr.flags field which will contain different flags
controlling alternatives patching behavior.

The initial idea was to be able to specify it as a separate macro
parameter but that would mean touching all possible invocations of the
alternatives macros and thus a lot of churn.

What is more, as PeterZ suggested, being able to say ALT_NOT(feature) is
very readable and explains exactly what is meant.

So make the feature field a u32 where the patching flags are the upper
u16 part of the dword quantity while the lower u16 word is the feature.

The highest feature number currently is 0x26a (i.e., word 19) so there
is plenty of space. If that becomes insufficient, the field can be
extended to u64 which will then make struct alt_instr of the nice size
of 16 bytes (14 bytes currently).

There should be no functional changes resulting from this.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/Y6RCoJEtxxZWwotd@zn.tnic
---
 arch/x86/include/asm/alternative.h            | 132 +++++++++--------
 arch/x86/kernel/alternative.c                 |  14 +--
 tools/objtool/arch/x86/include/arch/special.h |   6 +-
 3 files changed, 85 insertions(+), 67 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 7659217..e2975a3 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -6,8 +6,10 @@
 #include <linux/stringify.h>
 #include <asm/asm.h>
 
-#define ALTINSTR_FLAG_INV	(1 << 15)
-#define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
+#define ALT_FLAGS_SHIFT		16
+
+#define ALT_FLAG_NOT		BIT(0)
+#define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
 
 #ifndef __ASSEMBLY__
 
@@ -59,10 +61,27 @@
 	".long 999b - .\n\t"					\
 	".popsection\n\t"
 
+/*
+ * The patching flags are part of the upper bits of the @ft_flags parameter when
+ * specifying them. The split is currently like this:
+ *
+ * [31... flags ...16][15... CPUID feature bit ...0]
+ *
+ * but since this is all hidden in the macros argument being split, those fields can be
+ * extended in the future to fit in a u64 or however the need arises.
+ */
 struct alt_instr {
 	s32 instr_offset;	/* original instruction */
 	s32 repl_offset;	/* offset to replacement instruction */
-	u16 cpuid;		/* cpuid bit set for replacement */
+
+	union {
+		struct {
+			u32 cpuid: 16;	/* CPUID bit set for replacement */
+			u32 flags: 16;	/* patching control flags */
+		};
+		u32 ft_flags;
+	};
+
 	u8  instrlen;		/* length of original instruction */
 	u8  replacementlen;	/* length of new instruction */
 } __packed;
@@ -182,10 +201,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
 		" - (" alt_slen ")), 0x90\n"							\
 	alt_end_marker ":\n"
 
-#define ALTINSTR_ENTRY(feature, num)					      \
+#define ALTINSTR_ENTRY(ft_flags, num)					      \
 	" .long 661b - .\n"				/* label           */ \
 	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
-	" .word " __stringify(feature) "\n"		/* feature bit     */ \
+	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
 	" .byte " alt_total_slen "\n"			/* source len      */ \
 	" .byte " alt_rlen(num) "\n"			/* replacement len */
 
@@ -194,20 +213,20 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
 
 /* alternative assembly primitive: */
-#define ALTERNATIVE(oldinstr, newinstr, feature)			\
+#define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
 	OLDINSTR(oldinstr, 1)						\
 	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(feature, 1)					\
+	ALTINSTR_ENTRY(ft_flags, 1)					\
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr, 1)				\
 	".popsection\n"
 
-#define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
+#define ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	OLDINSTR_2(oldinstr, 1, 2)					\
 	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(feature1, 1)					\
-	ALTINSTR_ENTRY(feature2, 2)					\
+	ALTINSTR_ENTRY(ft_flags1, 1)					\
+	ALTINSTR_ENTRY(ft_flags2, 2)					\
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr1, 1)				\
@@ -215,21 +234,22 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	".popsection\n"
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
-#define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) \
+#define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
 	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
-		      newinstr_yes, feature)
-
-#define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
-	OLDINSTR_3(oldinsn, 1, 2, 3)						\
-	".pushsection .altinstructions,\"a\"\n"					\
-	ALTINSTR_ENTRY(feat1, 1)						\
-	ALTINSTR_ENTRY(feat2, 2)						\
-	ALTINSTR_ENTRY(feat3, 3)						\
-	".popsection\n"								\
-	".pushsection .altinstr_replacement, \"ax\"\n"				\
-	ALTINSTR_REPLACEMENT(newinsn1, 1)					\
-	ALTINSTR_REPLACEMENT(newinsn2, 2)					\
-	ALTINSTR_REPLACEMENT(newinsn3, 3)					\
+		      newinstr_yes, ft_flags)
+
+#define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2, \
+			newinsn3, ft_flags3)				\
+	OLDINSTR_3(oldinsn, 1, 2, 3)					\
+	".pushsection .altinstructions,\"a\"\n"				\
+	ALTINSTR_ENTRY(ft_flags1, 1)					\
+	ALTINSTR_ENTRY(ft_flags2, 2)					\
+	ALTINSTR_ENTRY(ft_flags3, 3)					\
+	".popsection\n"							\
+	".pushsection .altinstr_replacement, \"ax\"\n"			\
+	ALTINSTR_REPLACEMENT(newinsn1, 1)				\
+	ALTINSTR_REPLACEMENT(newinsn2, 2)				\
+	ALTINSTR_REPLACEMENT(newinsn3, 3)				\
 	".popsection\n"
 
 /*
@@ -244,14 +264,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * For non barrier like inlines please define new variants
  * without volatile and memory clobber.
  */
-#define alternative(oldinstr, newinstr, feature)			\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, feature) : : : "memory")
+#define alternative(oldinstr, newinstr, ft_flags)			\
+	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
 
-#define alternative_2(oldinstr, newinstr1, feature1, newinstr2, feature2) \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) ::: "memory")
+#define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
+	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
-#define alternative_ternary(oldinstr, feature, newinstr_yes, newinstr_no) \
-	asm_inline volatile(ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) ::: "memory")
+#define alternative_ternary(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
+	asm_inline volatile(ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) ::: "memory")
 
 /*
  * Alternative inline assembly with input.
@@ -261,8 +281,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Argument numbers start with 1.
  * Leaving an unused argument 0 to keep API compatibility.
  */
-#define alternative_input(oldinstr, newinstr, feature, input...)	\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, feature)	\
+#define alternative_input(oldinstr, newinstr, ft_flags, input...)	\
+	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
 		: : "i" (0), ## input)
 
 /*
@@ -273,20 +293,20 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, if CPU has feature1, newinstr1 is used.
  * Otherwise, oldinstr is used.
  */
-#define alternative_input_2(oldinstr, newinstr1, feature1, newinstr2,	     \
-			   feature2, input...)				     \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1,     \
-		newinstr2, feature2)					     \
+#define alternative_input_2(oldinstr, newinstr1, ft_flags1, newinstr2,	     \
+			   ft_flags2, input...)				     \
+	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1,     \
+		newinstr2, ft_flags2)					     \
 		: : "i" (0), ## input)
 
 /* Like alternative_input, but with a single output argument */
-#define alternative_io(oldinstr, newinstr, feature, output, input...)	\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, feature)	\
+#define alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
+	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
 		: output : "i" (0), ## input)
 
 /* Like alternative_io, but for replacing a direct call with another one. */
-#define alternative_call(oldfunc, newfunc, feature, output, input...)	\
-	asm_inline volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
+#define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
+	asm_inline volatile (ALTERNATIVE("call %P[old]", "call %P[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
@@ -295,10 +315,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, if CPU has feature1, function1 is used.
  * Otherwise, old function is used.
  */
-#define alternative_call_2(oldfunc, newfunc1, feature1, newfunc2, feature2,   \
+#define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,   \
 			   output, input...)				      \
-	asm_inline volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
-		"call %P[new2]", feature2)				      \
+	asm_inline volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", ft_flags1,\
+		"call %P[new2]", ft_flags2)				      \
 		: output, ASM_CALL_CONSTRAINT				      \
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
 		  [new2] "i" (newfunc2), ## input)
@@ -347,10 +367,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * enough information for the alternatives patching code to patch an
  * instruction. See apply_alternatives().
  */
-.macro altinstruction_entry orig alt feature orig_len alt_len
+.macro altinstr_entry orig alt ft_flags orig_len alt_len
 	.long \orig - .
 	.long \alt - .
-	.word \feature
+	.4byte \ft_flags
 	.byte \orig_len
 	.byte \alt_len
 .endm
@@ -361,7 +381,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * @newinstr. ".skip" directive takes care of proper instruction padding
  * in case @newinstr is longer than @oldinstr.
  */
-.macro ALTERNATIVE oldinstr, newinstr, feature
+.macro ALTERNATIVE oldinstr, newinstr, ft_flags
 140:
 	\oldinstr
 141:
@@ -369,7 +389,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 142:
 
 	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f
+	altinstr_entry 140b,143f,\ft_flags,142b-140b,144f-143f
 	.popsection
 
 	.pushsection .altinstr_replacement,"ax"
@@ -399,7 +419,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
  * @feature2, it replaces @oldinstr with @feature2.
  */
-.macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
+.macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
 140:
 	\oldinstr
 141:
@@ -408,8 +428,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 142:
 
 	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f
-	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f
+	altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f
+	altinstr_entry 140b,144f,\ft_flags2,142b-140b,145f-144f
 	.popsection
 
 	.pushsection .altinstr_replacement,"ax"
@@ -421,7 +441,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	.popsection
 .endm
 
-.macro ALTERNATIVE_3 oldinstr, newinstr1, feature1, newinstr2, feature2, newinstr3, feature3
+.macro ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
 140:
 	\oldinstr
 141:
@@ -430,9 +450,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 142:
 
 	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f
-	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f
-	altinstruction_entry 140b,145f,\feature3,142b-140b,146f-145f
+	altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f
+	altinstr_entry 140b,144f,\ft_flags2,142b-140b,145f-144f
+	altinstr_entry 140b,145f,\ft_flags3,142b-140b,146f-145f
 	.popsection
 
 	.pushsection .altinstr_replacement,"ax"
@@ -447,9 +467,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 .endm
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
-#define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) \
+#define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
 	ALTERNATIVE_2 oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
-	newinstr_yes, feature
+	newinstr_yes, ft_flags
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7d8c3cb..9a45aa1 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -282,27 +282,25 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	 */
 	for (a = start; a < end; a++) {
 		int insn_buff_sz = 0;
-		/* Mask away "NOT" flag bit for feature to test. */
-		u16 feature = a->cpuid & ~ALTINSTR_FLAG_INV;
 
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insn_buff));
-		BUG_ON(feature >= (NCAPINTS + NBUGINTS) * 32);
+		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
 
 		/*
 		 * Patch if either:
 		 * - feature is present
-		 * - feature not present but ALTINSTR_FLAG_INV is set to mean,
+		 * - feature not present but ALT_FLAG_NOT is set to mean,
 		 *   patch if feature is *NOT* present.
 		 */
-		if (!boot_cpu_has(feature) == !(a->cpuid & ALTINSTR_FLAG_INV))
+		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT))
 			goto next;
 
 		DPRINTK("feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
-			(a->cpuid & ALTINSTR_FLAG_INV) ? "!" : "",
-			feature >> 5,
-			feature & 0x1f,
+			(a->flags & ALT_FLAG_NOT) ? "!" : "",
+			a->cpuid >> 5,
+			a->cpuid & 0x1f,
 			instr, instr, a->instrlen,
 			replacement, a->replacementlen);
 
diff --git a/tools/objtool/arch/x86/include/arch/special.h b/tools/objtool/arch/x86/include/arch/special.h
index f2918f7..ca81313 100644
--- a/tools/objtool/arch/x86/include/arch/special.h
+++ b/tools/objtool/arch/x86/include/arch/special.h
@@ -11,11 +11,11 @@
 #define JUMP_NEW_OFFSET		4
 #define JUMP_KEY_OFFSET		8
 
-#define ALT_ENTRY_SIZE		12
+#define ALT_ENTRY_SIZE		14
 #define ALT_ORIG_OFFSET		0
 #define ALT_NEW_OFFSET		4
 #define ALT_FEATURE_OFFSET	8
-#define ALT_ORIG_LEN_OFFSET	10
-#define ALT_NEW_LEN_OFFSET	11
+#define ALT_ORIG_LEN_OFFSET	12
+#define ALT_NEW_LEN_OFFSET	13
 
 #endif /* _X86_ARCH_SPECIAL_H */
