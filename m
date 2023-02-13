Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1DC694B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjBMPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjBMPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:35:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0B015569
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5m87awoG5d3Jt5woUJ/yRx/DEUUgyrlkPyRKI0IZz1Y=; b=dBq9ZJzIp1Vi085/AexiVCKw8u
        +y10KiJOyhQY5+d8jeXirwW7N/XOhjxP3nFqrV1mshUcwbOEGPIzEGxyiNsDpLcNjCKjy3mYTDqNi
        5cwqUiH7tqAusPKkw4b/JroD+DZAyKLs07cw+3AeZZnFCnXGlnskMGjZJUXc/hH8wiqhhLzoZoG9k
        ghJofDywmB8D7OMfrtZW+IUt1fTawnsHfwCAoRA4UoodmuDCo4UDW9jITjLiCv23R0HCJ3fVsBLsa
        OJfCjlaD1sUTyyBdsu3FBUTTAdkd4III8xv4YA2y/OxfVA6njnqTZjSLFIj9MyIwbSmKqTdNfuKGe
        p3GVvMAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRaqg-005t2K-BC; Mon, 13 Feb 2023 15:34:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6FC4630036B;
        Mon, 13 Feb 2023 16:34:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 573A020835894; Mon, 13 Feb 2023 16:34:33 +0100 (CET)
Date:   Mon, 13 Feb 2023 16:34:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Message-ID: <Y+pYiUfKp32hbIEI@hirez.programming.kicks-ass.net>
References: <20230127014137.4906-1-hdanton@sina.com>
 <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
 <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
 <Y9z76ZLe4On96xIN@hirez.programming.kicks-ass.net>
 <Y9z+SerR8mlZYo16@hirez.programming.kicks-ass.net>
 <6c47dbcf-2a17-6bb2-719b-841d851c603b@I-love.SAKURA.ne.jp>
 <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
 <caa13441-5f95-b7d6-dd5d-1cf49e709714@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa13441-5f95-b7d6-dd5d-1cf49e709714@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 09:48:39AM +0900, Tetsuo Handa wrote:
> Please fold below diff,

Find final version below -- typing hard I suppose..

> provided that wait_for_completion_state(TASK_FREEZABLE)
> does not return when the current thread was frozen. (If
> wait_for_completion_state(TASK_FREEZABLE) returns when the current thread was
> frozen, we will fail to execute the

FREEZABLE should be transparent; that is it will only return when an
actual wakeup was missed, otherwise it will remain asleep.

Specifically, the FROZEN thing relies on wait loops to be resillient
against spurious wakeups. Consider do_wait_for_common(), the action() :=
schedule_timeout() might 'suriously' return after thawing, but it will
re-validate the actual completion condition and go back to sleep if it
hasn't happened yet.

OTOH, if the completeion condition has happened (right before the
completer itself was frozen for example, but after the waiter was
already frozen), then the 'spurious' wakeup on thaw is exactly what was
needed, the completion condition is satisfied and the wait terminated.

---
Subject: freezer,umh: Fix call_usermode_helper_exec() vs SIGKILL
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 3 Feb 2023 15:31:11 +0100

Tetsuo-San noted that commit f5d39b020809 ("freezer,sched: Rewrite
core freezer logic") broke call_usermodehelper_exec() for the KILLABLE
case.

Specifically it was missed that the second, unconditional,
wait_for_completion() was not optional and ensures the on-stack
completion is unused before going out-of-scope.

Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
Reported-by: syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Debugged-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net
---
 kernel/umh.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -438,21 +438,27 @@ int call_usermodehelper_exec(struct subp
 	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
 
-	if (wait & UMH_KILLABLE)
-		state |= TASK_KILLABLE;
-
 	if (wait & UMH_FREEZABLE)
 		state |= TASK_FREEZABLE;
 
-	retval = wait_for_completion_state(&done, state);
-	if (!retval)
-		goto wait_done;
-
 	if (wait & UMH_KILLABLE) {
+		retval = wait_for_completion_state(&done, state | TASK_KILLABLE);
+		if (!retval)
+			goto wait_done;
+
 		/* umh_complete() will see NULL and free sub_info */
 		if (xchg(&sub_info->complete, NULL))
 			goto unlock;
+
+		/*
+		 * fallthrough; in case of -ERESTARTSYS now do uninterruptible
+		 * wait_for_completion_state(). Since umh_complete() shall call
+		 * complete() in a moment if xchg() above returned NULL, this
+		 * uninterruptible wait_for_completion_state() will not block
+		 * SIGKILL'ed processes for long.
+		 */
 	}
+	wait_for_completion_state(&done, state);
 
 wait_done:
 	retval = sub_info->retval;
