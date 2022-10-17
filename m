Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A205B6011E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiJQO40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJQOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE55688BA;
        Mon, 17 Oct 2022 07:54:01 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=asVZrHtHnzUJtBpY2fkXrM0v0VaS9qpw6SZfXN2eyHY=;
        b=FD2NueMI5BfJ4C+FzsUHYUgxAV4mWGtUXudVLlkixdUBgCz7I9+odkObhfb5HeHp+WEObQ
        XFa0P1UtQn8V+Gj6fSzZFFls9yo+uxhGlBVJA5UloYad/k8ATrboB2r/WqLA3JkgBswf1W
        XX0l0JYy0xhIbFH0Ar/fWrIw2pV3GwX/OHw3kNtePKHMMUXuB0kegK4iYlDguVCDhU18bD
        UESFUpf42wuAPBpluyzj+CvNK4nBjPTQaBpbdTx9CGbzG7qT27wqzbgz4vkdbFaqMKFKwo
        Z7vyPNThCQweM745noQjeGdi21IyxfsGUfw9CHF8WmYoVc5HucYvY5/lw8fAvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=asVZrHtHnzUJtBpY2fkXrM0v0VaS9qpw6SZfXN2eyHY=;
        b=4348Q88V5Achoo7QiqVjuJEDJIa1wDS86Ahk7r7Sxm1+c63qy93YGctAI+wDvGxXgCKoGS
        RoNxv0FGGezV3NAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Fix find_{symbol,func}_containing()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111146.330203761@infradead.org>
References: <20220915111146.330203761@infradead.org>
MIME-Version: 1.0
Message-ID: <166601843798.401.7150470948315306838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5da6aea375cde499fdfac3cde4f26df4a840eb9f
Gitweb:        https://git.kernel.org/tip/5da6aea375cde499fdfac3cde4f26df4a840eb9f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:08 +02:00

objtool: Fix find_{symbol,func}_containing()

The current find_{symbol,func}_containing() functions are broken in
the face of overlapping symbols, exactly the case that is needed for a
new ibt/endbr supression.

Import interval_tree_generic.h into the tools tree and convert the
symbol tree to an interval tree to support proper range stabs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111146.330203761@infradead.org
---
 tools/include/linux/interval_tree_generic.h | 187 +++++++++++++++++++-
 tools/objtool/elf.c                         |  93 +++------
 tools/objtool/include/objtool/elf.h         |   3 +-
 3 files changed, 229 insertions(+), 54 deletions(-)
 create mode 100644 tools/include/linux/interval_tree_generic.h

