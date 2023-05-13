Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8431A7016CD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbjEMND7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjEMNDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:03:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A123C1D;
        Sat, 13 May 2023 06:03:49 -0700 (PDT)
Date:   Sat, 13 May 2023 13:03:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683983028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1EJEcR+AEzUmA99JgX5AmBXZDc9dgM8/B5i2adcZbo=;
        b=bImkBl5BnLLSX4fyIITZXutcB8/twGR5T4pUk9SV67KWbAoT3cOtjhCZriwlB/cSu+GAEy
        5jywC8ozBairmjLWpJbDkRNa07mjiv0OALioBM/og+sP1+bWx2Fqkfe7/ZPqUBcHNRgvqB
        R+o4OyuePV44k83vnxGgnkG5gDUtLPCSYhpH+Gxp22rdTs2ZRkSe06XL8cxO083t/saXz7
        CH27NczUR1qu9KVPHo+b0IUilqW/5/zAhO8PIWogvl81en6E9b0IbuksoPfR98Ssdf/DAw
        T+gtFb1wbz3ga3mMsAXqvLeimtVyfbTmNpbIBfmNE4NMFRVShQDtvD/s4IjN4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683983028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1EJEcR+AEzUmA99JgX5AmBXZDc9dgM8/B5i2adcZbo=;
        b=1W8hD30ijSQaUPOHdFA4l2R4m1SvZbgROE6jV51GnpKsSgJdInPFzhhWBEXh98gHu2J10E
        JeUDTEmpc0ya83Ag==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Rewrite optimize_nops() some
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230208171431.373412974@infradead.org>
References: <20230208171431.373412974@infradead.org>
MIME-Version: 1.0
Message-ID: <168398302782.404.12700216088592831704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     6c480f22212826425b57932f09b1f0abbec85485
Gitweb:        https://git.kernel.org/tip/6c480f22212826425b57932f09b1f0abbec85485
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:10:53 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 May 2023 17:33:36 +02:00

x86/alternative: Rewrite optimize_nops() some

Address two issues:

 - it no longer hard requires single byte NOP runs - now it accepts any
   NOP and NOPL encoded instruction (but not the more complicated 32bit
   NOPs).

 - it writes a single 'instruction' replacement.

Specifically, ORC unwinder relies on the tail NOP of an alternative to
be a single instruction. In particular, it relies on the inner bytes not
being executed.

Once the max supported NOP length has been reached (currently 8, could easily
be extended to 11 on x86_64), switch to JMP.d8 and INT3 padding to
achieve the same result.

Objtool uses this guarantee in the analysis of alternative/overlapping
CFI state for the ORC unwinder data. Every instruction edge gets a CFI
state and the more instructions the larger the chance of conflicts.

  [ bp:
  - Add a comment over add_nop() to explain why it does it this way
  - Make add_nops() PARAVIRT only as it is used solely there now ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230208171431.373412974@infradead.org
---
 arch/x86/kernel/alternative.c | 129 ++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 58 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 28eb1d0..839bc6d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -113,17 +113,35 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
 	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
 };
 
