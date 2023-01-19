Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CDE673077
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjASElR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjASEkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20248457E2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 20:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674102975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eek5YPddR+rdvDYmWL3WCwvTt/kh6fJNelSHfFXusYg=;
        b=d89wGSWqvQEBrDDRsk0a5ELPYCM/db16cQznQOCU00ym9zDzPunXE9ToV9nPrT/CYsS+5W
        LiVhrN1UhgF5YR7Xxrbb3cvks97GxQshleEpLLfrKaDh1fahVCIBauCp3MOD43Q3IK0QfC
        UNK9uY9qDvGPPh0WC6Op5VSY6s/a1VU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-JseQALo8MkyN83fBd0phlQ-1; Wed, 18 Jan 2023 23:01:21 -0500
X-MC-Unique: JseQALo8MkyN83fBd0phlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 657E52A5956F;
        Thu, 19 Jan 2023 04:01:21 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C65751E5;
        Thu, 19 Jan 2023 04:01:21 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [RESEND PATCH v2 2/2] mm/kmemleak: Fix UAF bug in kmemleak_scan()
Date:   Wed, 18 Jan 2023 23:01:11 -0500
Message-Id: <20230119040111.350923-3-longman@redhat.com>
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

Commit 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first
object iteration loop of kmemleak_scan()") fixes soft lockup problem
in kmemleak_scan() by periodically doing a cond_resched(). It does
take a reference of the current object before doing it. Unfortunately,
if the object has been deleted from the object_list, the next object
pointed to by its next pointer may no longer be valid after coming
back from cond_resched(). This can result in use-after-free and other
nasty problem.

Fix this problem by adding a del_state flag into kmemleak_object
structure to synchronize the object deletion process between
kmemleak_cond_resched() and __remove_object() to make sure that the
object remained in the object_list in the duration of the cond_resched()
call.

Fixes: 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first object iteration loop of kmemleak_scan()")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kmemleak.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index e7cb521236bf..0ece170fc9ef 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -13,11 +13,12 @@
  *
  * The following locks and mutexes are used by kmemleak:
  *
- * - kmemleak_lock (raw_spinlock_t): protects the object_list modifications and
- *   accesses to the object_tree_root (or object_phys_tree_root). The
- *   object_list is the main list holding the metadata (struct kmemleak_object)
- *   for the allocated memory blocks. The object_tree_root and object_phys_tree_root
- *   are red black trees used to look-up metadata based on a pointer to the
+ * - kmemleak_lock (raw_spinlock_t): protects the object_list as well as
+ *   del_state modifications and accesses to the object_tree_root (or
+ *   object_phys_tree_root). The object_list is the main list holding the
+ *   metadata (struct kmemleak_object) for the allocated memory blocks.
+ *   The object_tree_root and object_phys_tree_root are red
+ *   black trees used to look-up metadata based on a pointer to the
  *   corresponding memory block. The object_phys_tree_root is for objects
  *   allocated with physical address. The kmemleak_object structures are
  *   added to the object_list and object_tree_root (or object_phys_tree_root)
@@ -147,6 +148,7 @@ struct kmemleak_object {
 	struct rcu_head rcu;		/* object_list lockless traversal */
 	/* object usage count; object freed when use_count == 0 */
 	atomic_t use_count;
+	unsigned int del_state;		/* deletion state */
 	unsigned long pointer;
 	size_t size;
 	/* pass surplus references to this pointer */
@@ -177,6 +179,11 @@ struct kmemleak_object {
 /* flag set for object allocated with physical address */
 #define OBJECT_PHYS		(1 << 4)
 
+/* set when __remove_object() called */
+#define DELSTATE_REMOVED	(1 << 0)
+/* set to temporarily prevent deletion from object_list */
+#define DELSTATE_NO_DELETE	(1 << 1)
+
 #define HEX_PREFIX		"    "
 /* number of bytes to print per line; must be 16 or 32 */
 #define HEX_ROW_SIZE		16
@@ -567,7 +574,9 @@ static void __remove_object(struct kmemleak_object *object)
 	rb_erase(&object->rb_node, object->flags & OBJECT_PHYS ?
 				   &object_phys_tree_root :
 				   &object_tree_root);
-	list_del_rcu(&object->object_list);
+	if (!(object->del_state & DELSTATE_NO_DELETE))
+		list_del_rcu(&object->object_list);
+	object->del_state |= DELSTATE_REMOVED;
 }
 
 /*
@@ -633,6 +642,7 @@ static void __create_object(unsigned long ptr, size_t size,
 	object->count = 0;			/* white color initially */
 	object->jiffies = jiffies;
 	object->checksum = 0;
+	object->del_state = 0;
 
 	/* task information */
 	if (in_hardirq()) {
@@ -1470,9 +1480,22 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
 	if (!get_object(object))
 		return;	/* Try next object */
 
+	raw_spin_lock_irq(&kmemleak_lock);
+	if (object->del_state & DELSTATE_REMOVED)
+		goto unlock_put;	/* Object removed */
+	object->del_state |= DELSTATE_NO_DELETE;
+	raw_spin_unlock_irq(&kmemleak_lock);
+
 	rcu_read_unlock();
 	cond_resched();
 	rcu_read_lock();
+
+	raw_spin_lock_irq(&kmemleak_lock);
+	if (object->del_state & DELSTATE_REMOVED)
+		list_del_rcu(&object->object_list);
+	object->del_state &= ~DELSTATE_NO_DELETE;
+unlock_put:
+	raw_spin_unlock_irq(&kmemleak_lock);
 	put_object(object);
 }
 
-- 
2.31.1

