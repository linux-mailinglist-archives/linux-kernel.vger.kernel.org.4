Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E3F65E153
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjAEAKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbjAEAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0570B43A30;
        Wed,  4 Jan 2023 16:09:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92951B81986;
        Thu,  5 Jan 2023 00:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7E8C43392;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=isoqPsWCBoxvya3XBG1XQQhxkGdrk+wCUjPVtX+gzXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFreSwbNJSbKqmLpsZzxoF5Ds/4w0toLRX7JzauJIPSeOFRSk9YrhYOafx6lfw26T
         Lhc/NYW+a1yz9S+AwjRdG5OIHbc/A3W5oowXWdrv15kBE0P7QGyhIs9vchGiFkO8db
         a9xRRLURF4aiFfnGYA5GZzRatkitmPPjn+FojoANVMUuFhlxf9UMryvr6nzgBwoRza
         uXUtsahWe7tdLN1zI2GqzKax19BRZ45qLsqrmMBda4bGgx8vyybkaCOICykR6+2vVr
         BT/kb4yWqsZlc4A5bsYh9Vkyzg0tCqoUTcuPLwU4B/mgfbPkAzHY2f1FqkxBjJsBGl
         diMHdQA3RxRnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CBC1A5C149B; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/15] doc: Update and wordsmith rculist_nulls.rst
Date:   Wed,  4 Jan 2023 16:09:45 -0800
Message-Id: <20230105000955.1767218-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do some wordsmithing and breaking up of RCU readers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 109 ++++++++++++++--------------
 1 file changed, 54 insertions(+), 55 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index ca4692775ad41..f84d6970758bc 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -14,19 +14,19 @@ Using 'nulls'
 =============
 
 Using special makers (called 'nulls') is a convenient way
-to solve following problem :
+to solve following problem.
 
-A typical RCU linked list managing objects which are
-allocated with SLAB_TYPESAFE_BY_RCU kmem_cache can
-use following algos :
+Without 'nulls', a typical RCU linked list managing objects which are
+allocated with SLAB_TYPESAFE_BY_RCU kmem_cache can use the following
+algorithms:
 
-1) Lookup algo
---------------
+1) Lookup algorithm
+-------------------
 
 ::
 
-  rcu_read_lock()
   begin:
+  rcu_read_lock()
   obj = lockless_lookup(key);
   if (obj) {
     if (!try_get_ref(obj)) // might fail for free objects
@@ -38,6 +38,7 @@ use following algos :
     */
     if (obj->key != key) { // not the object we expected
       put_ref(obj);
+      rcu_read_unlock();
       goto begin;
     }
   }
@@ -52,9 +53,9 @@ but a version with an additional memory barrier (smp_rmb())
   {
     struct hlist_node *node, *next;
     for (pos = rcu_dereference((head)->first);
-        pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
-        ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
-        pos = rcu_dereference(next))
+         pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
+         ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
+         pos = rcu_dereference(next))
       if (obj->key == key)
         return obj;
     return NULL;
@@ -64,9 +65,9 @@ And note the traditional hlist_for_each_entry_rcu() misses this smp_rmb()::
 
   struct hlist_node *node;
   for (pos = rcu_dereference((head)->first);
-        pos && ({ prefetch(pos->next); 1; }) &&
-        ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
-        pos = rcu_dereference(pos->next))
+       pos && ({ prefetch(pos->next); 1; }) &&
+       ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
+       pos = rcu_dereference(pos->next))
    if (obj->key == key)
      return obj;
   return NULL;
@@ -82,36 +83,32 @@ Quoting Corey Minyard::
   solved by pre-fetching the "next" field (with proper barriers) before
   checking the key."
 
-2) Insert algo
---------------
+2) Insertion algorithm
+----------------------
 
 We need to make sure a reader cannot read the new 'obj->obj_next' value
-and previous value of 'obj->key'. Or else, an item could be deleted
+and previous value of 'obj->key'. Otherwise, an item could be deleted
 from a chain, and inserted into another chain. If new chain was empty
