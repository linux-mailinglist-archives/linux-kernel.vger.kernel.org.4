Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15B66C8991
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 01:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCYAZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 20:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjCYAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 20:25:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D81556D;
        Fri, 24 Mar 2023 17:25:19 -0700 (PDT)
Date:   Sat, 25 Mar 2023 00:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679703918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyuzyAnQSeLGWu93uTJbeIsNUAHIb+HATCcV7TE1cFg=;
        b=FNb4xVMFIAVotTMBCq0H19orNoX6huPi8pH0S4lBWsBTSuIY0A7zgGrvk9wps3tSiRoOQh
        ewLGzw05SVsG3dqDj5eftan17brrxocZbNkN4T0CsXc1D3CJbR76SooIQrzdI3AkDUg1VZ
        ESQMgJ1jSs4zUUXbFasDTewEZJL4xFn7Ta/W4GF3Syz3efHez3Hts/eA6UvlSmsvLl2EK7
        ePvAhuejL81svrUHUZ3nxaesofMGuLOnhZlGWhehMT7BU2+TtL6j0/hsuqHPHPrPy6y1jS
        2rFFEG+uqcNq/5bDuKLEkGwFxS1KiukIqEvmh/fxaZ1dk+uHh3bLc8IFocDSQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679703918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyuzyAnQSeLGWu93uTJbeIsNUAHIb+HATCcV7TE1cFg=;
        b=bLxYV7vnQOmEWKn12l3f0t8qvoEZ2ojOedgk+TXXLNA7o+iMAjLFB8DoYo+1y2JKDSWBqw
        /yg7Bsz/0oLV4GCA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Change UNWIND_HINT() argument order
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d994f8c29376c5618c75698df28fc03b52d3a868.1677683419.git.jpoimboe@kernel.org>
References: <d994f8c29376c5618c75698df28fc03b52d3a868.1677683419.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167970391765.5837.14292580186670687979.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d88ebba45dfe67114a6ac8c6514f2c65b6ed64c7
Gitweb:        https://git.kernel.org/tip/d88ebba45dfe67114a6ac8c6514f2c65b6ed64c7
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 01 Mar 2023 07:13:09 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 23 Mar 2023 23:18:57 +01:00

objtool: Change UNWIND_HINT() argument order

The most important argument is 'type', make that one first.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/d994f8c29376c5618c75698df28fc03b52d3a868.1677683419.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/unwind_hints.h | 2 +-
 include/linux/objtool.h             | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index e7c7175..97b3922 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -67,7 +67,7 @@
 #else
 
 #define UNWIND_HINT_FUNC \
-	UNWIND_HINT(ORC_REG_SP, 8, UNWIND_HINT_TYPE_FUNC, 0, 0)
+	UNWIND_HINT(UNWIND_HINT_TYPE_FUNC, ORC_REG_SP, 8, 0, 0)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 2b0258d..725d7f0 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -10,7 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
-#define UNWIND_HINT(sp_reg, sp_offset, type, signal, end)	\
+#define UNWIND_HINT(type, sp_reg, sp_offset, signal, end)	\
 	"987: \n\t"						\
 	".pushsection .discard.unwind_hints\n\t"		\
 	/* struct unwind_hint */				\
@@ -137,8 +137,7 @@
 
 #ifndef __ASSEMBLY__
 
-#define UNWIND_HINT(sp_reg, sp_offset, type, signal, end) \
-	"\n\t"
+#define UNWIND_HINT(type, sp_reg, sp_offset, signal, end) "\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define ANNOTATE_NOENDBR
