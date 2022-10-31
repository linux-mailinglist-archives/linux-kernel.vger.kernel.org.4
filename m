Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A2A612FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJaFls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJaFll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:41:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEA7BE3A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l2so9809504pld.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFR0j+YHx2uepPKlT+sIE6AyjijOgidhHUVwtVRcfQ8=;
        b=OsAM7e9gpky/PEpM6ussXnheiEIyAvoyhxEKv4YeN/y8428flisIoxqVDVQ/Z5NMre
         D5X/AKopD/9c9t4iyXFDie1MqC4kbMjkn2bPY7QhKi1M3jJRRwADtpxzFPYqbiKC4lsG
         L5Ihy/ujEO9g3F150Tblm3TeaA8a+A20XJX98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFR0j+YHx2uepPKlT+sIE6AyjijOgidhHUVwtVRcfQ8=;
        b=pH5l1rAcMIgs1aBTVE8gI71fhlyBHQiSa+iVDR50xkZ4cFnm2ORKBpm9v2dRRl+nkv
         5oqSGv5vFpTXaCBP2dj50aQE8c3ivrKrCxuBs7Zi4AKd4iN9sYHR1+fiGYOJHpHRdpoc
         W54dMXy8S12kFkordIUU1rlzcA8ScrxCE9Kj1pqvQCW3FugHsdz/ipg/foqvf+U8a5J9
         MEgg2+VUpLGSE7kZTdj17wgvWvtxduFo6pBrHYEVaFL6imny8JfiB0zOeCqzuBRrFD98
         4sxhL95FeC+sylz8wZd6/GU8IaNHha2hwKMgmzyBmGnqKsFDAdmIUpB7GBE0WGV5M0BH
         pL4g==
X-Gm-Message-State: ACrzQf1DwzgT1TXKEhH8PIrfVs6SyVokWOTf3zcBOirIYTvKB4viBVNz
        k0oaXSBQ4lZ3uCngpx4JeA2A1A==
X-Google-Smtp-Source: AMsMyM4naYgrzZsBUcVNory6T4TNl8WUIPDEeh31C5BordS6k/33LBC4k0wlPp/qKRKbgdkdntEu6g==
X-Received: by 2002:a17:90b:2705:b0:20a:b4fa:f624 with SMTP id px5-20020a17090b270500b0020ab4faf624mr13010028pjb.124.1667194892609;
        Sun, 30 Oct 2022 22:41:32 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7616:afe0:ba6c:96f4])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b0056befcd7958sm3573308pfj.84.2022.10.30.22.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 22:41:32 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 6/9] zsmalloc: pass limit on pages per-zspage to zs_create_pool()
Date:   Mon, 31 Oct 2022 14:41:05 +0900
Message-Id: <20221031054108.541190-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221031054108.541190-1-senozhatsky@chromium.org>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index b6b8654a2d45..28f2b9cb1c47 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -50,7 +50,7 @@ struct zs_pool_stats {
 
 struct zs_pool;
 
-struct zs_pool *zs_create_pool(const char *name);
+struct zs_pool *zs_create_pool(const char *name, unsigned long num_pages);
 void zs_destroy_pool(struct zs_pool *pool);
 
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags);
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d329bd673baa..42987a913f45 100644
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
+ * @num_pages: maximum number of pages per-zspage
  *
  * This function must be called before anything when using
  * the zsmalloc allocator.
@@ -2202,18 +2203,20 @@ static int zs_register_shrinker(struct zs_pool *pool)
  * On success, a pointer to the newly created pool is returned,
  * otherwise NULL.
  */
-struct zs_pool *zs_create_pool(const char *name)
+struct zs_pool *zs_create_pool(const char *name, unsigned long num_pages)
 {
 	int i;
 	struct zs_pool *pool;
 	struct size_class *prev_class = NULL;
-	unsigned long num_pages;
+
+	if (WARN_ON(num_pages < ZS_MIN_PAGES_PER_ZSPAGE ||
+		    num_pages > ZS_MAX_PAGES_PER_ZSPAGE))
+		return NULL;
 
 	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
 	if (!pool)
 		return NULL;
 
-	num_pages = ZS_DEFAULT_PAGES_PER_ZSPAGE;
 	/* min_alloc_size must be multiple of ZS_ALIGN */
 	pool->min_alloc_size = num_pages << PAGE_SHIFT >> OBJ_INDEX_BITS;
 	pool->min_alloc_size = max(pool->min_alloc_size, ZS_MIN_ALLOC_SIZE);
-- 
2.38.1.273.g43a17bfeac-goog

