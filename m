Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211A96A4828
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjB0RhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjB0Rg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:36:56 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C219524114
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:50 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id i15-20020aa78d8f000000b005edc307b103so2926495pfr.17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ei1aTodbgKgkLCHkAcrfXghqfC4aFVkwG1NwHfqe18=;
        b=mjTDCe3um0lc/xjVfVjgd+Npe9HefebnR6MJBHLvf3YF1uIBfRxVZUnFRJLGFeQ5Qn
         8RjZv63JPHIbjxEVYDv4CrjZbJnnn4Mt2fDeT1LOlyG88MFvPDh3biXldQxmJDhFfhkL
         MeulbY1wD03auJFox9o7eR+S24BryOLDDsTTZGQeZ4URN1aDTRabL9SThEbzRf62X937
         1Tp2+9t6o/KfoCPMJmoRWi+E8Rd5yccUzXxzvOPdrAcdSgNX0Ahh/fjHi6t+VXE449Oh
         mngGw09qy20HWkPARPiqIZAx0mZi+xWfyiKlsc96M1s7LVT+aejv+nyRL84gn5iOqmCZ
         H2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ei1aTodbgKgkLCHkAcrfXghqfC4aFVkwG1NwHfqe18=;
        b=6Bj1IQZ/Xzr6i8ILt+Zsgs2/+ytEFfvXSAGOXKODQfp6m1b8I5bZT3hZR3Z4AGaWAX
         W8vfzHizzuYOHbgMLB0uo+INnMegAhCx1j6kHN4rRZI+oYmLcYCzu+Gpk1nkajvVVtcU
         zpun2XbDf+L2jzhho1bA4xtsdBrplcWFxwTz9D/An6CRY8KBAc3IXglqxMI3yRxFGBOJ
         m1ih123O0VB2Qyk8nIYuc4UYPwOPyRVqmH12daSudIzsxeslYv4MM22fcx1ezfO3EKaC
         BsmJ3NxhYhCdUzy0BRaPkgHWqdiH1bjOvqi2QPWBDvp/e/3N+zLnMh5S23pyIRik5aZo
         JxTg==
X-Gm-Message-State: AO0yUKUibKW9eF8eO7Tkg7oz/3u0kgJWlq8QGNGP/m2idQUyNxkhfYEt
        uv/lJ2Wscy+KI0yGS/ATx57TzP1qLAs=
X-Google-Smtp-Source: AK7set8gSrJb7C7al4vp6knawTGaEfFTfMkKKVc0fZqqef6Oc8nGI6YkUfCL0eSaXZ77p/UxVJxZTTA+0vM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a63:714f:0:b0:4fc:2058:fa2b with SMTP id
 b15-20020a63714f000000b004fc2058fa2bmr6283546pgn.3.1677519409843; Mon, 27 Feb
 2023 09:36:49 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:04 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-6-surenb@google.com>
Subject: [PATCH v4 05/33] maple_tree: Fix write memory barrier of nodes once
 dead for RCU mode
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

During the development of the maple tree, the strategy of freeing
multiple nodes changed and, in the process, the pivots were reused to
store pointers to dead nodes.  To ensure the readers see accurate
pivots, the writers need to mark the nodes as dead and call smp_wmb() to
ensure any readers can identify the node as dead before using the pivot
values.

There were two places where the old method of marking the node as dead
without smp_wmb() were being used, which resulted in RCU readers seeing
the wrong pivot value before seeing the node was dead.  Fix this race
condition by using mte_set_node_dead() which has the smp_wmb() call to
ensure the race is closed.

Add a WARN_ON() to the ma_free_rcu() call to ensure all nodes being
freed are marked as dead to ensure there are no other call paths besides
the two updated paths.

This is necessary for the RCU mode of the maple tree.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/maple_tree.c                 |  7 +++++--
 tools/testing/radix-tree/maple.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3d5ab02f981a..6b6eddadd9d2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -185,7 +185,7 @@ static void mt_free_rcu(struct rcu_head *head)
  */
 static void ma_free_rcu(struct maple_node *node)
 {
-	node->parent = ma_parent_ptr(node);
+	WARN_ON(node->parent != ma_parent_ptr(node));
 	call_rcu(&node->rcu, mt_free_rcu);
 }
 
@@ -1778,8 +1778,10 @@ static inline void mas_replace(struct ma_state *mas, bool advanced)
 		rcu_assign_pointer(slots[offset], mas->node);
 	}
 
