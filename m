Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712206A08A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjBWMe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjBWMeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:34:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D551F53291
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TEsGyLB0CNcBpX90uP9C3/IuHqwgLDCS4pkbIzi7bTs=; b=W+Yg1h01pDhHfxnGAyRcsmwgae
        TUshyVt3m63K6ldCz0ndwzLsb7y7tLV14Pywr392gBpULlSTcJVFhW540Y3SiHgeMmp1msaNSxNxL
        23lUZfij3DeAxFGUX7WK0ceMqp5pkC+1ohtQE5GcrPATG1ZXU0a1We/Lmy/EhrRElzcnzM3jBMRCw
        UWWAB3pHtfdbwzU2ZRpWM+a50z2mkn48eAsvf3NXy7awZLRfV5NVj+tTBpTokPy5VHbm7uwNESw3u
        MV6tqDmGvzvM3onImHKxLJYIlk8ISJqq9No4CkqP3hHxlpLYImk+3NH+4GGL47TviJPiPV2avyFid
        h/0oSBmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVAo1-00EMIv-2D; Thu, 23 Feb 2023 12:34:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE32130082F;
        Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C88112C86FE08; Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Message-ID: <20230223123319.667433408@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 23 Feb 2023 13:26:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     longman@redhat.com, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com
Subject: [PATCH 6/6] locking/rwsem: Use the force
References: <20230223122642.491637862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the writer adjustment is done from the wakeup side and
HANDOFF guarantees spinning/stealing is disabled, use the combined
guarantee it ignore spurious READER_BIAS and directly claim the lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lock_events_list.h |    1 +
 kernel/locking/rwsem.c            |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -67,3 +67,4 @@ LOCK_EVENT(rwsem_rlock_handoff)	/* # of
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
 LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
+LOCK_EVENT(rwsem_wlock_ehandoff) /* # of write lock early handoffs	*/
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -433,6 +433,26 @@ static void rwsem_writer_wake(struct rw_
 	lockdep_assert_held(&sem->wait_lock);
 
 	count = atomic_long_read(&sem->count);
+
+	/*
+	 * Since rwsem_mark_wake() is only called (with WAKE_ANY) when
+	 * the lock is unlocked, and the HANDOFF bit guarantees that
+	 * all spinning / stealing is disabled, it is posssible to
+	 * unconditionally claim the lock -- any READER_BIAS will be
+	 * temporary.
+	 */
+	if (count & RWSEM_FLAG_HANDOFF) {
+		unsigned long adjustment = RWSEM_WRITER_LOCKED - RWSEM_FLAG_HANDOFF;
+
+		if (list_is_singular(&sem->wait_list))
+			adjustment -= RWSEM_FLAG_WAITERS;
+
+		atomic_long_set(&sem->owner, (long)waiter->task);
+		atomic_long_add(adjustment, &sem->count);
+		lockevent_inc(rwsem_wlock_ehandoff);
+		goto success;
+	}
+
 	do {
 		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
@@ -479,6 +499,7 @@ static void rwsem_writer_wake(struct rw_
 		return;
 	}
 
+success:
 	/*
 	 * Have rwsem_writer_wake() fully imply rwsem_del_waiter() on
 	 * success.


