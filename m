Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499D8731FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbjFOSKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbjFOSKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:10:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CDD295B;
        Thu, 15 Jun 2023 11:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51D8F61B53;
        Thu, 15 Jun 2023 18:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B7DC433CA;
        Thu, 15 Jun 2023 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686852611;
        bh=LmZp49bujap0FTIZFNAjgmpNWjLBvfyY95sutmfr3+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0z65ADiAyCKOR5m6JF1PbHdbNM4ZmghQ5OQ4yv+XKhkevdpcC/ZohV0VrPfJf9pS
         cpWNYWx/mCgQYAtQvH453C8EsIKCD812AlfSG06/IWxk83+ZcnkP6vOS3WKGxVXeny
         QQ6agvN4Mx5e05DClpoq2uACw7grNLMcKj+ubI1cVCrBOsZ/TF9hioKzc16IelEDws
         1FLeKO+irNBu1zMl0dtL4Re4406jhXNOZrc6XvGx3jTOV1+KaDq3fiVoF67cYDPA+K
         BP9JVFHkq35qBwLCE0DRmkIdanrbxvb5oUkQubgmdnX1VrFzSXJNBbYTW7HGwNZVXQ
         vEcQ4o6XC8kQw==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] Docs/RCU/rculist_nulls: Fix hlist_[nulls]_head field names of 'obj'
Date:   Thu, 15 Jun 2023 18:10:03 +0000
Message-Id: <20230615181004.86850-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615181004.86850-1-sj@kernel.org>
References: <20230615181004.86850-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 4b66e2fd2fb5..a24783ebc5df 100644
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