diff --git a/tools/include/linux/interval_tree_generic.h b/tools/include/linux/interval_tree_generic.h
new file mode 100644
index 0000000..aaa8a07
--- /dev/null
+++ b/tools/include/linux/interval_tree_generic.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+  Interval Trees
+  (C) 2012  Michel Lespinasse <walken@google.com>
+
+
+  include/linux/interval_tree_generic.h
+*/
+
+#include <linux/rbtree_augmented.h>
+
+/*
+ * Template for implementing interval trees
+ *
+ * ITSTRUCT:   struct type of the interval tree nodes
+ * ITRB:       name of struct rb_node field within ITSTRUCT
+ * ITTYPE:     type of the interval endpoints
+ * ITSUBTREE:  name of ITTYPE field within ITSTRUCT holding last-in-subtree
+ * ITSTART(n): start endpoint of ITSTRUCT node n
+ * ITLAST(n):  last endpoint of ITSTRUCT node n
+ * ITSTATIC:   'static' or empty
+ * ITPREFIX:   prefix to use for the inline tree definitions
+ *
+ * Note - before using this, please consider if generic version
+ * (interval_tree.h) would work for you...
+ */
+
+#define INTERVAL_TREE_DEFINE(ITSTRUCT, ITRB, ITTYPE, ITSUBTREE,		      \
+			     ITSTART, ITLAST, ITSTATIC, ITPREFIX)	      \
+									      \
+/* Callbacks for augmented rbtree insert and remove */			      \
+									      \
+RB_DECLARE_CALLBACKS_MAX(static, ITPREFIX ## _augment,			      \
+			 ITSTRUCT, ITRB, ITTYPE, ITSUBTREE, ITLAST)	      \
+									      \
+/* Insert / remove interval nodes from the tree */			      \
+									      \
+ITSTATIC void ITPREFIX ## _insert(ITSTRUCT *node,			      \
+				  struct rb_root_cached *root)	 	      \
+{									      \
+	struct rb_node **link = &root->rb_root.rb_node, *rb_parent = NULL;    \
+	ITTYPE start = ITSTART(node), last = ITLAST(node);		      \
+	ITSTRUCT *parent;						      \
+	bool leftmost = true;						      \
+									      \
+	while (*link) {							      \
+		rb_parent = *link;					      \
+		parent = rb_entry(rb_parent, ITSTRUCT, ITRB);		      \
+		if (parent->ITSUBTREE < last)				      \
+			parent->ITSUBTREE = last;			      \
+		if (start < ITSTART(parent))				      \
+			link = &parent->ITRB.rb_left;			      \
+		else {							      \
+			link = &parent->ITRB.rb_right;			      \
+			leftmost = false;				      \
+		}							      \
+	}								      \
+									      \
+	node->ITSUBTREE = last;						      \
+	rb_link_node(&node->ITRB, rb_parent, link);			      \
+	rb_insert_augmented_cached(&node->ITRB, root,			      \
+				   leftmost, &ITPREFIX ## _augment);	      \
+}									      \
+									      \
+ITSTATIC void ITPREFIX ## _remove(ITSTRUCT *node,			      \
+				  struct rb_root_cached *root)		      \
+{									      \
+	rb_erase_augmented_cached(&node->ITRB, root, &ITPREFIX ## _augment);  \
+}									      \
+									      \
+/*									      \
+ * Iterate over intervals intersecting [start;last]			      \
+ *									      \
+ * Note that a node's interval intersects [start;last] iff:		      \
+ *   Cond1: ITSTART(node) <= last					      \
+ * and									      \
+ *   Cond2: start <= ITLAST(node)					      \
+ */									      \
+									      \
+static ITSTRUCT *							      \
+ITPREFIX ## _subtree_search(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
+{									      \
+	while (true) {							      \
+		/*							      \
+		 * Loop invariant: start <= node->ITSUBTREE		      \
+		 * (Cond2 is satisfied by one of the subtree nodes)	      \
+		 */							      \
+		if (node->ITRB.rb_left) {				      \
+			ITSTRUCT *left = rb_entry(node->ITRB.rb_left,	      \
+						  ITSTRUCT, ITRB);	      \
+			if (start <= left->ITSUBTREE) {			      \
+				/*					      \
+				 * Some nodes in left subtree satisfy Cond2.  \
+				 * Iterate to find the leftmost such node N.  \
+				 * If it also satisfies Cond1, that's the     \
+				 * match we are looking for. Otherwise, there \
+				 * is no matching interval as nodes to the    \
+				 * right of N can't satisfy Cond1 either.     \
+				 */					      \
+				node = left;				      \
+				continue;				      \
+			}						      \
+		}							      \
+		if (ITSTART(node) <= last) {		/* Cond1 */	      \
+			if (start <= ITLAST(node))	/* Cond2 */	      \
+				return node;	/* node is leftmost match */  \
+			if (node->ITRB.rb_right) {			      \
+				node = rb_entry(node->ITRB.rb_right,	      \
+						ITSTRUCT, ITRB);	      \
+				if (start <= node->ITSUBTREE)		      \
+					continue;			      \
+			}						      \
+		}							      \
+		return NULL;	/* No match */				      \
+	}								      \
+}									      \
+									      \
+ITSTATIC ITSTRUCT *							      \
+ITPREFIX ## _iter_first(struct rb_root_cached *root,			      \
+			ITTYPE start, ITTYPE last)			      \
+{									      \
+	ITSTRUCT *node, *leftmost;					      \
+									      \
+	if (!root->rb_root.rb_node)					      \
+		return NULL;						      \
+									      \
+	/*								      \
+	 * Fastpath range intersection/overlap between A: [a0, a1] and	      \
+	 * B: [b0, b1] is given by:					      \
+	 *								      \
+	 *         a0 <= b1 && b0 <= a1					      \
+	 *								      \
+	 *  ... where A holds the lock range and B holds the smallest	      \
+	 * 'start' and largest 'last' in the tree. For the later, we	      \
+	 * rely on the root node, which by augmented interval tree	      \
+	 * property, holds the largest value in its last-in-subtree.	      \
+	 * This allows mitigating some of the tree walk overhead for	      \
+	 * for non-intersecting ranges, maintained and consulted in O(1).     \
+	 */								      \
+	node = rb_entry(root->rb_root.rb_node, ITSTRUCT, ITRB);		      \
+	if (node->ITSUBTREE < start)					      \
+		return NULL;						      \
+									      \
+	leftmost = rb_entry(root->rb_leftmost, ITSTRUCT, ITRB);		      \
+	if (ITSTART(leftmost) > last)					      \
+		return NULL;						      \
+									      \
+	return ITPREFIX ## _subtree_search(node, start, last);		      \
+}									      \
+									      \
+ITSTATIC ITSTRUCT *							      \
+ITPREFIX ## _iter_next(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
+{									      \
+	struct rb_node *rb = node->ITRB.rb_right, *prev;		      \
+									      \
+	while (true) {							      \
+		/*							      \
+		 * Loop invariants:					      \
+		 *   Cond1: ITSTART(node) <= last			      \
+		 *   rb == node->ITRB.rb_right				      \
+		 *							      \
+		 * First, search right subtree if suitable		      \
+		 */							      \
+		if (rb) {						      \
+			ITSTRUCT *right = rb_entry(rb, ITSTRUCT, ITRB);	      \
+			if (start <= right->ITSUBTREE)			      \
+				return ITPREFIX ## _subtree_search(right,     \
+								start, last); \
+		}							      \
+									      \
+		/* Move up the tree until we come from a node's left child */ \
+		do {							      \
+			rb = rb_parent(&node->ITRB);			      \
+			if (!rb)					      \
+				return NULL;				      \
+			prev = &node->ITRB;				      \
+			node = rb_entry(rb, ITSTRUCT, ITRB);		      \
+			rb = node->ITRB.rb_right;			      \
+		} while (prev == rb);					      \
+									      \
+		/* Check if the node intersects [start;last] */		      \
+		if (last < ITSTART(node))		/* !Cond1 */	      \
+			return NULL;					      \
+		else if (start <= ITLAST(node))		/* Cond2 */	      \
+			return node;					      \
+	}								      \
+}
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 7e24b09..89b37cd 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
+#include <linux/interval_tree_generic.h>
 #include <objtool/builtin.h>
 
 #include <objtool/elf.h>
