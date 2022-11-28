Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1141A63B1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiK1TQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiK1TQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:16:20 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0B32A723
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:19 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id a9so8014237pfr.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/z8xBFicb3R2PeUO5QeKRD0fnuKCQ0SAaRvKkmAk3E=;
        b=MoXOV1pWeYXh6PbisJX01BZJce1uz4bNi3N8VaqG8qKv7jhznnybAwHouVcezuswdR
         3rwSPKUFecPuAqXKIoX9s/uUVgU68mSe/sp8MPwWcYHzOZeybPexk8iEXBciozwzH8NG
         sa0DhlIdnpCghqfW9A+bG/zOqBnNUeb+tU4ahX2OTZ91qq4y9OFv6kqUavWrjuNyDrFC
         Ntg+DiGiJghENQ0wYrDIrlOZlrdtQL9QW4WWsFVFhBPrytQznW3ck7MRBQ2PjxbPzXsN
         5UL0J2LZF9HCtnimSrb8Av0tYmDx4N2egUI/lwL6hOtm9JRmADw9kL8vrmt2zF0F77Ke
         Ha+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/z8xBFicb3R2PeUO5QeKRD0fnuKCQ0SAaRvKkmAk3E=;
        b=7BnNNKBHeBTcnjvSN2isnii0LkB4jMza6mZzNT0eu06JRto1Ct8vQEVwCl+sw0l1Q2
         FemrwbyN/5yMY32jLNGtdDJ2lWnON37rlc6lYCYL/cYbOfWJCzm0FIVq9Lpsjfku27SK
         TfZFXy7GTAbLWlILsr+XOdQwQxGJ6/tR9xQu0yb81fLLCSpa0XxDTrs/tvtH4/m20CnB
         KchLjgIKZc9CxnXdAcdaRYNHwclPoaDEsPcPNSuUlQ+usc2u0R4XGVgoNilPv7lc6leU
         CsSdiLgbGOeNolYW2C3nWfP0rxLOKN8Vw9EdUm5sacKSN9yzzVSB8gfW0MQ80pK7a0m/
         lK9w==
X-Gm-Message-State: ANoB5pnQCNe5IBVu+HrRyonQMjB1bOc6aoffHiD8rTfgPOPf68ZGHJWQ
        dE1cCHIMuZjovz7T+jwpm3E=
X-Google-Smtp-Source: AA0mqf523izJHxzI+4A7CQUZVosROEwsf3PehmYpsrWuusjaoiqMgcmIdQp5MoYFCbbxgrsbbKH3JQ==
X-Received: by 2002:a63:5a56:0:b0:46e:9bac:17f with SMTP id k22-20020a635a56000000b0046e9bac017fmr31414467pgm.420.1669662978660;
        Mon, 28 Nov 2022 11:16:18 -0800 (PST)
Received: from localhost (fwdproxy-prn-013.fbsv.net. [2a03:2880:ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 67-20020a630346000000b0046f1e8cb30dsm7187107pgd.26.2022.11.28.11.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:16:18 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v7 1/6] zswap: fix writeback lock ordering for zsmalloc
Date:   Mon, 28 Nov 2022 11:16:10 -0800
Message-Id: <20221128191616.1261026-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128191616.1261026-1-nphamcs@gmail.com>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
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
 mm/zswap.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 3019f0bde194..f6c89049cf70 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
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
