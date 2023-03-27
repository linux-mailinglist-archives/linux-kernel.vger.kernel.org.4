Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3F16CAFF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjC0U0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjC0UZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7423C3B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679948668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8r2GtgMj8HsgRbA0nyRJOwHfIjPVfs2+AeiQGsNXamk=;
        b=Bar92AYN8rhZQF+aV3M2Gdsmwpfm9M1XsD6luFWanHHbE82rFxUErGNHL/vxZaNc4xjGFw
        tOviGUUO3BwaEhKn14Ew+DrY5bVpVAnjIucio3BrJ61AZimMrXHH6fMxLVG++RgU7kgWyt
        2EzwrNahSGK9Eq+nuxQw5k0bvN1uZsY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-NWXBHcTjMN-cOVwt0EF7XA-1; Mon, 27 Mar 2023 16:24:25 -0400
X-MC-Unique: NWXBHcTjMN-cOVwt0EF7XA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D0A138123AB;
        Mon, 27 Mar 2023 20:24:25 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CADCB2027040;
        Mon, 27 Mar 2023 20:24:24 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 8/8] locking/rwsem: Restore old write lock slow path behavior
Date:   Mon, 27 Mar 2023 16:24:13 -0400
Message-Id: <20230327202413.1955856-9-longman@redhat.com>
In-Reply-To: <20230327202413.1955856-1-longman@redhat.com>
References: <20230327202413.1955856-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An earlier commit ("locking/rwsem: Rework writer wakeup") moves writer
lock acquisition to the write wakeup path only. This can result in
an almost immediate transfer of write lock ownership after an unlock
leaving little time for lock stealing. That can be long before the new
write lock owner wakes up and run its critical section.

As a result, write lock stealing from optimistic spinning will be
greatly suppressed. By enabling CONFIG_LOCK_EVENT_COUNTS and running a
rwsem locking microbenmark on a 2-socket x86-64 test machine for 15s,
it was found that the locking rate was reduced to about 30% of that
before the patch - 584,091 op/s vs. 171,184 ops/s.  The total number
of lock stealings within the testing period was reduced to less than 1%
of that before the patch - 4,252,147 vs 17,939 [1].

To restore the lost performance, this patch restores the old write lock
slow path behavior of acquiring the lock after the waiter has been woken
up with the exception that lock transfer may happen in the wakeup path
if the HANDOFF bit has been set. In addition, the waiter that sets the
HANDOFF bit will still try to spin on the lock owner if it is on cpu.

With this patch, the locking rate is now back up to 580,256 ops/s which
is almost the same as before.

[1] https://lore.kernel.org/lkml/c126f079-88a2-4067-6f94-82f51cf5ff2b@redhat.com
/

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 7bd26e64827a..cf9dc1e250e0 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -426,6 +426,7 @@ rwsem_waiter_wake(struct rwsem_waiter *waiter, struct wake_q_head *wake_q)
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 					struct rwsem_waiter *waiter)
 {
+	bool first = (rwsem_first_waiter(sem) == waiter);
 	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
@@ -434,6 +435,9 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	do {
 		new = count;
 
+		if (!first && (count & (RWSEM_FLAG_HANDOFF | RWSEM_LOCK_MASK)))
+			return false;
+
 		if (count & RWSEM_LOCK_MASK) {
 			/*
 			 * A waiter (first or not) can set the handoff bit
@@ -501,11 +505,18 @@ static void rwsem_writer_wake(struct rw_semaphore *sem,
 		 */
 		list_del(&waiter->list);
 		atomic_long_set(&sem->owner, (long)waiter->task);
-
-	} else if (!rwsem_try_write_lock(sem, waiter))
+		rwsem_waiter_wake(waiter, wake_q);
 		return;
+	}
 
-	rwsem_waiter_wake(waiter, wake_q);
+	/*
+	 * Mark writer at the front of the queue for wakeup.
+	 * Until the task is actually awoken later by the caller, other
+	 * writers are able to steal it. Readers, on the other hand, will
+	 * block as they will notice the queued writer.
+	 */
+	wake_q_add(wake_q, waiter->task);
+	lockevent_inc(rwsem_wake_writer);
 }
 
 static void rwsem_reader_wake(struct rw_semaphore *sem,
@@ -1038,6 +1049,23 @@ rwsem_waiter_wait(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
 			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
 			break;
 		}
+		if (!reader) {
+			/*
+			 * Writer still needs to do a trylock here
+			 */
+			raw_spin_lock_irq(&sem->wait_lock);
+			if (waiter->task && rwsem_try_write_lock(sem, waiter))
+				waiter->task = NULL;
+			raw_spin_unlock_irq(&sem->wait_lock);
+			if (!smp_load_acquire(&waiter->task))
+				break;
+
+			if (waiter->handoff_set) {
+				rwsem_spin_on_owner(sem);
+				if (!smp_load_acquire(&waiter->task))
+					break;
+			}
+		}
 		if (signal_pending_state(state, current)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (waiter->task)
-- 
2.31.1

