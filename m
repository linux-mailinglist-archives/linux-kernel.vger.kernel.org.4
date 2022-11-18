Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102BB62FC9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242612AbiKRSZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242698AbiKRSZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:25:08 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4307D970B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:24:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so82617pjk.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdXYXXujE5c6Z8uTdZ5KokARMRQa3FrJU+bkNzs2RLY=;
        b=nkZTR8Kb+B0gk7H1xIfb6LfPuKa1/cZSjTASVzpInLhhWrDd52VMjYvyLSxibmHHod
         XS8PyxlBFQKCwIY7VnVGxHp2GBZlNfH/mDQ4f5E1mblACckXhlpqRDGQD3VKGXrVaLNy
         bo1/KFKE5Sqo1Aa3JN4cuKvISQluxEyKaDUihk3A+AHs589MG38F3CTjzVYiv3aBbekT
         x8m49ihtYKr1AJtwmsvWsD+DhRasBVPL6r5zFur0+0F9Yfp9UH+kmP1I9x8jXDu4nyYc
         GLJJzZhXs5fchmAsncztYOnoY5qanzae0S0voCitkq4P4TSqCe1NvZpSE82KV0vudWgM
         mn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdXYXXujE5c6Z8uTdZ5KokARMRQa3FrJU+bkNzs2RLY=;
        b=c1f6xfRh4ILjJyj+7am8PKdNMI1o1FSokd0M8TobAIIG0m7tQ9mjt9n4OPT5QFYDiA
         7n+PRKuG9OcGwWUzrtMse8BgTmn3bgZNytr8l4mQywL7xnScvQ+mOsFxRCOS1+NKvqjV
         PU8USuEljYMFWWqJy9f/G6IF5qgQuDd91LbVEhW0NjrcHx5ys7DAUTreL2/nbc9fLEbZ
         mrgCuDaUxLtX9Ccp6tCHFE6vOe35kCzjIdyiQ+fng6YMUL6axRdbBImvpDh456V4GXO6
         U9l7P0xxpI48yqObHrEdR7jSRmhIGJDZ/nRFghma16ASGwrfGx/6or1FFvQ0PmkqtOjH
         fGmA==
X-Gm-Message-State: ANoB5pl825jZ2ME37Lz7BNX4lUHD0vZhpBqSrhgnjXYs4xPRVHP9InKV
        BEgDBHFch+Jp51u12td5nl9gdR49RSPcmA==
X-Google-Smtp-Source: AA0mqf4on4UGDZHhIP6GW7D0Rfy6F/6F3IQcotM1yQTtdjyOb/lap7oA9Q9zfmpCA8bD6qY6+PtuEA==
X-Received: by 2002:a17:902:cacd:b0:17f:7d9a:4952 with SMTP id y13-20020a170902cacd00b0017f7d9a4952mr612738pld.117.1668795850563;
        Fri, 18 Nov 2022 10:24:10 -0800 (PST)
Received: from localhost (fwdproxy-prn-023.fbsv.net. [2a03:2880:ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902b68800b00188b5d25438sm4058927pls.35.2022.11.18.10.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:24:10 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v5 1/6] zswap: fix writeback lock ordering for zsmalloc
Date:   Fri, 18 Nov 2022 10:24:02 -0800
Message-Id: <20221118182407.82548-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221118182407.82548-1-nphamcs@gmail.com>
References: <20221118182407.82548-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

zswap's customary lock order is tree->lock before pool->lock, because
the tree->lock protects the entries' refcount, and the free callbacks in
the backends acquire their respective pool locks to dispatch the backing
object. zsmalloc's map callback takes the pool lock, so zswap must not
grab the tree->lock while a handle is mapped. This currently only
happens during writeback, which isn't implemented for zsmalloc. In
preparation for it, move the tree->lock section out of the mapped entry
section

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 2d48fd59cc7a..2d69c1d678fe 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -958,7 +958,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	};

 	if (!zpool_can_sleep_mapped(pool)) {
-		tmp = kmalloc(PAGE_SIZE, GFP_ATOMIC);
+		tmp = kmalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!tmp)
 			return -ENOMEM;
 	}
@@ -968,6 +968,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	swpentry = zhdr->swpentry; /* here */
 	tree = zswap_trees[swp_type(swpentry)];
 	offset = swp_offset(swpentry);
+	zpool_unmap_handle(pool, handle);

 	/* find and ref zswap entry */
 	spin_lock(&tree->lock);
@@ -975,20 +976,12 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	if (!entry) {
 		/* entry was invalidated */
 		spin_unlock(&tree->lock);
-		zpool_unmap_handle(pool, handle);
 		kfree(tmp);
 		return 0;
 	}
 	spin_unlock(&tree->lock);
 	BUG_ON(offset != entry->offset);

-	src = (u8 *)zhdr + sizeof(struct zswap_header);
-	if (!zpool_can_sleep_mapped(pool)) {
-		memcpy(tmp, src, entry->length);
-		src = tmp;
-		zpool_unmap_handle(pool, handle);
-	}
-
 	/* try to allocate swap cache page */
 	switch (zswap_get_swap_cache_page(swpentry, &page)) {
 	case ZSWAP_SWAPCACHE_FAIL: /* no memory or invalidate happened */
@@ -1006,6 +999,14 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 		dlen = PAGE_SIZE;

+		zhdr = zpool_map_handle(pool, handle, ZPOOL_MM_RO);
+		src = (u8 *)zhdr + sizeof(struct zswap_header);
+		if (!zpool_can_sleep_mapped(pool)) {
+			memcpy(tmp, src, entry->length);
+			src = tmp;
+			zpool_unmap_handle(pool, handle);
+		}
+
 		mutex_lock(acomp_ctx->mutex);
 		sg_init_one(&input, src, entry->length);
 		sg_init_table(&output, 1);
@@ -1015,6 +1016,11 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		dlen = acomp_ctx->req->dlen;
 		mutex_unlock(acomp_ctx->mutex);

+		if (!zpool_can_sleep_mapped(pool))
+			kfree(tmp);
+		else
+			zpool_unmap_handle(pool, handle);
+
 		BUG_ON(ret);
 		BUG_ON(dlen != PAGE_SIZE);

@@ -1045,7 +1051,11 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);

-	goto end;
+	return ret;
+
+fail:
+	if (!zpool_can_sleep_mapped(pool))
+		kfree(tmp);

 	/*
 	* if we get here due to ZSWAP_SWAPCACHE_EXIST
@@ -1054,17 +1064,10 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	* if we free the entry in the following put
 	* it is also okay to return !0
 	*/
-fail:
 	spin_lock(&tree->lock);
 	zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);

-end:
-	if (zpool_can_sleep_mapped(pool))
-		zpool_unmap_handle(pool, handle);
-	else
-		kfree(tmp);
-
 	return ret;
 }

--
2.30.2
