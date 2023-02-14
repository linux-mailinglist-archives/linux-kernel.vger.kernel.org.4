Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBCC696D83
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjBNTCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjBNTCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:02:43 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4DD25967;
        Tue, 14 Feb 2023 11:02:39 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id y8so947067ilv.1;
        Tue, 14 Feb 2023 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPPamIyRpbGBQ5ryZF3ausqPZtq/gq8Gwr+ekJX0vLw=;
        b=maTfyp8N7g3NFmHY2zeN8YjUoTVcYuR7ajHYTMcSRQzHkFYDHmJhx9ivtMUdBVF71L
         GQn4jY6oHeJqVgK7GJEF9aLjpgWkCTqjGs3hbIXrso1oVFzSV1eo9609BfFbuuuBBCuI
         ZyGyKx8aU7z1Om3ICTXa1KR7/JLA9jQTSprAIC8dEz7zaymZt3th4EEmYbwsrXXlC+p1
         sxZ7SNbSVNo/pkS61yMLbC5HX9no9qZGegY9IG9qe3Rj+1PzQlqNTBYxeczquNnk6ooA
         Oc5s7X0SnOx68eQv4KuSVtS35HYPX7X0fqe6ZVipE81nnvy/AAEtYche0HnA6lbxB56E
         CXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPPamIyRpbGBQ5ryZF3ausqPZtq/gq8Gwr+ekJX0vLw=;
        b=zKyCR8RXbVBQAJkeJThUYrrXeR9iG6X7liFveDUITFmsRRn67QATmb304TM8qL7tOx
         vDjmkZ5PwHcYMeegE9gjKA2mRARwZbrFKWwqS2NOAU6k5eaES1JCK/0WkYKXU0c0TPUu
         ZP8BtvnpDCVgFhtML2AuoXYtK1sWskudnCT66YpKWVTdYqqG/jZQhbyevuzGe/lLQb9d
         p0mR8dZy3YpFez4nN+VuPdUQf7/K1HnFThpXeTkx71tELhSIFnkjL90U0geNwpylfCdo
         SRR8YAHdxjW5L3Js361SkVoFwVahlN7kcl53MBwd0ncZ7pushdedOFICbjSc34pTJK7g
         xahw==
X-Gm-Message-State: AO0yUKV3uDWJnKReMyuuyffwFyAQ9VA5mSnqJpVVgrE1MkQLgkOjxl1H
        EjyWYLNlRiz5PyH24JJY6BY=
X-Google-Smtp-Source: AK7set+eY5XAwZXkOnW0qFOv85zlppyeV5NeG8+1WBt2UYlWnui6VEDbC+TuErm7ZvFyUGKQs5ccQQ==
X-Received: by 2002:a92:c241:0:b0:310:fa45:ac78 with SMTP id k1-20020a92c241000000b00310fa45ac78mr2181236ilo.29.1676401358385;
        Tue, 14 Feb 2023 11:02:38 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id r11-20020a056e0219cb00b0030c27c9eea4sm3608770ill.33.2023.02.14.11.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:02:38 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/5] mm: mempool: extract the common initialization and alloc code
Date:   Tue, 14 Feb 2023 11:02:18 -0800
Message-Id: <20230214190221.1156876-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214190221.1156876-1-shy828301@gmail.com>
References: <20230214190221.1156876-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the common initialization code to __mempool_init() and
__mempool_create().  And extract the common alloc code into an internal
function.  This will make the following patch easier and avoid duplicate
code.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/mempool.c | 93 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 36 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 734bcf5afbb7..975c9d1491b6 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -182,9 +182,10 @@ void mempool_destroy(mempool_t *pool)
 }
 EXPORT_SYMBOL(mempool_destroy);
 
-int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
-		      mempool_free_t *free_fn, void *pool_data,
-		      gfp_t gfp_mask, int node_id)
+static inline int __mempool_init(mempool_t *pool, int min_nr,
+				 mempool_alloc_t *alloc_fn,
+				 mempool_free_t *free_fn, void *pool_data,
+				 gfp_t gfp_mask, int node_id)
 {
 	spin_lock_init(&pool->lock);
 	pool->min_nr	= min_nr;
@@ -214,6 +215,14 @@ int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 
 	return 0;
 }
