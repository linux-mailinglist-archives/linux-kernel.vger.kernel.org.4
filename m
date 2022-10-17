Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12BD601B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJQVPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJQVOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8447B12AF0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666041280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FOjkxhhELa1U9D/ByzteSY8pSFjeQrEmDncUbTIS7+c=;
        b=A5M3h+0EGbEnjr+QC5kiWmCuJlld+7OKwkyoooYOHgIAPMjCuX5bmFH5YTVRfK8p3YTV93
        /zcbicelfkI0PrsYNVYfBgkP1ufmYc2GO5CbuTN5TxvQ+NmuqcJNPChXktCToc9wLdi1DZ
        n3/FjHDpppJhrvydl80UG9ERlACUo38=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-7Iole4m3PgibqziWY8sfPQ-1; Mon, 17 Oct 2022 17:14:36 -0400
X-MC-Unique: 7Iole4m3PgibqziWY8sfPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41BFE29AA2F0;
        Mon, 17 Oct 2022 21:14:36 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3AAD40C206B;
        Mon, 17 Oct 2022 21:14:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 1/5] locking/rwsem: Prevent non-first waiter from spinning in down_write() slowpath
Date:   Mon, 17 Oct 2022 17:13:52 -0400
Message-Id: <20221017211356.333862-2-longman@redhat.com>
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
Reviewed-and-tested-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 44873594de03..be2df9ea7c30 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -624,18 +624,16 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 			 */
 			if (first->handoff_set && (waiter != first))
 				return false;
-
-			/*
-			 * First waiter can inherit a previously set handoff
-			 * bit and spin on rwsem if lock acquisition fails.
-			 */
-			if (waiter == first)
-				waiter->handoff_set = true;
 		}
 
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
@@ -651,11 +649,12 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
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
+		first->handoff_set = true;
 		lockevent_inc(rwsem_wlock_handoff);
 		return false;
 	}
-- 
2.31.1

