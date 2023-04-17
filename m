Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994856E4A61
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjDQNyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjDQNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:54:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096235B8E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:54:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso13654975pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681739666; x=1684331666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pMpXhhgqoqclBiBIVXBf7YGaBTn2oRSRzJmNR6lNyRQ=;
        b=lMpY0Qu/a56IggAJIX6VY72VSKPhHpTVPaqC9ETNpc70bd9b77rx1n3k1yco4cOgb+
         0JkFI7L/B0txbOekHNYbOhMifBI+edyW57Ko/YhwXGvQCjfvIsZYH/qe67K85JWlLjLx
         iYy9oAYuUWlvta1fIOsBrHZmXUBQ6nFlBlxYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681739666; x=1684331666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMpXhhgqoqclBiBIVXBf7YGaBTn2oRSRzJmNR6lNyRQ=;
        b=H8wJhH5Q2+nGzexe0SrYWedxaRRVgpsBJ2/nRr0ETMP/w5M/YBuFr/59X/5FAc8pBj
         Z4hfn8C+PmjJyT6jsgKHCDrH4RoSeMRwPPDODWc18xeqjHoL2weuuPxvZ5EGDr7V16Kl
         i9mRU1WQ/+iEcU+ZL+mg6icX9DzfGrltJebbeooJfAnB+ZhTPs+N6lg7W2m2EBf9FLDa
         Fq7GivmVQjr7w6R7EWlSHfTiGgbRBbvjcYjd8tSvM86RcVAouOHod1EoPjHIgGWr1NhD
         oLjkJ32HBt1oLEfn3j9r7+NGV33+VHsIkSdUliPmmFXgQ1mY641k8wdpPEgyweA7r+3N
         sXyA==
X-Gm-Message-State: AAQBX9cH9u4OKceEwUHhOnqav1HPDbfghwO18q+OTkdkAP347orrDVYk
        Hx/UP5I9HWuU0QhJkfscdFIXAccSxzUbIXcShf0=
X-Google-Smtp-Source: AKy350aiXSKRpV73fKU81i74GwN8gg8Cy6+aTaH1inRxpfH4c1p76DmZJSftIura3Gqg5bquqZXkCg==
X-Received: by 2002:a17:902:e5ce:b0:1a6:f0d5:3e21 with SMTP id u14-20020a170902e5ce00b001a6f0d53e21mr1376568plf.32.1681739666455;
        Mon, 17 Apr 2023 06:54:26 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:97ac:e7c:d412:5251])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c24100b001a0667822c8sm7769619plg.94.2023.04.17.06.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:54:26 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] zsmalloc: allow only one active pool compaction context
Date:   Mon, 17 Apr 2023 22:54:20 +0900
Message-ID: <20230417135420.1836741-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

This creates unnecessary contention as all those processes
compete for access to the same classes. A single compaction
process is enough. Moreover contention that is created by
multiple compaction processes impact other zsmalloc functions,
e.g. zs_malloc(), since zsmalloc uses "global" pool->lock to
synchronize access to pool.

Introduce pool compaction mutex and permit only one compaction
context at a time. This reduces overall pool->lock contention.

/proc/lock-stat after make -j$((`nproc`+1)) linux kernel for
&pool->lock#3:

                Base           Patched
------------------------------------------
con-bounces     2035730        1540066
contentions     2343871        1774348
waittime-min    0.10           0.10
waittime-max    4004216.24     2745.22
waittime-total  101334168.29   67865414.91
waittime-avg    43.23          38.25
acq-bounces     2895765        2186745
acquisitions    6247686        5136943
holdtime-min    0.07           0.07
holdtime-max    2605507.97     482439.16
holdtime-total  9998599.59     5107151.01
holdtime-avg    1.60           0.99

Test run time:
Base
2775.15user 1709.13system 2:13.82elapsed 3350%CPU

Patched
2608.25user 1439.03system 2:03.63elapsed 3273%CPU

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index cc81dfba05a0..dfec2fc6a30f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -264,6 +264,7 @@ struct zs_pool {
 	struct work_struct free_work;
 #endif
 	spinlock_t lock;
+	atomic_t compaction_in_progress;
 };
 
 struct zspage {
@@ -2274,6 +2275,9 @@ unsigned long zs_compact(struct zs_pool *pool)
 	struct size_class *class;
 	unsigned long pages_freed = 0;
 
+	if (atomic_xchg(&pool->compaction_in_progress, 1))
+		return 0;
+
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
 		class = pool->size_class[i];
 		if (class->index != i)
@@ -2281,6 +2285,7 @@ unsigned long zs_compact(struct zs_pool *pool)
 		pages_freed += __zs_compact(pool, class);
 	}
 	atomic_long_add(pages_freed, &pool->stats.pages_compacted);
+	atomic_set(&pool->compaction_in_progress, 0);
 
 	return pages_freed;
 }
@@ -2388,6 +2393,7 @@ struct zs_pool *zs_create_pool(const char *name)
 
 	init_deferred_free(pool);
 	spin_lock_init(&pool->lock);
+	atomic_set(&pool->compaction_in_progress, 0);
 
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
-- 
2.40.0.634.g4ca3ef3211-goog

