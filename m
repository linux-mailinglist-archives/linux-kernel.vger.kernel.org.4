Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21B5618782
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiKCSbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKCSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283E26448
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667500188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVJQ6hSeE7yu8R15/R64CIrCsSyaWJogCMScfV2fhQc=;
        b=R47aNvhLImD8rsRM02Y5r8kCNbHZH0qY2UGUm4C8pZqIgRDeFvLrDRFwr/FaP7VcDrPnxe
        1ASVD51HLNKNOpdWnd7h2I33k/dvsY2Zu366BDH6lSA3+DbbxqFr4B1Ib8ur9T3YAyS7+T
        eSDXpPFyscHymqt9ivmhJoOnAmcDhXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-sI_NjxXbN56K98bwbs_pWQ-1; Thu, 03 Nov 2022 14:29:46 -0400
X-MC-Unique: sI_NjxXbN56K98bwbs_pWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57683858F13;
        Thu,  3 Nov 2022 18:29:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA05A1121325;
        Thu,  3 Nov 2022 18:29:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v5 2/6] locking/rwsem: Disable preemption at all down_read*() and up_read() code paths
Date:   Thu,  3 Nov 2022 14:29:32 -0400
Message-Id: <20221103182936.217120-3-longman@redhat.com>
In-Reply-To: <20221103182936.217120-1-longman@redhat.com>
References: <20221103182936.217120-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 kernel/locking/rwsem.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index be2df9ea7c30..ebaff8a87e1d 100644
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
-- 
2.31.1

