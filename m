Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A348F6F5EA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjECSzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjECSzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:55:48 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7191
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 11:55:40 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QBR3X6P2kz9scm;
        Wed,  3 May 2023 20:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1683140136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/h8uKJYfAv9R/u9tuEmPh/EOqTPtSMNzjfz8KywnhxA=;
        b=BD4ZKnPWjkMrdic6PbtXSbxXh89icVmktndp6QMtFQ5tjzE9lfAZpCieQ0vkmQAPSl3CNT
        vwtM9kar8DHH7FvLN2XSUS9y5lVKqHwNSaXICUz+1HsxJSEIVe/Cneatsu2ZCVVh6ywtOw
        he4wtoYC9Wp7/eMyHEvg8Y+zUjNfFQ9WRcqRfFueFalvWhCfK/2ZEIItbj96eFK5puayIb
        AvafIfZ0cl4rlDy4QtjOf9Fs1c09u36Kw6EhO/qR+pW5ska4x24iKoyvxYU5nTklQoUUp3
        ESJz3kmfkz0z7IAGz+D+5Qm6Ng8u//FEnL6Cjeq0uXOuFmdYcj3HChfIsxf0fA==
Message-ID: <69917b8c85c1fdc5e23cabee30284e61349aeac0.camel@mailbox.org>
Subject: library: [RFC PATCH 4/4] btree_blue - a simple btree with fast
 linear traverse and more
From:   liuwf <liuwf@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     joern@purestorage.com, torvalds@linux-foundation.org
Date:   Wed, 03 May 2023 14:54:39 -0400
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d38de76d7a01e793dd8
X-MBO-RS-META: jjybmq4y8qczpcjmjiubq9nf464y7iwo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Liu Weifeng 4019c26b5c0d5f6b <liuwf@mailbox.org>


Signed-off-by: Liu Weifeng 4019c26b5c0d5f6b <liuwf@mailbox.org>
---
 lib/btree_blue.c      | 208 ++++++++++++++++++++-------------
 lib/btree_blue_test.c | 264 +++++++++++++++++++++---------------------
 2 files changed, 259 insertions(+), 213 deletions(-)

