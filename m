Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27010622AF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiKILvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiKILvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:51:21 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97772EF28
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:51:15 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 6so7882595pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISzeUQbltZw2zOA4vUeGiMYh+5K7aaZl+AlK2yoDkbI=;
        b=abhQ1Lg35Ucp+NagZfYKvx4GbY0NqG+/hyXy+da3FyfoeakVv8aDDXACjC5rRaYMlE
         E3LixsEmNHw/j0vp8f/7HSXIgTj/qjh5U/zqtfM2h03rzuq8Scn+ixTQLqjY4CV5PBYE
         62QyHJ431/vUwvGW0FiMJTSIr0gK1BLKAlU3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISzeUQbltZw2zOA4vUeGiMYh+5K7aaZl+AlK2yoDkbI=;
        b=4RM6dur7XV2gx+xI5ZlcAb1t5uPGUgBw5pq3TEteXljfFPeYIXjzm2hYOJqIJCpG+b
         CqGr0zEUpo+5LHRS1U3ihdCmfgs3zXG9stPUS04YvfgZ2bZdGF5XyBnJqFs4OueOwMIz
         lkbMNVcT3wp6QlDHv5JjNInwDBlAFndieZdbVIehnKoe64NUBcnuvRYPuSiNeahtjnFd
         W3kp4RM8leAsLbQ4BHmYIQ9UJiA7p6wbsyBBFV9ISpbfkFqW2z5nI4ErziGgkeSGV/iY
         Yhimjg6k/Gcoa9uvIRaGDvgLwBsAkRLPSwWb+eBOIkI79TFul35/2jePK+jpcPVWL+Dy
         NpdA==
X-Gm-Message-State: ACrzQf2MzX+RZbs+sCIGBIaK5/mA29ziqnMppFTARUlQFH5s0QdG3qVX
        DbrsEzc6aqqDqgsSAlrh67XBoQ==
X-Google-Smtp-Source: AMsMyM5bs/os1qCUXnfE9uDJ3/tdq0rmqwrB+hDi9koev9Tj6IMDU384APFO34LPFle2GUW6mVXbfw==
X-Received: by 2002:a63:f047:0:b0:46e:b1d4:2a68 with SMTP id s7-20020a63f047000000b0046eb1d42a68mr51073818pgj.496.1667994675340;
        Wed, 09 Nov 2022 03:51:15 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:51:15 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCHv5 08/13] zram: add size class equals check into recompression
Date:   Wed,  9 Nov 2022 20:50:42 +0900
Message-Id: <20221109115047.2921851-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109115047.2921851-1-senozhatsky@chromium.org>
References: <20221109115047.2921851-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Romanov <avromanov@sberdevices.ru>

It makes no sense for us to recompress the object if it will be in the
same size class.  We anyway don't get any memory gain.  But, at the same
time, we get a CPU time overhead when inserting this object into zspage
and decompressing it afterwards.

[senozhatsky: rebased and fixed conflicts]
Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 11 ++++++++++-
 include/linux/zsmalloc.h      |  2 ++
 mm/zsmalloc.c                 | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9561569273fe..383d967ef4c7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1675,6 +1675,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	unsigned long handle_new;
 	unsigned int comp_len_old;
 	unsigned int comp_len_new;
+	unsigned int class_index_old;
+	unsigned int class_index_new;
 	void *src, *dst;
 	int ret;
 
@@ -1693,6 +1695,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	if (ret)
 		return ret;
 
+	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
 	/*
 	 * Iterate the secondary comp algorithms list (in order of priority)
 	 * and try to recompress the page.
@@ -1718,9 +1721,13 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 			return ret;
 		}
 
+		class_index_new = zs_lookup_class_index(zram->mem_pool,
+							comp_len_new);
+
 		/* Continue until we make progress */
 		if (comp_len_new >= huge_class_size ||
 		    comp_len_new >= comp_len_old ||
+		    class_index_new >= class_index_old ||
 		    (threshold && comp_len_new >= threshold)) {
 			zcomp_stream_put(zram->comps[prio]);
 			continue;
@@ -1743,7 +1750,9 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	 * that would save memory, mark the object as incompressible so that
 	 * we will not try to compress it again.
 	 */
-	if (comp_len_new >= huge_class_size || comp_len_new >= comp_len_old) {
+	if (comp_len_new >= huge_class_size ||
+	    comp_len_new >= comp_len_old ||
+	    class_index_new >= class_index_old) {
 		zram_set_flag(zram, index, ZRAM_INCOMPRESSIBLE);
 		return 0;
 	}
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 2a430e713ce5..a48cd0ffe57d 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -55,5 +55,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle);
 unsigned long zs_get_total_pages(struct zs_pool *pool);
 unsigned long zs_compact(struct zs_pool *pool);
 
+unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size);
+
 void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d03941cace2c..065744b7e9d8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1205,6 +1205,27 @@ static bool zspage_full(struct size_class *class, struct zspage *zspage)
 	return get_zspage_inuse(zspage) == class->objs_per_zspage;
 }
 
+/**
+ * zs_lookup_class_index() - Returns index of the zsmalloc &size_class
+ * that hold objects of the provided size.
+ * @pool: zsmalloc pool to use
+ * @size: object size
+ *
+ * Context: Any context.
+ *
+ * Return: the index of the zsmalloc &size_class that hold objects of the
+ * provided size.
+ */
+unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size)
+{
+	struct size_class *class;
+
+	class = pool->size_class[get_size_class_index(size)];
+
+	return class->index;
+}
+EXPORT_SYMBOL_GPL(zs_lookup_class_index);
+
 unsigned long zs_get_total_pages(struct zs_pool *pool)
 {
 	return atomic_long_read(&pool->pages_allocated);
-- 
2.38.1.431.g37b22c650d-goog

