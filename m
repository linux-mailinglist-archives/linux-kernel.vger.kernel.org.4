Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7015724678
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbjFFOkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbjFFOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:39:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A421730
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:38:22 -0700 (PDT)
Message-ID: <20230606142032.881951490@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=F1AIORQBsb8Q0wbN0ersqX3Q8WiAIjYPdK55avtTgbc=;
        b=zYwP+c1d0TKBY7umwUqJyZjwLRc75LhgtytLBn0aq2G7R+AEjzhXBYIIc0fMDCIezfOwju
        EfDzX3nUqEs7bEu4nFl8TNqFvnUb3gEV9jdmdsOKAiiVVWG+sjpYC0yoI5AT2EpQrAubF4
        8U40jBTqyal18gawuojiioVpDPLa7G1irpHhsrUayCyedCUUitLHCjcz8nO1WV+pKkotKP
        oUbnNHJNKUMgrt16vS9OHNRm5n67pBjDPk1x9q6KEqWwqdCa8jIK7mMjvtPJDVxYygNgTs
        hVTBSjN1kruivBXxTnTLJTS7oHHj5Dy3Koz/4kh+tjAUjTPsJKTtE+HlZd2GYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=F1AIORQBsb8Q0wbN0ersqX3Q8WiAIjYPdK55avtTgbc=;
        b=PXGS/1RDSbPqccGdfDQYlb/tXnCiLRy+k6oowj4ENqJgwDUvgVlmb55JC5BmOLQiKgKG7W
        PU5cWxeT8xHU+vCQ==
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
Subject: [patch 33/45] signal: Provide posixtimer_sigqueue_init()
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:11 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Provide a new function to initialize the embedded sigqueue to prepare for
that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    1 +
 kernel/signal.c              |   11 +++++++++++
 2 files changed, 12 insertions(+)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -168,6 +168,7 @@ static inline void posix_cputimers_rt_wa
 }
 
 void posixtimer_rearm_itimer(struct task_struct *p);
+bool posixtimer_init_sigqueue(struct sigqueue *q);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1901,6 +1901,17 @@ void flush_itimer_signals(void)
 	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
 }
 
+bool posixtimer_init_sigqueue(struct sigqueue *q)
+{
+	struct ucounts *ucounts = sig_get_ucounts(current, -1, 0);
+
+	if (!ucounts)
+		return false;
+	clear_siginfo(&q->info);
+	__sigqueue_init(q, ucounts, SIGQUEUE_PREALLOC);
+	return true;
+}
+
 struct sigqueue *sigqueue_alloc(void)
 {
 	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);

