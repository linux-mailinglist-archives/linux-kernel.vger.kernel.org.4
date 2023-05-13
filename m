Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F27016CE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbjEMNEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjEMNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:03:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C3A30D3;
        Sat, 13 May 2023 06:03:49 -0700 (PDT)
Date:   Sat, 13 May 2023 13:03:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683983027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Oq3nSRRyahq3w7w+xbouKY57xzUcX+wLHtQjfMjceo=;
        b=MQAEkm85Kl0QoThh5yewCmg9EtSmrM1JpeaXeHgmCCCPQNsmDy9K2sq3K65wASqdPtvMMG
        UeWlYG0+48VrofnV/P+mhu06PmXHrr8kZ/vgZ/OQ2ULGMFaXJuT94VvUcYXaNQhAFU7G/C
        EgwpPuiAIbx//mSEhrBqlperNs8j8xlyP/8fkcbQjLDgKA2mtxdsfPKHoutM4HmC3FgeL+
        4I7Hdb+I1o9f/XB/tvnFsXq/37bYP3a9jiQUFYyM0M35Lz5IqaPSWLLWtA6DZQOjDdjv26
        QkjhuYxLL3vExJWYPbTKTjek6gvXETFVDOrBflytiVT11rV7uRxxBh/N/YV3kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683983027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Oq3nSRRyahq3w7w+xbouKY57xzUcX+wLHtQjfMjceo=;
        b=FMFXKy9dPO1Qj9wHeR1xdlD7IFUKGLvNwTeIFCawbjpHHCixpTM7DnVzxy3PVPF+6G+d74
        8lwpXC1G0uAkxlDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Complicate optimize_nops() some more
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230208171431.433132442@infradead.org>
References: <20230208171431.433132442@infradead.org>
MIME-Version: 1.0
Message-ID: <168398302732.404.4356413406268674545.tip-bot2@tip-bot2>
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

Commit-ID:     b6c881b248ef9d629ec2365808cb4894991c0837
Gitweb:        https://git.kernel.org/tip/b6c881b248ef9d629ec2365808cb4894991c0837
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:10:54 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 May 2023 17:34:20 +02:00

x86/alternative: Complicate optimize_nops() some more

Because:

  SMP alternatives: ffffffff810026dc: [2:44) optimized NOPs: eb 2a eb 28 cc cc
    cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
    cc cc cc cc cc cc cc cc cc cc cc cc cc

is quite daft, make things more complicated and have the NOP runlength
detection eat the preceding JMP if they both end at the same target.

  SMP alternatives: ffffffff810026dc: [0:44) optimized NOPs: eb 2a cc cc cc cc
    cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
    cc cc cc cc cc cc cc cc cc cc cc cc cc

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230208171431.433132442@infradead.org
---
 arch/x86/kernel/alternative.c | 60 ++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 839bc6d..b78d55f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -114,6 +114,8 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
 };
 
 /*
+ * Fill the buffer with a single effective instruction of size @len.
+ *
  * In order not to issue an ORC stack depth tracking CFI entry (Call Frame Info)
  * for every single-byte NOP, try to generate the maximally available NOP of
  * size <= ASM_NOP_MAX such that only a single CFI entry is generated (vs one for
@@ -152,6 +154,9 @@ extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
 
+/*
+ * Matches NOP and NOPL, not any of the other possible NOPs.
+ */
 static bool insn_is_nop(struct insn *insn)
 {
 	if (insn->opcode.bytes[0] == 0x90)
@@ -165,6 +170,10 @@ static bool insn_is_nop(struct insn *insn)
 	return false;
 }
 
+/*
+ * Find the offset of the first non-NOP instruction starting at @offset
+ * but no further than @len.
+ */
 static int skip_nops(u8 *instr, int offset, int len)
 {
 	struct insn insn;
@@ -181,11 +190,46 @@ static int skip_nops(u8 *instr, int offset, int len)
 }
 
 /*
+ * Optimize a sequence of NOPs, possibly preceded by an unconditional jump
+ * to the end of the NOP sequence into a single NOP.
+ */
+static bool __optimize_nops(u8 *instr, size_t len, struct insn *insn,
+			    int *next, int *prev, int *target)
+{
+	int i = *next - insn->length;
+
+	switch (insn->opcode.bytes[0]) {
+	case JMP8_INSN_OPCODE:
+	case JMP32_INSN_OPCODE:
+		*prev = i;
+		*target = *next + insn->immediate.value;
+		return false;
+	}
+
+	if (insn_is_nop(insn)) {
+		int nop = i;
+
+		*next = skip_nops(instr, *next, len);
+		if (*target && *next == *target)
+			nop = *prev;
+
+		add_nop(instr + nop, *next - nop);
+		DUMP_BYTES(ALT, instr, len, "%px: [%d:%d) optimized NOPs: ", instr, nop, *next);
+		return true;
+	}
+
+	*target = 0;
+	return false;
+}
+
+/*
  * "noinline" to cause control flow change and thus invalidate I$ and
  * cause refetch after modification.
  */
 static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
 {
+	int prev, target = 0;
+
 	for (int next, i = 0; i < len; i = next) {
 		struct insn insn;
 
@@ -194,11 +238,7 @@ static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
 
 		next = i + insn.length;
 
-		if (insn_is_nop(&insn)) {
-			next = skip_nops(instr, next, len);
-			add_nop(instr + i, next - i);
-			DUMP_BYTES(ALT, instr, len, "%px: [%d:%d) optimized NOPs: ", instr, i, next);
-		}
+		__optimize_nops(instr, len, &insn, &next, &prev, &target);
 	}
 }
 
@@ -275,6 +315,8 @@ bool need_reloc(unsigned long offset, u8 *src, size_t src_len)
 static void __init_or_module noinline
 apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 {
+	int prev, target = 0;
+
 	for (int next, i = 0; i < len; i = next) {
 		struct insn insn;
 
@@ -283,6 +325,9 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 
 		next = i + insn.length;
 
+		if (__optimize_nops(buf, len, &insn, &next, &prev, &target))
+			continue;
+
 		switch (insn.opcode.bytes[0]) {
 		case 0x0f:
 			if (insn.opcode.bytes[1] < 0x80 ||
@@ -324,11 +369,6 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 					    src - dest);
 			}
 		}
-
-		if (insn_is_nop(&insn)) {
-			next = skip_nops(buf, next, len);
-			add_nop(buf + i, next - i);
-		}
 	}
 }
 
