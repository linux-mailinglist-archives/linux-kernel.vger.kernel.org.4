Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFE60E9DC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiJZUGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiJZUGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:06:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110219E0D5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so1424801pjd.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdXYXXujE5c6Z8uTdZ5KokARMRQa3FrJU+bkNzs2RLY=;
        b=Hi53eiNft/uxfPCA9DiEpqEUXzmt5CELkUIG4MFbzeAEA0yq6pTdtJTWBHdXP5SCiS
         n2Ur0KkDeGzYyPPU9S1a9htUfQlaijj8CCXdjA4PC9kS7VA9vxREY3Cw/N9LFE9f1bnA
         fZiNG0Brr5sdQwx9wEuZveHTnAKm4SpFqqTBNfi1t7B+g8OZ9ipJcZZOWrfcjQcGjNDC
         uGdiBtgZuRgYQ8HrD+09R/mRUyEq/IVckBQ6SkfC1zPCm3EtYyYiOPvYovyty4U1n2lH
         dGHYFWO8wt3JAUfVkXbtouiJ1q1G+6Ual7nwO3I/SWEYqWiCnwLKxXhDETzKFL1OtyCF
         sHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdXYXXujE5c6Z8uTdZ5KokARMRQa3FrJU+bkNzs2RLY=;
        b=Ak8//1fxf8wkUTGfX8Z81TlCFsr9xw0+V1mCwn/L6wFdl/ERt7GXg0WAKsQgF+9onf
         78+clb0O0Oa5uELhKCERtCix2N8NFjK0lRvdsgmO8iDfln9smeJyah9rSpnlc3mxlAvB
         b7gl/RFioxJNr8bOSQPpRl7tRBW+pAkQMuf48Wfm6zaf268tN2MSHFe84Xx2MLfX+AVL
         +1afW76P9D0lMS6pQsngYUEoZie1XdrsYL2nIah7MfCjACaKc9sM/RXpjw/3J29ubzqH
         omKdApHCmalqakDjU6+R16QQO8OUgg4upF+X2NgD3AYJyIDwhwdTBOEwvoqkkPwXn+yc
         XHug==
X-Gm-Message-State: ACrzQf3evAfZ/OUfhQYimF86ysiVDCW43e6Ox3UfNSmKIcrvxbeWi1rr
        fn9HcXdkQU9dXu7Ch2gPeIaQjPXkcxHSmQ==
X-Google-Smtp-Source: AMsMyM4iFxW9DroEwTO8biUJrN1XDhw8KUDpdW0Isf4jh0mJSFOpt+BANcnAvrvFY5OCPpE4+BCl/g==
X-Received: by 2002:a17:902:f710:b0:184:7a4c:fdc1 with SMTP id h16-20020a170902f71000b001847a4cfdc1mr45443478plo.27.1666814775478;
        Wed, 26 Oct 2022 13:06:15 -0700 (PDT)
Received: from localhost (fwdproxy-prn-015.fbsv.net. [2a03:2880:ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id y27-20020aa7943b000000b0056c47a5c34dsm1775845pfo.122.2022.10.26.13.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:06:15 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH 1/5] zswap: fix writeback lock ordering for zsmalloc
Date:   Wed, 26 Oct 2022 13:06:09 -0700
Message-Id: <20221026200613.1031261-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221026200613.1031261-1-nphamcs@gmail.com>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
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

