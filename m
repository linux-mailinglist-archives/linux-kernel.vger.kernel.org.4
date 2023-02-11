Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F16C6930B8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjBKLxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBKLxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:53:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA12199C9;
        Sat, 11 Feb 2023 03:52:45 -0800 (PST)
Date:   Sat, 11 Feb 2023 11:52:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676116352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6WNnFEzKZw22qK3R42wBGdCcv/u99EdPgGZadgYEvg=;
        b=zlvUSQHBX/6Kc7lQzaFSsqnQhw11TwiY8y+OT6mC1GdCQw1AXFQpT56uEIgGuswqeI9Laj
        GgCNzewoT3+DiHhzw13pCYAjhggw5UtRcPj7X9bAxjCqRbiT7iLPy9s21LVx6XrFshXrsc
        7WureRS7BYBMIix7eOtKucZhP0bB1+sEzVw1//YCOKR5sCGt+0r61cZAaZLkT/Xhddeyo+
        xVnq5rQdhbeKnrrJY14RCjEDM3v2aNu8qROLzk1+66SFW73a3nuPiiHiXDqlODEp2GPmiu
        LUlJSb1tsJ6CTF1pyXrC2YhJ+Bj3XrbnF/s/IYxkvDNbXzaEmY3XsWA8E/k6LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676116352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6WNnFEzKZw22qK3R42wBGdCcv/u99EdPgGZadgYEvg=;
        b=DrVoJGssK4ekjsf/DDzQqilafHoYO5TtKwTpbtr9M8Z/l+x4Oa0sTlQ3ypURznseZ4WAwj
        tvhURnyRyqRTcXCA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/unwind/orc: Add 'signal' field to ORC metadata
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d2c5ec4d83a45b513d8fd72fab59f1a8cfa46871.1676068346.git.jpoimboe@kernel.org>
References: <d2c5ec4d83a45b513d8fd72fab59f1a8cfa46871.1676068346.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167611635166.4906.3627437427960765080.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ffb1b4a41016295e298409c9dbcacd55680bd6d4
Gitweb:        https://git.kernel.org/tip/ffb1b4a41016295e298409c9dbcacd55680bd6d4
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 10 Feb 2023 14:42:01 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 11 Feb 2023 12:37:51 +01:00

x86/unwind/orc: Add 'signal' field to ORC metadata

Add a 'signal' field which allows unwind hints to specify whether the
instruction pointer should be taken literally (like for most interrupts
and exceptions) rather than decremented (like for call stack return
addresses) when used to find the next ORC entry.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/d2c5ec4d83a45b513d8fd72fab59f1a8cfa46871.1676068346.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/orc_types.h       |  4 +++-
 arch/x86/include/asm/unwind_hints.h    | 10 +++++-----
 arch/x86/kernel/unwind_orc.c           |  5 ++---
 include/linux/objtool.h                | 11 +++++++----
 tools/arch/x86/include/asm/orc_types.h |  4 +++-
 tools/include/linux/objtool.h          | 11 +++++++----
 tools/objtool/orc_dump.c               |  4 ++--
 7 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 5a2baf2..1343a62 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -57,12 +57,14 @@ struct orc_entry {
 	unsigned	sp_reg:4;
 	unsigned	bp_reg:4;
 	unsigned	type:2;
+	unsigned	signal:1;
 	unsigned	end:1;
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	unsigned	bp_reg:4;
 	unsigned	sp_reg:4;
-	unsigned	unused:5;
+	unsigned	unused:4;
 	unsigned	end:1;
+	unsigned	signal:1;
 	unsigned	type:2;
 #endif
 } __packed;
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index f66fbe6..e7c7175 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -15,7 +15,7 @@
 	UNWIND_HINT type=UNWIND_HINT_TYPE_ENTRY end=1
 .endm
 
-.macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 partial=0
+.macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 partial=0 signal=1
 	.if \base == %rsp
 		.if \indirect
 			.set sp_reg, ORC_REG_SP_INDIRECT
@@ -45,11 +45,11 @@
 		.set type, UNWIND_HINT_TYPE_REGS
 	.endif
 
-	UNWIND_HINT sp_reg=sp_reg sp_offset=sp_offset type=type
+	UNWIND_HINT sp_reg=sp_reg sp_offset=sp_offset type=type signal=\signal
 .endm
 
-.macro UNWIND_HINT_IRET_REGS base=%rsp offset=0
-	UNWIND_HINT_REGS base=\base offset=\offset partial=1
+.macro UNWIND_HINT_IRET_REGS base=%rsp offset=0 signal=1
+	UNWIND_HINT_REGS base=\base offset=\offset partial=1 signal=\signal
 .endm
 
 .macro UNWIND_HINT_FUNC
@@ -67,7 +67,7 @@
 #else
 
 #define UNWIND_HINT_FUNC \
-	UNWIND_HINT(ORC_REG_SP, 8, UNWIND_HINT_TYPE_FUNC, 0)
+	UNWIND_HINT(ORC_REG_SP, 8, UNWIND_HINT_TYPE_FUNC, 0, 0)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index cdf6c60..37307b4 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -484,6 +484,8 @@ bool unwind_next_frame(struct unwind_state *state)
 		goto the_end;
 	}
 
