Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16569667A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjALQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbjALQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:18:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920A81DF30
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673540087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMLRW5gvg+irO4xJtjlod4Jc3xlBzVZYp1kicQUxcG4=;
        b=Kagaz6iEzmO8wZDkXbvODyunl6SesJiIiNefVBMyIA3cVujWIhCKblrEJ28OtL8mUAOgSH
        +DuY61S6KT14swGJKGglNlr83JsqLAeAjCbj9KVWpMjXHwZNOL12OvaPmAz5uwtz4YCijB
        EOEhxKHNQ+eXE6a6ikuyCEROX8DV1Tk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-5MdotZiLPrelFSWPXgfy8w-1; Thu, 12 Jan 2023 11:14:44 -0500
X-MC-Unique: 5MdotZiLPrelFSWPXgfy8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDF96299E74C;
        Thu, 12 Jan 2023 16:14:42 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.33.36.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D26462166B26;
        Thu, 12 Jan 2023 16:14:41 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v8 4/5] workqueue: Don't hold any lock while rcuwait'ing for !POOL_MANAGER_ACTIVE
Date:   Thu, 12 Jan 2023 16:14:30 +0000
Message-Id: <20230112161431.860196-5-vschneid@redhat.com>
In-Reply-To: <20230112161431.860196-1-vschneid@redhat.com>
References: <20230112161431.860196-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_unbound_pool() currently passes wq_manager_inactive() as exit condition
to rcuwait_wait_event(), which grabs pool->lock to check for

  pool->flags & POOL_MANAGER_ACTIVE

A later patch will require destroy_worker() to be invoked with
wq_pool_attach_mutex held, which needs to be acquired before
pool->lock. A mutex cannot be acquired within rcuwait_wait_event(), as
it could clobber the task state set by rcuwait_wait_event()

Instead, restructure the waiting logic to acquire any necessary lock
outside of rcuwait_wait_event().

Since further work cannot be inserted into unbound pwqs that have reached
->refcnt==0, this is bound to make forward progress as eventually the
worklist will be drained and need_more_worker(pool) will remain false,
preventing any worker from stealing the manager position from us.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 11bb657059bcd..8ece9bfa04a09 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3604,18 +3604,6 @@ static void rcu_free_pool(struct rcu_head *rcu)
 	kfree(pool);
 }
 
-/* This returns with the lock held on success (pool manager is inactive). */
-static bool wq_manager_inactive(struct worker_pool *pool)
-{
-	raw_spin_lock_irq(&pool->lock);
-
-	if (pool->flags & POOL_MANAGER_ACTIVE) {
-		raw_spin_unlock_irq(&pool->lock);
-		return false;
-	}
-	return true;
-}
-
 /**
  * put_unbound_pool - put a worker_pool
  * @pool: worker_pool to put
@@ -3651,12 +3639,26 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * Become the manager and destroy all workers.  This prevents
 	 * @pool's workers from blocking on attach_mutex.  We're the last
 	 * manager and @pool gets freed with the flag set.
-	 * Because of how wq_manager_inactive() works, we will hold the
-	 * spinlock after a successful wait.
+	 *
+	 * Having a concurrent manager is quite unlikely to happen as we can
+	 * only get here with
+	 *   pwq->refcnt == pool->refcnt == 0
+	 * which implies no work queued to the pool, which implies no worker can
+	 * become the manager. However a worker could have taken the role of
+	 * manager before the refcnts dropped to 0, since maybe_create_worker()
+	 * drops pool->lock
 	 */
-	rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
-			   TASK_UNINTERRUPTIBLE);
-	pool->flags |= POOL_MANAGER_ACTIVE;
+	while (true) {
+		rcuwait_wait_event(&manager_wait,
+				   !(pool->flags & POOL_MANAGER_ACTIVE),
+				   TASK_UNINTERRUPTIBLE);
+		raw_spin_lock_irq(&pool->lock);
+		if (!(pool->flags & POOL_MANAGER_ACTIVE)) {
+			pool->flags |= POOL_MANAGER_ACTIVE;
+			break;
+		}
+		raw_spin_unlock_irq(&pool->lock);
+	}
 
 	while ((worker = first_idle_worker(pool)))
 		destroy_worker(worker);
-- 
2.31.1

