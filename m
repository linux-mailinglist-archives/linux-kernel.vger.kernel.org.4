Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2498B699EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjBPVKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjBPVKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:10:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F933B230
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676581790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MbSttENprtZeMfW1hKajzYumOMh0pA4tKJsFRVCESlg=;
        b=BFobe5b73eKXHaP9dQH9C0+uzykT+UWLCh5LjXm08QwPMVteXkJuvEjiEe/yl1Z/H5L/LB
        V4zdfskaS7PiIiIuGaYWsiNVZSsk4nzX0D35HyFBNlERoM6o/6x31f67GHHw8B1tyaTUAB
        fid/XAxpeu9k2D9wz0c2FJvyeRaXKSI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-Yo0BlUDiN3eM0vGM9v6BZQ-1; Thu, 16 Feb 2023 16:09:47 -0500
X-MC-Unique: Yo0BlUDiN3eM0vGM9v6BZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FF1C38149B5;
        Thu, 16 Feb 2023 21:09:46 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3536151FF;
        Thu, 16 Feb 2023 21:09:46 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 3/3] locking/rwsem: Wake up all readers for wait queue waker
Date:   Thu, 16 Feb 2023 16:09:33 -0500
Message-Id: <20230216210933.1169097-4-longman@redhat.com>
In-Reply-To: <20230216210933.1169097-1-longman@redhat.com>
References: <20230216210933.1169097-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

With commit 54c1ee4d614d ("locking/rwsem: Conditionally wake waiters
in reader/writer slowpaths"), a new incoming reader should wake up
another batch of up to 256 readers. However, these incoming readers
or writers will have to wait in the wait queue and there is nothing
else they can do until it is their turn to be waken up. This patch
renames rwsem_mark_wake() to __rwsem_mark_wake() and adds an additional
in_waitq argument to indicate that the waker is in the wait queue and
can ignore the limit. A rwsem_mark_wake() helper is added that keeps
the original semantics.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index fc3961ceabe8..35b4adf8ea55 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -408,9 +408,9 @@ rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
  *
  * Implies rwsem_del_waiter() for all woken readers.
  */
-static void rwsem_mark_wake(struct rw_semaphore *sem,
-			    enum rwsem_wake_type wake_type,
-			    struct wake_q_head *wake_q)
+static void __rwsem_mark_wake(struct rw_semaphore *sem,
+			      enum rwsem_wake_type wake_type,
+			      struct wake_q_head *wake_q, bool in_waitq)
 {
 	long count = atomic_long_read(&sem->count);
 	struct rwsem_waiter *waiter, *tmp;
@@ -542,9 +542,10 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
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
 
@@ -594,6 +595,13 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 }
 
+static inline void rwsem_mark_wake(struct rw_semaphore *sem,
+				   enum rwsem_wake_type wake_type,
+				   struct wake_q_head *wake_q)
+{
+	__rwsem_mark_wake(sem, wake_type, wake_q, false);
+}
+
 /*
  * Remove a waiter and try to wake up other waiters in the wait queue
  * This function is called from the out_nolock path of both the reader and
@@ -1022,7 +1030,7 @@ static inline void rwsem_cond_wake_waiter(struct rw_semaphore *sem, long count,
 		wake_type = RWSEM_WAKE_ANY;
 		clear_nonspinnable(sem);
 	}
-	rwsem_mark_wake(sem, wake_type, wake_q);
+	__rwsem_mark_wake(sem, wake_type, wake_q, true);
 }
 
 /*
-- 
2.31.1

