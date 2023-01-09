Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6203E6631E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbjAIUyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjAIUxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:53:50 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0919F6B5FE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:53:49 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-46eb8a5a713so103730177b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYS2Mdxn+jwv2Pf7FZ7D7lMnoZhtkSPqAfmT0KRte/A=;
        b=nFEf7/SuzvGfFfBp8alBHLcE/S20BVhkxOFCKJJxDEEpkBCqnPrEjXLQRPhpajIyrV
         J/MheNxTRWGkew5780i2M8uqtnyvNe0zoFPa24hnhtsW7xvdNOQ3PiEyoeTmA3WWPiUh
         QK2oHtldPphM+TCue7rjkADeiZ4F/aOO5f9+1p0Hswrqrn/9/CHXJyrN6vRAUq5GDqS7
         Axk6TqH0bcf1b4jM3d3LsItdyw7HXfIeFcgC6ZYFCu5leTcjZd3mHlVr8yfm4xVeOVbq
         OV6UpEzwnJ3oSH64LbnS9rS633sT7MF5+6p/WT9/4pbYtB4HJqqA4EN1qZDYnvdMkGJo
         Aq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYS2Mdxn+jwv2Pf7FZ7D7lMnoZhtkSPqAfmT0KRte/A=;
        b=BSTYANskypCCjpv3vFOc3FP5vusE+Rjt/egZaQf5U3vqSNrjrfC5SiyjnVGOr7v2ks
         3X4QFOKR6IrCpbRHBjjVsS7RjnGt11b2Pw366bgDwwFRkgMPQMtBJBIO+5BucFVWZvL8
         1aDkbjyTuXHNI9y8wYSaNEIDUFwcRc91Djar5icMCMmUWyVhOkoJwXIX9sjqU2iVoKI6
         FG6u4LRJniaZmjqQ3ud7lqCz27RL91Zz/NGlIfi0EkRCvTEuW8i2vxS8jYTGrI2vlY+F
         TAYwb+Ti9ppttNgqiyrkyD887DleyTSpCetnjL9CmT6g230eVLh0GsQWmoLbuByDtB+I
         LG+w==
X-Gm-Message-State: AFqh2ko1LOTlWzt2chs9xJAh+RN7HPrEnx8Xxeq+tBjc+j0xUjGP3KHC
        4Ev3cRHZYUrLklXFfrJ//ALjFudo1VE=
X-Google-Smtp-Source: AMrXdXs7OcQqihjg4pdS+IdnJHYFJuvOEzRgXy7ctwOn05/Em3c821T3ojLTZvqk1LIxMtAuoTuisCHM2Gs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:dd07:0:b0:7b4:db9a:48ae with SMTP id
 u7-20020a25dd07000000b007b4db9a48aemr1234542ybg.207.1673297628223; Mon, 09
 Jan 2023 12:53:48 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:52:58 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-4-surenb@google.com>
Subject: [PATCH 03/41] maple_tree: Fix freeing of nodes in rcu mode
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com, Liam Howlett <Liam.Howlett@oracle.com>
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

From: Liam Howlett <Liam.Howlett@oracle.com>

The walk to destroy the nodes was not always setting the node type and
would result in a destroy method potentially using the values as nodes.
Avoid this by setting the correct node types.  This is necessary for the
RCU mode of the maple tree.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/maple_tree.c | 73 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a748938ad2e9..a11eea943f8d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -897,6 +897,44 @@ static inline void ma_set_meta(struct maple_node *mn, enum maple_type mt,
 	meta->end = end;
 }
 
+/*
+ * mas_clear_meta() - clear the metadata information of a node, if it exists
+ * @mas: The maple state
+ * @mn: The maple node
+ * @mt: The maple node type
+ * @offset: The offset of the highest sub-gap in this node.
+ * @end: The end of the data in this node.
+ */
+static inline void mas_clear_meta(struct ma_state *mas, struct maple_node *mn,
+				  enum maple_type mt)
+{
+	struct maple_metadata *meta;
+	unsigned long *pivots;
+	void __rcu **slots;
+	void *next;
+
+	switch (mt) {
+	case maple_range_64:
+		pivots = mn->mr64.pivot;
+		if (unlikely(pivots[MAPLE_RANGE64_SLOTS - 2])) {
+			slots = mn->mr64.slot;
+			next = mas_slot_locked(mas, slots,
+					       MAPLE_RANGE64_SLOTS - 1);
+			if (unlikely((mte_to_node(next) && mte_node_type(next))))
+				return; /* The last slot is a node, no metadata */
+		}
+		fallthrough;
+	case maple_arange_64:
+		meta = ma_meta(mn, mt);
+		break;
+	default:
+		return;
+	}
+
+	meta->gap = 0;
+	meta->end = 0;
+}
+
 /*
  * ma_meta_end() - Get the data end of a node from the metadata
  * @mn: The maple node
@@ -5448,20 +5486,22 @@ static inline int mas_rev_alloc(struct ma_state *mas, unsigned long min,
  * mas_dead_leaves() - Mark all leaves of a node as dead.
  * @mas: The maple state
  * @slots: Pointer to the slot array
+ * @type: The maple node type
  *
  * Must hold the write lock.
  *
  * Return: The number of leaves marked as dead.
  */
 static inline
