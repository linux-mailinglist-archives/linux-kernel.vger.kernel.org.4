Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB94D63B16C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiK1Sea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiK1Sd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:33:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9492E3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669660281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=geDXnx8E4g+uq7+s+7kQQy4y7GBW/W7WN+scgMvYDCQ=;
        b=OXr5QJy9FkZzMjJaLfEmvksNReiHup+nbB00kJZr+a306SJ8yTfC+OQ4/O1m8rXG0fXV1d
        gA4blmgEOMUtmAIEHH6HZ5m5n72WSUPa9TjBe4r4GdIZi4KFZd5AGmha+JpUCWoOVaxNek
        jQNsM4/opUPvbQJT/A3oLRVzFO7XYaA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-GqLzjbzjMkqUlcmBZHdM0g-1; Mon, 28 Nov 2022 13:31:17 -0500
X-MC-Unique: GqLzjbzjMkqUlcmBZHdM0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F2B03814946;
        Mon, 28 Nov 2022 18:31:17 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.33.37.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7AFD2166B2E;
        Mon, 28 Nov 2022 18:31:15 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v6 0/4] workqueue: destroy_worker() vs isolated CPUs
Date:   Mon, 28 Nov 2022 18:31:05 +0000
Message-Id: <20221128183109.446754-1-vschneid@redhat.com>
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

This revision is mostly about getting work out of the timer callback and
into the new idle worker culling work item.

Revisions
=========

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

Valentin Schneider (3):
  workqueue: Factorize unbind/rebind_workers() logic
  workqueue: Convert the idle_timer to a timer + work_struct
  workqueue: Unbind kworkers before sending them to exit()

 kernel/workqueue.c | 195 +++++++++++++++++++++++++++++++++------------
 1 file changed, 143 insertions(+), 52 deletions(-)

--
2.31.1

