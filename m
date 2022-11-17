Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEE162E226
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbiKQQja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbiKQQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:38:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33635BD5C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:38:45 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 130so2282130pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+p1hPj61mepMRhXTZUUxeqFE4oggG2yUtQcHGL8WEqI=;
        b=R3zzWdjc5t/hqkJuKcDtHkIvecRh7pqG32ZDOeKpoiUvm6JWW16cQBdC0opssauqa9
         7zeNitEvIVRebPigqX1DOwT3lIXMPvIrYMmLV7WkKYai7bdcJur42doKXuGhgA1fWBYK
         YFET9iVKGKSnxcLUCzXWNasfQb4KvedIQ9EowX60sMHs/Ld+qan1Mhc9DOB34LoHONqi
         Wvrl1qxUfanPwueBdkvDOoynmkJBWjVNnj7WNgCC0XQ9hDnWZ7MQ33Ou4FhLpnWCnigG
         APgiIfw/vUuNDUgu8e0jgjJNvt/dfCUDFpIXhUm+WFMytCiLp9x5nCUsim84H9lqgcf7
         xs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+p1hPj61mepMRhXTZUUxeqFE4oggG2yUtQcHGL8WEqI=;
        b=qt5IStls3ihDV3zsR0xyvjZodpnXFu7EEC52bEriPnu83cqiI11WQWY4H0xrylYNB+
         E5XC2BX3jngrETq+gBFBGy4a8wt9uvC8fKi2cenBByafnUZ7dpw+7RIr4bLIbsguY7G4
         W45Fi28x45eIDa+ny4Wc12DL2mL1SUjQFyApXdvz1ej7ilMnzcv9IalDpC4IUQEjF/fq
         sZYU+9buDnz9e/iOzC1Q3ymYv9oHf0zcNYqDcM5DHqTOjZnXiU8oQFiI9xunFFfCVzm0
         uZi8uk8PryuAXwQR/CleQv2Z2r/EZ5WBs12zf7nvAxU7oeLoTYgzVYGj+AyZ7G+/JUCT
         F2yg==
X-Gm-Message-State: ANoB5pm5kSzo1w+Wr4jGUQNez1Ncc/H1hQrWecKeG/aubca4kwqM/xN9
        3Wa7NuL1knT2khYYAyC9UDs=
X-Google-Smtp-Source: AA0mqf5I9JnPFeNm/aV8+xxE4ZiIxU0CP+AdVIaS0pp0EvR8dF6GS5lQnCasEfg8QfuISDAhtOtnSA==
X-Received: by 2002:a05:6a00:2352:b0:572:91c6:9e4e with SMTP id j18-20020a056a00235200b0057291c69e4emr3760746pfj.53.1668703125266;
        Thu, 17 Nov 2022 08:38:45 -0800 (PST)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a23-20020aa79717000000b0056bc31f4f9fsm1373044pfg.65.2022.11.17.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:38:44 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v4 3/5] zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order
Date:   Thu, 17 Nov 2022 08:38:37 -0800
Message-Id: <20221117163839.230900-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117163839.230900-1-nphamcs@gmail.com>
References: <20221117163839.230900-1-nphamcs@gmail.com>
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
 mm/zsmalloc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 326faa751f0a..2557b55ec767 100644
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

@@ -1418,6 +1448,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
 		class_stat_inc(class, OBJ_USED, 1);
+
+#ifdef CONFIG_ZPOOL
+		/* Move the zspage to front of pool's LRU */
+		move_to_front(pool, zspage);
+#endif
 		spin_unlock(&pool->lock);

 		return handle;
@@ -1444,6 +1479,10 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)

 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
+#ifdef CONFIG_ZPOOL
+	/* Move the zspage to front of pool's LRU */
+	move_to_front(pool, zspage);
+#endif
 	spin_unlock(&pool->lock);

 	return handle;
@@ -1967,6 +2006,9 @@ static void async_free_zspage(struct work_struct *work)
 		VM_BUG_ON(fullness != ZS_EMPTY);
 		class = pool->size_class[class_idx];
 		spin_lock(&pool->lock);
+#ifdef CONFIG_ZPOOL
+		list_del(&zspage->lru);
+#endif
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&pool->lock);
 	}
@@ -2278,6 +2320,10 @@ struct zs_pool *zs_create_pool(const char *name)
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