@@ -50,38 +51,22 @@ static inline u32 str_hash(const char *str)
 	__elf_table(name); \
 })
 
-static bool symbol_to_offset(struct rb_node *a, const struct rb_node *b)
+static inline unsigned long __sym_start(struct symbol *s)
 {
-	struct symbol *sa = rb_entry(a, struct symbol, node);
-	struct symbol *sb = rb_entry(b, struct symbol, node);
-
-	if (sa->offset < sb->offset)
-		return true;
-	if (sa->offset > sb->offset)
-		return false;
-
-	if (sa->len < sb->len)
-		return true;
-	if (sa->len > sb->len)
-		return false;
-
-	sa->alias = sb;
-
-	return false;
+	return s->offset;
 }
 
-static int symbol_by_offset(const void *key, const struct rb_node *node)
+static inline unsigned long __sym_last(struct symbol *s)
 {
-	const struct symbol *s = rb_entry(node, struct symbol, node);
-	const unsigned long *o = key;
+	return s->offset + s->len - 1;
+}
 
-	if (*o < s->offset)
-		return -1;
-	if (*o >= s->offset + s->len)
-		return 1;
+INTERVAL_TREE_DEFINE(struct symbol, node, unsigned long, __subtree_last,
+		     __sym_start, __sym_last, static, __sym)
 
