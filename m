Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F8E6F3CAB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 06:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjEBEYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 00:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBEYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 00:24:41 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0413AA4
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 21:24:35 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Q9Rmv3BkRz9sRB
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:24:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1683001471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/nRI+U132wahs+pOoA4I7jxF5L7Dm/65frW5NZ2OquY=;
        b=AVtIZZr95sxw66eh620H0gT0qDzLBvLIz70GCfTmLolyDfFv5vf8j5X3EDsbj++liRd2iR
        pUJlQUSrAr/hYstC3rZduY8d4uPBBhyrYVu7GOcjrKzqpsrkGwaW2oOvIF9c+ocruoBiqG
        A4dBcKvYWgAuffGMml7lfn5iOGR4opql4vxDRCL0pGk1WiE2k/P1OBZ1wo4GxrCkNhK2K0
        zYfmu3EnWVyechFgp/DIZ2ZFrBGDS7i0YXJHeV7E2G9Mmu5SQOxDDIA3ywJD1JDD3KWWCP
        I8IWmRa8E264A/NKo5/XiGh0ML8cptNeDcXmLDW8Hf4TVC0Sfw3Jn3rIx5p/ng==
Message-ID: <72815eaf53824399974ba5855298d207f6b30fe9.camel@mailbox.org>
Subject: Library: [RFC PATCH 1/3] btree_blue - A simple btree with fast
 linear traverse
From:   liuwf <liuwf@mailbox.org>
To:     linux-kernel@vger.kernel.org
Date:   Tue, 02 May 2023 00:23:07 -0400
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: yb4szcsfb8jfxi8h3d99muox5t6t965o
X-MBO-RS-ID: 9aa73e9ac728d6154c0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Library: [RFC PATCH 1/3] btree_blue - A simple btree with fast linear traverse

From: Liu Weifeng 4019c26b5c0d5f6b <liuwf@mailbox.org>

This version (V6) has two major revision besides test data:

1 Replaced old search functions existed in get_prev()/next() and traverse().
The old search functions impeded laters perf, especially for big node size. 
Now, new vesrion with 4096 bytes node size gets 100% faster for get_prev()/
get_next(), and 50% faster for traverse(), and this let traverse() with 4096
bytes node size run faster from 700%, 1100% than btree, rbtree to 1000%, 1400% 
respectively.

2 Added support of different node size between mid-nodes and leaf-nodes. This
let btree_blue get better perf when use big node size.


Note: 
As for tree traversal, currently I am unable to find how to let btree, maple 
tree to get prev() in a callback way (or "inner way"), this is a fast traverse
- if they have. 
so I'm apologized to compare btree_blue to get_prev() in callback way with 
btree in standalone function-call way, and failed to post maple tree's data.
I would be very appreciated if anyone show me the faster traverse in btree and 
maple tree, and I will refresh their test data in later patchs.


Test for btree_blue with 512 bytes node size


insert 1000000 random keys to a empty tree ...

						btree	rbtree	maple tree
** btree_blue is faster than others with:	40%	140%	370%

maple tree inserts 1000000 random keys use time: 	1130567298 ns
rbtree inserts 1000000 random keys use time: 		 567922552 ns
btree 1000000 inserts use time: 			 334896703 ns
btree_blue inserts 1000000 random keys use time: 	 238597859 ns


random search 1000000 keys in a tree which has those keys ...

						btree	rbtree	maple tree
** btree_blue is faster than others with:	35%	120%	19%

maple tree search 1000000 random keys use time: 	250588892 ns
rbtree search 1000000 random keys use time: 		481358810 ns
btree search 1000000 random keys use time: 		295143973 ns
btree_blue search 1000000 random keys use time: 	213524545 ns


1000000 random mixed insert + delete based on a tree which has 1000000 keys ...

						btree	rbtree	maple tree
** btree_blue is faster than others with:	40%	180%	350%

maple tree 1000000 random mixed insert + delete use time: 	2395519572 ns
rbtree 1000000 random mixed insert + delete use time: 		1505482449 ns
btree 1000000 random mixed insert + delete use time: 		 740865056 ns
btree_blue 1000000 random mixed insert + delete use time: 	 526020856 ns


