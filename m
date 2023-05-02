Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6DF6F3CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 06:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjEBE0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 00:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjEBE0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 00:26:44 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F1F3AA4
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 21:26:42 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Q9RqM00V6z9sdn
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1683001599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8JIidON7ObJRXtw6ghF6hznpzFYqEMz6CIXHrODRrKU=;
        b=mIYx5D61w/xSoYvxqUcy2Q7+ecKGjsvfrAY2q74R8qa0YbHCp8HQ16Rq62+YlIagLwEbz0
        TuWCyYnt2Pjr2Gfr9ozCMriHoAJeUSkv73kNGl/TemvodGAP3W/6U4dslChVQ7V+dOH3QW
        /jpAUO8rWjYxGYC7LrLBr23uoMYB+RJ2skj8/uH627V+gwu3308GuZjZvs2IseNFZjkyu8
        P68ftSSvTjHX/zjp7ECjM5u1UDckeo7HCV2I1hRE6tOSx5M15jnDIJmgfP+dS3tEDTCLkF
        9YeVyd3ztzCwRaD3W7GED4pxRZjQytu5KKxfVNz7tAdf1fQtkdryKomJvOq0eA==
Message-ID: <d8bfc0a6bb4fed83761fd2db374b37705c705683.camel@mailbox.org>
Subject: Library: [RFC PATCH 2/3] btree_blue - A simple btree with fast
 linear traverse
From:   liuwf <liuwf@mailbox.org>
To:     linux-kernel@vger.kernel.org
Date:   Tue, 02 May 2023 00:26:27 -0400
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rwm4jpzcucjxem4n51xff7ttwdx4gzyg
X-MBO-RS-ID: 335a4a434b017783020
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Library: [RFC PATCH 2/3] btree_blue - A simple btree with fast linear traverse

From: Liu Weifeng 4019c26b5c0d5f6b <liuwf@mailbox.org>


Signed-off-by: Liu Weifeng 4019c26b5c0d5f6b <liuwf@mailbox.org>
---
 include/linux/btree_blue.h |   4 +-
 lib/btree_blue.c           | 170 +++++++++++++++++++++++++------------
 2 files changed, 118 insertions(+), 56 deletions(-)

diff --git a/include/linux/btree_blue.h b/include/linux/btree_blue.h
index 2f1a7781c77b..62217b96cb4e 100644
--- a/include/linux/btree_blue.h
+++ b/include/linux/btree_blue.h
@@ -17,16 +17,16 @@ struct btree_blue_node_cb;
 
 struct btree_blue_head {
 	unsigned long *node;
-	mempool_t *mempool;
 
 	u16 node_size;
+	u16 leaf_size;
 	u16 stub_base;
 	u8 keylen;
 	u8 slot_width;
 	u8 height;
 	u8 reserved[1];
 
-	u16 vols[MAX_TREE_HEIGHT + 1];
+	u16 slot_vols[MAX_TREE_HEIGHT + 1];
 };
 
 void *btree_blue_alloc(gfp_t gfp_mask, void *pool_data);
diff --git a/lib/btree_blue.c b/lib/btree_blue.c
index ddde34f23139..62f7baa43044 100644
--- a/lib/btree_blue.c
+++ b/lib/btree_blue.c
@@ -32,8 +32,10 @@ struct btree_blue_stub {
 	unsigned long *next;
 };
 
-static struct kmem_cache *btree_blue_cachep;
+static struct kmem_cache *btree_blue_cache_node;
+static struct kmem_cache *btree_blue_cache_leaf;
 
+/*
 void *btree_blue_alloc(gfp_t gfp_mask, void *pool_data)
 {
 	return kmem_cache_alloc(btree_blue_cachep, gfp_mask);
@@ -45,18 +47,36 @@ void btree_blue_free(void *element, void *pool_data)
 	kmem_cache_free(btree_blue_cachep, element);
 }
 EXPORT_SYMBOL_GPL(btree_blue_free);
+*/
 
 static unsigned long *btree_blue_node_alloc(struct btree_blue_head *head,
-					    gfp_t gfp)
+					    int level, gfp_t gfp)
 {
 	unsigned long *node;
+	int size;
+
+	if (likely(level == 1)) {
+		size = head->leaf_size;
+		node = kmem_cache_alloc(btree_blue_cache_leaf, gfp);
+	} else {
+		size = head->node_size;
+		node = kmem_cache_alloc(btree_blue_cache_node, gfp);
+	}
 
-	node = mempool_alloc(head->mempool, gfp);
 	if (likely(node))
-		memset(node, 0, head->node_size);
+		memset(node, 0, size);
+
 	return node;
 }
 
