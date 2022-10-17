Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46E6011DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiJQOzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiJQOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C1668CFA;
        Mon, 17 Oct 2022 07:53:59 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQw/5TSKpLxhNJ8ePMNlo4lTG5ZNTsMbyrcfgVXfCLc=;
        b=dP2xaqlApv5qMz9964ECeOM+PpiWWKuwJvY+X2ZLYor7emK2DkqIApI1uQFkQQoJl7PTEA
        s+qt8356Tch1XX5z7kjdiPV+afHUzMc0eX/tVk9dlH7tzDWELrEuyPc5VNbS9jEI0xZg7z
        f7NO3a8Ygr7MYK7AkDu/6Iqg28+QoBSq0U/a7lEJ+4rFyn8n9wopy7xZB+t7UIhbavb+6/
        fqeacYpbkrzWq3l7PvCsWNQpPhGb4eDZehNQKXBv2D7V2FI6wFafTtRA0qDse0a9njuKir
        dNaD5aQ9+htiRBG/D4PhV7y4jdqVoPvOPaNCOs+n6n7l0FZblNes5bfoNjSmOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQw/5TSKpLxhNJ8ePMNlo4lTG5ZNTsMbyrcfgVXfCLc=;
        b=GsPYvQ707SlMzMllzxsqgf9GKuMTtt7+QNN+vdATi2+BSl4Ghi9teQMiStVLop+UC5UimV
        tWuWeKgXI1q9d6Cw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/entry: Make sync_regs() invocation a tail call
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111146.539578813@infradead.org>
References: <20220915111146.539578813@infradead.org>
MIME-Version: 1.0
Message-ID: <166601843361.401.5567797360188596748.tip-bot2@tip-bot2>
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

Commit-ID:     ef79ed20e3ae9ee9ac2e0f3a4e12814893972e63
Gitweb:        https://git.kernel.org/tip/ef79ed20e3ae9ee9ac2e0f3a4e12814893972e63
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:09 +02:00

x86/entry: Make sync_regs() invocation a tail call

No point in having a call there. Spare the call/ret overhead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111146.539578813@infradead.org
---
 arch/x86/entry/entry_64.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 5c578a7..b24b84b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1062,11 +1062,8 @@ SYM_CODE_START_LOCAL(error_entry)
 	UNTRAIN_RET
 
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
-.Lerror_entry_from_usermode_after_swapgs:
-
 	/* Put us onto the real thread stack. */
-	call	sync_regs
-	RET
+	jmp	sync_regs
 
 	/*
 	 * There are two places in the kernel that can potentially fault with
@@ -1124,7 +1121,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 	call	fixup_bad_iret
 	mov	%rax, %rdi
-	jmp	.Lerror_entry_from_usermode_after_swapgs
+	jmp	sync_regs
 SYM_CODE_END(error_entry)
 
 SYM_CODE_START_LOCAL(error_return)
