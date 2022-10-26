Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B6360E9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiJZUG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiJZUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:06:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BE995ADD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:18 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id io19so10309771plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtNgGl1ujIcnJmyweLV5m7PzX6xgoQT5EqlkUSI6PN4=;
        b=Ak7cByKPgon/K+vDdR2mu/7sGLxErzFBRAs9CPl/Vts21w7AkP4S5jY0ZME5DdBENG
         CXkN2fTEH0rHR2UKBWxrMeBziN7WYtnWQCs1yDhMdkTf2P2F4oW0gbcPs2z1zSumYQGo
         IHMYEJZfsd6r1WI32+V2VvxUailYFWNanKeY6G40uKbzQStdjERrhsuyyWIbJtw7+Pz2
         dlGR4WHcRAhuq2E+gh5FA7fB1Oa4T3YhkuU9BBmihLr6gtKeOHPFstO36u29uEdKCvCI
         ccn4mJ9sJ3YfcLwnXPJL0g7BoHme9xKx5zjKN/x0kRZo129LyklvxE0Gtv5GXcv4AiSs
         TMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtNgGl1ujIcnJmyweLV5m7PzX6xgoQT5EqlkUSI6PN4=;
        b=nQeq7X9W2o7lShru7mljWX5pU1Pcbg3b1VnUX2PNE5IJprVl7/KvMCCq1ZMcaw3k4Y
         Shnjdqw6E6doudf02JQ8BuIjN6Vken5CheH4AiVcO0UnUOamfoM0kjLkfKcuQkormm4h
         gcPWcjSKJi6nhfzgR3qgNtVW3vmAHWqB/7hamtUsv/qdx93ULk8ggF78OyDqkqjWX4ju
         DJLObmusQTt1yO4KLSpxDyagHQ1TUqubL9LqloztF1cJ/QDM5IV/XOfQoRnEBidFWEcT
         T5y8m+/fZaoXibB443k9jmtNMmGb3zAxgx0zkkicVlJ+DuYfCamRZxwq5ptwk0PlZo/8
         bIlA==
X-Gm-Message-State: ACrzQf19oIK4Z38jgIj9wA3GjzLb4k/zskRfkUYRZMptULmMAORxF+V7
        iUHaIXOlcVNeiNWSe6Rvhp0N0EJbWNEVjQ==
X-Google-Smtp-Source: AMsMyM69dE2vohY2y2Qlpn6x5W7TgYhRydzzBEXDWYTfnYfcOfNhLM0TUS2OMp62BE0vJPDawoGQlA==
X-Received: by 2002:a17:902:ab89:b0:186:7cfc:cde8 with SMTP id f9-20020a170902ab8900b001867cfccde8mr29379358plr.9.1666814778018;
        Wed, 26 Oct 2022 13:06:18 -0700 (PDT)
Received: from localhost (fwdproxy-prn-019.fbsv.net. [2a03:2880:ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id y17-20020aa79e11000000b0056be4dbd4besm3363241pfq.111.2022.10.26.13.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:06:17 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH 3/5] zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order
Date:   Wed, 26 Oct 2022 13:06:11 -0700
Message-Id: <20221026200613.1031261-4-nphamcs@gmail.com>
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

