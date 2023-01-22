Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724DA676C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 11:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjAVKms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 05:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjAVKmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 05:42:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C06A3;
        Sun, 22 Jan 2023 02:42:43 -0800 (PST)
Date:   Sun, 22 Jan 2023 10:42:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674384159;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQzAUlffxP+Cue4tZ7knjTLBcxiecYtxOrWhjKJnyII=;
        b=TqlUA4vBbCPiyJpp1gP8yimb7Cioi56xOa1ocWkq07cDmVH0EndkUs6Chqs3jRCNwcuPQN
        nBAXw3VUr4fYp7TDY2hP/H/g5ZvNBBuiJoyQZH0e9Tphzmpf64dpNH4zOpURC6v9SINMO1
        pKdhbaWDMz8nsQG7Xe/mIJYH1AxedKyBYe9K3T8Z8KM8jbY+qm+VUhfv/0mfu/ZPp5T4pT
        QmXc6znrAoXxsPJMz7wujK/WOIstPoLzYohWayqo+EDOTJMky2LmkHhySJMmOFqEdaFn1M
        tIMQkPPIURmZ+wYReDksqWSH+5IYDPYzelO9J0yoNPMhGozByb++aNOS6D7Wjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674384159;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQzAUlffxP+Cue4tZ7knjTLBcxiecYtxOrWhjKJnyII=;
        b=ht6Ar4qiK2waBluVvw+/Ohd5EAorLiZ07VR9jNzCaF8AGauCM58nSeZz3vla5EtaGSqJoP
        Ql99WOXzz1lf2GBg==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/build: Move '-mindirect-branch-cs-prefix' out
 of GCC-only block
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230120165826.2469302-1-nathan@kernel.org>
References: <20230120165826.2469302-1-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <167438415817.4906.16581804181334586242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     27b5de622ea3fe0ad5a31a0ebd9f7a0a276932d1
Gitweb:        https://git.kernel.org/tip/27b5de622ea3fe0ad5a31a0ebd9f7a0a276932d1
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Fri, 20 Jan 2023 09:58:27 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 22 Jan 2023 11:36:45 +01:00

x86/build: Move '-mindirect-branch-cs-prefix' out of GCC-only block

LLVM 16 will have support for this flag so move it out of the GCC-only
block to allow LLVM builds to take advantage of it.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/1665
Link: https://github.com/llvm/llvm-project/commit/6f867f9102838ebe314c1f3661fdf95700386e5a
Link: https://lore.kernel.org/r/20230120165826.2469302-1-nathan@kernel.org
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 9cf0732..73ed982 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -14,13 +14,13 @@ endif
 
 ifdef CONFIG_CC_IS_GCC
 RETPOLINE_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
-RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)
 RETPOLINE_VDSO_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
 endif
 ifdef CONFIG_CC_IS_CLANG
 RETPOLINE_CFLAGS	:= -mretpoline-external-thunk
 RETPOLINE_VDSO_CFLAGS	:= -mretpoline
 endif
+RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)
 
 ifdef CONFIG_RETHUNK
 RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
