Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D998668F431
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjBHRSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjBHRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:18:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB3BEC46
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4aGsDj4JRDj/CxJoMye7YfiyXB2CneAdTMSJY1sBFjk=; b=khhUfXgKCP6qIQDMhQFWSPfqGb
        FrdrO/qmh1JireqJZJVaP3voQN5+fF2EaOy8XRKGjz4Cyi9GGvEovWw+MbqbKhByQsbr5UQdt2jm7
        lhpLpYaVh94hchhuBpoKoCwfe/pHDdO+pISgCqLuA/FZxIkUV7zsII296M/ITB3rU+D35t2dZjHKd
        Bqer8ARyWp1GjyrVK15mbcWArATlG5x7nzfiKuD3CSOKGKt9TiaZlchnBx9KYFqBSsptaEb3wqUy9
        Xix0B7bNT8IMfOho6LGUgtL9ytzgTOwE9PqLut5K2CYbS6hxHWu4Pg/TxqlN63Q7cHJFsXJLOsncc
        J0MTdB8Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPo3p-007VmG-0Z;
        Wed, 08 Feb 2023 17:16:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85D23300AFB;
        Wed,  8 Feb 2023 18:17:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6076020321D61; Wed,  8 Feb 2023 18:17:22 +0100 (CET)
Message-ID: <20230208171431.373412974@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:10:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, kirill.shutemov@linux.intel.com,
        Andrew.Cooper3@citrix.com, jpoimboe@redhat.com
Subject: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
References: <20230208171050.490809180@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This rewrite address two issues:

 - it no longer hard requires single byte nop runs, it now accepts
   any NOP and NOPL encoded instruction (but not the more complicated
   32bit NOPs).

 - it writes a single 'instruction' replacement.

Specifically, ORC unwinder relies on the tail NOP of an alternative to
be a single instruction, in particular it relies on the inner bytes
not being executed.

Once we reach the max supported NOP length (currently 8, could easily
be extended to 11 on x86_64), switches to JMP.d8 and INT3 padding to
achieve the same result.

The ORC unwinder uses this guarantee in the analysis of
alternative/overlapping CFI state,

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |  103 ++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 49 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -126,6 +126,30 @@ static void __init_or_module add_nops(vo
 	}
 }
 
+static void __init_or_module add_nop(u8 *instr, unsigned int len)
+{
+	u8 *target = instr + len;
+
+	if (!len)
+		return;
+
+	if (len <= ASM_NOP_MAX) {
+		memcpy(instr, x86_nops[len], len);
+		return;
+	}
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
+}
+
 extern s32 __retpoline_sites[], __retpoline_sites_end[];
 extern s32 __return_sites[], __return_sites_end[];
 extern s32 __cfi_sites[], __cfi_sites_end[];
@@ -134,39 +158,32 @@ extern struct alt_instr __alt_instructio
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
@@ -175,28 +192,19 @@ static __always_inline int optimize_nops
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
 
@@ -317,13 +325,10 @@ apply_relocation(u8 *buf, size_t len, u8
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
 


