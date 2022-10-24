Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A9460B45E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiJXRj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiJXRiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:38:52 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32267F55
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:14:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h2so2937228pgp.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2Veyg4Nf5OS8EqVCK8SMJvhKgZdYRnABHlUXCuatrY=;
        b=HofNrlVOtqi8ZwPhhW9uLCwc+6uzwE1KBoMF3VcMdZDnR7LFHq8ikzjf7Hv4G3zQLU
         rp/BxL8DdIY/NMbC/qDx8YBTVkcfegpnrh/dhIKWoX2D7HzG0gKjqqYmxflQmBzFy/jx
         E0/pLtZAe47U0RHpL3vFn+ytPI+h7Q5K7/eyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2Veyg4Nf5OS8EqVCK8SMJvhKgZdYRnABHlUXCuatrY=;
        b=W59lsSlWhP2XnkIqIszkaPke2+66Q1CSg+j6PcFNgvwqfngC2bVCHLnMGbC1d8tpC4
         RJgaIJ5B+IrbMDu0dSUvpfR7xWy+65dinIhX+7a78zwp4niSeS55uERFjH1YXRJ9fXml
         Wdipa1F1UldgUeajmdP1SbPz7Rbbuo11MqGhf3plOFx2rFzWsaS/p7vkiJG/DOxu7w9V
         FSUlHDTy+HvVB+msscdHMMTURtE2/bXo5n64TuG1iMirQNJQmg1rlQEur8HJyooMPwM9
         oMjiHdOIKCcalLpmjOZmb6sMy1kn8Ouzd9tdAUIfLhTt/G38Yy1nsOVPUgSE+VdQ3pZN
         +18Q==
X-Gm-Message-State: ACrzQf2rsdqUoem1T91rRI5/RiEkOOtV/4kmcHfk6BDDrY2ZlvEt4bOt
        nkyAUZkQw3FFOcu8dGFETpTqph0CMwid+Q==
X-Google-Smtp-Source: AMsMyM5seGttxnHPEAkSSnleJlRyABXkFEMuMx/U4i/q2Zh9h6VzJL9Bl/S2rm4EZjuyKYun+S0Xiw==
X-Received: by 2002:a63:6b49:0:b0:46a:fcba:308f with SMTP id g70-20020a636b49000000b0046afcba308fmr29088458pgc.8.1666627950628;
        Mon, 24 Oct 2022 09:12:30 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5f9c:c5bc:902f:3da4])
        by smtp.gmail.com with ESMTPSA id u70-20020a627949000000b0056b8726d2d3sm5162pfc.157.2022.10.24.09.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:12:30 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/6] zsmalloc/zram: pass zspage order to zs_create_pool()
Date:   Tue, 25 Oct 2022 01:12:09 +0900
Message-Id: <20221024161213.3221725-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221024161213.3221725-1-senozhatsky@chromium.org>
References: <20221024161213.3221725-1-senozhatsky@chromium.org>
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

Allow zsmalloc pool owner to specify max zspage (during
pool creation), so that different pools can have different
characteristics.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c |  3 ++-
 include/linux/zsmalloc.h      |  2 +-
 mm/zsmalloc.c                 | 11 ++++++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 364323713393..e3ef542f9618 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1253,7 +1253,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	if (!zram->table)
 		return false;
 
-	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
+	zram->mem_pool = zs_create_pool(zram->disk->disk_name,
+					ZS_DEFAULT_PAGE_ORDER);
 	if (!zram->mem_pool) {
 		vfree(zram->table);
 		return false;
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 2110b140e0fa..4a92c5e186ad 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -53,7 +53,7 @@ struct zs_pool_stats {
 
 struct zs_pool;
 
-struct zs_pool *zs_create_pool(const char *name);
+struct zs_pool *zs_create_pool(const char *name, u32 zspage_order);
 void zs_destroy_pool(struct zs_pool *pool);
 
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags);
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6ffa32b8b6c8..fa55e0c66f8d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -369,7 +369,7 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
 	 * different contexts and its caller must provide a valid
 	 * gfp mask.
 	 */
-	return zs_create_pool(name);
+	return zs_create_pool(name, ZS_DEFAULT_PAGE_ORDER);
 }
 
 static void zs_zpool_destroy(void *pool)
@@ -2177,6 +2177,7 @@ static int zs_register_shrinker(struct zs_pool *pool)
 /**
  * zs_create_pool - Creates an allocation pool to work from.
  * @name: pool name to be created
+ * @zspage_order: maximum order of zspage
  *
  * This function must be called before anything when using
  * the zsmalloc allocator.
@@ -2184,17 +2185,21 @@ static int zs_register_shrinker(struct zs_pool *pool)
  * On success, a pointer to the newly created pool is returned,
  * otherwise NULL.
  */
-struct zs_pool *zs_create_pool(const char *name)
+struct zs_pool *zs_create_pool(const char *name, u32 zspage_order)
 {
 	int i;
 	struct zs_pool *pool;
 	struct size_class *prev_class = NULL;
 
+	if (WARN_ON(zspage_order < ZS_MIN_PAGE_ORDER ||
+		    zspage_order > ZS_MAX_PAGE_ORDER))
+		return NULL;
+
 	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
 	if (!pool)
 		return NULL;
 
-	pool->max_pages_per_zspage = 1U << ZS_MIN_PAGE_ORDER;
+	pool->max_pages_per_zspage = 1U << zspage_order;
 	/* min_alloc_size must be multiple of ZS_ALIGN */
 	pool->min_alloc_size = (pool->max_pages_per_zspage << PAGE_SHIFT) >>
 		OBJ_INDEX_BITS;
-- 
2.38.0.135.g90850a2211-goog

