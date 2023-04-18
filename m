Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BA56E5ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDRHqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjDRHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:46:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8CC59E4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:46:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a67bcde3a7so21348115ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681804005; x=1684396005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h22ktkGMKWxVcxcaUxYu0h0WFMmYisG3d/tdFq9yk7c=;
        b=nAKwtwifeDZqZJY91VY4uctqfDAWvCJ8kPEnIdBPWP7nOCP+19w2A8evcSTy4aTXiK
         yj/dq6QyuaZW3oa0iB99dQ/GA/I0wivzBZA7HK4zAMwgfQe6ThDPlUrdvS+cWRz6iUjg
         rqUhYmna5js5NTsmoWbHHlyW2mNrCOezZspQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681804005; x=1684396005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h22ktkGMKWxVcxcaUxYu0h0WFMmYisG3d/tdFq9yk7c=;
        b=P8MW09XrLIsDdHi9/G8wLritk/+Wc5Vot3W6goTlBqf6xoIhm2MNzpILHhJEcUjR+p
         BQ3mB6q1hb/r0HDIbWdskSBssbrmJZqHAuWu96/QvDZcMfIhB+LZ9jgbk5i0onoHC+v/
         ySPpDzEqYm28//9q9m4z07Pv0ZzcTRLlSIcYfVTXt7asyAyFTx1xzFanOi3b1jYvBb06
         wwxVA3cdQqrY/TerZhntyyuMZQ7N/LDWPcj2pu7nE/6BnRDDrGhgIC4eGooMYakyWEZr
         +rXnVr391zoxTlaSjVprA7F44EC5LC7GeOlMA59C0O1ZyMyLFzzAaYGrBkJnUe41OJ/w
         fmIA==
X-Gm-Message-State: AAQBX9f3tGLeNAZGFKKUByP+A20AkZwUMe1o3/iA8RWeopXH4oDc1P+k
        xuFBI3tXUPvgDRH6Ji/UQ5J3Tg==
X-Google-Smtp-Source: AKy350YFjlSoPtsG95YiTUTNXmobFnXqxgrHOGzKKvaX5shNTFdX8nzsZ5QynhdG42owAFdYVfNIsw==
X-Received: by 2002:a17:903:1c3:b0:1a2:a8d0:838e with SMTP id e3-20020a17090301c300b001a2a8d0838emr1507684plh.61.1681804004787;
        Tue, 18 Apr 2023 00:46:44 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7e0d:abfb:57cb:cdfa])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709028d9500b001a527761c31sm8956975plo.79.2023.04.18.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:46:44 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3] zsmalloc: allow only one active pool compaction context
Date:   Tue, 18 Apr 2023 16:46:39 +0900
Message-ID: <20230418074639.1903197-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zsmalloc pool can be compacted concurrently by many contexts,
e.g.

 cc1 handle_mm_fault()
      do_anonymous_page()
       __alloc_pages_slowpath()
        try_to_free_pages()
         do_try_to_free_pages(
          lru_gen_shrink_node()
           shrink_slab()
            do_shrink_slab()
             zs_shrinker_scan()
              zs_compact()

Pool compaction is currently (basically) single-threaded as
it is performed under pool->lock. Having multiple compaction
threads results in unnecessary contention, as each thread
competes for pool->lock. This, in turn, affects all zsmalloc
operations such as zs_malloc(), zs_map_object(), zs_free(), etc.

Introduce the pool->compaction_in_progress atomic variable,
which ensures that only one compaction context can run at a
time. This reduces overall pool->lock contention in (corner)
cases when many contexts attempt to shrink zspool simultaneously.

Fixes: c0547d0b6a4b ("zsmalloc: consolidate zs_pool's migrate_lock and size_class's locks")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index cc81dfba05a0..44ddaf5d601e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -264,6 +264,7 @@ struct zs_pool {
 	struct work_struct free_work;
 #endif
 	spinlock_t lock;
+	atomic_t compaction_in_progress;
 };
 
 struct zspage {
@@ -2274,6 +2275,15 @@ unsigned long zs_compact(struct zs_pool *pool)
 	struct size_class *class;
 	unsigned long pages_freed = 0;
 
+	/*
+	 * Pool compaction is performed under pool->lock so it is basically
+	 * single-threaded. Having more than one thread in __zs_compact()
+	 * will increase pool->lock contention, which will impact other
+	 * zsmalloc operations that need pool->lock.
+	 */
+	if (atomic_xchg(&pool->compaction_in_progress, 1))
+		return 0;
+
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
 		class = pool->size_class[i];
 		if (class->index != i)
@@ -2281,6 +2291,7 @@ unsigned long zs_compact(struct zs_pool *pool)
 		pages_freed += __zs_compact(pool, class);
 	}
 	atomic_long_add(pages_freed, &pool->stats.pages_compacted);
+	atomic_set(&pool->compaction_in_progress, 0);
 
 	return pages_freed;
 }
@@ -2388,6 +2399,7 @@ struct zs_pool *zs_create_pool(const char *name)
 
 	init_deferred_free(pool);
 	spin_lock_init(&pool->lock);
+	atomic_set(&pool->compaction_in_progress, 0);
 
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
-- 
2.40.0.634.g4ca3ef3211-goog

