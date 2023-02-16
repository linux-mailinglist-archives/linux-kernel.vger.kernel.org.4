Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF19E698BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBPFS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBPFSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:18:40 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7838457D5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:12 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52f233aff21so8594177b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hX1DUaFSHqHCHFWD5Crp9NnpH/+9VHFxYkECoHgya1E=;
        b=ZK5oAM6AcKVtxFxzHW9PhD/PdA0+Kv3bSAspA28+ZPD1m3cnM9poVYSoqhonqkIeJU
         SshDVskllMZgIeSGhnCidLA6ddGXSMxz+S/xoEp08YDrkRg+7RXAXCoS6u4tI7rKulCi
         ggnzbiGToN5cME4XPhcHuI14WBO6+4EQsud/8F6AxE1deunG+n/R+uM3wq+OYW0Yw/xw
         3Mt1GtYUQdIHi9t1kC0vmn2kgnR9+BG6rYf5dtABCjAt9PnVyIFEokbi9zalyZENG7ye
         R6/8svYYK3xPGp282avPu/RfQWQWw9vT/0uQU8vbTuKv0KxRDKx0B9gWO6ClqS6abquo
         +1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hX1DUaFSHqHCHFWD5Crp9NnpH/+9VHFxYkECoHgya1E=;
        b=4lT4jObWMCftKY/lEJ3DG3KxiWu4QIXsWes2ERJUX2WO9NZL+dXBWL5inEStzMehjA
         rP0MLloHtGHaC2aErKnc7NLhHSi72v61YSNJPvjRCoZNT0v+Arv3FB2Qxb+28idxZuh/
         WjsrOCB+Kzwg9MIPKI0G+r3Hmu0h1MRCqHq5XgYTsdoTDnF4R/JP5Bce2b+Ws213CazK
         5xqsgimu2Uj4A79/VHM+qQxsJQoj7pMxgdw+16dLgUvO/mBKeQysOeEFrgUGgGx3yjM/
         kZ03oWFRviYZ+GSAM2W/0FAzdn32uPVVYgnJj5HwoU+0xvpC8etjZ4vLmFSSmf28zRaU
         zkNA==
X-Gm-Message-State: AO0yUKUjDVVwJ2xtn31VeRoIClNGidaPmL/Ys97+B8pDFcdDfJBN8WNV
        JjBJe0o5g5x5oj1EgfosgxY7VeGgRaE=
X-Google-Smtp-Source: AK7set+BUdfWyfJ4CpYtDrI1pKL/2vKMY8TRPzm0GzgZQonEWMOroSKkOakotgIDyZRMjNiR+HE0zfFqp3Q=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a05:6902:4ea:b0:926:d02a:c18a with SMTP id
 w10-20020a05690204ea00b00926d02ac18amr43355ybs.233.1676524691938; Wed, 15 Feb
 2023 21:18:11 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:22 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-8-surenb@google.com>
Subject: [PATCH v3 07/35] maple_tree: Add RCU lock checking to rcu callback functions
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Dereferencing RCU objects within the RCU callback without the RCU check
has caused lockdep to complain.  Fix the RCU dereferencing by using the
RCU callback lock to ensure the operation is safe.

Also stop creating a new lock to use for dereferencing during
destruction of the tree or subtree.  Instead, pass through a pointer to
the tree that has the lock that is held for RCU dereferencing checking.
It also does not make sense to use the maple state in the freeing
scenario as the tree walk is a special case where the tree no longer has
the normal encodings and parent pointers.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Reported-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 188 ++++++++++++++++++++++++-----------------------
 1 file changed, 96 insertions(+), 92 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8ad2d1669fad..2be86368237d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -824,6 +824,11 @@ static inline void *mt_slot(const struct maple_tree *mt,
 	return rcu_dereference_check(slots[offset], mt_locked(mt));
 }
 
