Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484F4630848
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKSBSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiKSBSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:18:12 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF61169C19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:15:39 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso6500902pjc.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdXYXXujE5c6Z8uTdZ5KokARMRQa3FrJU+bkNzs2RLY=;
        b=NHkIkh8RaR25rj7+Wlw0rbe1vzjooV8Fsu/f07L3zCG5lUFzcdTGGBtND54rMrvFn2
         1nztmuMnmKeDkLPZsShRcJCn8KfZDSS2xoMxkJ+8eWbfouubZv8PETaQAHxCEEQyuRcP
         7dtpmnLSJFtricXu29dRABoMD0uTm0Xv+9F3R8Z0zOZfzFHEh/jZfd89vph1ur+jnvoi
         qe4O0YDtzONH4Dze1Yr/u8DHfwdnbozJEOewCLH0RyGcNrdx/Q/rLMIXB5yDuzL+iHp+
         RKiSsuMYn6PCIoOSsyr2vmZRFTqbXCde8fgnZhLJQEkH9ydslMP7E4Ww+Oh0mh53K7e2
         lK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdXYXXujE5c6Z8uTdZ5KokARMRQa3FrJU+bkNzs2RLY=;
        b=G5R/8R7YXRr8brXvoLTTrFp6NL8YOyaF9a3oOeBBVQesgcjrHbvBd06hEDdKntOA85
         PqaxQkBshUbcCwNnC756/KHa+oOLas/kvw0wBgPHuUDTZMHxq18NcWuZdslxP1gVPoBP
         qetMNhRozlBedAVIifm5p7mvgG2cTDBjHgWkmfH/SFHRNaRmSdDPkZERo8Lo581c++Qr
         y+hbtPmQvlVdMNja+L8Yh9qCJkSyp8KqTZepd2UMM6QHWv6Y+24scRW4SJ/2uKz2d3ih
         x74wIYldEZkfHLvZTmYUy0K3H5I3LwHujwNGf8Mg7XUN+OB7iQMl5EuS86YenVzKtugr
         SUgw==
X-Gm-Message-State: ANoB5pmD5A42mbvOeA23Wr5wq7b+bLsKiBUIQufB6fqefL7K3FxfHArz
        GnkuTwbRcDBE0uZXHUp5aCI=
X-Google-Smtp-Source: AA0mqf7QZyc8yIJTE5WAZ0IZUUaf0nqx+pCwp3EewXFYXciM0TOgmftRCHrHwYQYKAVKePw7j1Pq+w==
X-Received: by 2002:a17:902:9a03:b0:186:9f20:e7e2 with SMTP id v3-20020a1709029a0300b001869f20e7e2mr1578912plp.174.1668816939044;
        Fri, 18 Nov 2022 16:15:39 -0800 (PST)
Received: from localhost (fwdproxy-prn-010.fbsv.net. [2a03:2880:ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0017f48a9e2d6sm4202332pln.292.2022.11.18.16.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 16:15:38 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v6 1/6] zswap: fix writeback lock ordering for zsmalloc
Date:   Fri, 18 Nov 2022 16:15:31 -0800
Message-Id: <20221119001536.2086599-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119001536.2086599-1-nphamcs@gmail.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
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
