Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D306FCEEC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjEIT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjEIT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:58:59 -0400
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [IPv6:2001:41d0:203:375::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7743C00
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:58:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683662335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jm2QfNkTZXKOgSp/4L5vhj91It6ERkpvl8xSf9vPkfs=;
        b=CqRc3INSDP5cQkc6geD00QrgHF+5LTgtV13Gf9XcykBwdxMbT8OpvF9X24purGPlY0aGO5
        OLnrjWnizTkB4vO1n1hyeNwMg7pudV9u5J3x89L7RG2MvGbEPS9DeUYBCfX7/IO7ZSibsc
        sAGtuSUROJCxm6BKoW8BI3WNFuGqazM=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 2/2] bcache: Convert to lock_cmp_fn
Date:   Tue,  9 May 2023 15:58:47 -0400
Message-Id: <20230509195847.1745548-2-kent.overstreet@linux.dev>
In-Reply-To: <20230509195847.1745548-1-kent.overstreet@linux.dev>
References: <20230509195847.1745548-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/btree.c | 23 ++++++++++++++++++++++-
 drivers/md/bcache/btree.h |  4 ++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 147c493a98..569f48958b 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -559,6 +559,27 @@ static void mca_data_alloc(struct btree *b, struct bkey *k, gfp_t gfp)
 	}
 }
 
+#define cmp_int(l, r)		((l > r) - (l < r))
+
+#ifdef CONFIG_PROVE_LOCKING
+static int btree_lock_cmp_fn(const struct lockdep_map *_a,
+			     const struct lockdep_map *_b)
+{
+	const struct btree *a = container_of(_a, struct btree, lock.dep_map);
+	const struct btree *b = container_of(_b, struct btree, lock.dep_map);
+
+	return -cmp_int(a->level, b->level) ?: bkey_cmp(&a->key, &b->key);
+}
+
+static void btree_lock_print_fn(const struct lockdep_map *map)
+{
+	const struct btree *b = container_of(map, struct btree, lock.dep_map);
+
+	printk(KERN_CONT " l=%u %llu:%llu", b->level,
+	       KEY_INODE(&b->key), KEY_OFFSET(&b->key));
+}
+#endif
+
 static struct btree *mca_bucket_alloc(struct cache_set *c,
 				      struct bkey *k, gfp_t gfp)
 {
@@ -572,7 +593,7 @@ static struct btree *mca_bucket_alloc(struct cache_set *c,
 		return NULL;
 
 	init_rwsem(&b->lock);
-	lockdep_set_novalidate_class(&b->lock);
+	lock_set_cmp_fn(&b->lock, btree_lock_cmp_fn, btree_lock_print_fn);
 	mutex_init(&b->write_lock);
 	lockdep_set_novalidate_class(&b->write_lock);
 	INIT_LIST_HEAD(&b->list);
diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
index 1b5fdbc0d8..17b1d201ce 100644
--- a/drivers/md/bcache/btree.h
+++ b/drivers/md/bcache/btree.h
@@ -247,8 +247,8 @@ static inline void bch_btree_op_init(struct btree_op *op, int write_lock_level)
 
 static inline void rw_lock(bool w, struct btree *b, int level)
 {
-	w ? down_write_nested(&b->lock, level + 1)
-	  : down_read_nested(&b->lock, level + 1);
+	w ? down_write(&b->lock)
+	  : down_read(&b->lock);
 	if (w)
 		b->seq++;
 }
-- 
2.40.1

