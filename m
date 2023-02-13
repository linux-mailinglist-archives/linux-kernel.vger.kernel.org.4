Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AC169510F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjBMTts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBMTtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:49:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E71422A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676317733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b7jYYaKDjGObGliNYlXudjzJtUfA3xOqfNANQ2twpT0=;
        b=JIK5Jv5RQBeTgG7bsqgToBVCPdS2Q3pPx2hnoweUylqcFl7f6Zn4rJ+hoO4ZEdutJZMy3U
        iWxqtLMUaqRX1R+cOVHVU2kP/XpZ6rzMruVFF9lDR2QkAwVQNUfpbQZt4bJsCF8eGbHo8K
        57f+1G+OCnhQmX2iLswLonE6HEBxW7Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-VdLTVRkBO5q9XEy8WNHXUA-1; Mon, 13 Feb 2023 14:48:50 -0500
X-MC-Unique: VdLTVRkBO5q9XEy8WNHXUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C50C100F906;
        Mon, 13 Feb 2023 19:48:49 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AD89C16023;
        Mon, 13 Feb 2023 19:48:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] locking/rwsem: Wake up all readers for wait queue waker
Date:   Mon, 13 Feb 2023 14:48:32 -0500
Message-Id: <20230213194832.832256-3-longman@redhat.com>
In-Reply-To: <20230213194832.832256-1-longman@redhat.com>
References: <20230213194832.832256-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted in commit 54c1ee4d614d ("locking/rwsem: Conditionally wake
waiters in reader/writer slowpaths"), it was possible for a rwsem to get
into a state where a reader-owned rwsem could have many readers waiting
in the wait queue but no writer.

Recently, it was found that one way to cause this condition is to have a
highly contended rwsem with many readers, like a mmap_sem. There can be
hundreds of readers waiting in the wait queue of a writer-owned mmap_sem.
The rwsem_wake() call by the up_write() call of the rwsem owning writer
can hit the 256 reader wakeup limit and leave the rests of the readers
remaining in the wait queue. The reason for the limit is to avoid
excessive delay in doing other useful work.

With commit 54c1ee4d614d ("locking/rwsem: Conditionally wake waiters in
reader/writer slowpaths"), a new incoming reader should wake up another
batch of up to 256 readers. However, these incoming readers or writers
will have to wait in the wait queue and there is nothing else they can
do until it is their turn to be waken up. This patch adds an additional
in_waitq argument to rwsem_mark_wake() to indicate that the waker is
in the wait queue and can ignore the limit.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 3936a5fe1229..723a8824b967 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -410,7 +410,7 @@ rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
  */
 static void rwsem_mark_wake(struct rw_semaphore *sem,
 			    enum rwsem_wake_type wake_type,
-			    struct wake_q_head *wake_q)
+			    struct wake_q_head *wake_q, bool in_waitq)
 {
 	struct rwsem_waiter *waiter, *tmp;
 	long oldcount, woken = 0, adjustment = 0;
@@ -524,9 +524,10 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		list_move_tail(&waiter->list, &wlist);
 
 		/*
-		 * Limit # of readers that can be woken up per wakeup call.
+		 * Limit # of readers that can be woken up per wakeup call
+		 * unless the waker is waiting in the wait queue.
 		 */
-		if (unlikely(woken >= MAX_READERS_WAKEUP))
+		if (unlikely(!in_waitq && (woken >= MAX_READERS_WAKEUP)))
 			break;
 	}
 
@@ -597,7 +598,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
 	 * be eligible to acquire or spin on the lock.
 	 */
 	if (rwsem_del_waiter(sem, waiter) && first)
-		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, wake_q);
+		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, wake_q, false);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	if (!wake_q_empty(wake_q))
 		wake_up_q(wake_q);
@@ -1004,7 +1005,7 @@ static inline void rwsem_cond_wake_waiter(struct rw_semaphore *sem, long count,
 		wake_type = RWSEM_WAKE_ANY;
 		clear_nonspinnable(sem);
 	}
-	rwsem_mark_wake(sem, wake_type, wake_q);
+	rwsem_mark_wake(sem, wake_type, wake_q, true);
 }
 
 /*
@@ -1042,7 +1043,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (!list_empty(&sem->wait_list))
 				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
-						&wake_q);
+						&wake_q, false);
 			raw_spin_unlock_irq(&sem->wait_lock);
 			wake_up_q(&wake_q);
 		}
@@ -1259,7 +1260,7 @@ static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 			goto unlock_out;
 		}
 	}
-	rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+	rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q, false);
 
 unlock_out:
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
@@ -1281,7 +1282,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (!list_empty(&sem->wait_list))
-		rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED, &wake_q);
+		rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED, &wake_q, false);
 
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
 	wake_up_q(&wake_q);
-- 
2.31.1

