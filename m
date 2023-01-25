Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB70667B1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjAYLjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjAYLjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:39:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56334274B3;
        Wed, 25 Jan 2023 03:39:15 -0800 (PST)
Date:   Wed, 25 Jan 2023 11:39:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674646753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jBboM+ctgRrhBN99GTml3A4jV37DjryvctriP0Q0cM=;
        b=vzqOFQBCgZtlsCsbG6BpGjcRPU45yaucN62K81vcmNpZpU4BDXIH4sv8xXJiovycU5R+rr
        FJxeQ5t+8YrHMx7pw9jGUnWR6BuyPP8MOAkmC/QiBR0ioeF+HQ+Xl3f0GOpgmK4JSxlZwB
        xPz0Wf2mJC3M2kyZtS2/BbmxtI4dI+RctTlvFbpfDRSLrdgpId7epige1qmWPBmO3nYeSM
        HPPeaNxuQxeVJCxukdysX4TJq85egrpF4il0vlrkN7M2B5ppa/70rICUzOJU0GqvRbDjmF
        MzlzKrWPRdgnJXXkU5mQia+CivpTdBG+p8OlfoJ9kjvoLwbLYstDvbOI0NJWEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674646753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jBboM+ctgRrhBN99GTml3A4jV37DjryvctriP0Q0cM=;
        b=3TIuWSeq9hVMbJZ0RRyhM6lXE73h4h7Akfr6dfn3cdQsUDX1xKK50e9781j7eulXVJjtR9
        tVFu0EQDfES63PAA==
From:   "tip-bot2 for Jens Axboe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Don't set TIF_NEED_FPU_LOAD for PF_IO_WORKER threads
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <560c844c-f128-555b-40c6-31baff27537f@kernel.dk>
References: <560c844c-f128-555b-40c6-31baff27537f@kernel.dk>
MIME-Version: 1.0
Message-ID: <167464675263.4906.14890690259469588852.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     cb3ea4b7671b7cfbac3ee609976b790aebd0bbda
Gitweb:        https://git.kernel.org/tip/cb3ea4b7671b7cfbac3ee609976b790aebd0bbda
Author:        Jens Axboe <axboe@kernel.dk>
AuthorDate:    Tue, 24 Jan 2023 08:23:20 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Jan 2023 12:35:15 +01:00

x86/fpu: Don't set TIF_NEED_FPU_LOAD for PF_IO_WORKER threads

We don't set it on PF_KTHREAD threads as they never return to userspace,
and PF_IO_WORKER threads are identical in that regard. As they keep
running in the kernel until they die, skip setting the FPU flag on them.

More of a cosmetic thing that was found while debugging and
issue and pondering why the FPU flag is set on these threads.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/560c844c-f128-555b-40c6-31baff27537f@kernel.dk
---
 arch/x86/include/asm/fpu/sched.h | 2 +-
 arch/x86/kernel/fpu/context.h    | 2 +-
 arch/x86/kernel/fpu/core.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index b2486b2..c2d6cd7 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -39,7 +39,7 @@ extern void fpu_flush_thread(void);
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
-	    !(current->flags & PF_KTHREAD)) {
+	    !(current->flags & (PF_KTHREAD | PF_IO_WORKER))) {
 		save_fpregs_to_fpstate(old_fpu);
 		/*
 		 * The save operation preserved register state, so the
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index 958accf..9fcfa5c 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -57,7 +57,7 @@ static inline void fpregs_restore_userregs(void)
 	struct fpu *fpu = &current->thread.fpu;
 	int cpu = smp_processor_id();
 
-	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
+	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_IO_WORKER)))
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 9baa89a..2babc53 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -426,7 +426,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 
 	this_cpu_write(in_kernel_fpu, true);
 
-	if (!(current->flags & PF_KTHREAD) &&
+	if (!(current->flags & (PF_KTHREAD | PF_IO_WORKER)) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 		save_fpregs_to_fpstate(&current->thread.fpu);
