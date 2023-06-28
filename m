Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F232740F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjF1Kuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjF1KuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:50:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805AE2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dQhhXN6q1u9IPLMUe3ltzz0s2Q0FPq1N06ZjA8UwcEc=; b=pWYjnDtFl7PV2on/AIyrV/S9tS
        NijgExfTsk1frx0mgerjGlUeS5MKZNd2I8AENpx/T5ff7+F/bSlsKLORe6TS5UJKOodd2EmgM/Kk5
        ud0GyhaHIcD1zJlW3h2TjuxtUWTscqrVurrkz15rRlPxFv2EDu3WxKn5ZmgYR8RmG5o7/PsK2LaxK
        wv0U6j/MTvN200ujBVR4okvYUN5BwIk47bTckrcA/0I5le9gRbx/iEsgQ4jbvkXHK6W/aXI2GQ2Oi
        W4y0wFKN/igv6kuzNDqxNB5m+D6QULYzxVlY8hd1b2pOpoGeDMSh+GEqbDmHITL2/+kP1+eXm0G+D
        xX8M4vqw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qESkD-003hym-V5; Wed, 28 Jun 2023 10:49:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A8D33002C5;
        Wed, 28 Jun 2023 12:49:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D61A23B2EE90; Wed, 28 Jun 2023 12:49:52 +0200 (CEST)
Date:   Wed, 28 Jun 2023 12:49:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230628104952.GA2439977@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Instead of making increasingly complicated ALTERNATIVE_n()
implementations, use a nested alternative expression.

The only difference between:

  ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)

and

  ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),
              newinst2, flag2)

is that the outer alternative can add additional padding when the
inner alternative is the shorter one, which then results in
alt_instr::instrlen being inconsistent.

However, this is easily remedied since the alt_instr entries will be
consecutive and it is trivial to compute the max(alt_instr::instrlen)
at runtime while patching.

Specifically, after this patch the ALTERNATIVE_2 macro, after CPP
expansion (and manual layout), looks like this:

  .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
   140:

     140: \oldinstr ;
     141: .skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90 ;
     142: .pushsection .altinstructions,"a" ;
	  altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f ;
	  .popsection ; .pushsection .altinstr_replacement,"ax" ;
     143: \newinstr1 ;
     144: .popsection ; ;

   141: .skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90 ;
   142: .pushsection .altinstructions,"a" ;
	altinstr_entry 140b,143f,\ft_flags2,142b-140b,144f-143f ;
	.popsection ;
	.pushsection .altinstr_replacement,"ax" ;
   143: \newinstr2 ;
   144: .popsection ;
  .endm

The only label that is ambiguous is 140, however they all reference
the same spot, so that doesn't matter.

NOTE: obviously only @oldinstr may be an alternative; making @newinstr
an alternative would mean patching .altinstr_replacement which very
likely isn't what is intended, also the labels will be confused in
that case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative.h | 204 ++++++++++---------------------------
 arch/x86/kernel/alternative.c      |  13 ++-
 tools/objtool/arch/x86/special.c   |  23 +++++
 tools/objtool/special.c            |  16 +--
 4 files changed, 99 insertions(+), 157 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index d7da28fada87..beac4c199eab 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -155,102 +155,60 @@ static inline int alternatives_text_reserved(void *start, void *end)
 }
 #endif	/* CONFIG_SMP */
 
-#define b_replacement(num)	"664"#num
-#define e_replacement(num)	"665"#num
-
-#define alt_end_marker		"663"
 #define alt_slen		"662b-661b"
-#define alt_total_slen		alt_end_marker"b-661b"
-#define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
+#define alt_total_slen		"663b-661b"
+#define alt_rlen		"665f-664f"
 
-#define OLDINSTR(oldinstr, num)						\
+#define OLDINSTR(oldinstr)						\
 	"# ALT: oldnstr\n"						\
 	"661:\n\t" oldinstr "\n662:\n"					\
 	"# ALT: padding\n"						\
-	".skip -(((" alt_rlen(num) ")-(" alt_slen ")) > 0) * "		\
-		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"		\
-	alt_end_marker ":\n"
-
-/*
- * gas compatible max based on the idea from:
- * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
- *
- * The additional "-" is needed because gas uses a "true" value of -1.
- */
-#define alt_max_short(a, b)	"((" a ") ^ (((" a ") ^ (" b ")) & -(-((" a ") < (" b ")))))"
+	".skip -(((" alt_rlen ")-(" alt_slen ")) > 0) * "		\
+		"((" alt_rlen ")-(" alt_slen ")),0x90\n"		\
+	"663:\n"
 
