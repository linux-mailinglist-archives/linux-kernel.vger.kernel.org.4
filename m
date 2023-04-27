Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369FB6EF849
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjDZQUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjDZQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:20:03 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5C03AA9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 09:19:58 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Q63x70LWdz9t7q;
        Wed, 26 Apr 2023 18:19:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1682525995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jq4KYYCMDDhfy29g5mOAyD9HdkagdnatAFa4WBqpCR0=;
        b=izQOH51xyeW/13Fs9W51I5p1URasTDuondGmWSUJS7BY1AavD8IE9MntdkAJzPcQXHk5rE
        9LIG+5iB5KEBKqa/vvUiayjrpSYO4NDJPP4cfOyMABtImI6cveQ0vG9KD6/kRbuv6w1DKa
        Q7KKYy6hlUP5yOkLZBBwW2c7+YYiHmrjBv4EgYQ7IAn9bSgMDkv+GVMSOmqgojCQjleLGr
        32XCgai7see2RKT7/2uO55Te1NRzMjMd5MnA95RBdq1yBPYltA97gCVScN9ygtjF/4anX5
        6y0ox0ru0Ek6glKPeQP7ziz+LuXdztoRadkbppgzsA/NlAhNPXro38xu7bKgzA==
Message-ID: <48d6f5a9788af056a212d0d5ba08219fdd592fbb.camel@mailbox.org>
Subject: Library: [RFC PATCH] btree_blue - A simple btree with fast linear
 travesal and more. V4. and test data
From:   liuwf <liuwf@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     joern@purestorage.com, torvalds@linux-foundation.org
Date:   Thu, 27 Apr 2023 00:39:23 -0400
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: u5jfmn4dszh3cdh5s6mw8mrck4f4p3bp
X-MBO-RS-ID: 2b36094f72c87087a91
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Weifeng 4019c26b5c0d5f6b <liuwf@mailbox.org>

btree_blue is a simple btree whose algorithm implementation comes from Joern 
Engel's lib/btree. btree_blue extended lib/btree with several features and 
optimizations:

	Add Two-Way links between leaf-nodes to offer a fast linear traversal.
	
	Insert, Search, Delete are relatively fast comparing with lib/btree, rbtee.
	Even if with a big node size(4K) btree_blue is still a bit fast.
	
	The 0 value of key itself is allowed.
	
	Node size can be variable in 256, 512, 1024, 2K, 4K, or 192, 384 ...
	
	Key length has sizes of one long, two longs, four longs (32-bit OS).
	
	
Joern Engel's lib/btree represents an elegance in logical and is fast and 
effective(100% slots usage). When I decided to add features based on it
like Two-Way links between leaf-nodes, bigger node sizes (and more, hope in 
the feature) which are required in many practices, I found it is a challenge 
to keep speed and effective with lib/btree, so I have to do several 
optimizings to keep or (hopefully) get more performance. 

One of optimizings in btree_blue is for a plain search long-by-long which is 
used in Joern Engel's lib/btree and I extend it to the range of 64 items and 
implemented it with carefull to try to get a bit faster than binary search
in the same range.

This 'extended plain search' seems worked well, along with other several 
optimizings btree_blue can run relatively fast when holding interesting 
features (big node size, fast linear traversal). In many test this search 
way demonstrated a happy perf over binary search (without it btree_blue with 
big node size (2K~4k) can be observed an evident slower than it's perf with 
small node size, this slowdown are also seen in many other btree 
implementations).


This version(V4) removed some struct members, code pathes that are reserved 
in the V1 for feature, but I think they are not needed any more, so this 
lighter version of can get a bit more perf than V1.

This round of test is based on the kernel version 6.2.6. Again, the results 
may be unfair for those competitors, for example, maple tree is RCU-safe and 
can deal with many complex cases, rbtree support duplicated keys, lib/btree's 
grace has virtue itself ...


btree_blue also needs to mature (debug, stable), and some APIs are needed to 
give.


*** ***

1. Test for btree_blue uses 512 bytes of node size. 

1000000 inserts to a empty tree ...

						btree	rbtree	maple tree
** btree_blue is fatser than others with	50%	280%	460%

maple tree 1000000 inserts use time: 		1129420872 ns
rbtree 1000000 inserts use time: 		 758329853 ns
btree 1000000 inserts use time: 		 297686337 ns
btree_blue 1000000 inserts use time: 		 198420840 ns


1000000 searches ...

** btree_blue, btree and maple tree almost got the same rate, and all faster 
about 100% than rbtree, btree_blue is 120% faster than rbtree and 20% faster
than the second(btree).

maple tree 1000000 searches use time: 	246779363 ns
rbtree 1000000 searches use time: 	454345925 ns
btree 1000000 searches use time: 	248777441 ns
btree_blue 1000000 searches use time: 	202541097 ns


1000000 mixed insert + delete based on a tree which has 1000000 keys ...

							btree	rbtree	maple tree
** btree_blue is fatser than others with		30%	170%	330%

maple tree 1000000 mixed insert + delete use time: 	2463726326 ns
rbtree 1000000 mixed insert + delete use time: 		1551667381 ns
btree 1000000 mixed insert + delete use time: 		 755925805 ns
btree_blue 1000000 mixed insert + delete use time: 	 572306495 ns


delete a tree which has 1000000 keys to empty ...

						btree	rbtree	maple tree
** btree_blue is fatser than others with	30%	150%	640%

