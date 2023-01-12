Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56948667A98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjALQTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbjALQSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:18:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724931DF2B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673540087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ajXg3rrPzpKQc3Qb9p25qpHrk+Gbw3eJrr+7KdkqnQQ=;
        b=LnlFZiTcID1TNIXY0QVhPXJg3/Wxb/NpsvibsxmKR+xsCj1g8EcXrhCpgrEOEc5AHuJnxu
        t7rcEAA6TISgAmDz8pLwDDy8CIOnjQuEAuWBrzqHFipK5q26QCjL9/D2ctqzln5G2h6vXY
        YSSCCISWCG0rVHwQhqp/0gx6gNCXOM4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-Uw44OhPHOwaROxaMbS5wPg-1; Thu, 12 Jan 2023 11:14:38 -0500
X-MC-Unique: Uw44OhPHOwaROxaMbS5wPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9613A85A588;
        Thu, 12 Jan 2023 16:14:37 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.33.36.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5895A2166B26;
        Thu, 12 Jan 2023 16:14:36 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v8 0/5] workqueue: destroy_worker() vs isolated CPUs
Date:   Thu, 12 Jan 2023 16:14:26 +0000
Message-Id: <20230112161431.860196-1-vschneid@redhat.com>
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

Hi folks,

This version only brings a small change: getting rid of wq_manager_inactive()
for (somewhat) saner wq_pool_attach_mutex acquisition.

range-diff with previous version
================================

1:  2448692cdc707 = 1:  2448692cdc707 workqueue: Protects wq_unbound_cpumask with wq_pool_attach_mutex
2:  55d7ac5db1560 = 2:  55d7ac5db1560 workqueue: Factorize unbind/rebind_workers() logic
3:  d35d1e33d9621 = 3:  d35d1e33d9621 workqueue: Convert the idle_timer to a timer + work_struct
-:  ------------- > 4:  d596651130433 workqueue: Don't hold any lock while rcuwait'ing for !POOL_MANAGER_ACTIVE
4:  d1ce4e27cbd20 ! 5:  6b6961c5ded12 workqueue: Unbind kworkers before sending them to exit()
    @@ kernel/workqueue.c: static int init_worker_pool(struct worker_pool *pool)
      
      	ida_init(&pool->worker_ida);
      	INIT_HLIST_NODE(&pool->hash_node);
    -@@ kernel/workqueue.c: static bool wq_manager_inactive(struct worker_pool *pool)
    +@@ kernel/workqueue.c: static void rcu_free_pool(struct rcu_head *rcu)
      static void put_unbound_pool(struct worker_pool *pool)
      {
      	DECLARE_COMPLETION_ONSTACK(detach_completion);
    @@ kernel/workqueue.c: static bool wq_manager_inactive(struct worker_pool *pool)
      
      	if (--pool->refcnt)
     @@ kernel/workqueue.c: static void put_unbound_pool(struct worker_pool *pool)
    - 			   TASK_UNINTERRUPTIBLE);
    - 	pool->flags |= POOL_MANAGER_ACTIVE;
    - 
    -+	/*
    -+	 * We need to hold wq_pool_attach_mutex() while destroying the workers,
    -+	 * but we can't grab it in rcuwait_wait_event() as it can clobber
    -+	 * current's task state. We can drop pool->lock here as we've set
    -+	 * POOL_MANAGER_ACTIVE, no one else can steal our manager position.
    -+	 */
    -+	raw_spin_unlock_irq(&pool->lock);
    -+	mutex_lock(&wq_pool_attach_mutex);
    -+	raw_spin_lock_irq(&pool->lock);
    + 		rcuwait_wait_event(&manager_wait,
    + 				   !(pool->flags & POOL_MANAGER_ACTIVE),
    + 				   TASK_UNINTERRUPTIBLE);
     +
    ++		mutex_lock(&wq_pool_attach_mutex);
    + 		raw_spin_lock_irq(&pool->lock);
    + 		if (!(pool->flags & POOL_MANAGER_ACTIVE)) {
    + 			pool->flags |= POOL_MANAGER_ACTIVE;
    + 			break;
    + 		}
    + 		raw_spin_unlock_irq(&pool->lock);
    ++		mutex_unlock(&wq_pool_attach_mutex);
    + 	}
    + 
      	while ((worker = first_idle_worker(pool)))
     -		destroy_worker(worker);
     +		set_worker_dying(worker, &cull_list);