+	state->signal = orc->signal;
+
 	/* Find the previous frame's stack: */
 	switch (orc->sp_reg) {
 	case ORC_REG_SP:
@@ -563,7 +565,6 @@ bool unwind_next_frame(struct unwind_state *state)
 		state->sp = sp;
 		state->regs = NULL;
 		state->prev_regs = NULL;
-		state->signal = false;
 		break;
 
 	case UNWIND_HINT_TYPE_REGS:
@@ -587,7 +588,6 @@ bool unwind_next_frame(struct unwind_state *state)
 		state->regs = (struct pt_regs *)sp;
 		state->prev_regs = NULL;
 		state->full_regs = true;
-		state->signal = true;
 		break;
 
 	case UNWIND_HINT_TYPE_REGS_PARTIAL:
@@ -604,7 +604,6 @@ bool unwind_next_frame(struct unwind_state *state)
 			state->prev_regs = state->regs;
 		state->regs = (void *)sp - IRET_FRAME_OFFSET;
 		state->full_regs = false;
-		state->signal = true;
 		break;
 
 	default:
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 62c54ff..9ac3df3 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -15,6 +15,7 @@ struct unwind_hint {
 	s16		sp_offset;
 	u8		sp_reg;
 	u8		type;
+	u8		signal;
 	u8		end;
 };
 #endif
@@ -49,7 +50,7 @@ struct unwind_hint {
 
 #ifndef __ASSEMBLY__
 
-#define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
+#define UNWIND_HINT(sp_reg, sp_offset, type, signal, end)	\
 	"987: \n\t"						\
 	".pushsection .discard.unwind_hints\n\t"		\
 	/* struct unwind_hint */				\
@@ -57,6 +58,7 @@ struct unwind_hint {
 	".short " __stringify(sp_offset) "\n\t"			\
 	".byte " __stringify(sp_reg) "\n\t"			\
 	".byte " __stringify(type) "\n\t"			\
+	".byte " __stringify(signal) "\n\t"			\
 	".byte " __stringify(end) "\n\t"			\
 	".balign 4 \n\t"					\
 	".popsection\n\t"
@@ -129,7 +131,7 @@ struct unwind_hint {
  * the debuginfo as necessary.  It will also warn if it sees any
  * inconsistencies.
  */
-.macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0
+.macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0 end=0
 .Lunwind_hint_ip_\@:
 	.pushsection .discard.unwind_hints
 		/* struct unwind_hint */
@@ -137,6 +139,7 @@ struct unwind_hint {
 		.short \sp_offset
 		.byte \sp_reg
 		.byte \type
+		.byte \signal
 		.byte \end
 		.balign 4
 	.popsection
@@ -174,7 +177,7 @@ struct unwind_hint {
 
 #ifndef __ASSEMBLY__
 
-#define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
+#define UNWIND_HINT(sp_reg, sp_offset, type, signal, end) \
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
@@ -182,7 +185,7 @@ struct unwind_hint {
 #define ASM_REACHABLE
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
-.macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0
+.macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0 end=0
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 5a2baf2..1343a62 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -57,12 +57,14 @@ struct orc_entry {
 	unsigned	sp_reg:4;
 	unsigned	bp_reg:4;
 	unsigned	type:2;
+	unsigned	signal:1;
 	unsigned	end:1;
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	unsigned	bp_reg:4;
 	unsigned	sp_reg:4;
-	unsigned	unused:5;
+	unsigned	unused:4;
 	unsigned	end:1;
+	unsigned	signal:1;
 	unsigned	type:2;
 #endif
 } __packed;
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 62c54ff..9ac3df3 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -15,6 +15,7 @@ struct unwind_hint {
 	s16		sp_offset;
 	u8		sp_reg;
 	u8		type;
+	u8		signal;
 	u8		end;
 };
 #endif
@@ -49,7 +50,7 @@ struct unwind_hint {
 
 #ifndef __ASSEMBLY__
 
-#define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
+#define UNWIND_HINT(sp_reg, sp_offset, type, signal, end)	\
 	"987: \n\t"						\
 	".pushsection .discard.unwind_hints\n\t"		\
 	/* struct unwind_hint */				\
@@ -57,6 +58,7 @@ struct unwind_hint {
 	".short " __stringify(sp_offset) "\n\t"			\
 	".byte " __stringify(sp_reg) "\n\t"			\
 	".byte " __stringify(type) "\n\t"			\
+	".byte " __stringify(signal) "\n\t"			\
 	".byte " __stringify(end) "\n\t"			\
 	".balign 4 \n\t"					\
 	".popsection\n\t"
@@ -129,7 +131,7 @@ struct unwind_hint {
  * the debuginfo as necessary.  It will also warn if it sees any
  * inconsistencies.
  */
-.macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0
+.macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0 end=0
 .Lunwind_hint_ip_\@:
 	.pushsection .discard.unwind_hints
 		/* struct unwind_hint */
@@ -137,6 +139,7 @@ struct unwind_hint {
 		.short \sp_offset
 		.byte \sp_reg
 		.byte \type
+		.byte \signal
 		.byte \end
 		.balign 4
 	.popsection
@@ -174,7 +177,7 @@ struct unwind_hint {
 
 #ifndef __ASSEMBLY__
 
-#define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
+#define UNWIND_HINT(sp_reg, sp_offset, type, signal, end) \
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
@@ -182,7 +185,7 @@ struct unwind_hint {
 #define ASM_REACHABLE
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
-.macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0
+.macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0 end=0
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 4f1211f..2d8ebdc 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -211,8 +211,8 @@ int orc_dump(const char *_objname)
 
 		print_reg(orc[i].bp_reg, bswap_if_needed(&dummy_elf, orc[i].bp_offset));
 
-		printf(" type:%s end:%d\n",
-		       orc_type_name(orc[i].type), orc[i].end);
+		printf(" type:%s signal:%d end:%d\n",
+		       orc_type_name(orc[i].type), orc[i].signal, orc[i].end);
 	}
 
 	elf_end(elf);
