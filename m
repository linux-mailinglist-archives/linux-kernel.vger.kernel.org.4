Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822675EFC9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiI2SEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiI2SEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311EC5FDC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664474682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UR5Zd9ORHHKbZxsxJNmBhTXsgUFFdrnVVqoQYsLLscc=;
        b=JTH4ZOU2qBfpbN5OFzHSBgNmb6Dy8lM+gHSIkilamd42Y75mFi6foHlT3SUMV6aoQI10Qe
        EEJHDvq/MN4JP7zetVD+r09Y7vVaFGxXQhlrp19EkjobufcImNUVeQyOSt44ZTp+vASjAD
        KuWkVQ5VmV7C3Xe9Y/5jfwY99hgoYO0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-epj_Yl07OUGkYeqK3TfBdA-1; Thu, 29 Sep 2022 14:04:38 -0400
X-MC-Unique: epj_Yl07OUGkYeqK3TfBdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DADD862FDC;
        Thu, 29 Sep 2022 18:04:38 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E050540C6EC2;
        Thu, 29 Sep 2022 18:04:37 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in down_write() slowpath
Date:   Thu, 29 Sep 2022 14:04:13 -0400
Message-Id: <20220929180413.107374-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A non-first waiter can potentially spin in the for loop of
rwsem_down_write_slowpath() without sleeping but fail to acquire the
lock even if the rwsem is free if the following sequence happens:

  Non-first waiter       First waiter      Lock holder
  ----------------       ------------      -----------
  Acquire wait_lock
  rwsem_try_write_lock():
    Set handoff bit if RT or
      wait too long
    Set waiter->handoff_set
  Release wait_lock
                         Acquire wait_lock
                         Inherit waiter->handoff_set
                         Release wait_lock
					   Clear owner
                                           Release lock
  if (waiter.handoff_set) {
    rwsem_spin_on_owner(();
    if (OWNER_NULL)
      goto trylock_again;
  }
  trylock_again:
  Acquire wait_lock
  rwsem_try_write_lock():
     if (first->handoff_set && (waiter != first))
     	return false;
  Release wait_lock

It is especially problematic if the non-first waiter is an RT task and
it is running on the same CPU as the first waiter as this can lead to
live lock.

Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 65f0262f635e..ad676e99e0b3 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -628,6 +628,11 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 		new = count;
 
 		if (count & RWSEM_LOCK_MASK) {
+			/*
+			 * A waiter (first or not) can set the handoff bit
+			 * if it is an RT task or wait in the wait queue
+			 * for too long.
+			 */
 			if (has_handoff || (!rt_task(waiter->task) &&
 					    !time_after(jiffies, waiter->timeout)))
 				return false;
@@ -643,11 +648,13 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
 
 	/*
-	 * We have either acquired the lock with handoff bit cleared or
-	 * set the handoff bit.
+	 * We have either acquired the lock with handoff bit cleared or set
+	 * the handoff bit. Only the first waiter can have its handoff_set
+	 * set here to enable optimistic spinning in slowpath loop.
 	 */
 	if (new & RWSEM_FLAG_HANDOFF) {
-		waiter->handoff_set = true;
+		if (waiter == first)
+			waiter->handoff_set = true;
 		lockevent_inc(rwsem_wlock_handoff);
 		return false;
 	}
-- 
2.31.1