-	if (!advanced)
+	if (!advanced) {
+		mte_set_node_dead(old_enode);
 		mas_free(mas, old_enode);
+	}
 }
 
 /*
@@ -4218,6 +4220,7 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
 done:
 	mas_leaf_set_meta(mas, newnode, dst_pivots, maple_leaf_64, new_end);
 	if (in_rcu) {
+		mte_set_node_dead(mas->node);
 		mas->node = mt_mk_node(newnode, wr_mas->type);
 		mas_replace(mas, false);
 	} else {
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 958ee9bdb316..4c89ff333f6f 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -108,6 +108,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mn->slot[1] != NULL);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
+	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 	mas.node = MAS_START;
 	mas_nomem(&mas, GFP_KERNEL);
@@ -160,6 +161,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 		MT_BUG_ON(mt, mas_allocated(&mas) != i);
 		MT_BUG_ON(mt, !mn);
 		MT_BUG_ON(mt, not_empty(mn));
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 	}
 
@@ -192,6 +194,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 		MT_BUG_ON(mt, not_empty(mn));
 		MT_BUG_ON(mt, mas_allocated(&mas) != i - 1);
 		MT_BUG_ON(mt, !mn);
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 	}
 
@@ -210,6 +213,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 			mn = mas_pop_node(&mas);
 			MT_BUG_ON(mt, not_empty(mn));
 			MT_BUG_ON(mt, mas_allocated(&mas) != j - 1);
+			mn->parent = ma_parent_ptr(mn);
 			ma_free_rcu(mn);
 		}
 		MT_BUG_ON(mt, mas_allocated(&mas) != 0);
@@ -233,6 +237,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 			MT_BUG_ON(mt, mas_allocated(&mas) != i - j);
 			mn = mas_pop_node(&mas);
 			MT_BUG_ON(mt, not_empty(mn));
+			mn->parent = ma_parent_ptr(mn);
 			ma_free_rcu(mn);
 			MT_BUG_ON(mt, mas_allocated(&mas) != i - j - 1);
 		}
@@ -269,6 +274,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 			mn = mas_pop_node(&mas); /* get the next node. */
 			MT_BUG_ON(mt, mn == NULL);
 			MT_BUG_ON(mt, not_empty(mn));
+			mn->parent = ma_parent_ptr(mn);
 			ma_free_rcu(mn);
 		}
 		MT_BUG_ON(mt, mas_allocated(&mas) != 0);
@@ -294,6 +300,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 			mn = mas_pop_node(&mas2); /* get the next node. */
 			MT_BUG_ON(mt, mn == NULL);
 			MT_BUG_ON(mt, not_empty(mn));
+			mn->parent = ma_parent_ptr(mn);
 			ma_free_rcu(mn);
 		}
 		MT_BUG_ON(mt, mas_allocated(&mas2) != 0);
@@ -334,10 +341,12 @@ static noinline void check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 2);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, not_empty(mn));
+	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 	for (i = 1; i <= MAPLE_ALLOC_SLOTS + 1; i++) {
 		mn = mas_pop_node(&mas);
 		MT_BUG_ON(mt, not_empty(mn));
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 	}
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
@@ -375,6 +384,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 		mas_node_count(&mas, i); /* Request */
 		mas_nomem(&mas, GFP_KERNEL); /* Fill request */
 		mn = mas_pop_node(&mas); /* get the next node. */
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 		mas_destroy(&mas);
 
@@ -382,10 +392,13 @@ static noinline void check_new_node(struct maple_tree *mt)
 		mas_node_count(&mas, i); /* Request */
 		mas_nomem(&mas, GFP_KERNEL); /* Fill request */
 		mn = mas_pop_node(&mas); /* get the next node. */
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 		mn = mas_pop_node(&mas); /* get the next node. */
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 		mn = mas_pop_node(&mas); /* get the next node. */
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 		mas_destroy(&mas);
 	}
@@ -35369,6 +35382,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
+	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
@@ -35386,6 +35400,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
+	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 
 	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
@@ -35756,6 +35771,7 @@ void farmer_tests(void)
 	tree.ma_root = mt_mk_node(node, maple_leaf_64);
 	mt_dump(&tree);
 
+	node->parent = ma_parent_ptr(node);
 	ma_free_rcu(node);
 
 	/* Check things that will make lockdep angry */
-- 
2.39.2.722.g9855ee24e9-goog

