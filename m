Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC00651380
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiLSTxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiLSTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:53:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B3913F68
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:53:20 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 485491EC06BB;
        Mon, 19 Dec 2022 20:53:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671479599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=vJI1xzguUjCJ3AL3Bxr2ECUeDlBeXHStIcyAC2xvic4=;
        b=Hsg//+ojSAWYvgfNID40rhg7xqucUrreeZrLws6MR8ZyKcpggZFJBJaXReRoGLb8HFrp1/
        ACULVKSdCRBxLXV9dEiNHMUiQp3Id+CGABLjVHbJZrAY1IFSRV+qK5PcJ9wIjo9zhQgmAV
        6Xynh6KT+7EE8gXhjiOKZla7JSkm0ao=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/alternatives: Add alt_instr.flags
Date:   Mon, 19 Dec 2022 20:53:12 +0100
Message-Id: <20221219195312.7054-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add struct alt_instr.flags field which will contain different flags
controlling alternatives patching behavior.

The initial idea was to be able to specify it as a separate macro
parameter but that would mean touching all possible invocations of the
alternatives macro and thus a lot of churn.

What is more, as PeterZ suggested, being able to say ALT_NOT(feature) is
very readable and explains exactly what is meant.

So have the patching flags be the upper word of the @feature u32
quantity parameter of the alternative macros while the lower u16 word is
the feature. The highest feature number currently is 0x26a (i.e., word
19) so we have plenty of space. If that becomes insufficient the macro
parameter can be extended to u64 which will then make struct alt_instr
of the nice size of 16 bytes.

The underlying magic splits the feature/flags parameter into two
separate u16 feature and u16 flags quantities which get assigned to the
respective alt_instr fields so that the alternativs code does not have
to do any macro massaging to the single field.

There should be no functional changes resulting from this.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h            | 124 +++++++++++-------
 arch/x86/kernel/alternative.c                 |  14 +-
 tools/objtool/arch/x86/include/arch/special.h |   2 +-
 3 files changed, 80 insertions(+), 60 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 7659217f4d49..62f3c88862d9 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -6,8 +6,16 @@
 #include <linux/stringify.h>
 #include <asm/asm.h>
 
-#define ALTINSTR_FLAG_INV	(1 << 15)
-#define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
+#define ALT_FLAGS_SHIFT		16
+
+#define ALT_FEAT_MASK		((1UL << ALT_FLAGS_SHIFT) - 1)
+#define ALT_FEAT(feature)	((feature) & ALT_FEAT_MASK)
+
+#define ALT_FLAGS_MASK		(ALT_FEAT_MASK << ALT_FLAGS_SHIFT)
+#define ALT_FLAGS(feature)	(((feature) & ALT_FLAGS_MASK) >> ALT_FLAGS_SHIFT)
+
+#define ALT_FLAG_NOT		BIT(0)
+#define ALT_NOT(feature)	((feature) | (ALT_FLAG_NOT << ALT_FLAGS_SHIFT))
 
 #ifndef __ASSEMBLY__
 
@@ -62,9 +70,10 @@
 struct alt_instr {
 	s32 instr_offset;	/* original instruction */
 	s32 repl_offset;	/* offset to replacement instruction */
-	u16 cpuid;		/* cpuid bit set for replacement */
+	u16 cpuid;		/* CPUID bit set for replacement */
 	u8  instrlen;		/* length of original instruction */
 	u8  replacementlen;	/* length of new instruction */
+	u16 flags;		/* patching control flags */
 } __packed;
 
 /*
@@ -182,36 +191,47 @@ static inline int alternatives_text_reserved(void *start, void *end)
 		" - (" alt_slen ")), 0x90\n"							\
 	alt_end_marker ":\n"
 
-#define ALTINSTR_ENTRY(feature, num)					      \
+#define ALTINSTR_ENTRY(feature, num, flags)				      \
 	" .long 661b - .\n"				/* label           */ \
 	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
 	" .word " __stringify(feature) "\n"		/* feature bit     */ \
 	" .byte " alt_total_slen "\n"			/* source len      */ \
-	" .byte " alt_rlen(num) "\n"			/* replacement len */
+	" .byte " alt_rlen(num) "\n"			/* replacement len */ \
+	" .word " __stringify(flags) "\n"		/* flags */
 
 #define ALTINSTR_REPLACEMENT(newinstr, num)		/* replacement */	\
 	"# ALT: replacement " #num "\n"						\
 	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
 
+/*
+ * The patching flags are part of the upper bits of the @ft_flgs parameter when
+ * specifying them. The split is currently like this:
+ *
+ * [31... flags ...16][15... CPUID feature bit ...0]
+ *
+ * but since this is all hidden in the macros argument being split, those fields can be
+ * extended in the future to fit in a u64 or however the need arises.
+ */
+
 /* alternative assembly primitive: */