-unsigned char mas_dead_leaves(struct ma_state *mas, void __rcu **slots)
+unsigned char mas_dead_leaves(struct ma_state *mas, void __rcu **slots,
+			      enum maple_type mt)
 {
 	struct maple_node *node;
 	enum maple_type type;
 	void *entry;
 	int offset;
 
-	for (offset = 0; offset < mt_slot_count(mas->node); offset++) {
+	for (offset = 0; offset < mt_slots[mt]; offset++) {
 		entry = mas_slot_locked(mas, slots, offset);
 		type = mte_node_type(entry);
 		node = mte_to_node(entry);
@@ -5480,14 +5520,13 @@ unsigned char mas_dead_leaves(struct ma_state *mas, void __rcu **slots)
 
 static void __rcu **mas_dead_walk(struct ma_state *mas, unsigned char offset)
 {
-	struct maple_node *node, *next;
+	struct maple_node *next;
 	void __rcu **slots = NULL;
 
 	next = mas_mn(mas);
 	do {
-		mas->node = ma_enode_ptr(next);
-		node = mas_mn(mas);
-		slots = ma_slots(node, node->type);
+		mas->node = mt_mk_node(next, next->type);
+		slots = ma_slots(next, next->type);
 		next = mas_slot_locked(mas, slots, offset);
 		offset = 0;
 	} while (!ma_is_leaf(next->type));
@@ -5551,11 +5590,14 @@ static inline void __rcu **mas_destroy_descend(struct ma_state *mas,
 		node = mas_mn(mas);
 		slots = ma_slots(node, mte_node_type(mas->node));
 		next = mas_slot_locked(mas, slots, 0);
-		if ((mte_dead_node(next)))
+		if ((mte_dead_node(next))) {
+			mte_to_node(next)->type = mte_node_type(next);
 			next = mas_slot_locked(mas, slots, 1);
+		}
 
 		mte_set_node_dead(mas->node);
 		node->type = mte_node_type(mas->node);
+		mas_clear_meta(mas, node, node->type);
 		node->piv_parent = prev;
 		node->parent_slot = offset;
 		offset = 0;
@@ -5575,13 +5617,18 @@ static void mt_destroy_walk(struct maple_enode *enode, unsigned char ma_flags,
 
 	MA_STATE(mas, &mt, 0, 0);
 
-	if (mte_is_leaf(enode))
+	mas.node = enode;
+	if (mte_is_leaf(enode)) {
+		node->type = mte_node_type(enode);
 		goto free_leaf;
+	}
 
+	ma_flags &= ~MT_FLAGS_LOCK_MASK;
 	mt_init_flags(&mt, ma_flags);
 	mas_lock(&mas);
 
-	mas.node = start = enode;
+	mte_to_node(enode)->ma_flags = ma_flags;
+	start = enode;
 	slots = mas_destroy_descend(&mas, start, 0);
 	node = mas_mn(&mas);
 	do {
@@ -5589,7 +5636,8 @@ static void mt_destroy_walk(struct maple_enode *enode, unsigned char ma_flags,
 		unsigned char offset;
 		struct maple_enode *parent, *tmp;
 
-		node->slot_len = mas_dead_leaves(&mas, slots);
+		node->type = mte_node_type(mas.node);
+		node->slot_len = mas_dead_leaves(&mas, slots, node->type);
 		if (free)
 			mt_free_bulk(node->slot_len, slots);
 		offset = node->parent_slot + 1;
@@ -5613,7 +5661,8 @@ static void mt_destroy_walk(struct maple_enode *enode, unsigned char ma_flags,
 	} while (start != mas.node);
 
 	node = mas_mn(&mas);
-	node->slot_len = mas_dead_leaves(&mas, slots);
+	node->type = mte_node_type(mas.node);
+	node->slot_len = mas_dead_leaves(&mas, slots, node->type);
 	if (free)
 		mt_free_bulk(node->slot_len, slots);
 
@@ -5623,6 +5672,8 @@ static void mt_destroy_walk(struct maple_enode *enode, unsigned char ma_flags,
 free_leaf:
 	if (free)
 		mt_free_rcu(&node->rcu);
+	else
+		mas_clear_meta(&mas, node, node->type);
 }
 
 /*
-- 
2.39.0

