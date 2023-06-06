Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC86A724714
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbjFFO6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbjFFO5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:57:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B66126
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:56:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977d55ac17bso435208766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686063405; x=1688655405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m93zvhqGY33dMVb3yJDR3QMRlXYYIvkhra5OO7s3gT0=;
        b=RfE0aSWywDCIfL5512Pu3B6bkZD1QwlRkOWba5xkCE3kZ/CUFRzF/fkGbXMZJTbARd
         x9k5ofptCtgT+ji09DRlVbzYAyiotQe4b1u5B5P+JuT2SjJgvCcfBdROAkyuCWZZszLl
         EZbLp/RvUorOIexhwLh81I/TDtZsiMdAyj12akic/4frFete6PsOcm2YfcdR4U2YTER3
         Q0/s7DzzBQ/JNw2kFPp4lU4QP0lfUiqckcx+SRgK6ydkB9i9mpG89yqlKylpoVFVghQM
         zo09X1hmq2k447L6atKnVkoZxvbrp9nFGTxcm7qiewEhb9fZU2N/q7v37sRJX3hLoU6m
         +AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063405; x=1688655405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m93zvhqGY33dMVb3yJDR3QMRlXYYIvkhra5OO7s3gT0=;
        b=RCNALF2aSMVdVdH2QNL9LuFpTQ3hBnCO1qPP5xI8TA0VLlHOynmcY5jGlXfjAnkzSy
         fVGdCvdixq/4Hv3Z6boN2kUM/pG2JcQ+rKyS4R9OKQsDzYWogVOFwJecscTnaeYg2vla
         DHIpgTTZd1F4oo0MaLeVhLK0G5u+HN4KUD9CFDQKZ6e9M76en38hvMWuvz4fLtrxclxX
         EDmcfbavSYiwTLy+ZZpr9LWjzFjgeg+RaftuwMEkfnnXziABGyanpor7oyfmjTYVL1oo
         X8ObyXgahKG8urRSjUAT7QVQrvJo1/imrM6oN1Tdofx+VDrXE9shov7QxLRqmE2DGM2o
         123A==
X-Gm-Message-State: AC+VfDzMkGcz7yw+y6yjJ0JSH1gbK8j9XTRXD5yF/MOliHbHBBTIlhHJ
        7ffBf/ce4QJZ8C6aRsl4gE/Pt02AEaUDpg1S
X-Google-Smtp-Source: ACHHUZ6O2cUNCcsvAIDsBzLtSS8l+80MAG9vLPOipz7gbDP+3RuGNYeq7OpMD8xDFvqqpJhfimsx8A==
X-Received: by 2002:a17:907:2d8c:b0:94e:e97b:c65 with SMTP id gt12-20020a1709072d8c00b0094ee97b0c65mr2637469ejc.60.1686063405095;
        Tue, 06 Jun 2023 07:56:45 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-214-132.retail.telecomitalia.it. [82.53.214.132])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709063e4f00b00965c529f103sm5619618eji.86.2023.06.06.07.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:56:44 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [RFC PATCH v2 6/7] mm: zswap: simplify writeback function
Date:   Tue,  6 Jun 2023 16:56:10 +0200
Message-Id: <20230606145611.704392-7-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, in zswap, the writeback function was passed to zpool drivers
for their usage in calling the writeback operation. However, since the
drivers did not possess references to entries and the function was
specifically designed to work with handles, the writeback process has
been modified to occur directly within zswap. Consequently, this change
allows for some simplification of the writeback function, taking into
account the updated workflow.

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 69 ++++++++++++++----------------------------------------
 1 file changed, 17 insertions(+), 52 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 2831bf56b168..ef8604812352 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -250,7 +250,8 @@ static bool zswap_has_pool;
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpool))
 
-static int zswap_writeback_entry(struct zpool *pool, unsigned long handle);
+static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header *zhdr,
+				 struct zswap_tree *tree);
 static int zswap_pool_get(struct zswap_pool *pool);
 static void zswap_pool_put(struct zswap_pool *pool);
 
@@ -632,15 +633,21 @@ static int zswap_shrink(struct zswap_pool *pool)
 	}
 	spin_unlock(&tree->lock);
 
