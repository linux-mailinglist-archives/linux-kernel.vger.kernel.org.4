Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED52C730DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 05:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbjFODtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 23:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbjFODtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:49:05 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904BB211C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:48:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-54f75f85a17so2799973a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686800919; x=1689392919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbu+qXDQAnJmw8qCM+u2edU9xMFzBPDexgHZg7upYSc=;
        b=QuB/9REryqq6Mgb8L/e4zMTLqzDoDXfDapT3W0Gx/mxECAPvMPdAXb/7xqeOhW6cOS
         rDSsPeeYrCYrv5l2lI+PFC6KhRdpynj5Nc5W68ZABRG0SVuM4SYMvOjbDQp9yiwdfuFg
         c3IlUzDHTM3Fe8qKMpcnHym1vs/Tc9pnPa/Z9VZjvYSWuOV+oc3k2SLfRMFyiHBgDHcf
         WE/hXQy+tuxSMe7jlfmDYO9nNIjXK8xkQy8hrUeKjS7HgAKMRd7kpWv9b+YE46IvVy/u
         dilXepFYsW49CWNtr+c9qK0KedUGDaNOr6gL61uSNoBrjIPF6bYFFyLINhJRBq0lk7Pf
         OxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686800919; x=1689392919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vbu+qXDQAnJmw8qCM+u2edU9xMFzBPDexgHZg7upYSc=;
        b=bK4dYPrfZLqKdRmZUq/DJnaOhlYhdxjfVL+WNXldOaDxZvs/2cOnkB2xpPxZJsEnGz
         GP1AxdJmv8I1qBsF7z9MGI0fnevxg7iDq+JRxhk5nr1gwoYX6AMXoCXbYUZXLlNGq7Oj
         PNJYIleE4fAHneePEMpix22ycw9DkcJijQBbPnoMZDkWtar2fejZorFZlJzSIqUI8+gr
         63l+OUKk1uxouyerpa8CsILTNTuM4LrOh5yI6Gm5fpJcXhhrdoo7OYM5+K6hxCr+yxjH
         yL+Dsl0X/eo6YYhkFJBSapRCfDcIcPa7w1i0XirtuBIiK0UY/8xveAgH+JfXICZre+9c
         Sw+A==
X-Gm-Message-State: AC+VfDxo39bmN9NevON6odUb/o9YguSyNw3x86y/HcDTuHQS6XKv9FvT
        JEP4MqavyBiASKKoY2pBf74VdA==
X-Google-Smtp-Source: ACHHUZ7IJ/OOff5P+kevIRNHk4rSmF9QFuBJH8tCKcPmy/VcWRp1kVAz+QNpkDSFj/YM7GxNJewtnw==
X-Received: by 2002:a05:6a21:29ca:b0:11d:d83b:8d80 with SMTP id tv10-20020a056a2129ca00b0011dd83b8d80mr2265679pzb.46.1686800919047;
        Wed, 14 Jun 2023 20:48:39 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001b3fb1119fdsm2751713pli.297.2023.06.14.20.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 20:48:38 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH 1/3] zram: charge the compressed RAM to the page's memcgroup
Date:   Thu, 15 Jun 2023 11:48:30 +0800
Message-Id: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compressed RAM is currently charged to kernel, not to
any memory cgroup, which is not satisfy our usage scenario.
if the memory of a task is limited by memcgroup, it will
swap out the memory to zram swap device when the memory
is insufficient. In that case, the memory limit will have
no effect.

So, it should makes sense to charge the compressed RAM to
the page's memory cgroup.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 drivers/block/zram/zram_drv.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f6d90f1ba5cf..03b508447473 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
+#include <linux/memcontrol.h>
 
 #include "zram_drv.h"
 
@@ -1419,6 +1420,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	struct zcomp_strm *zstrm;
 	unsigned long element = 0;
 	enum zram_pageflags flags = 0;
+	struct mem_cgroup *memcg, *old_memcg;
+
+	memcg = page_memcg(page);
+	old_memcg = set_active_memcg(memcg);
 
 	mem = kmap_atomic(page);
 	if (page_same_filled(mem, &element)) {
@@ -1426,7 +1431,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		/* Free memory associated with this sector now. */
 		flags = ZRAM_SAME;
 		atomic64_inc(&zram->stats.same_pages);
-		goto out;
+		goto out_free;
 	}
 	kunmap_atomic(mem);
 
@@ -1440,7 +1445,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 		pr_err("Compression failed! err=%d\n", ret);
 		zs_free(zram->mem_pool, handle);
-		return ret;
+		goto out;
 	}
 
 	if (comp_len >= huge_class_size)
@@ -1470,8 +1475,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				GFP_NOIO | __GFP_HIGHMEM |
 				__GFP_MOVABLE);
-		if (IS_ERR_VALUE(handle))
-			return PTR_ERR((void *)handle);
+		if (IS_ERR_VALUE(handle)) {
+			ret = PTR_ERR((void *)handle);
+			goto out;
+		}
 
 		if (comp_len != PAGE_SIZE)
 			goto compress_again;
@@ -1491,7 +1498,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (zram->limit_pages && alloced_pages > zram->limit_pages) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 		zs_free(zram->mem_pool, handle);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
@@ -1506,7 +1514,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 	zs_unmap_object(zram->mem_pool, handle);
 	atomic64_add(comp_len, &zram->stats.compr_data_size);
-out:
+out_free:
 	/*
 	 * Free memory associated with this sector
 	 * before overwriting unused sectors.
@@ -1531,6 +1539,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 	/* Update stats */
 	atomic64_inc(&zram->stats.pages_stored);
+out:
+	set_active_memcg(old_memcg);
 	return ret;
 }
 
-- 
2.25.1

