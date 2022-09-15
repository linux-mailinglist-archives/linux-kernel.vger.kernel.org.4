Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15185B9D07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiIOOZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiIOOYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:24:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1654013D5B;
        Thu, 15 Sep 2022 07:24:37 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:24:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663251876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCK/MKGMtOXzQO69XW896tntmgJtrYn0VzO3KqQ1JRA=;
        b=3Ya6q0fZ3p6Fm/+Bau3IwXbIj3OmkZ3aQA71ywpUtHsV06K6MsXjNJpT8CinTEPPteV6+P
        FYI0pfPgNy3GB9NwY69U7ovS6nh6lgMY9qxaSXdAxorv1sMSBf9A6w47C23ikQb72cO3kS
        I9jchItRoC9GVonRlmLfqIyjVjhGFKIyjWpqHNsQJ9glV4/TmRi1kt47QODbyqoHqYHq1B
        6zZw2q/qPHL3o/8hQfsWR4UURwH5c2ckuU9qqvH4vt5RnUViBGLRLmwD9VOWE1jcNsE4lm
        IoVcwbohLyRpswu3MoLpnORB255vuPp3reRvrLuUtpYXpASdNqlJZGCR6aWKFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663251876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCK/MKGMtOXzQO69XW896tntmgJtrYn0VzO3KqQ1JRA=;
        b=lmb/WnIqwNIx3fowgFfju038wkKjY1yMYKVUy5FbA/Q/q++nCjaVrvuWhiUWeOw9OmGegt
        f7JAn0tF+SmQ2qCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86,retpoline: Be sure to emit INT3 after JMP *%\reg
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Yxm+QkFPOhrVSH6q@hirez.programming.kicks-ass.net>
References: <Yxm+QkFPOhrVSH6q@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166325187487.401.4017547159660113681.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     8c03af3e090e9d57d90f482d344563dd4bae1e66
Gitweb:        https://git.kernel.org/tip/8c03af3e090e9d57d90f482d344563dd4bae1e66
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 08 Sep 2022 12:04:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Sep 2022 16:13:53 +02:00

x86,retpoline: Be sure to emit INT3 after JMP *%\reg

Both AMD and Intel recommend using INT3 after an indirect JMP. Make sure
to emit one when rewriting the retpoline JMP irrespective of compiler
SLS options or even CONFIG_SLS.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Link: https://lkml.kernel.org/r/Yxm+QkFPOhrVSH6q@hirez.programming.kicks-ass.net
---
 arch/x86/kernel/alternative.c |  9 +++++++++
 arch/x86/net/bpf_jit_comp.c   |  4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 62f6b8b..68d84cf 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -453,6 +453,15 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 		return ret;
 	i += ret;
 
+	/*
+	 * The compiler is supposed to EMIT an INT3 after every unconditional
+	 * JMP instruction due to AMD BTC. However, if the compiler is too old
+	 * or SLS isn't enabled, we still need an INT3 after indirect JMPs
+	 * even on Intel.
+	 */
+	if (op == JMP32_INSN_OPCODE && i < insn->length)
+		bytes[i++] = INT3_INSN_OPCODE;
+
 	for (; i < insn->length;)
 		bytes[i++] = BYTES_NOP1;
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c1f6c1c..4922517 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -419,7 +419,9 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 		OPTIMIZER_HIDE_VAR(reg);
 		emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
 	} else {
-		EMIT2(0xFF, 0xE0 + reg);
+		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
+		if (IS_ENABLED(CONFIG_RETPOLINE) || IS_ENABLED(CONFIG_SLS))
+			EMIT1(0xCC);		/* int3 */
 	}
 
 	*pprog = prog;
