Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C160DF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiJZLaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiJZLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:30:13 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6452B273
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:12 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 128so14498520pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cCehdWYmf2oT/+c3VC1U3PDElTtgIhBCXz1ANz8y7s=;
        b=GhNKrg0OAEwZop9TkQkoF/GYEB52Wp+FIXuigMbvdSHs2wjHSdWGVy+2RWGpHitcRZ
         GGEFJKQi4EZOQyUw0VThpPDdexrgvdZenXB8pA6s3yQsqgoPQ3jA02EQjZ513REHymHw
         eHeOgtudRK/s72eVGFn75SujwAATGHhrMKr7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cCehdWYmf2oT/+c3VC1U3PDElTtgIhBCXz1ANz8y7s=;
        b=j8CDqzktP9HuivvTYbCfxCXEDxPbwcVlL1r6+g2KHt7lwnWjO7VL6S2dGK+T8/HjE6
         vJLhPlDMoWmS8Fe6OLzQ+GBYiaSNIIH3wY8EKSArPAM95OAjfyEA53zGRhDkmoYwNnfa
         3e03bLV5vsgQMzSK4yCEhygOz1CcVBzNaYYz/co/8sbe0KlzCr99UN31MCTaPizYuyFN
         O8MXlFOd/f3LfL56+h2z0ij5Ai9l6ef8GttUzKuzQRYJ21a9UDegn8KHtGQR8YHp2oHQ
         bKEAvEzsARRkTBmVKo+D360Xnbvqvq0936V+Ah3IuYkdoTg2VKkdqlazrxcijY8cIQLA
         0lzQ==
X-Gm-Message-State: ACrzQf0R+X+VuihDERZAInupZs4YHmIItmSZGk4qHEoTJ7hnHM+PJ5PB
        yXBMYgDmdEoQt4DgJrQRb2azPg==
X-Google-Smtp-Source: AMsMyM7Q4/e+y7mw0PklcMKgFBOK8szlLFKFKA9a8e/xiHIZ2p93fMqJppuuw1/722a3mQ94k0Z3xA==
X-Received: by 2002:a05:6a00:1688:b0:53b:4239:7c5c with SMTP id k8-20020a056a00168800b0053b42397c5cmr44419098pfc.81.1666783811869;
        Wed, 26 Oct 2022 04:30:11 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:749c:f7f5:1a8e:d0be])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b005627868e27esm2814919pfb.127.2022.10.26.04.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:30:11 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexey Romanov <avromanov@sberdevices.ru>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/9] zram: add size class equals check into recompression
Date:   Wed, 26 Oct 2022 20:29:25 +0900
Message-Id: <20221026112933.4122957-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221026112933.4122957-1-senozhatsky@chromium.org>
References: <20221026112933.4122957-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Romanov <avromanov@sberdevices.ru>

It makes no sense for us to recompress the object if it will
be in the same size class. We anyway don't get any memory gain.
But, at the same time, we get a CPU time overhead when inserting
this object into zspage and decompressing it afterwards.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c |  5 +++++
 include/linux/zsmalloc.h      |  2 ++
 mm/zsmalloc.c                 | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 364323713393..fd31beb6491a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1632,6 +1632,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	unsigned long handle_next;
 	unsigned int comp_len_next;
 	unsigned int comp_len_prev;
+	unsigned int class_index_prev;
+	unsigned int class_index_next;
 	struct zcomp_strm *zstrm;
 	void *src, *dst;
 	int ret;
@@ -1656,6 +1658,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	ret = zcomp_compress(zstrm, src, &comp_len_next);
 	kunmap_atomic(src);
 
+	class_index_prev = zs_lookup_class_index(zram->mem_pool, comp_len_prev);
+	class_index_next = zs_lookup_class_index(zram->mem_pool, comp_len_next);
 	/*
 	 * Either a compression error or we failed to compressed the object
 	 * in a way that will save us memory. Mark the object so that we
@@ -1663,6 +1667,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	 */
 	if (comp_len_next >= huge_class_size ||
 	    comp_len_next >= comp_len_prev ||
+	    class_index_next >= class_index_prev ||
 	    ret) {
 		zram_set_flag(zram, index, ZRAM_RECOMP_SKIP);
 		zram_clear_flag(zram, index, ZRAM_IDLE);
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
2.38.0.135.g90850a2211-goog

