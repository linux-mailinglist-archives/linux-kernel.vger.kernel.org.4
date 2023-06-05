Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698CA72217F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjFEIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjFEIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:54:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B4E3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:54:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-97458c97333so544607666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685955272; x=1688547272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quwnb7o3aU6jP4gVPkDbqqMh/7gvdqRQsVfv3CnuXWc=;
        b=lIdeY+JOrMPJQm2NIXIo1MYmyMtIRWijY0IeEfWTJqO6LXtLTk2YMpxE5cTdaGqYqY
         ZbAy3O2zvhlTKmMZWnBW0PyCqRzrTfDAfuSvBDd6UbI3CJC1cKQtAYUfFAv7Pme/FE75
         46RG1OvtTDIDR5ZOoXRbOqVj2y6VexDO+4b/f5SM6LmP2fgpnVSsnSAt++H0j8rtAklc
         lMxAwEmgOQXoLTYL9VcZU2z52Wv9cC/XvttYf72xG4xXNdyhDTXGUs4yu4ekBauZbHFV
         Jb7x+YN4r/CX2cWq6YzrgVorap/HskToNeFwDwlIKDNC0nDOye/Fo4iGMPUz/mVgQqnI
         79xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685955272; x=1688547272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quwnb7o3aU6jP4gVPkDbqqMh/7gvdqRQsVfv3CnuXWc=;
        b=FB3RV9it2L7thprlx+z6f+pPs6LpplQS5lNfqasx98JSoLGJ4h83tOF7j2DqierLKL
         s+5GBqs08MClPiujUFwOPYZhQRlhep67Z/oHpJal7xlklak9yMbQzRMkTLGLKk74rmMr
         QHzvj3GVIXLli1SnH3a9Mh3A6yZKzGWNewQTFQZ2S8t3mVz9WMHI2eCmGBdRwsySHaDc
         O8l0Z1q0cBhDfc/F+rkmvis5STEZ2SY83dDdTDs7vWSSdPBVcQgbuFBuw87PxmJr+yqT
         msnAAFbpv/8kdXcJZoKwFhKaWW0alFbCZLt0bmwO7ZrAhnQ1rVu0/VQutYYI3ZAIEJdg
         Ii/w==
X-Gm-Message-State: AC+VfDzir/BoBPMTWS0NGqc3nCXiaF6ZmgOFkHSSk8H4Ht0M2hlAg3ul
        IR55yEoyuQ1CNOG14T/msus=
X-Google-Smtp-Source: ACHHUZ5vEQh4rSUK2fN+W5tYCUp98IshLSa9LzQb+m3ueetPEd+mwYBHYrDdglIhW6YgfKaYSFK/gw==
X-Received: by 2002:a17:907:6089:b0:94e:afa6:299f with SMTP id ht9-20020a170907608900b0094eafa6299fmr6692778ejc.22.1685955272281;
        Mon, 05 Jun 2023 01:54:32 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-8-153.retail.telecomitalia.it. [82.53.8.153])
        by smtp.gmail.com with ESMTPSA id lx5-20020a170906af0500b00965c6c63ea3sm4048915ejb.35.2023.06.05.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:54:31 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [RFC PATCH 6/7] mm: zswap: simplify writeback function
Date:   Mon,  5 Jun 2023 10:54:18 +0200
Message-Id: <20230605085419.44383-7-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
References: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
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
 mm/zswap.c | 50 +++++++++++---------------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f5fcb07a181d..8ee30a989508 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -244,7 +244,8 @@ static bool zswap_has_pool;
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpool))
 
-static int zswap_writeback_entry(struct zpool *pool, unsigned long handle);
+static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header *zhdr,
+				 struct zswap_tree *tree);
 static int zswap_pool_get(struct zswap_pool *pool);
 static void zswap_pool_put(struct zswap_pool *pool);
 
@@ -621,7 +622,7 @@ static int zswap_shrink(struct zswap_pool *pool)
 	}
 	spin_unlock(&tree->lock);
 
-	ret = zswap_writeback_entry(pool->zpool, lru_entry->handle);
+	ret = zswap_writeback_entry(lru_entry, zhdr, tree);
 
 	spin_lock(&tree->lock);
 	if (ret) {
@@ -1028,16 +1029,14 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
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
@@ -1052,25 +1051,6 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
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
@@ -1104,12 +1084,12 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
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
@@ -1124,7 +1104,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		if (!zpool_can_sleep_mapped(pool))
 			kfree(tmp);
 		else
-			zpool_unmap_handle(pool, handle);
+			zpool_unmap_handle(pool, entry->handle);
 
 		BUG_ON(ret);
 		BUG_ON(dlen != PAGE_SIZE);
@@ -1142,9 +1122,6 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	zswap_written_back_pages++;
 
 	spin_lock(&tree->lock);
-	/* drop local reference */
-	zswap_entry_put(tree, entry);
-
 	/*
 	* There are two possible situations for entry here:
 	* (1) refcount is 1(normal case),  entry is valid and on the tree
@@ -1152,7 +1129,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	*     because invalidate happened during writeback
 	*  search the tree and free the entry if find entry
 	*/
-	if (entry == zswap_rb_search(&tree->rbroot, offset))
+	if (entry == zswap_rb_search(&tree->rbroot, swp_offset(swpentry)))
 		zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);
 
@@ -1166,13 +1143,8 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
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