diff --git a/lib/btree_blue.c b/lib/btree_blue.c
index 62f7baa43044..f22598f36c93 100644
--- a/lib/btree_blue.c
+++ b/lib/btree_blue.c
@@ -136,7 +136,7 @@ static int getpos(struct btree_blue_head *head, struct btree_blue_node_cb *cb,
 	int nr, q, r, i, p, c;
 
 	nr = cb->slots_info.slots_nr;
-	q = nr / 8;
+	q = nr >> 3;
 
 	for (i = 1; i <= q; i++) {
 		p = i * 8 - 1;
@@ -155,8 +155,8 @@ static int getpos(struct btree_blue_head *head, struct btree_blue_node_cb *cb,
 			return p;
 	}
 
-	p = q * 8;
-	r = nr % 8;
+	p = q << 3;
+	r = nr & 7;
 	for (i = 0; i < r; i++) {
 		c = keycmp(head, cb, p, key);
 		if (c <= 0)
@@ -173,7 +173,7 @@ static int geteqv(struct btree_blue_head *head, struct btree_blue_node_cb *cb,
 	int nr, q, r, i, p, c;
 
 	nr = cb->slots_info.slots_nr;
-	q = nr / 8;
+	q = nr >> 3;
 
 	for (i = 1; i <= q; i++) {
 		p = i * 8 - 1;
@@ -191,8 +191,8 @@ static int geteqv(struct btree_blue_head *head, struct btree_blue_node_cb *cb,
 			return p;
 	}
 
-	p = q * 8;
-	r = nr % 8;
+	p = q << 3;
+	r = nr & 7;
 	for (i = 0; i < r; i++) {
 		c = keycmp(head, cb, p, key);
 		if (c == 0)
@@ -305,13 +305,26 @@ static inline void split_to_empty(struct btree_blue_head *head,
 				  struct btree_blue_node_cb *src, int level)
 {
 	int slots_nr = src->slots_info.slots_nr / 2;
+	int nr = src->slots_info.slots_nr - slots_nr;
 
 	_transfer_slots(head, dest, src, 0, 0, slots_nr);
-	dest->slots_info.slots_nr += slots_nr;
+	dest->slots_info.slots_nr = slots_nr;
 
-	_shift_slots(head, src, 0, slots_nr,
-		     src->slots_info.slots_nr - slots_nr);
-	src->slots_info.slots_nr -= slots_nr;
+	_shift_slots(head, src, 0, slots_nr, nr);
+	src->slots_info.slots_nr = nr;
+}
+
+static inline void split_to_empty_lazy(struct btree_blue_head *head,
+				       struct btree_blue_node_cb *dest,
+				       struct btree_blue_node_cb *src,
+				       int level)
+{
+	int slots_nr = src->slots_info.slots_nr / 2;
+	int nr = src->slots_info.slots_nr - slots_nr;
+
+	_transfer_slots(head, dest, src, 0, slots_nr, nr);
+	dest->slots_info.slots_nr = nr;
+	src->slots_info.slots_nr = slots_nr;
 }
 
 static inline void merge_nodes(struct btree_blue_head *head,
@@ -443,11 +456,6 @@ void *btree_blue_prev_or_next(struct btree_blue_head *head,
 
 	slots_nr = node->slots_info.slots_nr;
 	i = geteqv(head, node, key);
-	/*
-	for (i = 0; i < slots_nr; i++)
-		if (keycmp(head, node, i, key) == 0)
-			break;
-	*/
 	if (i == slots_nr)
 		return NULL;
 
@@ -540,11 +548,6 @@ size_t btree_blue_traverse_from_key(struct btree_blue_head *head,
 
 	slots_nr = node->slots_info.slots_nr;
 	i = geteqv(head, node, key);
-	/*
-	for (i = 0; i < slots_nr; i++)
-		if (keycmp(head, node, i, (unsigned long *)key) == 0)
-			break;
-	*/
 	if (i == slots_nr)
 		return total;
 
@@ -612,13 +615,13 @@ EXPORT_SYMBOL_GPL(btree_blue_traverse_from_key);
 
 static unsigned long *find_level(struct btree_blue_head *head,
 				 unsigned long *key, int level,
-				 struct btree_blue_node_cb **cb_p)
+				 struct btree_blue_node_cb **cb_p, int *pos_p)
 {
 	struct btree_blue_node_cb *node =
 		(struct btree_blue_node_cb *)head->node;
 	struct btree_blue_node_cb *node_p = node;
 	int height = head->height;
-	int pos;
+	int pos = -1;
 
 	for (; height > level; height--) {
 		pos = getpos(head, node, key);
@@ -637,6 +640,7 @@ static unsigned long *find_level(struct btree_blue_head *head,
 
 	BUG_ON(!node);
 	*cb_p = node_p;
+	*pos_p = pos;
 	return (unsigned long *)node;
 }
 
@@ -676,8 +680,6 @@ static void btree_blue_shrink(struct btree_blue_head *head)
 	head->node = bval(head, node, 0);
 	btree_blue_node_free((unsigned long *)node, head->height);
 	head->height--;
-
-	//mempool_free(node, head->mempool);
 }
 
 static int btree_blue_insert_level(struct btree_blue_head *head,
@@ -685,9 +687,12 @@ static int btree_blue_insert_level(struct btree_blue_head *head,
 				   struct btree_blue_node_cb *found, gfp_t gfp)
 {
 	struct btree_blue_node_cb *cb, *cb_new, *cb_p;
-	int pos, slots_nr, err;
+	int pos, pos_p, slots_nr, nr, err;
 
-	BUG_ON(!val);
+	struct btree_blue_node_cb *cb_next, *cb_prev;
+	struct btree_blue_stub *stub, *stub_new, *stub_next, *stub_prev;
+
+	//BUG_ON(!val);
 
 	if (head->height < level) {
 		err = btree_blue_grow(head, gfp);
@@ -699,74 +704,135 @@ static int btree_blue_insert_level(struct btree_blue_head *head,
 
 	if (!found)
 		cb = (struct btree_blue_node_cb *)find_level(head, key, level,
-							     &cb_p);
+							     &cb_p, &pos_p);
 	else {
 		cb = found;
 		cb_p = NULL;
 	}
 
 	pos = getpos(head, cb, key);
+
 	/* two identical keys are not allowed */
 	BUG_ON(pos < slots_nr && keycmp(head, cb, pos, key) == 0);
 
 	slots_nr = cb->slots_info.slots_nr;
 
-	if (slots_nr == head->slot_vols[level]) {
-		/* need to split node */
-		struct btree_blue_node_cb *cb_prev;
-		struct btree_blue_stub *stub, *stub_new, *stub_prev;
+	if (likely(slots_nr < head->slot_vols[level])) {
+_insert:
+		//BUG_ON(slots_nr >= head->slot_vols[level]);
+
+		/* shift and insert */
+		_shift_slots(head, cb, pos + 1, pos, slots_nr - pos);
+		cb->slots_info.slots_nr++;
 
-		cb_new = (struct btree_blue_node_cb *)btree_blue_node_alloc(
-			head, level, gfp);
-		if (!cb_new)
-			return -ENOMEM;
+		setkey(head, cb, pos, key);
+		setval(head, cb, pos, val);
 
+		return 0;
+	}
+
+	/* need to split node */
+
+	cb_new = (struct btree_blue_node_cb *)btree_blue_node_alloc(head, level,
+								    gfp);
+	if (!cb_new)
+		return -ENOMEM;
+
+	slots_nr = slots_nr / 2;
+	nr = cb->slots_info.slots_nr - slots_nr;
+
+	if (unlikely(level == head->height)) {
 		err = btree_blue_insert_level(head,
-					      bkey(head, cb, slots_nr / 2 - 1),
+					      bkey(head, cb, slots_nr - 1),
 					      cb_new, level + 1, cb_p, gfp);
 		if (err) {
-			//mempool_free(cb_new, head->mempool);
 			btree_blue_node_free((unsigned long *)cb_new, level);
 			return err;
 		}
 
+		setval(head, (struct btree_blue_node_cb *)(head->node), 0, cb);
+		setval(head, (struct btree_blue_node_cb *)(head->node), 1,
+		       cb_new);
+
+		goto _shift_lazy;
+	}
+
+	if (cb_p && (cb_p->slots_info.slots_nr < head->slot_vols[level + 1])) {
+		err = btree_blue_insert_level(head,
+					      bkey(head, cb, slots_nr - 1),
+					      cb_new, level + 1, cb_p, gfp);
+		if (err) {
+			btree_blue_node_free((unsigned long *)cb_new, level);
+			return err;
+		}
+
+		setval(head, cb_p, pos_p + 1, cb_new);
+		setval(head, cb_p, pos_p, cb);
+
+_shift_lazy:
+		_transfer_slots(head, cb_new, cb, 0, slots_nr, nr);
+		cb_new->slots_info.slots_nr = nr;
+		cb->slots_info.slots_nr = slots_nr;
+
 		if (level == 1) {
 			stub = __get_stub(head, cb);
 			stub_new = __get_stub(head, cb_new);
-			stub_new->next = (unsigned long *)cb;
 
-			if (stub->prev) {
-				cb_prev = (struct btree_blue_node_cb
-						   *)(stub->prev);
-				stub_prev = __get_stub(head, cb_prev);
-				stub_prev->next = (unsigned long *)cb_new;
-				stub_new->prev = stub->prev;
+			stub_new->prev = (unsigned long *)cb;
+
+			if (stub->next) {
+				cb_next = (struct btree_blue_node_cb
+						   *)(stub->next);
+				stub_next = __get_stub(head, cb_next);
+				stub_next->prev = (unsigned long *)cb_new;
+				stub_new->next = stub->next;
 			}
-			stub->prev = (unsigned long *)cb_new;
+			stub->next = (unsigned long *)cb_new;
 		}
 
-		split_to_empty(head, cb_new, cb, level);
-
-		if (pos <= (slots_nr / 2 - 1)) {
-			slots_nr = slots_nr / 2;
+		if (pos > (slots_nr - 1)) {
+			pos = pos - cb->slots_info.slots_nr;
+			slots_nr = cb_new->slots_info.slots_nr;
 			cb = cb_new;
-		} else {
-			pos = pos - slots_nr / 2;
-			slots_nr = slots_nr - slots_nr / 2;
 		}
+
+		goto _insert;
 	}
 
-	BUG_ON(slots_nr >= head->slot_vols[level]);
+	err = btree_blue_insert_level(head, bkey(head, cb, slots_nr - 1),
+				      cb_new, level + 1, cb_p, gfp);
+	if (err) {
+		btree_blue_node_free((unsigned long *)cb_new, level);
+		return err;
+	}
 
-	/* shift and insert */
-	//pos = shift_slots_on_insert(head, cb, pos, level);
-	_shift_slots(head, cb, pos + 1, pos, slots_nr - pos);
-	cb->slots_info.slots_nr++;
+	if (level == 1) {
+		stub = __get_stub(head, cb);
+		stub_new = __get_stub(head, cb_new);
+		stub_new->next = (unsigned long *)cb;
+
+		if (likely(stub->prev)) {
+			cb_prev = (struct btree_blue_node_cb *)(stub->prev);
+			stub_prev = __get_stub(head, cb_prev);
+			stub_prev->next = (unsigned long *)cb_new;
+			stub_new->prev = stub->prev;
+		}
+		stub->prev = (unsigned long *)cb_new;
+	}
 
-	setkey(head, cb, pos, key);
-	setval(head, cb, pos, val);
+	_transfer_slots(head, cb_new, cb, 0, 0, slots_nr);
+	_shift_slots(head, cb, 0, slots_nr, nr);
+	cb_new->slots_info.slots_nr = slots_nr;
+	cb->slots_info.slots_nr = nr;
 
-	return 0;
+	if (pos <= (slots_nr - 1))
+		cb = cb_new;
+	else {
+		pos = pos - slots_nr;
+		slots_nr = nr;
+	}
+
+	goto _insert;
 }
 
 int btree_blue_insert(struct btree_blue_head *head, unsigned long *key,
@@ -812,7 +878,6 @@ static void merge(struct btree_blue_head *head, int level,
 	setval(head, cb_parent, lpos + 1, cb_left);
 	/* Remove left (formerly right) child from parent */
 	btree_blue_remove_level(head, bkey(head, cb_parent, lpos), level + 1);
-	//mempool_free(cb_right, head->mempool);
 	btree_blue_node_free((unsigned long *)cb_right, level);
 }
 
@@ -855,7 +920,6 @@ static void rebalance(struct btree_blue_head *head, unsigned long *key,
 			}
 		}
 
-		//mempool_free(cb_child, head->mempool);
 		btree_blue_node_free((unsigned long *)cb_child, level);
 		return;
 	}
@@ -897,7 +961,7 @@ static void *btree_blue_remove_level(struct btree_blue_head *head,
 				     unsigned long *key, int level)
 {
 	struct btree_blue_node_cb *cb, *cb_p;
-	int pos, slots_nr;
+	int pos, pos_p, slots_nr;
 	void *ret;
 
 	if (level > head->height) {
@@ -907,7 +971,8 @@ static void *btree_blue_remove_level(struct btree_blue_head *head,
 		return NULL;
 	}
 
-	cb = (struct btree_blue_node_cb *)find_level(head, key, level, &cb_p);
+	cb = (struct btree_blue_node_cb *)find_level(head, key, level, &cb_p,
+						     &pos_p);
 	slots_nr = cb->slots_info.slots_nr;
 	pos = getpos(head, cb, key);
 
@@ -917,7 +982,6 @@ static void *btree_blue_remove_level(struct btree_blue_head *head,
 	ret = bval(head, cb, pos);
 
 	/* remove and shift */
-	//delete_slot(head, cb, pos, level);
 	_shift_slots(head, cb, pos, pos + 1, slots_nr - pos - 1);
 	cb->slots_info.slots_nr--;
 
@@ -957,14 +1021,6 @@ int __must_check btree_blue_init(struct btree_blue_head *head,
 	    (key_len_in_byte != 2 * sizeof(unsigned long)))
 		return -EINVAL;
 
-	//__btree_blue_init(head, node_size_in_byte, key_len_in_byte, flags);
-
-	//head->mempool =
-	//	mempool_create(0, btree_blue_alloc, btree_blue_free, NULL);
-	//if (!head->mempool)
-	//	return -ENOMEM;
-	//return 0;
-
 	head->node = NULL;
 	head->height = 0;
 
@@ -972,8 +1028,6 @@ int __must_check btree_blue_init(struct btree_blue_head *head,
 	head->slot_width =
 		(VALUE_LEN * BITS_PER_BYTE) / BITS_PER_LONG + head->keylen;
 
-	//head->node_size = node_size;
-
 	if (node_size_in_byte > 512)
 		x = 512;
 	else
@@ -1014,10 +1068,6 @@ EXPORT_SYMBOL_GPL(btree_blue_init);
 
 void btree_blue_destroy(struct btree_blue_head *head)
 {
-	//mempool_free(head->node, head->mempool);
-	//mempool_destroy(head->mempool);
-	//head->mempool = NULL;
-
 	if (btree_blue_cache_node) {
 		kmem_cache_destroy(btree_blue_cache_node);
 		btree_blue_cache_node = NULL;
diff --git a/lib/btree_blue_test.c b/lib/btree_blue_test.c
index 715dc614e7dd..797a3ebb3a62 100644
--- a/lib/btree_blue_test.c
+++ b/lib/btree_blue_test.c
@@ -132,6 +132,35 @@ static int btree_blue_test_init(void)
 	       RANDOM_NR);
 	err = 0;
 
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		err = btree_blue_insert(&btree_blue_root, &(data_set_1[i].k),
+					(void *)(data_set_1[i].v), GFP_NOIO);
+		if (err) {
+			printk(KERN_EMERG
+			       "error: btree_blue failed to insert\n");
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG
+	       "btree_blue inserts %lu random keys use time: %ld ns\n",
+	       RANDOM_NR, t0);
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		err = btree_insert(&btree_root, &btree_geo64,
+				   &(data_set_1[i].k),
+				   (void *)(data_set_1[i].v), GFP_NOIO);
+		if (err) {
+			printk(KERN_EMERG "error: btree failed to insert\n");
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "btree %lu inserts use time: %ld ns\n", RANDOM_NR,
+	       t0);
+
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
 		err = mtree_insert(&maple_tree, data_set_1[i].k,
@@ -164,40 +193,40 @@ static int btree_blue_test_init(void)
 	printk(KERN_EMERG "rbtree inserts %lu random keys use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
+	printk(KERN_EMERG "random search %lu keys ...\n", RANDOM_NR);
+	err = 0;
+
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
-		err = btree_insert(&btree_root, &btree_geo64,
-				   &(data_set_1[i].k),
-				   (void *)(data_set_1[i].v), GFP_NOIO);
-		if (err) {
-			printk(KERN_EMERG "error: btree failed to insert\n");
+		key = data_set_1[i].k;
+		val_ptr = btree_blue_lookup(&btree_blue_root, &key);
+		if (!val_ptr) {
+			err = -1;
+			printk(KERN_EMERG
+			       "error: btree_blue failed to search at %ld!\n",
+			       i);
 			goto exit;
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "btree %lu inserts use time: %ld ns\n", RANDOM_NR,
-	       t0);
+	printk(KERN_EMERG
+	       "btree_blue random search %lu keys use time: %ld ns\n",
+	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
-		err = btree_blue_insert(&btree_blue_root, &(data_set_1[i].k),
-					(void *)(data_set_1[i].v), GFP_NOIO);
-		if (err) {
-			printk(KERN_EMERG
-			       "error: btree_blue failed to insert\n");
+		key = data_set_1[i].k;
+		val_ptr = btree_lookup(&btree_root, &btree_geo64, &key);
+		if (!val_ptr) {
+			err = -1;
+			printk(KERN_EMERG "error: btree failed to search\n");
 			goto exit;
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG
-	       "btree_blue inserts %lu random keys use time: %ld ns\n",
+	printk(KERN_EMERG "btree random search %lu keys use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
-	printk(KERN_EMERG
-	       "search %lu random keys in  a tree which has those keys ...\n",
-	       RANDOM_NR);
-	err = 0;
-
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
 		key = data_set_1[i].k;
@@ -211,7 +240,7 @@ static int btree_blue_test_init(void)
 	}
 	t0 = ktime_get_ns() - t0;
 	printk(KERN_EMERG
-	       "maple tree search %lu random keys use time: %lu ns\n",
+	       "maple tree random search %lu keys use time: %lu ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
@@ -225,45 +254,63 @@ static int btree_blue_test_init(void)
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "rbtree search %lu random keys use time: %ld ns\n",
+	printk(KERN_EMERG "rbtree random search %lu keys use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
+	printk(KERN_EMERG
+	       "%lu random pairs of insert + delete based on a tree which has %lu keys ...\n",
+	       RANDOM_NR, RANDOM_NR);
+	err = 0;
+
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
+		err = btree_blue_insert(&btree_blue_root, &(data_set_2[i].k),
+					(void *)(data_set_2[i].v), GFP_NOIO);
+		if (err) {
+			printk(KERN_EMERG
+			       "error: btree_blue failed to insert with data_set_2\n");
+			goto exit;
+		}
+
 		key = data_set_1[i].k;
-		val_ptr = btree_lookup(&btree_root, &btree_geo64, &key);
+		val_ptr = btree_blue_remove(&btree_blue_root, &key);
 		if (!val_ptr) {
 			err = -1;
-			printk(KERN_EMERG "error: btree failed to search\n");
+			printk(KERN_EMERG
+			       "error: btree_blue failed to delete at %ld\n",
+			       i);
 			goto exit;
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "btree search %lu random keys use time: %ld ns\n",
+	printk(KERN_EMERG
+	       "btree_blue %lu random pairs of insert + delete use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
+		err = btree_insert(&btree_root, &btree_geo64,
+				   &(data_set_2[i].k),
+				   (void *)(data_set_2[i].v), GFP_NOIO);
+		if (err) {
+			printk(KERN_EMERG
+			       "error: btree failed to insert with data_set_2\n");
+			goto exit;
+		}
+
 		key = data_set_1[i].k;
-		val_ptr = btree_blue_lookup(&btree_blue_root, &key);
+		val_ptr = btree_remove(&btree_root, &btree_geo64, &key);
 		if (!val_ptr) {
 			err = -1;
-			printk(KERN_EMERG
-			       "error: btree_blue failed to search at %ld!\n",
-			       i);
+			printk(KERN_EMERG "error: btree failed to delete\n");
 			goto exit;
 		}
 	}
 	t0 = ktime_get_ns() - t0;
 	printk(KERN_EMERG
-	       "btree_blue search %lu random keys use time: %ld ns\n",
+	       "btree %lu random pairs of insert + delete use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
-	printk(KERN_EMERG
-	       "%lu random mixed insert + delete based on a tree which has %lu keys ...\n",
-	       RANDOM_NR, RANDOM_NR);
-	err = 0;
-
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
 		err = mtree_insert(&maple_tree, data_set_2[i].k,
@@ -284,7 +331,7 @@ static int btree_blue_test_init(void)
 	}
 	t0 = ktime_get_ns() - t0;
 	printk(KERN_EMERG
-	       "maple tree %lu random mixed insert + delete use time: %ld ns\n",
+	       "maple tree %lu random pairs of insert + delete use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
@@ -314,78 +361,41 @@ static int btree_blue_test_init(void)
 	}
 	t0 = ktime_get_ns() - t0;
 	printk(KERN_EMERG
-	       "rbtree %lu random mixed insert + delete use time: %ld ns\n",
+	       "rbtree %lu random pairs of insert + delete use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
-	t0 = ktime_get_ns();
-	for (long i = 0; i < RANDOM_NR; i++) {
-		err = btree_insert(&btree_root, &btree_geo64,
-				   &(data_set_2[i].k),
-				   (void *)(data_set_2[i].v), GFP_NOIO);
-		if (err) {
-			printk(KERN_EMERG
-			       "error: btree failed to insert with data_set_2\n");
-			goto exit;
-		}
-
-		key = data_set_1[i].k;
-		val_ptr = btree_remove(&btree_root, &btree_geo64, &key);
-		if (!val_ptr) {
-			err = -1;
-			printk(KERN_EMERG "error: btree failed to delete\n");
-			goto exit;
-		}
-	}
-	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG
-	       "btree %lu random mixed insert + delete use time: %ld ns\n",
-	       RANDOM_NR, t0);
+	printk(KERN_EMERG "get prev key in a tree which has %lu keys ...\n",
+	       RANDOM_NR);
+	err = 0;
 
 	t0 = ktime_get_ns();
-	for (long i = 0; i < RANDOM_NR; i++) {
-		err = btree_blue_insert(&btree_blue_root, &(data_set_2[i].k),
-					(void *)(data_set_2[i].v), GFP_NOIO);
-		if (err) {
-			printk(KERN_EMERG
-			       "error: btree_blue failed to insert with data_set_2\n");
-			goto exit;
-		}
-
-		key = data_set_1[i].k;
-		val_ptr = btree_blue_remove(&btree_blue_root, &key);
-		if (!val_ptr) {
-			err = -1;
-			printk(KERN_EMERG
-			       "error: btree_blue failed to delete at %ld\n",
-			       i);
-			goto exit;
-		}
-	}
+	total = 0;
+	total = btree_blue_traverse_from_key(&btree_blue_root, 0,
+					     btree_blue_visit, GET_PREV);
 	t0 = ktime_get_ns() - t0;
 	printk(KERN_EMERG
-	       "btree_blue %lu random mixed insert + delete use time: %ld ns\n",
-	       RANDOM_NR, t0);
-
-	printk(KERN_EMERG "get prev key in a tree which has %lu keys ...\n",
-	       RANDOM_NR);
-	err = 0;
+	       "btree_blue get %lu prev keys in callback way use time %ld ns\n",
+	       total, t0);
 
-	rbtree_node = rb_last(&rbtree_root);
-	if (!rbtree_node) {
-		printk(KERN_EMERG "rbtree failed to get the last node\n");
+	val_ptr = btree_blue_last(&btree_blue_root, &key);
+	if (!val_ptr) {
+		printk(KERN_EMERG
+		       "error: btree_blue failed to get the last key\n");
 		return -1;
 	}
 
 	t0 = ktime_get_ns();
 	for (long i = 1; i < RANDOM_NR; i++) {
-		rbtree_node = rb_prev(rbtree_node);
-		if (!rbtree_node) {
-			printk(KERN_EMERG "error: rbtree get prev failed\n");
+		val_ptr = btree_blue_get_prev(&btree_blue_root, &key);
+		if (!val_ptr) {
+			printk(KERN_EMERG
+			       "error: btree_blue get prev failed at i = %ld\n",
+			       i);
 			return -1;
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "rbtree get %lu prev keys use time: %lu ns\n",
+	printk(KERN_EMERG "btree_blue get %lu prev keys use time: %ld ns\n",
 	       RANDOM_NR - 1, t0);
 
 	val_ptr = btree_last(&btree_root, &btree_geo64, &key);
@@ -393,7 +403,6 @@ static int btree_blue_test_init(void)
 		printk(KERN_EMERG "btree failed to get the last key\n");
 		return -1;
 	}
-
 	t0 = ktime_get_ns();
 	for (long i = 1; i < RANDOM_NR; i++) {
 		val_ptr = btree_get_prev(&btree_root, &btree_geo64, &key);
@@ -408,36 +417,23 @@ static int btree_blue_test_init(void)
 	printk(KERN_EMERG "btree get %lu prev keys use time: %lu ns\n",
 	       RANDOM_NR - 1, t0);
 
-	val_ptr = btree_blue_last(&btree_blue_root, &key);
-	if (!val_ptr) {
-		printk(KERN_EMERG
-		       "error: btree_blue failed to get the last key\n");
+	rbtree_node = rb_last(&rbtree_root);
+	if (!rbtree_node) {
+		printk(KERN_EMERG "rbtree failed to get the last node\n");
 		return -1;
 	}
-
 	t0 = ktime_get_ns();
 	for (long i = 1; i < RANDOM_NR; i++) {
-		val_ptr = btree_blue_get_prev(&btree_blue_root, &key);
-		if (!val_ptr) {
-			printk(KERN_EMERG
-			       "error: btree_blue get prev failed at i = %ld\n",
-			       i);
+		rbtree_node = rb_prev(rbtree_node);
+		if (!rbtree_node) {
+			printk(KERN_EMERG "error: rbtree get prev failed\n");
 			return -1;
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "btree_blue get %lu prev keys use time: %ld ns\n",
+	printk(KERN_EMERG "rbtree get %lu prev keys use time: %lu ns\n",
 	       RANDOM_NR - 1, t0);
 
-	t0 = ktime_get_ns();
-	total = 0;
-	total = btree_blue_traverse_from_key(&btree_blue_root, 0,
-					     btree_blue_visit, GET_PREV);
-	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG
-	       "btree_blue get %lu prev keys in callback way use time %ld ns\n",
-	       total, t0);
-
 	printk(KERN_EMERG
 	       "verify btree_blue traversed %lu values with btree...\n",
 	       RANDOM_NR);
@@ -491,67 +487,67 @@ static int btree_blue_test_init(void)
 
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
-		val_ptr = mtree_erase(&maple_tree, data_set_2[i].k);
+		val_ptr =
+			btree_blue_remove(&btree_blue_root, &(data_set_2[i].k));
 		if (!val_ptr) {
 			err = -1;
 			printk(KERN_EMERG
-			       "error: maple tree failed to delete\n");
+			       "error: btree_blue failed to delete at %ld\n",
+			       i);
 			goto exit;
 		}
 	}
 	t0 = ktime_get_ns() - t0;
 	printk(KERN_EMERG
-	       "maple tree random deletes %lu keys use time: %ld ns\n",
+	       "btree_blue random deletes %lu keys use time: %lu ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
-		rbtree_node = rb_find(&(data_set_2[i].k), &rbtree_root,
-				      rbtree_entry_cmp);
-		if (!rbtree_node) {
+		val_ptr = btree_remove(&btree_root, &btree_geo64,
+				       &(data_set_2[i].k));
+		if (!val_ptr) {
 			err = -1;
 			printk(KERN_EMERG
-			       "rbtree failed to find key to delete\n");
+			       "error: btree failed to delete data_set_2\n");
 			goto exit;
 		}
-		rb_erase(rbtree_node, &rbtree_root);
-		entry_ptr = rb_entry(rbtree_node, struct rbtree_entry, node);
-		kmem_cache_free(rbtree_node_cache, entry_ptr);
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "rbtree random deletes %lu keys use time: %ld ns\n",
+	printk(KERN_EMERG "btree random deletes %lu keys use time: %lu ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
-		val_ptr = btree_remove(&btree_root, &btree_geo64,
-				       &(data_set_2[i].k));
+		val_ptr = mtree_erase(&maple_tree, data_set_2[i].k);
 		if (!val_ptr) {
 			err = -1;
 			printk(KERN_EMERG
-			       "error: btree failed to delete data_set_2\n");
+			       "error: maple tree failed to delete\n");
 			goto exit;
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "btree random deletes %lu keys use time: %lu ns\n",
+	printk(KERN_EMERG
+	       "maple tree random deletes %lu keys use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
-		val_ptr =
-			btree_blue_remove(&btree_blue_root, &(data_set_2[i].k));
-		if (!val_ptr) {
+		rbtree_node = rb_find(&(data_set_2[i].k), &rbtree_root,
+				      rbtree_entry_cmp);
+		if (!rbtree_node) {
 			err = -1;
 			printk(KERN_EMERG
-			       "error: btree_blue failed to delete at %ld\n",
-			       i);
+			       "rbtree failed to find key to delete\n");
 			goto exit;
 		}
+		rb_erase(rbtree_node, &rbtree_root);
+		entry_ptr = rb_entry(rbtree_node, struct rbtree_entry, node);
+		kmem_cache_free(rbtree_node_cache, entry_ptr);
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG
-	       "btree_blue random deletes %lu keys use time: %lu ns\n",
+	printk(KERN_EMERG "rbtree random deletes %lu keys use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
 exit:
-- 
2.30.2


