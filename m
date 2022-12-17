Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8485364FBF3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiLQS56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiLQSzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB18F26;
        Sat, 17 Dec 2022 10:55:39 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AwGJM7EnQb/mbTiit2gzsS6CqaERs5CQtZQmK0M83c=;
        b=Z+XUkZzByJsRGZ7RSU0WHpLK77dbS3Qmt5Rfu2bwPayDEUj1IuadoVMVql5ybMtoT9cCo5
        Lecx66eum0nAZlyzu1KbpzUQSymAZ4oPla0Pjt447gn281xrAwxDhL02fivT3HEAn7czUh
        N+TU676j5AyKgHPvlgREIg2jXoFxxVTfq9MsWVFYWFM0GPDNTIuy286lqm/SArF8EPTe2M
        ZK7SBKAOvvRfHggCHlhJBZkukJnM7YQQEp+BxucNSGeWdkG4njOOSMGS0jjmvS1PsaGfp/
        V82vMElGwWIkXAJt/FNjw/w3oCU4bIVI18NGWLFi5N1rmtGHf4OfQnY8ikSxpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AwGJM7EnQb/mbTiit2gzsS6CqaERs5CQtZQmK0M83c=;
        b=jZqmcPHtiapwvvpqhNKPzT+X8A41p0Q4kXlZ2qIIYQjjhQN82b5WsgSBV1Wpcr6Bn6yipV
        itbMK6cMKmwYBjAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/ftrace: Remove SYSTEM_BOOTING exceptions
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221025201057.945960823@infradead.org>
References: <20221025201057.945960823@infradead.org>
MIME-Version: 1.0
Message-ID: <167130333517.4906.15894678655600602703.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     eb7d389d5b2b3c453332abc41c3eea73290cc006
Gitweb:        https://git.kernel.org/tip/eb7d389d5b2b3c453332abc41c3eea73290cc006
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 Oct 2022 21:39:47 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:26 -08:00

x86/ftrace: Remove SYSTEM_BOOTING exceptions

Now that text_poke is available before ftrace, remove the
SYSTEM_BOOTING exceptions.

Specifically, this cures a W+X case during boot.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221025201057.945960823@infradead.org
---
 arch/x86/kernel/alternative.c | 10 ----------
 arch/x86/kernel/ftrace.c      |  3 +--
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5cadcea..e240351 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1681,11 +1681,6 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
 {
 	struct text_poke_loc *tp;
 
-	if (unlikely(system_state == SYSTEM_BOOTING)) {
-		text_poke_early(addr, opcode, len);
-		return;
-	}
-
 	text_poke_flush(addr);
 
 	tp = &tp_vec[tp_vec_nr++];
@@ -1707,11 +1702,6 @@ void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *
 {
 	struct text_poke_loc tp;
 
-	if (unlikely(system_state == SYSTEM_BOOTING)) {
-		text_poke_early(addr, opcode, len);
-		return;
-	}
-
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index bd16500..43628b8 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -415,8 +415,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	set_vm_flush_reset_perms(trampoline);
 
-	if (likely(system_state != SYSTEM_BOOTING))
-		set_memory_ro((unsigned long)trampoline, npages);
+	set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