-before the move, 'next' pointer is NULL, and lockless reader can
-not detect it missed following items in original chain.
+before the move, 'next' pointer is NULL, and lockless reader can not
+detect the fact that it missed following items in original chain.
 
 ::
 
   /*
-  * Please note that new inserts are done at the head of list,
-  * not in the middle or end.
-  */
+   * Please note that new inserts are done at the head of list,
+   * not in the middle or end.
+   */
   obj = kmem_cache_alloc(...);
   lock_chain(); // typically a spin_lock()
   obj->key = key;
-  /*
-  * we need to make sure obj->key is updated before obj->next
-  * or obj->refcnt
-  */
-  smp_wmb();
-  atomic_set(&obj->refcnt, 1);
+  atomic_set_release(&obj->refcnt, 1); // key before refcnt
   hlist_add_head_rcu(&obj->obj_node, list);
   unlock_chain(); // typically a spin_unlock()
 
 
-3) Remove algo
---------------
+3) Removal algorithm
+--------------------
+
 Nothing special here, we can use a standard RCU hlist deletion.
 But thanks to SLAB_TYPESAFE_BY_RCU, beware a deleted object can be reused
 very very fast (before the end of RCU grace period)
@@ -133,7 +130,7 @@ Avoiding extra smp_rmb()
 ========================
 
 With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup()
-and extra smp_wmb() in insert function.
+and extra _release() in insert function.
 
 For example, if we choose to store the slot number as the 'nulls'
 end-of-list marker for each slot of the hash table, we can detect
@@ -142,59 +139,61 @@ to another chain) checking the final 'nulls' value if
 the lookup met the end of chain. If final 'nulls' value
 is not the slot number, then we must restart the lookup at
 the beginning. If the object was moved to the same chain,
-then the reader doesn't care : It might eventually
+then the reader doesn't care: It might occasionally
 scan the list again without harm.
 
 
-1) lookup algo
---------------
+1) lookup algorithm
+-------------------
 
 ::
 
   head = &table[slot];
-  rcu_read_lock();
   begin:
+  rcu_read_lock();
   hlist_nulls_for_each_entry_rcu(obj, node, head, member) {
     if (obj->key == key) {
-      if (!try_get_ref(obj)) // might fail for free objects
+      if (!try_get_ref(obj)) { // might fail for free objects
+	rcu_read_unlock();
         goto begin;
+      }
       if (obj->key != key) { // not the object we expected
         put_ref(obj);
+	rcu_read_unlock();
         goto begin;
       }
-    goto out;
+      goto out;
+    }
+  }
+  
+  // If the nulls value we got at the end of this lookup is
+  // not the expected one, we must restart lookup.
+  // We probably met an item that was moved to another chain.
+  if (get_nulls_value(node) != slot) {
+    put_ref(obj);
+    rcu_read_unlock();
+    goto begin;
   }
-  /*
-  * if the nulls value we got at the end of this lookup is
-  * not the expected one, we must restart lookup.
-  * We probably met an item that was moved to another chain.
-  */
-  if (get_nulls_value(node) != slot)
-  goto begin;
   obj = NULL;
 
   out:
   rcu_read_unlock();
 
-2) Insert function
-------------------
+2) Insert algorithm
+-------------------
 
 ::
 
   /*
-  * Please note that new inserts are done at the head of list,
-  * not in the middle or end.
-  */
+   * Please note that new inserts are done at the head of list,
+   * not in the middle or end.
+   */
   obj = kmem_cache_alloc(cachep);
   lock_chain(); // typically a spin_lock()
   obj->key = key;
+  atomic_set_release(&obj->refcnt, 1); // key before refcnt
   /*
-  * changes to obj->key must be visible before refcnt one
-  */
-  smp_wmb();
-  atomic_set(&obj->refcnt, 1);
-  /*
-  * insert obj in RCU way (readers might be traversing chain)
-  */
+   * insert obj in RCU way (readers might be traversing chain)
+   */
   hlist_nulls_add_head_rcu(&obj->obj_node, list);
   unlock_chain(); // typically a spin_unlock()
-- 
2.31.1.189.g2e36527f23

