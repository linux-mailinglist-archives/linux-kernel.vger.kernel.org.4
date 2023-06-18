Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36358734862
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjFRUvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFRUuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45DE5D;
        Sun, 18 Jun 2023 13:50:09 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:50:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rZmwii/QkARH24aAlxE20/L4+QJ9DGFPRuwo6gx48U=;
        b=3GMDTePwyFmRAUOlTuiX/coZ1rY5XbdVyoFmMNFlHOlxTeXrih4QYUd5oUz+kTSx6vgmFJ
        VTt2gNZcLMT7mwnIknSZn2PUDF9vwb5ixO+ooL5Jo+ej9rVrGnSEsvPTt/sHgm6rvqLL+6
        42h1AKg4BSV6g+lpa+P3HFTPrUxRObvFkiZuKU3rYnyU71P254IjArUFZwRsLXK6I0/sFj
        ghm7unyCrRNlpyT2Uppht1xXWrzyDb7S2wWphUnrjnihR0bk4v7+y61vBi+g4vO9n+/MkJ
        dGJfa31VOA27o9PUhWDcIzJsNQxyimo6Vhl/IXawsUKhS4DElH4YC/I/FDU3iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rZmwii/QkARH24aAlxE20/L4+QJ9DGFPRuwo6gx48U=;
        b=P9KTMmp5BsaP4TqEMxyCMq6Xy1d5hlP2Q0Nntg2wtq4WNVOSecnq4xswED73j/3g0+Aa2r
        U9Y8iJb5KtYUVaAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Clarify timer_wait_running() comment
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183312.985681995@linutronix.de>
References: <20230425183312.985681995@linutronix.de>
MIME-Version: 1.0
Message-ID: <168712140796.404.15897229283135813033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7d9909026645064cd31b20cee5939a0f72282261
Gitweb:        https://git.kernel.org/tip/7d9909026645064cd31b20cee5939a0f72282261
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:48 +02:00

posix-timers: Clarify timer_wait_running() comment

Explain it better and add the CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y aspect
for completeness.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183312.985681995@linutronix.de

---
 kernel/time/posix-timers.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2d6cf93..0c61f29 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -836,10 +836,18 @@ static void common_timer_wait_running(struct k_itimer *timer)
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