+static inline void *mt_slot_locked(struct maple_tree *mt, void __rcu **slots,
+				   unsigned char offset)
+{
+	return rcu_dereference_protected(slots[offset], mt_locked(mt));
+}
 /*
  * mas_slot_locked() - Get the slot value when holding the maple tree lock.
  * @mas: The maple state
@@ -835,7 +840,7 @@ static inline void *mt_slot(const struct maple_tree *mt,
 static inline void *mas_slot_locked(struct ma_state *mas, void __rcu **slots,
 				       unsigned char offset)
 {
-	return rcu_dereference_protected(slots[offset], mt_locked(mas->tree));
+	return mt_slot_locked(mas->tree, slots, offset);
 }
 
 /*
@@ -907,34 +912,35 @@ static inline void ma_set_meta(struct maple_node *mn, enum maple_type mt,
 }
 
 /*
- * mas_clear_meta() - clear the metadata information of a node, if it exists
- * @mas: The maple state
+ * mt_clear_meta() - clear the metadata information of a node, if it exists
+ * @mt: The maple tree
  * @mn: The maple node
- * @mt: The maple node type
+ * @type: The maple node type
  * @offset: The offset of the highest sub-gap in this node.
  * @end: The end of the data in this node.
  */
-static inline void mas_clear_meta(struct ma_state *mas, struct maple_node *mn,
-				  enum maple_type mt)
+static inline void mt_clear_meta(struct maple_tree *mt, struct maple_node *mn,
+				  enum maple_type type)
 {
 	struct maple_metadata *meta;
 	unsigned long *pivots;
 	void __rcu **slots;
 	void *next;
 
-	switch (mt) {
+	switch (type) {
 	case maple_range_64:
 		pivots = mn->mr64.pivot;
 		if (unlikely(pivots[MAPLE_RANGE64_SLOTS - 2])) {
 			slots = mn->mr64.slot;
-			next = mas_slot_locked(mas, slots,
-					       MAPLE_RANGE64_SLOTS - 1);
-			if (unlikely((mte_to_node(next) && mte_node_type(next))))
-				return; /* The last slot is a node, no metadata */
+			next = mt_slot_locked(mt, slots,
+					      MAPLE_RANGE64_SLOTS - 1);
+			if (unlikely((mte_to_node(next) &&
+				      mte_node_type(next))))
+				return; /* no metadata, could be node */
 		}
 		fallthrough;
 	case maple_arange_64:
-		meta = ma_meta(mn, mt);
+		meta = ma_meta(mn, type);
 		break;
 	default:
 		return;
@@ -5497,7 +5503,7 @@ static inline int mas_rev_alloc(struct ma_state *mas, unsigned long min,
 }
 
 /*
- * mas_dead_leaves() - Mark all leaves of a node as dead.
+ * mte_dead_leaves() - Mark all leaves of a node as dead.
  * @mas: The maple state
  * @slots: Pointer to the slot array
  * @type: The maple node type
@@ -5507,16 +5513,16 @@ static inline int mas_rev_alloc(struct ma_state *mas, unsigned long min,
  * Return: The number of leaves marked as dead.
  */
 static inline
-unsigned char mas_dead_leaves(struct ma_state *mas, void __rcu **slots,
-			      enum maple_type mt)
+unsigned char mte_dead_leaves(struct maple_enode *enode, struct maple_tree *mt,
+			      void __rcu **slots)
 {
 	struct maple_node *node;
 	enum maple_type type;
 	void *entry;
 	int offset;
 
-	for (offset = 0; offset < mt_slots[mt]; offset++) {
-		entry = mas_slot_locked(mas, slots, offset);
+	for (offset = 0; offset < mt_slot_count(enode); offset++) {
+		entry = mt_slot(mt, slots, offset);
 		type = mte_node_type(entry);
 		node = mte_to_node(entry);
 		/* Use both node and type to catch LE & BE metadata */
@@ -5531,162 +5537,160 @@ unsigned char mas_dead_leaves(struct ma_state *mas, void __rcu **slots,
 	return offset;
 }
 
-static void __rcu **mas_dead_walk(struct ma_state *mas, unsigned char offset)
+/**
+ * mte_dead_walk() - Walk down a dead tree to just before the leaves
+ * @enode: The maple encoded node
+ * @offset: The starting offset
+ *
+ * Note: This can only be used from the RCU callback context.
+ */
+static void __rcu **mte_dead_walk(struct maple_enode **enode, unsigned char offset)
 {
-	struct maple_node *next;
+	struct maple_node *node, *next;
 	void __rcu **slots = NULL;
 
-	next = mas_mn(mas);
+	next = mte_to_node(*enode);
 	do {
-		mas->node = mt_mk_node(next, next->type);
-		slots = ma_slots(next, next->type);
-		next = mas_slot_locked(mas, slots, offset);
+		*enode = ma_enode_ptr(next);
+		node = mte_to_node(*enode);
+		slots = ma_slots(node, node->type);
+		next = rcu_dereference_protected(slots[offset],
+					lock_is_held(&rcu_callback_map));
 		offset = 0;
 	} while (!ma_is_leaf(next->type));
 
 	return slots;
 }
 
+/**
+ * mt_free_walk() - Walk & free a tree in the RCU callback context
+ * @head: The RCU head that's within the node.
+ *
+ * Note: This can only be used from the RCU callback context.
+ */
 static void mt_free_walk(struct rcu_head *head)
 {
 	void __rcu **slots;
 	struct maple_node *node, *start;
-	struct maple_tree mt;
+	struct maple_enode *enode;
 	unsigned char offset;
 	enum maple_type type;
-	MA_STATE(mas, &mt, 0, 0);
 
 	node = container_of(head, struct maple_node, rcu);
 
 	if (ma_is_leaf(node->type))
 		goto free_leaf;
 
-	mt_init_flags(&mt, node->ma_flags);
-	mas_lock(&mas);
 	start = node;
-	mas.node = mt_mk_node(node, node->type);
-	slots = mas_dead_walk(&mas, 0);
-	node = mas_mn(&mas);
+	enode = mt_mk_node(node, node->type);
+	slots = mte_dead_walk(&enode, 0);
+	node = mte_to_node(enode);
 	do {
 		mt_free_bulk(node->slot_len, slots);
 		offset = node->parent_slot + 1;
-		mas.node = node->piv_parent;
-		if (mas_mn(&mas) == node)
-			goto start_slots_free;
-
-		type = mte_node_type(mas.node);
-		slots = ma_slots(mte_to_node(mas.node), type);
-		if ((offset < mt_slots[type]) && (slots[offset]))
-			slots = mas_dead_walk(&mas, offset);
-
-		node = mas_mn(&mas);
+		enode = node->piv_parent;
+		if (mte_to_node(enode) == node)
+			goto free_leaf;
+
+		type = mte_node_type(enode);
+		slots = ma_slots(mte_to_node(enode), type);
+		if ((offset < mt_slots[type]) &&
+		    rcu_dereference_protected(slots[offset],
+					      lock_is_held(&rcu_callback_map)))
+			slots = mte_dead_walk(&enode, offset);
+		node = mte_to_node(enode);
 	} while ((node != start) || (node->slot_len < offset));
 
 	slots = ma_slots(node, node->type);
 	mt_free_bulk(node->slot_len, slots);
 
-start_slots_free:
-	mas_unlock(&mas);
 free_leaf:
 	mt_free_rcu(&node->rcu);
 }
 
-static inline void __rcu **mas_destroy_descend(struct ma_state *mas,
-			struct maple_enode *prev, unsigned char offset)
+static inline void __rcu **mte_destroy_descend(struct maple_enode **enode,
+	struct maple_tree *mt, struct maple_enode *prev, unsigned char offset)
 {
 	struct maple_node *node;
-	struct maple_enode *next = mas->node;
+	struct maple_enode *next = *enode;
 	void __rcu **slots = NULL;
+	enum maple_type type;
+	unsigned char next_offset = 0;
 
 	do {
-		mas->node = next;
-		node = mas_mn(mas);
-		slots = ma_slots(node, mte_node_type(mas->node));
-		next = mas_slot_locked(mas, slots, 0);
-		if ((mte_dead_node(next))) {
-			mte_to_node(next)->type = mte_node_type(next);
-			next = mas_slot_locked(mas, slots, 1);
-		}
+		*enode = next;
+		node = mte_to_node(*enode);
+		type = mte_node_type(*enode);
+		slots = ma_slots(node, type);
+		next = mt_slot_locked(mt, slots, next_offset);
+		if ((mte_dead_node(next)))
+			next = mt_slot_locked(mt, slots, ++next_offset);
 
-		mte_set_node_dead(mas->node);
-		node->type = mte_node_type(mas->node);
-		mas_clear_meta(mas, node, node->type);
+		mte_set_node_dead(*enode);
+		node->type = type;
 		node->piv_parent = prev;
 		node->parent_slot = offset;
-		offset = 0;
-		prev = mas->node;
+		offset = next_offset;
+		next_offset = 0;
+		prev = *enode;
 	} while (!mte_is_leaf(next));
 
 	return slots;
 }
 
-static void mt_destroy_walk(struct maple_enode *enode, unsigned char ma_flags,
+static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 			    bool free)
 {
 	void __rcu **slots;
 	struct maple_node *node = mte_to_node(enode);
 	struct maple_enode *start;
-	struct maple_tree mt;
-
-	MA_STATE(mas, &mt, 0, 0);
 
-	mas.node = enode;
 	if (mte_is_leaf(enode)) {
 		node->type = mte_node_type(enode);
 		goto free_leaf;
 	}
 
-	ma_flags &= ~MT_FLAGS_LOCK_MASK;
-	mt_init_flags(&mt, ma_flags);
-	mas_lock(&mas);
-
-	mte_to_node(enode)->ma_flags = ma_flags;
 	start = enode;
-	slots = mas_destroy_descend(&mas, start, 0);
-	node = mas_mn(&mas);
+	slots = mte_destroy_descend(&enode, mt, start, 0);
+	node = mte_to_node(enode); // Updated in the above call.
 	do {
 		enum maple_type type;
 		unsigned char offset;
 		struct maple_enode *parent, *tmp;
 
-		node->type = mte_node_type(mas.node);
-		node->slot_len = mas_dead_leaves(&mas, slots, node->type);
+		node->slot_len = mte_dead_leaves(enode, mt, slots);
 		if (free)
 			mt_free_bulk(node->slot_len, slots);
 		offset = node->parent_slot + 1;
-		mas.node = node->piv_parent;
-		if (mas_mn(&mas) == node)
-			goto start_slots_free;
+		enode = node->piv_parent;
+		if (mte_to_node(enode) == node)
+			goto free_leaf;
 
-		type = mte_node_type(mas.node);
-		slots = ma_slots(mte_to_node(mas.node), type);
+		type = mte_node_type(enode);
+		slots = ma_slots(mte_to_node(enode), type);
 		if (offset >= mt_slots[type])
 			goto next;
 
-		tmp = mas_slot_locked(&mas, slots, offset);
+		tmp = mt_slot_locked(mt, slots, offset);
 		if (mte_node_type(tmp) && mte_to_node(tmp)) {
-			parent = mas.node;
-			mas.node = tmp;
-			slots = mas_destroy_descend(&mas, parent, offset);
+			parent = enode;
+			enode = tmp;
+			slots = mte_destroy_descend(&enode, mt, parent, offset);
 		}
 next:
-		node = mas_mn(&mas);
-	} while (start != mas.node);
+		node = mte_to_node(enode);
+	} while (start != enode);
 
-	node = mas_mn(&mas);
-	node->type = mte_node_type(mas.node);
-	node->slot_len = mas_dead_leaves(&mas, slots, node->type);
+	node = mte_to_node(enode);
+	node->slot_len = mte_dead_leaves(enode, mt, slots);
 	if (free)
 		mt_free_bulk(node->slot_len, slots);
 
-start_slots_free:
-	mas_unlock(&mas);
-
 free_leaf:
 	if (free)
 		mt_free_rcu(&node->rcu);
 	else
-		mas_clear_meta(&mas, node, node->type);
+		mt_clear_meta(mt, node, node->type);
 }
 
 /*
@@ -5702,10 +5706,10 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 	struct maple_node *node = mte_to_node(enode);
 
 	if (mt_in_rcu(mt)) {
-		mt_destroy_walk(enode, mt->ma_flags, false);
+		mt_destroy_walk(enode, mt, false);
 		call_rcu(&node->rcu, mt_free_walk);
 	} else {
-		mt_destroy_walk(enode, mt->ma_flags, true);
+		mt_destroy_walk(enode, mt, true);
 	}
 }
 
-- 
2.39.1

