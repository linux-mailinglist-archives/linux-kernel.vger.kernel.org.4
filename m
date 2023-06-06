Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3142E724689
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjFFOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbjFFOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:40:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80911BD5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:39:11 -0700 (PDT)
Message-ID: <20230606142033.172901153@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jyhJ/3GMU7sDY6xXeRfAzgG/VNBQy0NUgflCvHfEUKI=;
        b=XJilMgHM4dy9cG9v0F6jyIRHdq6ACnil9FvydviHNHu7inyWZ/fx45hSDqAuNz94cKj0vE
        enpsGWuvD3DGfZjgYaBI9R5lV3TBjwSQBJSg3GiXnc0Vx2kerYmC2qYG9PtBsJpcYQr6Fk
        Cps1voMigj6U4UKBV49hXW8apAh3Rif3C51aPFhWeWN3QL6VHUFsRqJSDO35WHmrAs/T1B
        NHOAQPuPSYEhLjGCN5STeqRPp/dMAVHUq4nIFZstODIQzMNo1Tk1UE/XThfM1krMGuMf4h
        VNCJcelb2WbxdzWdxlwPI0NN+W0g/+bmtFU2GoqPO17U5T50yBUNo+xNRCN58g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jyhJ/3GMU7sDY6xXeRfAzgG/VNBQy0NUgflCvHfEUKI=;
        b=RLxZMsOTpnVTE7P8NlmT+H5U2JMs2DASwAD18xvfifkr75/k6ysGl+21VdvBYKC+2+U4/e
        8OuAtFyJ3UcNJkCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 38/45] signal: Add task argument to flush_sigqueue_mask()
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:19 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
add a task argument to flush_sigqueue_mask() and fixup all call sites.

This argument will be used in a later step to enqueue posix timers on an
ignored list, so their signal can be requeued when SIG_IGN is lifted later
on.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -727,11 +727,10 @@ void signal_wake_up_state(struct task_st
 
 /*
  * Remove signals in mask from the pending set and queue.
- * Returns 1 if any signals were found.
  *
  * All callers must be holding the siglock.
  */
-static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
+static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s, struct task_struct *ptmr_tsk)
 {
 	struct sigqueue *q, *n;
 	sigset_t m;
@@ -869,18 +868,18 @@ static bool prepare_signal(int sig, stru
 		 * This is a stop signal.  Remove SIGCONT from all queues.
 		 */
 		siginitset(&flush, sigmask(SIGCONT));
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(&flush, &signal->shared_pending, NULL);
 		for_each_thread(p, t)
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(&flush, &t->pending, NULL);
 	} else if (sig == SIGCONT) {
 		unsigned int why;
 		/*
 		 * Remove all stop signals from all queues, wake all threads.
 		 */
 		siginitset(&flush, SIG_KERNEL_STOP_MASK);
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(&flush, &signal->shared_pending, NULL);
 		for_each_thread(p, t) {
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(&flush, &t->pending, NULL);
 			task_clear_jobctl_pending(t, JOBCTL_STOP_PENDING);
 			if (likely(!(t->ptrace & PT_SEIZED))) {
 				t->jobctl &= ~JOBCTL_STOPPED;
@@ -4097,8 +4096,8 @@ void kernel_sigaction(int sig, __sighand
 		sigemptyset(&mask);
 		sigaddset(&mask, sig);
 
-		flush_sigqueue_mask(&mask, &current->signal->shared_pending);
-		flush_sigqueue_mask(&mask, &current->pending);
+		flush_sigqueue_mask(&mask, &current->signal->shared_pending, NULL);
+		flush_sigqueue_mask(&mask, &current->pending, NULL);
 		recalc_sigpending();
 	}
 	spin_unlock_irq(&current->sighand->siglock);
@@ -4165,9 +4164,9 @@ int do_sigaction(int sig, struct k_sigac
 		if (sig_handler_ignored(sig_handler(p, sig), sig)) {
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
-			flush_sigqueue_mask(&mask, &p->signal->shared_pending);
+			flush_sigqueue_mask(&mask, &p->signal->shared_pending, NULL);
 			for_each_thread(p, t)
-				flush_sigqueue_mask(&mask, &t->pending);
+				flush_sigqueue_mask(&mask, &t->pending, NULL);
 		}
 	}
 