get prev key in a tree which has 1000000 keys ...

# btree_blue use callback way				btree	rbtree
** btree_blue is faster than others with:		770%	1000%

# all in standalone function-call way			btree	rbtree
** btree_blue is faster than others with:		40%	80%

rbtree get 999999 prev keys use time: 				125563942 ns
btree get  999999 prev keys use time: 				 96824958 ns
btree_blue get 999999 prev keys use time: 			 68819831 ns
btree_blue get 1000000 prev keys in callback way use time 	 11165484 ns


random delete a tree which has 1000000 keys to empty ...

						btree	rbtree	maple tree
** btree_blue is faster than others with:	40%	160%	710%

maple tree random deletes 1000000 keys use time: 	1884726463 ns
rbtree random deletes 1000000 keys use time: 		 607711341 ns
btree random deletes 1000000 keys use time: 		 339519665 ns
btree_blue random deletes 1000000 keys use time: 	 235412079 ns



Test for btree_blue with 4096 bytes node size


insert 1000000 random keys to a empty tree ...

						btree	rbtree	maple tree
** btree_blue is faster than others with:	10%	100%	270%

maple tree inserts 1000000 random keys use time: 	1034812368 ns
rbtree inserts 1000000 random keys use time: 		 570123923 ns
btree 1000000 inserts use time: 			 306099366 ns
btree_blue inserts 1000000 random keys use time: 	 274876752 ns


random search 1000000 keys in a tree which has those keys ...

						btree	rbtree	maple tree
** btree_blue is faster than others with:	35%	170%	40%

maple tree search 1000000 random keys use time: 	257945888 ns
rbtree search 1000000 random keys use time: 		497525209 ns
btree search 1000000 random keys use time: 		248079462 ns
btree_blue search 1000000 random keys use time: 	181453016 ns


1000000 random mixed insert + delete based on a tree which has 1000000 keys ...

						btree	rbtree	maple tree
** btree_blue is faster than others with:	10%	100%	220%

maple tree 1000000 random mixed insert + delete use time: 	2453811687 ns
rbtree 1000000 random mixed insert + delete use time: 		1556638482 ns
tree 1000000 random mixed insert + delete use time: 		 836344661 ns
tree_blue 1000000 random mixed insert + delete use time: 	 756216346 ns


get prev key in a tree which has 1000000 keys ...

# btree_blue use callback way				btree	rbtree
** btree_blue is faster than others with:		1100%	1500%

# all in standalone function-call way			btree	rbtree
** btree_blue is faster than others with:		35%	80%

rbtree get 999999 prev keys use time: 				130549408 ns
btree get  999999 prev keys use time: 				 97368858 ns
btree_blue get  999999 prev keys use time: 	 		 71188277 ns
btree_blue get 1000000 prev keys in callback way use time 	  8084643 ns


random delete a tree which has 1000000 keys to empty ...

							btree	rbtree	maple tree
** btree_blue is faster than others with:		35%	150%	%650

maple tree random deletes 1000000 keys use time: 	1642422450 ns
rbtree random deletes 1000000 keys use time: 		 571219519 ns
tree random deletes 1000000 keys use time: 		 304089064 ns
btree_blue random deletes 1000000 keys use time: 	 216533261 ns


Signed-off-by: Liu Weifeng 4019c26b5c0d5f6b <liuwf@mailbox.org>
---
 include/linux/btree_blue.h |  85 ++++
 lib/Kconfig                |   8 +
 lib/Makefile               |   2 +
 lib/btree_blue.c           | 990 +++++++++++++++++++++++++++++++++++++
 lib/btree_blue_test.c      | 571 +++++++++++++++++++++
 5 files changed, 1656 insertions(+)
 create mode 100644 include/linux/btree_blue.h
 create mode 100644 lib/btree_blue.c
 create mode 100644 lib/btree_blue_test.c

