Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA8C62B65B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiKPJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiKPJV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:21:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC2427142;
        Wed, 16 Nov 2022 01:21:58 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:21:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668590516;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVY9uAbTuVF0xKex4cjna3AgPQ7XWMie7xxAYF/HBbc=;
        b=oMAwXVdZ4/q5UgEfdo00MJ2v3aowzcAkGXykYzlLDQpfYP6urBoYLeN+yrqi3L4qeHuvtO
        bA+ecYMKKAVI53lH4ZEXBz7yeheA+pERzhISkn0waUfAKgdUzUDm2rkmD56DEANLZKfUNT
        CXh0rVgHbruhy7n76S1LgXtwxDhdXUpSKRIi745vila1itfXHtfC04GvIomgfk3Kxf8pEn
        cgbbTWuYPu/EgWquhfald+n8FnMr7ssLbFdyG4jr+Ei0V9yXH//xjPnShUEQOk2Npj/4H1
        JpQFHdFHO+VwYpZTZEQffg6+V0QMpsefWStXCge+tU7nqw+RI06/CneE8lTa0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668590516;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVY9uAbTuVF0xKex4cjna3AgPQ7XWMie7xxAYF/HBbc=;
        b=wZPeI8ew0LEdEn9vdpiKo2zx1wlLFRgV9PIUr7HxnxAk3lr4B6/LEinj7UhU8z7pH0GDTG
        aHItwo6vaI9AkjCg==
From:   "tip-bot2 for Guo Jin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking: Fix qspinlock/x86 inline asm error
Cc:     Guo Jin <guoj17@chinatelecom.cn>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221108060126.2505-1-guoj17@chinatelecom.cn>
References: <20221108060126.2505-1-guoj17@chinatelecom.cn>
MIME-Version: 1.0
Message-ID: <166859051534.4906.7078966677789928700.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     23df39fc6a36183af5e6e4f47523f1ad2cdc1d30
Gitweb:        https://git.kernel.org/tip/23df39fc6a36183af5e6e4f47523f1ad2cdc1d30
Author:        Guo Jin <guoj17@chinatelecom.cn>
AuthorDate:    Tue, 08 Nov 2022 14:01:26 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Nov 2022 10:18:09 +01:00

locking: Fix qspinlock/x86 inline asm error

When compiling linux 6.1.0-rc3 configured with CONFIG_64BIT=y and
CONFIG_PARAVIRT_SPINLOCKS=y on x86_64 using LLVM 11.0, an error:
"<inline asm> error: changed section flags for .spinlock.text,
expected:: 0x6" occurred.

The reason is the .spinlock.text in kernel/locking/qspinlock.o
is used many times, but its flags are omitted in subsequent use.

LLVM 11.0 assembler didn't permit to
leave out flags in subsequent uses of the same sections.

So this patch adds the corresponding flags to avoid above error.

Fixes: 501f7f69bca1 ("locking: Add __lockfunc to slow path functions")
Signed-off-by: Guo Jin <guoj17@chinatelecom.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20221108060126.2505-1-guoj17@chinatelecom.cn
---
 arch/x86/include/asm/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 60ece59..dbb38a6 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -37,7 +37,7 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
  *   rsi = lockval           (second argument)
  *   rdx = internal variable (set to 0)
  */
-asm    (".pushsection .spinlock.text;"
+asm    (".pushsection .spinlock.text, \"ax\";"
 	".globl " PV_UNLOCK ";"
 	".type " PV_UNLOCK ", @function;"
 	".align 4,0x90;"
