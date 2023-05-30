Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223CC715ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjE3MSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjE3MSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:18:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E8B9D;
        Tue, 30 May 2023 05:18:13 -0700 (PDT)
Date:   Tue, 30 May 2023 12:18:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685449091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbDBIBOfL3vn6G8GVP1VF/4Ec/pcFLy9njdXtwuykC4=;
        b=ohN+1XE4NI8iN2blzE3PGkclS8OvmjDaLqbBood0k61WodakQFKBm81phvOXheMN5BfiPi
        k8C7U6TRWjcof+5DNKJFrMp2MBBw82+C5VbdrZY6djFjGF9m3lEd5KbEDRhk76pU5muCvO
        TxWji4QIhUy9Kw+yINtnqq/VIigOlgjxhocOsPaXtbcljYEQvzcCSIewLjiyrWqJIwyILt
        ZYfc2xb7LVnHPbamrfIGW5qnyXPxeQswhZ+ymr3YP1B1cwOq4qdizBzzMQ63XV6ZL48w7S
        lpZn9wYNu9i422Xyc43dRhoWjC94Ylfm6FijF4k2U/467C9t0JlLRahBwr1Ciw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685449091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbDBIBOfL3vn6G8GVP1VF/4Ec/pcFLy9njdXtwuykC4=;
        b=YT9aQdbhy6+9VgUO6lEO6zNst8GcSbKzekmFUYSGXn3jnFNpBSM9tgDpRf7ofxRoXJtrUI
        f7TAvkWTNrOsKHBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/realmode: Make stack lock work in trampoline_compat()
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87h6rujdvl.ffs@tglx>
References: <87h6rujdvl.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168544909088.404.150583934765484487.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     33e20b07bec4991c169e3c6ff28c2126583724fc
Gitweb:        https://git.kernel.org/tip/33e20b07bec4991c169e3c6ff28c2126583724fc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 30 May 2023 12:46:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 May 2023 14:11:47 +02:00

x86/realmode: Make stack lock work in trampoline_compat()

The stack locking and stack assignment macro LOAD_REALMODE_ESP fails to
work when invoked from the 64bit trampoline entry point:

trampoline_start64
  trampoline_compat
    LOAD_REALMODE_ESP <- lock

Accessing tr_lock is only possible from 16bit mode. For the compat entry
point this needs to be pa_tr_lock so that the required relocation entry is
generated. Otherwise it locks the non-relocated address which is
aside of being wrong never cleared in secondary_startup_64() causing all
but the first CPU to get stuck on the lock.

Make the macro take an argument lock_pa which defaults to 0 and rename it
to LOCK_AND_LOAD_REALMODE_ESP to make it clear what this is about.

Fixes: f6f1ae9128d2 ("x86/smpboot: Implement a bit spinlock to protect the realmode stack")
Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/87h6rujdvl.ffs@tglx
---
 arch/x86/realmode/rm/trampoline_64.S | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 4822ad2..c9f76fa 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -37,12 +37,16 @@
 	.text
 	.code16
 
-.macro LOAD_REALMODE_ESP
+.macro LOCK_AND_LOAD_REALMODE_ESP lock_pa=0
 	/*
 	 * Make sure only one CPU fiddles with the realmode stack
 	 */
 .Llock_rm\@:
+	.if \lock_pa
+        lock btsl       $0, pa_tr_lock
+	.else
         lock btsl       $0, tr_lock
+	.endif
         jnc             2f
         pause
         jmp             .Llock_rm\@
@@ -63,7 +67,7 @@ SYM_CODE_START(trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
 
-	LOAD_REALMODE_ESP
+	LOCK_AND_LOAD_REALMODE_ESP
 
 	call	verify_cpu		# Verify the cpu supports long mode
 	testl   %eax, %eax		# Check for return code
@@ -106,7 +110,7 @@ SYM_CODE_START(sev_es_trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
 
-	LOAD_REALMODE_ESP
+	LOCK_AND_LOAD_REALMODE_ESP
 
 	jmp	.Lswitch_to_protected
 SYM_CODE_END(sev_es_trampoline_start)
@@ -189,7 +193,7 @@ SYM_CODE_START(pa_trampoline_compat)
 	 * In compatibility mode.  Prep ESP and DX for startup_32, then disable
 	 * paging and complete the switch to legacy 32-bit mode.
 	 */
-	LOAD_REALMODE_ESP
+	LOCK_AND_LOAD_REALMODE_ESP lock_pa=1
 	movw	$__KERNEL_DS, %dx
 
 	movl	$(CR0_STATE & ~X86_CR0_PG), %eax
