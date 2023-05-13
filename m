Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAAB701825
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEMQKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjEMQKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:10:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C670D3586;
        Sat, 13 May 2023 09:10:40 -0700 (PDT)
Date:   Sat, 13 May 2023 16:10:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683994238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4H6Il2FBjbUen97ykKMKxuTbqQHAqsS0ZdcQh+Q5uC8=;
        b=uX5bAQK2urQVQFwcW9Pe26LPKnQxrE3uYLVjIw7daO9acjtCZ6dCuBqmq0um0v2Wnqm8F9
        TAILMWMshDoDqdGURxpptleoTr1BgDChdhbeK23IOmPklo0mHQzCFdVkGv8RJynynyXnhU
        4emdv9kFY5xLQGci5JZkRUHu7iIy5urreBkao2kGo4AjebpNolA1oWQNvYuqZMxfdLdsrA
        BIydgMbyHB5me7QlyOZ1aNS7hoVHsvpPs3LcLRi8uhl9fN5SsCmnmES4xK15SlKo1pdyep
        zu5VfOtpan6nOAZd0eKvtYlDFUTd/lLR7HGakP/dIesp3dIeTWIQdrmfWcWo+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683994238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4H6Il2FBjbUen97ykKMKxuTbqQHAqsS0ZdcQh+Q5uC8=;
        b=ZuxUTWsvKRit+0e9IMLEqIYV47VGePwvwS0YcQyYmhGVz/ZWuVf8OcYzGbvPlOunhnu7kS
        gJH7S9vhvviwrdBA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Fix section mismatch warnings
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230513160146.16039-1-bp@alien8.de>
References: <20230513160146.16039-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168399423765.404.4543227971125516398.tip-bot2@tip-bot2>
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

Commit-ID:     d42a2a89121071cc8dd285235253a4c739641635
Gitweb:        https://git.kernel.org/tip/d42a2a89121071cc8dd285235253a4c739641635
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 13 May 2023 16:01:39 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 13 May 2023 18:04:42 +02:00

x86/alternatives: Fix section mismatch warnings

Fix stuff like:

  WARNING: modpost: vmlinux.o: section mismatch in reference: \
  __optimize_nops (section: .text) -> debug_alternative (section: .init.data)

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230513160146.16039-1-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 3bb0a5f..93aa95a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -193,8 +193,8 @@ static int skip_nops(u8 *instr, int offset, int len)
  * Optimize a sequence of NOPs, possibly preceded by an unconditional jump
  * to the end of the NOP sequence into a single NOP.
  */
-static bool __optimize_nops(u8 *instr, size_t len, struct insn *insn,
-			    int *next, int *prev, int *target)
+static bool __init_or_module
+__optimize_nops(u8 *instr, size_t len, struct insn *insn, int *next, int *prev, int *target)
 {
 	int i = *next - insn->length;
 
@@ -765,7 +765,7 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
-static void poison_endbr(void *addr, bool warn)
+static void __init_or_module poison_endbr(void *addr, bool warn)
 {
 	u32 endbr, poison = gen_endbr_poison();
 
