Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C474D70F445
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjEXKcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjEXKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:31:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F7C1B9;
        Wed, 24 May 2023 03:31:47 -0700 (PDT)
Date:   Wed, 24 May 2023 10:31:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684924305;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHInt8PsCTTZea00osUteaIh5I/RtrIGNZBHdsJKGws=;
        b=ITmiUsLq8Jfo+zPaO/OrzXXnqDY9ShFIVpVm0kiyFGXO482cwL8noGTBU6e31S5j+zl/N9
        Po4L2wraBHC4Xwh0X5GSQ1dQwl6lvv3GQVEYtudnbUE6bdw921qXC3o8nJH+mkNQ/7a5oT
        yiKFl4mHM03dCMCsdkHtZKglY+S+xgs5aPbMmfmdMMIKllFd2PWB5+0cyer37J2i+dkD5r
        bwyboLFyHdJukWRQgUV5r840Pi+bsfXTx904QZ+db6Mbl08D++U322VSCziohJGMeNIJvb
        y6g5fh8z7j1xlswC0CVQZabknZnFNN9J8Tjm9pC1YtePPEJmdsreAJEm+94lXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684924305;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHInt8PsCTTZea00osUteaIh5I/RtrIGNZBHdsJKGws=;
        b=5iwnW01FWYxmUmADJXci4GEaxxaMZPVchAhkayW5nS/WgjHmFnwWIWtAYeeaEA2uvJVkpY
        VRsfMJxXmETcXsCw==
From:   "tip-bot2 for Kent Overstreet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] bcache: Convert to lock_cmp_fn
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Coly Li <colyli@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230509195847.1745548-2-kent.overstreet@linux.dev>
References: <20230509195847.1745548-2-kent.overstreet@linux.dev>
MIME-Version: 1.0
Message-ID: <168492430501.404.11013548302420797278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4c8a49244c6abc5fb829d81abaaf2435ad2a44bf
Gitweb:        https://git.kernel.org/tip/4c8a49244c6abc5fb829d81abaaf2435ad2a44bf
Author:        Kent Overstreet <kent.overstreet@linux.dev>
AuthorDate:    Tue, 09 May 2023 15:58:47 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 24 May 2023 12:21:22 +02:00

bcache: Convert to lock_cmp_fn

Replace one of bcache's lockdep_set_novalidate_class() usage with the
newly introduced custom lock nesting annotation.

[peterz: changelog]
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Coly Li <colyli@suse.de>
Link: https://lkml.kernel.org/r/20230509195847.1745548-2-kent.overstreet@linux.dev
---
 drivers/md/bcache/btree.c | 23 ++++++++++++++++++++++-
 drivers/md/bcache/btree.h |  4 ++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 147c493..569f489 100644
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
index 1b5fdbc..17b1d20 100644
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
