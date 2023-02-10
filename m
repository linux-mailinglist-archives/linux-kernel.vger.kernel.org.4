Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9885A692A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjBJWmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjBJWmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:42:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A2B7395D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:42:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED1061EBC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9DEC433A0;
        Fri, 10 Feb 2023 22:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676068931;
        bh=VHlvi54nMSSeZR3KfCUMR/kLCvhVDPgKk9UcONDfDm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=twTpIs6/gPBDovstqkCNjR9XnBUuwvfcUiXVrfonYdkkmK1NbabLfgO2n+agqBx60
         9LSLy4tbbOSMuwYgMUqIwzdKIlVTlWfgUw0RoL9tLjZ1XmEYZmFkLb++cbdr3jouZT
         Da3kfUsmdD9E+HFyieAzQP9XuTdvgz6bc7SrB6dE9AnOSI1BqMI4vlH7h9Mx482uSV
         bqMWabq3HEx5WTICR1vpiENvbn0y5pOFsWiWmo69zCfaCEaPF+YzUroHg0g53+ZuBe
         a7FcJm0QCBc7HL3U8eLL2cDdT8aSjfSAI72jp1Fh9G9K5iqu0ABXkyCowQZCGcTlN1
         naFLFexHxaLyA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/2] x86/unwind/orc: Add 'signal' field to ORC metadata
Date:   Fri, 10 Feb 2023 14:42:01 -0800
Message-Id: <d2c5ec4d83a45b513d8fd72fab59f1a8cfa46871.1676068346.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676068346.git.jpoimboe@kernel.org>
References: <cover.1676068346.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 'signal' field which allows unwind hints to specify whether the
instruction pointer should be taken literally (like for most interrupts
and exceptions) rather than decremented (like for call stack return
addresses) when used to find the next ORC entry.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
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
index 5a2baf28a1dc..1343a62106de 100644
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
index f66fbe6537dd..e7c71750b309 100644
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
index cdf6c6060170..37307b40f8da 100644
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
index 62c54ffbeeaa..9ac3df3fccf0 100644
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
index 5a2baf28a1dc..1343a62106de 100644
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
index 62c54ffbeeaa..9ac3df3fccf0 100644
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
index 4f1211fec82c..2d8ebdcd1db3 100644
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
-- 
2.39.1