+
+int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
+		      mempool_free_t *free_fn, void *pool_data,
+		      gfp_t gfp_mask, int node_id)
+{
+	return __mempool_init(pool, min_nr, alloc_fn, free_fn, pool_data,
+			      gfp_mask, node_id);
+}
 EXPORT_SYMBOL(mempool_init_node);
 
 /**
@@ -233,12 +242,30 @@ EXPORT_SYMBOL(mempool_init_node);
 int mempool_init(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 		 mempool_free_t *free_fn, void *pool_data)
 {
-	return mempool_init_node(pool, min_nr, alloc_fn, free_fn,
-				 pool_data, GFP_KERNEL, NUMA_NO_NODE);
-
+	return __mempool_init(pool, min_nr, alloc_fn, free_fn,
+			      pool_data, GFP_KERNEL, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL(mempool_init);
 
+static mempool_t *__mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
+				   mempool_free_t *free_fn, void *pool_data,
+				   gfp_t gfp_mask, int node_id)
+{
+	mempool_t *pool;
+
+	pool = kzalloc_node(sizeof(*pool), gfp_mask, node_id);
+	if (!pool)
+		return NULL;
+
+	if (__mempool_init(pool, min_nr, alloc_fn, free_fn, pool_data,
+			   gfp_mask, node_id)) {
+		kfree(pool);
+		return NULL;
+	}
+
+	return pool;
+}
+
 /**
  * mempool_create - create a memory pool
  * @min_nr:    the minimum number of elements guaranteed to be
@@ -258,8 +285,8 @@ EXPORT_SYMBOL(mempool_init);
 mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 				mempool_free_t *free_fn, void *pool_data)
 {
-	return mempool_create_node(min_nr, alloc_fn, free_fn, pool_data,
-				   GFP_KERNEL, NUMA_NO_NODE);
+	return __mempool_create(min_nr, alloc_fn, free_fn, pool_data,
+				GFP_KERNEL, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL(mempool_create);
 
@@ -267,19 +294,8 @@ mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
 			       mempool_free_t *free_fn, void *pool_data,
 			       gfp_t gfp_mask, int node_id)
 {
-	mempool_t *pool;
-
-	pool = kzalloc_node(sizeof(*pool), gfp_mask, node_id);
-	if (!pool)
-		return NULL;
-
-	if (mempool_init_node(pool, min_nr, alloc_fn, free_fn, pool_data,
-			      gfp_mask, node_id)) {
-		kfree(pool);
-		return NULL;
-	}
-
-	return pool;
+	return __mempool_create(min_nr, alloc_fn, free_fn, pool_data,
+				gfp_mask, node_id);
 }
 EXPORT_SYMBOL(mempool_create_node);
 
@@ -363,21 +379,7 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 }
 EXPORT_SYMBOL(mempool_resize);
 
-/**
- * mempool_alloc - allocate an element from a specific memory pool
- * @pool:      pointer to the memory pool which was allocated via
- *             mempool_create().
- * @gfp_mask:  the usual allocation bitmask.
- *
- * this function only sleeps if the alloc_fn() function sleeps or
- * returns NULL. Note that due to preallocation, this function
- * *never* fails when called from process contexts. (it might
- * fail if called from an IRQ context.)
- * Note: using __GFP_ZERO is not supported.
- *
- * Return: pointer to the allocated element or %NULL on error.
- */
-void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
+static void *__mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 {
 	void *element;
 	unsigned long flags;
@@ -444,6 +446,25 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 	finish_wait(&pool->wait, &wait);
 	goto repeat_alloc;
 }
+
+/**
+ * mempool_alloc - allocate an element from a specific memory pool
+ * @pool:      pointer to the memory pool which was allocated via
+ *             mempool_create().
+ * @gfp_mask:  the usual allocation bitmask.
+ *
+ * this function only sleeps if the alloc_fn() function sleeps or
+ * returns NULL. Note that due to preallocation, this function
+ * *never* fails when called from process contexts. (it might
+ * fail if called from an IRQ context.)
+ * Note: using __GFP_ZERO is not supported.
+ *
+ * Return: pointer to the allocated element or %NULL on error.
+ */
+void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
+{
+	return __mempool_alloc(pool, gfp_mask);
+}
 EXPORT_SYMBOL(mempool_alloc);
 
 /**
-- 
2.39.0

