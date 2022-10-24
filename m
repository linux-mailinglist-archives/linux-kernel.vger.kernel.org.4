Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E405760B7B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiJXTan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiJXT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91D6B5FF0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666634341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XFNqhe/9TyVt9WobmDUsN79a+94gmZaId1xsUvIpII=;
        b=VOS48z8PIvfgSnGvEuhWrINbbG60figtq7oLWt95Vy6onN9oZeNAOMTts5GuyoNXJ2OHm/
        A+yaq1XtK8hZmUW1pgPl5Vf8a5IU6nyRPl8+/Jqe6yEmcw5D8IKup4ZKceqmLWvIoJ/0V0
        HQiPPcYmCsLYUPa8o4KJ9IIFx9Ra32M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-k9qH5hQlNIiEGiRqsutV4A-1; Mon, 24 Oct 2022 13:44:52 -0400
X-MC-Unique: k9qH5hQlNIiEGiRqsutV4A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37353803D4B;
        Mon, 24 Oct 2022 17:44:51 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6073492B0F;
        Mon, 24 Oct 2022 17:44:50 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v4 3/5] locking/rwsem: Change waiter->hanodff_set to a handoff_state enum
Date:   Mon, 24 Oct 2022 13:44:16 -0400
Message-Id: <20221024174418.796468-4-longman@redhat.com>
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

Change the boolean waiter->handoff_set to an enum type so that we can
have more states in some later patches. Also use READ_ONCE() outside
wait_lock critical sections for read and WRITE_ONCE() inside wait_lock
critical sections for write for proper synchronization. There is no
functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c68d76fc8c68..a8bfc905637a 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -338,12 +338,17 @@ enum rwsem_waiter_type {
 	RWSEM_WAITING_FOR_READ
 };
 
+enum rwsem_handoff_state {
+	HANDOFF_NONE = 0,
+	HANDOFF_REQUESTED,
+};
+
 struct rwsem_waiter {
 	struct list_head list;
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
+	enum rwsem_handoff_state handoff_state;
 	unsigned long timeout;
-	bool handoff_set;
 };
 #define rwsem_first_waiter(sem) \
 	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
@@ -470,7 +475,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 					adjustment -= RWSEM_FLAG_HANDOFF;
 					lockevent_inc(rwsem_rlock_handoff);
 				}
-				waiter->handoff_set = true;
+				WRITE_ONCE(waiter->handoff_state, HANDOFF_REQUESTED);
 			}
 
 			atomic_long_add(-adjustment, &sem->count);
@@ -622,7 +627,7 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 			 * waiter is the one that set it. Otherwisee, we
 			 * still try to acquire the rwsem.
 			 */
-			if (first->handoff_set && (waiter != first))
+			if (first->handoff_state && (waiter != first))
 				return false;
 		}
 
@@ -650,11 +655,11 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 
 	/*
 	 * We have either acquired the lock with handoff bit cleared or set
-	 * the handoff bit. Only the first waiter can have its handoff_set
+	 * the handoff bit. Only the first waiter can have its handoff_state
 	 * set here to enable optimistic spinning in slowpath loop.
 	 */
 	if (new & RWSEM_FLAG_HANDOFF) {
-		first->handoff_set = true;
+		WRITE_ONCE(first->handoff_state, HANDOFF_REQUESTED);
 		lockevent_inc(rwsem_wlock_handoff);
 		return false;
 	}
@@ -1043,7 +1048,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_READ;
 	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
-	waiter.handoff_set = false;
+	waiter.handoff_state = HANDOFF_NONE;
 
 	raw_spin_lock_irq(&sem->wait_lock);
 	if (list_empty(&sem->wait_list)) {
@@ -1131,7 +1136,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_WRITE;
 	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
-	waiter.handoff_set = false;
+	waiter.handoff_state = HANDOFF_NONE;
 
 	raw_spin_lock_irq(&sem->wait_lock);
 	rwsem_add_waiter(sem, &waiter);
@@ -1176,7 +1181,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		 * In this case, we attempt to acquire the lock again
 		 * without sleeping.
 		 */
-		if (waiter.handoff_set) {
+		if (READ_ONCE(waiter.handoff_state)) {
 			enum owner_state owner_state;
 
 			preempt_disable();
-- 
2.31.1

