Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE3F63084B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiKSBTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiKSBSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:18:14 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808EEF5A19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:15:43 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 62so6287191pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlNO430pFQOka1esCEqa7IqA23nNPCeXNP57iQ3X88k=;
        b=dou3yaHyJKMOuyzUjM+AISJf6d71pZrUfWgikbtI9j3Y6hoNgor6yN25JPdwAaQ20T
         bmEir2kFtNskQqAa6VxLNCDTkWDBSHlNjmNr1BjrGtRvWaoVjBjwCe2CNlGrMB9dPazV
         zVupTfokhJ0RXHrTqeO8XRh2Sl5a0XajITvW/0w0eEWrXHyjTEthY+XOlM1/P3Qx+FOk
         PojrXY03qZdpjSSaqO9sYspzBL7r770DMqA1qyL4NgGRnuKeKEWvSnSjInRtGVvk6Vgd
         LqD/1+XOJo0RiC3b6nmNF2vpTvmAVhB1Dh2dkK+s9F02Uq+tVt1tf0f7PGy4eLuCIXyD
         42JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlNO430pFQOka1esCEqa7IqA23nNPCeXNP57iQ3X88k=;
        b=hsgIwZ6S/C4tM4N5k+DjZIzzC1FBwrkYUHatDwG9I4xG39KVwOrjH1FQKxHV415u94
         AhpB6eup9+99gHIOo7u2W+x825lWTOMEsAB8WD0bjNsu/7KwTQ/BTJUIDw4qxzXc+/Jq
         RkJLkmJ+C2CVfVNVbg55tH4ktukqkT0vMzi/BwkEaptNvlzqca0M9ID/+fpguM3IiQgd
         iYby4FfJ3BG5C7x/g1F5efowHtnx1RkGeicN1ibID55xuQ1DCc+YG0SXsOPTH5QJuhtL
         RTwPJRW6T1lbH83TCn69E9eYbooYf0Zg5DIeD+EOMyMt70iXr3fDgsQ/uacyEShbkO4c
         4mrg==
X-Gm-Message-State: ANoB5pm4SVO4WLwGHixUxZTlQIg6aLXa8vWu+iNzxelPESrwHCkqS5yQ
        BifrB2jcxwtpqiK7rxQBq9k=
X-Google-Smtp-Source: AA0mqf6yUmUHE0UvTfSdN0ChRKmCdP7x9U3+tTT0bCMv0jXDGck8BJGrPxpLEzKY2+HNMBmDm17XBg==
X-Received: by 2002:a63:d241:0:b0:439:8688:a98d with SMTP id t1-20020a63d241000000b004398688a98dmr8511296pgi.424.1668816943018;
        Fri, 18 Nov 2022 16:15:43 -0800 (PST)
Received: from localhost (fwdproxy-prn-017.fbsv.net. [2a03:2880:ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id u139-20020a627991000000b00561cf757749sm3751245pfc.183.2022.11.18.16.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 16:15:42 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order
Date:   Fri, 18 Nov 2022 16:15:34 -0800
Message-Id: <20221119001536.2086599-5-nphamcs@gmail.com>
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

This helps determines the coldest zspages as candidates for writeback.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zsmalloc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 326faa751f0a..7dd464b5a6a5 100644
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
@@ -953,6 +964,9 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 	}

 	remove_zspage(class, zspage, ZS_EMPTY);
+#ifdef CONFIG_ZPOOL
+	list_del(&zspage->lru);
+#endif
 	__free_zspage(pool, class, zspage);
 }

@@ -998,6 +1012,10 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		off %= PAGE_SIZE;
 	}

+#ifdef CONFIG_ZPOOL
+	INIT_LIST_HEAD(&zspage->lru);
+#endif
+
 	set_freeobj(zspage, 0);
 }

@@ -1249,6 +1267,15 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);

+#ifdef CONFIG_ZPOOL
+	/* Move the zspage to front of pool's LRU */
+	if (mm == ZS_MM_WO) {
+		if (!list_empty(&zspage->lru))
+			list_del(&zspage->lru);
+		list_add(&zspage->lru, &pool->lru);
+	}
+#endif
+
 	/*
 	 * migration cannot move any zpages in this zspage. Here, pool->lock
 	 * is too heavy since callers would take some time until they calls
@@ -1967,6 +1994,9 @@ static void async_free_zspage(struct work_struct *work)
 		VM_BUG_ON(fullness != ZS_EMPTY);
 		class = pool->size_class[class_idx];
 		spin_lock(&pool->lock);
+#ifdef CONFIG_ZPOOL
+		list_del(&zspage->lru);
+#endif
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&pool->lock);
 	}
@@ -2278,6 +2308,10 @@ struct zs_pool *zs_create_pool(const char *name)
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
