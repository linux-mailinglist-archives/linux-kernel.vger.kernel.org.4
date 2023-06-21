Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B85738202
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjFUJb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjFUJas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:30:48 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A3410A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:30:12 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-25b79a5cf1aso4094329a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687339812; x=1689931812;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZkMJYW9AaEkYEFdiIfyRJ8y7x5cNBiWOkfQ1Jk9vOOI=;
        b=U6f0qHdaGld6GTFVyXxfloqd25G2EbbnWjUmTySziT7GSoTmtZppD3J4/pbhq/vTr1
         FFrgcAlhqTCcqPc2fBGDrjxKgSAihBui7o41fev/08bRLTT4nyGNLaIHeGTUSzNvnAAO
         DN/9CTNj+eA4WdTANg86emSsQY4nvBEGRRhB/ZAJJuI3AxPKCnmFTdhWqcoSem0mF/pq
         JjHJy7Ca+IFbWiqi0l8H/LHQLNn5f6UIuqc8lDTvNY+QGwaGWGGdJaRy+kKc52aSFnt5
         U9RMgouucsiKJp4d+Z9Uh5kG6aeiyZGJ4RJjONYN8P1iFu+BzlK3XuBwRqVb5knD0dzE
         vjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339812; x=1689931812;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZkMJYW9AaEkYEFdiIfyRJ8y7x5cNBiWOkfQ1Jk9vOOI=;
        b=If6YW+WIndw+dwQpvGXrqX8H2WpmzY0CvIX8wrKaPoEhCHfZJ/xVLb/nn9NKoXKa6w
         aJfcEqCV4bhH/y4f6IT3ab/h/53qCc66lRB4Mu96nYopLKNLsTRB9uIUyTvtGF7Cx816
         XHTDWSXmDalkusEkIzyPyWMI9+V9njQaUpagfZZupH22/bmWkK1moS/xbpBdKOW/t/LB
         zkRCeOgccqUdHyr6YcrqHHAoAY3nuh2I1WOjdMFOuFDect9atxiNCBgxVXzXfFAZqK8+
         hEBc7vtwsN4F3Lr4b+/cHRkF3e6D1Pzv/1oyFAnYhVrzypEsReo+tR110XoRecVh6kPM
         i/gg==
X-Gm-Message-State: AC+VfDwkKyyTrIzxFfMVvZ2kp5jynDDukADRews7jkNU5Ycrlzt9vcnZ
        pYgU7v+DTMMhEJhk4vOHIJ/goov/p7eCjwnp
X-Google-Smtp-Source: ACHHUZ7l9rcK0816aFWbVC6lPdhWa3cUm/9YUOdHHYlROSnCwgf2ZSIN+kchQK1Tab23ig2CAx/x3hozCaVcEVHE
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:404c:b0:25e:c3a3:ccc7 with SMTP
 id k12-20020a17090a404c00b0025ec3a3ccc7mr1891887pjg.3.1687339812393; Wed, 21
 Jun 2023 02:30:12 -0700 (PDT)
Date:   Wed, 21 Jun 2023 09:30:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621093009.637544-1-yosryahmed@google.com>
Subject: [PATCH] mm: zswap: fix double invalidate with exclusive loads
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If exclusive loads are enabled for zswap, we invalidate the entry before
returning from zswap_frontswap_load(), after dropping the local
reference. However, the tree lock is dropped during decompression after
the local reference is acquired, so the entry could be invalidated
before we drop the local ref. If this happens, the entry is freed once
we drop the local ref, and zswap_invalidate_entry() tries to invalidate
an already freed entry.

Fix this by:
(a) Making sure zswap_invalidate_entry() is always called with a local
    ref held, to avoid being called on a freed entry.
(b) Making sure zswap_invalidate_entry() only drops the ref if the entry
    was actually on the rbtree. Otherwise, another invalidation could
    have already happened, and the initial ref is already dropped.

With these changes, there is no need to check that there is no need to
make sure the entry still exists in the tree in zswap_reclaim_entry()
before invalidating it, as zswap_reclaim_entry() will make this check
internally.

Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 87b204233115..62195f72bf56 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -355,12 +355,14 @@ static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
 	return 0;
 }
 
-static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
+static bool zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
 {
 	if (!RB_EMPTY_NODE(&entry->rbnode)) {
 		rb_erase(&entry->rbnode, root);
 		RB_CLEAR_NODE(&entry->rbnode);
+		return true;
 	}
+	return false;
 }
 
 /*
@@ -599,14 +601,16 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	return NULL;
 }
 
+/*
+ * If the entry is still valid in the tree, drop the initial ref and remove it
+ * from the tree. This function must be called with an additional ref held,
+ * otherwise it may race with another invalidation freeing the entry.
+ */
 static void zswap_invalidate_entry(struct zswap_tree *tree,
 				   struct zswap_entry *entry)
 {
-	/* remove from rbtree */
-	zswap_rb_erase(&tree->rbroot, entry);
-
-	/* drop the initial reference from entry creation */
-	zswap_entry_put(tree, entry);
+	if (zswap_rb_erase(&tree->rbroot, entry))
+		zswap_entry_put(tree, entry);
 }
 
 static int zswap_reclaim_entry(struct zswap_pool *pool)
@@ -659,8 +663,7 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
 	 * swapcache. Drop the entry from zswap - unless invalidate already
 	 * took it out while we had the tree->lock released for IO.
 	 */
-	if (entry == zswap_rb_search(&tree->rbroot, swpoffset))
-		zswap_invalidate_entry(tree, entry);
+	zswap_invalidate_entry(tree, entry);
 
 put_unlock:
 	/* Drop local reference */
@@ -1466,7 +1469,6 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		count_objcg_event(entry->objcg, ZSWPIN);
 freeentry:
 	spin_lock(&tree->lock);
-	zswap_entry_put(tree, entry);
 	if (!ret && zswap_exclusive_loads_enabled) {
 		zswap_invalidate_entry(tree, entry);
 		*exclusive = true;
@@ -1475,6 +1477,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		list_move(&entry->lru, &entry->pool->lru);
 		spin_unlock(&entry->pool->lru_lock);
 	}
+	zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);
 
 	return ret;
-- 
2.41.0.162.gfafddb0af9-goog

