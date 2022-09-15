Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4643E5B9D05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiIOOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiIOOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:24:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E170E26;
        Thu, 15 Sep 2022 07:24:30 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:24:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663251869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBd6yEFA9UE4AU7nqoRBCyulonFC7sO1lnx9vBfRkfs=;
        b=I0rKnvvURuBsuqRxdiEt8nQQAXqkfG0fjFh4EDB2MYVUEhK+BzcURjWvTh4BiG8MPApk4/
        mMyOLdvtvLCUNpi7Z41SN73pP3A+h7WMZZpa7Y0PbSVKHLSEu1jLxrXuM72YPip8/lQKro
        vELlkzQxXdfowuJU4qoAPGeINlLnrZxj7CpLMRK76BBoUa6riEmOZkxweo2/vB/XbcyEbz
        FnRGfPTwTvCUqUdJ0Wp4YQh2xvAG9IC4DVMb8fAabO0ffAXDpCYwYDmpUgPLy5apUxuKqy
        P5Q6qZC1nCaWYi79aHgAFXlKm2rZRWK5iL9ifshP3dq+sDmsKPIadTY/MRorzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663251869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBd6yEFA9UE4AU7nqoRBCyulonFC7sO1lnx9vBfRkfs=;
        b=MkdDLCGmGpXwwvRYvjmESUMaiCeJL1Z6NK40VPKTC6Bm3el2oojWknDNEH94J9lMgCz2bW
        FyUOtukAifwbyyBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool,x86: Teach decode about LOOP* instructions
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Yxhd4EMKyoFoH9y4@hirez.programming.kicks-ass.net>
References: <Yxhd4EMKyoFoH9y4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166325186772.401.11612053064323908718.tip-bot2@tip-bot2>
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

Commit-ID:     7a7621dfa417aa3715d2a3bd1bdd6cf5018274d0
Gitweb:        https://git.kernel.org/tip/7a7621dfa417aa3715d2a3bd1bdd6cf5018274d0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 07 Sep 2022 11:01:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Sep 2022 16:13:55 +02:00

objtool,x86: Teach decode about LOOP* instructions

When 'discussing' control flow Masami mentioned the LOOP* instructions
and I realized objtool doesn't decode them properly.

As it turns out, these instructions are somewhat inefficient and as
such unlikely to be emitted by the compiler (a few vmlinux.o checks
can't find a single one) so this isn't critical, but still, best to
decode them properly.

Reported-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Yxhd4EMKyoFoH9y4@hirez.programming.kicks-ass.net
---
 tools/objtool/arch/x86/decode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c260006..1c253b4 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -635,6 +635,12 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		*type = INSN_CONTEXT_SWITCH;
 		break;
 
+	case 0xe0: /* loopne */
+	case 0xe1: /* loope */
+	case 0xe2: /* loop */
+		*type = INSN_JUMP_CONDITIONAL;
+		break;
+
 	case 0xe8:
 		*type = INSN_CALL;
 		/*
