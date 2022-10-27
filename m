Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FFE60EF02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJ0E1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiJ0E1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:27:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0218314707A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso5161958pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LEdREXOiedl6vGVYMbQ82TGs+PZXFhY4wbRwwr21TI=;
        b=Zcq6gzJXc8pDC3sz236YGfd+bdTaFcvYac+GMH/ktY7y0857LiRjJT4CxQDoiKpJ5W
         dlHU93yewjxd3BjXMcxT/FViOsi4RfL608ETdPBbYx0sn/EdYGowB5McvhvZoD7KRoEe
         1xgvWfDhrbUSpMvvhR5Mbdlp6ZKQ0qoSOui2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LEdREXOiedl6vGVYMbQ82TGs+PZXFhY4wbRwwr21TI=;
        b=xF0XU1lxVLbrpD8+5wxeHSHfQKA0jae+Zo9PJW4Dnl9E+BvgV1LG/l0hPqBoRe6TR+
         N8HwlJsz/YUbWtosqEss9mfsDvBYzcNS2M1v5ncK3cHv0u1ySYQu0d8bDAG9L639g+n7
         33IVIqgWhY2BjAOu9YJpX/eOUJAHTzVm8VXwjBHGg9+aGhJZy8tmTqbnfeOwR2lNEImJ
         ZUBzpJOcmu4uNLFIB/Eney1wUaZ1fGpq7/nzQjqIIFUF+3i5av81EyIpWfPXgYxLK2l6
         8rSTgaJQ8k/vZcyEexh64OLSimGxklCYc9nyIo+bhUqMs370lig2SuniOAv75qSo5or5
         vF4g==
X-Gm-Message-State: ACrzQf2JUrYO7L32YS6XcZ7qpdE51WxAXQGRsA1carV97RfKTgRI8fUK
        /Nq7aXQn1qIgAJ0Iye3cLaG7uA==
X-Google-Smtp-Source: AMsMyM7F3N7gSPDHuv3QFtEaAFzVeHH03Bzk1UisZYyH0NIWqm7Tvfg4uaYQHifloXF/S65xeUmrSg==
X-Received: by 2002:a17:90b:3141:b0:20d:49d6:30c with SMTP id ip1-20020a17090b314100b0020d49d6030cmr7781973pjb.175.1666844831526;
        Wed, 26 Oct 2022 21:27:11 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:30f2:4501:65fa:df12])
        by smtp.gmail.com with ESMTPSA id w23-20020aa79557000000b00565c8634e55sm203140pfq.135.2022.10.26.21.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:27:11 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 6/9] zsmalloc: pass limit on pages per-zspage to zs_create_pool()
Date:   Thu, 27 Oct 2022 13:26:48 +0900
Message-Id: <20221027042651.234524-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027042651.234524-1-senozhatsky@chromium.org>
References: <20221027042651.234524-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow zsmalloc pool owner to specify max number of pages
per-zspage (during pool creation), so that different pools
can have different characteristics.

By default we pass ZS_DEFAULT_PAGES_PER_ZSPAGE which is 4
(matches the current order 2 zspages limit).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c |  3 ++-
 include/linux/zsmalloc.h      |  2 +-
 mm/zsmalloc.c                 | 11 +++++++----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 90b0c66bbd5b..bec02f636bce 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1247,7 +1247,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	if (!zram->table)
 		return false;
 
-	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
+	zram->mem_pool = zs_create_pool(zram->disk->disk_name,
+					ZS_DEFAULT_PAGES_PER_ZSPAGE);
 	if (!zram->mem_pool) {
 		vfree(zram->table);
 		return false;
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index b6b8654a2d45..ebd1ff3e8115 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -50,7 +50,7 @@ struct zs_pool_stats {
 
 struct zs_pool;
 
-struct zs_pool *zs_create_pool(const char *name);
+struct zs_pool *zs_create_pool(const char *name, u32 max_pages_per_zspage);
 void zs_destroy_pool(struct zs_pool *pool);
 
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags);
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index cab8080e2fc6..7465a45495bf 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -366,7 +366,7 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
 	 * different contexts and its caller must provide a valid
 	 * gfp mask.
 	 */
-	return zs_create_pool(name);
+	return zs_create_pool(name, ZS_DEFAULT_PAGES_PER_ZSPAGE);
 }
 
 static void zs_zpool_destroy(void *pool)
@@ -2195,6 +2195,7 @@ static int zs_register_shrinker(struct zs_pool *pool)
 /**
  * zs_create_pool - Creates an allocation pool to work from.
  * @name: pool name to be created
+ * @max_pages_per_zspage: maximum number of pages per-zspage
  *
  * This function must be called before anything when using
  * the zsmalloc allocator.
@@ -2202,18 +2203,20 @@ static int zs_register_shrinker(struct zs_pool *pool)
  * On success, a pointer to the newly created pool is returned,
  * otherwise NULL.
  */
-struct zs_pool *zs_create_pool(const char *name)
+struct zs_pool *zs_create_pool(const char *name, u32 max_pages_per_zspage)
 {
 	int i;
 	struct zs_pool *pool;
 	struct size_class *prev_class = NULL;
-	u32 max_pages_per_zspage;
+
+	if (WARN_ON(max_pages_per_zspage < ZS_MIN_PAGES_PER_ZSPAGE ||
+		    max_pages_per_zspage > ZS_MAX_PAGES_PER_ZSPAGE))
+		return NULL;
 
 	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
 	if (!pool)
 		return NULL;
 
-	max_pages_per_zspage = ZS_DEFAULT_PAGES_PER_ZSPAGE;
 	/* min_alloc_size must be multiple of ZS_ALIGN */
 	pool->min_alloc_size = (max_pages_per_zspage << PAGE_SHIFT) >>
 		OBJ_INDEX_BITS;
-- 
2.38.0.135.g90850a2211-goog

