Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEAC601B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJQVO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiJQVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E053115A11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666041280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ELOXUp+yBwsB57Mhpd3zpRxtPtGhdnF8W6vkkIQT1w=;
        b=iQat6eItQC468daxI9mFTRkb5xSl6yAHaQ2+bnJSiMXNuFwJLuMl7e6HDZiQAZNxqisD/f
        LWerrIV7bh4C/nuUUnk6+TTyGz3/3kydEYdPFwcSOg6ySVNn1u/cuZS6sUyBY8N+nLk7HN
        KGkYqWxeV5Dl56hxsqQmQdpHM9lPukI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-o2yZrGTSN0m2IO1NOahIbA-1; Mon, 17 Oct 2022 17:14:37 -0400
X-MC-Unique: o2yZrGTSN0m2IO1NOahIbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD3FA101A528;
        Mon, 17 Oct 2022 21:14:36 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D66740C206B;
        Mon, 17 Oct 2022 21:14:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 2/5] locking/rwsem: Limit # of null owner retries for handoff writer
Date:   Mon, 17 Oct 2022 17:13:53 -0400
Message-Id: <20221017211356.333862-3-longman@redhat.com>
In-Reply-To: <20221017211356.333862-1-longman@redhat.com>
References: <20221017211356.333862-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically
spin on owner") assumes that when the owner field is changed to NULL,
the lock will become free soon.  That assumption may not be correct
especially if the handoff writer doing the spinning is a RT task which
may preempt another task from completing its action of either freeing
the rwsem or properly setting up owner.

To prevent this live lock scenario, we have to limit the number of
trylock attempts without sleeping. The current limit is now set to 8
to allow enough time for the other task to hopefully complete its action.

By adding new lock events to track the number of NULL owner retries with
handoff flag set before a successful trylock when running a 96 threads
locking microbenchmark with equal number of readers and writers running
on a 2-core 96-thread system for 15 seconds, the following stats are
obtained. Note that none of locking threads are RT tasks.

  Retries of successful trylock    Count
  -----------------------------    -----
             1                     1738
             2                       19
             3                       11
             4                        2
             5                        1
             6                        1
             7                        1
             8                        0
             X                        1

The last row is the one failed attempt that needs more than 8 retries.
So a retry count maximum of 8 should capture most of them if no RT task
is in the mix.

Fixes: 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically spin on owner")
Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-and-tested-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 kernel/locking/rwsem.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index be2df9ea7c30..c68d76fc8c68 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1115,6 +1115,7 @@ static struct rw_semaphore __sched *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	struct rwsem_waiter waiter;
+	int null_owner_retries;
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
@@ -1156,7 +1157,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	set_current_state(state);
 	trace_contention_begin(sem, LCB_F_WRITE);
 
-	for (;;) {
+	for (null_owner_retries = 0;;) {
 		if (rwsem_try_write_lock(sem, &waiter)) {
 			/* rwsem_try_write_lock() implies ACQUIRE on success */
 			break;
@@ -1182,8 +1183,21 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 			owner_state = rwsem_spin_on_owner(sem);
 			preempt_enable();
 
-			if (owner_state == OWNER_NULL)
+			/*
+			 * owner is NULL doesn't guarantee the lock is free.
+			 * An incoming reader will temporarily increment the
+			 * reader count without changing owner and the
+			 * rwsem_try_write_lock() will fails if the reader
+			 * is not able to decrement it in time. Allow 8
+			 * trylock attempts when hitting a NULL owner before
+			 * going to sleep.
+			 */
+			if ((owner_state == OWNER_NULL) &&
+			    (null_owner_retries < 8)) {
+				null_owner_retries++;
 				goto trylock_again;
+			}
+			null_owner_retries = 0;
 		}
 
 		schedule();
-- 
2.31.1

