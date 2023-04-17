Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212136E4605
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjDQLGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjDQLGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:06:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343E4EF2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:05:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i8so16232172plt.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681729435; x=1684321435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXWxF7DmGQlS+I9+P3uaxt1m3XBosotbfe+681ULx84=;
        b=MzuSVH7Zo2sPbGWOQ47oeP4xLii2+aOg/66pgyJLKCz+X/rFQCZEZAlJXuDiRPX63L
         Cux+FDAbL2z7jkjdIeQ640L8J3LRvmFN5d/WR9Ny+AaK6EMbcWe5MWSCRdLkCXf100Ae
         4S6Af4C5MkMixqMRH1kFCqPRf92TDYYP6Bans=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681729435; x=1684321435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXWxF7DmGQlS+I9+P3uaxt1m3XBosotbfe+681ULx84=;
        b=haqPCf0VbV4J1YC5EFvts0UEGGS8y9h+mQvSZnV2q4faspjAReYocU8MEn7OyIwRo+
         umV+lLB/iJI5N9XLqwnm+Yjkju2DqtVd+R4gyOD0cV1ysNDkpjMgYzdlgt5GnR/VClfJ
         IhwqwUK9SIpQv3OkhsKHQ5Wi7hLFE9oJHDG5aM53vA8hdJkj3sUHBPPbqCVec87ecbd5
         k+tWiZE+CcsfEVd3rMt0mFXFD0qDreeYljUzudMcJtotBo2lCR8kUOCsD6kySB4whZg5
         AJrczHNvEUVCQ6EY4tpWc0qMy4wTsPP6fJrFME3TZrteo91+P52fyOlzq22NPj7dBImW
         t1aw==
X-Gm-Message-State: AAQBX9cGP9hxTcAEgM0aG3HjQFkEr3d5bcbkamNDDRoTc6SOeY9eZmqH
        CYjBL64mRcz+lY9BQDdoCbEyfw==
X-Google-Smtp-Source: AKy350aXLCVk+OYIIUH+lbE2hcALZKyJLxunUGHqU3dWfL0H59xa5XS2CsoUO3I3xsT99xRfHjqmzw==
X-Received: by 2002:a17:902:ac88:b0:1a6:5493:a3e8 with SMTP id h8-20020a170902ac8800b001a65493a3e8mr11813926plr.41.1681729435548;
        Mon, 17 Apr 2023 04:03:55 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:97ac:e7c:d412:5251])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902aa4600b001a221d14179sm7258666plr.302.2023.04.17.04.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 04:03:55 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zsmalloc: allow only one active pool compaction context
Date:   Mon, 17 Apr 2023 20:02:59 +0900
Message-ID: <20230417110259.1737315-1-senozhatsky@chromium.org>
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
context at a time.

/proc/lock-stat after make -j$((`nproc`+1)) linux kernel for
&pool->lock#3:

                Base           Patched
--------------------------------------
con-bounces     9797655        8125860
contentions     11131185       9242153
waittime-min    0.09           0.10
waittime-max    4171695.76     3926258.74
waittime-total  506197629.16   417061026.20
waittime-avg    45.48          45.13
acq-bounces     13809103       11383480
acquisitions    21145155       18049364
holdtime-min    0.06           0.07
holdtime-max    7379928.80     3926274.89
holdtime-total  46273950.89    37279624.53
holdtime-avg    2.19           2.07

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index cc81dfba05a0..0e036ec56c3c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -264,6 +264,7 @@ struct zs_pool {
 	struct work_struct free_work;
 #endif
 	spinlock_t lock;
+	struct mutex compact_lock;
 };
 
 struct zspage {
@@ -2274,6 +2275,9 @@ unsigned long zs_compact(struct zs_pool *pool)
 	struct size_class *class;
 	unsigned long pages_freed = 0;
 
+	if (!mutex_trylock(&pool->compact_lock))
+		return 0;
+
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
 		class = pool->size_class[i];
 		if (class->index != i)
@@ -2281,6 +2285,7 @@ unsigned long zs_compact(struct zs_pool *pool)
 		pages_freed += __zs_compact(pool, class);
 	}
 	atomic_long_add(pages_freed, &pool->stats.pages_compacted);
+	mutex_unlock(&pool->compact_lock);
 
 	return pages_freed;
 }
@@ -2388,6 +2393,7 @@ struct zs_pool *zs_create_pool(const char *name)
 
 	init_deferred_free(pool);
 	spin_lock_init(&pool->lock);
+	mutex_init(&pool->compact_lock);
 
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
-- 
2.40.0.634.g4ca3ef3211-goog

