Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23469B7E1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 04:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBRDVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 22:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBRDV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 22:21:28 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7999241F1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 19:21:27 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676690486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufEKrCHh2/vzycQBvOE+qM+s+xT5FVdqQ0HB7R/Xe3k=;
        b=uD7lgOBlsCVfzy1dGjZsWy+She5uqWXUI+QQLSWgVibzvMWtcg67Ykc1Pir8kDsJMlz0+O
        crHDWC4UkzpdRF9cUBZm+wTaP998KKOe6pyKhcriJDhMgwLjH0x2lW0tY6/nuk1yV1YNPe
        YNR9HO/5yXrrkyyR0Tuy2y5yVcPiYLc=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>, mingo@redhat.com,
        stern@rowland.harvard.edu, Coly Li <colyli@suse.de>
Subject: [PATCH 2/2] bcache: Convert to lock_cmp_fn
Date:   Fri, 17 Feb 2023 22:21:17 -0500
Message-Id: <20230218032117.2372071-3-kent.overstreet@linux.dev>
In-Reply-To: <20230218032117.2372071-1-kent.overstreet@linux.dev>
References: <20230218032117.2372071-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Coly Li <colyli@suse.de> (maintainer:BCACHE (BLOCK LAYER CACHE))
---
 drivers/md/bcache/btree.c | 15 ++++++++++++++-
 drivers/md/bcache/btree.h |  4 ++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 147c493a98..db2bf2402c 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -559,6 +559,19 @@ static void mca_data_alloc(struct btree *b, struct bkey *k, gfp_t gfp)
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
+#endif
+
 static struct btree *mca_bucket_alloc(struct cache_set *c,
 				      struct bkey *k, gfp_t gfp)
 {
@@ -572,7 +585,7 @@ static struct btree *mca_bucket_alloc(struct cache_set *c,
 		return NULL;
 
 	init_rwsem(&b->lock);
-	lockdep_set_novalidate_class(&b->lock);
+	lock_set_lock_cmp_fn(&b->lock, btree_lock_cmp_fn);
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
2.39.2

