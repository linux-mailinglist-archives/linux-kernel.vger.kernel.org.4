Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67311733CFF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbjFPXgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbjFPXgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:36:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6303AB8;
        Fri, 16 Jun 2023 16:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA76A62F12;
        Fri, 16 Jun 2023 23:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940BEC433CA;
        Fri, 16 Jun 2023 23:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686958593;
        bh=lBWgs+90Gck3vESACjS/SXnoZhAGTUFxSPAqJdGmdaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ia/JrTVmfO6NJ9ySd38aUtF/rqESYfPNIJAzKeZrON1qg4fubp0SM+oq1uibr+yYp
         oLu7MUKEaUVTJ//Bmrkv2EyBFocI6vbRHHhG9dx9Jhs2/FgmSJC9rmUYaz83TsYZ72
         zApvWG0oRnHFRPrUy8qpQieYJaSaEnvma8sxapHlng01nW7xa58jf+RpMAFtI2LYI2
         Y6R8dRwPcnoTxzqn3R4RnMNAbhgqgusnSk1hVhobDOGKGwI9JEtxBDCWkpRcK+VEHD
         xvBgu0QmlVfOlSG/Hyb2n/VLIwUI+/KjIGZmnoMMFCQ6nz+rv70V6odz/EEW/N6irU
         wmXoZENqEeHDw==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] Docs/RCU/rculist_nulls: Fix hlist_[nulls]_head field names of 'obj'
Date:   Fri, 16 Jun 2023 23:36:25 +0000
Message-Id: <20230616233626.83906-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616233626.83906-1-sj@kernel.org>
References: <20230616233626.83906-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example code snippets on rculist_nulls.rst are assuming 'obj' to
have the 'hlist_head' or 'hlist_nulls_head' field named 'obj_node', but
a sentence and some code snippets are wrongly calling
'obj->obj_node.next' as 'obj->obj_next', or 'obj->obj_node' as 'member'.
Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index a6827cc31791..4afa11f2c906 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -63,7 +63,7 @@ but a version with an additional memory barrier (smp_rmb())
     struct hlist_node *node, *next;
     for (pos = rcu_dereference((head)->first);
          pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
-         ({ obj = hlist_entry(pos, typeof(*obj), member); 1; });
+         ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
          pos = rcu_dereference(next))
       if (obj->key == key)
         return obj;
@@ -75,7 +75,7 @@ And note the traditional hlist_for_each_entry_rcu() misses this smp_rmb()::
   struct hlist_node *node;
   for (pos = rcu_dereference((head)->first);
        pos && ({ prefetch(pos->next); 1; }) &&
-       ({ obj = hlist_entry(pos, typeof(*obj), member); 1; });
+       ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
        pos = rcu_dereference(pos->next))
     if (obj->key == key)
       return obj;
@@ -95,7 +95,7 @@ Quoting Corey Minyard::
 2) Insertion algorithm
 ----------------------
 
-We need to make sure a reader cannot read the new 'obj->obj_next' value
+We need to make sure a reader cannot read the new 'obj->obj_node.next' value
 and previous value of 'obj->key'. Otherwise, an item could be deleted
 from a chain, and inserted into another chain. If new chain was empty
 before the move, 'next' pointer is NULL, and lockless reader can not
@@ -163,7 +163,7 @@ Note that using hlist_nulls means the type of 'obj_node' field of
   head = &table[slot];
   begin:
   rcu_read_lock();
-  hlist_nulls_for_each_entry_rcu(obj, node, head, member) {
+  hlist_nulls_for_each_entry_rcu(obj, node, head, obj_node) {
     if (obj->key == key) {
       if (!try_get_ref(obj)) { // might fail for free objects
 	rcu_read_unlock();
-- 
2.25.1