-	return 0;
-}
+#define __sym_for_each(_iter, _tree, _start, _end)			\
+	for (_iter = __sym_iter_first((_tree), (_start), (_end));	\
+	     _iter; _iter = __sym_iter_next(_iter, (_start), (_end)))
 
 struct symbol_hole {
 	unsigned long key;
@@ -147,13 +132,12 @@ static struct symbol *find_symbol_by_index(struct elf *elf, unsigned int idx)
 
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 {
-	struct rb_node *node;
-
-	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
-		struct symbol *s = rb_entry(node, struct symbol, node);
+	struct rb_root_cached *tree = (struct rb_root_cached *)&sec->symbol_tree;
+	struct symbol *iter;
 
-		if (s->offset == offset && s->type != STT_SECTION)
-			return s;
+	__sym_for_each(iter, tree, offset, offset) {
+		if (iter->offset == offset && iter->type != STT_SECTION)
+			return iter;
 	}
 
 	return NULL;
@@ -161,13 +145,12 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset)
 {
-	struct rb_node *node;
+	struct rb_root_cached *tree = (struct rb_root_cached *)&sec->symbol_tree;
+	struct symbol *iter;
 
-	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
-		struct symbol *s = rb_entry(node, struct symbol, node);
-
-		if (s->offset == offset && s->type == STT_FUNC)
-			return s;
+	__sym_for_each(iter, tree, offset, offset) {
+		if (iter->offset == offset && iter->type == STT_FUNC)
+			return iter;
 	}
 
 	return NULL;
@@ -175,13 +158,12 @@ struct symbol *find_func_by_offset(struct section *sec, unsigned long offset)
 
 struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset)
 {
-	struct rb_node *node;
-
-	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
-		struct symbol *s = rb_entry(node, struct symbol, node);
+	struct rb_root_cached *tree = (struct rb_root_cached *)&sec->symbol_tree;
+	struct symbol *iter;
 
-		if (s->type != STT_SECTION)
-			return s;
+	__sym_for_each(iter, tree, offset, offset) {
+		if (iter->type != STT_SECTION)
+			return iter;
 	}
 
 	return NULL;
@@ -202,7 +184,7 @@ int find_symbol_hole_containing(const struct section *sec, unsigned long offset)
 	/*
 	 * Find the rightmost symbol for which @offset is after it.
 	 */
-	n = rb_find(&hole, &sec->symbol_tree, symbol_hole_by_offset);
+	n = rb_find(&hole, &sec->symbol_tree.rb_root, symbol_hole_by_offset);
 
 	/* found a symbol that contains @offset */
 	if (n)
@@ -224,13 +206,12 @@ int find_symbol_hole_containing(const struct section *sec, unsigned long offset)
 
 struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 {
-	struct rb_node *node;
-
-	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
-		struct symbol *s = rb_entry(node, struct symbol, node);
+	struct rb_root_cached *tree = (struct rb_root_cached *)&sec->symbol_tree;
+	struct symbol *iter;
 
-		if (s->type == STT_FUNC)
-			return s;
+	__sym_for_each(iter, tree, offset, offset) {
+		if (iter->type == STT_FUNC)
+			return iter;
 	}
 
 	return NULL;
@@ -373,6 +354,7 @@ static void elf_add_symbol(struct elf *elf, struct symbol *sym)
 {
 	struct list_head *entry;
 	struct rb_node *pnode;
+	struct symbol *iter;
 
 	INIT_LIST_HEAD(&sym->pv_target);
 	sym->alias = sym;
@@ -386,7 +368,12 @@ static void elf_add_symbol(struct elf *elf, struct symbol *sym)
 	sym->offset = sym->sym.st_value;
 	sym->len = sym->sym.st_size;
 
-	rb_add(&sym->node, &sym->sec->symbol_tree, symbol_to_offset);
+	__sym_for_each(iter, &sym->sec->symbol_tree, sym->offset, sym->offset) {
+		if (iter->offset == sym->offset && iter->type == sym->type)
+			iter->alias = sym;
+	}
+
+	__sym_insert(sym, &sym->sec->symbol_tree);
 	pnode = rb_prev(&sym->node);
 	if (pnode)
 		entry = &rb_entry(pnode, struct symbol, node)->list;
@@ -401,7 +388,7 @@ static void elf_add_symbol(struct elf *elf, struct symbol *sym)
 	 * can exist within a function, confusing the sorting.
 	 */
 	if (!sym->len)
-		rb_erase(&sym->node, &sym->sec->symbol_tree);
+		__sym_remove(sym, &sym->sec->symbol_tree);
 }
 
 static int read_symbols(struct elf *elf)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index baa8085..d285331 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -30,7 +30,7 @@ struct section {
 	struct hlist_node hash;
 	struct hlist_node name_hash;
 	GElf_Shdr sh;
-	struct rb_root symbol_tree;
+	struct rb_root_cached symbol_tree;
 	struct list_head symbol_list;
 	struct list_head reloc_list;
 	struct section *base, *reloc;
@@ -53,6 +53,7 @@ struct symbol {
 	unsigned char bind, type;
 	unsigned long offset;
 	unsigned int len;
+	unsigned long __subtree_last;
 	struct symbol *pfunc, *cfunc, *alias;
 	u8 uaccess_safe      : 1;
 	u8 static_call_tramp : 1;