diff --git a/include/linux/btree_blue.h b/include/linux/btree_blue.h
new file mode 100644
index 000000000000..2f1a7781c77b
--- /dev/null
+++ b/include/linux/btree_blue.h
@@ -0,0 +1,85 @@
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
+ * @return value. The API return the number of key-value pairs visited.
+ *
+ * */
+size_t btree_blue_traverse_from_key(struct btree_blue_head *head,
+				    unsigned long *key,
+				    btree_blue_traverse_FN_T callback,
+				    bool prev_or_next);
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index ce2abffb9ed8..fa0845bb59ac 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -466,6 +466,14 @@ config TEXTSEARCH_FSM
 config BTREE
 	bool
 
+config BTREE_BLUE
+	tristate
+	default m
+
+config BTREE_BLUE_TEST
+	tristate
+	default m
+
 config INTERVAL_TREE
 	bool
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 4d9461bfea42..463deb504073 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -152,6 +152,8 @@ obj-$(CONFIG_TRACE_MMIO_ACCESS) += trace_readwrite.o
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 
 obj-$(CONFIG_BTREE) += btree.o
+obj-$(CONFIG_BTREE_BLUE) += btree_blue.o
+obj-$(CONFIG_BTREE_BLUE_TEST) += btree_blue_test.o
 obj-$(CONFIG_INTERVAL_TREE) += interval_tree.o
 obj-$(CONFIG_ASSOCIATIVE_ARRAY) += assoc_array.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
