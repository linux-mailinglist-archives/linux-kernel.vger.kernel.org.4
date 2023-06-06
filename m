Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F36172466D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbjFFOj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbjFFOie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:38:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFBF10F2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:59 -0700 (PDT)
Message-ID: <20230606142032.377649534@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FsQ2RLjA0ULPK1LuVh79qQG566mUAal9FpthIwhTUsc=;
        b=Tmh6xJJN3AmL9nJl7HXapdxc/ZScy95W8+cLDx1L6xE+OP1B2vQPjMLL+5svUX3zoTFAdT
        gncpwf7lXSp9Ji272ARmG3jMJ2POAqx47PEe+O6pbC62uP1i8RHhb3YpokscJqRUswAWCc
        VYBDoVqX94siQQ1l/gGSWYOAfMfaSvlt28l9sS0Tp+127j8OnAPpi7pzMsLuA3dgcz4KU8
        EPKlkqh/1D1C8Qw5P8QSTShe/ri42DmDm2gA0TUY1FtM02qrEI5yHNZfL3e623giI1omF6
        fpnxrcQ1X3iKH2jsmleBx0ROWU8cnw0c++oOho0RNttnba5Ou8bKsRcoYT61SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FsQ2RLjA0ULPK1LuVh79qQG566mUAal9FpthIwhTUsc=;
        b=PL0Wz+ZPwNKudLjbFeGDBMcUIJtGwB9cEhmWlmGb5tmx9eStFY3LSEeHX2P7CH6jsbif4L
        fG2953MQDdo3QkDg==
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
Subject: [patch 24/45] signal: Allow POSIX timer signals to be dropped
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:56 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case that a timer was reprogrammed or deleted an already pending signal
is obsolete. Right now such signals are kept around and eventually
delivered. While POSIX is blury about this:

 - "The effect of disarming or resetting a timer with pending expiration
    notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is
    unspecified."

it is reasonable in both cases to expect that pending signals are discarded
as they have no meaning anymore.

Prepare the signal code to allow dropping posix timer signals.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    5 +++--
 kernel/signal.c              |    7 +++++--
 kernel/time/posix-timers.c   |    3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -162,8 +162,9 @@ static inline void posix_cputimers_rt_wa
 {
 	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
 }
+
 void posixtimer_rearm_itimer(struct task_struct *p);
-void posixtimer_rearm(struct kernel_siginfo *info);
+bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -188,7 +189,7 @@ static inline void posix_cputimers_init(
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
-static inline void posixtimer_rearm(struct kernel_siginfo *info) { }
+static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -588,6 +588,7 @@ int dequeue_signal(sigset_t *mask, kerne
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
+again:
 	*type = PIDTYPE_PID;
 	signr = __dequeue_signal(&tsk->pending, mask, info);
 	if (!signr) {
@@ -619,8 +620,10 @@ int dequeue_signal(sigset_t *mask, kerne
 	}
 
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private))
-			posixtimer_rearm(info);
+		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private)) {
+			if (!posixtimer_deliver_signal(info))
+				goto again;
+		}
 	}
 
 	return signr;
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -254,7 +254,7 @@ static void common_hrtimer_rearm(struct
  * info::si_sys_private is not zero, which indicates that the timer has to
  * be rearmed. Restart the timer and update info::si_overrun.
  */
-void posixtimer_rearm(struct kernel_siginfo *info)
+bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 {
 	struct k_itimer *timr;
 	unsigned long flags;
@@ -286,6 +286,7 @@ void posixtimer_rearm(struct kernel_sigi
 
 	/* Don't expose the si_sys_private value to userspace */
 	info->si_sys_private = 0;
+	return true;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)

