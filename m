Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E6A7291B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbjFIHtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbjFIHrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1912139;
        Fri,  9 Jun 2023 00:47:43 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqRQz1OjzzpGQ4iiY57BC9yGXPvO2QKKws/Tybsfw8I=;
        b=v2fuNeHLUbSTOOAsx0dKhALq3wbgSNpaMjLUxp93MDWh0LMLtrHk+8YsxJgvRh1rkc03pD
        eOexA1DgrkkRSJDtTHqS1E2XxUgcUqBLau7ka3dhCMdpTgyISjVqYD8hjbU9V/cXDAF++7
        4q2XZskxqNIbm9zLMUZBuGee+7idVtHh0J1Ym+RCP59k87FiMo2i7X+IdIyQQvrVO0/0WW
        TUJYAoe1s/0U2LfnnGaV1UNd5cWYZBf2cye5a9mwLCyT8v8zkYCNCU9ZRxnQw++5a+MT3s
        oikTB+lOoQanSeb5X6phyE55IQZCQCq0edbCV3CflFDM7S2cHfKJDyCGjwESuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqRQz1OjzzpGQ4iiY57BC9yGXPvO2QKKws/Tybsfw8I=;
        b=ZgN+BxIz14x96iS5pjCMddFITiE5G/mnz+7SJIo5DvzEumjYsIuDWQRy98iAHGG9Z+DE/Q
        rMxaSFNpYjWQ2WBg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/entry: Move thunk restore code into thunk functions
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <46aa8aeb716f302e22e1673ae15ee6fe050b41f4.1685488050.git.jpoimboe@kernel.org>
References: <46aa8aeb716f302e22e1673ae15ee6fe050b41f4.1685488050.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629686115.404.13695695960788796083.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ac27ecf68a1ada240bb71531dc2d30cde04ad70a
Gitweb:        https://git.kernel.org/tip/ac27ecf68a1ada240bb71531dc2d30cde04ad70a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 16:07:41 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 09:54:45 -07:00

x86/entry: Move thunk restore code into thunk functions

There's no need for both thunk functions to jump to the same shared
thunk restore code which lives outside the thunk function boundaries.
It disrupts i-cache locality and confuses objtool.  Keep it simple by
keeping each thunk's restore code self-contained within the function.

Fixes a bunch of false positive "missing __noreturn" warnings like:

  vmlinux.o: warning: objtool: do_arch_prctl_common+0xf4: preempt_schedule_thunk() is missing a __noreturn annotation

Fixes: fedb724c3db5 ("objtool: Detect missing __noreturn annotations")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305281037.3PaI3tW4-lkp@intel.com/
Link: https://lore.kernel.org/r/46aa8aeb716f302e22e1673ae15ee6fe050b41f4.1685488050.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/thunk_64.S | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 5e37f41..27b5da2 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -26,17 +26,7 @@ SYM_FUNC_START(\name)
 	pushq %r11
 
 	call \func
-	jmp  __thunk_restore
-SYM_FUNC_END(\name)
-	_ASM_NOKPROBE(\name)
-	.endm
-
-	THUNK preempt_schedule_thunk, preempt_schedule
-	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
-	EXPORT_SYMBOL(preempt_schedule_thunk)
-	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
 
-SYM_CODE_START_LOCAL(__thunk_restore)
 	popq %r11
 	popq %r10
 	popq %r9
@@ -48,5 +38,11 @@ SYM_CODE_START_LOCAL(__thunk_restore)
 	popq %rdi
 	popq %rbp
 	RET
-	_ASM_NOKPROBE(__thunk_restore)
-SYM_CODE_END(__thunk_restore)
+SYM_FUNC_END(\name)
+	_ASM_NOKPROBE(\name)
+	.endm
+
+THUNK preempt_schedule_thunk, preempt_schedule
+THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
+EXPORT_SYMBOL(preempt_schedule_thunk)
+EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
