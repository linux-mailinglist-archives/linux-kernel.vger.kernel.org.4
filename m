Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891E4698BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBPFS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjBPFSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:18:10 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA40A410A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:07 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-507aac99fdfso8543797b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDMlMLTEmJU/Y3crV2atsbCBmpKXyma0yO0OAyc8vDw=;
        b=nzJ7S/CJB/US/rZvNC3fs8J8fXfgfseovx93tCDYzLZ8vkCeR9OXHCG0j7Ki073PZN
         rg58gpprBwFVBX+ke7DxYuYcgkrSQGYt8YR1LUHO8qrBrJHNZzYIw0fWkCpsF9iepuD5
         iMfSL7cYbKTG2WSIKdzRhuGyAIwfPFbrqz4Ug3Wxq2wbPU6P8gVi3bWvRrz9dl4kYYU2
         r7gzF5YCRjQDAYOvUYbM1k4rIOQJ+5ffpqKzLjZIEvFTLYyWs4Q62tIpz4Jjx53AOh2l
         MDbSaQOmeWEl4DEmE5lvlD2J9UkQB4Iedo6XxOd2amw2xyG9CIFDXUp1l5UWlLjXi78n
         VOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDMlMLTEmJU/Y3crV2atsbCBmpKXyma0yO0OAyc8vDw=;
        b=rRcURjHgly6C9phVmCfv/Qwn3KA2i2hsOFAed/MKybTvZZ1H5qmL+FstZVXszmjz0s
         kYPvlU5p1hQs9pDnu6C5oEPfdFkggH6lKVkenQN83A7Fb6qpJuihbPkpivhCpb+SsubO
         vxcyXiHc5XDC8gN6s7HDbfI1qrL9P3Qj8W388w3UbL9xW3CKKUoJtYDU3vwKKteLN05p
         6pMCdCOTj7+AvpGdTinzZ5M0OL04Cr4bJOagOsR0eVSalILZ9XrKz6fG7ukXGEccCgoH
         gjXNE47x+mNYQbxhcWB4GzAdKhqJnZAk5eq9jqhiS3qPIWrOgEA0tTLZam4qnx5Jjn2T
         N/wA==
X-Gm-Message-State: AO0yUKWy7RDm+0TL1UvYwALTkYC/7DsIlDeLUdpPxM2TGRzCzr5GpnYL
        M6YmM0fuL2oQGSVGHrWdRn9fhicOiHI=
X-Google-Smtp-Source: AK7set/lb47TNs4WZdV/lfneGa3vlSnF3eCz7HT/YLrrRFQlj7qxX88gXTKYg9jHepFjlMCGZaF+lFhq4LY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a81:4309:0:b0:52e:c2c5:b75e with SMTP id
 q9-20020a814309000000b0052ec2c5b75emr19ywa.2.1676524686391; Wed, 15 Feb 2023
 21:18:06 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:20 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-6-surenb@google.com>
Subject: [PATCH v3 05/35] maple_tree: Fix write memory barrier of nodes once
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
2.39.1