-#define ALTERNATIVE(oldinstr, newinstr, feature)			\
+#define ALTERNATIVE(oldinstr, newinstr, ft_flgs)			\
 	OLDINSTR(oldinstr, 1)						\
 	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(feature, 1)					\
+	ALTINSTR_ENTRY(ALT_FEAT(ft_flgs), 1, ALT_FLAGS(ft_flgs))	\
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr, 1)				\
 	".popsection\n"
 
-#define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
-	OLDINSTR_2(oldinstr, 1, 2)					\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(feature1, 1)					\
-	ALTINSTR_ENTRY(feature2, 2)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr1, 1)				\
-	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
+#define ALTERNATIVE_2(oldinstr, newinstr1, ft_flgs1, newinstr2, ft_flgs2)	\
+	OLDINSTR_2(oldinstr, 1, 2)						\
+	".pushsection .altinstructions,\"a\"\n"					\
+	ALTINSTR_ENTRY(ALT_FEAT(ft_flgs1), 1, ALT_FLAGS(ft_flgs1))		\
+	ALTINSTR_ENTRY(ALT_FEAT(ft_flgs2), 2, ALT_FLAGS(ft_flgs2))		\
+	".popsection\n"								\
+	".pushsection .altinstr_replacement, \"ax\"\n"				\
+	ALTINSTR_REPLACEMENT(newinstr1, 1)					\
+	ALTINSTR_REPLACEMENT(newinstr2, 2)					\
 	".popsection\n"
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
@@ -219,12 +239,13 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 		      newinstr_yes, feature)
 
-#define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
+#define ALTERNATIVE_3(oldinsn, newinsn1, ft_flgs1, newinsn2, ft_flgs2, newinsn3, \
+		      ft_flgs3) \
 	OLDINSTR_3(oldinsn, 1, 2, 3)						\
 	".pushsection .altinstructions,\"a\"\n"					\
-	ALTINSTR_ENTRY(feat1, 1)						\
-	ALTINSTR_ENTRY(feat2, 2)						\
-	ALTINSTR_ENTRY(feat3, 3)						\
+	ALTINSTR_ENTRY(ALT_FEAT(ft_flgs1), 1, ALT_FLAGS(ft_flgs1))		\
+	ALTINSTR_ENTRY(ALT_FEAT(ft_flgs2), 2, ALT_FLAGS(ft_flgs2))		\
+	ALTINSTR_ENTRY(ALT_FEAT(ft_flgs3), 3, ALT_FLAGS(ft_flgs3))		\
 	".popsection\n"								\
 	".pushsection .altinstr_replacement, \"ax\"\n"				\
 	ALTINSTR_REPLACEMENT(newinsn1, 1)					\
@@ -244,14 +265,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * For non barrier like inlines please define new variants
  * without volatile and memory clobber.
  */
-#define alternative(oldinstr, newinstr, feature)			\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, feature) : : : "memory")
+#define alternative(oldinstr, newinstr, ft_flgs)			\
+	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flgs) : : : "memory")
 
-#define alternative_2(oldinstr, newinstr1, feature1, newinstr2, feature2) \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) ::: "memory")
+#define alternative_2(oldinstr, newinstr1, ft_flgs1, newinstr2, ft_flgs2) \
+	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flgs1, newinstr2, ft_flgs2) ::: "memory")
 
-#define alternative_ternary(oldinstr, feature, newinstr_yes, newinstr_no) \
-	asm_inline volatile(ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) ::: "memory")
+#define alternative_ternary(oldinstr, ft_flgs, newinstr_yes, newinstr_no) \
+	asm_inline volatile(ALTERNATIVE_TERNARY(oldinstr, ft_flgs, newinstr_yes, newinstr_no) ::: "memory")
 
 /*
  * Alternative inline assembly with input.
@@ -261,8 +282,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Argument numbers start with 1.
  * Leaving an unused argument 0 to keep API compatibility.
  */
-#define alternative_input(oldinstr, newinstr, feature, input...)	\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, feature)	\
+#define alternative_input(oldinstr, newinstr, ft_flgs, input...)	\
+	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flgs)	\
 		: : "i" (0), ## input)
 
 /*
@@ -273,20 +294,20 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, if CPU has feature1, newinstr1 is used.
  * Otherwise, oldinstr is used.
  */
-#define alternative_input_2(oldinstr, newinstr1, feature1, newinstr2,	     \
-			   feature2, input...)				     \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1,     \
-		newinstr2, feature2)					     \
+#define alternative_input_2(oldinstr, newinstr1, ft_flgs1, newinstr2,	     \
+			   ft_flgs2, input...)				     \
+	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flgs1,     \
+		newinstr2, ft_flgs2)					     \
 		: : "i" (0), ## input)
 
 /* Like alternative_input, but with a single output argument */
-#define alternative_io(oldinstr, newinstr, feature, output, input...)	\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, feature)	\
+#define alternative_io(oldinstr, newinstr, ft_flgs, output, input...)	\
+	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flgs)	\
 		: output : "i" (0), ## input)
 
 /* Like alternative_io, but for replacing a direct call with another one. */
