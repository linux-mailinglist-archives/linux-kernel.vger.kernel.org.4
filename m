Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C8B649181
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 00:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLJXC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 18:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiLJXCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 18:02:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4750113EA9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 15:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670713268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzoClKiMxtjbfNJAceE2aMmNjTXvJrAUZ+qD1O1iqNQ=;
        b=WDJE+v+pr8Oy1izFLdljUKGvyW1ggWqeaLb3WbcuSYWK6qI4vULSgx5QZq+VTmAT5Pnll4
        0v+x/LbjGSKzmAnaMSlML8Pk50xUUlUb61koWM3gy8z20bJz7/CNOCvNVqQKi7U54HrL9N
        0V6bdfJb/IFeZhkhEUvlSc+nWvTJajk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-16NgXCebOAiorSWx2Dnadw-1; Sat, 10 Dec 2022 18:01:05 -0500
X-MC-Unique: 16NgXCebOAiorSWx2Dnadw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FFCE8032FB;
        Sat, 10 Dec 2022 23:01:04 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D4BD40C6EC2;
        Sat, 10 Dec 2022 23:01:04 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] mm/kmemleak: Fix UAF bug in kmemleak_scan()
Date:   Sat, 10 Dec 2022 18:00:48 -0500
Message-Id: <20221210230048.2841047-3-longman@redhat.com>
In-Reply-To: <20221210230048.2841047-1-longman@redhat.com>
References: <20221210230048.2841047-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first
object iteration loop of kmemleak_scan()") fixes soft lockup problem
in kmemleak_scan() by periodically doing a cond_resched(). It does
take a reference of the current object before doing it. Unfortunately,
if the object has been deleted from the object_list, the next object
pointed to by its next pointer may no longer be valid after coming
back from cond_resched(). This can result in use-after-free and other
nasty problem.

Fix this problem by restarting the object scan from the beginning of
the object_list in case the object has been de-allocated after returning
from cond_resched().

Fixes: 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first object iteration loop of kmemleak_scan()")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kmemleak.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 8c44f70ed457..d3a8fa4e3af3 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1465,15 +1465,26 @@ static void scan_gray_list(void)
  * that the given object won't go away without RCU read lock by performing a
  * get_object() if necessaary.
  */
-static void kmemleak_cond_resched(struct kmemleak_object *object)
+static void kmemleak_cond_resched(struct kmemleak_object **pobject)
 {
-	if (!get_object(object))
+	struct kmemleak_object *obj = *pobject;
+
+	if (!(obj->flags & OBJECT_ALLOCATED) || !get_object(obj))
 		return;	/* Try next object */
 
 	rcu_read_unlock();
 	cond_resched();
 	rcu_read_lock();
-	put_object(object);
+	put_object(obj);
+
+	/*
+	 * In the unlikely event that the object had been de-allocated, we
+	 * have to restart the scanning from the beginning of the object_list
+	 * as the object pointed to by the next pointer may have been freed.
+	 */
+	if (unlikely(!(obj->flags & OBJECT_ALLOCATED)))
+		*pobject = list_entry_rcu(object_list.next,
+					  typeof(*obj), object_list);
 }
 
 /*
@@ -1524,7 +1535,7 @@ static void kmemleak_scan(void)
 		raw_spin_unlock_irq(&object->lock);
 
 		if (need_resched())
-			kmemleak_cond_resched(object);
+			kmemleak_cond_resched(&object);
 	}
 	rcu_read_unlock();
 
@@ -1593,7 +1604,7 @@ static void kmemleak_scan(void)
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
 		if (need_resched())
-			kmemleak_cond_resched(object);
+			kmemleak_cond_resched(&object);
 
 		/*
 		 * This is racy but we can save the overhead of lock/unlock
@@ -1630,7 +1641,7 @@ static void kmemleak_scan(void)
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
 		if (need_resched())
-			kmemleak_cond_resched(object);
+			kmemleak_cond_resched(&object);
 
 		/*
 		 * This is racy but we can save the overhead of lock/unlock
-- 
2.31.1

