Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CCF60B79B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiJXT1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJXT0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886FC72FD3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666634295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fCvbSgxKkVngETIOIh3AmCdsye2c6FCNzZDR+LWaBok=;
        b=DWzb+n/5GMSSkudDS0cgxtdghZ6VmYC/AVHqZjS9RN+4es+Dv2mxBbqQKywUCBnPGnOJOJ
        41axuWjq/DUM3wWt0Aca0l354BS+ctwtV/708WVBYg0+HyKY77i0d/Cig2q0E2KqQO5zAr
        WvWK1zyQVS/yj4QTkakUt11yKN8YiRo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-lPIKskdWP3-rNMpu5I5t0w-1; Mon, 24 Oct 2022 13:44:52 -0400
X-MC-Unique: lPIKskdWP3-rNMpu5I5t0w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D49A63817960;
        Mon, 24 Oct 2022 17:44:51 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F12C492B0E;
        Mon, 24 Oct 2022 17:44:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v4 5/5] locking/rwsem: Update handoff lock events tracking
Date:   Mon, 24 Oct 2022 13:44:18 -0400
Message-Id: <20221024174418.796468-6-longman@redhat.com>
In-Reply-To: <20221024174418.796468-1-longman@redhat.com>
References: <20221024174418.796468-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new direct rwsem lock handoff, the corresponding handoff lock
events are updated to also track the number of secondary lock handoffs
in rwsem_down_read_slowpath() to see how prevalent those handoff
events are. The number of primary lock handoffs in the unlock paths is
(rwsem_handoff_read + rwsem_handoff_write - rwsem_handoff_rslow).

After running a 96-thread rwsem microbenchmark with equal number
of readers and writers on a 2-socket 96-thread system for 40s, the
following handoff stats were obtained:

  rwsem_handoff_read=189
  rwsem_handoff_rslow=1
  rwsem_handoff_write=6678
  rwsem_handoff_wspin=6681

The number of primary handoffs was 6866, whereas there was only one
secondary handoff for this test run.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h | 6 ++++--
 kernel/locking/rwsem.c            | 9 +++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 97fb6f3f840a..04d101767c2c 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -63,7 +63,9 @@ LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_steal)	/* # of read locks by lock stealing	*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
-LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
-LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
+LOCK_EVENT(rwsem_handoff_read)	/* # of read lock handoffs		*/
+LOCK_EVENT(rwsem_handoff_write)	/* # of write lock handoffs		*/
+LOCK_EVENT(rwsem_handoff_rslow)	/* # of handoffs in read slowpath	*/
+LOCK_EVENT(rwsem_handoff_wspin)	/* # of handoff spins in write slowpath	*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 287606aee0e6..46aea1994bf8 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -472,10 +472,8 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 			 * force the issue.
 			 */
 			if (time_after(jiffies, waiter->timeout)) {
-				if (!(oldcount & RWSEM_FLAG_HANDOFF)) {
+				if (!(oldcount & RWSEM_FLAG_HANDOFF))
 					adjustment -= RWSEM_FLAG_HANDOFF;
-					lockevent_inc(rwsem_rlock_handoff);
-				}
 				WRITE_ONCE(waiter->handoff_state, HANDOFF_REQUESTED);
 			}
 
@@ -680,7 +678,6 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	 */
 	if (new & RWSEM_FLAG_HANDOFF) {
 		WRITE_ONCE(first->handoff_state, HANDOFF_REQUESTED);
-		lockevent_inc(rwsem_wlock_handoff);
 		return false;
 	}
 
@@ -1019,10 +1016,12 @@ static void rwsem_handoff(struct rw_semaphore *sem, long adj,
 		wake_type = RWSEM_WAKE_ANY;
 		adj += RWSEM_WRITER_LOCKED;
 		atomic_long_set(&sem->owner, (long)waiter->task);
+		lockevent_inc(rwsem_handoff_write);
 	} else {
 		wake_type = RWSEM_WAKE_READ_OWNED;
 		adj += RWSEM_READER_BIAS;
 		__rwsem_set_reader_owned(sem, waiter->task);
+		lockevent_inc(rwsem_handoff_read);
 	}
 	atomic_long_add(adj, &sem->count);
 	rwsem_mark_wake(sem, wake_type, wake_q);
@@ -1128,6 +1127,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 		if (rwsem_first_waiter(sem)->type == RWSEM_WAITING_FOR_READ)
 			adjustment = 0;
 		rwsem_handoff(sem, adjustment, &wake_q);
+		lockevent_inc(rwsem_handoff_rslow);
 
 		if (!adjustment) {
 			raw_spin_unlock_irq(&sem->wait_lock);
@@ -1257,6 +1257,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 				preempt_disable();
 				rwsem_spin_on_owner(sem);
 				preempt_enable();
+				lockevent_inc(rwsem_handoff_wspin);
 			}
 			if (READ_ONCE(waiter.handoff_state) == HANDOFF_GRANTED)
 				goto skip_sleep;
-- 
2.31.1

