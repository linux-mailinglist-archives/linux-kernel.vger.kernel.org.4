Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C379621D0B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKHTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKHTcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:32:14 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA1F682B7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:32:12 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r18so14227643pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 11:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtNgGl1ujIcnJmyweLV5m7PzX6xgoQT5EqlkUSI6PN4=;
        b=CyOeV3YR6WRXm9NAlBA+Dp/PY8YjpvxWUqOk9TAlz7g/mObVJI4JA3foNBQN+I+TtX
         VY45KurMLA224PLyhlSrDXngV7pOYZIVDg3ko+rjZXpM/uQuxVsi2UTTY0tU95FDQxvu
         GHIk0rncMmZdZIU6KFwq57ZIwxKCdqXbdbfhioKXu8JCjMlJvm3IGRNLxVkWgV/4MNwB
         9jrbhFl7AD0jGRjMyTuOi2bG7eSt+CoMUIJyIMbHxkVmBFdEdahXRkoC/sgSKNyADbJw
         vyUZiNTTalkkFX+AN4JNIcfz8987oPqJ1uGbWohr3toeoKyna7g7tEYukGg7sATmYTuO
         11+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtNgGl1ujIcnJmyweLV5m7PzX6xgoQT5EqlkUSI6PN4=;
        b=LPnsYfzL+WEwAlJyXMY3RLyRcMTVb5vwVU3E6eyqSwvMvM1l6m5mzl6BMsxy9oHQd3
         5R2naQQDxfzKjP7U9+Xi7ziY//6aQxAYfhUUfWUklch0Oh49KEeAp3jFr7f26ZbDr1bB
         l6puU5SQ4bgrK0CEQBRe2HjvIYpyzX3vCVMEoqM1GRRmxhEp5K6y2G2uEOm7T296iDw5
         C/dhoO0Y2y5RQ7QiEwT6vhE1EOgogBCtpjgaM97ltcssf8Xyakp8PGiICPcXKIAu4cIv
         ojTqVoxGX1UiBEzsZarAAhcU3GC/5DJbEgp/bdoKbKTSNEm/9XN9UyQyDC7hM5ZUPSnL
         oIUA==
X-Gm-Message-State: ACrzQf0iLlMU5nLC+L3Ei9+gi3pZUJVeXoEDHm/2t2HBFXbo1H1wPdoF
        dE351cpwYw4sCgNWJOpJQ0E=
X-Google-Smtp-Source: AMsMyM7u99nOEGKZb++STMfVqtJU+InEbT6k2C/csUbE3dDzxLEQ/ipP74pO80At2w+h9mXfY8tPjw==
X-Received: by 2002:a63:f50f:0:b0:470:2eca:d84b with SMTP id w15-20020a63f50f000000b004702ecad84bmr24556115pgh.55.1667935932076;
        Tue, 08 Nov 2022 11:32:12 -0800 (PST)
Received: from localhost (fwdproxy-prn-016.fbsv.net. [2a03:2880:ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b0020a28156e11sm8354536pjb.26.2022.11.08.11.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:32:11 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v3 3/5] zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order
Date:   Tue,  8 Nov 2022 11:32:05 -0800
Message-Id: <20221108193207.3297327-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108193207.3297327-1-nphamcs@gmail.com>
References: <20221108193207.3297327-1-nphamcs@gmail.com>
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
 mm/zsmalloc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 326faa751f0a..600c40121544 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -239,6 +239,9 @@ struct zs_pool {
 	/* Compact classes */
 	struct shrinker shrinker;

+	/* List tracking the zspages in LRU order by most recently added object */
+	struct list_head lru;
+
 #ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
 #endif
@@ -260,6 +263,10 @@ struct zspage {
 	unsigned int freeobj;
 	struct page *first_page;
 	struct list_head list; /* fullness list */
+
+	/* links the zspage to the lru list in the pool */
+	struct list_head lru;
+
 	struct zs_pool *pool;
 #ifdef CONFIG_COMPACTION
 	rwlock_t lock;
@@ -352,6 +359,16 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
 	kmem_cache_free(pool->zspage_cachep, zspage);
 }

+/* Moves the zspage to the front of the zspool's LRU */
+static void move_to_front(struct zs_pool *pool, struct zspage *zspage)
+{
+	assert_spin_locked(&pool->lock);
+
+	if (!list_empty(&zspage->lru))
+		list_del(&zspage->lru);
+	list_add(&zspage->lru, &pool->lru);
+}
+
 /* pool->lock(which owns the handle) synchronizes races */
 static void record_obj(unsigned long handle, unsigned long obj)
 {
@@ -953,6 +970,7 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 	}

 	remove_zspage(class, zspage, ZS_EMPTY);
+	list_del(&zspage->lru);
 	__free_zspage(pool, class, zspage);
 }

@@ -998,6 +1016,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		off %= PAGE_SIZE;
 	}

+	INIT_LIST_HEAD(&zspage->lru);
+
 	set_freeobj(zspage, 0);
 }

@@ -1418,6 +1438,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
 		class_stat_inc(class, OBJ_USED, 1);
+		/* Move the zspage to front of pool's LRU */
+		move_to_front(pool, zspage);
 		spin_unlock(&pool->lock);

 		return handle;
@@ -1444,6 +1466,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)

 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
+	/* Move the zspage to front of pool's LRU */
+	move_to_front(pool, zspage);
 	spin_unlock(&pool->lock);

 	return handle;
@@ -1967,6 +1991,7 @@ static void async_free_zspage(struct work_struct *work)
 		VM_BUG_ON(fullness != ZS_EMPTY);
 		class = pool->size_class[class_idx];
 		spin_lock(&pool->lock);
+		list_del(&zspage->lru);
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&pool->lock);
 	}
@@ -2278,6 +2303,8 @@ struct zs_pool *zs_create_pool(const char *name)
 	 */
 	zs_register_shrinker(pool);

+	INIT_LIST_HEAD(&pool->lru);
+
 	return pool;

 err:
--
2.30.2
