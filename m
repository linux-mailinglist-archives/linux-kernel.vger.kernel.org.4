Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D07016CC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbjEMNDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjEMNDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:03:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C9630CF;
        Sat, 13 May 2023 06:03:49 -0700 (PDT)
Date:   Sat, 13 May 2023 13:03:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683983027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IUK9Cd8kmMUyf/sy2Cf/gw1P10mdKPr3GISjPNT/dJQ=;
        b=KKgBb5t8oGtUdw5h40u8q4NDnrBna64aZElNffdKtunpe1oPZxOWngsKDvrsOrEVTyfSO7
        SXN2o5KZtrfP5EN0Xhai8yNasNgj6WwjomqFdgGlu/isrErAvunsaAtYZoDIaLo7Hht8Mv
        l1/ocxdpKeiE+QjdY/pLFVLLw4dHpRvKVL7zrdNKuGxg7rl/4CbMKdaW9oTTUMcedXQr9a
        +bdc1FTdLmy4RtSiST5mgV89OOfbARbAwtvy2Pe9rbU50A2CdVx9IDkn78PAlYeHz63ISu
        UuKxYna180C8C5/IOxWZaoZZBN3etfkY+nxM+fCy1aLzcLXHGVYbP4ptzodJBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683983027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IUK9Cd8kmMUyf/sy2Cf/gw1P10mdKPr3GISjPNT/dJQ=;
        b=eHm5bsbh86Rwfw/TqCG+BNInkyzEPKSrjHWL30aXbcE58zFSIFmheY1w8G4n+1EnXWLP95
        SwYGi+/LcwScHIBA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Optimize returns patching
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512120952.7924-1-bp@alien8.de>
References: <20230512120952.7924-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168398302672.404.16833720798026245272.tip-bot2@tip-bot2>
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

Commit-ID:     d2408e043e7296017420aa5929b3bba4d5e61013
Gitweb:        https://git.kernel.org/tip/d2408e043e7296017420aa5929b3bba4d5e61013
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 12 May 2023 14:05:11 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 12 May 2023 17:53:18 +02:00

x86/alternative: Optimize returns patching

Instead of decoding each instruction in the return sites range only to
realize that that return site is a jump to the default return thunk
which is needed - X86_FEATURE_RETHUNK is enabled - lift that check
before the loop and get rid of that loop overhead.

Add comments about what gets patched, while at it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230512120952.7924-1-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b78d55f..3bb0a5f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -693,13 +693,12 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 {
 	int i = 0;
 
+	/* Patch the custom return thunks... */
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
-		if (x86_return_thunk == __x86_return_thunk)
-			return -1;
-
 		i = JMP32_INSN_SIZE;
 		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
 	} else {
+		/* ... or patch them out if not needed. */
 		bytes[i++] = RET_INSN_OPCODE;
 	}
 
@@ -712,6 +711,14 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 {
 	s32 *s;
 
+	/*
+	 * Do not patch out the default return thunks if those needed are the
+	 * ones generated by the compiler.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_RETHUNK) &&
+	    (x86_return_thunk == __x86_return_thunk))
+		return;
+
 	for (s = start; s < end; s++) {
 		void *dest = NULL, *addr = (void *)s + *s;
 		struct insn insn;
