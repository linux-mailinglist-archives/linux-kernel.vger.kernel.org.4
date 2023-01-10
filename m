Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3D566406F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjAJM0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbjAJM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:26:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC9412082;
        Tue, 10 Jan 2023 04:26:14 -0800 (PST)
Date:   Tue, 10 Jan 2023 12:26:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673353573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3i8g0Hw2ABdsPM4SxrWovnrLjc8AZV2Gt3pIcj7ReC8=;
        b=J6ZFvvSPmUxL+7oCwvwxf9uQMCrnZuAk15i35jFN7VpmHDIVVOndTjLAN2jdT0dCfWImOR
        5mbOR2slcZ7myO1TK9QWBvUWlrJ8B4YEydyzAjKO7JBim3rV5yrJVDRmgP/8R48Wm2N1O7
        /LxABJwv1S/vcS4uuI4PmBjuKOr9kbqyJCpHcghf6UxW8i90311JogrSsmTzLV+h5ae5IO
        uZ4dm8uk+aeTybQOo2+/bDAFBYhJquWv2kM2yOZwlVgqdg5f6luBHz2DfOKZxulN3Se/Cs
        oplCSkHh5gjzA1Ps6/d0+rmf8sTCiODzlH5egZyAv+0F+XoKqRo6C8pa5ppDiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673353573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3i8g0Hw2ABdsPM4SxrWovnrLjc8AZV2Gt3pIcj7ReC8=;
        b=2xpVBenDA2euCKCW+0k3nfctc/dH1fz9VtA9FI9i5AWaa2s+3JurSXL87h9ZTi5L7wF7D6
        7HRR8/H5r5xUd+Bg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Avoid using Intel mnemonics in AT&T syntax asm
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y71I3Ex2pvIxMpsP@hirez.programming.kicks-ass.net>
References: <Y71I3Ex2pvIxMpsP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <167335357249.4906.12734987935688647985.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7c6dd961d0c8e7e8f9fdc65071fb09ece702e18d
Gitweb:        https://git.kernel.org/tip/7c6dd961d0c8e7e8f9fdc65071fb09ece702e18d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 Jan 2023 12:15:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Jan 2023 13:03:23 +01:00

x86/boot: Avoid using Intel mnemonics in AT&T syntax asm

With 'GNU assembler (GNU Binutils for Debian) 2.39.90.20221231' the
build now reports:

  arch/x86/realmode/rm/../../boot/bioscall.S: Assembler messages:
  arch/x86/realmode/rm/../../boot/bioscall.S:35: Warning: found `movsd'; assuming `movsl' was meant
  arch/x86/realmode/rm/../../boot/bioscall.S:70: Warning: found `movsd'; assuming `movsl' was meant

  arch/x86/boot/bioscall.S: Assembler messages:
  arch/x86/boot/bioscall.S:35: Warning: found `movsd'; assuming `movsl' was meant
  arch/x86/boot/bioscall.S:70: Warning: found `movsd'; assuming `movsl' was meant

Which is due to:

  PR gas/29525

  Note that with the dropped CMPSD and MOVSD Intel Syntax string insn
  templates taking operands, mixed IsString/non-IsString template groups
  (with memory operands) cannot occur anymore. With that
  maybe_adjust_templates() becomes unnecessary (and is hence being
  removed).

More details: https://sourceware.org/bugzilla/show_bug.cgi?id=29525

Borislav Petkov further explains:

  " the particular problem here is is that the 'd' suffix is
    "conflicting" in the sense that you can have SSE mnemonics like movsD %xmm...
    and the same thing also for string ops (which is the case here) so apparently
    the agreement in binutils land is to use the always accepted suffixes 'l' or 'q'
    and phase out 'd' slowly... "

Fixes: 7a734e7dd93b ("x86, setup: "glove box" BIOS calls -- infrastructure")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/Y71I3Ex2pvIxMpsP@hirez.programming.kicks-ass.net
---
 arch/x86/boot/bioscall.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/bioscall.S b/arch/x86/boot/bioscall.S
index 5521ea1..aa9b964 100644
--- a/arch/x86/boot/bioscall.S
+++ b/arch/x86/boot/bioscall.S
@@ -32,7 +32,7 @@ intcall:
 	movw	%dx, %si
 	movw	%sp, %di
 	movw	$11, %cx
-	rep; movsd
+	rep; movsl
 
 	/* Pop full state from the stack */
 	popal
@@ -67,7 +67,7 @@ intcall:
 	jz	4f
 	movw	%sp, %si
 	movw	$11, %cx
-	rep; movsd
+	rep; movsl
 4:	addw	$44, %sp
 
 	/* Restore state and return */