maple tree 1000000 deletes use time: 		1624949238 ns
rbtree 1000000 deletes use time: 		 556931279 ns
btree 1000000 deletes use time: 		 299593684 ns
btree_blue 1000000 deletes use time: 		 217870837 ns




*** ***

2. Test for btree_blue uses 4096 bytes of node size


btree_blue droped some rate than it's perf with 512 bytes of node size in two
test category, but is still some fast among the fours. Surprisingly, search 
rate of btree_blue with 4096 bytes of node size is bit faster than it's perf 
with 512 bytes node size.

1000000 inserts to a empty tree ...

						btree	rbtree	maple tree
** btree_blue is fatser than others with	20%	110%	280%

maple tree 1000000 inserts use time: 		1034704010 ns
rbtree 1000000 inserts use time: 		 576622058 ns
btree 1000000 inserts use time: 		 335227184 ns
btree_blue 1000000 inserts use time: 		 270671222 ns


1000000 searches ...
						btree	rbtree	maple tree
** btree_blue is fatser than others with	30%	150%	40%

maple tree 1000000 searches use time: 		251009597 ns
rbtree 1000000 searches use time: 		452514099 ns
btree 1000000 searches use time: 		240169006 ns
btree_blue 1000000 searches use time: 		175108819 ns


1000000 mixed insert + delete based on a tree which has 1000000 keys ...

						btree	rbtree	maple tree
** btree_blue is fatser than others with	15%	130%	270%

maple tree 1000000 mixed insert + delete use time: 	2408988939 ns
rbtree 1000000 mixed insert + delete use time: 		1481094124 ns
btree 1000000 mixed insert + delete use time: 		 749438077 ns
btree_blue 1000000 mixed insert + delete use time: 	 638332253 ns


delete a tree which has 1000000 keys to empty ...

						btree	rbtree	maple tree
** btree_blue is fatser than others with	40%	160%	670%

maple tree 1000000 deletes use time: 		1637768019 ns
rbtree 1000000 deletes use time: 		 555470350 ns
btree 1000000 deletes use time: 		 314487857 ns
btree_blue 1000000 deletes use time: 		 212205682 ns

Signed-off-by: Liu Weifeng 4019c26b5c0d5f6b <liuwf@mailbox.org>
---
 include/linux/btree_blue.h |  83 ++++
 lib/Kconfig                |   4 +
 lib/Makefile               |   1 +
 lib/btree_blue.c           | 994 +++++++++++++++++++++++++++++++++++++
 4 files changed, 1082 insertions(+)
 create mode 100644 include/linux/btree_blue.h
 create mode 100644 lib/btree_blue.c

diff --git a/include/linux/btree_blue.h b/include/linux/btree_blue.h
new file mode 100644
index 000000000000..67a20752d0f6
--- /dev/null
+++ b/include/linux/btree_blue.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BTREE_BLUE_H
+#define BTREE_BLUE_H
+
+#include <linux/kernel.h>
+#include <linux/mempool.h>
+
+#define MAX_TREE_HEIGHT 8
+#define MIN_SLOTS_NUMBER 16
+#define MIN_NODE_SIZE (MIN_SLOTS_NUMBER * 2 * sizeof(unsigned long))
+
+#define GET_PREV 0
+#define GET_NEXT 1
+
+struct btree_blue_head;
+struct btree_blue_node_cb;
+
+struct btree_blue_head {
+	unsigned long *node;
+	mempool_t *mempool;
+
+	u16 node_size;
+	u16 stub_base;
+	u8 keylen;
+	u8 slot_width;
+	u8 height;
+	u8 reserved[1];
+
+	u16 vols[MAX_TREE_HEIGHT + 1];
+};
+
+void *btree_blue_alloc(gfp_t gfp_mask, void *pool_data);
+
+void btree_blue_free(void *element, void *pool_data);
+
+int __must_check btree_blue_init(struct btree_blue_head *head,
+				 int node_size_in_byte, int key_len_in_byte,
+				 int flags);
+
+void btree_blue_destroy(struct btree_blue_head *head);
+
+void *btree_blue_lookup(struct btree_blue_head *head, unsigned long *key);
+
+int __must_check btree_blue_insert(struct btree_blue_head *head,
+				   unsigned long *key, void *val, gfp_t gfp);
+
+int btree_blue_update(struct btree_blue_head *head, unsigned long *key,
+		      void *val);
+
+void *btree_blue_remove(struct btree_blue_head *head, unsigned long *key);
+
+void *btree_blue_first(struct btree_blue_head *head, unsigned long *__key);
+void *btree_blue_last(struct btree_blue_head *head, unsigned long *__key);
+
+void *btree_blue_get_prev(struct btree_blue_head *head, unsigned long *__key);
+void *btree_blue_get_next(struct btree_blue_head *head, unsigned long *__key);
+
+typedef bool (*btree_blue_traverse_FN_T)(const unsigned long *key,
+					 const void *val);
+
+/*
+ * Visit each key-value pair started from the @key and continue toward
+ * @prev_or_next until the last or fisrt.
+ *
+ * IF @key is given NULL, visit starts with the last(the biggest) key and walk
+ * toward the smallest.
+ *
+ * @prev_or_next, bool value to specify the visit direction.
+ *
+ * @callback. Your function that is called in the visit loop with each key-value
+ * visited.
+ * If a function like : bool myfunc(const unsigned long *key, const void *val)
+ * is given to the param @callback, you will see every *key and *val from the
+ * start @key(included, and it's value). Your function's return value of 0
+ * indicates to continue visit and 1 to exit the loop.
+ *
+ * */
+size_t btree_blue_traverse_from_key(struct btree_blue_head *head,
+				    unsigned long *key,
+				    btree_blue_traverse_FN_T callback,
+				    bool prev_or_next);
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index ce2abffb9ed8..0e15f0b0781f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -466,6 +466,10 @@ config TEXTSEARCH_FSM
 config BTREE
 	bool
 