-/*
- * Pad the second replacement alternative with additional NOPs if it is
- * additionally longer than the first replacement alternative.
- */
-#define OLDINSTR_2(oldinstr, num1, num2) \
-	"# ALT: oldinstr2\n"									\
-	"661:\n\t" oldinstr "\n662:\n"								\
-	"# ALT: padding2\n"									\
-	".skip -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")) > 0) * "	\
-		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0x90\n"	\
-	alt_end_marker ":\n"
-
-#define OLDINSTR_3(oldinsn, n1, n2, n3)								\
-	"# ALT: oldinstr3\n"									\
-	"661:\n\t" oldinsn "\n662:\n"								\
-	"# ALT: padding3\n"									\
-	".skip -((" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
-		" - (" alt_slen ")) > 0) * "							\
-		"(" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
-		" - (" alt_slen ")), 0x90\n"							\
-	alt_end_marker ":\n"
-
-#define ALTINSTR_ENTRY(ft_flags, num)					      \
+#define ALTINSTR_ENTRY(ft_flags)					      \
+	".pushsection .altinstructions,\"a\"\n"				      \
 	" .long 661b - .\n"				/* label           */ \
-	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
+	" .long 664f - .\n"				/* new instruction */ \
 	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
 	" .byte " alt_total_slen "\n"			/* source len      */ \
-	" .byte " alt_rlen(num) "\n"			/* replacement len */
+	" .byte " alt_rlen "\n"				/* replacement len */ \
+	".popsection\n"
 
-#define ALTINSTR_REPLACEMENT(newinstr, num)		/* replacement */	\
-	"# ALT: replacement " #num "\n"						\
-	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
+#define ALTINSTR_REPLACEMENT(newinstr)			/* replacement */	\
+	".pushsection .altinstr_replacement, \"ax\"\n"				\
+	"# ALT: replacement \n"							\
+	"664:\n\t" newinstr "\n 665:\n"						\
+	".popsection\n"
 
-/* alternative assembly primitive: */
+/*
+ * Define an alternative between two instructions. If @ft_flags is
+ * present, early code in apply_alternatives() replaces @oldinstr with
+ * @newinstr. ".skip" directive takes care of proper instruction padding
+ * in case @newinstr is longer than @oldinstr.
+ *
+ * Notably: @oldinstr may be an ALTERNATIVE() itself, also see
+ *          apply_alternatives()
+ */
 #define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
-	OLDINSTR(oldinstr, 1)						\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags, 1)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr, 1)				\
-	".popsection\n"
+	OLDINSTR(oldinstr)						\
+	ALTINSTR_ENTRY(ft_flags)					\
+	ALTINSTR_REPLACEMENT(newinstr)
 
-#define ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
-	OLDINSTR_2(oldinstr, 1, 2)					\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags1, 1)					\
-	ALTINSTR_ENTRY(ft_flags2, 2)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr1, 1)				\
-	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
-	".popsection\n"
+#define ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)	\
+	ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),		\
+		    newinst2, flag2)
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
 	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 		      newinstr_yes, ft_flags)
 
-#define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2, \
-			newinsn3, ft_flags3)				\
-	OLDINSTR_3(oldinsn, 1, 2, 3)					\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags1, 1)					\
-	ALTINSTR_ENTRY(ft_flags2, 2)					\
-	ALTINSTR_ENTRY(ft_flags3, 3)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinsn1, 1)				\
-	ALTINSTR_REPLACEMENT(newinsn2, 2)				\
-	ALTINSTR_REPLACEMENT(newinsn3, 3)				\
-	".popsection\n"
+#define ALTERNATIVE_3(oldinst, newinst1, flag1, newinst2, flag2,	\
+		      newinst3, flag3)					\
+	ALTERNATIVE(ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2), \
+		    newinst3, flag3)
 
 /*
  * Alternative instructions for different CPU types or capabilities.
@@ -375,6 +333,21 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	.byte \alt_len
 .endm
 
+#define __ALTERNATIVE(oldinst, newinst, flag)				\
+140:									\
+	oldinst	;							\
+141:									\
+	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90	;\
+142:									\
+	.pushsection .altinstructions,"a" ;				\
+	altinstr_entry 140b,143f,flag,142b-140b,144f-143f ;		\
+	.popsection ;							\
+	.pushsection .altinstr_replacement,"ax"	;			\
+143:									\
+	newinst	;							\
+144:									\
+	.popsection ;
+
 /*
  * Define an alternative between two instructions. If @feature is
  * present, early code in apply_alternatives() replaces @oldinstr with
@@ -382,88 +355,23 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * in case @newinstr is longer than @oldinstr.
  */
 .macro ALTERNATIVE oldinstr, newinstr, ft_flags
