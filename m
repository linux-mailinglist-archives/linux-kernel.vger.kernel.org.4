Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA636C369F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCUQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCUQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:11:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B1D4D297;
        Tue, 21 Mar 2023 09:11:44 -0700 (PDT)
Date:   Tue, 21 Mar 2023 17:11:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679415102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=nG0bOzqdgsuZ4sSUc4UXldoJdmKCghe+OL+gnubJm/U=;
        b=jJpuOhRcELM19ikq6o6peDpFolcfScaGLaNM8vHLDcS+6bhoPiMD9/Nbn0JpO/CDxxI2FU
        9wBfiBLoe74DbcBzGjsjoFkfQr1BkdAPS89Eej/gCIT23RwHvL9h+7N/I97Y0E4bOoKANQ
        o5SIznCLfxG2O5r08hvJLbtTL8OvhY/+4sTz+foiwCuyRV0QATb+2TNKYiRWMde6YIc1el
        LQTMRYo03ZymIHkFNgw032Oa2688gQrhloXvi7Ek1t7xgps+piG2tlwLSmu2qfSz97c7MK
        POAo02BCl9ZZyYCFE36z4DlW6iOanWfX3fal6XtLxMOheYb77migsFkeey0Y8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679415102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=nG0bOzqdgsuZ4sSUc4UXldoJdmKCghe+OL+gnubJm/U=;
        b=HtVblRZN8VEhdTg0yUDC5F1Pr7yJQqO2u1qqfa0HDbzNzKDXpPob2YLcxvbYynx/fl03aE
        QwNqIet1mEWH2rDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v6] locking/rwbase: Mitigate indefinite writer starvation.
Message-ID: <20230321161140.HMcQEhHb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rw_semaphore and rwlock_t locks are unfair to writers. Readers can
indefinitely acquire the lock unless the writer fully acquired the lock.
This can never happen if there is always a reader in the critical
section owning the lock.

Mel Gorman reported that since LTP-20220121 the dio_truncate test case
went from having 1 reader to having 16 reader and the number of readers
is sufficient to prevent the down_write ever succeeding while readers
exist. Eventually the test is killed after 30 minutes as a failure.

Mel proposed a timeout to limit how long a writer can be blocked until
the reader is forced into the slowpath.
Thomas argued that there is no added value by providing this timeout.
From PREEMPT_RT point of view, there are no critical rw_semaphore or
rwlock_t locks left where the reader must be prefer.

Mitigate indefinite writer starvation by forcing the READER into the
slowpath once the WRITER attempts to acquire the lock.

Reported-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/877cwbq4cq.ffs@tglx
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
- v5..v6: https://lore.kernel.org/all/Y+0W0wgyaJqYHKoj@linutronix.de/
  - dropped the timeout and forcing reader into the slowpath once a
    writer is waiting.

- v4..v5 https://lore.kernel.org/20230120140847.4pjqf3oinemokcyp@techsingularity.net
  - Reworded last paragraph of the commit message as Mel's suggestion
  - RT/DL tasks are no longer excluded from the waiter timeout. There
    is no reason why this should be done since no RT user relies on
    rwsem (and would need this kind of behaviour). The critical user
    from RT perspective replaced rwsem with RCU.
    Avoiding special treatment avoids this kind of bug with RT
    readers.
  - Update comments accordingly.

 kernel/locking/rwbase_rt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index c201aadb93017..25ec0239477c2 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -72,15 +72,6 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 	int ret;
 
 	raw_spin_lock_irq(&rtm->wait_lock);
-	/*
-	 * Allow readers, as long as the writer has not completely
-	 * acquired the semaphore for write.
-	 */
-	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
-		atomic_inc(&rwb->readers);
-		raw_spin_unlock_irq(&rtm->wait_lock);
-		return 0;
-	}
 
 	/*
 	 * Call into the slow lock path with the rtmutex->wait_lock
-- 
2.40.0