+config BTREE_BLUE
+	tristate
+	default m
+
 config INTERVAL_TREE
 	bool
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 4d9461bfea42..304b265fc736 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -152,6 +152,7 @@ obj-$(CONFIG_TRACE_MMIO_ACCESS) += trace_readwrite.o
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 
 obj-$(CONFIG_BTREE) += btree.o
+obj-$(CONFIG_BTREE_BLUE) += btree_blue.o
 obj-$(CONFIG_INTERVAL_TREE) += interval_tree.o
 obj-$(CONFIG_ASSOCIATIVE_ARRAY) += assoc_array.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
diff --git a/lib/btree_blue.c b/lib/btree_blue.c
new file mode 100644
index 000000000000..496e0a1ad3c9
--- /dev/null
+++ b/lib/btree_blue.c
@@ -0,0 +1,994 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/btree_blue.h>
+#include <linux/cache.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+#define LONG_PER_U64 (64 / BITS_PER_LONG)
+#define MAX_KEYLEN (2 * LONG_PER_U64)
+#define VALUE_LEN (sizeof(unsigned long))
+
+struct btree_blue_slots_info {
+#if (BITS_PER_LONG == 32)
+	u16 slots_nr;
+	u16 offset;
+#else
+	u16 slots_nr;
+	u16 offset;
+	u16 reserved_a;
+	u16 reserved_b;
+#endif
+};
+
+struct btree_blue_node_cb {
+	struct btree_blue_slots_info slots_info;
+	unsigned long slots_base[];
+};
+
+struct btree_blue_stub {
+	unsigned long *prev;
+	unsigned long *next;
+};
+
+static struct kmem_cache *btree_blue_cachep;
+
+void *btree_blue_alloc(gfp_t gfp_mask, void *pool_data)
+{
+	return kmem_cache_alloc(btree_blue_cachep, gfp_mask);
+}
+EXPORT_SYMBOL_GPL(btree_blue_alloc);
+
+void btree_blue_free(void *element, void *pool_data)
+{
+	kmem_cache_free(btree_blue_cachep, element);
+}
+EXPORT_SYMBOL_GPL(btree_blue_free);
+
+static unsigned long *btree_blue_node_alloc(struct btree_blue_head *head,
+					    gfp_t gfp)
+{
+	unsigned long *node;
+
+	node = mempool_alloc(head->mempool, gfp);
+	if (likely(node))
+		memset(node, 0, head->node_size);
+	return node;
+}
+
+static int longcmp(const unsigned long *l1, const unsigned long *l2, size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++) {
+		if (l1[i] < l2[i])
+			return -1;
+		if (l1[i] > l2[i])
+			return 1;
+	}
+	return 0;
+}
+
+static unsigned long *longcpy(unsigned long *dest, const unsigned long *src,
+			      size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		dest[i] = src[i];
+	return dest;
+}
+
+static unsigned long *bkey(struct btree_blue_head *head,
+			   struct btree_blue_node_cb *cb, int n)
+{
+	return cb->slots_base + n * head->slot_width + 1;
+}
+
+static void *bval(struct btree_blue_head *head, struct btree_blue_node_cb *cb,
+		  int n)
+{
+	return (void *)(cb->slots_base[n * head->slot_width]);
+}
+
+static void setkey(struct btree_blue_head *head, struct btree_blue_node_cb *cb,
+		   int n, unsigned long *key)
+{
+	longcpy(bkey(head, cb, n), key, head->keylen);
+}
+
+static void setval(struct btree_blue_head *head, struct btree_blue_node_cb *cb,
+		   int n, void *val)
+{
+	cb->slots_base[n * head->slot_width] = (unsigned long)val;
+}
+
+static int keycmp(struct btree_blue_head *head, struct btree_blue_node_cb *cb,
+		  int pos, unsigned long *key)
+{
+	return longcmp(bkey(head, cb, pos), key, head->keylen);
+}
+
+static int getpos(struct btree_blue_head *head, struct btree_blue_node_cb *cb,
+		  unsigned long *key)
+{
+	int nr, q, r, i, p, c;
+
+	nr = cb->slots_info.slots_nr;
+	q = nr / 8;
+
+	for (i = 1; i <= q; i++) {
+		p = i * 8 - 1;
+		c = keycmp(head, cb, p, key);
+		if (c < 0) {
+			p = (i - 1) * 8;
+			for (i = 0; i < 7; i++) {
+				c = keycmp(head, cb, p, key);
+				if (c <= 0)
+					return p;
+				p++;
+			}
+			return p;
+
+		} else if (c == 0)
+			return p;
+	}
+
+	p = q * 8;
+	r = nr % 8;
+	for (i = 0; i < r; i++) {
+		c = keycmp(head, cb, p, key);
+		if (c <= 0)
+			return p;
+		p++;
+	}
+
+	return nr;
+}
+
+static int geteqv(struct btree_blue_head *head, struct btree_blue_node_cb *cb,
+		  unsigned long *key)
+{
+	int nr, q, r, i, p, c;
+
+	nr = cb->slots_info.slots_nr;
+	q = nr / 8;
+
+	for (i = 1; i <= q; i++) {
+		p = i * 8 - 1;
+		c = keycmp(head, cb, p, key);
+		if (c < 0) {
+			p = (i - 1) * 8;
+			for (i = 0; i < 7; i++) {
+				c = keycmp(head, cb, p, key);
+				if (c == 0)
+					return p;
+				p++;
+			}
+			return nr;
+		} else if (c == 0)
+			return p;
+	}
+
+	p = q * 8;
+	r = nr % 8;
+	for (i = 0; i < r; i++) {
+		c = keycmp(head, cb, p, key);
+		if (c == 0)
+			return p;
+		p++;
+	}
+
+	return nr;
+}
+
+/* binary search */
+/*
+static int getpos(struct btree_blue_head *head,
+		      struct btree_blue_node_cb *cb, unsigned long *key)
+{
+	int l = 0;
+	int h = cb->slots_info.slots_nr;
+	int m, ret;
+
+	while (l < h) {
+		m = (l + h) / 2;
+		ret = keycmp(head, cb, m, key);
+
+		if (ret < 0)
+			h = m;
+		else if (ret > 0)
+			l = m + 1;
+		else
+			return m;
+	}
+
+	return h;
+}
+
+static int geteqv(struct btree_blue_head *head,
+		      struct btree_blue_node_cb *cb, unsigned long *key)
+{
+	int l = 0;
+	int h, nr = cb->slots_info.slots_nr;
+	int m, ret;
+
+	while (l < h) {
+		m = (l + h) / 2;
+		ret = keycmp(head, cb, m, key);
+
+		if (ret < 0)
+			h = m;
+		else if (ret > 0)
+			l = m + 1;
+		else
+			return m;
+	}
+
+	return nr;
+}
+ */
+
+static inline struct btree_blue_stub *__get_stub(struct btree_blue_head *head,
+						 struct btree_blue_node_cb *cb)
+{
+	return (struct btree_blue_stub *)((char *)cb + head->stub_base);
+}
+
+static inline void _shift_slots(struct btree_blue_head *head,
+				struct btree_blue_node_cb *cb, int dest_slot,
+				int src_slot, size_t slots_nr)
+{
+	unsigned long *d = cb->slots_base + dest_slot * head->slot_width;
+	unsigned long *s = cb->slots_base + src_slot * head->slot_width;
+
+	size_t n = slots_nr * head->slot_width * sizeof(long);
+
+	memmove(d, s, n);
+}
+
+static inline void _transfer_slots(struct btree_blue_head *head,
+				   struct btree_blue_node_cb *dest,
+				   struct btree_blue_node_cb *src,
+				   int dest_slot, int src_slot, size_t slots_nr)
+{
+	unsigned long *d = dest->slots_base + dest_slot * head->slot_width;
+	unsigned long *s = src->slots_base + src_slot * head->slot_width;
+
+	size_t n = slots_nr * head->slot_width * sizeof(long);
+
+	memmove(d, s, n);
+}
+
+static inline int shift_slots_on_insert(struct btree_blue_head *head,
+					struct btree_blue_node_cb *node,
+					int pos, int level)
+{
+	int slots_nr = node->slots_info.slots_nr;
+	_shift_slots(head, node, pos + 1, pos, slots_nr - pos);
+	node->slots_info.slots_nr++;
+	return pos;
+}
+
+static inline void delete_slot(struct btree_blue_head *head,
+			       struct btree_blue_node_cb *node, int pos,
+			       int level)
+{
+	int slots_nr = node->slots_info.slots_nr;
+	_shift_slots(head, node, pos, pos + 1, slots_nr - pos - 1);
+	node->slots_info.slots_nr--;
+}
+
+static inline void split_to_empty(struct btree_blue_head *head,
+				  struct btree_blue_node_cb *dest,
+				  struct btree_blue_node_cb *src, int level)
+{
+	int slots_nr = src->slots_info.slots_nr / 2;
+
+	_transfer_slots(head, dest, src, 0, 0, slots_nr);
+	dest->slots_info.slots_nr += slots_nr;
+
+	_shift_slots(head, src, 0, slots_nr,
+		     src->slots_info.slots_nr - slots_nr);
+	src->slots_info.slots_nr -= slots_nr;
+}
+
+static inline void merge_nodes(struct btree_blue_head *head,
+			       struct btree_blue_node_cb *dest,
+			       struct btree_blue_node_cb *src, int level)
+{
+	int dest_nr, src_nr;
+
+	dest_nr = dest->slots_info.slots_nr;
+	src_nr = src->slots_info.slots_nr;
+
+	_transfer_slots(head, dest, src, dest_nr, 0, src_nr);
+	dest->slots_info.slots_nr += src_nr;
+}
+
+void *btree_blue_first(struct btree_blue_head *head, unsigned long *__key)
+{
+	int height = head->height;
+	struct btree_blue_node_cb *node =
+		(struct btree_blue_node_cb *)head->node;
+
+	if (height == 0)
+		return NULL;
+
+	for (; height > 1; height--)
+		node = bval(head, node, node->slots_info.slots_nr - 1);
+
+	longcpy(__key, bkey(head, node, node->slots_info.slots_nr - 1),
+		head->keylen);
+
+	return bval(head, node, node->slots_info.slots_nr - 1);
+}
+EXPORT_SYMBOL_GPL(btree_blue_first);
+
+void *btree_blue_last(struct btree_blue_head *head, unsigned long *__key)
+{
+	int height = head->height;
+	struct btree_blue_node_cb *node =
+		(struct btree_blue_node_cb *)head->node;
+
+	if (height == 0)
+		return NULL;
+	for (; height > 1; height--)
+		node = bval(head, node, 0);
+
+	longcpy(__key, bkey(head, node, 0), head->keylen);
+
+	return bval(head, node, 0);
+}
+EXPORT_SYMBOL_GPL(btree_blue_last);
+
+static unsigned long *btree_blue_lookup_node(struct btree_blue_head *head,
+					     unsigned long *key)
+{
+	int pos, height;
+	struct btree_blue_node_cb *node;
+
+	height = head->height;
+	if (height == 0)
+		return NULL;
+
+	node = (struct btree_blue_node_cb *)head->node;
+
+	for (; height > 1; height--) {
+		pos = getpos(head, node, key);
+		if (pos == node->slots_info.slots_nr)
+			return NULL;
+
+		node = bval(head, node, pos);
+	}
+
+	return (unsigned long *)node;
+}
+
+void *btree_blue_lookup(struct btree_blue_head *head, unsigned long *key)
+{
+	int pos;
+	struct btree_blue_node_cb *node;
+
+	node = (struct btree_blue_node_cb *)btree_blue_lookup_node(head, key);
+	if (!node)
+		return NULL;
+
+	pos = geteqv(head, node, key);
+	if (pos == node->slots_info.slots_nr)
+		return NULL;
+
+	return bval(head, node, pos);
+}
+EXPORT_SYMBOL_GPL(btree_blue_lookup);
+
+int btree_blue_update(struct btree_blue_head *head, unsigned long *key,
+		      void *val)
+{
+	int pos;
+	struct btree_blue_node_cb *node;
+
+	node = (struct btree_blue_node_cb *)btree_blue_lookup_node(head, key);
+	if (!node)
+		return -ENOENT;
+
+	pos = geteqv(head, node, key);
+	/*pos = geteqv_bin(head, node, key);*/
+
+	if (pos == node->slots_info.slots_nr)
+		return -ENOENT;
+
+	setval(head, node, pos, val);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btree_blue_update);
+
+void *btree_blue_prev_or_next(struct btree_blue_head *head,
+			      unsigned long *__key, int flag)
+{
+	int i;
+	struct btree_blue_node_cb *node;
+	unsigned long key[MAX_KEYLEN];
+	int slots_nr;
+
+	if (head->height == 0)
+		return NULL;
+
+	longcpy(key, __key, head->keylen);
+
+	node = (struct btree_blue_node_cb *)btree_blue_lookup_node(head, key);
+	if (!node)
+		return NULL;
+
+	slots_nr = node->slots_info.slots_nr;
+	for (i = 0; i < slots_nr; i++)
+		if (keycmp(head, node, i, key) == 0)
+			break;
+	if (i == slots_nr)
+		return NULL;
+
+	if (flag == GET_PREV) {
+		if (++i < slots_nr) {
+			longcpy(__key, bkey(head, node, i), head->keylen);
+			return bval(head, node, i);
+		} else {
+			struct btree_blue_stub *stub = __get_stub(head, node);
+			if (stub->next) {
+				node = (struct btree_blue_node_cb *)(stub->next);
+				longcpy(__key, bkey(head, node, 0),
+					head->keylen);
+				return bval(head, node, 0);
+			} else
+				return NULL;
+		}
+	}
+
+	/* GET_NEXT  */
+
+	if (i > 0) {
+		--i;
+		longcpy(__key, bkey(head, node, i), head->keylen);
+		return bval(head, node, i);
+	} else {
+		struct btree_blue_stub *stub = __get_stub(head, node);
+		if (stub->prev) {
+			node = (struct btree_blue_node_cb *)(stub->prev);
+			longcpy(__key,
+				bkey(head, node, node->slots_info.slots_nr - 1),
+				head->keylen);
+			return bval(head, node, 0);
+		} else
+			return NULL;
+	}
+}
+
+void *btree_blue_get_prev(struct btree_blue_head *head, unsigned long *__key)
+{
+	return btree_blue_prev_or_next(head, __key, GET_PREV);
+}
+EXPORT_SYMBOL_GPL(btree_blue_get_prev);
+
+void *btree_blue_get_next(struct btree_blue_head *head, unsigned long *__key)
+{
+	return btree_blue_prev_or_next(head, __key, GET_NEXT);
+}
+EXPORT_SYMBOL_GPL(btree_blue_get_next);
+
+size_t btree_blue_traverse_from_key(struct btree_blue_head *head,
+				    unsigned long *key,
+				    btree_blue_traverse_FN_T callback,
+				    bool prev_or_next)
+{
+	struct btree_blue_node_cb *node;
+	struct btree_blue_stub *stub;
+	int i, slots_nr, height;
+	bool term;
+	unsigned long found_key[MAX_KEYLEN];
+	unsigned long found_val;
+	size_t total = 0;
+
+	height = head->height;
+	if (height == 0)
+		return total;
+
+	node = (struct btree_blue_node_cb *)(head->node);
+
+	if (key == NULL) {
+		for (; height > 1; height--)
+			node = bval(head, node, 0);
+
+		i = 0;
+		slots_nr = node->slots_info.slots_nr;
+		longcpy(found_key, bkey(head, node, i), head->keylen);
+		found_val = (unsigned long)bval(head, node, i);
+		term = callback((const unsigned long *)(&found_key),
+				(const void *)found_val);
+		total++;
+		if (term)
+			return total;
+		else
+			goto TRAVERSE;
+	}
+
+	node = (struct btree_blue_node_cb *)btree_blue_lookup_node(head, key);
+	if (!node)
+		return total;
+
+	slots_nr = node->slots_info.slots_nr;
+	for (i = 0; i < slots_nr; i++)
+		if (keycmp(head, node, i, (unsigned long *)key) == 0)
+			break;
+
+	if (i == slots_nr)
+		return total;
+
+	longcpy(found_key, bkey(head, node, i), head->keylen);
+	found_val = (unsigned long)bval(head, node, i);
+	term = callback((const unsigned long *)(&found_key),
+			(const void *)found_val);
+	total++;
+	if (term)
+		return total;
+
+TRAVERSE:
+
+	if (prev_or_next == GET_PREV) {
+		i = i + 1;
+		do {
+			if (i < slots_nr) {
+				longcpy(found_key, bkey(head, node, i),
+					head->keylen);
+				found_val = (unsigned long)bval(head, node, i);
+				term = callback(
+					(const unsigned long *)(&found_key),
+					(const void *)found_val);
+				total++;
+				if (term)
+					return total;
+				i++;
+			} else {
+				stub = __get_stub(head, node);
+				if (stub->next) {
+					node = (struct btree_blue_node_cb
+							*)(stub->next);
+					slots_nr = node->slots_info.slots_nr;
+					i = 0;
+				} else
+					return total;
+			}
+		} while (true);
+	}
+
+	/* GET_NEXT */
+	i = i - 1;
+	do {
+		if (i >= 0) {
+			longcpy(found_key, bkey(head, node, i), head->keylen);
+			found_val = (unsigned long)bval(head, node, i);
+			term = callback((const unsigned long *)(&found_key),
+					(const void *)found_val);
+			total++;
+			if (term)
+				return total;
+			i--;
+		} else {
+			stub = __get_stub(head, node);
+			if (stub->prev) {
+				node = (struct btree_blue_node_cb *)(stub->prev);
+				i = node->slots_info.slots_nr - 1;
+			} else
+				return total;
+		}
+	} while (true);
+}
+EXPORT_SYMBOL_GPL(btree_blue_traverse_from_key);
+
+static unsigned long *find_level(struct btree_blue_head *head,
+				 unsigned long *key, int level,
+				 struct btree_blue_node_cb **cb_p)
+{
+	struct btree_blue_node_cb *node =
+		(struct btree_blue_node_cb *)head->node;
+	struct btree_blue_node_cb *node_p = node;
+	int height = head->height;
+	int pos;
+
+	for (; height > level; height--) {
+		pos = getpos(head, node, key);
+		if (pos == node->slots_info.slots_nr) {
+			/* right-most key is too large, update it */
+			/* FIXME: If the right-most key on higher levels is
+			 * always zero, this wouldn't be necessary. */
+			pos--;
+			setkey(head, node, pos, key);
+		}
+
+		BUG_ON(pos < 0);
+		node_p = node;
+		node = bval(head, node, pos);
+	}
+
+	BUG_ON(!node);
+	*cb_p = node_p;
+	return (unsigned long *)node;
+}
+
+static int btree_blue_grow(struct btree_blue_head *head, gfp_t gfp)
+{
+	struct btree_blue_node_cb *node, *node_h;
+
+	node = (struct btree_blue_node_cb *)btree_blue_node_alloc(head, gfp);
+	if (!node)
+		return -ENOMEM;
+
+	if (likely(head->node)) {
+		node_h = (struct btree_blue_node_cb *)head->node;
+		setkey(head, node, 0,
+		       bkey(head, node_h, node_h->slots_info.slots_nr - 1));
+		setval(head, node, 0, head->node);
+		node->slots_info.slots_nr = 1;
+	}
+
+	head->node = (unsigned long *)node;
+	head->height++;
+
+	return 0;
+}
+
+static void btree_blue_shrink(struct btree_blue_head *head)
+{
+	struct btree_blue_node_cb *node;
+
+	if (head->height <= 1)
+		return;
+
+	node = (struct btree_blue_node_cb *)head->node;
+	BUG_ON(node->slots_info.slots_nr > 1);
+
+	head->node = bval(head, node, 0);
+	head->height--;
+
+	mempool_free(node, head->mempool);
+}
+
+static int btree_blue_insert_level(struct btree_blue_head *head,
+				   unsigned long *key, void *val, int level,
+				   struct btree_blue_node_cb *found, gfp_t gfp)
+{
+	struct btree_blue_node_cb *cb, *cb_new, *cb_p;
+	int pos, slots_nr, err;
+
+	BUG_ON(!val);
+
+	if (head->height < level) {
+		err = btree_blue_grow(head, gfp);
+		if (err)
+			return err;
+
+		found = 0;
+	}
+
+	if (found) {
+		cb = found;
+		cb_p = NULL;
+	} else
+		cb = (struct btree_blue_node_cb *)find_level(head, key, level,
+							     &cb_p);
+
+	pos = getpos(head, cb, key);
+	/* two identical keys are not allowed */
+	BUG_ON(pos < slots_nr && keycmp(head, cb, pos, key) == 0);
+
+	slots_nr = cb->slots_info.slots_nr;
+
+	if (slots_nr == head->vols[level]) {
+		/* need to split node */
+		struct btree_blue_node_cb *cb_prev;
+		struct btree_blue_stub *stub, *stub_new, *stub_prev;
+
+		cb_new = (struct btree_blue_node_cb *)btree_blue_node_alloc(
+			head, gfp);
+		if (!cb_new)
+			return -ENOMEM;
+
+		err = btree_blue_insert_level(head,
+					      bkey(head, cb, slots_nr / 2 - 1),
+					      cb_new, level + 1, cb_p, gfp);
+		if (err) {
+			mempool_free(cb_new, head->mempool);
+			return err;
+		}
+
+		if (level == 1) {
+			stub = __get_stub(head, cb);
+			stub_new = __get_stub(head, cb_new);
+			stub_new->next = (unsigned long *)cb;
+
+			if (stub->prev) {
+				cb_prev = (struct btree_blue_node_cb
+						   *)(stub->prev);
+				stub_prev = __get_stub(head, cb_prev);
+				stub_prev->next = (unsigned long *)cb_new;
+				stub_new->prev = stub->prev;
+			}
+			stub->prev = (unsigned long *)cb_new;
+		}
+
+		split_to_empty(head, cb_new, cb, level);
+
+		if (pos <= (slots_nr / 2 - 1)) {
+			slots_nr = slots_nr / 2;
+			cb = cb_new;
+		} else {
+			pos = pos - slots_nr / 2;
+			slots_nr = slots_nr - slots_nr / 2;
+		}
+	}
+
+	BUG_ON(slots_nr >= head->vols[level]);
+
+	/* shift and insert */
+	//pos = shift_slots_on_insert(head, cb, pos, level);
+	_shift_slots(head, cb, pos + 1, pos, slots_nr - pos);
+	cb->slots_info.slots_nr++;
+
+	setkey(head, cb, pos, key);
+	setval(head, cb, pos, val);
+
+	return 0;
+}
+
+int btree_blue_insert(struct btree_blue_head *head, unsigned long *key,
+		      void *val, gfp_t gfp)
+{
+	BUG_ON(!val);
+	return btree_blue_insert_level(head, key, val, 1, 0, gfp);
+}
+EXPORT_SYMBOL_GPL(btree_blue_insert);
+
+static void *btree_blue_remove_level(struct btree_blue_head *head,
+				     unsigned long *key, int level);
+
+static void merge(struct btree_blue_head *head, int level,
+		  struct btree_blue_node_cb *cb_left,
+		  struct btree_blue_node_cb *cb_right,
+		  struct btree_blue_node_cb *cb_parent, int lpos)
+{
+	struct btree_blue_node_cb *cb_right_right;
+
+	struct btree_blue_stub *stub_left, *stub_right, *stub_right_right;
+
+	/* Move all keys to the left */
+	merge_nodes(head, cb_left, cb_right, level);
+
+	if (level == 1) {
+		stub_left = __get_stub(head, cb_left);
+		stub_right = __get_stub(head, cb_right);
+
+		if (stub_right->next) {
+			stub_left->next = stub_right->next;
+
+			cb_right_right =
+				(struct btree_blue_node_cb *)(stub_right->next);
+			stub_right_right = __get_stub(head, cb_right_right);
+			stub_right_right->prev = (unsigned long *)cb_left;
+		} else
+			stub_left->next = NULL;
+	}
+
+	/* Exchange left and right child in parent */
+	setval(head, cb_parent, lpos, cb_right);
+	setval(head, cb_parent, lpos + 1, cb_left);
+	/* Remove left (formerly right) child from parent */
+	btree_blue_remove_level(head, bkey(head, cb_parent, lpos), level + 1);
+	mempool_free(cb_right, head->mempool);
+}
+
+static void rebalance(struct btree_blue_head *head, unsigned long *key,
+		      int level, struct btree_blue_node_cb *cb_child,
+		      struct btree_blue_node_cb *cb_p)
+{
+	struct btree_blue_node_cb *cb_parent, *cb_left, *cb_right;
+	struct btree_blue_stub *stub_child, *stub_left, *stub_right;
+	int i;
+	int slots_nr, slots_nr_left, slots_nr_right;
+
+	slots_nr = cb_child->slots_info.slots_nr;
+
+	if (slots_nr == 0) {
+		/* Because we don't steal entries from a neighbour, this case
+		 * can happen.  Parent node contains a single child, this
+		 * node, so merging with a sibling never happens.
+		 */
+		btree_blue_remove_level(head, key, level + 1);
+
+		if (level == 1) {
+			stub_child = __get_stub(head, cb_child);
+			if (stub_child->prev) {
+				cb_left = (struct btree_blue_node_cb
+						   *)(stub_child->prev);
+				stub_left = __get_stub(head, cb_left);
+				stub_left->next = stub_child->next ?
+								stub_child->next :
+								NULL;
+			}
+
+			if (stub_child->next) {
+				cb_right = (struct btree_blue_node_cb
+						    *)(stub_child->next);
+				stub_right = __get_stub(head, cb_right);
+				stub_right->prev = stub_child->prev ?
+								 stub_child->prev :
+								 NULL;
+			}
+		}
+
+		mempool_free(cb_child, head->mempool);
+		return;
+	}
+
+	cb_parent = cb_p;
+
+	i = getpos(head, cb_parent, key);
+	BUG_ON(bval(head, cb_parent, i) != cb_child);
+
+	if (i > 0) {
+		cb_left = bval(head, cb_parent, i - 1);
+		slots_nr_left = cb_left->slots_info.slots_nr;
+
+		if (slots_nr_left + slots_nr <= head->vols[level]) {
+			merge(head, level, cb_left, cb_child, cb_parent, i - 1);
+			return;
+		}
+	}
+
+	if (i + 1 < cb_parent->slots_info.slots_nr) {
+		cb_right = bval(head, cb_parent, i + 1);
+		slots_nr_right = cb_right->slots_info.slots_nr;
+
+		if (slots_nr + slots_nr_right <= head->vols[level]) {
+			merge(head, level, cb_child, cb_right, cb_parent, i);
+			return;
+		}
+	}
+	/*
+	 * We could also try to steal one entry from the left or right
+	 * neighbor.  By not doing so we changed the invariant from
+	 * "all nodes are at least half full" to "no two neighboring
+	 * nodes can be merged".  Which means that the average fill of
+	 * all nodes is still half or better.
+	 */
+}
+
+static void *btree_blue_remove_level(struct btree_blue_head *head,
+				     unsigned long *key, int level)
+{
+	struct btree_blue_node_cb *cb, *cb_p;
+	int pos, slots_nr;
+	void *ret;
+
+	if (level > head->height) {
+		/* we recursed all the way up */
+		head->height = 0;
+		head->node = NULL;
+		return NULL;
+	}
+
+	cb = (struct btree_blue_node_cb *)find_level(head, key, level, &cb_p);
+	slots_nr = cb->slots_info.slots_nr;
+	pos = getpos(head, cb, key);
+
+	if ((level == 1) && (pos == slots_nr))
+		return NULL;
+
+	ret = bval(head, cb, pos);
+
+	/* remove and shift */
+	//delete_slot(head, cb, pos, level);
+	_shift_slots(head, cb, pos, pos + 1, slots_nr - pos - 1);
+	cb->slots_info.slots_nr--;
+
+	if (cb->slots_info.slots_nr < head->vols[level] / 2 - 2) {
+		if (level < head->height)
+			rebalance(head, key, level, cb, cb_p);
+		else if (cb->slots_info.slots_nr == 1)
+			btree_blue_shrink(head);
+	}
+
+	return ret;
+}
+
+void *btree_blue_remove(struct btree_blue_head *head, unsigned long *key)
+{
+	if (head->height == 0)
+		return NULL;
+
+	return btree_blue_remove_level(head, key, 1);
+}
+EXPORT_SYMBOL_GPL(btree_blue_remove);
+
+static inline void __btree_blue_init(struct btree_blue_head *head,
+				     int node_size, int keylen, int flags)
+{
+	int vol;
+
+	head->node = NULL;
+	head->height = 0;
+	head->node_size = node_size;
+	head->keylen = (keylen * 8) / BITS_PER_LONG;
+	head->slot_width = (VALUE_LEN * 8) / BITS_PER_LONG + head->keylen;
+
+	vol = (node_size - sizeof(struct btree_blue_node_cb)) /
+	      (head->slot_width * sizeof(long));
+	for (int i = 2; i < MAX_TREE_HEIGHT + 1; i++)
+		head->vols[i] = vol;
+	vol = (node_size - sizeof(struct btree_blue_node_cb) -
+	       sizeof(struct btree_blue_stub)) /
+	      (head->slot_width * sizeof(long));
+	head->vols[0] = head->vols[1] = vol;
+
+	head->stub_base = sizeof(struct btree_blue_node_cb) +
+			  head->vols[1] * (head->slot_width * sizeof(long));
+}
+
+int __must_check btree_blue_init(struct btree_blue_head *head,
+				 int node_size_in_byte, int key_len_in_byte,
+				 int flags)
+{
+	if (node_size_in_byte % L1_CACHE_BYTES)
+		return -EINVAL;
+
+	if ((node_size_in_byte < MIN_NODE_SIZE) ||
+	    (node_size_in_byte > PAGE_SIZE))
+		return -EINVAL;
+
+#if defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)
+	if ((key_len_in_byte != sizeof(unsigned long)) &&
+	    (key_len_in_byte != 2 * sizeof(unsigned long)))
+		return -EINVAL;
+#else
+	if ((key_len_in_byte != sizeof(unsigned long)) &&
+	    (key_len_in_byte != 2 * sizeof(unsigned long)) &&
+	    (key_len_in_byte != 4 * sizeof(unsigned long)))
+		return -EINVAL;
+#endif
+
+	btree_blue_cachep = kmem_cache_create("btree_blue_node_cb",
+					      node_size_in_byte, 0,
+					      SLAB_HWCACHE_ALIGN, NULL);
+	if (!btree_blue_cachep)
+		return -ENOMEM;
+
+	__btree_blue_init(head, node_size_in_byte, key_len_in_byte, flags);
+
+	head->mempool =
+		mempool_create(0, btree_blue_alloc, btree_blue_free, NULL);
+	if (!head->mempool)
+		return -ENOMEM;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btree_blue_init);
+
+void btree_blue_destroy(struct btree_blue_head *head)
+{
+	mempool_free(head->node, head->mempool);
+	mempool_destroy(head->mempool);
+	head->mempool = NULL;
+}
+EXPORT_SYMBOL_GPL(btree_blue_destroy);
+
+static int __init btree_blue_module_init(void)
+{
+	return 0;
+}
+
+static void __exit btree_blue_module_exit(void)
+{
+	kmem_cache_destroy(btree_blue_cachep);
+}
+
+module_init(btree_blue_module_init);
+module_exit(btree_blue_module_exit);
+
+MODULE_LICENSE("GPL");

base-commit: fbe1871b562af6e9cffcf622247e821d1dd16c64
-- 
2.30.2