-	ret = zswap_writeback_entry(pool->zpool, lru_entry->handle);
+	ret = zswap_writeback_entry(lru_entry, zhdr, tree);
 
 	spin_lock(&tree->lock);
 	if (ret) {
 		spin_lock(&pool->lru_lock);
 		list_move(&lru_entry->lru, &pool->lru);
 		spin_unlock(&pool->lru_lock);
+		zswap_entry_put(tree, tree_entry);
+	} else {
+		/* free the local reference */
+		zswap_entry_put(tree, tree_entry);
+		/* free the entry if it's not been invalidated*/
+		if (lru_entry == zswap_rb_search(&tree->rbroot, swpoffset))
+			zswap_entry_put(tree, tree_entry);
 	}
-	zswap_entry_put(tree, tree_entry);
 	spin_unlock(&tree->lock);
 
 	return ret ? -EAGAIN : 0;
@@ -1039,16 +1046,14 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
  * the swap cache, the compressed version stored by zswap can be
  * freed.
  */
-static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
+static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header *zhdr,
+				 struct zswap_tree *tree)
 {
-	struct zswap_header *zhdr;
-	swp_entry_t swpentry;
-	struct zswap_tree *tree;
-	pgoff_t offset;
-	struct zswap_entry *entry;
+	swp_entry_t swpentry = zhdr->swpentry;
 	struct page *page;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
+	struct zpool *pool = entry->pool->zpool;
 
 	u8 *src, *tmp = NULL;
 	unsigned int dlen;
@@ -1063,25 +1068,6 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 			return -ENOMEM;
 	}
 
-	/* extract swpentry from data */
-	zhdr = zpool_map_handle(pool, handle, ZPOOL_MM_RO);
-	swpentry = zhdr->swpentry; /* here */
-	tree = zswap_trees[swp_type(swpentry)];
-	offset = swp_offset(swpentry);
-	zpool_unmap_handle(pool, handle);
-
-	/* find and ref zswap entry */
-	spin_lock(&tree->lock);
-	entry = zswap_entry_find_get(&tree->rbroot, offset);
-	if (!entry) {
-		/* entry was invalidated */
-		spin_unlock(&tree->lock);
-		kfree(tmp);
-		return 0;
-	}
-	spin_unlock(&tree->lock);
-	BUG_ON(offset != entry->offset);
-
 	/* try to allocate swap cache page */
 	switch (zswap_get_swap_cache_page(swpentry, &page)) {
 	case ZSWAP_SWAPCACHE_FAIL: /* no memory or invalidate happened */
@@ -1115,12 +1101,12 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 		dlen = PAGE_SIZE;
 
-		zhdr = zpool_map_handle(pool, handle, ZPOOL_MM_RO);
+		zhdr = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
 		src = (u8 *)zhdr + sizeof(struct zswap_header);
 		if (!zpool_can_sleep_mapped(pool)) {
 			memcpy(tmp, src, entry->length);
 			src = tmp;
-			zpool_unmap_handle(pool, handle);
+			zpool_unmap_handle(pool, entry->handle);
 		}
 
 		mutex_lock(acomp_ctx->mutex);
@@ -1135,7 +1121,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		if (!zpool_can_sleep_mapped(pool))
 			kfree(tmp);
 		else
-			zpool_unmap_handle(pool, handle);
+			zpool_unmap_handle(pool, entry->handle);
 
 		BUG_ON(ret);
 		BUG_ON(dlen != PAGE_SIZE);
@@ -1152,23 +1138,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	put_page(page);
 	zswap_written_back_pages++;
 
-	spin_lock(&tree->lock);
-	/* drop local reference */
-	zswap_entry_put(tree, entry);
-
-	/*
-	* There are two possible situations for entry here:
-	* (1) refcount is 1(normal case),  entry is valid and on the tree
-	* (2) refcount is 0, entry is freed and not on the tree
-	*     because invalidate happened during writeback
-	*  search the tree and free the entry if find entry
-	*/
-	if (entry == zswap_rb_search(&tree->rbroot, offset))
-		zswap_entry_put(tree, entry);
-	spin_unlock(&tree->lock);
-
 	return ret;
-
 fail:
 	if (!zpool_can_sleep_mapped(pool))
 		kfree(tmp);
@@ -1177,13 +1147,8 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	* if we get here due to ZSWAP_SWAPCACHE_EXIST
 	* a load may be happening concurrently.
 	* it is safe and okay to not free the entry.
-	* if we free the entry in the following put
 	* it is also okay to return !0
 	*/
-	spin_lock(&tree->lock);
-	zswap_entry_put(tree, entry);
-	spin_unlock(&tree->lock);
-
 	return ret;
 }
 
-- 
2.34.1

