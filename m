Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BF96CAFF4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjC0U0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjC0UZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0423C15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679948668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/k5fdQzdPEiui8WNN3fZp6fkCe06zAbO2ZueqkSVSw=;
        b=flPTfa4Ro0wVSBUhjzFpt+HpWiPu4glOt3D+WzGQ0H6TUKRF83mZxRMxlkC+0+9vzoqfQ7
        Uz17Y4+VkXRX7UE4c6WD7aS9vt+Ubf9sG61ivht35rKHdTvCOPa94CRDyRMBzNdNNizrH6
        I3VjA+Pt+S0OjiEMz52aTSPnxwE+Js0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-XnRBMUz4NNubxjrYG_Xr8Q-1; Mon, 27 Mar 2023 16:24:25 -0400
X-MC-Unique: XnRBMUz4NNubxjrYG_Xr8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCFAE101A550;
        Mon, 27 Mar 2023 20:24:24 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 867632027040;
        Mon, 27 Mar 2023 20:24:24 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] locking/rwsem: Use the force
Date:   Mon, 27 Mar 2023 16:24:12 -0400
Message-Id: <20230327202413.1955856-8-longman@redhat.com>
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

Now that the writer adjustment is done from the wakeup side and
HANDOFF guarantees spinning/stealing is disabled, use the combined
guarantee it ignore spurious READER_BIAS and directly claim the lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index ee8861effcc2..7bd26e64827a 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -377,8 +377,8 @@ rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
 /*
  * Remove a waiter from the wait_list and clear flags.
  *
- * Both rwsem_reader_wake() and rwsem_try_write_lock() contain a full 'copy' of
- * this function. Modify with care.
+ * Both rwsem_{reader,writer}_wake() and rwsem_try_write_lock() contain a full
+ * 'copy' of this function. Modify with care.
  *
  * Return: true if wait_list isn't empty and false otherwise
  */
@@ -479,8 +479,33 @@ static void rwsem_writer_wake(struct rw_semaphore *sem,
 			      struct rwsem_waiter *waiter,
 			      struct wake_q_head *wake_q)
 {
-	if (rwsem_try_write_lock(sem, waiter))
-		rwsem_waiter_wake(waiter, wake_q);
+	long count = atomic_long_read(&sem->count);
+
+	/*
+	 * Since rwsem_mark_wake() is only called (with WAKE_ANY) when
+	 * the lock is unlocked, and the HANDOFF bit guarantees that
+	 * all spinning / stealing is disabled, it is posssible to
+	 * unconditionally claim the lock -- any READER_BIAS will be
+	 * temporary.
+	 */
+	if ((count & (RWSEM_FLAG_HANDOFF|RWSEM_WRITER_LOCKED)) == RWSEM_FLAG_HANDOFF) {
+		unsigned long adjustment = RWSEM_WRITER_LOCKED - RWSEM_FLAG_HANDOFF;
+
+		if (list_is_singular(&sem->wait_list))
+			adjustment -= RWSEM_FLAG_WAITERS;
+
+		atomic_long_add(adjustment, &sem->count);
+		/*
+		 * Have rwsem_writer_wake() fully imply rwsem_del_waiter() on
+		 * success.
+		 */
+		list_del(&waiter->list);
+		atomic_long_set(&sem->owner, (long)waiter->task);
+
+	} else if (!rwsem_try_write_lock(sem, waiter))
+		return;
+
+	rwsem_waiter_wake(waiter, wake_q);
 }
 
 static void rwsem_reader_wake(struct rw_semaphore *sem,
-- 
2.31.1

