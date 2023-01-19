Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608F267307B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjASElx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjASElD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:41:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B214955C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 20:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674103023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFRn2G3kICVUTv0CVX/GON7X4LfKNre2jK8Ma2QSF+o=;
        b=e1ae3WS1lV4OMkKeGOBbwcORYIT2vCgoD3h3XApGYO2Y84mcJa0kozIOLX1AWciHhKFQ4M
        J8cIEa6kBc0Y2Vv49nRF+4tpAfESfAu/xP7D105DbEdLJFh4yCzIc6tZdnEvIRzC9DUlQa
        TfD5qNfmL8y0B+Uob25BasUbvwhEOYc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-1DQLsC-QPwm5vFLMtYRjPg-1; Wed, 18 Jan 2023 23:01:21 -0500
X-MC-Unique: 1DQLsC-QPwm5vFLMtYRjPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E2E53814950;
        Thu, 19 Jan 2023 04:01:21 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6CE551E5;
        Thu, 19 Jan 2023 04:01:20 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [RESEND PATCH v2 1/2] mm/kmemleak: Simplify kmemleak_cond_resched() usage
Date:   Wed, 18 Jan 2023 23:01:10 -0500
Message-Id: <20230119040111.350923-2-longman@redhat.com>
In-Reply-To: <20230119040111.350923-1-longman@redhat.com>
References: <20230119040111.350923-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The presence of a pinned argument and the 64k loop count make
kmemleak_cond_resched() a bit more complex to read. The pinned argument
is used only by first kmemleak_scan() loop.

Simplify the usage of kmemleak_cond_resched() by removing the pinned
argument and always do a get_object()/put_object() sequence. In
addition, the 64k loop is removed by using need_resched() to decide if
kmemleak_cond_resched() should be called.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 48 ++++++++++++------------------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 267332904354..e7cb521236bf 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1463,22 +1463,17 @@ static void scan_gray_list(void)
 /*
  * Conditionally call resched() in an object iteration loop while making sure
  * that the given object won't go away without RCU read lock by performing a
- * get_object() if !pinned.
- *
- * Return: false if can't do a cond_resched() due to get_object() failure
- *	   true otherwise
+ * get_object() if necessaary.
  */
-static bool kmemleak_cond_resched(struct kmemleak_object *object, bool pinned)
+static void kmemleak_cond_resched(struct kmemleak_object *object)
 {
-	if (!pinned && !get_object(object))
-		return false;
+	if (!get_object(object))
+		return;	/* Try next object */
 
 	rcu_read_unlock();
 	cond_resched();
 	rcu_read_lock();
-	if (!pinned)
-		put_object(object);
-	return true;
+	put_object(object);
 }
 
 /*
@@ -1492,15 +1487,12 @@ static void kmemleak_scan(void)
 	struct zone *zone;
 	int __maybe_unused i;
 	int new_leaks = 0;
-	int loop_cnt = 0;
 
 	jiffies_last_scan = jiffies;
 
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		bool obj_pinned = false;
-
 		raw_spin_lock_irq(&object->lock);
 #ifdef DEBUG
 		/*
@@ -1526,19 +1518,13 @@ static void kmemleak_scan(void)
 
 		/* reset the reference count (whiten the object) */
 		object->count = 0;
-		if (color_gray(object) && get_object(object)) {
+		if (color_gray(object) && get_object(object))
 			list_add_tail(&object->gray_list, &gray_list);
-			obj_pinned = true;
-		}
 
 		raw_spin_unlock_irq(&object->lock);
 
-		/*
-		 * Do a cond_resched() every 64k objects to avoid soft lockup.
-		 */
-		if (!(++loop_cnt & 0xffff) &&
-		    !kmemleak_cond_resched(object, obj_pinned))
-			loop_cnt--; /* Try again on next object */
+		if (need_resched())
+			kmemleak_cond_resched(object);
 	}
 	rcu_read_unlock();
 
@@ -1605,14 +1591,9 @@ static void kmemleak_scan(void)
 	 * scan and color them gray until the next scan.
 	 */
 	rcu_read_lock();
-	loop_cnt = 0;
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		/*
-		 * Do a cond_resched() every 64k objects to avoid soft lockup.
-		 */
-		if (!(++loop_cnt & 0xffff) &&
-		    !kmemleak_cond_resched(object, false))
-			loop_cnt--;	/* Try again on next object */
+		if (need_resched())
+			kmemleak_cond_resched(object);
 
 		/*
 		 * This is racy but we can save the overhead of lock/unlock
@@ -1647,14 +1628,9 @@ static void kmemleak_scan(void)
 	 * Scanning result reporting.
 	 */
 	rcu_read_lock();
-	loop_cnt = 0;
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		/*
-		 * Do a cond_resched() every 64k objects to avoid soft lockup.
-		 */
-		if (!(++loop_cnt & 0xffff) &&
-		    !kmemleak_cond_resched(object, false))
-			loop_cnt--;	/* Try again on next object */
+		if (need_resched())
+			kmemleak_cond_resched(object);
 
 		/*
 		 * This is racy but we can save the overhead of lock/unlock
-- 
2.31.1