diff --git a/lib/btree_blue.c b/lib/btree_blue.c
new file mode 100644
index 000000000000..ddde34f23139
--- /dev/null
+++ b/lib/btree_blue.c
@@ -0,0 +1,990 @@
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
+			p = p - 7;
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
+			p = p - 7;
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
+	bool stop;
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
+		stop = callback((const unsigned long *)found_key,
+				(const void *)found_val);
+		total++;
+		if (stop)
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
+	stop = callback((const unsigned long *)(&found_key),
+			(const void *)found_val);
+	total++;
+	if (stop)
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
+				stop = callback(
+					(const unsigned long *)found_key,
+					(const void *)found_val);
+				total++;
+				if (stop)
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
+
+	i = i - 1;
+	do {
+		if (i >= 0) {
+			longcpy(found_key, bkey(head, node, i), head->keylen);
+			found_val = (unsigned long)bval(head, node, i);
+			stop = callback((const unsigned long *)found_key,
+					(const void *)found_val);
+			total++;
+			if (stop)
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
+	if (!found)
+		cb = (struct btree_blue_node_cb *)find_level(head, key, level,
+							     &cb_p);
+	else {
+		cb = found;
+		cb_p = NULL;
+	}
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
+	head->keylen = (keylen * BITS_PER_BYTE) / BITS_PER_LONG;
+	head->slot_width =
+		(VALUE_LEN * BITS_PER_BYTE) / BITS_PER_LONG + head->keylen;
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
+	if ((key_len_in_byte != sizeof(unsigned long)) &&
+	    (key_len_in_byte != 2 * sizeof(unsigned long)))
+		return -EINVAL;
+
+	btree_blue_cachep = kmem_cache_create("btree_blue_node_buf",
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
diff --git a/lib/btree_blue_test.c b/lib/btree_blue_test.c
new file mode 100644
index 000000000000..b0a73836523d
--- /dev/null
+++ b/lib/btree_blue_test.c
@@ -0,0 +1,571 @@
+
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <linux/slab.h>
+
+#include <linux/rbtree.h>
+#include <linux/btree.h>
+#include <linux/maple_tree.h>
+#include <linux/btree_blue.h>
+
+#define RANDOM_NR (1000 * 1000 * 1UL)
+
+int node_size = 512;
+int key_len = 8;
+
+unsigned long total;
+
+struct key_value {
+	unsigned long k;
+	unsigned long v;
+};
+
+struct key_value data_set_1[RANDOM_NR];
+struct key_value data_set_2[RANDOM_NR];
+
+struct key_value result_set_1[RANDOM_NR];
+struct key_value result_set_2[RANDOM_NR];
+
+struct rbtree_entry {
+	struct rb_node node;
+	unsigned long k;
+	unsigned long v;
+};
+
+static struct rb_root rbtree_root;
+static struct rb_node *rbtree_node;
+static struct rbtree_entry *entry_ptr;
+static struct kmem_cache *rbtree_node_cache;
+
+static struct btree_head btree_root;
+
+static struct btree_blue_head btree_blue_root;
+
+static DEFINE_MTREE(maple_tree);
+
+static bool rbtree_entry_less(struct rb_node *node,
+			      const struct rb_node *parent)
+{
+	const struct rbtree_entry *entry, *exist;
+
+	entry = rb_entry(node, struct rbtree_entry, node);
+	exist = rb_entry(parent, struct rbtree_entry, node);
+
+	return entry->k < exist->k;
+}
+
+static int rbtree_entry_cmp(const void *k, const struct rb_node *n)
+{
+	const unsigned long key1 = *((const unsigned long *)k);
+
+	const struct rbtree_entry *e = rb_entry(n, struct rbtree_entry, node);
+	const unsigned long key2 = e->k;
+
+	if (key1 > key2)
+		return 1;
+	else if (key1 < key2)
+		return -1;
+
+	return 0;
+}
+
+static bool btree_blue_visit(const unsigned long *key, const void *val)
+{
+	total++;
+	return 0;
+}
+
+static bool btree_blue_visit_and_store(const unsigned long *key,
+				       const void *val)
+{
+	result_set_2[total].k = *key;
+	result_set_2[total].v = (unsigned long)val;
+	total++;
+	return 0;
+}
+
+static int btree_blue_test_init(void)
+{
+	int err;
+	long t0;
+
+	unsigned long key;
+	unsigned long *val_ptr;
+
+	rbtree_node_cache = kmem_cache_create("rbtree_buf",
+					      sizeof(struct rbtree_entry), 0,
+					      SLAB_HWCACHE_ALIGN, NULL);
+	if (!rbtree_node_cache) {
+		printk(KERN_EMERG "error: failed to init rbtree\n");
+		goto exit;
+	}
+	rbtree_root = RB_ROOT;
+
+	err = wait_for_random_bytes();
+	if (err) {
+		printk(KERN_EMERG "error: failed to collect randoms\n");
+		goto exit;
+	}
+	get_random_bytes(data_set_1, sizeof(data_set_1));
+
+	err = wait_for_random_bytes();
+	if (err) {
+		printk(KERN_EMERG "error: failed to collect randoms\n");
+		goto exit;
+	}
+	get_random_bytes(data_set_2, sizeof(data_set_2));
+
+	err = btree_init(&btree_root);
+	if (err) {
+		printk(KERN_EMERG "error: failed to init btree\n");
+		goto exit;
+	}
+
+	err = btree_blue_init(&btree_blue_root, node_size, key_len, 0);
+	if (err) {
+		printk(KERN_EMERG "error: failed to init btree_blue\n");
+		goto exit;
+	}
+
+	printk(KERN_EMERG "%lu inserts to a empty tree ...\n", RANDOM_NR);
+	err = 0;
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		err = mtree_insert(&maple_tree, data_set_1[i].k,
+				   (void *)(data_set_1[i].v), GFP_NOIO);
+		if (err) {
+			printk(KERN_EMERG
+			       "error: maple tree failed to insert\n");
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "maple tree %lu inserts use time: %lu ns\n",
+	       RANDOM_NR, t0);
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		entry_ptr = kmem_cache_zalloc(rbtree_node_cache, GFP_NOIO);
+		if (!entry_ptr) {
+			err = -1;
+			kmem_cache_destroy(rbtree_node_cache);
+			printk(KERN_EMERG "error: rbtree alloc node bad\n");
+			goto exit;
+		}
+		entry_ptr->k = data_set_1[i].k;
+		entry_ptr->v = data_set_1[i].v;
+		rb_add(&entry_ptr->node, &rbtree_root, rbtree_entry_less);
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "rbtree %lu inserts use time: %ld ns\n", RANDOM_NR,
+	       t0);
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
+	printk(KERN_EMERG "btree_blue %lu inserts use time: %ld ns\n",
+	       RANDOM_NR, t0);
+
+	printk(KERN_EMERG "%lu searches ...\n", RANDOM_NR);
+	err = 0;
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		key = data_set_1[i].k;
+		val_ptr = mt_find(&maple_tree, &key, ULONG_MAX);
+		if (!val_ptr) {
+			err = -1;
+			printk(KERN_EMERG
+			       "error: maple tree failed to search\n");
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "maple tree %lu searches use time: %lu ns\n",
+	       RANDOM_NR, t0);
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		key = data_set_1[i].k;
+		rbtree_node = rb_find(&key, &rbtree_root, rbtree_entry_cmp);
+		if (!rbtree_node) {
+			err = -1;
+			printk(KERN_EMERG "error: rbtree failed to search\n");
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "rbtree %lu searches use time: %ld ns\n", RANDOM_NR,
+	       t0);
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		key = data_set_1[i].k;
+		val_ptr = btree_lookup(&btree_root, &btree_geo64, &key);
+		if (!val_ptr) {
+			err = -1;
+			printk(KERN_EMERG "error: btree failed to search\n");
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "btree %lu searches use time: %ld ns\n", RANDOM_NR,
+	       t0);
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		key = data_set_1[i].k;
+		val_ptr = btree_blue_lookup(&btree_blue_root, &key);
+		if (!val_ptr) {
+			err = -1;
+			printk(KERN_EMERG
+			       "error: btree_blue failed to search at %ld!\n",
+			       i);
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "btree_blue %lu searches use time: %ld ns\n",
+	       RANDOM_NR, t0);
+
+	printk(KERN_EMERG
+	       "%lu mixed insert + delete based on a tree which has %lu keys ...\n",
+	       RANDOM_NR, RANDOM_NR);
+	err = 0;
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		err = mtree_insert(&maple_tree, data_set_2[i].k,
+				   (void *)(data_set_1[i].v), GFP_NOIO);
+		if (err) {
+			printk(KERN_EMERG
+			       "error: maple tree failed to insert with data_set_2\n");
+			goto exit;
+		}
+
+		val_ptr = mtree_erase(&maple_tree, data_set_1[i].k);
+		if (!val_ptr) {
+			err = -1;
+			printk(KERN_EMERG
+			       "error: maple tree failed to delete\n");
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG
+	       "maple tree %lu mixed insert + delete use time: %ld ns\n",
+	       RANDOM_NR, t0);
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		entry_ptr = kmem_cache_zalloc(rbtree_node_cache, GFP_NOIO);
+		if (!entry_ptr) {
+			err = -1;
+			kmem_cache_destroy(rbtree_node_cache);
+			printk(KERN_EMERG "error: rbtree alloc node bad\n");
+			goto exit;
+		}
+		entry_ptr->k = data_set_2[i].k;
+		entry_ptr->v = data_set_2[i].v;
+		rb_add(&(entry_ptr->node), &rbtree_root, rbtree_entry_less);
+
+		key = data_set_1[i].k;
+		rbtree_node = rb_find(&key, &rbtree_root, rbtree_entry_cmp);
+		if (!rbtree_node) {
+			err = -1;
+			printk(KERN_EMERG
+			       "rbtree failed to find key to delete\n");
+			goto exit;
+		}
+		rb_erase(rbtree_node, &rbtree_root);
+		entry_ptr = rb_entry(rbtree_node, struct rbtree_entry, node);
+		kmem_cache_free(rbtree_node_cache, entry_ptr);
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "rbtree %lu mixed insert + delete use time: %ld ns\n",
+	       RANDOM_NR, t0);
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		err = btree_insert(&btree_root, &btree_geo64,
+				   &(data_set_2[i].k),
+				   (void *)(data_set_2[i].v), GFP_NOIO);
+		if (err) {
+			printk(KERN_EMERG
+			       "error: btree failed to insert with data_set_2\n");
+			goto exit;
+		}
+
+		key = data_set_1[i].k;
+		val_ptr = btree_remove(&btree_root, &btree_geo64, &key);
+		if (!val_ptr) {
+			err = -1;
+			printk(KERN_EMERG "error: btree failed to delete\n");
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "btree %lu mixed insert + delete use time: %ld ns\n",
+	       RANDOM_NR, t0);
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		err = btree_blue_insert(&btree_blue_root, &(data_set_2[i].k),
+					(void *)(data_set_2[i].v), GFP_NOIO);
+		if (err) {
+			printk(KERN_EMERG
+			       "error: btree_blue failed to insert with data_set_2\n");
+			goto exit;
+		}
+
+		key = data_set_1[i].k;
+		val_ptr = btree_blue_remove(&btree_blue_root, &key);
+		if (!val_ptr) {
+			err = -1;
+			printk(KERN_EMERG
+			       "error: btree_blue failed to delete at %ld\n",
+			       i);
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG
+	       "btree_blue %lu mixed insert + delete use time: %ld ns\n",
+	       RANDOM_NR, t0);
+
+	printk(KERN_EMERG
+	       "get prev key in a tree which has %lu keys to empty ...\n",
+	       RANDOM_NR);
+	err = 0;
+
+	rbtree_node = rb_last(&rbtree_root);
+	if (!rbtree_node) {
+		printk(KERN_EMERG "rbtree failed to get the last node\n");
+		return -1;
+	}
+
+	t0 = ktime_get_ns();
+	for (long i = 1; i < RANDOM_NR; i++) {
+		rbtree_node = rb_prev(rbtree_node);
+		if (!rbtree_node) {
+			printk(KERN_EMERG "error: rbtree get prev failed\n");
+			return -1;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "rbtree get %lu prev keys use time: %lu ns\n",
+	       RANDOM_NR - 1, t0);
+
+	val_ptr = btree_last(&btree_root, &btree_geo64, &key);
+	if (!val_ptr) {
+		printk(KERN_EMERG "btree failed to get the last key\n");
+		return -1;
+	}
+
+	t0 = ktime_get_ns();
+	for (long i = 1; i < RANDOM_NR; i++) {
+		val_ptr = btree_get_prev(&btree_root, &btree_geo64, &key);
+		if (!val_ptr) {
+			printk(KERN_EMERG
+			       "error: btree get prev failed at i = %ld\n",
+			       i);
+			return -1;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "btree get %lu prev keys use time: %lu ns\n",
+	       RANDOM_NR - 1, t0);
+
+	val_ptr = btree_blue_last(&btree_blue_root, &key);
+	if (!val_ptr) {
+		printk(KERN_EMERG
+		       "error: btree_blue failed to get the last key\n");
+		return -1;
+	}
+
+	t0 = ktime_get_ns();
+	for (long i = 1; i < RANDOM_NR; i++) {
+		val_ptr = btree_blue_get_prev(&btree_blue_root, &key);
+		if (!val_ptr) {
+			printk(KERN_EMERG
+			       "error: btree_blue get prev failed at i = %ld\n",
+			       i);
+			return -1;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "btree_blue get %lu prev keys use time: %ld ns\n",
+	       RANDOM_NR - 1, t0);
+
+	t0 = ktime_get_ns();
+	total = 0;
+	total = btree_blue_traverse_from_key(&btree_blue_root, 0,
+					     btree_blue_visit, GET_PREV);
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG
+	       "btree_blue get %lu prev keys in traversal way use time %ld ns\n",
+	       total, t0);
+
+	printk(KERN_EMERG
+	       "verify btree_blue traversed %lu values with btree...\n",
+	       RANDOM_NR);
+
+	val_ptr = btree_last(&btree_root, &btree_geo64, &key);
+	if (!val_ptr) {
+		printk(KERN_EMERG "btree failed to get the last key\n");
+		return -1;
+	}
+	result_set_1[0].k = key;
+	result_set_1[0].v = (unsigned long)val_ptr;
+
+	for (long i = 1; i < RANDOM_NR; i++) {
+		val_ptr = btree_get_prev(&btree_root, &btree_geo64, &key);
+		if (!val_ptr) {
+			printk(KERN_EMERG
+			       "error: btree prev() failed at i = %ld\n",
+			       i);
+			return -1;
+		}
+		result_set_1[i].k = key;
+		result_set_1[i].v = (unsigned long)val_ptr;
+	}
+
+	total = 0;
+	total = btree_blue_traverse_from_key(
+		&btree_blue_root, 0, btree_blue_visit_and_store, GET_PREV);
+
+	for (long i = 0; i < RANDOM_NR; i++) {
+		if (result_set_1[i].k != result_set_2[i].k) {
+			printk(KERN_EMERG
+			       "error: btree_blue got wrong traversed key at i = %ld\n",
+			       i);
+			return -1;
+		}
+
+		if (result_set_1[i].v != result_set_2[i].v) {
+			printk(KERN_EMERG
+			       "error: btree_blue got wrong traversed value at i = %ld\n",
+			       i);
+			return -1;
+		}
+	}
+	printk(KERN_EMERG
+	       "btree_blue %lu traversed values are verified successfully\n",
+	       RANDOM_NR);
+
+	printk(KERN_EMERG "delete a tree which has %lu keys to empty ...\n",
+	       RANDOM_NR);
+	err = 0;
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		val_ptr = mtree_erase(&maple_tree, data_set_2[i].k);
+		if (!val_ptr) {
+			err = -1;
+			printk(KERN_EMERG
+			       "error: maple tree failed to delete\n");
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "maple tree %lu deletes use time: %ld ns\n",
+	       RANDOM_NR, t0);
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		rbtree_node = rb_find(&(data_set_2[i].k), &rbtree_root,
+				      rbtree_entry_cmp);
+		if (!rbtree_node) {
+			err = -1;
+			printk(KERN_EMERG
+			       "rbtree failed to find key to delete\n");
+			goto exit;
+		}
+		rb_erase(rbtree_node, &rbtree_root);
+		entry_ptr = rb_entry(rbtree_node, struct rbtree_entry, node);
+		kmem_cache_free(rbtree_node_cache, entry_ptr);
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "rbtree %lu deletes use time: %ld ns\n", RANDOM_NR,
+	       t0);
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		val_ptr = btree_remove(&btree_root, &btree_geo64,
+				       &(data_set_2[i].k));
+		if (!val_ptr) {
+			err = -1;
+			printk(KERN_EMERG
+			       "error: btree failed to delete data_set_2\n");
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "btree %lu deletes use time: %lu ns\n", RANDOM_NR,
+	       t0);
+
+	t0 = ktime_get_ns();
+	for (long i = 0; i < RANDOM_NR; i++) {
+		val_ptr =
+			btree_blue_remove(&btree_blue_root, &(data_set_2[i].k));
+		if (!val_ptr) {
+			err = -1;
+			printk(KERN_EMERG
+			       "error: btree_blue failed to delete at %ld\n",
+			       i);
+			goto exit;
+		}
+	}
+	t0 = ktime_get_ns() - t0;
+	printk(KERN_EMERG "btree_blue %lu deletes use time: %lu ns\n",
+	       RANDOM_NR, t0);
+
+exit:
+
+	rbtree_root = RB_ROOT;
+	if (rbtree_node_cache)
+		kmem_cache_destroy(rbtree_node_cache);
+
+	mtree_destroy(&maple_tree);
+	btree_destroy(&btree_root);
+	btree_blue_destroy(&btree_blue_root);
+
+	if (!err) {
+		printk(KERN_EMERG "Test successfully finished.\n");
+		return 0;
+	} else
+		return -1;
+}
+
+static void btree_blue_test_exit(void)
+{
+	printk(KERN_EMERG "btree_blue test module exiting ... Good-bye\n");
+}
+
+module_init(btree_blue_test_init);
+module_exit(btree_blue_test_exit);
+MODULE_LICENSE("GPL");

base-commit: fbe1871b562af6e9cffcf622247e821d1dd16c64
-- 
2.30.2