-/* Use this to add nops to a buffer, then text_poke the whole buffer. */
-static void __init_or_module add_nops(void *insns, unsigned int len)
+/*
+ * In order not to issue an ORC stack depth tracking CFI entry (Call Frame Info)
+ * for every single-byte NOP, try to generate the maximally available NOP of
+ * size <= ASM_NOP_MAX such that only a single CFI entry is generated (vs one for
+ * each single-byte NOPs). If @len to fill out is > ASM_NOP_MAX, pad with INT3 and
+ * *jump* over instead of executing long and daft NOPs.
+ */
+static void __init_or_module add_nop(u8 *instr, unsigned int len)
 {
-	while (len > 0) {
-		unsigned int noplen = len;
-		if (noplen > ASM_NOP_MAX)
-			noplen = ASM_NOP_MAX;
-		memcpy(insns, x86_nops[noplen], noplen);
-		insns += noplen;
-		len -= noplen;
+	u8 *target = instr + len;
+
+	if (!len)
+		return;
+
+	if (len <= ASM_NOP_MAX) {
+		memcpy(instr, x86_nops[len], len);
+		return;
 	}
+
+	if (len < 128) {
+		__text_gen_insn(instr, JMP8_INSN_OPCODE, instr, target, JMP8_INSN_SIZE);
+		instr += JMP8_INSN_SIZE;
+	} else {
+		__text_gen_insn(instr, JMP32_INSN_OPCODE, instr, target, JMP32_INSN_SIZE);
+		instr += JMP32_INSN_SIZE;
+	}
+
+	for (;instr < target; instr++)
+		*instr = INT3_INSN_OPCODE;
 }
 
 extern s32 __retpoline_sites[], __retpoline_sites_end[];
@@ -134,39 +152,32 @@ extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
 
-/*
- * optimize_nops_range() - Optimize a sequence of single byte NOPs (0x90)
- *
- * @instr: instruction byte stream
- * @instrlen: length of the above
- * @off: offset within @instr where the first NOP has been detected
- *
- * Return: number of NOPs found (and replaced).
- */
-static __always_inline int optimize_nops_range(u8 *instr, u8 instrlen, int off)
+static bool insn_is_nop(struct insn *insn)
 {
-	unsigned long flags;
-	int i = off, nnops;
+	if (insn->opcode.bytes[0] == 0x90)
+		return true;
 
-	while (i < instrlen) {
-		if (instr[i] != 0x90)
-			break;
+	if (insn->opcode.bytes[0] == 0x0F && insn->opcode.bytes[1] == 0x1F)
+		return true;
 
-		i++;
-	}
+	/* TODO: more nops */
 
-	nnops = i - off;
+	return false;
+}
 
-	if (nnops <= 1)
-		return nnops;
+static int skip_nops(u8 *instr, int offset, int len)
+{
+	struct insn insn;
 
-	local_irq_save(flags);
-	add_nops(instr + off, nnops);
-	local_irq_restore(flags);
+	for (; offset < len; offset += insn.length) {
+		if (insn_decode_kernel(&insn, &instr[offset]))
+			break;
 
-	DUMP_BYTES(ALT, instr, instrlen, "%px: [%d:%d) optimized NOPs: ", instr, off, i);
+		if (!insn_is_nop(&insn))
+			break;
+	}
 
-	return nnops;
+	return offset;
 }
 
 /*
@@ -175,28 +186,19 @@ static __always_inline int optimize_nops_range(u8 *instr, u8 instrlen, int off)
  */
 static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
 {
-	struct insn insn;
-	int i = 0;
+	for (int next, i = 0; i < len; i = next) {
+		struct insn insn;
 
-	/*
-	 * Jump over the non-NOP insns and optimize single-byte NOPs into bigger
-	 * ones.
-	 */
-	for (;;) {
 		if (insn_decode_kernel(&insn, &instr[i]))
 			return;
 
-		/*
-		 * See if this and any potentially following NOPs can be
-		 * optimized.
-		 */
-		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90)
-			i += optimize_nops_range(instr, len, i);
-		else
-			i += insn.length;
+		next = i + insn.length;
 
-		if (i >= len)
-			return;
+		if (insn_is_nop(&insn)) {
+			next = skip_nops(instr, next, len);
+			add_nop(instr + i, next - i);
+			DUMP_BYTES(ALT, instr, len, "%px: [%d:%d) optimized NOPs: ", instr, i, next);
+		}
 	}
 }
 
@@ -323,13 +325,10 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 			}
 		}
 
-
-		/*
-		 * See if this and any potentially following NOPs can be
-		 * optimized.
-		 */
-		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90)
-			next = i + optimize_nops_range(buf, len, i);
+		if (insn_is_nop(&insn)) {
+			next = skip_nops(buf, next, len);
+			add_nop(buf + i, next - i);
+		}
 	}
 }
 
@@ -1289,6 +1288,20 @@ int alternatives_text_reserved(void *start, void *end)
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PARAVIRT
+
+/* Use this to add nops to a buffer, then text_poke the whole buffer. */
+static void __init_or_module add_nops(void *insns, unsigned int len)
+{
+	while (len > 0) {
+		unsigned int noplen = len;
+		if (noplen > ASM_NOP_MAX)
+			noplen = ASM_NOP_MAX;
+		memcpy(insns, x86_nops[noplen], noplen);
+		insns += noplen;
+		len -= noplen;
+	}
+}
+
 void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 				     struct paravirt_patch_site *end)
 {