+static void btree_blue_node_free(unsigned long *node, int level)
+{
+	if (likely(level == 1))
+		kmem_cache_free(btree_blue_cache_leaf, node);
+	else
+		kmem_cache_free(btree_blue_cache_node, node);
+}
+
 static int longcmp(const unsigned long *l1, const unsigned long *l2, size_t n)
 {
 	size_t i;
@@ -422,9 +442,12 @@ void *btree_blue_prev_or_next(struct btree_blue_head *head,
 		return NULL;
 
 	slots_nr = node->slots_info.slots_nr;
+	i = geteqv(head, node, key);
+	/*
 	for (i = 0; i < slots_nr; i++)
 		if (keycmp(head, node, i, key) == 0)
 			break;
+	*/
 	if (i == slots_nr)
 		return NULL;
 
@@ -516,10 +539,12 @@ size_t btree_blue_traverse_from_key(struct btree_blue_head *head,
 		return total;
 
 	slots_nr = node->slots_info.slots_nr;
+	i = geteqv(head, node, key);
+	/*
 	for (i = 0; i < slots_nr; i++)
 		if (keycmp(head, node, i, (unsigned long *)key) == 0)
 			break;
-
+	*/
 	if (i == slots_nr)
 		return total;
 
@@ -619,7 +644,8 @@ static int btree_blue_grow(struct btree_blue_head *head, gfp_t gfp)
 {
 	struct btree_blue_node_cb *node, *node_h;
 
-	node = (struct btree_blue_node_cb *)btree_blue_node_alloc(head, gfp);
+	node = (struct btree_blue_node_cb *)btree_blue_node_alloc(
+		head, head->height + 1, gfp);
 	if (!node)
 		return -ENOMEM;
 
@@ -648,9 +674,10 @@ static void btree_blue_shrink(struct btree_blue_head *head)
 	BUG_ON(node->slots_info.slots_nr > 1);
 
 	head->node = bval(head, node, 0);
+	btree_blue_node_free((unsigned long *)node, head->height);
 	head->height--;
 
-	mempool_free(node, head->mempool);
+	//mempool_free(node, head->mempool);
 }
 
 static int btree_blue_insert_level(struct btree_blue_head *head,
@@ -684,13 +711,13 @@ static int btree_blue_insert_level(struct btree_blue_head *head,
 
 	slots_nr = cb->slots_info.slots_nr;
 
-	if (slots_nr == head->vols[level]) {
+	if (slots_nr == head->slot_vols[level]) {
 		/* need to split node */
 		struct btree_blue_node_cb *cb_prev;
 		struct btree_blue_stub *stub, *stub_new, *stub_prev;
 
 		cb_new = (struct btree_blue_node_cb *)btree_blue_node_alloc(
-			head, gfp);
+			head, level, gfp);
 		if (!cb_new)
 			return -ENOMEM;
 
@@ -698,7 +725,8 @@ static int btree_blue_insert_level(struct btree_blue_head *head,
 					      bkey(head, cb, slots_nr / 2 - 1),
 					      cb_new, level + 1, cb_p, gfp);
 		if (err) {
-			mempool_free(cb_new, head->mempool);
+			//mempool_free(cb_new, head->mempool);
+			btree_blue_node_free((unsigned long *)cb_new, level);
 			return err;
 		}
 
@@ -728,7 +756,7 @@ static int btree_blue_insert_level(struct btree_blue_head *head,
 		}
 	}
 
-	BUG_ON(slots_nr >= head->vols[level]);
+	BUG_ON(slots_nr >= head->slot_vols[level]);
 
 	/* shift and insert */
 	//pos = shift_slots_on_insert(head, cb, pos, level);
@@ -784,7 +812,8 @@ static void merge(struct btree_blue_head *head, int level,
 	setval(head, cb_parent, lpos + 1, cb_left);
 	/* Remove left (formerly right) child from parent */
 	btree_blue_remove_level(head, bkey(head, cb_parent, lpos), level + 1);
-	mempool_free(cb_right, head->mempool);
+	//mempool_free(cb_right, head->mempool);
+	btree_blue_node_free((unsigned long *)cb_right, level);
 }
 
 static void rebalance(struct btree_blue_head *head, unsigned long *key,
@@ -826,7 +855,8 @@ static void rebalance(struct btree_blue_head *head, unsigned long *key,
 			}
 		}
 
-		mempool_free(cb_child, head->mempool);
+		//mempool_free(cb_child, head->mempool);
+		btree_blue_node_free((unsigned long *)cb_child, level);
 		return;
 	}
 
@@ -839,7 +869,7 @@ static void rebalance(struct btree_blue_head *head, unsigned long *key,
 		cb_left = bval(head, cb_parent, i - 1);
 		slots_nr_left = cb_left->slots_info.slots_nr;
 
-		if (slots_nr_left + slots_nr <= head->vols[level]) {
+		if (slots_nr_left + slots_nr <= head->slot_vols[level]) {
 			merge(head, level, cb_left, cb_child, cb_parent, i - 1);
 			return;
 		}
@@ -849,7 +879,7 @@ static void rebalance(struct btree_blue_head *head, unsigned long *key,
 		cb_right = bval(head, cb_parent, i + 1);
 		slots_nr_right = cb_right->slots_info.slots_nr;
 
-		if (slots_nr + slots_nr_right <= head->vols[level]) {
+		if (slots_nr + slots_nr_right <= head->slot_vols[level]) {
 			merge(head, level, cb_child, cb_right, cb_parent, i);
 			return;
 		}
@@ -891,7 +921,7 @@ static void *btree_blue_remove_level(struct btree_blue_head *head,
 	_shift_slots(head, cb, pos, pos + 1, slots_nr - pos - 1);
 	cb->slots_info.slots_nr--;
 
-	if (cb->slots_info.slots_nr < head->vols[level] / 2 - 2) {
+	if (cb->slots_info.slots_nr < head->slot_vols[level] / 2 - 2) {
 		if (level < head->height)
 			rebalance(head, key, level, cb, cb_p);
 		else if (cb->slots_info.slots_nr == 1)
@@ -910,35 +940,12 @@ void *btree_blue_remove(struct btree_blue_head *head, unsigned long *key)
 }
 EXPORT_SYMBOL_GPL(btree_blue_remove);
 
-static inline void __btree_blue_init(struct btree_blue_head *head,
-				     int node_size, int keylen, int flags)
-{
-	int vol;
-
-	head->node = NULL;
-	head->height = 0;
-	head->node_size = node_size;
-	head->keylen = (keylen * BITS_PER_BYTE) / BITS_PER_LONG;
-	head->slot_width =
-		(VALUE_LEN * BITS_PER_BYTE) / BITS_PER_LONG + head->keylen;
-
-	vol = (node_size - sizeof(struct btree_blue_node_cb)) /
-	      (head->slot_width * sizeof(long));
-	for (int i = 2; i < MAX_TREE_HEIGHT + 1; i++)
-		head->vols[i] = vol;
-	vol = (node_size - sizeof(struct btree_blue_node_cb) -
-	       sizeof(struct btree_blue_stub)) /
-	      (head->slot_width * sizeof(long));
-	head->vols[0] = head->vols[1] = vol;
-
-	head->stub_base = sizeof(struct btree_blue_node_cb) +
-			  head->vols[1] * (head->slot_width * sizeof(long));
-}
-
 int __must_check btree_blue_init(struct btree_blue_head *head,
 				 int node_size_in_byte, int key_len_in_byte,
 				 int flags)
 {
+	int x;
+
 	if (node_size_in_byte % L1_CACHE_BYTES)
 		return -EINVAL;
 
@@ -950,27 +957,78 @@ int __must_check btree_blue_init(struct btree_blue_head *head,
 	    (key_len_in_byte != 2 * sizeof(unsigned long)))
 		return -EINVAL;
 
-	btree_blue_cachep = kmem_cache_create("btree_blue_node_buf",
-					      node_size_in_byte, 0,
-					      SLAB_HWCACHE_ALIGN, NULL);
-	if (!btree_blue_cachep)
-		return -ENOMEM;
+	//__btree_blue_init(head, node_size_in_byte, key_len_in_byte, flags);
 
-	__btree_blue_init(head, node_size_in_byte, key_len_in_byte, flags);
+	//head->mempool =
+	//	mempool_create(0, btree_blue_alloc, btree_blue_free, NULL);
+	//if (!head->mempool)
+	//	return -ENOMEM;
+	//return 0;
 
-	head->mempool =
-		mempool_create(0, btree_blue_alloc, btree_blue_free, NULL);
-	if (!head->mempool)
+	head->node = NULL;
+	head->height = 0;
+
+	head->keylen = (key_len_in_byte * BITS_PER_BYTE) / BITS_PER_LONG;
+	head->slot_width =
+		(VALUE_LEN * BITS_PER_BYTE) / BITS_PER_LONG + head->keylen;
+
+	//head->node_size = node_size;
+
+	if (node_size_in_byte > 512)
+		x = 512;
+	else
+		x = node_size_in_byte;
+	head->node_size = x;
+	head->leaf_size = node_size_in_byte;
+
+	btree_blue_cache_node = kmem_cache_create("btree_blue_cache_node",
+						  head->node_size, 0,
+						  SLAB_HWCACHE_ALIGN, NULL);
+	if (!btree_blue_cache_node)
 		return -ENOMEM;
+
+	btree_blue_cache_leaf = kmem_cache_create("btree_blue_cache_leaf",
+						  head->leaf_size, 0,
+						  SLAB_HWCACHE_ALIGN, NULL);
+	if (!btree_blue_cache_leaf)
+		return -ENOMEM;
+
+	for (int i = 2; i < MAX_TREE_HEIGHT + 1; i++) {
+		x = (head->node_size - sizeof(struct btree_blue_node_cb)) /
+		    (head->slot_width * sizeof(long));
+		head->slot_vols[i] = x;
+	}
+
+	x = (head->leaf_size - sizeof(struct btree_blue_node_cb) -
+	     sizeof(struct btree_blue_stub)) /
+	    (head->slot_width * sizeof(long));
+	head->slot_vols[0] = head->slot_vols[1] = x;
+
+	head->stub_base =
+		sizeof(struct btree_blue_node_cb) +
+		head->slot_vols[1] * (head->slot_width * sizeof(long));
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btree_blue_init);
 
 void btree_blue_destroy(struct btree_blue_head *head)
 {
-	mempool_free(head->node, head->mempool);
-	mempool_destroy(head->mempool);
-	head->mempool = NULL;
+	//mempool_free(head->node, head->mempool);
+	//mempool_destroy(head->mempool);
+	//head->mempool = NULL;
+
+	if (btree_blue_cache_node) {
+		kmem_cache_destroy(btree_blue_cache_node);
+		btree_blue_cache_node = NULL;
+	}
+
+	if (btree_blue_cache_leaf) {
+		kmem_cache_destroy(btree_blue_cache_leaf);
+		btree_blue_cache_leaf = NULL;
+	}
+
+	head->node = NULL;
 }
 EXPORT_SYMBOL_GPL(btree_blue_destroy);
 
@@ -981,7 +1039,11 @@ static int __init btree_blue_module_init(void)
 
 static void __exit btree_blue_module_exit(void)
 {
-	kmem_cache_destroy(btree_blue_cachep);
+	if (btree_blue_cache_node)
+		kmem_cache_destroy(btree_blue_cache_node);
+
+	if (btree_blue_cache_leaf)
+		kmem_cache_destroy(btree_blue_cache_leaf);
 }
 
 module_init(btree_blue_module_init);
-- 
2.30.2