-#define alternative_call(oldfunc, newfunc, feature, output, input...)	\
-	asm_inline volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
+#define alternative_call(oldfunc, newfunc, ft_flgs, output, input...)	\
+	asm_inline volatile (ALTERNATIVE("call %P[old]", "call %P[new]", ft_flgs) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
@@ -295,10 +316,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, if CPU has feature1, function1 is used.
  * Otherwise, old function is used.
  */
-#define alternative_call_2(oldfunc, newfunc1, feature1, newfunc2, feature2,   \
+#define alternative_call_2(oldfunc, newfunc1, ft_flgs1, newfunc2, ft_flgs2,   \
 			   output, input...)				      \
-	asm_inline volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
-		"call %P[new2]", feature2)				      \
+	asm_inline volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", ft_flgs1,\
+		"call %P[new2]", ft_flgs2)				      \
 		: output, ASM_CALL_CONSTRAINT				      \
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
 		  [new2] "i" (newfunc2), ## input)
@@ -347,12 +368,13 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * enough information for the alternatives patching code to patch an
  * instruction. See apply_alternatives().
  */
-.macro altinstruction_entry orig alt feature orig_len alt_len
+.macro altinstr_entry orig alt feature orig_len alt_len flags
 	.long \orig - .
 	.long \alt - .
 	.word \feature
 	.byte \orig_len
 	.byte \alt_len
+	.word \flags
 .endm
 
 /*
@@ -361,7 +383,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * @newinstr. ".skip" directive takes care of proper instruction padding
  * in case @newinstr is longer than @oldinstr.
  */
-.macro ALTERNATIVE oldinstr, newinstr, feature
+.macro ALTERNATIVE oldinstr, newinstr, ft_flgs
 140:
 	\oldinstr
 141:
@@ -369,7 +391,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 142:
 
 	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f
+	altinstr_entry 140b,143f,ALT_FEAT(\ft_flgs),142b-140b,144f-143f,ALT_FLAGS(\ft_flgs)
 	.popsection
 
 	.pushsection .altinstr_replacement,"ax"
@@ -399,7 +421,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
  * @feature2, it replaces @oldinstr with @feature2.
  */
-.macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
+.macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flgs1, newinstr2, ft_flgs2
 140:
 	\oldinstr
 141:
@@ -408,8 +430,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 142:
 
 	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f
-	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f
+	altinstr_entry 140b,143f,ALT_FEAT(\ft_flgs1),142b-140b,144f-143f,ALT_FLAGS(\ft_flgs1)
+	altinstr_entry 140b,144f,ALT_FEAT(\ft_flgs2),142b-140b,145f-144f,ALT_FLAGS(\ft_flgs2)
 	.popsection
 
 	.pushsection .altinstr_replacement,"ax"
@@ -421,7 +443,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	.popsection
 .endm
 
-.macro ALTERNATIVE_3 oldinstr, newinstr1, feature1, newinstr2, feature2, newinstr3, feature3
+.macro ALTERNATIVE_3 oldinstr, newinstr1, ft_flgs1, newinstr2, ft_flgs2, newinstr3, ft_flgs3
 140:
 	\oldinstr
 141:
@@ -430,9 +452,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 142:
 
 	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f
-	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f
-	altinstruction_entry 140b,145f,\feature3,142b-140b,146f-145f
+	altinstr_entry 140b,143f,ALT_FEAT(\ft_flgs1),142b-140b,144f-143f,ALT_FLAGS(\ft_flgs1)
+	altinstr_entry 140b,144f,ALT_FEAT(\ft_flgs2),142b-140b,145f-144f,ALT_FLAGS(\ft_flgs2)
+	altinstr_entry 140b,145f,ALT_FEAT(\ft_flgs3),142b-140b,146f-145f,ALT_FLAGS(\ft_flgs3)
 	.popsection
 
 	.pushsection .altinstr_replacement,"ax"
@@ -447,9 +469,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 .endm
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
-#define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) \
+#define ALTERNATIVE_TERNARY(oldinstr, ft_flgs, newinstr_yes, newinstr_no) \
 	ALTERNATIVE_2 oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
-	newinstr_yes, feature
+	newinstr_yes, ft_flgs
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 23cbfa8d34c5..4fd580ea3018 100644
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
index f2918f789a0a..bb4e634014d0 100644
--- a/tools/objtool/arch/x86/include/arch/special.h
+++ b/tools/objtool/arch/x86/include/arch/special.h
@@ -11,7 +11,7 @@
 #define JUMP_NEW_OFFSET		4
 #define JUMP_KEY_OFFSET		8
 
-#define ALT_ENTRY_SIZE		12
+#define ALT_ENTRY_SIZE		14
 #define ALT_ORIG_OFFSET		0
 #define ALT_NEW_OFFSET		4
 #define ALT_FEATURE_OFFSET	8
-- 
2.35.1

