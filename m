Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78066011AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiJQOyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJQOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1F667479;
        Mon, 17 Oct 2022 07:53:34 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a296qv2CVJFJIl0GGF0cDSGCF/VdsmOeIrg0nM5K2WU=;
        b=nDZU/czzkLeXHxWyFQX5MEkbTbNo4Cc4Qu0Pq396WN1f7Sj0nopF3VmNbYWWTMlHBwL8he
        CsC5LrvNHocxHcrZ+ZPbcUq5q6f1P6VBJ7zPv2JB7nsaQglJp12jzMGFtQinxnTkclAzn5
        I14SFiauGK9Nt+aamOuVvtZBVBcCUnXsDIjl9xccrXemUvasysHIlvWUzSd7A3YulmnV2H
        8Zr40ZUVw8dowLaiz+B51t4hT9e1AUIR90QFiYBCEzUy3iZOPRBU8YZqhrTW4bOFomPd9v
        bS9NX0M7qkHUdTIR4GsntWaQ8KINzc4RkemQ74hhFklmbyb6pEVg47jdH8PNaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a296qv2CVJFJIl0GGF0cDSGCF/VdsmOeIrg0nM5K2WU=;
        b=UF6WXlnhTY6gwednPoQJ62KTPLBO9Ufzz2FcSoEGumKekshCUgXTim3UQgPFEDcpPc7376
        we3junqjf3X/LPCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ftrace: Rebalance RSB
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111148.823216933@infradead.org>
References: <20220915111148.823216933@infradead.org>
MIME-Version: 1.0
Message-ID: <166601841090.401.13594696762736009940.tip-bot2@tip-bot2>
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

Commit-ID:     36b64f101219dd9e6e4f0ea880b64e8a90da547b
Gitweb:        https://git.kernel.org/tip/36b64f101219dd9e6e4f0ea880b64e8a90da547b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:36 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:19 +02:00

x86/ftrace: Rebalance RSB

ftrace_regs_caller() uses a PUSH;RET pattern to tail-call into a
direct-call function, this unbalances the RSB, fix that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111148.823216933@infradead.org
---
 arch/x86/kernel/ftrace_64.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index a90c55a..b5b54f5 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -271,6 +271,17 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	/* Restore flags */
 	popfq
 	UNWIND_HINT_FUNC
+
+	/*
+	 * The above left an extra return value on the stack; effectively
+	 * doing a tail-call without using a register. This PUSH;RET
+	 * pattern unbalances the RSB, inject a pointless CALL to rebalance.
+	 */
+	ANNOTATE_INTRA_FUNCTION_CALL
+	CALL .Ldo_rebalance
+	int3
+.Ldo_rebalance:
+	add $8, %rsp
 	RET
 
 SYM_FUNC_END(ftrace_regs_caller)