Revisions
=========

v7 -> v8
++++++++

o Nuke wq_manager_inactive() (Tejun)

v6 -> v7
++++++++

o Rebased onto v6.2-rc3

o Dropped work pending check in worker_enter_idle() (Tejun)
o Overall comment cleanup (Tejun)

o put_unbound_pool() locking issue (Lai)
  Unfortunately the mutex cannot be acquired from within wq_manager_inactive()
  as rcuwait_wait_event() sets the task state to TASK_UNINTERRUPTIBLE before
  invoking it, so grabbing the mutex could clobber the task state.

  I've gone with dropping the pool->lock and reacquiring the two locks in the
  right order after we've become the manager, see comments.

o Applied Lai's RB

v5 -> v6
++++++++

o Rebase onto v6.1-rc7
o Get rid of worker_pool.idle_cull_list; only do minimal amount of work in the
  timer callback (Tejun)
o Dropped the too_many_workers() -> nr_workers_to_cull() change

v4 -> v5
++++++++

o Rebase onto v6.1-rc6

o Overall renaming from "reaping" to "cull"
  I somehow convinced myself this was more appropriate
  
o Split the dwork into timer callback + work item (Tejun)

  I didn't want to have redudant operations happen in the timer callback and in
  the work item, so I made the timer callback detect which workers are "ripe"
  enough and then toss them to a worker for removal.

  This however means we release the pool->lock before getting to actually doing
  anything to those idle workers, which means they can wake up in the meantime.
  The new worker_pool.idle_cull_list is there for that reason.

  The alternative was to have the timer callback detect if any worker was ripe
  enough, kick the work item if so, and have the work item do the same thing
  again, which I didn't like.

RFCv3 -> v4
+++++++++++

o Rebase onto v6.0
o Split into more patches for reviewability
o Take dying workers out of the pool->workers as suggested by Lai

RFCv2 -> RFCv3
++++++++++++++

o Rebase onto v5.19
o Add new patch (1/3) around accessing wq_unbound_cpumask

o Prevent WORKER_DIE workers for kfree()'ing themselves before the idle reaper
  gets to handle them (Tejun)

  Bit of an aside on that: I've been struggling to convince myself this can
  happen due to spurious wakeups and would like some help here.

  Idle workers are TASK_UNINTERRUPTIBLE, so they can't be woken up by
  signals. That state is set *under* pool->lock, and all wakeups (before this
  patch) are also done while holding pool->lock.
  
  wake_up_worker() is done under pool->lock AND only wakes a worker on the
  pool->idle_list. Thus the to-be-woken worker *cannot* have WORKER_DIE, though
  it could gain it *after* being woken but *before* it runs, e.g.:
                          
  LOCK pool->lock
  wake_up_worker(pool)
      wake_up_process(p)
  UNLOCK pool->lock
                          idle_reaper_fn()
                            LOCK pool->lock
                            destroy_worker(worker, list);
			    UNLOCK pool->lock
			                            worker_thread()
						      goto woke_up;
                                                      LOCK pool->lock
						      READ worker->flags & WORKER_DIE
                                                          UNLOCK pool->lock
                                                          ...
						          kfree(worker);
                            reap_worker(worker);
			        // Uh-oh
			  
  ... But IMO that's not a spurious wakeup, that's a concurrency issue. I don't
  see any spurious/unexpected worker wakeup happening once a worker is off the
  pool->idle_list.
  

RFCv1 -> RFCv2
++++++++++++++

o Change the pool->timer into a delayed_work to have a sleepable context for
  unbinding kworkers

Cheers,
Valentin

Lai Jiangshan (1):
  workqueue: Protects wq_unbound_cpumask with wq_pool_attach_mutex

Valentin Schneider (4):
  workqueue: Factorize unbind/rebind_workers() logic
  workqueue: Convert the idle_timer to a timer + work_struct
  workqueue: Don't hold any lock while rcuwait'ing for
    !POOL_MANAGER_ACTIVE
  workqueue: Unbind kworkers before sending them to exit()

 kernel/workqueue.c | 234 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 166 insertions(+), 68 deletions(-)

--
2.31.1

