Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F7A67C1DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbjAZAie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjAZAiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5276A5AB7E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674693456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7FgnhlbaAs6E7+0zgDhgOJtIcO5/Rx7pYlSdMteD5sc=;
        b=IUmkumqxm5UzutlZ5BBpOxX1LvxISehrEoKI1RZpYWwKMIFv3ja+LGkG07lHTyxvhXqX9I
        y70Cj5aa7fF08Cnr5rS0g9FM5keXhYHwnl9djOXUoTpKxgctez8NgenXt5FsY0ApKPJXPY
        sjEz716hDy5QUk6X9wzLEpt5Rb0Pkko=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-NM9vHwU0NyCcWhkuIaPF6Q-1; Wed, 25 Jan 2023 19:37:31 -0500
X-MC-Unique: NM9vHwU0NyCcWhkuIaPF6Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 057B21C05AF5;
        Thu, 26 Jan 2023 00:37:31 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 909A6492C14;
        Thu, 26 Jan 2023 00:37:30 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v7 2/4] locking/rwsem: Disable preemption at all down_read*() and up_read() code paths
Date:   Wed, 25 Jan 2023 19:36:26 -0500
Message-Id: <20230126003628.365092-3-longman@redhat.com>
In-Reply-To: <20230126003628.365092-1-longman@redhat.com>
References: <20230126003628.365092-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
the lock will become free soon. Commit 48dfb5d2560d ("locking/rwsem:
Disable preemption while trying for rwsem lock") disables preemption
when acquiring rwsem for write. However, preemption has not yet been
disabled when acquiring a read lock on a rwsem. So a reader can add a
RWSEM_READER_BIAS to count without setting owner to signal a reader,
got preempted out by a RT task which then spins in the writer slowpath
as owner remains NULL leading to live lock.

One easy way to fix this problem is to disable preemption at all the
down_read*() and up_read() code paths as implemented in this patch.

Fixes: 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically spin on owner")
Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index be2df9ea7c30..84d5b649b95f 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1091,7 +1091,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
 			break;
 		}
-		schedule();
+		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_reader);
 	}
 
@@ -1253,14 +1253,20 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 static inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
+	int ret = 0;
 	long count;
 
+	preempt_disable();
 	if (!rwsem_read_trylock(sem, &count)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, count, state)))
-			return -EINTR;
+		if (IS_ERR(rwsem_down_read_slowpath(sem, count, state))) {
+			ret = -EINTR;
+			goto out;
+		}
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	}
-	return 0;
+out:
+	preempt_enable();
+	return ret;
 }
 
 static inline void __down_read(struct rw_semaphore *sem)
@@ -1280,19 +1286,23 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 
 static inline int __down_read_trylock(struct rw_semaphore *sem)
 {
+	int ret = 0;
 	long tmp;
 
 	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
 
+	preempt_disable();
 	tmp = atomic_long_read(&sem->count);
 	while (!(tmp & RWSEM_READ_FAILED_MASK)) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 						    tmp + RWSEM_READER_BIAS)) {
 			rwsem_set_reader_owned(sem);
-			return 1;
+			ret = 1;
+			break;
 		}
 	}
-	return 0;
+	preempt_enable();
+	return ret;
 }
 
 /*
@@ -1334,6 +1344,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 
+	preempt_disable();
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
@@ -1342,6 +1353,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 		clear_nonspinnable(sem);
 		rwsem_wake(sem);
 	}
+	preempt_enable();
 }
 
 /*
@@ -1661,6 +1673,12 @@ void down_read_non_owner(struct rw_semaphore *sem)
 {
 	might_sleep();
 	__down_read(sem);
+	/*
+	 * The owner value for a reader-owned lock is mostly for debugging
+	 * purpose only and is not critical to the correct functioning of
+	 * rwsem. So it is perfectly fine to set it in a preempt-enabled
+	 * context here.
+	 */
 	__rwsem_set_reader_owned(sem, NULL);
 }
 EXPORT_SYMBOL(down_read_non_owner);
-- 
2.31.1

