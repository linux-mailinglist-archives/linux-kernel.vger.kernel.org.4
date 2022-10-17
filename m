Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542696011E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiJQO4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiJQOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A331691B1;
        Mon, 17 Oct 2022 07:54:06 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nbufag0Oxh8t4N22hMXgny4zYLzoPkeRtte1uCCr7E8=;
        b=Z971YmX3OysIeFmTRjTtxJLSWz1C2ICWUHPqCBrDu9zCdqTJiLjiV/fyjX53gDweiWchLC
        oERJ/bkuI82LTbC8rgyqhqF+REZfWLJmZKITxChLmJDsY0Nkphb2aUgbaQH0nSezk1LyZ/
        6hDIKhDDy6wqfAnKEbjo+/0o2b7u+nYp5z17WcgJV0VIQkvRsKQyf2UplbIv81D8LuuZT6
        ymZ5MLS9MMABEFSDl+XTo8w//49I6bLiNDFRZZKHwFB9b8liFoIxqa3OByzvDpXRiNtPIs
        jSxAYJBSkkMZs5OD1O3l1/y9iDgkSqKTMKPAuM1iKAEhC2583kbsfWGcNNC+IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nbufag0Oxh8t4N22hMXgny4zYLzoPkeRtte1uCCr7E8=;
        b=5n9nRA3AYeqR4SXK0gniq+yXvw2lxONUc6RdCl9Ud8/2imxXbqk630oI+2eOU8UpuTLmON
        5zOchXrr5+qsIHCw==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Fixup asm-offsets duplicate
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166601844328.401.13651658545984215013.tip-bot2@tip-bot2>
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

Commit-ID:     5b71ac8a2a3185da34a6556e791b533b48183a41
Gitweb:        https://git.kernel.org/tip/5b71ac8a2a3185da34a6556e791b533b48183a41
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Mon, 17 Oct 2022 16:41:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:06 +02:00

x86: Fixup asm-offsets duplicate

It turns out that 'stack_canary_offset' is a variable name; shadowing
that with a #define is ripe of fail when the asm-offsets.h header gets
included. Rename the thing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S        | 2 +-
 arch/x86/kernel/asm-offsets_64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9249a45..5c578a7 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -252,7 +252,7 @@ SYM_FUNC_START(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movq	TASK_stack_canary(%rsi), %rbx
-	movq	%rbx, PER_CPU_VAR(fixed_percpu_data) + stack_canary_offset
+	movq	%rbx, PER_CPU_VAR(fixed_percpu_data) + FIXED_stack_canary
 #endif
 
 	/*
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 9b69821..bb65371 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -57,7 +57,7 @@ int main(void)
 	BLANK();
 
 #ifdef CONFIG_STACKPROTECTOR
-	DEFINE(stack_canary_offset, offsetof(struct fixed_percpu_data, stack_canary));
+	OFFSET(FIXED_stack_canary, fixed_percpu_data, stack_canary);
 	BLANK();
 #endif
 	return 0;
