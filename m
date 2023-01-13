Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4867F669750
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbjAMMen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjAMMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37D8551DF;
        Fri, 13 Jan 2023 04:31:12 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWUyIkdaQYU42lutK4TFmKKi5V4hFF4RSB+rS3NmQ6c=;
        b=XgvWSNLXFtZrkcNcygdI9veWzfAN+6eXuWgVoor0lUKDz0KATXxbKG3i1ZXc7LExZCxe4N
        7wi0CqdyVvZS7ifiJzOvtX7fU+7FNf7mHOa+j7AdGANj1RTLXQu8vq9KgvavjtQJhiyqZC
        inpL9HLdRoiopTCosT5AuxaqLQX/PdHZK3tsgj4iMFQ3GEFws1+mVEfpFNNV1/vjw1CJLP
        +sujqmLcF+X444myBpk5PPt9VXrfP04UEscUg3Ci+klS3Un1ffLxdM92YWSF0Yj31H5xXp
        uanQAJ/Zwo+9nnDuWY/pA52BPB8xHyrflh/+dfjPoV4XMsviVLZl5RzW73Ftfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWUyIkdaQYU42lutK4TFmKKi5V4hFF4RSB+rS3NmQ6c=;
        b=J0/YwKgLSPTo2BTQoUF/pub1GzxVOBvtjnJsQolqtfI0Osyiefu2Xp6BOKJLeJtizWvvos
        hiAuc3rnS9nBkWAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] time/tick-broadcast: Remove RCU_NONIDLE() usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195540.927904612@infradead.org>
References: <20230112195540.927904612@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306982.4906.17198573695326641065.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e3ee5e66f78e9950b9ada276700abd95e9b144d7
Gitweb:        https://git.kernel.org/tip/e3ee5e66f78e9950b9ada276700abd95e9b144d7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:16 +01:00

time/tick-broadcast: Remove RCU_NONIDLE() usage

No callers left that have already disabled RCU.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195540.927904612@infradead.org
---
 kernel/time/tick-broadcast-hrtimer.c | 29 +++++++++++----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index 797eb93..e28f921 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -56,25 +56,20 @@ static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 	 * hrtimer callback function is currently running, then
 	 * hrtimer_start() cannot move it and the timer stays on the CPU on
 	 * which it is assigned at the moment.
+	 */
+	hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED_HARD);
+	/*
+	 * The core tick broadcast mode expects bc->bound_on to be set
+	 * correctly to prevent a CPU which has the broadcast hrtimer
+	 * armed from going deep idle.
 	 *
-	 * As this can be called from idle code, the hrtimer_start()
-	 * invocation has to be wrapped with RCU_NONIDLE() as
-	 * hrtimer_start() can call into tracing.
+	 * As tick_broadcast_lock is held, nothing can change the cpu
+	 * base which was just established in hrtimer_start() above. So
+	 * the below access is safe even without holding the hrtimer
+	 * base lock.
 	 */
-	RCU_NONIDLE( {
-		hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED_HARD);
-		/*
-		 * The core tick broadcast mode expects bc->bound_on to be set
-		 * correctly to prevent a CPU which has the broadcast hrtimer
-		 * armed from going deep idle.
-		 *
-		 * As tick_broadcast_lock is held, nothing can change the cpu
-		 * base which was just established in hrtimer_start() above. So
-		 * the below access is safe even without holding the hrtimer
-		 * base lock.
-		 */
-		bc->bound_on = bctimer.base->cpu_base->cpu;
-	} );
+	bc->bound_on = bctimer.base->cpu_base->cpu;
+
 	return 0;
 }
 
