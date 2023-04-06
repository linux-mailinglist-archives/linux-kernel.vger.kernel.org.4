Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB7D6DA422
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbjDFU5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbjDFU5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:57:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A92E6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:57:19 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680814637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFXiELADcPRlzfKcViV8Vwc2Nkww8T+BuhJWY9I4uvA=;
        b=IT+nY8iHontAduYJPijfK7XGWlppk4WsZr1Zk+Hv8GJ+T0ULr6VaC8aq8yM8RK0VhM2YD0
        zni6Faf6ZaS6ViPHq3cs2O8q+l2bX4bof4/Gxyqkln9d2ySrxMO2iZxiQIt2KIVyJlxvo0
        j2w3vCSr3pIRkRT4WIEe3EASl1Lp5KuoQMgYeOr7UDhJFLzcubqniUkmWVcMGTOSG0kdEE
        fig/wXk5jyYe3sViC5T441JW/+IfuMaR7EmDSTzLc1qU5AhPN9jNyy17U5cfqvddOkrSW1
        PTUTfMBG7POd5k8vayyO3On8Aaov7fwvWyWSUFtRddNaY00RJWA4JgRxBVEoSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680814637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFXiELADcPRlzfKcViV8Vwc2Nkww8T+BuhJWY9I4uvA=;
        b=x7qj5MQe6PfvqAscE5pZfbRZzENrSFiodlAiUvCBv7493K+fsawkDsLLymBf+GXax1DBDV
        H0SdFbvhZRFVEHBg==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] signal: Add proper comment about the preempt-disable in ptrace_stop().
Date:   Thu,  6 Apr 2023 22:57:11 +0200
Message-Id: <20230406205713.1843072-2-bigeasy@linutronix.de>
In-Reply-To: <20230406205713.1843072-1-bigeasy@linutronix.de>
References: <20230406205713.1843072-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 53da1d9456fe7 ("fix ptrace slowness") added a preempt-disable section
between read_unlock() and the following schedule() invocation without
explaining why it is needed.

Replace the comment with an explanation why this is needed. Clarify that
it is needed for correctness but for performance reasons.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/signal.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2337,10 +2337,21 @@ static int ptrace_stop(int exit_code, in
 		do_notify_parent_cldstop(current, false, why);
=20
 	/*
-	 * Don't want to allow preemption here, because
-	 * sys_ptrace() needs this task to be inactive.
+	 * The previous do_notify_parent_cldstop() invocation woke ptracer.
+	 * One a PREEMPTION kernel this can result in preemption requirement
+	 * which will be fulfilled after read_unlock() and the ptracer will be
+	 * put on the CPU.
+	 * The ptracer is in wait_task_inactive(, __TASK_TRACED) waiting for
+	 * this task wait in schedule(). If this task gets preempted then it
+	 * remains enqueued on the runqueue. The ptracer will observe this and
+	 * then sleep for a delay of one HZ tick. In the meantime this task
+	 * gets scheduled, enters schedule() and will wait for the ptracer.
 	 *
-	 * XXX: implement read_unlock_no_resched().
+	 * This preemption point is not bad from correctness point of view but
+	 * extends the runtime by one HZ tick time due to the ptracer's sleep.
+	 * The preempt-disable section ensures that there will be no preemption
+	 * between unlock and schedule() and so improving the performance since
+	 * the ptracer has no reason to sleep.
 	 */
 	preempt_disable();
 	read_unlock(&tasklist_lock);