-140:
-	\oldinstr
-141:
-	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags,142b-140b,144f-143f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr
-144:
-	.popsection
+	__ALTERNATIVE(\oldinstr, \newinstr, \ft_flags)
 .endm
 
-#define old_len			141b-140b
-#define new_len1		144f-143f
-#define new_len2		145f-144f
-#define new_len3		146f-145f
-
-/*
- * gas compatible max based on the idea from:
- * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
- *
- * The additional "-" is needed because gas uses a "true" value of -1.
- */
-#define alt_max_2(a, b)		((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
-#define alt_max_3(a, b, c)	(alt_max_2(alt_max_2(a, b), c))
-
-
 /*
  * Same as ALTERNATIVE macro above but for two alternatives. If CPU
  * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
  * @feature2, it replaces @oldinstr with @feature2.
  */
 .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
-140:
-	\oldinstr
-141:
-	.skip -((alt_max_2(new_len1, new_len2) - (old_len)) > 0) * \
-		(alt_max_2(new_len1, new_len2) - (old_len)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f
-	altinstr_entry 140b,144f,\ft_flags2,142b-140b,145f-144f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr1
-144:
-	\newinstr2
-145:
-	.popsection
+	__ALTERNATIVE(__ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
+		      \newinstr2, \ft_flags2)
 .endm
 
 .macro ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
-140:
-	\oldinstr
-141:
-	.skip -((alt_max_3(new_len1, new_len2, new_len3) - (old_len)) > 0) * \
-		(alt_max_3(new_len1, new_len2, new_len3) - (old_len)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f
-	altinstr_entry 140b,144f,\ft_flags2,142b-140b,145f-144f
-	altinstr_entry 140b,145f,\ft_flags3,142b-140b,146f-145f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr1
-144:
-	\newinstr2
-145:
-	\newinstr3
-146:
-	.popsection
+	__ALTERNATIVE(__ALTERNATIVE(__ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
+				    \newinstr2, \ft_flags2),
+		      \newinstr3, \ft_flags3)
 .endm
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a7e1ec50ad29..694be4c610f3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -398,7 +398,7 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 						  struct alt_instr *end)
 {
-	struct alt_instr *a;
+	struct alt_instr *a, *b;
 	u8 *instr, *replacement;
 	u8 insn_buff[MAX_PATCH_LEN];
 
@@ -415,6 +415,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	for (a = start; a < end; a++) {
 		int insn_buff_sz = 0;
 
+		/*
+		 * In case of nested ALTERNATIVE()s the outer alternative might
+		 * add more padding. To ensure consistent patching find the max
+		 * padding for all alt_instr entries for this site (nested
+		 * alternatives result in consecutive entries).
+		 */
+		for (b = a+1; b < end && b->instr_offset == a->instr_offset; b++) {
+			u8 len = max(a->instrlen, b->instrlen);
+			a->instrlen = b->instrlen = len;
+		}
+
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insn_buff));
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 799ad6bb72e5..723cae9e2638 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -9,6 +9,29 @@
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
+	static struct special_alt *group, *prev;
+
+	/*
+	 * Recompute orig_len for nested ALTERNATIVE()s.
+	 */
+	if (group && group->orig_sec == alt->orig_sec &&
+	             group->orig_off == alt->orig_off) {
+
+		struct special_alt *iter = group;
+		for (;;) {
+			unsigned int len = max(iter->orig_len, alt->orig_len);
+			iter->orig_len = alt->orig_len = len;
+
+			if (iter == prev)
+				break;
+
+			iter = list_next_entry(iter, list);
+		}
+
+	} else group = alt;
+
+	prev = alt;
+
 	switch (feature) {
 	case X86_FEATURE_SMAP:
 		/*
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index baa85c31526b..84350f86d812 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -84,6 +84,14 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 						  entry->new_len);
 	}
 
+	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
+	if (!orig_reloc) {
+		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
+		return -1;
+	}
+
+	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
+
 	if (entry->feature) {
 		unsigned short feature;
 
@@ -94,14 +102,6 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 		arch_handle_alternative(feature, alt);
 	}
 
-	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
-	if (!orig_reloc) {
-		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
-		return -1;
-	}
-
-	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
-
 	if (!entry->group || alt->new_len) {
 		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);
 		if (!new_reloc) {
