Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6FC62FCA2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbiKRSZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242706AbiKRSZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:25:11 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A5A93CC0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:24:15 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k5so5196481pjo.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nOnhYHcTkk9/NzeLLNRVXEnZ77Tqa2lTVIFHU0KWSM=;
        b=MggomevQAHa406kdroPp0BE2cDvQIay2Gb8NdQCWaLxdg4h8AQot1ASw4tHnrl7FLd
         56+aica0cqemAuYdQspMkeDpWecDQelDR9Gc9qbXdKo1TguX0YVwNP11Jvcbka9DyMf+
         cORxRCKMhXQ7OyYFD2CRDeypFzgvstHAfqBBEM6IA+kdMR1ocfxwFRlEe0sxcoWY3i8D
         59gaHU51TAmpnx0iN7dZYwT7Xy8bComPIQp3m/pze4CX4XMOM9l/S9jx3itXvUzIFRhB
         NOpaB2oc7zutl+sPpv4XDKz1Jng9/0SSFGfSAH3pYZiUBDrD1YeHDg+r4oh4Zt/0o3/c
         qM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nOnhYHcTkk9/NzeLLNRVXEnZ77Tqa2lTVIFHU0KWSM=;
        b=vW4HXeeaey/fvMTnXPn7PBMmr/I7ZmA1AQQnHLexGcKjazuCDmQHylmKChJZIyVgD+
         5ahSfVQSZWV+YsxvqZ0WrS/dlyPizHFUQjYwY2Tr3NUfwn94x8P391W3TmAFhUi+p8dA
         2g5xBGveeG0h5zLpOg5kNXhKwJIz36CyVdx7O8N8GFjPiSyzx1QgUSl4JaOy/59sOUhT
         sejqohv3MN5rdTG8xGcM3mIfElmNwtJ1xSTU1JgOSgexgwJinPLouTgzlzPlsnyorhB2
         51v65/mcUzLbSdVxzuNKV9TxJH/B/hygO977I2tPmqI7oZiRpy5wvlSZeJfIpuwq5HpX
         sFYw==
X-Gm-Message-State: ANoB5pnrkNunthkZ6zwEH7dtw1SBsBnc0KUnYvz5UI37vaycSiM857Ja
        LKxt5l1aqWrumHaZ0qDj14TVvWtE7Qn5IQ==
X-Google-Smtp-Source: AA0mqf48DEa51obS+EvE6ftvWMRXSztSatZcDXYbQx5zerFRPZyQr+ZS273CdSAY1gjS6r1rDwBE9w==
X-Received: by 2002:a17:90a:6343:b0:213:b853:5e45 with SMTP id v3-20020a17090a634300b00213b8535e45mr14994881pjs.97.1668795854724;
        Fri, 18 Nov 2022 10:24:14 -0800 (PST)
Received: from localhost (fwdproxy-prn-010.fbsv.net. [2a03:2880:ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b00217cdc4b0a5sm5671207pjb.16.2022.11.18.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:24:14 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v5 4/6] zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order
Date:   Fri, 18 Nov 2022 10:24:05 -0800
Message-Id: <20221118182407.82548-5-nphamcs@gmail.com>
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

This helps determines the coldest zspages as candidates for writeback.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zsmalloc.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 326faa751f0a..9e7b54324181 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -239,6 +239,11 @@ struct zs_pool {
 	/* Compact classes */
 	struct shrinker shrinker;

+#ifdef CONFIG_ZPOOL
+	/* List tracking the zspages in LRU order by most recently added object */
+	struct list_head lru;
+#endif
+
 #ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
 #endif
@@ -260,6 +265,12 @@ struct zspage {
 	unsigned int freeobj;
 	struct page *first_page;
 	struct list_head list; /* fullness list */
+
+#ifdef CONFIG_ZPOOL
+	/* links the zspage to the lru list in the pool */
+	struct list_head lru;
+#endif
+
 	struct zs_pool *pool;
 #ifdef CONFIG_COMPACTION
 	rwlock_t lock;
@@ -352,6 +363,18 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
 	kmem_cache_free(pool->zspage_cachep, zspage);
 }

+#ifdef CONFIG_ZPOOL
+/* Moves the zspage to the front of the zspool's LRU */
+static void move_to_front(struct zs_pool *pool, struct zspage *zspage)
+{
+	assert_spin_locked(&pool->lock);
+
+	if (!list_empty(&zspage->lru))
+		list_del(&zspage->lru);
+	list_add(&zspage->lru, &pool->lru);
+}
+#endif
+
 /* pool->lock(which owns the handle) synchronizes races */
 static void record_obj(unsigned long handle, unsigned long obj)
 {
@@ -953,6 +976,9 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 	}

 	remove_zspage(class, zspage, ZS_EMPTY);
+#ifdef CONFIG_ZPOOL
+	list_del(&zspage->lru);
+#endif
 	__free_zspage(pool, class, zspage);
 }

@@ -998,6 +1024,10 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		off %= PAGE_SIZE;
 	}

+#ifdef CONFIG_ZPOOL
+	INIT_LIST_HEAD(&zspage->lru);
+#endif
+
 	set_freeobj(zspage, 0);
 }

@@ -1418,9 +1448,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
 		class_stat_inc(class, OBJ_USED, 1);
-		spin_unlock(&pool->lock);

-		return handle;
+		goto out;
 	}

 	spin_unlock(&pool->lock);
@@ -1444,6 +1473,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)

 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
+out:
+#ifdef CONFIG_ZPOOL
+	/* Move the zspage to front of pool's LRU */
+	move_to_front(pool, zspage);
+#endif
 	spin_unlock(&pool->lock);

 	return handle;
@@ -1967,6 +2001,9 @@ static void async_free_zspage(struct work_struct *work)
 		VM_BUG_ON(fullness != ZS_EMPTY);
 		class = pool->size_class[class_idx];
 		spin_lock(&pool->lock);
+#ifdef CONFIG_ZPOOL
+		list_del(&zspage->lru);
+#endif
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&pool->lock);
 	}
@@ -2278,6 +2315,10 @@ struct zs_pool *zs_create_pool(const char *name)
 	 */
 	zs_register_shrinker(pool);

+#ifdef CONFIG_ZPOOL
+	INIT_LIST_HEAD(&pool->lru);
+#endif
+
 	return pool;

 err:
--
2.30.2
