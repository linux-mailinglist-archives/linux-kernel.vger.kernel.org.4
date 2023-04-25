Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482A16EE7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjDYStR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjDYStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189AD16F3D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:02 -0700 (PDT)
Message-ID: <20230425183312.985681995@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=q6yQSMh5NftPeZgPAUvdDD7ZWt6JAf5f2/3w3UhJ70Q=;
        b=YFqFZlAfXnLvCdWhP63tL7EqJG01euEvWnXMKyZ4fWLintzWYtQlDrz4x1F3Le+A34Eu/S
        bEX9uXMigiFk+vTmiWsSTAgJVTghexsnMwawy/0Bx6Dy4xKuxOtZJvZXnCILC7l25yb3Up
        903ETpG3x3NpT6Cc8ue9GhAyXo1/CWzJVI3eup3kQucU0TYY5qxUwcMl8+h5omMXk0ToOp
        OoPbtFqFebZWIzfMIlGAtYbdsA7NEglKqS563SzLDghA/a3CTk1B/NEuqFl+Q+YykxsmJq
        TU+ouYWxJ7GEP6381AnkoR6Lk5W41pEU0kDLQAwW9YZyrXsZFpGV5WYxmrOgog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=q6yQSMh5NftPeZgPAUvdDD7ZWt6JAf5f2/3w3UhJ70Q=;
        b=mDOvRu4hOE3asu9/pisMKyXQeVXK2GPXNrCGQlnPFD3m0O4j1dO4Z5wx4QztID7kjjCE6/
        K7mtYEnp2qE3OrAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 03/20] posix-timers: Clarify timer_wait_running() comment
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:00 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain it better and add the CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y aspect
for completeness.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -835,10 +835,18 @@ static void common_timer_wait_running(st
 }
 
 /*
- * On PREEMPT_RT this prevent priority inversion against softirq kthread in
- * case it gets preempted while executing a timer callback. See comments in
- * hrtimer_cancel_wait_running. For PREEMPT_RT=n this just results in a
- * cpu_relax().
+ * On PREEMPT_RT this prevents priority inversion and a potential livelock
+ * against the ksoftirqd thread in case that ksoftirqd gets preempted while
+ * executing a hrtimer callback.
+ *
+ * See the comments in hrtimer_cancel_wait_running(). For PREEMPT_RT=n this
+ * just results in a cpu_relax().
+ *
+ * For POSIX CPU timers with CONFIG_POSIX_CPU_TIMERS_TASK_WORK=n this is
+ * just a cpu_relax(). With CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y this
+ * prevents spinning on an eventually scheduled out task and a livelock
+ * when the task which tries to delete or disarm the timer has preempted
+ * the task which runs the expiry in task work context.
  */
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)

