Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823396CAFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjC0U0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjC0UZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A43ABD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679948667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKqJMijs13Jukpid8KMMuGMpFDV4xKY3d7eMa9951QU=;
        b=CnHnHRnyr6Z8V+8gidl0UnwYDvhNfbSfmeacSWVy00QUWxGHGCk1J56XSwbHQ1IrxyeTp+
        SC1sipXSgBVFe+KKkE8Pe4zz50zCDBRVOG9Rl3mt9pTuqT7OxtGxKeMnR1x/fd1zVjeAJ4
        ZBQ3j/mhGaGFHpqCELkSl3sAOyka4P4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-uW3x49_LPuSP5n5_MrxFaw-1; Mon, 27 Mar 2023 16:24:24 -0400
X-MC-Unique: uW3x49_LPuSP5n5_MrxFaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E156185A588;
        Mon, 27 Mar 2023 20:24:23 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D2712027040;
        Mon, 27 Mar 2023 20:24:23 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/8] locking/rwsem: Simplify rwsem_writer_wake()
Date:   Mon, 27 Mar 2023 16:24:09 -0400
Message-Id: <20230327202413.1955856-5-longman@redhat.com>
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

From: Peter Zijlstra <peterz@infradead.org>

Since @waiter := rwsem_first_waiter() simplify things.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 0cc0aa566a6b..225e86326ea4 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -426,26 +426,12 @@ rwsem_waiter_wake(struct rwsem_waiter *waiter, struct wake_q_head *wake_q)
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 					struct rwsem_waiter *waiter)
 {
-
-	struct rwsem_waiter *first = rwsem_first_waiter(sem);
 	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
 
 	count = atomic_long_read(&sem->count);
 	do {
-		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
-
-		if (has_handoff) {
-			/*
-			 * Honor handoff bit and yield only when the first
-			 * waiter is the one that set it. Otherwisee, we
-			 * still try to acquire the rwsem.
-			 */
-			if (first->handoff_set && (waiter != first))
-				return false;
-		}
-
 		new = count;
 
 		if (count & RWSEM_LOCK_MASK) {
@@ -454,8 +440,9 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 			 * if it is an RT task or wait in the wait queue
 			 * for too long.
 			 */
-			if (has_handoff || (!rt_task(waiter->task) &&
-					    !time_after(jiffies, waiter->timeout)))
+			if ((count & RWSEM_FLAG_HANDOFF) ||
+			    (!rt_task(waiter->task) &&
+			     !time_after(jiffies, waiter->timeout)))
 				return false;
 
 			new |= RWSEM_FLAG_HANDOFF;
@@ -474,7 +461,7 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	 * set here to enable optimistic spinning in slowpath loop.
 	 */
 	if (new & RWSEM_FLAG_HANDOFF) {
-		first->handoff_set = true;
+		waiter->handoff_set = true;
 		lockevent_inc(rwsem_wlock_handoff);
 		return false;
 	}
-- 
2.31.1

