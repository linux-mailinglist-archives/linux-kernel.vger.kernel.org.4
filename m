Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008A26F237B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 09:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347268AbjD2HDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 03:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjD2HDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 03:03:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0852D55;
        Sat, 29 Apr 2023 00:03:11 -0700 (PDT)
Date:   Sat, 29 Apr 2023 07:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682751787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDaA+xUryUCZ8I28N9aEWarm2HCgNFHRBUqq4ZipNkw=;
        b=2TiaD9wZn/tmg+bkwQITCGx3iOLS9uQkek5A7KgV7yL8ds2KbJIsP4aOpz4VOBnXdo+fdy
        lffwBdeI/Pq2eKnmP+GBzyVMTmM2fqP2LsONK1YYKuHjsHTI9tjw0ianj2zOtxBYwDiX5a
        YREhS5mlW/q8gNRz5hqKYNfKbV3E7t4YezWRkODgxugzOrAiRUKXrFx4xuPiz7cM5nfpMV
        3vRn55VeYzLSIA3U0IeL2pQuiB+4UqLmEKLwbpPPOhFCqLRrSbTr1XrPmwzylncfuTU5Gg
        DinPIAQOtJo5kGjojGRTcVmzA6qDYU+DhkP+8JszgeCpHYRxaqMWLFDtuIGFig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682751787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDaA+xUryUCZ8I28N9aEWarm2HCgNFHRBUqq4ZipNkw=;
        b=dx3FTou7JcyvSTYo/IWVXqQGwAgfGNHc79nquHXcwz8GGbKYbTQAV5Pys2EwAhqnZ79apd
        AeT0lRM3+F9AnVCw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwbase: Mitigate indefinite writer starvation
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <877cwbq4cq.ffs@tglx>
References: <877cwbq4cq.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168275178708.404.13683665200717626496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0abdb96fc6862681b926a0686012820229fab450
Gitweb:        https://git.kernel.org/tip/0abdb96fc6862681b926a0686012820229fab450
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 21 Mar 2023 17:11:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 29 Apr 2023 08:51:08 +02:00

locking/rwbase: Mitigate indefinite writer starvation

On PREEMPT_RT, rw_semaphore and rwlock_t locks are unfair to writers.
Readers can indefinitely acquire the lock unless the writer fully acquired
the lock, which might never happen if there is always a reader in the
critical section owning the lock.

Mel Gorman reported that since LTP-20220121 the dio_truncate test case
went from having 1 reader to having 16 readers and that number of readers
is sufficient to prevent the down_write ever succeeding while readers
exist. Eventually the test is killed after 30 minutes as a failure.

Mel proposed a timeout to limit how long a writer can be blocked until
the reader is forced into the slowpath.

Thomas argued that there is no added value by providing this timeout.  From
a PREEMPT_RT point of view, there are no critical rw_semaphore or rwlock_t
locks left where the reader must be preferred.

Mitigate indefinite writer starvation by forcing the READER into the
slowpath once the WRITER attempts to acquire the lock.

Reported-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/877cwbq4cq.ffs@tglx
Link: https://lore.kernel.org/r/20230321161140.HMcQEhHb@linutronix.de
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 kernel/locking/rwbase_rt.c |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index c201aad..25ec023 100644
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
